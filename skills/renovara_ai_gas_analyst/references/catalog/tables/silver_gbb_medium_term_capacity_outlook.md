---
type: Renovara Table
title: silver_gbb_medium_term_capacity_outlook
description: Renovara table silver_gbb_medium_term_capacity_outlook
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_gbb_medium_term_capacity_outlook
column_count: 13
row_count: 27384
measured_at: '2026-09-01T17:10:37Z'
size_bytes: 101985
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_medium_term_capacity_outlook` |
| Rows | 27,384 |
| Date range | no recognised time column |
| Size on disk | 99.6 KB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `FacilityName` | `string` |  |
| `FacilityId` | `int` |  |
| `FromGasDate` | `date` |  |
| `ToGasDate` | `date` |  |
| `CapacityType` | `string` |  |
| `FlowDirection` | `string` |  |
| `ReceiptLocation` | `int` |  |
| `DeliveryLocation` | `int` |  |
| `CapacityDescription` | `string` |  |
| `OutlookQuantity` | `decimal(15,3)` |  |
| `Description` | `string` |  |
| `LastUpdated` | `timestamp` |  |
