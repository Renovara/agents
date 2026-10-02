---
type: Renovara Table
title: silver_gbb_actual_flow_storage
description: Renovara table silver_gbb_actual_flow_storage
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-10-02T03:16:58Z'
stale_after: '2026-12-30'
renovara_table: external_data.nemweb.silver_gbb_actual_flow_storage
column_count: 15
row_count: 446069
measured_at: '2026-10-01T07:50:09Z'
size_bytes: 7210471
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_actual_flow_storage` |
| Rows | 446,069 |
| Date range | no recognised time column |
| Size on disk | 6.9 MB |
| Measured at | `2026-10-01T07:50:09Z` |

**Measured 2026-10-01T07:50:09Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `GasDate` | `date` | Date of gas day. Timestamps are ignored. The gas day as defined in the pipeline contract or market rules. [AI-generated] Stored as `yyyy/MM/dd`; parse with to_date, never timezone-shift. |
| `FacilityName` | `string` | Name of the facility. [AI-generated] Not a stable key -- join on FacilityId. |
| `FacilityId` | `int` | A unique AEMO defined Facility identifier. [AI-generated] Join to silver_gbb_facilities.FacilityId. |
| `FacilityType` | `string` | The type of facility. AEMO lists: BBGPG, COMPRESSOR, PIPE, PROD, STOR, LNGEXPORT, LNGIMPORT, BBLARGE. [AI-generated] BDIST (blended gas distribution system) also occurs in the live data but is not in the guide's v2.2 list. |
| `Demand` | `decimal(15,3)` | Usage type expressed in TJ. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `Supply` | `decimal(15,3)` | Usage type expressed in TJ. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `TransferIn` | `decimal(15,3)` | Usage type. Only applicable to BB pipelines. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `TransferOut` | `decimal(15,3)` | Usage type. Only applicable to BB pipelines. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `HeldInStorage` | `decimal(15,3)` | Quantity in TJ; three decimal places is not shown if the value has trailing zeros after the decimal place. The AEMO guide gives no semantic definition for this field. [AI-generated] Observed populated only for storage facilities (~3% of rows), NULL otherwise. Guide spells the field `HeldinStorage`; the CSV header is `HeldInStorage`. |
| `CushionGasStorage` | `decimal(15,3)` | The quantity of natural gas that must be retained in the Storage or LNG Import facility in order to maintain the required pressure and deliverability rates. [AI-generated] NULL for non-storage facilities. |
| `State` | `string` | Name of the state. [AI-generated] NSW, VIC, QLD, SA, TAS, NT. Western Australia is a separate bulletin board and is not in this feed. |
| `LocationName` | `string` | Name of the location. [AI-generated] Join on LocationId rather than this. |
| `LocationId` | `int` | Unique location identifier. [AI-generated] Join to silver_gbb_locations.LocationId. |
| `LastUpdated` | `timestamp` | The date data was last submitted by a participant based on the report query. [AI-generated] `yyyy/MM/dd HH:mm:ss` AEST. Greatest value per key wins in this silver view; the full revision history is in bronze. |
