# Ambient-pressure superhydride wave — FROZEN-FIRST predictions (c16/c9)

Written BEFORE any new compute. No tune-to-green. An ambient dynamical
instability is a valid 🔴 result (c9), not a failure to hide.

Gate order (frozen, FLEET-DIAGNOSTIC lesson — do NOT fire el-ph on unstable cells):
  [1] vc-relax-tight @ press=0 → [2] ph DFPT + matdyn asr='crystal' (count imaginary modes)
  → [3] el-ph λ/Tc ONLY if 0 imaginary modes.

## LIVE compute candidates (P=0, no stability data yet)

### AcBeH8_ambient  (nat=10, 1Ac+1Be+8H, Fm-3m, 293K@1atm target axis)
- PREDICTION: LIKELY UNSTABLE @ 0 GPa. The BeH8 H-cage wants pressure; the
  AcBeH8 source paper (arXiv:2411.19028) reports Tc 181K only @ 10 GPa, and the
  deck itself carries a 10-GPa fallback. At true 1 atm I expect imaginary H-cage
  modes (>0 imaginary). Claimed Tc in literature: 181 K @ 10 GPa (NOT ambient).
- FALSIFIER: if matdyn shows 0 imaginary modes @ 0 GPa across the 2x2x2 q-grid,
  the ambient-stable hypothesis SURVIVES → promote to el-ph λ/Tc.

### CaB3C3_ambient  (nat=14, 2Ca+6B+6C, Pm-3n #223, MgB2-like covalent, NO hydrogen)
- PREDICTION: BORDERLINE-to-STABLE. Covalent B-C sigma framework (no soft H cage)
  is the strongest ambient-stability bet of the set; Zhu/Strobel (arXiv:1708.03483)
  argue MB3C3 is recoverable toward 1 atm. Expect 0 or few mild imaginary modes.
  No Tc claimed pre-DFT (g5/g6).
- FALSIFIER: hard imaginary modes (<-50 cm-1) @ 0 GPa → 🔴 ambient-unstable.

### LaB3C3_ambient  (nat=14, 2La+6B+6C, Pm-3n #223, La trivalent e-doping)
- PREDICTION: BORDERLINE. La (3+) electron-dopes the B-C sigma/pi bands
  (potentially higher λ than Ca) but the larger trivalent cation may strain the
  cage. Expect stability similar to CaB3C3 +/- soft modes. No Tc claimed pre-DFT.
- FALSIFIER: hard imaginary modes @ 0 GPa → 🔴.

## ALREADY-TERMINAL from existing data (NO new compute — promote-in-place)

### mg2irh6 (P=0, nat=9) — ALREADY 🔴 CLOSED-NEGATIVE
- Existing record rtsc_mg2irh6_partial5q_elph_20260526.json: 48% hard imaginary
  modes (<-50 cm-1) over q1-q5, min freq -113861 cm-1 (catastrophic). Verdict
  already RED_CLOSED_NEGATIVE. Re-firing el-ph = the documented FLEET waste.
  PROMOTE to terminal. polymorph = same Fm-3m soft-mode class.

### li2cuh6 (P=0, nat=9) — ALREADY 🔴 CLOSED-NEGATIVE
- Existing record rtsc_li2cuh6_partial2q_elph_20260527.json: 8 hard imaginary
  modes, min -944.9 cm-1, failed dynamical-stability gate 1 of 5. PROMOTE.

## OUT OF AMBIENT SCOPE (not P=0 — noted, not fired this wave)
- LaBeH8 (press=200 kbar=20 GPa), LaBH8 (500 kbar=50 GPa), KBeH8 (100 kbar=10 GPa).
  These are low-but-not-ambient; the wave goal is room-temp-at-1atm (P=0).
- CaBeH8 already terminal 🔴 (VERDICT.md, dynamically unstable).

## QFORGE cross-val: INFEASIBLE this wave
- sim/qforge_hybrid_lambda_tc.hexa DOES NOT EXIST in repo (searched). Cross-val
  only triggers post-el-ph anyway (requires surviving stability). Recorded honestly.
