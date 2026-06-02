<p align="center">
  <img src="docs/logo.svg" width="140" alt="hexa-matter">
</p>

<h1 align="center">🧬 hexa-matter</h1>

<p align="center"><strong>HEXA-Matter Family</strong> — materials science · 16+ DB bridges · 29 parity gates</p>

<p align="center">
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blue"></a>
  <a href="https://github.com/dancinlab/hexa-matter/actions"><img alt="CI" src="https://img.shields.io/badge/selftest-32%2F32-brightgreen"></a>
  <img alt="Spec" src="https://img.shields.io/badge/version-v1.2.0-success">
  <img alt="Verbs" src="https://img.shields.io/badge/verbs-36-informational">
  <img alt="Parity gates" src="https://img.shields.io/badge/parity--gates-29%2F29-informational">
  <img alt="Bridges" src="https://img.shields.io/badge/db--bridges-16%2B-informational">
  <img alt="Sibling" src="https://img.shields.io/badge/sibling-hexa--bio%20·%20hexa--space%20·%20hexa--physics-blueviolet">
  <a href="https://doi.org/10.5281/zenodo.20102811"><img alt="DOI" src="https://zenodo.org/badge/DOI/10.5281/zenodo.20102811.svg"></a>
</p>

<p align="center">materials-science · n=6 · ceramic · polymer · fiber · gem · metal · synthesis · recycle · MOF · perovskite · 2D · superalloy · liquid-crystal · silicon · carbon · concrete · glass · aerogel · geopolymer · ionic-liquid</p>

---

> 36-verb materials toolkit (17 v1.0.0 + 12 Phase D + 4 Phase D follow-on
> + 3 Phase D'' 2026-05-13) organized around the **n=6 invariant lattice**:
> ceramic / polymer / fiber / gem / metal / synthesis / recycle (silicon
> joins ceramic_inorganic — material layer only).

> **Category (a)+(b) closure = 100%** as of 2026-05-13 (see [`CLOSURE_STATUS.md`](CLOSURE_STATUS.md)).
> **Category (c)** — wet-lab synthesis, vendor procurement, fab capacity — remains **OUT-OF-REPO BY DESIGN** per [`AXIS_CLOSURE_PLAN.md §0`](AXIS_CLOSURE_PLAN.md).
> Scoreboard counts (selftest 28/28, parity gates 29/29) are current as of this commit and may evolve in parallel rounds; the (a)+(b)=100% verdict is stable.

---

## Why

**hexa-matter** is the materials member of the HEXA family.
Thirty-six verbs cover the working surface of industrial materials
science — from inorganic ceramics and concrete to engineered polymers,
glass, silicon (material layer), wide-bandgap compound semiconductors,
perovskite + 2D materials + MOFs + carbon allotropes, gems, metallurgy
(general + superalloy + magnetic), elastomers + adhesives + liquid
crystals + biodegradable plastics + ionic liquids, glass-ceramics +
geopolymers + aerogels, wood/cellulose, synthesis platforms,
refractory + photoresist + electrode-material (Phase D'', 2026-05-13),
and circular-material flows.

Sixteen of the seventeen v1.0.0 verbs are peer-citable spec docs
copy-pasted from the upstream
[`canon/domains/materials/`](https://github.com/dancinlab/canon) tree
(SHA `47c70cbf`, 2026-05-09). The seventeenth verb — **silicon** — was
authored in-repo on 2026-05-13 under the real-limits-first policy.
**Phase D (2026-05-13) adds 12 in-repo specs** (no upstream canon
source): elastomer, compound-semi, perovskite, 2d-materials, adhesive,
magnetic-materials, mof, liquid-crystal, superalloy, biodegradable-
plastics, wood-cellulose, carbon. **Phase D follow-on (2026-05-13)
adds 4 more in-repo specs** (29→33): glass-ceramic, geopolymer,
aerogel-foam, ionic-liquid. **Phase D'' (2026-05-13) adds 3 more
in-repo specs** (33→36): refractory, photoresist, electrode-material.
Each follows the silicon.md real-limits-first template.

**Out of scope** — call sibling CLI directly:

| concern                                                       | call                          |
| ------------------------------------------------------------- | ----------------------------- |
| chip-grade semiconductor *device + fab process* (lithography, | `hexa-chip materials`         |
| EUV resist, transistor architecture, fab capacity)            |                               |
| lutherie / instrument craft                                   | (culture domain, future repo) |
| fashion-textile / dyeing                                      | (industrial-textile, future)  |

The `silicon/` verb in *this* repo covers the **material** aspect of Si
(polysilicon, mono-Si wafers, SiO₂, SiC ceramic, silicone polymer,
vendor tonnage); device + fab process stay in `hexa-chip`.

---

## Install

```bash
# 1. Install hexa-lang (gives you `hexa` + `hx` package manager)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dancinlab/hexa-lang/main/install.sh)"

# 2. Install hexa-matter
hx install hexa-matter
```

## Run

```bash
# v1.0.0 verbs (17)
hexa-matter ceramics         # ceramics spec doc
hexa-matter concrete         # concrete spec doc
hexa-matter concrete_tech    # concrete-technology spec doc
hexa-matter glass            # hexa-glass spec doc
hexa-matter silicon          # silicon spec doc (material layer — poly-Si / mono-Si / SiO₂ / SiC)
hexa-matter aramid           # aramid spec doc
hexa-matter epoxy            # epoxy spec doc
hexa-matter nylon            # nylon spec doc
hexa-matter pet_film         # pet-film spec doc
hexa-matter tire_cord        # tire-cord spec doc
hexa-matter fabric           # hexa-fabric spec doc
hexa-matter paper            # paper spec doc
hexa-matter gemology         # gemology spec doc
hexa-matter metallurgy       # swordsmithing-anchored metallurgy spec doc
hexa-matter synthesis        # material-synthesis spec doc
hexa-matter recycle_n6       # hexa-recycle spec doc
hexa-matter recycling        # recycling spec doc

# Phase D verbs (12, added 2026-05-13)
hexa-matter compound-semi           # GaN / SiC / GaAs / InP wafer + epi (material layer)
hexa-matter perovskite              # ABX₃ oxide + halide (LK-99 UNPROVEN preserved)
hexa-matter 2d-materials            # MoS₂ / hBN / phosphorene / MXene (non-carbon 2D)
hexa-matter mof                     # metal-organic frameworks (DAC economics UNPROVEN)
hexa-matter carbon                  # diamond / CNT / fullerene / fiber / activated C
hexa-matter elastomer               # NR / SBR / EPDM / silicone / FKM
hexa-matter adhesive                # PSA / structural / cyanoacrylate / anaerobic
hexa-matter liquid-crystal          # nematic + smectic + LCP (Vectran/Kevlar dope)
hexa-matter biodegradable-plastics  # PLA / PHA / PBS (marine-biodegradable UNVERIFIED)
hexa-matter wood-cellulose          # CLT / glulam / CNF / CNC / regenerated cellulose
hexa-matter superalloy              # Inconel / CMSX / Co-base / TBC cross-link
hexa-matter magnetic-materials      # NdFeB / SmCo / Si-Fe / Metglas / Finemet

# Phase D follow-on verbs (4, added 2026-05-13; 29→33)
hexa-matter glass-ceramic           # LAS Zerodur / Macor / Pyroceram / Li-disilicate dental
hexa-matter geopolymer              # alkali-activated aluminosilicate (CO₂-LCA UNVERIFIED)
hexa-matter aerogel-foam            # silica / carbon / polymer / graphene aerogel (cost UNPROVEN)
hexa-matter ionic-liquid            # imidazolium / phosphonium IL + DES distinction

# Phase D'' verbs (3, added 2026-05-13; 33→36)
hexa-matter refractory              # firebrick / Al₂O₃ / MgO / ZrO₂ / mag-C / SiC / carbon (T ≥ 1000 °C)
hexa-matter photoresist             # g/i-line DNQ / KrF / ArF / EUV CAR + MOR (material only — process → hexa-chip)
hexa-matter electrode-material      # LFP / NMC811 / Si-anode / Li-metal / Pt-ORR / IrO₂-OER (material only — cell → hexa-energy)

# utility
hexa-matter status           # 36-verb table + cross-link + caveats
hexa-matter selftest         # 36-verb spec doc presence check
hexa-matter version          # print version
hexa-matter help             # full --help (subcommands + env vars + cross-link)
```

## Status

Spec-first at v1.0.0 (+ Phase D + Phase D follow-on + Phase D''
2026-05-13) — 36/36 verbs ship as peer-citable markdown docs;
working numerical sandboxes are TBD per per-verb falsifier deadlines.
CLI dispatcher prints spec headlines.

Per-group closure status (Category (a) in-repo / (b) parity / (c) wet-lab):
[`AXIS_CLOSURE_PLAN.md`](AXIS_CLOSURE_PLAN.md). Residual gates +
deferral ledger: [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md).

## Documentation map

Architecture & lifecycle docs sit at the repo root in UPPERCASE following
the [`hexa-bio`](https://github.com/dancinlab/hexa-bio) convention.

**Infrastructure (10)** — read first:

| File | Purpose |
|---|---|
| [`INIT.md`](INIT.md) | Working-state ledger — Phase A-G status, commit log, pick-it-up-cold guide |
| [`AXIS.md`](AXIS.md) | 7-group taxonomy (CER / POL / FIB / MET / GEM / PRC / FAS) + cross-link map |
| [`AXIS_CLOSURE_PLAN.md`](AXIS_CLOSURE_PLAN.md) | Per-group closure roadmap, Category (a) / (b) / (c) framework |
| [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md) | 29 (b) parity gates + 15 (c) wet-lab/HW deferral ledger |
| [`DECOMPOSITION_PLAN.md`](DECOMPOSITION_PLAN.md) | Material taxonomy decomposition (7 groups → 36 verbs) |
| [`LESSONS.md`](LESSONS.md) | Construction journal — what worked, what surprised, anti-patterns avoided |
| [`RELEASE_NOTES_v1.0.0.md`](RELEASE_NOTES_v1.0.0.md) | Initial 16-verb release notes (retroactive) |
| [`RELEASE_NOTES_v1.1.0.md`](RELEASE_NOTES_v1.1.0.md) | Silicon + Phase A→G elevation |
| [`RELEASE_NOTES_v1.2.0.md`](RELEASE_NOTES_v1.2.0.md) | Phase A–I elevation; 17→36 verbs; Category (a)+(b)=100% |
| [`CLOSURE_STATUS.md`](CLOSURE_STATUS.md) | Top-level Category (a)+(b)=100% closure certification |
| [`V1_2_0_HANDOFF.md`](V1_2_0_HANDOFF.md) | Forward-facing handoff (Phase B-G roadmap & future) |
| [`USER_ACTION_REQUIRED.md`](USER_ACTION_REQUIRED.md) | Open asks for the user (priority decisions) |
| [`IMPORTED_FROM_CANON.md`](IMPORTED_FROM_CANON.md) | File-by-file canon provenance ledger |
| [`NOVEL.md`](NOVEL.md) | De-novo-designed novel material candidate ledger (`hxm-*` IDs, sister of `hexa-bio/.roadmap.novel_drugs`) |

**Deep expansion (5)** — extended material chapters beyond per-verb specs:

| File | Subject |
|---|---|
| [`SILICON.md`](SILICON.md) | CZ / FZ growth physics, 9N purity ceiling, isotope-separated Si-28 |
| [`CERAMIC-ENGINEERING.md`](CERAMIC-ENGINEERING.md) | Si₃N₄ turbine blade, SiC armor, ZTA, hardness mapping |
| [`METALLURGY-DEEP.md`](METALLURGY-DEEP.md) | Ni superalloy, SX casting, Ti-6Al-4V, TTT diagrams |
| [`POLYMER-CHEMISTRY.md`](POLYMER-CHEMISTRY.md) | Chain vs step-growth, MW distribution, Tg/Tm, biodegradable chemistry |
| [`GRAPHENE-CARBON.md`](GRAPHENE-CARBON.md) | CVD growth, defect density, CNT/diamond/fullerene |

**Phase D roadmap stubs (11)**: ELASTOMER · COMPOUND-SEMI · PEROVSKITE ·
2D-MATERIALS · ADHESIVE · MAGNETIC-MATERIALS · MOF · LIQUID-CRYSTAL ·
SUPERALLOY · BIODEGRADABLE-PLASTICS · WOOD-CELLULOSE (root UPPERCASE
stubs that delegate to per-verb specs).

**Policy & limits** (`AGENTS.md` registers both):
- [`LATTICE_POLICY.md`](LATTICE_POLICY.md) — n=6 lattice auxiliary, real-limits-first
- [`LIMIT_BREAKTHROUGH.md`](LIMIT_BREAKTHROUGH.md) — per-limit assessment (HARD_WALL · SOFT_WALL · BREAKABLE_WITH_TECH · UNCLEAR)

## Verify

Sister-substrate `verify/run_all.hexa` aggregator pattern, scaled to
spec-first scope. From the repo root:

```bash
hexa run verify/run_all.hexa     # exit 0 = all 4 scripts PASS
```

| script                            | what it checks                                                                   |
| --------------------------------- | -------------------------------------------------------------------------------- |
| `verify/spec_presence.hexa`       | all 36 verb spec docs present at declared paths                                  |
| `verify/lattice_arithmetic.hexa`  | n=6 self-consistency (σ·φ = n·τ = 24) — *aux only* per `LATTICE_POLICY.md` §1.3  |
| `verify/real_limits_anchor.hexa`  | `LIMIT_BREAKTHROUGH.md` anchors (NIST WebBook · CRC Handbook · Hales · Frenkel)  |
| `verify/closure_consistency.hexa` | scoreboard cross-check (CLI · `hexa.toml` · README · `AGENTS.md`)                |

Per `LATTICE_POLICY.md` §1.3, lattice-arithmetic identities are
permitted only as auxiliary self-consistency checks; the substrate's
real verification anchors live in `LIMIT_BREAKTHROUGH.md` (NIST/CRC
HARD walls). Material-science claims that remain unproven (LK-99
room-T SC, metallic hydrogen at ambient) are preserved as caveats.

## Selftest

Beyond `verify/` (which checks structural closure — file presence,
lattice arithmetic, real-limits anchors, scoreboard cross-check), the
`selftest/` harness runs 28 fine-grained content-aware gates (current
as of this commit, evolving in parallel rounds). From the repo root:

```bash
bash selftest/run_all.sh                # exit 0 = 28/28 gates PASS at this commit
```

| Category | Count | Gates |
|---|---|---|
| Group-specific | 8 | `cer_thermal_shock_audit` · `pol_thermal_stability_audit` · `fib_tensile_audit` · `met_alloy_classification` · `gem_authenticity_check` · `prc_yield_audit` · `fas_dyeing_chemistry_audit` · `silicon_purity_audit` |
| Verb-specific | 4 | `compound_semi_bandgap_audit` · `magnetic_materials_curie_audit` · `carbon_cnt_strength_honesty_audit` (CNT 80 GPa caveat) · `mof_dac_economics_honesty_audit` ($100/t UNPROVEN) |
| Bridge aggregators | 3 | `pyproject_smoke` — Phase E `_python_bridge/` (12 modules) · `research_bridge_smoke` — Phase F `_research_bridge/` (arxiv + web; offline-replay) · `absorption_bridge_smoke` — Phase G `_absorption_bridge/` (10 adapters: MP / GNoME / Matlantis / OMat24 / SchNet / MACE / ALIGNN / CHGNet / M3GNet) |
| Adapter-specific | 4 | `cod_adapter_smoke` (G+1) · `oqmd_adapter_smoke` · `aflow_adapter_smoke` · `nomad_adapter_smoke` (G+2; brings adapter count to 14) |
| Parity-gates aggregator | 1 | `parity_gates_smoke` — Category (b) parity gates (29/29 PASS: 10 Phase H + 10 Phase I.1 + 9 Phase I.2; **Category (b) closure = 100%**) |

Honesty constraints enforced by the selftest harness:
- `lattice_fit_on_external_entities_audit` — fails if any post-policy spec
- `carbon_cnt_strength_honesty_audit` — CNT 80 GPa must be flagged
  "lab mm-scale, commercial 1–3 GPa"
- `mof_dac_economics_honesty_audit` — magic-MOF $100/t must stay UNPROVEN
  with Climeworks $600–1000/t baseline cited

## Python bridge (Phase E)

`_python_bridge/` ships 12 runnable scientific-compute modules (Phase E,
2026-05-13) backing material specs. Each module has a `--selftest` mode
that runs offline / deterministically; modules with optional deps
(RDKit / ASE / pymatgen) SKIP cleanly when the dep is missing.

```
_python_bridge/
├── pyproject.toml                          # optional-dep declaration
├── README.md                               # bridge overview
└── module/
    ├── rdkit_smiles_audit.py               # SMILES canonicalization (RDKit)
    ├── rdkit_descriptor_calc.py            # MolWt / LogP / TPSA / HBA / HBD (RDKit)
    ├── ase_atoms_construct.py              # Si / Fe / Cu crystal builders (ASE)
    ├── ase_relaxation_check.py             # EMT relaxation smoke (ASE)
    ├── pymatgen_structure_io.py            # CIF round-trip + MP-ID regex (pymatgen)
    ├── pymatgen_phasediagram_smoke.py      # binary phase diagram smoke (pymatgen)
    ├── silicon_purity_compute.py           # 9N → ppba arithmetic (stdlib)
    ├── polymer_mw_distribution.py          # M_n / M_w / M_z / PDI (stdlib)
    ├── metallurgy_alloy_composition.py     # wt-% ↔ at-% conversion (stdlib)
    ├── carbon_form_factor_classifier.py    # CNT / diamond / fiber / etc. (stdlib + optional RDKit)
    ├── cross_doc_consistency_compute.py    # README ↔ AXIS.md ↔ hexa.toml count check (stdlib)
    └── nist_anchor_resolver.py             # NIST/CRC/ASM citation pattern parse (stdlib, offline)
```

Install optional deps:

```bash
pip install -e "_python_bridge[all]"        # RDKit + ASE + pymatgen
pip install -e "_python_bridge[chem]"       # RDKit only
pip install -e "_python_bridge[atomic]"     # ASE only
pip install -e "_python_bridge[materials]"  # pymatgen only
```

Run the bridge aggregator (also wired into `selftest/run_all.sh`):

```bash
bash selftest/pyproject_smoke.sh    # exit 0 = all 12 modules PASS or SKIP-clean
```

data. Selftests are offline + deterministic; live external-DB fetch is
in Phase F (`_research_bridge/`, landed 2026-05-13).

## Research bridge (Phase F)

`_research_bridge/` ships 8 runnable absorption modules (Phase F,
2026-05-13) for **arxiv deep research** + **web deep research** (vendor
datasheets, materials industry RSS/Atom news, USPTO/EPO patent search).
Each module has a `--selftest` mode that runs **offline-replay only**
(no live network calls in selftest — air-gap / CI safe); live mode is
gated behind explicit `--live`.

```
_research_bridge/
├── pyproject.toml                          # optional-dep declaration (requests / feedparser / bs4)
├── README.md                               # bridge overview
├── arxiv/
│   ├── arxiv_pull.py                       # arxiv API pull (cond-mat.mtrl-sci primary, 3-sec backoff)
│   ├── arxiv_digest.py                     # verb-keyword tagging + UNPROVEN flag preservation
│   ├── arxiv_cache/sample_response.xml     # offline-replay fixture (3 synthetic papers)
│   └── SOURCES.md                          # arxiv categories + keyword strategy
├── web/
│   ├── vendor_datasheet_pull.py            # vendor HTML/PDF datasheet parse (Wacker/Wolfspeed/...)
│   ├── materials_news_feed.py              # RSS/Atom news feed poll + verb tagging
│   ├── patent_search.py                    # USPTO PatFT / EPO Espacenet public-API parse
│   ├── web_cache/                          # offline-replay fixtures (vendor HTML, RSS, patent JSON)
│   └── SOURCES.md                          # vendor URLs + RSS feeds + patent endpoints
└── selftest/
    ├── arxiv_smoke.py                      # arxiv subsystem aggregator
    ├── web_smoke.py                        # web subsystem aggregator
    └── sources_audit.py                    # SOURCES.md validity + speculative-trip-list audit
```

Run the bridge aggregator (also wired into `selftest/run_all.sh` as gate 22):

```bash
bash selftest/research_bridge_smoke.sh    # exit 0 = all 3 aggregators PASS (offline only)
```

- Vendor / arxiv / patent data is ingested AS-IS with vendor's own metrics;
  NO n=6 lattice-fit applied at ingest.
- Speculative claims (LK-99 RTSC, magic-MOF $100/t, perovskite 25-yr lifetime)
  trip the `UNPROVEN_FLAGS` list and surface with the flag attached.
- No live network call ever fires in `--selftest` — fixtures only.

## Absorption bridge (Phase G)

`_absorption_bridge/` ships 10 adapters (Phase G, 2026-05-13) for
**AlphaFold-class external materials-discovery system absorption**: 5
external database / API systems plus 5 universal force-field models.
Each adapter has a `--selftest` mode that replays a bundled fixture
**offline** — live API calls during selftest are FORBIDDEN per the
"NO LIVE API CALLS in selftest" rule.

```
_absorption_bridge/
├── pyproject.toml                                # optional-dep declaration (mp-api / mace-torch / schnetpack / matgl / alignn / chgnet)
├── README.md                                     # bridge overview + license honesty matrix
├── materials_project/   mp_api_smoke.py          # Berkeley/LBNL ~154k materials (mp-api SDK)
├── gnome/               gnome_dataset_smoke.py   # DeepMind 2.2M predicted stable crystals (Zenodo DOI)
├── matlantis/           matlantis_call_smoke.py  # Preferred Networks PFP universal NNP (COMMERCIAL)
├── omat24/              omat24_dataset_smoke.py  # Meta AI 110M structures + MACE-OMat checkpoint
├── universal_ff/
│   ├── schnet_call.py                            # SchNet (Schütt et al. 2017)
│   ├── mace_call.py                              # MACE (Batatia et al. 2022)
│   ├── alignn_call.py                            # ALIGNN (Choudhary & DeCost 2021)
│   ├── chgnet_call.py                            # CHGNet (Deng et al. 2023)
│   └── m3gnet_call.py                            # M3GNet via MatGL (Chen & Ong 2022)
└── selftest/
    ├── materials_project_smoke.py                # MP offline replay
    ├── gnome_smoke.py                            # GNoME offline replay
    ├── matlantis_smoke.py                        # Matlantis offline replay
    ├── omat24_smoke.py                           # OMat24 offline replay
    ├── universal_ff_smoke.py                     # 5-FF aggregate offline replay
    └── sources_audit.py                          # SOURCES.md license + citation presence audit
```

License honesty matrix (per `_absorption_bridge/README.md`):

| System | License | Cost |
|---|---|---|
| Materials Project | CC-BY 4.0 (free API key) | $0 |
| GNoME | CC-BY 4.0 (Zenodo DOI 10.5281/zenodo.10371563) — **PREDICTED, NOT SYNTHESIZED** | $0 |
| Matlantis | Commercial (Preferred Networks) — **UNVERIFIED at hexa-matter scale** | $$$ |
| OMat24 | CC-BY 4.0 (HuggingFace `fairchem/OMAT24`) | $0 |
| SchNet / MACE / ALIGNN | MIT | $0 |
| CHGNet / M3GNet | BSD-3-Clause | $0 |

Run the bridge aggregator (also wired into `selftest/run_all.sh` as gate 23):

```bash
bash selftest/absorption_bridge_smoke.sh    # exit 0 = all 6 aggregators PASS (offline only)
```

- No n=6 lattice-fit applied to Materials Project / GNoME / Matlantis /
  OMat24 / universal-FF outputs. Each external system carries its OWN
  published error bars (DFT-PBE typical, force MAE 20–60 meV/Å per NNP).
- GNoME records preserve the **PREDICTED, NOT SYNTHESIZED** marker (per
  `INIT.md` hard rule 5).
- Matlantis adapter SKIPs by default (commercial closed SDK not on PyPI);
  pricing UNVERIFIED at hexa-matter scale economics.
- No live API call fires in `--selftest` — fixtures only.

## Provenance

Extracted from `canon/domains/materials/` @ `47c70cbf` (2026-05-09).
Each copy file carries a `@canonical:` provenance header injected by
`tools/inject_provenance.hexa`. Drift checked by `tools/check_drift.hexa`.

## Repo layout

```
hexa-matter/
├── README.md                 # this file
├── AGENTS.md                 # long-form agent ops guide
├── AGENTS.tape               # governance + identity (.tape)
├── CLOSURE_STATUS.md         # category (a)+(b) closure scoreboard
├── AXIS_CLOSURE_PLAN.md      # per-verb plan
├── INIT.md                   # bootstrap + invariants
├── hexa.toml                 # package manifest
├── docs/                     # human docs · logo
├── cli/                      # hexa-matter CLI entry
├── verify/                   # deterministic verification gates
├── selftest/                 # 32-gate selftest suite (run_all.sh)
├── _absorption_bridge/       # 16 DB / library adapters
├── _python_bridge/           # 12 Python→hexa modules (Phase E)
├── _research_bridge/         # 8 research modules (Phase F)
├── tools/                    # provenance + drift utilities
├── ceramics/ concrete/ silicon/ glass/        # ceramic group (CER)
├── hexa-polymer/ elastomer/ adhesive/ epoxy/  # polymer group (POL)
├── hexa-fiber/ aramid/ fabric/                # fiber group (FIB)
├── hexa-metal/ superalloy/                    # metal group (MET)
├── hexa-gem/ gemology/                        # gem group (GEM)
├── compound-semi/ perovskite/ 2d-materials/   # synthesis group (PRC)
├── biodegradable-plastics/ liquid-crystal/    # additional verbs
└── ... (36 verbs total — see AGENTS.tape §verb-coverage)
```

## License

MIT.
