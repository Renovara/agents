---
type: Renovara Table
title: v_duid_fuel_aer
description: Renovara table v_duid_fuel_aer
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.v_duid_fuel_aer
column_count: 7
row_count: 569
measured_at: '2026-09-01T17:10:37Z'
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.v_duid_fuel_aer` |
| Rows | 569 |
| Date range | no recognised time column |
| Size on disk | — |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `duid` | `string` |  |
| `station_name` | `string` | The name of the generation or load station. |
| `dispatch_type` | `string` | Indicates if the asset is a Load, Generation Unit, or Bi-directional Unit. |
| `fuel_source_primary` | `string` | The primary fuel source used by the asset. |
| `fuel_source_descriptor` | `string` | A descriptive identifier for the fuel source. |
| `regionid` | `string` | The NEM region in which the asset is located. |
| `aer_fuel` | `string` |  |
