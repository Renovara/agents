---
type: Renovara Table
title: silver_dispatch_scada_dispatch_unit_scada
description: Dispatchable unit MW from SCADA at the start of the dispatch interval. Covers every unit
  with SCADA telemetry, including non-scheduled units that appear in no other dispatch table. Subtracting
  SCADAVALUE from DISPATCH_UNIT_SOLUTION.UIGF giv
tags:
- renovara
- nemweb
- canonical:DISPATCH_UNIT_SCADA
generated:
  by: renovara-okf-builder/1.0
  at: '2026-09-02T03:49:31Z'
stale_after: '2026-12-01'
renovara_table: external_data.nemweb.silver_dispatch_scada_dispatch_unit_scada
canonical_report: DISPATCH_UNIT_SCADA
column_count: 7
row_count: 337448786
measured_at: '2026-09-02T00:03:03Z'
coverage:
  column: SETTLEMENTDATE
  from: '2019-01-01 00:05:00'
  to: '2026-09-02 08:45:00'
size_bytes: 736551161
primary_key:
- SETTLEMENTDATE
- DUID
aemo_table: DISPATCH_UNIT_SCADA
visibility: Public
---

Dispatchable unit MW from SCADA at the start of the dispatch interval. Covers every unit with SCADA telemetry, including non-scheduled units that appear in no other dispatch table. Subtracting SCADAVALUE from DISPATCH_UNIT_SOLUTION.UIGF gives semi-scheduled curtailment.

# Coverage

|  |  |
|---|---|
| Qualified name | `external_data.nemweb.silver_dispatch_scada_dispatch_unit_scada` |
| Rows | 337,448,786 |
| Date range | 2019-01-01 00:05:00 to 2026-09-02 08:45:00 (by `SETTLEMENTDATE`) |
| Size on disk | 702.4 MB |
| Measured at | `2026-09-02T00:03:03Z` |

**Measured 2026-09-02T00:03:03Z.** Row count, date range and size are a point-in-time observation of the live table, not inferred from config — and they are only as current as that timestamp. For a continuously-loading table the real end of the date range has moved on since; treat `to` as a floor, not a ceiling. A query outside the range returns nothing: an empty window, not an error. If exact currency matters, check the table directly.

# Schema

| Column | Type | Comment |
|---|---|---|
| `PACKAGE` | `string` |  |
| `schema_version` | `int` |  |
| `SETTLEMENTDATE` | `timestamp` | Date and time of the dispatch interval, interval ending (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `DUID` | `string` | Dispatchable unit identifier. |
| `SCADAVALUE` | `decimal(16,6)` | Instantaneous MW reading from SCADA at the start of the dispatch interval. NULL where a unit's telemetry was unavailable. |
| `LASTCHANGED` | `timestamp` | Last date and time the record changed (parsed to timestamp in silver). Timestamp is in AEST or Australia/Brisbane. |
| `SETTLEMENTDATE_UTC` | `timestamp` |  |

# Upstream

Derived from AEMO's **DISPATCH_UNIT_SCADA** (package `DISPATCH`). For AEMO's own column definitions, primary keys and publication notes, see the `aemo-data-model` bundle.

AEMO source: https://nemweb.com.au/Reports/Current/MMSDataModelReport/Electricity/Electricity%20Data%20Model%20Report_files/Elec20.htm#85
