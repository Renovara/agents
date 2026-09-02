---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_interconnection
description: Inter-regional flow information common to or aggregated for regulated (i.e. not MNSP) Interconnectors
  spanning the From-Region and To-Region. Only the physical run is calculated.
tags:
- renovara
- nemweb
- canonical:DISPATCH_INTERCONNECTION
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_interconnection
canonical_report: DISPATCH_INTERCONNECTION
column_count: 15
row_count: 646735
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2024-09-05 00:05:00'
  to: '2026-09-02 08:50:00'
size_bytes: 23764728
primary_key:
- FROM_REGIONID
- INTERVENTION
- RUNNO
- SETTLEMENTDATE
- TO_REGIONID
aemo_table: DISPATCH_INTERCONNECTION
visibility: Public
---

Inter-regional flow information common to or aggregated for regulated (i.e. not MNSP) Interconnectors spanning the From-Region and To-Region. Only the physical run is calculated.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_interconnection` |
| Rows | 646,735 |
| Date range | 2024-09-05 00:05:00 to 2026-09-02 08:50:00 (by `SETTLEMENTDATE`) |
| Size on disk | 22.7 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date starting at 04:05 (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run no; always 1 |
| `INTERVENTION` | `tinyint` | Intervention case or not |
| `FROM_REGIONID` | `string` | Nominated RegionID from which the energy flows |
| `TO_REGIONID` | `string` | Nominated RegionID to which the energy flows |
| `DISPATCHINTERVAL` | `bigint` | Dispatch period identifier, from 001 to 288 in format YYYYMMDDPPP |
| `IRLF` | `decimal(15,5)` | Inter-Regional Loss Factor. Calculated based on the MWFLOW and the nominal From and To Region losses. |
| `MWFLOW` | `decimal(16,6)` | Summed MW flow of the parallel regulated Interconnectors |
| `METEREDMWFLOW` | `decimal(16,6)` | Summed Metered MW flow of the parallel regulated Interconnectors |
| `FROM_REGION_MW_LOSSES` | `decimal(16,6)` | Losses across the Interconnection attributable to the nominal From Region |
| `TO_REGION_MW_LOSSES` | `decimal(16,6)` | Losses across the Interconnection attributable to the nominal To Region |
| `LASTCHANGED` | `timestamp` | The datetime that the record was last changed |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCH_INTERCONNECTION** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#30
