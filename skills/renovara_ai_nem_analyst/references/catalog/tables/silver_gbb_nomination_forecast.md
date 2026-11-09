---
type: Renovara Table
title: silver_gbb_nomination_forecast
description: Renovara table silver_gbb_nomination_forecast
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:17:13Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_nomination_forecast
column_count: 13
row_count: 9355
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 140535
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_nomination_forecast` |
| Rows | 9,355 |
| Date range | no recognised time column |
| Size on disk | 137.2 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `Gasdate` | `date` | Date of gas day. [AI-generated] AEMO spells this column `GasDate` in the guide and in every other GBB report, but the CSV header for this report is `Gasdate` -- the inconsistency is in the source file. Stored as `yyyy/MM/dd`. |
| `FacilityId` | `int` | A unique AEMO defined Facility identifier. [AI-generated] Join to silver_gbb_facilities.FacilityId. |
| `FacilityName` | `string` | The name of the BB facility. [AI-generated] Not a stable key -- join on FacilityId. |
| `FacilityType` | `string` | Facility type associated with the Facility Id. AEMO examples: PIPE; PROD; STOR; COMPRESSOR; LNGIMPORT. |
| `LocationId` | `int` | Unique location identifier. [AI-generated] Join to silver_gbb_locations.LocationId. |
| `LocationName` | `string` | Name of the location. [AI-generated] Join on LocationId rather than this. |
| `State` | `string` | Name of the state. [AI-generated] NSW, VIC, QLD, SA, TAS, NT. |
| `Demand` | `decimal(15,3)` | Usage type expressed in TJ. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `Supply` | `decimal(15,3)` | Usage type expressed in TJ. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `TransferIn` | `decimal(15,3)` | Usage type expressed in TJ. Only applicable to BB pipelines. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `TransferOut` | `decimal(15,3)` | Usage type expressed in TJ. Only applicable to BB pipelines. Three decimal places is not shown if the value has trailing zeros after the decimal place. |
| `LastUpdated` | `timestamp` | Date file was last updated. [AI-generated] `yyyy/MM/dd HH:mm:ss` AEST. |
