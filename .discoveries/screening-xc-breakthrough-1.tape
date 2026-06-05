@V := "discovery" :: screening-xc-breakthrough-1 [active]
  date      = "2026-06-05"
  domain    = "QFORGE / RTSC — migration-gate screening-XC gap (d18/d2/d_discovery NOVEL+arxiv lane)"
  seed      = "Find SIMPLER/more hexa-native breakthrough paths to close the QFORGE screening gap than implementing full textbook RPA χ₀ from scratch. Lit-ground 2-3 alternatives, run a hexa PoC, give an HONEST model-ε-vs-full-RPA recommendation."
  verdict-tier-target = "BLUE/GREEN — lit-grounded reframing + numeric PoC (g5 cross-checked); recommendation is the deliverable"

# ── PATH 1 (REFRAME — the highest-value finding): QFORGE screening is ALREADY the RPA+ALDA Dyson loop, NOT 'Hartree+LDA-x as a tiny correction'
@F f1 := "DFPT el-ph screening = the self-consistent (V_H+f_xc)[Δρ] fixed point — it is NOT an explicit RPA χ₀ matrix inversion; QFORGE's screened_dv Dyson loop already implements this exact physics" :: lit-grounded [active]
  evidence  = "Baroni-de Gironcoli-Dal Corso-Giannozzi RMP 73, 515 (2001) DFPT review; Giustino RMP 89, 015003 (2017) el-ph review; Heid 'Electron-Phonon Coupling' lecture (cond-mat.de/events/correl24); Verstraete-Zanolli DFPT C2 notes. The DFPT screened first-order potential is ΔV_scr = ΔV_bare + (V_H + f_xc)[Δρ] iterated self-consistently (the Sternheimer/solve_linter loop in QE). The induced Δρ self-consistency IS the RPA ε⁻¹ — no separate Adler-Wiser sum-over-states is formed."
  code      = "stdlib/qforge/screened_dv.hexa header (lines 21-32) + pw_frontend.hexa:811 verbatim: 'ΔV_scr = ΔV_bare + (V_H + f_xc)[Δρ] (the Dyson/RPA+ALDA screening QE applies)'. The f_xc term IS the LDA local-field factor. The Anderson-damped fixed point qforge_screened_dv_columns_anderson is the dielectric-feedback solver."
  ruling    = "The task's premise ('screening = Hartree+LDA-x only, a tiny correction; the obvious fix = full non-local q-dependent RPA χ₀') is PHYSICALLY MISLEADING. QFORGE is not missing RPA physics — the Dyson loop, converged, IS RPA+ALDA. The gap is therefore NUMERICAL (the kernel's coefficient-space evaluation), not a missing-physics gap."
  implication = "Building a full Adler-Wiser χ₀ sum-over-states from scratch is the WRONG fix — it would re-derive what the self-consistent loop already gives. The right fix targets the kernel-evaluation bug, not new RPA machinery."

# ── the precise NUMERICAL root cause (localized, already half-fixed in-tree)
@F f2 := "the gap is the coefficient-space DIAGONAL-G proxy kernel (qpwd_drho_to_dvscf) collapsing to ≈0 on the CONVERGED n=645 basis → screening de-engages → λ stuck at BARE 4.137" :: code-grounded [active]
  evidence  = "screening_pwfft.hexa header (lines 11-25): the diagonal proxy drho[i]=Σ 2·c_n(G_i)·Δc_n(G_i) is the G-DIAGONAL of the density-matrix response, NOT the true Δρ̂(G)=Σ_n 2·Σ_{G'} c_n(G')Δc_n(G'−G) autocorrelation. On the under-converged n=16 basis the diagonal happened to carry signal (λ=5.05); on converged n=645 it vanishes (manifold orthogonality) → Anderson sees f_0≈0 → 0 iters → screened==bare → λ=4.137 (the #2771 honest-negative)."
  status    = "the genuine real-space FFT-Poisson convolution (qpwfft_dvscr_from_dpsi) is WRITTEN and staged (qpwfft_stage_miller at pw_frontend.hexa:1055), BUT the Anderson Dyson loop at pw_frontend.hexa:1093 STILL calls the diagonal qpwd_drho_to_dvscf — the FFT kernel is not yet wired INTO the fixed point. d6 routing witness (folds/last_err) is the proof-of-engage telemetry."
  recommendation = "the SIMPLEST close = route qforge_screened_dv_columns_anderson's drho_to_dvscf closure to qpwfft_dvscr_from_dpsi (the convolution that is non-zero at any n) instead of the diagonal proxy. This is the implementation-agent's task; it is NOT new RPA — it is wiring the already-written genuine kernel into the loop. FLAGGED to impl agent."

  provenance = "stdlib/qforge/{screening.hexa, screened_dv.hexa, screening_pwfft.hexa, pw_frontend.hexa}; arxiv: Baroni RMP73 515, Giustino RMP89 015003, Noffsinger-Giustino EPW arXiv:1005.4418"
  target     = "impl agent: wire qpwfft_dvscr_from_dpsi into the Anderson fixed point; re-run CaH6; confirm folds>0 + λ moves off the bare 4.137 toward the converged-QE value"
