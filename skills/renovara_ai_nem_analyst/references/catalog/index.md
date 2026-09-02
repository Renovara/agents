---
okf_version: '0.2'
---

# Renovara NEM catalogue

What `external_data.nemweb` actually holds — measured from the live catalogue, not inferred from config.

**All row counts, date ranges and sizes in this bundle were measured 2026-09-02T00:03:03Z.** They are a point-in-time observation, not a live reading. Continuously-loading tables have moved on since: treat a date range's end as a floor. Query the table directly when exact currency matters.

* [coverage.md](coverage.md) - what Renovara holds against what AEMO publishes, and what is missing.
* [tables](tables/index.md) - every loaded table, with its real row count and date range.

For AEMO's own definition of any upstream table, follow the `aemo_table` field in a table concept into the `aemo-data-model` bundle.
