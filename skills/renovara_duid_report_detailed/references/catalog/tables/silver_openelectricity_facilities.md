---
type: Renovara Table
title: silver_openelectricity_facilities
description: Renovara table silver_openelectricity_facilities
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:18:40Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_openelectricity_facilities
column_count: 11
row_count: 633
measured_at: '2026-11-09T03:17:59Z'
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_openelectricity_facilities` |
| Rows | 633 |
| Date range | no recognised time column |
| Size on disk | — |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `ingest_ts` | `timestamp` |  |
| `source_file` | `string` |  |
| `facility_code` | `string` |  |
| `facility_name` | `string` |  |
| `network_id` | `string` |  |
| `network_region` | `string` |  |
| `description` | `string` |  |
| `lat` | `double` |  |
| `lng` | `double` |  |
| `created_at` | `string` |  |
| `updated_at` | `string` |  |
