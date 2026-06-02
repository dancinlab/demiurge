# hexa-bio v1.0.0 — Molecular Toolkit (HEXA family)

**Release date**: 2026-05-04
**Closure verdict**: **PARTIAL_PASS** (1/4 verbs wired; 3/4 stubs with
falsifier preregister)
**Provenance**: extracted 2026-05-04 from `nexus/sim_bridge/weave/`
(canonical-from cycle 24, 2026-04-29). Sister-extraction of `qmirror` v2.0.0
(registry L22) and `sim-universe` v1.0.0 (registry L23). hexa-bio is the
**24th** entry.

This is the **initial standalone release** of `hexa-bio`, a 4-verb molecular
substrate organized around the **n=6 invariant lattice**: WEAVE / NANOBOT /
RIBOZYME / VIROCAPSID. One sister axis (`weave`) is empirically wired with
full Caspar-Klug + Zlotnick cage-assembly sandbox + Bayesian σ(6)=12
STRUCTURAL-EXACT audit; three sister axes ship as stub placeholders with
falsifier preregister at v1.0.0.

## Highlights

- **4-verb tetrahedron** — WEAVE (composition, WIRED), NANOBOT (actuation,
  STUB), RIBOZYME (catalysis, STUB), VIROCAPSID (assembly, STUB).
- **WEAVE empirical sandbox** — Caspar-Klug 1962 + Zlotnick 2003 ODE
  (cache-only by default; numpy/scipy opt-in via `HEXA_BIO_WITH_NUMPY=1`);
  Bayesian audit posterior 0.97 for T=1 60-subunit icosahedral cage.
- **n=6 invariant lattice** — `σ(6)=12, τ(6)=4, φ(6)=2, J₂=24`; master
  identity `σ·φ = n·τ = 24`. Algebraic backbone is shared across all
  4 verbs (only `weave` empirically grounded; others inherit by hypothesis —
  see Caveats §3).
- **CLI** — 7 subcommands (`weave`, `nanobot`, `ribozyme`, `virocapsid`,
  `status`, `selftest`, `help`); every subcommand accepts `--version`.
- **Selftest** — 4-verb sentinel sweep; `__HEXA_BIO_SELFTEST__ PASS` confirms
  all 4 modules load + print falsifier preregister tables (sentinel-only
  PASS does NOT validate empirical claims — see Caveats §1).
- **Apache-2.0** license; optional Python aux deps (`numpy`, `scipy`)
  ship under their own BSD-3 licenses; in-process safe (no copyleft).
  hexa-bio core stays Apache-2.0 under FSF MereAggregation.
- **GitHub-only distribution** — canonical at
  <https://github.com/dancinlab/hexa-bio>. (HF Hub mirror retired
  2026-05-04; HF Hub is designed for ML model weights / datasets, not CLI
  tooling.)

## Installation

```bash
# Recommended (post-hx install registration):
hx install hexa-bio@1.0.0
hexa-bio --version           # → 1.0.0

# Or git clone (works today):
git clone https://github.com/dancinlab/hexa-bio.git ~/.hexa-bio
export HEXA_BIO_ROOT=~/.hexa-bio
export PATH="$HEXA_BIO_ROOT/cli:$PATH"
hexa-bio selftest
```

## Quickstart

```bash
hexa-bio selftest                                # 4-verb sentinel sweep
hexa-bio weave                                   # default skeleton + n=6 + falsifier
hexa-bio weave --bayesian-audit                  # cached posterior 0.97 (no Python)
HEXA_BIO_WITH_NUMPY=1 hexa-bio weave --all       # full empirical paths
hexa-bio nanobot                                 # STUB — falsifier preregister only
hexa-bio ribozyme                                # STUB — falsifier preregister only
hexa-bio virocapsid                              # STUB — falsifier preregister only
```

## Distribution (GitHub canonical)

- canonical: <https://github.com/dancinlab/hexa-bio>

> HF Hub mirror retired 2026-05-04 — HF Hub is designed for ML model weights /
> datasets, not CLI tooling. GitHub remains canonical.

## Honest C3 caveats

The 5 base caveats (3/4 verbs are stub-only; falsifiers are initial-guess
deadlines; n=6 lattice claim speculative for 3/4 axes; weave-migration
edge-case consumers; GitHub-only distribution) are documented in
[README §Caveats](README.md#caveats-raw10-honest-c3). The polish cycle
adds 3 further disclosures specific to the v1.0.0 publication:

1. **GitHub release deletion is friction-laden** — once `v1.0.0` is
   published it is technically deletable but the tag OID lives on in any
   clone that fetched it; treat each release as effectively immutable.
2. **Public-repo maintenance burden** — issue/PR triage cost is now on the
   author; downstream consumers should not assume future SLA.
3. **Sister-cycle race risk** — qmirror, sim-universe, honesty-monitor polish
   cycles run in parallel; if any sister repo diverges in workflow/badge
   conventions, manual reconciliation is required (no cross-repo CI).

## Provenance

- WEAVE module imported from `nexus/sim_bridge/weave/` (commit `f81239d6+`,
  cycle 24 canonical, 2026-04-29). Original concept: `canon/
  domains/biology/hexa-weave/hexa-weave.md` empirical companion.
- NANOBOT/RIBOZYME/VIROCAPSID modules created **fresh** as stub
  placeholders during this extraction (2026-05-04) — no prior nexus
  implementation existed beyond .roadmap / atlas.append marker entries.
- Standalone-extraction cycle: `hexa_bio_standalone_extraction_2026_05_04`
  (commit `3877f5e` — initial extraction).
- Polish cycle: `hexa_bio_polish_2026_05_04` (this release).
- HF Hub mirror retired 2026-05-04 (GitHub canonical for CLI tooling).
- Sister extractions: `qmirror` v2.0.0, `sim-universe` v1.0.0,
  `honesty-monitor` v1.0.0.

## License

Apache-2.0 — see [LICENSE](LICENSE).

Author: 박민우 <nerve011235@gmail.com>

---

## v1.0.0 — post-release expansion layer (2026-05-16 session)

> **No version bump.** This is `v1.0.0 + an expansion layer`, NOT
> `v1.1.0` or `v2.0.0`. The committed core-5 `AXIS.tape` SSOT and the
> v1.0.0 release artefact above are UNCHANGED. The 2026-05-16 work
> landed as a separate governed expansion layer
> (`AXIS/HIERARCHY.tape`) with the original keep-5 dissent preserved
> verbatim in `AXIS/README.md` §4.

> **Honest scope fence (`g1` real-limits · `g3` honesty-external ·
> `g8` in-silico-only / `f2`)**: every claim below verifies in-silico
> simulator + metadata internal consistency ONLY. NEVER a
> therapeutic, clinical, regulatory, immunogenic, efficacy, potency,
> selectivity, DC50, Dmax, or wet-lab claim. Axis counts are an
> architectural decision (`f_lattice_fit`), NOT derived from any n=6
> lattice scalar. CBER-regulated modalities (GENETIC-MEDICINE / ADC /
> Zolgensma / anti-SARS-CoV-2 mAbs / CAR-T) remain **UNPLACED** per
> criterion #4 (drug-only / CDER discipline) — they are NOT
> implemented as code axes; the case studies surface them as
> `axis=null` schema-const entries.

The 2026-05-16 work session (8 commits, `4bd144b` → `ff72657`) added
an axis EXPANSION layer + cross-axis bridges + per-disease case
studies + an infrastructure-gate suite on top of v1.0.0. The
chronological per-commit record lives in
[`CHANGELOG.md`](CHANGELOG.md); per-tape Logs in
[`AXIS/HIERARCHY.tape`](AXIS/HIERARCHY.tape) `## Log` and
[`AXIS/README.md`](AXIS/README.md) §8. This addendum summarizes that
work at the release-notes layer. All numbers below are cross-checked
against [`AXIS/STATUS.md`](AXIS/STATUS.md) (auto-generated dashboard,
disk truth at HEAD `ff72657`).

### §A Expansion layer summary

| Layer | Count | SSOT |
|---|---|---|
| **Core axes** (UNCHANGED) | **5** | `AXIS.tape` (QUANTUM · WEAVE · NANOBOT · RIBOZYME · VIROCAPSID) |
| **Expansion-MAIN** | **4** | `AXIS/HIERARCHY.tape` §1 (COVALENT · BIFUNCTIONAL · METALLODRUG · OLIGONUCLEOTIDE) |
| **Sub-axes** | **15** | `AXIS/HIERARCHY.tape` §2 (6 `:>` BIFUNCTIONAL · 3 `:>` QUANTUM · 2 `:>` WEAVE · 1 `:>` COVALENT · 2 `:>` RIBOZYME · 1 `:>` VIROCAPSID) |
| **Total architectural axes** | **24** | architectural (NOT lattice-derived); core SSOT still 5 |

Per `STATUS.md` §1: 5 core + 4 expansion-MAIN + 15 sub-axes = **24
total**, architectural (`f_lattice_fit` clean — counts trace to user
direction + README promotion criteria, NOT to `σ(6)=12 · τ(6)=4 ·
φ(6)=2 · J₂=24`). The 4 expansion-MAIN each ship as
`HEXA-<AXIS>.tape` + `<axis>/module/<axis>.hexa` axis-verb + Python
bridge sim + draft-07 schema. The 15 sub-axes each ship as Python
bridge sim + draft-07 schema + sub-axis note + a `.hexa` announce/
status verb (main+sub `.hexa` parity now complete: 4 + 15).

### §B Cross-axis bridges

Cross-axis bridge sims at HEAD `ff72657`: **21** (disk truth,
`_python_bridge/module/*_cross.py`, matches `STATUS.md` §5). A
cross-axis bridge is **NOT a new axis** — it imports both sides' sims
(`f3` no-fork) and carries a passing sentinel + draft-07 schema + a
mathematical-equivalence ≠ mechanistic-equivalence honesty fence
(`comparison_is_ranking=false` schema-const where applicable).

| Round | Section | Bridges | Pattern |
|---|---|---|---|
| A1–A5 | `HIERARCHY.tape` §2.5 | METALLODRUG×QUANTUM-VQE · OLIGO-offtarget×RIBOZYME-GENCODE · RNA-targeting-SM vs OLIGO (SMN2) · CAM×VIROCAPSID-PDB · REVERSIBLE-COVALENT×Mpro-VQE | expansion → core/expansion |
| F1–F3 | `HIERARCHY.tape` §2.6 | OLIGO×NANOBOT · APTAMER×NANOBOT · CAM×WEAVE | expansion → previously-uncrossed core (NANOBOT, WEAVE) |
| G1–G5 | `HIERARCHY.tape` §2.8 | PROTAC×CAM · ALLOSTERIC×CRYPTIC-POCKET · PPI×MOLECULAR-GLUE · PEPTIDE×MACROCYCLE · APTAMER×OLIGO | expansion × expansion unifications (math-equiv ≠ mech-equiv) |
| J1–J3 | `HIERARCHY.tape` §2.11 | METALLODRUG×RIBOTAC · AUTAC×CRYPTIC-POCKET · MOLECULAR-GLUE×ALLOSTERIC | matrix-fill, mechanism-disjoint (sum refused) |
| W/N round-5 | `HIERARCHY.tape` §2.14 | PEPTIDE×NANOBOT · MACROCYCLE×NANOBOT · OLIGO×RIBOTAC · PROTAC×PPI · **METALLODRUG×COVALENT×QUANTUM (3-axis)** | first 3-axis bridge at Pt-N7 ~2.0 Å event |

**Mechanism-disjoint sum-refusal** (J1 + N1 signature): when two
axes describe the same event under different mechanism classes, the
bridges report magnitudes side-by-side without summing.
Mathematical equivalence ≠ mechanistic / operational equivalence.

### §C Case studies

Per `STATUS.md` §6: **5 disease portfolios + 1 landscape + 1
drug-redesign sandbox** in `case_studies/`. These are honest
one-disease pilots — they are **NOT** the deferred 200-disease
re-mapping (which remains DEFERRED in `CLOSURE_RESIDUAL_BACKLOG.md`).

| Artefact | Path | What it composes |
|---|---|---|
| HIV-1 portfolio | [`case_studies/hiv1_portfolio/`](case_studies/hiv1_portfolio/) | lenacapavir (Sunlenca, FDA 2022) CAM + maraviroc (Selzentry, FDA 2007) ALLOSTERIC; ASOs / HIV-PROTACs / gene-editing curatives listed UNPLACED |
| SMA portfolio | [`case_studies/sma_portfolio/`](case_studies/sma_portfolio/) | risdiplam (Evrysdi, FDA 2020) RNA-targeting-SM + nusinersen (Spinraza, FDA 2016) OLIGO; Zolgensma (Zolgensma 2019, CBER) UNPLACED with schema-const `axis=null` |
| Mpro / COVID portfolio | [`case_studies/mpro_covid_portfolio/`](case_studies/mpro_covid_portfolio/) | nirmatrelvir (Paxlovid, FDA 2022 EUA / 2023 NDA) REVERSIBLE-COVALENT; ensitrelvir PMDA-only + non-covalent research + anti-SARS-CoV-2 mAbs (CBER, withdrawn) UNPLACED |
| KRAS-G12C portfolio | [`case_studies/kras_g12c_portfolio/`](case_studies/kras_g12c_portfolio/) | sotorasib (Lumakras, FDA 2021) + adagrasib (Krazati, FDA 2022) COVALENT × CRYPTIC-POCKET (dual mapping) |
| BCL2 portfolio | [`case_studies/bcl2_portfolio/`](case_studies/bcl2_portfolio/) | venetoclax (Venclexta, FDA 2016) PPI + navitoclax clinical-stage (`fda_approval_status` enum); CAR-T (CBER) UNPLACED |
| Landscape | [`case_studies/landscape/`](case_studies/landscape/) | auto-generated 5-diseases × 24-axes = 120 cells (8 FDA-occupied 6.7% · 7 research-stage 5.8% · 105 honest empty 87.5% + 4 disease-level UNPLACED) |
| Drug-redesign sandbox | [`case_studies/drug_redesign_sandbox/`](case_studies/drug_redesign_sandbox/) | Mpro single-target through 4 modality lenses (REVERSIBLE-COVALENT status-quo · COVALENT irreversible · PROTAC degradation · PPI disruption); 9 schema-const honesty fields enforce "NOT a redesign proposal" |

### §D Infrastructure gates

> Disk truth at HEAD `ff72657`, cross-checked against `STATUS.md`.

- **P1 atlas atom proofs** — `selftest/atlas_atom_proofs.py`: 5
  symbolic / closed-form proofs (Caspar-Klug T-number geometry ·
  Griffith-Orgel CFSE · MWC `P_R + P_T = 1` · cooperative ternary
  partition function · 2×2 CI eigenvalue) using sympy + fractions
  exactness.
- **R1 atlas-atom tier-upgrade gate** —
  `selftest/atlas_atom_tier_upgrade_gate.py` +
  `_python_bridge/spec/atlas_atom_registry.json`: connects P1's 5
  proven atoms to **16 anchored sims as 🔵-eligible PROPOSAL**.
  Honest discipline — PROPOSAL ≠ ENFORCEMENT — the I3 tier reporter
  on disk stays at **1 🔵** (`lean4_proof_witness_emit`) until a
  sister-repo `hexa-meta` lean4 flip lands:
  - AS-IS (I3 reporter, `STATUS.md` §2): **42 🟢 · 1 🔵 · 1 🟠 · 0 🔴** (44 sims)
  - PROPOSED (R1 registry, not adopted): 16 additional sims 🔵-eligible
- **S-new schema-const audit** — `selftest/schema_const_audit.py`:
  scans 103 schemas; 1 TYPED-ONLY gap found AND closed in the same
  commit (`capsid_modulator_weave_cross_v1.schema.json`
  `illustrative_only`: typed-only → `const: true`). Now 101/101
  honesty-bearing fields are structurally const-enforced.
- **X1 deferred-items tracking gate** —
  `selftest/deferred_items_tracking_gate.py`: honest boundary
  enforcer for the 4 STILL-DEFERRED items + 1 PARTIALLY-RESOLVED
  (atlas 🔵). FAIL only on UN-DEFERRED-VIOLATION (silent un-defer
  without governance update).
- **O3 status dashboard** — `selftest/status_md_generator.py` +
  [`AXIS/STATUS.md`](AXIS/STATUS.md): 8-section auto-generated
  dashboard aggregating tier reporter + falsifier gate + determinism
  gate; byte-identical re-runs (fixed timestamp string).
- **I2 determinism regression gate** —
  `selftest/determinism_regression_gate.py`: 32 sims × 2 runs under
  `PYTHONHASHSEED=0` / `PYTHONDONTWRITEBYTECODE=1`, byte-for-byte
  stdout comparison. Per `STATUS.md` §4: **32 DETERMINISTIC · 0
  NON_DETERMINISTIC · 0 SKIP**.
- **I3 hexa-verify tier batch reporter** —
  `selftest/hexa_verify_tier_batch.py`: TIER REPORTER (not enforcer)
  for the 44-sim roster. 3-precedence classification (SKIP →
  self-declared glyph → real-limit heuristic); silent fall-through
  is honestly 🟠 (no tier inflation).
- **O2 cross-axis matrix** — `selftest/cross_axis_matrix.py`: 24×24
  matrix; 18/276 pair-cells (6.5%) covered by 17 cross files
  (handles 2-axis + 3-axis bridges uniformly). Empty cells are
  honest.
- **N2 portfolio fitness function reporter** —
  `selftest/portfolio_fitness_function.py`: reporter (NOT ranker)
  across all portfolios; 3 independent metrics (`drug_existence` /
  `axis_coverage` / `honesty_completeness`); no compound score;
  `comparison_is_ranking=false`.
- **K2 external governance cross-check** —
  `selftest/external_governance_cross_check.py`: 115 `@X`
  external-citation entries across 11 tapes; 18 PRESENT · 0
  MISSING-PATH · 3 URL-SKIP (offline-honest) · 94 NO-TARGET
  (bibliographic). COEXIST `AGENTS.tape` + `AGENTS.md` contract
  verified.
- **Falsifier execution gate** —
  `selftest/falsifier_execution_gate.py`: per `STATUS.md` §3,
  **12 falsifiers all HOLD · 0 FALSIFIED · 0 SKIP**
  (F-METALLODRUG-1/2/3 · F-OLIGO-1/2/3 · F-COVALENT-1/2/3 ·
  F-BIFUNCTIONAL-1/2/3). The Eyring prefactor
  (`k_B · 310 / h ≈ 6.459 × 10¹² s⁻¹`) is **independently re-derived
  from CODATA 2019 inside the gate** — the sim's value is NOT trusted
  blindly.
- **Selftest sweep** — [`selftest/run_all.sh`](selftest/run_all.sh)
  pre-round-5 long-run: **96 PASS / 0 FAIL** (`HIERARCHY.tape` `## Log`).
  Post-round-5 long-run not yet re-executed at HEAD `ff72657`.
- **Honesty cohort lint** — **69/69 PASS** (meta-mode opt-in covers
  meta tapes per `AGENTS.tape` `g_meta_mode_optin`).

### §E Honesty discipline highlights

- **`f_lattice_fit` clean across all 4 expansion-MAIN + 15 sub-axes**
  — none of the count / placement / score decisions are derived from
  the n=6 lattice (`σ=12 · τ=4 · φ=2 · J₂=24`). Counts trace to user
  direction + README promotion criteria
  (modality / non-overlap / rigor / scope / falsifier). Borderline
  `:>` placement tensions (e.g. PPI score-main-eligible but
  user-placed as sub) are openly flagged in `HIERARCHY.tape` §2.
- **`g8` / `f2` in-silico-only fence** — every gate, falsifier HOLD,
  DETERMINISTIC verdict, case-study sentinel, and tier glyph verifies
  simulator + metadata internal consistency ONLY. NEVER a wet-lab,
  clinical, regulatory, immunogenic, efficacy, potency, selectivity,
  DC50, Dmax, or portfolio-recommendation claim.
- **Schema-const honesty enforcement** — honesty caveats
  (`comparison_is_ranking=false` · `signals_commensurable=false` ·
  `creates_a_new_axis=false` · `illustrative_only=true` ·
  `research_stage_modality=true` · `linker_cost_pre_paid=true` ·
  `cross_is_three_axis=true` etc.) are encoded as draft-07 `const`
  fields in 21 schemas, not free-text in prose. S-new audit closed
  the final TYPED-ONLY gap in the same commit as the audit gate.
- **Deferred items still deferred** — the X1 gate enforces 4
  STILL-DEFERRED + 1 PARTIALLY-RESOLVED:
  - 200-disease re-mapping (the 5 case-studies in §C are **NOT** a
    replacement — they are deliberate one-disease pilots)
  - GENETIC-MEDICINE code axis (CBER scope, criterion #4 — Zolgensma)
  - ADC code axis (CBER antibody component, criterion #4)
  - THERANOSTIC scope decision
    ([`AXIS/THERANOSTIC_SCOPE.md`](AXIS/THERANOSTIC_SCOPE.md)
    FOR-5 / AGAINST-5 / DEFERRED document does **NOT decide**;
    awaits USER choice)
  - PARTIALLY-RESOLVED: atlas 🔵 upgrade (R1 proposes 16 sims as
    🔵-eligible; sister-repo `hexa-meta` lean4 flip required for
    adoption)
- **Core-5 UNCHANGED at HEAD `ff72657`** — the committed
  [`AXIS.tape`](AXIS.tape) SSOT remains QUANTUM · WEAVE · NANOBOT ·
  RIBOZYME · VIROCAPSID, exactly as v1.0.0. The expansion layer
  sits in a separate file (`AXIS/HIERARCHY.tape`) and cross-links to
  the core, never mutates it.
- **§4 keep-5 dissent preserved verbatim** — the rigorous
  axis-expansion analysis in [`AXIS/README.md`](AXIS/README.md) §4
  recommended KEEP 5 axes + cross-cutting platform layer. The
  expansion layer overrides that recommendation per explicit USER
  DIRECTION 2026-05-16; the dissent text is **NOT erased**, and
  both stand on the record (also marked in `HIERARCHY.tape` as
  `@N rigorous_dissent`).
- **CBER-scope UNPLACED items (criterion #4)** — GENETIC-MEDICINE,
  ADC, Zolgensma (onasemnogene abeparvovec), anti-SARS-CoV-2 mAbs,
  and CAR-T remain **UNPLACED**. They are not code axes; they
  surface as `axis=null` schema-const entries in the affected case
  studies. Implementing them as code axes would breach `g8` +
  criterion #4 (drug-only / CDER discipline).
- **External-contact deferral (`g9` / `g10`) clean** — the LVAD
  RFP / SOP drafts from `93e4a88` sit in-repo with STATUS
  `draft-ready` only; no user-send was proposed in any commit body
  of this session.

### §F Cross-links (single source of truth per scope)

| Scope | File |
|---|---|
| Chronological session record | [`CHANGELOG.md`](CHANGELOG.md) (8 commits, `4bd144b` → `ff72657`) |
| Architecture (core, UNCHANGED) | [`AXIS.tape`](AXIS.tape) + [`AXIS.log.tape`](AXIS.log.tape) |
| Expansion-layer SSOT (this addendum's primary surface) | [`AXIS/HIERARCHY.tape`](AXIS/HIERARCHY.tape) — §1 / §2 / §2.5–§2.16 + `## Log` |
| Gate-aggregation dashboard (numbers above traced here) | [`AXIS/STATUS.md`](AXIS/STATUS.md) (auto-generated, byte-identical re-runs) |
| Rigorous keep-5 dissent (preserved verbatim) | [`AXIS/README.md`](AXIS/README.md) §4 |
| THERANOSTIC scope (DEFERRED, document does NOT decide) | [`AXIS/THERANOSTIC_SCOPE.md`](AXIS/THERANOSTIC_SCOPE.md) |
| Per-disease pilots (NOT 200-disease deferred work) | `case_studies/{hiv1,sma,mpro_covid,kras_g12c,bcl2}_portfolio/` |
| Derivative case-study artefacts | [`case_studies/landscape/`](case_studies/landscape/) · [`case_studies/drug_redesign_sandbox/`](case_studies/drug_redesign_sandbox/) |
| Deferred-items index | [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md) · [`USER_ACTION_REQUIRED.md`](USER_ACTION_REQUIRED.md) |
| Governance | [`AGENTS.tape`](AGENTS.tape) + [`AGENTS.md`](AGENTS.md) (COEXIST per `h1`) |

---

*Addendum end. The version remains `v1.0.0`; the expansion layer is
metadata about post-release work, not a new release. No wet-lab,
clinical, therapeutic, regulatory, immunogenic, or efficacy claim is
made by this section (`g8` / `f2`). Source of truth for any specific
scope is the §F cross-link table above.*
