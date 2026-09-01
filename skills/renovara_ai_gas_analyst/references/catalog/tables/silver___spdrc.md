---
type: Renovara Table
title: silver___spdrc
description: SPDREGIONCONSTRAINT contains the LHS factor terms applied to aggregated regional gen/load
  by generic constraints in dispatch. A non-zero FACTOR for a (CONSTRAINTID, EFFECTIVEDATE, VERSIONNO,
  REGIONID, BIDTYPE) tuple means the constraint tar
tags:
- renovara
- nemweb
- canonical:SPDRC
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver___spdrc
canonical_report: SPDRC
column_count: 9
row_count: 5605
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: EFFECTIVEDATE
  from: '2025-01-07 00:00:00'
  to: '2026-07-09 00:00:00'
size_bytes: 31012
primary_key:
- BIDTYPE
- EFFECTIVEDATE
- GENCONID
- REGIONID
- VERSIONNO
aemo_table: SPDREGIONCONSTRAINT
visibility: Public
---

SPDREGIONCONSTRAINT contains the LHS factor terms applied to aggregated regional gen/load by generic constraints in dispatch. A non-zero FACTOR for a (CONSTRAINTID, EFFECTIVEDATE, VERSIONNO, REGIONID, BIDTYPE) tuple means the constraint targets the region's aggregate — every unit in that region participates in the limit, so a DUID is indirectly affected if its region appears here for the constraint version that was binding.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___spdrc` |
| Rows | 5,605 |
| Date range | 2025-01-07 00:00:00 to 2026-07-09 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 30.3 KB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `REGIONID` | `string` | Region identifier (e.g. NSW1, QLD1, VIC1, SA1, TAS1) |
| `EFFECTIVEDATE` | `timestamp` | Effective date of this record |
| `VERSIONNO` | `smallint` | Version number for the effective date |
| `GENCONID` | `string` | Generic constraint identifier (synonymous with CONSTRAINTID in DISPATCH_CONSTRAINT) |
| `FACTOR` | `decimal(16,6)` | Constraint factor on the region aggregate's contribution to the LHS (typically -1 or 1) |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `BIDTYPE` | `string` | Bid type the factor applies to: ENERGY, RAISE6SEC, RAISE60SEC, RAISE5MIN, LOWER6SEC, LOWER60SEC, LOWER5MIN, RAISEREG, LOWERREG |

# Upstream

Derived from AEMO's **SPDREGIONCONSTRAINT** (package `GENERIC_CONSTRAINT`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec29.htm#96
