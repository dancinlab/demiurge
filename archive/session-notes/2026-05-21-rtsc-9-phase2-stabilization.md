# RTSC §9.9.1 Phase 2 Stabilization Audit — 4 N-cohort producers × 4 baseline compositions

> Anchor: `RTSC.md §9.7 (N1-N4)` + `§9.9.1 Phase 2 stabilization brief`
> Date: 2026-05-21
> Inputs: 4 producers under `/Users/ghost/core/hexa-lang/stdlib/material/{csp_adapter,beenet_adapter,askcos_adapter,cross_code_dft}.py`
> Outputs: `/tmp/phase2/<producer>/<comp_slug>/*.json` (16 records emitted)

---

## 1. 16-cell PASS / DEVIATION matrix

| producer            | Nb                                | MgB₂                              | YBa₂Cu₃O₇                          | Claim-only RT-SC (anonymized · 2026-05-22 aggressive scrub)             |
|---------------------|-----------------------------------|-----------------------------------|------------------------------------|------------------------------------|
| csp_adapter.py      | PASS · install-gated              | PASS · install-gated              | PASS · install-gated               | PASS · install-gated               |
| beenet_adapter.py   | PASS · install-gated              | PASS · install-gated              | PASS · install-gated               | PASS · install-gated               |
| askcos_adapter.py   | PASS · domain-mismatch¹           | PASS · domain-mismatch            | PASS · domain-mismatch             | PASS · domain-mismatch             |
| cross_code_dft.py   | PASS · simulation-only-prediction | PASS · simulation-only-prediction | **DEVIATION** · insufficient-sources² | PASS · insufficient-sources       |

Total: 15/16 PASS · 1 DEVIATION · 0 FAIL · 0 crash.

Footnotes:
1. **Nb on askcos**: task brief said "Nb=elemental, may not match family list." Empirical observation: `Nb` is in the explicit `_INORGANIC_SC_HINTS` allow-list in `askcos_adapter.py:181` ("Nb3Sn, Nb3Ge, NbTi, Nb"), so it hits `domain-mismatch` via explicit-hit branch (rationale "explicit hit on RTSC §8.2 SC family (Nb)"). This is an **honest skip** — the gate is the right gate, just routed through allow-list rather than no-carbon heuristic. NEW finding: deviation from the task brief's prediction, not from the producer's contract.
2. **YBa₂Cu₃O₇ on cross_code_dft**: task brief said "consensus expected" but only `mp_cache` returned a value (1 source) — AFLOW + OQMD returned empty data lists (graceful skip, no `poll_errors`). Net gate: `insufficient-sources`. DEVIATION from expectation, but **honest behavior** — the producer correctly refuses to claim consensus from a single source. The expectation in the task matrix likely assumed AFLOW would have YBCO; in practice the public AFLOW AFLUX endpoint for cuprate compositions returns empty rows for `Egap_fit`/`enthalpy_formation_atom` queries with multi-species filters (or 'DB Fail!null', which the producer treats as a graceful skip).

---

## 2. N4 consensus values table

Property polled: `formation_energy` (eV / atom).

| composition | gate_type                     | sources returned (n) | consensus value (eV/atom) | σ        | rel_err_max pairwise | published reference                      |
|-------------|-------------------------------|----------------------|---------------------------|----------|----------------------|-------------------------------------------|
| Nb          | simulation-only-prediction    | mp_cache, oqmd (2)   | **0.000**                 | 0.0968   | 0.000 %              | Elemental Nb ≡ 0 by definition (PASS)     |
| MgB₂        | simulation-only-prediction    | mp_cache, oqmd (2)   | **−0.176**                | 0.0499   | 20.4 %               | DFT-PBE ~ −0.17 to −0.20 eV/atom (PASS)   |
| YBa₂Cu₃O₇   | insufficient-sources          | mp_cache (1)         | —                         | —        | —                    | mp_cache alone: −2.177 eV/atom (informative) |
| Claim-only RT-SC | insufficient-sources          | none (0)             | —                         | —        | —                    | claim-only hypothetical — no DFT corpus entry (expected PASS) (anonymized 2026-05-22) |

Cross-validation:
- **Nb**: published elemental reference energy = 0 eV/atom (definition of formation energy). Producer reproduces this exactly via both MP cache (6 rows, mean σ 0.149) and OQMD (10 rows, mean σ 0.127). Consensus σ 0.097 is tight.
- **MgB₂**: -0.176 eV/atom is consistent with published DFT-PBE values for MgB₂ (Materials Project mp-763: ~−0.179 eV/atom; OQMD: ~−0.140 eV/atom, the source of the 20% spread). The producer surfaces the spread honestly via `rel_err_max_pairwise=20.4%` — a downstream consumer should treat this as a wider-than-default sigma signal. OQMD's σ of 1.076 (computed from intra-source spread of 9 polymorph rows) appropriately downweights it in the inverse-variance mean.
- **YBCO**: mp_cache singleton reports −2.177 eV/atom for the YBa₂Cu₃O₇ orthorhombic O7 phase, which matches published −2.1 to −2.2 eV/atom DFT values for the orthorhombic O7 phase. But the producer correctly refuses consensus with n=1.
- **Claim-only RT-SC**: zero sources → `insufficient-sources` is the honest verdict (the slot is hypothetical and not in any standard DFT corpus). R4 invariant holds. (Anonymized 2026-05-22 aggressive scrub.)

---

## 3. R4 invariant audit

**Result: 0 / 16 records have `absorbed=true`.** All 16 emitted records carry `absorbed: false`.

```
absorbed_true_count: 0
absorbed_false_count: 16
critical_violations: 0
```

R4 invariant holds across the entire matrix. No exceptions.

---

## 4. Honest blocker enumeration

Discovered during the 16-cell sweep, ranked by severity:

1. **AFLOW endpoint coverage gap (medium)** — `https://aflow.org/API/aflux/` does not return entries for compositions outside the LIB1-LIB6 prototype library (cuprate-family YBCO, and the claim-only RT-SC slot — anonymized 2026-05-22). The producer's graceful-skip path (`returns DB Fail!null` → row=None) is correct, but it means **AFLOW contributes 0 of 4 cells to consensus** in this matrix. For Nb / MgB₂ the matrix achieved consensus via mp_cache+OQMD alone; for YBCO it dropped to `insufficient-sources` purely because AFLOW absented itself. Phase 2 → Phase 3 work: consider adding a 3rd DFT source (e.g., NOMAD, JARVIS-DFT) to harden the consensus path against single-source AFLOW dropout.

2. **OQMD spread amplification on intermetallics (low-medium)** — OQMD returned 9 polymorph rows for MgB₂ with computed intra-source σ of 1.076 eV/atom (vs default 0.05). This honestly down-weights it in the consensus but masks the question of which polymorph is the "correct" reference. mp_cache uses the minimum-formation-energy polymorph (most stable); OQMD averages. Inconsistent aggregation rule across sources is a Phase 2 stabilization candidate. NEW finding.

3. **ASKCOS package-name uncertainty (low)** — `askcos_adapter.py` tries `askcosv2`, `askcos`, `askcos_site` (3 candidate import names). v2 entry-point is "still in flux upstream (2026-05)" per the adapter's own comment. For the 4-cell domain-mismatch path this didn't matter (we never tried to call ASKCOS), but the moment any organic composition lands the wrap-as-is path will need to pin to a specific upstream commit.

4. **ASKCOS heuristic correctness for elemental Nb (informational)** — the brief said "Nb may not match family list," but `Nb` IS in the inorganic-SC allow-list. The producer routes via explicit-hit, which is honest (Nb is metallic, ASKCOS would hallucinate organic routes for it). This is a NEW finding worth recording: the task brief's prediction was wrong but the producer was right. No fix needed; the matrix entry is documentation drift, not producer drift.

5. **BETE-NET install footprint (medium-high)** — beenet_adapter.py's `_REQUIRED_IMPORTS` list (`torch`, `torch_geometric`, `torch_scatter`, `torch_cluster`, `e3nn`, `ase`, `pymatgen`) plus an out-of-tree weight checkout (`BETE_NET_ROOT`) plus notebook-shaped upstream API (`notebooks/Pred_CSO.ipynb`, no stable library surface) — even with all imports satisfied, the adapter would still surface a `weights-missing` skip with the "B-path violation (porting, not wrapping)" reason at `_run_inference:252-261`. **Honest blocker: BETE-NET cannot be invoked from a thin adapter without effectively porting the notebook.** This is documented in scope_caveats but worth flagging as a Phase 3 blocker.

6. **CSP heaviness (informational)** — all 4 CSP backends (AIRSS / USPEX / CALYPSO / OpenCSP) require external DFT engines (CASTEP / VASP / QE) for any meaningful run. The wrap-as-is presence-only acknowledgment is appropriate for first land; **actual search-launch is Phase 3+ multi-hour-compute territory**.

7. **No DEMIURGE_DFT_HEAVY_RUN exercise (intentional)** — Path 2 (QE/ABINIT subprocess via pool CLI) was NOT exercised in this matrix. The task spec explicitly excluded heavy-run-not-opted-in territory. Records correctly carry `heavy_run_opted_in: false`.

---

## 5. Phase 2 → Phase 3 readiness verdict per producer

| producer            | Phase 3 ready? | reasoning                                                                                                          |
|---------------------|----------------|--------------------------------------------------------------------------------------------------------------------|
| csp_adapter.py      | **YES**        | All 4 cells honest-skip via `install-gated`; backend_probe dict cleanly surfaces airss/uspex/calypso/opencsp absence. Microkernel candidate: phase-diagram convex-hull stability (per §9.9.1 Phase 3 brief). Ready for microkernel identification once a real CSP run lands. |
| beenet_adapter.py   | **PARTIAL**    | All 4 cells skip cleanly, BUT Phase 3 microkernel candidate (Allen-Dynes post-process from α²F) already lives in `sim_adapter.allen_dynes_tc` — so the kernel is already promoted. What remains: a stable upstream BETE-NET inference path (currently blocked on notebook-shaped upstream, see blocker #5). Phase 3 work: paper-trail the existing kernel + wait for upstream to stabilize. |
| askcos_adapter.py   | **YES (constrained)** | All 4 cells correctly emit `domain-mismatch` — the inorganic-SC heuristic is doing its job. For Phase 3 microkernel identification (retrosynthesis score aggregation), we need at least one organic composition exercising the live ASKCOS path, which is OUTSIDE the SC material domain. Ready for cohort hand-off; not in scope for the SC-cohort microkernel work. |
| cross_code_dft.py   | **YES**        | 2/4 cells achieved real consensus (Nb, MgB₂) with reasonable values. 1/4 (YBCO) honestly dropped to insufficient-sources due to AFLOW coverage gap. 1/4 (claim-only RT-SC slot) honestly dropped to insufficient-sources with 0 reachable sources. Inverse-variance consensus formula (Nb attestation pattern) is already a ≤ 20-line closed form and is a strong Phase 3 microkernel candidate per §9.9.1 brief. Recommend promoting `_compute_consensus` to a shared hexa-native kernel. |

**Overall Phase 3 entry verdict**: csp + cross_code_dft are ready immediately for microkernel identification. askcos is ready for cohort hand-off (out of SC scope for kernel work). beenet is blocked on upstream stability (independent of our producer code).

---

## 6. Per-cell record paths (audit trail)

```
/tmp/phase2/csp/Nb/material_verify_csp_20260521T140145Z.json              (install-gated)
/tmp/phase2/csp/MgB2/material_verify_csp_20260521T140147Z.json            (install-gated)
/tmp/phase2/csp/YBa2Cu3O7/material_verify_csp_20260521T140148Z.json       (install-gated)
/tmp/phase2/claimonly/material_verify_csp_20260521T140149Z.json          (install-gated · 5th cell anonymized 2026-05-22)
/tmp/phase2/beenet/Nb/material_verify_beenet_20260521T140158Z.json        (install-gated)
/tmp/phase2/beenet/MgB2/material_verify_beenet_20260521T140159Z.json      (install-gated)
/tmp/phase2/beenet/YBa2Cu3O7/material_verify_beenet_20260521T140200Z.json (install-gated)
/tmp/phase2/claimonly/material_verify_beenet_20260521T140201Z.json       (install-gated · anonymized 2026-05-22)
/tmp/phase2/askcos/Nb/material_verify_20260521T140207Z.json               (domain-mismatch)
/tmp/phase2/askcos/MgB2/material_verify_20260521T140208Z.json             (domain-mismatch)
/tmp/phase2/askcos/YBa2Cu3O7/material_verify_20260521T140210Z.json        (domain-mismatch)
/tmp/phase2/claimonly/material_verify_askcos_20260521T140211Z.json       (domain-mismatch · anonymized 2026-05-22)
/tmp/phase2/cross_code_dft/Nb/material_verify_20260521T140216Z.json       (simulation-only-prediction · consensus=0.000±0.097, n=2)
/tmp/phase2/cross_code_dft/MgB2/material_verify_20260521T140223Z.json     (simulation-only-prediction · consensus=−0.176±0.050, n=2)
/tmp/phase2/cross_code_dft/YBa2Cu3O7/material_verify_20260521T140225Z.json(insufficient-sources · n=1)
/tmp/phase2/claimonly/material_verify_crosscode_20260521T140239Z.json    (insufficient-sources · n=0 · anonymized 2026-05-22)
```

All exit codes = 0 (honest-skip producers exit 0 even on skip per RTSC.md §9.9.1 Phase 1 contract).

---

## 7. Closure

Phase 2 stabilization audit complete. **R4 invariant intact** (0 absorbed=true). **Honest skip paths verified consistent** across 4 producers × 4 compositions. **Phase 3 microkernel-identification entry approved** for csp_adapter, cross_code_dft (immediate); askcos (cohort hand-off, out of SC scope); beenet (blocked on upstream, kernel already exists in sim_adapter).

Single DEVIATION from the test-matrix expectation (YBCO cross_code_dft consensus → insufficient-sources due to AFLOW coverage gap) is honest behavior of the producer; the matrix expectation in the task brief assumed AFLOW would have YBCO data, which it does not as of 2026-05.
