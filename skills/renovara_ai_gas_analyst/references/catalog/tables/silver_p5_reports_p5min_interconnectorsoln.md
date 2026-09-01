---
type: Renovara Table
title: silver_p5_reports_p5min_interconnectorsoln
description: 'The five-minute predispatch (P5Min) system provides projected dispatch for 12 dispatch cycles
  (one hour). The P5Min cycle runs every 5 minutes to produce a dispatch and pricing schedule to a 5-minute
  resolution covering the next hour. This '
tags:
- renovara
- nemweb
- canonical:P5MIN_INTERCONNECTORSOLN
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_p5_reports_p5min_interconnectorsoln
canonical_report: P5MIN_INTERCONNECTORSOLN
column_count: 24
row_count: 5953608
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: INTERVAL_DATETIME
  from: '2025-11-19 00:05:00'
  to: '2026-09-02 03:40:00'
size_bytes: 166525338
primary_key:
- INTERCONNECTORID
- INTERVAL_DATETIME
- RUN_DATETIME
aemo_table: P5MIN_INTERCONNECTORSOLN
visibility: Public
---

The five-minute predispatch (P5Min) system provides projected dispatch for 12 dispatch cycles (one hour). The P5Min cycle runs every 5 minutes to produce a dispatch and pricing schedule to a 5-minute resolution covering the next hour. This table sets out the results of the capacity evaluation for interconnectors, including calculated limits for each interval.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_p5_reports_p5min_interconnectorsoln` |
| Rows | 5,953,608 |
| Date range | 2025-11-19 00:05:00 to 2026-09-02 03:40:00 (by `INTERVAL_DATETIME`) |
| Size on disk | 158.8 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `RUN_DATETIME` | `timestamp` | Unique timestamp identifier for this study |
| `INTERVENTION` | `tinyint` | 0 = pricing run, 1 = physical run. If there is no intervention in the market, both pricing and physical runs correspond to INTERVENTION = 0. |
| `INTERCONNECTORID` | `string` | Interconnector identifier |
| `INTERVAL_DATETIME` | `timestamp` | Unique identifier for the interval within this study |
| `METEREDMWFLOW` | `decimal(15,5)` | SCADA MW flow measured at run start. For periods after the first in a P5MIN run, this is the cleared target for the previous period of that run. |
| `MWFLOW` | `decimal(15,5)` | Cleared interconnector loading level (MW) |
| `MWLOSSES` | `decimal(15,5)` | Interconnector losses at cleared flow |
| `MARGINALVALUE` | `decimal(15,5)` | Marginal cost of interconnector standing data limits (if binding) |
| `VIOLATIONDEGREE` | `decimal(15,5)` | Violation of interconnector standing data limits (MW) |
| `MNSP` | `tinyint` | Flag indicating MNSP registration |
| `EXPORTLIMIT` | `decimal(15,5)` | Calculated interconnector export limit based on invoked constraints and static interconnector export limit |
| `IMPORTLIMIT` | `decimal(15,5)` | Calculated interconnector import limit based on invoked constraints and static interconnector import limit (directional quantity with respect to interconnector flow) |
| `MARGINALLOSS` | `decimal(15,5)` | Marginal loss factor at the cleared flow |
| `EXPORTGENCONID` | `string` | Generic constraint setting the export limit |
| `IMPORTGENCONID` | `string` | Generic constraint setting the import limit |
| `FCASEXPORTLIMIT` | `decimal(15,5)` | Calculated export limit applying to energy plus FCAS |
| `FCASIMPORTLIMIT` | `decimal(15,5)` | Calculated import limit applying to energy plus FCAS |
| `LASTCHANGED` | `timestamp` | Last changed date of this record |
| `LOCAL_PRICE_ADJUSTMENT_EXPORT` | `decimal(10,2)` | Aggregate constraint contribution cost for this interconnector: Sum(MarginalValue × Factor) over all relevant constraints, for Export (Factor ≥ 0) |
| `LOCALLY_CONSTRAINED_EXPORT` | `tinyint` | Key for Local_Price_Adjustment_Export: 2 = at least one Outage Constraint; 1 = at least one System Normal Constraint (and no Outage Constraint); 0 = no System Normal or Outage Constraints |
| `LOCAL_PRICE_ADJUSTMENT_IMPORT` | `decimal(10,2)` | Aggregate constraint contribution cost for this interconnector: Sum(MarginalValue × Factor) over all relevant constraints, for Import (Factor ≥ 0) |
| `LOCALLY_CONSTRAINED_IMPORT` | `tinyint` | Key for Local_Price_Adjustment_Import: 2 = at least one Outage Constraint; 1 = at least one System Normal Constraint (and no Outage Constraint); 0 = no System Normal or Outage Constraints |

# Upstream

Derived from AEMO's **P5MIN_INTERCONNECTORSOLN** (package `P5MIN`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec41.htm#37
