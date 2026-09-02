---
type: Renovara Table
title: silver_gbb_linepack_zones
description: Renovara table silver_gbb_linepack_zones
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T00:56:32Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_gbb_linepack_zones
column_count: 4
row_count: 56
measured_at: '2026-09-02T00:03:03Z'
size_bytes: 6402
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_linepack_zones` |
| Rows | 56 |
| Date range | no recognised time column |
| Size on disk | 6.3 KB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `Operator` | `string` |  |
| `LinepackZone` | `string` |  |
| `LinepackZoneDescription` | `string` |  |
