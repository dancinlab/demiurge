#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# CORTEX.tape — architecture-current (editable per v1.2)
# Event history → CORTEX.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "cortex" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Aura family · pillar 3/4 · direct cortical read/write"
  brief = "σ=12 cortical target zones (A1·A2·V1-V6·S1·S2·M1·PFC·hipp-relay) · φ=2 directions (read/write) · τ=4 modes (sense·inject·sync·sleep) · sopfr=5 ms loop"
  parent = "dancinlab/hexa-aura"
  pillar_name = "HEXA-CORTICAL-IF"
  falsifier = "F-AURA-3"
  spec = "cortex/doc/cortical-interface.md"
  crosslink = "hexa-brain (working EEG/BMI pipeline) · hexa-mind (cognitive verbs, pending) · hexa-senses (5-senses verbs, pending)"
  sibling-log = "CORTEX.log.tape"

@L l1 := "cortex-pillar-layout" :: structure [active]
  spec -> "cortex/doc/cortical-interface.md (§0 lattice + §1 WHY + §2 COMPARE + §3 REQUIRES + §4 STRUCT + §5 FLOW + §6 VERIFY + §7 EVOLVE + §8 scope)"
  t1_calc -> "verify/calc_cortex.hexa"
  t2_numerics -> "verify/numerics_cortex.hexa"
  t2_solver -> "verify/numerics_cortex_solver.hexa (LIF neuron τ_m·dV/dt = −(V − V_rest) + R_m·I_inj)"
  t2_fem -> "verify/numerics_cortex_fem.hexa (Cycle 3 — discretized linear-cable operator residual on V0·exp(−|x|/λ) → 0 at O(h²); green-gate deferred)"
  t3_parity -> "verify/numerics_cortex_parity.hexa (cochlear-implant 22-ch · Argus-II/Orion 60 · Flesher-2016 ICMS · BrainGate-handwriting · speech-BCI 62-78 WPM)"
  t3_fem_parity -> "verify/numerics_cortex_fem_parity.hexa (Cycle 4 — vs Rall infinite-cable · cortical λ∈[0.5,1.0]mm · Mountcastle macrocolumn; g3/f1 parity; green-gate deferred)"
  fem_cross -> "verify/numerics_fem_cross_pillar.hexa (coupled-FEM cross-cutter — coil B(cortex) drives localized column; shared)"
  cli -> "cli/hexa-aura.hexa cortex"

@D d_zones := "sigma-12-cortical-zones" :: cortex [required active]
  rule = "σ(6) = 12 target zones: A1, A2, V1, V2, V4, V5, V6, S1, S2, M1, PFC, hippocampal-relay"
  why = "covers earbuds + AR glass + e-skin + exoskeleton + sleep-tracker substitution"
  authority = "cortex/doc/cortical-interface.md §0"

@D d_modes := "tau-4-operating-modes" :: cortex [required active]
  rule = "τ=4 operating modes: sense · inject · sync · sleep; taps 4 of n=6 cortical layers (II/III · IV · V · VI)"
  authority = "cortex/doc/cortical-interface.md §0"

@D d_latency := "sopfr-5ms-closed-loop" :: cortex [required active]
  rule = "≤ 5 ms closed-loop decode latency (feels instantaneous); ≤ 5 simultaneous high-bandwidth zones"
  authority = ".roadmap.hexa_aura §A.1"

@D d_scope := "scope-discipline-cortex" :: cortex [required active]
  rule = "this pillar = cortical I/O substrate only; decode ML → hexa-mind/hexa-brain; cognitive verbs (dream/telepathy/oracle) → hexa-mind; sensory verbs (ear/speak/empath/olfact) → hexa-senses"
  authority = "README.md §Scope discipline"

@D d_m1_lane := "cortex M1 motor-decode lane" :: decision [d=2026-05-15 active]
  rule = "cortex keeps the M1 read/write *substrate* lane (bounded by falsifier F-AURA-3d aggregate decode WPM); the decode *model* is deferred to hexa-brain."
  why = "consistent with the scope-discipline — this pillar owns cortical I/O physics, decode ML → hexa-mind/hexa-brain. Folding the decode model in here would duplicate hexa-brain's working pipeline."
  resolves = ".roadmap.hexa_aura §A.5 D3"
  ?> x_hexa_brain

@F f_aura_3a := "a1-cochlear-implant-parity" :: falsifier [active]
  status = "OPEN"
  claim = "A1 auditory injection cannot match cochlear-implant intelligibility (Cochlear Nucleus 22-ch parity)"
  closure = "T1 ✓ + T2 ✓ + T3 ✓ = 100% code-layer"

@F f_aura_3b := "v1v6-vs-argus-orion" :: falsifier [active]
  status = "OPEN"
  claim = "V1~V6 injection cannot exceed Argus-II / Orion (60-electrode) effective-pixel count"

@F f_aura_3c := "s1-haptic-vs-flesher-icms" :: falsifier [active]
  status = "OPEN"
  claim = "S1 haptic write cannot reach Flesher-2016 ICMS taxel density (e-skin replacement fails)"

@F f_aura_3d := "decode-wpm-vs-speech-bci" :: falsifier [active]
  status = "OPEN"
  claim = "aggregate read decode WPM stays below Willett/Metzger-2023 speech-BCI (≈62-78 WPM)"

@X x_roadmap := ".roadmap.hexa_aura §B.3" :: roadmap [active]
  scope = "F-AURA-3 sub-ID detail table"

@X x_hexa_brain := "hexa-brain" :: sibling-repo [active]
  url = "https://github.com/dancinlab/hexa-brain"
  scope = "working EEG/BMI pipeline — v1.1.0 cross-verify anchor"
