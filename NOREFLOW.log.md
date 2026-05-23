# NOREFLOW — log

Append-only history sister of `NOREFLOW.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T00:40:00Z — M12/V3 simulation pass 완료 (cycle5) — 4 tracks 🟢

**4 tracks 모두 ubu-1/2 ssh 실제 실행 성공**:
- [x] M12.1 PK 2-comp (ubu-1) — IC tmax=3s · IV=300s · ratio 536× direction-match → 🟢
- [x] M12.2 IRI ODE Hill+salvage+ferroptosis (ubu-1) — CIRCUS 93.5% → IC-sync 56.9% (Δ=36.6 pp) → 🟢
- [x] M12.3 Monte Carlo 10k iter + 5 ablation (ubu-2) — adenosine/nicorandil 100% Tier-A · volatile=0 → 🟢
- [x] M12.4 Power n=500 (ubu-1) — primary 0.798 🟢 · Cox 0.157 🟠 · ALDH2*2 0.654 🟠
- [x] 산출 `NOREFLOW/M12_simulation.md` (277 lines) + `NOREFLOW/verify/V3_numerical_recompute.md` (134 lines)
- [ ] 🟡 pool CLI 회귀 — `hexa_index_get` 컴파일 회귀 차단 → ssh direct fallback 사용 · inbox patch 후속 필요

🎯 d1 governance 달성: non-wet-lab → completed-form (pre wet-lab)
🔑 핵심 통찰:
- **M2 §4 Path B (IC + reperfusion-synced) d2-wall 돌파 정량 정당성 확립** — CIRCUS IV → IC-sync 전환만으로 cell death **36.6 pp 감소** (delivery timing이 1차 lever, 약물 변경 아님)
- **M7 ranking 강건성 검증** — adenosine IC + nicorandil 가중치 ±20% perturb + 5-milestone ablation 모두 통과 (**100% Tier-A persistence**) → **F2 robustness gap closure**
- **Trial-A NICORADENO-MVO n=500** primary endpoint power 0.798 적정 / Cox 1y MACE under-powered (0.16) → **secondary exploratory로 protocol 명시 필요**

## 2026-05-25T00:30:00Z — M10/V1 honest fence + claim inventory 완료 (cycle5)

- [x] V1 NOREFLOW claim 색인 — 72 claims (M1:12 · M2:14 · M3:12 · M4:11 · M5:7 · M6:11 · M7:9 · M8:7 · M9:16)
- [x] ⚪ fence 분류 — 9 핵심 + 6 metaphor = 15
- [x] 🔵 도달 후보 11 (M11/V2 입력)
- [x] 🟢 도달 후보 13 (M12/V3 입력)
- [x] 🔴 falsified 4 (SGLT2i acute · colchicine acute · 한·중 nicorandil 6mo)
- [x] 산출 `NOREFLOW/verify/V1_claim_inventory.md` (437 lines) + `NOREFLOW/M10_fence.md` (240 lines)

🔑 핵심 통찰:
- **M5 endpoint · M4 delivery가 🔵 도달 비율 최고** (각 71% · 55%) — IMR=Pd×Tmn · cTFC×1.7 · Cmax ratio 등 산식 보유
- **M7 ranking · M9 deep research에서 ⚪ fence 집중** — subjective 5-axis 가중치 · 3-path 신호 강도 · 신규 d2 path 가설 등 본질적 산식화 불가
- fence는 **metaphor 6 + hypothetical 4 + subjective 2 + prognostic 1 + future infra 2** 5-카테고리 — Trial-B/C effect-size 산식 강제 방지로 절차적 정직성 확보

## 2026-05-25T00:05:00Z — scaffold 확장: M12 simulation pass 추가

- [x] M12 milestone 신설 — demiurge 자산 (d1 non-wet-lab completed-form) simulation 트랙
- [x] sub-tracks 4개 design: M12.1 PK 시뮬 · M12.2 IRI ODE · M12.3 M7 Monte Carlo · M12.4 Trial-A power calc
- [ ] cycle 5 M10 + M11(blocked) + M12 fan-out 예정

🎯 d1 governance: non-wet-lab verification → completed-form (pre wet-lab)
🛠 compute: pool ubu-1/2 (small) · 큰 시뮬 RunPod/Vast (d7) — ad-hoc python local 금지

## 2026-05-24T23:45:00Z — M9 web/arxiv deep research 완료 (cycle4)

- [x] §1 search 방법 (PubMed · CT.gov · arxiv · 2021-2026 · 9 키워드)
- [x] §2 최신 임상 trial 12건 (OASIS-9 · CLEAR SYNERGY · 외)
- [x] §3 mechanism 12 논문 (Bonora 2021 · Carraro 2023 · STING-GPX4 · CypD Ser191)
- [x] §4 arxiv ML 8 논문 (CMR auto-segmentation · GNN drug repurposing · multi-omics)
- [x] §5 한국/동아시아 8 evidence (ALDH2*2 stratification)
- [x] §6 evidence × M? 보강 매핑 (M2 +12 · M3 +10 · M4 +5 · M5 +6 · M6 +4 · M8 +8)
- [x] §7 d2 후속 6 시도 + §8 신규 endpoint + §9-10 ref + g5
- [x] 산출물 `NOREFLOW/M9_deep_research.md` (267 lines · refs 46)
- [ ] 🔴 **콜키친 M3/M7 demote 필요** (CLEAR SYNERGY + OASIS-9 acute MI null)
- [ ] M7 ranking update (콜키친 demote + 다축 cell-death 신규 path 반영)

🔑 새 evidence 3 핵심:
- **CLEAR SYNERGY + OASIS-9 (TCT 2024, n=7,062) null** — 콜키친 + spironolactone 모두 acute MI 무효. M3/M7에서 **콜키친 demote** 정당화
- **STING-GPX4 ferroptosis + CypD Ser191 phospho + mtRNA leak** (Nature 2025) — M2 단일 mPTP 표적 한계 명시 → **다축 cell-death 차단** 신규 d2 path
- **ALDH2*2 East Asian 40% stratification** (JAHA 2024) — 한국 nicorandil null 정당화 + ALDH2*2 sub-group **BH4 등 alternative NO donor** 가설 → M8 한국 우위 새 기회

## 2026-05-24T23:25:00Z — scaffold 확장: M9/M10/M11 추가 (🔵 도달 trajectory)

- [x] M9 web/arxiv deep evidence milestone 신설
- [x] M10 ⚪ honest fence milestone 신설 (bio/clinical closed-form 미가능 영역)
- [x] M11 formal grade-up pass milestone 신설 (atlas 확장 의존)
- [x] hexa-lang inbox patch 2건 fan-out 트리거 (clinical calc + external libs)
- [ ] hexa-lang `noreflow-clinical-calc-extension` reviewer-merge 대기 → M11 unblock

🎯 새 north star: **모든 영역 🔵 SUPPORTED-FORMAL 도달**
🚧 d2 wall: hexa verify atlas = number theory only → bio/clinical 직접 🔵 미가능
🛠 돌파 path: (A) atlas 확장 (Hill · exp_decay · pk_2comp · cox_h · fick_law) → reviewer-merge → 🔵 unblock · (C) ⚪ honest fence (정직한 본질 한계 인정)

## 2026-05-24T23:15:00Z — M7 통합 ranking 완료 (cycle3) — NOREFLOW 8/8 ✅

- [x] §1 5-axis scoring (efficacy 30% · delivery 20% · safety 25% · 한국 15% · 단계 10%)
- [x] §2 전체 후보 ranking (~20 row) — Tier-A 5 / Tier-B / Tier-C
- [x] §3 Tier 분류 + 권고 시나리오
- [x] §4 d2 wall 돌파 3-path 최종 권고 (CypD-selective · IMR-guided RCT · drug-eluting catheter)
- [x] §5 한국 first-in-class 3-trial 구상 (NICORADENO-MVO · NMN-PRECON · DERWIRE-PRECLIN)
- [x] §6 timeline + decision gates (2026-2028 roadmap)
- [x] §7-8 g5 grade + 참고문헌 14
- [x] 산출물 `NOREFLOW/M7_rank.md` (295 lines)

🔑 핵심 권고:
- **Tier-A 3약물 가중 종합**: adenosine IC 4.85 · nicorandil 4.30 · MTP-131 3.40
- **한국 first-in-class 기회**: Trial-A NICORADENO-MVO (n=500, 8기관, 30-50억, 2-3년)
- **d2 wall 돌파 우선순위**: Path B (IMR-guided RCT) > Path A (NAD+/NMN pilot) > Path C (drug-eluting frontier)

## 2026-05-24T23:05:00Z — M8 한국 KAMIR registry 매핑 완료 (cycle2)

- [x] §1 한국 STEMI/PCI registry 4대 (KAMIR/KAMIR-NIH · K-ACTION · KAMIR-V · HOST 시리즈)
- [x] §2 한국 no-reflow 빈도 + 인구학적 특성 (12-18% angiographic · 30-50% cMRI MVO)
- [x] §3 한국 약제/디바이스 가용 매트릭스 (nicorandil 보험 우위 · mPTP 약물 import gap)
- [x] §4 한국 IMR/CMR capacity (~10개 IMR · ~15-20개 CMR · 다기관 consortium 부재)
- [x] §5 한국 임상시험 gap 표 (mPTP/adenosine/nicorandil/thrombectomy/IMR-guided RCT)
- [x] §6 한국 우위 + 돌파 3-path (NAD+/NMN supplement · IMR-stratified RCT · nicorandil pre-PCI)
- [x] §7 한국 다기관 consortium 구상 (8개 대학병원 + central core lab)
- [x] 산출물 `NOREFLOW/M8_korea.md` (173 lines · 출처 12)
- [ ] M7 통합 ranking (cycle 3) — 한국 적용성 축 합산

🔑 핵심 통찰:
- **nicorandil 보험 등재 + familiarity = 한국 글로벌 우위** — J-WIND positive 후 즉시 진행 가능한 유일 약제 (Path C)
- **IMR-guided cause-stratified RCT = first-in-class 기회** — 글로벌 trial들이 cause-mixed enrollment로 neutral 양산, 한국 ~10개 IMR-capable 기관 consortium으로 power 향상 (Path B)
- **mPTP 직접 약물 한국 미수입** → NAD+/NMN supplement IRB-light pilot이 현실적 우회로 (Path A)
- 최대 capacity gap: **다기관 CMR consortium 부재** (M5 결론 재확인) — KHIDI/보건복지부 R&D 트랙으로 2-3년 빌드 가능

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
