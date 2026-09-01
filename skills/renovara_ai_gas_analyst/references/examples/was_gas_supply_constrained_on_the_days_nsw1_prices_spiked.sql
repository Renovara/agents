-- Was gas supply constrained on the days NSW1 prices spiked?
-- Was gas supply physically constrained on the days NSW1 prices spiked?
--
-- Joins AEMO Gas Bulletin Board linepack capacity adequacy (the pipeline
-- operators' own GREEN/AMBER/RED declaration) to NEM dispatch prices, at the
-- gas-day grain.
--
-- The join is DATE(SETTLEMENTDATE) = GasDate, and it is deliberately
-- day-level: the gas day runs 06:00-06:00 AEST, so GasDate is a day label and
-- not an instant. Joining it to a timestamp would attribute intervals to the
-- wrong gas day by six hours.
--
-- Reads as evidence, not proof. A constrained pipeline shows gas was tight;
-- use f_price_setter_by_fuel to establish whether gas actually set the price.
WITH daily_price AS (
    SELECT
        DATE(SETTLEMENTDATE)      AS gas_day,
        REGIONID,
        MAX(RRP)                  AS max_rrp,
        AVG(RRP)                  AS avg_rrp,
        SUM(CASE WHEN RRP > 300 THEN 1 ELSE 0 END) AS intervals_over_300
    FROM external_data.nemweb.silver_dispatchis_reports_dispatch_price
    WHERE REGIONID = 'NSW1'
      AND SETTLEMENTDATE >= current_date() - INTERVAL 30 DAYS
    GROUP BY 1, 2
),
gas_flags AS (
    SELECT
        lca.GasDate                                   AS gas_day,
        COUNT(*)                                      AS facilities_reporting,
        SUM(CASE WHEN lca.Flag = 'AMBER' THEN 1 ELSE 0 END) AS amber,
        SUM(CASE WHEN lca.Flag = 'RED'   THEN 1 ELSE 0 END) AS red,
        -- Name the facilities, resolved from the register rather than the
        -- denormalised name column on the fact table.
        CONCAT_WS(', ', COLLECT_SET(
            CASE WHEN lca.Flag IN ('AMBER', 'RED') THEN f.FacilityName END)) AS constrained_facilities
    FROM external_data.nemweb.silver_gbb_linepack_capacity_adequacy AS lca
    LEFT JOIN external_data.nemweb.silver_gbb_facilities AS f
           ON f.FacilityId = lca.FacilityId
    GROUP BY 1
)
SELECT
    p.gas_day,
    p.REGIONID,
    ROUND(p.max_rrp, 2)   AS max_rrp,
    ROUND(p.avg_rrp, 2)   AS avg_rrp,
    p.intervals_over_300,
    g.facilities_reporting,
    g.amber,
    g.red,
    g.constrained_facilities
FROM daily_price AS p
LEFT JOIN gas_flags AS g
       ON g.gas_day = p.gas_day
ORDER BY p.max_rrp DESC;
