-- What is the average demand in NSW1 by hour for the last year?
SELECT DATE(SETTLEMENTDATE) AS date, HOUR(SETTLEMENTDATE) AS hour_of_day, AVG(TOTALDEMAND) AS avg_demand_mw FROM silver_dispatchis_reports_dispatch_regionsum WHERE REGIONID = 'NSW1' AND SETTLEMENTDATE >= DATEADD(DAY, -365, CURRENT_DATE()) GROUP BY DATE(SETTLEMENTDATE), HOUR(SETTLEMENTDATE) ORDER BY date, hour_of_day
