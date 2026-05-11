-- Report 1.1 Generator Overview
SELECT
  `DUID`,
  `STATION_NAME`,
  `REGIONID`,
  `DISPATCH_TYPE`,
  `CATEGORY`,
  `FUEL_SOURCE_PRIMARY`,
  `TECHNOLOGY_TYPE_PRIMARY`,
  `REG_CAP_GENERATION_MW`,
  `MAX_CAP_GENERATION_MW`
FROM
  `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
WHERE
  `DUID` = :duid
ORDER BY
  `_ingest_timestamp` DESC
LIMIT 1
