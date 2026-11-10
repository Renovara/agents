---
type: Renovara Table
title: silver___participant_registration_dudetail
description: 'DUDETAIL sets out a records specific details for each unit including start type and whether
  normally on or off load. Effective-dated and versioned per DUID: the row with the latest EFFECTIVEDATE
  on or before a date, at that date''s highest V'
tags:
- renovara
- nemweb
- canonical:PARTICIPANT_REGISTRATION_DUDETAIL
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-10T00:25:30Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver___participant_registration_dudetail
canonical_report: PARTICIPANT_REGISTRATION_DUDETAIL
column_count: 36
row_count: 40055
measured_at: '2026-11-09T03:17:59Z'
coverage:
  column: EFFECTIVEDATE
  from: '1998-10-25 00:00:00'
  to: '2026-10-09 00:00:00'
size_bytes: 190469
primary_key:
- EFFECTIVEDATE
- DUID
- VERSIONNO
aemo_table: DUDETAIL
visibility: Public
---

DUDETAIL sets out a records specific details for each unit including start type and whether normally on or off load. Effective-dated and versioned per DUID: the row with the latest EFFECTIVEDATE on or before a date, at that date's highest VERSIONNO, is in force. Carries the DUID-level REGISTEREDCAPACITY and MAXCAPACITY (MW; MAXCAPACITY is the figure used for bid validation, and for solar farms is usually the AC limit below the registered capacity) and MAXSTORAGECAPACITY (MWh). One full copy per MMSDM archive month loaded (from 2026-01), so the same key repeats once per month: SELECT DISTINCT before counting. For a DUID's current capacity, station, region and fuel in one row use the view v_duid_registration.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___participant_registration_dudetail` |
| Rows | 40,055 |
| Date range | 1998-10-25 00:00:00 to 2026-10-09 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 186.0 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `EFFECTIVEDATE` | `timestamp` | Effective calendar date of record (parsed to timestamp in silver). AEST. |
| `DUID` | `string` | Dispatchable Unit Identifier |
| `VERSIONNO` | `smallint` | version of Dispatchable Unit details for this effective date |
| `CONNECTIONPOINTID` | `string` | Country wide - Unique id of a connection point |
| `VOLTLEVEL` | `string` | Voltage Level |
| `REGISTEREDCAPACITY` | `decimal(15,5)` | Registered capacity for normal operations (MW; AEMO publishes fractions despite the model's NUMBER(6,0)) |
| `AGCCAPABILITY` | `string` | AGC Capability flag |
| `DISPATCHTYPE` | `string` | Identifies LOAD, GENERATOR or BIDIRECTIONAL. |
| `MAXCAPACITY` | `decimal(15,5)` | Maximum Capacity as used for bid validation (MW; fractional for some units) |
| `STARTTYPE` | `string` | Identify unit as Fast or Slow |
| `NORMALLYONFLAG` | `string` | For a dispatchable load indicates that the load is normally on or off. |
| `PHYSICALDETAILSFLAG` | `string` | Indicates that the physical details for this unit are to be recorded |
| `SPINNINGRESERVEFLAG` | `string` | Indicates spinning reserve capability |
| `AUTHORISEDBY` | `string` | User authorising record |
| `AUTHORISEDDATE` | `string` | Date record authorised (string, YYYY/MM/DD HH:MM:SS, AEST; not parsed in silver). |
| `LASTCHANGED` | `timestamp` | Last date and time record changed (parsed to timestamp in silver). AEST. |
| `INTERMITTENTFLAG` | `string` | Indicate whether a unit is intermittent (e.g. a wind farm) |
| `SEMISCHEDULE_FLAG` | `string` | Indicates if the DUID is a Semi-Scheduled Unit |
| `MAXRATEOFCHANGEUP` | `int` | Maximum ramp up rate for Unit (Mw/min) |
| `MAXRATEOFCHANGEDOWN` | `int` | Maximum ramp down rate for Unit (Mw/min) |
| `DISPATCHSUBTYPE` | `string` | Additional information for DISPATCHTYPE. For DISPATCHTYPE = LOAD, subtype value is WDR for wholesale demand response units. For DISPATCHTYPE = LOAD, subtype value is NULL for Scheduled Loads. For DISPATCHTYPE = GENERATOR type, the subtype value is NULL. |
| `ADG_ID` | `string` | Aggregate Dispatch Group to which this dispatch unit belongs |
| `MINCAPACITY` | `int` | Minimum capacity only for load side of BDU, otherwise 0 (MW) |
| `REGISTEREDMINCAPACITY` | `int` | Registered minimum capacity only for load side of BDU, otherwise 0 (MW) |
| `MAXRATEOFCHANGEUP_LOAD` | `int` | Raise Ramp rate applied to BDU Load component (MW/min) |
| `MAXRATEOFCHANGEDOWN_LOAD` | `int` | Lower Ramp rate applied to BDU Load component (MW/min) |
| `MAXSTORAGECAPACITY` | `decimal(15,5)` | The rated storage capacity (MWh), information only |
| `STORAGEIMPORTEFFICIENCYFACTOR` | `decimal(15,5)` | The storage energy import conversion efficiency. Number from 0 to 1 where 1 is lossless. Calculated as (increase in stored energy / increase in imported energy) |
| `STORAGEEXPORTEFFICIENCYFACTOR` | `decimal(15,5)` | The storage energy export conversion efficiency. Number from 0 to 1 where 1 is lossless. Calculated as (decrease in exported energy / decrease in stored energy) |
| `MIN_RAMP_RATE_UP` | `int` | Calculated Minimum Ramp Rate Up value accepted for Energy Offers or Bids with explanation for energy imports (all DUID types and BDU Generation side) (MW/min) |
| `MIN_RAMP_RATE_DOWN` | `int` | Calculated Minimum Ramp Rate Down value accepted for Energy Offers or Bids with explanation for energy imports (all DUID types and BDU Generation side) (MW/min) |
| `LOAD_MIN_RAMP_RATE_UP` | `int` | Calculated Minimum Ramp Rate Up value accepted for Energy Offers or Bids on BDU Load component with explanation for energy imports (MW/min) |
| `LOAD_MIN_RAMP_RATE_DOWN` | `int` | Calculated Minimum Ramp Rate Down value accepted for Energy Offers or Bids on BDU Load component with explanation for energy imports (MW/min) |
| `AGGREGATED` | `int` | Identifies if a unit is aggregated. This flag was initially added in GENUNITS_UNIT table which is now deprecated with IESS release. |

# Upstream

Derived from AEMO's **DUDETAIL** (package `PARTICIPANT_REGISTRATION`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec44.htm#51
