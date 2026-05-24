# parity attempt — `scope + synthesize` (OpenMDAO segmented-primary sizing)

> **id**: `parity_attempt_scope_synth_2026-05-20` · **opened**: 2026-05-20 KST · **status**: `attempted — FAIL · do NOT flip absorbed`
> **substrate**: `~/core/hexa-lang/stdlib/scope/openmdao_sizing.py` (hexa-lang origin commit `08ad8983`; reads kernel from `stdlib/kernels/wave_optics/poppy_kernel.py`, hexa-lang commit `478629b2`)
> **versions**: `openmdao 3.39.0` · `poppy 1.1.1` · `numpy 1.26.4` · `astropy 6.0.1` · `python 3.9.6`
> **oracle**: closed-form hexagonal segmented-primary collecting area `A = N · (3√3/2) · a²` with `a = ftf/√3` (edge length); equivalently `A = N · (√3/2) · ftf²`
> **tolerance set in task**: ±2%
> **scope**: read-only on hexa-lang (substrate copied to `/tmp/...` for `import poppy_kernel` resolution; hexa-lang working tree untouched).

---

## ROI claim under test

`scope + synthesize` (ROI 4, ⭐⭐⭐⭐⭐): does the OpenMDAO-driven coupled optics×structure sizing reproduce a clean Pareto-frontier sanity check **and** match the analytic aperture-area formula within ±2% per shelf? If yes → flip `absorbed=true`. If no → file negative result, keep `measurement_gate = GATE_OPEN`.

---

## What ran

1. `python3 -m pip install --user openmdao` → `openmdao-3.39.0` installed.
2. `python3 /tmp/scope_synth_parity_kernel/scope/openmdao_sizing.py /tmp/scope_synth_parity_2248` → exit 0, JSON written.
   - **Why a `/tmp/` copy**: the substrate resolves the wave-optics kernel as `<script_dir>/../kernels/wave_optics/poppy_kernel.py`. On the local hexa-lang `s1-step2-codegen-perf` checkout, `stdlib/kernels/wave_optics/` is absent (the directory was added in hexa-lang commit `478629b2`, which is NOT on origin/main and NOT on the local working branch). To preserve the read-only constraint on `~/core/hexa-lang/`, the substrate was copied verbatim into `/tmp/scope_synth_parity_kernel/scope/` and the kernel extracted via `git show 478629b2:stdlib/kernels/wave_optics/poppy_kernel.py` into the sibling `/tmp/scope_synth_parity_kernel/kernels/wave_optics/`. The hexa-lang working tree was not modified.
3. SLSQP converged on all three shelves; substrate elected shelf=7 as winner (lowest J).

Full meta JSON: `/tmp/scope_synth_parity_2248/scope_synth_v1.meta.json`.

---

## Per-shelf parity (substrate `effective_area_m2` vs analytic hex-packing area)

| shelf (label) | POPPY rings → actual hex N | ftf [m] (converged) | D_eff [m] (substrate) | A_subst [m²] | A_analytic [m²]<br>(`N_label · √3/2 · ftf²`) | A_analytic_POPPY [m²]<br>(`N_poppy · √3/2 · ftf²`) | %parity vs labeled | %parity vs POPPY |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
|  7 | 1 → 7  | 0.5000 | 1.2990 |  1.3254 |  1.5155 |  1.5155 | **87.45 %** | **87.45 %** |
| 18 | 2 → 19 | 0.5000 | 2.1651 |  3.6816 |  3.8971 |  4.1136 | **94.47 %** | **89.50 %** |
| 36 | 3 → 37 | 1.3186 | 7.9939 | 50.1886 | 54.2114 | 55.7173 | **92.58 %** | **90.08 %** |

`A_subst = π·(D_eff/2)²` where `D_eff = (2·rings + 1) · ftf` (from `poppy_kernel.aperture_diameter_m`, kernel L98–L119) — confirmed numerically to exact equality.

**No shelf is inside ±2 %.** Worst miss: shelf=7 at 12.55 % low. Best miss: shelf=18 (labeled count) at 5.53 % low. Verdict: **FAIL parity gate**.

---

## Pareto-frontier sanity check

Driver behavior under the default scalarisation weights (`w_mass=0.01 · w_fwhm=1.0 · w_aper=0.2`) — the converged designs are:

```
shelf=7   ftf=0.5000 m (FLOOR)  D=1.299 m  FWHM=0.0840"  mass= 272.5 kg  J= 2.55  ← winner
shelf=18  ftf=0.5000 m (FLOOR)  D=2.165 m  FWHM=0.0538"  mass= 728.2 kg  J= 6.90
shelf=36  ftf=1.3186 m          D=7.994 m  FWHM=0.0875"  mass=5738.9 kg  J=55.88
```

Two-of-three shelves rail to the design-variable lower bound `ftf=0.50 m`. With this weighting, mass dominates and the optimum is "make the aperture as small as allowed", which is not a useful Pareto front — it is a corner solution against the box constraint. The 36-hex shelf does sit interior (`ftf ≈ 1.32 m`) but only because at small `ftf` its per-segment hardware mass (`36 × 20 kg = 720 kg`) already exceeds the 7-hex collecting-area benefit, so the optimizer moves outward against `W_FWHM`. This is **a single-evaluation optimum per shelf, not a Pareto sweep** — the substrate's docstring (`HONESTY (g3)` §1) already disclaims this.

---

## Root causes of the parity miss

1. **`effective_area_m2` is the bounding-disk area, not the hex-packed collecting area.** The substrate computes `A = π·(D/2)²` with `D = (2r+1)·ftf` from the kernel. That's the area of a disk circumscribing the flat-axis span of the hex lattice. The actual collecting area is the sum of segment areas, `N·(3√3/2)·a²` (Hardin & Sloane *hexagonal close packing*; Tatulli, E. & Le Bouquin, J.-B., *A&A* 511, A90, 2010 §3.1 for aperture-mask conventions). For ring r=1, the hex pack actually exceeds the `(2r+1)·ftf` bounding disk because the outer corners stick out past the flat-axis span (measured here: hex/disk ratio = 114.4 % / 111.7 % / 111.0 % for r=1/2/3). So the substrate **understates** collecting area by 7–12 %.
2. **Labeled segment counts disagree with POPPY's actual ring populations.** Substrate `SEGMENT_SHELVES = (7, 18, 36)`; POPPY's `MultiHexagonAperture(rings=r)` actually places `1 + 6·Σ(1..r)` = 7 / **19** / **37** hexes (kernel comment L75-77 documents this). The 18/36 labels are off-by-one in the outer ring. Under the corrected (POPPY-actual) hex count, the parity gap widens at shelf 2/3.
3. **Prompt's literal analytic constants are inconsistent.** Task text states "7-hex: A ≈ 5.196·s², 18-hex: A ≈ 13.36·s², 36-hex: A ≈ 26.71·s²" with `s = ftf/2`. Cross-check: `5.196 ≈ 3√3` is the area of *one* regular hexagon with edge `s` (not 7). And `13.36` / `26.71` are not integer multiples of any per-hex constant under either convention. Computing parity with the prompt's literal constants yields ~430 % at every shelf, which signals the prompt formula is garbled rather than the substrate being 4× off. The interpretation used above (`N · (√3/2) · ftf²`, the standard closed form on flat-to-flat) is the only physically self-consistent reading; under it, parity remains 87–94 %, still well outside ±2 %.

---

## Recommendation

**DO NOT flip `absorbed=true` for `scope + synthesize`.**

- Parity at the area-formula gate: **FAIL** (87.5 % / 94.5 % / 92.6 % vs ±2 % tolerance).
- The substrate's own `HONESTY` block (script L55–L77) already enumerates three independent reasons `absorbed=true` is BANNED here (back-of-envelope mass model, designer-chosen weights, no 2nd MDO consumer). This parity attempt adds a fourth: the area metric itself is bounding-disk, not collecting-area, and the labeled shelf counts mis-name the outer-ring populations.
- `measurement_gate` remains `GATE_OPEN` (consistent with substrate L62-L64).

## Suggested follow-ups (NOT done in this session)

These are pickups for whoever drives the next iteration; they require write access to `~/core/hexa-lang/` and are out of scope here.

- **(P1)** Rename `effective_area_m2` to `bounding_disk_area_m2` in the kernel return, and add a `collecting_area_m2 = N · (3√3/2) · a²` field computed alongside. The objective `J` should consume `collecting_area_m2` (it is what the `-w_aper · D` term morally rewards).
- **(P2)** Replace the `SEGMENT_SHELVES = (7, 18, 36)` labels with `(7, 19, 37)` to match POPPY's actual `(2r+1)`-ring populations, OR document the (7, 18, 36) ground-rule shelves explicitly and force the kernel to drop the outermost hex on rings ≥ 2.
- **(P3)** Lift the design-variable lower bound or re-weight `W_MASS / W_FWHM / W_APER` so the converged points stop railing to `ftf = 0.50 m` — the Pareto sanity check needs interior optima per shelf to be meaningful.
- **(P4)** Cross-check with Tatulli & Le Bouquin 2010 (*A&A* 511, A90) §3 multi-aperture combiner area conventions before claiming the closed-form A is "exact for ideal hex packing" — for an Aperture Mask Interferometry pipeline the effective area is convolved with the cophased-fraction sensitivity, which can shift the analytic target by 2-5 %.

---

## Artifacts (not checked into the demiurge worktree)

- `/tmp/scope_synth_parity_2248/scope_synth_v1.meta.json` (substrate output, 4.1 KB)
- `/tmp/scope_synth_parity_2248/scope_synth_v1.history.csv`
- `/tmp/scope_synth_parity_kernel/scope/openmdao_sizing.py` (verbatim copy of hexa-lang `08ad8983`)
- `/tmp/scope_synth_parity_kernel/kernels/wave_optics/poppy_kernel.py` (verbatim copy of hexa-lang `478629b2`)

These live under `/tmp/` and will not persist past reboot; the demiurge inbox carries only this note.
