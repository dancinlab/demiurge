#!/usr/bin/env tape
# UFO meta — EXPERIMENTS + HYPOTHESES 흡수 manifest tape.
# Sibling of UFO/meta/experiments-hypotheses.md (numbers derive from the .md + falsifier SSOT).
# 17-type alphabet only (@V @I @C @F @D::governance @X). No name-hardcoded dispatch (@D d4).
# 13-falsifier SSOT = UFO/verify/stage4-7-falsifier-preregister.md — this tape mirrors status (all OPEN).

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/meta/experiments-hypotheses" :: identity [d=2026-05-26 active]
  kind = "🛸 UFO meta experiments+hypotheses absorb (alias `exp-hypo`) — 13-falsifier monotone catalogue"
  brief = "absorb EXPERIMENTS.md + HYPOTHESES.md catalogues · 13 falsifier status set {OPEN,CONFIRMED,DEMOTED} monotone · all OPEN · UNPROVEN"
  parent = "dancinlab/demiurge"
  sibling-md = "UFO/meta/experiments-hypotheses.md"

# ─── §C absorbed source provenance ───
@C c_source_exp := "EXPERIMENTS.md provenance" :: config [d=2026-05-26 active]
  source = "UFO/EXPERIMENTS.md"
  blob_sha = "b02edd297704328025dd4d95f3e0d846ea7c7c6e"
  loc = 681
  scope = "section 8 3-STACK x 12 hardware experiments + section 8.5 experiment falsifier"

@C c_source_hypo := "HYPOTHESES.md provenance" :: config [d=2026-05-26 active]
  source = "UFO/HYPOTHESES.md"
  blob_sha = "cafa8a974975d3cb9f53c17c1ae9c5fad2dd55ea"
  loc = 2818
  scope = "section 6 testable predictions P-H1..P-H6 + n=6 hypothesis catalogue (H-OURO etc.)"

@C c_tally := "13-falsifier status tally (all OPEN @ v1.0)" :: config [d=2026-05-26 active]
  open = 13
  confirmed = 0
  demoted = 0
  verdict = "13/13 OPEN — academically UNPROVEN (CONFIRMED stamp on any of these is false)"

# ─── §F falsifier nodes (13 · status MONOTONE · all OPEN) ───
# SSOT = UFO/verify/stage4-7-falsifier-preregister.{md,tape}. This file mirrors the status only.

@F f_warp_1 := "F-WARP-1 Casimir negative-energy" :: falsifier [d=2026-05-26 active]
  stage = "Stage-4 warp"
  measure = "rho_Casimir = -hbar*c/(tau*d^4) vs Pfenning-Ford QI bound"
  demote = "warp-bubble negative-energy claim"
  status = "OPEN"

@F f_warp_2 := "F-WARP-2 horizon signalling" :: falsifier [d=2026-05-26 active]
  stage = "Stage-4 warp"
  measure = "causal signal reach vs bubble radius R"
  demote = "controllable warp drive claim"
  status = "OPEN"

@F f_warp_3 := "F-WARP-3 back-reaction collapse" :: falsifier [d=2026-05-26 active]
  stage = "Stage-4 warp"
  measure = "tau_collapse vs tau_propulsion"
  demote = "self-stable warp claim"
  status = "OPEN"

@F f_worm_1 := "F-WORM-1 exotic-matter source" :: falsifier [d=2026-05-26 active]
  stage = "Stage-5 wormhole"
  measure = "exotic rho at b0 > ell_Pl vs throat-required negative density"
  demote = "macroscopic Morris-Thorne throat claim"
  status = "OPEN"

@F f_worm_2 := "F-WORM-2 quantum-interest collapse" :: falsifier [d=2026-05-26 active]
  stage = "Stage-5 wormhole"
  measure = "∫T_munu k^u k^v dlambda vs ANEC bound (Ford-Roman/Pfenning-Ford)"
  demote = "stable-throat claim"
  status = "OPEN"

@F f_worm_3 := "F-WORM-3 chronology protection" :: falsifier [d=2026-05-26 active]
  stage = "Stage-5 wormhole"
  measure = "CTC formation feasibility (Hawking 1992)"
  demote = "traversable claim"
  status = "OPEN"

@F f_dim_1 := "F-DIM-1 LHC KK-resonance null" :: falsifier [d=2026-05-26 active]
  stage = "Stage-6 dim-jump"
  measure = "m_KK = n*hbar/(R_c*c)"
  demote = "m_KK closed-form (R_c probed)"
  status = "OPEN"

@F f_dim_2 := "F-DIM-2 sub-mm gravity null" :: falsifier [d=2026-05-26 active]
  stage = "Stage-6 dim-jump"
  measure = "R_c = ell_Pl*sigma^(n/phi) = 1728 ell_Pl (torsion-balance/Eot-Wash)"
  demote = "sigma^(n/phi) compactification radius"
  status = "OPEN"

@F f_dim_3 := "F-DIM-3 vacuum-energy transition unobserved" :: falsifier [d=2026-05-26 active]
  stage = "Stage-6 dim-jump"
  measure = "E_fold = M_Pl*c^2/(sigma-phi)^d"
  demote = "E_fold barrier scale"
  status = "OPEN"

@F f_use_1 := "F-USE-1 warp ANEC saturated" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (upstream-derived)"
  measure = "upstream F-WARP-* disposition"
  demote = "10c warp factor"
  status = "OPEN"

@F f_use_2 := "F-USE-2 KK above 14 TeV" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (upstream-derived)"
  measure = "upstream F-DIM-1 disposition"
  demote = "10x dimensional compression"
  status = "OPEN"

@F f_use_3 := "F-USE-3 2nd-law violation" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (composite-specific)"
  measure = "Stage-1 fold release E_fold vs Stage-2 warp consume E_warp (net positive?)"
  demote = "closed-loop energy claim"
  status = "OPEN"

@F f_use_4 := "F-USE-4 simultaneous destabilization" :: falsifier [d=2026-05-26 active]
  stage = "Stage-7 dim-use (composite-specific)"
  measure = "coupled warp+dimjump back-reaction vs tau=4 cycle stability"
  demote = "tau=4 cycle stability"
  status = "OPEN"

# ─── §D governance — monotone + honest UNPROVEN stance ───
@D g_monotone := "falsifier status set {OPEN,CONFIRMED,DEMOTED} monotone" :: governance [required active]
  do = "flip status OPEN->CONFIRMED or OPEN->DEMOTED only (.own own 2 contract · SSOT = stage4-7 preregister)"
  dont = "silently retract a falsifier · let CHANGELOG T1/T2/T3 cross-check stand in for wet-lab CONFIRMED"

@D g_all_open := "all 13 falsifiers OPEN — Stage-4~7 academically UNPROVEN" :: governance [required active]
  do = "keep all 13 OPEN @ v1.0 · physics academically UNPROVEN · CONFIRMED stamp on any is false"
  dont = "mark any of the 13 CONFIRMED/DEMOTED without empirical disposition · conflate with Stage-1~3 🟢"

@D g_layers := "two layers — hardware bench (wet-lab downstream) vs falsifier (UNPROVEN)" :: governance [required active]
  do = "keep EXPERIMENTS.md 3-STACK bench (Stage-1~3 substrate) distinct from Stage-4~7 13-falsifier"
  dont = "claim hardware bench PASS closes a Stage-4~7 falsifier · stamp any bench result PASS in-manifest"

@D g_no_impossibility := "no impossibility framing — preregistered breakthrough paths" :: governance [required active]
  do = "frame all 13 OPEN as UNPROVEN preregister with concrete paths (Casimir source · LHC · sim · @D d2)"
  dont = "concede 'impossible' · force a target number · concede defeat"

# ─── §X cross-links ───
@X x_md := "UFO/meta/experiments-hypotheses.md" :: source [d=2026-05-26 active]
  scope = "Korean absorb manifest — TL;DR · 13-falsifier table · experiments + hypotheses summary"

@X x_falsifier_ssot := "UFO/verify/stage4-7-falsifier-preregister.md" :: source [d=2026-05-26 active]
  scope = "13-falsifier SSOT — section 0 table · section 5 monotone · section 6 honest stance"

@X x_exp_src := "UFO/EXPERIMENTS.md" :: source [d=2026-05-26 active]
  scope = "in-tree source — section 8 3-STACK x 12 hardware pipeline"

@X x_hypo_src := "UFO/HYPOTHESES.md" :: source [d=2026-05-26 active]
  scope = "in-tree source — section 6 P-H1..P-H6 testable predictions + n=6 hypothesis catalogue"

@X x_lattice_verify := "UFO/verify/lattice_check.hexa + stages_falsifier.hexa + saturation_check.hexa" :: verify [d=2026-05-26 active]
  scope = "arithmetic consistency only (sigma*tau=48 · (sigma-phi)^2=100 · R_c=1728) — NOT physics proof"

@X x_mega := "UFO/meta/cross-domain-mega.md" :: source [d=2026-05-26 active]
  scope = "sibling Phase D meta absorb — RTSC↔FUSION↔ANTIMATTER↔CERN reuse lattice"
