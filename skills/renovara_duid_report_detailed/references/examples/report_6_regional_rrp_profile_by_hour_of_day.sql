-- Report 6: Regional RRP Profile by Hour of Day
WITH duid_region AS (
  SELECT
    REGIONID
  FROM
    `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE
    DUID = 'YABULU'
  ORDER BY
    _ingest_timestamp DESC
  LIMIT 1
)
SELECT
  DATE(p.SETTLEMENTDATE) AS date,
  DATE_FORMAT(p.SETTLEMENTDATE, 'HH:mm') AS time_of_day,
  AVG(p.RRP) AS avg_rrp
FROM
  `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` p
    JOIN duid_region r
      ON p.REGIONID = r.REGIONID
WHERE
  p.SETTLEMENTDATE >= DATE_SUB(CURRENT_DATE, 13)
  AND p.SETTLEMENTDATE < DATE_ADD(CURRENT_DATE, 1)
  AND p.RRP IS NOT NULL
GROUP BY
  DATE(p.SETTLEMENTDATE),
  DATE_FORMAT(p.SETTLEMENTDATE, 'HH:mm')
ORDER BY
  date,
  time_of_day
LIMIT 5000
