---
type: Renovara Table
title: v_duid_fuel_aemo
description: Renovara table v_duid_fuel_aemo
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:19:19Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.v_duid_fuel_aemo
column_count: 12
row_count: 1020
measured_at: '2026-11-09T03:17:59Z'
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.v_duid_fuel_aemo` |
| Rows | 1,020 |
| Date range | no recognised time column |
| Size on disk | — |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

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
| `region_id` | `string` | Region identifier that unit is in |
| `gensetids` | `string` |  |
| `genset_capacity_mw` | `bigint` |  |
| `co2e_energy_source` | `string` |  |
| `note` | `string` |  |
