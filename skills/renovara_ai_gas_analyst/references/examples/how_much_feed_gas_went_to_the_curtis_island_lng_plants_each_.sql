-- How much feed gas went to the Curtis Island LNG plants each month since 2019, by pipeline?
-- Feed gas delivered to the Curtis Island LNG plants, by month and pipeline.
--
-- Queensland's three LNG export projects (APLNG, GLNG, QCLNG) take their feed
-- gas over three pipelines that end at Curtis Island. Each pipeline reports
-- its delivery there as a connection point in
-- silver_gbb_pipeline_connection_flow:
--
--   APLNG Pipeline  connection point 1404050  "Curtis Island"
--   GLNG Pipeline   connection point 1404160  "GTP Outlet Station Receipt point"
--   WGP (QCLNG)     connection point 1404194  "Curtis Island  - D"
--
-- All three sit at LocationId 540030 (Curtis Island). Filter on the location
-- and the DELIVERY direction rather than on connection point names, which are
-- denormalised and drift.
--
-- HISTORY. Both GBB actuals tables were backfilled from AEMO's full-history
-- files on 2026-10-01, so they run from gas day 2018-09-29 -- September 2018
-- is a partial month (one day), so start a time series at 2018-10 or later.
--
-- Quality: exclude anything not 'OK'. A NIL row usually carries 0.000, which
-- means "unknown", not "no flow". (None occur at Curtis Island to date.)
SELECT
    date_trunc('MONTH', f.GasDate)            AS gas_month,
    fac.FacilityName                          AS pipeline,
    ROUND(SUM(f.ActualQuantity), 0)           AS feed_gas_tj,
    COUNT(DISTINCT f.GasDate)                 AS gas_days
FROM external_data.nemweb.silver_gbb_pipeline_connection_flow f
LEFT JOIN external_data.nemweb.silver_gbb_facilities fac
       ON fac.FacilityId = f.FacilityId
WHERE f.LocationId = 540030
  AND f.FlowDirection = 'DELIVERY'
  AND f.Quality = 'OK'
  AND f.GasDate >= DATE'2019-01-01'
GROUP BY 1, 2
ORDER BY 1, 2;

-- Cross-check against the facility totals. The same deliveries appear in
-- silver_gbb_actual_flow_storage as PIPE-facility Demand at Curtis Island, and
-- the two agree to the terajoule in every calendar year 2019-2025 (measured
-- on AEMO's history files, 2026-10-01):
--
--   year   feed gas TJ        year   feed gas TJ
--   2019   1,325,397          2023   1,371,119
--   2020   1,337,533          2024   1,438,978
--   2021   1,407,356          2025   1,422,940
--   2022   1,357,584
--
-- About 1,300-1,450 PJ a year, the scale of Queensland's LNG exports. If the two
-- tables ever disagree for a period, one of them has a missing submission --
-- check COUNT(DISTINCT GasDate) per pipeline first.
--
--   SELECT year(GasDate) AS yr, ROUND(SUM(Demand), 0) AS feed_gas_tj
--   FROM external_data.nemweb.silver_gbb_actual_flow_storage
--   WHERE LocationId = 540030 AND FacilityType = 'PIPE'
--   GROUP BY 1 ORDER BY 1;
