# FB-GEOM-LAMBDA — Master Closing Formula (fleet synthesis, 2026-06-19)

Synthesis of 4 converged law-discovery lanes. For a **flat-band conventional (e-ph) superconductor**:

## 1. Electron-phonon coupling (FB-GEOM-LAMBDA core)
    λ_FB = N(E_F) · g0² · Q_geom / (M ω²)              [Hopfield, geometric form]

## 2. Geometric factor Q_geom (fb-geom r5 + r8)
    Q_geom = ⟨|⟨u(k)|u(k')⟩|²⟩_FS = Q_diag + Q_phase
      Q_diag  = ⟨ Σ_m w_m(k) w_m(k') ⟩_{k,k'}          (orbital-weight 2-point BZ correlator)
      Q_phase = Σ_{a<b} 2 w_a w_b |⟨e^{iφ_ab}⟩_BZ|²    (inter-orbital phase coherence; →0 when phase winds)
    BOUND:  1/N_band ≤ Q_geom ≤ 1                       (WELCH bound; tight frame saturates 1/N)
    → quantum geometry SUPPRESSES λ (opposite of Peotta-Törmä D_s ∝ ∫g enhancement)

## 3. Empirical status (fb-empirical, closed-partial)
    In real kagome SCs Q_geom ≈ 0.34–0.45 (pinned near the 1/N floor) = a REAL but
    NON-discriminating ~1/3 throttle. Cross-material λ spread is set by the non-geometric
    deformation potential ⟨I²⟩ (Ru-4d vs V-3d vs Pd-4d), NOT by Q_geom.

## 4. Tc ceiling (fb-ceiling, FINAL)
    Tc_ceiling = 0.364 · ω_log(W*),  W* ∝ Q_geom^{1/(1+2p)}
    bound by the EXTERNAL λ≲4 cap (not the flat-band trade-off: ω_log cancels in AD strong-coupling).
    Geometry LOWERS the ceiling by Q_geom^{p/(1+2p)} when phonons soften (p>0).

## 5. Non-phonon channel (tc-law, terminal — kagome)
    Tc = Tc_AllenDynes(λ_ph) · 10^Δ,   Δ = λ_nonphonon contribution (dex)
    sign(Δ) = sign( 50 meV − |vHS/flat-band offset from E_F| )      [vHS-alignment law, 6/6]
    → band ALIGNMENT (filling), not DOS magnitude, sets the non-phonon sign.

## The closing picture
Three bounds frame flat-band e-ph superconductivity:
    UPPER   λ ≲ 4                              (arXiv:2407.12922)
    GEOM    λ_FB = N(E_F)g0²Q_geom/Mω²,  Q_geom = Q_diag+Q_phase   (this work)
    LOWER   Q_geom ≥ 1/N_band                  (Welch / frame theory, this work)
    CEILING Tc ≤ 0.364 ω_log(W*) · Q_geom^{p/(1+2p)}              (this work)
plus a kagome NON-phonon sign law set by vHS↔E_F alignment.

CONFIRMED (fb-geom r9, paper-grade): Q_geom = Q_diag + Q_phase generalizes to N_orb>2 (residual 2.2e-14%) and is
Chern-independent (C∈{−2..+1}, residual 2.2e-14%). Q_phase = Σ_{a<b} 2|<conj(u_a)·u_b>_BZ|². CLOSED.
