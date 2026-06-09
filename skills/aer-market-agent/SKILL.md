---
name: aer-market-agent
description: "Analyse Australia's electricity Default Market Offer (DMO) and answer questions from AER State of the Energy Market data 2019-2025 (networks, wholesale/NEM, retail, gas). Builds a DMO report deck."
license: MIT
---

# AER Market Agent

Generates a branded PowerPoint deck that decomposes Australia's **Default Market Offer** — the regulated electricity price safety net for NSW, South-East QLD and South Australia — across every determination from DMO 1 (2019-20) to the latest.

The deck tells one story: **where your power dollar goes**, and how the network / wholesale / environmental / retail split has moved over time.

It is also a **data oracle**: it bundles every AER *State of the Energy Market* data workbook (2019-2025, all chapters) plus a searchable catalog, so you can answer ad-hoc questions and run analysis directly from the source data — not just build the deck.

## Quick start

```bash
pip install python-pptx matplotlib openpyxl
python scripts/build_report.py --out "DMO Report.pptx"
```

That builds the full deck from the bundled, AER-verified data snapshot in `data/dmo_dataset.json` — no downloads needed.

## Use it as a data oracle (answer questions / analyze)

`data/catalog/catalog.json` indexes **every AER State of the Energy Market workbook, 2019-2025,
all chapters** (electricity networks, National Electricity Market / wholesale, retail, gas markets,
gas pipelines, market overview / transition) — 43 workbooks, ~1,000 figures & tables. Each entry
carries a direct AER **download `url`** plus a local `file` path. To keep the skill small, only the
report's own source files are bundled; `scripts/query.py` reads a figure from the local file if
present, otherwise it downloads the workbook from its AER url on demand. Use it to find and read any of it:

```bash
python scripts/query.py domains                       # what's covered (domains x years x #figures)
python scripts/query.py search network revenue        # find figures by keyword across all years
python scripts/query.py search wholesale price --year 2025
python scripts/query.py get 2025 "Figure 3.14"        # read a figure's data (RAB) on demand
python scripts/query.py get 2025 "Figure 3.11" --max-rows 0   # full series, all rows
python scripts/query.py list --domain networks        # list the workbooks in a domain
```

`get` prints the figure's data block as CSV — nothing is pre-extracted, so you always read the
authoritative source. Only the report's own source files are bundled; for any other workbook,
**pull it from the AER with Python** first:

```bash
python scripts/fetch_data.py --all                 # every workbook (2019-2025, all chapters)
python scripts/fetch_data.py --year 2025 --domain wholesale-nem
python scripts/query.py get 2025 "Figure 2.18"     # then read it (Generation output, by fuel)
```

`query.py get` also auto-downloads a missing workbook from its catalog `url`. Both need the runtime
to be allowed to reach `aer.gov.au` — see **Getting the data** below.

## Getting the data (Python, no browser)

The skill stays small by bundling only the report's source files; everything else is pulled from the
AER on demand with `scripts/fetch_data.py` / `scripts/query.py` (plain `urllib`, no browser). This
needs the runtime's network egress to allow `aer.gov.au`:

- **Claude Code / local machine** — works out of the box (your normal network). Just run
  `python scripts/fetch_data.py --all`.
- **Claude Cowork (Team/Enterprise)** — an org owner allows the runtime to reach AER:
  *Organization settings > Capabilities > Code execution* > **"package managers and specific
  domains"** > add `aer.gov.au`. Network changes apply to **new** sessions only.
- **API code-execution skills** — have no network; bundle the workbooks instead of fetching.

If a download is blocked you'll see a `403 / Tunnel connection failed` — that's the egress
allow-list, not a bug. `query.py` and `fetch_data.py` print the same guidance.

## Refresh from the bundled local files

Everything the report needs is **local** — the source files live in `data/sources/` and nothing
here goes online. The pipeline is:

```
data/sources/*  ->  scripts/parse_sources.py  ->  data/dmo_dataset.json  ->  scripts/build_report.py
```

To rebuild the data-derived series (network long view, grid usage per customer, cost-reflective
tariffs, average & peak demand, reference prices) straight from the bundled files:

```bash
python scripts/parse_sources.py --check   # parse + verify against current dataset (no write)
python scripts/parse_sources.py           # parse + write data/dmo_dataset.json
python scripts/build_report.py --out "DMO Report.pptx"
```

`DATA_SOURCES.md` lists exactly which bundled file feeds which slide, and how to swap in a newer
AER release (drop the newer download into `data/sources/`, re-run `parse_sources.py`).

## Make it yours (fork this)

- **Numbers & text:** edit `data/dmo_dataset.json` (prices, driver notes, reforms, the basics).
- **Your own slides:** add them in the clearly-marked `add_custom_analysis(prs, data)` function in `scripts/build_report.py`.
- **Branding:** change the `branding` block in the dataset (org name, tagline, URL, colours).

## Instructions for Claude (when running this skill)

**Answering a data question (oracle mode).** If the user asks a question about the energy market
rather than asking for the deck: run `python scripts/query.py search <terms>` to locate the right
figure(s), then `python scripts/query.py get <year> "<Figure X.Y>"` to read the numbers (it reads the bundled
file, else downloads from the AER url via Python). If a workbook isn't present, run
`python scripts/fetch_data.py --year <Y> --domain <D>` first. If the download is blocked, it's the
runtime egress allow-list — tell the user to allow `aer.gov.au` (see *Getting the data*) or run in Claude Code. Cite the figure id, year and report (e.g. "AER State of the Energy Market 2025, Fig 3.14").
Apply the verification discipline below. Don't guess when the data is one query away.

**Building the report.**

1. By default, build from the bundled snapshot — it's already derived from the local files in `data/sources/`, no internet needed. To regenerate the data-derived series from those files, run `python scripts/parse_sources.py` (see `DATA_SOURCES.md` for what feeds what). Only point the user at a download if they want a *newer* AER year than the one bundled.
2. Install the three pip deps if missing.
3. Run `build_report.py` to produce the `.pptx`.
4. Present the resulting file to the user. Offer to add a custom-analysis slide.
5. Apply the verification discipline below - never name a cost driver without a magnitude and a source, and never back-fill a residual with narrative.

## Data, sources & caveats

- Source: AER final determinations, 2019-20 to present (aer.gov.au).
- Headline series is the **residential flat rate (no controlled load)** — the only apples-to-apples series across all years.
- The small-business benchmark changed from 20,000 to 10,000 kWh at DMO 4, so it is **not** comparable across that break.
- The bundled cost-stack proportions are the AER's **published ranges**. Exact per-component dollar splits live inside the AER cost-assessment Excel models, which are optional and not shipped — see *Not bundled* in `DATA_SOURCES.md`.

---
Built and maintained by **Renovara** — National Electricity Market analytics. renovara.co

## Verification discipline (read before refreshing)

This report is a *data-grounded correction* of a popular but unverified narrative — "renewables transition -> transmission build-out -> higher network bills". The AER's own data shows the opposite: in real terms network costs peaked ~2015 and have fallen; the recent *nominal* rises are inflation plus a rate-of-return bounce. To keep the report honest when you refresh or extend it:

- **No cost driver without a magnitude and a source.** Never attribute an increase to "renewables", "the transition" or "transmission" unless you can cite a figure and where it came from.
- **Label residuals as residuals.** If the data explains part of a change (e.g. "46% is inflation + interest rates"), state the rest as an unexplained residual - do not back-fill it with a plausible story.
- **Do not pattern-match to the popular narrative.** Derive conclusions from the AER determinations and State of the Energy Market data, not from what "sounds right".
- **Separate forward-looking from realized**, and the transmission layer (~4-11% of a bill) from distribution.
- **State the dollar basis.** Network revenue rose in nominal resets but fell in real terms from its 2015 peak - both are true; say which you mean.

---
Built and maintained by **Renovara** - renovara.co
