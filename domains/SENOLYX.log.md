# SENOLYX — log

Append-only history sister of `SENOLYX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-07T04:35 — R12 B5 bottleneck quantified (summer RTX 5070 HREX throughput)

Empirical timing of the R12 ΔΔG validation run on summer (only reliable GPU — vast blocked by
B4 CUDA-PTX 222, openfe RBFE blocked by B3 conda hang).

- [x] 17AG complex leg HEALTHY but SLOW — `abfe_complex.nc` mtime fresh (04:34), GPU 243W/100%,
      yet ~8h in (`sampler.run (1000 iters)` since 20:39 KST) with NO `dG_decouple` printed yet.
- [x] `.nc` growth ~14KB / 3min → iterations crawling. R10b's FULL run (complex+solvent, 20 win ×
      1000 iter) converged in 4.95h; summer 5070 is empirically ~5–6× slower on identical protocol.
- [x] B5 (MD throughput) recorded in QFORGE.log.md — this entry adds the SENOLYX-side measured rate.
- [ ] R12 ΔΔG = dG_bind(17AG) − dG_bind(17AAG) vs ΔΔG_exp −1.9(quinone)/−0.65(hydroquinone):
      gated on MD completion (sequential 4-leg on single GPU, ETA many hours). Autonomous harvest
      scheduled (1h cadence) — harvest grep validated vs script line 259 output format.
- harvest constraint: let it finish (d_defer_no_delete) · no fabricate (d6/g63) · no vast (B4) ·
      no co-agent fleet touch.

