#!/usr/bin/env tape
# ══════════════════════════════════════════════════════════════════════
# RARE-EARTH+ALTERNATIVE.log.tape — append-only event history
# ══════════════════════════════════════════════════════════════════════
# Per AGENTS.tape @D g_arch_vs_log_split.
# Architecture sibling: RARE-EARTH+ALTERNATIVE.tape
# ══════════════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@A genesis_2026_05_17 := "RARE-EARTH+ALTERNATIVE.tape created" :: assistant [d=2026-05-17 ok]
  => "6-track REE substitution roadmap seeded (recycling · ferrite-hd · Mn-Al-C · boride · low-Dy/Tb · AI-found); 14+ arxiv 2024-2026 anchors; 4 forbidden patterns; 5 hxm-mag-* candidates seeded in NOVEL.md §3.5"

@D correction_2026_05_17 := "Mn₂MoB₄ misattribution corrected" :: decision [d=2026-05-17 ok]
  <- "@A genesis_2026_05_17"
  => "initial web-search summary mis-attributed Mn₂MoB₄ / Mn₂WB₄ to arxiv:2507.01849 boride family. Direct arxiv HTML fetch confirms paper's actual 10 candidates are FeSn / CrSb / Mn₂Sb / FeB / FeNi / Fe2P / Fe3Ga / FeGe / ZnFe / Fe8N — no boride formulas appear. Beeson 2025 Adv. Mater. C16 high-entropy boride (DOI 10.1002/adma.202516135) added as separate peer-reviewed boride anchor. Mn₂Sb (predicted Tc=2270K, K=1.57 MJ/m³) added as new NOVEL candidate hxm-mag-mn2sb-001."
  |> "RARE-EARTH+ALTERNATIVE.tape @L t4_boride correction-note field + @X x_beeson_2025_adv_mater added"

@N mp_lookup_blocked_2026_05_17 := "Materials Project live lookup blocked" :: investigation [d=2026-05-17]
  attempted = "promote hxm-mag-boride-001 DESIGN → SIM-DFT via MP cross-reference"
  outcome   = "BLOCKED — mp_api package + MP_API_KEY both absent in environment"
  evidence  = "mp_api_smoke.py --selftest PASS (offline fixture only)"
  next-step = "user installs mp-api>=0.41.0 + sets MP_API_KEY → re-run with composition / mp-id query"

@A deepen_2026_05_17 := "TRACK 4/6 candidate specification deepened" :: assistant [d=2026-05-17 ok]
  <- "@D correction_2026_05_17"
  => "Beeson C16 boride detail extracted: Fe/Co sublattice mixing flips easy-plane→easy-axis anisotropy, >2× coercivity vs binary/ternary; thin-film (combinatorial sputter) — bulk NOT demonstrated. hxm-mag-boride-001 falsifier F-MAG-4 retargeted to thin-film K₁ + bulk-synthesis-demo gate."
  => "NEMAD Table 4 fetched (arxiv:2409.15675 HTML): 62 FM candidates Tc>500K. Top REE-free Fe-Co intermetallics: Ga₃Fe₄Co₈Si / FeCo₂Ge / GaFe₂Co₄Si / Fe₃Co₃Si₂. hxm-mag-aifound-001 specialized to FeCo₂Ge (Heusler-like, 3-model Tc consensus 999/1051/1068 K, simple composition)."

@N mp_api_installed_2026_05_17 := "mp-api package installed" :: investigation [d=2026-05-17]
  <- "@N mp_lookup_blocked_2026_05_17"
  outcome   = "mp-api 0.45.9 + pymatgen 2024.8.9 now installed (pip3, user site-packages)"
  remaining = "MP_API_KEY env var still NOT set — user must obtain a free key at materialsproject.org/api and export it"
  next-step = "once MP_API_KEY set: query MP for FeCo₂Ge / Mn₂Sb / Beeson-composition records → promote candidates DESIGN → SIM-DFT"

@A mp_query_2026_05_17 := "Materials Project cross-reference completed" :: assistant [d=2026-05-17 ok]
  <- "@N mp_api_installed_2026_05_17"
  => "MP_API_KEY provisioned via secret vault. mp-api 0.45.9 package unusable (pymatgen 2024.8.9 ↔ emmet-core 0.84.6rc4 SymmetryUndeterminedError conflict on Python 3.9) → queried MP REST summary API directly with stdlib urllib."
  => "FeCo₂Ge → mp-22300 (Fm-3m full Heusler, FM, E_hull=0 stable, M=6.0 μB). Mn₂Sb → mp-20664 (P4/nmm tetragonal, FM, E_hull=0 stable, M=15.16 μB) — P4/nmm matches the arxiv:2507.01849 'tetragonal' candidate, not the metastable mp-6912/mp-1008875 polymorphs."
  => "hxm-mag-mn2sb-001 + hxm-mag-aifound-001 promoted DESIGN → SIM-DFT. hxm-mag-boride-001 stays DESIGN (Beeson C16 composition not public)."

@? mp_api_version_conflict := "mp-api adapter blocked by dependency conflict" :: anomaly [d=2026-05-17]
  detail = "mp-api 0.45.9 pulls emmet-core 0.84.6rc4 which imports SymmetryUndeterminedError from pymatgen.symmetry.analyzer — absent in pymatgen 2024.8.9 (last Python-3.9-compatible release)"
  impact = "_absorption_bridge/materials_project/mp_api_smoke.py live path (--mp-id) is unusable until resolved; --selftest offline path unaffected"
  workaround = "MP REST summary API direct call via stdlib urllib (no mp-api / pymatgen dependency)"
  fix-options = ["upgrade Python to 3.10+ then upgrade pymatgen", "pin emmet-core to a pymatgen-2024.8.9-compatible release", "add a stdlib-REST fallback path to mp_api_smoke.py"]

@A beeson_deep_research_2026_05_17 := "Beeson C16 composition + structure resolved via web deep research" :: assistant [d=2026-05-17 ok]
  <- "@A mp_query_2026_05_17"
  => "Adv. Mater. paper itself paywalled, but composition + structure extracted from abstract + Georgetown press + Fe-Co-B literature: C16 = tetragonal I4/mcm (No.140) CuAl₂-type M₂B; quinary 3d-TM = Fe·Co·Ni·Mn·Cr; named film (FeCoNiMn)₂B 50 nm a=5.05 c=4.25 Å; Fe/Co easy-plane→easy-axis switch (x=0.3 K₁≈410 kJ/m³); DFT anisotropy ~1×10⁷ erg/cm³."
  => "MP cross-ref of C16 endmembers via the new --formula path: Fe₂B mp-1915 (I4/mcm FM E_hull=0), Co₂B mp-493 (I4/mcm FM), Ni₂B mp-2536 (I4/mcm NM), Mn₂B mp-20318 (I4/mcm AFM)."
  => "hxm-mag-boride-001 STAYS DESIGN — endmembers confirm the C16 lattice but the disordered quinary high-entropy composition has no single MP record; SIM-DFT would need an ordered approximant or a direct DFT run."

@A novel_full_sweep_2026_05_18 := "NOVEL §3.5 full MP cross-reference sweep" :: assistant [d=2026-05-18 ok]
  <- "@A beeson_deep_research_2026_05_17"
  => "Swept all §3.5 hxm-mag-* via the stdlib-REST --formula path (dogfooding 877e50c). Promotion rule: DESIGN → SIM-DFT iff MP record with confirmed magnetic ordering AND E_hull ≤ 0.01 eV/atom."
  => "Promoted: refree-001↔mp-555 (Fe₈N≡Fe₁₆N₂), tetra-001↔mp-2213 (FeNi L1₀), mnalc-001↔mp-771 (MnAl), lowdy-001↔mp-5182 (base Nd₂Fe₁₄B). New: gfcs-001↔mp-1225352 (Ga₃Fe₄Co₈Si, NEMAD highest-Tc, SIM-DFT), znfe-001↔mp-1215473 (ZnFe, DESIGN, metastable)."
  => "Kept DESIGN: ferrhd-001 (mp-3742 E_hull=0.072 — DFT over-penalises this commercial-stable oxide), mnbi-001 (mp-568382 0.21), boride-001 (no single MP record for the disordered quinary)."
  => "§3.5 roster now 11 entries: 7 SIM-DFT + 4 DESIGN. All Tc/(BH)max/Hc remain UNVERIFIED (MP carries no Tc; E_hull is a stability proxy only)."

@? selftest_raw10_collateral_2026_05_18 := "user raw#10 cleanup broke 7 selftest gates" :: anomaly [d=2026-05-18]
  detail = "selftest/run_all.sh → 7/38 FAIL. Root cause: the user's in-flight raw#10 C3 cleanup deletes every line containing the string 'raw#10 C3' — including code identifier lines like `_RISK_TOKENS = (... 'raw#10 C3')` in cross_link_integrity_audit.py, causing NameError. 25 selftest scripts show pure-deletion diffs (44 deletions, 0 insertions)."
  impact = "FAIL is a working-tree artifact of an unfinished user cleanup, NOT caused by any hexa-matter domain/bridge commit this session (none of which touch selftest/)."
  not-mine = "true — flagged to user; cleanup script needs an identifier-safe match (avoid deleting code tokens that merely contain the literal 'raw#10 C3')"

@A boride_simnnp_2026_05_18 := "hxm-mag-boride-001 DESIGN → SIM-NNP via CHGNet" :: assistant [d=2026-05-18 ok]
  <- "@A beeson_deep_research_2026_05_17"
  => "boride-001 disordered quinary (FeCoNiMnCr)₂B has no single MP record → built the C16 (FeCoNiMn)₂B ordered approximant (I4/mcm M₂B, M-8h decorated Fe/Co/Ni/Mn) and ran a real CHGNet 0.4.2 relaxation on the wilson compute pool (ubu-1, NVIDIA RTX 5070)."
  => "Result: relaxes stably (a 5.05→5.02 Å, c 4.25→4.23 Å — within 0.5% of the Beeson named film), retains a magnetic moment (|magmom| 0.64 μB/atom; Fe₂B C16 control 1.32). Snapshot: _absorption_bridge/universal_ff/predictions/hxm-mag-boride-001.json."
  => "hxm-mag-boride-001 promoted DESIGN → SIM-NNP (real universal-FF computation). CHGNet resolves neither FM/AFM ordering nor K₁ — F-MAG-4 stays UNVERIFIED, wet-lab handoff C-MET-3 open. roster: 7 SIM-DFT + 1 SIM-NNP + 3 DESIGN."

# ─── append new events below this line ───
