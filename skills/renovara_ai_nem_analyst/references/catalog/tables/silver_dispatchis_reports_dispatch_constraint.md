---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_constraint
description: DISPATCHCONSTRAINT sets out details of all binding and interregion constraints in each dispatch
  run. Invoked constraints can be established from GENCONSETINVOKE. Binding constraints show as marginal
  value > $0. Interconnector constraints ar
tags:
- renovara
- nemweb
- canonical:DISPATCH_CONSTRAINT
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_constraint
canonical_report: DISPATCH_CONSTRAINT
column_count: 16
row_count: 198231704
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2024-09-05 00:05:00'
  to: '2026-09-02 08:50:00'
size_bytes: 1968679371
primary_key:
- CONSTRAINTID
- DISPATCHINTERVAL
- INTERVENTION
- RUNNO
- SETTLEMENTDATE
aemo_table: DISPATCHCONSTRAINT
visibility: Private & Public Next-Day
---

DISPATCHCONSTRAINT sets out details of all binding and interregion constraints in each dispatch run. Invoked constraints can be established from GENCONSETINVOKE. Binding constraints show as marginal value > $0. Interconnector constraints are listed so RHS (SCADA calculated limits) can be reported.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_constraint` |
| Rows | 198,231,704 |
| Date range | 2024-09-05 00:05:00 to 2026-09-02 08:50:00 (by `SETTLEMENTDATE`) |
| Size on disk | 1.8 GB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date starting at 04:05 (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run no; always 1 |
| `CONSTRAINTID` | `string` | Generic Constraint identifier (synonymous with GenConID) |
| `DISPATCHINTERVAL` | `bigint` | Dispatch period identifier, from 001 to 288 in format YYYYMMDDPPP. |
| `INTERVENTION` | `tinyint` | Manual Intervention flag, which, if set (1), causes predispatch to solve twice. |
| `RHS` | `decimal(15,5)` | Right hand Side value as used in dispatch. |
| `MARGINALVALUE` | `decimal(15,5)` | $ Value of binding constraint |
| `VIOLATIONDEGREE` | `decimal(15,5)` | Degree of violation in MW |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `DUID` | `string` | DUID to which the Constraint is confidential. Null denotes non-confidential |
| `GENCONID_EFFECTIVEDATE` | `timestamp` | Effective date of the Generic Constraint (ConstraintID). Used to track the version of this constraint applied in this dispatch interval |
| `GENCONID_VERSIONNO` | `bigint` | Version number of the Generic Constraint (ConstraintID). Used to track the version of this constraint applied in this dispatch interval |
| `LHS` | `decimal(15,5)` | Aggregation of the constraint’s LHS term solution values |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHCONSTRAINT** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#109
