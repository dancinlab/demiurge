# QFORGE hybrid assembler — CaH6 g5 RE-verify (2026-06-15) — ✅ PASS

**Deliverable #1** of the 2026-06-15 QFORGE cross-val (plan `drafts/qforge-update-plan.md` @L2b).
RE-verify that the QFORGE L3 α²F→λ assembler (mode b, hybrid QE|g|²→QFORGE) is still
**gate-grade / immediately-usable** by re-feeding the CaH6 QE el-ph anchor and confirming λ
reproduces the QE BZ-summed value to ≤1% (g5 threshold rel-ε ≤ 2.5e-3 also passed by 4 orders).

## what was run

- engine = hexa-native QFORGE assembler, `~/.hx/src/stdlib/qforge/assembler.hexa` + `elph.hexa`
  (`qforge_a2f_from_elph` deposit `qforge_gaussian_delta` + L2 integrator `qforge_a2f_lambda`).
- driver/test = `~/.hx/src/stdlib/qforge/qforge_cah6_qe_xval_test.hexa`
- anchor = CaH6 terminal QE `electron_phonon='simple'` 2×2×2-q el-ph (`.elph`, Im-3m sodalite,
  7 atoms, 150 GPa), the SAME RTSC campaign whose harvest lives under
  `exports/material_discovery/rtsc_cah6_*` / `exports/rtsc/CaH6/`. Fixtures byte-checked-in at
  `stdlib/qforge/fixtures/cah6_elph/`. Primary broadening = scf MP degauss 0.010 Ry.
- host = mini (local CPU, $0). cli = `/Users/mini/.hx/bin/hexa run`.

## VERBATIM result (g5 · NOT forced)

```
── parser: BZ-summed λ from raw QE CaH6 .elph bytes ──
PASS parsed λ_BZ=8.516825000000004 == QE 8.516825 (rel-ε=6.257109331471237e-16, 168 modes)
── QFORGE assembler: λ = 2∫α²F/ω from assembled α²F (σ_ph→0) ──
ng=1000 σ_ph=3.5390775845924667K  λ_QFORGE=8.516915071405924  rel-ε=1.0575702321566331e-05
PASS ng=1000 residual shrank (1.0575702321566331e-05 < 9.99)
ng=4000 σ_ph=0.88476939614811663K  λ_QFORGE=8.51683062702589  rel-ε=6.606952579835221e-07
PASS ng=4000 residual shrank (6.606952579835221e-07 < 1.0575702321566331e-05)
ng=8000 σ_ph=0.44238469807405831K  λ_QFORGE=8.51682640313096  rel-ε=1.647481262974376e-07
PASS ng=8000 residual shrank (1.647481262974376e-07 < 6.606952579835221e-07)
── L3 GATE: QFORGE α²F assembler vs QE λ_BZ, rel-ε ≤ 1% ──
PASS L3 |g|/α²F cross-val — QFORGE λ within 1% of QE 8.516825 (rel-ε=1.647481262974376e-07)
qforge_cah6_qe_xval_test PASS
```

Corroborating anchor — LaH10 (`qforge_lah10_qe_xval_test.hexa`):
```
PASS parsed λ_BZ=4.315662499999998 == QE 4.315662 (rel-ε=1.15857080060821e-07, 264 modes)
ng=8000 ... λ_QFORGE=4.31566404747444  rel-ε=4.7442882222247e-07
PASS L3 |g|/α²F cross-val — QFORGE λ within 1% of QE 4.315662 (rel-ε=4.7442882222247e-07)
qforge_lah10_qe_xval_test PASS
```

## verdict

- **VERDICT: ✅ PASS** — QFORGE hybrid assembler λ = 8.51682640 vs QE λ_BZ 8.516825,
  **rel-ε = 1.647e-7** (σ_ph→0 monotone-convergent, ng=8000). ≤ 1% L3 gate AND ≤ 2.5e-3 g5
  threshold both passed. LaH10 corroborates (rel-ε 4.74e-7). Matches the QFORGE.md ENGINE STATUS
  documented 1.65e-7 exactly.
- **scope (d6/c9)**: this is the **QE-moment → λ leg** (mode b). It does NOT validate a from-scratch
  QFORGE |g|² (mode c is HELD). It confirms the assembler is immediately usable as a gate-grade
  production path once QE DFPT moments exist. No number forced anywhere.
