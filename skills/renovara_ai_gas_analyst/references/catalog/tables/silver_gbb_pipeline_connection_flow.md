---
type: Renovara Table
title: silver_gbb_pipeline_connection_flow
description: Renovara table silver_gbb_pipeline_connection_flow
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:17:59Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_pipeline_connection_flow
column_count: 13
row_count: 1665203
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 13437064
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_pipeline_connection_flow` |
| Rows | 1,665,203 |
| Date range | no recognised time column |
| Size on disk | 12.8 MB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `GasDate` | `date` | Date of gas day. Timestamps are ignored. The gas day as defined in the pipeline contract or market rules. [AI-generated] Stored as `yyyy/MM/dd`; parse with to_date, never timezone-shift. |
| `FacilityName` | `string` | Name of the facility. [AI-generated] Not a stable key -- join on FacilityId. |
| `FacilityId` | `int` | A unique AEMO defined Facility identifier. [AI-generated] Always a BB pipeline in this report. Join to silver_gbb_facilities.FacilityId. |
| `ConnectionPointName` | `string` | Names of the connection point. [AI-generated] Not a stable key -- join on ConnectionPointId. |
| `ConnectionPointId` | `int` | A unique AEMO defined connection point identifier. [AI-generated] Join to silver_gbb_nodes_connection_points.ConnectionPointId. |
| `ActualQuantity` | `decimal(18,3)` | The actual flow quantity reported in TJ to the nearest terajoule with three decimal places. |
| `FlowDirection` | `string` | A conditional value of either: RECEIPT -- a flow of gas into the BB pipeline, or DELIVERY -- a flow of gas out of the BB pipeline. |
| `State` | `string` | Location. [AI-generated] State code -- NSW, VIC, QLD, SA, TAS, NT. |
| `LocationName` | `string` | Name of the Location. [AI-generated] Join on LocationId rather than this. |
| `LocationId` | `int` | Unique Location identifier. [AI-generated] Join to silver_gbb_locations.LocationId. |
| `Quality` | `string` | Indicates whether meter data for the submission date is available. OK -- Actual Quantity based on meter data; NIL -- Actual Quantity cannot be determined due to an operational issue; OOR -- Out of Range, the submitted value exceeds the High Range set for the connection point's capacity; Not Available -- not submitted by the BB reporting entity for the gas date. [AI-generated] Only OK and NIL occur in the history loaded on 2026-10-01 (1,310 NIL of 1,641,860 rows). NIL rows mostly carry 0.000, which means unknown rather than no flow -- treat them as missing, not as zero. |
| `LastUpdated` | `timestamp` | The date data was last submitted by the participant. [AI-generated] `yyyy/MM/dd HH:mm:ss` AEST. Greatest value per key wins in this silver table; the full revision history is in bronze. |
