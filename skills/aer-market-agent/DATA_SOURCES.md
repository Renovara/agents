# Data sources — everything is local

This skill is **self-contained and offline**. Every source file is bundled under `data/sources/`,
and nothing in the build or query pipeline touches the internet.

It serves two jobs:

1. **Build the report** — a curated, verified snapshot (`data/dmo_dataset.json`) drives the deck.
2. **Answer questions / analyze** — the full AER dataset is bundled and indexed so you can read any
   figure on demand (see *The data oracle* below).

---

## The report pipeline

```
data/sources/*  ->  scripts/parse_sources.py  ->  data/dmo_dataset.json  ->  scripts/build_report.py
```

`data/dmo_dataset.json` is a verified snapshot, so the deck builds with **no parsing step at all**.
Run `parse_sources.py` only to rebuild the data-derived series from the bundled files.

| File the report reads | Feeds | What it is |
|------|-------|-----------|
| `data/sources/2025/…Chapter 3 - Electricity networks.xlsx` | network long view (revenue), grid usage/customer, cost-reflective tariffs | AER *State of the Energy Market 2025*, Ch 3 |
| `data/sources/demand/AER-NEM-annual-consumption.csv` | average demand (TWh / 8.76 -> GW) | AER *Demand & energy* — annual consumption, NEM |
| `data/sources/demand/AER-NEM-seasonal-peak.csv` | peak demand (higher of summer/winter -> GW) | AER *Demand & energy* — seasonal peak, NEM |
| `data/sources/demand/AER-regional-seasonal-peak.csv` | reference / regional detail | AER *Demand & energy* — seasonal peak, regions |
| `data/sources/dmo-reference-prices-2019-2027.csv` | residential reference prices, DMO 1-8 | Compiled from AER DMO final determinations |

```bash
python scripts/parse_sources.py --check   # parse + compare to current dataset (no write)
python scripts/parse_sources.py           # parse + write data/dmo_dataset.json
python scripts/build_report.py --out "DMO Report.pptx"
```

Everything else in `dmo_dataset.json` (cost-stack proportions, worked example, building-block
summary, narrative copy) is curated and verified by hand and is **not** overwritten by the parser.

---

## The data oracle — the full AER dataset, by URL

`data/catalog/catalog.json` indexes **every AER State of the Energy Market workbook, 2019-2025,
all chapters**: electricity networks, National Electricity Market (wholesale), retail energy
markets, gas markets, gas pipelines, and market-overview / transition — 43 workbooks, ~1,000
figures & tables. For each workbook it stores year, domain, chapter, the sheet list, every
figure/table title (+ source line), a local `file` path, and a direct AER **download `url`**
(`data/catalog/source_urls.json` holds the filename -> url map).

To keep the skill small (the raw workbooks are ~95 MB; skills are capped at 30 MB), only the
report's own source files are bundled under `data/sources/`. Everything else is fetched on demand
from its `url`. Query it with `scripts/query.py`:

```bash
python scripts/query.py domains                    # coverage: domains x years x #figures
python scripts/query.py search network revenue     # find figures by keyword (all years)
python scripts/query.py get 2025 "Figure 3.14"     # read a bundled figure (-> CSV)
python scripts/query.py get 2023 "Figure 7.2"      # not bundled -> downloads from the AER url
python scripts/query.py list --domain wholesale-nem
```

Pull workbooks from the AER with Python (no browser):

```bash
python scripts/fetch_data.py --all                 # every workbook, 2019-2025
python scripts/fetch_data.py --year 2025 --domain wholesale-nem
```

`query.py get` also auto-downloads a missing workbook from its catalog `url`. Both use plain
`urllib` and need the runtime's egress to allow `aer.gov.au`:
- **Claude Code / local** — works out of the box.
- **Cowork (Team/Enterprise)** — allow `aer.gov.au` in *Organization settings > Capabilities >
  Code execution* ("package managers and specific domains"); applies to new sessions.
- **API code-execution skills** — no network; bundle the files instead.

A blocked download shows `403 / Tunnel connection failed` (the egress allow-list, not a bug).
Rebuild the index with:

```bash
python scripts/build_catalog.py                    # reads local files or downloads from source_urls.json
```

Domains: `networks`, `wholesale-nem`, `retail`, `gas-markets`, `gas-pipelines`, `transition`, `overview`.

---

## Provenance & refreshing to a newer year

All files are public AER/ABS data (no login, no API key). To move to a newer release, drop the
newer download into `data/sources/<year>/` (or `data/sources/demand/`) and re-run the relevant
script. Where they came from:

- State of the Energy Market (data workbooks): https://www.aer.gov.au/publications/reports/performance/state-energy-market-2025
- Demand & energy charts (annual consumption, seasonal peak): https://www.aer.gov.au/industry/registers/charts
- DMO determinations (reference prices): https://www.aer.gov.au/industry/registers/resources/reviews/default-market-offer-2026-27
- Inflation (real vs nominal): ABS Consumer Price Index, June-quarter index — `cpi_index` in the dataset.

> AER chart pages render their tables in-browser, so each has a **"Download CSV"** button — that
> download is the CSV you'd drop into `data/sources/demand/`. Only needed to pull a *newer* year.

## Not bundled (optional, advanced)

The report uses the AER's **published cost-stack ranges** and a verified building-block summary, so
these primary models are **not required** and are not shipped:

- **DMO cost-assessment models** (`.xlsx`, one per determination) — exact wholesale / network /
  environmental / retail dollars inside each DMO.
- **Network revenue determination Post-Tax Revenue Models** (`.xlsx`, one per network) — exact
  year-by-year building blocks. From https://www.aer.gov.au/industry/registers/determinations
