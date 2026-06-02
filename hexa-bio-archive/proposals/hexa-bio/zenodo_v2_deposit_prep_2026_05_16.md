<!--
@canonical-origin: proposals/hexa-bio/zenodo_v2_deposit_prep_2026_05_16.md
predecessor:      proposals/hexa-weave/hexa_weave_zenodo_deposit_prep_2026_04_28.md (v1)
session:          2026-05-16 expansion-layer + cross + case-studies + infrastructure
scope:            DRAFT prep only — no deposit performed, no network call, no DOI minted
governance:       AGENTS.tape g3 / g8 / g9 / g10 (external-contact deferral; in-silico-only)
-->

# hexa-bio Zenodo v2 Deposit-Prep Manifest (2026-05-16)

## §0 STATUS

> **STATUS: DRAFTED — READY FOR USER REVIEW — DEPOSIT NOT EXECUTED. User owns the SEND step (g9 external-contact-defer).**
>
> No network calls have been made. No Zenodo API token has been read. No
> DOI has been requested, allocated, or minted. ORCID iDs, author byline
> emails, license selection, and the actual upload remain user decisions —
> see `USER_INPUT_CHECKLIST.md` in this directory for the 7-item gate list.
>
> Per AGENTS.tape **g9** (external-contact-defer-to-user) the agent's
> deliverable ends at: this draft proposal + a JSON metadata draft + a
> user-input checklist. The agent will NOT propose the deposit as a "next
> step" (g10) — `USER_ACTION_REQUIRED.md` is the single canonical index
> for deferred external items.

## §1 What's NEW since the v1 prep (2026-04-28)

The v1 deposit prep
([`../hexa-weave/hexa_weave_zenodo_deposit_prep_2026_04_28.md`](../hexa-weave/hexa_weave_zenodo_deposit_prep_2026_04_28.md))
targeted Option-A (Zenodo DOI) for the HEXA-WEAVE formal-mechanical W2/W3/W5
paper at the cycle-7 sorry-free milestone (7 named axioms). v2 (this
prep) would cover the **repo-scale state** that has accumulated since,
specifically the 2026-05-16 session.

The deltas below are surfaced from disk truth (`AXIS/HIERARCHY.tape`,
`AXIS/STATUS.md`, `_python_bridge/module/`, `case_studies/`,
`selftest/`, `RELEASE_NOTES_v1.1.0.md`). Each line traces to a file in the
repo at the time of drafting.

### §1.1 Expansion-layer governance record (4 expansion-main axes)

Source-of-truth: `AXIS/HIERARCHY.tape` `@D axis_covalent` /
`axis_bifunctional` / `axis_metallodrug` / `axis_oligonucleotide`.

- **COVALENT** — expansion-main · own precedent: ibrutinib (FDA 2013) ·
  sotorasib (2021) · adagrasib (2022). Verify anchor: Strelow 2017
  k_inact/K_i + Eyring 1935 TST.
- **BIFUNCTIONAL** — expansion-main · own precedent: PROTAC ARV-471 /
  ARV-110 (clinical) · lenalidomide / thalidomide (CRBN). Verify anchor:
  Douglass 2013 / Han 2020 ternary-complex cooperativity + Gadd 2017 α.
- **METALLODRUG** — expansion-main · own precedent: cisplatin (1978) ·
  carboplatin · oxaliplatin · auranofin · arsenic trioxide. Verify
  anchor: Griffith-Orgel CFSE closed form + Takahara 1995 Pt–N7(guanine)
  ~2.0 Å.
- **OLIGONUCLEOTIDE** — expansion-main · own precedent: nusinersen (ASO,
  2016) · patisiran (siRNA, 2018) · inclisiran (2021). Verify anchor:
  SantaLucia 1998 NN + van 't Hoff Tm + Dickerson-dodecamer recompute.

**Governance honesty**: per `HIERARCHY.tape @N rigorous_dissent` the
rigorous axis-expansion analysis recommended KEEP 5 axes; the 4
expansion-main entries exist by USER DIRECTION 2026-05-16, and the §4
"keep-5" dissent is preserved verbatim — NOT erased — in
`AXIS/README.md` §4. Both stand on record.

### §1.2 15 sub-axes (specialization / borderline tree)

Source: `AXIS/HIERARCHY.tape` `@D sub_under_*`. Counts per parent:

| Parent axis        | Sub-axes (count) | Members                                                                                  |
|--------------------|------------------|------------------------------------------------------------------------------------------|
| BIFUNCTIONAL (exp) | 6                | PROTAC · LYTAC · AUTAC · RIBOTAC · COVALENT-DEGRADER · MOLECULAR-GLUE                    |
| QUANTUM (core)     | 3                | ALLOSTERIC · CRYPTIC-POCKET · PPI                                                        |
| WEAVE (core)       | 2                | PEPTIDE · MACROCYCLE                                                                     |
| COVALENT (exp)     | 1                | REVERSIBLE-COVALENT                                                                      |
| RIBOZYME (core)    | 2                | APTAMER · RNA-TARGETING-SMALL-MOLECULE                                                   |
| VIROCAPSID (core)  | 1                | CAPSID-ASSEMBLY-MODULATOR                                                                |
| **TOTAL**          | **15**           | each backed by `<sub>/module/<sub>.hexa` + draft-07 spec + bridge sim                    |

### §1.3 Cross-axis bridges

`_python_bridge/module/*_cross.py` file count at draft time: **23** bridges
(disk-verified). Examples include `metallodrug_quantum_vqe_cross.py`,
`protac_ppi_cross.py`, `rna_modality_comparison_smn2_cross.py`,
`oligonucleotide_offtarget_gencode_cross.py`. Per `g6` cross sims are
NOT new axes — they import both sides' sims unchanged (`f3`
no-shadow-implementation) and emit fenced witness rows.

> **Note on count**: the brief mentions "17 cross"; on-disk count is 23
> at draft time. Final manifest should use the disk-verified count at the
> moment of deposit. Honest discrepancies surface here, not get hidden.

### §1.4 Case studies (disease portfolios)

`case_studies/` directories on disk: **10** —
`alzheimer_portfolio · bcl2_portfolio · drug_redesign_sandbox ·
hiv1_portfolio · kras_g12c_portfolio · landscape · migraine_portfolio ·
mpro_covid_portfolio · sma_portfolio · type2_diabetes_portfolio`.
`AXIS/STATUS.md` §6 names **5** as "disease portfolios"
(bcl2 · hiv1 · kras_g12c · mpro_covid · sma); the other 5 are
sandbox / scoping artefacts. The brief's "5 case studies" matches the
STATUS.md narrow count. Per `g8`/`f2`: each portfolio composes existing
sims for FDA-approved drugs against one disease at **IN-SILICO grade only**
— NOT a clinical, efficacy, or portfolio-recommendation claim.

### §1.5 Infrastructure gates (selftest layer)

Gate scripts on disk in `selftest/` matching `*_gate.{py,sh}` at draft
time: **6** (e.g. `falsifier_execution_gate.py`,
`determinism_regression_gate.py`, `deferred_items_tracking_gate.py`,
`atlas_atom_tier_upgrade_gate.py`, `qmirror_chemistry_vqe_gate.sh`,
`xeno_substrate_gate.sh`). The brief's "7 infrastructure gates" likely
includes one further gate-equivalent in `run_all.sh` or a planned
addition; final manifest should reconcile to disk truth at deposit.
**Honest count discrepancies are noted, not hidden.**

### §1.6 Tier and falsifier status (AXIS/STATUS.md)

- Tier distribution: SUPPORTED-NUMERICAL 42 · SUPPORTED-FORMAL 1 ·
  DEFERRED 1 · FALSIFIED 0 (of 44 sims).
- Falsifier execution gate: HOLD 12 · FALSIFIED 0 · SKIP 0.
- Determinism gate: DETERMINISTIC 32 · NON_DETERMINISTIC 0 · SKIP 0.

All numbers are simulator-consistency only (g8). No therapeutic claim.

## §2 v2 Zenodo metadata proposal

The fields below are **draft proposals** — the user must finalise each
before any deposit. JSON form is in
[`zenodo_v2_metadata_draft.json`](zenodo_v2_metadata_draft.json).

- **Title (proposed)**: `hexa-bio v2 — 5-axis core + 4-axis expansion-layer record + 15 sub-axes + cross-axis bridges + disease-portfolio case studies (in-silico simulator-consistency)`.
  Alternative (shorter): `hexa-bio: HEXA-Bio Molecular Toolkit — expansion-layer snapshot, 2026-05-16`.
  **User to choose**; the working draft uses the longer form for searchability.

- **Description (abstract — DRAFT)**: a stand-alone repository snapshot
  of the 5-axis hexa-bio Molecular Toolkit (QUANTUM · WEAVE · NANOBOT ·
  RIBOZYME · VIROCAPSID) at session 2026-05-16. The deposit captures the
  core-5 SSOT **unchanged** since v1 plus a USER-DIRECTED expansion-layer
  record (`AXIS/HIERARCHY.tape`) registering 4 expansion-main axes
  (COVALENT · BIFUNCTIONAL · METALLODRUG · OLIGONUCLEOTIDE) and 15
  sub-axes, with the rigorous "keep-5" dissent preserved verbatim. All
  C2/C3 PASS verdicts verify **in-silico simulator + metadata internal
  consistency only**; NO therapeutic, clinical, regulatory, immunogenic,
  efficacy, potency, selectivity, or wet-lab claim is made or implied
  (per AGENTS.tape g8 / f2). External-modality entries are described by
  their **own** published drug precedents (Strelow 2017 / Douglass 2013 /
  Griffith-Orgel / SantaLucia 1998), never lattice-fit (g3 / f1).

- **Keywords (proposed)**: `hexa-bio`, `in-silico-molecular-toolkit`,
  `5-axis`, `quantum-vqe`, `weave-composition`, `nanobot-actuation`,
  `ribozyme-kinetics`, `virocapsid-assembly`, `expansion-layer`,
  `covalent-inhibitor`, `bifunctional-degrader`, `metallodrug`,
  `oligonucleotide`, `cross-axis-bridge`, `falsifier-gate`,
  `simulator-consistency`. User to trim to ~10 per Zenodo recommendation.

- **Authors / Creators (placeholder — USER MUST FILL)**: see
  `USER_INPUT_CHECKLIST.md` items 1–2. ORCID iD and byline email are
  user-owned external surfaces; agent does NOT pre-fill them.

- **License (proposed)**: Apache-2.0 (matches existing repo `LICENSE` and
  v1.1.0 release notes); alternative CC-BY-4.0 for the paper-text-only
  case. User to choose.

- **Upload type**: `software` (per Zenodo schema; the deposit is a code
  + spec snapshot, not a paper PDF).

- **Related identifiers**: cross-link to the v1 deposit DOI **iff** the
  user actually deposited v1 (the v1 prep document states deposit was
  gated on user approval; agent has no evidence v1 was deposited — leave
  blank until user confirms in checklist item 6).

- **Communities**: none (user-controlled curation).

- **Grants**: none (no funding identifier on file).

## §3 Supplementary materials list (DRAFT)

Suggested tarball contents for `hexa-bio-v2-snapshot-2026-05-16.tar.gz`
(user can prune):

1. `AGENTS.tape`, `AGENTS.md`, `CLAUDE.md` — governance + identity SSOT.
2. `LATTICE_POLICY.md`, `LIMIT_BREAKTHROUGH.md`, `COMPUTE_PORTFOLIO.md` —
   real-limits + breakthrough audit + compute substrate.
3. `AXIS/` directory (`AXIS.tape` core-5 SSOT · `HIERARCHY.tape`
   expansion-layer · `STATUS.md` auto-generated dashboard · `INDEX.md`
   hypothesis enumeration with fence · `README.md` rigorous dissent ·
   `THERANOSTIC_SCOPE.md`).
4. `RELEASE_NOTES_v1.0.0.md`, `RELEASE_NOTES_v1.1.0.md`,
   `V1_1_0_HANDOFF.md` — release context.
5. `CHANGELOG.md`, `AXIS_CLOSURE_PLAN.md`,
   `CLOSURE_RESIDUAL_BACKLOG.md`, `USER_ACTION_REQUIRED.md` — closure
   + deferred-item indices.
6. `selftest/` directory (gate scripts; 6+ `*_gate.{py,sh}` + `run_all.sh`).
7. `_python_bridge/module/` — 54 bridge modules (incl. 23 cross sims).
8. Per-axis directories: `quantum/`, `weave/`, `nanobot/`, `ribozyme/`,
   `virocapsid/`, plus expansion-main `covalent/`, `bifunctional/`,
   `metallodrug/`, `oligonucleotide/` and 15 sub-axis directories.
9. `case_studies/` — 10 directories (5 disease portfolios + 5
   sandbox/scoping artefacts).
10. `CITATION.cff` — pre-existing citation file (Apache-2.0).

Out-of-scope for the deposit (per g8):
- `wetlab/` templates with USER_ACTION_REQUIRED markers (still deferred).
- `_absorption_bridge/` adapters with NON-COMMERCIAL RESEARCH ONLY
  licence flags (e.g. AlphaFold-3) — must be re-reviewed before
  including in any redistribution.

## §4 Honesty disclosures (must appear verbatim in the deposit description)

These are **mandatory** in any deposit description per AGENTS.tape g8 /
f2 / g3 / f1:

1. **In-silico-only (g8)**: every PASS / HOLD / DETERMINISTIC verdict in
   the deposited snapshot verifies simulator + metadata internal
   consistency ONLY. No therapeutic, clinical, regulatory, immunogenic,
   efficacy, potency, selectivity, DC50, Dmax, or wet-lab claim is made
   or implied.
2. **Core-5 unchanged (architectural)**: the committed 5-axis core
   (`AXIS.tape`: QUANTUM · WEAVE · NANOBOT · RIBOZYME · VIROCAPSID) has
   NOT been mutated by the expansion-layer record. `AXIS/HIERARCHY.tape`
   is a SEPARATE user-directed expansion layer.
3. **Expansion-layer governance-separate**: the 4 expansion-main + 15
   sub-axes exist by explicit USER DIRECTION 2026-05-16; the rigorous
   axis-expansion analysis (`AXIS/README.md` §4) recommended KEEP 5
   axes, and that dissent is preserved verbatim — NOT erased.
4. **No lattice-fit on external entities (g3 / f1)**: drug-modality axes
   are described by their OWN published precedents (FDA-approved drugs;
   peer-reviewed mechanism papers). No external entity (CRO · regulator
   · vendor · pharma · academic lab) is fit to the n=6 lattice.
5. **All DEFERRED items still deferred (g9 / g10)**: wet-lab outreach,
   IP counsel, FDA pre-IND, ORCID linkage, the actual Zenodo SEND step,
   and every item enumerated in `USER_ACTION_REQUIRED.md` remain user
   decisions. This deposit prep does NOT advance any of them.
6. **Honest count discrepancies surfaced (§1)**: the brief's "17 cross"
   vs disk's 23 cross sims, and "7 infrastructure gates" vs disk's 6
   `*_gate.*` files, are recorded in §1.3 / §1.5 rather than silently
   reconciled to the brief.

## §5 Cross-link to v1 prep + user-input items

- v1 prep: [`../hexa-weave/hexa_weave_zenodo_deposit_prep_2026_04_28.md`](../hexa-weave/hexa_weave_zenodo_deposit_prep_2026_04_28.md)
  — 8-item checklist for the W2 paper Option-A Zenodo deposit at cycle-7
  sorry-free milestone. Per its §1 footer "no deposit performed this
  cycle. Deposit gated on explicit user approval." — agent has no
  evidence the v1 deposit was subsequently executed; checklist item 6
  asks the user to confirm.
- v1 auto-prep (cycle-13 artifact catalogue):
  [`../hexa-weave/hexa_weave_zenodo_auto_prep_2026_04_28.md`](../hexa-weave/hexa_weave_zenodo_auto_prep_2026_04_28.md)
  — referenced a `tool/zenodo/` 10-file 1-click bundle for the W2 paper.
  v2 prep here is a separate scope (repo snapshot, not paper deposit).
- The 7 user-input items for v2 are enumerated in
  [`USER_INPUT_CHECKLIST.md`](USER_INPUT_CHECKLIST.md) (this directory)
  with a single user-consent checkbox at the bottom.

## §6 mk-history

- 2026-05-16 — initial v2 prep draft for the post-session repo snapshot.
  3 files created in `proposals/hexa-bio/`:
  - this proposal,
  - `zenodo_v2_metadata_draft.json` (never submitted),
  - `USER_INPUT_CHECKLIST.md` (7 unchecked items + one consent
    checkbox).
  **No deposit performed. No Zenodo API call executed. No DOI minted.**
  Agent deliverable ENDS HERE; user owns the SEND step per g9.
