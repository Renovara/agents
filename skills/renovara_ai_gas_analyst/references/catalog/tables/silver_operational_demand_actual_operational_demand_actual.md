---
type: Renovara Table
title: silver_operational_demand_actual_operational_demand_actual
description: AEMO's measured actual operational demand per region, one value per half hour — the average
  MW over the half-hour interval ENDING at INTERVAL_DATETIME (the 21:30 row covers 21:00-21:30). Operational
  demand is demand met by scheduled, semi-s
tags:
- renovara
- nemweb
- canonical:OPERATIONAL_DEMAND_ACTUAL
generated:
  by: renovara-okf-builder/1.0
  at: '2026-10-02T03:16:54Z'
stale_after: '2026-12-30'
renovara_table: external_data.nemweb.silver_operational_demand_actual_operational_demand_actual
canonical_report: OPERATIONAL_DEMAND_ACTUAL
column_count: 8
row_count: 190010
measured_at: '2026-10-01T07:50:09Z'
coverage:
  column: INTERVAL_DATETIME
  from: '2024-08-01 00:30:00'
  to: '2026-10-01 17:00:00'
size_bytes: 957534
primary_key:
- INTERVAL_DATETIME
- REGIONID
aemo_table: DEMANDOPERATIONALACTUAL
visibility: Public
---

AEMO's measured actual operational demand per region, one value per half hour — the average MW over the half-hour interval ENDING at INTERVAL_DATETIME (the 21:30 row covers 21:00-21:30). Operational demand is demand met by scheduled, semi-scheduled and significant non-scheduled generation, as generated; it excludes rooftop PV (add ROOFTOP_ACTUAL to get underlying demand). It runs a few percent above DISPATCH_REGIONSUM TOTALDEMAND, which is a 5-minute dispatch target that excludes non-scheduled generation — average TOTALDEMAND over the six 5-minute SETTLEMENTDATEs in (INTERVAL_DATETIME - 30 min, INTERVAL_DATETIME] to compare. OPERATIONAL_DEMAND is unadjusted; OPERATIONAL_DEMAND_ADJUSTMENT (RERT and involuntary load shedding) and WDR_ESTIMATE (wholesale demand response) are zero on almost every row. SA1 can be negative at midday. Source AEMO table DEMANDOPERATIONALACTUAL (Current folder Operational_Demand/ACTUAL_HH). The MMSDM archive holds this table only from 2024-08.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_operational_demand_actual_operational_demand_actual` |
| Rows | 190,010 |
| Date range | 2024-08-01 00:30:00 to 2026-10-01 17:00:00 (by `INTERVAL_DATETIME`) |
| Size on disk | 935.1 KB |
| Measured at | `2026-10-01T07:50:09Z` |

**Measured 2026-10-01T07:50:09Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `REGIONID` | `string` | Region identifier. One of NSW1, QLD1, SA1, TAS1, VIC1. |
| `INTERVAL_DATETIME` | `timestamp` | End of the half-hour interval this value averages over, interval ending - the 21:30 row covers 21:00 to 21:30 (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `OPERATIONAL_DEMAND` | `bigint` | Average 30-minute measured operational demand in MW (unadjusted), as generated. Excludes rooftop PV. Can be negative in SA1 around midday. |
| `OPERATIONAL_DEMAND_ADJUSTMENT` | `bigint` | Adjustment in MW for the estimated amount of activated RERT and involuntary load shedding that occurred as a result of a NER 4.8.9 instruction for load shedding from AEMO. Zero outside such events. |
| `WDR_ESTIMATE` | `bigint` | Estimated average 30-minute MW amount of Wholesale Demand Response that occurred. Zero on almost every interval. |
| `LASTCHANGED` | `timestamp` | Last date and time the record changed (parsed to timestamp in silver). Published about one second after the interval ends. Timestamp is in AEST or Australia/Brisbane. |

# Upstream

Derived from AEMO's **DEMANDOPERATIONALACTUAL** (package `DEMAND_FORECASTS`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec18.htm#1
