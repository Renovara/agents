---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_case_solution
description: DISPATCHCASESOLUTION shows information relating to the complete dispatch run. The fields
  in DISPATCHCASESOLUTION provide an overview of the dispatch run results, allowing immediate identification
  of conditions such as energy or FCAS deficie
tags:
- renovara
- nemweb
- canonical:DISPATCH_CASE_SOLUTION
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_case_solution
canonical_report: DISPATCH_CASE_SOLUTION
column_count: 27
row_count: 209410
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: SETTLEMENTDATE
  from: '2024-09-05 00:05:00'
  to: '2026-09-02 02:45:00'
size_bytes: 5950279
primary_key:
- RUNNO
- SETTLEMENTDATE
aemo_table: DISPATCHCASESOLUTION
visibility: Public
---

DISPATCHCASESOLUTION shows information relating to the complete dispatch run. The fields in DISPATCHCASESOLUTION provide an overview of the dispatch run results, allowing immediate identification of conditions such as energy or FCAS deficiencies.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_case_solution` |
| Rows | 209,410 |
| Date range | 2024-09-05 00:05:00 to 2026-09-02 02:45:00 (by `SETTLEMENTDATE`) |
| Size on disk | 5.7 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Dispatch interval end (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run no; always 1 |
| `INTERVENTION` | `tinyint` | Intervention flag - refer to package documentation for definition and practical query examples |
| `CASESUBTYPE` | `string` | Overconstrained dispatch indicator: OCD = detecting over-constrained dispatch; null = no special condition |
| `SOLUTIONSTATUS` | `tinyint` | If non-zero indicated one of the following conditions: 1 = Supply Scarcity, Excess generation or constraint violations; X = Model failure |
| `SPDVERSION` | `string` | Current version of SPD |
| `NONPHYSICALLOSSES` | `tinyint` | Non-Physical Losses algorithm invoked occurred during this run |
| `TOTALOBJECTIVE` | `decimal(27,10)` | The Objective function from the LP |
| `TOTALAREAGENVIOLATION` | `decimal(15,5)` | Total Region Demand violations |
| `TOTALINTERCONNECTORVIOLATION` | `decimal(15,5)` | Total interconnector violations |
| `TOTALGENERICVIOLATION` | `decimal(15,5)` | Total generic constraint violations |
| `TOTALRAMPRATEVIOLATION` | `decimal(15,5)` | Total ramp rate violations |
| `TOTALUNITMWCAPACITYVIOLATION` | `decimal(15,5)` | Total unit capacity violations |
| `TOTAL5MINVIOLATION` | `decimal(15,5)` | Total of 5 minute ancillary service region violations |
| `TOTALREGVIOLATION` | `decimal(15,5)` | Total of Regulation ancillary service region violations |
| `TOTAL6SECVIOLATION` | `decimal(15,5)` | Total of 6 second ancillary service region violations |
| `TOTAL60SECVIOLATION` | `decimal(15,5)` | Total of 60 second ancillary service region violations |
| `TOTALASPROFILEVIOLATION` | `decimal(15,5)` | Total of ancillary service trader profile violations |
| `TOTALFASTSTARTVIOLATION` | `decimal(15,5)` | Total of fast start trader profile violations |
| `TOTALENERGYOFFERVIOLATION` | `decimal(15,5)` | Total of unit summated offer band violations |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `SWITCHRUNINITIALSTATUS` | `tinyint` | Flag indicating the SCADA status for FCAS Interconnector dead-band. "0" if SCADA Status or requesting Constraint not invoked. "1" if SCADA Status AND requesting Constraint is invoked |
| `SWITCHRUNBESTSTATUS` | `tinyint` | Flag indicating which Switch run was used for the Solution – from PeriodSolution |
| `SWITCHRUNBESTSTATUS_INT` | `tinyint` | Flag indicating which Switch run was used for the Intervention Physical Solution - from PeriodSolution |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHCASESOLUTION** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#100
