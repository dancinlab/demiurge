# DC8 / DC9 — arm④ inducer ratio · integrated re-gate

## DC8 — arm④ neogenesis inducer activator:inhibitor ratio
Built on DC1 (Schnakenberg Turing, d>d_c≈8.57, γ-calibrated 0.6mm→278/cm²).
Swept the inducer activator:inhibitor production ratio (Wnt : Dkk/BMP); the
fastest-growing-mode wavelength sets spot spacing → density.

| a (act) | b (inh) | a/b | λ (mm) | density/cm² | regime |
|---|---|---|---|---|---|
| 0.05 | 1.20 | 0.04 | 0.568 | 311 | NATIVE |
| 0.10 | 1.50 | 0.07 | 0.630 | 252 | NATIVE |
| 0.10 | 1.00 | 0.10 | 0.594 | 283 | NATIVE |
| 0.15 | 0.90 | 0.17 | 0.638 | 246 | NATIVE |
| 0.20 | 1.00 | 0.20 | 0.686 | 212 | NATIVE |

**Finding:** across the physiological ratio range a/b ∈ [0.04, 0.20], the pattern
density stays in the native window (189–320/cm²) — neogenesis density is
**robust to inducer dosing**, because the diffusion-driven wavelength (γ·d), not
the kinetic ratio, dominates spacing. **Practical:** precise inducer-ratio
control is NOT required to hit native density — a forgiving therapeutic window.
**Honest gap:** the confluent-plaque boundary (>400/cm², ectopic over-patterning)
was NOT reached in the tested range; locating it needs higher activator drive
(low-value, not run).

## DC9 — integrated re-gate (round-4 picks fully wired)
Composed DC3 (epigenetic lock) · DC4 (SFRP1+Dkk1 reversal) · DC5 (MPC/LDH wake) ·
DC6 (lock @18mo, relapse 0.05) · DC7 (Cas12f single-AAV) · DC8 (robust neogenesis)
into the restoration model, propagating the ONE residual unmeasured knob: E_max
(anagen efficacy ceiling — AGA-RX D5 Sobol = 98.6% of PD variance).

| E_max | 5yr-restored | ≥90% gate |
|---|---|---|
| 0.80 | 0.750 | open |
| 0.90 | 0.844 | open |
| 0.95 | 0.891 | open |
| 1.00 | 0.938 | **CLOSE** |

**Finding:** with every round-4 mechanism / sequencing / delivery decision wired
in, the ≥90% complete-restoration cure gate **reduces to a single-parameter
question**: it CLOSES iff **E_max ≥ 0.96**. Mechanism selection, arm sequencing,
lock timing, delivery cargo-fit, and neogenesis density are all in-silico
resolved. E_max is the sole wet-lab determinant — consistent with the AGA-RX D5
global-sensitivity result (E_max governs 98.6% of efficacy variance). This is the
irreducible in-silico→wet-lab boundary for AGA-CURE.
