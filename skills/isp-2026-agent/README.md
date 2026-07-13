# isp-2026-agent

A Claude skill that turns AEMO's **2026 Integrated System Plan** (published
25 June 2026) into a queryable data oracle: ~170 cataloged documents and
datasets with direct AEMO URLs, fetch-on-demand, and workbook/zip readers.

Ask it things like:

- What does the optimal development path build by 2035 and 2050?
- Which transmission projects are actionable, and at what cost?
- What did AEMO assume for build costs, fuel prices and demand growth?
- Show me NSW half-hourly demand under Step Change, POE50.

## Layout

```
SKILL.md                    instructions + starter questions + verification discipline
scripts/build_catalog.py    regenerates the catalog (URL inventory lives here)
scripts/fetch_data.py       downloads files from aemo.com.au (curl/urllib)
scripts/query.py            search / info / sheets / get / zip / pages
data/catalog/catalog.json   the source of truth (~170 entries)
data/sources/<category>/    downloaded files land here (empty at ship)
```

## Network

Downloads need egress to `aemo.com.au`. In sandboxed runtimes (e.g. Claude
Cowork's default allow-list) fetches are blocked — run the printed
`fetch_data.py` command on your own machine and drop files into
`data/sources/`, or allow the domain in org settings. Claude Code on a normal
machine works out of the box. Details in `SKILL.md` and `fetch_data.py --help`.

## Sibling

`aer-market-agent` — same architecture over AER State of the Energy Market
data, plus a DMO report deck builder.

---
Built and maintained by **Renovara** — renovara.co · MIT licence
