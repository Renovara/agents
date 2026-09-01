---
type: Renovara Table
title: silver___genconset
description: GENCONSET maps generic constraint sets (GENCONSETID) to the individual constraints (GENCONID)
  they contain. Constraint sets are invoked or revoked together (see GENCONSETINVOKE), and a single set
  may contain many constraints. Joining DISPAT
tags:
- renovara
- nemweb
- canonical:GENCONSET
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver___genconset
canonical_report: GENCONSET
column_count: 9
row_count: 131731
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: EFFECTIVEDATE
  from: '2025-01-01 00:00:00'
  to: '2026-07-31 00:00:00'
size_bytes: 688191
primary_key:
- EFFECTIVEDATE
- GENCONID
- GENCONSETID
- VERSIONNO
aemo_table: GENCONSET
visibility: Public
---

GENCONSET maps generic constraint sets (GENCONSETID) to the individual constraints (GENCONID) they contain. Constraint sets are invoked or revoked together (see GENCONSETINVOKE), and a single set may contain many constraints. Joining DISPATCH_CONSTRAINT.CONSTRAINTID = GENCONSET.GENCONID and then to GENCONDATA gives the descriptive context of any binding constraint in dispatch.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___genconset` |
| Rows | 131,731 |
| Date range | 2025-01-01 00:00:00 to 2026-07-31 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 672.1 KB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `GENCONSETID` | `string` | Unique identifier for the constraint set |
| `EFFECTIVEDATE` | `timestamp` | Date this record becomes effective |
| `VERSIONNO` | `smallint` | Version number of the record for the given effective date |
| `GENCONID` | `string` | Generic constraint ID belonging to this set (joins to GENCONDATA.GENCONID) |
| `GENCONEFFDATE` | `string` | Unused since market start in 1998; data should be ignored |
| `GENCONVERSIONNO` | `smallint` | Unused since market start in 1998; data should be ignored |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |

# Upstream

Derived from AEMO's **GENCONSET** (package `GENERIC_CONSTRAINT`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec29.htm#18
