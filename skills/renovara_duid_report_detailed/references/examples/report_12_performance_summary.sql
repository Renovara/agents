-- Report 1.2 Performance Summary
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
    `d`.`DUID` = 'YABULU'
    AND `d`.`SETTLEMENTDATE` >= DATE_SUB(CURRENT_DATE, 30)
    AND `d`.`SETTLEMENTDATE` < DATE_ADD(CURRENT_DATE, 1)
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
