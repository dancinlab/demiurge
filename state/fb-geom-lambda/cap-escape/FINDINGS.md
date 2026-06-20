# cap-escape lane r1 (parent-persisted) · 2026-06-19 · TERMINAL depletion(a): ESCAPE found

VERDICT: the λ≲4 cap is CIRCUMVENTABLE — model-internal (single-band adiabatic harmonic
Migdal-Eliashberg), NOT a theorem. g5 PASS.

## What the cap is (arXiv:2407.12922 Semenok/Altshuler/Yuzbashyan)
Electronic kinetic/thermodynamic instability inside ME: C_el<0 (Z<0) at λ*=3.69 (Einstein)/
4.72 (Debye), via ξ=max_T{...}<1, λ*=λ/ξ. Ceiling Tc<0.18√(λ⟨ω²⟩), absolute Tc<950K/√A.
Claimed independent of phonon softening.

## Load-bearing assumptions
1 harmonic phonons · 2 adiabaticity/Migdal (ω_max/E_F≪1) · 3 single-band ME no vertex ·
4 λ is the controlling pairing parameter · 5 C_el<0 ⇒ true thermodynamic instability

## Escape routes (sourced)
A — premise #5 DISPUTED: Sadovskii arXiv:2506.19326 (Ref[32]): total C=(2π²/3)N(0)T(1+λ)>0
    for all params while adiabatic holds; negative-C_el trigger may be artifact of electronic-only
    part. True limiter = lattice (Fröhlich) instability; within stable phase λ can be very large;
    Tc=0.182√(λ⟨ω²⟩) grows monotonically/unbounded. → limiter = ⟨I²⟩/M, Tc*=0.18√(N(0)⟨I²⟩/M).
B — premises #2,3,4: non-adiabatic / flat-band (ω~E_F), vertex corrections O(1), can be positive;
    cap authors concede "significant modifications necessary" → cap out-of-domain.
C — premises #3,4: bond-SSH bipolaron (Zhang/Berciu PRX 13,011010 2023; PRB 109 L220502): light,
    small, sliding bipolarons, Tc bound exponentially larger than Holstein, ≥ ME/McMillan bound;
    real-space pairing bypasses Eliashberg λ. Optimal t/Ω~1-2, light atoms.
D — (NOT escape) anharmonic/quantum-ionic (SSCHA): stabilizes the lattice so a material EXISTS at
    high λ, but cap is on the renormalized α²F → moves toward λ*, consistent with formula. =enabler
    for ambient hydrides sitting AT the ceiling.

## Escape clause for the RTSC closing formula
λ≤~4 holds ONLY in single-band adiabatic harmonic ME, and even there is an empirical
lattice-stability/⟨I²⟩ ceiling (negative-C_el disputed), NOT a theorem; Tc=0.182√(λ⟨ω²⟩) does not
saturate in λ. EVADED in (E1) non-adiabatic flat-band vertex regime, (E2) bond-SSH bipolaron channel.
→ replace bare λ≤~4 with: (adiabatic single-band: Tc ≤ 0.18√(N(0)⟨I²⟩/M), λ-stability-limited ~4)
   ⊕ ESCAPE {non-adiabatic flat-band vertex, bond-SSH bipolaron}.
Sources: 2407.12922, 2409.19562, 2506.19326 (Sadovskii+Ref[32]), Zhang/Berciu PRX, PRB 109 L220502.
