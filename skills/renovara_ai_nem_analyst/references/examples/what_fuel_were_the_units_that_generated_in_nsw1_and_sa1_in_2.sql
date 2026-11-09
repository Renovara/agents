-- What fuel were the units that generated in NSW1 and SA1 in 2021, including units that have since retired?
-- What fuel were the units that generated in a past period, including units
-- that have since retired? (Here: NSW1 and SA1, calendar 2021.)
--
-- A list of TODAY's registered units -- such as the NEM Registration and
-- Exemption List workbook, which this warehouse no longer loads -- misses
-- Liddell (LD01-04), Torrens Island A (TORRA1-4) and every other retired unit,
-- so joining history to it drops their energy into "unknown" without an error.
--
-- AEMO's own registration tables keep every unit ever registered:
--   silver___participant_registration_dualloc   DUID -> GENSETID, effective-dated
--   silver___participant_registration_genunits  GENSETID -> CO2E_ENERGY_SOURCE,
--                                               GENSETTYPE, MAXCAPACITY
-- Both hold one full cumulative copy per MMSDM month loaded, retired units in.
--
-- ⚠ DUALLOC is effective-dated AND versioned: take the gensets at the DUID's
--   latest EFFECTIVEDATE and, within it, the highest VERSIONNO. Joining raw
--   fans out ~8x for an old unit like LD01 and multiplies every MWh.
-- ⚠ GENUNITS repeats every genset once per month loaded: keep the latest
--   LASTCHANGED per GENSETID before joining, or MWh multiply again.
-- ⚠ CO2E_ENERGY_SOURCE is AEMO's emissions-factor fuel, not the QED fuel
--   group: it is blank for most loads and is not updated when a unit switches
--   fuel (SNAPPER1 reads 'Diesel oil' though AEMO counts it as gas from
--   2025-01-01). For the QED groups -- Hydro Pump Load, Battery for the old
--   split HPRG1/HPRL1 DUIDs, effective-dated SNAPPER1 -- use the view
--   v_duid_fuel_aemo, which is built from these two tables. This query shows
--   the raw join so the fallback logic is visible.
-- ⚠ Loads (pumps, the charge side of the old split batteries such as HPRL1)
--   report consumption as a positive SCADAVALUE, so they appear here too;
--   their CO2E_ENERGY_SOURCE is usually blank.
--
-- Whether a unit is still registered is DUDETAILSUMMARY's END_DATE, here
-- v_duid_registration.is_registered.
--
-- Measured on 2021: NSW1 retired Liddell LD01-04 = 8,189 GWh of black coal;
-- in SA1 the split battery DUIDs (HPRG1/HPRL1 and others) and Torrens Island
-- A (TORRA3) are retired too.
WITH gensets_now AS (
    SELECT DISTINCT DUID, GENSETID
    FROM (
        SELECT DUID, GENSETID,
               DENSE_RANK() OVER (PARTITION BY DUID ORDER BY EFFECTIVEDATE DESC, VERSIONNO DESC) AS rk
        FROM external_data.nemweb.silver___participant_registration_dualloc
    )
    WHERE rk = 1
),
genunits AS (
    -- One row per genset: the latest of the monthly copies.
    SELECT * FROM external_data.nemweb.silver___participant_registration_genunits
    QUALIFY ROW_NUMBER() OVER (PARTITION BY GENSETID ORDER BY LASTCHANGED DESC) = 1
),
duid_fuel AS (
    -- One fuel per DUID: the largest genset's CO2E_ENERGY_SOURCE.
    SELECT a.DUID,
           MAX_BY(g.CO2E_ENERGY_SOURCE, g.MAXCAPACITY) AS co2e_energy_source,
           SUM(g.MAXCAPACITY)                          AS max_capacity_mw
    FROM gensets_now a
    JOIN genunits g
      ON g.GENSETID = a.GENSETID
    GROUP BY a.DUID
),
gen AS (
    SELECT s.DUID, d.REGIONID, SUM(s.SCADAVALUE) * 5.0 / 60.0 AS mwh
    FROM external_data.nemweb.silver_dispatch_scada_dispatch_unit_scada s
    JOIN (
        SELECT DUID, REGIONID,
               ROW_NUMBER() OVER (PARTITION BY DUID ORDER BY START_DATE DESC, LASTCHANGED DESC) AS rn
        FROM external_data.nemweb.silver___participant_registration_dudetailsummary
    ) d ON d.DUID = s.DUID AND d.rn = 1
    WHERE s.SETTLEMENTDATE >= '2021-01-01' AND s.SETTLEMENTDATE < '2022-01-01'
      AND d.REGIONID IN ('NSW1', 'SA1')
      AND s.SCADAVALUE > 0
    GROUP BY s.DUID, d.REGIONID
)
SELECT
    g.REGIONID,
    COALESCE(f.co2e_energy_source, '(blank in GENUNITS)')       AS co2e_energy_source,
    CASE WHEN r.is_registered THEN 'registered today'
         ELSE 'retired' END                                     AS registration_status,
    COUNT(*)                                                    AS units,
    ROUND(SUM(g.mwh) / 1000, 0)                                 AS gwh,
    CONCAT_WS(',', SLICE(SORT_ARRAY(COLLECT_LIST(g.DUID)), 1, 8)) AS example_duids
FROM gen g
LEFT JOIN duid_fuel f ON f.DUID = g.DUID
LEFT JOIN external_data.nemweb.v_duid_registration r ON r.duid = g.DUID
GROUP BY 1, 2, 3
ORDER BY 1, gwh DESC
