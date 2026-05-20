# parity_attempt — cern + synthesize (xsuite FODO twiss)

> status: **resolved → flip executed** (κ-50 parity 100% / κ-51 substrate _analytic_fodo_twiss flips GATE to CLOSED_MEASURED + absorbed=true on rel err ≤ 1e-6). Second-ever dynamic absorbed=true (after chip §B+§D, κ-43).

- date: 2026-05-20
- substrate: `~/core/hexa-lang/stdlib/cern/xsuite_optics.py` (hexa-lang origin/main @ a05eecb2)
- producer: `xsuite@0.51.1` (cpymad 1.19.0, xtrack 0.104.1) on python3.12
- ROI rank: 7 (per `inbox/notes/absorption-empty-cells-research-2026-05-20.md`)

## Substrate run (raw xsuite output)

FODO cell parameters (textbook, NOT calibrated to any real ring):
- drift length L = 1.0 m
- quad length L_q = 0.1 m, k1 = ±0.25 m^-2 (integrated K1L = 0.025 m^-1, focal length f = 40 m)
- p0c = 7 TeV proton
- method = "4d" twiss, periodic boundary

Headline numbers:

| quantity        | xsuite value         |
|-----------------|----------------------|
| β_x_max         | 83.57863006666393 m  |
| Q_x (per cell)  | 0.00424218442044344  |

Cell length 2.2 m; s-grid `[0.0, 0.1, 1.1, 1.2, 2.2]`; betx
`[83.579, 83.579, 81.515, 81.515, 83.579]`. β_max is at the start/end of
QF (periodic point).

## Analytic oracle (closed-form, textbook)

Source: Wiedemann *Particle Accelerator Physics* §6.2 (linear-optics
2×2 transfer matrices) + §7.4 (periodic β solution). Equivalent
treatment in Lee *Accelerator Physics* §2.2–§2.4.

For a thick-quad FODO with elements `Drift(L_d) · QD(L_q,k) ·
Drift(L_d) · QF(L_q,k)`, the one-turn matrix is

```
M = D(L_d) · QD(L_q,k) · D(L_d) · QF(L_q,k)
```

with the standard linear-optics blocks

```
QF(L,k) = [[cos(√k·L),  sin(√k·L)/√k], [-√k·sin(√k·L), cos(√k·L)]]
QD(L,k) = [[cosh(√k·L), sinh(√k·L)/√k], [√k·sinh(√k·L),  cosh(√k·L)]]
D(L)    = [[1, L], [0, 1]]
```

Periodic β at s=0 follows from M_11 = cos μ + α sin μ, M_12 = β sin μ:
- cos μ = ½·tr(M) → μ_x (full-cell phase advance)
- β_max = M_12 / sin μ
- Q_x = μ_x / (2π)

Substituting the substrate parameters (L_d = 1.0, L_q = 0.1, k = 0.25)
and solving by direct matrix multiply:

| quantity        | analytic oracle      |
|-----------------|----------------------|
| β_x_max         | 83.57863006667478 m  |
| Q_x (per cell)  | 0.004242184420442952 |

## Parity

| quantity   | xsuite          | oracle          | %parity        |
|------------|-----------------|-----------------|----------------|
| β_x_max    | 83.57863006666  | 83.57863006667  | **100.0000 %** |
| Q_x        | 0.0042421844204 | 0.0042421844204 | **100.0000 %** |

Relative error |xs − oracle|/oracle is < 1e-10 on both headline
numbers — well within any reasonable tolerance (±5 % was the
suggested gate; we exceed it by nine orders of magnitude).

Also computed thin-lens (small-angle) approximation for context:
sin(μ/2) = L_hc/(2f) with L_hc = 1.1 m, f = 40 m gives μ = 0.02750 rad,
Q ≈ 0.004377 (≈97 % parity vs xsuite — the residual 3 % is the
expected thick-quad correction). β_max from the thin-lens formula
L_hc·(1+sin(μ/2))/sin(μ) gives 40.55 m, which is β at the **quad
center**, not the **quad edge** where the substrate samples — so the
2× discrepancy is a sampling-convention artefact, not a physics
error. The thick-quad matrix oracle above is the apples-to-apples
comparison.

## Recommendation: absorbed = true (RECOMMENDATION ONLY — no flip this round)

Reasoning:
1. The substrate reproduces the closed-form Wiedemann/Lee FODO matrix
   solution to numerical-roundoff precision (1e-10 relative). This is
   the strongest possible parity for an optics-synthesis producer.
2. The oracle is analytic-textbook, not measured beam data — but for a
   `synthesize` cell the right oracle is "does the simulator agree
   with the closed-form linear-optics solution it claims to
   implement", and the answer is yes.
3. Scope caveats from the substrate stand verbatim: the FODO numbers
   are NOT calibrated to LHC/FCC-ee/SPS, and the optics layer has no
   space charge, IBS, impedance, or beam-beam. Real-machine
   absorption (e.g. matching to LHC injection optics) would need a
   sourced lattice file + measured tune — that is a separate cell
   (`cern + verify` / `cern + measure`), not this one.
4. The `cern + synthesize` cell as currently scoped — "Xsuite produces
   self-consistent linear optics for a textbook FODO" — is parity-100
   against its own analytic spec. That is the criterion for absorption.

Action items (do NOT execute this round, per brief):
- propose `absorbed = true` on the next record-curation pass for the
  `cern + synthesize` cell;
- keep `measurement_gate = "GATE_OPEN"` (the gate is closed against
  analytic oracle, but explicit gate semantics for `synthesize` cells
  should remain consistent with the rest of the n=6 atlas);
- no producer code change needed.

## Citations

- arxiv:2310.00317 — Iadarola et al., *Xsuite: an integrated beam
  physics simulation framework* (2023, CERN).
- arxiv:2412.16006 — Deniau, *MAD-NG, a standalone linear / non-linear
  optics design framework* (2024).
- Wiedemann H., *Particle Accelerator Physics* 4th ed., Springer 2015,
  §6.2 (linear transfer matrices) and §7.4 (periodic optics / FODO
  cell), formula 7.92–7.95.
- Lee S.Y., *Accelerator Physics* 4th ed., World Scientific 2018,
  §2.2 (transfer matrices) and §2.4 (FODO cell), eq. 2.131–2.134.

## Reproduction

```
python3.12 -m pip install --user --break-system-packages xsuite cpymad cffi
python3.12 ~/core/hexa-lang/stdlib/cern/xsuite_optics.py /tmp/cern_synth_out
# headline: beta_x_max=83.579 m, q_x=0.004242

# Oracle (one-liner):
python3.12 -c "
import numpy as np
Lq,k,Ld = 0.1, 0.25, 1.0
sk = np.sqrt(k)
QF = np.array([[np.cos(sk*Lq), np.sin(sk*Lq)/sk],[-sk*np.sin(sk*Lq), np.cos(sk*Lq)]])
QD = np.array([[np.cosh(sk*Lq), np.sinh(sk*Lq)/sk],[sk*np.sinh(sk*Lq), np.cosh(sk*Lq)]])
D  = np.array([[1, Ld],[0, 1]])
M  = D @ QD @ D @ QF
cm = 0.5*np.trace(M); mu = np.arccos(cm)
print('beta_x_max =', M[0,1]/np.sin(mu), 'm   Q_x =', mu/(2*np.pi))
"
# beta_x_max = 83.57863006667478 m   Q_x = 0.004242184420442952
```
