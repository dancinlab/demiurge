# Parity attempt — `scope + verify` (POPPY PSF verify producer)

> status: **superseded** (v2 surfaced design flaw, v3 / D75 closed it at 5/5 PASS). v1 result: 4/5 PASS (WebbPSF env data missing).

**Date**: 2026-05-20
**Substrate SSOT**: `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py` (origin/main @ `08ad8983`)
**Kernel** (①a wave-optics): `~/core/hexa-lang/stdlib/kernels/wave_optics/poppy_kernel.py`
**Cohort**: empty-cell `scope + verify` (cohort-round, ROI 3, ⭐⭐⭐⭐⭐)
**Verdict**: **PARITY ESTABLISHED** within tolerance — but recommendation is **DO NOT flip `absorbed=true`** for g3 honesty reasons (see §5 below).

---

## 1. Run

```bash
python3 -m pip install --user poppy webbpsf synphot astropy
python3 /tmp/scope_parity_run/stdlib/scope/poppy_psf_verify.py /tmp/scope_verify_parity_2061
```

Substrate emitted `SCOPE_VERIFY_RESULT`:

```json
{"all_required_passed": false, "n_passed": 4, "n_required": 5, "n_skipped": 0,
 "ok": false, "poppy_version": "1.1.1", "synphot_version": "1.3.post0",
 "webbpsf_version": "1.2.1"}
```

5-check tally:
| # | Check | Result | Note |
|---|---|---|---|
| 1 | `reproducibility_psf_sha_match` | PASS | sha = `f7f529e559ffd6d2` (twice) |
| 2 | `diffraction_limit_within_20pct` | PASS | rel_err = 17.09 % (≤ 20 %) |
| 3 | `encircled_energy_monotonic` | PASS | EE(1") ≤ EE(2") ≤ EE(5") |
| 4 | `webbpsf_cross_check` | **FAIL** | `$WEBBPSF_PATH` not set — data files not installed |
| 5 | `synphot_photometry_round_trip` | PASS | countrate = 1.0e7 / m² (finite, positive) |

Check #4 fails for an honest environment reason (WebbPSF instrument data files require a separate 300 MB download from STScI, not a `pip install`). The substrate intentionally fails-loud rather than skip when `webbpsf` imports successfully but data is missing — that's the correct g3 honesty stance, not a parity defect.

---

## 2. Substrate measurements (reference aperture)

JWST-class 18-segment MultiHexagonAperture, 1.32 m flat-to-flat, λ = 550 nm.

| Quantity | Value |
|---|---|
| Effective diameter `D_eff` | 5.7158 m |
| Wavelength `λ` | 550 nm |
| FOV | 12 arcsec |
| Pixel scale (oversampled) | 0.010 arcsec |
| FWHM measured | **0.020075 arcsec** |
| FWHM "diffraction limit" (substrate label, = 1.22 λ/D) | 0.024214 arcsec |
| Strehl proxy | 0.7858 |
| Total intensity captured | 0.9969 |
| EE @ r = 1" | 0.9895 |
| EE @ r = 2" | 0.9938 |
| EE @ r = 5" | 0.9985 |
| PSF SHA-256 (16-prefix) | `f7f529e559ffd6d2` |

---

## 3. Airy oracle (analytic, closed-form)

Citations:
- **Born & Wolf** *Principles of Optics* 7th ed. §8.5.2 — Airy disk for a circular aperture.
- **Bracewell** *Fourier Transform and Its Applications* — circular-aperture FT pair.
- **Perrin, Sivaramakrishnan, Lajoie et al.** "Simulating point spread functions for the James Webb Space Telescope with WebbPSF", *PASP* 124:1267 (2012) / **Astropy POPPY** notes ApJ 2013 — POPPY reference implementation.

Closed-form values at our (λ, D):
| Quantity | Formula | Value |
|---|---|---|
| First null half-angle | θ₁ = 1.22 λ/D | **0.024214 arcsec** |
| **True Airy FWHM** | 1.028 λ/D (full-width half-max of `[2 J₁(x)/x]²`) | **0.020404 arcsec** |
| EE at first dark ring | 1 − J₀²(3.8317) − J₁²(3.8317) | 0.8377 |

---

## 4. Parity computation

### 4a. Substrate's stated diffraction limit vs Airy first-null
- substrate `fwhm_diffraction_limit_arcsec` = 0.024214 arcsec
- oracle 1.22 λ/D                          = 0.024214 arcsec
- **parity = 100.0000 %** (formula is exact — bit-for-bit identity, no numerical loss).

### 4b. Substrate's MEASURED FWHM vs TRUE Airy FWHM (1.028 λ/D)
- substrate `fwhm_measured_arcsec` = 0.020075 arcsec
- oracle 1.028 λ/D                 = 0.020404 arcsec
- |Δ| / oracle                     = 1.61 %
- **parity = 98.39 %** (well inside ±10 % tolerance, even tighter than the substrate's own ±20 % band).

### 4c. EE comparison — N/A for this geometry
EE@first-dark-ring (analytic 0.8377) cannot be compared directly: substrate samples EE only at r ∈ {1", 2", 5"}, all ≫ first-null (0.024"). At those radii EE → 1.0 (total captured energy in FOV). The monotonicity check is valid for what it measures (CDF property) but the substrate does not report EE@first-ring. **Parity@EE: not measurable from current outputs.** Improving this would require adding `r_first_ring_arcsec` to the kernel's EE radii list.

### 4d. Label correctness — finding worth flagging
The substrate field `fwhm_diffraction_limit_arcsec` stores 1.22 λ/D, but 1.22 λ/D is the **first-null half-angle**, not the FWHM. True Airy FWHM = 1.028 λ/D. This is a labelling defect, not a numerical defect — the value is correct for what it computes, and the measured FWHM (0.020075") is actually a better match to the true Airy FWHM (98.39 %) than to the labelled 1.22 λ/D (82.91 %). Fix is one-line: rename field to `airy_first_null_arcsec` or split into both quantities.

---

## 5. Recommendation: **DO NOT flip `absorbed=true`**

### Reasons (in order of weight)
1. **(g3, primary)** The substrate's own header (lines 56–71) explicitly states:
   > `absorbed=true` would require: (a) WebbPSF parity within ±X% on a JWST NIRCam commissioning hash, AND (b) a hexa-native FFT re-propagation matching POPPY to IEEE-754 — neither lands here.
   Neither condition is met. WebbPSF cross-check failed (data files missing), and there is no hexa-native FFT yet.
2. **WebbPSF check failed loud** — not because of substrate logic, but because the `$WEBBPSF_PATH` data bundle is not installed in this environment. Even if installed, the substrate uses ±50 % tolerance because the WebbPSF baffle/strut/OPD model differs from MultiHexagonAperture; that loose band is honest, not a parity claim.
3. **Aperture is parametric**, not absorbed flight data. `measurement_gate = GATE_OPEN`, `absorbed = false` is the substrate's documented permanent stance regardless of how many checks GREEN.
4. **The parity that IS established** (100 % formula identity + 98.39 % measured FWHM vs Airy oracle) is a strong *signoff of the analyze tool*, which is exactly what the substrate's `verify` verb claims to deliver — not a discovery / absorption.

### What WOULD justify a flip (future work)
- Install WebbPSF data files (`$WEBBPSF_PATH`), re-run, see check #4 PASS → still not enough for absorbed; only proves WebbPSF/POPPY agree on a parametric aperture.
- Add a commissioning-PSF FITS reference (e.g. a published NIRCam in-flight calibration PSF) and compare hash-stable percentile bands. That would be `scope + absorb`, a different cohort cell.
- Provide a hexa-native FFT implementation and require IEEE-754 bit-equivalence on the same complex aperture — that closes the kernel-side of the parity loop.

---

## 6. Tooling artifacts
- Output dir: `/tmp/scope_verify_parity_2061/`
- Meta JSON: `scope_verify_v1.meta.json` (86 lines)
- FITS witness: `scope_verify_v1.fits`
- Checks CSV: `scope_verify_v1.checks.csv`
- Extracted run dir: `/tmp/scope_parity_run/stdlib/{scope,kernels/wave_optics}/` (origin/main copies, used because `~/core/hexa-lang` working tree is on a different branch — read-only extraction, no hexa-lang side-effects).

---

## 7. Bottom line

| Metric | Value | Tolerance | Verdict |
|---|---|---|---|
| 1.22 λ/D formula vs oracle | 100.00 % | ±10 % | PASS (exact) |
| Measured FWHM vs true Airy FWHM | 98.39 % | ±10 % | PASS |
| EE@first-ring vs 0.8377 | N/A | ±10 % | not measured |
| WebbPSF cross-check | FAIL | env-driven | NOT a parity issue |
| Required for `absorbed=true` | g3-blocked | substrate's own gate | DO NOT FLIP |

**Recommendation**: leave `absorbed=false` (substrate is honest about this — see header lines 60–62). File this note as **parity-attempt evidence** demonstrating that the analyze→verify loop closes correctly on the analytic oracle to within 1.61 % on the physically-meaningful quantity (FWHM), and flag the label-defect on `fwhm_diffraction_limit_arcsec` for a one-line rename in a future commit.
