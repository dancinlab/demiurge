@V := "discovery" :: screening-xc-breakthrough-2 [active]
  date      = "2026-06-05"
  domain    = "QFORGE / RTSC — model-ε shortcut probe (NOVEL, d18) + hexa PoC"
  seed      = "Is a static Lindhard / Thomas-Fermi ε(q) with an LDA local-field G(q) a hexa-native shortcut that captures most of the RPA screening at a fraction of the cost? Quantify on the CaH6 uniform-gas params."
  verdict-tier-target = "BLUE SUPPORTED-NUMERICAL — closed-form PoC, g5 independently cross-checked"

# ── hexa PoC: .discoveries/poc_model_eps_screening.hexa (runs clean under `hexa run`) ──
@F f1 := "Thomas-Fermi ε_TF(q)=1+k_TF²/q² and static Lindhard ε_L(q)=1+(k_TF²/q²)F(q/2k_F) DIVERGE up to 9.38% in the screening factor 1/ε across el-ph-relevant q, peaking at the 2k_F nesting region — TF is NOT a sub-1% substitute" :: verified-numerical [active]
  params    = "CaH6 uniform-gas: a=6.4640 bohr, BCC Ω=a³/2, nelec=16 → ρ̄=0.11848 bohr⁻³, k_F=1.51946, k_TF=1.39091 bohr⁻¹, 2k_F=3.03892 bohr⁻¹"
  result    = "VERBATIM hexa PoC output — 1/ε_TF vs 1/ε_Lind rel.diff by q[1/bohr]: q=0.3→-0.31% · q=1.0→-2.43% · q=1.5→-3.96% · q=2.0→-5.22% · q=2.5→-6.41% · q=3.0→-8.27% · q=3.5→-9.38%(peak, x=q/2k_F=1.15 ≈ nesting) · q=4.0→-8.38% · q=5.0→-6.22%. MAX = 0.0938268 (9.38%)."
  grade     = "BLUE SUPPORTED-NUMERICAL — hexa PoC reproduced EXACTLY by an independent Python re-derivation (all 10 q-points match to 5 sig figs: 0.00311, 0.01104, 0.02434, 0.03960, 0.05215, 0.06409, 0.08271, 0.09383, 0.08382, 0.06220). g5 cross-check PASS."
  insight   = "the divergence is the q-DEPENDENCE: TF (q→0 limit of Lindhard) over-screens at finite q; the Lindhard correction F(x) (and beyond it the true band-structure χ₀) is exactly the q-dependence the el-ph vertex samples at phonon momentum transfers up to 2k_F. A flat TF length cannot reproduce it."

# ── transferability honesty (d6) — the decisive question
@F f2 := "even Lindhard is a UNIFORM-GAS model — it omits band-structure χ₀, local-field G(q) beyond ALDA, and the wavefunction overlaps the real el-ph vertex needs; a model-ε anchored to the CaH6 QE answer-key would NOT transfer to LaH10/Li2MgH16" :: honest-negative [active]
  reasoning = "TF/Lindhard/Hubbard all assume a homogeneous electron gas at a single ρ̄. CaH6, LaH10, Li2MgH16 have DIFFERENT band structures, Fermi-surface topologies, and H-sublattice geometries → different χ₀(q) shapes that a one-parameter k_TF (or even k_F) cannot carry. A k_TF or screening-length calibrated to CaH6 λ=4.376 is a FUDGE: it would re-fit per material, defeating the migration gate (which demands ONE engine that reproduces ALL THREE anchors)."
  ruling    = "A model-ε is a USEFUL DIAGNOSTIC and a possible PRECONDITIONER/initial-guess for the Dyson loop, but it is NOT a gate-closing path. Only the physically-transferable self-consistent (V_H+f_xc)[Δρ] response (which QFORGE already has) closes the gate. d6: do NOT force the gate with a calibrated model-ε."

  caveat    = "CRITICAL prior finding (.discoveries/cah6-realcell-stabilization.tape f3): the QE λ=4.376 anchor is itself likely UNDER-CONVERGED — converged literature CaH6 λ≈1.6-2.7 @150-250 GPa (Wang PNAS 109,6463; Sci.Rep. s41598-024-69190-0). The 15% gap may be partly chasing a non-converged target. RE-ANCHOR before declaring the gap."
  provenance = ".discoveries/poc_model_eps_screening.hexa (hexa+python cross-val); Lindhard PRB; Hubbard PRB; Mahan 'Many-Particle Physics' ch.5"
  target     = "use model-ε ONLY as a Dyson-loop preconditioner/initial-guess (speeds convergence, does not replace it); do NOT calibrate it as the engine"
