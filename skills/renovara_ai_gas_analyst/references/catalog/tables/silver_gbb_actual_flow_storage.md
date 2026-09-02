---
type: Renovara Table
title: silver_gbb_actual_flow_storage
description: Renovara table silver_gbb_actual_flow_storage
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_gbb_actual_flow_storage
column_count: 15
row_count: 5841
measured_at: '2026-09-02T00:03:03Z'
size_bytes: 73199
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_actual_flow_storage` |
| Rows | 5,841 |
| Date range | no recognised time column |
| Size on disk | 71.5 KB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `GasDate` | `date` |  |
| `FacilityName` | `string` |  |
| `FacilityId` | `int` |  |
| `FacilityType` | `string` |  |
| `Demand` | `decimal(15,3)` |  |
| `Supply` | `decimal(15,3)` |  |
| `TransferIn` | `decimal(15,3)` |  |
| `TransferOut` | `decimal(15,3)` |  |
| `HeldInStorage` | `decimal(15,3)` |  |
| `CushionGasStorage` | `decimal(15,3)` |  |
| `State` | `string` |  |
| `LocationName` | `string` |  |
| `LocationId` | `int` |  |
| `LastUpdated` | `timestamp` |  |
