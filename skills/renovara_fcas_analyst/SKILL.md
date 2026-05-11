---
name: renovara-fcas-analyst
description: TRIGGERS: Dispatch Price, Nem Participant And Scheduled Loads, Dispatch Unit Solution
---

# Renovara FCAS Analyst

## Overview

Use this skill to query and analyse the Renovara FCAS Analyst dataset.

# ⚙️ **Renovara: FCAS Revenue per MW Instructions Set (v2, Dec 2025)**

### **Purpose**

Analyse **FCAS revenue** across all 10 FCAS markets in the NEM over the past **48 months**, using AEMO 5-minute dispatch data.

---

## 🧩 **1. Data Sources**

Pull data from the following Databricks tables:

| Dataset                            | Table                                             | Key Columns                                                                                                                                                                                        |
| ---------------------------------- | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **FCAS Prices**                    | `silver_dispatchis_reports_dispatch_price`        | `SETTLEMENTDATE`, `REGIONID`, `RAISE1SECRRP`, `RAISE6SECRRP`, `RAISE60SECRRP`, `RAISE5MINRRP`, `RAISEREGRRP`, `LOWER1SECRRP`, `LOWER6SECRRP`, `LOWER60SECRRP`, `LOWER5MINRRP`, `LOWERREGRRP`       |
| **FCAS Enablement & Availability** | `silver_next_day_dispatch_dispatch_unit_solution` | `SETTLEMENTDATE`, `DUID`, `RAISE1SEC`, `RAISE6SEC`, `RAISE60SEC`, `RAISE5MIN`, `RAISEREG`, `LOWER1SEC`, `LOWER6SEC`, `LOWER60SEC`, `LOWER5MIN`, `LOWERREG`, plus their `ACTUALAVAILABILITY` fields |

---

## 🕓 **2. Time Frame**

* **Window:** Last 48 months from `CURRENT_DATE()` or user defined
* **Interval:** 5-minute dispatch
* **Aggregation:** Monthly
* **Timezone:** All results reported in **AEST** (no conversion required)

---

Here is the **corrected and fully aligned version**, using **average available MW** as per the revised methodology.
All formulas are rewritten so they render cleanly in VS Code Markdown + MathJax.

---

## 💡 **3. Core Calculation**

### **Per–unit, per–service, per–interval revenue**

For every service (s), unit (i), and interval (t):

$$
\text{Revenue}_{i,s,t}
    = \text{Price}_{s,t}
      \times \text{EnabledMW}_{i,s,t}
      \times \frac{5}{60}
$$

---

### **Monthly aggregates**

#### **1. Total monthly revenue per service**

$$
\text{TotalRevenue}_{s,m}
    = \sum_{t \in m} \sum_i \text{Revenue}_{i,s,t}
$$

#### **2. Average available MW per service per month**

$$
\text{AvgAvailableMW}_{s,m}
    = 
    \frac{\sum_{t \in m} \text{AvailableMW}_{s,t}}
         {N_{m}}
$$

Where (N_m) is the number of 5-minute intervals in month (m).

---

### **3. Final metric: Revenue per MW per month**

$$
\text{RevenuePerMW}_{s,m}
    = \frac{\text{TotalRevenue}_{s,m}}
           {\text{AvgAvailableMW}_{s,m}}
$$

---

## 📊 **4. Analysis**

### **Market-Level Revenue per MW**

**Goal:** Monthly FCAS revenue per MW by service for the entire NEM.

#### SQL Summary

| month | service | total_revenue | total_available_mw | revenue_per_mw |

#### FCAS Services (10 total)

```
RAISE1SEC, RAISE6SEC, RAISE60SEC, RAISE5MIN, RAISEREG,
LOWER1SEC, LOWER6SEC, LOWER60SEC, LOWER5MIN, LOWERREG
```

---

## 🧠 **5. Deliverables**

1. **Chart 1:** FCAS revenue per MW by service (market-level). Stacked bar chart.

<!-- 5. **Annotations:** Vertical line at **June 2025 (FPP rule change)** -->
1. **Interpretation summary:**

   * Market-level and group-level trend comments
   * % change in average revenue per MW between first and last 12 months

---

## 🧮 **6. Visualisation Standards**

**Chart 1 – Market Level**

* X = Month (AEST)
* Y = Revenue per MW (AUD/MW/month)
* Bar colour = FCAS Service
* Bar = stacked
* Annotate June 2025

---

## 📂 **7. Notes & Best Practices**

* **Units:** MW for power, MWh for energy (via 5/60 conversion).
* Handle zero or null denominators with `NULLIF(..., 0)`.
* Treat missing 1-second service data before 2024 as 0 or NULL.
* All timestamps correspond to the **end** of each 5-minute interval.

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
  - `provide_analysis_for_monthly_fcas_revenue_per_mw_for_each_of.sql` — Provide analysis for monthly FCAS revenue per MW for each of the 10 services in the NEM over the past 48 months.

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
