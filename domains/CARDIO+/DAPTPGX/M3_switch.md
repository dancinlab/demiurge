# M3 — 약제 전환 결정 트리 (clopidogrel ⇄ prasugrel / ticagrelor)

> 마일스톤 M3 산출물 · current-state · no history.
> 입력 = M1 (한국인 phenotype 분포) + M2 (active AUC · PRU) + M4 (PRECISE-DAPT · ARC-HBR) + M5 (PFT) → 출력 = escalation / de-escalation 결정 트리.
> 출처 = TRITON-TIMI 38 · PLATO · TICAKOREA · TROPICAL-ACS · TOPIC · HOST-REDUCE-POLYTECH-ACS + ESC/ACC/AHA/KSC 가이드라인 → 🟡 SUPPORTED-BY-CITATION.

---

## 1. 3제 비교 표 — clopidogrel · prasugrel · ticagrelor

| 항목 | **clopidogrel** | **prasugrel** | **ticagrelor** |
|---|---|---|---|
| 화학 클래스 | thienopyridine 2세대 | thienopyridine 3세대 | cyclopentyl-triazolo-pyrimidine (CPTP) |
| **Prodrug?** | **Yes** (2-step CYP) | **Yes** (1-step CYP) | **No** (직접 활성 + 활성대사물 AR-C124910XX) |
| **CYP 의존성** | **CYP2C19 (직렬 2회)** + CYP3A4/2B6 | CYP3A4 · **CYP2B6** · CYP2C19 (보조) | CYP3A4/5 (대사 — 활성은 모분자도 가짐) |
| **CYP2C19 LoF 영향** | **막대** (active AUC −50~70%) | 미미 (NM 대비 −5~10%) | 없음 |
| P2Y12 결합 | **비가역** (covalent Cys17/270) | **비가역** (covalent) | **가역** (allosteric) |
| Loading dose | 300-600 mg | 60 mg | 180 mg |
| Maintenance | 75 mg qd | 10 mg qd (서구) / **5 mg qd (한국·일본)** | 90 mg **bid** |
| Plasma t½ (active) | ~30 분 (R-130964) | ~7 시간 (R-138727) | 7-9 h (parent) + 9-12 h (AR-C…) |
| Onset (IPA ≥50%) | 4-6 h (300 mg) · 2-4 h (600 mg) | **~30 min** | **~30 min** |
| Offset (회복) | 7-10 일 (platelet turnover) | 7-10 일 | **3-5 일** (가역 + 짧은 t½) |
| 출혈위험 (vs clopi, RCT) | reference | **TIMI major +32%** (TRITON) | **PLATO major +25%** (PLATO, non-CABG) |
| 동양인 dose 조정 | 없음 | **10 mg → 5 mg** (KAMIR-NIH · 일본 PMDA) | 90 mg bid 유지 but 출혈 ↑ 감시 (TICAKOREA) |
| 호흡곤란 부작용 | < 1% | < 1% | **~15%** (adenosine reuptake 억제) |
| 서맥 / AV block | 거의 없음 | 거의 없음 | **드물게 동기능 부전** |
| 요산 ↑ | 없음 | 없음 | **+0.5-1.0 mg/dL** (gout 악화 가능) |
| CYP3A4 강력 억제제 (azole 등) | 효과 ↓ 가능 | 영향 미미 | **금기** (active level ↑↑) |
| 가격 (한국 보험가, 일/대략) | ~500원 (제네릭) | ~2,500원 | ~3,500원 |

> **요점**: clopidogrel만 CYP2C19에 critical하게 의존 — 한국인 IM+PM 60%에서 이 라인이 약점. Prasugrel은 CYP2C19 우회 + 가장 강력 (출혈도 강력). Ticagrelor는 prodrug 의존성 자체를 제거 + 가역 + 빠른 offset (수술 시 유리).

---

## 2. Escalation 결정 트리 (ASCII)

```
한국인 PCI 환자 (ACS or elective)
        │
        ├─ ① CYP2C19 genotype (PCR or POC Spartan RX, 1-2h)
        │     ├─ NM/RM (~33%) ────────────────────┐
        │     ├─ IM (~45%) ───────────────────────┤
        │     └─ PM (~15%) ───────────────────────┤
        │                                          │
        ├─ ② ARC-HBR / PRECISE-DAPT (M4)           │
        │     ├─ HBR ⊕                             │
        │     └─ HBR ⊖                             │
        │                                          │
        ├─ ③ Ischemic risk                         │
        │     (ACS+multivessel · DM · prior MI · LM · bifurcation · stent ≥3)
        │     ├─ HIR ⊕                             │
        │     └─ HIR ⊖                             │
        │                                          │
        └─ ④ 금기 스크린                            │
              (prasugrel: >75세 · <60kg · prior CVA)
              (ticagrelor: CYP3A4 강력억제 · severe brady · ICH 과거력)
                                                   │
                                                   ↓
                                            ┌──── 약제 선택 ────┐
                                            │                   │
   ┌────────────────────────────────────────┴────────┐          │
   │                                                 │          │
   ▼                                                 ▼          ▼
PM/IM + HBR⊖ + HIR⊕                      PM/IM + HBR⊕        NM/RM
                                                                │
→ prasugrel 5 mg (한국인)                → clopidogrel         → clopidogrel
  or ticagrelor 90 bid                     + short DAPT          (default)
  + DAPT 12 mo                             (3-6 mo)              + DAPT 12 mo
  + 6 mo 후 de-escalation 고려             + HOST-EXAM 근거       (HBR⊕ 시 3-6 mo)
  (TROPICAL-ACS · HOST-REDUCE)              clopi 단독 유지      
                                                                
                                          ⚠ "high-stakes cell"
                                          PM × HBR⊕ (한국 100명 중 7-8명)
                                          → PFT (M5) 추가 + monthly 모니터
                                          → de-escalation 매우 보수적
```

### 트리 분기 요약 (룰 형식)

```
IF phenotype ∈ {PM, IM} AND HBR(-) AND HIR(+):
    → prasugrel 5mg OR ticagrelor 90mg bid · DAPT 12mo
IF phenotype ∈ {PM, IM} AND HBR(+):
    → clopidogrel 75mg · DAPT 3-6mo (HOST-EXAM 후 clopi 단독)
    IF phenotype = PM:
        → PFT 추가 (PRU > 280 시 ticagrelor 60mg 감량 검토)
IF phenotype ∈ {NM, RM}:
    → clopidogrel 75mg · DAPT 12mo (HBR(+) → 3-6mo)
IF phenotype = UM:
    → clopidogrel 75mg · 출혈 모니터 (PRU < 85 시 감량 검토 — 근거 약함)
```

---

## 3. Prasugrel — TRITON-TIMI 38 · CYP2C19 비의존 · 한국인 5 mg

### 핵심 시험 결과

| 시험 | n | 환자군 | 비교 | Primary endpoint | 결과 |
|---|---|---|---|---|---|
| **TRITON-TIMI 38** (2007) | 13,608 | ACS + planned PCI | prasugrel 10mg vs clopidogrel 75mg | CV death/MI/stroke 15mo | **9.9% vs 12.1% (HR 0.81, p<0.001)** |
| TRITON 출혈 sub | 같음 | 같음 | 같음 | TIMI major non-CABG | **2.4% vs 1.8% (HR 1.32, p=0.03)** |
| TRITON 순이익 sub | 같음 | 같음 | 같음 | net clinical benefit | clopi 우세군: **≥75세 · <60kg · prior CVA** (3대 금기) |
| **TRILOGY-ACS** (2012) | 9,326 | medical-Rx ACS (no PCI) | prasugrel 10/5mg vs clopi | CV death/MI/stroke 17mo | 음성 (HR 0.91, p=0.21) |
| **ACCOAST** (2013) | 4,033 | NSTEMI pre-treatment | prasugrel pre-PCI vs at-PCI | CV/MI/stroke/UR 7d | 음성 + 출혈 ↑ → **pre-treatment 금기** |

### 약리

- **CYP2C19 비의존**: prasugrel은 intestinal esterase → R-95913 (중간체) → CYP3A4·CYP2B6 (주) + CYP2C19·2C9 (보조) → R-138727 (active). CYP2C19 LoF carrier도 active AUC −5~10% 수준 (Mega 2009 *Circulation*, PMID 19729611).
- **신속 onset**: 60 mg loading 후 IPA ≥50% **30분 이내** — primary PCI에 유리.
- **비가역 covalent** P2Y12 차단 (clopi와 동일 메커니즘) → 7-10일 회복.

### 한국인 5 mg 권고 (KAMIR-NIH · 일본 PMDA)

| 근거 | 내용 |
|---|---|
| **PRASFIT-ACS** (일본, 2014) | n=1,363; prasugrel **20mg LD + 3.75mg MD** vs clopi 300+75 → MACE 9.4% vs 11.8% (비열등) + 출혈 동등 → 일본 PMDA 승인 |
| **KAMIR-NIH 분석** (Lee 2019) | 한국인 5mg arm = 10mg 대비 출혈 ↓ + MACE 동등 (관찰연구) |
| **PRASFIT-Elective** | n=741 (안정형 PCI); 3.75mg MD 비열등 |
| 동양인 PK | 체중 보정 시 5mg 한국인 active AUC ≈ 10mg 백인 active AUC (Small 2010 *J Clin Pharm*) |

### 금기 (절대 / 상대)

| 카테고리 | 기준 | 근거 |
|---|---|---|
| **절대** | prior **stroke / TIA** (모든 유형) | TRITON: net harm (ICH ↑↑) |
| **상대 (위험>이익)** | 연령 **≥75세** | TRITON subgroup: net 0 → 일본/한국 5mg로 사용 가능 |
| **상대** | 체중 **<60 kg** | dose 5mg 권고 (한국·일본은 default 5mg) |
| 활동성 출혈 | — | 공통 |

### 한국 임상 적용

- KSC 2024: ACS PCI + HBR⊖ + HIR⊕ → **prasugrel 5 mg** 고려 가능 (clopidogrel 대안).
- 60kg 미만 + ≥75세는 사용 회피 또는 PFT 가이드.

---

## 4. Ticagrelor — PLATO · CYP3A4 의존 · TICAKOREA 출혈 시그널

### 핵심 시험 결과

| 시험 | n | 환자군 | 비교 | Primary endpoint | 결과 |
|---|---|---|---|---|---|
| **PLATO** (2009) | 18,624 | ACS (STEMI · NSTEMI · UA) | ticagrelor 180+90bid vs clopi 300+75 | CV death/MI/stroke 12mo | **9.8% vs 11.7% (HR 0.84, p<0.001)** |
| PLATO 출혈 sub | 같음 | 같음 | 같음 | PLATO major (non-CABG) | **4.5% vs 3.8% (p=0.03)** |
| **PEGASUS-TIMI 54** (2015) | 21,162 | prior MI 1-3y | ticag 90bid / 60bid vs placebo | CV death/MI/stroke 33mo | 90: 7.85% / 60: 7.77% / pbo 9.04% (60mg 채택) |
| **PHILO** (2015, 동아시아) | 801 | ACS (한·일·대만) | ticag vs clopi | composite | 음성 + 출혈 ↑ (HR 1.47) |
| **TICAKOREA** (2020) | 800 | 한국 ACS | ticag vs clopi | PLATO major bleeding 12mo | **ticag 11.7% vs clopi 5.3% (HR 2.26)**; 허혈 ↓ 시그널 미달 |
| **TWILIGHT** (2019) | 7,119 | high-risk PCI (DAPT 3mo 무사) | ticag 단독 vs ticag+ASA 9mo | BARC 2/3/5 bleeding | **4.0% vs 7.1% (HR 0.56)** + 허혈 동등 |

### 약리

- **모분자가 활성** (prodrug 아님) — CYP2C19 LoF 영향 0.
- **CYP3A4/5** 대사 → 활성 metabolite AR-C124910XX (모분자와 동등 강도, t½ ~9-12h) 추가 생성.
- **가역 allosteric** P2Y12 차단 (ADP 결합부위와 다른 site) — 약물 제거 시 receptor 회복.
- **Adenosine reuptake 억제** (ENT1) → 호흡곤란 · 서맥 · 요산 ↑ 부작용 메커니즘.
- **CYP3A4 강력 억제제 (azole · macrolide · ritonavir)** 병용 시 active level ↑↑ → **금기**.

### 한국인 출혈 시그널 (TICAKOREA · PHILO)

```
한국 ACS 800명 (Park KW 2020 Circulation)
─────────────────────────────────────────
  ticagrelor arm  : PLATO major 11.7%
  clopidogrel arm : PLATO major  5.3%
                    ──────────────
  HR 2.26 (95% CI 1.48-3.45, p<0.001)
  허혈 사건: 9.2% vs 8.4% (NS)
  
  → 한국인에서 ticagrelor의 net benefit 입증 실패
  → KSC 2024: ticagrelor "first-line" 보류, clopi-first 선호
```

### 부작용 management

| 부작용 | 빈도 | 대응 |
|---|---|---|
| 호흡곤란 | 13-15% (PLATO) | 통상 mild — 지속 시 변경 (prasugrel) |
| 서맥 / sinus pause | < 1% | Holter 모니터; 동기능 부전 시 중단 |
| 요산 ↑ | 평균 +0.6 mg/dL | gout 과거력 시 allopurinol 병용 |
| ventricular pause (> 3 s) | 5.8% vs 3.6% (PLATO Holter) | 대개 무증상 |

---

## 5. De-escalation 시나리오 — TROPICAL-ACS · TOPIC · HOST-REDUCE-POLYTECH-ACS

| 시험 | n | 디자인 | de-escalation 시점 | Primary endpoint | 결과 |
|---|---|---|---|---|---|
| **TROPICAL-ACS** (2017) | 2,610 | ACS PCI; 1주차 prasugrel → 1-2주차 clopidogrel + PFT day 14 → HTPR(PRU≥46U MEA)면 prasugrel 복귀, OK면 clopi 유지 | **2주차** | net clinical benefit (CV/bleeding) 12mo | **7% vs 9% (HR 0.81, p비열등=0.0004)**; BARC 2-5 출혈 ↓ HR 0.82 |
| **TOPIC** (2017) | 646 | ACS PCI; 1mo prasugrel/ticag → 1mo 후 clopidogrel switch vs 12mo 유지 | **1개월** | NACE (death/UR/stroke/BARC ≥2) 12mo | **13.4% vs 26.3% (HR 0.48, p<0.001)**; 출혈 차이 dominant |
| **HOST-REDUCE-POLYTECH-ACS** (2020, 한국) | 2,338 | ACS PCI; 1mo prasugrel 10mg → 5mg 감량 vs 10mg 유지 12mo | **1개월 (dose ↓)** | NACE 12mo | **7.2% vs 10.1% (HR 0.70, p비열등 0.012)**; 출혈 ↓ 6.0% vs 9.5% |
| **HOST-EXAM** (2020, 한국) | 5,438 | PCI 12mo 후 chronic phase: clopi 단독 vs ASA 단독 | **PCI 후 12mo (chronic)** | thrombotic+bleeding 24mo | **clopi 5.7% vs ASA 7.7% (HR 0.73)** — chronic 단독요법 clopi 우위 |
| **POPular AGE** (2020) | 1,002 | NSTEMI ≥70세 | randomize clopi vs ticag/prasugrel from start | net benefit | clopi 17.6% vs 22.5% (비열등 + 출혈 ↓) |

### De-escalation 메타분석 요약 (Kuno 2021 *Lancet*, n>23,000)

- **uniform de-escalation** (시간 trigger, 1mo후 switch): 출혈 ↓ ~40%, 허혈 ↑ 시그널 없음.
- **guided de-escalation** (PFT or genotype trigger): 비열등 + 출혈 ↓ ~30%.
- 단 ACS 후 30일 이내 de-escalation은 권고하지 않음 (조기 stent thrombosis window).

### 한국인 권고 통합 (KSC 2024 + HOST-REDUCE)

```
PCI 후 1개월
        │
        ├─ ACS + prasugrel 10mg 시작 → 5mg 감량 (HOST-REDUCE)
        ├─ ACS + ticagrelor 90bid → clopidogrel switch (TOPIC, 단 PFT or genotype 확인 권고)
        └─ HBR⊕ + clopi → DAPT 종료 + clopi 단독 (HOST-EXAM, 12mo 후)
```

---

## 6. Switch 프로토콜 — loading · maintenance · risk window

### 6.1 Switch 방향별 프로토콜 (ESC 2020 Antiplatelet Consensus, Angiolillo 2017 *Eur Heart J*)

| From → To | 시점 | Loading 필요? | 시간 gap | 비고 |
|---|---|---|---|---|
| **clopi → prasugrel** (escalation) | acute (≤24h) | **60 mg LD** | 다음 dose 시점 | TRITON 적용 케이스 |
| **clopi → ticagrelor** (escalation) | acute | **180 mg LD** | 다음 dose 시점 | PLATO 적용 |
| **clopi → prasugrel** (chronic, >30d) | non-acute | **LD 권고** (Angiolillo) | 24h gap | de novo 부하 |
| **clopi → ticagrelor** (chronic) | non-acute | **LD 권고** | 24h gap | — |
| **prasugrel → ticagrelor** | acute | 180 mg LD | 24h gap | cross-reactivity 보고 드묾 |
| **ticagrelor → prasugrel** | acute | **60 mg LD** (필수) | 24h gap | rebound platelet reactivity 회피 |
| **prasugrel → clopi** (de-escalation) | non-acute | **600 mg LD** (acute setting) or **75 mg next dose** (chronic, TROPICAL-ACS 방식) | 24h gap | TROPICAL-ACS day 8 LD 600 |
| **ticagrelor → clopi** (de-escalation) | non-acute | **600 mg LD** (gap 12-24h) | **★ rebound 위험 ↑** | TOPIC: LD 후 75mg; 가역적 ticag offset 빠름 → window 좁음 |

### 6.2 출혈 risk window 표

```
약제별 platelet 회복 시간 (off-drug)
─────────────────────────────────────────────
                  IPA 50% 회복   IPA full 회복   수술 권고 hold
  clopidogrel     ~3 일          7-10 일         5 일
  prasugrel       ~5 일          7-10 일         7 일
  ticagrelor      ~1.5 일        3-5 일          3-5 일
```

### 6.3 Switch 시 rebound / overlap window

| 시나리오 | 메커니즘 | mitigation |
|---|---|---|
| **ticag → clopi** acute (LD 부족) | ticagrelor offset 빠름 (~1.5d) + clopi onset 느림 (4-6h LD 후) → **acute coronary 재발 위험 시간대 발생** | LD 600mg + 12h overlap; PFT 24h 후 확인 |
| **prasugrel → clopi** acute | prasugrel offset 느림 (5d) → overlap 자체 위험 작음 | LD 600mg; TROPICAL-ACS 방식 |
| escalation 모든 방향 | clopi → 강력제: 24h gap이 acute 환경에선 사치 | **즉시 LD + 다음 dose** |
| post-CABG 재시작 | bleeding 안정 후 LD 권고 | 외과 결정 |

```
시간 (h)  0    6    12   24   36   48   72
ticag 마지막 ●
                   │ — ticagrelor IPA decay ─────────────┐
clopi 600mg LD       ●                                    │
                            │ — clopi IPA build ───────→  │
                                                          │
"VULNERABLE WINDOW"     ◄────── 6-24 h ──────►            │
                        (양쪽 다 50% 미만 IPA)             │
                        → acute thrombotic 위험 ↑          │
```

→ **임상 권고**: ticag → clopi switch는 가급적 stable phase (>30d post-PCI)에 시행. Acute setting에선 LD 600mg + 12h overlap 의무.

---

## 7. 한국인 정량 시뮬레이션 — 100명 코호트 4-quadrant

### CYP2C19 phenotype × ARC-HBR 4-quadrant (M1 × M4 합성)

| | **HBR ⊕** (~25명) | **HBR ⊖** (~75명) | 행 합계 |
|---|---|---|---|
| **PM** (~15%) | **★ 7-8명** (high-stakes) | 7-8명 | 15명 |
| **IM** (~45%) | ~11명 | ~34명 | 45명 |
| **NM** (~32%) | ~8명 | ~24명 | 32명 |
| **RM/UM** (~1%) | <1명 | <1명 | 1명 |
| 기타 (rare) | ~1-2명 | ~5-6명 | ~7명 |
| **열 합계** | **~25명** | **~75명** | **100명** |

### 각 cell 약제 선택 + DAPT 기간 (KSC 2024 + CPIC 2022 통합)

| Cell | 인원 | 1차 약제 | DAPT 기간 | 보조 전략 |
|---|---|---|---|---|
| **PM × HBR⊕** ★ | **7-8명** | **clopi 75mg** + PFT 모니터 (PRU > 280 시 ticag 60mg 감량 검토) | **3-6 mo** then clopi 단독 (HOST-EXAM) | de-escalation 매우 보수적; monthly Hb·BUN/Cr·BARC 모니터 |
| **PM × HBR⊖** | 7-8명 | **prasugrel 5mg** (한국인) or ticagrelor 90bid | 6-12 mo | 1mo 후 prasugrel→clopi de-escalation 옵션 (HOST-REDUCE 근거) |
| **IM × HBR⊕** | ~11명 | **clopi 75mg** | 3-6 mo | HBR 우위 → 단축; PFT는 선택적 |
| **IM × HBR⊖** | ~34명 | **prasugrel 5mg** or ticagrelor (HIR⊕ 시 강력 권고) | 12 mo | TROPICAL/TOPIC de-escalation 1mo 후 옵션 |
| **NM × HBR⊕** | ~8명 | **clopi 75mg** | 3-6 mo | 단축 우선 |
| **NM × HBR⊖** | ~24명 | **clopi 75mg** (default) | 12 mo | 표준; HIR⊕ 시 prasugrel 고려 |
| RM/UM | ~1명 | clopi (출혈 모니터) | 12 mo | PRU < 85 시 감량 검토 (근거 약함) |

### Net 분포 (100명)

```
clopi-based : ~57명 (NM·RM/UM 33 + IM×HBR⊕ 11 + PM×HBR⊕ 8 + 기타 ~5)
prasugrel 5mg or ticagrelor : ~42명 (IM×HBR⊖ 34 + PM×HBR⊖ 8)
de-escalation eligible (1mo 후) : ~42명 (강력제 시작자 전원 후보)
PFT 권고 cell : ~7-8명 (PM×HBR⊕)
```

→ **한국 임상 핵심 통찰**: **clopi-first가 여전히 다수 (~57%)** — 서양 ticagrelor-first 가이드라인과 분기.
→ **"high-stakes cell" PM × HBR⊕ = 7-8/100**: 약제 선택 + 기간 + PFT + 모니터링 모두 customize 필요. M5 PFT 핵심 활용 cell.

---

## 8. 가이드라인 비교 — ESC 2023 · ACC/AHA 2025 · KSC 2024 · CPIC 2022

| 항목 | **ESC 2023 ACS** (Byrne) | **ACC/AHA 2025 ACS** (Rao) | **KSC 2024** | **CPIC 2022** (genotype) |
|---|---|---|---|---|
| Default ACS PCI | **ticagrelor (Class I)** > prasugrel > clopi | ticag = prasugrel > clopi | **clopi-first** if HBR⊕ or 동양인 baseline; ticag/prasug if HIR⊕ + HBR⊖ | **NM/RM**: clopi OK; **IM/PM**: prasug/ticag 권고 |
| Genotype routine? | 권고 안함 (선택적) | 선택적 (Class IIb) | 권고 (PCI 환자, 급여) | **권고** (Class A) |
| PFT routine? | 권고 안함 | 권고 안함 | 보조 (response 의심 시) | 보조 |
| HBR DAPT 단축 | 3-6 mo 옵션 | 1-3 mo 옵션 (HBR + 출혈) | **3-6 mo** (HOST-EXAM 기반) | — |
| De-escalation | guided (PFT/genotype) IIb | uniform 1mo IIa | guided IIa (HOST-REDUCE) | guided (LoF 확인 후) |
| 동양인 dose | 언급 없음 | 언급 없음 | **prasugrel 5mg** 명시 | — |
| chronic phase | aspirin 단독 | aspirin 단독 (선택적 clopi) | **clopi 단독** (HOST-EXAM, Class IIa) | — |

### 핵심 분기점

```
                    ESC/ACC                    KSC + CPIC
                    ───────────                ─────────────────
default PCI :       ticag-first                clopi-first (genotype-aware)
genotype :          optional                   recommended (한국 급여)
동양인 dose :        no guidance                prasugrel 5mg
chronic monotherapy: aspirin                   clopidogrel (HOST-EXAM)
```

→ **수렴 방향**: 2024-2025 update에서 ESC/ACC 모두 genotype/PFT 보조 + de-escalation 인정 트렌드. 한국이 evidence-leading (HOST-EXAM · HOST-REDUCE · TICAKOREA · KAMIR-NIH).

---

## 9. 참고문헌

### 핵심 RCT
- Wiviott SD et al. (2007) *NEJM* 357:2001 — **TRITON-TIMI 38** (prasugrel) · PMID 17982182
- Wallentin L et al. (2009) *NEJM* 361:1045 — **PLATO** (ticagrelor) · PMID 19717846
- Roe MT et al. (2012) *NEJM* 367:1297 — **TRILOGY-ACS** · PMID 22920930
- Montalescot G et al. (2013) *NEJM* 369:999 — **ACCOAST** · PMID 23991622
- Bonaca MP et al. (2015) *NEJM* 372:1791 — **PEGASUS-TIMI 54** · PMID 25773268
- Goto S et al. (2015) *Circ J* 79:2452 — **PHILO** · PMID 26396014
- Park KW et al. (2020) *Circulation* 142:1641 — **TICAKOREA** · PMID 32777931
- Mehran R et al. (2019) *NEJM* 381:2032 — **TWILIGHT** · PMID 31556978

### De-escalation
- Sibbing D et al. (2017) *Lancet* 390:1747 — **TROPICAL-ACS** · PMID 28855078
- Cuisset T et al. (2017) *Eur Heart J* 38:3070 — **TOPIC** · PMID 28510646
- Kim HS et al. (2021) *Lancet* 398:1305 — **HOST-REDUCE-POLYTECH-ACS** · PMID 34627490
- Kim HS et al. (2020) *Lancet* 397:2487 — **HOST-EXAM** · PMID 34010616
- Gimbel ME et al. (2020) *Lancet* 395:1374 — **POPular AGE** · PMID 32334703
- Kuno T et al. (2021) *Eur Heart J* 42:4633 — de-escalation meta · PMID 34389858

### 한국·일본 prasugrel
- Saito S et al. (2014) *Circ J* 78:1684 — **PRASFIT-ACS** · PMID 24759795
- Lee CH et al. (2019) *JACC Cardiovasc Interv* — KAMIR-NIH 5mg

### Switch consensus
- Angiolillo DJ et al. (2017) *Eur Heart J* 38:3070 — switching P2Y12 consensus
- Mega JL et al. (2009) *Circulation* 119:2553 — prasugrel + CYP2C19 LoF analysis · PMID 19729611

### Guidelines
- Byrne RA et al. (2023) *Eur Heart J* 44:3720 — **ESC 2023 ACS**
- Rao SV et al. (2025) *J Am Coll Cardiol* — **ACC/AHA 2025 ACS**
- 대한심장학회 (2024) **KSC ACS 2024**
- Lee CR et al. (2022) *Clin Pharmacol Ther* 112:959 — **CPIC 2022**

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 3제 약리 비교 (prodrug · CYP · 가역성) | 🟡 SUPPORTED-BY-CITATION | FDA labels + Angiolillo 2017 consensus |
| TRITON / PLATO 결과 수치 | 🟡 SUPPORTED-BY-CITATION | 1차 RCT (high-quality) |
| 한국인 prasugrel 5mg 권고 | 🟡 SUPPORTED-BY-CITATION | PRASFIT-ACS · KAMIR-NIH · 일본 PMDA 승인 |
| TICAKOREA 출혈 ↑ 시그널 | 🟡 SUPPORTED-BY-CITATION | Park 2020 Circulation (RCT) |
| De-escalation (TROPICAL/TOPIC/HOST-REDUCE) 비열등 | 🟡 SUPPORTED-BY-CITATION | RCT + meta (Kuno 2021) |
| Switch 프로토콜 (LD · gap) | 🟡 SUPPORTED-BY-CITATION | Angiolillo 2017 consensus |
| Rebound window ASCII timeline | 🟠 INSUFFICIENT/DEFERRED | 정성적 — head-to-head IPA 측정 RCT 부족 |
| 4-quadrant 한국인 인원 추정 | 🟠 INSUFFICIENT/DEFERRED | M1 빈도 × M4 HBR 25% 단순 곱; 실측 cohort 검증 필요 |
| KSC clopi-first vs ESC ticag-first 분기 | 🟡 SUPPORTED-BY-CITATION | KSC 2024 + HOST-EXAM RCT |

---

## 🔑 핵심 통찰 (5 bullets)

- **3제의 CYP2C19 의존성 비대칭**: clopidogrel만 직렬 2-step 율속 (M2) — 한국인 IM+PM 60%에서 escalation 또는 PFT 필수. prasugrel은 CYP2C19 우회 (LoF 영향 −5~10%), ticagrelor는 prodrug 의존 자체 제거.
- **한국 vs 서양 가이드라인 분기점**: ESC/ACC는 **ticag-first**, KSC 2024는 **clopi-first + genotype-aware**. 근거 = TICAKOREA (한국인 ticag 출혈 2.3×) + HOST-EXAM (chronic clopi 단독 우위) + HOST-REDUCE (prasugrel 1mo 후 5mg de-escalation 우위) — 한국이 evidence-leading.
- **"High-stakes cell" = PM × HBR⊕ ~7-8/100명**: M1+M4 4-quadrant의 critical cell. 약제(clopi 유지 + ticag 60mg 감량 옵션) · 기간(3-6 mo) · PFT(M5) · 모니터링 모두 customize 필요 — 결정맵 가치 생산이 가장 큰 cell.
- **De-escalation이 escalation보다 evidence-strong**: TROPICAL-ACS · TOPIC · HOST-REDUCE 모두 비열등 + 출혈 ↓ (HR 0.5-0.8). 1mo 후 강력제→clopi 또는 prasugrel 10→5mg switch는 한국인에서 net benefit 명확. 반면 routine PFT-guided escalation은 GRAVITAS/ARCTIC/ANTARCTIC 모두 음성.
- **Switch 프로토콜의 timing window 위험**: ticag→clopi acute switch 시 6-24h "vulnerable window" (양쪽 IPA <50%) — acute coronary 재발 위험. LD 600mg + 12h overlap + 가급적 stable phase (>30d) 시행이 안전. Stable한 prasugrel→clopi는 offset 느려 overlap 위험 작음.
