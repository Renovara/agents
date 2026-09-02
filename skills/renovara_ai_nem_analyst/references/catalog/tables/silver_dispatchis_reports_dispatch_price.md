---
type: Renovara Table
title: silver_dispatchis_reports_dispatch_price
description: DISPATCHPRICE records 5-minute dispatch prices for energy and FCAS, including whether an
  intervention has occurred, or price override (e.g. for Administered Price Cap). Updates occur every
  5 minutes. APCFLAG meanings are as follows Bit 5 (1
tags:
- renovara
- nemweb
- canonical:DISPATCH_PRICE
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_dispatchis_reports_dispatch_price
canonical_report: DISPATCH_PRICE
column_count: 73
row_count: 4140800
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 00:05:00'
  to: '2026-09-02 08:50:00'
size_bytes: 297566212
primary_key:
- DISPATCHINTERVAL
- INTERVENTION
- REGIONID
- RUNNO
- SETTLEMENTDATE
aemo_table: DISPATCHPRICE
visibility: Public
---

DISPATCHPRICE records 5-minute dispatch prices for energy and FCAS, including whether an intervention has occurred, or price override (e.g. for Administered Price Cap). Updates occur every 5 minutes. APCFLAG meanings are as follows Bit 5 (16) Price Scaling via Inter-regional Loss Factor (IRLF) Bit 4 (8) Price manually overwritten Bit 3 (4) MPC or MPF binding (ROP outside MPC/MPF) Bit 2 (2) VoLL Override applied Bit 1 (1) APC or APF binding (ROP outside APC/APF) FCAS APCFLAG meanings are as follows Bit 4 (8) Price manually overwritten Bit 3 (4) MPC ($VoLL) or MPF ($zero) binding (ROP outside MPC/MPF) Bit 1 (1) APC or APF binding (ROP outside APC/APF) Where MPC = Market Price Cap, MPF = Market Price Floor, APC = Administered Price Cap, APF = Administered Price Floor

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatchis_reports_dispatch_price` |
| Rows | 4,140,800 |
| Date range | 2019-01-01 00:05:00 to 2026-09-02 08:50:00 (by `SETTLEMENTDATE`) |
| Size on disk | 283.8 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date and time (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `RUNNO` | `smallint` | Dispatch run number; always 1 |
| `REGIONID` | `string` | Region Identifier |
| `DISPATCHINTERVAL` | `bigint` | Dispatch interval identifier, format YYYYMMDDPPP (001–288). |
| `INTERVENTION` | `tinyint` | Manual intervention flag. |
| `RRP` | `decimal(15,5)` | Regional Reference Price for this dispatch period (used for settlement). |
| `EEP` | `decimal(15,5)` | Excess energy price (no longer used). |
| `ROP` | `decimal(15,5)` | Regional Override Price before any scaling, capping, or VoLL override. |
| `APCFLAG` | `smallint` | Administered Price Cap flag indicating post-processing adjustments. |
| `MARKETSUSPENDEDFLAG` | `smallint` | Indicates if market was suspended. |
| `LASTCHANGED` | `timestamp` | Timestamp of last record change. |
| `RAISE6SECRRP` | `decimal(15,5)` | RAISE 6SEC Regional Reference Price. |
| `RAISE6SECROP` | `decimal(15,5)` | RAISE 6SEC Regional Override Price. |
| `RAISE6SECAPCFLAG` | `smallint` | RAISE 6SEC APC Flag. |
| `RAISE60SECRRP` | `decimal(15,5)` | RAISE 60SEC Regional Reference Price. |
| `RAISE60SECROP` | `decimal(15,5)` | RAISE 60SEC Regional Override Price. |
| `RAISE60SECAPCFLAG` | `smallint` | RAISE 60SEC APC Flag. |
| `RAISE5MINRRP` | `decimal(15,5)` | RAISE 5MIN Regional Reference Price. |
| `RAISE5MINROP` | `decimal(15,5)` | RAISE 5MIN Regional Override Price. |
| `RAISE5MINAPCFLAG` | `smallint` | RAISE 5MIN APC Flag. |
| `RAISEREGRRP` | `decimal(15,5)` | RAISE REG Regional Reference Price. |
| `RAISEREGROP` | `decimal(15,5)` | RAISE REG Regional Override Price. |
| `RAISEREGAPCFLAG` | `smallint` | RAISE REG APC Flag. |
| `LOWER6SECRRP` | `decimal(15,5)` | LOWER 6SEC Regional Reference Price. |
| `LOWER6SECROP` | `decimal(15,5)` | LOWER 6SEC Regional Override Price. |
| `LOWER6SECAPCFLAG` | `smallint` | LOWER 6SEC APC Flag. |
| `LOWER60SECRRP` | `decimal(15,5)` | LOWER 60SEC Regional Reference Price. |
| `LOWER60SECROP` | `decimal(15,5)` | LOWER 60SEC Regional Override Price. |
| `LOWER60SECAPCFLAG` | `smallint` | LOWER 60SEC APC Flag. |
| `LOWER5MINRRP` | `decimal(15,5)` | LOWER 5MIN Regional Reference Price. |
| `LOWER5MINROP` | `decimal(15,5)` | LOWER 5MIN Regional Override Price. |
| `LOWER5MINAPCFLAG` | `smallint` | LOWER 5MIN APC Flag. |
| `LOWERREGRRP` | `decimal(15,5)` | LOWER REG Regional Reference Price. |
| `LOWERREGROP` | `decimal(15,5)` | LOWER REG Regional Override Price. |
| `LOWERREGAPCFLAG` | `smallint` | LOWER REG APC Flag. |
| `PRICE_STATUS` | `string` | Status of regional prices for this dispatch interval: "FIRM" or "NOT FIRM". |
| `PRE_AP_ENERGY_PRICE` | `decimal(15,5)` | Energy price before administered price (AP) capping or scaling. |
| `PRE_AP_RAISE6_PRICE` | `decimal(15,5)` | Price before ap capping or scaling - for rolling sum price monitoring |
| `PRE_AP_RAISE60_PRICE` | `decimal(15,5)` | Price before ap capping or scaling - for rolling sum price monitoring |
| `PRE_AP_RAISE5MIN_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `PRE_AP_RAISEREG_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `PRE_AP_LOWER6_PRICE` | `decimal(15,5)` | Price before ap capping or scaling - for rolling sum price monitoring |
| `PRE_AP_LOWER60_PRICE` | `decimal(15,5)` | Price before ap capping or scaling - for rolling sum price monitoring |
| `PRE_AP_LOWER5MIN_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `PRE_AP_LOWERREG_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `RAISE1SECRRP` | `decimal(15,5)` | Regional Raise 1Sec Price - R1Price attribute after capping/flooring |
| `RAISE1SECROP` | `decimal(15,5)` | Raise1Sec Regional Original Price - uncapped/unfloored and unscaled |
| `RAISE1SECAPCFLAG` | `tinyint` | BitFlag field for Price adjustments - "1" = Voll_Override; "4" = Floor_VoLL; "8" = Manual_Override; "16" = Price_Scaled |
| `LOWER1SECRRP` | `decimal(15,5)` | Regional Lower 1Sec Price - RegionSolution element L1Price attribute |
| `LOWER1SECROP` | `decimal(15,5)` | Lower1Sec Regional Original Price - uncapped/unfloored and unscaled |
| `LOWER1SECAPCFLAG` | `tinyint` | BitFlag field for Price adjustments - "1" = Voll_Override; "4" = Floor_VoLL; "8" = Manual_Override; "16" = Price_Scaled |
| `PRE_AP_RAISE1_PRICE` | `decimal(15,5)` | Price before AP capping or scaling - for Rolling Sum Price monitoring |
| `PRE_AP_LOWER1_PRICE` | `decimal(15,5)` | Price before AP capping or scaling - for Rolling Sum Price monitoring |
| `CUMUL_PRE_AP_ENERGY_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_RAISE6_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_RAISE60_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_RAISE5MIN_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_RAISEREG_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_LOWER6_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_LOWER60_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_LOWER5MIN_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_LOWERREG_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing if above the threshold. |
| `CUMUL_PRE_AP_RAISE1_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing event if above the threshold |
| `CUMUL_PRE_AP_LOWER1_PRICE` | `decimal(15,5)` | Cumulative price that triggers administered pricing event if above the threshold |
| `OCD_STATUS` | `string` | OCD status: 'NOT_OCD', 'OCD_UNRESOLVED', or 'OCD_RESOLVED'. |
| `MII_STATUS` | `string` | MII status: 'NOT_MII', 'MII_SUBJECT_TO_REVIEW', 'MII_PRICE_REJECTED', or 'MII_PRICE_ACCEPTED'. |
| `PRE_AP_RAISE6SEC_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `PRE_AP_RAISE60SEC_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `PRE_AP_LOWER6SEC_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `PRE_AP_LOWER60SEC_PRICE` | `decimal(15,5)` | Price before AP capping or scaling (for rolling sum monitoring). |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHPRICE** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec21.htm#151
