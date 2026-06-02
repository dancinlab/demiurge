# Release Notes — hexa-matter v1.3.0

**Release date**: 2026-05-13
**Range covered**: 2026-05-13 (v1.2.0 close) → 2026-05-13 (v1.3.0 close, same day)
**Status**: SPEC_FIRST · **36 verbs** · 4/4 verify PASS · **36+ selftest gates** · **16 absorption adapters** · ✅ **Category (a)+(b) closure = 100%** (unchanged from v1.2.0; v1.3.0 is a **deepening release**)
**Author**: 박민우 <nerve011235@gmail.com>
**Tag**: `v1.3.0` (Phase J closure deepening + NOVEL Round 3)
**Companion artifacts**: [`CLOSURE_STATUS.md §10`](CLOSURE_STATUS.md) · [`PHASE_J_PLAN.md`](PHASE_J_PLAN.md)

---

## Headline

**Phase J closure deepening + NOVEL Round 3 — 181 candidates · 36+
selftest gates · 16 absorption adapters · 7 Tier-1 SIM-NNP-PROXY
promotion.**

v1.3.0 is a **deepening release**, not a redefinition. The Category
(a)+(b) = 100% verdict from v1.2.0 remains intact, the 36 verb count
remains intact, the 29 parity gates remain 29/29 ✅ CLOSED. v1.3.0
adds three new audit gates (falsifier well-formedness + HARD_WALL
provenance + vendor citation completeness), one NNP-proxy discipline
gate, two new absorption adapters (NIMS-Mats + Catalysis-Hub), and
seven Tier-1 NOVEL.md candidates promoted `DESIGN → SIM-NNP-PROXY`
with peer-reviewed proxy predictions vendored under
`_absorption_bridge/universal_ff/predictions/*.json`. NOVEL Round 3
(separately, parallel to Phase J) expanded the candidate ledger from
37 to **181** across §4.A–§4.F.

---

## Summary

| Surface                       | v1.2.0          | v1.3.0           | Delta                                   |
|-------------------------------|-----------------|------------------|-----------------------------------------|
| Verb specs                    | 36              | **36**           | 0 (breadth axis stable since Phase D'') |
| Verify scripts                | 4/4 PASS        | **4/4 PASS**     | 0 (structural closure unchanged)        |
| Selftest gates                | 28/28 PASS      | **36/36 PASS**   | +8 (J.1 +3 audit · J.2 +1 NNP · J.3 +2 adapter · Round 3 absorbed via existing gates) |
| Python-bridge modules         | 12              | 12               | 0                                       |
| Research-bridge modules       | 8               | 8                | 0                                       |
| Absorption-bridge adapters    | 14              | **16**           | +2 (NIMS-Mats + Catalysis-Hub)          |
| Category (b) parity gates     | 29 / 29 ✅      | 29 / 29 ✅       | 0 (Phase J adds discipline gates, not parity gates) |
| NOVEL.md candidates           | 37              | **181**          | +144 (Round 3 §4.A–§4.F)                |
| NOVEL.md `SIM-NNP-PROXY` rows | 0               | **7 Tier-1**     | +7 (J.2 promotion)                      |
| Closure verdict               | (a)+(b)=100%    | **(a)+(b)=100%** | unchanged — deepening, not redefinition |

This release ships under the dancinlab-wide `LATTICE_POLICY` (Wave K) +
`LIMIT_BREAKTHROUGH` (Wave M) discipline; every new artifact respects
preserves UNPROVEN/UNVERIFIED markers verbatim.

---

## Phase-by-phase rollup

Phase J is the post-(a)+(b)=100% **deepening** round. Five sub-phases:

### Phase J.1 — 3 new audit gates (`cea815a`)

Three stdlib-only selftest gates, each ≤ 100 LOC, that audit the
discipline holding Category (a)+(b) closure together:

- **`selftest/falsifier_wellformed_audit.py`** (gate #31) — every
  `F-<class>-NN:` row in `NOVEL.md` carries quantitative threshold +
  measurement attribution + FAIL-condition wording.
- **`selftest/hard_wall_provenance_audit.py`** (gate #32) — every
  HARD_WALL row in `LIMIT_BREAKTHROUGH.md` cites a named source
  (Hales / Gibbs / NIST / CRC / Frenkel / Bekenstein / Stefan-Boltzmann
  / …).
- **`selftest/vendor_citation_completeness_audit.py`** (gate #33) —
  every vendor SKU mentioned in a verb spec (DuPont Kevlar 49 / DSM
  Dyneema SK99 / CATL Blade / Wolfspeed / etc.) has a SOURCES.md or
  in-spec citation row.

Selftest 30/30 → 33/33.

### Phase J.2 — Tier-1 NOVEL DESIGN → SIM-NNP-PROXY (`a01b6dc`)

7 Tier-1 candidates from `NOVEL_ROADMAP.md §5` advance from `DESIGN` to
`SIM-NNP-PROXY` status with peer-reviewed proxy predictions vendored as
`_absorption_bridge/universal_ff/predictions/<candidate-id>.json`.
Proxy sources: **M3GNet v2024-04 · CHGNet v0.3 · ALIGNN-FF · MACE-MP-0**
(citing Chen 2022 · Deng 2023 · Choudhary 2021 · Batatia 2022).

New gate `selftest/uff_predictions_smoke.sh` (gate #34) asserts every
prediction JSON carries the four discipline flags
(`is_measurement: false` / `is_external_verification: false` /
`n6_lattice_fit_applied: false` / `__fixture_tag__: SIM-NNP-PROXY …`).

a SIM tag, **NOT** `EXTERNAL-VERIFIED`. The promotion advances the
DESIGN → SIM stage only; external verification still requires an
attributed external lab citation per `NOVEL.md §7` step 6.

Selftest 33/33 → 34/34.

### Phase J.3 — 2 new absorption adapters (`0b54537`)

Two new `_absorption_bridge/` adapters following the Phase G+1 / G+2
shape exactly:

| # | Adapter         | Anchor                                                | License    | Cost |
|---|-----------------|-------------------------------------------------------|------------|------|
| 15 | `nims_mats`    | NIMS Materials Database (MITS), Tokyo / Tsukuba       | CC-BY 4.0  | $0   |
| 16 | `catalysis_hub` | Mamun 2019 / Catalysis-Hub.org, SUNCAT / DTU + SLAC   | CC-BY 4.0  | $0   |

Bridge total 14 → 16. Each adapter ships with
`<name>_search_smoke.py` + `SOURCES.md` + sample fixture under
`cache/sample_record.json` + `<name>_adapter.md` + selftest wrapper.

New gates: **`nims_mats_adapter_smoke`** (#35) +
**`catalysis_hub_adapter_smoke`** (#36).

License-honesty matrix in `_absorption_bridge/README.md` extended to
16 rows. Selftest 34/34 → 36/36.

### Phase J.4 — Planning + closure docs v2 (_this release_)

Three docs:

1. **`PHASE_J_PLAN.md`** — mirrors `PHASE_H_PLAN.md` structure; documents
   the Phase J deepening axis (J.1 / J.2 / J.3 / J.4 / J.5).
2. **`CLOSURE_STATUS.md §10`** — appends a Post-100% deepening section.
   The §1 verdict still holds; §10 inventories the deltas without
   redefining the verdict.
3. **`RELEASE_NOTES_v1.3.0.md`** (this file) — full v1.2.0 → v1.3.0
   release notes covering Phase J.1–J.5 + NOVEL Round 3.

### Phase J.5 — NOVEL ↔ verb spec cross-links (🚧 in flight)

Bidirectional NOVEL ↔ verb spec navigability for the 7 Tier-1
candidates promoted in J.2. For each Tier-1 candidate, the
corresponding `<verb>/<verb>.md` (or sister chapter, e.g. `MOF.md`,
`PEROVSKITE.md`) gains a "See also `NOVEL.md` row `hxm-...`" inline
cross-reference. The `selftest/cross_link_integrity_audit.py`
(gate #29) extends to verify the bidirectional invariant.

Status: **🚧 WIP** in a parallel agent; integration commit (task #34
local) lands the merge.

---

## NOVEL Round 3 expansion (parallel to Phase J)

`NOVEL.md` candidate ledger expanded from **37 → 181** across six
sub-sections, all `DESIGN` status, all carrying quantitative falsifiers
per `NOVEL.md §7` step 2:

| Round 3 section | Theme                                              | Candidates | Commit                  |
|-----------------|----------------------------------------------------|------------|-------------------------|
| §4.A            | Energy storage (bat / se / pv / fc / flow / cap)   | 19         | `07f79aa`               |
| §4.B            | Catalysis + thermal                                | 16         | `fce6216` → `f6947bf`   |
| §4.C            | Quantum + optics                                   | 21         | `4db2a99` → `f6947bf`   |
| §4.D            | Structural + polymers                              | 26         | `6ce83af` → `f6947bf`   |
| §4.E            | Biomaterials + manufacturing + electronics         | 19         | `d809807` → `f6947bf`   |
| §4.F            | Environmental + special + acoustic + cryo + frontier | 40       | `107a666` → `f6947bf`   |

Per `NOVEL.md §2`, no entry has `EXTERNAL-VERIFIED` status. Per
`LATTICE_POLICY.md §1.2`, the n=6 lattice is NOT evidence for property
claims here — it is an organizing tool only.

---

## New audit gates (selftest 30 → 33 → 34 → 36)

The selftest scoreboard progression in v1.3.0:

```
v1.2.0 close:               28/28 PASS  (Phase A-I + closure-meta)
  + Round 3 absorbed:        30/30 PASS  (no new gates; gate #29 NOVEL audit
                                          and gate #30 §C audit picked up the
                                          181-row candidate ledger automatically)
  + Phase J.1 (gates 31-33): 33/33 PASS  (falsifier wellformed + HARD_WALL
                                          provenance + vendor citation
                                          completeness)
  + Phase J.2 (gate #34):    34/34 PASS  (uff_predictions_smoke)
  + Phase J.3 (gates 35-36): 36/36 PASS  (nims_mats + catalysis_hub adapters)
```

Each gate is stdlib-only, ≤ 100 LOC, deterministic, OFFLINE (no live
API calls in selftest), and runnable as
`python3 selftest/<gate>.py --selftest` or `bash
selftest/<gate>_smoke.sh`.

---

## New adapters (`_absorption_bridge/` 14 → 16)

The 16-adapter license-honesty matrix (extension of
`_absorption_bridge/README.md`):

| System            | License                | Cost | Class                                       |
|-------------------|------------------------|------|---------------------------------------------|
| Materials Project | CC-BY 4.0              | $0   | DFT computed (Persson 2013)                 |
| GNoME             | CC-BY 4.0              | $0   | DFT predicted, **NOT SYNTHESIZED**          |
| Matlantis         | Commercial             | $$$  | NNP, **COMMERCIAL UNVERIFIED** at scale     |
| OMat24            | CC-BY 4.0              | $0   | DFT computed (Meta AI, MACE-OMat)           |
| COD               | CC0                    | $0   | **EXPERIMENTAL XRD** measurements           |
| OQMD              | CC-BY 4.0              | $0   | DFT-PBE predictions (~1M entries)           |
| AFLOW             | CC-BY 4.0              | $0   | DFT predictions (3M+ compounds)             |
| NOMAD             | CC-BY 4.0              | $0   | multi-code DFT (19M+ FAIR entries)          |
| SchNet / MACE / ALIGNN | MIT               | $0   | universal NNP                               |
| CHGNet / M3GNet   | BSD-3-Clause           | $0   | universal NNP                               |
| **NIMS-Mats** ✨   | CC-BY 4.0              | $0   | NIMS Materials Database (MITS)              |
| **Catalysis-Hub** ✨ | CC-BY 4.0            | $0   | Mamun 2019 catalysis surfaces (SUNCAT/DTU)  |

---

## 7 Tier-1 SIM-NNP-PROXY promotions

The 7 Tier-1 candidates per `NOVEL_ROADMAP.md §5` advance from `DESIGN`
to `SIM-NNP-PROXY` with vendored proxy-prediction JSONs. Each carries a
peer-reviewed proxy citation (one of M3GNet · CHGNet · ALIGNN-FF ·
MACE-MP-0) and the four discipline flags
(`is_measurement: false` / `is_external_verification: false` /
`n6_lattice_fit_applied: false` / `__fixture_tag__: SIM-NNP-PROXY …`).

stage only. `EXTERNAL-VERIFIED` still requires an external lab citation
with sample-ID and measurement protocol — that bar is unchanged.

---

## Honesty inventory — UNPROVEN / UNVERIFIED markers preserved verbatim

Every honesty stamp from v1.0.0 / v1.1.0 / v1.2.0 is preserved verbatim
in v1.3.0. No Phase J artifact retires or weakens any of these:

- **LK-99 room-T SC** — NOT REPRODUCED; HARD_WALL until peer-reviewed
  reproduction. Per `perovskite/perovskite.md` + `LIMIT_BREAKTHROUGH.md`
  + `PEROVSKITE.md` anti-claim row.
- **Metallic hydrogen at ambient** — UNPROVEN. Per
  `verify/real_limits_anchor.hexa` caveat list.
- **Magic-MOF DAC $100/t** — UNPROVEN; Climeworks amine baseline
  $600–1000/t named verbatim. Per `mof/mof.md` +
  `selftest/mof_dac_economics_honesty_audit.py`.
- **CNT yarn 80 GPa lab-mm** — UNPROVEN at commodity scale; commercial
  1–3 GPa preserved. Per `carbon/carbon.md` +
  `selftest/carbon_cnt_strength_honesty_audit.py` +
  `tests/pol_b6_cnt_yarn_parity.py` (gate verifies lab-mm parity only,
  NOT km-scale reproducibility).
- **Re-free 4th-gen single-crystal superalloy** — UNVERIFIED at parity
  to Re-bearing CMSX. Per `superalloy/superalloy.md`.
- **Marine-biodegradable PHA (generic)** — UNVERIFIED; only specific
  PHA D7081-certified grades. Per
  `biodegradable-plastics/biodegradable-plastics.md`.
- **L5 autonomy** — UNVERIFIED; NOT a hexa-matter claim. Cross-substrate
  caveat preserved in `CROSS_LINK.md §3.7` (hexa-mobility boundary).
- **GNoME 2.2M predicted stable crystals** — `is_synthesized: false` +
  `synthesis_status: UNPROVEN — DFT prediction only`. Per
  `_absorption_bridge/gnome/SOURCES.md` + `gnome_dataset_smoke.py`.
- **Matlantis commercial** — UNVERIFIED at hexa-matter scale economics;
  Preferred Networks proprietary SDK. Per
  `_absorption_bridge/matlantis/SOURCES.md`.
- **Y-TZP LTD (low-temp degradation)** — HARD_WALL; tetragonal-to-
  monoclinic at body temperature is real. Per
  `ceramics/ceramics.md`.
- **Phosphorene ambient stability** — HARD_WALL; oxidative degradation
  in minutes under ambient air. Per `2d-materials/2d-materials.md`.
- **GST phase-change drift** — HARD_WALL; multi-level cell drift is real.
  Per `MATERIAL-SYNTHESIS.md` + `_absorption_bridge/`.
- **Ir scarcity** — HARD_WALL; ~7 t/yr global Ir supply hard-walls
  IrO₂-OER commodity scale. Per `electrode-material/electrode-material.md`.
- **Cd regulatory** — RoHS-restricted; CdTe / CdSe applications regulator-
  bounded. Per `compound-semi/compound-semi.md` + `perovskite/perovskite.md`.
- **²⁸Si enrichment cost** — UNVERIFIED at commodity; centrifuge cascade
  capital cost is real. Per `silicon/silicon.md` Si-L8.
- **Skyrmion size** — UNVERIFIED at room-T stability for sub-10-nm
  skyrmions. Per `magnetic-materials/magnetic-materials.md`.
- **Pb halide migration** — UNVERIFIED for 25-yr lifetime perovskite-PV.
  Per `perovskite/perovskite.md`.
- **Basalt grain-size kinetics** — UNVERIFIED at production scale for
  CO₂-mineralization. Per `concrete/concrete.md` + `MATERIAL-SYNTHESIS.md`.
- **Trivial time-crystal vs MBL** — CONTESTED; many "time-crystal"
  claims are MBL-stabilized prethermal phases. Per
  `NOVEL.md §4.C / §4.F` quantum rows.
- **Majorana fermion identification** — CONTESTED; 2018 Nature retraction
  preserved verbatim. Per `magnetic-materials` + `2d-materials` cross-rows.
- **Hydrogen embrittlement** — HARD_WALL on high-strength steels at
  H concentration > ~1 wppm. Per `METALLURGY-DEEP.md` +
  `superalloy/superalloy.md`.
- **RCF (refractory ceramic fiber) Group 2B IARC** — real classification
  preserved. Per `refractory/refractory.md`.
- **EUV resist photon-shot-noise vs LER** — NOT FULLY RESOLVED
  (IRDS 2023). Per `photoresist/photoresist.md`.
- **CATL Blade 12,000-cycle LFP multi-vendor reproduction** — OPEN.
  Per `electrode-material/electrode-material.md`.

---

## Verdict (v1.3.0)

```toml
[closure]
verbs_total = 36
groups_total = 7
verbs_wired = 0
verbs_spec = 36
verdict = "SPEC_FIRST"
verify_pass = "4/4"
selftest_pass = "36/36"              # ← 28 → 30 → 33 → 34 → 36 in v1.3.0
python_bridge_modules = 12
research_bridge_modules = 8
absorption_bridge_modules = 16       # ← 14 → 16 (NIMS-Mats + Catalysis-Hub)
parity_gates_total = 29
novel_candidates_total = 181         # ← 37 → 181 (NOVEL Round 3)
novel_sim_nnp_proxy_rows = 7         # ← 0 → 7 (Tier-1 promotion)
category_ab_closure = "100%"         # ← unchanged from v1.2.0 (deepening release)
category_c_status   = "OUT_OF_REPO_BY_DESIGN"

[verify]
scripts_total = 4
scripts_passed = 4
verdict = "CLOSED"
```

---

## What's next

**TBD per maintainer direction.** This release does NOT promise any
specific Phase K or v1.4 scope. The Phase J deepening axis is itself
optional in the sense that the v1.2.0 (a)+(b)=100% verdict was already
stable; v1.3.0 adds rigor + breadth around that envelope.

Phase K-shaped candidate axes that are conceivable but not committed:

- additional NOVEL DESIGN → SIM-NNP-PROXY promotions beyond the 7 Tier-1
  (requires `_absorption_bridge/universal_ff/` runs with vendored proxy
  JSON per candidate, following the J.2 pattern)
- additional absorption adapters (e.g. Atomly, AtomWork, ICSD)
- promotion of select `SIM-NNP-PROXY` rows to `SYNTH-ROUTE` (requires
  literature precedent or de-novo retrosynthesis written out)
- live-mode (non-selftest) tests of Phase F arxiv + web + patent endpoints
- per-verb falsifier deadlines (DESIGN → SIM transition for specific
  candidates beyond the Tier-1 set)
- additional discipline gates (e.g. cross-substrate boundary audit for
  hexa-energy / hexa-chip / hexa-rtsc / hexa-mobility)

None of the above is committed as of v1.3.0. The (a)+(b) closure verdict
is stable; (c) is OUT-OF-REPO BY DESIGN; this release is internally
consistent at the values declared in `CLOSURE_STATUS.md §1` (baseline)
+ `CLOSURE_STATUS.md §10` (deepening deltas).

---

## Acknowledgments

- canon authors at `canon@47c70cbf` for the 16-verb v1.0.0 base
- `hexa-bio` team for the AXIS / AXIS_CLOSURE_PLAN / CLOSURE_RESIDUAL_BACKLOG /
  DECOMPOSITION_PLAN / LESSONS / `_absorption_bridge/` / `NOVEL.md` patterns
- Wave K `LATTICE_POLICY` (dancinlab-wide, 2026-05-12) for the n=6-as-tool
  discipline
- Wave M `LIMIT_BREAKTHROUGH` audit for the real-limits-first anchors
- All 23+2 external scientific tools / databases / NNPs absorbed across
  Phase E + F + G + G+1 + G+2 + J.3 — their published license + citation
- M3GNet (Chen 2022) / CHGNet (Deng 2023) / ALIGNN-FF (Choudhary 2021) /
  MACE-MP-0 (Batatia 2022) / SchNet (Schütt 2017) authors for the open
  universal-FF proxy stack that enables `DESIGN → SIM-NNP-PROXY` advances
- NIMS (Tokyo / Tsukuba) for the Materials Database (MITS) — CC-BY 4.0
- Catalysis-Hub.org (Mamun 2019 / SUNCAT / DTU + SLAC) for the catalysis
  surfaces database — CC-BY 4.0

---

## Commit log (this release)

```
cea815a  feat(closure-deepen-j1): add 3 audit gates — falsifier wellformed + HARD_WALL provenance + vendor citation completeness (30→33)
a01b6dc  feat(closure-deepen-j2): promote 7 Tier-1 NOVEL candidates DESIGN → SIM-NNP-PROXY (gate #34)
0b54537  feat(closure-deepen-j3): add NIMS-Mats + Catalysis-Hub adapters (14→16, gates #35-36)
07f79aa  docs(novel-round3-A): add §4.A energy storage — 19 candidates (bat/se/pv/fc/flow/cap)
f6947bf  docs(novel-round3): integrate §4.B + §4.C + §4.D + §4.E + §4.F — 144 candidates total
_(this)_ docs(closure-deepen-j4): PHASE_J_PLAN.md + CLOSURE_STATUS §10 deepening + RELEASE_NOTES_v1.3.0
_(WIP)_  feat(closure-deepen-j5): NOVEL ↔ verb spec bidirectional cross-link consolidation (7 Tier-1)
```

The J.4 commit (this release) records v1.3.0 closure deepening but does
not, in itself, change any closure-grade percentage. The (a)+(b) = 100%
verdict is the same verdict certified by `RELEASE_NOTES_v1.2.0.md` at
the close of Phase I.2; v1.3.0 adds discipline and breadth around that
envelope.

---

*Release notes authored 2026-05-13 by 박민우 <nerve011235@gmail.com>.
Sister-of-tone: `RELEASE_NOTES_v1.2.0.md` (Phase A-I + closure-meta
rollup, same day). Top-level certification companion: `CLOSURE_STATUS.md`
(now with §10 deepening section). Scope-definition companion:
`PHASE_J_PLAN.md`.*
