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
-- Schedule type, region and fuel come from v_duid_registration, one row per
-- DUID (AEMO's DUDETAILSUMMARY and v_duid_fuel_aemo), so the join cannot fan
-- out. Joining silver___participant_registration_dudetailsummary directly
-- instead needs its ~382 rows per DUID collapsed first, or every MWh total is
-- multiplied.
SELECT
    r.fuel_group                              AS fuel,
    r.region_id,
    COUNT(DISTINCT s.DUID)                    AS units,
    -- SCADAVALUE is instantaneous MW at the interval start; convert to energy
    -- with the 5-minute interval length before summing.
    ROUND(SUM(s.SCADAVALUE) * 5.0 / 60.0, 0)  AS mwh
FROM external_data.nemweb.silver_dispatch_scada_dispatch_unit_scada s
JOIN external_data.nemweb.v_duid_registration r
  ON r.duid = s.DUID
 AND r.schedule_type = 'NON-SCHEDULED'
WHERE s.SETTLEMENTDATE >= current_timestamp() - INTERVAL 2 DAYS
GROUP BY 1, 2
ORDER BY mwh DESC
