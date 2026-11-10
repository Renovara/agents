---
type: Renovara Table
title: silver_gbb_medium_term_capacity_outlook
description: Renovara table silver_gbb_medium_term_capacity_outlook
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-10T00:25:30Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_medium_term_capacity_outlook
column_count: 13
row_count: 34826
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 171534
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_medium_term_capacity_outlook` |
| Rows | 34,826 |
| Date range | no recognised time column |
| Size on disk | 167.5 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `FacilityName` | `string` | Name of the plant. [AI-generated] Not a stable key -- join on FacilityId. |
| `FacilityId` | `int` | Unique plant identifier. [AI-generated] Join to silver_gbb_facilities.FacilityId. |
| `FromGasDate` | `date` | Date of gas day. Any time component supplied is ignored. The gas day is applicable under the pipeline contract or market rules. [AI-generated] First gas day the outlook quantity applies to; stored as `yyyy/MM/dd`. |
| `ToGasDate` | `date` | Date of gas day. Any time component supplied is ignored. The gas day is that applicable under the pipeline contract or market rules. [AI-generated] Last gas day the outlook quantity applies to; ranges of several years are normal. |
| `CapacityType` | `string` | Capacity type values can be: STORAGE -- holding capacity in storage; or MDQ -- daily maximum firm capacity under the expected operating conditions. |
| `FlowDirection` | `string` | Gas flow direction. RECEIPT: the flow of gas into the BB storage facility or LNG import. DELIVERY: the flow of gas out of the BB storage facility or LNG export. PROCESSED: used only for capacities -- for LNG export the amount of gas that can be processed to a liquefied state on a gas day, for LNG import the amount that can be received and processed into storage. DELIVERYLNGSTOR: used only for capacities -- for LNG import, the amount of gas withdrawn from storage for processing to a gaseous state on a gas day. [AI-generated] NONE also occurs in the live data and is the most common value. |
| `ReceiptLocation` | `int` | The Connection Point Id that best represents the receipt location. The Receipt Location in conjunction with the Delivery Location indicates the capacity direction and location. Applicable to BB pipelines only; for other BB facilities this field is populated with -1. [AI-generated] Join to silver_gbb_nodes_connection_points.ConnectionPointId. |
| `DeliveryLocation` | `int` | The Connection Point Id that best represents the delivery location. The Delivery Location in conjunction with the Receipt Location indicates the capacity direction and location. Applicable to BB pipelines only; for other BB facilities this field is populated with -1. [AI-generated] Join to silver_gbb_nodes_connection_points.ConnectionPointId. |
| `CapacityDescription` | `string` | Free text to describe the meaning of the capacity number provided, including a description of material factors that impact the capacity number and any other relevant information. Will only be shown for Pipelines and Compression facilities, and may be shown for LNGImport facilities. |
| `OutlookQuantity` | `decimal(15,3)` | Capacity outlook quantity in TJ to three decimal places. Three decimal places is not required if the value has trailing zeros after the decimal place. |
| `Description` | `string` | [AI-generated] Operator's free-text condition note; the AEMO guide's field table does not define this column, but its example gives "Corrective maintenance requiring reduction of operating pressure". Populated on every observed row, most commonly "Normal conditions". |
| `LastUpdated` | `timestamp` | [AI-generated] When the operator last submitted or revised this outlook, `yyyy/MM/dd HH:mm:ss` AEST. Not defined in the guide's field table for this report. |
