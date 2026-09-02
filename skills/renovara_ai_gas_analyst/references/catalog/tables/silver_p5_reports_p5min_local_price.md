---
type: Renovara Table
title: silver_p5_reports_p5min_local_price
description: Sets out local pricing offsets associated with each DUID connection point for each dispatch
  period.
tags:
- renovara
- nemweb
- canonical:P5MIN_LOCAL_PRICE
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_p5_reports_p5min_local_price
canonical_report: P5MIN_LOCAL_PRICE
column_count: 8
row_count: 46597738
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: INTERVAL_DATETIME
  from: '2025-11-19 00:35:00'
  to: '2026-09-02 09:55:00'
size_bytes: 108978994
primary_key:
- DUID
- INTERVAL_DATETIME
- RUN_DATETIME
aemo_table: P5MIN_LOCAL_PRICE
visibility: Public
---

Sets out local pricing offsets associated with each DUID connection point for each dispatch period.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_p5_reports_p5min_local_price` |
| Rows | 46,597,738 |
| Date range | 2025-11-19 00:35:00 to 2026-09-02 09:55:00 (by `INTERVAL_DATETIME`) |
| Size on disk | 103.9 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `RUN_DATETIME` | `timestamp` | Unique timestamp identifier for this study (parsed to timestamp in silver) |
| `DUID` | `string` | Dispatchable unit identifier |
| `INTERVAL_DATETIME` | `timestamp` | Unique identifier for the interval within this study (parsed to timestamp in silver) |
| `LOCAL_PRICE_ADJUSTMENT` | `decimal(10,2)` | Aggregate Constraint contribution cost of this unit: Sum(MarginalValue x Factor) for all relevant Constraints |
| `LOCALLY_CONSTRAINED` | `tinyint` | Key for Local_Price_Adjustment: 2 = at least one Outage Constraint; 1 = at least 1 System Normal Constraint (and no Outage Constraint); 0 = No System Normal or Outage Constraints |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |

# Upstream

Derived from AEMO's **P5MIN_LOCAL_PRICE** (package `P5MIN`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec41.htm#58
