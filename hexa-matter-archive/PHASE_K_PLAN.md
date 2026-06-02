# PHASE_K_PLAN — Universal-FF runner infrastructure + SIM-NNP-PROXY → SIM-NNP transition path

> **Created**: 2026-05-14 · **Status**: 🚧 ROLLING UP (K.1 ✅ DONE _(this commit)_; K.2 / K.3 / K.4 planned, no automated promotion)
> **Author**: 박민우 <nerve011235@gmail.com>
> **Predecessors**: Phase J.2 (`a01b6dc` + ledger sync) — vendored 17 SIM-NNP-PROXY snapshots under `_absorption_bridge/universal_ff/predictions/*.json` for 7 Tier-1 NOVEL candidates plus 10 additional Round-3 candidates.

---

## 0. Why Phase K — "infrastructure-only", not promotion

Phase J.2 vendored 17 SIM-NNP-PROXY snapshots (peer-reviewed proxy values
quoted verbatim from the universal-FF literature; `is_measurement: false`).
Phase J left the actual **local NNP runs** as future work because:

- Each model requires hundreds-of-MB checkpoint downloads.
- Live inference breaks CI's offline + deterministic discipline.
- Promoting any candidate from `SIM-NNP-PROXY` (vendored proxy) to
  `SIM-NNP` (real local run) is a deliberate user/maintainer action,
  **not** an automated CI promotion.

Phase K is the **infrastructure landing** for that next step. K.1 ships a
unified runner module under `_python_bridge/universal_ff_runner.py` that
exposes a single `run_universal_ff(candidate_id, model, structure=None)`
function for all 5 supported NNPs. The runner SKIPs cleanly when each
optional dep is missing — no fake "we ran MACE" output when MACE isn't
installed (NO MOCKED FUNCTIONALITY discipline).

What Phase K is **not**:

- ❌ Not an automated promotion of any candidate to `SIM-NNP`. That
  requires an explicit user/maintainer trigger (Phase K.2 below).
- ❌ Not a redefinition of "100% closure". (a)+(b) = 100% from Phase I.2
  remains intact. K.1 adds infrastructure depth; it does not redraw the
  envelope.
- ❌ Not an EXTERNAL-VERIFIED promotion. `SIM-NNP` is still a SIM tag.
  Neither `SIM-NNP-PROXY` nor `SIM-NNP` crosses the external-lab
- ❌ Not an UNPROVEN-flag removal. Every flag preserved verbatim.

---

## 1. Scope (4 sub-phases)

### K.1 — `universal_ff_runner.py` infrastructure ✅ DONE _(this commit)_

A single ~250-LOC stdlib-plus-optional-imports module under
`_python_bridge/universal_ff_runner.py`. Exposes:

```python
run_universal_ff(candidate_id: str, model: str,
                 structure: Optional[dict] = None) -> dict
```

For each of `mace` / `chgnet` / `alignn` / `schnet` / `m3gnet`:

- **Try-import**. If missing, emit
  `SKIP <model> (optional dep '<package>' not installed; SIM-NNP run not performed)`
  to stdout and return `{"status": "SKIP", "reason": ..., "is_measurement": false,
  "is_external_verification": false, "n6_lattice_fit_applied": false}`.
- **When deps are present**, load the proxy fixture from
  `_absorption_bridge/universal_ff/predictions/<candidate_id>.json`, run
  the model on a representative structure (deterministic — uses ASE
  Atoms or formula-derived structure), and return
  `{"status": "RUN", "model": ..., "predicted_value": ..., "proxy_value": ...,
  "match_within_tolerance": bool, "is_measurement": false, "is_external_verification": false,
  "n6_lattice_fit_applied": false}`. Tolerance: ±20 % relative.

`--selftest` mode is **mock-only**:

- Force-SKIPs every optional dep via `_MOCK_FORCE_SKIP = True`.
- Validates all 5 SKIP sentinels are reachable.
- Exits 0 with sentinel
  `__HEXA_MATTER_UFF_RUNNER__ PASS (M models attempted, K skipped, J run)`.
- Selftest **never** triggers live computation. CI remains
  network-free and torch-free.

**Completion criterion (measurable)**: `python3 _python_bridge/universal_ff_runner.py --selftest` → exit 0 with `5 models attempted, 5 skipped, 0 run`. ✅ Confirmed.

**Status**: ✅ IMPLEMENTED in this commit.

---

### K.2 — 7 Tier-1 actual runs (future, user-triggered)

Promote `SIM-NNP-PROXY` → `SIM-NNP` for the 7 Tier-1 candidates from
`NOVEL_ROADMAP.md §5`, IF AND ONLY IF:

1. The maintainer has installed all 5 optional deps locally
   (`mace-torch` · `chgnet` · `alignn` · `schnetpack` · `matgl`).
2. `run_universal_ff(candidate_id, model)` returns `status: "RUN"` for
   **all 5 models** without crashing.
3. Each `match_within_tolerance` is `True` (model output within ±20 %
   relative of the vendored proxy value).
4. The maintainer explicitly opts-in via a separate commit — there is
   NO automated promotion path in CI.

Per-candidate result manifest deposited under
`_absorption_bridge/universal_ff/predictions/<candidate_id>.sim_nnp.json`
(distinct from the existing `<candidate_id>.json` proxy snapshot — the

**Completion criterion (measurable, future)**: 7 of the existing 17
proxy snapshots gain a sibling `.sim_nnp.json` real-run manifest with
`status: "RUN"` and `match_within_tolerance: true` across 5/5 models;
the corresponding NOVEL.md row flips from `SIM-NNP-PROXY` to `SIM-NNP`
with an explicit user-maintainer attribution.

**Status**: 📋 PLANNED. **No automated promotion** — requires explicit
user/maintainer trigger.


- Real model output is computation, **not** measurement. Every record
  carries `is_measurement: false`.
- `SIM-NNP` status does **not** promote to `EXTERNAL-VERIFIED`. The
  external-lab attribution requirement holds.
- Proxy snapshot from Phase J.2 stays verbatim — K.2 adds a sibling
  manifest, never overwrites.

---

### K.3 — Selftest gate aggregation ✅ DONE _(this commit, K.1 scope)_

Phase K.1 wires `selftest/universal_ff_runner_smoke.sh` (gate #38) into
`selftest/run_all.sh`. Selftest scoreboard 37/37 → **38/38** PASS.

The gate emits sentinel:
`__UNIVERSAL_FF_RUNNER__ PASS (5/5 models SKIP cleanly when deps missing)`

K.3 (this sub-phase, captured in this commit) also keeps the existing
`uff_predictions_smoke` gate (Phase J.2 gate #37) unchanged — that gate
validates the **proxy** snapshots; this new gate validates the **runner
infrastructure**. Both gates coexist; they audit complementary surfaces.

**Status**: ✅ IMPLEMENTED in this commit.

---

### K.4 — Documentation update ✅ DONE _(this commit)_

Docs landed in this commit:

1. **`_python_bridge/universal_ff_runner.md`** (~80 lines) — runner
   architecture, SIM-NNP vs SIM-NNP-PROXY distinction, optional-dep
2. **`NOVEL.md §2`** — new `SIM-NNP` row in the status pipeline table
   distinguishing real-local-run from SIM-NNP-PROXY (vendored proxy).
3. **`PHASE_K_PLAN.md`** (this file) — Phase K scope-definition
   mirroring `PHASE_J_PLAN.md` shape.
4. **`INIT.md`** Phase status table — new Phase K row.
5. **`AGENTS.md`** + **`hexa.toml`** scoreboard sync — 37/37 → 38/38.

**Status**: ✅ IMPLEMENTED in this commit.

---

## 2. Out of scope (explicit, preserves the discipline)

- ❌ **Automated SIM-NNP-PROXY → SIM-NNP promotion.** K.1 ships
  infrastructure only. K.2 promotion requires explicit
  user/maintainer trigger; CI never auto-promotes.
- ❌ **Live MACE / CHGNet / ALIGNN / SchNet / M3GNet inference in
  selftest.** `--selftest` is mock-only; force-SKIPs every dep. No
  network, no checkpoint download, no torch import in CI.
  requires an external lab citation with sample-ID + measurement
  protocol. NNP-real-local-run predictions do NOT qualify.
- ❌ **UNPROVEN-flag removal.** Every flag preserved verbatim — LK-99
  HARD_WALL · magic-MOF DAC $100/t UNPROVEN · CNT yarn 80 GPa
  lab-mm UNPROVEN · Re-free 4th-gen SX UNVERIFIED · marine-PHA generic
  UNVERIFIED · GNoME `is_synthesized: false` · Matlantis COMMERCIAL
  UNVERIFIED · perovskite 25-yr lifetime UNVERIFIED · Pb halide migration
  HARD_WALL · Cr poisoning HARD_WALL · Ir scarcity HARD_WALL · SEI
  HARD_WALL.
- ❌ **n=6 lattice-fit on NNP outputs.** Every K.1 record carries
  `n6_lattice_fit_applied: false`. NNPs publish their own error bars
  (Batatia 2022 force MAE 20–60 meV/Å typical); we do not lattice-fit.
- ❌ **New verbs.** Verb count stays at 36 across Phase K.

---

## 3. Honesty / hard-constraint compliance

Bound by the 6 hard constraints in `INIT.md` §"Hard constraints":

1. **`LATTICE_POLICY.md §1.2 real-limits-first`** — every K.1 record
   anchors on REAL NNP discipline (force MAE published by each model
   paper), never on n=6 tautology.
2. **`LATTICE_POLICY.md §1.3 n=6 auxiliary`** — zero lattice-derived
   assertions added. Tolerance band (±20 %) is engineering-chosen,
   matching typical universal-FF energy/property MAE on out-of-domain
   chemistries.
   ALIGNN / SchNet / M3GNet outputs flow through verbatim with
   provenance + their own error bars. NO n=6 lattice-fit applied.
4. **SPEC_FIRST verdict preserved** — `SIM-NNP` is a SIM tag, NOT
   `EXTERNAL-VERIFIED`. Verb spec footers ("SPEC_FIRST, not MEASURED
   here") stay verbatim across all 36 verb specs.
5. **UNPROVEN / UNVERIFIED stamps preserved verbatim** — see §2 list.
6. **`LIMIT_BREAKTHROUGH.md` HARD_WALL classifications honored** —
   Phase K does not re-classify any wall; it only adds an
   infrastructure layer for local NNP simulation.

Sister-domain hand-off discipline (`CROSS_LINK.md §3`) remains intact:
cell-level engineering → `hexa-energy` · device-level → `hexa-chip` ·
room-T superconductivity → `hexa-rtsc` · L5 autonomy → `hexa-mobility`
(out-of-claim). hexa-matter owns the material layer only.

---

## 4. Sequencing within Phase K

```
K.1  (runner infrastructure, gate #38)   _(this commit)_   [DONE]
K.2  (7 Tier-1 actual runs, opt-in)      📋 PLANNED         [requires user trigger]
K.3  (selftest gate aggregation)         _(this commit)_   [DONE — bundled with K.1]
K.4  (docs)                              _(this commit)_   [DONE — bundled with K.1]
```

K.1 + K.3 + K.4 are landed in **this commit** (single feat(phase-k.1)
commit). K.2 is deferred to a future user/maintainer-triggered commit.

Each sub-phase carries the same author-trailer convention:
`박민우 <nerve011235@gmail.com>` + `Co-Authored-By: Claude Opus 4.7`.

---

## 5. Expected post-Phase-K scoreboard

| Surface                            | Phase J baseline | Phase K target (this commit) |
|------------------------------------|------------------|------------------------------|
| `verify/run_all.hexa`              | 4/4 PASS         | 4/4 PASS (unchanged)         |
| `selftest/run_all.sh`              | 37/37 PASS       | **38/38 PASS**               |
| `tests/*_parity.py`                | 29               | 29 (unchanged)               |
| `_absorption_bridge/` adapters     | 16               | 16 (unchanged)               |
| `_python_bridge/` modules          | 12 (under `module/`) | 12 + 1 runner-at-root        |
| NOVEL.md candidates                | 181              | 181 (unchanged)              |
| NOVEL.md `SIM-NNP-PROXY` rows      | 7 Tier-1 + 10    | unchanged (K.1 ships infra only) |
| NOVEL.md `SIM-NNP` rows            | 0                | 0 (K.1 ships infra only; K.2 future) |
| `CLOSURE_RESIDUAL_BACKLOG.md §B`   | 0 (all CLOSED)   | 0 (unchanged)                |
| `(a)+(b) closure-grade`            | **100%**         | **100%** (unchanged)         |
| Verb count                         | 36               | 36 (unchanged)               |

---

## 6. Risk register

| Risk | Mitigation |
|---|---|
| Reader interprets K.1 as "we now run NNPs in CI" | This plan §0 + §1 K.1 explicitly state mock-only selftest; runner module's docstring + `_python_bridge/universal_ff_runner.md` repeat the boundary. |
| K.2 future promotion drifts from infrastructure (sibling-manifest convention) | K.2 spec in §1 above fixes the naming convention (`<candidate_id>.sim_nnp.json` sibling) so any future agent picks up the same pattern. |
| SIM-NNP confused with SIM-NNP-PROXY | `NOVEL.md §2` now has two adjacent rows distinguishing them; runner SKIP record explicitly says "SIM-NNP run not performed". |
| SIM-NNP confused with EXTERNAL-VERIFIED | Every runner record carries `is_external_verification: false`; runner doc + plan §2 + §3 repeat the boundary. |
| Optional-dep fragility (torch wheel breaks on Apple Silicon) | K.1 SKIPs cleanly; K.2 deferral is the explicit mitigation — CI does not depend on torch availability. |
| Selftest scoreboard expansion breaks downstream consumers | `hexa.toml [closure].selftest_pass` updated atomically in this commit; `cross_doc_audit.py` keeps README / AGENTS.md / INIT.md in sync. |

---

## 7. References

- [`_python_bridge/universal_ff_runner.py`](_python_bridge/universal_ff_runner.py) — K.1 module
- [`_python_bridge/universal_ff_runner.md`](_python_bridge/universal_ff_runner.md) — K.1 architecture doc
- [`selftest/universal_ff_runner_smoke.sh`](selftest/universal_ff_runner_smoke.sh) — gate #38
- [`selftest/universal_ff_runner_smoke.py`](selftest/universal_ff_runner_smoke.py) — gate #38 inner wrapper
- [`_absorption_bridge/universal_ff/predictions/`](_absorption_bridge/universal_ff/predictions/) — 17 SIM-NNP-PROXY fixtures (Phase J.2)
- [`_absorption_bridge/universal_ff/SOURCES.md`](_absorption_bridge/universal_ff/SOURCES.md) — 5-FF citation table
- [`NOVEL.md`](NOVEL.md) §2 — status pipeline (now distinguishes SIM-NNP-PROXY ↔ SIM-NNP)
- [`PHASE_J_PLAN.md`](PHASE_J_PLAN.md) — structural template Phase K mirrors
- [`INIT.md`](INIT.md) — Phase status table (Phase K row added)
- [`AGENTS.md`](AGENTS.md) — agent operating guide (scoreboard synced 37 → 38)
- [`LATTICE_POLICY.md`](LATTICE_POLICY.md) §1.2/§1.3 — real-limits-first / n=6-auxiliary discipline Phase K honors

---

*Document authored 2026-05-14 by 박민우 <nerve011235@gmail.com> as
Phase K scope-definition. K.1 + K.3 + K.4 landed in this commit; K.2
deferred (requires explicit user/maintainer trigger). Co-defined with
Claude Opus 4.7 (1M context). Sister-of-pattern: `PHASE_J_PLAN.md` (2026-05-13).*
