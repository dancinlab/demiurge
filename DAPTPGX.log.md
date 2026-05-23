# DAPTPGX — log

Append-only history sister of `DAPTPGX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24T22:45:00Z — M9 · M10 · M11 심화 라운드 완료 (deep research 3-axis)

- [x] **M9 arxiv/PubMed 2024-2026** (446 lines) — 45 PMID · 13 sections · HIGH priority 12편 · TALOS-AMI substudies 6편 (M3·M7 cells 🟠→🟡 upgrade) · CELEBRATE zalunfiban Phase 3 · Galli 2024 EHJCVP meta · Gragnano 2025 PRECISE-HBR · Cavallari 2026 "Missing the Boat" editorial · DT-678 신규 class (Liu 2025 BJP FIH) · 한국인 `*35` allele 2.02% (Youn 2024) · 5 NEW axes (AI/ML · P2Y12 occupancy biomarker · DT-678 · sex-modifier · Lp-PLA2)
- [x] **M10 web 임상 readout** (237 lines) — 2024-2026 readout 12건 · HOST-EXAM 10y (Lancet 2026 HR 0.86) + SMART-CHOICE 3 (Lancet 2025 HR 0.71) 한국 chronic clopi 단독 evidence-leading 확정 · ACC/AHA 2025 ticag monotherapy ≥1mo Class IIa 격상 · vicagrel FDA NDA 2023-12 filing (M6 timeline 1-2y 단축) · 음성 readout 2건 (ACTISAVE · BMS-986141 stroke arm 중단)
- [x] **M11 PGx 라이브러리 → inbox handoff** (6 files 980 lines) — demiurge/inbox/notes/daptpgx-* (library-inventory + ssot-databases + cyp-callers + cds-tools + poc-devices + ngs-pipelines) — hexa-lang stdlib wrapper + hexa atlas SSOT 등록 후보 명시 · 한국 환경 적용 매트릭스
- [ ] M12 verify-push (🔵 SUPPORTED-FORMAL 도달) — M9·M10 propagation + canonical-ssot 통합

🔑 심화 통찰:
- **한국 evidence-leading 정점** — HOST-EXAM 10y + SMART-CHOICE 3 동시 출판 → chronic clopi 단독 KSC Class I 격상 가능성 (M10 §8 ⚪)
- **vicagrel timeline 단축** — FDA NDA filing 확인 → 2026-2028 → 2025-2026 (M6 update 필요)
- **결정맵 5D 진화 evidence** — M9 5 NEW axes (sex · AI/ML · biomarker · DT-678 · Lp-PLA2) → M7 cube 확장 후보 (M12·M13 candidate)
- **caller cross-tool consistency 미검증** (gap F8) — PyPGx vs PharmCAT vs Stargazer head-to-head 없음 — M11 inbox callers note에 audit hook
- **M9·M10 findings → M1-M8 propagation 미완** (gap F5 fixpoint priority #1) — M12 audit이 동시 해결 대상

📊 도메인 통계 (M1-M11 landed): ~5,200 lines + 6 inbox notes 980 lines = 총 ~6,180 lines / 11 milestone files + 1 audit 큐.

## 2026-05-24T22:05:00Z — M7 · M8 cycle3 병렬 완료 · DOMAIN COMPLETE 8/8 🎯

- [x] **M7 통합 결정맵** (531 lines) — 3-axis cube (phenotype × HBR × 시술복잡도) · 27-cell + 9-cell 요약 · 5 critical cells deep dive · 시간축 trigger (acute → 12mo) · POC genotyping (Spartan RX · Cube · 1h TAT) + EMR CDS workflow · vicagrel/selatogrel 미래 cell
- [x] **M8 cost-effectiveness** (325 lines) — 4-strategy 비교 (S1 universal clopi · S2 ticag · S3 prasug · S4 targeted PGx) · NHIS 약가 input · Markov 1y/5y/lifetime · ICER 계산 · TICAKOREA bleed 2.8% 결정 변수 · 5y NHIS 888억 절감 + QALY +3,200

🔑 결정맵 완성형 통찰:
- **S4 targeted PGx-guided가 한국에서 유일한 cost-effective frontier** — S1 대비 ICER 34M KRW/QALY (WTP 30M borderline), S3 dominant, S2 압도. CYP2C19 PCR 50,000원이 5년 ST/MACE 비용 회피로 정당화
- **S2 universal ticagrelor는 한국에서 명확히 dominated** — TICAKOREA bleeding 2.8% (PLATO 1.4% 2배)가 결정타. 5y NHIS 추가 부담 +850억 + ICER ~9억/QALY → 가이드라인 import 비합리
- **3-axis cube의 "PM × HBR-HIGH × complex" = 결정맵 가치 최대 cell (~3-5명/100)** — PFT + de-escalation + 신약 전부 활용. 단일 cell에 RCT-level 의사결정 강도 집중
- **HOST-EXAM clopi 단독이 chronic phase 한국적 표준** — 서양 aspirin 단독과 분기. 한국 evidence-leading 영역의 정점
- **시간축 4-trigger로 27-cell 압축 가능** — acute LD · Day 14 PFT · Month 1 de-esc · Month 3-12 HOST-EXAM. EMR CDS 통합 용이 → implementability 핵심
- **vicagrel KFDA 진입 시 결정맵 단순화** — CES1 1-step 활성화로 PM 60% 1:1 대체. 5y NHIS -218억 추가 절감 가능 (가정). 2026-2028 게임체인저

🎯 **DAPTPGX 도메인 완성** — 한국인 PCI DAPT PGx 결정맵 8/8 milestone landed.
- 총 ~2,000 lines 의 8-milestone 통합 문서
- M1 epidemiology → M2 mechanism → M3 switch tree → M4 bleed → M5 PFT → M6 next-gen → M7 통합 cube → M8 cost-effectiveness
- d2 wall 없음 — 모든 milestone 완료-form 도달 (d1 충족)

## 2026-05-24T21:50:00Z — M3 · M6 cycle2 병렬 완료 (2 milestone)

- [x] **M3 switch tree** (388 lines) — 3제 비교 표 · escalation/de-escalation ASCII · TRITON/PLATO/TICAKOREA/TROPICAL-ACS/TOPIC/HOST-REDUCE 결과 · switch 프로토콜 vulnerable window · 4-quadrant 한국인 100명 분포 · KSC/ESC/ACC/CPIC 가이드라인 비교
- [x] **M6 next-gen P2Y12** (251 lines) — selatogrel SC · revacept GPVI-Fc · vicagrel CES1 · zalunfiban αIIbβ3 · PAR-4 rs773902 동양인 GoF · CYP-independence 매트릭스 · 한국 진입 timeline
- [ ] M7 통합 결정맵 (M1-M6 종합 ready)
- [ ] M8 cost-effectiveness (M7 의존)

🔑 핵심 통찰 (cross-cutting):
- **한국 가이드라인이 evidence-leading** — KSC 2024 clopi-first + 단기 DAPT는 TICAKOREA + HOST-EXAM + HOST-REDUCE 한국인 RCT 트라이앵글 근거. ESC/ACC ticag-first와 분기점, 글로벌 PGx 결정맵의 unique한 한국형 axis 확립.
- **De-escalation > escalation evidence weight** — TROPICAL-ACS · TOPIC · HOST-REDUCE 비열등 + 출혈 ↓. 반면 routine PFT-guided escalation은 GRAVITAS/ARCTIC/ANTARCTIC 모두 음성. M3 결정 트리의 primary movement 방향이 escalation이 아닌 de-escalation으로 정렬.
- **Switch vulnerable window** — ticag→clopi acute 6-24h "양쪽 IPA <50%" 위험. LD 600mg + 12h overlap + stable phase (>30d) 시행 안전. M5 PFT의 두 번째 가치 cell.
- **vicagrel = 한국 진입 임팩트 1위 신약 후보** — CES1 1-step 활성화로 CYP2C19 LoF 영향 zero, 동양인 데이터 풍부 (중국 NMPA). 라이센스 deal만 성사되면 2026-2028 KFDA. PM 60%에 즉시 적용 가능 → 결정맵 단순화.
- **selatogrel = STEMI prehospital 골든타임 공백** 표적 유일 후보 (SC 자가, 30분 peak). SOS-AMI readout (~2027)이 한국 결정맵 재편 트리거.
- **PAR-4 rs773902 동양인 GoF** — M1 allele 인벤토리 확장 후보 (BMS-986120/141 class 임상 진입 시 한국인 별도 layer).

## 2026-05-24T21:35:00Z — M2 · M4 · M5 cycle1 병렬 완료 (3 milestone)

- [x] **M2 pathway** (202 lines) — clopidogrel 2-step bioactivation · P2Y12 Cys17/Cys270 covalent · phenotype별 active AUC + PRU 정량 · 한국인 baseline · ABCB1/CES1/PON1 modifier
- [x] **M4 bleed** (225 lines) — PRECISE-DAPT · PARIS · ARC-HBR 14항목 · 한국인 calibration (KAMIR-NIH · K-ACTIVE · HOST-EXAM · TICAKOREA) · BARC/TIMI/GUSTO 비교 · LoF × HBR 교차표
- [x] **M5 PFT** (192 lines) — VerifyNow PRU 208 · LTA 46% · MEA 46U · 3-assay 상관 r 0.5-0.7 · GRAVITAS/ARCTIC/ANTARCTIC/TROPICAL-ACS/POPular Genetics/TAILOR-PCI 결과표 · 한국 보험급여
- [ ] 🟠 M3 switch tree (M2+M4 의존 ready)
- [ ] M6 next-gen P2Y12 · M7 통합 결정맵 · M8 econ

🔑 핵심 통찰 (cross-cutting):
- **PK→PD→임상 인과 사슬 확정** — CYP2C19 LoF → active AUC 25-70%↓ → PRU↑ → ST 2-5× · MACE 1.5-2× (Mega 2010 메타)
- **Asymmetric risk in LoF** — LoF는 효과만 깎고 출혈은 안 늘림 → 한국인 60% IM+PM에서 escalation net benefit 명확
- **한국인 dual jeopardy** — 출혈 ↑ (체중 65kg, ICH↑) + clopidogrel 무반응 (LoF 60%) → 서양 결정 트리 import 불가, KSC 2024는 clopidogrel-first + 단기 DAPT
- **PFT-guided escalation = no hard benefit** — GRAVITAS·ARCTIC·ANTARCTIC 모두 음성. PFT의 진짜 역할은 **de-escalation 안전 확인**(TROPICAL-ACS)
- **Genotype ≥ PFT** (POPular Genetics) — M3 결정 트리는 **CYP2C19 → 임상 risk → (선택적) PFT** 순서
- **High-stakes cell** — 한국인 PCI 100명 중 ~7-8명이 **PM × HBR⊕** → M3 + M5의 최대가치 cohort

## 2026-05-24T21:20:00Z — M1 CYP2C19 한국인 allele 완료

- [x] §1 clopidogrel 2-step CYP2C19 의존 ASCII
- [x] §2 `*1` / `*2` / `*3` / `*17` 기능 + 활성도
- [x] §3 한국인 vs 동아시아 vs 백인 vs 흑인 allele freq 표
- [x] §4 diplotype × phenotype × clopidogrel 반응 + ASCII (한국인 100명 모델)
- [x] §5 CPIC 2022 + 한국인 caveat (TICAKOREA · HOST-EXAM)
- [x] §6 ABCB1 · PON1 · ITGB3 · P2RY12 보조 polymorphism
- [x] 산출물 `DAPTPGX/M1_allele.md` (~125 lines)
- [ ] 🟠 platelet reactivity 정량 (M5 PFT cutoff)
- [ ] M2 pathway 정량 (active metabolite 감소율)

🔑 핵심 통찰:
- **한국인 LoF allele freq ~40% — 글로벌 최고** (백인의 ~2.5×)
- **한국인 IM+PM 합 ~60%** → PCI 환자 절반 이상이 clopidogrel 비-최적
- `*3` allele이 백인 대비 ~20-50× → 한국인 특이 결정 변수
- 단순 prasugrel/ticagrelor switch는 출혈위험 ↑ (동양인 체격) → M3 결정 트리 필요

## 2026-05-24T21:00:00Z — scaffold

- [x] @goal 확립 — 한국인 PCI DAPT PGx 결정맵
- [x] M1-M8 milestone 설계
- [x] M1 CYP2C19 한국인 allele 빈도
