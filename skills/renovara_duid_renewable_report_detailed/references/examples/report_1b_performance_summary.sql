-- Report 1b: Performance Summary
WITH duid_region AS (
  SELECT
    `REGIONID`
  FROM
    `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE
    `DUID` = :duid
  ORDER BY
    `_ingest_timestamp` DESC
  LIMIT 1
),
dispatch_data AS (
  SELECT
    `d`.`SETTLEMENTDATE`,
    `d`.`TOTALCLEARED`,
    `d`.`AVAILABILITY`,
    `p`.`RRP`
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d`
      JOIN `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` `p`
        ON `d`.`SETTLEMENTDATE` = `p`.`SETTLEMENTDATE`
      JOIN duid_region `r`
        ON `p`.`REGIONID` = `r`.`REGIONID`
  WHERE
    `d`.`DUID` = :duid
    AND `d`.`SETTLEMENTDATE` >= DATE_SUB(DATE(CONVERT_TIMEZONE('UTC', 'Australia/Brisbane', CURRENT_TIMESTAMP())), 30)
    AND `d`.`SETTLEMENTDATE` < DATE_ADD(DATE(CONVERT_TIMEZONE('UTC', 'Australia/Brisbane', CURRENT_TIMESTAMP())), 1)
    -- Prices: use pricing run (INTERVENTION = 0)
    AND `p`.`INTERVENTION` = 0
    -- Power: use physical run (max INTERVENTION, i.e. base case if intervention occurred)
    AND `d`.`INTERVENTION` = (
      SELECT MAX(`d2`.`INTERVENTION`)
      FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d2`
      WHERE `d2`.`DUID` = `d`.`DUID`
        AND `d2`.`SETTLEMENTDATE` = `d`.`SETTLEMENTDATE`
    )
)
SELECT
  COUNT(DISTINCT DATE(`SETTLEMENTDATE`)) AS days_in_period,
  COUNT(*) AS total_intervals,
  SUM(
    CASE
      WHEN `TOTALCLEARED` > 0 THEN 1
      ELSE 0
    END
  ) AS intervals_dispatched,
  ROUND(
    SUM(
      CASE
        WHEN `TOTALCLEARED` > 0 THEN 1
        ELSE 0
      END
    )
    * 100.0
    / COUNT(*),
    2
  ) AS pct_intervals_dispatched,
  SUM(`TOTALCLEARED` * (5.0 / 60.0)) AS total_energy_mwh,
  SUM(`TOTALCLEARED` * `RRP` * (5.0 / 60.0)) AS total_revenue,
  AVG(
    CASE
      WHEN `TOTALCLEARED` > 0 THEN `TOTALCLEARED`
      ELSE NULL
    END
  ) AS avg_dispatch_when_online,
  MAX(`TOTALCLEARED`) AS max_dispatch,
  AVG(`AVAILABILITY`) AS avg_availability
FROM
  dispatch_data
