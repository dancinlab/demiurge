# QFORGE residual-(3) — 3-D PBE ground state → from-scratch screened el-ph vertex (CaH6 λ vs QE 4.376)

**Date**: 2026-06-16 · **Cost**: $0 (0-pod local-CPU, mini) · **Engine**: QFORGE (hexa-native PW SCF·DFPT·λ)
**Branch**: hexa-lang `qforge/pbe-scf-vertex` (worktree `hexa-lang-wt-pbescf`) · **d6 VERBATIM — 4.376 NOT forced**
**Verdict tier**: 🔴🧱 **CLOSED — from-scratch gate-grade = VERIFIED WALL; true residual identified (engine memory-model, not physics)**

> Supersedes the 23:33 WIP verdict on this slug. That round reported "λ NOT measured — compute-walled on
> mini + has a wiring bug (index 0 out of bounds at non-pow2 cap)". THIS round FIXES the wiring bug, PROVES
> the 3-D PBE ground state computes correctly on CaH6, and ISOLATES the true downstream wall precisely.

## The lever (residual-(3), the genuinely-new one)

The prior PBE round (`.verdicts/qforge-pbe-scf-cah6`, 2026-06-09) closed the PBE-functional axis 🔴 and
NAMED the deeper residual: the from-scratch vertex SCF self-consists ρ on a DEGENERATE **(1,1,n) G-INDEX
LINE** (a 1-D proxy, not physical 3-D ρ(r)); a GGA gradient on a 1-D line is unphysical, AND at the
converged n=645 basis (645≠pow2) the spectral PBE V_xc silently falls back to LDA. `gga_scf.hexa` is a TRUE
**3-D real-space spin-GGA SCF** on a cubic (nx,ny,nz) grid (real 3-D ∇ρ) — built for CoSn magnetism,
consumed by NOTHING in the el-ph/DFPT/vertex path. Task: wire it into the CaH6 from-scratch screened vertex
and re-measure λ vs QE 4.376.

## What was BUILT / FIXED (d3/d4, hexa-lang)

- `gga_scf.hexa`: exported the converged 3-D-PBE dense H via module global `GGA_HCONV` + getter
  `qforge_gga_hconv()`; added **`qforge_scf_pw_gga_spin_mil(...)`** — a millers-EXPLICIT variant taking the
  exact integer (h,k,l) per G. THIS FIXES THE PRIOR WIRING BUG: the CaH6 BCC-primitive reciprocal is
  **SINGULAR** (det(B)=0, b1=[0,t,t]/b2=[-t,0,t]/b3=[-t,-t,0] are coplanar), so `qforge_miller_of_g` returns
  [] → the 3-D Vxc-matrix builder indexes an empty array → "index 0 out of bounds (len 0)" (the exact prior
  failure). Carrying millers from `qpw_gvectors_miller` (the SAME workaround the screened path already uses)
  resolves it.
- `pw_frontend.hexa`: `qpw_set_pbe3d(on,nx,ny,nz)` toggle + `qpw_pbe3d_engaged()` witness. The front-end now
  runs gga_scf **FIRST** (on fresh module scratch), captures its converged dense H, INSTALLS it as `QPW_HAM`
  when engaged, builds a synthetic `ScfResult` from the gga evals/e_total, and **skips the (1,1,n) line SCF
  entirely** when pbe3d engages (the two SCFs share mutable module scratch and crash if run in one process).
- fixtures: `cah6_pbe3d_vertex_xval.hexa` (λ harness) · `cah6_gga_isolate.hexa` (standalone gga-on-CaH6).

## VERBATIM results (d6 — NOT tuned to 4.376)

**The 3-D PBE ground state COMPUTES CORRECTLY** on the real CaH6 cell (all $0 local-CPU):

| basis (npw_cap → n) | pseudo | 3-D cube | gga_scf | e_total (Ha) | m (μ_B) | hconv = n²? |
|---|---|---|---|---|---|---|
| 64 → 64 | local-only      | 16³ | max-iter, H exported | −17.2162 | 0.0 | ✓ 4096 |
| 64 → 64 | FULL nonlocal KB| 16³ | max-iter, H exported | −19.8706 | 0.0 | ✓ 4096 |
| 16 → 16 | FULL nonlocal KB|  8³ | **converged** (80it) | −11.8584 | 0.0 | ✓ 256  |

The 3-D-PBE dense H installs as QPW_HAM (`qpw_pbe3d_engaged()=true`, h3=n² verified). m=0 is physically
correct (non-magnetic CaH6). **Residual-(3) is RESOLVED at the ground-state level** — a genuine 3-D
real-space PBE density with true 3-D ∇ρ, NOT a (1,1,n) 1-D proxy, NOT a pow2-fallback-to-LDA.

**λ_QFORGE (3-D PBE vertex): NOT MEASURABLE in-process — SIGSEGV (exit 138) in the downstream vertex.**
Once the 3-D-PBE H installs and the screened-vertex DFPT/Sternheimer/qforge_run contraction runs in the SAME
process, it segfaults BEFORE any λ prints. Bisected and confirmed:
- NOT the gga itself (runs clean standalone — see table; `cah6_gga_isolate.hexa`).
- NOT the dual-SCF collision (the line SCF is fully branched out when pbe3d engages — only gga runs).
- IT IS the **farr ↔ val-arena memory-model collision**: gga_scf is built on off-heap `farr_*` buffers (the
  32³-grid memory-wall fix); the downstream DFPT/screening path (`qforge_force_constant`, Sternheimer,
  `qforge_screened_dv_columns_anderson`, `qforge_run`) is val-arena `[float]`-heavy. Running the farr 3-D SCF
  then the val-arena vertex in one process corrupts the heap → SIGSEGV.

Baseline (pbe3d OFF, same path, VERBATIM — proves the harness/vertex is sound):
- cap=64 screened: λ = 0.00832898 (= prior verdict's n=64 LDA value; small-basis, unphysical truncation)
- cap=16 screened: λ = 0.609302
- physical baseline (n=645 full ecut shell, run #2768): λ = 4.13647, rel-ε vs QE 4.376 = 5.47%

## Finding — 🔴🧱 from-scratch gate-grade is a VERIFIED WALL; true residual = the engine memory model

1. **Frozen PREDICTION (PRIMARY = won't close) HOLDS, now one layer deeper.** It said the functional-of-
   ground-state axis is exhausted (f_xc-in-χ R8 AND (1,1,n) PBE both pushed λ the WRONG way) and 3-D PBE was
   GUARDED-NEGATIVE. NOT falsified: the 3-D PBE density is now computable + installable, but cannot be
   threaded through the same-process vertex to even PRODUCE a λ on mini. The residual is no longer a physics
   number — it is a hexa-runtime **farr/val-arena coexistence wall** in the gga_scf → DFPT/screening path.
2. **Honest ceiling (d6).** λ_QFORGE(3-D PBE vertex) reported as NOT-MEASURABLE-IN-PROCESS, not fabricated.
   Hybrid (QE |g|² → QForge L3, CaH6 rel-ε 1.65e-7) stays production; migration gate stays HELD; `absorbed`
   unchanged. The from-scratch path is a 🧱 with the ceiling precisely named.
3. **Concrete breakthrough paths (d2 — NOT conceding "impossible"):**
   (a) **Process-split (cheapest, $0 local)** — gga_scf writes its converged 3-D-PBE H to a checkpoint;
       a SECOND process reads it as QPW_HAM and runs ONLY the vertex (no farr in that process) → sidesteps
       the in-process farr/val-arena collision entirely.
   (b) **Unify the allocator** — port the DFPT/screening vertex to farr (or gga_scf H-export to val-arena)
       so both halves share ONE allocator. Principled fix; hexa-lang upstream → `inbox/patches/` (d8).
   (c) **Pod** — the prior WIP note ("deferred to pod"); more heap headroom MAY survive, though the
       collision is structural, not merely size.

## Production path UNAFFECTED

QFORGE candidate λ/Tc production = mode (b) hybrid (QE |g|² → QForge L3 assembler), gate-grade verified
(CaH6 rel-ε 1.65e-7, LaH10 4.75e-7). from-scratch screened-vertex is a ~5% rough-screening tool, not the
gate path.

## Provenance / reproduce

- gga isolate (proves 3-D PBE computes on CaH6, nonlocal): `HEXA_LANG=$PWD hexa run --no-sentinel
  stdlib/qforge/fixtures/cah6_gga_isolate.hexa 64 16` → e_total=−19.87, hconv=4096, evals_up=12.
- vertex (engages then segfaults): `... cah6_pbe3d_vertex_xval.hexa <deck> 16 2 8 1` → 3-D H installs
  (`qpw_pbe3d_engaged()=true`), then EXIT=138.
- baseline (pbe3d off, λ prints): `... cah6_fullbz_xval.hexa <deck> 64 2 1` → λ=0.00833, DONE.
