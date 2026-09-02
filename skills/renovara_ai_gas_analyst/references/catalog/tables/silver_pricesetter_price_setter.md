---
type: Renovara Table
title: silver_pricesetter_price_setter
description: Renovara table silver_pricesetter_price_setter
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_pricesetter_price_setter
column_count: 11
row_count: 85520979
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 04:05:00'
  to: '2026-08-01 04:00:00'
size_bytes: 454815262
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_pricesetter_price_setter` |
| Rows | 85,520,979 |
| Date range | 2019-01-01 04:05:00 to 2026-08-01 04:00:00 (by `SETTLEMENTDATE`) |
| Size on disk | 433.7 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `SETTLEMENTDATE` | `timestamp` | Dispatch interval end time, AEST (Australia/Brisbane), parsed to timestamp in silver. Derived from the XML PeriodID (which carries a +10:00 offset). |
| `REGIONID` | `string` | Region whose price this row helps set (e.g. NSW1, QLD1, VIC1, SA1, TAS1). |
| `MARKET` | `string` | Priced commodity — "Energy" or an FCAS service (R6SE, R60S, R5MI, R1SE, L6SE, L60S, L5MI, L1SE). |
| `PRICE` | `decimal(15,5)` | Resolved regional price for MARKET in this interval ($/MWh for Energy, $/MW for FCAS). Equals DISPATCH_PRICE.RRP for Energy. |
| `UNIT` | `string` | DUID of the contributing unit, or an interconnector id for inter-regional contributions (e.g. "T-V-MNSP1,TAS1" — exclude with NOT LIKE '%MNSP%' for unit-level analysis). Join to v_duid_fuel_aer (or silver_nem_participant_and_scheduled_loads) for fuel source. |
| `DISPATCHEDMARKET` | `string` | Market the unit was dispatched in for this contribution. ENOF = energy offer; BDOF,GEN / BDOF,LOAD = bidirectional-unit (battery) offer by side — together these are the unit energy price-setters. R*/L* codes = FCAS offers contributing to the energy price via co-optimisation; tbslack* / GenericConstraintSurplus = solver artifacts. LDOF = scheduled-load offer (rare). |
| `BANDNO` | `tinyint` | Offer band number (1-10) of the contributing unit. |
| `INCREASE` | `decimal(18,8)` | Marginal MW response of this unit/band to a 1 MW demand change in REGIONID (effectiveness factor). Largest absolute INCREASE among ENOF/BDOF rows = the dominant energy price setter. |
| `RRNBANDPRICE` | `decimal(15,5)` | The unit's offer band price referred to the Regional Reference Node ($/MWh). |
| `BANDCOST` | `decimal(18,8)` | INCREASE x RRNBANDPRICE — this band's contribution to the resolved regional price. |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |
