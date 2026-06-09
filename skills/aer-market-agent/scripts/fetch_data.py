#!/usr/bin/env python3
"""Pull AER State of the Energy Market workbooks from the AER (Python, no browser).

Downloads the raw workbooks listed in data/catalog/catalog.json from their AER
`url` into data/sources/<year>/ so the oracle (scripts/query.py) and the report
(scripts/parse_sources.py) can read them locally.

It downloads with `curl` (the same client that serves these files from a normal
machine), falling back to urllib if curl is unavailable.

    python scripts/fetch_data.py --all                 # every workbook (2019-2025, all chapters)
    python scripts/fetch_data.py --domain networks     # one domain, all years
    python scripts/fetch_data.py --year 2025           # one year, all domains
    python scripts/fetch_data.py --year 2025 --domain wholesale-nem
    python scripts/fetch_data.py --all --dry-run       # show what would download, fetch nothing
    python scripts/fetch_data.py --all --force         # re-download even if present

Network notes:
  * Claude Code / local machine: works out of the box (your normal network).
  * Claude Cowork (Team/Enterprise): an org owner must allow the runtime to reach
    AER -> Organization settings > Capabilities > Code execution >
    "package managers and specific domains" -> add `aer.gov.au` (and
    `www.aer.gov.au`). Network changes apply to NEW sessions only.
  * API code-execution skills: no network at all -> bundle the files instead.

Two different 403s, two different causes (this script tells them apart):
  - "Tunnel connection failed / could not resolve"  -> egress allow-list (add the domain above).
  - HTTP 403 from the server (Akamai)               -> the AER's bot/WAF layer is blocking the
        runtime's datacenter IP. Not fixable from here without evading bot detection. Run this
        on your own machine / Claude Code (where it serves fine) and read the files locally.

Built and maintained by Renovara - renovara.co
"""
from __future__ import annotations
import argparse, json, shutil, subprocess, sys, urllib.request, urllib.error
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / "data" / "catalog" / "catalog.json"
UA = "aer-market-agent/1.0 (+https://renovara.co)"


def load():
    if not CATALOG.exists():
        sys.exit(f"catalog not found at {CATALOG} (run scripts/build_catalog.py)")
    return json.loads(CATALOG.read_text())["workbooks"]


def select(wbs, args):
    out = []
    for w in wbs:
        if args.year and w["year"] not in args.year:
            continue
        if args.domain and w["domain"] not in args.domain:
            continue
        if args.file and not any(f.lower() in w["file"].lower() for f in args.file):
            continue
        out.append(w)
    return out


def download(url, dest, timeout):
    """Return (ok, how, detail). Tries curl first, then urllib."""
    dest.parent.mkdir(parents=True, exist_ok=True)
    if shutil.which("curl"):
        r = subprocess.run(
            ["curl", "-fSL", "--show-error", "--retry", "2", "--retry-delay", "1",
             "--max-time", str(timeout), "-o", str(dest), url],
            capture_output=True, text=True)
        if r.returncode == 0 and dest.exists() and dest.stat().st_size > 0:
            return True, "curl", dest.stat().st_size
        # failed: run a verbose probe so we can see WHY (proxy header vs server 403)
        probe = subprocess.run(
            ["curl", "-sS", "-v", "-o", "/dev/null", "--max-time", str(min(timeout, 30)), url],
            capture_output=True, text=True)
        detail = (r.stderr + "\n" + probe.stderr).strip() or f"curl exit {r.returncode}"
        return False, "curl", detail
    # fallback: urllib
    try:
        req = urllib.request.Request(url, headers={"User-Agent": UA})
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            data = resp.read()
        dest.write_bytes(data)
        return True, "urllib", len(data)
    except Exception as e:  # noqa
        return False, "urllib", str(e)


def classify(detail: str) -> str:
    d = detail.lower()
    # egress proxy signals: the request never reached AER (proxy refused the CONNECT)
    if ("blocked-by-allowlist" in d or "x-proxy-error" in d or "from proxy after connect" in d
            or "could not resolve" in d or "connection refused" in d or "tunnel connection failed" in d):
        return "egress"
    # tunnel established but AER's bot/WAF (Akamai) returned 403
    if "akamai" in d or "akamaighost" in d:
        return "akamai"
    if "403" in d or "forbidden" in d:
        return "akamai"
    return "other"


def main():
    ap = argparse.ArgumentParser(description="Pull AER workbooks via curl/Python.",
                                 formatter_class=argparse.RawDescriptionHelpFormatter, epilog=__doc__)
    ap.add_argument("--all", action="store_true", help="select every workbook")
    ap.add_argument("--year", type=int, action="append", help="filter by year (repeatable)")
    ap.add_argument("--domain", action="append", help="filter by domain (repeatable)")
    ap.add_argument("--file", action="append", help="filter by filename substring (repeatable)")
    ap.add_argument("--dry-run", action="store_true", help="list selection, download nothing")
    ap.add_argument("--force", action="store_true", help="re-download even if file exists")
    ap.add_argument("--timeout", type=int, default=120)
    args = ap.parse_args()

    if not (args.all or args.year or args.domain or args.file):
        ap.error("choose what to fetch: --all, or --year / --domain / --file")

    wbs = load()
    sel = wbs if args.all else select(wbs, args)
    if not sel:
        sys.exit("nothing matched your selection.")

    print(f"Selected {len(sel)} workbook(s):")
    done = skipped = failed = 0
    causes = set()
    for w in sel:
        dest = ROOT / w["file"]
        if dest.exists() and not args.force:
            print(f"  = exists  {w['file']}")
            skipped += 1
            continue
        if args.dry_run:
            print(f"  > would fetch  {w['year']} {w['domain']:13} <- {w['url']}")
            continue
        ok, how, detail = download(w["url"], dest, args.timeout)
        if ok:
            print(f"  + {detail/1e6:6.2f} MB  ({how})  {w['file']}")
            done += 1
        else:
            print(f"  ! FAILED ({how})  {w['file']}\n      {detail}")
            failed += 1
            causes.add(classify(detail))

    if args.dry_run:
        print(f"\nDry run: {len(sel)} selected, {skipped} already present.")
        return
    print(f"\nDone. downloaded {done}, skipped {skipped}, failed {failed}.")
    if "egress" in causes:
        print("\nEgress allow-list blocked the request (it never reached AER):")
        print("  Cowork (Team/Enterprise): add `aer.gov.au` and `www.aer.gov.au` in Organization")
        print("  settings > Capabilities > Code execution, then start a NEW session.")
    if "akamai" in causes:
        print("\nReached AER but got HTTP 403 from its bot/WAF (Akamai) layer — it is blocking this")
        print("  runtime's datacenter IP. This is not fixable from here without evading bot detection.")
        print("  Run this on your own machine / Claude Code (where the same URL serves fine) and let")
        print("  the skill read the files from data/sources/.")


if __name__ == "__main__":
    main()
