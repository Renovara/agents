-- Report 2: Curtailment by Hour of Day
WITH duid_region AS (
  SELECT `REGIONID`
  FROM `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE `DUID` = :duid
  ORDER BY `_ingest_timestamp` DESC
  LIMIT 1
),
intervals AS (
  SELECT
    HOUR(`d`.`SETTLEMENTDATE`) AS hour_of_day,
    `d`.`SEMIDISPATCHCAP`,
    `p`.`RRP`,
    GREATEST(`d`.`UIGF` - `d`.`TOTALCLEARED`, 0) AS curtailed_mw
  FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d`
    JOIN `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` `p`
      ON `d`.`SETTLEMENTDATE` = `p`.`SETTLEMENTDATE`
    JOIN duid_region `r`
      ON `p`.`REGIONID` = `r`.`REGIONID`
  WHERE `d`.`DUID` = :duid
    AND `d`.`SETTLEMENTDATE` >= :start_date
    AND `d`.`SETTLEMENTDATE` < DATE_ADD(:end_date, 1)
    AND `d`.`TOTALCLEARED` IS NOT NULL
    AND `d`.`UIGF` IS NOT NULL
    AND `p`.`INTERVENTION` = 0
    AND `d`.`INTERVENTION` = (
      SELECT MAX(`d2`.`INTERVENTION`)
      FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d2`
      WHERE `d2`.`DUID` = `d`.`DUID`
        AND `d2`.`SETTLEMENTDATE` = `d`.`SETTLEMENTDATE`
    )
)
SELECT
  hour_of_day,
  AVG(CASE WHEN `SEMIDISPATCHCAP` = 1 THEN curtailed_mw ELSE 0 END) AS avg_forced_curtailment_mw,
  AVG(CASE WHEN `SEMIDISPATCHCAP` = 0 AND `RRP` <= 0 THEN curtailed_mw ELSE 0 END) AS avg_economic_curtailment_mw
FROM intervals
GROUP BY hour_of_day
ORDER BY hour_of_day ASC
