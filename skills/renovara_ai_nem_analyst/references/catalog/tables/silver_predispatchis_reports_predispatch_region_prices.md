---
type: Renovara Table
title: silver_predispatchis_reports_predispatch_region_prices
description: PREDISPATCHPRICE records predispatch prices for each region by period for each predispatch
  run, including fields to handle the Ancillary Services functionality.
tags:
- renovara
- nemweb
- canonical:PREDISPATCH_REGION_PRICES
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_predispatchis_reports_predispatch_region_prices
canonical_report: PREDISPATCH_REGION_PRICES
column_count: 37
row_count: 3839470
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: LASTCHANGED
  from: '2025-11-18 00:32:25'
  to: '2026-09-02 08:31:44'
size_bytes: 37867714
primary_key:
- DATETIME
- REGIONID
aemo_table: PREDISPATCHPRICE
visibility: Public
---

PREDISPATCHPRICE records predispatch prices for each region by period for each predispatch run, including fields to handle the Ancillary Services functionality.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_predispatchis_reports_predispatch_region_prices` |
| Rows | 3,839,470 |
| Date range | 2025-11-18 00:32:25 to 2026-09-02 08:31:44 (by `LASTCHANGED`) |
| Size on disk | 36.1 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `PREDISPATCHSEQNO` | `string` | Unique identifier of predispatch run in the form YYYYMMDDPP with 01 at 04:30 |
| `RUNNO` | `smallint` | LP Solver Predispatch run no, typically 1. It increments if the case is re-run. |
| `REGIONID` | `string` | Unique region identifier |
| `PERIODID` | `string` | PERIODID is just a period count, starting from 1 for each predispatch run. Use DATETIME to determine half hour period. |
| `INTERVENTION` | `tinyint` | Flag to indicate if this result set was sourced from the pricing run (INTERVENTION=0) or the physical run (INTERVENTION=1). In the event that there is not intervention in the market, both pricing and physical runs correspond to INTERVENTION=0. |
| `RRP` | `decimal(15,5)` | Regional Reference Price |
| `EEP` | `decimal(15,5)` | Excess energy price |
| `RRP1` | `decimal(15,5)` | Not used |
| `EEP1` | `decimal(15,5)` | Not used |
| `RRP2` | `decimal(15,5)` | Not used |
| `EEP2` | `decimal(15,5)` | Not used |
| `RRP3` | `decimal(15,5)` | Not used |
| `EEP3` | `decimal(15,5)` | Not used |
| `RRP4` | `decimal(15,5)` | Not used |
| `EEP4` | `decimal(15,5)` | Not used |
| `RRP5` | `decimal(15,5)` | Not used |
| `EEP5` | `decimal(15,5)` | Not used |
| `RRP6` | `decimal(15,5)` | Not used |
| `EEP6` | `decimal(15,5)` | Not used |
| `RRP7` | `decimal(15,5)` | Not used |
| `EEP7` | `decimal(15,5)` | Not used |
| `RRP8` | `decimal(15,5)` | Not used |
| `EEP8` | `decimal(15,5)` | Not used |
| `LASTCHANGED` | `timestamp` | Last date and time record changed (parsed to timestamp in silver) |
| `DATETIME` | `timestamp` | Period date and time (parsed to timestamp in silver) |
| `RAISE6SECRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `RAISE60SECRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `RAISE5MINRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `RAISEREGRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `LOWER6SECRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `LOWER60SECRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `LOWER5MINRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `LOWERREGRRP` | `decimal(15,5)` | Regional reference price for this dispatch period |
| `RAISE1SECRRP` | `decimal(15,5)` | Regional Raise 1Sec Price - R1Price attribute after capping / flooring |
| `LOWER1SECRRP` | `decimal(15,5)` | Regional Lower 1Sec Price - RegionSolution element L1Price attribute |

# Upstream

Derived from AEMO's **PREDISPATCHPRICE** (package `PRE_DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec48.htm#109
