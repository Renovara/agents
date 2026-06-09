# AER Market Agent — open-source Australian energy-market analysis

Turn Australia's annual **Default Market Offer (DMO)** determinations into a clean, shareable PowerPoint in one command.

The DMO is the regulated "safety net" electricity price the [AER](https://www.aer.gov.au) sets each 1 July for NSW, South-East QLD and South Australia. This tool charts seven-plus years of it and breaks down **where your power dollar actually goes** — network, wholesale, environmental and retail costs.

It doubles as a **data oracle**: a searchable catalog of every AER *State of the Energy Market* workbook (2019-2025, all chapters) with a direct AER download URL for each, so you can answer ad-hoc questions and pull any figure on demand.

![what it makes](examples/preview.md)

## Install

```bash
pip install python-pptx matplotlib openpyxl
```

## Use

```bash
# Build from the bundled, AER-verified snapshot
python scripts/build_report.py --out "DMO Report.pptx"

# Or rebuild the data-derived series from the bundled local source files first
python scripts/parse_sources.py
python scripts/build_report.py --out "DMO Report.pptx"
```

Everything is **local and offline** — the AER source files ship in `data/sources/`.

## Ask the data anything (oracle)

```bash
python scripts/query.py domains                  # what's covered
python scripts/query.py search network revenue   # find figures across all years
python scripts/query.py get 2025 "Figure 3.14"   # bundled: reads locally
python scripts/fetch_data.py --all               # pull every AER workbook (Python)
python scripts/query.py get 2023 "Figure 7.2"    # not bundled: auto-downloads from the AER url
```

## What's in the box

| Path | What it is |
|------|------------|
| `data/dmo_dataset.json` | AER-verified reference prices (DMO 1–8) + cost-stack proportions, driver notes, reforms, branding. Edit this to change the report. |
| `scripts/build_report.py` | Builds the deck. Has an `add_custom_analysis()` hook for your own slides. |
| `scripts/parse_sources.py` | Rebuilds the report's data-derived series from local files. |
| `scripts/query.py` | **Oracle** — search & read any figure from the bundled AER dataset. |
| `scripts/fetch_data.py` | **Pulls AER workbooks via Python** into `data/sources/` (no browser). |
| `scripts/build_catalog.py` | Re-indexes `data/sources/` into `data/catalog/catalog.json`. |
| `data/catalog/catalog.json` | Index of 43 workbooks / ~1,000 figures (titles, sheets, **AER url** each). |
| `data/catalog/source_urls.json` | filename -> AER download URL map. |
| `data/sources/` | The report's own source files (other workbooks fetched on demand by url). |
| `SKILL.md` | Lets this run as a Claude skill (Cowork / Claude Code). |

## Fork it

This is meant to be cloned. Swap the `branding` block in `data/dmo_dataset.json`, drop in your own analysis slides, and ship your own version. Pull requests welcome.

## Caveats

Residential flat rate (no controlled load) is the comparable headline series. Small-business figures aren't comparable before/after DMO 4 (benchmark changed 20,000→10,000 kWh). Bundled proportions are the AER's published ranges; exact per-component dollar splits live in the AER cost-assessment models (optional, not shipped — see `DATA_SOURCES.md`).

## License

MIT © 2026 Renovara. Built by [Renovara](https://renovara.co) — we turn AER & AEMO data into decisions.

## Refreshing the data

The report is built from the local files in `data/sources/` — no internet needed. To move to a
newer AER release, drop the newer download into `data/sources/` and re-run
`python scripts/parse_sources.py`. See [`DATA_SOURCES.md`](DATA_SOURCES.md) for which file feeds
which slide and where each one originally came from.
