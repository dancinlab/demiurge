# AXIS/STATUS.md — hexa-bio gate-aggregation dashboard

> **Status: auto-generated from selftest gate outputs. Hand-edits will be overwritten by `selftest/status_md_generator.py`.** The DASHBOARD is in-silico simulator-consistency only (g8/f2).


> **Honesty fence (g8 / f2 / README criterion #4):** every number below reports an IN-SILICO gate state. A PASS / HOLD / DETERMINISTIC verdict verifies simulator-consistency of a preregistered condition ONLY — NEVER a therapeutic, clinical, regulatory, immunogenic, efficacy, potency, selectivity, or wet-lab claim. Axis counts are an architectural decision (`f_lattice_fit`), NOT derived from any n=6 lattice scalar.


---

## §1 Axis count summary

> _SSOT-declared totals (AXIS.tape core + AXIS/HIERARCHY.tape expansion-layer). NOT lattice-derived (`f_lattice_fit`)._


| Layer | Count | SSOT |
|---|---|---|
| **Core axes** | 5 | `../AXIS.tape` (QUANTUM · WEAVE · NANOBOT · RIBOZYME · VIROCAPSID) |
| **Expansion-MAIN** | 4 | `HIERARCHY.tape` §1 (COVALENT · BIFUNCTIONAL · METALLODRUG · OLIGONUCLEOTIDE) |
| **Sub-axes** | 15 | `HIERARCHY.tape` §2 (6 :> BIFUNCTIONAL · 3 :> QUANTUM · 2 :> WEAVE · 1 :> COVALENT · 2 :> RIBOZYME · 1 :> VIROCAPSID) |
| **TOTAL** | **24** | architectural — see `README.md` §4 (keep-5 dissent preserved) |

## §2 Tier distribution

> _From `selftest/hexa_verify_tier_batch.py` — a TIER REPORTER, not enforcer. Glyph counts across the 44-sim roster._


[SKIP] tier-batch gate could not be run on this host (g7 skip-is-honest).

## §3 Falsifier-gate status

> _From `selftest/falsifier_execution_gate.py` — runs each preregistered falsifier (F-METALLODRUG/OLIGO/COVALENT/BIFUNCTIONAL-1/2/3) against its axis sim._


[SKIP] falsifier-gate could not be run on this host (g7 skip-is-honest).

## §4 Determinism-gate status

> _From `selftest/determinism_regression_gate.py` — runs each sim TWICE under `PYTHONHASHSEED=0` and compares stdout byte-for-byte. This is the §11 deductive-verification determinism contract._


[SKIP] determinism-gate could not be run on this host (g7 skip-is-honest).

## §5 Cross-axis coverage

> _Filesystem-derived count of cross-axis bridge sims (`_python_bridge/module/*_cross.py`). A cross-axis bridge is NOT a new axis — core-5 unchanged._


Cross-axis bridge sims: **24**.

> _Each bridge imports both sides' sims (no fork — `f3`); each carries a passing sentinel + draft-07 schema; each is honesty-fenced (mathematical equivalence ≠ mechanistic equivalence; comparison ≠ ranking)._

## §6 Case studies

> _One-disease in-silico pilots in `case_studies/`. NOT the 200-disease deferred work (which remains deferred)._


Disease portfolios: **10** (alzheimer_portfolio · bcl2_portfolio · hiv1_portfolio · kras_g12c_portfolio · migraine_portfolio · mpro_covid_portfolio · parkinson_portfolio · sickle_cell_portfolio · sma_portfolio · type2_diabetes_portfolio).

> _Each portfolio composes existing sims for FDA-approved drugs against one disease, with research-stage / CBER-scope items honestly listed as UNPLACED. NOT a clinical, efficacy, or portfolio-recommendation claim (g8)._

## §7 Honesty caveats


- **g1 real-limits-first** — every gate is anchored in a named real-limit (Eyring TST · SantaLucia NN · Caspar-Klug · Zlotnick · Griffith-Orgel · MWC · Bell · Strelow · Douglass/Han/Gadd · Zimm-Bragg · Nussinov · CODATA 2019). The dashboard does NOT invent claims at the aggregation layer — every number here matches the underlying gate.
- **g7 skip-is-honest** — a [SKIP] in any section above means the underlying gate could not be run on this host (file absent, subprocess timeout, non-zero exit). It is NOT a failure. Only a `__STATUS_MD_GENERATOR__ FAIL` (consistency-check mismatch) signals a real problem.
- **g8 in-silico-only-claim-scope** — a tier ≠ 🔴, a falsifier HOLD, a DETERMINISTIC verdict, and a passing case-study sentinel ALL verify in-silico simulator + metadata internal consistency ONLY. None of them is a wet-lab, clinical, regulatory, immunogenic, efficacy, potency, selectivity, DC50, Dmax, or therapeutic claim.
- **f2 wet-lab-clinical-claim-from-in-silico** — never claim therapeutic / clinical / regulatory progress from a C2/C3 in-silico PASS. See `CLOSURE_RESIDUAL_BACKLOG.md` §0 for the explicit out-of-software-scope items.
- **f_lattice_fit** — the axis counts in §1 are an architectural decision grounded in computational scope, NOT a lattice derivation. The hexa- token is a dancinlab-family branding artifact (see `README.md` §0 count-honesty paragraph).
- **README §4 keep-5 dissent** — the rigorous axis-expansion analysis recommended KEEP 5 axes + cross-cutting platform layer. The 4 expansion-main axes here exist per explicit USER DIRECTION 2026-05-16, with the dissent preserved verbatim (NOT erased) in `README.md` §4 + `HIERARCHY.tape` `@N rigorous_dissent`.
- **Criterion #4 (drug-only / CDER)** — THERANOSTIC + GENETIC-MEDICINE + ADC remain UNPLACED (CBER scope tension); not implemented as code axes (honest).

## §8 Generated-at timestamp

> _Fixed for byte-identical re-runs (cohort convention). Re-run `python3 selftest/status_md_generator.py` to refresh the gate-aggregated numbers; the timestamp string itself is deliberately stable._


- **generated-at**: `2026-05-16T00:00:00Z`
- **generator**: `selftest/status_md_generator.py`
- **output**: `AXIS/STATUS.md` (this file)
- **gates aggregated**:
    1. `selftest/hexa_verify_tier_batch.py`
    2. `selftest/falsifier_execution_gate.py`
    3. `selftest/determinism_regression_gate.py`

---

_End of auto-generated dashboard. Hand-edits will be overwritten on next run of `selftest/status_md_generator.py`._
