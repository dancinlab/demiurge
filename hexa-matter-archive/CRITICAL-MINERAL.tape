#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "critical-mineral" :: identity-claim [d=2026-05-17 active]
  kind   = "CRITICAL-MINERAL — umbrella domain for export-controlled materials"
  brief  = "REE + Ga + Ge + Sb + W + Co + Li + graphite + Mg + Ti. Per-commodity concentration + 2024-2026 export-control status. REE detail deferred to RARE-EARTH.tape."
  parent = "dancinlab/hexa-matter"
  sibling-md = "CRITICAL-MINERAL.md (planned)"
  @> AGENTS.md

# ────────────────────────────────────────────────────────────────────
# Layout — commodity inventory
# ────────────────────────────────────────────────────────────────────

@L l1 := "commodity-inventory" :: taxonomy [active d=2026-05-17]
  commodities = ["REE-17", "Ga", "Ge", "Sb", "W", "Co", "Li", "graphite", "Mg", "Ti", "Nb", "Ta"]
  selection-basis = "intersection of: USGS Critical Minerals List 2022 ∩ EU CRM Act 2024 strategic raw materials ∩ China 2023-2025 export-control announcements"
  note = "deliberately includes both demand-driven (Li · Co · graphite for batteries) AND supply-driven (Ga · Ge · Sb · W for export control) commodities"

@L l2_china_dominance := "China processing share (2024-2025 anchors)" :: market-map [active d=2026-05-17]
  REE_processing      = "~90%"
  graphite_anode      = "~75%   (battery-grade spherical)"
  W                   = "~80%"
  Sb                  = "~60%"
  Ga                  = "~98%   (primary low-purity); ~80% high-purity 7N+"
  Ge                  = "~60%   (primary refined)"
  Mg                  = "~85%   (primary metal smelting)"
  Co_refining         = "~70%   (DRC-mined → China-refined)"
  Li_refining         = "~65%   (LiOH/Li₂CO₃ battery grade)"
  Nb_Ta               = "low    (Brazil/Australia dominate; not concentrated in China)"
  source = "USGS MCS 2025 + IEA Critical Minerals Outlook 2024 + Adamas Intelligence quarterly"

@L l3_export_controls := "China export-control timeline 2023-2026" :: chronology [active d=2026-05-17]
  events <<~EOF
    2023-08  Ga + Ge dual-use license requirement (effective 2023-08)
    2023-12  graphite license requirement (effective 2023-12)
    2024-08  Sb license requirement
    2024-12  Ga + Ge + Sb shipments to US specifically blocked
    2025-04  7 medium-/heavy-REE elements + REE permanent magnets license requirement
              (Sm · Gd · Tb · Dy · Lu · Sc · Y — note Nd/Pr NOT yet listed)
    2025-10  expanded REE controls announced (extra-territorial scope)
    2025-11  US-China 12-month suspension agreed — controls paused until 2026-11-10
    2026-01  reported de-facto restriction on REE exports to Japan (defense supply chain)
    2026-?   pending: 2026-11-10 expiry — extension, selective reinstatement, or full reimposition
  EOF
  |> "[@x_csis_2025_consequences]"
  |> "[@x_fdd_2026_japan]"

# ────────────────────────────────────────────────────────────────────
# Per-commodity criticality cards
# ────────────────────────────────────────────────────────────────────

@L c_REE := "REE-17" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (90% processing, ~70% mining)"
  primary_use       = "permanent magnets (Nd/Pr/Dy/Tb), phosphors (Eu/Tb/Y), catalysts (La/Ce)"
  substitution      = "see [[RARE-EARTH+ALTERNATIVE]] (5-track roadmap)"
  detail-in         = "RARE-EARTH.tape"

@L c_Ga := "Gallium" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~98% primary, ~80% high-purity)"
  primary_use       = "GaAs / GaN power + RF semis, LED, photovoltaic CIGS"
  substitution      = "GaN ↔ SiC for power (partial); InP for some RF; no drop-in for high-electron-mobility transistors"
  detail-in         = "COMPOUND-SEMI.tape"
  status            = "under PRC export license since 2023-08; US-bound shipments blocked since 2024-12"

@L c_Ge := "Germanium" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~60% refined), DRC + Russia secondary"
  primary_use       = "fiber-optic core, IR optics (thermal imaging), polymerization catalyst (PET), GaAs/Ge tandem PV"
  substitution      = "limited — Si replaces in some IR; no drop-in for fiber-optic core or 4-junction concentrator PV"
  status            = "under PRC export license since 2023-08; US-bound shipments blocked since 2024-12"

@L c_Sb := "Antimony" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~60%), Russia + Tajikistan secondary"
  primary_use       = "lead-acid battery grids, flame retardants (Sb₂O₃), ammunition (military), liquid-metal batteries"
  substitution      = "Bi-based for some flame retardants; no drop-in for ammunition primer"
  status            = "under PRC export license since 2024-08"

@L c_W := "Tungsten" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~80%)"
  primary_use       = "WC cemented carbide (cutting tools), filaments, electrodes, alloying"
  substitution      = "ceramic cutting tools partial; no drop-in for tool-steel hot-strength"
  detail-in         = "METALLURGY-DEEP.md · SUPERALLOY.tape"

@L c_Co := "Cobalt" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "DRC mining (~70%), China refining (~70%)"
  primary_use       = "NMC cathode (Li-ion battery), superalloys (jet engines), tool-steel"
  substitution      = "LFP cathode (Tesla 2022+ shift) eliminates Co for cost-sensitive EV; Ni-rich (NMC 9-0.5-0.5) reduces Co; no drop-in for jet-engine superalloy"
  detail-in         = "SUPERALLOY.tape · NOVEL.md §3.2 (hxm-cath-*)"

@L c_Li := "Lithium" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "Australia + Chile mining, China refining (~65%)"
  primary_use       = "Li-ion battery (cathode + electrolyte salt LiPF₆)"
  substitution      = "Na-ion (CATL 2023+ commercial, ~70% Wh/kg of LFP); solid-state Li (no Li substitution); no drop-in at high energy density"
  detail-in         = "NOVEL.md §3.2 + §3.3 (hxm-cath-*, hxm-se-*)"

@L c_graphite := "Graphite (battery-grade)" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~75% spherical anode-grade)"
  primary_use       = "Li-ion battery anode (natural + synthetic)"
  substitution      = "Si-anode hybrid (5-10% Si common 2024+); pure Si or Li-metal anode in R&D"
  detail-in         = "GRAPHENE-CARBON.tape · NOVEL.md §3.2"

@L c_Mg := "Magnesium" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~85%)"
  primary_use       = "lightweight alloys (auto + aerospace), Al-alloy desulfurization, Mg-air battery research"
  substitution      = "Al alloys partial; no drop-in for lightest structural metal"

@L c_Ti := "Titanium" :: commodity-card [active d=2026-05-17]
  dominant_supplier = "China (~50% sponge), Russia (~25%) — VSMPO-AVISMA is largest single supplier"
  primary_use       = "aerospace airframe, jet-engine, biomedical implants, sea-water heat exchangers"
  substitution      = "Al-Li for some airframe; superalloy partial; no drop-in for jet-engine fan blade or biocompatible implant"

# ────────────────────────────────────────────────────────────────────
# External anchors
# ────────────────────────────────────────────────────────────────────

@X x_usgs_critical_minerals_list_2022 := "USGS Critical Minerals List 2022" :: external-spec [active]
  url  = "https://www.usgs.gov/news/national-news-release/us-geological-survey-releases-2022-list-critical-minerals"
  role = "US-government anchor for which commodities count as 'critical'"

@X x_iea_critical_minerals_2024 := "IEA Global Critical Minerals Outlook 2024" :: external-anchor [active]
  url = "https://www.iea.org/reports/global-critical-minerals-outlook-2024"

@X x_eu_crm_act_2024 := "EU Critical Raw Materials Act (2024)" :: external-spec [active]
  role = "EU strategic + critical raw-material list; 2030 sourcing thresholds"

@X x_csis_2025_consequences := "CSIS — Consequences of China's New REE Export Restrictions" :: think-tank [active d=2025]
  url  = "https://www.csis.org/analysis/consequences-chinas-new-rare-earths-export-restrictions"

@X x_fdd_2026_japan := "FDD — China Reportedly Blocks REE Exports to Japan" :: think-tank [active d=2026-01-12]
  url  = "https://www.fdd.org/analysis/2026/01/12/china-reportedly-blocks-rare-earth-exports-to-japan-targeting-defense-supply-chains/"

@X x_european_parliament_2025_ree := "EP Briefing — China's Rare-Earth Export Restrictions" :: gov [active d=2025-11-24]
  url  = "https://epthinktank.eu/2025/11/24/chinas-rare-earth-export-restrictions/"

@X x_arxiv_2605_02926 := "Geostrategic Critical Minerals + Materials Resilience" :: arxiv-paper [active d=2026-05]
  url     = "https://arxiv.org/abs/2605.02926"
  finding = "QCCM dashboard methodology for tracking concentration + substitutability + qualification bottlenecks"

@X x_arxiv_2508_00556 := "Systemic Trade Risk Suppresses Comparative Advantage in REE Industries" :: arxiv-paper [active d=2025-08]
  url = "https://arxiv.org/html/2508.00556v1"

# ────────────────────────────────────────────────────────────────────
# Governance
# ────────────────────────────────────────────────────────────────────

@D g1_scope_umbrella := "this-file-is-umbrella-not-deep-dive" :: governance [required active d=2026-05-17]
  rule = "CRITICAL-MINERAL.tape is the UMBRELLA — per-commodity 1-card summaries + China concentration + export-control timeline. Material-property deep dives stay in their verb / domain files."
  deferred-to <<~EOF
    REE             → RARE-EARTH.tape · RARE-EARTH+ALTERNATIVE.tape
    Ga · Ge         → COMPOUND-SEMI.tape
    Co · Li · graphite (battery) → NOVEL.md §3.2-§3.4 (cathode + SE + anode)
    W · Ti · superalloy elements → METALLURGY-DEEP.md · SUPERALLOY.tape
    graphite (carbon) → GRAPHENE-CARBON.tape
  EOF

@D g2_concentration_anchors := "supply-share anchors" :: governance [required active d=2026-05-17]
  rule = "Concentration percentages MUST cite USGS MCS, IEA, or EU CRM. NEVER cite vendor / industry-association numbers as authoritative — they routinely diverge 1.5-3× from reconciled government anchors."
  inherits-from = "RARE-EARTH.tape @D g_anchor_honesty"

@D g3_no_political_speculation := "report-policy-not-predict-it" :: governance [required active d=2026-05-17]
  rule = "Document announced and verified export controls. Do NOT speculate about future PRC / US / EU policy moves beyond stating named scenarios from cited analyses (CSIS · FDD · EP · IEA)."
  why  = "speculation rots fast; documented policy events stay useful"

# ────────────────────────────────────────────────────────────────────
# Forbidden patterns
# ────────────────────────────────────────────────────────────────────

@F f1_substitution_as_solved := "marketing-claim of substitution-availability" :: anti-pattern [denied d=2026-05-17]
  rule = "Vendor claims that a Co-free / Li-free / REE-free / W-free alternative 'exists' MUST be checked against envelope (operating temperature, energy density, hardness, throughput). Lab-scale ≠ drop-in."
  inherits-from = "RARE-EARTH+ALTERNATIVE.tape @F f1_lab_mm_strength_claim"

@F f2_recycling_silver_bullet := "recycling does not zero out new mining at scale" :: anti-pattern [denied d=2026-05-17]
  rule = "Demand-doubling commodities (Li · Co · graphite) cannot be supplied by recycling at >20% in the next 10 years — battery first-life is 8-15 years and EoL wave is still small."
  inherits-from = "RARE-EARTH+ALTERNATIVE.tape @F f3_recycling_silver_bullet"

# ─── §Log (append @A / @D events here, chronological) ────────────────
#
#   @A commit_<hash> :: critical-mineral [d=<YYYY-MM-DD> ok]
#     <- <prev-id>
#     => "<one-line description>"
#
# See ~/core/tape/spec/tape.md for full grammar.
