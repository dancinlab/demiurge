# D116 Phase C inventory — `~/core/hexa-bio/` substrate-code audit + migration plan

## § 0. Purpose

D116 Phase C hexa-bio inventory + migration plan · per-directory audit (59 top-level dirs · 124,323 tracked LOC code · 135 .tape files · 193 md docs) · 8-15 cycle multi-stage migration to `~/core/hexa-lang/stdlib/bio/`. Read-only. No code change. No commit.

> **Prompt LOC vs reality**: prompt asserted "1506 LOC". Actual git-tracked code LOC (.hexa/.py/.swift/.c/.cpp/.rs/.go) = **124,323** across 416 tracked code files. `build/` (1.19M LOC) is gitignored compile artifacts — excluded from migration scope. Working set ≈ 124k LOC is the real D116 violator footprint.

---

## § 1. Top-level inventory

Reference snapshot: hexa-bio rider unknown (read-only). 59 top-level dirs + 217 top-level files (135 .tape · 17 md · misc cli/install hexa · roadmap dot-files).

Legend for **category**:
- **S** = substrate-code · D116 violator · target = `hexa-lang/stdlib/bio/`
- **D** = docs/narrative · D116 compliant · stays in hexa-bio
- **X** = scaffold/dead · `_*` cache or removed-Python parallel · separate-cycle removal candidate
- **T** = tape/SSOT · governance · classify per content (most STAY; cross-domain bleed flagged)
- **H** = hybrid · per-file split required
- **A** = artifact · gitignored build output

| dir | code | md | tape | tracked-LOC | category | note |
|---|---|---|---|---|---|---|
| `quantum/` | 10 | 0 | 0 | 1,612 | **S** | core-5 axis: VQE / pauli / external_pilot_runner / anima_phi pure-hexa modules |
| `weave/` | 7 | 1 | 0 | 2,010 | **S** | core-5 axis · v1.0.0 only fully-wired · cage assembly Bayesian |
| `nanobot/` | 16 | 1 | 0 | 4,372 | **S** | core-5 axis · pure-hexa actuation primitive |
| `ribozyme/` | 15 | 2 | 0 | 3,625 | **S** | core-5 axis · pure-hexa RNA catalyst |
| `virocapsid/` | 15 | 1 | 0 | 3,764 | **S** | core-5 axis · pure-hexa capsid assembly + PDB corpus |
| `_hexa_bridge/` | 112 | 0 | 0 | 40,809 | **S** | LARGEST · hexa-native ports of `_python_bridge` (selftest/module split) |
| `_python_bridge/` | 55 | 12 | 0 | 23,977 | **S/X** | sunset-target Python sims · `_hexa_bridge` ports replacing this · likely **dead-once-ported** |
| `_qiskit_bridge/` | 15 | 0 | 0 | 5,898 | **S** | quantum chemistry adapter (qiskit VQE/Pauli/UCCSD) — quantum subdomain |
| `_absorption_bridge/` | 19 | 10 | 0 | 1,877 | **S** | external-fold-adapter (AF3/OpenFold/ColabFold/ESMFold/Foldseek/MMseqs/Rosetta/UniProt/PDB) |
| `selftest/` | 32 | 0 | 0 | 12,427 | **S** | hexa+py selftest harness (atlas_atom_proofs, regression gates) |
| `tests/` | 67 | 0 | 0 | 6,931 | **S** | per-target pocket VQE / cohort audit Python tests (`*_v7.py`) |
| `case_studies/` | 12 | 13 | 0 | 7,524 | **H** | per-disease portfolio runner.py + docs (md) — split: runners → stdlib, narrative → stays |
| `drylab/` | 12 | 12 | 0 | 4,073 | **H** | sim/ + research/ + README — sim code is substrate, research md stays |
| `LVAD/` | 1 | 1 | 4 | 433 | **H** | 1 emitter py + scenario .tape (3 SHEAR_GATED_NANOBOT etc.) + AAV guides — split |
| `examples/` | 5 | 0 | 0 | 121 | **S** | 5 quick-start hexa snippets · move to `hexa-lang/stdlib/bio/examples/` or `demiurge/domains/bio/examples/` |
| `cli/` | 1 | 0 | 0 | 440 | **S** | `hexa-bio.hexa` axis router — port → `hexa-lang/stdlib/bio/cli/bio_router.hexa` |
| `allosteric/` | 1 | 0 | 0 | 165 | **S** | sub-axis verb (`.hexa`) :> QUANTUM |
| `aptamer/` | 1 | 0 | 0 | 230 | **S** | sub-axis verb :> RIBOZYME |
| `autac/` | 1 | 0 | 0 | 160 | **S** | sub-axis verb :> BIFUNCTIONAL |
| `bifunctional/` | 1 | 0 | 0 | 221 | **S** | expansion-main axis verb |
| `capsid_assembly_modulator/` | 1 | 0 | 0 | 242 | **S** | sub-axis verb :> VIROCAPSID |
| `covalent/` | 1 | 0 | 0 | 224 | **S** | expansion-main axis verb |
| `covalent_degrader/` | 1 | 0 | 0 | 169 | **S** | sub-axis verb :> BIFUNCTIONAL |
| `cryptic_pocket/` | 1 | 0 | 0 | 171 | **S** | sub-axis verb :> QUANTUM |
| `lytac/` | 1 | 0 | 0 | 157 | **S** | sub-axis verb :> BIFUNCTIONAL |
| `macrocycle/` | 1 | 0 | 0 | 232 | **S** | sub-axis verb :> WEAVE |
| `metallodrug/` | 1 | 0 | 0 | 209 | **S** | expansion-main axis verb |
| `molecular_glue/` | 1 | 0 | 0 | 175 | **S** | sub-axis verb :> BIFUNCTIONAL |
| `oligonucleotide/` | 1 | 0 | 0 | 233 | **S** | expansion-main axis verb |
| `peptide/` | 1 | 0 | 0 | 225 | **S** | sub-axis verb :> WEAVE |
| `ppi/` | 1 | 0 | 0 | 183 | **S** | sub-axis verb :> QUANTUM |
| `protac/` | 1 | 0 | 0 | 153 | **S** | sub-axis verb :> BIFUNCTIONAL |
| `reversible_covalent/` | 1 | 0 | 0 | 257 | **S** | sub-axis verb :> COVALENT |
| `ribotac/` | 1 | 0 | 0 | 163 | **S** | sub-axis verb :> BIFUNCTIONAL |
| `rna_targeting_small_molecule/` | 1 | 0 | 0 | 229 | **S** | sub-axis verb :> RIBOZYME |
| `crispr-gene-editing/` | 1 | 1 | 0 | 61 | **S** | `verify_crispr-gene-editing.hexa` n=6 check — small substrate |
| `AXIS/` | 0 | 4 | 1 | 0 | **D+T** | HIERARCHY.tape (governance SSOT) + INDEX/README/STATUS/THERANOSTIC_SCOPE md |
| `docs/` | 0 | 21 | 0 | 0 | **D** | 25 md (cycle handoffs, brainstorm, disease inventory, lessons) — stays |
| `proposals/` | 0 | 59 | 0 | 0 | **D** | 59 md proposals (hexa-bio + hexa-weave subtrees) — stays |
| `papers/` | 0 | 8 | 0 | 0 | **D** | 8 paper md (n6-hexa-bio-integrated, dolphin-bioacoustics, etc.) — stays |
| `wetlab/` | 0 | 13 | 0 | 0 | **D** | cro/ data/ ip/ mta/ regulatory/ sop/ README — pure narrative · stays |
| `breakthroughs/` | 0 | 2 | 0 | 0 | **D** | 2 md narrative · stays |
| `sessions/` | 0 | 3 | 0 | 0 | **D** | session handoff md · stays |
| `bio-pharma/` | 0 | 1 | 0 | 0 | **D** | 1-md axis-narrative landing page · stays |
| `biology-medical/` | 0 | 1 | 0 | 0 | **D** | 1-md ditto · stays |
| `biology/` | 0 | 1 | 0 | 0 | **D** | 1-md ditto · stays |
| `genetics/` | 0 | 1 | 0 | 0 | **D** | 1-md narrative · stays |
| `medical-device/` | 0 | 1 | 0 | 0 | **D** | 1-md narrative · stays |
| `synbio/` | 0 | 1 | 0 | 0 | **D** | 1-md narrative · stays |
| `incoming/` | 0 | 1 | 0 | 0 | **D** | `patches/` inbox · stays |
| `crispr-cas13-poc-diagnostic/` | 0 | 1 | 0 | 0 | **D** | doc-only domain page · stays |
| `hexa-nanobot/` | 0 | 1 | 0 | 0 | **D** | canon extract (`<!-- @canonical: canon@... -->`) of domain md · stays |
| `hexa-ribozyme/` | 0 | 1 | 0 | 0 | **D** | canon extract md · stays |
| `hexa-virocapsid/` | 0 | 1 | 0 | 0 | **D** | canon extract md · stays |
| `hexa-weave/` | 0 | 1 | 0 | 0 | **D** | canon extract md · stays |
| `__pyphi_cache__/` | 0 | 0 | 0 | 0 | **X** | `__pycache__`-like cache (PyPhi consciousness lib by-product) · disposable |
| `design/` | 0 | 0 | 0 | 0 | **X?** | `kick/` only · empty stub · likely dead |
| `state/` | 0 | 0 | 0 | 0 | **X** | runtime log/markers (gitignored content) — keep gitignore-only stub |
| `build/` | 1093 | 0 | 0 | 1,196,923 | **A** | gitignored hexa→C transpile artifacts (`_hxg_*.c` · `*.bin.c`) · NOT migration scope |

**Top-level singletons** (`hexa_bio.hexa` 124 LOC root dispatcher · `install.hexa` hx hook · `AGENTS.md` 16k · `CLAUDE.md` 188B symlink · `ARCH.md` · `CHANGELOG.md` · `CLOSURE_RESIDUAL_BACKLOG.md` · `COMPUTE_PORTFOLIO.md` · `AXIS_CLOSURE_PLAN.md` 74k · `.roadmap.*` ~190 hidden disease/scenario roadmaps): substrate **`hexa_bio.hexa` + `install.hexa` + `cli/`** moves to `hexa-lang/stdlib/bio/` (S); all md + roadmap dotfiles + AGENTS.md stay (D).

---

## § 2. Substrate-code directories (D116 migration target)

Per-directory target / shape / cellrun-compat / dependency / LOC / cost.

| # | dir | target | shape | cellrun-compat | depends-on | LOC | cost |
|---|---|---|---|---|---|---|---|
| S1 | `quantum/` | `hexa-lang/stdlib/bio/quantum/` | pure-move | firmware-ready (hexa modules · `@tool` decorator) | `_qiskit_bridge` (cross-axis) | 1,612 | **small** |
| S2 | `weave/` | `hexa-lang/stdlib/bio/weave/` | pure-move | firmware-ready | `_python_bridge` (weave_composition.py) | 2,010 | **small** |
| S3 | `nanobot/` | `hexa-lang/stdlib/bio/nanobot/` | pure-move | firmware-ready | self-contained | 4,372 | **small** |
| S4 | `ribozyme/` | `hexa-lang/stdlib/bio/ribozyme/` | pure-move | firmware-ready | self-contained | 3,625 | **small** |
| S5 | `virocapsid/` | `hexa-lang/stdlib/bio/virocapsid/` | pure-move | firmware-ready | `_absorption_bridge/pdb` (corpus builder) | 3,764 | **small** |
| S6 | `cli/` | `hexa-lang/stdlib/bio/cli/` | pure-move + path-rewrite | firmware-ready | all 5 core-axis | 440 | **micro** |
| S7 | `examples/` | `hexa-lang/stdlib/bio/examples/` | pure-move + `HEXA_BIO_ROOT` env-var sub | firmware-ready | 4 core axes | 121 | **micro** |
| S8 | `allosteric/ aptamer/ autac/ bifunctional/ capsid_assembly_modulator/ covalent/ covalent_degrader/ cryptic_pocket/ lytac/ macrocycle/ metallodrug/ molecular_glue/ oligonucleotide/ peptide/ ppi/ protac/ reversible_covalent/ ribotac/ rna_targeting_small_molecule/` | `hexa-lang/stdlib/bio/<verb>/` (19 dirs · flatten or keep nested) | pure-move (each is 1 `module/<verb>.hexa` file · 153–257 LOC) | firmware-ready (`#!hexa strict`) | parent axis (per AXIS/HIERARCHY.tape `:>` chain) | 3,758 total | **micro·batch** (single PR for all 19) |
| S9 | `crispr-gene-editing/` | `hexa-lang/stdlib/bio/crispr_gene_editing/` | pure-move | firmware-ready | none | 61 | **micro** |
| S10 | `_hexa_bridge/` | `hexa-lang/stdlib/bio/bridges/hexa/` or split per-axis | partial-move (largest dir · 112 files · selftest+module split) | firmware-ready (pure hexa) | all 24 axes (self-contained at bridge layer) | 40,809 | **medium-large** (4 sessions · split decision needed) |
| S11 | `_python_bridge/` | **OPEN QUESTION** — port-to-`_hexa_bridge` in progress; remaining = sunset OR migrate as legacy under `hexa-lang/stdlib/bio/legacy/python/` | hybrid: schemas (`spec/`) → atlas n6 / module py → port-or-sunset | sscb-pattern (Python argv-driven sims) | atlas + cross-axis | 23,977 | **large** (depends on porting status — many already hexa-mirrored) |
| S12 | `_qiskit_bridge/` | `hexa-lang/stdlib/bio/bridges/qiskit/` (or split → quantum-axis substrate) | refactor-into-stdlib (Python · keep argv shim) | sscb-pattern | qiskit (external dep) + quantum axis | 5,898 | **medium** |
| S13 | `_absorption_bridge/` | `hexa-lang/stdlib/bio/bridges/absorption/` | pure-move + per-tool subdir | sscb-pattern (each tool has its own `*_smoke.py`) | external tools (AF3, OpenFold, Foldseek, etc.) | 1,877 | **small** |
| S14 | `selftest/` | `hexa-lang/stdlib/bio/selftest/` | pure-move | hybrid (`*.hexa` + `*.py` mix) | all bridges + axes | 12,427 | **medium** |
| S15 | `tests/` | `hexa-lang/stdlib/bio/tests/` (or → atlas `verified_atoms` for v7 pocket-VQE locks) | pure-move + run-with-system-python3 | sscb-pattern (per-target Python `*_v7.py`) | `_qiskit_bridge` + atlas | 6,931 | **medium** |
| S16 | `case_studies/` (runner.py 부분) | `hexa-lang/stdlib/bio/case_studies/` (code only) — md stays | split-then-move | sscb-pattern (Python runners) | per-axis substrate + atlas | ~5,000 LOC code (rough; md = 7,524 mixed total) | **medium** |
| S17 | `drylab/sim/` | `hexa-lang/stdlib/bio/drylab/` (sim only; research md stays) | split-then-move | sscb-pattern | LVAD scenario + axes | ~3,000 LOC sim | **medium** |
| S18 | `LVAD/weave_coating_geometric_only_emitter.py` (1 file) | `hexa-lang/stdlib/bio/drylab/lvad/` (co-locate w/ drylab) | extract-1-file-then-move | sscb-pattern | weave + LVAD .tape | 433 | **micro** |
| S19 | `hexa_bio.hexa` (root dispatcher) | `hexa-lang/stdlib/bio/bio.hexa` | pure-move + cellrun `domains/bio.demi` shim | firmware-ready | all 24 axes | 124 (visible) | **micro** |
| S20 | `install.hexa` | `hexa-lang/stdlib/bio/install.hexa` or hx hook layer | pure-move | firmware-ready (hx hook) | hx pkg manager | ~50 visible | **micro** |

**Total substrate-code LOC (rough)**: 1,612 + 2,010 + 4,372 + 3,625 + 3,764 + 440 + 121 + 3,758 + 61 + 40,809 + 23,977 + 5,898 + 1,877 + 12,427 + 6,931 + ~5,000 + ~3,000 + 433 + 124 + 50 ≈ **120,289 LOC** to migrate (within the 124k tracked-code envelope · remainder ≈ 4k = scattered `.md`-aside test fixtures + non-code text in code files).

---

## § 3. Docs/narrative directories (stay in hexa-bio · D116 compliant)

Stays unchanged in `~/core/hexa-bio/` per D116 doctrine:

- `docs/` (25 md · cycle handoffs · disease inventory · brainstorm · lessons)
- `proposals/` (59 md · hexa-bio + hexa-weave proposal trees)
- `papers/` (8 md · paper drafts — n6-hexa-bio-integrated, dolphin-bioacoustics, genetics)
- `wetlab/` (13 md · cro/data/ip/mta/regulatory/sop/README · pure narrative · no code)
- `breakthroughs/`, `sessions/`, `incoming/`
- Mono-md placeholder dirs: `bio-pharma/`, `biology-medical/`, `biology/`, `genetics/`, `medical-device/`, `synbio/`, `crispr-cas13-poc-diagnostic/`
- Canon-extract dirs: `hexa-nanobot/`, `hexa-ribozyme/`, `hexa-virocapsid/`, `hexa-weave/` (each contains 1 `<!-- @canonical: canon@... -->` md)
- Top-level md (17): `AGENTS.md`, `ARCH.md`, `AXIS_CLOSURE_PLAN.md`, `CHANGELOG.md`, `CLAUDE.md`, `CLOSURE_RESIDUAL_BACKLOG.md`, `COMPUTE_PORTFOLIO.md`, `RTSC.md`, etc.
- Hidden `.roadmap.*` (~190 disease/scenario roadmap dotfiles · ~8-20k each · narrative roadmap content)

Mixed dirs split-policy: `case_studies/<portfolio>/`, `drylab/research/`, `LVAD/*.tape + README.md + *.tsv`, `_absorption_bridge/*/README.md`, `_python_bridge/module/*_subaxis.md`, `selftest/*.md` (if any) — **md/tsv/.tape pieces stay**, code parts migrate.

---

## § 4. Scaffold/dead directories (separate-cycle removal candidates)

| dir | status | recommendation |
|---|---|---|
| `__pyphi_cache__/` | 0 files tracked · PyPhi (consciousness lib by Tononi group) cache · 4 entries from `ls -la` | confirm via `git ls-files __pyphi_cache__` (should be empty) + add to `.gitignore` if not already · then `rm -rf` in cleanup cycle |
| `design/kick/` | empty stub | candidate removal (no content) |
| `state/` | gitignored runtime (markers, log) | KEEP dir + gitignore stub (`!.gitkeep`) — runtime artifact root |
| `build/` | gitignored hexa→C transpile output (1.19M LOC `.c` artifacts) | KEEP gitignored · NOT migration scope · rebuild on demand |

**Confirm before deletion**: `__pyphi_cache__/` content might be referenced by `_python_bridge` quantum-consciousness experiments — check git-tracked references before purge (use `git grep -l '__pyphi_cache__'`).

---

## § 5. Tape/SSOT special files (135 .tape · classification)

The `.tape` files are **70 unique stems** (each typically present as `STEM.tape` + `STEM.log.tape` pair). Categorization:

**T-Core (hexa-bio governance · STAYS · D116 compliant — tape is doc-shaped audit)**:
- `AGENTS.tape`, `AXIS.tape`, `AXIS_CLOSURE_PLAN.tape`, `AXIS/HIERARCHY.tape`, `CHANGELOG.tape`, `CLOSURE_RESIDUAL_BACKLOG.tape`, `COMPUTE_PORTFOLIO.tape`, `BIO-PHARMA.tape`, `BIOLOGY.tape`, `BIOLOGY-MEDICAL.tape`, `CANCER-THERAPY.tape`, `CRISPR-GENE-EDITING.tape`, `CRISPR-CAS13-POC-DIAGNOSTIC.tape`, `DECOMPOSITION_PLAN.tape`

**T-LVAD (scenario tapes · `LVAD/*.tape`)**: `LVAD/A2_STABILIZER.tape`, `LVAD/AAV_BTR_GENE_THERAPY.tape`, `LVAD/SHEAR_GATED_NANOBOT.tape`, `LVAD/WEAVE_COATING.tape` — STAYS in hexa-bio (scenario narrative).

**T-CrossDomain (NON-bio · candidates for relocation to OTHER project)**:
- `AGRICULTURE.tape` (25,908 B) + `.log.tape` — agriculture isn't bio
- `APICULTURE.tape` (beekeeping)
- `AQUACULTURE.tape` (fish farming)
- `BAKING.tape` (cookery)
- `BIOCHAR-DRYLAND-RESTORATION.tape` (geo · soil)
- `CHEESE-DAIRY.tape` (cookery)
- `COFFEE.tape` + `COFFEE-SCIENCE.tape` (cookery)

→ **Recommendation**: these 7 cross-domain tapes are **applied-biology** narrative that should live in a sibling repo (`~/core/hexa-life-applied/` or similar) per AXIS/INDEX.md hypothetical-axis discipline. **Open Q-1 to user** below.

**Memory aid**: Per user `MEMORY.md` — ".tape format not actively enforced — AGENTS.tape / ARCH.tape entries are doc-shaped audit; XCTest is the real enforcement vehicle right now. Don't block downstream work on `@D` row landing." → tape relocation is **cosmetic-only**, not blocking.

---

## § 6. Migration order proposal (Phase B-1 through B-5)

> Phased ordering optimizes for **zero-cross-dependency-first** then **deepening graphs**. Per user-confirmed B option: 8–15 cycle scope.

### Phase B-1 — foundation (cycles 1-3 · pure-move · zero cross-deps)

Targets: S19 (`hexa_bio.hexa` root) + S20 (`install.hexa`) + S6 (`cli/`) + S7 (`examples/`) + S9 (`crispr-gene-editing/`).

Why first: smallest LOC · pure-move · `.hexa` shebang already firmware-pattern. Establishes `hexa-lang/stdlib/bio/` skeleton + `hx install` entry point + CLI router. Cellrun `domains/bio.demi` lands in demiurge as part of B-1 cycle 3 (script-path = `~/core/hexa-lang/stdlib/bio/bio.hexa`).

**Cycles**: ~3 · cumulative migrated LOC ≈ **806** (1.1k including doc-rewires)

### Phase B-2 — core-5 axes (cycles 4-6 · pure-move · single-up-dep on B-1)

Targets: S1 (quantum) + S2 (weave) + S3 (nanobot) + S4 (ribozyme) + S5 (virocapsid) — but **weave** depends on `_python_bridge/weave_composition.py` (not yet ported) and **quantum** on `_qiskit_bridge` (sscb shim).

Compromise: migrate the **pure-hexa subset** of each axis in B-2 (skeleton + `*.hexa` modules); defer cross-axis bridges to B-3.

**Cycles**: ~3 · cumulative LOC migrated ≈ **15,383** (≈ 14.5k added)

### Phase B-3 — expansion + sub axes batch (cycles 7-8 · single-PR · `:>` dependency chain)

Targets: S8 (19 single-`.hexa` verb dirs — `allosteric/`, `aptamer/`, `autac/`, `bifunctional/`, `capsid_assembly_modulator/`, `covalent/`, `covalent_degrader/`, `cryptic_pocket/`, `lytac/`, `macrocycle/`, `metallodrug/`, `molecular_glue/`, `oligonucleotide/`, `peptide/`, `ppi/`, `protac/`, `reversible_covalent/`, `ribotac/`, `rna_targeting_small_molecule/`).

Each is a 153–257-LOC self-contained `module/<verb>.hexa` declaring `:>` parent. Pure-move batch (1-2 PR) per AXIS/HIERARCHY.tape ordering: expansion-main first (covalent/bifunctional/metallodrug/oligonucleotide), then sub-axes by parent chain.

**Cycles**: ~2 · cumulative LOC ≈ **19,141** (+ 3,758)

### Phase B-4 — bridges + selftest + tests (cycles 9-12 · medium · cross-axis)

Targets: S10 (`_hexa_bridge/` 40,809 LOC), S12 (`_qiskit_bridge/` 5,898), S13 (`_absorption_bridge/` 1,877), S14 (`selftest/` 12,427), S15 (`tests/` 6,931), S16 (`case_studies/` ~5k code), S17 (`drylab/sim/` ~3k), S18 (`LVAD/weave_coating_geometric_only_emitter.py` 433).

Why later: `_hexa_bridge` is the largest single chunk and depends on **all 24 axes already landed** (B-2 + B-3). Bridges + selftest + tests follow naturally once verbs are in place.

This is the **bulk of LOC migration** (~76,375 of 120k = 63%).

**Cycles**: ~4 · cumulative LOC ≈ **95,516** (+ 76,375)

### Phase B-5 — `_python_bridge` decision + cleanup (cycles 13-15 · large · sunset OR legacy-port)

Target: S11 (`_python_bridge/` 23,977 LOC) — **decision-required**: port-to-`_hexa_bridge` already largely happened (cycle 24+, 2026-05-04 onward per `weave/module/weave.hexa` provenance comment). Three options:

1. **Sunset** — confirm full `_hexa_bridge` parity per file, delete `_python_bridge` (cleanup commit).
2. **Legacy-port** — move intact to `hexa-lang/stdlib/bio/legacy/python/` for reference/regression-testing only.
3. **Selective port** — port not-yet-mirrored files, sunset the rest.

Also in B-5: `__pyphi_cache__/` removal (Q-1 conditional on user OK), `design/kick/` removal, cellrun-adapter completion (any missing `domains/bio*.demi` manifests for sub-axes), hexa-bio docs-only attestation commit.

**Cycles**: ~3 · cumulative LOC ≈ **119,493** (+ 23,977 sunset/move)

**Total scope**: 15 cycles · 120k LOC migrated · ≈ **upper-bound of user 8-15 cycle envelope**.

---

## § 7. Cellrun-compat audit summary

Per ARCH §4.5 / D111 cellrun pattern: substrate needs argv-driven entry (firmware-pattern via hexa modules OR sscb-pattern via Python argv shim).

| pattern | dir count | LOC | notes |
|---|---|---|---|
| **firmware-ready** (pure `.hexa` modules · `@tool` decorator · `#!hexa strict` shebang · argv via `env()` reads) | quantum · weave · nanobot · ribozyme · virocapsid · cli · examples · 19 sub/expansion axes · `_hexa_bridge` · crispr-gene-editing · root dispatcher · install | ~63,000 LOC | majority of substrate · pure-move to `hexa-lang/stdlib/bio/` per dir + cellrun spawns via `hexa run <script>` |
| **sscb-pattern** (Python with argv parsing · stdlib-only or numpy-opt-in · existing JSON I/O) | `_python_bridge` · `_qiskit_bridge` · `_absorption_bridge` · `selftest` (py subset) · `tests` · `case_studies` runners · `drylab/sim` · `LVAD` emitter | ~52,000 LOC | needs shim layer in `domains/bio.demi` cellrun manifest · per-file argv signature audit during migration · matches MaterialFalsifier sscb precedent |
| **from-scratch** (none required) | — | 0 | hexa-bio substrate is mature · no greenfield substrate needed |
| **mixed within-dir** | selftest (hexa + py) · case_studies (py runner + md) · drylab (py sim + md research) · LVAD (1 py + 4 tape + tsv + md) | — | per-dir split during migration · code → stdlib · narrative → stays in hexa-bio |

---

## § 8. Open questions for user

**Q-1 (cross-domain tapes)**: 7 cross-domain `.tape` files at hexa-bio root (`AGRICULTURE.tape` · `APICULTURE.tape` · `AQUACULTURE.tape` · `BAKING.tape` · `BIOCHAR-DRYLAND-RESTORATION.tape` · `CHEESE-DAIRY.tape` · `COFFEE.tape` + `COFFEE-SCIENCE.tape`) → these are applied-biology / food / agro · NOT bio in the n=6 axis sense. Migrate to a new sibling repo `~/core/hexa-life-applied/` (or rename current scope)? Or stay (acknowledge hexa-bio = "bio + life-applied")?

**Q-2 (`__pyphi_cache__/`)**: confirm disposal · likely PyPhi consciousness lib cache by-product · should be `.gitignore`-d not committed · git status should clarify. Run `git ls-files __pyphi_cache__/ | wc -l` before deletion.

**Q-3 (`_qiskit_bridge` boundary)**: 5.9k LOC quantum-chem adapter under hexa-bio. Quantum chemistry is **dual-domain** (quantum + bio cross-axis). Migration target options: (a) `hexa-lang/stdlib/bio/bridges/qiskit/` (stays bio), (b) `hexa-lang/stdlib/quantum/bridges/qiskit/` (cross-cut), (c) new `hexa-lang/stdlib/quantum-chem/`. Which?

**Q-4 (`_python_bridge` sunset vs legacy)**: 23,977 LOC Python sims · `_hexa_bridge` is the port target (40k LOC hexa-native landed). Are all `_python_bridge` files mirrored, or selective sunset needed? Need a parity audit pre-B-5.

**Q-5 (case_studies / drylab split granularity)**: these are **hybrid dirs** (code + md per disease/scenario). Option A: split per dir (code → stdlib, md stays). Option B: move whole dir (md goes too — violates D116). Option C: re-arrange so all py is consolidated under `*/sim/` subdirs and only those move. Confirm policy.

**Q-6 (cellrun manifest granularity)**: one `domains/bio.demi` for all 24 axes, OR one `.demi` per axis (`domains/bio_quantum.demi`, `domains/bio_weave.demi`, ..., 24 manifests)? Per-axis is more granular but explodes manifest count. RFC needed.

**Q-7 (`build/` policy on hexa-lang side)**: `build/` is gitignored hexa→C transpile output (1.19M LOC). After migration, the hexa-lang stdlib build cache will explode similarly. Confirm `.gitignore` policy carries over.

---

## § 9. Total LOC migration estimate + timeline

| metric | value |
|---|---|
| Total git-tracked code LOC (current hexa-bio) | **124,323** |
| Total substrate-code LOC for migration | **≈ 120,289** (96.8% of tracked) |
| Docs/narrative LOC (stays in hexa-bio) | hard to count; ~5 MB of md across `docs/`, `proposals/`, `papers/`, `wetlab/`, top-level + 190 `.roadmap.*` |
| Tape governance files (stays) | 135 .tape (70 unique stems) |
| Scaffold/dead candidates | `__pyphi_cache__/`, `design/kick/` (2 dirs · ~0 LOC) |
| Build artifacts (gitignored, NOT migrated) | 1,196,923 LOC (rebuilds on demand) |
| **Phase B-1** | 3 cycles · 806 LOC |
| **Phase B-2** | 3 cycles · 14,577 LOC |
| **Phase B-3** | 2 cycles · 3,758 LOC |
| **Phase B-4** | 4 cycles · 76,375 LOC |
| **Phase B-5** | 3 cycles · 23,977 LOC (+ cleanup) |
| **Total cycles** | **15** (upper bound of 8-15 envelope) |
| **Cumulative LOC migrated** | **119,493** (96% — `_python_bridge` sunset closes the gap) |

Cycle-week translation depends on session cadence. At G-cycle 2026-05-22 rate (~1 substantive PR/cycle for medium complexity), 15 cycles ≈ **15-25 calendar days** assuming dedicated focus, or **2-4 months** in mixed-priority cadence with PR review latency.

---

## § 10. Cross-link

- **D116 ratification commit**: demiurge `709dea9` (constitution R3 1.3.0 → 1.3.1 PATCH · ARCH §0 + §4.4 + §4.5 narrative)
- **ARCH §4.4**: "sibling repos (hexa-rtsc · hexa-matter · hexa-bio · hexa-chem) = docs only · NO code"
- **ARCH §4.5**: cellrun reads `.demi` manifest from `domains/` · resolves substrate `script` under `~/core/hexa-lang/stdlib/<domain>/` (NEVER sibling repo)
- **Constitution R3 v1.3.1**: substrate-code = hexa-lang stdlib ONLY
- **Precedent (D114 Phase B)**: `inbox/notes/2026-05-21-d114-phaseb-material-falsifier-audit.md` + D116 corrigendum block — same audit-then-migrate pattern · MaterialFalsifier 438 LOC was R3 violation in cockpit → migration target `hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa` (sibling-repo move forbidden post-D116)
- **CLAUDE.md Principles**: 1 (ai-native) · 2 (hexa-first — "absorbed stdlib over hand-rolling") · 4 (domain-meta-domain) · 5 (lattice-as-tool · n=6 not constraint)
- **MEMORY note**: ".tape format not actively enforced — XCTest is the real enforcement vehicle right now" → tape migration is cosmetic, not blocking
- **Cellrun precedent**: D111 + ARCH §4.5 (cellrun `.demi` manifest pattern); D14/D18/D74/D80/D83 (`.demi` precedent)
- **G-cycle context**: post-G33 LANDED (κ-69 R8 4/4 closure · commit `8402ed2`) + post-`ae9e5a2` (ARCH log)

---

**END · Phase C inventory complete · NO migration executed · note untracked per instruction**
