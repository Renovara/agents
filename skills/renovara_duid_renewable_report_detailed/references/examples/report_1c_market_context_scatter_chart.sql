-- Report 1c: Market Context Scatter Chart
-- guidance: Run this query to generate the market context scatter chart. Select the REGIONID based on the DUID provided by the user.
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
  AND `p`.`SETTLEMENTDATE` >= DATE_SUB(DATE(CONVERT_TIMEZONE('UTC', 'Australia/Brisbane', CURRENT_TIMESTAMP())), 13)
  AND `p`.`SETTLEMENTDATE` < DATE_ADD(DATE(CONVERT_TIMEZONE('UTC', 'Australia/Brisbane', CURRENT_TIMESTAMP())), 1)
  -- Prices: use pricing run (INTERVENTION = 0)
  AND `p`.`INTERVENTION` = 0
  -- Demand: use physical run (max INTERVENTION, i.e. base case if intervention occurred)
  AND `r`.`INTERVENTION` = (
    SELECT MAX(`r2`.`INTERVENTION`)
    FROM `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_regionsum` `r2`
    WHERE `r2`.`REGIONID` = `r`.`REGIONID`
      AND `r2`.`SETTLEMENTDATE` = `r`.`SETTLEMENTDATE`
  )
GROUP BY
  DATE(`p`.`SETTLEMENTDATE`),
  HOUR(`p`.`SETTLEMENTDATE`)
ORDER BY
  date,
  hour_of_day
