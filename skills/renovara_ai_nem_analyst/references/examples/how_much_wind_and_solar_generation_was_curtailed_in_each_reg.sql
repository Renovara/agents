-- How much wind and solar generation was curtailed in each region over the last 7 days?
-- How much wind and solar generation was curtailed in each region over the
-- last 7 days?
--
-- Curtailment splits into two different things, and conflating them is the
-- usual mistake:
--
--   UIGF - TOTALCLEARED   the dispatch engine declined available energy.
--                         THIS is curtailment (network or economic).
--   TOTALCLEARED - SCADA  the unit did not deliver its target. That is
--                         deviation/conformance, not curtailment.
--
-- Measured over 3 days of semi-scheduled units: 22,152 MWh was the dispatch
-- decision and 2,858 MWh was unit deviation — so lumping them together
-- overstates curtailment by roughly 12%. Both are reported below.
--
-- SEMIDISPATCHCAP = 1 marks intervals where dispatch actually capped the unit,
-- which separates network curtailment from a unit bidding itself off.
WITH reg AS (
    -- dudetailsummary is effective-dated: ~387,000 rows for ~1,014 DUIDs,
    -- about 382 versions each. Joining it directly multiplies every total by
    -- that factor while the output still looks plausible. Always collapse to
    -- the current row per DUID first.
    SELECT
        DUID,
        REGIONID,
        ROW_NUMBER() OVER (
            PARTITION BY DUID ORDER BY START_DATE DESC, LASTCHANGED DESC
        ) AS rn
    FROM external_data.nemweb.silver___participant_registration_dudetailsummary
)
SELECT
    r.REGIONID,
    date_trunc('DAY', s.SETTLEMENTDATE)                        AS day,
    -- UIGF and SCADAVALUE are instantaneous MW at the interval start, so
    -- convert to energy with the 5-minute interval length before summing.
    ROUND(SUM(u.UIGF)       * 5.0 / 60.0, 1)                   AS available_mwh,
    ROUND(SUM(u.TOTALCLEARED) * 5.0 / 60.0, 1)                 AS cleared_mwh,
    ROUND(SUM(s.SCADAVALUE) * 5.0 / 60.0, 1)                   AS actual_mwh,
    -- Curtailment proper: available energy dispatch chose not to take.
    ROUND(SUM(u.UIGF - u.TOTALCLEARED) * 5.0 / 60.0, 1)        AS curtailed_mwh,
    ROUND(100 * SUM(u.UIGF - u.TOTALCLEARED) / NULLIF(SUM(u.UIGF), 0), 1)
                                                               AS curtailed_pct,
    -- Separate line: the unit missing its own target. Not curtailment.
    ROUND(SUM(u.TOTALCLEARED - s.SCADAVALUE) * 5.0 / 60.0, 1)  AS deviation_mwh
FROM external_data.nemweb.silver_dispatch_scada_dispatch_unit_scada s
JOIN external_data.nemweb.silver_next_day_dispatch_dispatch_unit_solution u
       ON u.SETTLEMENTDATE = s.SETTLEMENTDATE
      AND u.DUID           = s.DUID
      -- Intervention runs repeat the interval and would double count. No
      -- intervention has occurred since 2024-11-27, so this is a no-op on a
      -- recent window — but it is essential over any multi-year window, where
      -- 7.46M intervention rows exist.
      AND u.INTERVENTION   = 0
JOIN reg r
       ON r.DUID = s.DUID
      AND r.rn   = 1
WHERE s.SETTLEMENTDATE >= current_timestamp() - INTERVAL 7 DAYS
  -- UIGF is 0 (never NULL) for SCHEDULED and NON-SCHEDULED units, so `> 0`
  -- is what restricts this to semi-scheduled wind and solar. Do NOT use
  -- `UIGF IS NOT NULL` for that — it is true for every row and filters
  -- nothing. It also drops overnight intervals where the resource is zero,
  -- which are not curtailment.
  AND u.UIGF > 0
GROUP BY 1, 2
ORDER BY 1, 2
