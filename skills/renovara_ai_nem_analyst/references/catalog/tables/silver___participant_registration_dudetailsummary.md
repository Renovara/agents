---
type: Renovara Table
title: silver___participant_registration_dudetailsummary
description: |
  DUDETAILSUMMARY sets out a single summary unit table so reducing the need for participants to use the various dispatchable unit detail and owner tables to establish generating unit specific details.
tags:
- renovara
- nemweb
- canonical:PARTICIPANT_REGISTRATION_DUDETAILSUMMARY
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver___participant_registration_dudetailsummary
canonical_report: PARTICIPANT_REGISTRATION_DUDETAILSUMMARY
column_count: 31
row_count: 387214
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: LASTCHANGED
  from: '2007-06-13 12:29:29'
  to: '2026-08-07 15:49:45'
size_bytes: 3975095
primary_key:
- DUID
- START_DATE
aemo_table: DUDETAILSUMMARY
visibility: Public
---

DUDETAILSUMMARY sets out a single summary unit table so reducing the need for participants to use the various dispatchable unit detail and owner tables to establish generating unit specific details.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___participant_registration_dudetailsummary` |
| Rows | 387,214 |
| Date range | 2007-06-13 12:29:29 to 2026-08-07 15:49:45 (by `LASTCHANGED`) |
| Size on disk | 3.8 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `DUID` | `string` | Dispatchable Unit Identifier |
| `START_DATE` | `timestamp` | Start date for effective record |
| `END_DATE` | `timestamp` | End date for effective record |
| `DISPATCHTYPE` | `string` | Either Generator or Load |
| `CONNECTIONPOINTID` | `string` | Country wide - Unique id of a connection point |
| `REGIONID` | `string` | Region identifier that unit is in |
| `STATIONID` | `string` | Station that unit is in |
| `PARTICIPANTID` | `string` | Participant that owns unit during effective record period |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `TRANSMISSIONLOSSFACTOR` | `decimal(15,5)` | The transmission level loss factor for currently assigned connection point |
| `STARTTYPE` | `string` | Unit start type; typically Fast, Slow or Non Dispatched |
| `DISTRIBUTIONLOSSFACTOR` | `decimal(15,5)` | The distribution loss factor to the currently assigned connection point |
| `MINIMUM_ENERGY_PRICE` | `decimal(9,2)` | Floored Offer/Bid Energy Price adjusted for TLF, DLF and MPF |
| `MAXIMUM_ENERGY_PRICE` | `decimal(9,2)` | Capped Offer/Bid Energy Price adjusted for TLF, DLF and VoLL |
| `SCHEDULE_TYPE` | `string` | Scheduled status of the unit: 'SCHEDULED', 'NON-SCHEDULED', 'SEMI-SCHEDULED' |
| `MIN_RAMP_RATE_UP` | `decimal(6,0)` | MW/Min. Calculated Minimum Ramp Rate Up value accepted for Energy Offers or Bids with explanation |
| `MIN_RAMP_RATE_DOWN` | `decimal(6,0)` | MW/Min. Calculated Minimum Ramp Rate Down value accepted for Energy Offers or Bids with explanation |
| `MAX_RAMP_RATE_UP` | `decimal(6,0)` | Maximum ramp up rate for Unit (MW/min) - from DUDetail table |
| `MAX_RAMP_RATE_DOWN` | `decimal(6,0)` | Maximum ramp down rate for Unit (MW/min) - from DUDetail table |
| `IS_AGGREGATED` | `tinyint` | Whether the DUID is classified as an "Aggregated Unit" under the rules. This impacts the Minimum Ramp Rate calculation |
| `DISPATCHSUBTYPE` | `string` | Additional information for DISPATCHTYPE; for DISPATCHTYPE = LOAD, subtype value is WDR for Wholesale Demand Response units |
| `ADG_ID` | `string` | Aggregate Dispatch Group; group into which the DUID is aggregated for Conformance, null if not aggregated |
| `LOAD_MINIMUM_ENERGY_PRICE` | `decimal(9,2)` | BDU only; floored Offer/Bid Energy Price adjusted for TLF, DLF and MPF for energy imports |
| `LOAD_MAXIMUM_ENERGY_PRICE` | `decimal(9,2)` | BDU only; capped Offer/Bid Energy Price adjusted for TLF, DLF and VoLL for energy imports |
| `LOAD_MIN_RAMP_RATE_UP` | `int` | BDU only; MW/Min calculated Minimum Ramp Rate Up for Energy Offers or Bids with explicit ramp rates for energy imports |
| `LOAD_MIN_RAMP_RATE_DOWN` | `int` | BDU only; MW/Min calculated Minimum Ramp Rate Down for Energy Offers or Bids with explicit ramp rates for energy imports |
| `LOAD_MAX_RAMP_RATE_UP` | `int` | BDU only; MW/Min registered Maximum Ramp Rate Up for Energy Offers or Bids for energy imports |
| `LOAD_MAX_RAMP_RATE_DOWN` | `int` | BDU only; MW/Min registered Maximum Ramp Rate Down for Energy Offers or Bids for energy imports |
| `SECONDARY_TLF` | `decimal(18,8)` | Used in Bidding, Dispatch and Settlements; only populated where Dual TLFs apply |

# Upstream

Derived from AEMO's **DUDETAILSUMMARY** (package `PARTICIPANT_REGISTRATION`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec44.htm#60
