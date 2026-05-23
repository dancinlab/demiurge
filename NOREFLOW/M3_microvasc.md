# M3 — 미세혈관 보호 약물 short-list (VS · DE · ED)

> 마일스톤 M3 산출물 · current-state · no history.
> 출처 = literature (RCT + meta) → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).
> 표적 범위 = M1 §4의 **DE · VS · ED** 3-cause (IR/mPTP은 M2 영역).

---

## 1. 미세혈관 보호 5-family overview

```
[ no-reflow 3-cause (M1 §4) ]      [ pharmacological coverage ]
       DE  ──┐                          A. Adenosine A2A  (VS · IR 일부)
       VS  ──┼──► 미세혈관 폐색 ◄──── B. K-ATP opener      (VS · IR 일부)
       ED  ──┘                          C. NO donor          (VS)
                                        D. Ca²⁺ blocker      (VS)
                                        E. GP IIb/IIIa       (DE)
                                        (※ ED 직접 약물 거의 부재)
```

| Family | 대표약 | MoA | 주표적 cause | 임상 stage | KR 보험·접근 |
|---|---|---|---|---|---|
| **A. Adenosine receptor** | adenosine · regadenoson | A2A 활성 → 미세동맥 이완 + 호중구 억제 | VS (+IR 부분) | Ph3 (AMISTAD-II) · REOPEN-AMI Ph3 | adenosine 보험 가능 (off-label) |
| **B. K-ATP opener** | nicorandil · pinacidil | K-ATP 개방 + NO 공여 (nicorandil) | VS (+IR 부분) | Ph3 (J-WIND) · 일본 표준 | nicorandil 처방 가능 (일본·한국 우위) |
| **C. NO donor** | sodium nitroprusside · nitroglycerin IC | NO → cGMP → 평활근 이완 | VS | Ph2 meta 다수 · IC bolus 임상 표준 | 광범위 사용 (저가) |
| **D. Ca²⁺ blocker (IC)** | verapamil · nicardipine · diltiazem | L-type Ca²⁺ 차단 → 평활근 이완 | VS | Ph2 IC bolus 다수 · guideline IIa | 처방 가능 (저가) |
| **E. GP IIb/IIIa antagonist** | abciximab · tirofiban · eptifibatide | GP IIb/IIIa 차단 → 미세혈전 분해 | DE | Ph3 (INFUSE-AMI neutral primary) | abciximab 단종, tirofiban 가능 |

---

## 2. 약제별 deep-dive (top 6)

### 2.1 Adenosine — A2A 매개 미세동맥 이완

- **MoA**: A2A 수용체 → 미세동맥 평활근 이완 · 호중구 부착·ROS 억제 (VS + 부분 IR)
- **AMISTAD-II** (Ross AM 2005, *JACC* 45:1775, n=2118): IV adenosine 50 vs 70 μg/kg/min × 3h, primary endpoint (CHF/death) neutral. **High-dose 70 μg/kg/min subgroup**에서 infarct size ↓ (p=0.03).
- **REOPEN-AMI** (Niccoli G 2013, *JACC* 62:1289, n=240): IC adenosine 4 mg + nitroprusside vs saline. MVO (cMRI 5d) ↓ 14% vs 35% (p=0.001), ST-resolution ↑.
- **표준 IC dose**: adenosine 24 mg distal bolus (또는 4 mg split, 60s 간격)

### 2.2 Nicorandil — K-ATP opener + NO donor (이중 기전)

- **MoA**: 미토콘드리아 K-ATP 개방 (전조건화 흡사) + nitrate moiety로 NO 공여 → VS + IR 동시 표적
- **J-WIND** (Kitakaze M 2007, *Lancet* 370:1483, n=545 nicorandil arm): IV nicorandil 0.067 mg/kg bolus + 24h infusion, primary endpoint (infarct size SPECT) **neutral**. 그러나 LVEF 6 mo ↑ (p=0.011), MACE ↓.
- **JCAD-Nicorandil registry** (n>1000): post-PCI MACE ↓.
- 일본/한국 SAS·CCS 광범위 처방 — pre-PCI loading + post-PCI 유지 sequential 사용 가능 (글로벌 대비 우위).
- **표준 dose**: IV bolus 4-12 mg + infusion 4-8 mg/h, oral 5-20 mg × 2-3/day.

### 2.3 Sodium nitroprusside — IC NO donor

- **MoA**: NO 직접 공여 → 미세동맥 이완 (VS 표적)
- **Hillegass meta-analysis** (Hillegass WB 2011, *Catheter Cardiovasc Interv* 78:1057, n>900): IC nitroprusside 50-200 μg bolus → TIMI flow grade ↑, MBG ↑.
- **Nasarwanji R et al. (2018)** meta (n>1100): no-reflow rate OR 0.40 (95% CI 0.27-0.59) 유의 감소. 단 hard endpoint (mortality/MACE) → 데이터 부족.
- **표준 IC dose**: 250 μg distal bolus (50-300 μg titration). 저혈압 부작용 모니터링 필수.

### 2.4 IC verapamil / nicardipine — Ca²⁺ blocker

- **MoA**: L-type Ca²⁺ 채널 차단 → 평활근 이완 (VS 표적)
- **Werner GS** (Werner GS 2002, *Circulation* 105:2418): IC verapamil 1-1.5 mg → TIMI flow grade 0/1 → 3 회복 88%.
- **VAPOR trial** (Vijayalakshmi K 2006, *Heart* 92:1278): IC verapamil prophylactic vs control SVG PCI → no-reflow 0% vs 33%.
- **Nicardipine IC** (Huang RI 2006, *Catheter Cardiovasc Interv* 68:671): 200-500 μg distal, verapamil보다 음성 변력 효과 낮음 → 좌심실 기능 저하 환자 선호.
- **표준 IC dose**: verapamil 100-200 μg, nicardipine 200-500 μg, diltiazem 0.5-2.5 mg.

### 2.5 IC abciximab — GP IIb/IIIa antagonist (DE 표적)

- **MoA**: 미세혈전 GP IIb/IIIa 차단 → 혈소판 응집 분해 (DE 표적)
- **INFUSE-AMI** (Stone GW 2012, *JAMA* 307:1817, n=452): IC abciximab + thrombectomy vs control, primary endpoint (30d infarct size cMRI) ↓ 15.1% vs 17.9% (p=0.03, **borderline positive**). 그러나 후속 5-year mortality neutral.
- **subset positive**: 대형 anterior MI · 큰 thrombus burden → infarct size ↓.
- abciximab 단종 → tirofiban / eptifibatide로 대체 (IC bolus 25 μg/kg).

### 2.6 Cangrelor — IV P2Y12 (secondary protection)

- **MoA**: IV reversible P2Y12 차단 → peri-PCI 혈소판 응집 즉시 억제 (DE 보조)
- **CHAMPION-PHOENIX** (Bhatt DL 2013, *NEJM* 368:1303, n=11,145): primary composite (death/MI/IDR/ST) ↓ 4.7% vs 5.9% (p=0.005). no-reflow는 secondary, MBG ↑.
- 직접 no-reflow trial 부재, 그러나 thrombus-driven DE에 즉효 → bridging 후보.

---

## 3. cause × drug 매트릭스 (M1 §4 확장)

| cause | 1st-line | 2nd-line | preclinical / 신규 후보 |
|---|---|---|---|
| **DE** (distal embolization) | abciximab / tirofiban IC | thrombus aspiration · cangrelor IV | plaque stabilizer (statin loading) · ASA 변형 |
| **VS** (vasospasm) | nitroprusside IC · verapamil IC | nicorandil · adenosine IC | endothelin antagonist (bosentan IC, Ph1) |
| **ED** (edema) | mannitol (실험 단계) | — (직접 약물 부재) | hyaluronidase · osmotic agent · SGLT2i (peri-PCI) |
| IR (참조) | — (M2 mPTP 영역) | — (M2) | — (M2) |

**관찰**: ED는 직접 약물 부재 → M4 device (controlled reperfusion · pressure manipulation)로 보완 필요.

---

## 4. 임상 결과 종합 (positive vs neutral 분포)

| trial | drug | cohort | endpoint | result |
|---|---|---|---|---|
| AMISTAD-II (2005) | IV adenosine | STEMI n=2118 | CHF/death 6mo | neutral (high-dose subgroup positive) |
| REOPEN-AMI (2013) | IC adenosine + nitroprusside | STEMI n=240 | MVO cMRI 5d | **positive** (14% vs 35%) |
| J-WIND nicorandil (2007) | IV nicorandil | AMI n=545 | infarct size SPECT | neutral (LVEF/MACE 2차 positive) |
| Hillegass meta (2011) | IC nitroprusside | n>900 | TIMI/MBG | **positive** (flow ↑) |
| Nasarwanji meta (2018) | IC nitroprusside | n>1100 | no-reflow rate | **positive** (OR 0.40) |
| Werner (2002) | IC verapamil | rescue n=32 | TIMI 회복 | **positive** (TIMI 3 88%) |
| VAPOR (2006) | IC verapamil | SVG PCI n=22 | no-reflow rate | **positive** (0% vs 33%) |
| INFUSE-AMI (2012) | IC abciximab | STEMI n=452 | 30d infarct cMRI | borderline (15.1% vs 17.9%) |
| TASTE (2013) | aspiration thrombectomy | STEMI n=7244 | 30d mortality | neutral |
| CHAMPION-PHOENIX (2013) | IV cangrelor | PCI n=11,145 | death/MI/IDR | **positive** (composite ↓) |

**패턴**: small-trial IC bolus 약물 → positive 다수. large-trial systemic 약물 → neutral 다수. d2 wall 트리거.

---

## 5. d2 wall — 큰 임상 음성 분석

### 5.1 음성 RCT 패턴 분해

```
[ small Ph2 (positive) ]   →   [ large Ph3 (neutral) ]
─────────────────────────       ───────────────────────
n=20-200 (선별 cohort)            n=500-2000 (전체)
intra-coronary bolus            IV systemic infusion
surrogate endpoint              hard endpoint (mortality)
선별 진단 (IMR / OCT)            unselected STEMI
```

### 5.2 3대 실패 원인

1. **single-cause 표적, multi-cause 발생**: 환자별 DE-dominant vs VS-dominant 혼재 → 단일 약물 평균 효과 희석.
2. **환자 heterogeneity 진단 부재**: 시술 전 cause 분포 미측정 → IMR/OCT 등 미세혈관 phenotyping 없이 일률 무작위화.
3. **timing window 미일치**: VS 약물은 PCI 직후 즉효, IR 약물은 재관류 0-10분, ED는 30분-수일 → 약물별 최적 시점 무시.

### 5.3 돌파 path 3-fork (d2)

```
   d2 wall = large RCT neutral
   ─────────────────────────────
   │
   ├─ Path A: IMR > 40 환자 선택적 무작위화
   │           cause-stratified RCT 디자인
   │           (M5 IMR-guided endpoint 연계)
   │
   ├─ Path B: multi-drug cocktail
   │           verapamil IC + nicorandil + adenosine
   │           cause 동시 표적 → heterogeneity 해결
   │
   └─ Path C: intra-procedural cause 진단 + individualized
              OCT thrombus burden (DE) · IMR (VS/ED)
              → 환자별 약물 선택 → 효과 누적
```

→ M5 endpoint definition은 Path C IMR-guided 노선 우선 채택.

---

## 6. 신규 후보 (preclinical → early phase)

| 후보 | family | stage | rationale |
|---|---|---|---|
| Bosentan IC | endothelin antagonist | preclinical (porcine) | VS endothelin 매개 → 직접 차단 |
| Sitagliptin (peri-PCI) | DPP-4 inhibitor | Ph2 meta | GLP-1 신호 → cardioprotective |
| Empagliflozin (peri-PCI) | SGLT2i | Ph2 (EMMY 2022) | 부종 ↓ + osmotic → ED 후보 |
| Exenatide IV | GLP-1 agonist | Ph2 (FAVOR 2017) | infarct size ↓ surrogate positive |
| Colchicine (LoDoCo / COLCOT / OASIS) | IL-1β · IL-6 ↓ | Ph3 positive | 만성 inflammation 표적, no-reflow는 secondary |

**SGLT2i (empagliflozin)** — ED 직접 약물 부재 갭의 가장 유망 후보. EMMY (Tromp J 2022, *Circulation*) post-MI peri-PCI window에서 NT-proBNP ↓, LVEF ↑.

---

## 7. 한국인 hooks (M8 입력)

| 출처 | 데이터 | 비고 |
|---|---|---|
| KAMIR-V | adenosine IC subgroup no-reflow rate | retrospective, multi-center |
| K-ACTION | nicorandil subgroup MACE | 한국형 RCT |
| 보험급여 | nicorandil 일·한국 우선 처방 가능 (글로벌 대비 +) | Ono Pharma SIGMART 한국 등재 |
| KAMIR-NIH | IMR sub-study 진행 중 | Path A 무작위화 cohort 후보 |

→ 한국 nicorandil 보험접근 우위 + KAMIR-V adenosine 데이터 → M8 한국인-우선 short-list 핵심 자산.

---

## 8. 참고문헌

- Ross AM et al. (2005) *JACC* 45:1775 — AMISTAD-II (IV adenosine)
- Niccoli G et al. (2013) *JACC* 62:1289 — REOPEN-AMI (IC adenosine + nitroprusside)
- Kitakaze M et al. (2007) *Lancet* 370:1483 — J-WIND (IV nicorandil)
- Stone GW et al. (2012) *JAMA* 307:1817 — INFUSE-AMI (IC abciximab)
- Werner GS et al. (2002) *Circulation* 105:2418 — IC verapamil rescue
- Hillegass WB et al. (2011) *Catheter Cardiovasc Interv* 78:1057 — IC nitroprusside meta
- Nasarwanji R et al. (2018) meta — IC nitroprusside no-reflow OR 0.40
- Niccoli G et al. (2009) *Eur Heart J* 30:2705 — 4-cause framework (M1 공통)
- Bhatt DL et al. (2013) *NEJM* 368:1303 — CHAMPION-PHOENIX (cangrelor)
- Tromp J et al. (2022) *Circulation* — EMMY (empagliflozin peri-PCI)
- Tardif JC et al. (2019) *NEJM* 381:2497 — COLCOT (colchicine post-MI)
- Vijayalakshmi K et al. (2006) *Heart* 92:1278 — VAPOR (IC verapamil SVG)

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 5-family · 약제별 MoA | 🟡 SUPPORTED-BY-CITATION | 약리학 standard + RCT 결과 |
| RCT positive / neutral 분포 | 🟡 SUPPORTED-BY-CITATION | published primary outcome |
| d2 wall 3-path 가설 | 🟠 INSUFFICIENT/DEFERRED | M5 endpoint RCT 검증 필요 |
| multi-drug cocktail 효능 | 🟠 INSUFFICIENT/DEFERRED | head-to-head RCT 부재 |
| 한국인 subgroup 우위 | 🟠 INSUFFICIENT/DEFERRED | M8 KAMIR-V 직접 데이터 필요 |

→ M5 (endpoint · IMR-guided) · M6 (multi-drug cocktail 설계) · M8 (한국인 short-list) 입력 준비 완료.
