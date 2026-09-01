---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_local_price
description: Sets out local pricing offsets associated with each DUID connection point for each dispatch
  period. Note that from 2014 mid-year release, only records with non-zero Local_Price_Adjustment values
  are issued.
tags:
- renovara
- nemweb
- canonical:DISPATCH_LOCAL_PRICE
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_local_price
canonical_report: DISPATCH_LOCAL_PRICE
column_count: 7
row_count: 10319399
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: SETTLEMENTDATE
  from: '2024-08-01 00:05:00'
  to: '2026-09-02 02:45:00'
size_bytes: 42426042
primary_key:
- DUID
- SETTLEMENTDATE
aemo_table: DISPATCH_LOCAL_PRICE
visibility: Private & Public Next-Day
---

Sets out local pricing offsets associated with each DUID connection point for each dispatch period. Note that from 2014 mid-year release, only records with non-zero Local_Price_Adjustment values are issued.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_local_price` |
| Rows | 10,319,399 |
| Date range | 2024-08-01 00:05:00 to 2026-09-02 02:45:00 (by `SETTLEMENTDATE`) |
| Size on disk | 40.5 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date time (parsed to timestamp in silver) |
| `DUID` | `string` | Dispatchable unit identifier |
| `LOCAL_PRICE_ADJUSTMENT` | `decimal(10,2)` | Aggregate Constraint contribution cost of this unit: Sum(MarginalValue x Factor) for all relevant Constraints |
| `LOCALLY_CONSTRAINED` | `tinyint` | Key for Local_Price_Adjustment: 2 = at least one Outage Constraint; 1 = at least 1 System Normal Constraint (and no Outage Constraint); 0 = No System Normal or Outage Constraints |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCH_LOCAL_PRICE** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#36
