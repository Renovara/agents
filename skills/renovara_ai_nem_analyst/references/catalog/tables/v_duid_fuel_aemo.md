---
type: Renovara Table
title: v_duid_fuel_aemo
description: Renovara table v_duid_fuel_aemo
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-10-02T03:16:58Z'
stale_after: '2026-12-30'
renovara_table: external_data.nemweb.v_duid_fuel_aemo
column_count: 14
row_count: 1018
measured_at: '2026-10-01T07:50:09Z'
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.v_duid_fuel_aemo` |
| Rows | 1,018 |
| Date range | no recognised time column |
| Size on disk | — |
| Measured at | `2026-10-01T07:50:09Z` |

**Measured 2026-10-01T07:50:09Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `duid` | `string` |  |
| `effective_from` | `date` |  |
| `effective_to` | `date` |  |
| `fuel_group` | `string` |  |
| `resolved_by` | `string` |  |
| `side` | `string` |  |
| `station_id` | `string` |  |
| `region_id` | `string` |  |
| `gensetids` | `string` |  |
| `genset_capacity_mw` | `bigint` |  |
| `co2e_energy_source` | `string` |  |
| `reglist_fuel_source_primary` | `string` | The primary fuel source used by the asset. |
| `reglist_fuel_source_descriptor` | `string` | A descriptive identifier for the fuel source. |
| `note` | `string` |  |
