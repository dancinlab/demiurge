@V := "discovery" :: qforge-allen-dynes-tc-lift [active]
  date      = "2026-06-01"
  domain    = "QFORGE / RTSC"
  seed      = "QFORGE<->QE cross-val (hexa-lang PR#2362) proved recorded 'Allen-Dynes Tc' = AD-kernel (omega_log/1.2, no f1.f2). Recompute every confirmed candidate with the true f1.f2 form."
  method    = "qforge_tc_allen_dynes(lambda,omega_log,mu*) on 14 candidates' real-DFPT moments read verbatim from exports/material_discovery/; mu*=0.10 & 0.13. Deterministic closed form."
  mechanism = "Allen-Dynes f1 strong-coupling factor (Lambda1=2.46(1+3.8mu*)) lifts the McMillan/AD-kernel underestimate; f2=1 here since omega2=omega_log. Lift grows with lambda."

# verified recompute (verdict-tier = GREEN, hexa verify + QE cross-val selftest verbatim)
@F f1 := "true Allen-Dynes f1.f2 lifts every recorded Tc, monotone-increasing in lambda: +2.51% (SrAuH3 lambda=0.62) -> +35.06% (CaH6 lambda=4.38)" :: verified [active]
  grade     = "GREEN SUPPORTED-NUMERICAL — 14/14 hexa verify PASS; QE cross-val qforge_qe_xval_test 12/12 PASS (GATE A reproduce AD-kernel rel-eps<=0.25%; GATE B lift positive & monotone-in-lambda)"
  highest   = "CaH6 344.5K(mu*=.10)/323.5K(.13) @172GPa; YH10 274.5K(.10)/256.3K(.13) @250GPa — both cross room-temp as MODEL UPPER estimates"
  baseline  = "recorded = AD-kernel (omega_log/1.2, no f1.f2), cross-validated to reproduce QE records exactly"
  caveat    = "NO room-temp claim. high-pressure (150-250 GPa) != ambient (campaign 293K@1atm target unmet). f1.f2 over-predicts lambda>~3 (CaH6, H3Po least reliable). f2=1 => reported lift is itself a lower bound. AD = prediction not measurement."
  bottom    = "Proper Allen-Dynes does NOT surface a new ambient room-temp superconductor; it re-interprets recorded Tc as McMillan/AD-kernel lower bounds and systematically raises them."
  record    = "PAPER/qforge-allen-dynes-tc-lift/companion/recompute-table.csv + verify-ledger.json"
  provenance = "hexa-lang PR#2362; stdlib/qforge/tc.hexa; stdlib/material/sim.hexa"
  paper     = "PAPER/qforge-allen-dynes-tc-lift/ (PAPER.tape registered)"
  target    = "follow-up: direct isotropic Migdal-Eliashberg (QFORGE L1) solve on same moments to bracket high-lambda hydrides between McMillan lower & Allen-Dynes upper bound"
