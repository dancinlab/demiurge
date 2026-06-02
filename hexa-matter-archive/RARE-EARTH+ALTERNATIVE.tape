#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "rare-earth+alternative" :: identity-claim [d=2026-05-17 active]
  kind   = "META-DOMAIN — REE × Substitution roadmap (only when BOTH conditions hold)"
  brief  = "5-track substitution roadmap for the rare-earth supply problem. Anchored to arxiv 2025-2026 literature. Feeds hxm-mag-* candidates into NOVEL.md §3.5."
  parent = "dancinlab/hexa-matter"
  sibling-md = "RARE-EARTH+ALTERNATIVE.md (planned)"
  intersects = ["RARE-EARTH.tape (element family)", "MAGNETIC-MATERIALS.tape (verb scope)"]
  @> AGENTS.md

# ────────────────────────────────────────────────────────────────────
# Layout — the 5 substitution tracks
# ────────────────────────────────────────────────────────────────────

@L tracks := "5-track substitution roadmap" :: roadmap [active d=2026-05-17]

@L t1_recycling := "TRACK 1 — closed-loop NdFeB recycling" :: track [active d=2026-05-17]
  approach   = "hydrometallurgical leach + selective precipitation of EoL NdFeB (HDD / EV motor / wind nacelle)"
  ceiling    = "~40% demand offset for mobility magnets over the next decade ([@x_climate_change_news_2026])"
  blocker    = "commercial-scale economics still uncertain; ROW collection logistics fragmented"
  feedstock  = ["~75 kt/yr EoL HDD globally", "EV motor wave starts ~2030+ (15-year vehicle life)", "wind nacelle wave ~2035+ (20-year asset life)"]
  hxm        = "(process track — does NOT become a hxm-mag-* novel entry; lives in RECYCLING.tape · HEXA-RECYCLE.tape)"
  |> "[@x_arxiv_2506_22569]  Toward Sustainable REE Production"
  |> "[@x_arxiv_2504_10495]  REE recovery from phosphogypsum"

@L t2_ferrite_hd := "TRACK 2 — high-density anisotropic ferrite" :: track [active d=2026-05-17]
  approach     = "SrFe₁₂O₁₉ / BaFe₁₂O₁₉ M-type hexaferrite, Co/La/Mn co-doped for enhanced (BH)max"
  cost         = "iron oxide + Sr/Ba carbonate — REE-FREE, ~10× cheaper raw than NdFeB"
  performance  = "(BH)max ~5 MGOe (commercial Sr-ferrite) vs NdFeB ~50 MGOe → 10× volume / mass penalty for same flux"
  envelope     = "best fit: low-cost EV (sub-200 kW), industrial motors, micro-magnets, magnetic separation"
  hxm          = "→ NOVEL.md §3.5 hxm-mag-ferrhd-001"
  |> "[@x_acs_lca_2024]  LCA of REE-free magnets — Sr-ferrite + Mn-Al-C"

@L t3_mnalc := "TRACK 3 — Mn-Al-C τ-phase intermetallic" :: track [active d=2026-05-17]
  approach    = "Mn₅₅Al₄₄C₁ ordered L1₀ τ-phase (REE-free, Co-free)"
  performance = "(BH)max ~7-12 MGOe lab-scale; Hc ~0.3 T; Tc ~340°C"
  status      = "decades-old discovery (Koch 1960s); revived interest 2020+ via mechanochemical synthesis"
  blocker     = "τ-phase metastability — formation window narrow, demixing on T cycling"
  hxm         = "→ NOVEL.md §3.5 hxm-mag-mnalc-001"
  |> "[@x_acs_lca_2024]"
  |> "[@x_arxiv_2507_01849]  DFT high-throughput screen"

@L t4_boride := "TRACK 4 — rare-earth-free borides + nitrides + Fe-based intermetallics" :: track [active d=2026-05-17]
  approach     = "two complementary literature waves: (a) Beeson 2025 Adv. Mater. C16-phase high-entropy borides; (b) arxiv:2507.01849 DFT high-throughput screen → 10 binary candidates (FeSn, CrSb, Mn2Sb, FeB, FeNi, Fe2P, Fe3Ga, FeGe, ZnFe, Fe8N)"
  beeson-detail = "C16 phase = tetragonal I4/mcm (No.140), CuAl₂-type, M₂B (33% B). quinary 3d-TM = Fe·Co·Ni·Mn·Cr. Named film: (FeCoNiMn)₂B 50 nm, a=5.05 Å c=4.25 Å. Mechanism: (Fe₁₋ₓCoₓ)₂B easy-plane→easy-axis switch, x=0.3 → K₁≈410 kJ/m³ at RT. DFT anisotropy ≈ 1×10⁷ erg/cm³ (~1 MJ/m³). Team: Beeson·Yin·Liu, Georgetown Physics."
  performance  = "Mn2Sb (tetragonal): Ms=1.76 T, K=1.57 MJ/m³, Tc=2270 K predicted; ZnFe / Fe8N highlighted as novel; Beeson C16 >2× coercivity vs binary/ternary TM borides"
  status       = "Beeson Adv. Mater. = published, THIN-FILM (combinatorial sputter, ~50 samples/run); bulk-scale NOT demonstrated. arxiv:2507.01849 = DFT predicted only"
  mp-verified  = "Mn₂Sb → MP mp-20664 (P4/nmm, FM, E_hull=0, M=15.16 μB) → hxm-mag-mn2sb-001 SIM-DFT. C16 structure family confirmed in MP: Fe₂B mp-1915 (I4/mcm, FM, E_hull=0), Co₂B mp-493 (I4/mcm, FM), Ni₂B mp-2536 (I4/mcm, NM), Mn₂B mp-20318 (I4/mcm, AFM). The disordered quinary high-entropy composition has NO single MP record → boride-001 instead promoted via a CHGNet relax of the (FeCoNiMn)₂B C16 ordered approximant on ubu-1 GPU → hxm-mag-boride-001 SIM-NNP (2026-05-18)."
  novelty      = "5-element compositions sit naturally near n=6 lattice — high-entropy boride space largely unexplored"
  caveat       = "Beeson result is thin-film — thin-film K₁ ≠ bulk magnet (BH)max (per @F f1). Exact quinary stoichiometry still requires Adv. Mater. paper-level extraction."
  hxm          = "→ NOVEL.md §3.5 hxm-mag-boride-001 (Beeson C16 family — thin-film measured, bulk unproven)"
  |> "[@x_arxiv_2507_01849]  DFT HT search for REE-free PMs (10 binary candidates)"
  |> "[@x_arxiv_2501_01607]  Unveiling potential REE-free candidates"
  |> "[@x_phys_org_2026_boride]  Georgetown announcement (popular press)"
  |> "[@x_beeson_2025_adv_mater]  Beeson C16 high-entropy boride (peer-reviewed)"
  correction-note = "earlier draft mis-attributed Mn₂MoB₄ / Mn₂WB₄ to arxiv:2507.01849 — direct fetch confirms those compounds DO NOT appear in that paper's final 10. Corrected 2026-05-17."

@L t5_lowdy := "TRACK 5 — light-REE substitution in NdFeB (low-Dy/Tb)" :: track [active d=2026-05-17]
  approach     = "replace expensive heavy-REE (Dy, Tb) with cheaper abundant LREE (Ce, La) at Nd₂Fe₁₄B grain boundaries"
  goal         = "preserve thermal coercivity above 150°C while cutting heavy-REE content by ≥50%"
  trade-off    = "Ce/La addition reduces saturation magnetization → must compensate via grain refinement + GB diffusion"
  status       = "Toyota / Daido + Hitachi Metals have published prototype motor magnets with 50-80% Dy reduction"
  hxm          = "→ NOVEL.md §3.5 hxm-mag-lowdy-001"
  |> "[@x_pmc_securing_2024]  Securing REE PMs for sustainable energy"
  |> "[@x_arxiv_2312_02475]  ML predictions of coercivity"

@L t6_ai := "TRACK 6 — AI / ML discovery from large magnetic-materials DBs" :: track [active d=2026-05-17]
  approach     = "graph-NN + descriptor-based screening over MAGNDATA · NEMAD · MP · GNoME for unexplored ferromagnets"
  evidence     = "NEMAD (67,573 entries, 90% classifier accuracy); Table 4 screen → 62 FM candidates Tc>500K, 22% above 600K"
  top-candidates = "highest predicted Tc (3-model consensus, K): Ga₃Fe₄Co₈Si ~1106, FeCo₂Ge ~1039, GaFe₂Co₄Si ~1021, Fe₃Co₃Si₂ ~965 — all REE-free Fe-Co intermetallics"
  selected     = "hxm-mag-aifound-001 → FeCo₂Ge (Heusler-like) chosen: simple composition + 3-model Tc consensus 999/1051/1068 K; easier synthesis target than the quinary Ga-Fe-Co-Si compounds"
  mp-verified  = "MP mp-22300 confirms FeCo₂Ge as Fm-3m full Heusler, FM ordering, E_hull=0 (stable), M_tot=6.0 μB → hxm-mag-aifound-001 promoted DESIGN → SIM-DFT (2026-05-17)"
  status       = "SIM-DFT for FeCo₂Ge (MP DFT cross-ref); other Table 4 candidates remain computational, validation rate ≤5%"
  caveat       = "AI predictions ≠ measurements (project governance @F f2). NEMAD Tc is ML-regressed (R²=0.87, MAE=56K), not measured."
  hxm          = "→ NOVEL.md §3.5 hxm-mag-aifound-001 (FeCo₂Ge)"
  |> "[@x_arxiv_2409_15675]  NEMAD database (67k magnetic compounds) — Table 4 candidate list"
  |> "[@x_arxiv_2509_05909]  ML magnetic-order classification"
  |> "[@x_arxiv_2507_01913]  Structure-based ML for magnetic ordering"

# ────────────────────────────────────────────────────────────────────
# External anchors — arxiv 2024-2026 + supporting press
# ────────────────────────────────────────────────────────────────────

@X x_arxiv_2507_01849 := "Data-driven high-throughput search for REE-free PMs" :: arxiv-paper [active d=2025-07]
  url       = "https://arxiv.org/abs/2507.01849"
  finding   = "DFT screen on binary alloys → final 10 candidates: FeSn / CrSb / Mn2Sb (Tc=2270K, K=1.57 MJ/m³) / FeB / FeNi / Fe2P / Fe3Ga / FeGe / ZnFe (Ms=1.15T, K=0.76, κ=0.85) / Fe8N (Ms=1.21T, K=0.57, κ=0.70). ZnFe + Fe8N highlighted as novel."
  role      = "primary anchor for TRACK 4 binary intermetallic candidates"
  correction = "earlier-recorded 'Mn₂MoB₄ / Mn₂WB₄' assertion was from a low-confidence web-search summary and does NOT appear in this paper's final 10; directly verified via arxiv HTML 2026-05-17"

@X x_beeson_2025_adv_mater := "Beeson et al. — C16 Phase High-Entropy Borides with High Magnetic Anisotropy" :: peer-reviewed [active d=2025]
  doi     = "10.1002/adma.202516135"
  journal = "Advanced Materials (2025)"
  role    = "primary peer-reviewed anchor for TRACK 4 high-entropy boride family (3d transition metals + B in C16 phase)"
  honesty = "press release (Georgetown via phys.org 2026-01) omits the exact composition; full paper required for stoichiometry + measured K1 / Tc values"

@X x_arxiv_2501_01607 := "Unveiling potential candidates for REE-free magnets" :: arxiv-paper [active d=2025-01]
  url     = "https://arxiv.org/pdf/2501.01607"
  finding = "complementary candidate enumeration; intermetallic + transition-metal-rich phases"

@X x_arxiv_2506_22569 := "Toward Sustainable REE Production — TEA + LCA + Social" :: arxiv-paper [active d=2025-06]
  url       = "https://arxiv.org/abs/2506.22569"
  finding   = "Nd is 63-89 wt% of REE content in NdFeB; recycling must hit higher rates; hydromet material costs dominate OPEX"
  role      = "primary anchor for TRACK 1 recycling"

@X x_arxiv_2504_10495 := "REE Recovery from Phosphogypsum" :: arxiv-paper [active d=2025-04]
  url     = "https://arxiv.org/abs/2504.10495"
  finding = "bio-inspired adsorptive separation treatment train for secondary REE source from fertilizer waste"

@X x_arxiv_2504_07007 := "Data-Driven Insights into REE Mineralization (ML on hydrothermal data)" :: arxiv-paper [active d=2025-04]
  url     = "https://arxiv.org/abs/2504.07007"
  finding = "ML predicts product elements + phases from synthesis conditions; usable for industrial separation tuning"

@X x_arxiv_2509_05909 := "Learning Magnetic Order Classification from Large-Scale DBs" :: arxiv-paper [active d=2025-09]
  url     = "https://arxiv.org/abs/2509.05909"
  finding = "MAGNDATA-trained classifiers reach >92% accuracy on propagation vectors"

@X x_arxiv_2507_01913 := "Structure-based ML for magnetic ordering + moment" :: arxiv-paper [active d=2025-07]
  url     = "https://arxiv.org/abs/2507.01913"
  finding = "refined descriptor generalizes across 5741 stable binary + ternary Fe/Mn/Co compounds"

@X x_arxiv_2409_15675 := "NEMAD — Northeast Materials Database (magnetic)" :: arxiv-paper [active d=2024-09]
  url       = "https://arxiv.org/html/2409.15675v1"
  published = "Nature Communications 16, 9415 (2025) — s41467-025-64458-z"
  finding   = "67,573 LLM-extracted entries; 90% ferro/antiferro/non-mag classification accuracy; Table 4 → 62 FM candidates Tc>500K (Ensemble-NN + XGBoost + RF). Top REE-free: Ga₃Fe₄Co₈Si, FeCo₂Ge, GaFe₂Co₄Si, Fe₃Co₃Si₂, MnCo₂Si — all Fe-Co intermetallics"
  role      = "primary anchor for TRACK 6 AI discovery; FeCo₂Ge selected for hxm-mag-aifound-001"

@X x_arxiv_2312_02475 := "ML predictions of coercivity in high-performance PMs" :: arxiv-paper [active d=2023-12]
  url     = "https://arxiv.org/abs/2312.02475"
  finding = "coercivity ML predictor; usable for Dy/Tb substitution design"

@X x_arxiv_2605_02926 := "Geostrategic Critical Minerals + Materials Resilience" :: arxiv-paper [active d=2026-05]
  url     = "https://arxiv.org/abs/2605.02926"
  finding = "QCCM dashboard for quantum-tech criticality; methodology transfers to REE"

@X x_arxiv_2508_00556 := "Systemic Trade Risk Suppresses Comparative Advantage in REE Industries" :: arxiv-paper [active d=2025-08]
  url     = "https://arxiv.org/html/2508.00556v1"
  finding = "downstream REE-dependent industries see >50% productivity loss under trade-shock scenarios"

@X x_arxiv_2506_11645 := "Expert-Insight Modeling of Non-Kinetic Strategic Deterrence (REE)" :: arxiv-paper [active d=2025-06]
  url     = "https://arxiv.org/abs/2506.11645"
  finding = "simulation-driven framework for REE supply-disruption deterrence scenarios"

@X x_arxiv_2512_20317 := "Critical Minerals in the Indian Context" :: arxiv-paper [active d=2025-12]
  url     = "https://arxiv.org/abs/2512.20317"
  finding = "copper tailings + fly-ash + e-waste as underutilized REE feedstock"

@X x_arxiv_2405_01128 := "REE-based magnetocaloric intermetallics for H₂ liquefaction" :: arxiv-paper [active d=2024-05]
  url     = "https://arxiv.org/html/2405.01128v3"
  finding = "criticality-aware review of Gd-based magnetocaloric materials"

@X x_pmc_securing_2024 := "Securing REE Permanent Magnet Needs for Sustainable Energy" :: review [active d=2024]
  url     = "https://pmc.ncbi.nlm.nih.gov/articles/PMC11595260/"
  finding = "Dy/Tb minimization via Ce/La substitution at grain boundaries; production-scale routes"

@X x_acs_lca_2024 := "LCA of REE-Free PM Alternatives — Sintered Ferrite + Mn-Al-C" :: paper [active d=2024]
  url     = "https://pubs.acs.org/doi/10.1021/acssuschemeng.3c02984"
  finding = "ferrite + Mn-Al-C beat NdFeB on cradle-to-gate impact per kg, but require 5-10× volume for equal flux"

@X x_climate_change_news_2026 := "The energy transition has a rare earth problem — startups solving it" :: press [active d=2026-05]
  url     = "https://www.climatechangenews.com/2026/05/05/the-energy-transition-has-a-rare-earth-problem-these-startups-are-solving-it/"
  finding = "recycling + substitution roadmap; ~40% demand offset ceiling for mobility magnets via recycling"

@X x_phys_org_2026_boride := "Georgetown — new class of strong magnets uses earth-abundant elements" :: press [active d=2026-01]
  url     = "https://phys.org/news/2026-01-class-strong-magnets-earth-abundant.html"
  finding = "quinary boride compositions exceed prior REE-free high-entropy magnet records"

@X x_sciencedaily_2026_ai := "AI breakthrough could replace REE magnets in EVs" :: press [active d=2026-02]
  url     = "https://www.sciencedaily.com/releases/2026/02/260218031611.htm"
  finding = "67,000-compound AI DB; 25 promising high-Tc candidates surfaced (matches NEMAD)"

# ────────────────────────────────────────────────────────────────────
# Governance — what counts as a real alternative
# ────────────────────────────────────────────────────────────────────

@D g1_substitution_defined := "what-counts-as-alternative" :: governance [required active d=2026-05-17]
  rule <<~EOF
    A REE alternative is admitted to this file IFF at least one holds:
      (a) eliminates ≥1 REE element from the magnetic phase (TRACK 2/3/4),
      (b) reduces Dy/Tb content by ≥50% at equal envelope (TRACK 5),
      (c) replaces virgin REE with secondary feedstock at >25% mass (TRACK 1),
      (d) surfaces a candidate not previously enumerated in MP / GNoME / OMat24
          databases at design time (TRACK 6 — only when this novelty holds).
    "Marketing-grade" substitution (e.g., AlNiCo for niche industrial) without
    quantitative envelope-match is NOT in scope.
  EOF
  why = "without a quantitative gate, every iron-based magnet becomes a 'rare-earth alternative' marketing claim. Real engineering replacement requires envelope-match + heavy-REE reduction."
  |> "TRACK 1-6 §performance and §approach fields"

@D g2_real_limits_first := "anchor-to-real-magnetic-physics" :: governance [required active d=2026-05-17]
  rule    = "Performance ceilings are bounded by real magnetic physics ((BH)max upper bound ≈ 64 MGOe for NdFeB at theoretical density; Hc/Hk Brown's relation), NOT by n=6 lattice fits."
  anchors = ["Stoner-Wohlfarth single-domain limit", "Brown's coercivity inequality", "anisotropy field H_K = 2K₁/μ₀M_s"]
  ?> "[@x_lattice_policy] §1.2 real-limits catalogue"
  ?> "[[LIMIT_BREAKTHROUGH]]  (Wave M magnet entries: NdFeB / SmCo / Mn-Al-C walls)"

@D g3_arxiv_freeze := "arxiv-snapshot-2025-04-to-2026-05" :: governance [recommended active d=2026-05-17]
  rule = "@X arxiv citations in this file are frozen to the 2025-04 → 2026-05 literature wave that motivated TRACK 4-6 selection. New literature triggers a NEW @X entry (do NOT silently rewrite an existing one)."
  why  = "preserve the evidence base future maintainers can replay; arxiv preprints get revised — pinning the URL + finding line documents what we read when."

# ────────────────────────────────────────────────────────────────────
# Forbidden patterns
# ────────────────────────────────────────────────────────────────────

@F f1_lab_mm_strength_claim := "lab-mm performance ≠ production performance" :: anti-pattern [denied d=2026-05-17]
  rule = "Lab-scale single-crystal / thin-film / mm-sample magnetic performance MUST NOT be presented as production-grade. Always tag: lab-scale / pilot / production."
  examples <<~EOF
    Fe₁₆N₂ thin-film (BH)max ~135 MGOe (Coey et al.) ≠ producible bulk magnet
    Mn-Al-C τ-phase 12 MGOe (mechanochemical lab) ≠ sintered pellet 12 MGOe
    CNT yarn 80 GPa (lab-mm) ≠ structural-cable strength
  EOF
  fix = "every performance claim gets a (lab-mm | pilot | production) tag; absent tag → reject"

@F f2_ai_prediction_as_measurement := "DFT / ML predictions ≠ measurements" :: anti-pattern [denied d=2026-05-17]
  rule = "DFT MAE, ML coercivity, NEMAD high-Tc candidates are PREDICTIONS. Tag SIM-DFT / SIM-NNP / SIM-PROXY in NOVEL.md. Promotion to EXTERNAL-VERIFIED requires attributed external measurement."
  inherits-from = "[[AGENTS]] @F f2 predictions-promoted-to-measurements"
  |> "selftest/c_handoff_completeness_audit.py"

@F f3_recycling_silver_bullet := "recycling does not zero out new mining" :: anti-pattern [denied d=2026-05-17]
  rule = "Claims that recycling can supply >40% of NdFeB demand in the next decade are not supported by feedstock availability (EoL wave timing) — see TRACK 1 ceiling."
  why  = "EV motor + wind nacelle recycling waves are 10-20 years out due to asset life; HDD wave is shrinking due to SSD displacement."

@F f4_quinary_boride_overclaim := "high-entropy boride claims need source-discrimination" :: anti-pattern [denied d=2026-05-17]
  rule <<~EOF
    Two distinct claims must NOT be conflated:
      (a) Beeson 2025 Adv. Mater. C16 high-entropy boride — peer-reviewed,
          some measured anisotropy; exact composition + bulk (BH)max NOT in
          press release; need full paper for synthesis-readiness claim
      (b) arxiv:2507.01849 binary intermetallics (FeSn / Mn2Sb / ZnFe / ...) —
          DFT predicted MAE + Tc ONLY; no bulk magnetic measurement
    Mn₂MoB₄ / Mn₂WB₄ have NOT been confirmed in either source; do NOT cite
    those formulas as boride candidates without a direct paper-level reference.
  EOF
  fix  = "TRACK 4 candidates stay in NOVEL.md DESIGN status until experimental Hc + (BH)max measured at bulk scale"

# ────────────────────────────────────────────────────────────────────
# Novel-ledger seeds — feeds NOVEL.md §3.5
# ────────────────────────────────────────────────────────────────────

@N mp_lookup_2026_05_17 := "Materials Project lookup — RESOLVED" :: investigation [active d=2026-05-17]
  attempted = "TRACK 4b / TRACK 6 candidates promotion DESIGN → SIM-DFT via MP record cross-reference"
  outcome   = "DONE — MP_API_KEY provisioned (secret vault). mp-api 0.45.9 package itself unusable (pymatgen 2024.8.9 ↔ emmet-core 0.84.6rc4 SymmetryUndeterminedError conflict on Python 3.9) → queried MP REST summary API directly via stdlib urllib."
  results <<~EOF
    FeCo2Ge  → mp-22300  Fm-3m full Heusler · ordering=FM · E_hull=0 (stable) · M_tot=6.0 μB
    Mn2Sb    → mp-20664  P4/nmm tetragonal  · ordering=FM · E_hull=0 (stable) · M_tot=15.16 μB
               (metastable polymorphs mp-6912 P6₃/mmc, mp-1008875 F-43m also exist)
  EOF
  promotion = "hxm-mag-mn2sb-001 + hxm-mag-aifound-001 → DESIGN promoted to SIM-DFT (MP DFT ordering + E_hull). hxm-mag-boride-001 → SIM-NNP via CHGNet relax of the (FeCoNiMn)₂B C16 ordered approximant (ubu-1 GPU, 2026-05-18) — the disordered quinary has no MP record."
  honesty   = "SIM-DFT = MP DFT prediction cross-ref ONLY; Tc / (BH)max remain UNVERIFIED (MP has no Tc field)."
  followup  = "mp_api_smoke.py adapter needs a pymatgen/emmet version fix OR a stdlib-REST fallback path so future MP lookups produce a proper §6 sim handle"
  ~> "@N mp_lookup_attempt_2026_05_17"

@N seed_novel_md := "NOVEL.md §3.5 hxm-mag-* roster (11 total: 6 seeded + 2 added + 3 pre-existing cross-ref'd)" :: planned-edit [active d=2026-05-18]
  seeded-by-this-domain = [
    "hxm-mag-boride-001  : (FeCoNiMnCr)₂B C16 — Beeson Adv. Mater. 2025 (TRACK 4a) — SIM-NNP (CHGNet relax of (FeCoNiMn)₂B C16 ordered approximant on ubu-1; disordered quinary has no MP record)",
    "hxm-mag-mn2sb-001   : Mn₂Sb P4/nmm — arxiv:2507.01849 (TRACK 4b) — SIM-DFT mp-20664",
    "hxm-mag-mnalc-001   : MnAl τ-phase (TRACK 3) — SIM-DFT mp-771",
    "hxm-mag-ferrhd-001  : SrFe₁₂O₁₉ M-type (TRACK 2) — DESIGN (mp-3742 E_hull=0.072 DFT-metastable)",
    "hxm-mag-lowdy-001   : (Nd,Ce,La)₂Fe₁₄B (TRACK 5) — SIM-DFT mp-5182 (base Nd₂Fe₁₄B; Ce/La sub stays design)",
    "hxm-mag-aifound-001 : FeCo₂Ge (TRACK 6) — SIM-DFT mp-22300",
    "hxm-mag-gfcs-001    : Ga₃Fe₄Co₈Si — NEMAD highest-Tc (TRACK 6) — SIM-DFT mp-1225352 (added 2026-05-18)",
    "hxm-mag-znfe-001    : ZnFe — arxiv:2507.01849 top-10 (TRACK 4b) — DESIGN (mp-1215473 E_hull=0.023) (added 2026-05-18)"
  ]
  pre-existing-cross-refd = [
    "hxm-mag-refree-001 (Fe₁₆N₂) → SIM-DFT mp-555 (Fe₈N≡Fe₁₆N₂)",
    "hxm-mag-tetra-001 (tetrataenite L1₀ FeNi) → SIM-DFT mp-2213",
    "hxm-mag-mnbi-001 (MnBi LTP) → DESIGN (mp-568382 E_hull=0.21)"
  ]
  promotion-rule = "DESIGN → SIM-DFT when an MP record exists with magnetic ordering confirmed AND E_hull ≤ 0.01 eV/atom (structural-stability proxy, NOT a property measurement — Tc/(BH)max/Hc stay UNVERIFIED per @F f2)"
  note   = "TRACK 1 (recycling) is a PROCESS track, not a de-novo material → does NOT get a hxm-mag-* entry; lives in RECYCLING.tape per NOVEL §0 scope boundary."
  -> "NOVEL.md §3.5 Magnetic materials (rare-earth-free)"

# ────────────────────────────────────────────────────────────────────
# Cross-link hooks
# ────────────────────────────────────────────────────────────────────

@H h1_xlink_rare_earth := "links-to-element-family" :: cross-link [active d=2026-05-17]
  ?> "[[RARE-EARTH]]"
  why = "element-family detail (which REE goes where) lives in RARE-EARTH.tape; this file only references it"

@H h2_xlink_magnetic := "links-to-magnetic-materials-verb" :: cross-link [active d=2026-05-17]
  ?> "[[MAGNETIC-MATERIALS]]"
  why = "MAGNETIC-MATERIALS.tape covers the verb itself (process / characterization / parity gates); this file is the alternative-track lens"

@H h3_xlink_recycling := "links-to-recycling-domain" :: cross-link [active d=2026-05-17]
  ?> "[[RECYCLING]]"
  ?> "[[HEXA-RECYCLE]]"
  why = "TRACK 1 (NdFeB hydromet recycling) is fully owned by RECYCLING.tape; this file references it without duplicating"

@H h4_xlink_critical_mineral := "links-to-broader-critical-mineral-context" :: cross-link [active d=2026-05-17]
  ?> "[[CRITICAL-MINERAL]]"
  why = "Ga / Ge / Sb / W / Co / Li export-control context lives in CRITICAL-MINERAL.tape; REE is one of many"

# ─── §Log (append @A / @D events here, chronological) ────────────────
#
#   @A commit_<hash> :: rare-earth+alternative [d=<YYYY-MM-DD> ok]
#     <- <prev-id>
#     => "<one-line description>"
#
# See ~/core/tape/spec/tape.md for full grammar.
