# Renovara Agents

This repository packages a collection of Renovara skills as standalone, distributable bundles for AI assistants that need to analyse Australian National Electricity Market (NEM) data from Databricks.

It is designed for teams that want reusable, domain-aware market-analysis skills rather than repeatedly rewriting prompts, SQL, schema lookups, and charting instructions for common NEM tasks.

## Why use this repo

Each skill in this repo helps an AI assistant move from generic SQL generation to domain-aware NEM analysis. They give the model a structured workflow, bundled schema knowledge, and table-selection guidance so it can answer questions faster and with fewer avoidable mistakes.

Typical use cases include:

- analysing regional price behaviour and volatility
- comparing NEM regions across time
- investigating constraints, interconnector behaviour, and dispatch outcomes
- profiling individual dispatch units (DUIDs), including renewables
- reviewing FCAS market participation and outcomes
- producing chart-ready datasets for reports and presentations

Common features across the skills:

- schema guidance for the relevant NEM tables under `external_data.nemweb`
- clear routing from business question to the right schema reference file
- Databricks SQL workflow guidance, including when to fall back to live schema inspection
- NEM-specific handling for time, region IDs, interval data, and power-versus-energy calculations
- support for both analysis responses and visualisation-oriented outputs

## Available skills

Each skill is published as a self-contained zip under [Releases](../../releases).

- `renovara_ai_nem_analyst` — general NEM market analyst
- `renovara_duid_report_detailed` — dispatch unit performance reporting
- `renovara_duid_renewable_report_detailed` — renewable (wind/solar) dispatch unit performance
- `renovara_duid_constraint_analysis` — forced vs economic curtailment analysis for semi-scheduled renewables
- `renovara_fcas_analyst` — FCAS market participation and outcomes

## Requirements

Most skills here require access to the Renovara Databricks SQL MCP server to execute queries against the live NEM data catalog.

In particular, the skills expect the host AI platform to expose tools equivalent to:

- `mcp__renovara-sql__execute_sql_read_only`
- `mcp__renovara-sql__execute_sql`
- `mcp__renovara-sql__poll_sql_result`

Without that MCP integration, the skills can still provide table-selection guidance and SQL drafts, but they will not be able to execute queries against the live NEM data catalog.

## Quick start

1. Download the zip for the skill you want from [Releases](../../releases).
2. Unzip it into the skill directory used by your AI platform (for Claude Code: `~/.claude/skills/<skill-name>/`).
3. Configure access to the Renovara Databricks SQL MCP server so the platform can execute read-only and polling SQL tools.
4. Load the skill and test it with a simple question, e.g.:
   `Show average NSW1 RRP by hour for the last 7 days.`
5. Confirm the assistant can:
   - open `references/schema-index.md`
   - select the relevant YAML schema
   - execute a Databricks SQL query through the MCP server
   - return a chart-ready result

## Layout

Each skill bundle, once unzipped, has the structure:

- `<skill-name>/SKILL.md` — core skill instructions and metadata (YAML frontmatter + markdown body)
- `<skill-name>/references/schema-index.md` — entry point for table selection
- `<skill-name>/references/knowledge/*.yaml` — per-table schema knowledge (columns, types, comments, primary keys, indexes)
- `<skill-name>/references/examples/*.sql` — worked example queries
- `<skill-name>/references/snippets.md` — reusable joins, filters, expressions, and measures (when applicable)

## Source and packaging

The skills in this repo are generated from Genie space definitions in a separate (private) Databricks pipeline repository. Bundles are built with a renderer that converts each Genie space into a self-contained skill directory and zips it for distribution here.

This repo is intended to make the skills easy to:

- browse and reference on GitHub
- download as zip releases
- install or copy into AI skill directories on supported platforms
- share with other users who want ready-made NEM analysis capabilities
