# PHASE_J_PLAN — Post-100% closure deepening

> **Created**: 2026-05-13 · **Status**: 🚧 ROLLING UP (J.1 / J.2 / J.3 ✅ landed in parallel; J.4 ✅ DONE _(this commit)_; J.5 🚧 in-flight in a parallel agent)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Predecessors**: Phase H (`e12dfb9`) + Phase I.1 (`583fddb`) + Phase I.2
> (`196b03c`) — those phases drove Category (a)+(b) closure to **100%**.
> Closure-meta (`9c21948` + `674653e` + `6526de6`) certified the verdict in
> `CLOSURE_STATUS.md` + `RELEASE_NOTES_v1.2.0.md`.
> NOVEL Round 3 (`07f79aa` + `f6947bf`) expanded `NOVEL.md` to **181**
> candidates across §4.A–§4.F.
> **Source-of-scope**: `CLOSURE_STATUS.md §7` ("what 100% does NOT mean") +
> `NOVEL_ROADMAP.md §5` (Tier-1 promotion targets) +
> `_absorption_bridge/README.md` license-honesty matrix.

---

## 0. Why Phase J — "deepening", not redefinition

Phase A–I drove the (a)+(b) closure axis from `0%` (silicon stub on
2026-05-09) to **`100%`** (Phase I.2 close on 2026-05-13). That verdict
is stable — Phase J does **NOT** change it. Per `CLOSURE_STATUS.md §1`
the verdict is "audit-trail discipline within an enumerated scope", and
per `CLOSURE_STATUS.md §7` it is explicitly **NOT** a claim about real-
world material behavior. The verdict is also explicitly bounded — see
the seven invariants in `CLOSURE_STATUS.md §6`.

Phase J is the **deepening** round around that verdict. It does four
things, each measurable, each fully respecting the hard constraints:

1. **More audit gates around the falsifier discipline.** §B parity gates
   measure spec ↔ source agreement; Phase J adds three gates that
   measure whether the falsifier well-formedness, HARD_WALL provenance,
   and vendor citation completeness disciplines that hold the verdict
   together are themselves machine-checked.
2. **Promotion infrastructure for NOVEL.** §3 of `NOVEL.md` defines a
   `DESIGN → SIM → SYNTH-ROUTE → EXTERNAL-VERIFIED` flow. Phase J lands
   the **DESIGN → SIM-NNP-PROXY** transition for 7 Tier-1 candidates
   using already-vendored universal-FF proxies (SchNet / MACE / ALIGNN /
   CHGNet / M3GNet from Phase G). This is **NOT** a promotion to
   tags, with `is_measurement: false` and `is_external_verification:
   false` baked into the prediction JSON.
3. **Broader external-data absorption.** Phase G shipped 14 adapters;
   Phase J adds **NIMS-Mats** (NIMS Materials Database, MITS) and
   **Catalysis-Hub** (Mamun 2019, free CC-BY 4.0) to reach **16**.
4. **Bidirectional NOVEL ↔ verb spec navigability.** NOVEL.md cross-
   links to `<verb>/<verb>.md` already exist; Phase J.5 adds the
   reverse direction for the 7 Tier-1 candidates so spec readers see
   "see also `NOVEL.md` row `hxm-...`" inline.

What Phase J is **not**:

- ❌ Not a re-definition of "100% closure". (a)+(b) = 100% as of
  2026-05-13 remains intact. Phase J adds rigor + breadth around the
  envelope; it does not redraw it.
- ❌ Not a wet-lab claim. Category (c) remains OUT-OF-REPO BY DESIGN
  per `AXIS_CLOSURE_PLAN.md §0`. SIM-NNP-PROXY ≠ MEASURED.
- ❌ Not an UNPROVEN-flag removal. LK-99, magic-MOF DAC $100/t, CNT
  yarn 80 GPa lab-mm, Re-free SX, marine-PHA, GNoME predicted-not-
  synthesized, Matlantis commercial-unverified — all preserved verbatim.

---

## 1. Scope (5 sub-phases)

### J.1 — 3 new audit gates (selftest 30 → 33)

**Status**: ✅ IMPLEMENTED in parallel commit `cea815a`.

Three stdlib-only selftest gates, each ≤ 100 LOC, that audit the
discipline holding Category (a)+(b) closure together:

| # | Gate                                            | Audits                                                                                                                                          |
|---|-------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| 31 | `selftest/falsifier_wellformed_audit.py`       | Every `F-<class>-NN:` row in `NOVEL.md` carries quantitative threshold + measurement attribution + FAIL-condition wording. Per `NOVEL.md §1`.   |
| 32 | `selftest/hard_wall_provenance_audit.py`       | Every HARD_WALL row in `LIMIT_BREAKTHROUGH.md` cites a named source (Hales / Gibbs / NIST / CRC / Frenkel / Bekenstein / Stefan-Boltzmann / …). |
| 33 | `selftest/vendor_citation_completeness_audit.py` | Every vendor SKU mentioned in a verb spec (DuPont Kevlar 49 / DSM Dyneema SK99 / CATL Blade / etc.) has a SOURCES.md or in-spec citation row.   |

**Completion criterion (measurable)**: `bash selftest/run_all.sh` returns
`__HEXA_MATTER_SELFTEST__ PASS (33/33)`. No false negatives on any current
spec doc — these gates pass on the v1.2.0 corpus as-is.

**Discipline**: each gate carries `n6_lattice_fit_applied: false`
semantics — it audits text discipline, not numerical claims; it does
NOT promote any spec to a measurement.

### J.2 — Tier-1 NOVEL DESIGN → SIM-NNP-PROXY (selftest 33 → 34)

**Status**: ✅ IMPLEMENTED in parallel commit `a01b6dc`.

7 Tier-1 candidates from `NOVEL_ROADMAP.md §5` advance from `DESIGN` to
`SIM-NNP-PROXY` status. Each carries a vendored proxy-prediction JSON
under `_absorption_bridge/universal_ff/predictions/<candidate-id>.json`
of the shape:

```json
{
  "__fixture_tag__": "SIM-NNP-PROXY PREDICTION — NOT a measurement, NOT external verification",
  "candidate_id": "hxm-...",
  "proxy_source": "M3GNet v2024-04 / CHGNet v0.3 / ALIGNN-FF / MACE-MP-0 / etc.",
  "proxy_property": "...",
  "proxy_value": ...,
  "is_measurement": false,
  "is_external_verification": false,
  "n6_lattice_fit_applied": false,
  "raw_10_c3_note": "proxy is a NNP prediction; vendor-published error bars apply"
}
```

A new gate `selftest/uff_predictions_smoke.sh` (#34) sweeps each
prediction file and asserts the four discipline flags are present and
correctly valued (`is_measurement: false` etc.).

**Completion criterion (measurable)**:
`ls _absorption_bridge/universal_ff/predictions/*.json | wc -l ≥ 7`;
`bash selftest/run_all.sh` → 34/34 PASS; each `hxm-*` row in `NOVEL.md`
flipped from `DESIGN` to `SIM-NNP-PROXY` with proxy handle recorded.

- proxy is a NNP **prediction**, not a measurement.
- `is_measurement: false` and `is_external_verification: false` are
  hardcoded in every prediction JSON — Phase J.1 gate #31 verifies the
  falsifier well-formedness; J.2 gate #34 verifies the proxy discipline.
- No advance to `EXTERNAL-VERIFIED` — that requires an external lab
  citation per `NOVEL.md §7` step 6.

### J.3 — 2 new absorption adapters (14 → 16)

**Status**: ✅ IMPLEMENTED in parallel commit `0b54537`.

Two new `_absorption_bridge/` adapters following the Phase G+1 / G+2
shape exactly (`<name>_search_smoke.py` + `SOURCES.md` + sample fixture
+ `<name>_adapter.md` + `selftest/<name>_smoke.py` wrapper + top-level
`selftest/<name>_adapter_smoke.sh`):

| # | Adapter        | Anchor                                                       | License       | Cost |
|---|----------------|--------------------------------------------------------------|---------------|------|
| 15 | `nims_mats`    | NIMS Materials Database (MITS), Tokyo / Tsukuba              | CC-BY 4.0     | $0   |
| 16 | `catalysis_hub` | Mamun 2019 / Catalysis-Hub.org, SUNCAT / DTU + SLAC          | CC-BY 4.0     | $0   |

Selftest gates added: #35 (`nims_mats_adapter_smoke`) + #36
(`catalysis_hub_adapter_smoke`).

**Completion criterion (measurable)**:
`ls _absorption_bridge/*/cache/sample_record.json | wc -l ≥ 16`;
`bash selftest/absorption_bridge_smoke.sh` PASS;
`bash selftest/run_all.sh` → 36/36 PASS.

**Discipline**: each adapter ships its own SOURCES.md license + citation
+ status row; license-honesty matrix in `_absorption_bridge/README.md`
enforced via `lattice_fit_on_external_entities_audit.py` (existing gate
#8) automatically picking up the new subdirs.

### J.4 — Planning + closure-doc v2 (this commit)

**Status**: ✅ DONE _(this commit)_.

Three docs:

1. **`PHASE_J_PLAN.md`** (this file) — mirrors `PHASE_H_PLAN.md`
   structure; documents the Phase J deepening axis.
2. **`CLOSURE_STATUS.md` §10** — appends a "Post-100% deepening" section
   that records what Phase J adds *around* the verdict without
   redefining it. The (a)+(b) = 100% baseline from §1 still holds; §10
   inventories the deepening deltas (audit gates, SIM-NNP-PROXY, two
   new adapters, NOVEL ↔ verb bidirectional links).
3. **`RELEASE_NOTES_v1.3.0.md`** — full v1.2.x → v1.3.0 release notes
   covering Phase J.1–J.5 + NOVEL Round 3 (37 → 181 candidates) + the
   updated scoreboard (36 selftest gates · 16 adapters · 7 Tier-1
   SIM-NNP-PROXY promotions).

**Completion criterion**: this commit contains all three files; selftest
+ verify both continue to PASS at their current counts.

### J.5 — NOVEL ↔ verb spec cross-link consolidation

**Status**: 🚧 WIP (parallel agent in flight).

For each of the 7 Tier-1 candidates promoted in J.2, the corresponding
`<verb>/<verb>.md` (or sister chapter, e.g. `MOF.md`, `PEROVSKITE.md`)
gains a "See also `NOVEL.md` row `hxm-<class>-<target>-NNN`" inline
cross-reference. The reverse direction already exists per
`NOVEL.md §1` naming + §8 cross-references.

**Completion criterion (measurable)**: every Tier-1 `hxm-*` row in
`NOVEL.md` carries a back-link from its primary verb spec; the existing
`selftest/cross_link_integrity_audit.py` (gate #29) extends to verify
the bidirectional invariant.

---

## 2. Out of scope (explicit, preserves the discipline)

- ❌ **Wet-lab synthesis / vendor procurement / fab capacity.** Per
  `AXIS_CLOSURE_PLAN.md §0`, Category (c) is permanently OUT-OF-REPO. Phase
  J adds zero (c) closure. The §C ledger remains at 18 enumerated items,
  each at DEST: vendor-numbers-only / HARD_WALL / cross-domain.
  `EXTERNAL-VERIFIED` requires an external lab citation with sample-ID
  + measurement protocol. NNP-proxy predictions do **not** qualify.
- ❌ **UNPROVEN-flag removal.** Every flag preserved verbatim — LK-99
  HARD_WALL · magic-MOF DAC $100/t UNPROVEN · CNT yarn 80 GPa
  lab-mm UNPROVEN at commodity · Re-free 4th-gen SX UNVERIFIED · marine-
  PHA generic UNVERIFIED · GNoME `is_synthesized: false` · Matlantis
  COMMERCIAL UNVERIFIED · L5 autonomy UNVERIFIED (cross-substrate) ·
  Y-TZP LTD HARD_WALL · phosphorene ambient HARD_WALL · GST drift
  HARD_WALL · Ir scarcity HARD_WALL · Cd regulatory · ²⁸Si enrichment
  cost · skyrmion size · Pb halide migration · basalt grain-size
  kinetics · trivial-time-crystal vs MBL · Majorana CONTESTED ·
  H-embrittlement HARD_WALL.
- ❌ **n=6 lattice-fit on external entities.** Every Phase J artifact
  carries `n6_lattice_fit_applied: false` semantics. Vendor records,
  NIST values, ASM ranges, NNP predictions all flow through verbatim
  with provenance.
- ❌ **New verbs.** Verb count stays at 36 across Phase J. The breadth
  axis was closed in Phase D''.

---

## 3. Honesty / hard-constraint compliance

Bound by the 6 hard constraints in `INIT.md` §"Hard constraints":

1. **`LATTICE_POLICY.md §1.2 real-limits-first`** — every Phase J gate
   anchors on REAL discipline (text well-formedness, HARD_WALL named
   source, vendor SKU traceability, NNP published error bars), never
   on n=6 tautology.
2. **`LATTICE_POLICY.md §1.3 n=6 auxiliary`** — zero lattice-derived
   assertions added. Gate count is engineering-chosen.
   Hub records flow through verbatim; SchNet / MACE / ALIGNN / CHGNet /
   M3GNet proxy predictions carry their own published error bars
   (force MAE 20–60 meV/Å typical); NO n=6 lattice-fit applied.
4. **SPEC_FIRST verdict preserved** — `SIM-NNP-PROXY` is a SIM tag, NOT
   `EXTERNAL-VERIFIED`. The verb spec footers ("SPEC_FIRST, not MEASURED
   here") stay verbatim across all 36 verb specs.
5. **UNPROVEN / UNVERIFIED stamps preserved verbatim** — see §2 list.
6. **`LIMIT_BREAKTHROUGH.md` HARD_WALL classifications honored** —
   Phase J.1 gate #32 enforces a named source for every HARD_WALL row;
   it does NOT silently re-classify any wall.

Sister-domain hand-off discipline (`CROSS_LINK.md §3`) remains intact:
cell-level engineering → `hexa-energy` · device-level → `hexa-chip` ·
room-T superconductivity → `hexa-rtsc` · L5 autonomy → `hexa-mobility`
(out-of-claim). hexa-matter owns the material layer only.

---

## 4. Sequencing within Phase J

The five sub-phases are independent and were authored in parallel:

```
J.1  (gates 31-33)    cea815a    [parallel agent]
J.2  (NNP-proxy, #34) a01b6dc    [parallel agent]
J.3  (adapters 15-16) 0b54537    [parallel agent]
J.4  (these 3 docs)   _(this)_   [this commit]
J.5  (back-links)     🚧 WIP     [parallel agent]
```

Integration is a separate commit (task #34 in the local task list) that
fast-forwards or merges J.1 + J.2 + J.3 + J.5 onto the closure-deepen-j3
branch line.

Each sub-phase carries the same author-trailer convention:
`박민우 <nerve011235@gmail.com>` + `Co-Authored-By: Claude Opus 4.7`.

---

## 5. Expected post-Phase-J scoreboard

| Surface                            | Phase I.2 baseline | Phase J target (after integration) |
|------------------------------------|--------------------|-----------------------------------|
| `verify/run_all.hexa`              | 4/4 PASS           | 4/4 PASS (unchanged — Phase J is selftest + adapter + NOVEL layer) |
| `selftest/run_all.sh`              | 30/30 PASS         | **36/36 PASS**                    |
| `tests/*_parity.py`                | 29                 | 29 (unchanged — Phase J does not add §B gates) |
| `_absorption_bridge/` adapters     | 14                 | **16**                            |
| NOVEL.md candidates                | 37                 | **181** (Round 3 already integrated; not a J-axis number) |
| NOVEL.md `SIM-NNP-PROXY` rows      | 0                  | **7 Tier-1**                      |
| `CLOSURE_RESIDUAL_BACKLOG.md §B`   | 0 (all CLOSED)     | 0 (unchanged)                     |
| `(a)+(b) closure-grade`            | **100%**           | **100%** (unchanged; J is deepening, not redefinition) |
| Verb count                         | 36                 | 36 (unchanged)                    |

---

## 6. Risk register

| Risk | Mitigation |
|---|---|
| Reader interprets "deepening" as "100% was incomplete" | `CLOSURE_STATUS.md §10` opens with explicit statement that the §1 verdict still holds; this plan §0 repeats it. |
| SIM-NNP-PROXY confused with EXTERNAL-VERIFIED | Every prediction JSON carries `is_measurement: false` + `is_external_verification: false`; J.1 gate #31 + J.2 gate #34 machine-enforce. |
| NOVEL bidirectional links drift | `selftest/cross_link_integrity_audit.py` (gate #29) extension in J.5 enforces both directions. |
| Selftest scoreboard expansion breaks downstream consumers | `hexa.toml [closure].selftest_pass` updated atomically with the J commits; `cross_doc_audit.py` keeps README / AGENTS.md / INIT.md in sync. |

---

## 7. References

- [`INIT.md`](INIT.md) — Phase status table (Phase J row gets a 🚧
  ROLLING-UP entry pending integration commit task #34)
- [`CLOSURE_STATUS.md`](CLOSURE_STATUS.md) §10 — Post-100% deepening
  inventory (companion to this plan)
- [`RELEASE_NOTES_v1.3.0.md`](RELEASE_NOTES_v1.3.0.md) — full v1.3.0
  release notes (companion to this plan)
- [`PHASE_H_PLAN.md`](PHASE_H_PLAN.md) — structural template Phase J
  mirrors
- [`NOVEL.md`](NOVEL.md) — 181-candidate ledger with §4.A–§4.F
- [`NOVEL_ROADMAP.md`](NOVEL_ROADMAP.md) §5 — Tier-1 promotion targets
- [`CROSS_LINK.md`](CROSS_LINK.md) §3 — sister-repo boundary discipline
- [`AGENTS.md`](AGENTS.md) §"Quick agent checklist" — every Phase J
  commit must run `bash selftest/run_all.sh` + `hexa run
  verify/run_all.hexa` before push
- [`LATTICE_POLICY.md`](LATTICE_POLICY.md) §1.2/§1.3 — real-limits-first /
  n=6-auxiliary discipline Phase J honors
- [`LIMIT_BREAKTHROUGH.md`](LIMIT_BREAKTHROUGH.md) — HARD_WALL /
  SOFT_WALL / BREAKABLE_WITH_TECH ledger Phase J.1 gate #32 audits

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase J
scope-definition. J.1–J.3 already landed in parallel commits; J.4 is
this docs commit; J.5 is in flight. Co-defined with Claude Opus 4.7
(1M context). Sister-of-pattern: `PHASE_H_PLAN.md` (2026-05-13).*
