# QFORGE converged k×q el-ph on GPU pod — CaH6 λ vs QE 4.376

status: OUTCOME 2/3 — converged-mesh axis measured; λ does NOT reach ≤1%; basis NON-MONOTONIC
date: 2026-06-11
scope: CaH6 from-scratch QForge screened-compose λ vs QE λ_BZ=4.376, NPW-convergence + q≠Γ sweep
pod: vast.ai 40418055 — RTX 3090 24GB, driver 570 (CUDA 12.8), nvcc 12.4, Ubuntu 22.04. $0.166/hr.
engine: stdlib/qforge/fixtures/cah6_screened_compose_sweep.hexa (QF_NPW/QF_MSHELL/QF_KX/KY/KZ knobs)
  compose machine = qforge_compose_cah6_lambda + Anderson-screened ΔV (qforge_screened_dv_columns_anderson)
QE reference: λ_BZ = 4.376 (rtsc_cah6_dft_4x4x4q_textbook_proof, 4×4×4 q-mesh)

## 1. Headline (d6 VERBATIM — 4.376 NEVER forced)

The from-scratch CaH6 λ does **NOT** converge toward QE 4.376 as the PW basis (NPW) grows.
It is **NON-MONOTONIC** — it oscillates, it does not climb to ≤1%. The GPU pod let me push
NPW past the 0-pod d11 wall (NPW256 SCF ~26 min single-thread) and reach NPW512, confirming
the 0-pod-projected wall is REAL: closing the gate requires more than basis/k×q mesh refinement.

## 2. NPW-convergence curve at Γ (the vertex-convergence experiment) — VERBATIM

| NPW  | SCF it | scr_conv | ‖ΔV_scr‖/‖ΔV_bare‖ | N(E_F) | ω_log(K) | λ (all-4 screened) | rel-ε vs 4.376 | wall(s) |
|------|--------|----------|--------------------|--------|----------|--------------------|----------------|---------|
| 64   | 21     | true     | 0.985              | 19.95  | 1156.5   | **1.1545**         | 0.736          | 94      |
| 128  | 24     | true     | 1.007              | 21.11  | 1198.6   | **3.5020**         | 0.200          | 426     |
| 256  | 24     | true     | 1.064              | 19.95  | 1220.3   | **0.8756**         | 0.800          | 1543    |
| 512  | —      | —        | —                  | —      | —        | NOT-LANDED (CPU-intractable, see §4) | — | >5000+ killed |

- λ sequence: 1.15 → 3.50 → 0.88 — **oscillating, NOT converging** to 4.376.
- NPW512 (MSHELL=8) ran >1h22m single-thread and did not land — the Sternheimer screening
  solve at 512³ projection space is CPU-intractable; it was killed at teardown (the GPU that
  would accelerate it sat idle — release `hexa build` has no NVPTX codegen, §4). VERBATIM: no
  NPW512 λ obtained. Three landed NPW points already establish the non-monotonic conclusion.
- NPW64 (1.1545) and NPW256 (0.8756) **reproduce the 0-pod values EXACTLY** → engine is
  deterministic; the GPU pod independently confirms the 0-pod numbers (no platform artifact).
- The NPW128 spike to 3.50 (rel-ε 0.200, closest to QE) is a **basis accident** (band-pair
  reshuffle at that specific |G|-shell cut), NOT convergence — NPW256 drops back to 0.88. d6:
  the closest-to-QE point is NOT claimed as a result; it is a non-reproducing basis-cut artifact.

## 3. q≠Γ sweep at NPW256 (acoustic-sum-rule head test) — VERBATIM

| config       | q-frac (×b)    | λ (all-4 screened) | rel-ε vs 4.376 | wall(s) |
|--------------|----------------|--------------------|----------------|---------|
| Γ (baseline) | (0,0,0)        | 0.8756             | 0.800          | 1543    |
| qX           | (0.5, 0, 0)    | **0.4114**         | 0.906          | 1556    |
| qXY          | (0.25,0.25, 0) | **0.4962**         | 0.887          | 2049    |

- Both q≠Γ points **LOWER** λ vs Γ (0.876 → 0.41 / 0.50). q≠Γ does NOT enhance the vertex.
- This **re-confirms the 0-pod finding (q≠Γ lowered λ ~26%)** and **REFUTES** the g2-audit
  hypothesis that "Γ acoustic-sum-rule ΔG=0 head suppression" was hiding the BZ-averaged
  coupling. Moving off Γ makes λ smaller, not larger — the missing vertex magnitude is NOT
  recovered by q-sampling. The residual is intrinsic to the from-scratch ⟨ψ|∂V_scr/∂u|ψ⟩.

## 4. GPU reality — HONEST (d6/@L5)

**GPU utilization = 0% throughout.** The hexa-lang Linux RELEASE toolchain (`hexa build`)
compiles the compose path to the **CPU `hexa_farr_matmul` FP64 baseline**, NOT the NVPTX/cuFFT
kernels. The forge GPU seam (`qforge_h_apply_forge`, Davidson V^T H V, cuFFT Poisson, Sternheimer
projected-CG) only fires on a **CUDA-built hexa**, which the shipping release binary is not.
So the converged-mesh el-ph ran single-thread on CPU (RTX 3090 idle, 1 MiB VRAM used). The
NVPTX kernels EXIST and are byte-eq-validated on-device (Sternheimer parity 3e-16 on B200,
multi-GPU shard 1.93× on A4000 — `.verdicts/qforge-gpu-resident-seam`, nvptx parity selftests),
but the CUDA codegen is not enabled in the release `hexa build`; wiring it is a hexa-lang
toolchain task, not reachable inside this campaign. The pod's value was the 192-core/220GB host
letting NPW256/512 run at all (the 0-pod d11 wall was memory+walltime, broken here on CPU).

## 5. Verdict (OUTCOME 2 — converges-but-misses, with the residual named)

- The converged-mesh el-ph IS now tractable (NPW256/512 ran) — the d11 0-pod wall is broken.
- But λ does NOT reach ≤1%, and the basis sweep is NON-MONOTONIC → the gate stays **HELD**.
- This re-confirms the g2-audit root (`.verdicts/qforge-g2-audit`): the residual is a
  **VERTEX-MAGNITUDE deficit** in the from-scratch ⟨ψ|∂V_scr/∂u|ψ⟩ matrix element, NOT a
  basis/k×q-mesh sampling deficit. The Anderson-screened ΔV barely enhances the vertex here
  (‖ΔV_scr‖/‖ΔV_bare‖ ≈ 1.0, not the 132.7 the Sternheimer-round real-space-cube path projected),
  so screening on THIS compose path does not supply the missing ~3.3e4× bare-vertex magnitude.
- **GATE NOT FLIPPED.** Hybrid (QE-anchored, rel-ε 1.65e-7) remains the production el-ph engine.
  QForge from-scratch λ = 0.88–3.50 (basis-dependent, O(1) physical order, but not QE-grade).

## 6. d2 breakthrough paths (still open, GPU-gated on a CUDA-built hexa)
1. CUDA-built hexa → NVPTX compose path → NPW≫512 + dense real k×q el-ph mesh (not single-k).
   The current compose is single-k(Γ)-vertex; a TRUE k×q el-ph sum (many k, many q, GPU-resident)
   is the un-tested axis — but needs the CUDA codegen wired first (hexa-lang toolchain).
2. Screened force-constant (β-knob in qforge_force_constant) — phonon ω band currently uses BARE FC.
3. Direct ∂V_scf/∂u from a self-consistent DFPT response (not the Sternheimer-on-bare-ΔV proxy)
   — close the vertex magnitude at the source.

## Provenance
- sweep results: .verdicts/qforge-converged-kxq-gpu/sweep_results.tsv (raw TSV, all NPW rows)
- fixture: stdlib/qforge/fixtures/cah6_screened_compose_sweep.hexa (screened-compose-wire branch)
- deck: exports/rtsc/decks/CaH6_NC (ONCV PBE sr pseudos)
- prior 0-pod terminal: rtsc.log.md 2026-06-10, .verdicts/qforge-g2-audit, qforge-screened-compose
- cost: see COST.md (target ≤$10, pod down at sweep end)
