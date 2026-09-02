---
type: Renovara Table
title: silver_next_day_dispatch_dispatch_offertrk
description: DISPATCHOFFERTRK is the energy and ancillary service bid tracking table for the Dispatch
  process. It identifies which bids from BIDDAYOFFER and BIDPEROFFER were applied for a given unit and
  bid type for each dispatch interval. Data is confi
tags:
- renovara
- nemweb
- canonical:DISPATCH_OFFERTRK
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_next_day_dispatch_dispatch_offertrk
canonical_report: DISPATCH_OFFERTRK
column_count: 9
row_count: 1163225315
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 00:05:00'
  to: '2026-09-02 04:00:00'
size_bytes: 3257141019
primary_key:
- BIDTYPE
- DUID
- SETTLEMENTDATE
aemo_table: DISPATCHOFFERTRK
visibility: Private & Public Next-Day
---

DISPATCHOFFERTRK is the energy and ancillary service bid tracking table for the Dispatch process. It identifies which bids from BIDDAYOFFER and BIDPEROFFER were applied for a given unit and bid type for each dispatch interval. Data is confidential until the next trading day, when it becomes public.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_next_day_dispatch_dispatch_offertrk` |
| Rows | 1,163,225,315 |
| Date range | 2019-01-01 00:05:00 to 2026-09-02 04:00:00 (by `SETTLEMENTDATE`) |
| Size on disk | 3.0 GB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Market date starting at 04:05 (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `DUID` | `string` | Dispatchable unit identifier. |
| `BIDTYPE` | `string` | Bid type identifier – the ancillary service to which the bid applies. |
| `BIDSETTLEMENTDATE` | `string` | Settlement date of bid applied. |
| `BIDOFFERDATE` | `string` | Offer date of bid applied. |
| `LASTCHANGED` | `timestamp` | Last date and time record changed. |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCHOFFERTRK** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec21.htm#140
