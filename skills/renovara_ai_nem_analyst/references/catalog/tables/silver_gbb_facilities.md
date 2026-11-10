---
type: Renovara Table
title: silver_gbb_facilities
description: Renovara table silver_gbb_facilities
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-10T00:22:53Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_facilities
column_count: 11
row_count: 159
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 13234
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_facilities` |
| Rows | 159 |
| Date range | no recognised time column |
| Size on disk | 12.9 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `FacilityName` | `string` | Name of the facility. |
| `FacilityShortName` | `string` | Abbreviated version of the facility name. [AI-generated] NULL for ~40% of facilities. |
| `FacilityId` | `int` | A unique AEMO defined facility identifier. [AI-generated] The join key from every GBB fact table. |
| `FacilityType` | `string` | Facility type associated with the facility id. AEMO examples: PIPE, PROD, STOR, COMPRESSOR. |
| `FacilityTypeDescription` | `string` | Free text description of the facility type. |
| `OperatingState` | `string` | The operating state (Active or Inactive) of the facility. |
| `OperatingStateDate` | `date` | Date the current operating state was set. [AI-generated] Stored as `yyyy/MM/dd`. |
| `OperatorName` | `string` | Name of the operator for the facility. [AI-generated] NULL for ~13% of facilities. |
| `OperatorId` | `int` | The facility operator's ID. [AI-generated] Join to silver_gbb_participants.CompanyId. |
| `OperatorChangeDate` | `date` | Date the current operator for the facility was set. [AI-generated] Stored as `yyyy/MM/dd`; NULL where OperatorName is NULL. |
