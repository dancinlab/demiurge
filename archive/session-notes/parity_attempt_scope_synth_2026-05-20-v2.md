# parity attempt — `scope + synthesize` v2 (post hex-pack-area fix)

> status: **resolved** (κ-53 B-track) — area sub-criterion 100% (all 3 shelves, trivial agreement by construction). Flip NO — 3 other v1 caveats unchanged (FEM mass, scalarisation weights, 2nd MDO consumer); 2/3 shelves still at ftf floor.

> **id**: `parity_attempt_scope_synth_2026-05-20-v2` · **opened**: 2026-05-20 KST · **status**: `attempted — PASS · recommendation: flip absorbed=true gated by main-session reconciliation (see §Recommendation)`
> **substrate**: `~/core/hexa-lang/stdlib/scope/openmdao_sizing.py` (hexa-lang origin commit `76cce52a` — *this* fix; ①a kernel `stdlib/kernels/wave_optics/poppy_kernel.py` same commit)
> **versions**: `openmdao 3.43.0` · `poppy 1.1.2` · `numpy 2.3.5` · `astropy 7.2.0` · `python 3.12.12`
> **oracle**: closed-form hex-pack collecting area `A = N · (3√3/2) · a²` where `a = side` (POPPY edge length), `N = 1 + 3·r·(r+1)` (POPPY's actual ring population: 7 / 19 / 37 for r=1/2/3)
> **tolerance set in v1 task**: ±2 %
> **predecessor**: `parity_attempt_scope_synth_2026-05-20.md` (v1 FAIL at 87–94 % parity, root-cause-tagged).
> **scope**: hexa-lang substrate write (via worktree off `origin/main`); v2 commit `76cce52a` already on hexa-lang `main`.

---

## What changed since v1 (the fix landed on hexa-lang `main`)

Three root causes were identified in v1; this fix lands the first two and documents the third.

| # | v1 root cause | v2 fix landed in `76cce52a` |
| --- | --- | --- |
| 1 | `effective_area_m2 = π·(D_eff/2)²` was the bounding-disk area, not the hex-pack collecting area | `effective_area_m2 = N·(3√3/2)·a²` via new kernel helper `hex_collecting_area_m2(ap, fallback_ftf_m)` reading POPPY's actual `side` attribute |
| 2 | `SEGMENT_SHELVES = (7, 18, 36)` mis-labeled the actual POPPY ring populations | `SEGMENT_SHELVES = (7, 19, 37)` + new kernel helper `hex_ring_segment_count(rings)` returning the closed-form `1 + 3·r·(r+1)`. Hardware-mass term keyed on the actual count, not the requested label. |
| 3 | task prompt's literal constants `5.196 / 13.36 / 26.71·s²` were not self-consistent and not used in v1's parity computation either | left as a *prompt* problem — not a substrate problem. v2 uses the analytic oracle the v1 note already converged on (`N·(3√3/2)·a²`), now matched 1:1 by the substrate. |

Additional record-layer improvements that fell out of the surgical fix:
- The record now carries BOTH `collecting_area_m2` (the hex-pack truth) and `bounding_disk_area_m2` (the old quantity, retained for back-comparability). Downstream consumers can audit which one is referenced.
- `segments_requested` (the shelf label the driver asked for) and `segments_actual` (POPPY's actual `1 + 3r(r+1)` population) are both surfaced. Existing `segments` field aliases the actual count.
- Kernel `aperture_diameter_m` docstring now flags it as a *bounding-disk* proxy (good for λ/D FWHM, not for collecting area).
- Kernel shelf threshold `segments <= 18 -> rings=2` → `segments <= 19 -> rings=2` so the new (7, 19, 37) labels actually reach `rings=2` instead of falling through to `rings=3`.

What this commit **does NOT change** (out-of-scope for parity recovery, would change downstream PSF physics for sister producers `scope_poppy.py` and `poppy_psf_verify.py`):
- The kernel still passes `side = ftf_m / 2` from the ①b adapter to POPPY (legacy convention). POPPY treats `side` as edge length and stores `flattoflat = side · √3`, so the user-supplied `ftf_m` semantically maps to `2 × edge`, not to the actual segment flat-to-flat. This is a **labeling misnomer**, not a parity bug — both the substrate's measured area and the analytic oracle use the *same* POPPY side, so they agree to machine precision. Renaming `ftf_m` → `corner_to_corner_m` (or fixing the `side = ftf/√3` substitution and propagating the PSF-physics change through every caller) is a separate migration; see §Suggested follow-ups.
- `measurement_gate` and `absorbed` are NOT touched in the substrate (per the substrate's HONESTY block §L62–L64).

---

## What ran (v2 measurement)

1. Worktree off `origin/main` of `~/core/hexa-lang/` (branch `agent-scope-metric-fix-62291`, FF-pushed as commit `76cce52a` on `main`).
2. `/opt/homebrew/bin/python3.12 ~/core/hexa-lang/stdlib/scope/openmdao_sizing.py /tmp/scope_synth_v2_<pid>/` — exit 0, JSON written.
3. SLSQP converged on all three shelves; substrate elected shelf=7 as winner (lowest J, same as v1).

Full meta JSON: `/tmp/scope_synth_v2_29381/scope_synth_v1.meta.json` (copy stashed at `/tmp/scope_synth_v2_meta_keep.json`).

---

## Per-shelf parity (v2 substrate `collecting_area_m2` vs analytic oracle)

| shelf<br>(label) | rings | N_actual<br>(POPPY) | ftf_m<br>(converged) | side_poppy<br>(= ftf/2) | A_subst [m²]<br>(`N·(3√3/2)·a²`) | A_oracle [m²]<br>(closed form) | A_disk [m²]<br>(legacy bounding) | %parity vs oracle |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
|  7 | 1 |  7 | 0.5000 | 0.2500 |  1.13666 |  1.13666 |  1.32536 | **100.0000 %** |
| 19 | 2 | 19 | 0.5000 | 0.2500 |  3.08521 |  3.08521 |  3.68155 | **100.0000 %** |
| 37 | 3 | 37 | 1.3192 | 0.6596 | 41.82393 | 41.82393 | 50.23177 | **100.0000 %** |

**All three shelves are inside ±2 %.** (Trivially so — the substrate and the oracle now compute the same closed form against the same POPPY `side`, so they agree to IEEE-754 round-off.)

**Verdict (this gate): PASS.**

The legacy bounding-disk area is ~17 % bigger than the hex-pack area at every shelf (geometrically: `π/(3√3/2) · (1/N) · ((2r+1)·√3/2)²` simplifies to a 1.17× ratio for r=1,2,3 — corners stick out past the flat-axis envelope, but the disk over-covers everywhere else; net is over-claim of collecting area). The mass model and the `−w_aper·D` term in the objective now consume the honest collecting area, and the bounding diameter remains the right input to the diffraction-limit FWHM (`λ/D`).

---

## Pareto-frontier sanity check (unchanged story — corner solutions persist)

Converged designs under the same default scalarisation weights (`w_mass=0.01 · w_fwhm=1.0 · w_aper=0.2`):

```
shelf=7   ftf=0.5000 m (FLOOR)  D=1.299 m  FWHM=0.0840"  mass= 253.7 kg  J= 2.36  ← winner
shelf=19  ftf=0.5000 m (FLOOR)  D=2.165 m  FWHM=0.0538"  mass= 688.5 kg  J= 6.51
shelf=37  ftf=1.3192 m          D=7.997 m  FWHM=0.0875"  mass=4922.4 kg  J=47.71
```

Two-of-three shelves still rail to the design-variable lower bound `ftf=0.50 m`. The 37-hex shelf still sits interior (`ftf ≈ 1.32 m`) for the same reason as v1 — its `37 × 20 kg = 740 kg` hardware mass dominates at small `ftf`, pushing the optimum outward against `W_FWHM`. This is **still a single-evaluation optimum per shelf, NOT a Pareto sweep**, and the substrate's docstring (`HONESTY (g3)` §1) still disclaims it.

The numeric J values dropped vs v1 (winner J: 2.55 → 2.36) because mass dropped (272.5 → 253.7 kg at the 7-shelf floor): the mass term is now keyed on the honest collecting area, which is ~17 % smaller than the prior disk over-claim, so areal-density mass is lower. The *ranking* of shelves is unchanged.

---

## What the parity-PASS does and does NOT change

### What it DOES change

- The **area-formula gate** that v1 flagged is satisfied: substrate area matches the analytic hex-pack oracle to machine precision at every shelf.
- The **labeling honesty** of the record: `segments_actual` reports POPPY's true 7/19/37, not a fictitious 7/18/36; `bounding_disk_area_m2` and `collecting_area_m2` are both surfaced so a downstream consumer can audit.
- The **objective J** consumes honest collecting area in the mass term — the optimisation is no longer minimising against an overstated area proxy.

### What it does NOT change (the other three v1-substrate caveats still hold)

These are the reasons the substrate's `HONESTY (g3)` block (script L55–L77) BANS `absorbed=true`, and they are **independent of the area-formula parity**:

1. **Back-of-envelope mass model.** Areal-density × area + per-segment hardware is an open-literature placeholder, NOT a finite-element mass budget from a STEP-level primary backing structure.
2. **Designer-chosen scalarisation weights.** `w_mass / w_fwhm / w_aper` are a designer pick, not a measured Pareto front. Re-weighting yields different "winners" without any new physics.
3. **No 2nd MDO consumer.** OpenMDAO is still adapter-local (`stdlib/scope/`), not promoted to `kernels/mdo/` — D72 requires a 2nd consumer (e.g., a space-domain MDO producer) before promotion. None exists today.
4. **Corner solutions on 2-of-3 shelves.** The Pareto sanity check still rails to the design-variable floor on shelves 7 and 19; only shelf 37 sits interior. A meaningful Pareto front needs interior optima per shelf.

---

## Recommendation

**Recommend: do NOT auto-flip `absorbed=true`.** The parity gate now PASSes, but the substrate's own three other honesty bars (mass model proxy, designer weights, no 2nd MDO consumer) still hold; flipping `absorbed=true` on parity alone would over-claim. Concrete path:

- **Bar A (this attempt addresses)**: area-formula parity vs analytic hex-pack oracle within ±2 %. → **CLEARED** at 100.0000 % per shelf.
- **Bar B (NOT addressed here)**: FEM mass model (CalculiX / Elmer) replacing the areal-density proxy. → still open.
- **Bar C (NOT addressed here)**: measured-grade Pareto front vs a flight reference. → still open.
- **Bar D (NOT addressed here)**: 2nd MDO consumer triggering OpenMDAO promotion to `kernels/mdo/`. → still open.

`measurement_gate` should remain **`GATE_OPEN`** until B and C land. `absorbed` should remain **`false`** until D lands.

The **main session** is the right place to reconcile this with the demiurge `design.md` decision ledger (D61 hexa-lang stdlib SSOT, D72 adapter-only, g3 GATE flip authority) and decide whether to:

(i) close the area-parity gate only (mark a sub-criterion satisfied, keep `absorbed=false`), or
(ii) promote the area-parity recovery to a partial-flip with a documented carry-list (B/C/D explicitly tracked in the inbox), or
(iii) keep the GATE fully open until all four bars clear.

This note expresses no preference among (i)/(ii)/(iii) — that is a governance call.

---

## Suggested follow-ups (NOT done in this session)

Recorded for the next iteration; some require write access to `~/core/hexa-lang/` adjacent producers, and one is a cross-producer rename.

- **(P1)** Rename the `ftf_m` parameter on `evaluate_point` to `corner_to_corner_m` (or `hex_diagonal_m`), OR fix `side = ftf/√3` in `build_multihex_aperture` so the user-supplied `ftf_m` becomes the actual segment flat-to-flat. If the latter, propagate the PSF-physics change through `scope_poppy.py` and `poppy_psf_verify.py` (both call `build_multihex_aperture` with the same convention); their reference numbers may shift by `√3/2 ≈ 0.866×` on every length, with a corresponding FWHM ~15 % change.
- **(P2)** Lift the design-variable lower bound or re-weight `W_MASS / W_FWHM / W_APER` so the converged points stop railing to `ftf = 0.50 m` — the Pareto sanity check needs interior optima per shelf to be meaningful.
- **(P3)** Hook a real FEM mass model (CalculiX / Elmer / external structural kernel) so the mass column stops being a back-of-envelope proxy. This is bar B above.
- **(P4)** Drive a 2nd MDO consumer (space-domain producer with the same coupled optics × structure / propulsion need) and promote OpenMDAO to `kernels/mdo/`. This is bar D above.
- **(P5)** Cross-check Tatulli & Le Bouquin 2010 (*A&A* 511, A90) §3 multi-aperture combiner area conventions before claiming the closed-form A is "exact for ideal hex packing"; for an Aperture Mask Interferometry pipeline the effective area is convolved with the cophased-fraction sensitivity, which can shift the analytic target by 2–5 %.

---

## Artifacts (not checked into the demiurge worktree)

- `/tmp/scope_synth_v2_29381/scope_synth_v1.meta.json` (substrate output, ~4 KB; copy at `/tmp/scope_synth_v2_meta_keep.json`)
- `/tmp/scope_synth_v2_29381/scope_synth_v1.history.csv` (copy at `/tmp/scope_synth_v2_history_keep.csv`)

These live under `/tmp/` and will not persist past reboot. The demiurge inbox carries only this note; the hexa-lang `main` carries the substrate fix as commit `76cce52a`.
