---
type: Renovara Table
title: silver_next_day_dispatch_dispatch_unit_solution
description: DISPATCHLOAD set out the current SCADA MW and target MW for each dispatchable unit, including
  relevant Frequency Control Ancillary Services (FCAS) enabling targets for each five minutes and additional
  fields to handle the new Ancillary Serv
tags:
- renovara
- nemweb
- canonical:DISPATCH_UNIT_SOLUTION
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_next_day_dispatch_dispatch_unit_solution
canonical_report: DISPATCH_UNIT_SOLUTION
column_count: 72
row_count: 349610342
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 00:05:00'
  to: '2026-09-02 04:00:00'
size_bytes: 4363868788
primary_key:
- DUID
- INTERVENTION
- RUNNO
- SETTLEMENTDATE
aemo_table: DISPATCHLOAD
visibility: Private & Public Next-Day
---

DISPATCHLOAD set out the current SCADA MW and target MW for each dispatchable unit, including relevant Frequency Control Ancillary Services (FCAS) enabling targets for each five minutes and additional fields to handle the new Ancillary Services functionality. Fast Start Plant status is indicated by dispatch mode.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_next_day_dispatch_dispatch_unit_solution` |
| Rows | 349,610,342 |
| Date range | 2019-01-01 00:05:00 to 2026-09-02 04:00:00 (by `SETTLEMENTDATE`) |
| Size on disk | 4.1 GB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date and time starting at 04:05. Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run number; always 1 |
| `DUID` | `string` | Dispatchable unit identifier |
| `TRADETYPE` | `tinyint` | Not used |
| `DISPATCHINTERVAL` | `bigint` | Dispatch period identifier, from 001 to 288 in format YYYYMMDDPPP |
| `INTERVENTION` | `tinyint` | Intervention flag; 1 = intervention run, 0 = normal |
| `CONNECTIONPOINTID` | `string` | Connection point identifier for DUID |
| `DISPATCHMODE` | `tinyint` | Dispatch mode for fast start plant (0–4) |
| `AGCSTATUS` | `tinyint` | Automatic Generation Control status: 1 = on, 0 = off |
| `INITIALMW` | `decimal(15,5)` | Initial MW at start of period |
| `TOTALCLEARED` | `decimal(15,5)` | Target MW for end of period |
| `RAMPDOWNRATE` | `decimal(15,5)` | Ramp down rate used in dispatch (min of bid or telemetered rate) |
| `RAMPUPRATE` | `decimal(15,5)` | Ramp up rate used in dispatch (min of bid or telemetered rate) |
| `LOWER5MIN` | `decimal(15,5)` | Lower 5-minute reserve target |
| `LOWER60SEC` | `decimal(15,5)` | Lower 60-second reserve target |
| `LOWER6SEC` | `decimal(15,5)` | Lower 6-second reserve target |
| `RAISE5MIN` | `decimal(15,5)` | Raise 5-minute reserve target |
| `RAISE60SEC` | `decimal(15,5)` | Raise 60-second reserve target |
| `RAISE6SEC` | `decimal(15,5)` | Raise 6-second reserve target |
| `DOWNEPF` | `decimal(15,5)` | Not used |
| `UPEPF` | `decimal(15,5)` | Not used |
| `MARGINAL5MINVALUE` | `decimal(15,5)` | Marginal $ value for 5 min |
| `MARGINAL60SECVALUE` | `decimal(15,5)` | Marginal $ value for 60 seconds |
| `MARGINAL6SECVALUE` | `decimal(15,5)` | Marginal $ value for 6 seconds |
| `MARGINALVALUE` | `decimal(15,5)` | Marginal $ value for energy |
| `VIOLATION5MINDEGREE` | `decimal(15,5)` | Violation MW 5 min |
| `VIOLATION60SECDEGREE` | `decimal(15,5)` | Violation MW 60 seconds |
| `VIOLATION6SECDEGREE` | `decimal(15,5)` | Violation MW 6 seconds |
| `VIOLATIONDEGREE` | `decimal(15,5)` | Violation MW energy |
| `LASTCHANGED` | `timestamp` | Last date and time record changed |
| `LOWERREG` | `decimal(15,5)` | Lower regulation reserve target |
| `RAISEREG` | `decimal(15,5)` | Raise regulation reserve target |
| `AVAILABILITY` | `decimal(15,5)` | Bid energy availability |
| `RAISE6SECFLAGS` | `tinyint` | Raise 6s status flag (bitmask 0–4): 0=unavailable, 1=enabled, 3=trapped, 4=stranded |
| `RAISE60SECFLAGS` | `tinyint` | Raise 60s status flag (bitmask 0–4) |
| `RAISE5MINFLAGS` | `tinyint` | Raise 5m status flag (bitmask 0–4) |
| `RAISEREGFLAGS` | `tinyint` | Raise regulation flag (bitmask 0–4) |
| `LOWER6SECFLAGS` | `tinyint` | Lower 6s status flag (bitmask 0–4): 0=unavailable, 1=enabled, 3=trapped, 4=stranded |
| `LOWER60SECFLAGS` | `tinyint` | Lower 60s status flag (bitmask 0–4) |
| `LOWER5MINFLAGS` | `tinyint` | Lower 5m status flag (bitmask 0–4) |
| `LOWERREGFLAGS` | `tinyint` | Lower regulation flag (bitmask 0–4) |
| `RAISEREGAVAILABILITY` | `decimal(15,5)` | RaiseReg availability - minimum of bid and telemetered value |
| `RAISEREGENABLEMENTMAX` | `decimal(15,5)` | RaiseReg enablement max point - minimum of bid and telemetered value |
| `RAISEREGENABLEMENTMIN` | `decimal(15,5)` | RaiseReg Enablement Min point - maximum of bid and telemetered value |
| `LOWERREGAVAILABILITY` | `decimal(15,5)` | Lower Reg availability - minimum of bid and telemetered value |
| `LOWERREGENABLEMENTMAX` | `decimal(15,5)` | Lower Reg enablement Max point - minimum of bid and telemetered value |
| `LOWERREGENABLEMENTMIN` | `decimal(15,5)` | Lower Reg Enablement Min point - maximum of bid and telemetered value |
| `RAISE6SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise 6sec availability |
| `RAISE60SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise 60sec availability |
| `RAISE5MINACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted raise 5min availability |
| `RAISEREGACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium-adjusted raise regulation availability |
| `LOWER6SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium-adjusted lower 6s availability |
| `LOWER60SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium-adjusted lower 60s availability |
| `LOWER5MINACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium-adjusted lower 5m availability |
| `LOWERREGACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium-adjusted lower regulation availability |
| `SEMIDISPATCHCAP` | `tinyint` | Boolean flag (0/1) indicating if target is capped |
| `DISPATCHMODETIME` | `smallint` | Minutes for which the unit has been in the current DISPATCHMODE. From NEMDE TRADERSOLUTION element FSTARGETMODETIME attribute. |
| `LOWER1SEC` | `decimal(15,5)` | Dispatched Lower1Sec - TraderSolution element L1Target attribute |
| `RAISE1SEC` | `decimal(15,5)` | Dispatched Raise1Sec - TraderSolution element R1Target attribute |
| `RAISE1SECFLAGS` | `tinyint` | TraderSolution element R1Flags attribute |
| `LOWER1SECFLAGS` | `tinyint` | TraderSolution element L1Flags attribute |
| `RAISE1SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted Raise 1Sec Availability |
| `LOWER1SECACTUALAVAILABILITY` | `decimal(16,6)` | Trapezium adjusted Lower 1Sec Availability |
| `CONFORMANCE_MODE` | `int` | Mode specific to units within an aggregate. 0 - no monitoring, 1 - aggregate monitoring, 2 - individual monitoring due to constraint |
| `UIGF` | `decimal(15,5)` | For Semi-Scheduled units. Unconstrained Intermittent Generation Forecast value provided to NEMDE |
| `INITIAL_ENERGY_STORAGE` | `decimal(15,5)` | The energy storage at the start of this dispatch interval(MWh) |
| `ENERGY_STORAGE` | `decimal(15,5)` | The projected energy storage based on cleared energy and regulation FCAS dispatch(MWh) |
| `MIN_AVAILABILITY` | `decimal(15,5)` | BDU only. Load side availability (BidOfferPeriod.MAXAVAIL where DIRECTION = LOAD) |
| `ELEMENT_CAP` | `int` | Cap on the number of turbines or inverters at a DUID. |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHLOAD** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#129
