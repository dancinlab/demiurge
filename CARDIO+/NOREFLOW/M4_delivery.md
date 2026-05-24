# M4 — 전달 경로 (delivery route) 5-tier + IC 우위 정량 + d2 wall 매트릭스

> 마일스톤 M4 산출물 · current-state · no history.
> 출처 = literature (RCT + PK + guideline) → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).
> M2 d2 wall (재관류 첫 5분 lethal window vs IV bolus arm-to-heart lag 30-120s) → 본 M4가 **PK 우회 경로** 규정.
> M3 (미세혈관 약물 5-family) × M4 (전달 경로) 매트릭스가 M7 ranking 입력.

---

## 1. 전달 경로 5-tier 분류

```
[ 전달 경로 5-tier · proximal → distal · systemic → local ]

                                    PCI 시술 동안 사용 가능
                                  ┌─────────────────────────┐
                                  │                         │
  systemic ◄──────────────────────┼──── local ──────────────┤
                                  │                         │
  T2 IV systemic                  T1 IC bolus               T5 drug-eluting
  (말초 정맥)                      (guide / micro-cath)      catheter / wire
   arm→heart                       coronary ostium             local sustained
   lag 30-120s                     direct                      release
                                  │                         │
                                  │  T3 thrombectomy         │
                                  │  (aspiration · proximal) │
                                  │                         │
                                  │  T4 distal protection    │
                                  │  (filter · 원위부)        │
                                  │                         │
                                  └─────────────────────────┘
                                     LAD/LCX/RCA 내부
```

| Tier | 명칭 | 위치 | 작용 | 임상 stage | M2/M3 약물 호환 |
|---|---|---|---|---|---|
| **T1** | IC bolus (intracoronary) | guide catheter 또는 microcatheter | 약물 직접 주입, coronary ostium ~ distal segment | 광범위 (off-label routine) | adenosine · NTG · verapamil · nicardipine · abciximab |
| **T2** | IV systemic | 말초 정맥 (antecubital) | 전신 순환 → coronary | guideline 표준 | nicorandil · cangrelor · CsA · adenosine (high-dose) |
| **T3** | Mechanical thrombectomy | aspiration catheter (Pronto · Export · Eliminate) | 혈전 흡인 제거 | guideline (selective, IIb) | 비약물 — DE cause 직접 제거 |
| **T4** | Distal protection device (DPD) | filter (Filterwire EZ) · occlusion balloon (GuardWire) | 원위부 embolic debris 포획 | SVG PCI에서만 권고 (Class I) | 비약물 — DE cause 차단 |
| **T5** | Drug-eluting catheter / guidewire | PLGA-coated wire · DCB · reperfusion-synced inflator | local sustained release + 풍선 inflation 동기화 | preclinical → early clinical (DCB는 ISR에서 임상화) | mPTP CypD-selective (NIM811) · paclitaxel (DCB) |

T1·T2가 약물 전달의 두 주축. T3·T4는 mechanical (DE 직접 제거), T5는 frontier.

---

## 2. IC bolus PK 우위 — 정량

### 2.1 Arm-to-heart lag

| 경로 | 도달 시간 (coronary microvasc) | 근거 |
|---|---|---|
| 말초 IV (antecubital, infusion pump) | **30-120 s** (bolus 후) | 정맥→상대정맥→우심→폐→좌심→대동맥→관상동맥 — Henderson 2003 |
| Central IV (CVC, jugular/subclavian) | 15-30 s | 위와 동일 경로, 시작점만 단축 |
| **IC bolus (guide catheter)** | **~0-3 s** | coronary ostium 직접, 1 cardiac cycle 내 도달 |
| **IC bolus (microcatheter distal)** | **~0-1 s** | culprit lesion 원위부 직접 주입 |

→ 재관류 첫 5분 lethal window (M2 d2 wall) 대비 **IV는 6-24% 손실, IC는 ~0%**.

### 2.2 국소 농도 ratio — IC vs IV

| 약물 | IV dose | IC dose | Cmax ratio (coronary) | t1/2 elimination | 근거 |
|---|---|---|---|---|---|
| Adenosine | 70 μg/kg/min × 3h (AMISTAD-II) | 24 mg distal bolus (REOPEN-AMI) | **~30-100×** (very short t1/2 보정) | <10 s | Niccoli 2013 |
| Verapamil | 5-10 mg IV × 2 min | 200-1000 μg IC bolus | ~50× | 3-7 h (전신은 무관) | Werner 2002 |
| Nicardipine | 5 mg/h IV infusion | 100-200 μg IC bolus | ~30-60× | 2-4 h | Huang 2006 |
| Abciximab | 0.25 mg/kg IV bolus + 12 h infusion | 0.25 mg/kg IC bolus | ~3-10× (단백 결합 큼) | 10-15 min (free) · 일주일 (bound) | Stone 2012 (INFUSE) |
| Eptifibatide | 180 μg/kg IV × 2 bolus | 180 μg/kg IC | ~5× | ~2.5 h | Deibele 2010 |
| Sodium nitroprusside | 0.5-10 μg/kg/min IV | 60-100 μg IC bolus | ~20-40× | 1-2 min | Hillegass 2001 |
| **Cyclosporine A (CsA)** | 2.5 mg/kg IV (CIRCUS, IT) | **미시도** (M2 §4 Path B) | n/a — 1.5 h infusion이라 arm-to-heart lag 미해결 | 8-20 h | Cung 2015 (CIRCUS neutral) |

핵심: short-t1/2 vasodilator (adenosine · NTG · NPS)에서 IC 우위 가장 크다. 단백 결합 큰 약물 (abciximab)은 ratio 축소.

---

## 3. 임상 결과 — IC vs IV head-to-head

| 약물 | IC trial | IV trial | IC 코호트 | IV 코호트 | Primary endpoint | 결과 |
|---|---|---|---|---|---|---|
| **Adenosine** | REOPEN-AMI (Niccoli 2013) | AMISTAD-II (Ross 2005) | n=240, IC 4 mg + NPS | n=2118, 70 μg/kg/min × 3h | MVO (cMRI 5d) / CHF·death | **IC: MVO 14% vs 35%, p=0.001** · IV neutral, 70 μg subgroup infarct ↓ |
| **Verapamil** | Werner 2002 (small) | 임상 거의 부재 (전신 hypotension) | n=20, 1 mg IC | — | CFR · TIMI frame count | IC positive (small, mechanistic) |
| **Nicardipine** | Huang 2006 · 다수 case series | 미주류 (전신 hypotension) | n=70, 200 μg IC | — | TIMI flow grade | IC positive (uncontrolled) |
| **Abciximab** | INFUSE-AMI (Stone 2012) | EVA-AMI · standard IV | n=452 (IC arm), 0.25 mg/kg IC | 동량 IV | Infarct size (cMRI 30d) | **Primary neutral**; **BMS subset positive** (15.1% vs 17.9%, p=0.03) |
| **Eptifibatide** | AIDA STEMI (Eitel 2013) | standard IV | n=452 (IC arm) | n=450 (IV arm) | Infarct size (cMRI 5d) | Neutral (15.0% vs 14.8%) |
| **Cangrelor** | 미시도 | CHAMPION-PHOENIX (Bhatt 2013) | — | n=11,145, 30 μg/kg IV bolus + 4 μg/kg/min | Composite ischemic at 48h | IV: 4.7% vs 5.9% (clopidogrel), p=0.005 — but no-reflow specific X |
| **Cyclosporine A** | **미시도** (M2 §4 Path B) | CIRCUS (Cung 2015) | — | n=970, 2.5 mg/kg IV bolus | Composite 1y | **Neutral** (59% vs 58%) — IV PK가 lethal window 놓침 |
| **Sodium nitroprusside** | Hillegass 2001 · combined w/ adenosine | — | n=20-50 (small) | — | TIMI flow / blush | IC positive (small) |

**해석**: short-t1/2 vasodilator (adenosine · NPS · Ca²⁺ blocker) IC 우위 대형 RCT 확립. mPTP 억제 (CsA) · GP IIb/IIIa는 IV에서 neutral — **IC + reperfusion-synced 재시도가 d2 wall 돌파 경로** (M2 §4 Path B).

---

## 4. Mechanical strategy — thrombectomy + DPD

### 4.1 Aspiration thrombectomy — routine 권고 철회

| Trial | n | 디자인 | Primary endpoint | 결과 |
|---|---|---|---|---|
| TAPAS (Svilaas 2008) | 1,071 | Aspiration vs PCI alone | Myocardial blush grade | Aspiration 우월 (small) |
| TASTE (Frobert 2013) | **7,244** | Aspiration vs PCI alone | All-cause mortality 30d | **Neutral** (2.8% vs 3.0%) |
| TOTAL (Jolly 2015) | **10,732** | Aspiration vs PCI alone | CV death/MI/CHF/stroke 180d | **Neutral** + **stroke ↑** (0.7% vs 0.3%, p=0.02) |

→ 2017 ESC + 2021 ACC/AHA guideline: **routine X · high thrombus burden (TIMI thrombus grade ≥4) bailout only**.

### 4.2 Distal protection device (DPD) — SVG 한정

| Trial | n | 디자인 | 결과 |
|---|---|---|---|
| SAFER (Baim 2002) | 801 | SVG PCI + GuardWire vs PCI alone | MACE ↓ 9.6% vs 16.5% (p=0.004) — **SVG에서 Class I** |
| EMERALD (Stone 2005) | 501 | **Native coronary STEMI** + GuardWire vs PCI alone | **Neutral** ST-resolution + infarct size |
| PROMISE (Gick 2005) | 200 | Filter in STEMI | Neutral |

→ Native coronary에서 DPD는 효과 X. SVG (saphenous vein graft) PCI에서만 일관된 효과.

### 4.3 ASCII — mechanical vs pharmacological

```
[ no-reflow 4-cause (M1 §4) ]    [ mechanical (T3/T4) ]    [ pharmacological (T1/T2) ]
   DE  (distal embolization) ──► aspiration · DPD ────────► GP IIb/IIIa IC
   IR  (ischemia-reperfusion) ─► n/a ─────────────────────► CsA IC (M2 Path B) · mPTP
   VS  (vasospasm)            ─► n/a ─────────────────────► adenosine · NTG · CaB IC
   ED  (endothelial dysfn)    ─► n/a ─────────────────────► NO donor · nicorandil
```

Mechanical은 DE 한 가지에만 직접 작용 — pharmacological이 4-cause 전반 커버.

---

## 5. Drug-eluting catheter / guidewire — frontier

### 5.1 현 상태

| 기술 | 위상 | 적응증 | no-reflow 적용 |
|---|---|---|---|
| **Drug-coated balloon (DCB)** — paclitaxel · sirolimus | clinical (Class IIa for ISR · small vessel) | in-stent restenosis · 분지 lesion | **미시도** (no-reflow에서 임상 X) |
| **Drug-eluting guidewire** — PLGA-coated · paclitaxel-eluting | preclinical (Wu 2015 등) | 동물 모델 | n/a |
| **Reperfusion-synced IC bolus** | clinical 가능 (off-label) — guide catheter 통한 풍선 inflation 직전 bolus | manual synchronization | 임상 routine 일부 (no-reflow rescue) |
| **Local sustained-release stent (drug-eluting)** | clinical (DES standard) | restenosis | mPTP/microvasc 표적 약물 코팅 X |

### 5.2 M2 §4 Path B 연결 — CypD-selective + IC-synced

M2 d2 wall 돌파 Path B = CypD-selective inhibitor (NIM811) + IC + reperfusion-synced delivery.

- **NIM811 (사이클로필린 D-selective, non-immunosuppressive)**: 동물 IRI 50% 감소 (Hansson 2009), 임상 H1 단계
- **Delivery 요구**: 풍선 직전 IC bolus (~0-1s 도달) → 풍선 inflation = 약물이 distal microvasculature 도달하는 lethal window 진입
- **현재 gap**: NIM811 IC formulation 없음 · GLP tox 미완 · sponsor 부재

→ Path B 실현 = M5 frontier (drug-eluting catheter / synced delivery) + M2 §4 Path B (CypD-selective compound) 동시 충족.

### 5.3 ASCII — synced delivery 타이밍

```
[ PCI 타임라인 + IC-synced delivery ]

T-30s  ┃ guide catheter engaged · culprit lesion 확인
T-10s  ┃ microcatheter → distal segment
T-3s   ┃ IC bolus (CypD-selective · CsA · adenosine)  ← 약물 주입
T=0    ┃ balloon inflation · reperfusion 시작           ← lethal window 진입
T+1s   ┃ 약물이 microvasculature 도달 (no arm-to-heart lag)
T+5min ┃ lethal window 끝 — mPTP fate 결정
                                                       ▲
                                  IV bolus (T=0)는 여기 도달 (T+30-120s)
                                  → lethal window 안에서 농도 부족
```

---

## 6. d2 wall 돌파 매트릭스 — M2/M3 약물 × M4 전달 경로

| 약물 family | 표적 cause | 최적 전달 | 임상 단계 | KR 가용 | M2 d2 wall 돌파 path |
|---|---|---|---|---|---|
| **mPTP CypD-selective (NIM811)** | IR | T1 IC + T5 풍선 동기화 | preclinical | gap (수입 X) | **Path B 핵심** |
| **mPTP CsA** | IR | T1 IC bolus (재시도) | Phase 3 IV neutral (CIRCUS) | IV 형태 OK | **Path A** (CIRCUS IC 재시도) |
| **Adenosine A2A** | VS · IR (부분) | T1 IC 24 mg | RCT positive (REOPEN-AMI) | 가능 (off-label) | 입증된 IC |
| **Nicorandil** | VS · IR (부분) | T2 IV pre-PCI · T1 IC | RCT (J-WIND) | 가능 (보험 일본 우위) | IV 표준 |
| **NTG · sodium nitroprusside** | VS · ED | T1 IC bolus | RCT positive (Hillegass) | 광범위 (저가) | 입증된 IC |
| **Verapamil · nicardipine** | VS | T1 IC bolus | small RCT (Werner · Huang) | 가능 (저가) | 입증된 IC |
| **Abciximab IC** | DE | T1 IC | Phase 3 (INFUSE-AMI neutral primary, BMS subset positive) | 단종 → tirofiban 대체 | partial |
| **Tirofiban IC** | DE | T1 IC | Phase 3 (Niccoli 2017 meta positive) | 가능 (저가) | 입증된 IC |

```
[ 약물 × 전달 trade-off 다이아몬드 ]

                      가장 좋은 효율
                            ▲
                            │
              IC + synced (T1+T5)
              /            \
             /              \
   IC bolus (T1)        DCB local (T5)
    short-t1/2           sustained
    vasodilator          mPTP selective
        │                    │
   IV systemic (T2)     thrombectomy/DPD (T3/T4)
   arm-to-heart lag      DE only
        \                /
         \              /
        가장 나쁜 효율 (long lag, 단일 cause)
```

---

## 7. 한국 capacity — M8 입력

| 카테고리 | 가용성 | 비고 |
|---|---|---|
| **Guide catheter (6Fr/7Fr)** | 광범위 (보험) | 모든 cath lab 표준 |
| **Microcatheter (Finecross · Caravel · Corsair)** | 가능 (보험 일부) | CTO 시술 표준, distal IC bolus 가능 |
| **Aspiration thrombectomy catheter (Eliminate · Export)** | 가능 (보험 selective) | high thrombus bailout 사용 |
| **Distal protection device (Filterwire EZ · GuardWire)** | **사용 빈도 낮음** | SVG PCI 드물어 routine X |
| **Drug-coated balloon (DCB)** | 가능 (ISR/small vessel 보험) | no-reflow 적응증 X |
| **Drug-eluting guidewire** | **임상 가용 X (frontier gap)** | 전임상 — 국내 개발 기회 |
| **Adenosine · NTG · verapamil · nicardipine** | 광범위 (저가) | IC bolus 처방 가능 |
| **Tirofiban** | 가능 (보험) | abciximab 단종 대체 |
| **Nicorandil** | 가능 (보험) | 일본·한국 우위 |
| **CsA IV** | 가능 (이식과 공유) | no-reflow 적응증 X (off-label) |
| **NIM811 (CypD-selective)** | **수입/가용 X** | 임상시험 IND 필요 |

→ M2/M3 표준약 8종은 한국 routine 가능. Path B (NIM811 + drug-eluting catheter)는 IND + 국내 개발 협업 필요.

---

## 8. 참고문헌

- Werner GS, Lang K, Kuehnert H, Figulla HR (2002) *Circulation* 105:2275 — IC verapamil for no-reflow
- Hillegass WB et al. (2001) *Catheter Cardiovasc Interv* 53:444 — IC sodium nitroprusside
- Niccoli G, Rigattieri S, De Vita MR et al. (2013) *JACC Cardiovasc Interv* 6:580 — REOPEN-AMI IC adenosine
- Ross AM et al. (2005) *JACC* 45:1775 — AMISTAD-II IV adenosine
- Stone GW et al. (2012) *JAMA* 307:1817 — INFUSE-AMI IC abciximab
- Eitel I et al. (2013) *JACC* 61:1447 — AIDA STEMI IC eptifibatide
- Frobert O et al. (2013) *NEJM* 369:1587 — TASTE thrombectomy
- Jolly SS et al. (2015) *NEJM* 372:1389 — TOTAL thrombectomy
- Baim DS et al. (2002) *Circulation* 105:1285 — SAFER SVG distal protection
- Stone GW et al. (2005) *JAMA* 293:1063 — EMERALD native coronary DPD
- Bhatt DL et al. (2013) *NEJM* 368:1303 — CHAMPION-PHOENIX cangrelor IV
- Cung TT et al. (2015) *NEJM* 373:1021 — CIRCUS cyclosporine IV neutral
- Cortese B et al. (2020) *Eur Heart J* 41:1538 — DCB clinical review
- Niccoli G, Burzotta F, Galiuto L, Crea F (2016) *Circ Res* 118:127 — no-reflow IC delivery review
- Wu E et al. (2015) *J Control Release* 219:543 — drug-eluting guidewire prototype (preclinical)
- Henderson RA et al. (2003) — peripheral IV PK lag baseline

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 5-tier 전달 경로 분류 | 🟡 SUPPORTED-BY-CITATION | guideline + Niccoli 2016 review |
| Arm-to-heart lag 30-120s · IC ~0s | 🟡 SUPPORTED-BY-CITATION | Henderson 2003 + 표준 PK textbook |
| IC vs IV Cmax ratio | 🟡 SUPPORTED-BY-CITATION | 약물별 PK 문헌 (Werner · Niccoli · Stone) |
| RCT 결과 (REOPEN-AMI · INFUSE · TASTE · TOTAL · EMERALD · CIRCUS) | 🟡 SUPPORTED-BY-CITATION | 등록 trial primary publication |
| Drug-eluting guidewire 전임상 | 🟡 SUPPORTED-BY-CITATION | Wu 2015 + preclinical pipeline |
| KR capacity table | 🟡 SUPPORTED-BY-CITATION | 보험·실무 관행 (출처 mixed) |
| Synced delivery 타이밍 모델 | 🟡 SUPPORTED-BY-CITATION | M2 §4 Path B 연결 — first-principles 정량은 M7 단계 |

다음 단계: M7 (delivery × drug × cause 종합 ranking)에서 본 매트릭스 + M2/M3 + cost·KR feasibility 가중치 적용 → short-list 5-10종 도출.
