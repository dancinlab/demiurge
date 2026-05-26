#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# CORTEX.log.tape — append-only event history (v1.2 split)
# Sibling: CORTEX.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A commit_495e30f :: cortex [d=2026-05-15 ok]
  => "Cycle 3+4 closure-deepening: + verify/numerics_cortex_fem.hexa (discretized linear-cable operator residual on V0·exp(−|x|/λ) → 0 at O(h²); σ=12-zone selectivity) + verify/numerics_cortex_fem_parity.hexa (vs Rall infinite-cable · cortical λ∈[0.5,1.0]mm · Mountcastle macrocolumn, g3/f1). Decode side still → hexa-mind/hexa-brain. T2/T3 depth, NOT closure — F-AURA-3/3a/3b/3c stay OPEN; green-gate deferred (run_all 19 unchanged); sat-1/STOP/100% code-layer 3-tier unchanged."
  |> "verify/numerics_fem_cross_pillar.hexa (coupled chain: coil B(cortex) drives localized column)"

@D d_m1_lane :: cortex [d=2026-05-15 active]
  <- commit_495e30f
  => "§A.5 D3 RESOLVED: cortex keeps the M1 read/write *substrate* lane (bounded by F-AURA-3d aggregate decode WPM); the decode *model* is deferred to hexa-brain. Consistent with scope-discipline (substrate here, decode ML → hexa-mind/hexa-brain). Architecture recorded as @D d_m1_lane in CORTEX.tape."
