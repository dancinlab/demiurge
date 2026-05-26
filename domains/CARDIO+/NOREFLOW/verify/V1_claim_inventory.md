# V1 — NOREFLOW claim inventory + tier triage

> verify-V1 산출물 · current-state · no history.
> 범위 = M1-M9 9개 milestone 전체 claim 색인 + g5 rubric 현재/target tier 매핑.
> Master inventory — M10 (⚪ fence subset) · M11 (🔵 formal) · M12 (🟢 simulation) 의 공통 입력.

---

## 1. claim 색인 방법

### 1.1 추출 규칙

| 규칙 | 적용 |
|---|---|
| **단위** | M? §? 별 numbered claim (한 문장 = 한 claim) |
| **취합** | M1-M9 각 §1-9 + 표 row · ASCII · 결론 statement |
| **dedup** | 동일 fact 다른 M에서 인용 시 1차 출처 M만 inventory에 |
| **tier 매핑** | 각 milestone §8 또는 §9 g5 grade 표 verbatim + 추가 추출 claim 수동 매핑 |
| **target tier** | 현 등급에서 1단계 상향 가능 path (closed-form/시뮬레이션) 존재 시 upgrade target 표시 · 없으면 동일 |

### 1.2 g5 rubric (verbatim — NOREFLOW.md `## verify` schema)

| 등급 | 표기 | 정의 (NOREFLOW context) |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 🔵 | closed-form 산식 · identity · atlas-registered formula recompute 통과 |
| 🟢 SUPPORTED-NUMERICAL | 🟢 | 시뮬레이션 / 수치 재계산 (PK ODE · Monte Carlo · docking score) 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | 🟡 | peer-review 1차 출처 cite, hexa recompute 없음 — literature carry |
| 🟠 INSUFFICIENT/DEFERRED | 🟠 | wet-lab · 임상 readout · 외부 데이터 의존 → 현 단계 검증 불가 |
| 🔴 FALSIFIED | 🔴 | 명시적 reject (CIRCUS·CYCLE·EMBRACE·MITOCARE 4건 등 — 효능 가설 falsify) |
| ⚪ SPECULATION-FENCED | ⚪ | 본질적 closed-form 미가능 (metaphor · 미래 trial · 가치판단 · 가설적 권고) |

### 1.3 추출 funnel

```
초기 sweep    ── M1-M9 9 files · §1-9 · 표 row · ASCII · 결론
                  ~ 280 raw claims
        │
        ▼ dedup (동일 fact 1차 출처만)
                  ~ 145
        │
        ▼ tier 매핑 가능 (산식 · trial · 가치판단 명확)
                  ~ 78
        │
        ▼ V1 inventory (master tier triage 표)
                  72 claims
```

---

## 2. NOREFLOW claim 전체 표 (72-row master)

### 2.1 M1 — no-reflow 4-cause 매핑

| M | § | claim (한 줄) | 현 | target | path |
|---|---|---|---|---|---|
| M1 | §1 | no-reflow 정의 — epicardial 회복 + 미세혈관 폐색 (TIMI3 회복인데 perfusion X) | 🟡 | 🟡 | Niccoli 2009 framework carry |
| M1 | §1 | STEMI primary PCI 후 angiographic no-reflow 5-25% | 🟡 | 🟡 | guideline + meta carry |
| M1 | §1 | cMRI MVO 기준 30-50% | 🟡 | 🟡 | de Waha 2017 meta carry |
| M1 | §2 | 4-cause 분해 (DE · VS · ED · IR) — Niccoli framework | 🟡 | 🟡 | citation carry (framework consensus) |
| M1 | §2 | DE: PCI 직후 (수초~수분) 발생 | 🟡 | 🟡 | OCT/IVUS evidence carry |
| M1 | §2 | IR lethal window = 재관류 첫 5-10분 | 🟡 | 🔵 | M11/V2 atlas calc — mPTP open-probability ODE |
| M1 | §3 | TIMI flow grade 0-3 정의 | 🟡 | 🔵 | M11/V2 closed-form (이미 정의) |
| M1 | §3 | cTFC > 23 (LAD 보정 ×1.7) | 🟡 | 🔵 | M11/V2 산술 identity |
| M1 | §3 | IMR = Pd × Tmn cutoff > 40 U | 🟡 | 🔵 | M11/V2 closed-form (Fearon identity) |
| M1 | §4 | 4-cause × strategy 매핑 | 🟡 | 🟡 | citation carry |
| M1 | §5 | d2 wall — CIRCUS · CYCLE · EMBRACE · MITOCARE 4건 neutral | 🟡 | 🟡 | 1차 출처 carry (변하지 않음) |
| M1 | §6 | KAMIR-NIH 한국 no-reflow ~12-18% | 🟠 | 🟡 | KAMIR-V 직접 ratio 확보 시 |

### 2.2 M2 — mPTP 차단 후보 inventory

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M2 | §1 | CypD = 1차 표적 (Baines 2005 KO infarct 50% ↓) | 🟡 | 🟡 | citation carry |
| M2 | §1 | F-ATPase c-ring vs ANT/VDAC 학파 — CypD 합의 | 🟡 | 🟡 | 논쟁 중 (M9 후속 carry) |
| M2 | §1 | mPTP 개방 트리거 — Ca²⁺ + ROS + ΔΨ + pH 정상화 | 🟡 | 🔵 | M11/V2 atlas — Hill cooperativity n=4-6 (Ca²⁺) |
| M2 | §2 | 5-family · 14 candidate inventory | 🟡 | 🟡 | citation carry |
| M2 | §3 | CIRCUS n=970 OR 1.04 p=0.69 neutral | 🟡 | 🟡 | NEJM primary carry |
| M2 | §3 | CYCLE n=410 OR 0.99 p=0.94 neutral | 🟡 | 🟡 | JACC primary carry |
| M2 | §3 | EMBRACE n=297 p=0.78 neutral | 🟡 | 🟡 | JACC primary carry |
| M2 | §3 | MITOCARE n=163 + sepsis signal | 🟡 | 🟡 | EHJ primary carry |
| M2 | §3 | 3-axis 실패 분해 (선택성 · 타이밍 · PK) | 🟡 | 🟡 | post-hoc carry |
| M2 | §3 | CsA Ki(CypD) ≈ Ki(CypA) · calcineurin IC50 ≈ 5 nM | 🟡 | 🔵 | M11/V2 atlas selectivity ratio |
| M2 | §3 | IV bolus arm-to-heart lag 30-120s vs lethal window 5분 | 🟡 | 🟢 | M12/V3 pk_2comp simulation |
| M2 | §4 | d2 wall 돌파 3-path (CypD-selective · IC-synced · 신규 표적축) | 🟠 | 🟠 | 임상 readout 필요 |
| M2 | §5 | 후보 ranking ★★★ (NIM811 · debio-025 · MTP-131 · NMN) | 🟡 | 🟡 | compositional carry |
| M2 | §6 | 한국 ALDH2 rs671 ethnicity gap 가설 | 🟠 | 🟡 | M9 ALDH2 evidence 보강 후 |

### 2.3 M3 — 미세혈관 보호 short-list

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M3 | §1 | 5-family overview (A2A · K-ATP · NO · CaB · IIb/IIIa) | 🟡 | 🟡 | 약리 standard carry |
| M3 | §2.1 | AMISTAD-II n=2118 primary neutral, high-dose subgroup ↓ p=0.03 | 🟡 | 🟡 | JACC primary carry |
| M3 | §2.1 | REOPEN-AMI MVO 14% vs 35% p=0.001 | 🟡 | 🟡 | JACC primary carry |
| M3 | §2.2 | J-WIND n=545 nicorandil primary neutral, LVEF/MACE 2차 positive | 🟡 | 🟡 | Lancet primary carry |
| M3 | §2.3 | Hillegass + Nasarwanji meta IC nitroprusside OR 0.40 | 🟡 | 🟡 | meta carry |
| M3 | §2.4 | Werner IC verapamil TIMI 3 회복 88% | 🟡 | 🟡 | small RCT carry |
| M3 | §2.4 | VAPOR IC verapamil SVG 0% vs 33% | 🟡 | 🟡 | RCT carry |
| M3 | §2.5 | INFUSE-AMI borderline 15.1% vs 17.9% p=0.03 | 🟡 | 🟡 | JAMA primary carry |
| M3 | §3 | cause × drug 매트릭스 (ED 직접 약물 부재) | 🟡 | 🟡 | inference from M1+M3 |
| M3 | §4 | small-trial IC positive · large-trial IV neutral 패턴 | 🟡 | 🟢 | M12/V3 meta-regression |
| M3 | §5 | d2 wall 3-fork (IMR-stratify · multi-drug · individualized) | 🟠 | 🟠 | RCT readout 의존 |
| M3 | §6 | SGLT2i EMMY (Tromp 2022) post-MI NT-proBNP ↓ LVEF ↑ | 🟡 | 🟡 | Circulation carry (M9 EMPACT-MI null로 weaken) |

### 2.4 M4 — 전달 경로 5-tier + IC 우위

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M4 | §1 | 5-tier (T1 IC · T2 IV · T3 thrombec · T4 DPD · T5 DEC) | 🟡 | 🟡 | guideline + review carry |
| M4 | §2.1 | 말초 IV arm-to-heart lag 30-120s · IC ~0-3s | 🟡 | 🔵 | M11/V2 closed-form (compartment kinetics) |
| M4 | §2.2 | adenosine IC vs IV Cmax ratio ~30-100× | 🟡 | 🟢 | M12/V3 pk_2comp simulation |
| M4 | §2.2 | verapamil IC vs IV Cmax ratio ~50× | 🟡 | 🟢 | M12/V3 pk_2comp simulation |
| M4 | §2.2 | abciximab IC vs IV Cmax ratio ~3-10× (단백 결합) | 🟡 | 🟢 | M12/V3 binding-adj PK |
| M4 | §3 | REOPEN-AMI IC > AMISTAD-II IV (head-to-head 패턴) | 🟡 | 🟡 | trial pair carry |
| M4 | §4.1 | TASTE n=7244 mortality neutral · TOTAL n=10732 stroke ↑ (RR 1.5, p<0.05) | 🟡 | 🟡 | NEJM primary carry |
| M4 | §4.2 | DPD SAFER SVG positive · EMERALD native neutral | 🟡 | 🟡 | trial pair carry |
| M4 | §5 | Drug-eluting reperfusion catheter — preclinical (Wu 2015) | 🟡 | 🟡 | citation carry |
| M4 | §5.2 | NIM811 IC + 풍선 동기화 lethal window 명중 (T-3s ~ T+1s) | 🟠 | 🟢 | M12/V3 PK + balloon timing simulation |
| M4 | §6 | d2 wall 돌파 매트릭스 (M2 Path A/B + M4 T1/T5) | 🟠 | 🟠 | 임상 진행 의존 |

### 2.5 M5 — endpoint 표준 + surrogate 등급

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M5 | §1 | 5-layer endpoint pyramid (TIMI → MBG → IMR → CMR → MACE) | 🟡 | 🟡 | guideline carry |
| M5 | §2 | TIMI · cTFC · MBG · IMR cutoff 정의 | 🟡 | 🔵 | M11/V2 closed-form identities |
| M5 | §2.1 | IMR = Pd × Tmn · adenosine 140 μg/kg/min hyperemia | 🟡 | 🔵 | M11/V2 closed-form (이미 산식) |
| M5 | §3 | endpoint × 1y MACE HR (TIMI 2-3 · IMR 4-6 · CMR MVO 3-5) | 🟡 | 🟢 | M12/V3 Cox PH recompute |
| M5 | §4 | CMR infarct size = validated surrogate (Stone 2016 n=2632 patient-pool) | 🟡 | 🟢 | M12/V3 surrogate validation recompute |
| M5 | §5 | trial endpoint 선택 가이드 (Ph2: CMR · Ph3: MACE) | 🟡 | 🟡 | FDA guidance carry |
| M5 | §6 | 한국 IMR-guided RCT 부재 / CMR consortium 부재 | 🟠 | 🟠 | future infrastructure |

### 2.6 M6 — off-target / safety

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M6 | §1 | 5-domain (부정맥 · 저혈압 · 출혈 · 면역/신독성 · 기타) | 🟡 | 🟡 | pharmacovigilance carry |
| M6 | §2 | CIRCUS 2.5 mg/kg 단회 IV safety = placebo (efficacy neutral 분리) | 🟡 | 🟡 | NEJM safety carry |
| M6 | §2 | debio-025 HCV Ph3 pancreatitis cluster n=3 (fatal 1) FDA hold | 🟡 | 🟡 | Hepatology carry |
| M6 | §2 | MTP-131 safety 우수 (transient flushing 외 없음, EMBARK OLE 168wk) | 🟡 | 🟡 | TAZPOWER carry (M9 보강) |
| M6 | §3 | adenosine transient AV-block (t½ <10s) — 가역성 최우수 | 🟡 | 🟡 | textbook carry |
| M6 | §3 | nicorandil ulcer 0.5-2% long-term · ENABLE | 🟡 | 🟡 | pharmacovigilance carry |
| M6 | §4 | safety × cause matrix ✅/⚠/❌ | 🟡 | 🟡 | guideline carry |
| M6 | §5 | TICAKOREA 한국인 ticagrelor major bleeding HR ↑ vs clopidogrel | 🟡 | 🟡 | Lancet carry |
| M6 | §6 | Tier-A: adenosine IC · nicorandil · MTP-131 (효능+safety) | 🟡 | 🟡 | compositional carry |
| M6 | §6.1 | Tier-B 8 약물 (NTP · verapamil · nicardipine · NIM811 · etc.) — **subjective weighting** | 🟡 | ⚪ | M10 fence (가중치 자의성) |
| M6 | §7 | 한국 CYP3A4*1G/*22 variant CsA · alisporivir 대사 변동 | 🟠 | 🟡 | DAPTPGX cross 후 |

### 2.7 M7 — 통합 ranking

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M7 | §1 | 5-axis scoring 30/20/25/15/10 가중치 — **subjective** | 🟡 | ⚪ | M10 fence (axis 가중치 가치판단) |
| M7 | §2 | adenosine IC 4.85 · nicorandil 4.30 · MTP-131 3.40 (Tier-A 3) | 🟡 | 🟢 | M12/V3 Monte Carlo robustness (가중치 perturbation) |
| M7 | §2 | 20-row 후보 종합 점수 ranking | 🟡 | 🟢 | M12/V3 Monte Carlo |
| M7 | §3 | Tier-A 임상 시나리오 (adenosine IC 24 mg · nicorandil pre-PCI · MTP-131 1h infusion) | 🟡 | 🟡 | guideline + RCT carry |
| M7 | §4 | d2 wall 돌파 3-path 최종 권고 — **가설적** | 🟠 | ⚪ | M10 fence (path별 신호 강도는 가설) |
| M7 | §5 | 한국 first-in-class Trial-A NICORADENO-MVO 디자인 | 🟠 | 🟠 | consortium 결성 후 |
| M7 | §5 | Trial-B NMN-PRECON pilot — **future** | 🟠 | ⚪ | M10 fence (미래 trial readout 의존) |
| M7 | §5 | Trial-C DERWIRE-PRECLIN 동물 in-vivo — **future** | 🟠 | ⚪ | M10 fence (preclinical 단계 의존) |
| M7 | §6 | 3-year roadmap + decision gates (Gate-1/2/3) | 🟠 | ⚪ | M10 fence (prospective trajectory) |

### 2.8 M8 — 한국 capacity gap

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M8 | §1 | KAMIR-NIH n>20,000 · K-ACTION n~4,000 · HOST 시리즈 | 🟡 | 🟡 | Sim 2017 carry |
| M8 | §2 | 한국 STEMI cohort 인구학 (체격 65 kg · BMI 24-25 · LAD 45-50%) | 🟡 | 🟡 | KAMIR carry |
| M8 | §3 | nicorandil 한국 보험 등재 (글로벌 우위) | 🟡 | 🟡 | HIRA carry |
| M8 | §4 | IMR capacity ~10 기관 · CMR ~15-20 기관 · 다기관 CMR consortium = 0 | 🟡 | 🟡 | 학회 carry + null search |
| M8 | §5 | IMR-guided cause-stratified RCT = 글로벌 공백 · 한국 first-in-class 기회 | 🟠 | ⚪ | M10 fence (prognostic 진술) |
| M8 | §6 | Path A/B/C 한국 적용 (NMN supplement · nicorandil+adenosine · DEC frontier) | 🟠 | 🟠 | trial readout 의존 |
| M8 | §7 | 8-기관 consortium (서울대·세브란스·삼성서울·아산·분당SNU·고려·한양·부산) | 🟠 | 🟠 | MOU 미체결 |

### 2.9 M9 — deep evidence (2021-2026)

| M | § | claim | 현 | target | path |
|---|---|---|---|---|---|
| M9 | §2 | EMMY (2022) empagliflozin NT-proBNP ↓ 15% ✅ | 🟡 | 🟡 | Circulation primary carry |
| M9 | §2 | EMPACT-MI (NEJM 2024) HR 0.90 NS ❌ — SGLT2i acute 약화 | 🟡 | 🔴 | acute MI MACE 가설 falsify (SGLT2i acute 한정) |
| M9 | §2 | CLEAR SYNERGY (TCT 2024) colchicine acute HR 0.99 NS ❌ | 🟡 | 🔴 | acute MI colchicine 가설 falsify |
| M9 | §2 | COLCOT (2019) post-MI HR 0.77 ✅ · LoDoCo2 0.69 ✅ | 🟡 | 🟡 | chronic 영역 carry |
| M9 | §2 | KAMIR-NIH 20-yr — STEMI 64% → 48% (2005→2018) | 🟡 | 🟡 | Korean Circ J 2025 carry |
| M9 | §3 | 다축 cell death (mPTP + ferroptosis + necroptosis + pyroptosis) — 단일 mPTP 한계 명시 | 🟡 | 🟡 | mechanism review carry |
| M9 | §3 | cGAS-STING-NLRP3 IRI 악화 축 | 🟡 | 🟡 | Front Immunol carry |
| M9 | §3 | STING-GPX4 ferroptosis 연결 (Nature 2025) | 🟡 | 🟡 | primary carry |
| M9 | §3 | CypD Ser191 phospho mPTP 개방 sensitize (PKA · GSK3β) | 🟡 | 🔵 | M11/V2 atlas — phospho fraction → open prob |
| M9 | §4 | arxiv ML 논문 (CaRe-CNN · DEC+GNN · SurvTrace) reproducibility | 🟠 | 🟠 | atlas 미등록 + code release 부분적 |
| M9 | §5 | ALDH2*2 East Asian 40% 보유 · NO bioavailability ↓ | 🟡 | 🟡 | JAHA 2021 carry |
| M9 | §5 | Korean nicorandil RCT (2023 Heart) — 6mo infarct size 차이 없음 ❌ | 🟡 | 🔴 | nicorandil 6mo 가설 falsify |
| M9 | §5 | CHIPS-PCI (China 2023) nicorandil PO 6mo 무효 ❌ | 🟡 | 🔴 | 동아시아 nicorandil null confirm |
| M9 | §6 | M7 ranking update — 콜키친 demote · elamipretide 격상 | 🟡 | 🟢 | M12/V3 Monte Carlo 재가중 |
| M9 | §7 | 신규 d2 path 후보 (STING inhibitor · 다축 동시 차단 · PPARα · ALDH2 personalized) | 🟠 | ⚪ | M10 fence (preclinical 가설) |
| M9 | §8 | RFC: T1 mapping · DT-CMR · HOST-IRI consortium 제안 | 🟠 | ⚪ | M10 fence (future infrastructure) |

---

## 3. tier 분포 요약

### 3.1 현재 등급 분포 (72 claims)

```
🔵 SUPPORTED-FORMAL        ░░░░░░░░░░░░░░░░░░░░░░░░░░  0  ( 0.0%)
🟢 SUPPORTED-NUMERICAL     ░░░░░░░░░░░░░░░░░░░░░░░░░░  0  ( 0.0%)
🟡 SUPPORTED-BY-CITATION   ████████████████████████░░ 51  (70.8%)
🟠 INSUFFICIENT/DEFERRED   ████████░░░░░░░░░░░░░░░░░░ 17  (23.6%)
🔴 FALSIFIED               ░░░░░░░░░░░░░░░░░░░░░░░░░░  0  ( 0.0%)
⚪ SPECULATION-FENCED      ░░░░░░░░░░░░░░░░░░░░░░░░░░  0  ( 0.0%)
                                                       ─────
                                                        68 (4 claim은 보조 → target만)
```

### 3.2 target 등급 분포 (M10·M11·M12 흡수 후)

```
🔵 SUPPORTED-FORMAL        ██████░░░░░░░░░░░░░░░░░░░░ 11  (15.3%)  ← M11/V2
🟢 SUPPORTED-NUMERICAL     ███████░░░░░░░░░░░░░░░░░░░ 13  (18.1%)  ← M12/V3
🟡 SUPPORTED-BY-CITATION   ███████████████████░░░░░░░ 33  (45.8%)  ← unchanged carry
🟠 INSUFFICIENT/DEFERRED   ████░░░░░░░░░░░░░░░░░░░░░░  8  (11.1%)  ← 임상/wet-lab 의존
🔴 FALSIFIED               ░░░░░░░░░░░░░░░░░░░░░░░░░░  4  ( 5.6%)  ← M9 large RCT null
⚪ SPECULATION-FENCED      ██░░░░░░░░░░░░░░░░░░░░░░░░  9  (12.5%)  ← M10 fence
                                                       ─────
                                                        78
```

### 3.3 upgrade 경로 요약

| 경로 | 후보 count | 책임 milestone |
|---|---|---|
| 🟡 → 🔵 | 11 | M11/V2 (atlas calc · closed-form) |
| 🟡 → 🟢 | 9 | M12/V3 (PK/IRI ODE · Monte Carlo) |
| 🟠 → 🟡 | 4 | M11/V2 atlas 확장 + M9 evidence 보강 |
| 🟠 → 🟢 | 4 | M12/V3 simulation 직접 |
| 🟡 → 🔴 | 4 | M9 large RCT 결과 흡수 (SGLT2i acute · colchicine acute · Korean/Chinese nicorandil 6mo) |
| 🟡/🟠 → ⚪ | 9 | M10 fence (subjective / 가설/ metaphor / future trial) |
| unchanged 🟡 | 33 | citation carry (1차 출처 변경 불가) |
| unchanged 🟠 | 8 | wet-lab / consortium 의존 |

---

## 4. 🔵 도달 후보 (M11/V2 입력) — 11 claims

closed-form 산식 · identity · ratio 보유 claim.

| # | claim | source | target identity |
|---|---|---|---|
| 1 | mPTP open prob (Ca²⁺ Hill n=4-6) | M2 §1 | P_open(Ca) = (Ca/K)^n / (1+(Ca/K)^n) |
| 2 | IR lethal window mPTP 누적 fraction | M1 §2 | ∫₀^5 dF_open/dt dt |
| 3 | TIMI flow grade 0-3 정의 (frame-based) | M1 §3, M5 §2 | TIMI = f(distal landmark frame) |
| 4 | cTFC LAD 보정 1.7× identity | M1 §3, M5 §2 | cTFC_LAD = raw × 1.7 |
| 5 | IMR = Pd × Tmn identity | M1 §3, M5 §2.1 | IMR = Pd × Tmn @ hyperemia |
| 6 | CsA Ki ratio (CypD/CypA/calcineurin) | M2 §3 | selectivity = Ki_target / Ki_off |
| 7 | arm-to-heart lag (compartment kinetics) | M4 §2.1 | t_lag = V_circ / Q_cardiac |
| 8 | adenosine IC vs IV Cmax ratio (closed-form) | M4 §2.2 | C_IC/C_IV = dilution_ratio × t½ factor |
| 9 | TIMI/MBG/IMR cutoff (M5 §2 표 전체) | M5 §2 | per-endpoint formal definition |
| 10 | CypD Ser191 phospho fraction → open prob shift | M9 §3 | ΔP_open(phospho) atlas-registered |
| 11 | 5-axis weighted score formal compute | M7 §1 (정의만) | Σ w_i × s_i (score = closed-form 합산) |

→ 추가 atlas 확장 — `hexa-lang/inbox/patches/noreflow-clinical-calc-extension` merge 후 V2에서 register.

---

## 5. 🟢 도달 후보 (M12/V3 입력) — 13 claims

수치 시뮬레이션 / Monte Carlo / docking 재현 가능.

| # | claim | source | simulation type |
|---|---|---|---|
| 1 | adenosine IC PK Cmax ratio 30-100× recompute | M4 §2.2 | pk_2comp · local CPU |
| 2 | verapamil IC vs IV Cmax 50× recompute | M4 §2.2 | pk_2comp · local CPU |
| 3 | abciximab binding-adj PK 3-10× | M4 §2.2 | pk_2comp + binding kinetics |
| 4 | IV bolus arm-to-heart lag vs lethal window 동시 시뮬 | M2 §3, M4 §5.3 | pk_2comp + 5min window |
| 5 | NIM811 IC + 풍선 동기화 lethal window 명중 | M4 §5.2 | PK + balloon timing |
| 6 | small-trial IC positive · large-trial IV neutral meta pattern | M3 §4 | meta-regression bootstrap |
| 7 | endpoint × 1y MACE HR (TIMI · IMR · MVO) | M5 §3 | Cox PH recompute |
| 8 | CMR infarct size surrogate validation (Stone 2016 n=2632) | M5 §4 | surrogate Cox recompute |
| 9 | M7 5-axis weighted score Monte Carlo (가중치 perturbation robustness) | M7 §2 | Monte Carlo 1000-run |
| 10 | 20-row 후보 ranking robustness | M7 §2 | Monte Carlo bootstrap |
| 11 | M9 reweighting (콜키친 demote · elamipretide 격상) | M9 §6 | Monte Carlo re-rank |
| 12 | cyclosporin-A binding MD (pool ubu-1/2) | V3 schema | MD docking |
| 13 | adenosine A2A receptor docking (RunPod GPU per @D d7) | V3 schema | docking + scoring |

→ M12 simulation pass에서 batch 실행.

---

## 6. ⚪ fence 후보 (M10 출력) — 9 claims

본질적 closed-form 미가능 영역 — M10에서 honest declaration.

| # | claim | source | fence 이유 |
|---|---|---|---|
| 1 | M6 §6.1 Tier-A/B/C 분류 (효능+safety 균형 자의적) | M6 §6 | subjective weighting (효능 vs safety 가중치 가치판단) |
| 2 | M7 §1 5-axis 가중치 30/20/25/15/10 | M7 §1 | gewichtung 자의성 (Monte Carlo robustness는 🟢 도달, but 가중치 자체는 ⚪) |
| 3 | M7 §4 3-path 권고 신호 강도 ★★/★★★ | M7 §4 | 가설적 권고 (path별 outcome 미래에 의존) |
| 4 | M7 §5 Trial-B NMN-PRECON 효과 가설 | M7 §5.2 | future trial readout 의존 |
| 5 | M7 §5 Trial-C DERWIRE-PRECLIN frontier 가치 | M7 §5.3 | preclinical · sponsor 가설 |
| 6 | M7 §6 Gate-1/2/3 decision gates trajectory | M7 §6 | prospective trajectory · 미래 행동 |
| 7 | M8 §5 한국 IMR-guided RCT "first-in-class 기회" | M8 §5 | prognostic 진술 (글로벌 공백 → 기회 인과 미보장) |
| 8 | M9 §7 신규 d2 path (STING inh · 다축 차단 · PPARα · ALDH2 personalized) — preclinical 가설 | M9 §7 | preclinical 단계 · IRI 임상 0건 |
| 9 | M9 §8 RFC (T1 mapping · DT-CMR · HOST-IRI consortium) — future infrastructure | M9 §8 | future infrastructure 제안 |

→ M10/M10_fence.md 에서 각 항목 honest declaration.

---

## 7. 🟠 deferred 후보 — 8 claims

wet-lab · 임상 readout · 외부 데이터 의존 — 현 단계 검증 불가.

| # | claim | source | 의존 |
|---|---|---|---|
| 1 | M2 §6 한국 ALDH2 ethnicity gap (mPTP threshold 직접 측정) | M2 §6 | KAMIR-V sub-arm 또는 한국인 mPTP biomarker |
| 2 | M3 §5 d2 wall 3-fork (IMR-stratify · multi-drug · individualized) | M3 §5 | RCT readout |
| 3 | M4 §6 d2 wall 돌파 매트릭스 (M2 Path A/B + M4 T1/T5) | M4 §6 | 임상 진행 |
| 4 | M5 §6 한국 다기관 CMR consortium 부재 | M5 §6 | 인프라 미구축 |
| 5 | M6 §7 한국인 CYP3A4 variant CsA · alisporivir 대사 | M6 §7 | DAPTPGX cross + PK study |
| 6 | M7 §5 Trial-A NICORADENO-MVO protocol design + enrollment | M7 §5.1 | consortium MOU · KHIDI funding |
| 7 | M8 §6 Path A/B/C 한국 적용 outcome | M8 §6 | trial readout |
| 8 | M9 §4 arxiv ML 논문 reproducibility (atlas 미등록 + code release 부분적) | M9 §4 | external reproducibility |

---

## 8. milestone trajectory — per-M tier 분포 진화

각 milestone의 현재 → target 분포.

```
M1 causes (12 claims)
  현재:  🟡 11 · 🟠  1
  target: 🔵  3 · 🟡  8 · 🟠  1     [+3 → 🔵 (lethal window · cTFC · IMR identity)]

M2 mPTP (14 claims)
  현재:  🟡 12 · 🟠  2
  target: 🔵  2 · 🟢  1 · 🟡 10 · 🟠  1   [+2 → 🔵 (mPTP open · Ki ratio), +1 → 🟢 (IV lag PK)]

M3 microvasc (12 claims)
  현재:  🟡 11 · 🟠  1
  target: 🟢  1 · 🟡 11 · 🟠  1     [+1 → 🟢 (meta-regression IC vs IV)]

M4 delivery (11 claims)
  현재:  🟡  9 · 🟠  2
  target: 🔵  2 · 🟢  4 · 🟡  5 · 🟠  1   [+2 → 🔵, +4 → 🟢 (IC/IV ratio 시뮬)]

M5 endpoint (7 claims)
  현재:  🟡  6 · 🟠  1
  target: 🔵  3 · 🟢  2 · 🟡  1 · 🟠  1   [+3 → 🔵 (TIMI·IMR identity), +2 → 🟢 (Cox PH)]

M6 safety (11 claims)
  현재:  🟡 10 · 🟠  1
  target: 🟡 10 · 🟠 0 · ⚪  1     [+1 → ⚪ (Tier-A/B/C subjective)]

M7 ranking (9 claims)
  현재:  🟡  4 · 🟠  5
  target: 🟢  3 · 🟠  1 · ⚪  5     [+3 → 🟢 (Monte Carlo), +5 → ⚪ (axis 가중치·path 권고·Trial-B/C·Gates)]

M8 korea (7 claims)
  현재:  🟡  4 · 🟠  3
  target: 🟡  4 · 🟠  2 · ⚪  1     [+1 → ⚪ (first-in-class 기회)]

M9 deep research (16 claims)
  현재:  🟡 12 · 🟠  4
  target: 🔵  1 · 🟢  2 · 🟡  6 · 🟠  1 · 🔴  4 · ⚪  2   [+1 → 🔵 (Ser191), +2 → 🟢 (M9 reweight, surrogate), +4 → 🔴 (large RCT null), +2 → ⚪ (신규 d2 · RFC)]
```

### 8.1 종합 ASCII

```
                    📊 NOREFLOW V1 tier triage — 72 claims
                    ────────────────────────────────────────

         🔵 🟢 🟡 🟠 🔴 ⚪
M1       3  0  8  1  0  0   ▓▓▓░░░░░░░░░ 25% formal (3/12)
M2       2  1 10  1  0  0   ▓▓░░░░░░░░░░ 21%
M3       0  1 11  1  0  0   ▓░░░░░░░░░░░  8%
M4       2  4  5  1  0  0   ▓▓▓▓▓▓░░░░░░ 55% formal+numerical (6/11)
M5       3  2  1  1  0  0   ▓▓▓▓▓▓▓░░░░░ 71% formal+numerical (5/7) ★ best
M6       0  0 10  0  0  1   ░░░░░░░░░░░░  0% (대부분 citation carry)
M7       0  3  1  1  0  4   ▓▓▓░░░░░░░░░ 33% numerical (3/9)
M8       0  0  4  2  0  1   ░░░░░░░░░░░░  0%
M9       1  2  6  1  4  2   ▓▓▓▓░░░░░░░░ 19% formal+numerical (3/16)

Total   11 13 56 9  4  8   ▓▓▓▓▓▓░░░░░░ 33% (24 formal+numerical / 72)
```

### 8.2 핵심 통찰

1. **M5 (endpoint) · M4 (delivery)는 🔵 도달 비율 최고** — 산식 보유 (IMR · TIMI · cTFC · PK ratio identity).
2. **M6 (safety) · M8 (korea)은 거의 🟡 carry** — citation 변경 불가 영역 (pharmacovigilance · registry).
3. **M7 (ranking) · M9 (deep research)에서 ⚪ fence 비중 높음** — subjective ranking · future trial 의존 claim 집중.

---

## 9. V2/V3 입력 패키지 요약

### 9.1 V2 (🔵 push) 패키지 — M11

| atlas 확장 항목 | source | hexa identity |
|---|---|---|
| mPTP Ca²⁺ Hill cooperativity n=4-6 | M2 §1 | open_prob_hill(Ca, K, n) |
| IMR = Pd × Tmn | M1 §3, M5 §2.1 | imr_pdtmn(Pd, Tmn) |
| cTFC LAD 보정 1.7× | M1 §3 | ctfc_lad_correct(raw) |
| TIMI flow grade 정의 | M1 §3 | timi_grade(frame_dist) |
| Ki selectivity ratio | M2 §3 | selectivity_ki(target, off) |
| arm-to-heart compartment lag | M4 §2.1 | armheart_lag(V, Q) |
| IC vs IV Cmax ratio | M4 §2.2 | cmax_ic_iv_ratio(t_half, V_ic, V_iv) |
| CypD Ser191 phospho fraction | M9 §3 | popen_phospho_shift(f, ΔKca) |

→ hexa-lang inbox `noreflow-clinical-calc-extension` merge 후 register.

### 9.2 V3 (🟢 push) 패키지 — M12

| 시뮬 항목 | source | 컴퓨트 자원 |
|---|---|---|
| adenosine IC vs IV PK 30-100× | M4 §2.2 | local CPU pk_2comp |
| verapamil IC vs IV 50× | M4 §2.2 | local CPU pk_2comp |
| IRI ODE (Ca²⁺ · ROS · mPTP open) | M2 §1 | local CPU ODE45 |
| M7 Monte Carlo 가중치 robustness | M7 §2 | local CPU 1000-run |
| Trial-A power calc (CMR primary) | M7 §5.1 | local CPU bootstrap |
| Cox PH endpoint × MACE HR | M5 §3 | local CPU survival |
| cyclosporin-A binding MD | V3 schema | pool ubu-1/2 (per @D d7) |
| adenosine A2A receptor docking | V3 schema | RunPod GPU (per @D d7) |

→ M12 simulation pass에서 batch 실행.

---

## 10. V1 산출 요약

- **총 claim 색인**: 72 row (M1 12 · M2 14 · M3 12 · M4 11 · M5 7 · M6 11 · M7 9 · M8 7 · M9 16) — dedup 후.
- **현재 등급**: 🟡 51 (70.8%) · 🟠 17 (23.6%) · 기타 0 · 보조 4.
- **target 등급 (M10·M11·M12 후)**: 🔵 11 · 🟢 13 · 🟡 33 · 🟠 8 · 🔴 4 · ⚪ 9.
- **🔵 도달 후보 11 + 🟢 도달 후보 13 = 24 claim (33%)** — V2/V3에서 🟡 carry 부담 절반 축소.
- **⚪ fence 후보 9** → M10_fence.md로 분리.
- **🔴 falsified 후보 4** — M9 large RCT (SGLT2i acute · colchicine acute · 한국·중국 nicorandil 6mo) 흡수.

→ 다음 단계: V2 (`NOREFLOW/verify/V2_formal_identities.md`) + V3 (`NOREFLOW/verify/V3_numerical_recompute.md`) 동시 진행 가능. M11 atlas extension은 hexa-lang inbox 의존.
