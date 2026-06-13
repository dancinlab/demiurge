# RTSC partial DFPT harvest (2026-06-01)

Per-deck `harvest_partial/` holds the COMPLETED ph.x DFPT q-point dynmats + ph.out
downloaded from the 16 phonon pods BEFORE the 2026-06-01 cost-teardown (29 vast pods
torn down; QE ph.x DFPT was the no-GPU bottleneck → bled cost without finishing).

Resume options (d_defer_no_delete — candidates stay in the pool):
1. QE-recover: re-fire a pod, place these + the outdir recover state, `recover=.true.`
   → QE ph.x continues from the completed q's.
2. QFORGE-GPU rerun: once QFORGE production engine (PWFORGE M5.7 + el-ph) ships,
   re-run atoms→|g|²→λ→Tc on GPU (fast) — does NOT consume these QE checkpoints
   (incompatible), but the material finishes quickly.

These dynmats are PARTIAL (no material reached full-q → el-ph → λ), so NOT terminal.
