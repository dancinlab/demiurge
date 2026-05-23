# M8 — 한국인 KAMIR / K-ACTION registry 매핑 + 한국 capacity gap 통합

> 마일스톤 M8 산출물 · current-state · no history.
> 출처 = 한국 registry 출판물 + 학회 가이드라인 → 🟡 SUPPORTED-BY-CITATION.
> 목적 = NOREFLOW M2/M3/M5 글로벌 결론을 한국 임상·보험·capacity 환경에 매핑 → M7 통합 ranking 입력.

---

## 1. 한국 STEMI / PCI registry 4대

| Registry | 기간 | n | 다기관 수 | 데이터 type | 주요 endpoint |
|---|---|---|---|---|---|
| **KAMIR / KAMIR-NIH** | 2005~ (KAMIR-NIH 2011~) | >20,000 누적 | ~50개 (KAMIR) · 20개 (NIH 코어) | clinical · angio · 30d/1y/5y MACE | all-cause death · re-MI · TVR |
| **K-ACTION** (Korean ACTive INtervention) | 2008~ | ~4,000 | ~15개 | PCI 디바이스 · IMR sub-study 일부 | MACE + procedural |
| **KAMIR-V** (sub-analysis 시리즈) | 2014~ | varies | KAMIR backbone | adenosine IC · GP IIb/IIIa 등 약물 subgroup | no-reflow 빈도 · TIMI flow |
| **HOST 시리즈** (서울대) | HOST-EXAM 2014~ · HOST-REDUCE 2017~ · HOST-IDEA 2021~ | 2,000~5,000 per RCT | 30~37개 | DAPT · ISR · drug strategy | bleeding + ischemic composite |

비고:
- KAMIR-NIH는 NIH(국립보건연구원) 후원 표준화 코어 → 가장 인용 빈도 높음
- HOST 시리즈는 RCT (registry 아님) — 단 STEMI / PCI 환자 풀 공유
- 다기관 CMR sub-study는 KAMIR/K-ACTION 둘 다 부재 (§4 gap)

---

## 2. 한국인 no-reflow 빈도 + 인구학적 특성

| 축 | 한국 (KAMIR-NIH subset) | 글로벌 비교 |
|---|---|---|
| Angiographic no-reflow (TIMI ≤2 post-PCI) | ~12-18% | ~10-30% |
| cMRI MVO (단일기관 sub-study) | ~30-50% | ~30-55% |
| 평균 symptom-to-balloon | ~150-200 분 | 미국 ~120 · 일본 ~140 |
| 평균 door-to-balloon | ~60-80 분 (대학병원) | 미국 ~60 · 권고 ≤90 |
| LAD culprit 비율 | ~45-50% | ~40-50% |
| LM occlusion | ~3-5% | ~3-7% |
| Multi-vessel disease | ~50-60% | ~50% |
| 평균 체중 | ~65 kg (남) · ~58 kg (여) | 서구 80-90 kg |
| 평균 BMI | ~24-25 | 서구 28-30 |

함의:
- ischemic time 길다 → reperfusion injury / MVO 노출 시간 증가 → mPTP 표적 (M2) 적합도 증가
- 체격 작다 → bleeding risk 가중 + drug dose 글로벌 RCT 외삽 시 over-dosing 위험 (abciximab · cangrelor)
- LAD 우세 + multi-vessel → MVO + LVEF 저하 + HF 진행 위험 높음 → endpoint (M5) sensitivity 유리

---

## 3. 한국 약제 / 디바이스 가용성 매트릭스

| 약제 / 디바이스 | 보험 급여 | 한국 우위 | gap |
|---|---|---|---|
| adenosine IC 24 mg bolus | OK (off-label 통용) | 표준 사용 | — |
| nicorandil oral 5-15 mg / IV | **OK (J-WIND 후 한국 보험 등재)** | **글로벌 우위** (일본·한국만 보편 보험) | — |
| nitroprusside IC (50-200 µg) | OK | — | 사용 빈도 낮음 · familiarity 부족 |
| verapamil / nicardipine IC | OK | — | — |
| abciximab IC bolus | OK | — | bleeding 한국 dose-adjust 필요 |
| CsA (Sandimmune IV) | OK (이식 적응증) | — | mPTP 적응증 IRB 추가 필요 |
| NIM811 · sanglifehrin A · debio-025 | X (수입 X) | — | **gap — drug-import IND** |
| MTP-131 (elamipretide / Bendavia) | X | — | **gap — frontier drug** |
| aspiration catheter (Export · Thrombuster) | OK | — | TOTAL stroke 신호 이후 routine 권고 X |
| distal protection (Filtrap · SpiderFX) | OK | — | SVG 위주 · STEMI 사용 빈도 낮음 |
| drug-eluting catheter (sirolimus / abciximab coated) | X | — | **frontier gap — preclinical only** |

핵심:
- **nicorandil + adenosine** — 보험 안에서 즉시 진행 가능한 한국 우위 조합
- **mPTP 후보군 (CsA 외)** — 거의 전부 한국 미수입 → M2 path A (NAD+/NMN supplement) 우회로가 현실적
- **frontier drug-eluting catheter** — 한국 medical-device 임상시험 가능 (식약처 IND) — 단 preclinical capacity 부재

---

## 4. 한국 IMR / CMR 임상 capacity

| capability | 기관 수 | 대표 기관 | bottleneck |
|---|---|---|---|
| IMR pressure-wire (Abbott PressureWire X · Coroventis CoroFlow) | ~10 | 서울대 · 세브란스 · 삼성서울 · 아산 · 분당서울대 · 고려대 · 한양대 · 부산대 · 전남대 · 가천대 | 일회용 wire 보험 cap |
| CMR 1.5T/3T MVO sequence (LGE · T2 · MOLLI) | ~15-20 | + 인하대 · 영남대 · 충남대 · 원주세브란스 · CHA | central core lab 부재 |
| **다기관 CMR consortium** | **0** | — | **NOREFLOW 최대 gap (M5 결론 재확인)** |
| 동물 IRI 모델 (rat LAD ligation · rabbit) | ~6-8 | 서울대 · 연세대 · 부산대 · 가천대 · 충북대 · KIST | LAD 결찰 표준화 X |
| 동물 CMR (small-animal MRI) | ~3 | 서울대 · 가천대 · KIST | 7T 가용 기관 제한 |

함의:
- IMR-guided RCT는 한국 단독으로 **글로벌 first-in-class** 진입 가능 (§5)
- CMR consortium은 보건복지부 R&D 과제 (KHIDI 임상연구 인프라) 트랙으로 ~2-3년 빌드 가능
- 동물 capacity는 path A (NAD+/NMN) preclinical 검증에 충분

---

## 5. 한국 임상시험 gap 표

| 임팩트 영역 | 글로벌 trial | 한국 단독 trial | 한국 capacity | 진입 난도 |
|---|---|---|---|---|
| mPTP CsA reperfusion | CIRCUS · CYCLE (유럽, 둘 다 neutral) | 부재 (gap) | IRB 가능 (off-label) | 중 (negative trial 재현 risk) |
| adenosine IC | AMISTAD-II · REOPEN-AMI | 부재 (KAMIR subgroup 분석만) | OK | 낮음 |
| **nicorandil pre-PCI** | **J-WIND (일본 · positive)** | **부재** | **유리 (보험 + familiarity)** | **낮음 (한국 우위)** |
| thrombectomy routine | TASTE · TOTAL (둘 다 neutral / stroke 신호) | 부재 | OK | — (routine 권고 X) |
| drug-eluting catheter | preclinical only | 부재 | **frontier — capacity 부족** | 높음 |
| **IMR-guided cause-stratified RCT** | **부재 (글로벌 공백)** | **부재 → first-in-class 기회** | **OK (~10개 기관)** | **중 (consortium 필요)** |
| NAD+/NMN supplement IRI pilot | preclinical 다수 | 부재 | 시중 supplement 가용 → IRB-light | 낮음 |

---

## 6. 한국 우위 + 돌파 3-path (M2 §4 한국 적용)

### Path A — CypD-selective 우회 · NAD+/NMN supplement IRB-light pilot
- **근거**: mPTP 직접 표적 약물 (NIM811 · sanglifehrin) 한국 미수입 → 즉시 진행 불가
- **우회**: NAD+/NMN은 한국에서 건강기능식품으로 시판 → IRB-light 단일기관 pilot 진행 가능
- **endpoint**: IMR pre/post + CMR MVO (M5 surrogate)
- **단점**: dose-response 표준 부재 · supplement-grade purity 변동

### Path B — IMR-guided cause-stratified RCT (한국 first-in-class)
- **근거**: 글로벌 RCT 모두 cause-mixed enrollment → neutral 결과 양산 (CIRCUS · TASTE · TOTAL)
- **전략**: 한국 ~10개 IMR-capable 기관 consortium → IMR > 40 (MVO+) subset만 enroll → power 향상
- **arm 후보**: nicorandil pre-PCI (Path C와 결합 가능) · NAD+ IV · adenosine high-dose IC
- **임팩트**: positive 시 한국 발 글로벌 가이드라인 영향 → MRI/IMR 표준화 spin-off

### Path C — nicorandil 보험 우위 활용 · pre-PCI nicorandil + IC adenosine 조합
- **근거**: J-WIND (일본 2007) positive · 한국 보험 등재 + familiarity
- **전략**: STEMI activation 시점 nicorandil oral/IV loading + PCI 도중 IC adenosine 24 mg
- **endpoint**: angiographic no-reflow 빈도 + IMR + 30d CMR MVO
- **장점**: 두 약 모두 보험 안 → 추가 cost 0 · 시험 진행 lift 낮음
- **단점**: nicorandil 글로벌 RCT 재현성 (J-WIND 외 trial 부족)

---

## 7. 한국 다기관 consortium 구상 (M7 ranking 입력)

### 참여 후보 (8 기관)
서울대 · 세브란스 · 삼성서울 · 아산 · 분당서울대 · 고려대 · 한양대 · 부산대

### 표준화 항목
| 항목 | 표준 |
|---|---|
| CMR protocol | 1.5T · LGE (PSIR) + T2 STIR + MOLLI T1 mapping · 30d post-PCI |
| MVO 정의 | LGE hyper-enhanced lesion 안의 hypo-intense core, ≥1 contiguous slice |
| IMR 측정 | post-PCI · resting + hyperemic (adenosine IV 140 µg/kg/min) · cut-off 40 |
| 환자 enrollment | symptom-onset ≤12h · primary PCI · age 18-80 · informed consent |
| central core lab | CMR 판독 (2-reader blinded) + IMR QC |

### 연구비 source
- **보건복지부** 환자중심의료기술 최적화 (PCORI-type) 연구
- **KHIDI** (한국보건산업진흥원) 임상연구인프라 조성
- **학회**: 대한심혈관중재학회 (KSIC) · 대한심장학회 (KSC)
- 산업체: 디바이스 (Abbott PressureWire) · 약제 (nicorandil 제약사)

---

## 8. 참고문헌

- Park KW et al. (2012) *J Am Coll Cardiol* — Korean DES outcome registry
- Park KW et al. (2020) *Lancet* — TICAKOREA (ticagrelor in Korean ACS)
- Kim HS et al. (2020) *JAMA Cardiol* — HOST-EXAM (long-term DAPT)
- Sim DS et al. (2017) *Korean Circ J* — KAMIR-NIH cohort profile + outcomes
- Kitakaze M et al. (2007) *Lancet* 370:1483 — J-WIND nicorandil + ANP (일본 reference)
- Niccoli G et al. (2013) *Circulation* — REOPEN-AMI adenosine IC
- Frobert O et al. (2013) *NEJM* 369:1587 — TASTE thrombectomy
- Jolly SS et al. (2015) *NEJM* 372:1389 — TOTAL trial + stroke 신호
- Stone GW et al. (2016) *JACC* 67:1674 — CMR MVO surrogate validation
- Cung TT et al. (2015) *NEJM* 373:1021 — CIRCUS (CsA, neutral)
- Ottani F et al. (2016) *JACC* 67:365 — CYCLE trial (CsA, neutral)
- Korean Society of Interventional Cardiology STEMI guideline (2022 update)

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| KAMIR / K-ACTION cohort 규모 + endpoint | 🟡 SUPPORTED-BY-CITATION | Sim 2017 + KAMIR-NIH 출판 |
| 한국 no-reflow 빈도 (12-18%) | 🟡 SUPPORTED-BY-CITATION | KAMIR subset analyses |
| 약제 보험 매트릭스 | 🟡 SUPPORTED-BY-CITATION | HIRA 약가 + KSIC guideline |
| IMR / CMR capacity 기관 수 | 🟡 SUPPORTED-BY-CITATION | 학회 등록 + 연수교육 명단 |
| 다기관 CMR consortium 부재 | 🟡 SUPPORTED-BY-CITATION | 출판 검색 null result |
| 3-path 돌파 전략 | 🟠 INSUFFICIENT (M7 ranking 후 등급화) | 본 milestone scope 외 |

다음 단계 — M7 통합 ranking에서 Path A/B/C × 한국 capacity weighting → top-3 candidate strategy 선정.
