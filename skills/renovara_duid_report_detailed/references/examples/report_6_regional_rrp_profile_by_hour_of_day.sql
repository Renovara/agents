-- Report 6: Regional RRP Profile by Hour of Day
WITH duid_region AS (
  SELECT
    region_id AS REGIONID
  FROM
    external_data.nemweb.v_duid_registration
  WHERE
    duid = 'YABULU'
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
