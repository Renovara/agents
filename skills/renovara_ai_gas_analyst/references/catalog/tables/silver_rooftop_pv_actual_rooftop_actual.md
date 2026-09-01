---
type: Renovara Table
title: silver_rooftop_pv_actual_rooftop_actual
description: AEMO's estimate of regional rooftop solar (distributed PV) actual generation for each half-hour
  interval, in MW at the interval end. Rooftop PV is not metered by AEMO, so these are estimates, published
  twice per interval under two TYPEs — M
tags:
- renovara
- nemweb
- canonical:ROOFTOP_ACTUAL
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_rooftop_pv_actual_rooftop_actual
canonical_report: ROOFTOP_ACTUAL
column_count: 8
row_count: 2606000
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: INTERVAL_DATETIME
  from: '2019-01-01 00:30:00'
  to: '2026-09-02 02:00:00'
size_bytes: 8498689
primary_key:
- INTERVAL_DATETIME
- TYPE
- REGIONID
aemo_table: ROOFTOP_PV_ACTUAL
visibility: Public
---

AEMO's estimate of regional rooftop solar (distributed PV) actual generation for each half-hour interval, in MW at the interval end. Rooftop PV is not metered by AEMO, so these are estimates, published twice per interval under two TYPEs — MEASUREMENT (derived from a sample of metered sites; AEMO's best-quality same-day estimate) and SATELLITE (derived from satellite irradiance imagery). Both are delayed about one half-hour. TYPE is part of the primary key, so filter it or the same interval is counted twice. Rooftop PV is netted out of operational demand, so this table is what explains the difference between underlying and operational demand and drives the midday demand trough. Source AEMO table ROOFTOP_PV_ACTUAL. Half-hourly; join to 5-minute dispatch tables by truncating SETTLEMENTDATE to the half hour. WARNING - before 2025-12 REGIONID holds more than regions. The MMSDM archive also publishes sub-regional areas (QLDC, QLDN, QLDS, TASN, TASS) in that column, and they sum to QLD1 and TAS1. Filter REGIONID IN ('NSW1','QLD1','SA1','TAS1','VIC1') for any regional or national total.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_rooftop_pv_actual_rooftop_actual` |
| Rows | 2,606,000 |
| Date range | 2019-01-01 00:30:00 to 2026-09-02 02:00:00 (by `INTERVAL_DATETIME`) |
| Size on disk | 8.1 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `INTERVAL_DATETIME` | `timestamp` | The half-hour interval this estimate applies to, interval ending (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `REGIONID` | `string` | Region identifier. WARNING - not only regions. For intervals before 2025-12 the MMSDM archive also publishes sub-regional AREAS in this column (QLDC, QLDN, QLDS, TASN, TASS) alongside the five regions NSW1, QLD1, SA1, TAS1, VIC1. QLDC+QLDN+QLDS sum to QLD1 and TASN+TASS sum to TAS1, so any aggregate MUST filter REGIONID IN ('NSW1','QLD1','SA1','TAS1','VIC1') or it double-counts Queensland and Tasmania. From 2025-12 onward only the five regions are published. |
| `POWER` | `decimal(12,3)` | Estimated rooftop PV generation in MW at the interval end. |
| `QI` | `decimal(2,1)` | Quality indicator between 0 and 1 representing the confidence in the estimate; 1 is the highest. SATELLITE estimates typically score lower than MEASUREMENT. |
| `TYPE` | `string` | Estimate method, part of the primary key. MEASUREMENT is AEMO's best-quality same-day estimate from a metered sample; SATELLITE is derived from satellite imagery. A third value DAILY (best quality, published day-after) exists ONLY in history - AEMO published it from the start of the archive until 2019-10-21 and then stopped, so intervals before that date carry THREE estimates and everything after carries two. Always filter TYPE for any aggregate. |
| `LASTCHANGED` | `timestamp` | Last date and time the record changed (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |

# Upstream

Derived from AEMO's **ROOFTOP_PV_ACTUAL** (package `DEMAND_FORECASTS`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec18.htm#139
