# RTSC.md §9.9.1 Phase 3 — N1-N4 microkernel identification audit

**Stamp** 2026-05-21
**Scope** Audit the 4 N-cohort producers (`csp_adapter.py` · `beenet_adapter.py` · `askcos_adapter.py` · `cross_code_dft.py`) under `/Users/ghost/core/hexa-lang/stdlib/material/` for hot closed-form sections that are Phase-4 Path-A port candidates.
**Precedent** `stdlib/material/sim.hexa` (BCS / McMillan / Allen-Dynes / WHH, ~200 LOC, libm-only, 4 closed-form formulas — the ONLY successful Path A case so far, per RTSC.md §9.9.1).
**Anti-pattern guard** RTSC.md §9.9.1 explicitly forbids porting (a) wrap itself / (b) external lib outputs / (c) ML weights / (d) DB content. Only *post-processing closed-form on lib outputs* counts as a valid Path-A candidate.

---

## Per-producer summary

| Cohort | File | LOC | MICROKERNEL CANDIDATE | DELEGATION | DISPATCH/SKIP |
|---|---|---:|---:|---:|---:|
| **N1** csp_adapter | `csp_adapter.py` | 385 | **0** | 5 (`_probe_airss/uspex/calypso/opencsp`, `_run_backend_stub`) | 4 (`_detect_backend`, `main`, `_parse_argv`, `_which`) |
| **N2** beenet_adapter | `beenet_adapter.py` | 530 | **0** (Allen-Dynes already in sim.hexa) | 5 (`_probe_imports`, `_probe_repo`, `_probe_weights`, `_load_structure`, `_run_inference`) | 3 (`_classify_input`, `main`, `_parse_argv`) |
| **N3** askcos_adapter | `askcos_adapter.py` | 515 | **2** (`_parse_formula_elements`, `_classify_composition_domain`) | 4 (`_probe_askcos`, `_probe_docker_image`, `_resolve_hosted_endpoint`, `_call_askcos_*`) | 1 (`main`) |
| **N4** cross_code_dft | `cross_code_dft.py` | 759 | **2** (`_compute_consensus`, source-σ-from-spread helper) | 6 (`_poll_mp_cache`, `_poll_aflow`, `_poll_oqmd`, `_poll_hexa_rtsc`, `_http_get_json`, `_pool_cli_present`) | 5 (`_slugify_mp_cache`, `_parse_formula_to_species`, `_resolve_hexa_*`, `main`) |

**Aggregate microkernel candidate count = 4** (across 4 cohorts, matching RTSC.md §9.9.1 Phase 3 expectation of "0-5 tight list").

---

## Per-candidate specs

### C1 — `cross_code_dft._compute_consensus` (N4) · **HIGHEST ROI**

- **Source** `cross_code_dft.py:468-509` (~42 LOC)
- **What it does** Inverse-variance weighted consensus + pairwise relative-error metric. Formula matches the Nb attestation pattern: `wᵢ = 1/σᵢ²`, `mean = Σwᵢxᵢ/Σwᵢ`, `combined σ = 1/√Σwᵢ`, plus `rel_err_max = max over (i,j) of |xᵢ-xⱼ|/max(|xᵢ|,|xⱼ|,ε)`.
- **Inputs** `rows: [{name: string, value: float, sigma: float}, ...]` (filter out `name == "hexa_rtsc"` per s4 caveat — algebraic ceiling excluded from numeric consensus).
- **Output** `{value: float, sigma: float, n_sources: int, rel_err_max_pairwise: float, consensus_sources: [string]}` or `None` when `< 2` eligible.
- **Dependencies (libm)** `sqrt` only. Pure arithmetic otherwise.
- **Equivalent in sim.hexa?** No. Distinct from BCS/McMillan/AD/WHH. Would be the **first non-Tc kernel** in sim.hexa.
- **Port effort** ~30 min (single function, comparable to `whh_hc2_zero` in sim.hexa).
- **Why ROI is highest** (1) closed-form math identical to existing Nb attestation precedent — already a "trusted formula" in this codebase; (2) directly cross-validates a Python implementation that already lives in production; (3) enables hexa-native re-derivation for *any* future multi-source consensus consumer (not just N4 — generic stats kernel).

### C2 — `cross_code_dft` σ-from-spread sub-snippet (N4)

- **Source** `cross_code_dft.py:139-144, 274-279, 338-343` (~6 LOC, repeated inline 3× across MP/AFLOW/OQMD pollers)
- **What it does** Compute per-source σ as `max(stdev_of_polymorph_values, σ_default)`. Pure unbiased sample stdev: `mean = Σx/n`, `var = Σ(x-mean)²/(n-1)`, `sigma = max(√var, σ_default)`.
- **Inputs** `vals: [float]`, `sigma_default: float`
- **Output** `float` (effective σ)
- **Dependencies (libm)** `sqrt`.
- **Equivalent in sim.hexa?** No.
- **Port effort** ~10 min if bundled with C1 in same hexa-native file (shared sqrt usage).
- **Why ROI is real but lower than C1** It's a tiny helper used inline 3×. Port = de-duplication win + 1 hexa-native helper for future producers. Could be merged into C1's hexa-native module as a private helper.

### C3 — `askcos._parse_formula_elements` (N3)

- **Source** `askcos_adapter.py:137-163` (~27 LOC)
- **What it does** Flat chemical-formula → element-count dict; expands single-level parentheses (`(PO4)6` → `P6O24`); tracks fractional stoichiometry. NOT a full IUPAC parser.
- **Inputs** `formula: string`
- **Output** `Map<string, float>` (element symbol → count)
- **Dependencies (libm)** None — pure regex + integer/float arithmetic.
- **Equivalent in sim.hexa?** No.
- **Port effort** ~45 min (requires hexa-lang regex/string-iterator API; if regex is missing from hexa stdlib, this becomes a ~90 LOC hand-rolled tokenizer — **borderline candidate**).
- **Why ROI is moderate** Used twice (composition classifier in N3; would be useful in any future composition-aware producer). **CAVEAT**: depends on hexa-lang regex/character-class support — verify before scheduling Phase 4 port. If regex unavailable, this becomes a heavier port.

### C4 — `askcos._classify_composition_domain` (N3)

- **Source** `askcos_adapter.py:166-249` (~84 LOC including the `_INORGANIC_SC_HINTS` allow-list and `metals` set)
- **What it does** Composition → `inorganic_sc | organic_molecular | ambiguous`. Closed-form rules: (1) explicit allow-list hit, (2) no-carbon → inorganic, (3) carbon + heavy-metal + oxide pattern → inorganic, (4) carbon + small molecule → organic, (5) ambiguous otherwise.
- **Inputs** `formula: string`
- **Output** `{domain_label: string, rationale: string}`
- **Dependencies (libm)** None.
- **Equivalent in sim.hexa?** No.
- **Port effort** ~30 min (once C3 is ported — the parser is a prerequisite).
- **Why ROI is moderate** Pure-rule classifier on top of C3. Decoupling from C3 not possible — port both together as one hexa-native module or skip both. Replaces a Python-only gate-decision in the ASKCOS wrap with a hexa-native rule that any cohort can reuse for organic/inorganic dispatch.

---

## Aggregate recommendation — Phase 4 port priority

| Priority | Candidate | Rationale | LOC | Session est |
|---:|---|---|---:|---|
| **P1** | **C1 + C2 — inverse-variance consensus + σ-from-spread** | Generic stats kernel (not bound to material domain), libm-only, mirrors trusted Nb attestation precedent already used elsewhere in this codebase. First non-Tc hexa-native kernel — opens `sim.hexa` to multi-source consensus consumers beyond N4. | ~50 | **1 session** |
| **P2** | **C3 + C4 — formula parse + organic/inorganic classifier (bundled)** | Replaces N3's Python-only gate decision with a hexa-native rule that any cohort can call. Two-function port. **Blocker**: depends on hexa-lang regex/string-iterator support — verify before scheduling. | ~110 | 1-2 sessions |
| **(no P3)** | — | N1 has 0 candidates. N2 has 0 new candidates (Allen-Dynes already in sim.hexa; only exposure work, not port). | — | — |

**Total Phase-4 capacity required** 2-3 sessions for the full microkernel batch (matches RTSC.md §9.9.1 "4-8 sessions for 4 cohorts" — Phase 3 audit revealed N1/N2 contribute zero new ports, so we land below that ceiling).

---

## Anti-pattern catches (false-microkernel rejections)

The following *looked* like microkernels but were rejected — porting them would violate RTSC.md §9.9.1 anti-pattern rules (ML weights / DB content / external-lib internals).

| Rejected candidate | File | Why it's NOT a microkernel |
|---|---|---|
| **`_poll_mp_cache` polymorph-min logic** | cross_code_dft.py:128-167 | Depends on the *content* of `material_cache/mp/*.json` from MP REST. Port = re-deriving MP DFT corpus = anti-pattern (db port). The MIN over polymorphs IS pure arithmetic but it's interleaved with `record.get("rows")` JSON walks → keep in Python wrap. |
| **AFLOW / OQMD JSON normalization** (`_poll_aflow`, `_poll_oqmd`) | cross_code_dft.py:211-354 | Pure data-massage on external lib output. Port = re-implementing AFLUX / OQMD response parsing → tracks upstream API changes = anti-pattern (wrap drift). Keep in Python. |
| **`_run_inference` BETE-NET shim** | beenet_adapter.py:221-267 | Wraps an e3nn/torch_geometric ensemble forward pass. Port = re-training the EGNN ensemble = anti-pattern (~10⁵ GPU-hour per RTSC.md §9.9.1 explicit). Even the "inference call" is not portable without the upstream Network class. |
| **CSP backend stubs** (`_run_backend_stub`) | csp_adapter.py:190-209 | Today it's a no-op stub. Once it gains real output parsing (Phase 2), the parser tracks AIRSS/USPEX/CALYPSO/OpenCSP wire formats — wrap-as-is mandate. Never port. |
| **ASKCOS retrosynthesis calls** (`_call_askcos_python`, `_call_askcos_docker`) | askcos_adapter.py:254-306 | Wraps ASKCOS TreeBuilder / Docker invocation. Port = re-training template DB on millions of reactions = anti-pattern (RTSC.md §9.9.1 explicit). |
| **`_compute_consensus` `hexa_rtsc` exclusion logic** | cross_code_dft.py:478-484 | This filter is correct per s4 caveat (algebraic ceiling ≠ DFT numeric) but the *exclusion rule* is policy, not math. Port the math (C1); keep the policy in the Python orchestrator that builds the `rows` list. |

---

## Honest g3 (RTSC.md §9.9.1 alignment check)

- **No over-identification** — final count is 4 candidates across 4 cohorts (P1 bundle of 2 + P2 bundle of 2). Below the "0-5 tight list" ceiling.
- **Cost/benefit per port** P1 (≤50 LOC, 1 session) provides hexa-native cross-validation of a formula already used elsewhere → strong justify. P2 (~110 LOC, 1-2 sessions, regex-blocked) replaces one Python dispatch path → moderate justify; defer if hexa-lang regex absent.
- **Zero-candidate cohorts are valid findings** N1 (CSP) and N2 (BEE-NET) contribute zero new ports — wrap stays as-is, no Phase 4 work for them. This is RTSC.md §9.9.1 "wrap 자체 port 금지" honored.
- **R4 invariant intact** None of the candidates change the `absorbed=false` invariant. Port moves *math* into hexa-native, not *measurement gate state*.
- **No changes to** producer source · `sim.hexa` · `RTSC.md` · `MP.md` (audit-only, as instructed).

---

## Anchors

- RTSC.md §9.9.1 Phase 3 (microkernel identification brief)
- RTSC.md §9.9.1 Phase 4 (Path A microkernel port — destination for the P1/P2 ports listed above)
- `stdlib/material/sim.hexa` (precedent — extend with consensus kernel as first non-Tc helper)
- N4 `_compute_consensus` matches the Nb attestation inverse-variance pattern already used elsewhere in this codebase (per `cross_code_dft.py:476` comment "Formula (matches Nb attestation in mp_query / sim_adapter)").

---

## Closure (2026-05-22)

**P1 LANDED** — `_compute_consensus` + `sigma_from_spread` ported to hexa-lang `stdlib/material/sim.hexa` v0.2.0 (commit `701bfe1b`).

Parity verify: **22/22 PASS** (10 cases · ≤1e-9 rel tolerance · max rel_err 3.93e-16 IEEE 754 floor). Evidence: [`2026-05-22-rtsc-9-phase4-1-parity-verify.md`](2026-05-22-rtsc-9-phase4-1-parity-verify.md).

P2 (C3+C4 ASKCOS parser+classifier) **DEFERRED** — hexa-lang regex stdlib API ✅ but runtime backend ❌ (broken stub, `hexa_regex_match` undeclared in `self/runtime.h`). Hand-rolled tokenizer alternative = ~280 LOC (P1 의 5.6×) → 외부 consumer 출현 시 재opens. Audit: [`2026-05-22-rtsc-9-phase4-2-prep.md`](2026-05-22-rtsc-9-phase4-2-prep.md).
