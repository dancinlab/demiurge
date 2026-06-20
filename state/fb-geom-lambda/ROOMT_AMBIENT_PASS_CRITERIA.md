# 상압·상온 초전도 통과기준 (ROOMT-AMBIENT PASS-CRITERIA · SSOT)
정의: 후보가 "상압(1 atm) 상온(≥293K) 초전도체"로 인정받기 위해 통과해야 할 게이트 사다리.
세션 교훈 반영: Tc는 zero-R만으로 불충분(Meissner 필수)·단일배치 preprint 불충분·투영≠측정(d6).
2-tier: in-silico 사전게이트(우리가 driving) → wet-lab 확정게이트(downstream, d1/d5).

## 하드 임계 (정의)
- Tc(임계온도) ≥ 293.15 K (20°C). 마진 권장 ≥ 300K로 측정 여유.
- P(압력) = 1 atm (≈0 GPa). GPa-급은 상압 아님 (고압 수소화물 LaH10 등 제외).
- 자기장 0(또는 명시), 벌크 시료(박막/계면 SC는 별도 라벨).

## TIER-1 in-silico 사전게이트 (g5·우리 driving, 전부 PASS여야 wet-lab 추천)
1. 열역학 안정 (1 atm): convex-hull 위 또는 ΔH_f<0·decomposition 안전 (vc-relax-tight).
2. 동적 안정 (1 atm): matdyn/DFPT 전 q서 허수모드 0 (d6 동적안정 사전체크). [상압 핵심: 고압 안정 ≠ 상압 안정]
3. 캐리어 채널: E_F서 금속(또는 도달가능 도핑)·N(E_F)>0. flat-band 매장/wide-gap이면 FAIL(이번 COF 교훈).
4. 결합·Tc 계산:
   - conventional el-ph: DFPT λ + Allen-Dynes/Eliashberg Tc ≥ 293K (μ*=0.10-0.13).
   - unconventional/기하: 해당 order-parameter Tc(BKT/3D-XY·D_s) ≥ 293K + 정직한 estimator(이번 ÷3.3 MgB2 보정 같은 calibration).
5. 자성 비-선점: SC 싱글렛이 자성/CDW 바닥상태에 안 짐 (U-scan·경쟁상 체크, 이번 GaNb4S8 교훈).
6. 신규성 (d_novel_only): arxiv PUBLISHED/PARTIAL/NOVEL 판정 — 기지 재현 아님.
→ TIER-1 전부 PASS = "in-silico 상압-상온 후보" (🟡 GATED, 측정 전).

## TIER-2 wet-lab 확정게이트 (d1/d5 downstream, absorbed=true 조건)
A. Zero-resistance: ρ→0 @ T≥293K (4-probe).
B. ★Meissner: 반자성 차폐분율(shielding fraction) 측정 — zero-R 단독 불충분(이번 45K 교훈). bulk SC 증명.
C. 비열 점프 ΔC/γTc (벌크 전이 증거) + Hc1/Hc2.
D. 동위원소 효과 또는 갭 측정 (기전 확인).
E. 재현성: ≥2 독립 배치/랩 (단일배치 preprint 불충분).
→ TIER-2 A-E ALL PASS = ✅ 상압-상온 초전도 확정 (absorbed=true).

## 현 세션 후보 채점 (이 기준 적용)
- Ge:GaNb4S8 ~50K: T-1 #1-3,5,6 부분통과·#4 FAIL(Tc 50K≪293K). → 상압이나 상온 미달.
- MgB2 39K(기지)·LiBC ~45K·CoSn 등: 전부 #4(Tc≥293K) FAIL.
- 결론: 이번 세션 어느 후보도 TIER-1 #4(상온 Tc) 미통과. 상압·상온은 미달성(정직).

## 정직 메타 (d6)
상압·상온은 이 통과기준에서 #4(Tc≥293K @1atm)가 결정 병목. off-diagonal bond 패밀리 천장 ~40-80K로 #4 구조적 FAIL.
#4를 통과하려면: (a) 경원소(H/B/C/N) 강결합 + 상압 동적안정 동시, 또는 (b) 비-phonon 기전(여태 미실현). 둘 다 현재 미해결 벽.
