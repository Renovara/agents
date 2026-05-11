-- Report 1: Curtailment Summary
WITH duid_region AS (
  SELECT `REGIONID`
  FROM `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE `DUID` = :duid
  ORDER BY `_ingest_timestamp` DESC
  LIMIT 1
),
intervals AS (
  SELECT
    `d`.`SETTLEMENTDATE`,
    `d`.`UIGF`,
    `d`.`TOTALCLEARED`,
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
    -- Prices: pricing run (INTERVENTION = 0)
    AND `p`.`INTERVENTION` = 0
    -- Power: physical run (max INTERVENTION per interval)
    AND `d`.`INTERVENTION` = (
      SELECT MAX(`d2`.`INTERVENTION`)
      FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d2`
      WHERE `d2`.`DUID` = `d`.`DUID`
        AND `d2`.`SETTLEMENTDATE` = `d`.`SETTLEMENTDATE`
    )
)
SELECT
  COUNT(*) AS total_intervals,
  SUM(CASE WHEN `SEMIDISPATCHCAP` = 1 THEN 1 ELSE 0 END) AS capped_intervals,
  SUM(CASE WHEN curtailed_mw > 0 THEN 1 ELSE 0 END) AS curtailed_intervals,
  SUM(CASE WHEN `SEMIDISPATCHCAP` = 1 THEN curtailed_mw ELSE 0 END) * (5.0 / 60.0) AS forced_curtailed_mwh,
  SUM(CASE WHEN `SEMIDISPATCHCAP` = 0 AND `RRP` <= 0 THEN curtailed_mw ELSE 0 END) * (5.0 / 60.0) AS economic_curtailed_mwh,
  SUM(`UIGF`) * (5.0 / 60.0) AS available_mwh,
  100.0 * SUM(CASE WHEN `SEMIDISPATCHCAP` = 1 THEN curtailed_mw ELSE 0 END)
        / NULLIF(SUM(`UIGF`), 0) AS forced_curtailment_pct,
  100.0 * SUM(CASE WHEN `SEMIDISPATCHCAP` = 0 AND `RRP` <= 0 THEN curtailed_mw ELSE 0 END)
        / NULLIF(SUM(`UIGF`), 0) AS economic_curtailment_pct,
  SUM(CASE WHEN `SEMIDISPATCHCAP` = 1 AND `RRP` > 0
           THEN curtailed_mw * `RRP` * (5.0 / 60.0) ELSE 0 END) AS forced_foregone_revenue_aud,
  MAX(CASE WHEN `SEMIDISPATCHCAP` = 1 THEN curtailed_mw ELSE 0 END) AS worst_cap_mw
FROM intervals
