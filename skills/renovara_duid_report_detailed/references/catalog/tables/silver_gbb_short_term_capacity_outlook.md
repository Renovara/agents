---
type: Renovara Table
title: silver_gbb_short_term_capacity_outlook
description: Renovara table silver_gbb_short_term_capacity_outlook
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:18:40Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_short_term_capacity_outlook
column_count: 13
row_count: 12028
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 175900
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_short_term_capacity_outlook` |
| Rows | 12,028 |
| Date range | no recognised time column |
| Size on disk | 171.8 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `FacilityId` | `int` | A unique AEMO defined Facility Identifier. [AI-generated] Join to silver_gbb_facilities.FacilityId. |
| `FacilityName` | `string` | The name of the BB facility. [AI-generated] Not a stable key -- join on FacilityId. |
| `CapacityType` | `string` | Capacity type values can be: STORAGE -- holding capacity in storage; or MDQ -- daily maximum firm capacity under the expected operating conditions. |
| `CapacityTypeDescription` | `string` | Description of the Capacity Type. |
| `FlowDirection` | `string` | Gas flow direction. Only valid for BB storage, LNG export, or LNG import facilities. RECEIPT: the flow of gas into the BB storage or LNG export facility. DELIVERY: the flow of gas out of the BB storage or LNG import facility. PROCESSED: used by LNG export and LNG import facilities -- for LNG export the amount of gas that can be processed to a liquefied state on a gas day, for LNG import the amount that can be received and processed into storage. DELIVERYLNGSTOR: used by LNG import facilities -- the amount of gas that can be withdrawn from storage for processing to a gaseous state on a gas day. [AI-generated] NONE also occurs in the live data. |
| `GasDate` | `date` | Date of gas day. Timestamps are ignored. The gas day as defined in the pipeline contract or market rules. [AI-generated] Stored as `yyyy/MM/dd`. |
| `OutlookQuantity` | `decimal(15,3)` | Capacity outlook quantity to three decimal places. Three decimal places is not required if the value has trailing zeros after the decimal place. [AI-generated] TJ, as for the medium-term outlook. |
| `Description` | `string` | [AI-generated] Operator's free-text condition note; not defined in the guide's field table for this report, but its example gives "This capacity is the amount of gas that this storage facility can inject into the Victorian Declared Transmission System". NULL on ~26% of rows. |
| `CapacityDescription` | `string` | Free text to describe the meaning of the capacity number provided. [AI-generated] NULL on ~43% of rows. |
| `ReceiptLocation` | `int` | [AI-generated] The Connection Point Id that best represents the receipt location; -1 for BB facilities other than BB pipelines. Not defined in the guide's field table for this report -- wording follows the identically named field in section 4.5. Join to silver_gbb_nodes_connection_points.ConnectionPointId; note ~2% of delivery-side ids in this report do not resolve against the current register snapshot. |
| `DeliveryLocation` | `int` | [AI-generated] The Connection Point Id that best represents the delivery location; -1 for BB facilities other than BB pipelines. Not defined in the guide's field table for this report -- wording follows the identically named field in section 4.5. |
| `LastUpdated` | `timestamp` | [AI-generated] When the operator last submitted or revised this outlook, `yyyy/MM/dd HH:mm:ss` AEST. Not defined in the guide's field table for this report. |
