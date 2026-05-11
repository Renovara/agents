---
name: renovara-duid-report-detailed
description: Welcome to the NEM dispatch unit reporter. TRIGGERS: Dispatch Case Solution, Dispatch Interconnection, Dispatch Interconnectorres, Dispatch Price, Dispatch Regionsum, Nem Participant And Scheduled Loads, Dispatch Unit Solution, Predispatch Interconnector Soln, Predispatch Region Prices, Predispatch Region Solution
---

# Renovara DUID Report Detailed

## Overview

Welcome to the NEM dispatch unit reporter.

# Generator Performance Report Instructions (for LLM use)

## Required Inputs

* **DUID:** e.g., ERARING1, MURRAY1, SNOWY1
* **Report Period:** Start Date and End Date (AEST)

---

## Report 1: Market Context Overview

**Data Sources:** `DISPATCH_PRICE`, `DISPATCH_REGIONSUM`, `DISPATCH_INTERCONNECTION`

**Tasks:**

1. Analyse regional market context for the DUID.
2. Join on REGIONID which is available from `nem_participant_and_scheduled_loads` to ensure correct RRP.
3. Produce - Report 1.1 Generator Overview
4. Produce - Report 1.2 Performance Summary
5. Plot **Scatter chart** of **RRP (left-hand y-axis) & Total Demand (MW) (right-hand y-axis)** by hour-of-day (x-axis) and date.

## Report 2: Capacity and Availability Analysis

**Data Sources:** `DISPATCH_UNIT_SOLUTION`, `nem_participant_and_scheduled_loads`

**Metrics:**

1. **Average Availability (%):**
   
Let $N_{\text{intervals}}$ be the number of dispatch intervals in the period.

$$
\text{AverageAvailability}
    = \frac{\sum \text{AVAILABILITY}}{\text{REG\_CAP\_GENERATION\_MW} \times N_{\text{intervals}}} \times 100\%
$$

**Output:** Dual-axis line chart (interval on x-axis; 5-minute, or hourly if >17 days)

* Left y-axis: Availability (%) per interval.
* Right y-axis: RRP ($/MWh) per interval.

---

## Report 3: Dispatch Performance vs Market Prices interval

**Objective:** Show whether the DUID’s hourly dispatch aligns with market price peaks.

**Steps:**

1. Average TOTALCLEARED and RRP to 5-minute intervals or hourly if more than 17 days requested.
2. Join on REGIONID which is available from `nem_participant_and_scheduled_loads` to ensure correct RRP.
3. Plot:

   * Average RRP ($/MWh) – left axis.
   * Average DUID Output (MW) – right axis.
   * X-axis: time interval — index 1–288 for 5-minute data, or hour-of-day 0–23 for hourly.

**Output:** Line chart (RRP vs Output).

---

## Report 4: Target Tracking

**Objective:** Compare INITIALMW vs TOTALCLEARED and highlight variance.

**Steps:**

1. Aggregate INITIALMW and TOTALCLEARED to 5-minute intervals (hourly if >17 days).
2. Compute % Variance = (TOTALCLEARED - INITIALMW) / INITIALMW × 100.
3. Align time axis with the same interval granularity.

**Output:** Dual-axis line chart

* Left axis: INITIALMW (MW) and TOTALCLEARED (MW) as two lines.
* Right axis: % Variance line (above/below 0%).
* X-axis: Interval timestamp (5-minute or hourly).

**Performance Metrics:**

* Target Tracking Accuracy (% within ±X MW of target)
* Average Deviation from Target (MW)
* High-Price Missed Target Events (price > SRMC and actual < target)

---

## Report 5: Earnings per Megawatt by Hour of Day

**Objective:** Evaluate earning efficiency by hour.

**Steps:**

1. Calculate Revenue = DISPATCHED_MW × RRP × (5/60).
2. Compute Earnings per MW = Revenue / DISPATCHED_MW.
3. Aggregate hourly averages, 90th percentile, and 10th percentile.

**Output:** Line chart showing:

* Solid line: Average earnings per MW ($/MWh).
* Dashed lines: 90th and 10th percentiles.

---

## Report 6: Regional RRP Profile by Hour of Day

**Objective:** Show hourly RRP patterns for the DUID’s region.

**Steps:**

1. Identify REGIONID from `nem_participant_and_scheduled_loads`.
2. Retrieve RRP for the period.
3. Choose interval granularity:

   * ≤17 days: use 5-minute intervals.
   * > 17 days: use hourly averages per date.

**Output:** Line chart – Hour (x-axis), RRP ($/MWh) (y-axis), each date as a series.

---

## Report 7: Critical Price Events (Automated)

**Objective:** Identify and summarise high and low RRP events and DUID response.

**Detection Rules:**

* High Price: RRP > $300/MWh.
* Negative Price: RRP < $0/MWh.

**Process:**

1. Extract RRP, DISPATCHED_MW, and AVAILABILITY from relevant tables.
2. Rank top 10 events by |RRP|.
3. Classify event type and response (online/offline).

**Output Table:**

| Price ($/MWh)                            | Date | Time | Availability (MW) | Dispatch (MW) | Event Type | Observation |
| ---------------------------------------- | ---- | ---- | ----------------- | ------------- | ---------- | ----------- |
| Example data to be dynamically generated |      |      |                   |               |            |             |

**Auto-Summary:**

* Count of High-Price Missed Opportunities.
* Count of Negative Price Avoidance Events.
* Brief summary of responsiveness.

---

## Insights & Commentary

**Goal:** Generate short analytical commentary.

* Summarise generator performance, availability, and responsiveness.
* Highlight operational drivers and constraints.
* Comment on earnings and strategy effectiveness.

---

## Output Rules

* All timestamps in **AEST**.
* Power in **MW**, Energy in **MWh**.
* Data from **AEMO NEMWeb** dispatch and registration datasets.

**Interval Rule (Databricks Genie 5,000‑row limit):**

* If the report period is **≤17 days**, use **5‑minute intervals**.
* If the report period is **>17 days**, use **hourly averages** per date.

---

## Required Inputs Before Execution

1. **DUID**
2. **Start Date** and **End Date**

Once confirmed, query Databricks SQL, retrieve data, and produce charts + analysis.
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
  - `report_1_market_context_overview.sql` — Report 1: Market Context Overview
  - `report_2_capacity_and_availability_analysis_comparison_of_ge.sql` — Report 2: Capacity and Availability Analysis: Comparison of generator availability with market energy prices.
  - `report_3_dispatch_performance_vs_market_prices_interval.sql` — Report 3: Dispatch Performance vs Market Prices interval:
  - `report_4_target_tracking.sql` — Report 4: Target Tracking
  - `report_5_earnings_per_megawatt_by_hour_of_day.sql` — Report 5: Earnings per Megawatt by Hour of Day
  - `report_6_regional_rrp_profile_by_hour_of_day.sql` — Report 6: Regional RRP Profile by Hour of Day
  - `report_7_critical_price_events_automated.sql` — Report 7: Critical Price Events (Automated)
  - `report_11_generator_overview.sql` — Report 1.1 Generator Overview
  - `report_12_performance_summary.sql` — Report 1.2 Performance Summary

## Data Source

Data originates from NEMWEB, published by AEMO:
https://www.aemo.com.au/energy-systems/electricity/national-electricity-market-nem/data-nem/market-data-nemweb

## How to query

This skill executes SQL through an MCP server connection. It does not use
the `databricks` CLI — there is no `databricks auth login` step. Once the
host AI platform has the required MCP connection configured and the user
has authenticated to it, the following tools must be available:

- `mcp__renovara-sql__execute_sql_read_only`
- `mcp__renovara-sql__execute_sql`
- `mcp__renovara-sql__poll_sql_result`

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
