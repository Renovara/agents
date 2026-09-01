-- Which facilities most consistently under-forecast their own gas supply?
-- Which facilities most consistently under-forecast their own gas supply?
--
-- Compares what participants nominated (silver_gbb_nomination_forecast) against
-- what they actually flowed (silver_gbb_actual_flow_storage), per facility.
--
-- Two things this query has to get right, both of which are easy to miss:
--
-- 1. The join column is spelled `Gasdate` in the forecast table and `GasDate`
--    in the actuals table. That inconsistency is in AEMO's source files, not a
--    typo here.
--
-- 2. Actuals are RESTATED for weeks after the gas day — a row for a gas day
--    three weeks old may still change. Measuring bias against the most recent
--    days measures it against provisional numbers, so the window below ends 14
--    days ago rather than today. Widen it only if you also widen the exclusion.
WITH bounds AS (
    SELECT
        DATE(from_utc_timestamp(current_timestamp(), 'Australia/Brisbane')) - INTERVAL 90 DAYS AS from_day,
        DATE(from_utc_timestamp(current_timestamp(), 'Australia/Brisbane')) - INTERVAL 14 DAYS AS to_day
),
paired AS (
    SELECT
        f.FacilityId,
        f.Gasdate                        AS gas_day,
        f.Supply                         AS forecast_supply,
        a.Supply                         AS actual_supply,
        a.Supply - f.Supply              AS error_tj
    FROM external_data.nemweb.silver_gbb_nomination_forecast AS f
    JOIN external_data.nemweb.silver_gbb_actual_flow_storage AS a
      ON  a.GasDate    = f.Gasdate
      AND a.FacilityId = f.FacilityId
      AND a.LocationId = f.LocationId
    CROSS JOIN bounds AS b
    WHERE f.Gasdate BETWEEN b.from_day AND b.to_day
      -- Only facilities that actually supply gas; demand-side rows are a
      -- different question and would dilute the bias.
      AND (f.Supply > 0 OR a.Supply > 0)
)
SELECT
    fac.FacilityName,
    fac.FacilityType,
    fac.OperatorName,
    COUNT(*)                                    AS gas_days,
    ROUND(AVG(p.actual_supply), 1)              AS avg_actual_tj,
    ROUND(AVG(p.error_tj), 2)                   AS avg_error_tj,
    -- Positive mean error = flowed more than nominated (under-forecast).
    ROUND(AVG(ABS(p.error_tj)), 2)              AS avg_abs_error_tj,
    ROUND(100 * AVG(p.error_tj)
              / NULLIF(AVG(p.actual_supply), 0), 1) AS avg_bias_pct
FROM paired AS p
JOIN external_data.nemweb.silver_gbb_facilities AS fac
  ON fac.FacilityId = p.FacilityId
GROUP BY 1, 2, 3
HAVING COUNT(*) >= 30
ORDER BY avg_bias_pct DESC;
