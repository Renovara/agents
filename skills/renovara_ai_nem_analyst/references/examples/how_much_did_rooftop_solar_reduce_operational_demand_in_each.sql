-- How much did rooftop solar reduce operational demand in each region yesterday, and when was its peak contribution?
-- How much did rooftop solar reduce operational demand in each region
-- yesterday, and when was its peak contribution?
--
-- TOTALDEMAND in dispatch_regionsum is OPERATIONAL demand: what the market
-- had to serve after rooftop PV was already consumed behind the meter.
-- Rooftop is netted out of it, so:
--
--     underlying demand = operational demand + rooftop PV
--
-- Measured on NSW1 for 2026-08-31, operational demand fell 16% between 10:00
-- and 12:30 (5,720 -> 4,790 MW) while underlying demand was essentially flat
-- at ~10,100 MW. Nothing about consumption changed; rooftop did. At the
-- trough rooftop supplied 52.6% of underlying demand.
--
-- Two joins matter here:
--   * TYPE = 'MEASUREMENT' -- TYPE is part of the primary key and both
--     MEASUREMENT and SATELLITE rows exist for every interval. Without this
--     filter every rooftop figure roughly doubles and still looks plausible.
--   * the half-hour alignment -- dispatch_regionsum is 5-minute and this
--     table is 30-minute interval-ending, so the dispatch side is averaged
--     within the half hour rather than sampled at one point.
WITH half_hourly_demand AS (
    -- Collapse 5-minute dispatch to the interval-ending half hour that the
    -- rooftop tables use. date_trunc('HOUR', ...) + 30 min * floor(min/30)
    -- gives the half-hour the reading falls in.
    SELECT
        REGIONID,
        date_trunc('HOUR', SETTLEMENTDATE)
            + INTERVAL 30 MINUTES * FLOOR(MINUTE(SETTLEMENTDATE) / 30) AS INTERVAL_DATETIME,
        AVG(TOTALDEMAND) AS operational_mw
    FROM external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum
    WHERE INTERVENTION = 0
      AND SETTLEMENTDATE >= date_trunc('DAY', current_timestamp()) - INTERVAL 1 DAY
      AND SETTLEMENTDATE <  date_trunc('DAY', current_timestamp())
    GROUP BY ALL
),
rooftop AS (
    SELECT
        REGIONID,
        INTERVAL_DATETIME,
        POWER AS rooftop_mw
    FROM external_data.nemweb.silver_rooftop_pv_actual_rooftop_actual
    WHERE TYPE = 'MEASUREMENT'          -- never omit: TYPE is in the PK
      AND INTERVAL_DATETIME >= date_trunc('DAY', current_timestamp()) - INTERVAL 1 DAY
      AND INTERVAL_DATETIME <  date_trunc('DAY', current_timestamp())
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
