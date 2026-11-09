---
type: Renovara Table
title: silver_gbb_linepack_capacity_adequacy
description: Renovara table silver_gbb_linepack_capacity_adequacy
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:19:19Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_linepack_capacity_adequacy
column_count: 8
row_count: 3834
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 69688
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_linepack_capacity_adequacy` |
| Rows | 3,834 |
| Date range | no recognised time column |
| Size on disk | 68.1 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `FacilityName` | `string` | The name of the BB facility. [AI-generated] Not a stable key -- join on FacilityId. |
| `FacilityId` | `int` | A unique AEMO defined Facility identifier. [AI-generated] Join to silver_gbb_facilities.FacilityId. |
| `FacilityType` | `string` | The type of facility. AEMO examples for this report: COMPRESSOR, PIPE. [AI-generated] PROD also occurs in the live data. |
| `GasDate` | `date` | Date of gas day. Timestamps are ignored. The gas day as defined in the pipeline contract or market rules. [AI-generated] Wire format is `dd MMM yyyy HH:mm:ss` in this report -- NOT the `yyyy/MM/dd` form used elsewhere in GBB. Take AEMO's "timestamps are ignored" literally: the time component is noise that changes between publications of the same gas day (AGP 2026-09-01 observed as 17:15:00 then 20:45:00), so silver parses this to a DATE and discards it. Keeping it made the natural key unstable and duplicated the table. |
| `Flag` | `string` | The flags are traffic light colours (Green, Amber, Red) indicating the LCA status for each pipeline. GREEN: pipeline is able to accommodate increased gas flows and the conditions for Amber or Red are not met. AMBER: pipeline is flowing at full capacity, but no involuntary curtailment of 'firm' load is likely or happening. RED: involuntary curtailment of 'firm' load is likely or happening, or linepack has (or is forecast to) drop below minimum operating levels. For a Declared Transmission System, AMBER means a notice of a threat to system security has been issued indicating out-of-merit-order gas may be scheduled, and RED means 'non-firm' LNG is scheduled or involuntary curtailment of load is likely or happening. |
| `Description` | `string` | Free text; facility use is restricted to a description for reasons or comments directly related to the change in the LCA flag and the times, dates, or duration for which those changes are expected to apply. [AI-generated] NULL on roughly 60% of rows, including many GREEN ones. |
| `LastUpdated` | `timestamp` | The date when the record was last updated. [AI-generated] `dd MMM yyyy HH:mm:ss` AEST. |
