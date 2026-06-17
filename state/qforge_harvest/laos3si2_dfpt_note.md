# LaOs3Si2 DFPT el-ph (λ / Allen-Dynes Tc) — fire note

**Date fired:** 2026-06-16 · **Host:** summer (FREE pool, no GPU rent) · **Engine:** QE 7.x DFPT (ph.x)
**Lane:** rtsc-laos-dfpt round 1 · **Question:** does flat-band-at-E_F → anomalously high λ?

## Subject
2nd CONFIRMED flat-band-at-E_F winner **LaOs3Si2** (🟢 GREEN). CeCo3B2-type hexagonal P6/mmm
(No.191), ibrav=4, nat=6 ntyp=3 (La 1a; Os 3g KAGOME z=1/2; Si 2c honeycomb z=0).
Relaxed cell (vc-relax CONFIRMED): **alat = 10.59910 bohr, c/a = 0.66989, ΔE = +0.089, m = 0.00**.

## Method (mirrors LaRu3Si2 DFPT reference)
- **SCF:** nspin=1 (NM ground state CONFIRMED by gate, m=0.00 → non-spin-pol is correct AND cheaper);
  12×12×12 k; ecutwfc=90, ecutrho=360 Ry; MP smearing degauss=0.02 Ry; conv_thr=1e-12.
  Justification for nspin=1: LaOs3Si2 is non-magnetic (gate m=0); spin-polarized el-ph would double cost
  for an identical result. Identical recipe to the LaRu3Si2 el-ph scf (scf_elph.in).
- **q-grid:** 2×2×2 (ldisp, Γ-centered irreducible set) — matches LaRu3Si2 reference exactly.
- **el-ph:** electron_phonon='simple' (double-delta a²F), el_ph_sigma=0.005, el_ph_nsigma=10,
  fine k-mesh 16×16×16 for the double-delta integration. tr2_ph=1e-14, alpha_mix=0.4.
- **Os mass corrected to real 190.23** (the relaxed-cell scf placeholder was 100.0; phonon freqs depend
  on mass, so DFPT needs the true value).

## Stability precheck plan (CRITICAL — d6 / ARCHITECTURE; ScH9/YH6 crash lesson)
After the 2×2×2 dyn matrices are computed: q2r (zasr='crystal' → laos3si2.fc) → matdyn
(asr='crystal') evaluated at the 8 commensurate q-points → scan laos3si2.freq for negative
(imaginary) frequencies. **0 imaginary modes ⇒ dynamically stable ⇒ λ/Tc trustworthy.**
If hard imaginary modes appear → cell may need tighter relaxation; report HONESTLY, do NOT fabricate a Tc.

## Allen-Dynes Tc
lambda.x assembles the per-q a²F into λ, ω_log, and Allen-Dynes Tc at μ*=0.10 and μ*=0.13.
This is a harvest step (needs per-q omega + DOS(E_F) header from ph.x output) — run at harvest.

## Honest caveat (c9)
A MODEST λ (≈ the expected kagome value, like LaRu3Si2) is a VALID result, not a failure. The open
question is precisely whether flat-band-at-E_F drives anomalously strong coupling; either answer is a
finding. 2×2×2 q is the same coarse grid as the LaRu3Si2 reference — fair for a head-to-head λ comparison,
but absolute Tc from a 2×2×2 grid is coarse-grid-limited (denser q would shift it; the comparison to
LaRu3Si2 at the SAME grid is the load-bearing result).

## Run handles
- Workdir: `summer:~/laos3si2_dfpt/` · Log: `summer:~/laos3si2_dfpt.log`
- Fire: `setsid bash ~/laos3si2_dfpt_fire.sh >/dev/null 2>&1 </dev/null & disown`
- Progress: `grep -nE "===|Representation|Diagonalizing|JOB DONE|lambda|STABILITY|FAILED" ~/laos3si2_dfpt.log`
- Done marker: "ph.x ... JOB DONE" for el-ph, then "STABILITY:" line, then "run_elph.sh DONE".
