# CoSn ⟨g⟩ 검증 시도 결과 — 🟠 정규화 컨벤션 충돌 발견 (d6 honest, c2 catch)
GOAL: upgrade CoSn ⟨g⟩ from generic TB-est 2.87 → band-calibrated scalar, to move GATED→defensible.
RESULT: band-calibrated kagome TB gives ⟨tr g⟩ ≈ 0.037 (per-step link-discretized convention, /nk²) — 35× BELOW
the room-T-host lane's 2.87. AND our own files disagree by convention:
  - kagome_R4.py: int_trg = 0.061 (per-step / un-normalized)
  - geom-stiffness probe2: kagome ⟨tr g⟩ = 2.19 (claimed |dk|²-normalized BZ-average; "lieb_probe int_trg dropped 1/|dk|² factor")
  - this extraction: 0.037 (per-step, same family as kagome_R4 0.061)
→ the 35× gap is a NORMALIZATION-CONVENTION mismatch (per-plaquette link sum vs |dk|²-normalized continuum BZ-average),
NOT (only) a TB bug. CoSn 2.87 and the derived 128K rest ENTIRELY on the |dk|²-normalized convention being the one
that enters the Peotta-Törmä D_s = 4|U|ν(1-ν)·⟨g⟩ formula.
ALSO: my quick intrinsic-SOC term (diagonal sin) did NOT open the isolation gap (gap=0 across scan) — the proper
Guo-Franz imaginary-2nd-NN form is needed to isolate the C=1 flat band; the gapless-band metric is ill-defined.
VERDICT (d6): CoSn scalar ⟨g⟩ is UNVERIFIED — convention-ambiguous by 35×. the candidate-verification 128K (and the
whole ⟨g⟩→Tc ladder) inherits this ambiguity. CoSn STAYS GATED, and confidence in 2.87/128K is LOWERED pending:
  (1) a CONVENTION AUDIT — pin which ⟨g⟩ normalization is dimensionally correct in Peotta-Törmä D_s (the dimensionless
      BZ-average tr g(k) with g in units of a², averaged ∫d²k/A_BZ — reconcile kagome_R4 0.061 vs geom-stiffness 2.19),
  (2) a PROPER intrinsic-SOC (Guo-Franz) CoSn flat band (gap-opened, C=1) for the real metric, or DFT-Wannier.
this is the real next gate — a convention audit, not a pod. artifact state/fb-geom-lambda/cosn_gmetric.py

## UPDATE — convention audit RESOLVED (c2 catch → resolved)
The 35× = pure (2π)²/nk² discretization factor. dimensionless ⟨tr g⟩ = link_sum/(2π)² = 2.57 (kagome, this model),
matching geom-stiffness 2.19 (same ~2-3 class). |dk|²-normalized (geom-stiffness 2.19) = dimensionally-correct in
Peotta-Törmä D_s. CoSn ⟨g⟩~2-3 HOLDS; 128K does NOT collapse from a convention error.
Remaining CoSn gates (the REAL ones, not the convention): (1) DFT-Wannier scalar to pin ~2-3→a number; (2) SC pairing
channel — CoSn is paramagnetic / non-SC today (the actual blocker). ⟨g⟩ is no longer the open question.
