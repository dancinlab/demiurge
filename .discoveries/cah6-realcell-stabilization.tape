@V := "discovery" :: cah6-realcell-stabilization [active]
  date      = "2026-06-02"
  domain    = "QFORGE / RTSC — CaH6 migration gate (lane C: lit grounding + NOVEL, d18)"
  seed      = "Two real-cell QFORGE-NC walls (etot non-monotone in NPW even under Mermin fix; screened ΔV NaN at the metal small-gap (I−χv) near-singularity) — ground the sibling fixes in published technique; re-check whether the QE reference λ=4.376 (migration_gate_anchors.hexa) is a converged value."
  method    = "arxiv + web deep search; verified claims against abstracts / canonical bib records (d6 — unconfirmed refs marked unverified-citation). Findings doc = drafts/cah6-realcell-lit-grounding.md."

# basis-stability wall — standard fixes (ranked for a from-scratch PW engine)
@F f1 := "etot non-monotone-in-NPW for a Fermi-straddling metal is cured by minimizing the FREE energy F=E−σS, not E" :: lit-grounded [active]
  recipe    = "Marzari-Vanderbilt-De Vita-Payne cold smearing (PRL 82, 3296, 1999 — σ-independent F to 2nd order) [or Methfessel-Paxton N1, PRB 40, 3616, 1989]; THEN dual-grid ecutwfc/ecutrho decoupling (Kresse-Furthmüller PRB 54, 11169, 1996); THEN Kerker G²/(G²+G₀²) mixing (PRB 23, 3082, 1981)."
  insight   = "if the sibling added Mermin occupations but still compares band-energy (not F=E−TS) across NPW, that alone explains the residual non-monotone etot. Switch the compared variable to F + prefer cold smearing (cleanest etot-vs-NPW)."

# screening-NaN wall — standard fixes (ranked)
@F f2 := "the screened-ΔV NaN is (I−χv) going singular at E_F; killed by Anderson/Broyden response-mixing + finite-σ broadening of χ" :: lit-grounded [active]
  recipe    = "Anderson mixing (J.ACM 12, 547, 1965 — provably ≡GMRES on the linear inner problem, minimal code) on the self-consistent response density + finite electronic σ broadening χ + damped line-search per Baroni DFPT review (RMP 73, 515, 2001); Broyden-II (Johnson PRB 38, 12807, 1988) hardened fallback; projected Sternheimer-CG inner solve (QE solve_linter)."

# Q3 — gate-target re-check (CRITICAL)
@F f3 := "λ=4.376 is NOT a converged published CaH6 value — converged literature is λ≈1.6-2.7 at 150-250 GPa" :: lit-grounded [active]
  evidence  = "Wang PNAS 109,6463 (2012, arXiv:1203.0263): λ=2.69 @150 GPa (highest credible harmonic). Sci.Rep.14 s41598-024-69190-0 (PMC11310335): λ=2.27/1.92/1.62 @170/200/250 GPa (96³k 8³q). arXiv:2111.10797: λ falls with P, Tc 235→201→187 K. Anharmonic SSCHA cuts Tc 240→190 K."
  ruling    = "λ=4.376 is ~1.6-2.7× every converged value at these P. Likely a near-instability (~120-130 GPa soft-mode) or harmonic-uncorrected/under-converged-q-mesh number. RE-ANCHOR the QE gate reference to ≈2.3-2.7 @170 GPa with recorded P+mesh+smearing."

# Q4 — NOVEL route (d18)
@F f4 := "NOVEL: frozen-phonon (finite-displacement) force constants + Wannier-interpolated el-ph (EPW-style) sidesteps DFPT linear response entirely" :: novel-probe [active]
  rationale = "Both walls are DFPT-linear-response-on-a-metal artifacts. Finite-displacement phonons use only ground-state total-energy/force differences — never form χ, so the ΔV NaN vanishes; only needs robust per-config SCF (handled by f1/f2). Wannier interpolation (Giustino-Cohen-Louie PRB 76, 165108, 2007; EPW Poncé CPC 209, 116, 2016, arXiv:1604.03525) Fourier-interpolates g(k,q) to a dense mesh — exactly the convergence the Γ-only-vs-4×4×4q gap (scoreboard rel-ε 97.95%) needs. Reuses QFORGE eigen/fft; no new linear-response solver. MLFF-phonon variant = later speed layer (d6: training-distribution dep)."
  record    = "drafts/cah6-realcell-lit-grounding.md"
  target    = "siblings: adopt cold-smearing-F + dual-grid + Kerker (basis) · Anderson(≡GMRES)+σ-broadened-χ (NaN); re-anchor λ gate to ~2.3-2.7@170GPa; evaluate frozen-phonon+Wannier as the NaN-free el-ph path."
