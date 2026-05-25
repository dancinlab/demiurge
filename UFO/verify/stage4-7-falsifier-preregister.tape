#!/usr/bin/env tape
# UFO Stage-4~7 falsifier preregister — 13 F-* nodes (warp/wormhole/dim-jump/dim-use · UNPROVEN)
# Sibling of UFO/verify/stage4-7-falsifier-preregister.md (numbers derive from the .md SSOT).
# 17-type alphabet only (@V @I @C @F @D::governance @X). No name-hardcoded dispatch (@D d4).

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "ufo/falsifier" :: identity-claim [d=2026-05-26 active]
  kind = "🛸 UFO Stage-4~7 falsifier preregister (alias `falsifier`) — warp · wormhole · dim-jump · dim-use"
  brief = "13 preregistered falsifiers · status set {OPEN,CONFIRMED,DEMOTED} monotone · all OPEN @ v1.0 · physics academically UNPROVEN"
  parent = "dancinlab/demiurge"
  sibling-md = "UFO/verify/stage4-7-falsifier-preregister.md"

# ─── §C lattice config (verifiable integer arithmetic — NOT physics proof) ───
@C c_lattice := "n=6 invariant lattice" :: config [d=2026-05-26 active]
  n = 6
  sigma = 12
  tau = 4
  phi = 2
  J2 = 24

@C c_identities := "closed-form lattice identities (arithmetically verifiable)" :: config [d=2026-05-26 active]
  master = "sigma*phi = n*tau = J2 = 24"
  sigma_tau = "sigma*tau = 48  (hexa-rtsc Hc2=48T sister cross-link)"
  composite = "(sigma-phi)^2 = 100  (Stage-7 effective composite speed, in c)"
  R_c = "ell_Pl * sigma^(n/phi) = 1728 ell_Pl  (Stage-6 compactification radius)"

# ─── §F falsifier nodes (per task: @F carries the 13 preregistered falsifiers) ───
# Status MONOTONE: OPEN -> CONFIRMED (refuted, lattice claim DEMOTED) or OPEN -> DEMOTED only.

@F f_warp_1 := "F-WARP-1 Casimir negative-energy" :: falsifier [d=2026-05-26 active]
  stage = "Stage-4 warp"
  pattern = "sigma=12 Casimir plate array cannot realise warp-bubble-scale negative-energy density rho=-hbar*c/(tau*d^4)"
  measure = "measured Casimir rho vs Pfenning-Ford QI bound ∫rho*g dt >= -3hbar/(32 pi^2 tau_g^4)"
  falsify = "DEMOTE warp-bubble negative-energy claim"
  status = "OPEN"

@F f_warp_2 := "F-WARP-2 horizon signalling" :: falsifier [d=2026-05-26 active]
  stage = "Stage-4 warp"
  pattern = "bubble-wall observer cannot signal outside the bubble (Alcubierre horizon problem)"
  measure = "causal signal reach vs bubble radius R"
  falsify = "DEMOTE controllable warp drive claim"
  status = "OPEN"

@F f_warp_3 := "F-WARP-3 back-reaction collapse" :: falsifier [d=2026-05-26 active]
  stage = "Stage-4 warp"
  pattern = "Hawking-style quantum back-reaction destroys bubble before propulsion completes"
  measure = "tau_collapse vs tau_propulsion"
  falsify = "DEMOTE self-stable warp claim"
  status = "OPEN"

@F f_worm_1 := "F-WORM-1 exotic-matter source" :: falsifier [d=2026-05-26 active]
  stage = "Stage-5 wormhole"
  pattern = "no quantum-field source (Casimir/squeezed/phantom) can sustain b0 > ell_Pl exotic-matter density"
  measure = "exotic rho at b0 > ell_Pl vs throat-required negative density"
  falsify = "DEMOTE macroscopic Morris-Thorne throat claim"
  status = "OPEN"

@F f_worm_2 := "F-WORM-2 quantum-interest collapse" :: falsifier [d=2026-05-26 active]
  stage = "Stage-5 wormhole"
  pattern = "back-reaction collapses throat under quantum interest conjecture (Ford-Roman 1995 / Pfenning-Ford 1997)"
  measure = "∫T_munu k^u k^v dlambda vs ANEC bound -hbar*c/(b0^4*tau)"
  falsify = "DEMOTE stable-throat claim"
  status = "OPEN"

@F f_worm_3 := "F-WORM-3 chronology protection" :: falsifier [d=2026-05-26 active]
  stage = "Stage-5 wormhole"
  pattern = "chronology protection (Hawking 1992) precludes traversal — CTC formation forbids stable wormhole"
  measure = "CTC formation feasibility for relatively-moving mouths"
  falsify = "DEMOTE traversable claim"
  status = "OPEN"

@F f_dim_1 := "F-DIM-1 LHC KK-resonance null" :: falsifier [d=2026-05-26 active]
  stage = "Stage-6 dim-jump"
  pattern = "LHC 14 TeV KK-resonance hunt null beyond bound -> R_c probed"
  measure = "m_KK = n*hbar/(R_c*c)"
  falsify = "DEMOTE m_KK closed-form (R_c probed)"
  status = "OPEN"

@F f_dim_2 := "F-DIM-2 sub-mm gravity null" :: falsifier [d=2026-05-26 active]
  stage = "Stage-6 dim-jump"
  pattern = "sub-millimeter gravity test (torsion-balance / Eot-Wash) null beyond bound"
  measure = "R_c = ell_Pl*sigma^(n/phi) = 1728 ell_Pl ~ 2.79e-32 m"
  falsify = "DEMOTE sigma^(n/phi) compactification radius"
  status = "OPEN"

@F f_dim_3 := "F-DIM-3 vacuum-energy transition unobserved" :: falsifier [d=2026-05-26 active]
  stage = "Stage-6 dim-jump"
  pattern = "no observed vacuum-energy transition / dimensional-fold release"
  measure = "E_fold = M_Pl*c^2/(sigma-phi)^d  (d=1 -> ~2e18 GeV)"
  falsify = "DEMOTE E_fold barrier scale"
  status = "OPEN"

@F f_use_1 := "F-USE-1 warp ANEC saturated" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (upstream-derived)"
  pattern = "warp Stage-4 ANEC bound saturated (gated by hexa-warp BT-347 empirical status)"
  measure = "upstream F-WARP-* disposition"
  falsify = "DEMOTE 10c warp factor"
  status = "OPEN"

@F f_use_2 := "F-USE-2 KK above 14 TeV" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (upstream-derived)"
  pattern = "dimjump Stage-6 KK m > 14 TeV from LHC (gated by hexa-dimjump BT-348 empirical status)"
  measure = "upstream F-DIM-1 disposition"
  falsify = "DEMOTE 10x dimensional compression"
  status = "OPEN"

@F f_use_3 := "F-USE-3 2nd-law violation" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (composite-specific)"
  pattern = "self-cycle violates 2nd law of thermodynamics in 4D projection"
  measure = "Stage-1 fold release E_fold vs Stage-2 warp consume E_warp=Msun/sigma^2 (net positive?)"
  falsify = "DEMOTE closed-loop energy claim"
  status = "OPEN"

@F f_use_4 := "F-USE-4 simultaneous destabilization" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (composite-specific)"
  pattern = "composite back-reaction destabilizes both stages simultaneously"
  measure = "coupled warp+dimjump back-reaction vs tau=4 cycle stability"
  falsify = "DEMOTE tau=4 cycle stability"
  status = "OPEN"

# ─── §D governance — honest stance (bookkeeping closure != empirical truth) ───
@D g_unproven := "Stage-4~7 academically UNPROVEN — falsifier-only" :: governance [required active]
  do = "keep Stage-4~7 (warp/wormhole/dim-jump/dim-use) as falsifier-only — all 13 OPEN @ v1.0, physics UNPROVEN"
  dont = "mark Stage-4~7 verified/proven · conflate with the Stage-1~3 🟢 SUPPORTED-NUMERICAL row"

@D g_arith_vs_physics := "lattice arithmetic is verifiable; physics is not" :: governance [required active]
  do = "treat lattice identities (sigma*tau=48 · (sigma-phi)^2=100 · R_c=1728 ell_Pl) as arithmetically verifiable only"
  dont = "claim the physics they index is proven · let bookkeeping closure stand in for empirical truth"

@D g_monotone := "falsifier status set {OPEN,CONFIRMED,DEMOTED} monotone" :: governance [required active]
  do = "flip status OPEN->CONFIRMED or OPEN->DEMOTED only (.own own 2 contract from in-tree hexa-* SSOT)"
  dont = "silently retract a falsifier (honest C3 violation) · let any sentinel/PASS validate an empirical claim"

@D g_no_impossibility := "no impossibility framing — concrete breakthrough paths" :: governance [required active]
  do = "frame Stage-4~7 as UNPROVEN preregister with concrete paths (NEC-violating source · extra-dim obs · simulator)"
  dont = "concede 'impossible' (@D d2) · make a false breakthrough claim · concede defeat"

# ─── §X cross-links (in-tree SSOT + lattice verify scripts + Stage-1~3 control) ───
@X x_warp := "UFO/warp/hexa-warp.md §10" :: source [d=2026-05-26 active]
  scope = "F-WARP-{1,2,3} SSOT · Alcubierre metric · n=6 lattice"

@X x_worm := "UFO/wormhole/hexa-wormhole.md §9" :: source [d=2026-05-26 active]
  scope = "F-WORM-{1,2,3} SSOT · Morris-Thorne metric · b0=ell_Pl*sigma"

@X x_dim := "UFO/dimjump/hexa-dimjump.md §8" :: source [d=2026-05-26 active]
  scope = "F-DIM-{1,2,3} SSOT · KK ladder 4D->26D · R_c=1728 ell_Pl"

@X x_use := "UFO/dimuse/hexa-dimuse.md §6" :: source [d=2026-05-26 active]
  scope = "F-USE-{1,2,3,4} SSOT · (sigma-phi)^2=100c composite · tau=4 cycle"

@X x_main := "UFO/HEXA-UFO.md" :: source [d=2026-05-26 active]
  scope = "7-stage ladder · alien_index chain 🛸6 -> 🛸ABSOLUTE"

@X x_lattice_verify := "UFO/verify/lattice_check.hexa + calc_*.hexa + stages_falsifier.hexa" :: verify [d=2026-05-26 active]
  scope = "arithmetic consistency of σ·τ=48 · (σ−φ)²=100 · R_c=1728 (NOT physics proof)"

@X x_stage123 := "UFO/verify/stage{1,2,3}-*.md" :: source [d=2026-05-26 active]
  scope = "Stage-1~3 verify 🟢 LANDED — control row distinct from Stage-4~7 UNPROVEN"
