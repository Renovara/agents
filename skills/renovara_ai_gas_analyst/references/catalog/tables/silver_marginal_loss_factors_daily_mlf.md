---
type: Renovara Table
title: silver_marginal_loss_factors_daily_mlf
description: Marginal Loss Factors by connection point, versioned by effective date and version number.
  Includes primary and secondary TLFs where dual TLFs apply.
tags:
- renovara
- nemweb
- canonical:DAILY_MLF
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_marginal_loss_factors_daily_mlf
canonical_report: DAILY_MLF
column_count: 11
row_count: 841366
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: EFFECTIVEDATE
  from: '2011-07-01 00:00:00'
  to: '2026-08-31 00:00:00'
size_bytes: 1830971
---

Marginal Loss Factors by connection point, versioned by effective date and version number. Includes primary and secondary TLFs where dual TLFs apply.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_marginal_loss_factors_daily_mlf` |
| Rows | 841,366 |
| Date range | 2011-07-01 00:00:00 to 2026-08-31 00:00:00 (by `EFFECTIVEDATE`) |
| Size on disk | 1.7 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `EFFECTIVEDATE` | `timestamp` | Effective date of record |
| `VERSIONNO` | `bigint` | Version no of record for given effective date |
| `REGIONID` | `string` | Region Identifier |
| `CONNECTIONPOINTID` | `string` | Connection Point ID |
| `CONNECTIONPOINTTYPE` | `string` | Type of connection point |
| `DUID` | `string` | Dispatchable unit identifier |
| `TRANSMISSIONLOSSFACTOR` | `decimal(15,5)` | Used in Bidding, Dispatch and Settlements. For Bidding and Dispatch, where the DUID is a BDU with DISPATCHTYPE of BIDIRECTIONAL, the TLF for the load component of the BDU. For Settlements, where dual TLFs apply, the primary TLF is applied to all energy (load and generation) when the Net Energy Flow of the ConnectionPointID in the interval is negative (net load). |
| `SECONDARY_TLF` | `decimal(18,8)` | Used in Bidding, Dispatch and Settlements, only populated where Dual TLFs apply. For Bidding and Dispatch, the TLF for the generation component of a BDU; when null the TRANSMISSIONLOSSFACTOR is used for both the load and generation components. For Settlements, the secondary TLF is applied to all energy (load and generation) when the Net Energy Flow of the ConnectionPointID in the interval is positive (net generation). |
| `LASTCHANGED` | `timestamp` | Record creation timestamp |
