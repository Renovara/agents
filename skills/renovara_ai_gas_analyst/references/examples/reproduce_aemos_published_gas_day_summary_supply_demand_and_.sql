-- Reproduce AEMO's published gas day summary — supply, demand and net by state.
-- Gas day summary by state — reproduces AEMO's published GBB summary table.
--
-- This is the table on AEMO's GBB interactive map ("Summary" tab): SUPPLY,
-- DEMAND and NET in TJ per state, plus a total. Verified against the published
-- figures for gas day 2026-08-29 — see the reconciliation note at the bottom.
--
-- THE CRITICAL POINT: the summary is built from the PIPELINE rows, not from
-- production. Gas is recorded more than once as it moves through the network —
-- once at the producer, again as it is received and delivered across each
-- pipeline — so summing every facility type roughly DOUBLES the answer
-- (10,992 TJ instead of 5,489 TJ on 2026-08-29). Filtering to FacilityType =
-- 'PIPE' counts each molecule once, at the transmission system boundary, which
-- is the basis AEMO publishes on.
--
-- AEMO's own definitions, from the map page:
--   Supply — total production and storage receipted into the state, except
--            Victoria, where it relates only to the Victorian Transmission
--            System.
--   Demand — total demand in the state, except Victoria which is based on the
--            Victorian Transmission System; VTS nominations are at controllable
--            points only and a calculation presents the uncontrollable data.
--            Some GPG nomination data may be excluded by the aggregation
--            methodology.
SELECT
    COALESCE(State, 'TOTAL')          AS location,
    ROUND(SUM(Supply), 0)             AS supply_tj,
    ROUND(SUM(Demand), 0)             AS demand_tj,
    ROUND(SUM(Supply) - SUM(Demand), 0) AS net_tj
FROM external_data.nemweb.silver_gbb_actual_flow_storage
WHERE GasDate = DATE'2026-08-29'
  AND FacilityType = 'PIPE'
GROUP BY ROLLUP (State)
ORDER BY (State IS NULL), State;

-- Verified 2026-09-02 against AEMO's published summary for gas day 2026-08-29:
--
--   state   AEMO supply / ours    AEMO demand / ours
--   QLD       4,249 / 4,249  ok     4,384 / 4,384  ok
--   NSW           0 /     0  ok       337 /   337  ok
--   SA          219 /   219  ok       136 /   136  ok
--   VIC         964 /   964  ok       495 /   501  +6
--   TAS           0 /     0  ok        40 /    40  ok
--   NT           57 /    57  ok        48 /    57  +9
--   TOTAL     5,489 / 5,489  ok     5,440 / 5,455  +15
--
-- Supply matches exactly on all six states and the total. Demand matches on
-- four. The two that differ are both explained, and neither is a data error:
--
-- VICTORIA (+6.2). Fully accounted for. AEMO publishes Victorian demand on the
-- Victorian Transmission System only, and only at genuine demand zones:
--
--     VTS Melbourne 311.9 + Geelong 54.6 + Northern 48.8 + Gippsland 36.7
--       + Ballarat 31.9 + Western 11.2                      = 495.1  -> AEMO 495
--     our extra: VTS Iona Hub 2.7 (a storage hub, not end use)
--                BassGas to Pakenham 2.7   (non-VTS pipeline)
--                Eastern Gas Pipeline 0.7  (non-VTS pipeline)
--     501.2 - 2.7 - 2.7 - 0.7 = 495.1. Exact.
--
-- NORTHERN TERRITORY (+9.1). Mechanism identified, exact exclusion not
-- uniquely determinable from a rounded published figure. Every NT pipeline
-- delivery equals a generator's consumption to the decimal:
--
--     Amadeus Gas Pipeline (Darwin)  20.4 = Channel Island Power Station 20.4
--     Wickham Point Pipeline         10.8 = Weddell Power Station        10.8
--     McArthur River Pipeline         9.5 = McArthur River Mine           9.5
--
-- i.e. the pipeline's delivery and the generator's burn are the SAME gas,
-- recorded twice by two different reporting entities. That is precisely what
-- AEMO's "some GPG nomination data may be excluded ... due to the aggregation
-- methodology" footnote is about. Removing McArthur River gives 47.6 and
-- removing Tanami gives 48.4; both round to the published 48, so which one
-- AEMO drops cannot be settled from the rounded figure alone.
--
-- Do NOT "fix" either by adjusting this query. The difference is AEMO's
-- published basis differing from the raw submissions, and the raw submissions
-- are what this table holds — which is the more useful thing to hold, because
-- you can always aggregate up to AEMO's basis and never back down from it.
--
-- Also verified at finer grain on the same gas day. Location pins on the map
-- are PIPE demand at that location — Curtis Island 4,174, Sydney 221,
-- Adelaide 49, Brisbane 37, all exact. Production pins are PROD supply at that
-- facility — Woleebee Creek 643, Longford 636, Moomba 216, all exact.
