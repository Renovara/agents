---
type: Renovara Table
title: silver___spdcpc
description: SPDCONNECTIONPOINTCONSTRAINT contains the LHS factor terms applied to connection points by
  generic constraints in dispatch, predispatch, and STPASA. A non-zero FACTOR for a (CONSTRAINTID, EFFECTIVEDATE,
  VERSIONNO, CONNECTIONPOINTID, BIDTYPE
tags:
- renovara
- nemweb
- canonical:SPDCPC
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver___spdcpc
canonical_report: SPDCPC
column_count: 9
row_count: 2160031
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: EFFECTIVEDATE
  from: '2025-01-01 00:00:00'
  to: '2026-07-31 00:00:00'
size_bytes: 3671010
primary_key:
- BIDTYPE
- CONNECTIONPOINTID
- EFFECTIVEDATE
- GENCONID
- VERSIONNO
aemo_table: SPDCONNECTIONPOINTCONSTRAINT
visibility: Public
---

SPDCONNECTIONPOINTCONSTRAINT contains the LHS factor terms applied to connection points by generic constraints in dispatch, predispatch, and STPASA. A non-zero FACTOR for a (CONSTRAINTID, EFFECTIVEDATE, VERSIONNO, CONNECTIONPOINTID, BIDTYPE) tuple means that constraint directly limits the named connection point's energy or FCAS bid. Joining DISPATCH_CONSTRAINT.CONSTRAINTID + GENCONID_EFFECTIVEDATE + GENCONID_VERSIONNO to this table, then to DUDETAILSUMMARY on CONNECTIONPOINTID, gives causal DUID-level attribution of binding constraints (i.e. which constraints actually constrain a specific unit).


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___spdcpc` |
| Rows | 2,160,031 |
| Date range | 2025-01-01 00:00:00 to 2026-07-31 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 3.5 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `CONNECTIONPOINTID` | `string` | Connection Point Identifier (joins to DUDETAILSUMMARY.CONNECTIONPOINTID) |
| `EFFECTIVEDATE` | `timestamp` | Effective date of this record |
| `VERSIONNO` | `smallint` | Version number for the effective date |
| `GENCONID` | `string` | Generic constraint identifier (synonymous with CONSTRAINTID in DISPATCH_CONSTRAINT) |
| `FACTOR` | `decimal(16,6)` | Constraint factor on the connection point's contribution to the LHS |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `BIDTYPE` | `string` | Bid type the factor applies to: ENERGY, RAISE6SEC, RAISE60SEC, RAISE5MIN, LOWER6SEC, LOWER60SEC, LOWER5MIN, RAISEREG, LOWERREG |

# Upstream

Derived from AEMO's **SPDCONNECTIONPOINTCONSTRAINT** (package `GENERIC_CONSTRAINT`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec29.htm#78
