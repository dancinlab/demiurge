@title: ⚙️ QFORGE-PROCESS — "el-ph 공정 기록자" (the phonon assembly-line logbook)

@goal: capture the LIVE el-ph campaign pipeline flow stage-by-stage (vc-relax → scf → ph/DFPT → elph → λ → Tc) with measured wall/resource per stage, so the performance · resource · speed bottlenecks are auditable and improvement levers are found. NOT the engine (root QFORGE/) — this is the PROCESS observability + optimization domain.

icon ⚙️ · name QFORGE-PROCESS · alias "공정 기록자" (production-line logbook)

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

## 설계 SSOT
- pipeline = hexa-lang stdlib/cloud/dft_dispatch.hexa (vc-relax→scf→ph→lambda chain) · QE 7.x ph.x DFPT
- engine (the thing being profiled) = root QFORGE/ (QFORGE.md)
- live job manifest = ./pods.json (/lab control tower) · harvest inventory = RTSC_HARVEST_PARTIAL.jsonl
