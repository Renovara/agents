---
type: Renovara Table
title: silver_gbb_nodes_connection_points
description: Renovara table silver_gbb_nodes_connection_points
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:18:40Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_nodes_connection_points
column_count: 15
row_count: 775
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 46469
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_nodes_connection_points` |
| Rows | 775 |
| Date range | no recognised time column |
| Size on disk | 45.4 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `FacilityName` | `string` | Name of the facility. [AI-generated] Join on FacilityId rather than this. |
| `FacilityId` | `int` | A unique AEMO defined facility identifier. [AI-generated] Join to silver_gbb_facilities.FacilityId. |
| `FacilityType` | `string` | Facility type associated with the Facility Id. AEMO examples: PIPE, PROD, STOR, COMPRESSOR. |
| `ConnectionPointId` | `int` | A unique AEMO defined connection point identifier. [AI-generated] The target of ReceiptLocation / DeliveryLocation in the capacity outlook tables. |
| `ConnectionPointName` | `string` | Name of connection point. [AI-generated] Authoritative -- prefer this over the denormalised name columns in the capacity outlook reports, which disagree with it. |
| `FlowDirection` | `string` | Gas flow direction. RECEIPT: the flow of gas into the BB storage facility or LNG import. DELIVERY: the flow of gas out of the BB storage facility or LNG export. PROCESSED: used only for capacities -- for LNG export the amount of gas that can be processed to a liquefied state on a gas day, for LNG import the amount that can be received and processed into storage. DELIVERYLNGSTOR: used only for capacities -- for LNG import, the amount of gas withdrawn from storage for processing to a gaseous state on a gas day. |
| `Exempt` | `boolean` | Flag indicating whether the connection point has a data exemption. |
| `ExemptionDescription` | `string` | Description of exemption. [AI-generated] NULL on every row in the current source file. |
| `NodeId` | `int` | A unique AEMO defined node identifier. |
| `StateId` | `smallint` | A unique AEMO defined state identifier. |
| `StateName` | `string` | Name of the state. AEMO values: New South Wales and ACT, Northern Territory, Queensland, South Australia, Tasmania, Victoria. |
| `LocationName` | `string` | Name of location. [AI-generated] Join on LocationId rather than this. |
| `LocationId` | `int` | A unique AEMO defined location identifier. [AI-generated] Join to silver_gbb_locations.LocationId. |
| `LastUpdated` | `timestamp` | Date the record was last modified. [AI-generated] `yyyy/MM/dd HH:mm:ss` AEST. |
