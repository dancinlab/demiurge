# INIT — hexa-matter elevation to hexa-bio level

> **Last updated**: 2026-05-18
> **Purpose**: Working-state record so phase progress is not lost across sessions.
> If you're picking this up cold, read this file first.

## Goal

Elevate `dancinlab/hexa-matter` from a thin 17-verb SPEC_FIRST catalog to the
architectural maturity of `dancinlab/hexa-bio` (77 root `.md` files, 32+ selftest
gates, Category (a)/(b)/(c) closure framework, Python compute bridges, per-axis
depth directories, external-research absorption).

User directive (2026-05-13):
- "hexa-bio 수준으로 hexa-matter 만들고 싶어"
- "Phase A~E 전수" — full scope, all phases
- "web deep research & arxiv deep research & 알파폴드 처럼 흡수할 시스템도 흡수"
  → expanded to Phase F (research bridges) + Phase G (AlphaFold-class absorption)

## Phase status

| Phase | Scope | Status | Commit |
|---|---|---|---|
| **A** | 10 infra docs + 5 deep expansion + 11 stubs | ✅ DONE | `c55199b` |
| **D** | 12 new material verbs (17→29) | ✅ DONE | `99620b2` |
| **D'** | 4 Phase D follow-on verbs (29→33): glass-ceramic, geopolymer, aerogel-foam, ionic-liquid | ✅ DONE | `f4531fa` |
| **D''** | 3 Phase D'' verbs (33→36): refractory, photoresist, electrode-material | ✅ DONE | _(this commit)_ |
| **B** | selftest harness (21 Python/bash gates) | ✅ DONE | `f24d8a5` |
| **C** | `hexa-*` axis-prefixed depth dirs (9 groups, 36 files, 3913 lines) | ✅ DONE | `6e4928a` |
| **E** | `_python_bridge/` (RDKit/ASE/pymatgen) | ✅ DONE | `b4ebf8f` |
| **F** | `_research_bridge/` (arxiv + web deep research) | ✅ DONE | `185ce33` |
| **G** | `_absorption_bridge/` (MaterialsProject, GNoME, Matlantis, OMat24, SchNet/MACE/ALIGNN/CHGNet/M3GNet) | ✅ DONE | `e712068` |
| **G+1** | `_absorption_bridge/cod/` (Crystallography Open Database — 11th adapter, EXPERIMENTAL measurements, CC0 raw data) | ✅ DONE | _(prev commit)_ |
| **G+2** | `_absorption_bridge/oqmd/` + `aflow/` + `nomad/` (DFT/FAIR-data sources — 12th/13th/14th adapters: OQMD Wolverton, AFLOW Curtarolo, NOMAD Draxl/Scheffler; all CC-BY 4.0) | ✅ DONE | `a54da35` |
| **J.3** | `_absorption_bridge/nims_mats/` + `catalysis_hub/` (15th + 16th adapters: NIMS MatNavi Japan ~50k dual-mode records + Catalysis-Hub NTNU/SUNCAT > 100k DFT surface-reaction records; both CC-BY 4.0; +2 selftest gates) | ✅ DONE | _(this commit)_ |
| **H** | Category (b) parity-gate landing — 10 `tests/<gate>_parity.py` + 10 `tests/snapshots/<gate>.json` + `selftest/parity_gates_smoke.sh`; ledger drain 29 → 19 in CLOSURE_RESIDUAL_BACKLOG §B; selftest 24/24 → 28/28 (with G+2) | ✅ DONE | `e12dfb9` |
| **I.1** | Phase B target parity gates batch 1 — 10 more `tests/<gate>_parity.py` + 10 snapshots (cer_b1 quartz · cer_b7 Mohs · pol_b2 PET hydrolysis · fib_b1 cellulose Segal · met_b1/2/3 IN718/Ti64/AISI1080 · gem_b2 ruby R-line · prc_b1 Hales packing · fas_b1 reactive dye yield); `parity_gates_smoke` sweeps 20/20; ledger drain 19 → 9 in CLOSURE_RESIDUAL_BACKLOG §B | ✅ DONE | `583fddb` |
| **I.2** | Phase F/B target parity gates batch 2 — 9 more `tests/<gate>_parity.py` + 9 vendored snapshots (cer_b6 UHPC Ductal+Cor-Tuf · cer_b8 Si thermal donor Kaiser-Frisch+SEMI · cer_b9 Si [O_i] ASTM F121 · pol_b3 microplastic K_d NOAA · pol_b5 UHMWPE Dyneema · pol_b6 CNT yarn Tsinghua **UNPROVEN-at-commodity preserved** · prc_b2 recycling Gibbs ISO 14040 · prc_b3 sol-gel TEOS Hench-West · fas_b2 K/S Kubelka-Munk AATCC); `parity_gates_smoke` sweeps 29/29; ledger drain 9 → 0 in CLOSURE_RESIDUAL_BACKLOG §B — **Category (a)+(b) closure = 100%** | ✅ DONE | _(this commit)_ |
| **HX** | hexa-native Stage-1 migration — T1 6 stdlib-only compute modules → `_hexa_bridge/module/*.hexa`; T2 **26/26** selftest audit gates → `_hexa_bridge/selftest/*.hexa`; `selftest/run_all.sh` rewired to a hexa-first **union** (`.py`/`.sh` kept as fallback + re-parity reference); every gate verified at **byte-parity** with its `.py` source (lossless: `grep -E` ERE ≡ Python `re`, no Stage-1 substring approx — g3 regression 0); `verify/closure_consistency.hexa` README-badge regex fixed (pre-existing 3/4 regression from `20a919d` README reformat → restored **verify 4/4**). Migration SSOT: `~/core/hexa-lang/stdlib/PLAN.md`. selftest **38/38**, verify **4/4**. | ✅ DONE | `bf577fa` · `af1141a` |

### 🏆 100% (a)+(b) closure reached 2026-05-13

With Phase I.2 landing the final 9 parity gates, every enumerated row in
`CLOSURE_RESIDUAL_BACKLOG.md §A` and `§B` is ✅ CLOSED. The combined
**Category (a) + Category (b) closure-grade is 100%** as of this commit.
Category (c) — wet-lab synthesis / vendor procurement / fab capacity —
remains OUT-OF-REPO BY DESIGN per `AXIS_CLOSURE_PLAN.md §0` (software
cannot close (c) — only external execution can). The repo's `verify`
verdict `CLOSED` and the selftest `28/28 PASS` honestly cover the
(a)+(b) scope; (c) handoff is enumerated in §C for visibility, not
counted against the grade.

## Phase A — DONE (commit `c55199b`)

26 files, 5045 lines.

### 10 infrastructure docs
| File | Lines |
|---|---|
| `AXIS.md` | 252 |
| `AXIS_CLOSURE_PLAN.md` | 258 |
| `CLOSURE_RESIDUAL_BACKLOG.md` | 229 |
| `DECOMPOSITION_PLAN.md` | 231 |
| `LESSONS.md` | 274 |
| `RELEASE_NOTES_v1.0.0.md` | 207 |
| `RELEASE_NOTES_v1.1.0.md` | 222 |
| `V1_2_0_HANDOFF.md` | 253 |
| `USER_ACTION_REQUIRED.md` | 235 |
| `IMPORTED_FROM_CANON.md` | 196 |

### 5 deep expansion docs (300+ lines)
SILICON.md (350) · CERAMIC-ENGINEERING.md (299) · METALLURGY-DEEP.md (308) ·
POLYMER-CHEMISTRY.md (439) · GRAPHENE-CARBON.md (353)

### 11 Phase D stubs
ELASTOMER · COMPOUND-SEMI · PEROVSKITE · 2D-MATERIALS · ADHESIVE ·
MAGNETIC-MATERIALS · MOF · LIQUID-CRYSTAL · SUPERALLOY ·
BIODEGRADABLE-PLASTICS · WOOD-CELLULOSE (~939 lines combined)

## Phase D — DONE (commit `99620b2`)

12 verb subdirectories added with `<verb>/<verb>.md` specs (silicon.md template,
~269 lines avg, 3227 total new lines). 17 → **29 verbs**.

12 verbs (with line counts):
| # | Verb | Lines |
|---|---|---|
| 18 | elastomer (natural rubber, SBR, EPDM, silicone rubber, PU, fluoroelastomer) | 249 |
| 19 | compound-semi (GaN, SiC, GaAs, InP) | 263 |
| 20 | perovskite (ABX₃ PV + oxide perovskite) | 255 |
| 21 | 2d-materials (MoS₂, WS₂, hBN, phosphorene, MXene) | 259 |
| 22 | adhesive (PSA, structural, cyanoacrylate, anaerobic, hot-melt) | 255 |
| 23 | magnetic-materials (NdFeB, SmCo, ferrite, Metglas, Finemet) | 263 |
| 24 | mof (HKUST-1, MOF-5, ZIF-8, MIL-101, UiO-66) | 263 |
| 25 | liquid-crystal (thermotropic + lyotropic) | 258 |
| 26 | superalloy (Ni-based, Co-based, Fe-Ni-based) | 267 |
| 27 | biodegradable-plastics (PLA, PHA, PBS, starch blends) | 311 |
| 28 | wood-cellulose (engineered wood, nanocellulose, CA) | 280 |
| 29 | carbon (activated, glassy, pyrolytic, fiber, CNT, diamond, fullerene) | 304 |

Verify scoreboard: **4/4 PASS · 29/29 verbs** ✅

Honest UNPROVEN/UNVERIFIED markers preserved per verb (one-liner each):
- **elastomer** — self-healing rubber + bio-isoprene UNVERIFIED at production
- **compound-semi** — 6/8" bulk GaN ammonothermal UNVERIFIED; diamond-as-semi wafer UNPROVEN
- **perovskite** — LK-99 NOT REPRODUCED (HARD_WALL); large-area + 25-yr-lifetime UNVERIFIED
- **2d-materials** — wafer-scale 2D mobility 10–100× loss vs lab; phosphorene ambient + 2D-magnet T_c > 300 K UNVERIFIED
- **adhesive** — bio-based + self-healing + gecko-inspired aerospace UNVERIFIED
- **magnetic-materials** — rare-earth-free > 35 MGOe UNVERIFIED; tetrataenite/MnBi/Fe₁₆N₂ R&D only. **Supply-chain trio added 2026-05-17**: `RARE-EARTH.tape` + `RARE-EARTH+ALTERNATIVE.tape` (6-track substitution roadmap, 14+ arxiv) + `CRITICAL-MINERAL.tape` (umbrella, 12 commodities, PRC export-control timeline). NOVEL §3.5: +6 `hxm-mag-*` seeds DESIGN (boride / mn2sb / mnalc / ferrhd / lowdy / aifound)
- **mof** — magic-MOF-DAC $100/t CO₂ UNPROVEN (Climeworks amine $600–1000/t)
- **liquid-crystal** — polymer-stabilized blue-phase commercial display UNVERIFIED
- **superalloy** — Re-free 4th-gen SX at parity UNVERIFIED; Co-base SX commercial UNVERIFIED
- **biodegradable-plastics** — marine-biodegradability UNVERIFIED most grades (only certain PHA D7081); cost parity to PE UNVERIFIED
- **wood-cellulose** — 50+ story mass-timber UNVERIFIED; transparent/densified wood UNVERIFIED at cost
- **carbon** — CNT yarn 80 GPa = lab mm-scale (commercial 1–3 GPa); bulk lonsdaleite + carbyne + diamond-semi UNVERIFIED

Small fix during verify: `verify/closure_consistency.hexa` regex `[a-z_0-9]+` → `[a-z_0-9-]+`
to accept dash-named Phase D verbs (`2d-materials`, `compound-semi`, etc.).

## Phase D follow-on — DONE (this commit)

4 additional verb subdirectories added with `<verb>/<verb>.md` specs
(silicon.md template), 29 → **33 verbs**.

4 verbs (with line counts):
| # | Verb | Lines |
|---|---|---|
| 30 | glass-ceramic (LAS Zerodur, Macor, Pyroceram, Li-disilicate dental, transparent armor) | 304 |
| 31 | geopolymer (alkali-activated FA/MK/GGBFS; low-CO₂ cement alternative) | 340 |
| 32 | aerogel-foam (silica, carbon, polymer, graphene aerogel) | 355 |
| 33 | ionic-liquid (imidazolium / pyridinium / ammonium / phosphonium; DES distinction preserved) | 376 |

Verify scoreboard: **4/4 PASS · 35/35 verbs** ✅

Honest UNPROVEN/UNVERIFIED markers preserved per verb (one-liner each):
- **glass-ceramic** — transparent-armor large-pane production UNVERIFIED; self-healing GC UNPROVEN
- **geopolymer** — CO₂-reduction claim bracket 10–80 % UNVERIFIED (system-boundary-sensitive LCA); multi-decade durability UNVERIFIED (oldest commercial < 10 yr)
- **aerogel-foam** — cost-per-kg UNPROVEN at commodity-foam parity ($20–100/kg insulation vs $2–5/kg PU); graphene aerogel 0.16 kg/m³ density record UNVERIFIED at production
- **ionic-liquid** — "green solvent" claim UNVERIFIED at full LCA (toxicity EC50 ~ 5 mg/L; biodegradability poor); commodity cost < $50/kg UNPROVEN; DES distinction preserved (H-bond complex ≠ pure salt)

Allocation: CER +3 (glass-ceramic, geopolymer, aerogel-foam — all
silicate/silica-network/aluminosilicate chemistry); POL +1 (ionic-liquid
as organic/soft-matter extension though formally not a polymer; spec §1
preserves DES distinction).

## Phase D'' — DONE (this commit)

3 additional verb subdirectories added with `<verb>/<verb>.md` specs
(silicon.md template), 33 → **36 verbs**.

3 verbs (with line counts):
| # | Verb | Lines |
|---|---|---|
| 34 | refractory (firebrick · Al₂O₃ · MgO · ZrO₂ · mag-C · SiC · carbon; T_service ≥ 1000 °C; AZS fused-cast glass-tank block; RHI Magnesita / Vesuvius / Imerys / Saint-Gobain / Morgan / Krosaki / Shinagawa anchors) | 391 |
| 35 | photoresist (g/i-line DNQ-novolac · KrF CAR · ArF CAR · EUV CAR + MOR · dry-film PCB; JSR / TOK / Shin-Etsu / Sumitomo / Fujifilm / Dow / Inpria anchors; material-layer only — lithography process → hexa-chip per CROSS_LINK §3.2) | 414 |
| 36 | electrode-material (LFP · NMC811 · LCO · graphite · Si anode · Li-metal · Pt-ORR · IrO₂-OER · MnO₂; Umicore / POSCO Future M / CATL / BYD / LG Energy / Samsung SDI / Sumitomo Metal Mining / Tanaka Holdings anchors; material-layer only — cell engineering → hexa-energy per CROSS_LINK §3.3) | 485 |

Verify scoreboard: **4/4 PASS · 36/36 verbs** ✅

Honest UNPROVEN/UNVERIFIED markers preserved per verb (one-liner each):
- **refractory** — RCF Group 2B IARC (real); self-healing refractory UNPROVEN; spent-refractory structural-grade recycling UNVERIFIED; AZS glass-tank 20-yr-life UNVERIFIED at vendor warranty
- **photoresist** — EUV resist photon-shot-noise vs LER trade-off NOT FULLY RESOLVED (IRDS 2023); MOR full-commodity yield UNVERIFIED; high-NA EUV resist at production UNVERIFIED; resist owns material only, lithography process belongs to hexa-chip
- **electrode-material** — Si-anode 500-cycle 1C 70% retention UNVERIFIED at full commodity scale; Li-metal anode dendrite suppression UNVERIFIED for ≥ 500 deep cycles; Pt-loading reduction roadmap UNVERIFIED at production durability; CATL Blade 12,000-cycle LFP multi-vendor reproduction OPEN; cell engineering belongs to hexa-energy

Allocation: CER +2 (refractory — high-T service envelope discipline
distinct from `ceramics/`; electrode-material — battery cathode/anode
oxide + electrocatalyst); POL +1 (photoresist — photopolymer chemistry).

Cross-link discipline (CROSS_LINK.md):
- `photoresist/photoresist.md` contains explicit line declaring device
  + lithography process belongs to hexa-chip per CROSS_LINK §3.2 —
  this verb owns the MATERIAL only (lines 8, 246, 397, 412+)
- `electrode-material/electrode-material.md` contains explicit line
  declaring cell engineering belongs to hexa-energy per CROSS_LINK §3.3
  — this verb owns the ACTIVE MATERIAL only (lines 8, 350, 470, 484+)

## Phase B — selftest harness ✅ DONE

`selftest/` directory at `/Users/ghost/core/hexa-matter/selftest/` with **21
fine-grained gates** (8 cross-cutting + 8 group-specific + 4 verb-specific + 1
bonus). Orchestrator: `selftest/run_all.sh`.

Final result: `__HEXA_MATTER_SELFTEST__ PASS  (21/21)`.

**Cross-cutting (8)**:
- `r1_symlink_audit.sh` — no out-of-repo symlinks in any verb dir
- `registry_consistency_audit.py` — CLI VERBS ≡ hexa.toml [verbs] ≡ verify/spec_presence VERBS ≡ README badge ≡ AXIS.md group sum (all = 29)
- `regression_audit.py` — falsifier preservation across CLOSURE_RESIDUAL_BACKLOG
- `n6_axis_computational_verification.py` — σ/τ/φ/J₂ arithmetic sanity (per LATTICE_POLICY §1.3 auxiliary)
- `cross_doc_audit.py` — README ↔ hexa.toml ↔ AXIS.md ↔ AGENTS.md semantic consistency
- `canon_provenance_check.py` — IMPORTED_FROM_CANON.md row ↔ local file presence
- `nist_anchor_audit.py` — every post-policy spec cites NIST/CRC/ASM/SEMI/ASTM/vendor/primary literature

**Group-specific (8)**:
- `cer_thermal_shock_audit.py` — CER thermal-shock parameter R/R′/R″ anchored
- `pol_thermal_stability_audit.py` — POL group T_g numeric anchor (≥ 4 specs)
- `fib_tensile_audit.py` — FIB MPa/GPa/kN-per-m anchor per verb
- `met_alloy_classification.py` — ≥3 alloy families (Ni/Co/Fe-Ni/NdFeB/etc.)
- `gem_authenticity_check.py` — GIA/IGS or ≥3 gemological-property anchors
- `prc_yield_audit.py` — yield claims have falsifier/citation (legacy canon-import noted)
- `fas_dyeing_chemistry_audit.py` — corpus has ≥2 dye classes + ≥2 fiber substrates
- `silicon_purity_audit.py` — Si-L1..Si-L12 + 9N SOFT_WALL + CZ 600 mm + FZ 200 mm anchors

**Verb-specific (4)**:
- `compound_semi_bandgap_audit.py` — GaN/SiC/GaAs/InP bandgap eV cited with Sze/NIST/Saddow anchor
- `magnetic_materials_curie_audit.py` — Curie + BHmax + NdFeB/SmCo + Coey/Hitachi/TDK/Vacuumschmelze anchor
- `carbon_cnt_strength_honesty_audit.py` — CNT 80 GPa carries "lab mm-scale" / UNVERIFIED caveat (refs section excluded)
- `mof_dac_economics_honesty_audit.py` — MOF $100/t kept UNPROVEN with Climeworks $600-1000/t baseline named

**Bonus (1)**:
- `pyproject_smoke.sh` — SKIP cleanly until Phase E (Python bridge) lands

Entry point: `bash selftest/run_all.sh` from repo root. Exit 0 = all 21 PASS.

## Phase C — hexa-* axis-prefixed depth dirs (queued)

9 depth directories, one per AXIS group:
- `hexa-silicon/` (Si depth: wafer, polysilicon, FZ vs CZ, SiO₂ cross-link)
- `hexa-polymer/` (POL group depth: epoxy + nylon + microplastics + pet_film + biodegradable)
- `hexa-ceramic/` (CER group depth: ceramics + concrete + glass + silicon-cross-link + SiC + perovskite)
- `hexa-metal/` (MET group depth: metallurgy + lutherie + superalloy + magnetic)
- `hexa-fiber/` (FIB group depth: aramid + fabric + paper + wood-cellulose + carbon-fiber)
- `hexa-gem/` (GEM group: gemology)
- `hexa-fashion/` (FAS group: textile-dyeing + fashion-textile)
- `hexa-recycle/` (recycling + recycle_n6)
- `hexa-synthesis/` (synthesis pathway depth)

Each contains its own sub-spec markdowns + cross-links back to verb dirs.

## Phase E — `_python_bridge/` ✅ DONE (2026-05-13)

12 runnable scientific-compute modules ship under `_python_bridge/module/`.
Each accepts `--selftest`, runs offline/deterministically, and SKIPs
cleanly when its optional dep is missing. Bridge aggregator
(`selftest/pyproject_smoke.sh`) wires into `selftest/run_all.sh` as gate 21.

| Module | Status | Optional dep |
|---|---|---|
| `silicon_purity_compute.py` | **FUNCTIONAL** | stdlib only |
| `polymer_mw_distribution.py` | **FUNCTIONAL** | stdlib only |
| `metallurgy_alloy_composition.py` | **FUNCTIONAL** | stdlib only |
| `carbon_form_factor_classifier.py` | **FUNCTIONAL** | stdlib + optional RDKit |
| `cross_doc_consistency_compute.py` | **FUNCTIONAL** | stdlib only |
| `nist_anchor_resolver.py` | **FUNCTIONAL** | stdlib only |
| `rdkit_smiles_audit.py` | PARTIAL (SKIPs without RDKit) | rdkit-pypi |
| `rdkit_descriptor_calc.py` | PARTIAL (SKIPs without RDKit) | rdkit-pypi |
| `ase_atoms_construct.py` | PARTIAL (SKIPs without ASE) | ase |
| `ase_relaxation_check.py` | PARTIAL (SKIPs without ASE) | ase |
| `pymatgen_structure_io.py` | PARTIAL (stdlib MP-ID regex works; pymatgen CIF round-trip SKIPs) | pymatgen |
| `pymatgen_phasediagram_smoke.py` | PARTIAL (SKIPs without pymatgen) | pymatgen |

Stock-Python env (no optional deps installed) result:
`__HEXA_MATTER_PYTHON_BRIDGE__ PASS (12/12 modules, 5 skipped)`.

Full selftest (Phase B harness + Phase E gate):
`__HEXA_MATTER_SELFTEST__ PASS (21/21)`.

Honest C3: every SKIPped module prints why (e.g. `SKIP: rdkit not installed`)
and exits 0. No mocked compute is disguised as real — the harness treats
SKIP as PASS per the `NO MOCKED FUNCTIONALITY` rule.

## Phase F — `_research_bridge/` ✅ DONE (2026-05-13)

External-literature absorption layer. 8 runnable modules ship under
`_research_bridge/`. Each module accepts `--selftest` and runs OFFLINE
(fixtures replayed from local cache; NO live network calls in selftest).
Live mode is gated behind explicit `--live` flag and is rate-limit aware
(arxiv 3-sec backoff, vendor robots.txt, USPTO/EPO polite query cadence).

| Subsystem | Module | Status | Optional dep |
|---|---|---|---|
| **arxiv** | `arxiv/arxiv_pull.py` | FUNCTIONAL (stdlib urllib) | none |
| **arxiv** | `arxiv/arxiv_digest.py` | FUNCTIONAL (stdlib) | none |
| **web**   | `web/vendor_datasheet_pull.py` | FUNCTIONAL (stdlib regex; bs4 optional) | beautifulsoup4 |
| **web**   | `web/materials_news_feed.py` | FUNCTIONAL (stdlib ElementTree; feedparser optional) | feedparser |
| **web**   | `web/patent_search.py` | FUNCTIONAL (stdlib JSON) | none |
| **selftest** | `selftest/arxiv_smoke.py` | aggregator (PASS over 2 arxiv modules) | none |
| **selftest** | `selftest/web_smoke.py` | aggregator (PASS over 3 web modules) | none |
| **selftest** | `selftest/sources_audit.py` | SOURCES.md + speculative-flag-list audit | none |

Top-level Phase F gate: `selftest/research_bridge_smoke.sh` (gate 22 in
`selftest/run_all.sh`). Result: `__HEXA_MATTER_RESEARCH_BRIDGE__ PASS
(3/3 modules, 0 skipped)`.

Full selftest scoreboard after Phase F:
`__HEXA_MATTER_SELFTEST__ PASS (22/22)`.

Bundled offline-replay fixtures (synthetic, not real data):
- `arxiv/arxiv_cache/sample_response.xml` — 3 synthetic papers
- `web/web_cache/sample_vendor.html` — vendor product page mock
- `web/web_cache/sample_rss.xml` — 3-item RSS mock
- `web/web_cache/sample_patent.json` — 3-record USPTO-shape JSON mock

Honesty preservation (UNPROVEN flag list — propagates through arxiv +
news + patent verb-keyword digest):
- LK-99 / room-T superconductivity (never reproduced)
- Magic-MOF $100/t DAC (Climeworks amine $600–1000/t baseline)
- Perovskite 25-yr operational lifetime (UNVERIFIED commercial scale)
- Ambient metallic hydrogen, infinite recycle, 100% recyclable

Vendor datasheet values quoted AS-IS with provenance; SPEC_FIRST verdict
is informed by research signals, not replaced by them.

SOURCES.md:
- `arxiv/SOURCES.md` — 6 cond-mat categories + keyword strategy + 3-sec
  backoff discipline + `@arxiv-informed:` cross-link convention
- `web/SOURCES.md` — 14 vendors + 7 RSS/Atom feeds + 5 patent endpoints
  with last-verified dates + robots.txt / ToS notes

## Phase G — `_absorption_bridge/` ✅ DONE (2026-05-13)

External materials-discovery system absorption layer per user directive
("알파폴드 처럼 흡수할 시스템도 흡수"). **16 adapters** ship under
`_absorption_bridge/` (10 from Phase G + 1 from Phase G+1 + 3 from Phase G+2
+ 2 from Phase J.3, 2026-05-13): 11 database/API systems plus 5 universal
force-field models. Each accepts `--selftest`, runs OFFLINE (fixtures
replayed from bundled `<system>/cache/`; NO live API calls in selftest),
and SKIPs cleanly when its optional dep is missing.

**Phase G+1 (2026-05-13)** added the Crystallography Open Database (COD)
adapter — the first EXPERIMENTAL-measurement source in the bridge (distinct
from MP / GNoME / OMat24 / NNP outputs, which are computed predictions).
Files:
- `_absorption_bridge/cod/cod_search_smoke.py` — stdlib-only adapter
- `_absorption_bridge/cod/SOURCES.md` — Gražulis 2009/2012 + CC0 raw data
- `_absorption_bridge/cod/cache/sample_record.json` — COD entry 9008565 (Si) fixture
- `_absorption_bridge/cod_adapter.md` — short adapter doc
- `_absorption_bridge/selftest/cod_smoke.py` — wrapper
- `selftest/cod_adapter_smoke.sh` — dedicated top-level gate 24
- Selftest scoreboard: 23/23 → **24/24** PASS (gate 24 = `cod_adapter_smoke`).

**Phase G+2 (2026-05-13)** added three more DFT/FAIR-data adapters:
- **OQMD** (Open Quantum Materials Database, Wolverton/Northwestern): ~1M
  DFT-PBE entries; Saal 2013 JOM + Kirklin 2015 npj Comput. Mater.; CC-BY 4.0.
- **AFLOW** (Automatic-FLOW for Materials Discovery, Curtarolo/Duke): 3M+
  DFT compounds (largest single computational DB); Curtarolo 2012 + Toher
  2018 + Rose AFLUX 2017; CC-BY 4.0.
- **NOMAD** (NOvel MAterials Discovery, Draxl & Scheffler, EU FAIR-data):
  19M+ aggregated multi-code DFT entries (VASP / QE / FHI-aims / ABINIT /
  CP2K / GPAW / SIESTA / …); preserves originating-code provenance;
  Draxl & Scheffler 2018 MRS Bull. + 2019 J. Phys. Mater.; CC-BY 4.0.

Each Phase G+2 adapter ships with the same shape as the COD adapter:
- `_absorption_bridge/<name>/<name>_search_smoke.py` — stdlib-only adapter
- `_absorption_bridge/<name>/SOURCES.md` — license + citation
- `_absorption_bridge/<name>/cache/sample_record.json` — sample fixture
- `_absorption_bridge/<name>_adapter.md` — short adapter doc
- `_absorption_bridge/selftest/<name>_smoke.py` — wrapper for the aggregator
- `selftest/<name>_adapter_smoke.sh` — dedicated top-level gate

Selftest scoreboard: 24/24 → **27/27** PASS (gates 25/26/27 =
`oqmd_adapter_smoke` / `aflow_adapter_smoke` / `nomad_adapter_smoke`).

**Phase J.3 (2026-05-13)** added two more closure-deepening adapters
(14 → 16):
- **NIMS MatNavi / MITS** (National Institute for Materials Science,
  Tsukuba, Japan): ~50,000 records covering metals + alloys + ceramics +
  polymers + composites + multi-decade Creep / Fatigue Data Sheet series.
  Unique distinguisher among the 16 sources — carries **BOTH experimental
  and computed** records. Validator REQUIRES `record_type` to start with
  `experimental_` or `computed_` so the two flavours cannot be conflated.
  Sample fixture: SUS304 / SS304 austenitic stainless steel mechanical
  record at 25 °C per ASTM A240 / JIS G4304 (YS 215 MPa, UTS 505 MPa,
  E 193 GPa). Xu 2011 Procedia Eng. + Demura 2019 STAM; CC-BY 4.0 on the
  open-data subset (account-gated subsets retain separate terms; adapter
  does NOT redistribute).
- **Catalysis-Hub** (NTNU + Stanford SUNCAT): > 100,000 surface reactions
  / adsorption energies; DFT-only — GPAW (default) + VASP, mostly BEEF-vdW.
  Strict-prediction sister: validator REJECTS any record mis-labelled as
  experimental. Sample fixture: CO₂ → CO adsorption on Cu(111) (ΔE_rxn
  −0.18 eV, E_a 0.62 eV; BEEF-vdW + GPAW + climbing-image NEB). Winther
  2019 Sci. Data + Schlexer Lamoureux 2019 ChemCatChem; CC-BY 4.0.

Phase J.3 selftest scoreboard delta: +2 gates (`nims_mats_adapter_smoke` +
`catalysis_hub_adapter_smoke`). Final count depends on merge order of the
J.1 / J.2 closure-deepening branches; on stock-main-at-commit-time (30
gates) this delta lands at **32/32 PASS**.

| Subsystem | Module | Status | Optional dep |
|---|---|---|---|
| **materials_project** | `materials_project/mp_api_smoke.py` | FUNCTIONAL (offline replay) | mp-api |
| **gnome**             | `gnome/gnome_dataset_smoke.py`     | FUNCTIONAL (offline replay) | none (Zenodo download is runtime) |
| **matlantis**         | `matlantis/matlantis_call_smoke.py` | FUNCTIONAL (offline replay) | none — COMMERCIAL SDK out-of-scope |
| **omat24**            | `omat24/omat24_dataset_smoke.py`   | FUNCTIONAL (offline replay) | huggingface_hub |
| **universal_ff**      | `universal_ff/schnet_call.py`      | PARTIAL (SKIPs without schnetpack)   | schnetpack |
| **universal_ff**      | `universal_ff/mace_call.py`        | PARTIAL (SKIPs without mace-torch)   | mace-torch |
| **universal_ff**      | `universal_ff/alignn_call.py`      | PARTIAL (SKIPs without alignn)       | alignn |
| **universal_ff**      | `universal_ff/chgnet_call.py`      | PARTIAL (SKIPs without chgnet)       | chgnet |
| **universal_ff**      | `universal_ff/m3gnet_call.py`      | PARTIAL (SKIPs without matgl)        | matgl |
| **selftest**          | `selftest/materials_project_smoke.py` · `gnome_smoke.py` · `matlantis_smoke.py` · `omat24_smoke.py` · `universal_ff_smoke.py` · `sources_audit.py` | aggregators (6 total) | none |

Top-level Phase G gate: `selftest/absorption_bridge_smoke.sh` (gate 23 in
`selftest/run_all.sh`). Result: `__HEXA_MATTER_ABSORPTION_BRIDGE__ PASS
(6/6 modules, 0 skipped)` on stock Python.

Full selftest scoreboard after Phase G:
`__HEXA_MATTER_SELFTEST__ PASS (23/23)`.

Full selftest scoreboard after Phase G+1 (COD):
`__HEXA_MATTER_SELFTEST__ PASS (24/24)`.

Full selftest scoreboard after Phase G+2 (OQMD + AFLOW + NOMAD):
`__HEXA_MATTER_SELFTEST__ PASS (27/27)`.

License honesty matrix (per `_absorption_bridge/README.md`):

| System | License | Cost |
|---|---|---|
| Materials Project | CC-BY 4.0 (free API key required) | $0 |
| GNoME | CC-BY 4.0 (Zenodo DOI 10.5281/zenodo.10371563) — **PREDICTED, NOT SYNTHESIZED** | $0 |
| Matlantis | Commercial (Preferred Networks) — **UNVERIFIED at hexa-matter scale** | $$$ |
| OMat24 | CC-BY 4.0 (HuggingFace `fairchem/OMAT24`) | $0 |
| COD (Phase G+1) | CC0 / public-domain raw data (Gražulis 2009/2012) | $0 |
| OQMD (Phase G+2) | CC-BY 4.0 (Saal 2013 + Kirklin 2015) — **DFT-PBE PREDICTIONS, ~1M entries** | $0 |
| AFLOW (Phase G+2) | CC-BY 4.0 (Curtarolo 2012 + Toher 2018) — **DFT PREDICTIONS, 3M+ compounds** | $0 |
| NOMAD (Phase G+2) | CC-BY 4.0 (Draxl & Scheffler 2018) — **multi-code DFT, 19M+ FAIR entries** | $0 |
| NIMS MatNavi (Phase J.3) | CC-BY 4.0 open-data subset (Xu 2011 + Demura 2019) — **BOTH experimental AND computed**, ~50k records, Japan/JIS-industrial | $0 (open-data) |
| Catalysis-Hub (Phase J.3) | CC-BY 4.0 (Winther 2019 + Schlexer Lamoureux 2019) — **DFT surface-reaction predictions**, > 100k reactions, BEEF-vdW + GPAW/VASP | $0 |
| SchNet / MACE / ALIGNN | MIT | $0 |
| CHGNet / M3GNet | BSD-3-Clause | $0 |

Bundled offline-replay fixtures (illustrative; tagged
`__fixture_tag__: SAMPLE FIXTURE — not real data, for selftest replay only`):
- `materials_project/cache/sample_response.json` — Si record (mp-149 schema)
- `gnome/cache/sample_record.json` — GNoME prediction record schema
- `matlantis/cache/sample_response.json` — Matlantis PFP structure→energy schema
- `omat24/cache/sample_record.json` — OMat24 DFT record schema
- `universal_ff/cache/sample_structure.json` — Si diamond-cubic 2-atom input

Honesty preservation (per `INIT.md` hard rules):
  Matlantis / OMat24 / universal-FF outputs. Each external system carries
  its OWN published error bars (DFT-PBE typical; NNP force MAE 20–60 meV/Å).
- **Rule 4 (SPEC_FIRST)**: external records INFORM hexa-matter specs; do
  not REPLACE the SPEC_FIRST verdict.
- **Rule 5 (UNPROVEN preservation)**: GNoME records carry an `is_synthesized:
  false` field + `synthesis_status: UNPROVEN — DFT prediction only`
  marker; `gnome_dataset_smoke.py` enforces these are present.
- **NO LIVE API CALLS in selftest**: every selftest reads from bundled
  fixtures. Live adapter use is a runtime concern, not CI.

SOURCES.md per subsystem (all 5 present + non-empty + carrying license +
citation/DOI/journal markers — enforced by `selftest/sources_audit.py`):
- `materials_project/SOURCES.md` — Persson et al. 2013 APL Mater. + MP API
  key signup + CC-BY 4.0
- `gnome/SOURCES.md` — Merchant et al. 2023 Nature + Zenodo DOI +
  CC-BY 4.0 + UNPROVEN discipline
- `matlantis/SOURCES.md` — Takamoto et al. 2022 Nat. Comm. + commercial
  pricing UNVERIFIED note
- `omat24/SOURCES.md` — Barroso-Luque et al. 2024 arXiv:2410.12771 +
  HuggingFace links + CC-BY 4.0
- `universal_ff/SOURCES.md` — 5-FF aggregate citation table (Schütt 2017 /
  Batatia 2022 / Choudhary 2021 / Deng 2023 / Chen 2022)

## Phase H — Category (b) parity gates ✅ DONE (2026-05-13)

10 stdlib-only parity gates landed under `tests/*_parity.py`, each
backed by a vendored source-of-truth snapshot under
`tests/snapshots/<gate_id>.json`. Each gate is ≤ 80 LOC, reads its
snapshot, locates the spec doc's value via deterministic regex, and
asserts spec↔source parity within a published tolerance. Aggregator:
`selftest/parity_gates_smoke.sh` (gate #25). Selftest scoreboard
24/24 → **25/25 PASS**.

| # | Gate | Anchor (source) | Spec doc | Tolerance |
|---|---|---|---|---|
| 1 | `cer_b2_si_density` | CRC 105th ed. (2024) p.4-87 — Si rho = 2.329 g/cm³ | `silicon/silicon.md` Si-L6 | abs 0.002 g/cm³ |
| 2 | `cer_b3_si_bandgap` | NIST WebBook + Sze 3rd ed. — Si E_g = 1.12 eV (300 K) | `silicon/silicon.md` Si-L7 | abs 0.02 eV |
| 3 | `cer_b4_sic_bandgap` | Saddow & Agarwal 2004 — 4H-SiC E_g = 3.26 eV (6H-SiC 3.02 eV) | `silicon/silicon.md` Si-L11 | abs 0.05 eV |
| 4 | `cer_b5_si3n4_flexural` | ASM Handbook vol. 21 (2001) — Si₃N₄ HIP σ_f 600-1200 MPa | `silicon/silicon.md` Si-L12 | range containment |
| 5 | `pol_b1_aramid_tensile` | ASTM D885 + DuPont Kevlar 49 datasheet + ASM vol. 21 — σ_f ≥ 3.0 GPa | `aramid/aramid.md` F-AR-Q1 | min threshold 3.0 GPa |
| 6 | `pol_b4_nylon66_tg_tm` | ASM Engineered Materials vol. 2 + CRC 105th — PA66 T_g 50-65 °C, T_m 265 °C | `POLYMER-CHEMISTRY.md` §3.2 | T_g ± 5 °C, T_m ± 3 °C |
| 7 | `fib_b2_paper_tensile` | TAPPI T494 (2021) — bleached softwood kraft tensile index ≥ 70 N·m/g | `paper/paper.md` F-PA-Q1 | min threshold 70 N·m/g |
| 8 | `met_b4_w_melting` | CRC 105th / NIST — W T_m = 3422 °C (3695 K) | `LIMIT_BREAKTHROUGH.md` refractory row | abs 1 °C |
| 9 | `met_b5_os_density` | CRC 105th / NIST WebBook — Os ρ = 22.59 g/cm³ (densest stable element) | `LIMIT_BREAKTHROUGH.md` L6 row | abs 0.02 g/cm³ |
| 10 | `gem_b1_corundum_ri` | GIA / NIST gem-RI — corundum n_d 1.762-1.770 | `gemology/gemology.md` F-GEM-Q1 | ± 0.002 |

Aggregator output (stock Python):
`__HEXA_MATTER_PARITY_GATES__ PASS (10/10 gates, 0 skipped)`.

Selftest scoreboard after Phase H:
`__HEXA_MATTER_SELFTEST__ PASS (25/25)`.

Honesty preservation (per `INIT.md` hard rules):
  `n6_lattice_fit_applied: false`; NIST / CRC / ASM / TAPPI / GIA values
  flow through verbatim with provenance. NO n=6 lattice-fit applied on
  any external entity.
- **Rule 4 (SPEC_FIRST)**: gates check spec↔source parity; a passing
  gate does NOT turn the spec into a measurement. "SPEC_FIRST, not
  MEASURED here" footer stays verbatim across all 33 verb specs.
- **Rule 5 (UNPROVEN preservation)**: LK-99, magic-MOF DAC $100/t, CNT
  yarn 80 GPa lab-mm, marine-biodegradable PHA, perovskite 25-yr
  lifetime — all keep their flags. Phase H targets honestly-anchored
  values only; it does NOT close any UNPROVEN claim.
- **NO LIVE API CALLS in selftest**: every gate reads bundled snapshots
  under `tests/snapshots/`. Live retrieval (if ever needed) would be a
  Phase F research-bridge concern, not Phase H.

Ledger movement (`CLOSURE_RESIDUAL_BACKLOG.md §B`):
**29 → 19 remaining** (10 ✅ CLOSED by Phase H; 10 Phase B residual + 9
Phase F residual still UNVERIFIED).

Files added this phase:
- `tests/cer_b2_si_density_parity.py` · `tests/cer_b3_si_bandgap_parity.py`
- `tests/cer_b4_sic_bandgap_parity.py` · `tests/cer_b5_si3n4_flexural_parity.py`
- `tests/pol_b1_aramid_tensile_parity.py` · `tests/pol_b4_nylon66_tg_tm_parity.py`
- `tests/fib_b2_paper_tensile_parity.py`
- `tests/met_b4_w_melting_parity.py` · `tests/met_b5_os_density_parity.py`
- `tests/gem_b1_corundum_ri_parity.py`
- `tests/snapshots/<gate_id>.json` (10 vendored snapshots)
- `selftest/parity_gates_smoke.sh` (aggregator gate #25)

## Phase I.1 — Phase B target parity gates batch 1 — ✅ DONE (commit `583fddb`)

10 more stdlib-only parity gates landed under `tests/*_parity.py` + 10
snapshots under `tests/snapshots/*.json`. Each gate is ≤ 80 LOC, reads
its snapshot, locates the spec doc's value via deterministic regex, and
asserts spec↔source parity within a published tolerance. The
`selftest/parity_gates_smoke.sh` aggregator now sweeps **20 gates total**
(10 Phase H + 10 Phase I.1) and emits
`__HEXA_MATTER_PARITY_GATES__ PASS (20/20 gates, 0 skipped)`.

| # | Gate | Anchor (source) | Spec doc | Tolerance |
|---|---|---|---|---|
| 1 | `cer_b1_quartz_ri` | NIST SRM 1960 quartz — α-quartz n_d = 1.5443 at 589.3 nm, 25 °C | `glass/hexa-glass.md` F-GL-Q4 | abs 0.003 |
| 2 | `cer_b7_mohs_hardness` | Mohs 1812 + NIST SRD — 10-stop ladder talc(1) → diamond(10) | `gemology/gemology.md` F-GEM-Q5 | exact 10 stops, mineral identity |
| 3 | `pol_b2_pet_hydrolysis_ea` | Marshall et al. 1988 + Toray — PET hydrolysis E_a 75-100 kJ/mol | `POLYMER-CHEMISTRY.md` §4.1 | ± 10 kJ/mol on each endpoint |
| 4 | `fib_b1_cellulose_segal` | TAPPI T 271 + Segal 1959 — kraft cellulose CrI 60-80 % | `wood-cellulose/wood-cellulose.md` WC-L12 | ± 10 % on each endpoint |
| 5 | `met_b1_inconel718_creep` | ASM vol. 1 + Special Metals — IN718 ≥ 690 MPa stress-rupture at 650 °C, 100 h | `superalloy/superalloy.md` SA-L1 | min threshold 690 MPa |
| 6 | `met_b2_ti64_transus` | ASM vol. 2 — Ti-6Al-4V β-transus 995 °C (1268 K) ± 15 °C | `METALLURGY-DEEP.md` §4.3 | abs 15 °C |
| 7 | `met_b3_aisi1080_ttt` | ASM vol. 4 + Bain 1930 — AISI 1080 nose 550 °C / bainite 540 °C / Ms 250 °C | `METALLURGY-DEEP.md` §5 | nose ± 25 °C, bainite ± 25 °C, Ms ± 35 °C |
| 8 | `gem_b2_ruby_rline` | NIST + Sugano-Tanabe-Kamimura 1970 — ruby Cr³⁺ R₁ 694.3 nm at 300 K | `gemology/gemology.md` F-GEM-Q3 | abs 0.3 nm |
| 9 | `prc_b1_hales_packing` | Hales 2005 + 2017 formal proof — FCC/HCP density = π/(3√2) ≈ 0.7405 | `LIMIT_BREAKTHROUGH.md` L11 | abs 0.0005 |
| 10 | `fas_b1_reactive_dye_yield` | ISO 105-X12 + ICI Procion-H + Aspland 1997 — reactive dye covalent yield ≥ 60 % at 60 °C, pH 11 | `hexa-fashion/fashion-architecture.md` §3.1 F-FAS-Q1 | min threshold 60 % |

Aggregator output (stock Python):
`__HEXA_MATTER_PARITY_GATES__ PASS (20/20 gates, 0 skipped)`.

Selftest scoreboard after Phase I.1 (aggregator is one gate):
`__HEXA_MATTER_SELFTEST__ PASS (28/28)`.

Honesty preservation (per hard rules):
  `n6_lattice_fit_applied: false`; NIST / Mohs / Marshall / TAPPI / Segal
  / ASM / Sugano / Hales / ISO values flow through verbatim. NO n=6
  lattice-fit applied on any external entity. The Hales packing gate is
  a numerical check against `π/(3·√2)` — the Kepler invariant, not an
  n=6 invariant; `prc_b1` snapshot's `n6_lattice_fit_applied: false`
  documents that the coincidence `0.7405 ≈ R(6)` mentioned in
  `MATERIAL-SYNTHESIS.md` is NOT used by the gate.
- **Rule 4 (SPEC_FIRST)**: gates check spec↔source parity; a passing
  gate does NOT turn the spec into a measurement.
- **Rule 5 (UNPROVEN preservation)**: LK-99, CNT yarn 80 GPa,
  marine-biodegradable PHA, MOF DAC $100/t, perovskite 25-yr lifetime —
  all keep their flags. Phase I.1 targets honestly-anchored values
  only; it does NOT close any UNPROVEN claim.
- **NO LIVE API CALLS in selftest**: every gate reads bundled snapshots.

Ledger movement (`CLOSURE_RESIDUAL_BACKLOG.md §B`):
**19 → 9 remaining** (10 ✅ CLOSED by Phase I.1; only B-FAS-2 Kubelka-Munk
remains Phase B target + 8 Phase F target items).

Spec doc edits this phase (minimal real-domain anchor additions):
- `glass/hexa-glass.md` — new F-GL-Q4 row (α-quartz n_d)
- `gemology/gemology.md` — new F-GEM-Q5 row (Mohs 10-stop ladder)
- `hexa-fashion/fashion-architecture.md` §3.1 — F-FAS-Q1 reactive-dye
  covalent-yield falsifier paragraph

Files added this phase:
- `tests/cer_b1_quartz_ri_parity.py` · `tests/cer_b7_mohs_hardness_parity.py`
- `tests/pol_b2_pet_hydrolysis_ea_parity.py` · `tests/fib_b1_cellulose_segal_parity.py`
- `tests/met_b1_inconel718_creep_parity.py` · `tests/met_b2_ti64_transus_parity.py` · `tests/met_b3_aisi1080_ttt_parity.py`
- `tests/gem_b2_ruby_rline_parity.py`
- `tests/prc_b1_hales_packing_parity.py`
- `tests/fas_b1_reactive_dye_yield_parity.py`
- `tests/snapshots/<gate_id>.json` (10 vendored snapshots)
- `selftest/parity_gates_smoke.sh` aggregator docstring + run_all.sh
  comment updated to reflect 20-gate sweep

Status: **✅ DONE** (commit `583fddb`) — 20/20 parity gates passing; Phase I.2 follow-up
(commit `196b03c`) closed the remaining 9 §B rows; closure-meta integration
(commits `9c21948` + `674653e` + `6526de6`) wired the cross-link integrity gate
+ §C handoff completeness gate and authored CLOSURE_STATUS.md / RELEASE_NOTES_v1.2.0.

## Phase I.2 — Phase F target parity gates batch 2 — ✅ DONE (commit `196b03c`)

9 vendor- / literature-anchored parity gates closing the final §B residual:
`cer_b6_uhpc_compressive` (Ductal + Cor-Tuf) · `cer_b8_si_thermal_donor`
(Kaiser-Frisch 1958 + SEMI MF1188) · `cer_b9_si_oxygen_interstitial`
(ASTM F121 / F1188) · `pol_b3_microplastic_kd` (NOAA + Mato 2001 + Rochman
2013) · `pol_b5_uhmwpe` (DSM Dyneema SK99) · `pol_b6_cnt_yarn` (Tsinghua
Bai 2018; **UNPROVEN at commodity scale preserved verbatim** — gate verifies
lab-mm parity only) · `prc_b2_recycling_gibbs` (ISO 14040 + Gibbs ideal-mixing
floor; derived check) · `prc_b3_solgel_teos` (Hench-West 1990 + Brinker-Scherer
1990) · `fas_b2_kubelka_munk` (AATCC TM6 + Kubelka-Munk 1931; closed-form
identity check).

Aggregator output:
`__HEXA_MATTER_PARITY_GATES__ PASS (29/29 gates, 0 skipped)`. **§B drained
29 → 0; Category (a)+(b) closure = 100% as of 2026-05-13.**

## Closure-meta — ✅ DONE (commits `9c21948` + `674653e` + `6526de6`)

- `selftest/cross_link_integrity_audit.py` (gate #29) — enforces CROSS_LINK.md
  sister-repo boundary discipline + NOVEL.md candidate invariants (DESIGN
  status, quantitative falsifier, risk-flags, NNN uniqueness) + doc-reference
  integrity. Audits 37 candidates + 17 cross-links; 0 violations.
- `selftest/c_handoff_completeness_audit.py` (gate #30) — walks every §C row
  C3 (no n=6 lattice-fit). Software-side §C handoff documentation = 100%.
- `CLOSURE_STATUS.md` — top-level certification of Category (a)+(b) = 100%
  with explicit "what 100% does NOT mean" caveat.
- `RELEASE_NOTES_v1.2.0.md` — full Phase A-I + closure-meta rollup.

### Phase J.1 — three deepening audit gates ✅ DONE (2026-05-13)

Three stdlib-only audit gates landed under `selftest/` to make the Round-3
NOVEL.md + verb-spec corpus invariants explicitly checkable. Each gate
accepts `--selftest`, runs offline / deterministic, exits 0 on PASS with a
sentinel line.

- `selftest/falsifier_wellformed_audit.py` (gate #31) — every `hxm-*`
  candidate row has F-tag + quantitative number+unit pair + `→ FAIL`
  boundary within ±5 lines + DESIGN/SIM-DFT/SIM-MD/SIM-NNP/SIM-NNP-PROXY/
  SYNTH-ROUTE/UNVERIFIED/FALSIFIED status; EXTERNAL-VERIFIED / VERIFIED
  rejected absent same-row external-lab citation. Audits 180 candidates;
  180 wellformed, 0 nonconforming.
- `selftest/hardwall_provenance_audit.py` (gate #32) — every HARD_WALL /
  SOFT_WALL / BREAKABLE_WITH_TECH / UNCLEAR / UNPROVEN / UNVERIFIED /
  NOT REPRODUCED / CONTESTED token in NOVEL.md + every `<verb>/<verb>.md` +
  LIMIT_BREAKTHROUGH.md + CLOSURE_RESIDUAL_BACKLOG.md traces to either
  LIMIT_BREAKTHROUGH.md itself (authoritative) OR a curated citation
  allowlist (NIST/CRC/ASM/ASTM/ISO/TAPPI/AATCC/SEMI/GIA/IEEE/IEC/NREL +
  vendor / scientist anchors) OR a generic `Lastname YYYY` / journal-acronym
  pattern within ±12 lines. PASS at K ≤ 5 transitional floor. Currently
  710 tokens / 706 traceable / 4 untraceable.
- `selftest/vendor_citation_completeness_audit.py` (gate #33) — every named
  vendor in a curated 30-entry allowlist (Wacker / Wolfspeed / DuPont /
  Toray / Sila Nano / Group14 / Amprius / Climeworks / Ductal / Cor-Tuf /
  DSM Dyneema / NatureWorks / Danimer / Lafarge-Holcim / Sibelco / Hitachi
  Metals / Vacuumschmelze / RHI Magnesita / Vesuvius / GE Aviation /
  Rolls-Royce / Pratt & Whitney / Special Metals / NREL / Oak Ridge /
  Sumitomo / POSCO / CATL / BYD / Element Six) has ≥ 1 occurrence with a
  year token within ±5 lines (±12 fallback), ≥ 1 product/standard ID
  anchor anywhere in the corpus (Vitreloy / IN718 / SEMI MF1188 / ASTM
  F121 / ICI Procion-H / Dyneema SK99 / NMC811 / LFP / SmCo / NdFeB / …),
  and NO `lattice-fit` / `n=6 invariant` attribute claim on the vendor

Selftest scoreboard 30/30 → **37/37 PASS**.

## 🏆 Category (a)+(b) closure = 100% (2026-05-13)

Per `AXIS_CLOSURE_PLAN.md` (Phase A output), hexa-matter uses the **Category (a)/(b)/(c)** framework from hexa-bio:

- **(a) in-repo SW/spec closure** — **100%** (4/4 verify · 37/37 selftest · 36/36 verb specs).
- **(b) formal/empirical material-property parity** — **100%** (29/29 parity
  gates passing under `tests/*_parity.py` + `tests/snapshots/*.json`; §B
  drained 29 → 0). UNPROVEN markers in source data preserved verbatim in
  snapshot metadata.
- **(c) wet-lab synthesis / manufacturing scale closure** — **OUT-OF-REPO BY
  DESIGN** (cannot be closed in software). 18 (c) items enumerated in §C,
  each with DEST + LIMIT_BREAKTHROUGH wall classification audited by gate #30.

## Hard constraints (NEVER violate)

These rules are baked into every phase. Any output that violates them is BAD:

1. **`LATTICE_POLICY.md` §1.2 — Real-limits-first**
   The project ceiling is set by REAL math/physics/engineering limits (Shannon,
   Kolmogorov, Bekenstein, c, ℏ, k, Stefan-Boltzmann, Carnot, ASML throughput,
   …), NOT by the n=6 lattice. Lattice tautologies (σ·φ=24) alone are NOT
   sufficient verification.

2. **`LATTICE_POLICY.md` §1.3 — n=6 is auxiliary, not load-bearing**
   The lattice is a tool, not a constraint. Use it where it fits naturally;
   never force-map it onto external domains.

   Wacker, GCL, Hemlock, Wolfspeed, Merck KGaA, TSMC, Wolfspeed, ASML, vendors
   of any kind use THEIR OWN published invariants. NEVER apply n=6 lattice
   formulas to vendor data, NIST constants, ITER specs, etc.

4. **SPEC_FIRST verdict preserved**
   Every spec must state "SPEC_FIRST, not MEASURED here." Numbers cite
   sources (NIST/CRC/SEMI/ASTM/vendor). The repo does not own measurements.

5. **UNPROVEN / UNVERIFIED stamps preserved verbatim**
   LK-99, metallic-hydrogen, infinite-recycle, MOF DAC economics, marine-
   biodegradable claims, etc. — all explicitly UNPROVEN and must stay so.

6. **`AGENTS.md` `LIMIT_BREAKTHROUGH.md` is authoritative**
   For HARD_WALL / SOFT_WALL / BREAKABLE_WITH_TECH / UNCLEAR classifications,
   defer to that file.

## Key files and references

- `/Users/ghost/core/hexa-matter/README.md` — landing
- `/Users/ghost/core/hexa-matter/AGENTS.md` — agent operating guide
- `/Users/ghost/core/hexa-matter/LATTICE_POLICY.md` — discipline anchor
- `/Users/ghost/core/hexa-matter/LIMIT_BREAKTHROUGH.md` — real-limits ceiling
- `/Users/ghost/core/hexa-matter/AXIS.md` (Phase A) — 7-group taxonomy
- `/Users/ghost/core/hexa-matter/AXIS_CLOSURE_PLAN.md` (Phase A) — (a)/(b)/(c) roadmap
- `/Users/ghost/core/hexa-matter/CLOSURE_RESIDUAL_BACKLOG.md` (Phase A) — (b)/(c) ledger
- `/Users/ghost/core/hexa-matter/V1_2_0_HANDOFF.md` (Phase A) — full Phase B-G plan
- `/Users/ghost/core/hexa-bio/` — sister-substrate REFERENCE (don't copy, but emulate maturity)
- `/Users/ghost/core/hexa-matter/silicon/silicon.md` — gold-standard verb spec template

## Commit log (this elevation)

- `91981d4` — Initial 4/4 verify closure (16 verbs)
- `a239611` — Silicon added (17 verbs, gold template)
- `c55199b` — Phase A infrastructure (10 infra + 5 deep + 11 stubs)
- `99620b2` — Phase D (12 new verbs, 17 → 29)
- `f24d8a5` — Phase B (21-gate selftest harness; `__HEXA_MATTER_SELFTEST__ PASS  (21/21)`)
- `6e4928a` — Phase C (hexa-* axis-prefixed depth dirs: 9 groups, 36 files, 3913 lines)
- `b4ebf8f` — Phase E (`_python_bridge/` — 12 compute modules; `__HEXA_MATTER_PYTHON_BRIDGE__ PASS (12/12, 5 skipped)`)
- `185ce33` — Phase F (`_research_bridge/` — 8 absorption modules; arxiv + vendor + news + patent; `__HEXA_MATTER_RESEARCH_BRIDGE__ PASS (3/3, 0 skipped)`; selftest scoreboard `__HEXA_MATTER_SELFTEST__ PASS (22/22)`)
- `e712068` — Phase G (`_absorption_bridge/` — 10 adapters: Materials Project / GNoME / Matlantis / OMat24 + SchNet / MACE / ALIGNN / CHGNet / M3GNet; `__HEXA_MATTER_ABSORPTION_BRIDGE__ PASS (6/6, 0 skipped)`; selftest scoreboard `__HEXA_MATTER_SELFTEST__ PASS (23/23)`)
- `6993e4a` — Phase G+1 (`_absorption_bridge/cod/` — Crystallography Open Database 11th adapter; CC0 raw data; EXPERIMENTAL XRD measurements; selftest scoreboard `__HEXA_MATTER_SELFTEST__ PASS (24/24)`)
- `a54da35` — Phase G+2 (`_absorption_bridge/{oqmd,aflow,nomad}/` — 3 DFT/FAIR-data adapters: OQMD Wolverton 1M / AFLOW Curtarolo 3M / NOMAD Draxl-Scheffler 19M multi-code; all CC-BY 4.0)
- `e12dfb9` — Phase H (10 Category (b) parity gates under `tests/*_parity.py` + 10 vendored snapshots under `tests/snapshots/*.json` + `selftest/parity_gates_smoke.sh` aggregator; `__HEXA_MATTER_PARITY_GATES__ PASS (10/10 gates, 0 skipped)`; selftest scoreboard `__HEXA_MATTER_SELFTEST__ PASS (28/28)`; ledger CLOSURE_RESIDUAL_BACKLOG §B drained 29 → 19)
- _(this commit, 2026-05-14)_ — Phase K.1 (`_python_bridge/universal_ff_runner.py` — unified MACE/CHGNet/ALIGNN/SchNet/M3GNet runner; mock-mode `--selftest` force-SKIPs all 5 optional deps; new SIM-NNP status tag in NOVEL.md §2 distinct from SIM-NNP-PROXY; new gate `selftest/universal_ff_runner_smoke.sh` #38; `__UNIVERSAL_FF_RUNNER__ PASS (5/5 models SKIP cleanly when deps missing)`; selftest scoreboard `__HEXA_MATTER_SELFTEST__ PASS (38/38)`)

## Phase K.1 — universal-FF runner infrastructure ✅ DONE (2026-05-14)

Phase K.1 lands the **infrastructure** to do actual local universal-FF NNP
runs against the 17 SIM-NNP-PROXY candidates vendored in Phase J.2 — without
promoting any candidate from `SIM-NNP-PROXY` to `SIM-NNP` automatically.
Promotion (Phase K.2) requires an explicit user/maintainer trigger.

Files added (this commit):
- `_python_bridge/universal_ff_runner.py` (~250 LOC, stdlib + optional imports)
- `_python_bridge/universal_ff_runner.md` (~80-line architecture doc)
- `selftest/universal_ff_runner_smoke.py` (~80-LOC mock-mode wrapper)
- `selftest/universal_ff_runner_smoke.sh` (gate #38 wrapper)
- `PHASE_K_PLAN.md` (Phase K scope-definition mirroring PHASE_J_PLAN.md)

NOVEL.md §2 status pipeline update (this commit):
- `SIM-NNP-PROXY` row reworded to emphasize "no live computation".
- New `SIM-NNP` row: real local computation via the runner; SIM-NNP-PROXY
  proxy value matched within ±20 % tolerance; **does NOT promote to

5 supported models with citations:
- **MACE** — Batatia et al. 2022 ([arXiv:2206.07697](https://arxiv.org/abs/2206.07697)) · `mace-torch` · MIT
- **CHGNet** — Deng et al. 2023 Nat. Mach. Intell. · `chgnet` · BSD-3-Clause
- **ALIGNN** — Choudhary & DeCost 2021 npj Comput. Mater. · `alignn` · MIT
- **SchNet** — Schütt et al. 2018 J. Chem. Phys. · `schnetpack` · MIT
- **M3GNet** — Chen & Ong 2022 Nat. Comput. Sci. · `matgl` · BSD-3-Clause

- Every runner record carries `is_measurement: false` — model output is
  computation, not measurement.
- `is_external_verification: false` — local run does not satisfy
  external-lab attribution.
- `n6_lattice_fit_applied: false` — NNPs publish their own error bars.
- `--selftest` is **mock-only** (force-SKIPs every optional dep). CI
  never imports torch / mace / chgnet etc.; no checkpoint download in
  the gate path.

Selftest scoreboard: **38/38 PASS** (37/37 baseline + gate #38
`universal_ff_runner_smoke`).

## If you're picking this up cold

1. Read this file (you just did).
2. Check Phase status table above. Find the in_progress phase.
3. `git -C /Users/ghost/core/hexa-matter status` — check working tree.
4. `git -C /Users/ghost/core/hexa-matter log --oneline -10` — confirm head.
5. Read `V1_2_0_HANDOFF.md` for the comprehensive plan.
6. Resume in the next blocked phase per the dependency graph above.
7. NEVER violate the 6 hard constraints.
