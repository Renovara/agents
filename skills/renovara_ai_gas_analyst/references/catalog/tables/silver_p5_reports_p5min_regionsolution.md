---
type: Renovara Table
title: silver_p5_reports_p5min_regionsolution
description: |
  The five-minute predispatch (P5Min) system provides projected dispatch for 12 dispatch cycles (one hour). This table shows regional capacity, maximum surplus reserve, and maximum spare capacity evaluations for each period.
tags:
- renovara
- nemweb
- canonical:P5MIN_REGIONSOLUTION
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_p5_reports_p5min_regionsolution
canonical_report: P5MIN_REGIONSOLUTION
column_count: 121
row_count: 4965840
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: INTERVAL_DATETIME
  from: '2025-11-19 00:05:00'
  to: '2026-09-02 09:55:00'
size_bytes: 666327126
primary_key:
- INTERVAL_DATETIME
- REGIONID
- RUN_DATETIME
aemo_table: P5MIN_REGIONSOLUTION
visibility: Public
---

The five-minute predispatch (P5Min) system provides projected dispatch for 12 dispatch cycles (one hour). This table shows regional capacity, maximum surplus reserve, and maximum spare capacity evaluations for each period.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_p5_reports_p5min_regionsolution` |
| Rows | 4,965,840 |
| Date range | 2025-11-19 00:05:00 to 2026-09-02 09:55:00 (by `INTERVAL_DATETIME`) |
| Size on disk | 635.5 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `RUN_DATETIME` | `timestamp` | Unique timestamp identifier for this study |
| `INTERVENTION` | `tinyint` | 0 = pricing run, 1 = physical run |
| `INTERVAL_DATETIME` | `timestamp` | Unique identifier for the interval within this study |
| `REGIONID` | `string` | Region identifier |
| `RRP` | `decimal(15,5)` | Region Reference Price (Energy) |
| `ROP` | `decimal(15,5)` | Region Override Price (Energy) |
| `EXCESSGENERATION` | `decimal(15,5)` | Total energy imbalance (MW) |
| `RAISE6SECRRP` | `decimal(15,5)` | Region Reference Price (Raise 6 Sec) |
| `RAISE6SECROP` | `decimal(15,5)` | Original regional price (Raise 6 Sec) |
| `RAISE60SECRRP` | `decimal(15,5)` | Region Reference Price (Raise 60 Sec) |
| `RAISE60SECROP` | `decimal(15,5)` | Original regional price (Raise 60 Sec) |
| `RAISE5MINRRP` | `decimal(15,5)` | Region Reference Price (Raise 5 Min) |
| `RAISE5MINROP` | `decimal(15,5)` | Original regional price (Raise 5 Min) |
| `RAISEREGRRP` | `decimal(15,5)` | Region Reference Price (Raise Regulation) |
| `RAISEREGROP` | `decimal(15,5)` | Original regional price (Raise Regulation) |
| `LOWER6SECRRP` | `decimal(15,5)` | Region Reference Price (Lower 6 Sec) |
| `LOWER6SECROP` | `decimal(15,5)` | Original regional price (Lower 6 Sec) |
| `LOWER60SECRRP` | `decimal(15,5)` | Region Reference Price (Lower 60 Sec) |
| `LOWER60SECROP` | `decimal(15,5)` | Original regional price (Lower 60 Sec) |
| `LOWER5MINRRP` | `decimal(15,5)` | Region Reference Price (Lower 5 Min) |
| `LOWER5MINROP` | `decimal(15,5)` | Original regional price (Lower 5 Min) |
| `LOWERREGRRP` | `decimal(15,5)` | Region Reference Price (Lower Regulation) |
| `LOWERREGROP` | `decimal(15,5)` | Original regional price (Lower Regulation) |
| `TOTALDEMAND` | `decimal(15,5)` | Regional demand (not net of interconnector flows or loads) |
| `AVAILABLEGENERATION` | `decimal(15,5)` | Regional available generation |
| `AVAILABLELOAD` | `decimal(15,5)` | Regional available load |
| `DEMANDFORECAST` | `decimal(15,5)` | Predicted change in regional demand for this interval |
| `DISPATCHABLEGENERATION` | `decimal(15,5)` | Regional dispatched generation |
| `DISPATCHABLELOAD` | `decimal(15,5)` | Regional dispatched load |
| `NETINTERCHANGE` | `decimal(15,5)` | Net interconnector flows |
| `LOWER5MINDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER5MINIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER5MINLOCALDISPATCH` | `decimal(15,5)` | Lower 5 minute local dispatch |
| `LOWER5MINLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER5MINREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER60SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER60SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER60SECLOCALDISPATCH` | `decimal(15,5)` | Lower 60 sec local dispatch |
| `LOWER60SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER60SECREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER6SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER6SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER6SECLOCALDISPATCH` | `decimal(15,5)` | Lower 6 sec local dispatch |
| `LOWER6SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER6SECREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE5MINDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE5MINIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE5MINLOCALDISPATCH` | `decimal(15,5)` | Raise 5 min local dispatch |
| `RAISE5MINLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE5MINREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE60SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE60SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE60SECLOCALDISPATCH` | `decimal(15,5)` | Raise 60 sec local dispatch |
| `RAISE60SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE60SECREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE6SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE6SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE6SECLOCALDISPATCH` | `decimal(15,5)` | Raise 6 sec local dispatch |
| `RAISE6SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE6SECREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `AGGREGATEDISPATCHERROR` | `decimal(15,5)` | Aggregate dispatch error |
| `INITIALSUPPLY` | `decimal(15,5)` | Initial generation + import |
| `CLEAREDSUPPLY` | `decimal(15,5)` | Cleared generation + import |
| `LOWERREGIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWERREGDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWERREGLOCALDISPATCH` | `decimal(15,5)` | Lower Regulation local dispatch |
| `LOWERREGLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWERREGREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISEREGIMPORT` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISEREGDISPATCH` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISEREGLOCALDISPATCH` | `decimal(15,5)` | Raise Regulation local dispatch |
| `RAISEREGLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISEREGREQ` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE5MINLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISEREGLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE60SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE6SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER5MINLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWERREGLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER60SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER6SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE5MINVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISEREGVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE60SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `RAISE6SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER5MINVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWERREGVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER60SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LOWER6SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003 |
| `LASTCHANGED` | `timestamp` | Last date/time record changed |
| `TOTALINTERMITTENTGENERATION` | `decimal(15,5)` | Allowance for non-scheduled generation (MW) |
| `DEMAND_AND_NONSCHEDGEN` | `decimal(15,5)` | Cleared scheduled + imported + nonsched generation |
| `UIGF` | `decimal(15,5)` | Unconstrained Intermittent Generation Forecast |
| `SEMISCHEDULE_CLEAREDMW` | `decimal(15,5)` | Semi-Scheduled cleared MW |
| `SEMISCHEDULE_COMPLIANCEMW` | `decimal(15,5)` | Semi-Scheduled cleared MW under dispatch cap |
| `SS_SOLAR_UIGF` | `decimal(15,5)` | Solar UIGF |
| `SS_WIND_UIGF` | `decimal(15,5)` | Wind UIGF |
| `SS_SOLAR_CLEAREDMW` | `decimal(15,5)` | Solar cleared MW |
| `SS_WIND_CLEAREDMW` | `decimal(15,5)` | Wind cleared MW |
| `SS_SOLAR_COMPLIANCEMW` | `decimal(15,5)` | Solar cleared MW under dispatch cap |
| `SS_WIND_COMPLIANCEMW` | `decimal(15,5)` | Wind cleared MW under dispatch cap |
| `WDR_INITIALMW` | `decimal(15,5)` | Initial MW for WDR units |
| `WDR_AVAILABLE` | `decimal(15,5)` | Available MW for WDR units |
| `WDR_DISPATCHED` | `decimal(15,5)` | Dispatched MW for WDR units |
| `SS_SOLAR_AVAILABILITY` | `decimal(15,5)` | Solar semi-scheduled availability |
| `SS_WIND_AVAILABILITY` | `decimal(15,5)` | Wind semi-scheduled availability |
| `RAISE1SECRRP` | `decimal(15,5)` | Raise 1-Sec RRP |
| `RAISE1SECROP` | `decimal(15,5)` | Raise 1-Sec unscaled original price |
| `LOWER1SECRRP` | `decimal(15,5)` | Lower 1-Sec RRP |
| `LOWER1SECROP` | `decimal(15,5)` | Lower 1-Sec unscaled original price |
| `RAISE1SECLOCALDISPATCH` | `decimal(15,5)` | Raise 1-Sec dispatched MW |
| `LOWER1SECLOCALDISPATCH` | `decimal(15,5)` | Lower 1-Sec dispatched MW |
| `BDU_ENERGY_STORAGE` | `decimal(15,5)` | BDU energy storage (MWh) |
| `BDU_MIN_AVAIL` | `decimal(15,5)` | BDU load-side available MW |
| `BDU_MAX_AVAIL` | `decimal(15,5)` | BDU generation-side available MW |
| `BDU_CLEAREDMW_GEN` | `decimal(15,5)` | Cleared MW as generation for BDU |
| `BDU_CLEAREDMW_LOAD` | `decimal(15,5)` | Cleared MW as load for BDU |
| `BDU_INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | Initial BDU energy storage (MWh) |
| `DECGEN_INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | Initial DEC-generator energy storage (MWh) |

# Upstream

Derived from AEMO's **P5MIN_REGIONSOLUTION** (package `P5MIN`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec41.htm#72
