-- Report 2: Capacity and Availability Analysis: Comparison of generator availability with market energy prices.
WITH duid_info AS (
  SELECT
    REG_CAP_GENERATION_MW
  FROM
    `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
  WHERE
    DUID = :duid
  ORDER BY
    _ingest_timestamp DESC
  LIMIT 1
),
intervals AS (
  SELECT
    d.SETTLEMENTDATE,
    d.AVAILABILITY,
    d.DUID
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` d
  WHERE
    d.DUID = :duid
    AND d.SETTLEMENTDATE >= DATE_SUB(CURRENT_DATE, 13)
    AND d.SETTLEMENTDATE < DATE_ADD(CURRENT_DATE, 1)
    AND d.AVAILABILITY IS NOT NULL
),
availability_calc AS (
  SELECT
    i.SETTLEMENTDATE,
    i.AVAILABILITY,
    (try_divide(i.AVAILABILITY, NULLIF(di.REG_CAP_GENERATION_MW, 0))) * 100 AS availability_pct
  FROM
    intervals i CROSS JOIN duid_info di
)
SELECT
  a.SETTLEMENTDATE,
  a.availability_pct,
  p.RRP
FROM
  availability_calc a
    LEFT JOIN `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` p
      ON a.SETTLEMENTDATE = p.SETTLEMENTDATE
      AND p.REGIONID = (
        SELECT
          REGIONID
        FROM
          `external_data`.`nemweb`.`silver_nem_participant_and_scheduled_loads`
        WHERE
          DUID = :duid
        ORDER BY
          _ingest_timestamp DESC
        LIMIT 1
      )
WHERE
  p.RRP IS NOT NULL
ORDER BY
  a.SETTLEMENTDATE ASC
