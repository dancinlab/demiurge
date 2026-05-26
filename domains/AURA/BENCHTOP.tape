#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# BENCHTOP.tape — architecture-current (editable per v1.2)
# Event history → BENCHTOP.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "benchtop" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Aura family · Stage-1+ hardware path (T4, out of RSC code-layer scope)"
  brief = "the region the verify/*.hexa RSC loop CANNOT close — external collab · funding · phantom-skull rig · in-vivo · regulatory. Code-layer reaches A–D (paper / FEM-tier / sim / hexa-native skeleton); the rest is hardware."
  parent = "dancinlab/hexa-aura"
  spec = "clip/doc/benchtop_v0_design.md (§A.6.1 stage A paper design)"
  sibling-log = "BENCHTOP.log.tape"

@L l1 := "benchtop-layout" :: structure [active]
  paper_design -> "clip/doc/benchtop_v0_design.md (stage A — BOM + ASCII block diagram + τ=4-lane interface table + bench safety spec)"
  sim_C -> "firmware/sim/coil_driver_sim.hexa + firmware/sim/watchdog_adc_sim.hexa (stage C — runnable sim-only, isolated from verify/)"
  skeleton_D -> "firmware/hdl/coil_timing_controller.hexa + firmware/mcu/watchdog_mcu.hexa (stage D — hexa-native compile-only, DEFERRED until board)"
  roadmap -> ".roadmap.hexa_aura §A.6 (Stage-1+ hardware path) + §A.6.1 (A→D pre-work order)"
  rtsc_dep -> "hexa-rtsc (foundational: RT-SC material is an unproven research claim, not procurement)"

@D d_stage_status := "§A.6.1 stage A–D status" :: decision [d=2026-05-15 active]
  stage_A = "DONE — clip/doc/benchtop_v0_design.md (paper design, docs-layer)"
  stage_B = "DONE (code-layer reach) — 9 FEM-tier scripts, 1D analytic-parity, green-gate deferred; full 3D Maxwell/bioheat/neuron-population FEM still needs rig-validation"
  stage_C = "DONE — firmware/sim/ ×2 (runnable hexa sim)"
  stage_D = "DONE (code half) — firmware/hdl/ + firmware/mcu/ hexa-native compile-only skeletons; hardware half gated on §A.6 step 4"
  note = "stages A–D exhaust the code-layer's reach. §A.6 steps 1–5 are T4 — NOT closable by cron/loop firing."

@D d_hexa_native_override := "stage D realized hexa-native" :: decision [d=2026-05-15 active]
  rule = "§A.6.1 table names firmware/hdl/*.v + firmware/mcu/*.rs; overridden to hexa-native .hexa per AGENTS.tape g2 (hexa-first) + 0-non-hexa discipline. 0 .v / 0 .rs / 0 .py."
  authority = "AGENTS.tape g2 · user-directed 2026-05-15"

@N n_hw_gates := "hardware-dependency → falsifier map" :: note [active]
  rtsc_tile = "RT-SC nano-coil tile fab (μ=1 µm litho) → blocks F-AURA-2 (2a/2b/2c); depends on hexa-rtsc material claim"
  phantom_skull = "tissue-equiv gel + 5 mm bone slab → blocks F-AURA-2b (through-bone SNR) + F-AURA-4c (ΔT real-measure)"
  meg_opm = "SQUID-MEG ~2–3 fT/√Hz or OPM ~7–15 fT/√Hz → blocks F-AURA-2b (read sensitivity)"
  tms_rig = "TMS figure-8 reference → blocks F-AURA-2a (write focal-gradient real-measure)"
  jaw_stage = "2.5 Hz jaw actuator + Ti/PEEK clip coupon → blocks F-AURA-1a/1b/1c"
  eeg_adc = "EEG front-end + ADC + real clinical EEG cohort → blocks F-AURA-4d (real watchdog ROC; the sim uses deterministic synthetic EEG)"
  mri_bench = "MRI bench (RF heating / displacement / artifact, IEC 60601 / ASTM F2503) → blocks F-AURA-4e"
  biocompat = "biocompat lab + cadaver-skull / NHP → blocks F-AURA-4a (Shannon charge density in real tissue) + the in-vivo path"

@N n_external_gates := "non-physical external gates" :: note [active]
  step1 = "external neuro-eng lab collab (rig access is via partner — you do not own the MEG/TMS rigs) — §A.6 step 1, ~2026-Q4, MOU"
  step2 = "funding round (RT-SC fab + phantom rig + MEG/OPM diagnostics) — §A.6 step 2, ~2027-Q1"
  step5 = "FDA/KFDA class III pre-sub → IDE → first-in-human; IRB — §A.6 step 5, ~2028+ (institutional, not buildable)"

@N n_honest_scope := "what BENCHTOP is / is NOT" :: note [active]
  is = "the structured SSOT of the §A.6 hardware path + the stage-A paper design — a tracking ledger, not a build."
  is_not = "NOT a built rig, NOT funded, NOT scheduled, NOT a verify/* target. Creating/editing this tape changes NO closure: F-AURA 15 sub-IDs stay OPEN; sat-1 / __HEXA_AURA_RSC_SATURATED__ STOP / falsifier_check 100% code-layer 3-tier unchanged."
  deepest_dep = "hexa-rtsc: 'a real room-temperature superconductor exists and is μ=1 µm-lithographable' is an open research problem, not procurement. If hexa-rtsc falsifies → F-AURA-2 DEMOTED (see COIL.tape @D d_rtsc_xlink)."

@X x_roadmap_a6 := ".roadmap.hexa_aura §A.6 / §A.6.1" :: roadmap [active]
  scope = "Stage-1+ hardware path (steps 1–5, T4) + A→D pre-work order"

@X x_hexa_rtsc := "hexa-rtsc" :: sibling-repo [active]
  url = "https://github.com/dancinlab/hexa-rtsc"
  scope = "RT-SC material substrate — the foundational hardware dependency for F-AURA-2"
