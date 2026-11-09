---
type: Renovara Table
title: silver___participant_registration_station
description: 'STATION sets out valid station identifiers: one row per station AEMO has registered, with
  its full name and address. Join to DUIDs on STATIONID through PARTICIPANT_REGISTRATION_DUDETAILSUMMARY
  (or GENUNITS). Names are as registered, in mixe'
tags:
- renovara
- nemweb
- canonical:PARTICIPANT_REGISTRATION_STATION
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:17:59Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver___participant_registration_station
canonical_report: PARTICIPANT_REGISTRATION_STATION
column_count: 13
row_count: 5823
measured_at: '2026-11-09T03:17:59Z'
coverage:
  column: LASTCHANGED
  from: '2003-11-25 15:34:57'
  to: '2026-10-07 16:14:43'
size_bytes: 50529
primary_key:
- STATIONID
aemo_table: STATION
visibility: Public
---

STATION sets out valid station identifiers: one row per station AEMO has registered, with its full name and address. Join to DUIDs on STATIONID through PARTICIPANT_REGISTRATION_DUDETAILSUMMARY (or GENUNITS). Names are as registered, in mixed case ('ERARING POWER STATION', 'Bayswater Power Station'), so match them case-insensitively. One full copy per MMSDM archive month loaded (from 2026-01): take the row with the latest LASTCHANGED per STATIONID. For a DUID's station, region, fuel and capacity in one row use the view v_duid_registration.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___participant_registration_station` |
| Rows | 5,823 |
| Date range | 2003-11-25 15:34:57 to 2026-10-07 16:14:43 (by `LASTCHANGED`) |
| Size on disk | 49.3 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `STATIONID` | `string` | Station Identifier |
| `STATIONNAME` | `string` | Full name of station |
| `ADDRESS1` | `string` | Station Address |
| `ADDRESS2` | `string` | Station Address |
| `ADDRESS3` | `string` | Station Address |
| `ADDRESS4` | `string` | Station Address |
| `CITY` | `string` | City |
| `STATE` | `string` | State of Australia |
| `POSTCODE` | `string` | Post Code |
| `LASTCHANGED` | `timestamp` | Last date and time record changed (parsed to timestamp in silver). AEST. |
| `CONNECTIONPOINTID` | `string` | Not used. Do not use as the Connection Point Identifier for station load |

# Upstream

Derived from AEMO's **STATION** (package `PARTICIPANT_REGISTRATION`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec44.htm#218
