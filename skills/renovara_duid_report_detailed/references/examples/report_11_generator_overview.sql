-- Report 1.1 Generator Overview
SELECT
  `duid`,
  `station_name`,
  `region_id`,
  `participant_id`,
  `dispatch_type`,
  `schedule_type`,
  `fuel_group`,
  `co2e_energy_source`,
  `registered_capacity_mw`,
  `max_capacity_mw`,
  `max_storage_capacity_mwh`
FROM
  `external_data`.`nemweb`.`v_duid_registration`
WHERE
  `duid` = :duid
