<!-- HANDOFF: parent appends this block to the shared domains/rtsc.log.md (the shared working tree).
     This isolated lane is off branch qforge/pbe-scf-vertex and must not touch the shared uncommitted
     rtsc.md/rtsc.log (d9 index isolation). Also flip the relevant rtsc.md QFORGE migration-gate line. -->

## 2026-06-16 · residual-(3) 3-D PBE ground state → screened vertex — 🔴🧱 from-scratch gate-grade WALL (engine memory-model 잔차, 0-pod)

- **레버 = residual-(3) 정면돌파**: 2026-06-09 PBE-SCF verdict가 명명한 깊은 잔차((1,1,n) 1-D G-라인 밀도 = 비물리적 3-D ∇ρ)를, 진짜 **3-D 실공간 spin-GGA SCF**(`gga_scf.hexa`)를 CaH6 from-scratch 차폐정점에 배선해 테스트. branch `qforge/pbe-scf-vertex`.
- **배선 + 직전 WIP 버그 FIX (d3/d4)**: `gga_scf` 에 converged 3-D-PBE dense H export(`GGA_HCONV`+`qforge_gga_hconv()`) + **millers-EXPLICIT 변형 `qforge_scf_pw_gga_spin_mil`** 추가 — CaH6 BCC 역격자가 **특이(det(B)=0, b1/b2/b3 공면)** 라 `qforge_miller_of_g`→[] → "index 0 out of bounds" (직전 WIP 가 막혔던 정확한 버그). `qpw_gvectors_miller` 의 정수 (h,k,l) 를 직접 carry 해 해결. `pw_frontend` 에 `qpw_set_pbe3d` 토글 + gga 를 **먼저**(fresh globals) 돌려 H install, pbe3d engage 시 (1,1,n) line SCF **완전 분기 제외**.
- **VERBATIM (d6, 4.376 강제 안 함)**: **3-D PBE 바닥상태는 정확히 계산됨** (CaH6 실셀, $0 local): npw64 nonlocal e_total=−19.8706 Ha · npw16 nonlocal **converged** e_total=−11.8584 Ha · m=0 (비자성, 물리적으로 정확) · hconv=n² 검증 · `qpw_pbe3d_engaged()=true`. **= residual-(3) 가 바닥상태 수준에서 RESOLVED** (진짜 3-D ∇ρ, 1-D 프록시 아님, pow2-fallback-to-LDA 아님).
- **λ_QFORGE(3-D PBE vertex) = 측정불가 (in-process SIGSEGV exit138)**: 3-D-PBE H install 후 같은 프로세스서 차폐정점 DFPT/Sternheimer/qforge_run contraction 돌면 λ 출력 前 segfault. Bisect 확정 — gga 자체 아님(standalone clean) · dual-SCF 충돌 아님(line SCF 분기제외) · **farr ↔ val-arena 메모리모델 충돌** (gga_scf=off-heap farr / 하류 DFPT·screening=val-arena [float]; 한 프로세스서 공존 시 heap corrupt). baseline(pbe3d off) λ 정상출력(cap64 0.00833 · cap16 0.609 · 물리 n=645 4.137 rel-ε 5.47%) = 하네스/정점 건전 확인.
- **🔴🧱 from-scratch gate-grade WALL — 진짜 잔차 = 엔진 메모리모델(물리 숫자 아님)**: frozen prediction(PRIMARY=won't close) 유지. functional-of-ground-state 축은 이미 소진(R8 f_xc-in-χ + (1,1,n) PBE 둘 다 λ 악화); 3-D PBE 는 이제 **계산·install 됨**에도 mini 단일프로세스서 정점까지 못 통과. **게이트 flip 금지** · 하이브리드(1.65e-7) production · gate HELD · absorbed 불변.
- **돌파경로(d2)**: (a) **process-split** — gga 가 H 를 checkpoint 로 쓰고, 2번째 프로세스가 그걸 QPW_HAM 으로 읽어 정점만 실행(farr 없음) → in-process 충돌 우회, $0 local **= 다음 라운드**. (b) allocator 통일(DFPT/screening→farr 또는 H-export→val-arena), hexa-lang upstream→inbox/patches(d8). (c) pod(heap 여유; 구조적 충돌이라 size만은 아님). verdict: `.verdicts/qforge-cah6-pbe-scf-vertex/`.

<!-- rtsc.md QFORGE migration-gate 라인 flip 제안: f_xc-in-χ / PBE-SCF 항목 뒤에 append —
"🔴🧱 residual-(3) 3-D PBE vertex (2026-06-16): 진짜 3-D 실공간 gga_scf 바닥상태를 from-scratch 차폐정점에
배선 (qpw_set_pbe3d + millers-explicit gga, BCC 특이역격자 버그 FIX). 3-D PBE 바닥상태 계산·install 됨
(CaH6 e=−11.86~−19.87 Ha, m=0, hconv=n²) = residual-(3) 바닥상태 RESOLVED. 그러나 λ 측정불가 — gga(farr)→
정점(val-arena) 같은-프로세스 메모리충돌 SIGSEGV. 벽 = 엔진 메모리모델(물리 아님). flip 금지·하이브리드
production. 돌파=process-split(다음 라운드). `.verdicts/qforge-cah6-pbe-scf-vertex/`" -->
