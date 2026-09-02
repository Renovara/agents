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
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver___participant_registration_participant
canonical_report: PARTICIPANT_REGISTRATION_PARTICIPANT
column_count: 9
row_count: 21679
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: LASTCHANGED
  from: '1998-06-30 22:01:22'
  to: '2026-07-24 15:16:29'
size_bytes: 301252
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
| Rows | 21,679 |
| Date range | 1998-06-30 22:01:22 to 2026-07-24 15:16:29 (by `LASTCHANGED`) |
| Size on disk | 294.2 KB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

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
