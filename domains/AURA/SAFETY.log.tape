#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# SAFETY.log.tape — append-only event history (v1.2 split)
# Sibling: SAFETY.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A commit_495e30f :: safety [d=2026-05-15 ok]
  => "Cycle 3+4 closure-deepening: + verify/numerics_safety_fem.hexa (discretized 1D Pennes operator residual on ΔT0·exp(−r/L_th) → 0 at O(h²); ΔT0 ≤ φ/τ=0.5 K cap) + verify/numerics_safety_fem_parity.hexa (vs Pennes-1948 · brain k · perfused-tissue L_th · CEM43/ICNIRP, g3/f1 parity-or-safer). T2/T3 depth, NOT closure — F-AURA-4/4b/4c stay OPEN; green-gate deferred (run_all 19 unchanged); sat-1/STOP/100% code-layer 3-tier unchanged. T4 (SAR/thermal/regulatory) still §A.6, out of scope."
  |> "verify/numerics_fem_cross_pillar.hexa (coupled chain: SAR_design ⇒ Pennes ΔT_ss ≤ 0.5 K)"

@A commit_stageC :: safety [d=2026-05-15 ok]
  <- commit_495e30f
  => "Cycle 5 §A.6.1 stage C: + firmware/sim/watchdog_adc_sim.hexa — EEG-watchdog ADC→detector sim (16-bit ADC ≥1 kS/s, sliding-window energy detector, deterministic synthetic burst, μ=1→1% FAR floor, λ=2 redundant lanes). Prototype of MCU watchdog firmware, NOT firmware; sim-only. ISOLATED in firmware/sim/ — not a verify/* script. Firmware-sim layer NOT closure: F-AURA-4/4d stay OPEN; sat-1/STOP/100% code-layer 3-tier unchanged; T4 (real-EEG ROC) = §A.6."

@A commit_stageD :: safety [d=2026-05-15 ok]
  <- commit_stageC
  => "Cycle 6 §A.6.1 stage D: + firmware/mcu/watchdog_mcu.hexa — init→sample→eval→trip control-loop FSM + λ=2 redundant lanes + IRQ/register map. HEXA-NATIVE (overrides the §A.6.1 Rust/C plan per AGENTS.tape g2 hexa-first; 0 .rs). COMPILE-ONLY structural skeleton, emits DEFERRED token (NOT __ PASS), NOT target-compiled/flashed, NOT a sim. ISOLATED in firmware/mcu/. Deferred until board (§A.6 step 4, T4). NOT closure: F-AURA-4 stays OPEN; sat-1/STOP/falsifier_check unchanged."
