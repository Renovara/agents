-- How much generation comes from non-scheduled units, and what fuel is it?
-- How much generation comes from non-scheduled units, and what fuel is it?
--
-- Non-scheduled units have no dispatch target, so they appear in NO dispatch
-- table. Measured: of 35 non-scheduled DUIDs reporting SCADA, 34 are absent
-- from dispatch_unit_solution entirely. Any generation total built from
-- dispatch data silently omits them.
--
-- silver_dispatch_scada_dispatch_unit_scada is the only table that sees them.
-- Over a recent 2-day window they produced ~22,200 MWh — about 1.7% of all
-- generation, concentrated in Tasmanian hydro and wind, and in embedded
-- generation across QLD, NSW and VIC.
--
-- ⚠ BOTH reference tables below fan out and BOTH must be deduplicated first:
--      dudetailsummary          ~382 rows per DUID  (effective-dated)
--      participant_and_scheduled_loads  ~2 rows per DUID
--    Joining either raw multiplies every MWh total. Skipping the second one
--    double-counted this query's fuel figures on the first attempt.
WITH reg AS (
    -- Current registration row per DUID: schedule type and region.
    SELECT
        DUID, REGIONID, SCHEDULE_TYPE,
        ROW_NUMBER() OVER (
            PARTITION BY DUID ORDER BY START_DATE DESC, LASTCHANGED DESC
        ) AS rn
    FROM external_data.nemweb.silver___participant_registration_dudetailsummary
),
fuel AS (
    -- One fuel row per DUID. The registration list carries ~2 rows each.
    SELECT
        DUID, FUEL_SOURCE_PRIMARY,
        ROW_NUMBER() OVER (PARTITION BY DUID ORDER BY FUEL_SOURCE_PRIMARY) AS rn
    FROM external_data.nemweb.silver_nem_participant_and_scheduled_loads
)
SELECT
    COALESCE(f.FUEL_SOURCE_PRIMARY, '(not in registration list)') AS fuel,
    r.REGIONID,
    COUNT(DISTINCT s.DUID)                                        AS units,
    -- SCADAVALUE is instantaneous MW at the interval start; convert to energy
    -- with the 5-minute interval length before summing.
    ROUND(SUM(s.SCADAVALUE) * 5.0 / 60.0, 0)                      AS mwh
FROM external_data.nemweb.silver_dispatch_scada_dispatch_unit_scada s
JOIN reg r
       ON r.DUID = s.DUID
      AND r.rn   = 1
      AND r.SCHEDULE_TYPE = 'NON-SCHEDULED'
LEFT JOIN fuel f
       ON f.DUID = s.DUID
      AND f.rn   = 1
WHERE s.SETTLEMENTDATE >= current_timestamp() - INTERVAL 2 DAYS
GROUP BY 1, 2
ORDER BY mwh DESC
