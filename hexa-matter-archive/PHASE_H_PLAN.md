# PHASE_H_PLAN — Category (b) parity-gate landing

> **Created**: 2026-05-13 · **Status**: ✅ IMPLEMENTED (`e12dfb9` lands all 10 Phase H gates; Phase I.1 `583fddb` + Phase I.2 `196b03c` extend coverage to 29/29 — full §B closure)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Predecessor**: Phase G (`_absorption_bridge/` at `e712068`) — closes the
> external-systems absorption layer; this is what comes next.
> **Source-of-scope**: [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md) §B
> + [`V1_2_0_HANDOFF.md`](V1_2_0_HANDOFF.md) §1.

---

## 0. Why Phase H now

Phase A-G shipped the breadth axis (architecture, selftest harness, depth
dirs, +12 verbs, Python/research/absorption bridges). The **largest
concrete residual** per the closure ledger is the **29 enumerated
Category (b) parity gates** in `CLOSURE_RESIDUAL_BACKLOG.md §B` (split
20 Phase B target + 9 Phase F target). Every spec doc cites NIST / CRC /
ASM / SEMI / vendor values, but no `tests/<group>_<gate>_parity.py` has
been authored to do a deterministic numerical comparison against a
vendored snapshot of those values.

Phase H drains the highest-leverage subset. It is the honesty-bridge
step: hexa-matter states "Si density = 2.329 g/cm³ (CRC)"; Phase H makes
that claim a runnable, deterministic test that the spec doc and the
vendored CRC snapshot agree within a published tolerance — without
(vendor snapshots are vendored AS-IS with provenance; no n=6 lattice-fit
applied).

Not vanity scope: every gate has a named source (not a hypothetical),
a numeric target with published tolerance, offline-only execution
(vendored snapshot), small (≤ 80 lines stdlib Python), and zero new
infrastructure (the aggregator pattern already exists in Phase B/E/F/G).

---

## 1. Scope (5 concrete sub-items)

### H.1 — Author 10 Phase-B-target parity gates under `tests/`

**What**: One Python stdlib-only module per gate, located at
`tests/<group>_<gate-id>_parity.py`. Each module owns:

- the cited source (NIST SRD ID / CRC 105th ed. page / ASM vol.+page /
  vendor datasheet PDF SHA / standard ID like ISO 105 / ASTM F121)
- the spec-doc claim (file path + line range + the numeric value)
- the vendored snapshot value (under `tests/snapshots/<gate-id>.json`)
- a tolerance window (absolute and/or relative, source-published where
  available, engineering-defensible otherwise)
- a deterministic numerical comparison that exits 0 on PASS, non-zero on
  FAIL
- a `__<GROUP>_<GATE>__ PASS` sentinel print

**10 target gates** (highest-leverage subset of `§B`, all "Phase B target"
in the ledger — no live-DB fetch needed):

| # | Gate ID | Group | Claim | Source |
|---|---------|-------|-------|--------|
| 1 | `cer_b2_si_density` | CER | Si ρ = 2.329 g/cm³ | CRC 105th ed. |
| 2 | `cer_b3_si_bandgap` | CER | Si E_g = 1.12 eV (300 K) | NIST / Sze 3rd ed. |
| 3 | `cer_b4_sic_bandgap` | CER | 4H-SiC E_g = 3.26 eV | Saddow & Agarwal 2004 |
| 4 | `cer_b5_si3n4_flexural` | CER | Si₃N₄ HIP σ_f = 600–1200 MPa | ASM Handbook vol. 21 |
| 5 | `pol_b1_aramid_tensile` | POL | Kevlar 49 σ = 3.6 GPa / E = 124 GPa / ρ = 1.44 g/cm³ | ASM vol. 21 + DuPont datasheet |
| 6 | `pol_b4_nylon66_tg_tm` | POL | Nylon-6,6 T_g = 323 K / T_m = 538 K | CRC 105th ed. |
| 7 | `fib_b2_paper_tensile` | FIB | Kraft paper tensile per TAPPI T-494 | TAPPI T-494 |
| 8 | `met_b4_w_melting` | MET | W melting point T_m = 3695 K | NIST |
| 9 | `met_b5_os_density` | MET | Os ρ = 22.59 g/cm³ | NIST |
| 10 | `gem_b1_corundum_ri` | GEM | Corundum n_d = 1.762–1.770 | NIST |

**Completion criterion (measurable)**: `ls tests/*_parity.py | wc -l` ≥ 10
AND each individual gate exits 0 when invoked as `python3
tests/<gate>.py --selftest`. Each gate prints its
`__<GROUP>_<GATE>__ PASS` sentinel on stdout. No gate makes a live network
call.

### H.2 — Vendor 10 source-of-truth snapshots under `tests/snapshots/`

**What**: One JSON file per Phase H gate at
`tests/snapshots/<gate-id>.json`. Each snapshot carries:

```json
{
  "__fixture_tag__": "VENDORED SOURCE SNAPSHOT — frozen citation, not live data",
  "gate_id": "cer_b2_si_density",
  "claim": {"property": "density", "value": 2.329, "unit": "g/cm^3"},
  "source": {
    "kind": "CRC_HANDBOOK",
    "edition": "105th",
    "year": 2024,
    "page": "4-87",
    "table": "Physical Constants of Inorganic Compounds"
  },
  "tolerance": {"abs": 0.001, "unit": "g/cm^3", "basis": "CRC tabulated precision"},
  "accessed": "2026-05-13",
  "n6_lattice_fit_applied": false
}
```

- `n6_lattice_fit_applied: false` is a mandatory field on every snapshot.
  No σ·φ=24 fitting on vendor / NIST / standards data.
- `__fixture_tag__` matches the Phase F/G pattern ("VENDORED SOURCE
  SNAPSHOT — frozen citation, not live data").
- Where the source publishes a range (e.g., HIP Si₃N₄ σ_f = 600–1200 MPa),
  the snapshot carries `range_min` and `range_max`; the gate passes iff
  the spec-doc claim lies inside the range.
- SPEC_FIRST verdict is preserved: gate FAIL means the spec doc has
  drifted from the source, not that the spec doc is "MEASURED here".

**Completion criterion (measurable)**: `ls tests/snapshots/*.json | wc -l`
≥ 10 AND `python3 -c "import json, pathlib;
[json.loads(p.read_text()) for p in
pathlib.Path('tests/snapshots').glob('*.json')]"` exits 0 (all parse).
Every snapshot contains the `__fixture_tag__`, `gate_id`, `claim`,
`source`, `tolerance`, `accessed`, and `n6_lattice_fit_applied: false`
fields.

### H.3 — Add a Phase H aggregator at `selftest/parity_gates_smoke.sh`

**What**: A bash aggregator that discovers `tests/*_parity.py`, runs each
with `--selftest`, counts PASS/SKIP/FAIL, and prints a
`__HEXA_MATTER_PARITY_GATES__ PASS (N/N gates, 0 skipped)` sentinel.
Wired into `selftest/run_all.sh` as gate #24.

**Constraints**:
- Pure bash; no Python orchestration. Mirrors the existing
  `selftest/pyproject_smoke.sh` and `selftest/research_bridge_smoke.sh`
  shape exactly.
- Exit 0 iff every gate exits 0. SKIP not allowed here (these are
  stdlib-only parity gates; no optional deps means no skip path).
- Prints a one-line per-gate result followed by the aggregate sentinel.

**Completion criterion (measurable)**: `bash
selftest/parity_gates_smoke.sh` exits 0 AND its stdout contains exactly
one line matching `__HEXA_MATTER_PARITY_GATES__ PASS (10/10 gates, 0
skipped)`. The selftest scoreboard moves from `23/23 PASS` to `24/24
PASS` after wiring.

### H.4 — Flip 10 ledger rows in `CLOSURE_RESIDUAL_BACKLOG.md §B`

**What**: For each gate landed under H.1+H.2, change the §B table row's
`Status` from "Phase B target" to "✅ CLOSED 2026-MM-DD (gate:
`tests/<gate-id>_parity.py`)". Update the §B summary totals and the §D
roll-up.

**Honesty discipline**:
- ✅ CLOSED only after H.3 aggregator confirms the gate exits 0. No
  "CLOSED" with a FAIL underneath.
- UNPROVEN markers on adjacent verbs (LK-99, magic-MOF DAC, CNT yarn
  80 GPa lab-mm, marine-biodegradable PHA, …) stay verbatim.
- SPEC_FIRST verdict preserved: a parity gate matching a CRC value
  does not turn the spec into a measurement.

**Completion criterion**: `grep -c "✅ CLOSED" CLOSURE_RESIDUAL_BACKLOG.md`
increases by exactly 10 vs. the Phase G baseline. §B summary totals
"29 → 19 remaining"; §D roll-up updated accordingly.

### H.5 — Update `INIT.md`, `hexa.toml`, and `AGENTS.md` consistency

**What**: Three coordinated edits so the selftest's
`registry_consistency_audit.py` + `cross_doc_audit.py` keep passing:

- `INIT.md` Phase H row: `🚧 WIP` → `✅ DONE` + commit SHA filled in; add
  a "Phase H — DONE" section mirroring the Phase G template (gate count,
- `hexa.toml [closure]`: add `parity_gates_total = 10`; update
  `selftest_pass = "23/23"` → `"24/24"`.
- `AGENTS.md` §🧪 Selftest authority: update "23/23 PASS" → "24/24 PASS";
  add a Phase H "Parity gates" subsection noting `tests/*_parity.py` +
  `selftest/parity_gates_smoke.sh`.

**Completion criterion**: `bash selftest/run_all.sh` exits 0 showing
24/24 PASS; `hexa run verify/run_all.hexa` exits 0 showing 4/4 PASS;
`registry_consistency_audit.py` and `cross_doc_audit.py` both PASS
(no new drift between CLI / hexa.toml / verify / README / AXIS.md /
AGENTS.md).

---

## 2. Out of scope (explicit, preserves the discipline)

- ❌ **Phase F-target parity gates** (the 9 §B rows tagged "Phase F"
  — `cer-b6` UHPC vendor, `cer-b8` thermal donor, `pol-b3` microplastics,
  `pol-b5` Dyneema, `pol-b6` CNT yarn, `prc-b2` Gibbs LCA, `prc-b3`
  sol-gel kinetics). These require live-DB or literature aggregation
  bridges that overlap with `_research_bridge/`. Defer.
- ❌ **Category (c) wet-lab partnerships** (Wacker poly-Si batch audit,
  Wolfspeed SiC wafer audit, LK-99 reproduction, Stora Enso CLT mill
  audit, …). 100% out-of-software-scope; stays in §C.
  every vendor / NIST / ASM / SEMI / ISO / TAPPI value is quoted
  AS-IS with provenance. `n6_lattice_fit_applied: false` is hard-coded
  in every snapshot.
- ❌ **Touching UNPROVEN markers.** LK-99 stays UNPROVEN; magic-MOF DAC
  $100/t stays UNPROVEN with Climeworks $600–1000/t baseline; CNT yarn
  80 GPa stays "lab mm-scale" UNVERIFIED; marine-biodegradability
  stays UNVERIFIED for most PHA grades. The parity-gate work is on the
  honest spec values, not on the speculative ones.
- ❌ **New verbs.** Phase H is honesty-on-existing-29, not breadth.
  The 29-verb count is fixed across Phase H.
- ❌ **Live API calls in selftest.** Mirrors the Phase F/G discipline
  exactly — vendored snapshots only; live mode (if ever added) is
  gated behind an explicit `--live` flag and never invoked by CI.

---

## 3. Honesty / hard-constraint compliance

Bound by the 6 hard constraints in `INIT.md` §"Hard constraints":

1. **`LATTICE_POLICY.md` §1.2 real-limits-first** — gates anchor to REAL
   limits (NIST constants, CRC measured values, ASM ranges, ISO/TAPPI
   test methods), never to n=6 tautology. `verify/lattice_arithmetic.hexa`
   stays auxiliary per §1.3.
2. **`LATTICE_POLICY.md` §1.3 n=6 auxiliary** — zero lattice-derived
   assertions added. Gate count (10) is engineering-chosen, not
   lattice-chosen.
   tagged `n6_lattice_fit_applied: false`. NIST / CRC / ASM / TAPPI /
   ISO / DuPont / Wolfspeed values flow through verbatim with provenance.
4. **SPEC_FIRST verdict preserved** — gates check spec ↔ source parity;
   they do not turn the spec into a measurement. "SPEC_FIRST, not
   MEASURED here" footer stays verbatim.
5. **UNPROVEN / UNVERIFIED stamps preserved verbatim** — LK-99,
   metallic-H, magic-MOF DAC, CNT yarn 80 GPa lab-mm, marine-
   biodegradable PHA all keep their stamps. Phase H targets honestly-
   anchored values only.
6. **`LIMIT_BREAKTHROUGH.md` HARD_WALL classifications honored** —
   nothing in Phase H attempts to "verify" a HARD_WALL claim.

---

## 4. Sequencing within Phase H

Recommended order (each step is independently committable):

1. **H.2 first** — author 10 snapshots under `tests/snapshots/*.json`.
   This is the citation-discipline anchor; the gates need this as input.
2. **H.1 second** — author 10 stdlib-only parity gates under
   `tests/*_parity.py`. Each reads its snapshot and the cited spec-doc
   line; each prints its sentinel.
3. **H.3 third** — add `selftest/parity_gates_smoke.sh` aggregator; wire
   into `selftest/run_all.sh` as gate #24; confirm `24/24 PASS`.
4. **H.4 fourth** — flip the 10 ledger rows in
   `CLOSURE_RESIDUAL_BACKLOG.md §B` from "Phase B target" to "✅ CLOSED".
5. **H.5 last** — update `INIT.md` (Phase H row: WIP → DONE + SHA),
   `hexa.toml [closure]`, and `AGENTS.md` (23/23 → 24/24).

A single Phase H commit at the end ties the SHA into `INIT.md`. The same
author-trailer convention as Phase A-G applies:
`박민우 <nerve011235@gmail.com>` + `Co-Authored-By: Claude Opus 4.7`.

---

## 5. Expected post-Phase-H scoreboard

| Surface | Phase G baseline | Phase H target |
|---|---|---|
| `verify/run_all.hexa` | 4/4 PASS | 4/4 PASS (unchanged — Phase H is selftest layer) |
| `selftest/run_all.sh` | 23/23 PASS | **24/24 PASS** |
| `tests/*_parity.py` | 0 | **10** |
| `tests/snapshots/*.json` | 0 | **10** |
| `CLOSURE_RESIDUAL_BACKLOG.md §B` UNVERIFIED | 29/29 | **19/29** (10 closed) |
| `hexa.toml [closure].parity_gates_total` | (absent) | **10** |
| `_python_bridge/` modules | 12 | 12 (unchanged) |
| `_research_bridge/` modules | 8 | 8 (unchanged) |
| `_absorption_bridge/` adapters | 10 | 10 (unchanged) |
| Verb count | 29 | 29 (unchanged) |

---

## 6. Risk register

| Risk | Mitigation |
|---|---|
| Source value drift across editions (CRC 104th vs 105th) | Snapshot pins `edition` + `year` + `page`; gate uses snapshot, not "latest CRC" |
| Spec precision vs source precision (spec 2.33 vs CRC 2.329) | Tolerance window with explicit `basis` covers this; widen tolerance with documented basis if needed |
| Vendor datasheet paywall / login | Phase F handles live retrieval; Phase H stays on freely-citable sources (NIST / CRC / ASM / open standards) |
| Gate count of 10 feels arbitrary | Engineering-driven: 10 highest-confidence rows in §B that need no live-DB. A future phase can pick the remaining Phase-B rows |
| Selftest scoreboard expansion breaks downstream consumers | `hexa.toml` + `cross_doc_audit.py` keeps every consumer (README / AGENTS.md / INIT.md) in sync |

---

## 7. References

- [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md) §B — the
  29-gate ledger that Phase H drains 10 from
- [`V1_2_0_HANDOFF.md`](V1_2_0_HANDOFF.md) §1 — the original Phase B
  parity-gate roster (this is the implementation phase of that plan,
  retitled "Phase H" in the post-A-G numbering)
- [`INIT.md`](INIT.md) — Phase status table (Phase H row added with
  status `🚧 WIP` / no SHA pending this commit)
- [`AGENTS.md`](AGENTS.md) §"Quick agent checklist" — every Phase H
  commit must run `bash selftest/run_all.sh` (target 24/24) +
  `hexa run verify/run_all.hexa` (target 4/4) before push
- [`LATTICE_POLICY.md`](LATTICE_POLICY.md) §1.2/§1.3 — the
  real-limits-first / n=6-auxiliary discipline Phase H must honor
- [`LIMIT_BREAKTHROUGH.md`](LIMIT_BREAKTHROUGH.md) — the HARD_WALL /
  SOFT_WALL / BREAKABLE_WITH_TECH ledger Phase H must not silently
  re-classify

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase H
scope-definition. No gates authored yet — plan only. Co-defined with
Claude Opus 4.7 (1M context).*
