# QFORGE-FEATURE — work log (append-only)

## 2026-06-02 — domain created · seeded from migration-gate campaign gaps
- Created as the FORWARD capability backlog for QFORGE (QE-independent el-ph engine + dispatch toolchain). Sibling of QFORGE-PROCESS (process observability) and QFORGE-PERF (GPU/perf track).
- Seeded the backlog from gaps surfaced during the 2026-06-01/02 QFORGE migration-gate campaign:
  - **engine**: correlation-XC functional (PZ81/PW92) — screening.hexa is Hartree+LDA-exchange only · real-q metallic α²F beyond M5.8 Γ-only Einstein · NVPTX GPU hot-kernels · in-engine q-star symmetry reduction.
  - **dispatch**: dft-run corrupt-recover salvage (DONE #2459/2460) + proxy scp-fallback (DONE #2451/2453) + HostPort-lag orphan guard (filed 9e2347d6) + true resume-in-place (.save bank) + per-stage telemetry → QFORGE-PROCESS.
  - **verify**: one-shot 3-anchor cross-val harness (CaH6·LaH10·Li2MgH16).
- Boundary kept explicit: bugs/defects → `hexa-lang/inbox/patches/` (d8); this file = forward features only.
- migration default-flip stays HELD (d6/@L4) until correlation-XC + real-q metallic λ + 3-anchor cross-val all close.

## 2026-06-02 — metallic-wall breadth brick (c) DONE — real N(E_F) k-mesh DOS (hexa-lang PR#2491)
- Built `stdlib/qforge/dos_nef.hexa` — REAL Fermi-level DOS `N(E_F)=Σ_k w_k Σ_b δ_σ(ε_{k,b}−E_F)` over a Monkhorst-Pack k-mesh, replacing the placeholder `n_ef=1.0` + Γ-only single-k electronic sum. Surface: `qforge_dos_nef` (explicit weights) + `qforge_dos_nef_uniform` (1/nk uniform). d19 reuse: `elph.qforge_gaussian_delta` (same normalized δ_σ as the el-ph double-δ) + `mpgrid.qforge_mp_grid` (k-mesh). d4: eps[k·nbands+b] flat, material-agnostic, 0-diff to brick (d)'s `realcell_phonon.hexa`.
- g5 STRONG PASS (`dos_nef_selftest.hexa` `qforge_dos_nef_selftest PASS`, 5 axes): (1) metallic N(E_F)>0 · (2) flat-band limit N(E_F)=δ_σ(0)=1/(σ√2π) nk-INDEPENDENT + placeholder reduction to 1.0 (d4) · (3) k-mesh convergence MONOTONE (linear band |N_est−1/v| 4→8→16→32 = 0.499→0.310→0.0106→1.3e-8, n32 <1%) · (4) `_uniform`≡explicit weights · (5) guard sentinels.
- CROSS-VAL (d6/g63 VERBATIM, NOT tuned): real CaH6 metallic-cell |g| path (bricks a/b/d) NOT yet on origin/main → only in-repo SCF cell is the toy 7-PW free-electron system. Drove `orchestrator_pw` atoms→λ chain: `n_ef=1.0` → λ=0.04076 (rel-ε 0.990686); real **N(E_F)=7.97885** (4×4×4 MP, σ_el=0.05) → **λ=0.00510851** (rel-ε vs QE 4.376 = **0.998833**). λ ratio 0.125331 == 1/N(E_F) EXACTLY (Allen-1972 1/N(E_F) normalizer confirmed).
- VERDICT = PARTIAL (brick DONE/g5 · λ-closure not reached): N(E_F) is now a genuine k-mesh BZ-summed DOS feeding the correct 1/N(E_F) physics; absolute CaH6 λ needs the real CaH6 SCF cell + real-|g| (bricks a/b/d) on origin/main, NOT a different N(E_F). 4.376 NOT forced.
- Breadth status: (a)✅#2488 · (b)✅#2490 · (c)✅#2491 · (d)⬜ Sternheimer-screened ΔV_scf remains. cite: hexa-lang PR#2491 (merge 12cd3cf05).
