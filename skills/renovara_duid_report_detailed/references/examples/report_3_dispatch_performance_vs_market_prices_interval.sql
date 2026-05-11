-- Report 3: Dispatch Performance vs Market Prices interval:
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
intervals AS (
  SELECT
    d.SETTLEMENTDATE,
    d.TOTALCLEARED,
    d.DUID
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` d
  WHERE
    d.DUID = 'YABULU'
    AND d.SETTLEMENTDATE >= DATE_SUB(CURRENT_DATE, 13)
    AND d.SETTLEMENTDATE < DATE_ADD(CURRENT_DATE, 1)
    AND d.TOTALCLEARED IS NOT NULL
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
    AND p.RRP IS NOT NULL
)
SELECT
  i.SETTLEMENTDATE,
  i.TOTALCLEARED,
  r.RRP
FROM
  intervals i
    LEFT JOIN rrp_data r
      ON i.SETTLEMENTDATE = r.SETTLEMENTDATE
ORDER BY
  i.SETTLEMENTDATE ASC
LIMIT 5000
