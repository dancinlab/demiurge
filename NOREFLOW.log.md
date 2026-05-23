# NOREFLOW — log

Append-only history sister of `NOREFLOW.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24T23:00:00Z — M6 off-target / 안전성 완료 (cycle2)

- [x] §1 safety 5-domain (부정맥 · 저혈압 · 출혈 · 면역억제/신독성 · 기타)
- [x] §2 M2 mPTP 약물 safety profile (CsA · NIM811 · sanglifehrin · debio-025 · MTP-131 · TRO40303 · SIRT3 · NAD+)
- [x] §3 M3 미세혈관 약물 safety profile (adenosine · nicorandil · NTP · CCB · IIb/IIIa)
- [x] §4 safety × 환자군 매트릭스 (bradycardia · bleeding · LV dysfunction · renal failure)
- [x] §5 trial safety 신호 (CIRCUS · AMISTAD-II · INFUSE-AMI · TASTE · TOTAL · MITOCARE)
- [x] §6 M2/M3 통합 safety ranking (Tier-A/B/C)
- [x] §7 한국인 safety 고려 (TICAKOREA bleeding · nicorandil 보험 · supplement gray zone)
- [x] 산출물 `NOREFLOW/M6_safety.md` (221 lines · 출처 12)
- [ ] M7 통합 ranking (cycle 3) — efficacy × safety 결합

🔑 핵심 통찰:
- **Tier-A 3약물 (adenosine IC · nicorandil · MTP-131)** = 효능 + safety 균형 우위. debio-025 (pancreatitis hold) · abciximab (bleeding · 글로벌 생산 중단) · TRO40303 (GI) 대비 명확한 grade 차이
- **단회 IV가 safety window의 결정 요소** — CIRCUS CsA 단회 2.5mg/kg = 위약과 동등 / 반복은 calcineurin/cyclophilin 누적 독성 → 약물 자체보다 **schedule 설계**가 안전성 지표
- **한국인 출혈 baseline ↑ (TICAKOREA HR~1.5)** + nicorandil 보험 우위 + supplement gray zone → M8 한국 pilot: IIb/IIIa 회피 + nicorandil arm 우선 + supplement vs 의약품 분리 IRB

## 2026-05-24T22:55:00Z — M4 delivery 경로 완료 (cycle2)

- [x] §1 전달 경로 5-tier (IC bolus · IV systemic · thrombectomy · DPD · drug-eluting catheter)
- [x] §2 IC bolus PK 우위 정량 (Cmax ratio · arm-to-heart lag)
- [x] §3 IC vs IV 임상 비교 (REOPEN-AMI · AMISTAD-II · INFUSE-AMI · AIDA · CIRCUS)
- [x] §4 Mechanical 검토 (TASTE · TOTAL · EMERALD — 모두 routine 권고 down)
- [x] §5 drug-eluting catheter/guidewire frontier
- [x] §6 d2 wall 돌파 매트릭스 (M2/M3 + M4 종합)
- [x] §7 한국 capacity (microcatheter · aspiration · DPD · drug-eluting gap)
- [x] 산출물 `NOREFLOW/M4_delivery.md` (256 lines · 출처 16)
- [ ] M6 safety · M8 한국 (cycle2 병렬)
- [ ] M7 통합 ranking (cycle3)

🔑 핵심 통찰:
- **IC PK 우위 정량** — arm-to-heart lag IV 30-120s vs IC ~0-3s · short-t1/2 vasodilator (adenosine/NTP) Cmax 30-100× · t1/2 큰 약물 (abciximab) 3-10×
- **CIRCUS neutral의 진짜 원인 = PK 미달** — CsA 2.5mg/kg IV 1.5h infusion으로는 lethal window (재관류 첫 5분, M2 d2 wall) 도달 부족 → IC + reperfusion-synced 재시도 (M2 Path B)가 미시도 path
- **Mechanical = DE 한 cause만 커버** — TASTE/TOTAL neutral + stroke↑로 routine 철회, EMERALD native coronary DPD도 neutral → **M7 ranking은 IC bolus 약물 중심**

## 2026-05-24T22:35:00Z — M5 임상 측정 endpoint 완료 (cycle1)

- [x] §1 endpoint 5-layer 피라미드 (epicardial → MBG → IMR → CMR → MACE)
- [x] §2 각 endpoint 정량 cutoff (TIMI · cTFC>23 · MBG≤1 · IMR>40 · CMR MVO≥1.5% · LGE≥30%)
- [x] §3 endpoint × outcome HR 표 (TIMI HR 2-3 / IMR·CMR HR 4-6)
- [x] §4 surrogate 등급 (CMR infarct size = 유일 validated · Stone 2016)
- [x] §5 trial endpoint 선택 가이드 (Ph2 CMR n~200-400 · Ph3 MACE n>2000)
- [x] §6 한국 표준 endpoint + gap (KAMIR-NIH CMR 미포함 · 다기관 CMR 부재)
- [x] 산출물 `NOREFLOW/M5_endpoint.md` (176 lines · 출처 13)
- [ ] M2/M3 임상 설계 gating: 한국 다기관 CMR consortium 결성 필요

🔑 핵심 통찰:
- IMR/CMR HR ~ 4-6 vs TIMI HR ~ 2-3 → **아래층(microcirc/infarct) 예측력 약 2배 강함**
- **CMR infarct size = 유일한 validated surrogate** (Stone 2016 n=2,632) → Ph2 PoC n~200-400으로 효과 detect, Ph3 MACE confirm 하는 2-tier 표준
- 한국 gap = IMR-guided RCT 부재 + 다기관 CMR consortium 부재 → M2/M3 임상 설계의 gating 조건

## 2026-05-24T22:32:00Z — M3 미세혈관 보호 약물 완료 (cycle1)

- [x] §1 5-family overview (adenosine · K-ATP · NO donor · CCB · IIb/IIIa)
- [x] §2 약제별 deep-dive 6종 (AMISTAD-II · REOPEN-AMI · J-WIND · VAPOR · INFUSE-AMI · CHAMPION)
- [x] §3 cause × drug 매트릭스 (DE/VS/ED — IR은 M2)
- [x] §4 임상 결과 positive vs neutral 분포 (small Ph2 IC bolus 양성 vs large Ph3 systemic 음성)
- [x] §5 d2 wall 돌파 3-path (IMR-stratified RCT · multi-drug cocktail · individualized)
- [x] §6 신규 후보 (endothelin · DPP-4 · SGLT2i EMMY · GLP-1 FAVOR · 콜키친)
- [x] §7 한국 hooks (KAMIR-V · K-ACTION · 한국 nicorandil 보험우위)
- [x] 산출물 `NOREFLOW/M3_microvasc.md` (206 lines · 출처 12)
- [ ] M4 delivery 경로 + M6 safety + M7 ranking 입력

🔑 핵심 통찰:
- **small Ph2 IC bolus positive vs large Ph3 systemic neutral** 패턴 = d2 wall (single-cause × multi-cause heterogeneity × timing 부정합)
- 돌파 3-path: IMR>40 cause-stratified RCT · multi-drug cocktail (verapamil+nicorandil+adenosine) · OCT/IMR individualized
- ED 직접 약물 갭 → **SGLT2i (empagliflozin EMMY)** 신규 후보 · 한국 nicorandil 보험우위 = M8 자산

## 2026-05-24T22:30:00Z — M2 mPTP 차단 후보 inventory 완료 (cycle1)

- [x] §1 mPTP 구조 (F-ATPase c-ring vs ANT 학파 + CypD 합의) + ASCII 닫힘/개방
- [x] §2 14-candidate × 5-family 표 (CypD-binding · F0F1 · MTP-131 · sirtuin · UCP2)
- [x] §3 4건 neutral 임상 정량 (CIRCUS · CYCLE · EMBRACE · MITOCARE) + 3-axis 실패 (선택성/타이밍/PK)
- [x] §4 d2 wall 돌파 3-path tree (CypD-selective · IC-synced · 신규 표적)
- [x] §5 후보 ranking 10 row
- [x] §6 한국 hooks (ALDH2 ethnicity 가설 · NAD+/NMN supplement 가용)
- [x] 산출물 `NOREFLOW/M2_mptp.md` (197 lines · 출처 13)
- [ ] 🟠 한국 단독 mPTP RCT 부재 (gap)
- [ ] M6 safety + M7 ranking 입력

🔑 핵심 통찰:
- **CypD selectivity가 d2 wall 1축 핵심** — CsA의 calcineurin off-target이 dose ceiling 깎고 CypA 동시 결합으로 항-ROS 효과 상쇄. NIM811 · debio-025가 직격
- **재관류 첫 5분 lethal window vs IV bolus arm-to-heart lag 30-120s = PK 화해 불가** → IC + reperfusion-synced delivery (PCI guidewire bolus · drug-eluting catheter)가 유일 우회
- **SIRT3-CypD K166 deacetylation 축 + NAD⁺/NMN booster = 한국 supplement 가용** → IRB-light pilot으로 ethnicity-aware fast track 가능

## 2026-05-24T21:15:00Z — M1 4-cause 매핑 완료

- [x] §1 정의 + ASCII (epicardial 회복 vs microvascular MVO)
- [x] §2 4-cause × 메커니즘 × 시점 × marker 표
- [x] §3 임상 척도 (TIMI · cTFC · MBG · IMR · cMRI MVO)
- [x] §4 cause × 대응 전략 매핑 → M2-M4 hooks
- [x] §5 d2 wall — CIRCUS/CYCLE/EMBRACE/MITOCARE 임상 neutral
- [x] §6 한국인 데이터 hooks (KAMIR-NIH · K-ACTION)
- [x] 산출물 `NOREFLOW/M1_causes.md` (~115 lines)
- [ ] 🟠 KAMIR-V 한국인 no-reflow rate 직접 ratio
- [ ] M2 mPTP 후보 inventory + d2 wall 돌파 path

🔑 핵심 통찰:
- 4-cause 중 IR(ROS/mPTP)이 가장 큰 임팩트이지만 임상 4건 연속 neutral → d2 wall
- 돌파 가설: 선택성 부족 (CsA = calcineurin off-target) + 타이밍 부족 (재관류 첫 5분 lethal window)

## 2026-05-24T21:00:00Z — scaffold

- [x] @goal 확립 — IRI/MVO 보호 후보 short-list
- [x] M1-M8 milestone 설계
- [x] M1 4-cause inventory
