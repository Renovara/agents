-- How accurate is AEMO's rooftop solar forecast, and does the error grow with lead time?
-- How accurate is AEMO's rooftop solar forecast, and does the error grow with
-- lead time?
--
-- The forecast table reissues the full 8-day-ahead forecast every 30 minutes,
-- so one target interval carries many forecasts of very different age --
-- measured average 113 vintages per interval, up to 164. Averaging over the
-- table without pinning a lead time answers nothing, because it mixes a
-- 20-minute-ahead nowcast with a 7-day-ahead outlook.
--
-- This query bins by lead time instead, and compares against the MEASUREMENT
-- actuals (AEMO's best same-day estimate; SATELLITE is a different method and
-- disagrees by 2.5-5.2% of daytime output).
--
-- Measured over a 3.4-day window, daytime intervals only: MAE grew from
-- 106 MW at 0-2h lead to 226 MW beyond 48h, and the bias was NEGATIVE at
-- every lead (-42 to -86 MW) -- the forecast ran below actuals throughout.
-- Report bias and MAE separately: a near-zero mean error would hide a
-- systematic bias that matters for anyone trading the midday trough.
WITH actuals AS (
    SELECT
        REGIONID,
        INTERVAL_DATETIME,
        POWER AS actual_mw
    FROM external_data.nemweb.silver_rooftop_pv_actual_rooftop_actual
    WHERE TYPE = 'MEASUREMENT'          -- TYPE is in the PK; both types exist
),
forecasts AS (
    SELECT
        REGIONID,
        INTERVAL_DATETIME,
        POWERMEAN AS forecast_mw,
        -- VERSION_DATETIME is the forecast run; INTERVAL_DATETIME is the
        -- target. Both are Australia/Brisbane, so the difference is safe
        -- without any timezone conversion.
        (unix_timestamp(INTERVAL_DATETIME) - unix_timestamp(VERSION_DATETIME)) / 3600.0 AS lead_hours
    FROM external_data.nemweb.silver_rooftop_pv_forecast_rooftop_forecast
)
SELECT
    CASE
        WHEN lead_hours <  2 THEN '0-2h'
        WHEN lead_hours <  6 THEN '2-6h'
        WHEN lead_hours < 24 THEN '6-24h'
        WHEN lead_hours < 48 THEN '24-48h'
        ELSE '48h+'
    END                                                   AS lead_bucket,
    COUNT(*)                                              AS n_forecasts,
    ROUND(AVG(ABS(f.forecast_mw - a.actual_mw)), 1)       AS mae_mw,
    ROUND(AVG(f.forecast_mw - a.actual_mw), 1)            AS bias_mw,
    ROUND(SQRT(AVG(POW(f.forecast_mw - a.actual_mw, 2))), 1) AS rmse_mw
FROM forecasts f
JOIN actuals a USING (REGIONID, INTERVAL_DATETIME)
WHERE a.actual_mw > 100      -- daytime only; overnight zeros are trivially exact
GROUP BY ALL
ORDER BY MIN(f.lead_hours)
