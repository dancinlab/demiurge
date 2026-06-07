# SENOLYX — log

Append-only history sister of `SENOLYX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-07T21:02Z — R12 RBFE 4-leg H100 병렬 ABFE (walltime-MIN, ΔΔG=−0.75±0.64 vs exp −1.9)

- [x] **walltime-MIN 파티션**: replica-exchange 병목(20 windows SERIAL/iter, CPU-bound swaps → H100 ~38 iter/h, single-pod complex→solvent 순차 ~9h)을 **leg별 분리**로 깸 — 4 H100 동시(complex/solvent × 17AG/17AAG), pole = complex N_ITER=110 ≈ ~2.9h 이론치, 실제 walltime ~30min(provision 포함, complex 110-iter는 fast 모드). d17/d_qforge_parallel/d_parallel_first.
- [x] **인프라**: 직전 full-ABFE H100 2개(39862041 r12h-17aag·39862042 r12h-17ag) destroy → per-leg 전환. 4×H100 rent (cheapest verified cuda≥12.4, high cpu_ghz 우선 — HREX swaps CPU-bound): 38955907(agc,3.1GHz/64vCPU,$2.00)·29019357(ags,4.1GHz,$2.40)·24548924(aagc,3.72GHz,$2.40)·28762950(aags 초기,pubkey 영구거부→destroy→재렌트 38955910,$2.00). cuda12.4 pin(PTX-222 회피)+bzip2 부트스트랩.
- [x] **per-leg dG_decouple harvest** (deck `=== LEG ... ===` 라인, monitor 캡처): 17AG complex **31.45±0.39** ssc 4.00 · 17AG solvent **6.55±0.21** · 17AAG complex **30.18±0.42** ssc 4.12 · 17AAG solvent **5.91±0.18**. 4 leg nc+prod.log → exports/SENOLYX/round12-rbfe/recover/{agc,ags,aagc,aags}/.
- [x] **ABFE 조립** (=dG_solvent−dG_complex+ssc): ABFE(17AG)=6.55−31.45+4.00=**−20.90** · ABFE(17AAG)=5.91−30.18+4.12=**−20.15**.
- [x] **ΔΔG = ABFE(17AG)−ABFE(17AAG) = −0.75 ± 0.64 kcal/mol** (err=√Σ4leg²). vs **exp −1.9**(quinone, cb600224w): **부호 일치·방향 correct**, 편차 +1.15 = 1.8σ(stat). |err|=0.64 ≤ 1.5(stat gate PASS).
- [ ] **🟠 PRELIMINARY/미해결(g6/g63 정직)**: N_ITER=110 complex = 공격적 fast 샘플링(walltime-min 목적) → magnitude 과소수렴 의심(ΔΔG 크기가 exp의 ~40%; stat ±는 짧은 run 내부 노이즈만 반영, 계통적 미수렴 미포함). 편차>1σ + 미수렴으로 R12 OPEN 유지. **gold cross-check = summer 1000-iter 17AG full**(독립 backstop, 본 캠페인과 무관히 진행 중). 수렴 확인 후 종결.
- [x] **teardown**: 4 H100 전부 destroy(39879210·39879212·39879213·39880705) + 초기 broken aags(39879215) destroy. 비용 ~**$4.85**. RTSC anchor(39610026)·co-agent pod 무접촉.

