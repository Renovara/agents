---
type: Renovara Table
title: silver_openelectricity_units
description: Renovara table silver_openelectricity_units
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_openelectricity_units
column_count: 19
row_count: 1125
measured_at: '2026-09-01T17:10:37Z'
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_openelectricity_units` |
| Rows | 1,125 |
| Date range | no recognised time column |
| Size on disk | — |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `ingest_ts` | `timestamp` |  |
| `source_file` | `string` |  |
| `facility_code` | `string` |  |
| `facility_name` | `string` |  |
| `facility_network_id` | `string` |  |
| `facility_network_region` | `string` |  |
| `facility_lat` | `double` |  |
| `facility_lng` | `double` |  |
| `unit_code` | `string` |  |
| `unit_fueltech_id` | `string` |  |
| `unit_status_id` | `string` |  |
| `unit_capacity_registered` | `double` |  |
| `unit_capacity_maximum` | `double` |  |
| `unit_capacity_storage` | `double` |  |
| `unit_dispatch_type` | `string` |  |
| `unit_data_first_seen` | `string` |  |
| `unit_data_last_seen` | `string` |  |
| `unit_created_at` | `string` |  |
| `unit_updated_at` | `string` |  |
