# Parity attempt — `scope + verify` (v3, D75 Option B)

> status: **5/5 PASS** — D75 Option B (split into two checks @ same wavelength) closes the gate-of-honesty. `absorbed=true` flip still requires the substrate's other caveats (parametric aperture vs flight data, hexa-native FFT IEEE-754) — out of scope for this round.

- date: 2026-05-20
- substrate: `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py`
- substrate fix landed: hexa-lang `origin/main` `03470762`
- env: poppy 1.1.2 · webbpsf 2.2.0 · stpsf-data 128 MB at `~/data/stpsf-data`

## 1. What changed (D75)

`check_webbpsf_cross_same_wavelength` replaces the legacy
`check_webbpsf_cross`. The new check does two propagations:

1. NIRCam F480M PSF at 4.8 μm via WebbPSF (unchanged).
2. **A second `poppy_kernel.propagate_psf` call at the SAME 4.8 μm.**

Both FWHMs are now at the same wavelength, so the ±50 % tolerance
reflects optics differences (baffle / strut / OPD) instead of the
λ ratio. The 550 nm analytic Airy check stays on check #2
(`diffraction_limit_within_20pct`) — instrument-independent and
unaffected.

## 2. v3 result

| check | passed | rel err / note |
|---|---|---|
| `reproducibility_psf_sha_match` | ✅ | bit-identical re-propagation |
| `diffraction_limit_within_20pct` | ✅ | 1.61 % vs Airy first-null (550 nm) |
| `encircled_energy_monotonic` | ✅ | EE strictly increasing across r=1/2/5″ |
| `webbpsf_cross_check_same_wavelength` | ✅ | **rel err 12.78 %**, tol 50 % (4.8 μm both sides) |
| `synphot_photometry_round_trip` | ✅ | finite + positive count |

**all_required_passed: true · n_passed = 5 / n_required = 5 · n_skipped = 0**

Same-wavelength check values:
- NIRCam F480M FWHM @ 4.8 μm = 0.15641″
- Kernel-propagated FWHM @ 4.8 μm = 0.17934″
- rel_err = 0.12784 (≤ tolerance 0.50 ⇒ pass)

## 3. What this PASS does and does not claim

DOES claim:
- the kernel's wave-optics propagation, run at NIRCam's central
  wavelength, agrees with NIRCam's PSF FWHM to within 13 % on a
  parametric MultiHexagonAperture — well inside the documented loose
  band. The check now has *physical meaning* (same λ on both sides).
- the 550 nm visible-light analytic Airy parity (check #2) remains
  intact at 1.61 % — both wavelength regimes are now exercised.

DOES NOT claim (and substrate header line 56–71 still requires for
`absorbed=true`):
- a measured ring optics deck (sourced LHC / FCC-ee / JWST PIL).
- WebbPSF parity on a JWST NIRCam commissioning-data hash.
- a hexa-native FFT propagation matching POPPY to IEEE-754.

So `measurement_gate=GATE_OPEN` and `absorbed=false` **hold** until
those three additional bars clear. The D75 fix removes one specific
honesty blocker (wavelength mismatch); it does not flip the gate.

## 4. Recommendation

- **D75 Option B substrate fix**: COMMIT (already landed on hexa-lang
  `origin/main` `03470762`).
- **absorbed=true flip**: still NO. Two new substrate-honesty bars
  remain (measured optics deck, hexa-native FFT) and are out of scope
  for this round.

## 5. Rejected options (carried forward in design.md D75 for audit)

- (A) align REF_WAVELENGTH to 4.8 μm — loses visible-light scope.
- (C) drop the WebbPSF cross-check — loses JWST instrument signal.
- (D) widen tolerance to 0.9 — silent pass / g3 violation.

## 6. Tooling artifacts

- substrate: `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py` @ commit `03470762`
- test record (local run): `/tmp/scope_verify_d75_v2_*/scope_verify_v1.meta.json`
- design.md D75 audit trail.

## 7. Cross-references

- `parity_attempt_scope_verify_2026-05-20.md` (v1, 4/5 — WebbPSF env missing)
- `parity_attempt_scope_verify_2026-05-20-v2.md` (v2, 4/5 — WebbPSF env installed, design flaw exposed, 4 options surveyed)
- this note (v3, 5/5 — D75 Option B applied)
