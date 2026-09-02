---
type: Renovara Table
title: silver_predispatchis_reports_predispatch_region_solution
description: |-
  PREDISPATCH_REGION_SOLUTION sets out the overall regional Pre-Dispatch results for
  base case details (excluding price). It includes forecast demand (total demand)
  and FCAS requirements (Raise Regulation and Lower Regulation), and updates
  ev
tags:
- renovara
- nemweb
- canonical:PREDISPATCH_REGION_SOLUTION
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_predispatchis_reports_predispatch_region_solution
canonical_report: PREDISPATCH_REGION_SOLUTION
column_count: 129
row_count: 3839470
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: LASTCHANGED
  from: '2025-11-18 00:32:25'
  to: '2026-09-02 08:31:44'
size_bytes: 654302677
primary_key:
- DATETIME
- REGIONID
aemo_table: PREDISPATCHREGIONSUM
visibility: Public
---

PREDISPATCH_REGION_SOLUTION sets out the overall regional Pre-Dispatch results for
base case details (excluding price). It includes forecast demand (total demand)
and FCAS requirements (Raise Regulation and Lower Regulation), and updates
every thirty minutes with the latest Pre-Dispatch details for remaining
periods. Regional demand can be calculated as:
Regional demand = TotalDemand + DispatchableLoad.


# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_predispatchis_reports_predispatch_region_solution` |
| Rows | 3,839,470 |
| Date range | 2025-11-18 00:32:25 to 2026-09-02 08:31:44 (by `LASTCHANGED`) |
| Size on disk | 624.0 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `PREDISPATCHSEQNO` | `string` | Unique identifier of predispatch run in the form YYYYMMDDPP with 01 at 04:30 |
| `RUNNO` | `smallint` | LP Solver Pre-Dispatch run no, typically 1; increments if the case is re-run |
| `REGIONID` | `string` | Unique region identifier |
| `PERIODID` | `string` | Period count starting from 1 for each Pre-Dispatch run. Use DATETIME to determine half hour period. |
| `INTERVENTION` | `tinyint` | Flag indicating if result set was sourced from pricing or physical run. 0 = pricing run; 1 = physical run. If no intervention, both runs correspond to 0. |
| `TOTALDEMAND` | `decimal(15,5)` | Total demand in MW for period (less normally on loads) |
| `AVAILABLEGENERATION` | `decimal(15,5)` | Aggregate generation bid available in region |
| `AVAILABLELOAD` | `decimal(15,5)` | Aggregate load bid available in region |
| `DEMANDFORECAST` | `decimal(15,5)` | Delta MW value only |
| `DISPATCHABLEGENERATION` | `decimal(15,5)` | Generation dispatched in period |
| `DISPATCHABLELOAD` | `decimal(15,5)` | Load dispatched in period |
| `NETINTERCHANGE` | `decimal(15,5)` | Net interconnector flow from the regional reference node |
| `EXCESSGENERATION` | `decimal(15,5)` | Excess generation in period / deficit generation if VOLL |
| `LOWER5MINDISPATCH` | `decimal(15,5)` | Not used since Dec 2003. Lower 5 min MW dispatch |
| `LOWER5MINIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Lower 5 min MW imported |
| `LOWER5MINLOCALDISPATCH` | `decimal(15,5)` | Lower 5 min local dispatch |
| `LOWER5MINLOCALPRICE` | `decimal(15,5)` | Not used since Dec 2003. Local price of lower 5 min |
| `LOWER5MINLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower 5 min local requirement |
| `LOWER5MINPRICE` | `decimal(15,5)` | Not used since Dec 2003. Regional price of lower 5 min |
| `LOWER5MINREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower 5 min total requirement |
| `LOWER5MINSUPPLYPRICE` | `decimal(15,5)` | Not used since Dec 2003. Supply price of lower 5 min |
| `LOWER60SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003. Lower 60 sec MW dispatch |
| `LOWER60SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Lower 60 sec MW imported |
| `LOWER60SECLOCALDISPATCH` | `decimal(15,5)` | Lower 60 sec local dispatch |
| `LOWER60SECLOCALPRICE` | `decimal(15,5)` | Not used since Dec 2003. Local price of lower 60 sec |
| `LOWER60SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower 60 sec local requirement |
| `LOWER60SECPRICE` | `decimal(15,5)` | Not used since Dec 2003. Regional price of lower 60 sec |
| `LOWER60SECREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower 60 sec total requirement |
| `LOWER60SECSUPPLYPRICE` | `decimal(15,5)` | Not used since Dec 2003. Supply price of lower 60 sec |
| `LOWER6SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003. Lower 6 sec MW dispatch |
| `LOWER6SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Lower 6 sec MW imported |
| `LOWER6SECLOCALDISPATCH` | `decimal(15,5)` | Lower 6 sec local dispatch |
| `LOWER6SECLOCALPRICE` | `decimal(15,5)` | Not used since Dec 2003. Local price of lower 6 sec |
| `LOWER6SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower 6 sec local requirement |
| `LOWER6SECPRICE` | `decimal(15,5)` | Not used since Dec 2003. Regional price of lower 6 sec |
| `LOWER6SECREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower 6 sec total requirement |
| `LOWER6SECSUPPLYPRICE` | `decimal(15,5)` | Not used since Dec 2003. Supply price of lower 6 sec |
| `RAISE5MINDISPATCH` | `decimal(15,5)` | Not used since Dec 2003. Raise 5 min MW dispatch |
| `RAISE5MINIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Raise 5 min MW imported |
| `RAISE5MINLOCALDISPATCH` | `decimal(15,5)` | Raise 5 min local dispatch |
| `RAISE5MINLOCALPRICE` | `decimal(15,5)` | Not used since Dec 2003. Local price of raise 5 min |
| `RAISE5MINLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise 5 min local requirement |
| `RAISE5MINPRICE` | `decimal(15,5)` | Not used since Dec 2003. Regional price of raise 5 min |
| `RAISE5MINREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise 5 min total requirement |
| `RAISE5MINSUPPLYPRICE` | `decimal(15,5)` | Not used since Dec 2003. Supply price of raise 5 min |
| `RAISE60SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003. Raise 60 sec MW dispatch |
| `RAISE60SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Raise 60 sec MW imported |
| `RAISE60SECLOCALDISPATCH` | `decimal(15,5)` | Raise 60 sec local dispatch |
| `RAISE60SECLOCALPRICE` | `decimal(15,5)` | Not used since Dec 2003. Local price of raise 60 sec |
| `RAISE60SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise 60 sec local requirement |
| `RAISE60SECPRICE` | `decimal(15,5)` | Not used since Dec 2003. Regional price of raise 60 sec |
| `RAISE60SECREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise 60 sec total requirement |
| `RAISE60SECSUPPLYPRICE` | `decimal(15,5)` | Not used since Dec 2003. Supply price of raise 60 sec |
| `RAISE6SECDISPATCH` | `decimal(15,5)` | Not used since Dec 2003. Raise 6 sec MW dispatch |
| `RAISE6SECIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Raise 6 sec MW imported |
| `RAISE6SECLOCALDISPATCH` | `decimal(15,5)` | Raise 6 sec local dispatch |
| `RAISE6SECLOCALPRICE` | `decimal(15,5)` | Not used since Dec 2003. Local price of raise 6 sec |
| `RAISE6SECLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise 6 sec local requirement |
| `RAISE6SECPRICE` | `decimal(15,5)` | Not used since Dec 2003. Regional price of raise 6 sec |
| `RAISE6SECREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise 6 sec total requirement |
| `RAISE6SECSUPPLYPRICE` | `decimal(15,5)` | Not used since Dec 2003. Supply price of raise 6 sec |
| `LASTCHANGED` | `timestamp` | Period date and time (parsed to timestamp in silver) |
| `DATETIME` | `timestamp` | Period expressed as Date/Time (parsed to timestamp in silver) |
| `INITIALSUPPLY` | `decimal(15,5)` | Sum of initial generation and import for region |
| `CLEAREDSUPPLY` | `decimal(15,5)` | Sum of cleared generation and import for region |
| `LOWERREGIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Lower Regulation MW imported |
| `LOWERREGLOCALDISPATCH` | `decimal(15,5)` | Lower Regulation local dispatch |
| `LOWERREGLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower Regulation local requirement |
| `LOWERREGREQ` | `decimal(15,5)` | Not used since Dec 2003. Lower Regulation total requirement |
| `RAISEREGIMPORT` | `decimal(15,5)` | Not used since Dec 2003. Raise Regulation MW imported |
| `RAISEREGLOCALDISPATCH` | `decimal(15,5)` | Raise Regulation local dispatch |
| `RAISEREGLOCALREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise Regulation local requirement |
| `RAISEREGREQ` | `decimal(15,5)` | Not used since Dec 2003. Raise Regulation total requirement |
| `RAISE5MINLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise 5 min local requirement |
| `RAISEREGLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise Reg local requirement |
| `RAISE60SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise 60 sec local requirement |
| `RAISE6SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise 6 sec local requirement |
| `LOWER5MINLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower 5 min local requirement |
| `LOWERREGLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower Reg local requirement |
| `LOWER60SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower 60 sec local requirement |
| `LOWER6SECLOCALVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower 6 sec local requirement |
| `RAISE5MINVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise 5 min requirement |
| `RAISEREGVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise Reg requirement |
| `RAISE60SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise 60 seconds requirement |
| `RAISE6SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Raise 6 seconds requirement |
| `LOWER5MINVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower 5 min requirement |
| `LOWERREGVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower Reg requirement |
| `LOWER60SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower 60 seconds requirement |
| `LOWER6SECVIOLATION` | `decimal(15,5)` | Not used since Dec 2003. Violation (MW) of Lower 6 seconds requirement |
| `RAISE6SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise 6 sec availability |
| `RAISE60SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise 60 sec availability |
| `RAISE5MINACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise 5 min availability |
| `RAISEREGACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise Regulation availability |
| `LOWER6SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted lower 6 sec availability |
| `LOWER60SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted lower 60 sec availability |
| `LOWER5MINACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted lower 5 min availability |
| `LOWERREGACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted lower Regulation availability |
| `DECAVAILABILITY` | `decimal(16,6)` | Generation availability taking into account daily energy constraints |
| `LORSURPLUS` | `decimal(16,6)` | Not used after Feb 2006. Total short term generation capacity reserve used in assessing lack of reserve condition |
| `LRCSURPLUS` | `decimal(16,6)` | Not used after Feb 2006. Total short term generation capacity reserve above the stated low reserve condition requirement |
| `TOTALINTERMITTENTGENERATION` | `decimal(15,5)` | Allowance made for non-scheduled generation in the demand forecast (MW) |
| `DEMAND_AND_NONSCHEDGEN` | `decimal(15,5)` | Sum of cleared scheduled generation, imported generation (at the region boundary) and allowances made for non-scheduled generation (MW) |
| `UIGF` | `decimal(15,5)` | Regional aggregated Unconstrained Intermittent Generation Forecast of Semi-scheduled generation (MW) |
| `SEMISCHEDULE_CLEAREDMW` | `decimal(15,5)` | Regional aggregated Semi-Schedule generator Cleared MW |
| `SEMISCHEDULE_COMPLIANCEMW` | `decimal(15,5)` | Regional aggregated Semi-Schedule generator Cleared MW where Semi-Dispatch cap is enforced |
| `SS_SOLAR_UIGF` | `decimal(15,5)` | Regional aggregated UIGF of Semi-scheduled generation (MW) where the primary fuel source is solar |
| `SS_WIND_UIGF` | `decimal(15,5)` | Regional aggregated UIGF of Semi-scheduled generation (MW) where the primary fuel source is wind |
| `SS_SOLAR_CLEAREDMW` | `decimal(15,5)` | Regional aggregated Semi-Schedule generator Cleared MW where the primary fuel source is solar |
| `SS_WIND_CLEAREDMW` | `decimal(15,5)` | Regional aggregated Semi-Schedule generator Cleared MW where the primary fuel source is wind |
| `SS_SOLAR_COMPLIANCEMW` | `decimal(15,5)` | Regional aggregated Semi-Schedule generator Cleared MW where Semi-Dispatch cap is enforced and the primary fuel source is solar |
| `SS_WIND_COMPLIANCEMW` | `decimal(15,5)` | Regional aggregated Semi-Schedule generator Cleared MW where Semi-Dispatch cap is enforced and the primary fuel source is wind |
| `WDR_INITIALMW` | `decimal(15,5)` | Regional aggregated MW value at start of interval for Wholesale Demand Response (WDR) units |
| `WDR_AVAILABLE` | `decimal(15,5)` | Regional aggregated available MW for Wholesale Demand Response (WDR) units |
| `WDR_DISPATCHED` | `decimal(15,5)` | Regional aggregated dispatched MW for Wholesale Demand Response (WDR) units |
| `LOWER1SECLOCALDISPATCH` | `decimal(15,5)` | Total Lower1Sec dispatched in region – RegionSolution element L1Dispatch attribute |
| `RAISE1SECLOCALDISPATCH` | `decimal(15,5)` | Total Raise1Sec dispatched in region – RegionSolution element R1Dispatch attribute |
| `RAISE1SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted Raise1Sec availability (summated from UnitSolution) |
| `LOWER1SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted Lower1Sec availability (summated from UnitSolution) |
| `SS_SOLAR_AVAILABILITY` | `decimal(15,5)` | For Semi-Scheduled units. Aggregate Energy Availability from Solar units in that region |
| `SS_WIND_AVAILABILITY` | `decimal(15,5)` | For Semi-Scheduled units. Aggregate Energy Availability from Wind units in that region |
| `BDU_ENERGY_STORAGE` | `decimal(15,5)` | Regional aggregated energy storage where the DUID type is BDU (MWh) |
| `BDU_MIN_AVAIL` | `decimal(15,5)` | Total available load side BDU summated for region (MW) |
| `BDU_MAX_AVAIL` | `decimal(15,5)` | Total available generation side BDU summated for region (MW) |
| `BDU_CLEAREDMW_GEN` | `decimal(15,5)` | Regional aggregated cleared MW where the DUID type is BDU, net of export (generation) |
| `BDU_CLEAREDMW_LOAD` | `decimal(15,5)` | Regional aggregated cleared MW where the DUID type is BDU, net of import (load) |
| `BDU_INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | Energy storage for BDU at the start of the interval (MWh) – region aggregated |
| `DECGEN_INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | Energy storage for Daily Energy Constrained Scheduled Generating Units at the start of the interval (MWh) – region aggregated |

# Upstream

Derived from AEMO's **PREDISPATCHREGIONSUM** (package `PRE_DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec49.htm#131
