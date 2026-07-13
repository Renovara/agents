---
name: isp-2026-agent
description: "Analyse AEMO's 2026 Integrated System Plan (published 25 June 2026): optimal development path, scenarios (Step Change, Accelerated Transition, Slower Growth), generation & storage outlook, transmission/REZ projects, IASR inputs & assumptions, demand/solar/wind traces, gas projections. Data oracle over the full 2026 ISP document and dataset catalog. Triggers: ISP, Integrated System Plan, AEMO, ODP, IASR, REZ, demand traces, NEM transition roadmap."
license: MIT
---

# ISP 2026 Agent

A **data oracle** for AEMO's **2026 Integrated System Plan** — the roadmap for the
National Electricity Market's transition to 2050, published 25 June 2026. It
catalogs every 2026 ISP document and dataset (~170 items: the ISP report and
appendices A1–A10, the generation & storage outlook, the PLEXOS model, the
IASR and its reference studies, network/gas options reports, and the full
demand/solar/wind trace library) with direct AEMO download URLs, and gives you
scripts to search the catalog, fetch files on demand, and read workbook data
straight from the source.

Unlike its sibling `aer-market-agent`, this skill does **not** build a deck —
it answers questions.

## Quick start

```bash
pip install openpyxl
python scripts/query.py categories              # what's covered
python scripts/query.py search chart data       # find a document
python scripts/query.py sheets 2026-isp-chart-data
python scripts/query.py get 2026-isp-chart-data "Figure 3" --max-rows 40
```

The skill ships **catalog-only** (no bundled data). Files download on demand
from aemo.com.au — see *Getting the data* for network rules.

## Starter questions (offer these when the user has no specific question)

When invoked without a concrete question, present these to get the user going:

1. **The headline:** "What does the 2026 ISP's optimal development path say we
   need to build — wind, solar, storage and firming — by 2035 and 2050?"
2. **Scenarios:** "What are the three 2026 ISP scenarios and how were they
   weighted? What happens under Slower Growth vs Step Change?"
3. **Transmission:** "Which transmission projects are actionable in the 2026
   ISP, and what did Appendix A5 cost them at?"
4. **Demand:** "How much is NEM electricity demand forecast to grow, and what's
   driving it — data centres, electrification, EVs?"
5. **Inputs:** "What build costs, fuel prices and discount rates did AEMO
   assume? (IASR workbook + Aurecon/ACIL Allen/GHD reference studies)"
6. **REZs:** "Which renewable energy zones does the plan lean on hardest, and
   what do the REZ boundary changes mean?"
7. **Draft vs final:** "What changed between the Draft 2026 ISP (Dec 2025) and
   the final (June 2026)?"

## Instructions for Claude (when running this skill)

**Answering a data question (oracle mode).**

1. `python scripts/query.py search <terms>` to locate the right document(s).
   `categories` gives the map; `pages` lists AEMO's methodology/consultation pages.
2. For **workbooks** (xlsx/xlsm): `sheets <id>` then `get <id> "<sheet>"` — it
   auto-downloads if missing. Start with `2026-isp-chart-data` (the data behind
   every chart in the ISP report) — it answers most headline questions fastest.
3. For **zips** (generation & storage outlook, traces, model): `zip <id>` to
   list contents, `zip <id> --extract "*.csv"` to pull members, then read the
   extracted files with pandas/python.
4. For **PDFs** (report, appendices, IASR): `fetch_data.py --id <id>` then read
   the PDF directly.
5. **Cite precisely**: document + table/sheet/page, e.g. "2026 ISP, Appendix A5,
   Table 7" or "2026 ISP chart data workbook, sheet 'Figure 12'".
6. If a download fails, the scripts diagnose why (sandbox egress vs AEMO WAF)
   and print what to tell the user — see *Getting the data*. Don't guess when
   the data is one query away; and don't silently substitute 2024 ISP numbers.

**Verification discipline.**

- **Scenario first.** Every ISP number is conditional on a scenario (Step
  Change / Accelerated Transition / Slower Growth) and often on a CDP. Never
  quote a capacity, cost or date without naming the scenario; the ODP is the
  cost-weighted choice across scenarios, not "the forecast".
- **ODP ≠ prediction.** The optimal development path is a least-cost,
  least-regret plan under stated policies — present it as such.
- **Draft ≠ final.** The Draft 2026 ISP (10 Dec 2025) is superseded; use it
  only for explicit draft-vs-final comparison, and label it.
- **State the dollar basis** (real vs nominal, base year) for any cost, and
  the POE (10/50) for any demand figure.
- **No claim without a source.** Cite the specific document and table; if the
  ISP doesn't answer it, say so rather than back-filling from priors.

## Getting the data (Python, no browser)

The skill stays tiny by bundling only the catalog; files are pulled on demand
with `scripts/fetch_data.py` / `scripts/query.py` (curl/urllib, no browser).
This needs network egress to `aemo.com.au`:

- **Claude Code / local machine** — works out of the box.
- **Claude Cowork** — the sandbox allow-list blocks aemo.com.au by default, so
  fetch commands must run **outside the sandbox**: either run the printed
  command on your own machine and drop files into `data/sources/`, or
  (Team/Enterprise) have an org owner add `aemo.com.au` + `www.aemo.com.au`
  under *Organization settings > Capabilities > Code execution* (new sessions
  only).
- **API code-execution skills** — no network; bundle the files you need.

A `403 blocked-by-allowlist` is the sandbox egress list, not a bug; a plain
HTTP 403 from Akamai is AEMO's WAF blocking datacenter IPs — run the fetch on
your own machine. Both scripts print this guidance when it happens.

Mind the sizes: the ISP model is 127 MB, wind traces 152 MB, the generation &
storage outlook 80 MB. Fetch by `--id`, not `--all`.

## Catalog map

| category | what's in it |
|---|---|
| `report` | 2026 ISP, explainer, infographic, webinar deck, timetable |
| `appendices` | A1–A10 (REZs, network investments, CBA, system security, gas...) |
| `supporting-materials` | **chart data workbook**, generation & storage outlook, inputs & assumptions workbook, REZ GIS, consultation summary |
| `isp-model` | PLEXOS model + instructions, bulk solar/wind/timeslice traces |
| `demand-traces-regional` | 5 regions x 3 scenarios x POE10/50, half-hourly, 23 ref years |
| `demand-traces-subregional` | 15 sub-regions x 3 scenarios |
| `vre-traces` | solar/wind traces r2011–r2025, firm contribution factors |
| `iasr` | 2025 IASR report + workbook + addendum, EV workbook, scenario weighting |
| `iasr-reference` | Aurecon/GHD/CSIRO/ACIL Allen/Oxford Economics input studies |
| `network-options` | 2025 Electricity Network Options Report, transmission cost estimates |
| `gas` | Gas Infrastructure Options Report, GHD gas cost databases |
| `draft` | Draft 2026 ISP (superseded — comparison only) |

`data/catalog/catalog.json` is the source of truth; regenerate with
`scripts/build_catalog.py` when AEMO updates files. Trace datasets use
extensionless vanity URLs (`aemo.com.au/2026-06-ISP-Demand-Traces/...`) that
redirect to zips — fetch_data.py follows the redirect.

## Not covered

- The Transmission Cost Database v3.1 itself (AEMO request form only — see
  `network-options` notes and the `transmission-cost-database` page).
- Draft-stage data files and stakeholder submissions (linked from the
  `draft-2026-isp-consultation` page in `query.py pages`).
- Anything post-dating the catalog `generated` date — check the 2026 ISP page
  for newer revisions.

---
Built and maintained by **Renovara** — National Electricity Market analytics. renovara.co
