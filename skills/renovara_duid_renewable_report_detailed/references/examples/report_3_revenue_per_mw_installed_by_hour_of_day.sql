-- Report 3: Revenue per MW Installed by Hour of Day
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
duid_region AS (
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
intervals AS (
  SELECT
    HOUR(`d`.`SETTLEMENTDATE`) AS hour_of_day,
    `d`.`TOTALCLEARED` * `p`.`RRP` * (5.0 / 60.0) AS interval_revenue,
    `di`.`REG_CAP_GENERATION_MW` AS reg_cap_mw
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d`
      CROSS JOIN duid_info `di`
      JOIN `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` `p`
        ON `d`.`SETTLEMENTDATE` = `p`.`SETTLEMENTDATE`
      JOIN duid_region `r`
        ON `p`.`REGIONID` = `r`.`REGIONID`
  WHERE
    `d`.`DUID` = :duid
    AND `d`.`SETTLEMENTDATE` >= :start_date
    AND `d`.`SETTLEMENTDATE` < DATE_ADD(:end_date, 1)
    AND `d`.`TOTALCLEARED` IS NOT NULL
    -- Prices: use pricing run (INTERVENTION = 0)
    AND `p`.`INTERVENTION` = 0
    -- Power: use physical run (max INTERVENTION per interval)
    AND `d`.`INTERVENTION` = (
      SELECT MAX(`d2`.`INTERVENTION`)
      FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d2`
      WHERE `d2`.`DUID` = `d`.`DUID`
        AND `d2`.`SETTLEMENTDATE` = `d`.`SETTLEMENTDATE`
    )
),
hourly AS (
  SELECT
    hour_of_day,
    SUM(interval_revenue) / NULLIF(MAX(reg_cap_mw), 0) AS total_revenue_per_mw_nameplate,
    SUM(interval_revenue) AS revenue_by_hour
  FROM
    intervals
  GROUP BY
    hour_of_day
)
SELECT
  hour_of_day,
  total_revenue_per_mw_nameplate,
  SUM(revenue_by_hour) OVER () AS total_gross_revenue
FROM
  hourly
ORDER BY
  hour_of_day ASC
