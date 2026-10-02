---
type: Renovara Table
title: silver_gbb_locations
description: Renovara table silver_gbb_locations
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-10-02T03:16:58Z'
stale_after: '2026-12-30'
renovara_table: external_data.nemweb.silver_gbb_locations
column_count: 7
row_count: 25
measured_at: '2026-10-01T07:50:09Z'
size_bytes: 6198
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_locations` |
| Rows | 25 |
| Date range | no recognised time column |
| Size on disk | 6.1 KB |
| Measured at | `2026-10-01T07:50:09Z` |

**Measured 2026-10-01T07:50:09Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `LocationName` | `string` | Name of the Location. |
| `LocationId` | `int` | Unique Location identifier. [AI-generated] The join key from the GBB flow and nomination tables. |
| `LocationType` | `string` | Type of location. [AI-generated] Observed values are STANDARD (a demand zone) and HUB (a production/transfer hub). The guide's example value for this field is "Head office", which appears to be an error carried over from the Participants report. |
| `State` | `string` | [AI-generated] State/territory abbreviation (NSW, VIC, QLD, SA, TAS, NT). The guide's description for this field reads only "Location", which is not a definition. |
| `Description` | `string` | Free text description of the Location including boundaries and the basis of measurement. |
| `LastUpdated` | `timestamp` | Date the list of locations was last updated. [AI-generated] `yyyy/MM/dd HH:mm:ss` AEST. |
