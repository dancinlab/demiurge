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
- [x] resource-sizing table — atoms → {PW basis, per-rank GiB, _ph0 GB, walltime} from observed runs. **DONE 2026-06-05**: 4 gate-anchor rows grepped from `exports/rtsc/<cand>/harvest_final/{scf.out,ph.out}` — CaH6 (7at, TERMINAL) · LaH10 (11at) · ScH9 (10at) · Li2MgH16 (38at). **Key finding (d6, observed): RAM-per-rank, not core count, is the binding constraint for large cells — the 38-atom Li2MgH16 ran on only -np 6 MPI ranks despite a 64-vCPU/128-GiB pod (d11 preflight clamp: per-rank mem-budget, not cores). See "resource-sizing table" + LEVER row below.**

## resource-sizing table — gate-anchor observed runs (d11 pre-rent feasibility · d7 compute tiers)

Built FROM the RTSC QFORGE cross-val gate anchors harvested on disk (`d_qforge_xval_archive`),
NOT estimates. Every number is grepped from each anchor's
`exports/rtsc/<cand>/harvest_final/{scf.out,ph.out}` (PW basis = dense-grid G-vectors · per-rank /
total dynamical RAM · SCF/PH wall = QE's own `WALL` summary). The `_ph0` scratch column is the ONLY
estimate (the harvest banked the LIGHT xval set only — heavy `_ph0/{dvscf,wfc}` dropped per
`d_qforge_xval_archive`), explicitly labeled `(est.)`. `status` marks terminal vs in-flight (d6 honesty).

| candidate | atoms | ecut wfc/rho (Ry) | PW basis (dense G-vec) | RAM/rank (MiB) | total RAM | MPI ranks (-np) | SCF wall | PH wall (observed) | _ph0 (est.) | status |
|---|---|---|---|---|---|---|---|---|---|---|
| **CaH6**     |  7 | 80 / 320 | 13 451 | 94.8 scf / 4.5 ph | 663.6 MB | **7** | 3 m 49 s | **7 h 33 m** (8/8 q) | ~3–8 GB/q (est.) | 🟢 **TERMINAL** — `JOB DONE`, 8/8 q, dyn1–8 + elph.1–8 banked |
| LaH10        | 11 | 80 / 800 | 73 001 | 139.9 scf / 760 ph† | 1.23 GB | 9 | 4 m 12 s | 7 h 13 m (q4–8, 5/8 q this run) | ~8–18 GB/q (est.) | 🟡 in-flight — dyn1–5 + elph.1–5 banked, q6–8 pending |
| ScH9         | 10 | 80 / 640 | 49 839 | 106.0 scf / 206 ph† | 953.7 MB | 9 | 6 m 02 s | 5 h 05 m (q3–8, 6/8 q this run) | ~6–12 GB/q (est.) | 🟡 in-flight — dyn1–3 + elph.1–3 banked, q4–8 pending |
| **Li2MgH16** | 38 | 60 / 480 | 90 777 | **145.9** scf | 875.4 MB | **6** ⚠ | 7 m 13 s | grinding q1 (≈8.3 h CPU into 1st q, no dyn/elph yet) | ~15–40 GB/q (est.) | 🟡 in-flight — **MEMORY-CLAMP anchor** (see LEVER) |

† LaH10 / ScH9 ph-stage RAM is the per-q ph.x `Estimated total dynamical RAM` (760 MB / 206 MB) — total, not per-rank.

### 🔑 LEVER (observed 2026-06-05) — for large cells the limit is RAM-per-rank, NOT cores

> **A 64-vCPU / 128-GiB pod ran Li2MgH16 (38 atoms) on only `-np 6`.** The `hexa cloud dft-run` d11
> preflight clamped MPI ranks to **6** because each rank's working set (DFPT `dvscf` + wfc + the dense
> ~90 777-PW / 480-Ry charge grid × 38 atoms × n_modes) hit the **per-rank memory budget**, NOT the
> core ceiling. Preflight reported (per the 2026-06-05 dft-run d11 log) **~1 606 395 PW basis · per-rank
> ~10 GiB vs 64-GiB floor → -np clamped to 6 (mem-budget sweet-spot)**; the harvested `scf.out` confirms
> the run executed on **6 MPI ranks** (`Parallel version (MPI), running on 6 processors`). Note the
> preflight's ~1.6 M-PW estimate is the *worst-case dense-FFT* sizing that drove the clamp decision;
> the actual converged run used a 90 777-G-vec dense grid at the clamped `-np 6`.
>
> **Implication:** above ~20 atoms, throwing MORE CORES at one ph.x process buys nothing — a 64-core
> pod clamped to `-np 6` is no faster than a 6-core pod. The two real levers are:
> 1. **higher RAM-per-core pod** (raise the per-rank budget → unclamp `-np`), or
> 2. **q / irrep split** (the q-points are independent — dispatch q1…q8 across N small pods, then union
>    the `dynN`; see the `parallel-q dispatch` milestone), which sidesteps the single-pod RAM wall entirely.
>
> This inverts the small-cell rule: for CaH6 / LaH10 / ScH9 (7–11 atoms, < 1.3 GB total) RAM is ample and
> the binding cost is **PH WALL** (q-count × irreps × Sternheimer iters × |G+k|, the 5–8 h tails above);
> for ≥~20-atom cells the binding cost flips to **RAM-per-rank** before wall even matters.

### sizing rule (derived from the four anchors)
- **PW basis ≈ dense-grid G-vector count** scales with `atoms × ecutrho^{1.5}` — 320 Ry/7 at → 13 451 G;
  800 Ry/11 at → 73 001 G; 480 Ry/38 at → 90 777 G (lower ecut on the big cell offsets the atom count).
- **per-rank RAM is flat (~95–146 MiB) across all four** at these `-np`; total RAM = per-rank × ranks, so
  the way RAM bites a big cell is the **rank clamp**, not a per-rank blow-up — Li2MgH16's 145.9 MiB/rank
  looks tame, but the d11 preflight's denser worst-case sizing (~10 GiB/rank projected) is what forced `-np 6`.
- **d7 tier map (confirmed):** 7–11-atom anchors (CaH6/LaH10/ScH9) → pool-free / Vast CPU (RAM trivial,
  wall is the cost); **≥20-atom (Li2MgH16) → high-RAM-per-core pod OR q-split**, never a high-core CPU pod.

### provenance
- CaH6:     `exports/rtsc/CaH6/harvest_final/{scf.out,ph.out}` (git d42e46fa · TERMINAL)
- LaH10:    `exports/rtsc/LaH10/harvest_final/{scf.out,ph.out}` (5/8 q co-archived)
- ScH9:     `exports/rtsc/ScH9/harvest_final/{scf.out,ph.out}` (6/8 q co-archived · d_pool_fixed)
- Li2MgH16: `exports/rtsc/Li2MgH16/harvest_final/{scf.out,ph.out}` (scf terminal · ph grinding q1 · -np 6)
- d11 mem-clamp preflight figure (~1.6M PW · ~10 GiB/rank · -np 6): the 2026-06-05 `dft-run` preflight
  log (ephemeral preflight output) — the on-disk `scf.out` corroborates the `-np 6` execution.

## 설계 SSOT
- pipeline = hexa-lang stdlib/cloud/dft_dispatch.hexa (vc-relax→scf→ph→lambda chain) · QE 7.x ph.x DFPT
- engine (the thing being profiled) = root QFORGE/ (QFORGE.md)
- live job manifest = ./pods.json (/lab control tower) · harvest inventory = RTSC_HARVEST_PARTIAL.jsonl
