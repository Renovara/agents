#!/usr/bin/env python3
"""Pull 2026 ISP documents/datasets from AEMO (Python/curl, no browser).

Downloads files listed in data/catalog/catalog.json from their AEMO `url`
into data/sources/<category>/ so scripts/query.py can read them locally.

    python scripts/fetch_data.py --id 2026-isp-chart-data
    python scripts/fetch_data.py --category report            # the ISP + explainer etc.
    python scripts/fetch_data.py --category appendices
    python scripts/fetch_data.py --search "demand traces NSW step change"
    python scripts/fetch_data.py --all --dry-run              # list everything, fetch nothing
    python scripts/fetch_data.py --id 2026-isp-model --force  # re-download

Heads-up on sizes: trace zips and the ISP model run to 80-150 MB each. Prefer
--id over --all; --all will pull several GB.

Network notes (commands may need to run OUTSIDE a sandbox):
  * Claude Code / your local machine: works out of the box.
  * Claude Cowork: the sandbox egress allow-list blocks aemo.com.au by default.
    Team/Enterprise org owners can allow it: Organization settings > Capabilities >
    Code execution > "package managers and specific domains" -> add `aemo.com.au`
    and `www.aemo.com.au`. Applies to NEW sessions only. Otherwise run the same
    command on your own machine and drop the files into data/sources/.
  * API code-execution skills: no network -> bundle the files instead.

Two different 403s, two different causes (this script tells them apart):
  - "blocked-by-allowlist / tunnel connection failed" -> sandbox egress allow-list.
  - HTTP 403 from the server (Akamai)                 -> AEMO's WAF is blocking the
        runtime's datacenter IP. Run on your own machine and read files locally.

Built and maintained by Renovara - renovara.co
"""
from __future__ import annotations
import argparse, json, shutil, subprocess, sys, urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / "data" / "catalog" / "catalog.json"
UA = "isp-2026-agent/1.0 (+https://renovara.co)"


def load():
    if not CATALOG.exists():
        sys.exit(f"catalog not found at {CATALOG} (run scripts/build_catalog.py)")
    return json.loads(CATALOG.read_text())["documents"]


def select(docs, args):
    out = []
    for d in docs:
        if args.id and d["id"] not in args.id:
            continue
        if args.category and d["category"] not in args.category:
            continue
        if args.search:
            hay = " ".join([d["title"], d["id"], d["category"], d["type"], d.get("notes", "")]).lower()
            if not all(t.lower() in hay for t in args.search.split()):
                continue
        out.append(d)
    return out


def download(url, dest, timeout):
    """Return (ok, how, detail). curl first (follows AEMO redirects), urllib fallback."""
    dest.parent.mkdir(parents=True, exist_ok=True)
    if shutil.which("curl"):
        r = subprocess.run(
            ["curl", "-fSL", "--show-error", "--retry", "2", "--retry-delay", "1",
             "-A", UA, "--max-time", str(timeout), "-o", str(dest), url],
            capture_output=True, text=True)
        if r.returncode == 0 and dest.exists() and dest.stat().st_size > 0:
            return True, "curl", dest.stat().st_size
        probe = subprocess.run(
            ["curl", "-sS", "-v", "-o", "/dev/null", "--max-time", str(min(timeout, 30)), url],
            capture_output=True, text=True)
        detail = (r.stderr + "\n" + probe.stderr).strip() or f"curl exit {r.returncode}"
        return False, "curl", detail
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
    if ("blocked-by-allowlist" in d or "x-proxy-error" in d or "from proxy after connect" in d
            or "could not resolve" in d or "connection refused" in d or "tunnel connection failed" in d):
        return "egress"
    if "akamai" in d or "403" in d or "forbidden" in d:
        return "waf"
    return "other"


def main():
    ap = argparse.ArgumentParser(description="Pull 2026 ISP files from AEMO.",
                                 formatter_class=argparse.RawDescriptionHelpFormatter, epilog=__doc__)
    ap.add_argument("--all", action="store_true", help="select every document (several GB!)")
    ap.add_argument("--id", action="append", help="catalog id (repeatable)")
    ap.add_argument("--category", action="append", help="filter by category (repeatable)")
    ap.add_argument("--search", help="space-separated terms matched against title/id/notes")
    ap.add_argument("--dry-run", action="store_true", help="list selection, download nothing")
    ap.add_argument("--force", action="store_true", help="re-download even if file exists")
    ap.add_argument("--timeout", type=int, default=600)
    args = ap.parse_args()

    if not (args.all or args.id or args.category or args.search):
        ap.error("choose what to fetch: --all, or --id / --category / --search")

    docs = load()
    sel = docs if args.all else select(docs, args)
    if not sel:
        sys.exit("nothing matched your selection.")

    print(f"Selected {len(sel)} document(s):")
    done = skipped = failed = 0
    causes = set()
    for d in sel:
        dest = ROOT / d["file"]
        if dest.exists() and not args.force:
            print(f"  = exists  {d['file']}")
            skipped += 1
            continue
        if args.dry_run:
            print(f"  > would fetch  [{d['category']}] {d['id']}  ({d.get('size', '?')})")
            continue
        ok, how, detail = download(d["url"], dest, args.timeout)
        if ok:
            print(f"  + {detail/1e6:8.2f} MB  ({how})  {d['file']}")
            done += 1
        else:
            print(f"  ! FAILED ({how})  {d['id']}\n      {detail}")
            failed += 1
            causes.add(classify(detail))

    if args.dry_run:
        print(f"\nDry run: {len(sel)} selected, {skipped} already present.")
        return
    print(f"\nDone. downloaded {done}, skipped {skipped}, failed {failed}.")
    if "egress" in causes:
        print("\nThe sandbox egress allow-list blocked the request (it never reached AEMO).")
        print("  Run this command on your own machine / Claude Code, or (Cowork Team/Enterprise)")
        print("  add `aemo.com.au` + `www.aemo.com.au` under Organization settings > Capabilities >")
        print("  Code execution, then start a NEW session. Downloaded files go in data/sources/.")
    if "waf" in causes:
        print("\nReached AEMO but its WAF returned 403 (blocking this runtime's datacenter IP).")
        print("  Run the same command on your own machine, then let the skill read data/sources/.")


if __name__ == "__main__":
    main()
