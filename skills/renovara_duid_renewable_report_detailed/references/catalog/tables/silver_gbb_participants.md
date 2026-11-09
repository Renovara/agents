---
type: Renovara Table
title: silver_gbb_participants
description: Renovara table silver_gbb_participants
tags:
- renovara
- nemweb
generated:
  by: renovara-okf-builder/1.0
  at: '2026-11-09T07:19:19Z'
stale_after: '2027-02-07'
renovara_table: external_data.nemweb.silver_gbb_participants
column_count: 13
row_count: 260
measured_at: '2026-11-09T03:17:59Z'
size_bytes: 34753
---

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_gbb_participants` |
| Rows | 260 |
| Date range | no recognised time column |
| Size on disk | 33.9 KB |
| Measured at | `2026-11-09T03:17:59Z` |

**Measured 2026-11-09T03:17:59Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `source_last_modified` | `timestamp` |  |
| `CompanyId` | `int` | Company ID associated with the person. [AI-generated] The target of silver_gbb_facilities.OperatorId. |
| `CompanyName` | `string` | Company name associated with the person. |
| `OrganisationTypeName` | `string` | The type of organisation. [AI-generated] e.g. Shipper, BB Reporting Entity, Gas Market Operator. NULL for ~10% of companies. |
| `ABN` | `string` | Australian Business Number for the participant. [AI-generated] STRING, not numeric -- AEMO types this varchar(30), and most values carry the conventional space grouping ("11 086 013 283") while some do not. |
| `CompanyPhone` | `string` | Company phone details. [AI-generated] STRING -- values carry leading zeros and spaces. |
| `Locale` | `string` | Location for the participant. [AI-generated] Suburb or city of the registered address. |
| `AddressType` | `string` | Type of address. [AI-generated] "Head Office" on every row observed. |
| `Address` | `string` | Mailing address for the company. [AI-generated] NULL for ~84% of companies. |
| `State` | `string` | State where the company is located. [AI-generated] The source mixes conventions -- "VI" appears alongside "VIC". |
| `Postcode` | `string` | Postcode details. [AI-generated] STRING, not INT -- AEMO types this varchar(4), and NT postcodes carry a leading zero (0481, 0801, 0828) that an integer type would silently destroy. |
| `CompanyFax` | `string` | Company fax details. [AI-generated] STRING for the same reason as CompanyPhone. NULL for ~47% of companies. |
| `LastUpdated` | `timestamp` | Last changed details. [AI-generated] `dd MMM yyyy HH:mm:ss` AEST -- NOT the slash form used by most GBB reports. |
