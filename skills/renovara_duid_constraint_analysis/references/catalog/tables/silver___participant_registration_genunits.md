---
type: Renovara Table
title: silver___participant_registration_genunits
description: 'GENUNITS shows genset details for each physical unit with the relevant station: one row
  per genset AEMO has ever registered, retired units included (Liddell LD01-04, Torrens Island A TORRA1-4).
  Carries the fuel AEMO uses for emissions (CO2E'
tags:
- renovara
- nemweb
- canonical:PARTICIPANT_REGISTRATION_GENUNITS
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-10T00:25:30Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver___participant_registration_genunits
canonical_report: PARTICIPANT_REGISTRATION_GENUNITS
column_count: 24
row_count: 8759
measured_at: '2026-11-09T03:17:59Z'
coverage:
  column: LASTCHANGED
  from: '2005-11-23 09:55:53'
  to: '2026-10-02 15:12:44'
size_bytes: 50920
primary_key:
- GENSETID
aemo_table: GENUNITS
visibility: Public
---

GENUNITS shows genset details for each physical unit with the relevant station: one row per genset AEMO has ever registered, retired units included (Liddell LD01-04, Torrens Island A TORRA1-4). Carries the fuel AEMO uses for emissions (CO2E_ENERGY_SOURCE), GENSETTYPE (GENERATOR, LOAD or BIDIRECTIONAL) and capacity. Join to DUIDs through PARTICIPANT_REGISTRATION_DUALLOC (DUID -> GENSETID). One full copy per MMSDM archive month loaded (from 2026-01): GENUNITS has no effective date and AEMO updates rows in place, so take the row with the latest LASTCHANGED per GENSETID. For DUID -> AEMO fuel group use the view v_duid_fuel_aemo; for station, region and capacity, v_duid_registration.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver___participant_registration_genunits` |
| Rows | 8,759 |
| Date range | 2005-11-23 09:55:53 to 2026-10-02 15:12:44 (by `LASTCHANGED`) |
| Size on disk | 49.7 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `GENSETID` | `string` | Physical unit identifier |
| `STATIONID` | `string` | Station identifier |
| `SETLOSSFACTOR` | `decimal(16,6)` | Not used |
| `CDINDICATOR` | `string` | Centrally dispatched indicator |
| `AGCFLAG` | `string` | AGC available flag |
| `SPINNINGFLAG` | `string` | Not used |
| `VOLTLEVEL` | `int` | Voltage level |
| `REGISTEREDCAPACITY` | `int` | Registered capacity (MW) |
| `DISPATCHTYPE` | `string` | Type NET/NET identifies if DUID is a Scheduled and GROSS/NET identifies if DUID is either Semi-Scheduled or Non-Scheduled. |
| `STARTTYPE` | `string` | Fast / Slow / Not Dispatched |
| `MKTGENERATORIND` | `string` | Market generator indicator flag |
| `NORMALSTATUS` | `string` | On / Off for load |
| `MAXCAPACITY` | `int` | Maximum capacity (MW) |
| `GENSETTYPE` | `string` | Identifies LOAD, GENERATOR or BIDIRECTIONAL. Older batteries are registered as a GENERATOR genset plus a separate LOAD genset (e.g. HPRG1 / HPRL1); newer ones as one BIDIRECTIONAL genset. |
| `GENSETNAME` | `string` | Genset name |
| `LASTCHANGED` | `timestamp` | Last date and time record changed (parsed to timestamp in silver). AEST. |
| `CO2E_EMISSIONS_FACTOR` | `decimal(18,8)` | The emissions factor for the generating unit, as calculated by Settlements staff members |
| `CO2E_ENERGY_SOURCE` | `string` | The energy source for the generating unit, as used in the calculation of the CO2-e emissions factor (e.g. 'Black coal', 'Natural Gas (Pipeline)', 'Diesel oil', 'Battery Storage'). Distinct from the fuel source in the Registration and Exemption List. Blank for about 180 gensets, mostly loads; AEMO does not change it when a unit switches fuel (SNAPPER1 still reads 'Diesel oil'), so prefer v_duid_fuel_aemo for fuel. |
| `CO2E_DATA_SOURCE` | `string` | Source of the emission factor: NTNDP (quoted from the National Transmission Network Development Plan) or Estimated (an internal AEMO procedure based on NGA factors). |
| `MINCAPACITY` | `int` | Minimum capacity only for load side of BDU, otherwise 0 (MW) |
| `REGISTEREDMINCAPACITY` | `int` | Registered minimum capacity only for load side of BDU, otherwise 0 (MW) |
| `MAXSTORAGECAPACITY` | `decimal(15,5)` | The rated storage capacity (MWh), information only |

# Upstream

Derived from AEMO's **GENUNITS** (package `PARTICIPANT_REGISTRATION`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec44.htm#80
