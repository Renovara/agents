-- Report 7: Critical Price Events (Automated)
WITH duid_region AS (
  SELECT
    REGIONID
  FROM
    `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE
    DUID = 'YABULU'
  ORDER BY
    _ingest_timestamp DESC
  LIMIT 1
),
dispatch_data AS (
  SELECT
    d.SETTLEMENTDATE,
    d.AVAILABILITY,
    d.TOTALCLEARED,
    d.DUID
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` d
  WHERE
    d.DUID = 'YABULU'
    AND d.SETTLEMENTDATE >= DATE_SUB(CURRENT_DATE, 13)
    AND d.SETTLEMENTDATE < DATE_ADD(CURRENT_DATE, 1)
),
rrp_data AS (
  SELECT
    p.SETTLEMENTDATE,
    p.RRP
  FROM
    `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` p
      JOIN duid_region r
        ON p.REGIONID = r.REGIONID
  WHERE
    p.SETTLEMENTDATE >= DATE_SUB(CURRENT_DATE, 13)
    AND p.SETTLEMENTDATE < DATE_ADD(CURRENT_DATE, 1)
),
events AS (
  SELECT
    d.SETTLEMENTDATE,
    r.RRP,
    d.AVAILABILITY,
    d.TOTALCLEARED,
    CASE
      WHEN r.RRP > 300 THEN 'High Price'
      WHEN r.RRP < 0 THEN 'Negative Price'
    END AS event_type,
    CASE
      WHEN
        d.AVAILABILITY > 0
        AND d.TOTALCLEARED > 0
      THEN
        'Online'
      ELSE 'Offline'
    END AS observation
  FROM
    dispatch_data d
      JOIN rrp_data r
        ON d.SETTLEMENTDATE = r.SETTLEMENTDATE
  WHERE
    r.RRP > 300
    OR r.RRP < 0
)
SELECT
  RRP AS `Price ($/MWh)`,
  DATE(SETTLEMENTDATE) AS `Date`,
  DATE_FORMAT(SETTLEMENTDATE, 'HH:mm') AS `Time`,
  AVAILABILITY AS `Availability (MW)`,
  TOTALCLEARED AS `Dispatch (MW)`,
  event_type AS `Event Type`,
  observation AS `Observation`
FROM
  events
ORDER BY
  ABS(RRP) DESC
LIMIT 10
