-- Provide analysis for monthly FCAS revenue per MW for each of the 10 services in the NEM over the past 48 months.
WITH fcas_services AS (
  SELECT 'RAISE1SEC' AS service
  UNION ALL SELECT 'RAISE6SEC'
  UNION ALL SELECT 'RAISE60SEC'
  UNION ALL SELECT 'RAISE5MIN'
  UNION ALL SELECT 'RAISEREG'
  UNION ALL SELECT 'LOWER1SEC'
  UNION ALL SELECT 'LOWER6SEC'
  UNION ALL SELECT 'LOWER60SEC'
  UNION ALL SELECT 'LOWER5MIN'
  UNION ALL SELECT 'LOWERREG'
),
price_data AS (
  SELECT
    DATE_TRUNC('MONTH', p.`SETTLEMENTDATE`) AS month,
    p.`REGIONID`,
    p.`SETTLEMENTDATE`,
    p.`RAISE1SECRRP`,
    p.`RAISE6SECRRP`,
    p.`RAISE60SECRRP`,
    p.`RAISE5MINRRP`,
    p.`RAISEREGRRP`,
    p.`LOWER1SECRRP`,
    p.`LOWER6SECRRP`,
    p.`LOWER60SECRRP`,
    p.`LOWER5MINRRP`,
    p.`LOWERREGRRP`
  FROM
    `external_data`.`nemweb`.`silver_dispatchis_reports_dispatch_price` p
  WHERE
    p.`SETTLEMENTDATE` >= DATE_TRUNC('MONTH', DATE_SUB(CURRENT_DATE(), 96 * 30))
    AND p.`SETTLEMENTDATE` < DATE_TRUNC('MONTH', CURRENT_DATE())
),
enablement_data AS (
  SELECT
    DATE_TRUNC('MONTH', e.`SETTLEMENTDATE`) AS month,
    e.`SETTLEMENTDATE`,
    e.`DUID`,
    e.`RAISE1SEC`,
    e.`RAISE6SEC`,
    e.`RAISE60SEC`,
    e.`RAISE5MIN`,
    e.`RAISEREG`,
    e.`LOWER1SEC`,
    e.`LOWER6SEC`,
    e.`LOWER60SEC`,
    e.`LOWER5MIN`,
    e.`LOWERREG`,
    e.`RAISE1SECACTUALAVAILABILITY`,
    e.`RAISE6SECACTUALAVAILABILITY`,
    e.`RAISE60SECACTUALAVAILABILITY`,
    e.`RAISE5MINACTUALAVAILABILITY`,
    e.`RAISEREGACTUALAVAILABILITY`,
    e.`LOWER1SECACTUALAVAILABILITY`,
    e.`LOWER6SECACTUALAVAILABILITY`,
    e.`LOWER60SECACTUALAVAILABILITY`,
    e.`LOWER5MINACTUALAVAILABILITY`,
    e.`LOWERREGACTUALAVAILABILITY`
  FROM
    `external_data`.`nemweb`.`silver_next_day_dispatch_dispatch_unit_solution` e
  WHERE
    e.`SETTLEMENTDATE` >= DATE_TRUNC('MONTH', DATE_SUB(CURRENT_DATE(), 96 * 30))
    AND e.`SETTLEMENTDATE` < DATE_TRUNC('MONTH', CURRENT_DATE())
),
joined AS (
  SELECT
    ed.month,
    ed.`SETTLEMENTDATE`,
    fs.service,
    CASE fs.service
      WHEN 'RAISE1SEC' THEN pd.`RAISE1SECRRP`
      WHEN 'RAISE6SEC' THEN pd.`RAISE6SECRRP`
      WHEN 'RAISE60SEC' THEN pd.`RAISE60SECRRP`
      WHEN 'RAISE5MIN' THEN pd.`RAISE5MINRRP`
      WHEN 'RAISEREG' THEN pd.`RAISEREGRRP`
      WHEN 'LOWER1SEC' THEN pd.`LOWER1SECRRP`
      WHEN 'LOWER6SEC' THEN pd.`LOWER6SECRRP`
      WHEN 'LOWER60SEC' THEN pd.`LOWER60SECRRP`
      WHEN 'LOWER5MIN' THEN pd.`LOWER5MINRRP`
      WHEN 'LOWERREG' THEN pd.`LOWERREGRRP`
    END AS price,
    CASE fs.service
      WHEN 'RAISE1SEC' THEN ed.`RAISE1SEC`
      WHEN 'RAISE6SEC' THEN ed.`RAISE6SEC`
      WHEN 'RAISE60SEC' THEN ed.`RAISE60SEC`
      WHEN 'RAISE5MIN' THEN ed.`RAISE5MIN`
      WHEN 'RAISEREG' THEN ed.`RAISEREG`
      WHEN 'LOWER1SEC' THEN ed.`LOWER1SEC`
      WHEN 'LOWER6SEC' THEN ed.`LOWER6SEC`
      WHEN 'LOWER60SEC' THEN ed.`LOWER60SEC`
      WHEN 'LOWER5MIN' THEN ed.`LOWER5MIN`
      WHEN 'LOWERREG' THEN ed.`LOWERREG`
    END AS enabled_mw,
    CASE fs.service
      WHEN 'RAISE1SEC' THEN ed.`RAISE1SECACTUALAVAILABILITY`
      WHEN 'RAISE6SEC' THEN ed.`RAISE6SECACTUALAVAILABILITY`
      WHEN 'RAISE60SEC' THEN ed.`RAISE60SECACTUALAVAILABILITY`
      WHEN 'RAISE5MIN' THEN ed.`RAISE5MINACTUALAVAILABILITY`
      WHEN 'RAISEREG' THEN ed.`RAISEREGACTUALAVAILABILITY`
      WHEN 'LOWER1SEC' THEN ed.`LOWER1SECACTUALAVAILABILITY`
      WHEN 'LOWER6SEC' THEN ed.`LOWER6SECACTUALAVAILABILITY`
      WHEN 'LOWER60SEC' THEN ed.`LOWER60SECACTUALAVAILABILITY`
      WHEN 'LOWER5MIN' THEN ed.`LOWER5MINACTUALAVAILABILITY`
      WHEN 'LOWERREG' THEN ed.`LOWERREGACTUALAVAILABILITY`
    END AS available_mw
  FROM
    enablement_data ed
      JOIN price_data pd
        ON ed.`SETTLEMENTDATE` = pd.`SETTLEMENTDATE`
      CROSS JOIN fcas_services fs
),
revenue_calc AS (
  SELECT
    month,
    service,
    `SETTLEMENTDATE`,                          -- CHANGED: keep interval in this CTE
    TRY_DIVIDE(price * enabled_mw * 5.0, 60.0) AS revenue,
    available_mw
  FROM
    joined
  WHERE
    price IS NOT NULL
    AND available_mw IS NOT NULL
),
monthly_agg AS (
  SELECT
    month,
    service,
    SUM(revenue) AS total_revenue,
    SUM(available_mw) AS sum_available_mw,     -- CHANGED: renamed for clarity
    COUNT(DISTINCT `SETTLEMENTDATE`) AS intervals_in_month,  -- NEW: # of 5-min intervals
    TRY_DIVIDE(
      SUM(available_mw),
      NULLIF(COUNT(DISTINCT `SETTLEMENTDATE`), 0)
    ) AS avg_available_mw,                     -- NEW: average deployed MW in market
    TRY_DIVIDE(
      SUM(revenue),
      NULLIF(
        TRY_DIVIDE(
          SUM(available_mw),
          NULLIF(COUNT(DISTINCT `SETTLEMENTDATE`), 0)
        ),
        0
      )
    ) AS revenue_per_mw                        -- CHANGED: $ per MW per month
  FROM
    revenue_calc
  GROUP BY
    month,
    service
)
SELECT
  month,
  service,
  total_revenue,
  avg_available_mw,                            -- CHANGED: expose avg instead of sum
  revenue_per_mw
FROM
  monthly_agg
ORDER BY
  month,
  service;
