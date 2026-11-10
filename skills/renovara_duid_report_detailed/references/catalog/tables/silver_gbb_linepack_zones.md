---
type: Renovara Table
title: silver_gbb_linepack_zones
description: Renovara table silver_gbb_linepack_zones
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-10T00:24:12Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_linepack_zones
column_count: 4
row_count: 56
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 7695
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_linepack_zones` |
| Rows | 56 |
| Date range | no recognised time column |
| Size on disk | 7.5 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `Operator` | `string` | [AI-generated] Company operating the linepack zone. Part of the key -- zone codes are only unique within an operator. |
| `LinepackZone` | `string` | [AI-generated] Zone code, e.g. "AGP-LP-01". NOT unique on its own; DTS-LP-01 appears under two operators. |
| `LinepackZoneDescription` | `string` | [AI-generated] Physical extent of the zone, e.g. "The entirety of the Amadeus Gas Pipeline including all laterals." |
