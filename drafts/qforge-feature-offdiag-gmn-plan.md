---
slug: qforge-feature-offdiag-gmn
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated · NATIVE CPU (no pod)
domain: QFORGE-FEATURE (demiurge) — metallic-wall breadth brick (b) off-diagonal |g_mn|
---

## task brief
CaH6 xval λ is broadening honestly (brick a #2488: 0.000170 vs QE 4.376) but the el-ph |g| path is
DIAGONAL-only (⟨ψ_n|ΔV|ψ_n⟩). Breadth brick (b): add the OFF-DIAGONAL inter-band matrix elements
|g_mn| = ⟨ψ_m|ΔV_bare|ψ_n⟩ (m≠n) — dominant in hydrides — into the el-ph sum with the correct
double-delta energy weighting (δ(ε_m−E_F)δ(ε_n−E_F)). Re-run the CaH6 xval and report the broader REAL
λ. Honest residual on the remaining 2 breadth items (real N(E_F)+k-mesh, screened ΔV) stays explicit.

## locked decisions
- @L1 (complete): extend the realcell |g| evaluation (realcell_phonon.hexa #2485 path) to compute the full m×n matrix |g_mn|=⟨ψ_m|ΔV_bare|ψ_n⟩ over occupied/active bands, not just m=n. New brick file e.g. stdlib/qforge/elph_offdiag.hexa (do NOT edit the merged realcell_phonon.hexa — compose). assert:file stdlib/qforge/elph_offdiag.hexa
- @L2 (complete): include the off-diagonal terms in λ with the Fermi-surface double-delta weight (Gaussian-smeared δ, reuse the verified qforge_gaussian_delta / a2f assembler). Reuse dvloc_du #2480 ΔV_bare + the metallic_a2f #2476 path; 0-diff existing files.
- @L3 (complete · g5): selftest — Hermiticity |g_mn|=conj(|g_nm|) · the off-diagonal contribution is NON-trivial (changes λ vs diagonal-only) · a known 2-band analytic anchor where Σ_mn is closed-form. Paste VERBATIM.
- @L4 (safe): NATIVE CPU only (CaH6 7 atoms), `nice -n 19` the xval (prior runs killed by CPU starvation). NO pod ops; live gate pods 38943553·38922322 untouched.
- @L5 (complete · d6 HONESTY): brick (b) of 4 — adds inter-band coupling, may still be outside 1% (real N(E_F)+k-mesh and screening remain). Report the real λ AS-IS (vs the diagonal-only 0.000170); do NOT force 4.376.
- @L6 (std): g4 <200 lines, 1 concern, stacked PR, self-merge. demiurge QFORGE-FEATURE.md metallic line → breadth state (brick b DONE · 2 remaining), cite PR.

## next-action checklist
- [ ] worktree off origin/main (`~/core/hexa-lang-offdiag-gmn`); HEAD = origin/main (e44519ad6 or newer)
- [ ] read realcell_phonon.hexa (#2485 diagonal |g_nn| path) + realcell_qmesh (#2488 ω(q,ν)) + dvloc_du (#2480) + metallic_a2f (#2476) + qforge_gaussian_delta
- [ ] build elph_offdiag.hexa (full |g_mn| matrix + double-delta weighted λ contribution)
- [ ] g5 selftest VERBATIM (Hermiticity · off-diag non-trivial · 2-band analytic anchor)
- [ ] re-run CaH6 xval (nice'd) with off-diagonal |g_mn| → REAL λ + rel-ε vs 4.376 VERBATIM
- [ ] PR <200 lines + g5 + self-merge; demiurge QFORGE-FEATURE.md breadth update, explicit-path commit
- [ ] ship

## completion criteria
- elph_offdiag.hexa lands + g5 PASS · CaH6 xval re-run with off-diagonal |g_mn| → broader REAL λ reported VERBATIM with honest residual (2 breadth items remain). Zero fabrication toward 4.376.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (native-CPU task). nice the run.
- d6/g63: brick (b)/4 — honest partial; broader-but-not-closed real λ is the valid deliverable.
- d9: isolated worktree · explicit paths · separate hexa-lang PR + demiurge commit.
- Sibling agents: a5cf752 owns assembler.hexa (GPU bench), adfed63 owns dft_dispatch.hexa (PROCESS). Do NOT edit the merged realcell_phonon.hexa/realcell_qmesh.hexa — compose via a new file. Stage only elph_offdiag.hexa + its test + the demiurge doc.
- plan-guard "without/forced/fabricat" false-positives EXPECTED; consistent with migration-plan @L4/@L5.
