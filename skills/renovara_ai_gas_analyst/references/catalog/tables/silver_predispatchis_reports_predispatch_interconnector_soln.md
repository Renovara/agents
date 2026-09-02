---
type: Renovara Table
title: silver_predispatchis_reports_predispatch_interconnector_soln
description: PREDISPATCHINTERCONNECTORRES records interconnector flows and losses for the periods calculated
  in each predispatch run. Only binding and interconnector constraints are reported, including FCAS export/import
  limits and the generic constrain
tags:
- renovara
- nemweb
- canonical:PREDISPATCH_INTERCONNECTOR_SOLN
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_predispatchis_reports_predispatch_interconnector_soln
canonical_report: PREDISPATCH_INTERCONNECTOR_SOLN
column_count: 25
row_count: 4607364
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: LASTCHANGED
  from: '2025-11-18 00:32:25'
  to: '2026-09-02 08:31:44'
size_bytes: 161698433
primary_key:
- DATETIME
- INTERCONNECTORID
aemo_table: PREDISPATCHINTERCONNECTORRES
visibility: Public
---

PREDISPATCHINTERCONNECTORRES records interconnector flows and losses for the periods calculated in each predispatch run. Only binding and interconnector constraints are reported, including FCAS export/import limits and the generic constraints setting the energy import and export limits. MW losses may be negative depending on flow. Positive flow is defined from FROMREGION in INTERCONNECTOR.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_predispatchis_reports_predispatch_interconnector_soln` |
| Rows | 4,607,364 |
| Date range | 2025-11-18 00:32:25 to 2026-09-02 08:31:44 (by `LASTCHANGED`) |
| Size on disk | 154.2 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `PREDISPATCHSEQNO` | `string` | Unique identifier of predispatch run in the form YYYYMMDDPP with 01 at 04:30 |
| `RUNNO` | `smallint` | SPD Pre-Dispatch run number, typically 1; increments if the case is re-run |
| `INTERCONNECTORID` | `string` | Interconnector identifier |
| `PERIODID` | `string` | Period count starting from 1 for each Pre-Dispatch run. Use DATETIME to determine half hour period. |
| `INTERVENTION` | `tinyint` | Flag indicating if result set was sourced from pricing or physical run. 0 = pricing run; 1 = physical run. If no intervention, both runs correspond to 0. |
| `METEREDMWFLOW` | `decimal(15,5)` | Metered MW flow from EMS. For periods after the first in a run, this is the cleared target for the previous period of that Pre-Dispatch run. |
| `MWFLOW` | `decimal(15,5)` | Calculated MW flow |
| `MWLOSSES` | `decimal(15,5)` | Calculated MW losses (may be negative depending on flow) |
| `MARGINALVALUE` | `decimal(15,5)` | Dollar marginal value of interconnector constraint from SPD |
| `VIOLATIONDEGREE` | `decimal(15,5)` | Degree of violation of interconnector constraint in MW |
| `LASTCHANGED` | `timestamp` | Last changed date and time (parsed to timestamp in silver) |
| `DATETIME` | `timestamp` | Period date and time (parsed to timestamp in silver) |
| `EXPORTLIMIT` | `decimal(15,5)` | Calculated export limit |
| `IMPORTLIMIT` | `decimal(15,5)` | Calculated import limit |
| `MARGINALLOSS` | `decimal(15,5)` | Marginal loss factor, used to adjust bids between reports |
| `EXPORTGENCONID` | `string` | Generic constraint setting the export limit |
| `IMPORTGENCONID` | `string` | Generic constraint setting the import limit |
| `FCASEXPORTLIMIT` | `decimal(15,5)` | Calculated export limit applying to energy + FCAS |
| `FCASIMPORTLIMIT` | `decimal(15,5)` | Calculated import limit applying to energy + FCAS |
| `LOCAL_PRICE_ADJUSTMENT_EXPORT` | `decimal(10,2)` | Aggregate constraint contribution cost of this interconnector for export: Sum(MarginalValue × Factor) for all relevant constraints where Factor ≥ 0. |
| `LOCALLY_CONSTRAINED_EXPORT` | `tinyint` | Key for LOCAL_PRICE_ADJUSTMENT_EXPORT: 2 = at least one Outage Constraint; 1 = at least one System Normal Constraint (and no Outage Constraint); 0 = no System Normal or Outage Constraints. |
| `LOCAL_PRICE_ADJUSTMENT_IMPORT` | `decimal(10,2)` | Aggregate constraint contribution cost of this interconnector for import: Sum(MarginalValue × Factor) for all relevant constraints where Factor ≥ 0. |
| `LOCALLY_CONSTRAINED_IMPORT` | `tinyint` | Key for LOCAL_PRICE_ADJUSTMENT_IMPORT: 2 = at least one Outage Constraint; 1 = at least one System Normal Constraint (and no Outage Constraint); 0 = no System Normal or Outage Constraints. |

# Upstream

Derived from AEMO's **PREDISPATCHINTERCONNECTORRES** (package `PRE_DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec46.htm#68
