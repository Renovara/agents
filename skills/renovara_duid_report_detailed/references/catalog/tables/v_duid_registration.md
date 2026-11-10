---
type: Renovara Table
title: v_duid_registration
description: Renovara table v_duid_registration
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-10T00:24:12Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.v_duid_registration
column_count: 18
row_count: 1019
measured_at: '2026-11-09T03:17:59Z'
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.v_duid_registration` |
| Rows | 1,019 |
| Date range | no recognised time column |
| Size on disk | — |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `duid` | `string` |  |
| `region_id` | `string` |  |
| `station_id` | `string` |  |
| `station_name` | `string` |  |
| `participant_id` | `string` | Participant that owns unit during effective record period |
| `dispatch_type` | `string` |  |
| `dispatch_subtype` | `string` | Additional information for DISPATCHTYPE; for DISPATCHTYPE = LOAD, subtype value is WDR for Wholesale Demand Response units |
| `schedule_type` | `string` |  |
| `is_aggregated` | `tinyint` | Whether the DUID is classified as an "Aggregated Unit" under the rules. This impacts the Minimum Ramp Rate calculation |
| `fuel_group` | `string` |  |
| `fuel_resolved_by` | `string` |  |
| `co2e_energy_source` | `string` |  |
| `registered_capacity_mw` | `decimal(15,5)` |  |
| `max_capacity_mw` | `decimal(15,5)` |  |
| `max_storage_capacity_mwh` | `decimal(15,5)` |  |
| `registered_from` | `timestamp` | Start date for effective record |
| `registered_to` | `timestamp` | End date for effective record |
| `is_registered` | `boolean` |  |
