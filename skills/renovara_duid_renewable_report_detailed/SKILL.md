---
name: renovara-duid-renewable-report-detailed
description: NEM renewable energy (wind/solar) dispatch unit performance reporter. TRIGGERS: "Give me the generator overview and performance summary for BODWF1.", "What was HDWF1's energy output and revenue for March 2026", "Show me the market context (price and demand) for the NSW1 region over the past month.", "What's the capacity factor by hour of day for BERYLSF1, including p10 and p90 bands", "Which hours of the day generate the most revenue per MW installed for MUWAWF1", "What is BODWF1's total gross revenue and revenue per MW nameplate by hour for the last quarter", Dispatch Case Solution, Dispatch Interconnection, Dispatch Interconnectorres, Dispatch Price, Dispatch Regionsum, Nem Participant And Scheduled Loads, Dispatch Unit Solution, Predispatch Interconnector Soln, Predispatch Region Prices, Predispatch Region Solution
---

# Renovara DUID Renewable Report Detailed

## Overview

NEM renewable energy (wind/solar) dispatch unit performance reporter.

# Renewable Generator Performance Report (for LLM use)

## Required Inputs

* **DUID:** semi-scheduled renewable unit, e.g., BODWF1, HDWF1, LGAPV1
* **Start Date / End Date** (AEST)

## Global Rules

* **Always run the named example query exactly as provided.** Do not regenerate or modify SQL.
* **Timestamps:** AEST (Australia/Brisbane, UTC+10). **Power:** MW. **Energy:** MWh.
* **Renewable generators only** (wind/solar) — do not apply thermal assumptions.
* **INTERVENTION handling** is pre-applied in queries: prices from `INTERVENTION = 0`, power/energy from max INTERVENTION per interval.

---

## Report 1: Generator Overview & Market Context

Run the three sub-reports in order. Present 1a and 1b as tables.

### 1a — Generator Overview
Query: `report_1a_generator_overview.sql` → table of registration details (station, region, capacity, fuel type).

### 1b — Performance Summary
Query: `report_1b_performance_summary.sql` → aggregated energy, revenue, dispatch stats over the period.

### 1c — Market Context Scatter Chart
Query: `report_1c_market_context_scatter.sql` → scatter chart:

* **X-axis:** `hour_of_day` (0-23)
* **Left Y:** `avg_rrp` ($/MWh)
* **Right Y:** `avg_total_demand` (MW)
* **Series/colour:** one per `date`

**CRITICAL:** Use `HOUR(SETTLEMENTDATE)` and `DATE(SETTLEMENTDATE)` — do NOT use `DATE_TRUNC`.

---

## Report 2: Capacity Factor by Hour of Day

Query: `report_2_capacity_factor_by_hour.sql`

Capacity factor = `TOTALCLEARED / REG_CAP_GENERATION_MW × 100%`, computed per 5-minute interval and aggregated by hour of day across all dates in the period.

Line chart:

* **X-axis:** `hour_of_day` (0-23)
* **Y-axis:** Capacity factor (%)
* **Solid line:** `avg_capacity_factor_pct` (mean)
* **Dashed line:** `p90_capacity_factor_pct` (good conditions — 90th percentile)
* **Dashed line:** `p10_capacity_factor_pct` (poor conditions — 10th percentile)

The p10-p90 band shows the typical performance spread per hour — useful for understanding solar peak hours, wind variability, etc.

---

## Report 3: Revenue per MW Nameplate by Hour of Day

Query: `report_3_revenue_per_mw_by_hour.sql`

For each hour of day, sum revenue (`TOTALCLEARED × RRP × (5/60)`) across all dates in the period, then divide by `REG_CAP_GENERATION_MW`. This shows cumulative $/MW-nameplate earned at each hour over the whole period — useful for comparing which hours are most valuable for this generator.

Line chart:

* **X-axis:** `hour_of_day` (0-23)
* **Y-axis:** `total_revenue_per_mw_nameplate` ($ per MW installed, summed over period)

The `total_gross_revenue` column contains the generator's total revenue ($) over the period — report this value in the summary.

---

## General Skill Conventions

These conventions are used in two contexts. Apply whichever matches:

- **Databricks (Genie space):** Refer to the tables attached to this Genie Space for schema. Execute SQL **directly against the warehouse** — do not use MCP tools. Ignore references below to `references/knowledge/*.yaml`, `references/schema-index.md`, or `references/examples/`.
- **Skill (outside Databricks):** Refer to the bundled YAML files under `references/knowledge/` for schema. Execute SQL via the MCP tools listed under "How to query".

The bundled YAML knowledge files under `references/knowledge/` are the source of truth for table selection, column names, business meaning, and `display_name`. The schema entry point is [`references/schema-index.md`](references/schema-index.md). Fall back to live `DESCRIBE TABLE` only when a query errors, the table is live-only, or the bundled references do not cover the object.

### Workflow

1. **Classify the request** — region, unit, interconnector, constraint, etc.
2. **Load only the relevant reference** from `references/knowledge/`.
3. **Write the first query from the bundled schema** using fully qualified Unity Catalog names such as `external_data.nemweb.silver_dispatchis_reports_dispatch_price`.
4. **Match identifier casing exactly.** If a query fails with an unresolved column or type error, run `DESCRIBE TABLE external_data.nemweb.<table>` and correct it. Trust the live table for physical type, trust the YAML for purpose and `display_name`.
5. **Execute the query.** In **Databricks (Genie)** run it directly against the warehouse. In **Skill** context use the MCP tool (see "How to query"); if a long-running statement returns `pending`, poll for completion using the statement ID.
6. **Answer with analysis, not raw rows.** State the time basis as AEST.

### Query Rules

- Default to read-only SQL.
- Fully qualified Unity Catalog names: `catalog.schema.table`.
- Prefer `references/knowledge/*.yaml` before live schema inspection.
- Use `display_name` from the YAML when referring to a table in prose.
- Match identifier casing exactly in `WHERE` clauses — Databricks SQL is case-sensitive.
- Regional IDs: `NSW1`, `QLD1`, `VIC1`, `SA1`, `TAS1`.

### Time Handling

- Treat user-facing results as AEST.
- Convert relative dates using `Australia/Brisbane`.
- `SETTLEMENTDATE` is already aligned to AEST — do not shift it again. `SETTLEMENTDATE_UTC` exists if UTC is explicitly required.
- AEST "now": `from_utc_timestamp(current_timestamp(), 'Australia/Brisbane')`.
- AEST "today": `date(from_utc_timestamp(current_timestamp(), 'Australia/Brisbane'))`.

### Power And Energy Rules

- `TOTALCLEARED`, `TOTALDEMAND`, `AVAILABILITY` are power in MW. `AVAILABILITY` is dispatch-cycle available capacity, not rated capacity.
- Interval-based power summaries: use `AVG(...)`.
- Convert 5-minute MW to MWh with `MW / 12.0` before summing.
- Be explicit in the answer about whether a metric is average MW, interval MWh, or total MWh.

### Access Tiers

The Renovara platform distinguishes two tiers: **Free** (last 7 days) and **Pro** (full history). Several silver tables have `_free` variants that enforce the 7-day window. For free-tier behaviour, prefer the `_free` table or constrain the query to the last 7 days; otherwise use the full historical silver table.

### Response Style

- British/Australian English.
- Professional and concise; state assumptions when the request is ambiguous.
- Report results in AEST.
- When preparing a chart in code, add brief comments that explain the chart type, the transformation applied, and why both fit the data.

## Reference Files

- [`references/schema-index.md`](references/schema-index.md): entry point and file selection guide.
- `references/knowledge/*.yaml`: per-table schema knowledge (table_name, display_name, table_comment, primary keys, indexes, typed column list with comments).
- `references/examples/*.sql`: worked example queries:
  - `report_1a_generator_overview.sql` — Report 1a: Generator Overview
  - `report_1b_performance_summary.sql` — Report 1b: Performance Summary
  - `report_1c_market_context_scatter_chart.sql` — Report 1c: Market Context Scatter Chart
  - `report_2_capacity_factor_by_hour_of_day.sql` — Report 2: Capacity Factor by Hour of Day
  - `report_3_revenue_per_mw_installed_by_hour_of_day.sql` — Report 3: Revenue per MW Installed by Hour of Day

## Example Triggers

- "Give me the generator overview and performance summary for BODWF1."
- "What was HDWF1's energy output and revenue for March 2026?"
- "Show me the market context (price and demand) for the NSW1 region over the past month."
- "What's the capacity factor by hour of day for BERYLSF1, including p10 and p90 bands?"
- "Which hours of the day generate the most revenue per MW installed for MUWAWF1?"
- "What is BODWF1's total gross revenue and revenue per MW nameplate by hour for the last quarter?"

## Data Source

Data originates from NEMWEB, published by AEMO:
https://www.aemo.com.au/energy-systems/electricity/national-electricity-market-nem/data-nem/market-data-nemweb

## How to query

This skill executes SQL through an MCP server connection. It does not use
the `databricks` CLI — there is no `databricks auth login` step. Once the
host AI platform has the required MCP connection configured and the user
has authenticated to it, the following tools must be available:

- `renovara-mcp`

Typical flow:

1. Draft the SQL using the schema in `references/knowledge/` and the
   examples in `references/examples/`.
2. Call the read-only execute tool with the statement.
3. If the response carries a `statement_id` rather than rows, poll the
   result tool until the statement completes.

If the MCP tools listed above are not available in the current
environment, surface that to the user — they need to connect and
authenticate the MCP server before queries can run. Until then this skill
can still return schema guidance and SQL drafts.

Pass `warehouse_id=013c82a1b401ca7e` to the MCP tool if the server requires it (some configurations infer it).

Tables in this skill live in the catalog/schema implied by their fully
qualified `identifier` (e.g. `external_data.nemweb.silver_...`).
