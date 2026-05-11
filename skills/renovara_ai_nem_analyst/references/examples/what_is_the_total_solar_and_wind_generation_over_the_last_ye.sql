-- What is the total solar and wind generation over the last year?
SELECT
  date(SETTLEMENTDATE) AS date,
  SUM(SS_SOLAR_CLEAREDMW + (DEMAND_AND_NONSCHEDGEN - TOTALDEMAND)) * (5.0/60.0) AS total_solar_mwh,
  -- SUM(SS_SOLAR_CLEAREDMW) * (5.0/60.0) AS total_solar_mwh,
  SUM(SS_WIND_CLEAREDMW) * (5.0 / 60.0) AS total_wind_mwh
FROM
  nemweb.silver_dispatchis_reports_dispatch_regionsum
WHERE
  SETTLEMENTDATE >= date_add(YEAR, -1, current_date())
GROUP BY
  date
ORDER BY
  date
