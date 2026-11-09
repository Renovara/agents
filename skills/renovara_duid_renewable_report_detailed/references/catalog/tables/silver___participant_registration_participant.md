---
type: Renovara Table
title: silver___participant_registration_participant
description: |
  PARTICIPANT sets out Participant ID, name and class for all participants.
tags:
- renovara
- nemweb
- canonical:PARTICIPANT_REGISTRATION_PARTICIPANT
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:19:19Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver___participant_registration_participant
canonical_report: PARTICIPANT_REGISTRATION_PARTICIPANT
column_count: 9
row_count: 24074
measured_at: '2026-11-09T03:17:59Z'
coverage:
  column: LASTCHANGED
  from: '1998-06-30 22:01:22'
  to: '2026-10-07 14:35:40'
size_bytes: 388070
primary_key:
- PARTICIPANTID
aemo_table: PARTICIPANT
visibility: Public
---

PARTICIPANT sets out Participant ID, name and class for all participants.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___participant_registration_participant` |
| Rows | 24,074 |
| Date range | 1998-06-30 22:01:22 to 2026-10-07 14:35:40 (by `LASTCHANGED`) |
| Size on disk | 379.0 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `PARTICIPANTID` | `string` | Unique participant identifier. |
| `PARTICIPANTCLASSID` | `string` | Class of participant. |
| `NAME` | `string` | Full name of participant. |
| `DESCRIPTION` | `string` | Not used. |
| `ACN` | `string` | Australian Company Number; nine digits. |
| `PRIMARYBUSINESS` | `string` | Identifies primary business activity of participant. |
| `LASTCHANGED` | `timestamp` | Last date and time record changed. |

# Upstream

Derived from AEMO's **PARTICIPANT** (package `PARTICIPANT_REGISTRATION`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec44.htm#115
