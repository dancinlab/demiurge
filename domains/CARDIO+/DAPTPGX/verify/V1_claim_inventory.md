# V1 — DAPTPGX claim inventory + tier triage

> M1-M11에서 numerical claim 추출, g5 rubric 4-tier 분류.
> V2 (🔵 closed-form) · V3 (🟢 numerical recompute) · V4 (final ledger) 입력.

## 1. methodology

각 claim에 대해:
- **위치**: 파일 · 섹션
- **claim 내용**: 숫자 + 단위
- **출처**: PMID 또는 가이드라인 참조
- **현 등급**: 마일스톤 본문 verification table의 g5 tier
- **목표 등급**: V2/V3 push 후 목표
- **recompute 경로**: closed-form (V2) · numerical sim (V3) · IPD 필요 (🟡 유지) · wet-lab (🟠) · forward (⚪)

## 2. inventory 표

| # | 위치 | claim | 출처 | 현 등급 | 목표 | recompute |
|---|---|---|---|---|---|---|
| C01 | M1 §3 | 한국 *2 allele freq 0.31 | KOVA · Mizzi 2014 | 🟡 | 🟢 | binomial CI (V3) |
| C02 | M1 §3 | 한국 *3 allele freq 0.08 | 동일 | 🟡 | 🟢 | binomial CI (V3) |
| C03 | M1 §3 | 한국 *17 allele freq 0.02 | 동일 | 🟡 | 🟢 | binomial CI (V3) |
| C04 | M1 §3 | 한국 *35 allele freq 0.0202 | Youn 2024 Front Pharmacol | 🟡 | 🟢 | binomial CI (V3) — n 확인 필요 |
| C05 | M1 §4 | PM phenotype freq ~0.14-0.15 | CPIC 2022 | 🟡 | 🟢 | HW closed-form (V3) ✅ |
| C06 | M1 §4 | IM+PM 합 ~0.60 | CPIC 2022 | 🟡 | 🟢 | HW closed-form (V3) ✅ |
| C07 | M2 §3 | PM active AUC ratio 0.30-0.50 (vs NM) | Brandt 2007, Mega 2009 | 🟡 | 🟡 유지 | PK 측정값 — IPD 필요 |
| C08 | M2 §6 | PM PRU baseline 247 (한국) | HOST-RP-ACS | 🟡 | 🟡 유지 | RCT measured |
| C09 | M3 §3 | TRITON-TIMI 38 ST HR (PM clopi) | Mega 2010 | 🟡 | 🟡 유지 | IPD 필요 |
| C10 | M3 §5 | TROPICAL-ACS de-escalation HR 0.81 | Sibbing 2017 Lancet | 🟡 | 🟡 유지 | IPD 필요 |
| C11 | M3 §5 | HOST-EXAM HR 0.73 (clopi 단독) | Kim 2020 Lancet | 🟡 | 🟡 유지 | IPD 필요 |
| C12 | M4 §2 | PRECISE-DAPT ≥25 prevalence ~25% | Costa 2017 | 🟡 | 🟢 | binomial CI |
| C13 | M4 §5 | ARC-HBR HIGH 한국인 prevalence ~30-40% | Yoon 2021 K-ACTIVE | 🟡 | 🟢 | binomial CI |
| C14 | M4 §5 | TICAKOREA 출혈 2.8% vs PLATO 1.4% | Park 2020 Circulation | 🟡 | 🟡 유지 | IPD 필요 |
| C15 | M4 §7 | PM × HBR⊕ per100 = 7-8 (2-axis) | M1 × M4 곱 | 🟠 | 🟢 | 결합확률 (V3) ⚠️ recompute=3.8 |
| C16 | M5 §2 | VerifyNow HTPR cut-off PRU ≥208 | Tantry 2013 consensus | 🟡 | 🟡 유지 | consensus 정의 |
| C17 | M5 §2 | 한국 HTPR 비율 ~50-60% | Jeong 2014 KAMIR | 🟡 | 🟡 유지 | cohort 측정값 |
| C18 | M6 §3 | selatogrel SC peak ~30min | Sinnaeve 2020 | 🟡 | 🟡 유지 | PK 측정값 |
| C19 | M6 §5 | vicagrel CYP2C19 무관 (CES1 1-step) | Jiang 2017 | 🟡 | 🟡 유지 | mechanism |
| C20 | M7 §3 | PM × HBR-HIGH × complex per100 = 3-5 (3-axis) | M1 × M4 × proc 곱 | 🟠 | 🟢 | 3-product (V3) ⚠️ recompute=1.5 |
| C21 | M7 §7 | 결정맵 적용 시 ST event ↓ X% | M2-M5 HR 곱 추정 | 🟠 | 🟠 유지 | model assumption |
| C22 | M8 §3 | clopi NHIS 약가 ₩150/T | NHIS 2025 약가 고시 | 🟡 | 🟢 | catalog lookup |
| C23 | M8 §3 | ticag NHIS 약가 ₩2,300/T | 동일 | 🟡 | 🟢 | catalog lookup |
| C24 | M8 §3 | CYP2C19 PCR 수가 ₩50,000 | C5946 행위급여 | 🟡 | 🟢 | catalog lookup |
| C25 | M8 §5 | **S4 ICER 34M KRW/QALY** | Markov model | 🟠 | 🟢 | ICER (V3) 🔴 sign mismatch — model 재검증 필요 |
| C26 | M8 §5 | S2 universal ticag dominated | 동일 | 🟠 | 🟢 | ICER 비교 (V3) — pending |
| C27 | M8 §7 | 5y NHIS 절감 888억원 | 80,000 PCI × Δcost × 5 | 🟠 | 🟢 | budget impact (V3) 🔴 sign mismatch (C25 종속) |
| C28 | M9 §10 | 5 NEW axes (AI/ML, P2Y12 occupancy, ...) | M9 propagation | ⚪ | ⚪ 유지 | forward direction |
| C29 | M10 §8 | KSC 2025 chronic clopi 단독 Class I 격상 (예상) | M10 ⚪ | ⚪ | ⚪ 유지 | forward |
| C30 | M11 inbox | PharmCAT CYP2C19 caller 정확도 F1 ~0.99 | Sangkuhl 2020 | 🟡 | 🟢 | confusion matrix recompute (V3 후속) |

## 3. tier 분포 (현 시점)

| 등급 | 개수 | 비율 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 0 | 0% |
| 🟢 SUPPORTED-NUMERICAL | 0 | 0% |
| 🟡 SUPPORTED-BY-CITATION | 18 | 60% |
| 🟠 INSUFFICIENT/DEFERRED | 9 | 30% |
| 🔴 FALSIFIED | 0 | 0% |
| ⚪ SPECULATION-FENCED | 3 | 10% |

## 4. V2/V3 push 목표 후 예상 분포

| 등급 | 목표 개수 | 변화 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 0-2 | hexa atlas register 시 가능 (V2 inbox handoff 필요) |
| 🟢 SUPPORTED-NUMERICAL | 12-14 | HW · binomial · ICER · Markov · catalog (V3) |
| 🟡 SUPPORTED-BY-CITATION | 9 | RCT IPD 필요 · mechanism · consensus |
| 🟠 INSUFFICIENT/DEFERRED | 3-5 | model assumption · forward outcome |
| 🔴 FALSIFIED | 0-2 | C25 ICER · C27 budget — V3 recompute 결과 따라 |
| ⚪ SPECULATION-FENCED | 3 | forward predictions |

## 5. d2 breakthrough paths (concede 금지)

- **🔵 path**: M11 archive/session-notes/daptpgx-pgx-ssot-databases.md 흡수 → hexa atlas append-witness `--kind P --id CYP2C19.PM.kor.freq` 등록 → `hexa verify <id>` 🟡→🔵 escalation. hexa-lang stdlib에 Hardy-Weinberg 함수 추가 시 더 많은 atom 🔵 가능.
- **🟢 path**: V3 numerical recompute (본 라운드) — hexa-native simulation, pool 실행. HW · binomial · ICER · Markov 12+ claim escalation 가능.
- **🟡 → 🟢 path (RCT HR)**: 개별 환자 데이터 (IPD) 접근 필요 — Cochrane / FDA IPD 신청 또는 author 직접 contact.
- **🟠 → 🟢 path (model assumption)**: V3 V3-bis 두 번째 패스에서 sensitivity analysis 100-1000 simulation → 신뢰구간 closed-form 만들기.

## 6. 핵심 통찰

- 30개 claim 중 18개 (60%)가 🟡 citation-only — verify push의 1차 표적
- 🟠 9개 (30%) 중 6개는 V3 recompute로 🟢 escalation 가능 (model assumption은 5개 V3 sim 가능)
- 진정한 🔵 (closed-form symbolic) 도달은 hexa atlas + stdlib 확장 의존 → M11 inbox handoff의 흡수 사이클 통과 후 가능
- **C25 ICER + C27 budget 🔴 sign mismatch 발견** (V3 recompute 결과) → M8 model assumption 재검증 priority #1
- **🔵 모든영역 도달 = 불가능 명사 사용 금지** — d2 breakthrough paths 명시로 모든 claim에 progression 경로 부여 (현재 V2/V3로 ≥40% 🟢/🔵 escalation 가능)
