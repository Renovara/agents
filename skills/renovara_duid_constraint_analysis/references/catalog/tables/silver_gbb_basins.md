---
type: Renovara Table
title: silver_gbb_basins
description: Renovara table silver_gbb_basins
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:19:54Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_basins
column_count: 3
row_count: 15
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 5312
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_basins` |
| Rows | 15 |
| Date range | no recognised time column |
| Size on disk | 5.2 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `BasinId` | `int` | A unique AEMO defined Facility Identifier. [AI-generated] The guide says "Facility" here, which appears to be a copy-paste error -- this is a basin identifier. AEMO types it bigint; observed values fit comfortably in INT. |
| `BasinName` | `string` | The name of the basin. If short name exists then short name included in report. |
