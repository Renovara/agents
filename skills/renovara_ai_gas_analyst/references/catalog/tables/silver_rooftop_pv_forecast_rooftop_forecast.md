---
type: Renovara Table
title: silver_rooftop_pv_forecast_rooftop_forecast
description: AEMO's regional forecast of rooftop solar (distributed PV) generation, half-hourly over the
  next 8 days, in MW at the interval end. Republished every 30 minutes, so the same target INTERVAL_DATETIME
  is forecast up to 379 times by successive
tags:
- renovara
- nemweb
- canonical:ROOFTOP_FORECAST
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_rooftop_pv_forecast_rooftop_forecast
canonical_report: ROOFTOP_FORECAST
column_count: 10
row_count: 244538105
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: INTERVAL_DATETIME
  from: '2019-01-01 01:00:00'
  to: '2026-09-10 02:30:00'
size_bytes: 1546570520
primary_key:
- VERSION_DATETIME
- REGIONID
- INTERVAL_DATETIME
aemo_table: ROOFTOP_PV_FORECAST
visibility: Public
---

AEMO's regional forecast of rooftop solar (distributed PV) generation, half-hourly over the next 8 days, in MW at the interval end. Republished every 30 minutes, so the same target INTERVAL_DATETIME is forecast up to 379 times by successive runs. VERSION_DATETIME identifies the forecast run and is part of the primary key — a query that does not pin it averages across superseded vintages. For the current view of a future interval use QUALIFY ROW_NUMBER() OVER (PARTITION BY REGIONID, INTERVAL_DATETIME ORDER BY VERSION_DATETIME DESC) = 1; to measure forecast error, join a chosen VERSION_DATETIME against ROOFTOP_ACTUAL on (REGIONID, INTERVAL_DATETIME) with TYPE = 'MEASUREMENT'. POWERPOELOW and POWERPOEHIGH bracket the forecast — note the naming is by probability of exceedance, so POWERPOELOW (90% POE) is the LOWER MW value. Source AEMO table ROOFTOP_PV_FORECAST.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_rooftop_pv_forecast_rooftop_forecast` |
| Rows | 244,538,105 |
| Date range | 2019-01-01 01:00:00 to 2026-09-10 02:30:00 (by `INTERVAL_DATETIME`) |
| Size on disk | 1.4 GB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `VERSION_DATETIME` | `timestamp` | Date and time this forecast run was produced, identifying the vintage (parsed to timestamp in silver). Part of the primary key — pin it or the same target interval is counted once per run. Timestamp is in AEST or Australia/Brisbane. |
| `REGIONID` | `string` | Region identifier. One of NSW1, QLD1, SA1, TAS1, VIC1. |
| `INTERVAL_DATETIME` | `timestamp` | The half-hour interval the forecast applies to, interval ending, up to 8 days after VERSION_DATETIME (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `POWERMEAN` | `decimal(12,3)` | Average forecast rooftop PV generation in MW at the interval end. |
| `POWERPOE50` | `decimal(12,3)` | 50% probability-of-exceedance (median) forecast value in MW at the interval end. |
| `POWERPOELOW` | `decimal(12,3)` | 90% probability-of-exceedance forecast value in MW at the interval end. Named LOW because 90% POE is the LOWER MW bound — the value expected to be exceeded 9 times in 10. |
| `POWERPOEHIGH` | `decimal(12,3)` | 10% probability-of-exceedance forecast value in MW at the interval end. Named HIGH because 10% POE is the UPPER MW bound — the value expected to be exceeded only 1 time in 10. |
| `LASTCHANGED` | `timestamp` | Last date and time the record changed (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |

# Upstream

Derived from AEMO's **ROOFTOP_PV_FORECAST** (package `DEMAND_FORECASTS`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec18.htm#183
