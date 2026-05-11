-- Report 2: Capacity Factor by Hour of Day
WITH duid_info AS (
  SELECT
    `REG_CAP_GENERATION_MW`
  FROM
    `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE
    `DUID` = :duid
  ORDER BY
    `_ingest_timestamp` DESC
  LIMIT 1
),
intervals AS (
  SELECT
    HOUR(`d`.`SETTLEMENTDATE`) AS hour_of_day,
    (`d`.`TOTALCLEARED` / NULLIF(`di`.`REG_CAP_GENERATION_MW`, 0)) * 100 AS capacity_factor_pct
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d`
      CROSS JOIN duid_info `di`
  WHERE
    `d`.`DUID` = :duid
    AND `d`.`SETTLEMENTDATE` >= :start_date
    AND `d`.`SETTLEMENTDATE` < DATE_ADD(:end_date, 1)
    AND `d`.`TOTALCLEARED` IS NOT NULL
    -- Power: use physical run (max INTERVENTION, i.e. base case if intervention occurred)
    AND `d`.`INTERVENTION` = (
      SELECT MAX(`d2`.`INTERVENTION`)
      FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d2`
      WHERE `d2`.`DUID` = `d`.`DUID`
        AND `d2`.`SETTLEMENTDATE` = `d`.`SETTLEMENTDATE`
    )
)
SELECT
  hour_of_day,
  AVG(capacity_factor_pct) AS avg_capacity_factor_pct,
  PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY capacity_factor_pct) AS p10_capacity_factor_pct,
  PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY capacity_factor_pct) AS p90_capacity_factor_pct
FROM
  intervals
GROUP BY
  hour_of_day
ORDER BY
  hour_of_day ASC
