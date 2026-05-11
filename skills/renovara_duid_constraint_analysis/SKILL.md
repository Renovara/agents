---
name: renovara-duid-constraint-analysis
description: Network constraint and curtailment analysis for semi-scheduled NEM renewable generators (wind/solar). Quantifies forced vs economic curtailment, identifies time-of-day patterns, and attributes capped intervals to specific binding constraints with descriptive context from GENCONDATA. TRIGGERS: "How much was BODWF1 curtailed in March 2026, and what was the foregone revenue", "Show me the curtailment by hour of day for MUWAWF1 over the last quarter.", "Which network constraints are most often binding when CROWLWF1 gets capped", "Was ARWF1 mostly affected by network constraints or FCAS service constraints last month", "Show me the daily curtailment timeline for BULGANA1 in March 2026 — were there specific event days", "What share of HUGSF1's total available energy was lost to forced curtailment this year", Nem Participant And Scheduled Loads, Dispatch Unit Solution, Dispatch Price, Dispatch Constraint, Gencondata, Genconset, Spdcpc, Spdrc, Participant Registration Dudetailsummary
---

# Renovara DUID Constraint Analysis

## Overview

Network constraint and curtailment analysis for semi-scheduled NEM renewable generators (wind/solar). Quantifies forced vs economic curtailment, identifies time-of-day patterns, and attributes capped intervals to specific binding constraints with descriptive context from GENCONDATA.

# Renewable Generator Constraint & Curtailment Analysis (for LLM use)

## Required Inputs

* **DUID:** semi-scheduled renewable unit, e.g., BODWF1, HDWF1, LGAPV1
* **Start Date / End Date** (AEST)

## Global Rules

* **Always run the named example query exactly as provided.** Do not regenerate or modify SQL.
* **Timestamps:** AEST (Australia/Brisbane, UTC+10). **Power:** MW. **Energy:** MWh.
* **Renewable generators only** (wind/solar) — relies on `UIGF` and `SEMIDISPATCHCAP` which are populated for semi-scheduled units.
* **INTERVENTION handling** is pre-applied: prices/constraints from `INTERVENTION = 0`, power from max INTERVENTION per interval.
* **Curtailment cause buckets:**
  * **Forced curtailment** = AEMO actively capped the unit (`SEMIDISPATCHCAP = 1`) — caused by network/system constraints. This is the actionable one for asset owners (storage, network upgrades, MLF advocacy).
  * **Economic curtailment** = unit voluntarily backed off when `RRP ≤ 0` and `SEMIDISPATCHCAP = 0` — market-driven, not constraint-driven.
  * Offer-based curtailment (`SEMIDISPATCHCAP = 0`, `RRP > 0`, but cleared < UIGF) is not counted in either bucket — it reflects the unit's own bid behaviour.

---

## Report 1: Curtailment Summary

Query: `report_1_curtailment_summary.sql` → single-row table summarising the period.

Headline metrics: total/capped/curtailed interval counts, forced vs economic MWh and %, available MWh, foregone revenue from forced caps (only counted when RRP > 0), and worst single-interval cap MW.

Present as a key-value table. Lead the summary with `forced_curtailed_mwh` and `forced_foregone_revenue_aud` — those are the numbers an asset owner cares about.

---

## Report 2: Curtailment by Hour of Day

Query: `report_2_curtailment_by_hour.sql`

Bar/line chart:

* **X-axis:** `hour_of_day` (0-23)
* **Y-axis:** MW
* **Series 1:** `avg_forced_curtailment_mw` (AEMO caps)
* **Series 2:** `avg_economic_curtailment_mw` (negative-price backoff)

Reveals the time-of-day pattern. Forced curtailment clustered midday for solar suggests a tight network at peak generation (storage / upgrade case). Forced curtailment overnight for wind suggests voltage / system strength limits.

---

## Report 3: Top Binding Constraints During Caps

Query: `report_3_top_binding_constraints.sql` → table.

Lists the constraint equations that were binding (`MARGINALVALUE > 0`) during this DUID's capped intervals, with **causal attribution** via the SPD constraint factor tables and descriptive context from GENCONDATA.

Columns:
* `attribution_type` — strength of link to this DUID (see below)
* `constraint_id` — AEMO constraint ID (e.g. `N>>NIL_75`)
* `description` — what the constraint is doing (from GENCONDATA)
* `reason` — trigger condition (e.g. "Trip of Wellington to Mt Piper line")
* `limit_type` — Thermal / Voltage / Stability / FCAS
* `impact` — affected generation/region group (e.g. "NSW Generation")
* `intervals_binding_during_cap` — count
* `pct_of_duid_caps` — % of this DUID's capped intervals where this constraint was binding
* `avg_marginal_value_aud` — shadow price ($ tightness indicator)

**Attribution types** (sorted from most to least specific):

1. **`Direct (CP)`** — the constraint has a non-zero factor on this DUID's connection point in `SPDCONNECTIONPOINTCONSTRAINT`. This is **causal**: the constraint formulation explicitly names this unit. These are the rows the asset owner can act on (storage, repowering, MLF advocacy, network upgrades).
2. **`Region (NSW1/etc)`** — the constraint has a non-zero factor on the DUID's region aggregate in `SPDREGIONCONSTRAINT`. The constraint targets a peer group the unit belongs to (e.g. "all NSW semi-scheduled generation ≤ X MW"). Indirect but meaningful.
3. **`System (associative)`** — the constraint was binding while this DUID was capped, but it does not target the unit's connection point or region. Most often these are FCAS service procurement constraints (`F_*`) where co-optimisation between energy and FCAS markets caused the cap. Read the description to interpret.

**How to interpret for the asset owner:**
* If most rows are `Direct (CP)` or `Region` — your caps are network-driven; engage with the TNSP / NSP about constraint formulation and upgrades.
* If most rows are `System (associative)` and primarily `F_*` IDs — your caps are FCAS-driven (co-optimisation chose to back off your energy to free FCAS capacity elsewhere). Different remediation: check FCAS market participation, look at battery hybrid options.

---

## Report 4: Daily Curtailment Timeline

Query: `report_4_daily_curtailment_timeline.sql`

Bar chart:

* **X-axis:** `date`
* **Y-axis:** MWh
* **Series 1:** `daily_forced_curtailed_mwh`
* **Series 2:** `daily_economic_curtailed_mwh`

Useful for spotting specific events — outages, weather, equipment trips — that drove unusual curtailment on a given day. Cross-reference with Report 3 to investigate the constraints binding on those days.

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
  - `report_1_curtailment_summary.sql` — Report 1: Curtailment Summary
  - `report_2_curtailment_by_hour_of_day.sql` — Report 2: Curtailment by Hour of Day
  - `report_3_top_binding_constraints_during_caps.sql` — Report 3: Top Binding Constraints During Caps
  - `report_4_daily_curtailment_timeline.sql` — Report 4: Daily Curtailment Timeline

## Example Triggers

- "How much was BODWF1 curtailed in March 2026, and what was the foregone revenue?"
- "Show me the curtailment by hour of day for MUWAWF1 over the last quarter."
- "Which network constraints are most often binding when CROWLWF1 gets capped?"
- "Was ARWF1 mostly affected by network constraints or FCAS service constraints last month?"
- "Show me the daily curtailment timeline for BULGANA1 in March 2026 — were there specific event days?"
- "What share of HUGSF1's total available energy was lost to forced curtailment this year?"

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
