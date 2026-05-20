# Parity attempt v2 — `scope + verify` (POPPY PSF verify producer, WebbPSF data installed)

**Date**: 2026-05-20
**Substrate SSOT**: `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py` (origin/main @ `08ad8983`)
**Kernel** (①a wave-optics): `~/core/hexa-lang/stdlib/kernels/wave_optics/poppy_kernel.py`
**Cohort**: empty-cell `scope + verify` (cohort-round, ROI 3, ⭐⭐⭐⭐⭐)
**Predecessor**: `parity_attempt_scope_verify_2026-05-20.md` (v1 — 4/5 PASS, WebbPSF check skipped on `$WEBBPSF_PATH` data absence).
**Goal of v2**: install WebbPSF reference data (~128 MB), set env, re-run → target 5/5 PASS.
**Outcome of v2**: **4/5 PASS still** — WebbPSF check now *runs* (data resolved), but fails on substrate-level **wavelength mismatch** (kernel @ 550 nm vs WebbPSF NIRCam @ 4.8 µm). Honest finding: env-data install was successful and necessary, but **insufficient** for 5/5; the 5th gate is gated on a substrate edit (one of: align wavelengths, widen tolerance with documented physical justification, or split the check).
**Verdict**: **DO NOT flip `absorbed=true`** (same as v1 — for the same g3 reasons plus the new finding that the WebbPSF check as currently authored cannot physically pass).

---

## 1. v2 run — WebbPSF data installed

### 1a. Install steps (this session)

```bash
# 1. Install webbpsf (now aliased to STPSF library) for python3.12.
/opt/homebrew/bin/python3.12 -m pip install --user --break-system-packages \
  webbpsf poppy synphot astropy
# resolved: webbpsf-2.0.0 (alias to stpsf-2.2.0)

# 2. Download STPSF reference data via the library's own helper:
/opt/homebrew/bin/python3.12 -c "import webbpsf; webbpsf.utils.auto_download_stpsf_data()"
# → fetched from STScI box.com, extracted to ~/data/stpsf-data
# size:  128 MB (well within budget)
# files: 33 entries — pupil masks, OPD maps, instrument config FITS

# 3. Export env (both names — webbpsf 2.x renamed but reads either):
export STPSF_PATH=/Users/ghost/data/stpsf-data
export WEBBPSF_PATH=/Users/ghost/data/stpsf-data
```

Smoke test of WebbPSF data wiring:
```python
import webbpsf
nrc = webbpsf.NIRCam()           # loads pupil + OPD FITS — OK
nrc.filter = 'F480M'             # 4.8 µm filter — OK
nrc.pixelscale                   # 0.06290713 arcsec — OK
```

### 1b. Substrate re-run (v2)

```bash
mkdir -p /tmp/scope_parity_run_v2/stdlib/{scope,kernels/wave_optics}
git -C ~/core/hexa-lang show origin/main:stdlib/scope/poppy_psf_verify.py \
  > /tmp/scope_parity_run_v2/stdlib/scope/poppy_psf_verify.py
git -C ~/core/hexa-lang show origin/main:stdlib/kernels/wave_optics/poppy_kernel.py \
  > /tmp/scope_parity_run_v2/stdlib/kernels/wave_optics/poppy_kernel.py
# (working tree is on s1-step2-codegen-perf branch — read-only extraction)

export STPSF_PATH=/Users/ghost/data/stpsf-data
export WEBBPSF_PATH=/Users/ghost/data/stpsf-data
/opt/homebrew/bin/python3.12 \
  /tmp/scope_parity_run_v2/stdlib/scope/poppy_psf_verify.py \
  /tmp/scope_verify_v2_run
```

Substrate emitted `SCOPE_VERIFY_RESULT`:
```json
{"all_required_passed": false, "n_passed": 4, "n_required": 5, "n_skipped": 0,
 "ok": false, "poppy_version": "1.1.2", "synphot_version": "1.7.0",
 "webbpsf_version": "2.2.0"}
```

5-check tally:
| # | Check | v1 | v2 | Note |
|---|---|---|---|---|
| 1 | `reproducibility_psf_sha_match` | PASS | **PASS** | sha = `08d1e98a3283b2bc` (twice, deterministic) |
| 2 | `diffraction_limit_within_20pct` | PASS | **PASS** | rel_err = 17.09 % (≤ 20 %) |
| 3 | `encircled_energy_monotonic` | PASS | **PASS** | EE(1") = 0.9895 ≤ EE(2") = 0.9938 ≤ EE(5") = 0.9985 |
| 4 | `webbpsf_cross_check` | FAIL (data missing) | **FAIL (wavelength mismatch)** | rel_err = 87.16 % (kernel 0.0201" @ 550 nm vs WebbPSF 0.1564" @ 4.8 µm) |
| 5 | `synphot_photometry_round_trip` | PASS | **PASS** | countrate = 1.0e7 / m² (finite, positive) |

---

## 2. The wavelength-mismatch finding (NEW in v2 — what env-data install exposed)

### 2a. Numbers

Kernel side (substrate constants in `poppy_psf_verify.py`, lines 99 + 130):
- `REF_WAVELENGTH_M = 550.0e-9` → λ = 550 nm
- Kernel-propagated FWHM = **0.020075 arcsec**

WebbPSF side (substrate constant `WEBBPSF_REF_WL_M`, line 267):
- `WEBBPSF_REF_WL_M = 4.8e-6` → λ = 4.8 µm (NIRCam F480M centre)
- WebbPSF NIRCam FWHM = **0.15641 arcsec**

Ratio: 0.15641 / 0.020075 ≈ **7.79×**.
Wavelength ratio: 4.8 µm / 550 nm = 8.73×.

Since FWHM ∝ λ (1.22 λ/D scaling for a circular aperture, same for a hex aperture in the diffraction-limited regime), the two FWHMs **cannot agree** within ±50 % — they differ by ~780 %, which is exactly what physics predicts for an 8.7× wavelength jump on the same aperture.

### 2b. Why the substrate forces this mismatch

NIRCam is an infrared instrument; its filter passbands all sit between ≈ 0.6 µm and 5 µm. The substrate header (lines 217–221) acknowledges this:

> closest NIRCam filter to 550 nm broad band model (real JWST has no 550 nm passband — F480M ≈ 4.8 μm is the documented closest test path; loose band is honest, g3)

The "loose band" is ±50 %. But physics dictates ~780 % drift purely from the λ scaling — so the ±50 % band is **not loose enough for a real NIRCam filter applied to a 550 nm kernel**. Loosening to ±900 % would render the check meaningless ("the WebbPSF FWHM is within an order of magnitude of the kernel FWHM" — true of any two PSFs).

Probing whether the kernel could be moved to 4.8 µm instead:
```python
nrc.calc_psf(monochromatic=550e-9, fov_arcsec=4.0)
# RuntimeError: The requested wavelengths are too short to be imaged with NIRCam
```
NIRCam refuses any λ below its bandpass floor — so the substrate cannot just run WebbPSF at 550 nm to fix the mismatch.

### 2c. What this finding is, and is not

It **is** a substrate design issue: check #4 as authored cannot physically PASS on a 550 nm kernel + NIRCam combination, regardless of how perfectly the WebbPSF data files are installed.
It **is not** a parity defect of the kernel or of POPPY: the kernel's 550 nm FWHM and the WebbPSF 4.8 µm FWHM are each individually correct for their wavelengths (1.22 λ/D scales them).
It **is not** what v1 found: v1 said "data files missing"; v2 says "data files installed, check now runs, and the physics of the comparison is incompatible with the ±50 % band the substrate publishes."

---

## 3. What a 5/5 PASS would require (substrate edits — **not** done here, g3 / cross-session safety)

Three orthogonal substrate-side options. None done in this session; flagged for `main session` triage if the cohort cell wants `verify` to GREEN end-to-end.

### Option A — align wavelengths (preferred, smallest)
Change `REF_WAVELENGTH_M` from 550 nm to a NIRCam-accessible wavelength (e.g. 4.8 µm to match F480M, or 2.0 µm to match F200W). One-line change in `poppy_psf_verify.py`. Side-effect: this is now a JWST-class verify, not a visible-light verify — re-frames what the analyze tool is signing off (which may or may not match the cohort cell's intent).

### Option B — split into two checks
- check #4a: WebbPSF NIRCam @ 4.8 µm vs an *independent* kernel propagation at 4.8 µm (kernel runs both 550 nm and 4.8 µm; ±50 % band applies to like-wavelength pair).
- check #4b: existing analytic diffraction limit at 550 nm (already check #2).

Larger refactor; adds a second kernel propagation; doubles runtime.

### Option C — replace check with same-instrument analytic verification
Drop the WebbPSF cross-check (it has fundamental honesty problems documented in the substrate header anyway — "different baffle/strut/OPD model") and replace with a hex-vs-circ aperture comparison (kernel @ 550 nm vs analytic Airy @ 550 nm, which is what check #2 already does at 17 % rel err). Net effect: 5-check → 4-check, all green, but the cohort cell loses the JWST cross-instrument signal.

### Option D — adopt physical-band tolerance
Widen `WEBBPSF_FWHM_REL_TOL` to ≈ 0.9 (or 9.0) with header note that this is "order-of-magnitude wavelength-corrected sanity, not a parity claim." Honest about being weak; preserves the check signal.

**No recommendation in this note** — option choice is a producer-design decision for the `main session`, not a parity-evidence finding.

---

## 4. Parity computation (unchanged from v1 — v2 didn't change the kernel)

(Identical to v1 §4, repeated here for self-contained reading.)

| Quantity | Substrate | Airy oracle | Δ | Parity |
|---|---|---|---|---|
| 1.22 λ/D first-null | 0.024214" | 0.024214" | 0 | **100.00 %** (bit-identical formula) |
| Measured FWHM (vs 1.028 λ/D true Airy FWHM) | 0.020075" | 0.020404" | 1.61 % | **98.39 %** |
| EE@first-dark-ring | not sampled (substrate samples r=1",2",5") | 0.8377 | N/A | not measurable |
| Label correctness: `fwhm_diffraction_limit_arcsec` stores 1.22 λ/D | — | — | — | mislabel — should be `airy_first_null_arcsec` (one-line rename — same finding as v1) |

---

## 5. Recommendation: **DO NOT flip `absorbed=true`**

Same as v1, with one additional reason.

1. **(g3, primary, unchanged)** Substrate header (lines 56–71) explicitly gates `absorbed=true` on:
   > (a) WebbPSF parity within ±X% on a JWST NIRCam commissioning hash, AND (b) a hexa-native FFT re-propagation matching POPPY to IEEE-754 — neither lands here.
   Neither condition is met. Even if check #4 PASSED, it would not satisfy (a) — a parametric MH aperture is not a flight commissioning hash.
2. **(v2-new)** Check #4 as currently authored has a **physical incompatibility** between the kernel wavelength (550 nm) and the WebbPSF instrument floor (≥ 600 nm-ish). A GREEN check #4 cannot happen without a substrate edit (§3). Until that edit lands, `verify` *intrinsically* tops out at 4/5 — by substrate design, not by parity defect.
3. **(g3, unchanged)** Aperture is parametric. `measurement_gate = GATE_OPEN`, `absorbed = false` is the substrate's permanent stance regardless of how many checks GREEN.
4. **(g3, unchanged)** The parity that **is** established (100 % formula identity + 98.39 % measured FWHM vs Airy oracle) is a strong signoff of the analyze tool, which is what `verify` claims to deliver.

---

## 6. What v2 changed vs v1 (operational delta)

| Aspect | v1 | v2 |
|---|---|---|
| WebbPSF library | `webbpsf-1.2.1` direct | `webbpsf-2.0.0` (alias to `stpsf-2.2.0`) |
| WebbPSF data files | absent | **installed** at `~/data/stpsf-data` (128 MB) |
| `$WEBBPSF_PATH` / `$STPSF_PATH` | unset | **both set** to `~/data/stpsf-data` |
| Check #4 status | FAIL (data missing — env reason) | FAIL (wavelength mismatch — physics reason) |
| 5/5 PASS achieved? | no | **no** — but for a different, more interesting reason |
| Substrate edits made? | none | **none** (cross-session safety — hexa-lang concurrent) |

The env-data install was **successful and necessary** progress — check #4 transitioned from "skipped/failed-loud due to missing files" to "ran with real WebbPSF data, found a substrate-physics incompatibility." That itself is parity-evidence value: this attempt **discovered a substrate design flaw** that v1 could not see because it could not get past the data-file gate.

---

## 7. Tooling artifacts (v2)

- Output dir: `/tmp/scope_verify_v2_run/`
- Meta JSON: `scope_verify_v1.meta.json`
- FITS witness: `scope_verify_v1.fits`
- Checks CSV: `scope_verify_v1.checks.csv`
- STPSF data: `~/data/stpsf-data/` (128 MB, persisted — future runs do not re-download)
- Extracted substrate copy: `/tmp/scope_parity_run_v2/stdlib/{scope,kernels/wave_optics}/` (origin/main, read-only — hexa-lang working tree is on `s1-step2-codegen-perf` and untouched)

---

## 8. Bottom line

| Metric | v1 | v2 |
|---|---|---|
| 5/5 PASS achieved | 4/5 (data missing) | **4/5** (wavelength-mismatch — physics) |
| 1.22 λ/D formula vs oracle | 100.00 % | 100.00 % |
| Measured FWHM vs true Airy FWHM | 98.39 % | 98.39 % |
| WebbPSF check would pass with no substrate change? | no (env-blocked) | **no (physics-blocked)** |
| Required for `absorbed=true` | g3-blocked | g3-blocked + new substrate-edit prerequisite |
| Recommendation | DO NOT FLIP | **DO NOT FLIP** |
| Net progress vs v1 | — | env-data installed (reusable); substrate flaw discovered |

**Bottom line**: 5/5 PASS not achieved. The env data install (intended remedy) was successful but exposed a **deeper, substrate-side issue**: check #4 is authored such that it cannot physically PASS on the current 550 nm kernel + NIRCam combination. Substrate edit needed — see §3 options A/B/C/D — flag for `main session`. Parity itself (kernel↔analytic-Airy) remains at 98.39 % on the physically-meaningful quantity (FWHM), unchanged from v1.
