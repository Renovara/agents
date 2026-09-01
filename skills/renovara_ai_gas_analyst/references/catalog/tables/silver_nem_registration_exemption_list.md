---
type: Renovara Table
title: silver_nem_registration_exemption_list
description: Renovara table silver_nem_registration_exemption_list
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-01T23:41:23Z'
stale_after: '2026-11-30'
renovara_table: external_data.nemweb.silver_nem_registration_exemption_list
column_count: 24
row_count: 545
measured_at: '2026-09-01T17:10:37Z'
size_bytes: 36522
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_nem_registration_exemption_list` |
| Rows | 545 |
| Date range | no recognised time column |
| Size on disk | 35.7 KB |
| Measured at | `2026-09-01T17:10:37Z` |

**Measured 2026-09-01T17:10:37Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PARTICIPANT` | `string` | The registered participant in the NEM. |
| `STATION_NAME` | `string` | The name of the generation or load station. |
| `REGIONID` | `string` | The NEM region in which the asset is located. |
| `DISPATCH_TYPE` | `string` | Indicates if the asset is a Load, Generation Unit, or Bi-directional Unit. |
| `CATEGORY` | `string` | The category of the participant or asset. |
| `CLASSIFICATION` | `string` | The classification of the asset (e.g., scheduled, semi-scheduled, or non-scheduled). |
| `FUEL_SOURCE_PRIMARY` | `string` | The primary fuel source used by the asset. |
| `FUEL_SOURCE_DESCRIPTOR` | `string` | A descriptive identifier for the fuel source. |
| `TECHNOLOGY_TYPE_PRIMARY` | `string` | The primary technology type of the asset. |
| `TECHNOLOGY_TYPE_DESCRIPTOR` | `string` | A descriptive identifier for the technology type. |
| `UNITS` | `string` | The number of units associated with the asset. |
| `AGGREGATION` | `string` | Aggregation details for the participant or asset. |
| `DUID` | `string` | The Dispatchable Unit Identifier for the asset. |
| `REG_CAP_GENERATION_MW` | `double` | The registered capacity of the generator in MW. |
| `MAX_CAP_GENERATION_MW` | `double` | The maximum generation capacity of the asset in MW. |
| `MAX_ROC_MIN_GENERATION` | `double` | Maximum Rate of Change (MW/minute) for generation. |
| `REG_CAP_CONSUMPTION_MW` | `double` | The registered capacity of the consumer in MW. |
| `MAX_CAP_CONSUMPTION_MW` | `double` | The maximum consumption capacity of the asset in MW. |
| `MAX_ROC_MIN_CONSUMPTION` | `double` | Maximum Rate of Change (MW/minute) for consumption. |
| `Maximum storage capacity ` | `double` |  |
| `COMMENTS` | `double` | Additional comments or notes about the participant or asset. |
| `DISPATCH_UNIT_TYPE` | `string` | Derived column combining FUEL_SOURCE_PRIMARY and FUEL_SOURCE_DESCRIPTOR. Represents the generation type of the dispatch unit (e.g., solar, black coal, hydro, wind, gas). Use this column when identifying the generation type of a dispatch unit. |
| `GENERATOR_TYPE` | `string` | Derived column combining FUEL_SOURCE_PRIMARY and FUEL_SOURCE_DESCRIPTOR. Represents the generation type of the dispatch unit (e.g., solar, black coal, hydro, wind, gas). Use this column when identifying the generation type of a dispatch unit. |
| `GENERATOR_FUEL_TYPE` | `string` | Derived column combining FUEL_SOURCE_PRIMARY and FUEL_SOURCE_DESCRIPTOR. Represents the generation type of the dispatch unit (e.g., solar, black coal, hydro, wind, gas). Use this column when identifying the generation type of a dispatch unit. |
