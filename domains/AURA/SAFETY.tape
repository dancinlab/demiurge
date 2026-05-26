#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# SAFETY.tape — architecture-current (editable per v1.2)
# Event history → SAFETY.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "safety" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Aura family · pillar 4/4 · current-density / SAR / heating / seizure / no-craniotomy cap"
  brief = "Shannon k≤1.5 · SAR≤φ=2 W/kg · ΔT≤φ/τ=0.5 K · watchdog FAR≤μ=1% · coating φ·σ=24 yr · MRI-conditional · external-only μ=1 mm clearance"
  parent = "dancinlab/hexa-aura"
  pillar_name = "HEXA-CORTICAL-SAFETY"
  falsifier = "F-AURA-4"
  spec = "safety/doc/cortical-safety.md"
  sibling-log = "SAFETY.log.tape"

@L l1 := "safety-pillar-layout" :: structure [active]
  spec -> "safety/doc/cortical-safety.md (§0 lattice + §1 WHY + §2 COMPARE + §3 REQUIRES + §4 STRUCT + §5 FLOW + §6 VERIFY + §7 EVOLVE + §8 scope)"
  t1_calc -> "verify/calc_safety.hexa"
  t2_numerics -> "verify/numerics_safety.hexa"
  t2_solver -> "verify/numerics_safety_solver.hexa (Pennes bioheat ρc·dT/dt = q_gen − w_b·ρ_b·c_b·(T − T_a))"
  t2_fem -> "verify/numerics_safety_fem.hexa (Cycle 3 — discretized 1D Pennes operator residual on ΔT0·exp(−r/L_th) → 0 at O(h²); green-gate deferred)"
  t3_parity -> "verify/numerics_safety_parity.hexa (ICNIRP-2020 · IEEE-C95.1-2019 · Shannon-1992 · McCreery · CEM43 · Rossi-2009 · ASTM-F2503 · IEC-60601)"
  t3_fem_parity -> "verify/numerics_safety_fem_parity.hexa (Cycle 4 — vs Pennes-1948 · brain k · perfused-tissue L_th · CEM43/ICNIRP; g3/f1 parity; green-gate deferred)"
  fem_cross -> "verify/numerics_fem_cross_pillar.hexa (coupled-FEM cross-cutter — SAR_design ⇒ Pennes ΔT_ss ≤ φ/τ=0.5 K; shared)"
  firmware_sim -> "firmware/sim/watchdog_adc_sim.hexa (Cycle 5 — §A.6.1 stage C: ADC→seizure detector, μ=1→1% FAR floor, λ=2 lanes; sim-only, isolated from verify/)"
  firmware_mcu -> "firmware/mcu/watchdog_mcu.hexa (Cycle 6 — §A.6.1 stage D: init→sample→eval→trip FSM, λ=2 lanes, IRQ/reg map; hexa-native compile-only skeleton, DEFERRED until board)"
  cli -> "cli/hexa-aura.hexa safety"

@D d_shannon := "shannon-k-le-1.5" :: safety [required active]
  rule = "induced charge density factor k ≤ sopfr/τ = 5/4 = 1.25 → rounded design target ≤ 1.5 (Shannon 1992 damage line at k ≈ 1.85)"
  authority = "Shannon 1992 + McCreery; safety/doc/cortical-safety.md §0"

@D d_sar := "sar-2w-per-kg-local" :: safety [required active]
  rule = "local 10 g-avg SAR ≤ φ(6) = 2 W/kg (ICNIRP-2020 / IEEE-C95.1-2019 head/trunk local limit)"
  authority = "ICNIRP-2020 + IEEE-C95.1-2019"

@D d_heating := "delta-t-0.5k" :: safety [required active]
  rule = "steady-state tissue heating ΔT ≤ φ/τ = 0.5 K at scalp/cortex (CEM43 thermal-dose conservative)"
  authority = "CEM43 + Pennes bioheat"

@D d_watchdog := "watchdog-far-1pct" :: safety [required active]
  rule = "EEG-watchdog seizure-detection false-alarm rate ≤ μ(6) = 1% at clinical sensitivity; τ=4 watchdog tiers; λ=2 redundant lanes"
  authority = ".roadmap.hexa_aura §A.1 + §B.4"

@D d_external := "no-craniotomy-external-only" :: safety [required active]
  rule = "external-only μ=1 mm minimum skin clearance · zero implanted material · MRI-conditional (IEC 60601-1 / ASTM F2503)"
  authority = "safety/doc/cortical-safety.md §0"

@F f_aura_4a := "shannon-k-exceed" :: falsifier [active]
  status = "OPEN"
  claim = "continuous-wear induced charge density exceeds Shannon k≤1.5 (and k≤1.85) cortical damage limit"
  closure = "T1 ✓ + T2 ✓ + T3 ✓ = 100% code-layer"

@F f_aura_4b := "sar-exceed-icnirp" :: falsifier [active]
  status = "OPEN"
  claim = "local 10 g-avg SAR exceeds ICNIRP-2020 / IEEE-C95.1-2019 2 W/kg at F-AURA-2 write field strengths"

@F f_aura_4c := "heating-exceed-0.5k" :: falsifier [active]
  status = "OPEN"
  claim = "scalp/cortex steady-state heating exceeds ΔT ≤ 0.5 K (CEM43 thermal-dose) limit"

@F f_aura_4d := "watchdog-roc-insufficient" :: falsifier [active]
  status = "OPEN"
  claim = "EEG-watchdog seizure-detection ROC cannot reach the μ=1 → 1% false-alarm floor at clinical sensitivity"

@F f_aura_4e := "mri-conditional-fail" :: falsifier [active]
  status = "OPEN"
  claim = "device is not MRI-conditional (RF heating / displacement-force / image-artifact fails IEC 60601 / ASTM F2503)"

@X x_roadmap := ".roadmap.hexa_aura §B.4" :: roadmap [active]
  scope = "F-AURA-4 sub-ID detail table"
