-- Report 5: Earnings per Megawatt by Hour of Day
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
),
earnings AS (
  SELECT
    HOUR(i.SETTLEMENTDATE) AS hour_of_day,
    i.TOTALCLEARED,
    r.RRP,
    (i.TOTALCLEARED * r.RRP * (try_divide(5.0, 60.0))) AS revenue,
    TRY_DIVIDE(
      (i.TOTALCLEARED * r.RRP * (try_divide(5.0, 60.0))), NULLIF(i.TOTALCLEARED, 0)
    ) AS earnings_per_mw
  FROM
    intervals i
      LEFT JOIN rrp_data r
        ON i.SETTLEMENTDATE = r.SETTLEMENTDATE
  WHERE
    i.TOTALCLEARED IS NOT NULL
    AND r.RRP IS NOT NULL
)
SELECT
  hour_of_day,
  AVG(earnings_per_mw) AS avg_earnings_per_mw,
  PERCENTILE(earnings_per_mw, 0.9) AS p90_earnings_per_mw,
  PERCENTILE(earnings_per_mw, 0.1) AS p10_earnings_per_mw
FROM
  earnings
WHERE
  earnings_per_mw IS NOT NULL
GROUP BY
  hour_of_day
ORDER BY
  hour_of_day ASC
LIMIT 24
