#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# COIL.tape — architecture-current (editable per v1.2)
# Event history → COIL.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "coil" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Aura family · pillar 2/4 · RT-SC nano-coil transducer"
  brief = "planar RT-SC nano-coil tile · μ=1 μm pitch · σ²=144 ch/tile · J₂=24 ch/macro · n^τ=6⁴=1296-ch hex lattice · σ³=1728 virtual"
  parent = "dancinlab/hexa-aura"
  pillar_name = "HEXA-RT-SC-NANOCOIL"
  falsifier = "F-AURA-2"
  spec = "coil/doc/rt-sc-nanocoil.md"
  crosslink = "hexa-rtsc (critical — if hexa-rtsc falsified → F-AURA-2 DEMOTED)"
  sibling-log = "COIL.log.tape"

@L l1 := "coil-pillar-layout" :: structure [active]
  spec -> "coil/doc/rt-sc-nanocoil.md (§0 lattice + §1 WHY + §2 COMPARE + §3 REQUIRES + §4 STRUCT + §5 FLOW + §6 VERIFY + §7 EVOLVE + §8 scope)"
  t1_calc -> "verify/calc_coil.hexa"
  t2_numerics -> "verify/numerics_coil.hexa"
  t2_solver -> "verify/numerics_coil_solver.hexa (RL ODE L·dI/dt = V − R·I, persistent-current limit)"
  t2_fem -> "verify/numerics_coil_fem.hexa (Cycle 3 — discretized on-axis Maxwell near-field, central-FD ∂B/∂z → analytic at O(h²); green-gate deferred)"
  t3_parity -> "verify/numerics_coil_parity.hexa (Neuralink-N1 1024 · Utah 96 · Stentrode 16 · SQUID-MEG · OPM-MEG · TMS figure-8)"
  t3_fem_parity -> "verify/numerics_coil_fem_parity.hexa (Cycle 4 — vs exact Biot–Savart loop · TMS figure-8 · SQUID/OPM floor; g3/f1 parity; green-gate deferred)"
  fem_cross -> "verify/numerics_fem_cross_pillar.hexa (coupled-FEM cross-cutter — RT-SC R=0 ⇒ safety thermal cap closes; shared)"
  firmware_sim -> "firmware/sim/coil_driver_sim.hexa (Cycle 5 — §A.6.1 stage C: DAC→RL drive chain, µs pulse, ≤50 mW; sim-only, isolated from verify/)"
  firmware_hdl -> "firmware/hdl/coil_timing_controller.hexa (Cycle 6 — §A.6.1 stage D: τ=4/200 Hz FSM + µs pulse slot; hexa-native compile-only skeleton, DEFERRED until board)"
  cli -> "cli/hexa-aura.hexa coil"

@D d_pitch := "mu-1um-litho-pitch" :: coil [required active]
  rule = "μ(6) = 1 → 1 μm nano-coil lithography pitch (loop-to-loop)"
  why = "focal write requires μm-scale gradient sources; μ=1 anchors the litho process node"
  authority = "coil/doc/rt-sc-nanocoil.md §0"

@D d_channels := "sigma-sq-144-ch-per-tile" :: coil [required active]
  rule = "σ² = 144 bidirectional channels / tile (12×12 micro-grid); J₂ = 24 ch / macro-tile; n^τ = 1296-ch hex"
  why = "Neuralink-N1 1024-ch parity·+ without craniotomy"
  authority = "coil/doc/rt-sc-nanocoil.md §0"

@D d_directions := "phi-2-read-write" :: coil [required active]
  rule = "φ=2 directions per channel — pick-up loop (read, MEG-class fT) + drive loop (write, TMS-class focal E-field); time-shared τ=4 phases"
  authority = ".roadmap.hexa_aura §A.1"

@D d_rtsc_xlink := "hexa-rtsc cross-link strength" :: decision [d=2026-05-15 active]
  rule = "coil ↔ hexa-rtsc coupling is a single `selftest` cross-check (loose), NOT a full numeric import."
  why = "a full import would make hexa-aura's green gate depend on another repo's runtime — violates the never-PASS→FAIL / monotone invariant (§A.6.1) and the green-core isolation discipline. RT-SC material claim stays deferred to hexa-rtsc (if it falsifies, F-AURA-2 is DEMOTED)."
  resolves = ".roadmap.hexa_aura §A.5 D2"
  ?> x_hexa_rtsc

@F f_aura_2a := "rtsc-tile-focal-gradient" :: falsifier [active]
  status = "OPEN"
  claim = "μ=1 μm pitch RT-SC tile cannot reach ∂B/∂x focal gradient TMS-class cortical write needs"
  closure = "T1 ✓ + T2 ✓ + T3 ✓ = 100% code-layer"

@F f_aura_2b := "tile-read-snr-vs-opm" :: falsifier [active]
  status = "OPEN"
  claim = "σ²=144 ch/tile read SNR is below OPM-MEG (≈15 fT/√Hz) noise floor through 5 mm bone"

@F f_aura_2c := "coil-power-thermal-budget" :: falsifier [active]
  status = "OPEN"
  claim = "coil switching power dissipates > 3.6 g clip thermal budget allows (ΔT > 0.5 K at scalp)"

@X x_roadmap := ".roadmap.hexa_aura §B.2" :: roadmap [active]
  scope = "F-AURA-2 sub-ID detail table"

@X x_hexa_rtsc := "hexa-rtsc" :: sibling-repo [active]
  url = "https://github.com/dancinlab/hexa-rtsc"
  scope = "RT-SC material substrate — F-AURA-2 critical external dependency"
