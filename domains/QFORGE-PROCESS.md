@title: ⚙️ QFORGE-PROCESS — "el-ph 공정 기록자" (the phonon assembly-line logbook)

@goal: capture the LIVE el-ph campaign pipeline flow stage-by-stage (vc-relax → scf → ph/DFPT → elph → λ → Tc) with measured wall/resource per stage, so the performance · resource · speed bottlenecks are auditable and improvement levers are found. NOT the engine (root QFORGE/) — this is the PROCESS observability + optimization domain.

icon ⚙️ · name QFORGE-PROCESS · alias "공정 기록자" (production-line logbook)
**부모(parent)**: 🔨 QFORGE (engine · `QFORGE/QFORGE.md`) · siblings: 🚀 QFORGE-PERF · 🧰 QFORGE-FEATURE

- 하는 일: QE el-ph 파이프라인이 실제로 어떻게 흐르고 어디서 시간·자원을 쓰는지 단계별로 기록 → 개선 레버 발굴
- 비유: 공장 컨베이어 벨트 옆에서 "어느 공정이 느린가" 스톱워치로 재는 관리자
- 비교: root QFORGE/ = 엔진 자체(부품 제작) · QFORGE-PROCESS = 그 엔진이 돌 때의 공정 계측·최적화

## pipeline flow (the QE el-ph chain `hexa cloud dft-run` runs)

```
vc-relax ──▶ scf(k-mesh) ──▶ ph.x DFPT ──────────────────────▶ lambda.x ──▶ Tc
 (ions      (ground-state    [per IBZ q:                        (a2F→λ,      (Allen-Dynes
  relax)     ρ, ~min-hr)       per irrep perturbation:           ω_log)       · Eliashberg)
                               Sternheimer/ddv_scf SCF iter loop]
                              → dynN + elph.N per q  ← DOMINANT COST (hr-day)
```

## bottleneck axes (perf · resource · speed) — the reason this domain exists

| axis | observed bottleneck | improvement lever |
|---|---|---|
| 성능 perf | ph.x per-q linear-response (Sternheimer) SCF is CPU-bound, dominates wall | GPU accel — NVPTX kernels (fft3·eigh·davidson·sternheimer·a2F BZ-sum) = the migration/QFORGE-PERF track |
| 자원 resource | each q `_ph0` scratch 5–18 GB · SCF `.save` NOT banked → dead pod = fresh rerun · ecut→OOM | bank `.save` for true resume · resource-sizing table (atoms→GB) · ecut tuning (Li2MgH16 60/480) |
| 속도 speed | q-points INDEPENDENT but run SEQUENTIALLY within one pod (ph.x walks q1→q2→…) | parallel-q dispatch (split q-grid across pods) · start_q salvage · walltime-window chaining |
| 공정 friction | tooling gaps stalled the campaign (scp-255 · corrupt-recover · hostport-lag) | all 3 fixed this session (PR#2451/2453/2459/2460 + inbox) — friction removed |

## progress milestones
- [ ] per-stage timing instrumentation — capture scf/ph/elph/lambda wall + cpu per deck into the lab ledger
- [ ] dominant per-q DFPT cost driver identified (irrep count × iter × |G+k| basis size) — measured, not guessed
- [ ] parallel-q dispatch design — split a 2×2×2 q-grid across N pods, collect dynN, run lambda.x on the union
- [ ] GPU accel lever quantified — NVPTX el-ph kernel CPU-parity g5 → measured speedup vs CPU-first vast offer
- [ ] resource-sizing table — atoms → {PW basis, per-rank GiB, _ph0 GB, walltime} from observed runs (anchor: LaH10 11at, Li2MgH16 38at)
- [ ] end-to-end pipeline ledger (deck→Tc single entry) — one record per full run: deck · commit · pod · per-stage wall/RAM/GPU · final λ·Tc — why: telemetry emits per-stage but no unified deck→Tc record — gate: a completed run → one queryable JSONL with all stages + result
- [ ] GPU-vs-CPU per-stage cost model — extend the #2706 cost-driver with the GPU kernels (assembler always · Sternheimer above N_basis · SCF?) — why: blind GPU offload wastes launch overhead on tiny stages — gate: a measured crossover table (stage × size → CPU|GPU)
- [ ] auto-sizing dispatcher — predict {RAM/rank, cores, GPU-VRAM, walltime} from the sizing table and auto-pick the pod --query — why: manual --query guessing wasted 2 rents this session (RAM-clamp) — gate: predicted -np matches the observed clamp within ±1 on the 4 anchors
- [ ] per-kernel roofline profiler — each GPU kernel vs Blackwell peak (α²F exp-bound 138 GFLOP/s · Sternheimer matvec-bound) — why: #2717 found the α²F exp-bound by hand; automate it — gate: roofline per kernel with the binding resource named
- [ ] cost-per-Tc economics metric — $ and wall-time per converged Tc per candidate — why: free-pool vs paid-GPU tradeoff is ad-hoc — gate: ledger columns $/Tc + wall/Tc per harvested candidate
- [ ] multi-pod q-split runtime orchestrator — lab-dispatch wiring of parallel-q (#2709 is the primitive): fan a q-grid across N pods, monitor, collect dynN, union→λ — why: #2709 proved the math, the runtime dispatch isn't wired — gate: a real 2-pod q-split run unions to the same λ as 1-pod
- [ ] convergence early-stop predictor — detect non-converging/diverging runs early (residual trend) and abort to save compute — why: Picard-NaN + recover-EOF crashes burned pod-hours before detection — gate: flags a known-divergent run ≥2× sooner than walltime
- [ ] closed-loop autonomous candidate selection — lab-auto picks the NEXT candidate by expected-Tc/cost (not FIFO) — why: current campaign is hand-seeded; a closed loop maximizes discovery rate — gate: the selector orders a candidate pool by an expected-Tc score with a stated prior

## 설계 SSOT
- pipeline = hexa-lang stdlib/cloud/dft_dispatch.hexa (vc-relax→scf→ph→lambda chain) · QE 7.x ph.x DFPT
- engine (the thing being profiled) = root QFORGE/ (QFORGE.md)
- live job manifest = ./pods.json (/lab control tower) · harvest inventory = RTSC_HARVEST_PARTIAL.jsonl
