---
type: Renovara Table
title: silver___gencondata
description: GENCONDATA contains the catalogue of generic constraints used in PASA, predispatch, and dispatch
  processes. Each row is a versioned constraint definition keyed by GENCONID + EFFECTIVEDATE + VERSIONNO,
  with descriptive fields (DESCRIPTION, R
tags:
- renovara
- nemweb
- canonical:GENCONDATA
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver___gencondata
canonical_report: GENCONDATA
column_count: 31
row_count: 87911
measured_at: '2026-09-01T17:10:37Z'
coverage:
  column: EFFECTIVEDATE
  from: '2025-01-01 00:00:00'
  to: '2026-07-31 00:00:00'
size_bytes: 1740895
primary_key:
- EFFECTIVEDATE
- GENCONID
- VERSIONNO
aemo_table: GENCONDATA
visibility: Public
---

GENCONDATA contains the catalogue of generic constraints used in PASA, predispatch, and dispatch processes. Each row is a versioned constraint definition keyed by GENCONID + EFFECTIVEDATE + VERSIONNO, with descriptive fields (DESCRIPTION, REASON, LIMITTYPE, IMPACT, SOURCE) explaining what the constraint represents and applicability flags for each market process.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___gencondata` |
| Rows | 87,911 |
| Date range | 2025-01-01 00:00:00 to 2026-07-31 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 1.7 MB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `EFFECTIVEDATE` | `timestamp` | Effective date of constraint |
| `VERSIONNO` | `smallint` | Version number relative to effective date |
| `GENCONID` | `string` | Unique generic constraint identifier (synonymous with CONSTRAINTID in DISPATCH_CONSTRAINT) |
| `CONSTRAINTTYPE` | `string` | Logical operator applied to the constraint (=, >=, <=) |
| `CONSTRAINTVALUE` | `decimal(16,6)` | Static RHS value when no dynamic RHS definition exists |
| `DESCRIPTION` | `string` | Detail of affected plant or service status |
| `STATUS` | `string` | Unused field |
| `GENERICCONSTRAINTWEIGHT` | `decimal(16,6)` | Violation penalty factor |
| `AUTHORISEDDATE` | `string` | Authorisation date for this constraint version |
| `AUTHORISEDBY` | `string` | Authorising user |
| `DYNAMICRHS` | `decimal(15,5)` | Unused field |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `DISPATCH` | `string` | Dispatch applicability flag (1 = applies to dispatch, 0 = does not) |
| `PREDISPATCH` | `string` | Pre-dispatch applicability flag (1/0) |
| `STPASA` | `string` | Short-term PASA applicability flag (1/0) |
| `MTPASA` | `string` | Medium-term PASA applicability flag (1/0) |
| `ADDITIONALNOTES` | `string` | Supplementary constraint notes |
| `P5MIN_SCOPE_OVERRIDE` | `string` | RHS definition scope indicator for the 5-minute pre-dispatch run |
| `LRC` | `string` | LRC PASA run applicability flag (1/0) |
| `LOR` | `string` | LOR PASA run applicability flag (1/0) |
| `IMPACT` | `string` | Affected devices or systems |
| `SOURCE` | `string` | Formulation source of the constraint |
| `LIMITTYPE` | `string` | Constraint category (e.g. Stability, Voltage, Thermal) |
| `REASON` | `string` | Contingency or justification for the constraint |
| `MODIFICATIONS` | `string` | Version change details |
| `FORCE_SCADA` | `tinyint` | Intervention pricing value selection flag |
| `SYSTEMSECURITY` | `string` |  |
| `SSM_REGIONID` | `string` |  |
| `SSM_GROUPID` | `string` |  |

# Upstream

Derived from AEMO's **GENCONDATA** (package `GENERIC_CONSTRAINT`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec29.htm#9
