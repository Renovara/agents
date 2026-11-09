---
type: Renovara Table
title: silver___participant_registration_dualloc
description: 'DUALLOC cross references dispatch unit identifier (DUID) to genset ID (GENSETID), effective-dated
  and versioned: for a DUID, the rows with the latest EFFECTIVEDATE on or before a date, at that date''s
  highest VERSIONNO, are the gensets in fo'
tags:
- renovara
- nemweb
- canonical:PARTICIPANT_REGISTRATION_DUALLOC
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:18:39Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver___participant_registration_dualloc
canonical_report: PARTICIPANT_REGISTRATION_DUALLOC
column_count: 7
row_count: 27526
measured_at: '2026-11-09T03:17:59Z'
coverage:
  column: EFFECTIVEDATE
  from: '1998-10-25 00:00:00'
  to: '2026-10-06 00:00:00'
size_bytes: 81781
primary_key:
- EFFECTIVEDATE
- VERSIONNO
- DUID
- GENSETID
aemo_table: DUALLOC
visibility: Public
---

DUALLOC cross references dispatch unit identifier (DUID) to genset ID (GENSETID), effective-dated and versioned: for a DUID, the rows with the latest EFFECTIVEDATE on or before a date, at that date's highest VERSIONNO, are the gensets in force. One DUID can map to several gensets (HVGTS -> GH01, GH02). Full history back to 1998, retired units included. One full copy per MMSDM archive month loaded (from 2026-01), so the same key repeats once per month: SELECT DISTINCT before counting.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___participant_registration_dualloc` |
| Rows | 27,526 |
| Date range | 1998-10-25 00:00:00 to 2026-10-06 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 79.9 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `EFFECTIVEDATE` | `timestamp` | Effective calendar date of record (parsed to timestamp in silver). AEST. |
| `VERSIONNO` | `smallint` | Version number of record for the effective date; the highest applies |
| `DUID` | `string` | Dispatchable unit identifier |
| `GENSETID` | `string` | Physical unit identifier (joins to PARTICIPANT_REGISTRATION_GENUNITS.GENSETID) |
| `LASTCHANGED` | `timestamp` | Last date and time record changed (parsed to timestamp in silver). AEST. |

# Upstream

Derived from AEMO's **DUALLOC** (package `PARTICIPANT_REGISTRATION`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec44.htm#40
