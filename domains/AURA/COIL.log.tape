#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# COIL.log.tape — append-only event history (v1.2 split)
# Sibling: COIL.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A commit_495e30f :: coil [d=2026-05-15 ok]
  => "Cycle 3+4 closure-deepening: + verify/numerics_coil_fem.hexa (discretized on-axis Maxwell near-field, central-FD ∂B/∂z → analytic at O(h²); bone-decay + reciprocity) + verify/numerics_coil_fem_parity.hexa (vs exact Biot–Savart loop · TMS figure-8 · SQUID/OPM floor, g3/f1). RT-SC material claim still → hexa-rtsc. T2/T3 depth, NOT closure — F-AURA-2/2a/2b stay OPEN; green-gate deferred (run_all 19 unchanged); sat-1/STOP/100% code-layer 3-tier unchanged."
  |> "verify/numerics_fem_cross_pillar.hexa (coupled chain: RT-SC R=0 ⇒ safety thermal cap closes)"

@A commit_stageC :: coil [d=2026-05-15 ok]
  <- commit_495e30f
  => "Cycle 5 §A.6.1 stage C: + firmware/sim/coil_driver_sim.hexa — DAC→RL drive-chain sim (12-bit current DAC, µs write pulse, τ=4/200 Hz frame, ≤50 mW). Prototype of MCU firmware, NOT firmware; sim-only, no hardware-in-the-loop. ISOLATED in firmware/sim/ — not a verify/* script (not in run_all green core / lint / saturation). Firmware-sim layer NOT closure: F-AURA-2/2c stay OPEN; sat-1/STOP/100% code-layer 3-tier unchanged; T4 = §A.6."

@A commit_stageD :: coil [d=2026-05-15 ok]
  <- commit_stageC
  => "Cycle 6 §A.6.1 stage D: + firmware/hdl/coil_timing_controller.hexa — τ=4/200 Hz read-frame FSM + µs write-pulse slot + register map. HEXA-NATIVE (overrides the §A.6.1 Verilog plan per AGENTS.tape g2 hexa-first; 0 .v). COMPILE-ONLY structural skeleton, emits DEFERRED token (NOT __ PASS), NOT synthesised/flashed, NOT a sim. ISOLATED in firmware/hdl/. Deferred until board (§A.6 step 4, T4). NOT closure: F-AURA-2 stays OPEN; sat-1/STOP/falsifier_check unchanged."

@D d_rtsc_xlink :: coil [d=2026-05-15 active]
  <- commit_stageD
  => "§A.5 D2 RESOLVED: hexa-rtsc cross-link = single selftest cross-check (loose), NOT full numeric import — a full import would couple hexa-aura's green gate to another repo's runtime (violates never-PASS→FAIL / monotone). RT-SC material claim stays deferred to hexa-rtsc; F-AURA-2 DEMOTE-on-rtsc-falsify contract unchanged. Architecture recorded as @D d_rtsc_xlink in COIL.tape."
