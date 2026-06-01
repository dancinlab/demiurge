# QFORGE-PROCESS — work log (append-only)

## 2026-06-02 — domain created · seeded with live el-ph campaign observations
- Created to make the QE el-ph pipeline (vc-relax→scf→ph/DFPT→elph→λ→Tc) observable so perf/resource/speed bottlenecks are auditable. Sibling to root QFORGE/ (engine) — this is the PROCESS-profiling domain.

### live timing observations (direct pod probe, QFORGE migration-gate anchors)
- **LaH10** (11 atoms, 2×2×2 q, pod 38943553 vast CPU-first): ph.x stage = DFPT `Self-consistent Calculation`, `Pert. #1 iter #1`, total cpu 2290 s, `|ddv_scf|²=3.86e-08`. 9× ph.x ranks alive, pw.x=0. dynN done = 1 (q1 only). `out/_ph0` present.
- **Li2MgH16** (38 atoms, 2×2×2 q, pod 38922322 vast CPU-first): ph.x `Pert. #1 iter #4`, total cpu 11413 s, `|ddv_scf|²=2.96e-10` (converging a perturbation). 6× ph.x ranks alive, pw.x=0. dynN done = 1.
- **Reading:** the per-q DFPT self-consistency (Sternheimer linear response, the `ddv_scf` SCF loop per irreducible perturbation) is the DOMINANT wall — hours per q. scf/relax finished earlier (minutes-hours). 38-atom Li2MgH16 per-iter cpu ~5× the 11-atom LaH10 (11413 vs 2290 s) — cost scales steeply with atom count / basis.

### process-friction tooling gaps hit + fixed this session (campaign speed-killers)
- scp-255 on proxy-only vast direct endpoint (re-picked same broken offer) → FIXED: hexa-lang PR#2451 (proxy-fallback) + #2453 (durable offer-blacklist).
- corrupt phonon-recover (`PARSE_ERR/runParser` on a half-written `_ph0/q_N/*.save` after a teardown-kill) → ph.x SIGABRT, dft-run nuked the whole pod losing completed q → FIXED: PR#2459/#2460 (detect class → delete corrupt per-q scratch → start_q recompute, preserve completed dynN, 1-attempt guard).
- `--detach` HostPort-map lag → unregistered billing orphan + stale-state re-read → 3 first-attempt pods torn down clean; filed hexa-lang inbox/patches/dft-run-detach-hostport-lag-orphan.md.

### identified improvement levers (→ milestones in the snapshot)
- speed: q-points are independent yet run SEQUENTIALLY within one pod → parallel-q dispatch across pods is the biggest untapped wall-clock win.
- perf: ph.x el-ph is CPU-bound → GPU NVPTX kernels (QFORGE-PERF / migration track) are the per-q-cost lever.
- resource: SCF `.save` not banked → a dead pod forces a full fresh rerun; banking `.save` would enable true resume.
- next: instrument per-stage wall/cpu into the lab ledger so these are MEASURED, not anecdotal.
