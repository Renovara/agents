-- Report 1: Market Context Overview
-- guidance: Run this query to generate the results for: ## Report 1: Market Context Overview

Select the REGIONID based on the DUID provided by the user.
SELECT
  DATE(`p`.`SETTLEMENTDATE`) AS date,
  HOUR(`p`.`SETTLEMENTDATE`) AS hour_of_day,
  AVG(`p`.`RRP`) AS avg_rrp,
  AVG(`r`.`TOTALDEMAND`) AS avg_total_demand,
  COUNT(*) AS interval_count
FROM
  `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` AS `p`
    INNER JOIN `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_regionsum` AS `r`
      ON `p`.`SETTLEMENTDATE` = `r`.`SETTLEMENTDATE`
      AND `p`.`REGIONID` = `r`.`REGIONID`
WHERE
  `p`.`REGIONID` = :regionid
  AND `p`.`SETTLEMENTDATE` >= TIMESTAMP('2025-11-25 00:00:00')
  AND `p`.`SETTLEMENTDATE` < TIMESTAMP('2025-12-10 00:00:00')
GROUP BY
  DATE(`p`.`SETTLEMENTDATE`),
  HOUR(`p`.`SETTLEMENTDATE`)
ORDER BY
  date,
  hour_of_day
