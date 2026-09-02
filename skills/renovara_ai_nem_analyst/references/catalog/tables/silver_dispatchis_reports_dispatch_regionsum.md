---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_regionsum
description: DISPATCHREGIONSUM sets out the 5-minute solution for each dispatch run for each region, including
  Frequency Control Ancillary Services (FCAS) data, demand, generation, and semi-scheduled forecasts.
  Includes legacy FCAS requirement and price
tags:
- renovara
- nemweb
- canonical:DISPATCH_REGIONSUM
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum
canonical_report: DISPATCH_REGIONSUM
column_count: 138
row_count: 4140800
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 00:05:00'
  to: '2026-09-02 08:50:00'
size_bytes: 639166082
primary_key:
- DISPATCHINTERVAL
- INTERVENTION
- REGIONID
- RUNNO
- SETTLEMENTDATE
aemo_table: DISPATCHREGIONSUM
visibility: Public
---

DISPATCHREGIONSUM sets out the 5-minute solution for each dispatch run for each region, including Frequency Control Ancillary Services (FCAS) data, demand, generation, and semi-scheduled forecasts. Includes legacy FCAS requirement and price fields that are no longer used since December 2003 but retained for completeness.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_regionsum` |
| Rows | 4,140,800 |
| Date range | 2019-01-01 00:05:00 to 2026-09-02 08:50:00 (by `SETTLEMENTDATE`) |
| Size on disk | 609.6 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date and time (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run no; always 1 |
| `REGIONID` | `string` | Region Identifier |
| `DISPATCHINTERVAL` | `bigint` | Dispatch period identifier, from 001 to 288 in format YYYYMMDDPPP. |
| `INTERVENTION` | `tinyint` | Manual Intervention flag |
| `TOTALDEMAND` | `decimal(15,5)` | Demand (less loads) |
| `AVAILABLEGENERATION` | `decimal(15,5)` | Aggregate generation bid available in region |
| `AVAILABLELOAD` | `decimal(15,5)` | Aggregate load bid available in region |
| `DEMANDFORECAST` | `decimal(15,5)` | 5-minute demand forecast adjustment |
| `DISPATCHABLEGENERATION` | `decimal(15,5)` | Dispatched Generation |
| `DISPATCHABLELOAD` | `decimal(15,5)` | Dispatched Load (add to total demand to get inherent region demand) |
| `NETINTERCHANGE` | `decimal(15,5)` | Net interconnector flow from the regional reference node |
| `EXCESSGENERATION` | `decimal(15,5)` | MW quantity of excess generation |
| `LOWER5MINDISPATCH` | `decimal(15,5)` | Lower 5MIN Dispatch (Not used since Dec 2003). |
| `LOWER5MINIMPORT` | `decimal(15,5)` | Lower 5MIN Import (Not used since Dec 2003). |
| `LOWER5MINLOCALDISPATCH` | `decimal(15,5)` | Lower 5MIN Localdispatch (Not used since Dec 2003). |
| `LOWER5MINLOCALPRICE` | `decimal(15,5)` | Lower 5MIN Localprice (Not used since Dec 2003). |
| `LOWER5MINLOCALREQ` | `decimal(15,5)` | Lower 5MIN Localreq (Not used since Dec 2003). |
| `LOWER5MINPRICE` | `decimal(15,5)` | Lower 5MIN Price (Not used since Dec 2003). |
| `LOWER5MINREQ` | `decimal(15,5)` | Lower 5MIN Req (Not used since Dec 2003). |
| `LOWER5MINSUPPLYPRICE` | `decimal(15,5)` | Lower 5MIN Supplyprice (Not used since Dec 2003). |
| `LOWER60SECDISPATCH` | `decimal(15,5)` | Lower 60SEC Dispatch (Not used since Dec 2003). |
| `LOWER60SECIMPORT` | `decimal(15,5)` | Lower 60SEC Import (Not used since Dec 2003). |
| `LOWER60SECLOCALDISPATCH` | `decimal(15,5)` | Lower 60SEC Localdispatch (Not used since Dec 2003). |
| `LOWER60SECLOCALPRICE` | `decimal(15,5)` | Lower 60SEC Localprice (Not used since Dec 2003). |
| `LOWER60SECLOCALREQ` | `decimal(15,5)` | Lower 60SEC Localreq (Not used since Dec 2003). |
| `LOWER60SECPRICE` | `decimal(15,5)` | Lower 60SEC Price (Not used since Dec 2003). |
| `LOWER60SECREQ` | `decimal(15,5)` | Lower 60SEC Req (Not used since Dec 2003). |
| `LOWER60SECSUPPLYPRICE` | `decimal(15,5)` | Lower 60SEC Supplyprice (Not used since Dec 2003). |
| `LOWER6SECDISPATCH` | `decimal(15,5)` | Lower 6SEC Dispatch (Not used since Dec 2003). |
| `LOWER6SECIMPORT` | `decimal(15,5)` | Lower 6SEC Import (Not used since Dec 2003). |
| `LOWER6SECLOCALDISPATCH` | `decimal(15,5)` | Lower 6SEC Localdispatch (Not used since Dec 2003). |
| `LOWER6SECLOCALPRICE` | `decimal(15,5)` | Lower 6SEC Localprice (Not used since Dec 2003). |
| `LOWER6SECLOCALREQ` | `decimal(15,5)` | Lower 6SEC Localreq (Not used since Dec 2003). |
| `LOWER6SECPRICE` | `decimal(15,5)` | Lower 6SEC Price (Not used since Dec 2003). |
| `LOWER6SECREQ` | `decimal(15,5)` | Lower 6SEC Req (Not used since Dec 2003). |
| `LOWER6SECSUPPLYPRICE` | `decimal(15,5)` | Lower 6SEC Supplyprice (Not used since Dec 2003). |
| `RAISE5MINDISPATCH` | `decimal(15,5)` | Raise 5MIN Dispatch (Not used since Dec 2003). |
| `RAISE5MINIMPORT` | `decimal(15,5)` | Raise 5MIN Import (Not used since Dec 2003). |
| `RAISE5MINLOCALDISPATCH` | `decimal(15,5)` | Raise 5MIN Localdispatch (Not used since Dec 2003). |
| `RAISE5MINLOCALPRICE` | `decimal(15,5)` | Raise 5MIN Localprice (Not used since Dec 2003). |
| `RAISE5MINLOCALREQ` | `decimal(15,5)` | Raise 5MIN Localreq (Not used since Dec 2003). |
| `RAISE5MINPRICE` | `decimal(15,5)` | Raise 5MIN Price (Not used since Dec 2003). |
| `RAISE5MINREQ` | `decimal(15,5)` | Raise 5MIN Req (Not used since Dec 2003). |
| `RAISE5MINSUPPLYPRICE` | `decimal(15,5)` | Raise 5MIN Supplyprice (Not used since Dec 2003). |
| `RAISE60SECDISPATCH` | `decimal(15,5)` | Raise 60SEC Dispatch (Not used since Dec 2003). |
| `RAISE60SECIMPORT` | `decimal(15,5)` | Raise 60SEC Import (Not used since Dec 2003). |
| `RAISE60SECLOCALDISPATCH` | `decimal(15,5)` | Raise 60SEC Localdispatch (Not used since Dec 2003). |
| `RAISE60SECLOCALPRICE` | `decimal(15,5)` | Raise 60SEC Localprice (Not used since Dec 2003). |
| `RAISE60SECLOCALREQ` | `decimal(15,5)` | Raise 60SEC Localreq (Not used since Dec 2003). |
| `RAISE60SECPRICE` | `decimal(15,5)` | Raise 60SEC Price (Not used since Dec 2003). |
| `RAISE60SECREQ` | `decimal(15,5)` | Raise 60SEC Req (Not used since Dec 2003). |
| `RAISE60SECSUPPLYPRICE` | `decimal(15,5)` | Raise 60SEC Supplyprice (Not used since Dec 2003). |
| `RAISE6SECDISPATCH` | `decimal(15,5)` | Raise 6SEC Dispatch (Not used since Dec 2003). |
| `RAISE6SECIMPORT` | `decimal(15,5)` | Raise 6SEC Import (Not used since Dec 2003). |
| `RAISE6SECLOCALDISPATCH` | `decimal(15,5)` | Raise 6SEC Localdispatch (Not used since Dec 2003). |
| `RAISE6SECLOCALPRICE` | `decimal(15,5)` | Raise 6SEC Localprice (Not used since Dec 2003). |
| `RAISE6SECLOCALREQ` | `decimal(15,5)` | Raise 6SEC Localreq (Not used since Dec 2003). |
| `RAISE6SECPRICE` | `decimal(15,5)` | Raise 6SEC Price (Not used since Dec 2003). |
| `RAISE6SECREQ` | `decimal(15,5)` | Raise 6SEC Req (Not used since Dec 2003). |
| `RAISE6SECSUPPLYPRICE` | `decimal(15,5)` | Raise 6SEC Supplyprice (Not used since Dec 2003). |
| `AGGEGATEDISPATCHERROR` | `decimal(15,5)` | Calculated dispatch error |
| `AGGREGATEDISPATCHERROR` | `decimal(15,5)` | Calculated dispatch error |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `INITIALSUPPLY` | `decimal(15,5)` | Sum of initial generation and import for region |
| `CLEAREDSUPPLY` | `decimal(15,5)` | Sum of cleared generation and import for region |
| `LOWERREGIMPORT` | `decimal(15,5)` | Lower REG Import (Not used since Dec 2003). |
| `LOWERREGLOCALDISPATCH` | `decimal(15,5)` | Lower REG Localdispatch (Not used since Dec 2003). |
| `LOWERREGLOCALREQ` | `decimal(15,5)` | Lower REG Localreq (Not used since Dec 2003). |
| `LOWERREGREQ` | `decimal(15,5)` | Lower REG Req (Not used since Dec 2003). |
| `RAISEREGIMPORT` | `decimal(15,5)` | Raise REG Import (Not used since Dec 2003). |
| `RAISEREGLOCALDISPATCH` | `decimal(15,5)` | Raise REG Localdispatch (Not used since Dec 2003). |
| `RAISEREGLOCALREQ` | `decimal(15,5)` | Raise REG Localreq (Not used since Dec 2003). |
| `RAISEREGREQ` | `decimal(15,5)` | Raise REG Req (Not used since Dec 2003). |
| `RAISE5MINLOCALVIOLATION` | `decimal(15,5)` | Raise 5MIN Localviolation (Not used since Dec 2003). |
| `RAISEREGLOCALVIOLATION` | `decimal(15,5)` | Raise REG Localviolation (Not used since Dec 2003). |
| `RAISE60SECLOCALVIOLATION` | `decimal(15,5)` | Raise 60SEC Localviolation (Not used since Dec 2003). |
| `RAISE6SECLOCALVIOLATION` | `decimal(15,5)` | Raise 6SEC Localviolation (Not used since Dec 2003). |
| `LOWER5MINLOCALVIOLATION` | `decimal(15,5)` | Lower 5MIN Localviolation (Not used since Dec 2003). |
| `LOWERREGLOCALVIOLATION` | `decimal(15,5)` | Lower REG Localviolation (Not used since Dec 2003). |
| `LOWER60SECLOCALVIOLATION` | `decimal(15,5)` | Lower 60SEC Localviolation (Not used since Dec 2003). |
| `LOWER6SECLOCALVIOLATION` | `decimal(15,5)` | Lower 6SEC Localviolation (Not used since Dec 2003). |
| `RAISE5MINVIOLATION` | `decimal(15,5)` | Raise 5MIN Violation (Not used since Dec 2003). |
| `RAISEREGVIOLATION` | `decimal(15,5)` | Raise REG Violation (Not used since Dec 2003). |
| `RAISE60SECVIOLATION` | `decimal(15,5)` | Raise 60SEC Violation (Not used since Dec 2003). |
| `RAISE6SECVIOLATION` | `decimal(15,5)` | Raise 6SEC Violation (Not used since Dec 2003). |
| `LOWER5MINVIOLATION` | `decimal(15,5)` | Lower 5MIN Violation (Not used since Dec 2003). |
| `LOWERREGVIOLATION` | `decimal(15,5)` | Lower REG Violation (Not used since Dec 2003). |
| `LOWER60SECVIOLATION` | `decimal(15,5)` | Lower 60SEC Violation (Not used since Dec 2003). |
| `LOWER6SECVIOLATION` | `decimal(15,5)` | Lower 6SEC Violation (Not used since Dec 2003). |
| `RAISE6SECACTUALAVAILABILITY` | `decimal(16,6)` | Raise 6SEC Actualavailability |
| `RAISE60SECACTUALAVAILABILITY` | `decimal(16,6)` | Raise 60SEC Actualavailability |
| `RAISE5MINACTUALAVAILABILITY` | `decimal(16,6)` | Raise 5MIN Actualavailability |
| `RAISEREGACTUALAVAILABILITY` | `decimal(16,6)` | Raise REG Actualavailability |
| `LOWER6SECACTUALAVAILABILITY` | `decimal(16,6)` | Lower 6SEC Actualavailability |
| `LOWER60SECACTUALAVAILABILITY` | `decimal(16,6)` | Lower 60SEC Actualavailability |
| `LOWER5MINACTUALAVAILABILITY` | `decimal(16,6)` | Lower 5MIN Actualavailability |
| `LOWERREGACTUALAVAILABILITY` | `decimal(16,6)` | Lower REG Actualavailability |
| `LORSURPLUS` | `decimal(16,6)` | Not in use after 17 Feb 2006. Total short term generation capacity reserve used in assessing lack of reserve condition. |
| `LRCSURPLUS` | `decimal(16,6)` | Not in use after 17 Feb 2006. Total short term generation capacity reserve above the stated low reserve condition requirement. |
| `TOTALINTERMITTENTGENERATION` | `decimal(15,5)` | Allowance made for non-scheduled generation in the demand forecast (MW). |
| `DEMAND_AND_NONSCHEDGEN` | `decimal(15,5)` | Sum of cleared scheduled generation, imports, and non-scheduled generation (MW). |
| `UIGF` | `decimal(15,5)` | Regional aggregated Unconstrained Intermittent Generation Forecast (MW). |
| `SEMISCHEDULE_CLEAREDMW` | `decimal(15,5)` | Regional aggregated Semi-Scheduled generator Cleared MW. |
| `SEMISCHEDULE_COMPLIANCEMW` | `decimal(15,5)` | Semi-Scheduled generator Cleared MW under Semi-Dispatch cap. |
| `SS_SOLAR_UIGF` | `decimal(15,5)` | Unconstrained Intermittent Generation Forecast for solar. |
| `SS_WIND_UIGF` | `decimal(15,5)` | Unconstrained Intermittent Generation Forecast for wind. |
| `SS_SOLAR_CLEAREDMW` | `decimal(15,5)` | Semi-Scheduled solar Cleared MW. |
| `SS_WIND_CLEAREDMW` | `decimal(15,5)` | Semi-Scheduled wind Cleared MW. |
| `SS_SOLAR_COMPLIANCEMW` | `decimal(15,5)` | Solar Cleared MW under Semi-Dispatch cap. |
| `SS_WIND_COMPLIANCEMW` | `decimal(15,5)` | Wind Cleared MW under Semi-Dispatch cap. |
| `WDR_INITIALMW` | `decimal(15,5)` | Regional aggregated MW value at start of interval for Wholesale Demand Response (WDR) units |
| `WDR_AVAILABLE` | `decimal(15,5)` | Regional aggregated available MW for Wholesale Demand Response (WDR) units |
| `WDR_DISPATCHED` | `decimal(15,5)` | Regional aggregated dispatched MW for Wholesale Demand Response (WDR) units |
| `RAISE1SECLOCALDISPATCH` | `decimal(15,5)` | Total Raise1Sec Dispatched in Region - RegionSolution element R1Dispatch attribute |
| `LOWER1SECLOCALDISPATCH` | `decimal(15,5)` | Total Lower1Sec Dispatched in Region - RegionSolution element L1Dispatch attribute |
| `RAISE1SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted Raise1Sec availability (summated from UnitSolution) |
| `LOWER1SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted Lower1Sec availability (summated from UnitSolution) |
| `SS_SOLAR_AVAILABILITY` | `decimal(15,5)` | For Semi-Scheduled units. Aggregate Energy Availability from Solar units in that region |
| `SS_WIND_AVAILABILITY` | `decimal(15,5)` | For Semi-Scheduled units. Aggregate Energy Availability from Wind units in that region |
| `BDU_ENERGY_STORAGE` | `decimal(15,5)` | Regional aggregated energy storage where the DUID type is BDU (MWh) |
| `BDU_MIN_AVAIL` | `decimal(15,5)` | Total available load side BDU summated for region (MW) |
| `BDU_MAX_AVAIL` | `decimal(15,5)` | Total available generation side BDU summated for region (MW) |
| `BDU_CLEAREDMW_GEN` | `decimal(15,5)` | Regional aggregated cleared MW where the DUID type is BDU. Net of export (Generation) |
| `BDU_CLEAREDMW_LOAD` | `decimal(15,5)` | Regional aggregated cleared MW where the DUID type is BDU. Net of import (Load) |
| `BDU_INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | Energy Storage for BDU at the start of the interval(MWh) - Region Aggregated |
| `LOWERREGDISPATCH` | `decimal(15,5)` | Lower REG Dispatch (Not used since Dec 2003). |
| `LOWERREGLOCALPRICE` | `decimal(15,5)` | Lower REG Localprice (Not used since Dec 2003). |
| `LOWERREGPRICE` | `decimal(15,5)` | Lower REG Price (Not used since Dec 2003). |
| `LOWERREGSUPPLYPRICE` | `decimal(15,5)` | Lower REG Supplyprice (Not used since Dec 2003). |
| `RAISEREGDISPATCH` | `decimal(15,5)` | Raise REG Dispatch (Not used since Dec 2003). |
| `RAISEREGLOCALPRICE` | `decimal(15,5)` | Raise REG Localprice (Not used since Dec 2003). |
| `RAISEREGPRICE` | `decimal(15,5)` | Raise REG Price (Not used since Dec 2003). |
| `RAISEREGSUPPLYPRICE` | `decimal(15,5)` | Raise REG Supplyprice (Not used since Dec 2003). |
| `DECGEN_INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | Energy storage for Daily Energy Constrained Scheduled Generating Units at the start of the interval(MWh) - Region Aggregated |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHREGIONSUM** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec22.htm#160
