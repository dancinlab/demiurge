# NOREFLOW — log

Append-only history sister of `NOREFLOW.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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
