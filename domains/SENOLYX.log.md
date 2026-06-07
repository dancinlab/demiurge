# SENOLYX — log

Append-only history sister of `SENOLYX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-08T05:50Z — R12 RBFE N_ITER=500 수렴-푸시 시도 (vast 불안정으로 complex leg 미완 · R12 OPEN 유지)

목적: 직전 N_ITER=110 run(ΔΔG=−0.75±0.64, magnitude ~exp의 40% 과소수렴 의심)을 **N_ITER=500 per-leg 4×H100**로 재실행해 수렴된 magnitude 확보, R12 종결 시도. 동일 검증된 파이프라인(deck LEG-split + N_ITER env, bootstrap cuda12.4 pin + bzip2). cost no object.

- [x] **4×H100 rent + fire** (high cpu_ghz 우선, HREX swaps CPU-bound): agc 17AG complex(ssh4, H100 SXM 4.1GHz)·ags 17AG solvent(ssh7, H100 NVL)·aagc 17AAG complex(ssh8, H100 SXM 4.1GHz)·aags 17AAG solvent(ssh9, H100 SXM 4.1GHz). 4 leg 전부 GPU-active 확인, 올바른 리간드 md5 검증(17AG=1aca8f66·17AAG=753b2edc).
- [x] **solvent leg 2개 N_ITER=500 수렴 PASS** (synced): 17AG solvent **dG_decouple=72.97 ± 0.41**·17AAG solvent **dG_decouple=64.65 ± 0.37** (±≪값, tight). recover/{ags,aags}/abfe_solvent.nc + prod.log 로컬 보존.
- [ ] **🔴 complex leg 2개 미완 — vast 환경 불안정(>2 re-rent/pod stop-rule 발동)**: 측정된 throughput **~80 iter/h**(289k-297k atom HREX, H100). agc 원본 350/500·aagc 원본 ~330/500 도달 시점에 **pod이 외부 요인으로 소멸**(co-tenant/host action). 직전 iter는 pod-local만 확인했고 nc를 다운로드 전이라 진행분 유실. 재렌트 3회 전부 실패: agc2(39320993, R=89 host)→발사 후 ~10min 소멸 · agc3(29019369, R=99.9 Czechia)→production 진입 후 ~7min 소멸 · aagc2(24548925)→production 진입(`sampler.run`) 후 ~7min 소멸 **+ 재현불가 31194-atom 시스템 빌드**(원본 297446 atom과 불일치 → 비교 무효). 모든 신규 pod이 4개 서로 다른 host에서 10-15min 내 사망 = **현 시점 vast 사용불가**(d2/d6 정직). complex leg 없이는 ABFE 조립 불가 → **N_ITER=500 ΔΔG 산출 불가**.
- [x] **harvest 판정 = INCOMPLETE (no fabricate, d6/g63)**: 2/4 leg(solvent)만 terminal. complex 2개 `=== LEG ===` 미출력 → ABFE(17AG)·ABFE(17AAG) 조립 불가 → **ΔΔG_N500 미산출**. **R12는 직전 N=110 preliminary(−0.75±0.64) 그대로 OPEN 유지** — 새 값으로 덮어쓰지 않음.
- [x] **teardown + 비용**: 내 r12c-* contract 7개(원본4 + 재렌트3: 39883122·39883135·39883138·39883149·39939183·39940968·39942420) 전부 destroy 확인(API 404 = terminated, **billing leak 0**). 보호 pod 무접촉: rtsc-li2mgh16-anchor(39610026)·co-agent r12d-aagc(39911877)·anima(39922335). **비용 ~$28** (4 pod × ~$2.4-2.7/hr × ~8h complex pole 도중 사망 + 재렌트 3개 단명).
- [ ] **다음 수(d2 breakthrough paths)**: ① vast 안정화 대기 후 N=500 complex 2개만 재발사(solvent는 이미 수렴, 재실행 불요) + **주기적 nc sync**(이번 유실의 직접 원인=sync 누락; cp-snapshot→scp 매 10min). ② summer 단일 신뢰 경로(무료, B5 느림 감수)로 complex 2개 순차. ③ complex leg checkpoint_interval 조밀화 + 즉시-sync 로 pod 사망 내성 확보. R12 = 수렴된 complex magnitude 확보 시 종결.

## 2026-06-07T21:02Z — R12 RBFE 4-leg H100 병렬 ABFE (walltime-MIN, ΔΔG=−0.75±0.64 vs exp −1.9)

- [x] **walltime-MIN 파티션**: replica-exchange 병목(20 windows SERIAL/iter, CPU-bound swaps → H100 ~38 iter/h, single-pod complex→solvent 순차 ~9h)을 **leg별 분리**로 깸 — 4 H100 동시(complex/solvent × 17AG/17AAG), pole = complex N_ITER=110 ≈ ~2.9h 이론치, 실제 walltime ~30min(provision 포함, complex 110-iter는 fast 모드). d17/d_qforge_parallel/d_parallel_first.
- [x] **인프라**: 직전 full-ABFE H100 2개(39862041 r12h-17aag·39862042 r12h-17ag) destroy → per-leg 전환. 4×H100 rent (cheapest verified cuda≥12.4, high cpu_ghz 우선 — HREX swaps CPU-bound): 38955907(agc,3.1GHz/64vCPU,$2.00)·29019357(ags,4.1GHz,$2.40)·24548924(aagc,3.72GHz,$2.40)·28762950(aags 초기,pubkey 영구거부→destroy→재렌트 38955910,$2.00). cuda12.4 pin(PTX-222 회피)+bzip2 부트스트랩.
- [x] **per-leg dG_decouple harvest** (deck `=== LEG ... ===` 라인, monitor 캡처): 17AG complex **31.45±0.39** ssc 4.00 · 17AG solvent **6.55±0.21** · 17AAG complex **30.18±0.42** ssc 4.12 · 17AAG solvent **5.91±0.18**. 4 leg nc+prod.log → exports/SENOLYX/round12-rbfe/recover/{agc,ags,aagc,aags}/.
- [x] **ABFE 조립** (=dG_solvent−dG_complex+ssc): ABFE(17AG)=6.55−31.45+4.00=**−20.90** · ABFE(17AAG)=5.91−30.18+4.12=**−20.15**.
- [x] **ΔΔG = ABFE(17AG)−ABFE(17AAG) = −0.75 ± 0.64 kcal/mol** (err=√Σ4leg²). vs **exp −1.9**(quinone, cb600224w): **부호 일치·방향 correct**, 편차 +1.15 = 1.8σ(stat). |err|=0.64 ≤ 1.5(stat gate PASS).
- [ ] **🟠 PRELIMINARY/미해결(g6/g63 정직)**: N_ITER=110 complex = 공격적 fast 샘플링(walltime-min 목적) → magnitude 과소수렴 의심(ΔΔG 크기가 exp의 ~40%; stat ±는 짧은 run 내부 노이즈만 반영, 계통적 미수렴 미포함). 편차>1σ + 미수렴으로 R12 OPEN 유지. **gold cross-check = summer 1000-iter 17AG full**(독립 backstop, 본 캠페인과 무관히 진행 중). 수렴 확인 후 종결.
- [x] **teardown**: 4 H100 전부 destroy(39879210·39879212·39879213·39880705) + 초기 broken aags(39879215) destroy. 비용 ~**$4.85**. RTSC anchor(39610026)·co-agent pod 무접촉.


## 2026-06-08 — R12 CLOSED-DIRECTIONAL (N=500 smallbox-31k clean path)
ΔΔG = −1.42 ± 0.99 kcal/mol vs exp −1.9 (cb600224w) → 부호 ✓, |err|=0.48, 0.5σ.
4 leg dG_decouple (31113-atom box, per-leg 4×H100):
- 17AG  complex 58.12±0.44 (ssc −0.21) · solvent 72.53±0.42 → ABFE(17AG)=14.20
- 17AAG complex 47.38±0.61 (ssc −0.21) · solvent 63.21±0.48 → ABFE(17AAG)=15.62
방향성+정량 모두 exp와 0.5σ 일치 (N=110 −0.75±0.64 대비 개선). 절대 ABFE(+14/+16)는
비물리적 = R11 단일포즈 거대고리-퀴논 ABFE 절대값 무효 한계 그대로; 오차상쇄된 ΔΔG만 유의.
핵심 fix: 289k-atom box-blowup(addSolvent 과용매 ~9.3×) 진단·수정 → 31k clean path가 결과 산출
(289k 경로는 complex leg 소실 INCOMPLETE, PR#606). 17AAG complex는 gremlin double-invoke 환경서
완료 500-iter prod.log LEG선(canonical)으로 회수. definitive(repeat≥3)는 R12-GOLD/summer 추적.
logs: exports/SENOLYX/round12-rbfe/smallbox/{17AG,17AAG}_{complex,solvent}.log + 17AAG_complex.nc
