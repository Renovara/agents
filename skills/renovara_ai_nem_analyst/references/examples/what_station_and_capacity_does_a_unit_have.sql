-- What station and capacity does a unit have?
-- What station is a unit at, how big is it, and how has its registered
-- capacity changed? (Here: the Gladstone and Eraring coal units.)
--
-- Today's answer is one row per DUID in v_duid_registration: region, station
-- id and name, dispatch and schedule type, fuel group and capacity. Station
-- names come from silver___participant_registration_station and are AEMO's
-- registered names, in mixed case ('ERARING POWER STATION', 'Bayswater Power
-- Station'), so match them case-insensitively; one station can hold several
-- plants ('Swanbank B Power Station & Swanbank E Gas Turbine').
--
-- History is in silver___participant_registration_dudetail, effective-dated
-- and versioned per DUID: the row in force on a date is the latest
-- EFFECTIVEDATE on or before it, at that date's highest VERSIONNO. It holds
-- one full copy per monthly archive loaded, so take DISTINCT effective rows
-- before counting or summing them.
--
-- MAXCAPACITY is the figure used for bid validation, in whole MW; for most
-- solar farms it is the AC limit, below REGISTEREDCAPACITY (the DC rating).
-- Use max_capacity_mw for capacity factors.
WITH units AS (
    SELECT duid, region_id, station_id, station_name, fuel_group,
           registered_capacity_mw, max_capacity_mw
    FROM external_data.nemweb.v_duid_registration
    WHERE station_id IN ('G/STONE', 'ERARING')
      AND dispatch_type = 'GENERATOR'
),
history AS (
    -- Each effective-dated version once, however many monthly copies hold it.
    SELECT DISTINCT TRIM(DUID) AS duid, EFFECTIVEDATE, VERSIONNO, REGISTEREDCAPACITY, MAXCAPACITY
    FROM external_data.nemweb.silver___participant_registration_dudetail
    WHERE TRIM(DUID) IN (SELECT duid FROM units)
),
in_force AS (
    -- The highest version of each effective date.
    SELECT * FROM history
    QUALIFY ROW_NUMBER() OVER (PARTITION BY duid, EFFECTIVEDATE ORDER BY VERSIONNO DESC) = 1
)
SELECT
    u.station_name,
    u.duid,
    u.max_capacity_mw                          AS max_capacity_mw_today,
    u.registered_capacity_mw                   AS registered_capacity_mw_today,
    COUNT(*)                                   AS effective_dates,
    MIN(i.EFFECTIVEDATE)                       AS first_effective,
    MIN(i.MAXCAPACITY)                         AS lowest_max_capacity_mw,
    MAX(i.MAXCAPACITY)                         AS highest_max_capacity_mw
FROM units u
JOIN in_force i ON i.duid = u.duid
GROUP BY 1, 2, 3, 4
ORDER BY 1, 2
