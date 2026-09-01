---
type: Renovara Table
title: silver_predispatchis_reports_predispatch_local_price
description: Sets out local pricing offsets associated with each DUID connection point for each dispatch
  period.
tags:
- renovara
- nemweb
- canonical:PREDISPATCH_LOCAL_PRICE
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_predispatchis_reports_predispatch_local_price
canonical_report: PREDISPATCH_LOCAL_PRICE
column_count: 9
row_count: 34359998
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: LASTCHANGED
  from: '2025-11-18 00:32:25'
  to: '2026-09-02 02:31:55'
size_bytes: 90123135
primary_key:
- DATETIME
- DUID
aemo_table: PREDISPATCH_LOCAL_PRICE
visibility: Private & Public Next-Day
---

Sets out local pricing offsets associated with each DUID connection point for each dispatch period.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_predispatchis_reports_predispatch_local_price` |
| Rows | 34,359,998 |
| Date range | 2025-11-18 00:32:25 to 2026-09-02 02:31:55 (by `LASTCHANGED`) |
| Size on disk | 85.9 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `PREDISPATCHSEQNO` | `string` | Unique identifier of predispatch run in the form YYYYMMDDPP with 01 at 04:30 |
| `DATETIME` | `timestamp` | The unique identifier for the interval within this study (parsed to timestamp in silver) |
| `DUID` | `string` | Dispatchable unit identifier |
| `PERIODID` | `string` | A period count, starting from 1 for each predispatch run. Use DATETIME to determine half hour period |
| `LOCAL_PRICE_ADJUSTMENT` | `decimal(10,2)` | Aggregate Constraint contribution cost of this unit: Sum(MarginalValue x Factor) for all relevant Constraints |
| `LOCALLY_CONSTRAINED` | `tinyint` | Key for LOCAL_PRICE_ADJUSTMENT: 2 = at least one Outage Constraint; 1 = at least 1 System Normal Constraint (and no Outage Constraint); 0 = No System Normal or Outage Constraints |
| `LASTCHANGED` | `timestamp` | Last date and time record changed (parsed to timestamp in silver) |

# Upstream

Derived from AEMO's **PREDISPATCH_LOCAL_PRICE** (package `PRE_DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec46.htm#25
