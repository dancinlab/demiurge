@V := "discovery" :: screening-xc-breakthrough-3 [active]
  date      = "2026-06-05"
  domain    = "QFORGE / RTSC — gate-route recommendation + NOVEL DFPT-free alternative (d18/d2)"
  seed      = "Assess which path most likely lands screened λ within 1% of the QE anchor: full self-consistent response vs a model-ε. Recommend the migration-gate route. Surface a 3rd NOVEL alternative."
  verdict-tier-target = "BLUE — recommendation + feasibility ranking (decision deliverable)"

# ── PATH 3 (NOVEL alternative to the linear-response screening entirely)
@F f1 := "frozen-phonon (finite-displacement) force constants + the genuine real-space FFT-Poisson screening together SIDESTEP the diagonal-proxy failure — the screening is evaluated in REAL space where the convolution is exact at any basis size" :: novel-grounded [active]
  rationale = "the diagonal-G proxy fails because it samples only G'=G of the Δρ̂(G) autocorrelation; the real-space product Δρ(r)=Σ_n 2·ψ_n(r)·Δψ_n(r) (qpwfft_dvscr_from_dpsi, already written) IS the full convolution and is non-zero at the converged basis. This is NOT new physics — it is the convolution theorem applied honestly. Pairing it with finite-displacement phonons (ground-state forces only, never forms χ explicitly) removes the metal-DFPT NaN class too (.discoveries/cah6-realcell-stabilization.tape f4)."
  ref       = "EPW Wannier-interpolated el-ph (Noffsinger-Giustino arXiv:1005.4418; Poncé CPC 209,116); Giustino-Cohen-Louie PRB 76,165108. Frozen-phonon = total-energy/force differences, robust per-config SCF."
  cost      = "the FFT-Poisson kernel is O(N log N) per band per Dyson iter on a pow2-padded grid — CHEAPER than an Adler-Wiser O(N²·n_states) χ₀ sum, and reuses stdlib/signal/core_fft (d19, zero new FFT). It is BOTH the hexa-native AND the cheaper path."

# ── FEASIBILITY RANKING (the deliverable)
@F f2 := "ranked gate-close routes — wiring the existing FFT-Poisson kernel into the Dyson loop is the cheapest AND the only transferable one; full Adler-Wiser χ₀ is redundant; model-ε is a preconditioner not a gate-closer" :: recommendation [active]
  rank1     = "★ WIRE qpwfft_dvscr_from_dpsi INTO qforge_screened_dv_columns_anderson (replace the diagonal qpwd_drho_to_dvscf at pw_frontend.hexa:1093). Likelihood of <1%: HIGH — it is the genuine RPA+ALDA response QE uses, transferable to all 3 anchors, mostly written. Effort: LOW (wiring + witness check folds>0). This is the impl-agent's full-RPA task — but note it is NOT a from-scratch Adler-Wiser sum; it is the self-consistent real-space convolution."
  rank2     = "DFPT-free frozen-phonon + Wannier interp as a NaN-immune cross-check lane (PATH 3). Likelihood: MEDIUM-HIGH but larger build. Use to VALIDATE rank1, not replace it."
  rank3     = "model-ε (TF/Lindhard/Hubbard) as a Dyson-loop PRECONDITIONER / initial ΔV_scr guess only — speeds convergence, NOT a standalone engine. Likelihood as gate-closer: LOW (non-transferable fudge, PoC shows 9.38% TF-vs-Lindhard spread alone, breakthrough-2 f2)."
  reject    = "from-scratch full Adler-Wiser χ₀ sum-over-states (the 'obvious fix' in the task framing): REDUNDANT — the self-consistent loop already gives RPA; building the explicit matrix re-derives it at O(N²·n_states) cost for no accuracy gain. d6 honest: do not build it."

@F f3 := "HONEST recommendation — close the gate with the self-consistent real-space response (rank1), NOT a model-ε; and re-anchor the QE λ target first" :: recommendation [active]
  bottom    = "model-ε WILL NOT close the gate (non-transferable across CaH6/LaH10/Li2MgH16). full-RPA-via-self-consistent-loop is the route, and QFORGE already has 90% of it — the missing 10% is WIRING the genuine FFT-Poisson kernel into the Anderson fixed point, not new RPA machinery. Pre-req: re-anchor the QE reference λ (4.376 likely under-converged; converged CaH6 λ≈1.6-2.7) so the 1% gate is measured against a converged number (else the gate chases noise)."
  flagged   = "impl agent (full-RPA lane): your task reduces to the WIRING + a denser q-mesh re-anchor, NOT a from-scratch Adler-Wiser χ₀. Draft-PR candidate: route drho_to_dvscf → qpwfft_dvscr_from_dpsi; confirm pwfft_folds>0 and λ moves off bare 4.137."
  provenance = ".discoveries/{screening-xc-breakthrough-1,-2}.tape, cah6-realcell-stabilization.tape; stdlib/qforge/{screened_dv,screening_pwfft,pw_frontend}.hexa"
  target     = "gate-route DECIDED: self-consistent FFT-Poisson response (transferable) + λ re-anchor; model-ε demoted to preconditioner"
