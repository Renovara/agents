-- Report 3: Top Binding Constraints During Caps
WITH duid_cp AS (
  SELECT `CONNECTIONPOINTID`, `REGIONID`
  FROM `external_data`.`nemweb`.`silver___participant_registration_dudetailsummary`
  WHERE `DUID` = :duid
  ORDER BY `START_DATE` DESC
  LIMIT 1
),
duid_capped_intervals AS (
  SELECT `d`.`SETTLEMENTDATE`
  FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d`
  WHERE `d`.`DUID` = :duid
    AND `d`.`SETTLEMENTDATE` >= :start_date
    AND `d`.`SETTLEMENTDATE` < DATE_ADD(:end_date, 1)
    AND `d`.`SEMIDISPATCHCAP` = 1
    AND `d`.`INTERVENTION` = (
      SELECT MAX(`d2`.`INTERVENTION`)
      FROM `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` `d2`
      WHERE `d2`.`DUID` = `d`.`DUID`
        AND `d2`.`SETTLEMENTDATE` = `d`.`SETTLEMENTDATE`
    )
),
total_caps AS (
  SELECT COUNT(*) AS n FROM duid_capped_intervals
),
binding AS (
  SELECT
    `c`.`CONSTRAINTID`,
    `c`.`MARGINALVALUE`
  FROM `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_constraint` `c`
    JOIN duid_capped_intervals `i`
      ON `c`.`SETTLEMENTDATE` = `i`.`SETTLEMENTDATE`
  WHERE `c`.`MARGINALVALUE` > 0
    AND `c`.`INTERVENTION` = 0
),
cp_attributed AS (
  SELECT DISTINCT `spdcp`.`GENCONID` AS constraint_id
  FROM `external_data`.`nemweb`.`silver___spdcpc` `spdcp`
    CROSS JOIN duid_cp `dcp`
  WHERE `spdcp`.`CONNECTIONPOINTID` = `dcp`.`CONNECTIONPOINTID`
    AND `spdcp`.`BIDTYPE` = 'ENERGY'
    AND `spdcp`.`FACTOR` != 0
),
region_attributed AS (
  SELECT DISTINCT `spdr`.`GENCONID` AS constraint_id
  FROM `external_data`.`nemweb`.`silver___spdrc` `spdr`
    CROSS JOIN duid_cp `dcp`
  WHERE `spdr`.`REGIONID` = `dcp`.`REGIONID`
    AND `spdr`.`BIDTYPE` = 'ENERGY'
    AND `spdr`.`FACTOR` != 0
)
SELECT
  CASE
    WHEN `cp`.`constraint_id` IS NOT NULL THEN 'Direct (CP)'
    WHEN `rg`.`constraint_id` IS NOT NULL THEN 'Region (NSW1/etc)'
    ELSE 'System (associative)'
  END AS attribution_type,
  `b`.`CONSTRAINTID` AS constraint_id,
  COALESCE(`g`.`DESCRIPTION`, '(no metadata)') AS description,
  COALESCE(`g`.`REASON`, '') AS reason,
  COALESCE(`g`.`LIMITTYPE`, '') AS limit_type,
  COALESCE(`g`.`IMPACT`, '') AS impact,
  COUNT(*) AS intervals_binding_during_cap,
  ROUND(100.0 * COUNT(*) / NULLIF((SELECT n FROM total_caps), 0), 1) AS pct_of_duid_caps,
  ROUND(AVG(`b`.`MARGINALVALUE`), 2) AS avg_marginal_value_aud
FROM binding `b`
  LEFT JOIN cp_attributed `cp` ON `cp`.`constraint_id` = `b`.`CONSTRAINTID`
  LEFT JOIN region_attributed `rg` ON `rg`.`constraint_id` = `b`.`CONSTRAINTID`
  LEFT JOIN (
    SELECT `GENCONID`,
           `DESCRIPTION`,
           `REASON`,
           `LIMITTYPE`,
           `IMPACT`,
           ROW_NUMBER() OVER (PARTITION BY `GENCONID` ORDER BY `EFFECTIVEDATE` DESC, `VERSIONNO` DESC) AS rn
    FROM `external_data`.`nemweb`.`silver___gencondata`
  ) `g` ON `g`.`GENCONID` = `b`.`CONSTRAINTID` AND `g`.`rn` = 1
GROUP BY
  `cp`.`constraint_id`,
  `rg`.`constraint_id`,
  `b`.`CONSTRAINTID`,
  `g`.`DESCRIPTION`,
  `g`.`REASON`,
  `g`.`LIMITTYPE`,
  `g`.`IMPACT`
ORDER BY
  CASE
    WHEN `cp`.`constraint_id` IS NOT NULL THEN 1
    WHEN `rg`.`constraint_id` IS NOT NULL THEN 2
    ELSE 3
  END,
  intervals_binding_during_cap DESC
LIMIT 30
