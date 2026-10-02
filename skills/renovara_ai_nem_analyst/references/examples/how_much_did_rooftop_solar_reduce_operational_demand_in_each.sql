-- How much did rooftop solar reduce operational demand in each region yesterday, and when was its peak contribution?
-- How much did rooftop solar reduce operational demand in each region
-- yesterday, and when was its peak contribution?
--
-- Rooftop PV is consumed behind the meter, so it is netted out of the demand
-- the grid sees:
--
--     underlying demand = operational demand + rooftop PV
--
-- TOTALDEMAND in dispatch_regionsum is not AEMO's operational demand: it runs
-- about 2% lower, because operational demand also counts non-scheduled
-- generation. TOTALDEMAND + TOTALINTERMITTENTGENERATION approximates it.
--
-- Two joins matter here:
--   * TYPE = 'MEASUREMENT' -- TYPE is part of the primary key and both
--     MEASUREMENT and SATELLITE rows exist for every interval. Without this
--     filter every rooftop figure roughly doubles and still looks plausible.
--   * the half-hour alignment -- dispatch_regionsum is 5-minute interval-ending
--     and this table is 30-minute interval-ending, so each 5-minute interval
--     is rounded UP to the half hour it ends in, and the six are averaged.
WITH half_hourly_demand AS (
    -- The half hour ending H holds SETTLEMENTDATE in (H - 30 min, H].
    SELECT
        REGIONID,
        timestamp_seconds(CEIL(unix_timestamp(SETTLEMENTDATE) / 1800) * 1800) AS INTERVAL_DATETIME,
        AVG(TOTALDEMAND + TOTALINTERMITTENTGENERATION) AS operational_mw
    FROM external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum
    WHERE INTERVENTION = 0
      AND SETTLEMENTDATE >  date_trunc('DAY', current_timestamp()) - INTERVAL 1 DAY
      AND SETTLEMENTDATE <= date_trunc('DAY', current_timestamp())
    GROUP BY ALL
),
rooftop AS (
    SELECT
        REGIONID,
        INTERVAL_DATETIME,
        POWER AS rooftop_mw
    FROM external_data.nemweb.silver_rooftop_pv_actual_rooftop_actual
    WHERE TYPE = 'MEASUREMENT'          -- never omit: TYPE is in the PK
      AND INTERVAL_DATETIME >  date_trunc('DAY', current_timestamp()) - INTERVAL 1 DAY
      AND INTERVAL_DATETIME <= date_trunc('DAY', current_timestamp())
),
combined AS (
    SELECT
        d.REGIONID,
        d.INTERVAL_DATETIME,
        d.operational_mw,
        r.rooftop_mw,
        d.operational_mw + r.rooftop_mw AS underlying_mw
    FROM half_hourly_demand d
    JOIN rooftop r USING (REGIONID, INTERVAL_DATETIME)
)
SELECT
    REGIONID,
    ROUND(MIN(operational_mw))                                        AS min_operational_mw,
    ROUND(MAX(underlying_mw))                                         AS max_underlying_mw,
    ROUND(MAX(rooftop_mw))                                            AS peak_rooftop_mw,
    -- MW at interval end over a half hour -> MWh is MW * 0.5
    ROUND(SUM(rooftop_mw) * 0.5)                                      AS rooftop_energy_mwh,
    ROUND(100 * MAX(rooftop_mw / underlying_mw), 1)                   AS peak_rooftop_pct_of_underlying,
    MAX_BY(INTERVAL_DATETIME, rooftop_mw / underlying_mw)             AS interval_of_peak_share
FROM combined
GROUP BY REGIONID
ORDER BY peak_rooftop_pct_of_underlying DESC
