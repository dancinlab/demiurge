#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "rare-earth" :: identity-claim [d=2026-05-17 active]
  kind = "RARE-EARTH — 17-element family reference (15 lanthanides + Sc + Y)"
  brief = "Pure element-family domain. Applications, supply concentration, criticality anchors. Substitution roadmap lives in RARE-EARTH+ALTERNATIVE.tape."
  parent = "dancinlab/hexa-matter"
  sibling-md = "RARE-EARTH.md (planned)"
  @> AGENTS.md

# ────────────────────────────────────────────────────────────────────
# Layout — element family
# ────────────────────────────────────────────────────────────────────

@L l1 := "element-family" :: taxonomy [active d=2026-05-17]
  total       = 17
  light_REE   = ["La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu"]
  heavy_REE   = ["Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Y"]
  scandium    = ["Sc"]
  note        = "Pm is radioactive — no natural occurrence. Y groups with HREE by ionic radius. Sc treated separately by USGS / IEA."
  =>  "LREE = abundant in monazite + bastnaesite; HREE = concentrated in ion-adsorption clays (S. China · Myanmar)"

@L l2 := "primary-applications" :: use-map [active d=2026-05-17]
  Nd_Pr      = "NdFeB permanent magnets — EV traction motors, wind turbine generators, HDD voice coils, robotics actuators"
  Dy_Tb      = "high-coercivity additive in NdFeB — thermal stability above 150°C (EV motor operating envelope)"
  Sm         = "SmCo (1:5 and 2:17) magnets — high-T aerospace, medical, defense"
  Eu_Tb_Y    = "phosphors — legacy CRT, white-LED red/green emitters, display"
  La_Ce      = "FCC catalyst (petroleum cracking), Ni-MH battery cathode (legacy HEV)"
  Gd         = "MRI contrast agents, magnetocaloric refrigeration / H₂ liquefaction"
  Er_Yb      = "EDFA fiber-optic amplifiers, solid-state laser hosts"
  Sc         = "Al-Sc aerospace alloys (Airbus A380 floor beams, additive manufacturing wire)"
  Ho_Tm_Lu   = "research-grade — niche optics, medical isotopes, NMR shift reagents"
  ?> "[[MAGNETIC-MATERIALS]]"
  ?> "[[METALLURGY-DEEP]]"
  ?> "[[COMPOUND-SEMI]]"

@L l3 := "supply-concentration" :: market-map [active d=2026-05-17]
  china_mining_share          = "~70%   (2024 USGS MCS estimate)"
  china_processing_share      = "~90%   (separation + metal + alloy)"
  china_HREE_processing       = "~100%  (Dy / Tb monopoly — Korea import 91.2% from China)"
  ROW_NdPr_2024_to_2030       = "4.4× non-Chinese capacity expansion projected, still 36% short of 2030 demand (Bloomberg Intelligence)"
  rebuild_independent_supply  = "20–30 years (mine → separation → metal → alloy → magnet)"
  global_demand_growth        = "~7%/yr 2024-2030 (EV + wind primary drivers)"
  |> "[@x_iea_critical_minerals_2024]"
  |> "[@x_usgs_mcs_2025]"

@L l4 := "non-china-supply-projects" :: pipeline [active d=2026-05-17]
  operating          = ["Lynas (Mt Weld AU + Kuantan MY)", "MP Materials (Mountain Pass US)", "Energy Fuels / Neo Performance (US/EE)"]
  ramping            = ["Iluka Resources (Eneabba AU refinery 2026+)", "Vital Metals (Saskatoon CA — paused)", "Pensana (Longonjo AO)"]
  recycling_at_scale = ["Solvay La Rochelle FR (2025+)", "Cyclic Materials CA", "REEsolve · Phoenix Tailings (Boston)"]
  honesty            = "all combined ~10% of global processing capacity by 2030 if all hit nameplate — China retains structural dominance"

# ────────────────────────────────────────────────────────────────────
# External anchors
# ────────────────────────────────────────────────────────────────────

@X x_usgs_mcs_2025 := "USGS Mineral Commodity Summaries 2025 — Rare Earths" :: external-anchor [active]
  url    = "https://pubs.usgs.gov/periodicals/mcs2025/mcs2025-rare-earths.pdf"
  role   = "primary US-government anchor for global REE mine production + reserves"
  status = "annual update; 2025 edition is current as of 2026-05-17"

@X x_iea_critical_minerals_2024 := "IEA Global Critical Minerals Outlook 2024" :: external-anchor [active]
  url  = "https://www.iea.org/reports/global-critical-minerals-outlook-2024"
  role = "global demand/supply forecasts to 2040; REE demand 3-7× baseline"

@X x_eu_crm_act_2024 := "EU Critical Raw Materials Act (2024)" :: external-spec [active]
  role = "EU strategic + critical raw-material list; 17 REEs included as a group"
  thresholds = "by 2030: ≥10% extraction · ≥40% processing · ≥25% recycling within EU; ≤65% from any single 3rd country"

@X x_korea_strategic_minerals_2026 := "한국 희토류 공급망 종합대책 (2026-02)" :: external-spec [active]
  agency = "산업통상자원부"
  budget = "1조 원 (~$760M USD) 5-year fund"
  scope  = "17 REEs designated as core minerals; stockpile expansion; recycling subsidy; magnetic-material consortium"

# ────────────────────────────────────────────────────────────────────
# Governance — scope split
# ────────────────────────────────────────────────────────────────────

@D g_scope_reference_only := "this-file-is-element-reference" :: governance [required active d=2026-05-17]
  rule = "RARE-EARTH.tape is the REFERENCE for the 17-element family — applications, supply, criticality anchors. Substitution / process / candidate detail lives in sibling domains."
  deferred-to <<~EOF
    alternatives    → RARE-EARTH+ALTERNATIVE.tape
    broader-context → CRITICAL-MINERAL.tape   (Ga · Ge · Sb · W · Co · Li · graphite)
    recycling       → RECYCLING.tape · HEXA-RECYCLE.tape
    magnet-deep     → MAGNETIC-MATERIALS.tape · METALLURGY-DEEP.md
    novel-candidates → NOVEL.md §3.5 (hxm-mag-*)
  EOF
  ?> "[[RARE-EARTH+ALTERNATIVE]]"
  ?> "[[CRITICAL-MINERAL]]"

@D g_anchor_honesty := "USGS/IEA/EU-CRM only for criticality numbers" :: governance [required active d=2026-05-17]
  rule = "Criticality + supply-share numbers MUST cite a named anchor (USGS MCS, IEA Critical Minerals, EU CRM Act, Bloomberg Intelligence, Adamas Intelligence, Argus). NEVER cite a vendor self-report as a supply-share number."
  why  = "vendor self-reporting + industry-association numbers diverge by 2-3× from USGS/IEA reconciled numbers; mixing them creates false precision."

# ─── §Log (append @A / @D events here, chronological) ────────────────
#
#   @A commit_<hash> :: rare-earth [d=<YYYY-MM-DD> ok]
#     <- <prev-id>
#     => "<one-line description>"
#
#   @D <id> := "<decision-name>" :: rare-earth [<grades>]
#     <- <evidence-id>
#     |> <verifier>
#
# See ~/core/tape/spec/tape.md for full grammar.
