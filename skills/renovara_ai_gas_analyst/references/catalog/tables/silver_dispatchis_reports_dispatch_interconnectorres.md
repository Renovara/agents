---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_interconnectorres
description: 'DISPATCHINTERCONNECTORRES sets out MW flow and losses on each interconnector for each dispatch
  period, including fields for the Frequency Controlled Ancillary Services export and import limits and
  extra reporting of the generic constraints '
tags:
- renovara
- nemweb
- canonical:DISPATCH_INTERCONNECTORRES
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_interconnectorres
canonical_report: DISPATCH_INTERCONNECTORRES
column_count: 25
row_count: 5172504
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 00:05:00'
  to: '2026-09-02 02:45:00'
size_bytes: 190767558
primary_key:
- DISPATCHINTERVAL
- INTERCONNECTORID
- INTERVENTION
- RUNNO
- SETTLEMENTDATE
aemo_table: DISPATCHINTERCONNECTORRES
visibility: Public
---

DISPATCHINTERCONNECTORRES sets out MW flow and losses on each interconnector for each dispatch period, including fields for the Frequency Controlled Ancillary Services export and import limits and extra reporting of the generic constraints that set the energy import and export limits.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_interconnectorres` |
| Rows | 5,172,504 |
| Date range | 2019-01-01 00:05:00 to 2026-09-02 02:45:00 (by `SETTLEMENTDATE`) |
| Size on disk | 181.9 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date starting at 04:05 (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run no; always 1 |
| `INTERCONNECTORID` | `string` | Interconnector identifier |
| `DISPATCHINTERVAL` | `bigint` | Dispatch period identifier, from 001 to 288 in format YYYYMMDDPPP. |
| `INTERVENTION` | `tinyint` | Intervention case or not |
| `METEREDMWFLOW` | `decimal(15,5)` | Metered MW Flow from SCADA. |
| `MWFLOW` | `decimal(15,5)` | Target MW Flow for next 5 mins. |
| `MWLOSSES` | `decimal(15,5)` | Calculated MW Losses |
| `MARGINALVALUE` | `decimal(15,5)` | Shadow price resulting from thermal or reserve sharing constraints on Interconnector import/export (0 unless binding). |
| `VIOLATIONDEGREE` | `decimal(15,5)` | Degree of violation on interconnector constraints |
| `LASTCHANGED` | `timestamp` | Last changed. |
| `EXPORTLIMIT` | `decimal(15,5)` | Calculated export limit applying to energy only. |
| `IMPORTLIMIT` | `decimal(15,5)` | Calculated import limit applying to energy only. |
| `MARGINALLOSS` | `decimal(15,5)` | Marginal loss factor. Use this to adjust prices between regions. |
| `EXPORTGENCONID` | `string` | Generic Constraint setting the export limit |
| `IMPORTGENCONID` | `string` | Generic Constraint setting the import limit |
| `FCASEXPORTLIMIT` | `decimal(15,5)` | Calculated export limit applying to energy + FCAS. |
| `FCASIMPORTLIMIT` | `decimal(15,5)` | Calculated import limit applying to energy + FCAS. |
| `LOCAL_PRICE_ADJUSTMENT_EXPORT` | `decimal(10,2)` | Aggregate Constraint contribution cost of this Interconnector for Export. |
| `LOCALLY_CONSTRAINED_EXPORT` | `tinyint` | 2 = at least one Outage Constraint; 1 = at least 1 System Normal Constraint (and no Outage Constraint); 0 = No System Normal or Outage Constraints |
| `LOCAL_PRICE_ADJUSTMENT_IMPORT` | `decimal(10,2)` | Aggregate Constraint contribution cost of this Interconnector for Import. |
| `LOCALLY_CONSTRAINED_IMPORT` | `tinyint` | 2 = at least one Outage Constraint; 1 = at least 1 System Normal Constraint (and no Outage Constraint); 0 = No System Normal or Outage Constraints |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHINTERCONNECTORRES** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#120
