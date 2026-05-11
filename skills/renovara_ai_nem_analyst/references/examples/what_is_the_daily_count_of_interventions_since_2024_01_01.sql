-- What is the daily count of interventions since 2024-01-01?
SELECT
  date_trunc('day', TO_TIMESTAMP(SETTLEMENTDATE, 'yyyy/MM/dd HH:mm:ss')) AS agg_bucket,
  intervention,
  count(*) as count
FROM
  external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum
WHERE
  SETTLEMENTDATE >= '2024-01-01'
GROUP BY
  agg_bucket, INTERVENTION
ORDER BY
  agg_bucket DESC
