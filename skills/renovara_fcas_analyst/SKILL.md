---
name: renovara-fcas-analyst
description: TRIGGERS: dispatchis reports dispatch price, nem participant and scheduled loads, next day dispatch dispatch unit solution
---

# Renovara FCAS Analyst

## Overview

Use this skill to query and analyse the Renovara FCAS Analyst dataset.

Prefer the schemas in `references/knowledge/` for table selection, column
names, and business meaning. Fall back to live `DESCRIBE TABLE` only when
a query errors, the table is live-only, or the bundled references do not
cover the object.

## Workflow

1. Classify the request. Decide the grain first: region, unit,
   interconnector, constraint, daily MLF, registration metadata, etc.
2. Load only the relevant reference. Start at
   [`references/schema-index.md`](references/schema-index.md), then open
   the matching YAML files under `references/knowledge/`.
3. Write the first query from the bundled schema. Use fully qualified
   Unity Catalog names such as
   `external_data.nemweb.silver_dispatchis_reports_dispatch_price`. Do
   not start with `DESCRIBE TABLE` when the YAML already covers the
   table.
4. Match identifier casing exactly, especially in string filters. Use
   the YAML as the default source of truth for intended schema and
   business meaning. If a query fails with an unresolved column,
   missing object, or type error, inspect the live table with
   `DESCRIBE TABLE external_data.nemweb.<table>` and correct the query.
   If the bundled YAML and the live table disagree, trust Databricks
   for physical type and column list, and trust the YAML for table
   purpose, `display_name`, and business meaning.
5. Execute and iterate (see "How to query"). Run the query; if a
   long-running statement returns `pending`, poll for completion using
   the statement ID.
6. Answer with analysis, not raw rows. State the time basis as AEST.
   Explain aggregation choices, especially when converting power to
   energy. If a chart is useful, provide chart-ready output and briefly
   justify the chart type.

## Query Rules

- Default to read-only SQL.
- Always use fully qualified Unity Catalog names: `catalog.schema.table`.
- Prefer the table and column definitions in `references/knowledge/*.yaml`
  before doing live schema inspection.
- Use `display_name` from the YAML when referring to a table in prose.
- Match identifier casing exactly in `WHERE` clauses — column and string
  comparisons in Databricks SQL are case-sensitive.
- Relevant regional IDs are `NSW1`, `QLD1`, `VIC1`, `SA1`, and `TAS1`.

## Time Handling

- Treat user-facing results as AEST.
- Convert relative "today", "last 7 days", and similar filters using
  `Australia/Brisbane`.
- `SETTLEMENTDATE` in NEM datasets is already aligned to AEST market
  time. Do not shift it again.
- Some silver tables also expose `SETTLEMENTDATE_UTC`; use it only when
  UTC is explicitly required.
- A safe AEST "now" expression:

```sql
from_utc_timestamp(current_timestamp(), 'Australia/Brisbane')
```

- A safe AEST "today" expression:

```sql
date(from_utc_timestamp(current_timestamp(), 'Australia/Brisbane'))
```

## Power And Energy Rules

- `TOTALCLEARED`, `TOTALDEMAND`, `AVAILABILITY`, and similar fields are
  power in MW. `AVAILABILITY` refers to dispatch-cycle available
  capacity, not rated capacity.
- For interval-based power summaries, use `AVG(...)`.
- Convert 5-minute MW observations to MWh with `MW / 12.0` before
  summing.
- Be explicit in the answer about whether a metric is average MW,
  interval MWh, or total MWh.

## Access Tiers

The Renovara platform distinguishes two access tiers:

- **Free** — limited to the previous 7 days.
- **Pro** — full historical access.

Several silver tables have `_free` variants that enforce the 7-day
window. If the user asks for free-tier behaviour, prefer the `_free`
table or constrain the query to the last 7 days. Otherwise use the full
historical silver table.

## Response Style

- Use British/Australian English.
- Keep explanations professional and concise.
- State assumptions when the request is ambiguous.
- When preparing a chart in code, add brief comments that explain the
  chart type, the transformation applied, and why both fit the data.

## Reference Files

- [`references/schema-index.md`](references/schema-index.md): entry point and file selection guide.
- `references/knowledge/*.yaml`: per-table schema knowledge (table_name, display_name, table_comment, primary keys, indexes, typed column list with comments).
- `references/examples/*.sql`: worked example queries:
  - `provide_analysis_for_monthly_fcas_revenue_per_mw_for_each_of.sql` — Provide analysis for monthly FCAS revenue per MW for each of the 10 services in the NEM over the past 48 months.

## Data Source

Data originates from NEMWEB, published by AEMO:
https://www.aemo.com.au/energy-systems/electricity/national-electricity-market-nem/data-nem/market-data-nemweb

## How to query

This skill describes a Databricks SQL warehouse dataset. To execute a query:

1. **Authenticate** (one-time, opens a browser):
   ```bash
   databricks auth login --host <your-databricks-host>
   ```
2. **Find your warehouse ID**:
   ```bash
   databricks warehouses list
   ```
3. **Run a query** via the SQL Statement Execution API:
   ```bash
   databricks api post /api/2.0/sql/statements --json '{
     "statement": "SELECT ...",
     "warehouse_id": "<warehouse_id>",
     "wait_timeout": "50s"
   }'
   ```

Quote strings inside the JSON `statement` value carefully — single quotes
inside SQL must be escaped for the surrounding shell quoting (`'\''`).

Default warehouse for this dataset: `013c82a1b401ca7e`.

Tables in this skill live in the catalog/schema implied by their fully
qualified `identifier` (e.g. `external_data.nemweb.silver_...`).
