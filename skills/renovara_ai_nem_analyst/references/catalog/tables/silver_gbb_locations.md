---
type: Renovara Table
title: silver_gbb_locations
description: Renovara table silver_gbb_locations
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_gbb_locations
column_count: 7
row_count: 25
measured_at: '2026-09-02T00:03:03Z'
size_bytes: 6198
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_locations` |
| Rows | 25 |
| Date range | no recognised time column |
| Size on disk | 6.1 KB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `LocationName` | `string` |  |
| `LocationId` | `int` |  |
| `LocationType` | `string` |  |
| `State` | `string` |  |
| `Description` | `string` |  |
| `LastUpdated` | `timestamp` |  |
