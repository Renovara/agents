#!/usr/bin/env python3
"""Regenerate data/catalog/catalog.json for the isp-2026-agent skill.

The catalog is the skill's single source of truth: every 2026 ISP document and
dataset published by AEMO, with its direct download `url` and the local `file`
path where fetch_data.py will store it. Entries were verified against
aemo.com.au on 2026-07-10 (final 2026 ISP published 25 June 2026).

Run this only when AEMO publishes new/updated files and you want to refresh
the catalog. Otherwise the shipped catalog.json is authoritative.

Built and maintained by Renovara - renovara.co
"""
from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "data" / "catalog" / "catalog.json"

M = "https://www.aemo.com.au/-/media/files"


def slug(title: str) -> str:
    s = "".join(c if c.isalnum() else "-" for c in title.lower())
    while "--" in s:
        s = s.replace("--", "-")
    return s.strip("-")


def entry(category, title, url, ftype, date, size=None, notes=None, eid=None):
    fname = url.split("?")[0].rsplit("/", 1)[-1]
    if "." not in fname:  # extensionless vanity URL (trace datasets)
        fname = slug(title) + ".zip"
    e = {
        "id": eid or slug(title),
        "category": category,
        "title": title,
        "url": url,
        "type": ftype,
        "date": date,
        "file": f"data/sources/{category}/{fname}",
    }
    if size:
        e["size"] = size
    if notes:
        e["notes"] = notes
    return e


E = []

# ---------------------------------------------------------------- report ----
E += [
    entry("report", "2026 Integrated System Plan (ISP)",
          f"{M}/major-publications/isp/2026/2026-integrated-system-plan-isp.pdf?rev=f2f142d0a8d740a986f186da17bb8a9d&sc_lang=en",
          "pdf", "2026-06-25", "6.93 MB",
          "The final 2026 ISP: optimal development path (ODP), key findings, actionable transmission projects, scenario outcomes."),
    entry("report", "2026 Integrated System Plan - Explainer",
          f"{M}/major-publications/isp/2026/aemo-2026-isp-explainer.pdf?rev=a1aa113a81194508a1aced90d26b1dd9&sc_lang=en",
          "pdf", "2026-06-25", "1.57 MB"),
    entry("report", "2026 Integrated System Plan - Infographic",
          f"{M}/major-publications/isp/2026/2026-integrated-system-plan-infographic.pdf?rev=6568e9e8a4f34f5cb5f28a702d7fb453&sc_lang=en",
          "pdf", "2026-06-25", "5.96 MB"),
    entry("report", "2026 ISP Publication Webinar Presentation",
          f"{M}/major-publications/isp/2026/2026-isp-publication-webinar-presentation.pdf?rev=c28503d5b36e49ff821ba8a01a9a5502&sc_lang=en",
          "pdf", "2026-07-07", "2.26 MB"),
    entry("report", "2026 ISP Timetable",
          f"{M}/major-publications/isp/2026/2026-isp-timetable.pdf?rev=dd922dccb4b34164ba620057d7f19bb0&sc_lang=en",
          "pdf", "2025-10-23", "1.05 MB"),
]

# ------------------------------------------------------------ appendices ----
APPX = [
    ("Appendix A1 Stakeholder Engagement", "a1-stakeholder-engagement", "fb67d2dee69042f3885d5f8a649267d6", "1.95 MB", None),
    ("Appendix A2 ISP Development Opportunities", "a2-isp-development-opportunities", "d81062e7cdcf4af8a04fbccdfc3c9fb4", "4.83 MB",
     "Generation, storage and firming development opportunities under the ODP."),
    ("Appendix A3 Renewable Energy Zones", "a3-renewable-energy-zones", "6bb2ea22f0244c04a87cf3b2139be152", "14.77 MB",
     "REZ capacities, boundaries and development."),
    ("Appendix A4 System Operability", "a4-system-operability", "bdf7b0d6a2f94c07a6b05938ad94a518", "3.38 MB", None),
    ("Appendix A5 Network Investments", "a5-network-investments", "a351f6c817484d79bc34f9a8e817f077", "3.05 MB",
     "Actionable and future ISP transmission projects, costs, timings, decision rules."),
    ("Appendix A6 Cost Benefit Analysis", "a6-cost-benefit-analysis", "65263f64b43f4e7c856ba47364508845", "6.53 MB",
     "How the optimal development path was chosen; candidate development path (CDP) comparison."),
    ("Appendix A7 System Security", "a7-system-security", "d5ac8b3674ef42178d6453e2111f8532", "3.66 MB", None),
    ("Appendix A8 Social Licence", "a8-social-licence", "035a91c449f44bfc82a888a6770d9f90", "1.26 MB", None),
    ("Appendix A9 Demand Side Factors Statement", "a9-demand-side-factors-statement", "cfadf873c9934b46aecd670fdcd8995f", "2 MB", None),
    ("Appendix A10 Gas Development Projections", "a10-gas-development-projections", "e204886dac1c4f01a471e239723fb054", "2.58 MB", None),
]
E += [entry("appendices", t,
            f"{M}/major-publications/isp/2026/appendices/{f}.pdf?rev={r}&sc_lang=en",
            "pdf", "2026-06-25", s, notes=n)
      for t, f, r, s, n in APPX]

# --------------------------------------------------- supporting materials ----
SUP = "major-publications/isp/2026/supporting-materials"
E += [
    entry("supporting-materials", "2026 ISP Consultation Summary Report",
          f"{M}/{SUP}/2026-isp-consultation-summary-report.pdf?rev=7982dc7041d4477d988d9f75485846d3&sc_lang=en",
          "pdf", "2026-06-25", "2.35 MB"),
    entry("supporting-materials", "2026 ISP chart data",
          f"{M}/{SUP}/2026-isp-chart-data.xlsx?rev=c84f5cba01b94b10aa5893f04fbbbba1&sc_lang=en",
          "xlsx", "2026-06-25", "4.69 MB",
          "Data behind every chart in the 2026 ISP report - the fastest route to headline numbers."),
    entry("supporting-materials", "2026 ISP generation and storage outlook",
          f"{M}/{SUP}/2026-isp-generation-and-storage-outlook.zip?rev=b64eda28a46b4d3eb3e4b3cbafea3f84&sc_lang=en",
          "zip", "2026-06-25", "80.01 MB",
          "Model outputs: capacity/generation/storage build by scenario and CDP to 2050."),
    entry("supporting-materials", "2026 ISP Inputs and Assumptions workbook",
          f"{M}/{SUP}/2026-isp-inputs-and-assumptions-workbook.xlsm?rev=de6f5853cd5e4d5cbb06bc90bdf0e378&sc_lang=en",
          "xlsm", "2026-06-25", "22.96 MB",
          "The consolidated inputs/assumptions workbook used for the final 2026 ISP."),
    entry("supporting-materials", "Indicative REZ boundaries 2026 - GIS data",
          f"{M}/{SUP}/indicative-rez-boundaries-2026-gis-data.kmz?rev=9b0bf7fc154b496aa8736928be26b015&sc_lang=en",
          "kmz", "2026-06-25", "885.18 KB"),
    entry("supporting-materials", "Indicative sub-regional boundaries 2026 - GIS data",
          f"{M}/{SUP}/indicative-subregional-boundaries-2026-gis-data.kmz?rev=9e0f0e434d9343ad8d4111068da9c531&sc_lang=en",
          "kmz", "2026-06-25", "44.3 KB"),
    entry("supporting-materials", "Ministerial letter - New England REZ network infrastructure project",
          f"{M}/{SUP}/2026-isp-ministerial-letter-new-england-rez.pdf?rev=a840f63a7ad34dff95f223de5af1508f&sc_lang=en",
          "pdf", "2026-06-25", "194.47 KB"),
]

# -------------------------------------------------------------- isp-model ----
MOD = "major-publications/isp/2026/isp-model"
E += [
    entry("isp-model", "2026 ISP Model",
          f"{M}/{MOD}/2026-isp-model.zip?rev=78bfcf05ad414a8f9ba01f6a7c329fc2&sc_lang=en",
          "zip", "2026-06-25", "127.07 MB", "Full PLEXOS model package."),
    entry("isp-model", "2026 ISP PLEXOS Model Instructions",
          f"{M}/{MOD}/2026-isp-plexos-model-instructions.pdf?rev=79d503ba4e584fa88c65ee90e25ad7a2&sc_lang=en",
          "pdf", "2026-06-25", "781.05 KB"),
    entry("isp-model", "2026 ISP Solar traces (bulk)",
          f"{M}/{MOD}/2026-isp-solar-traces.zip?rev=3ad06155b7b94628bc77b90efe94588e&sc_lang=en",
          "zip", "2026-06-25", "98.68 MB"),
    entry("isp-model", "2026 ISP Timeslice traces",
          f"{M}/{MOD}/2026-isp-timeslice-traces.zip?rev=ea662aca37774fc9bd63e824297e2967&sc_lang=en",
          "zip", "2026-06-25", "11.92 KB"),
    entry("isp-model", "2026 ISP Wind traces (bulk)",
          f"{M}/{MOD}/2026-isp-wind-traces.zip?rev=73674cd5bc6b4b7fbbc7d0e68ee0bc7c&sc_lang=en",
          "zip", "2026-06-25", "151.88 MB"),
]

# ------------------------------------------------- demand traces (vanity) ----
DT = "https://www.aemo.com.au/2026-06-ISP-Demand-Traces"
SCEN = ["Accelerated-Transition", "Slower-Growth", "Step-Change"]
for reg in ["NSW", "QLD", "SA", "TAS", "VIC"]:
    for sc in SCEN:
        for poe in ["POE10", "POE50"]:
            t = f"ISP Demand Traces {reg} {sc.replace('-', ' ')} {poe}"
            E.append(entry("demand-traces-regional", t,
                           f"{DT}/ISP-Demand-Traces-{reg}-{sc}-{poe}", "zip",
                           "2026-06-25",
                           notes="Half-hourly regional demand by component, 23 reference years (2003-2025)."))
for sub in ["CNSW", "CQ", "CSA", "GG", "MEL", "NNSW", "NQ", "NSA",
            "SESA", "SEV", "SNSW", "SNW", "SQ", "TAS", "WNV"]:
    for sc in SCEN:
        t = f"ISP Demand Traces {sub} {sc.replace('-', ' ')}"
        E.append(entry("demand-traces-subregional", t,
                       f"{DT}/ISP-Demand-Traces-{sub}-{sc}", "zip",
                       "2026-06-25",
                       notes="Half-hourly sub-regional demand (OPSO_MODELLING, OPSO_MODELLING_PV_LITE, PV_TOT)."))

# ------------------------------------------------------------- vre traces ----
E.append(entry("vre-traces", "2026 ISP Firm Contribution Factors",
               f"{M}/major-publications/isp/2026/2026-isp-firm-contribution-factors.xlsx?rev=0805c25abe754f7bbd562c50bbe8e054&sc_lang=en",
               "xlsx", "2026-06-25", "2.06 MB"))
for yr in range(2011, 2026):
    E.append(entry("vre-traces", f"ISP Solar Traces r{yr}",
                   f"https://www.aemo.com.au//2026-06-ISP-Solar-Traces/ISP-Solar-Traces-r{yr}",
                   "zip", "2026-06-25"))
    E.append(entry("vre-traces", f"ISP Wind Traces r{yr}",
                   f"https://www.aemo.com.au//2026-06-ISP-Wind-Traces/ISP-Wind-Traces-r{yr}",
                   "zip", "2026-06-25"))

# ------------------------------------------------------------------- iasr ----
FD = "stakeholder_consultation/consultations/nem-consultations/2024/2025-iasr-scenarios/final-docs"
E += [
    entry("iasr", "2025 Inputs Assumptions and Scenarios Report",
          f"{M}/{FD}/2025-inputs-assumptions-and-scenarios-report.pdf?rev=63268acd3f044adb9f5f3a32b6880c27&sc_lang=en",
          "pdf", "2025-08-28", "10.9 MB",
          "The IASR: scenarios, demand, fuel prices, build costs for 2025-26 planning."),
    entry("iasr", "2025 Inputs and Assumptions Workbook",
          f"{M}/{FD}/2025-inputs-and-assumptions-workbook.xlsm?rev=2d0e43f63185479e9c7b54331f0aad7b&sc_lang=en",
          "xlsm", "2025-08-28", "17.4 MB",
          "Key scenario data used as inputs to AEMO's market models."),
    entry("iasr", "Addendum to the 2025 IASR",
          f"{M}/major-publications/isp/draft-2026/addendum-to-the-2025-inputs-assumptions-and-scenarios-report.pdf?rev=00798523a25e42078034d1878c337f19&sc_lang=en",
          "pdf", "2025-12-10", "894.02 KB",
          "Released with the Draft 2026 ISP."),
    entry("iasr", "2025 IASR Consultation Summary Report",
          f"{M}/{FD}/2025-iasr-consultation-summary-report.pdf?rev=6dc56931355649d9a4610a540d11154c&sc_lang=en",
          "pdf", "2025-07-31", "1.92 MB"),
    entry("iasr", "2025 IASR Overview",
          f"{M}/{FD}/2025-iasr-overview.pdf?rev=edd69645d24046babf574a4505c80ec2&sc_lang=en",
          "pdf", "2025-07-31", "542.71 KB"),
    entry("iasr", "2026 ISP Scenario weighting overview",
          f"{M}/major-publications/isp/2026/2026-isp-scenario-weighting-overview.pdf?rev=4dae70ae407241f68e19e768a4ce2a14&sc_lang=en",
          "pdf", "2025-11-05", "320.22 KB"),
    entry("iasr", "2025 IASR EV workbook",
          f"{M}/{FD}/aemo-2025-iasr-ev-workbook.xlsx?rev=66c26c22845d4891a020e32ecd0be709&sc_lang=en",
          "xlsx", "2025-07-31", "660.68 KB"),
]

# --------------------------------------------------------- iasr-reference ----
E += [
    entry("iasr-reference", "Aurecon 2024 Energy technology cost and technical parameter review report",
          f"{M}/{FD}/aurecon-2024-energy-technology-cost-technical-parameter-review-report.pdf?rev=5526946b9e3e4db680b7bcc82ecce94b&sc_lang=en",
          "pdf", "2025-07-31", "5.61 MB"),
    entry("iasr-reference", "Aurecon 2024 cost review tables",
          f"{M}/{FD}/aurecon-2024-energy-technology-cost-technical-parameter-review-tables.xlsx?rev=3fc5ff7dc11142a5a768753c4837e56f&sc_lang=en",
          "xlsx", "2025-07-31", "59.45 KB", "Technology build-cost tables."),
    entry("iasr-reference", "Aurecon 2024 cost review tables - Mid Size Solar PV and BESS",
          f"{M}/{FD}/aurecon-2024-energy-technology-cost-technical-parameter-review-tables-solar.xlsx?rev=ad3f9545639847479cddefc050c862b8&sc_lang=en",
          "xlsx", "2025-07-31", "24.25 KB"),
    entry("iasr-reference", "GHD 2025 Pumped hydro energy storage cost parameter review",
          f"{M}/{FD}/ghd-2025-pumped-hydro-energy-storage-cost-parameter-review.pdf?rev=23aa606f804b44c9a60efb1cd078468b&sc_lang=en",
          "pdf", "2025-07-31", "20.51 MB"),
    entry("iasr-reference", "GHD 2025 Energy technology retirement cost and O&M estimate review",
          f"{M}/{FD}/ghd-2025-energy-technology-retirement-cost-om-estimate-review.pdf?rev=e2644c247ff7443a93c5ab09349fe0d9&sc_lang=en",
          "pdf", "2025-07-31", "1.18 MB"),
    entry("iasr-reference", "Oxford Economics Australia - Data centre energy consumption report",
          f"{M}/{FD}/oxford-economics-australia-data-centre-energy-consumption-report.pdf?rev=2d89b1a4455f4f0db94c1ffff76c0c06&sc_lang=en",
          "pdf", "2025-07-31", "1.39 MB"),
    entry("iasr-reference", "Oxford Economics Australia - Discount rates for energy infrastructure report",
          f"{M}/{FD}/oxford-economics-australia-discount-rates-for-energy-infrastructure-report.pdf?rev=2b6a76734b334a309f30167baa7e154d&sc_lang=en",
          "pdf", "2025-07-31", "1.36 MB"),
    entry("iasr-reference", "Oxford Economics Australia - Planning and installation cost escalation factors report",
          f"{M}/{FD}/oxford-economics-australia-planning-installation-cost-escalation-factors-report.pdf?rev=92ecc2e2bdec49c4a82fd29e1e3992f2&sc_lang=en",
          "pdf", "2025-07-31", "1.41 MB"),
    entry("iasr-reference", "Strategy Policy Research 2025 Energy Efficiency report",
          f"{M}/{FD}/strategy-policy-research-2025-energy-efficiency-report.pdf?rev=16f21ea5114a47f9b8f535505c520ea4&sc_lang=en",
          "pdf", "2025-07-31", "3.81 MB"),
    entry("iasr-reference", "ACIL Allen 2024 Gas, liquid fuel, coal and renewable gas projections",
          f"{M}/major-publications/isp/2025/acil-allen-2024-fuel-price-forecast-report.pdf?rev=3dd0a9e2448f46cabf84196e012eb081&sc_lang=en",
          "pdf", "2025-07-31", "2 MB"),
    entry("iasr-reference", "ACIL Allen 2024 Price forecast data files",
          f"{M}/major-publications/isp/2025/acil-allen-2024-price-forecast-data-files.zip?rev=b26651230b4940fe82a0da00f0fc590a&sc_lang=en",
          "zip", "2024-12-11", "893.78 KB", "Fuel price trajectories by scenario."),
    entry("iasr-reference", "CSIRO 2024 Solar PV and Battery Projections Report",
          f"{M}/major-publications/isp/2025/csiro-2024-solar-pv-and-battery-projections-report.pdf?rev=e8a158794c6d4327a1eb66ae15d86ca8&sc_lang=en",
          "pdf", "2024-12-11", "1.86 MB"),
    entry("iasr-reference", "Deloitte Access Economics 2024 Economic Forecast",
          f"{M}/major-publications/isp/2025/deloitte-access-economics-2024-economic-forecast.pdf?rev=92704425728b4097b3cb4894e1ccf0de&sc_lang=en",
          "pdf", "2024-12-11", "1.44 MB"),
]

# -------------------------------------------------------- network-options ----
NC = "stakeholder_consultation/consultations/nem-consultations/2025/2025-electricity-network-options-report/final"
EN = "major-publications/isp/2026/enor-reference-material"
E += [
    entry("network-options", "2025 Electricity Network Options Report",
          f"{M}/{NC}/2025-electricity-network-options-report.pdf?rev=7fd2059752bd41eba55184df4e389e1e&sc_lang=en",
          "pdf", "2025-08-28", "8.61 MB",
          "Candidate network options, costs and timings feeding the ISP."),
    entry("network-options", "2025 transmission cost estimates",
          f"{M}/{EN}/2025-transmission-cost-estimates.zip?rev=5b48ab65e0154f209794f6ca9518014a&sc_lang=en",
          "zip", "2025-07-31", "3.32 MB"),
    entry("network-options", "GHD 2025 Transmission Cost Database update report",
          f"{M}/{EN}/ghd-2025-transmission-cost-database-update-report.pdf?rev=7aed994756df40678b68fa51ccffeedf&sc_lang=en",
          "pdf", "2025-07-31", "933.77 KB",
          "TCD v3.1 itself is via AEMO request form, not direct download."),
    entry("network-options", "GHD 2025 Transmission cost forecasting method update report",
          f"{M}/{EN}/ghd-2025-transmission-cost-forecasting-method-update-report.pdf?rev=0121a12dddda4c8eb5ad90d79ff13d3c&sc_lang=en",
          "pdf", "2025-05-22", "1.3 MB"),
    entry("network-options", "Jacobs 2025 Strategic land use transmission assessment report",
          f"{M}/{EN}/jacobs-strategic-land-use-transmission-assessment-report.pdf?rev=027ad6aa178948f4a9cb9e1f8db3bbab&sc_lang=en",
          "pdf", "2025-05-22", "3.31 MB"),
    entry("network-options", "Jacobs Strategic land use transmission assessment GIS data",
          f"{M}/{EN}/jacobs-strategic-land-use-transmission-assessment-gis-data.zip?rev=b93171dafa064574b91ce69c4c0fba10&sc_lang=en",
          "zip", "2025-05-22", "6.51 MB"),
]

# -------------------------------------------------------------------- gas ----
GC = "stakeholder_consultation/consultations/nem-consultations/2025/2025-gas-infrastructure-options-report"
E += [
    entry("gas", "2025 Gas Infrastructure Options Report",
          f"{M}/{GC}/final/2025-gas-infrastructure-options-report.pdf?rev=fecf33c5de994deb9423ad1e326c6e98&sc_lang=en",
          "pdf", "2025-07-31", "1.88 MB"),
    entry("gas", "2025 Gas fuel limitations data (existing infrastructure)",
          f"{M}/{FD}/2025-gas-fuel-limitations-data.zip?rev=bb5ab15e63444ccd8111e5b2499a13a8&sc_lang=en",
          "zip", "2025-08-06", "16.65 MB"),
    entry("gas", "GHD 2025 Gas Infrastructure Costs Report",
          f"{M}/{GC}/2025-gas-infrastructure-costs-report.pdf?rev=013f876a90b9421c886f8e4c96a600dd&sc_lang=en",
          "pdf", "2025-05-22", "2.2 MB"),
    entry("gas", "GHD 2025 Gas Master Cost database",
          f"{M}/{GC}/2025-gas-master-cost-database.xlsx?rev=3a2caf85294a4520907f707c81ac88d0&sc_lang=en",
          "xlsx", "2025-05-22", "83.38 KB"),
    entry("gas", "GHD 2025 Gas Adjustment Factors database",
          f"{M}/{GC}/2025-gas-adjustment-factors-database.xlsx?rev=feae5791b7dd4f3b88c87230e389fb53&sc_lang=en",
          "xlsx", "2025-05-22", "59.12 KB"),
    entry("gas", "GHD 2025 Gas Infrastructure Price forecasts",
          f"{M}/{GC}/ghd-2025-gas-infrastructure-price-forecasts.xlsx?rev=29cc81d909624e4abba79aacb3a976b3&sc_lang=en",
          "xlsx", "2025-05-22", "574.93 KB"),
]

# ------------------------------------------------------------------ draft ----
E += [
    entry("draft", "Draft 2026 Integrated System Plan",
          f"{M}/major-publications/isp/draft-2026/draft-2026-integrated-system-plan.pdf?rev=01e6116c8dbd473a954928253886791c&sc_lang=en",
          "pdf", "2025-12-10",
          notes="Superseded by the final 2026 ISP; use for draft-vs-final comparison only."),
]

PAGES = {
    "2026-isp-home": "https://www.aemo.com.au/energy-systems/major-publications/integrated-system-plan-isp/2026-integrated-system-plan-isp",
    "2025-26-iasr": "https://www.aemo.com.au/energy-systems/major-publications/integrated-system-plan-isp/2026-integrated-system-plan-isp/2025-26-inputs-assumptions-and-scenarios",
    "isp-methodology": "https://www.aemo.com.au/energy-systems/major-publications/integrated-system-plan-isp/2026-integrated-system-plan-isp/isp-methodology",
    "draft-2026-isp-consultation": "https://www.aemo.com.au/consultations/current-and-closed-consultations/draft-2026-isp-consultation",
    "draft-2026-isp-addendum-consultation": "https://www.aemo.com.au/consultations/current-and-closed-consultations/draft-2026-isp-addendum-consultation",
    "transmission-cost-database": "https://www.aemo.com.au/energy-systems/major-publications/integrated-system-plan-isp/2026-integrated-system-plan-isp/2025-26-inputs-assumptions-and-scenarios/transmission-cost-database",
}


def main():
    ids = [e["id"] for e in E]
    dupes = {i for i in ids if ids.count(i) > 1}
    if dupes:
        raise SystemExit(f"duplicate ids: {sorted(dupes)}")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({
        "generated": "2026-07-10",
        "source": "aemo.com.au (verified 2026-07-10; final 2026 ISP published 2026-06-25)",
        "scenarios": ["Step Change", "Accelerated Transition", "Slower Growth"],
        "pages": PAGES,
        "documents": E,
    }, indent=1))
    cats = {}
    for e in E:
        cats[e["category"]] = cats.get(e["category"], 0) + 1
    print(f"wrote {OUT} - {len(E)} documents")
    for c, n in sorted(cats.items()):
        print(f"  {c:26} {n}")


if __name__ == "__main__":
    main()
