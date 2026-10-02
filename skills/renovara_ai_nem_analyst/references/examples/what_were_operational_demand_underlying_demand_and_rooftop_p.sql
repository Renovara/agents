-- What were operational demand, underlying demand and rooftop PV in each region, half hour by half hour, yesterday?
-- What were operational demand, underlying demand and rooftop PV in each
-- region, half hour by half hour, yesterday?
--
-- silver_operational_demand_actual_operational_demand_actual is AEMO's
-- measured ACTUAL OPERATIONAL DEMAND (MMS table DEMANDOPERATIONALACTUAL):
-- one row per region per half hour, the average MW over the half hour ENDING
-- at INTERVAL_DATETIME (the 12:00 row covers 11:30-12:00). Timestamps are
-- AEST market time, like every other NEM timestamp here. History starts in
-- 2024-08 -- AEMO's archive holds nothing earlier -- so a query before then
-- returns no rows, not zero demand.
--
-- It is not the same number as dispatch_regionsum TOTALDEMAND. TOTALDEMAND
-- is a 5-minute dispatch quantity that leaves out non-scheduled generation;
-- operational demand counts it. Measured over 24 hours on 2026-09-26/27,
-- TOTALDEMAND ran about 2% lower NEM-wide (QLD1 ~0%, NSW1 and SA1 ~1.5%,
-- TAS1 ~2.5%, VIC1 ~7%). For "operational demand" use this table; use
-- TOTALDEMAND only when you need 5-minute resolution, and say which you used.
--
-- Rooftop PV is behind the meter, so it is netted out of both:
--
--     underlying demand = operational demand + rooftop PV
--
-- Two traps:
--   * rooftop TYPE is part of its primary key -- both MEASUREMENT and
--     SATELLITE rows exist for every interval. Filter to MEASUREMENT or every
--     rooftop figure doubles.
--   * to compare with 5-minute dispatch data, average the six SETTLEMENTDATEs
--     in (INTERVAL_DATETIME - 30 min, INTERVAL_DATETIME]. Both tables label an
--     interval by its END; flooring SETTLEMENTDATE to the half hour instead
--     shifts the comparison by 25 minutes.
WITH bounds AS (
    SELECT date_trunc('DAY', from_utc_timestamp(current_timestamp(), 'Australia/Brisbane')) AS today
),
operational AS (
    SELECT REGIONID, INTERVAL_DATETIME, OPERATIONAL_DEMAND AS operational_mw
    FROM external_data.nemweb.silver_operational_demand_actual_operational_demand_actual, bounds
    WHERE INTERVAL_DATETIME >  today - INTERVAL 1 DAY
      AND INTERVAL_DATETIME <= today
),
rooftop AS (
    SELECT REGIONID, INTERVAL_DATETIME, POWER AS rooftop_mw
    FROM external_data.nemweb.silver_rooftop_pv_actual_rooftop_actual, bounds
    WHERE TYPE = 'MEASUREMENT'              -- never omit: TYPE is in the PK
      AND INTERVAL_DATETIME >  today - INTERVAL 1 DAY
      AND INTERVAL_DATETIME <= today
),
dispatch_half_hourly AS (
    -- 5-minute TOTALDEMAND averaged to the half hour ENDING at the label.
    SELECT
        REGIONID,
        timestamp_seconds(CAST(CEIL(unix_timestamp(SETTLEMENTDATE) / 1800) * 1800 AS BIGINT)) AS INTERVAL_DATETIME,
        AVG(TOTALDEMAND) AS totaldemand_mw
    FROM external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum, bounds
    WHERE INTERVENTION = 0
      AND SETTLEMENTDATE >  today - INTERVAL 1 DAY
      AND SETTLEMENTDATE <= today
    GROUP BY ALL
)
SELECT
    o.REGIONID,
    o.INTERVAL_DATETIME,                                    -- half hour ending, AEST
    o.operational_mw,
    ROUND(r.rooftop_mw)                                     AS rooftop_mw,
    ROUND(o.operational_mw + r.rooftop_mw)                  AS underlying_mw,
    ROUND(100 * r.rooftop_mw / (o.operational_mw + r.rooftop_mw), 1) AS rooftop_pct_of_underlying,
    ROUND(d.totaldemand_mw)                                 AS dispatch_totaldemand_mw
FROM operational o
LEFT JOIN rooftop r             USING (REGIONID, INTERVAL_DATETIME)
LEFT JOIN dispatch_half_hourly d USING (REGIONID, INTERVAL_DATETIME)
ORDER BY o.REGIONID, o.INTERVAL_DATETIME
