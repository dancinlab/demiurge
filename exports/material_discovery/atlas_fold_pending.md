# atlas_fold_pending — PR-blocked atlas-binary register queue

Materials that are simulation-verified (DFT closed in this repo) but NOT YET registered in `compiler/atlas/embedded.gen.hexa` (atlas SSOT per d3 / d4 / memory `reference_atlas_register_direct_n6`). Atlas fold lands as a separate PR once the campaign branch merges to main.

| date_utc | material | verdict | gate | metric (verbatim) | record JSON | notes |
|---|---|---|---|---|---|---|
| 2026-05-26 | Mg₂IrH₆ (Fm-3m, 0 GPa) | 🔴 CLOSED_NEGATIVE | dynamical-stability (gate 1 of 5) FAILED | min_freq = −2235 cm⁻¹ across q1-q5/13; 48 % modes hard-imag (<−50 cm⁻¹); 65 hard soft modes; DOS(Eꜰ)=19.46 states/spin/Ry/cell · Eꜰ=10.95 eV; Tc = undefined (d6) | `exports/material_discovery/rtsc_mg2irh6_partial5q_elph_20260526.json` | first X₂MH₆ cation-VEC PRED falsification (Tc=160K PRED by PR #150 cation rule → falsified at dynamical-stability gate). Atlas fold = `material_verdict/mg2irh6_partial5q_v1` with absorbed=false (g63 closed-negative; R4 sim≠measured). |
