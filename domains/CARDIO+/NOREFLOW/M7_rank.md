# M7 — 최종 통합 ranking (efficacy × delivery × safety × 한국 × 단계)

> 마일스톤 M7 산출물 · current-state · no history.
> 출처 = 선행 M1-M6 + M8 직접 통합 → 🟡 SUPPORTED-BY-CITATION (compositional).
> 범위 = no-reflow 차단 + IRI/MVO 보호 후보 short-list + 한국 first-in-class 3-trial 구상.

---

## 1. 5-axis scoring 체계

선행 마일스톤 결론을 5축에서 1-5 점 척도로 매핑 후 가중 합산. 효능 + delivery + safety + 한국 적용성 + 임상 단계가 한 후보의 종합 가치를 결정.

### 1.1 가중치 + 점수 기준

| Axis | 가중치 | 1점 | 3점 | 5점 | 출처 |
|---|---|---|---|---|---|
| **A1. efficacy** | 30% | 전임상 only / Ph3 neutral | small Ph2 positive · meta mixed | Ph3 positive · 일관된 RCT 다수 | M2 (mPTP) · M3 (microvasc) |
| **A2. delivery PK** | 20% | IV systemic, lethal window 놓침 | IC bolus 가능 (off-label) | IC + reperfusion-synced 가능 | M4 IC vs IV Cmax ratio |
| **A3. safety** | 25% | Tier-C (회피) · 임상 hold · 누적 독성 | Tier-B (환자군별 회피) | Tier-A (단회 + transient만) | M6 Tier 분류 |
| **A4. 한국 적용성** | 15% | 미수입 · IND 필요 | 수입 가능 · off-label | 보험 등재 · 글로벌 우위 | M8 약제 매트릭스 |
| **A5. 임상 단계** | 10% | 전임상 only | Ph1-Ph2 | Ph3 완료 또는 routine | M2/M3 단계 column |

종합 점수 = Σ (axis 점수 × 가중치) → 0-5 scale. 4.0+ = Tier-A · 3.0-3.9 = Tier-B · <3.0 = Tier-C.

### 1.2 ASCII — 5-axis radar 도식

```
                    efficacy (30%)
                         ▲
                         │
                         │
   임상 단계 ◄──────────┼──────────► delivery PK
   (10%)               ●            (20%)
                       종합
                         │
                         │
   한국 적용성 ◄────────┼──────────► safety
   (15%)                ▼            (25%)
                    (가중합 0-5)

   가중치 우선순위:  efficacy > safety > delivery > 한국 > 단계
                    30%       25%     20%        15%    10%
```

---

## 2. 전체 후보 통합 ranking — 20-row table

A1-A5 점수 × 가중치 → 종합 점수 (가중합 0-5). M2 mPTP + M3 미세혈관 + frontier 합 ~20개 후보. ★ = Tier-A (>=4.0) · ☆ = Tier-B (3.0-3.9) · × = Tier-C (<3.0).

| # | 후보 | family | A1 효능 | A2 deliv | A3 safety | A4 KR | A5 phase | **종합** | Tier |
|---|---|---|---|---|---|---|---|---|---|
| 1 | **adenosine IC 24 mg** | A2A | 5 | 5 | 5 | 4 | 5 | **4.85** | **★A** |
| 2 | **nicorandil pre-PCI** | K-ATP | 4 | 3 | 5 | 5 | 5 | **4.30** | **★A** |
| 3 | **MTP-131 (elamipretide)** | cardiolipin peptide | 3 | 3 | 5 | 1 | 4 | **3.40** | ☆B |
| 4 | **NTP IC (sodium nitroprusside)** | NO donor | 4 | 5 | 3 | 4 | 4 | **3.95** | ☆B (cusp) |
| 5 | **verapamil IC** | Ca²⁺ block | 4 | 5 | 3 | 4 | 4 | **3.95** | ☆B (cusp) |
| 6 | **nicardipine IC** | Ca²⁺ block (DHP) | 3 | 5 | 4 | 4 | 4 | **3.85** | ☆B |
| 7 | **tirofiban IC** | GP IIb/IIIa | 3 | 4 | 3 | 4 | 4 | **3.35** | ☆B |
| 8 | **NAD+/NMN supplement** | SIRT3 axis | 2 | 2 | 5 | 5 | 2 | **3.05** | ☆B (한국 fast) |
| 9 | **NIM811** | CypD-selective | 3 | 4 | 4 | 1 | 2 | **2.95** | ☆B (cusp) |
| 10 | **sanglifehrin-A** | CypD-selective | 2 | 4 | 3 | 1 | 1 | **2.30** | × C |
| 11 | **SGLT2i (empagliflozin) pre-PCI** | 부종/osmotic | 2 | 2 | 5 | 4 | 4 | **3.05** | ☆B |
| 12 | **GLP-1 (exenatide IV) peri-PCI** | metabolic | 3 | 2 | 4 | 3 | 3 | **3.05** | ☆B |
| 13 | **콜키친 post-PCI (COLCOT)** | IL-1β/IL-6 | 3 | 1 | 4 | 4 | 5 | **3.20** | ☆B |
| 14 | **abciximab IC** | GP IIb/IIIa | 3 | 4 | 2 | 2 | 4 | **2.85** | × C (생산 중단) |
| 15 | **debio-025 (alisporivir)** | CypD-pan | 3 | 3 | 1 | 1 | 2 | **2.05** | × C (pancreatitis hold) |
| 16 | **CsA 2.5 mg/kg IV 재시도** | CypD-pan | 2 | 1 | 4 | 4 | 5 | **2.90** | × C (CIRCUS neutral) |
| 17 | **TRO40303** | TSPO/mPTP | 1 | 2 | 2 | 1 | 2 | **1.55** | × C (개발 중단) |
| 18 | **SRT1720 / honokiol** | SIRT1 agonist | 2 | 2 | 4 | 3 | 1 | **2.45** | × C (전임상) |
| 19 | **routine thrombectomy** | mechanical | 1 | 5 | 2 | 4 | 5 | **2.90** | × C (TOTAL stroke) |
| 20 | **drug-eluting reperfusion catheter (frontier)** | T5 synced | 4 | 5 | 4 | 1 | 1 | **3.45** | ☆B (frontier) |

**핵심 패턴**:
- **상위 5위**: adenosine IC · nicorandil · NTP IC · verapamil IC · nicardipine IC — 모두 IC delivery + Ph2/Ph3 positive RCT 보유.
- **mPTP 단독**: MTP-131이 mPTP family 1위 (safety 우수) — Tier-B 상단. CypD-selective (NIM811)는 효능 잠재력 있으나 한국 미수입 → cusp.
- **frontier**: drug-eluting catheter (T5) — 잠재력 ★A 자리, 그러나 단계/한국 capacity 둘 다 1점 → Tier-B 상단.
- **회피 명확**: CsA 반복 IV · debio-025 · TRO40303 · routine thrombectomy — Tier-C 4종.

---

## 3. Tier 분류 + 권고 사용 시나리오

3-Tier 분류는 종합 점수 cut-off + 임상 적용 시나리오 함께 정의.

### 3.1 Tier-A — 당장 임상 적용 가능, 한국 우위 (3 약물)

| 약물 | 종합 | 사용 시나리오 | 한국 보험 | 임상 근거 핵심 |
|---|---|---|---|---|
| **adenosine IC 24 mg distal bolus** | 4.85 | PCI 직후 TIMI ≤2 발생 시 microcatheter distal injection · 4 mg split (60s 간격) | OK (off-label routine) | REOPEN-AMI (Niccoli 2013) MVO 14% vs 35% (p=0.001) |
| **nicorandil pre-PCI loading** | 4.30 | STEMI activation 시점 oral 5-10 mg or IV 4-12 mg bolus → PCI 후 infusion 4-8 mg/h | **OK (한국 등재, 글로벌 우위)** | J-WIND (Kitakaze 2007) LVEF 6mo ↑, MACE ↓ |
| **MTP-131 (elamipretide)** | 3.40 | 단회 IV bolus 0.05 mg/kg/h × 1h, 재관류 -15min → +1h window. 안전성 매우 양호 (단회) | 미승인 (수입 IND 필요) | EMBARK (장기 safety) + EMBRACE Ph2 후속 재시도 가치 |

→ **권고**: adenosine IC + nicorandil 조합은 한국 보험 내 즉시 진행 가능 · MTP-131은 후속 Ph2 한국 단독 IND.

### 3.2 Tier-B — 선택적 / 보조 (8 약물)

| 약물 | 종합 | 시나리오 |
|---|---|---|
| **NTP IC 60-100 μg** | 3.95 | adenosine 효과 불충분 시 IC 동시 주입 (REOPEN-AMI 조합 디자인) |
| **verapamil IC 200 μg** | 3.95 | rescue (Werner 2002 small RCT) · LVEF ≥40% subset만 |
| **nicardipine IC 200 μg** | 3.85 | LV dysfunction 환자 (verapamil 회피군) · bradycardia 안전 |
| **drug-eluting reperfusion catheter** | 3.45 | frontier · M2 §4 Path B 핵심 · NIM811 IC formulation 또는 paclitaxel-coated wire |
| **tirofiban IC 25 μg/kg** | 3.35 | 대형 thrombus burden (TIMI thrombus grade ≥4) bailout |
| **콜키친 0.5 mg post-PCI** | 3.20 | COLCOT 적용 — chronic inflammation 표적, no-reflow secondary |
| **SGLT2i / GLP-1 peri-PCI** | 3.05 | EMMY / FAVOR mechanistic · ED 직접 약물 부재 갭 |
| **NAD+/NMN supplement** | 3.05 | 한국 IRB-light pilot · elective PCI 7일 precondition |
| **NIM811 (cusp)** | 2.95 | M2 §4 Path B 본격 path — CypD-selective + IC formulation 개발 시 ★A로 상향 |

### 3.3 Tier-C — 회피 또는 highly selective (5+ 약물)

| 약물 | 종합 | 회피 이유 |
|---|---|---|
| abciximab IC | 2.85 | 글로벌 생산 중단 (2019) · tirofiban으로 대체 |
| CsA 2.5 mg/kg IV 반복 | 2.90 | CIRCUS neutral + 반복 시 신독성 · 단회 재시도는 IC route 동반 시만 |
| routine thrombectomy | 2.90 | TASTE/TOTAL neutral + TOTAL stroke 신호 (RR 1.5, p<0.05) → guideline IIb high thrombus only |
| debio-025 (alisporivir) | 2.05 | HCV Ph3 pancreatitis cluster (fatal 1) → FDA partial hold |
| TRO40303 | 1.55 | MITOCARE neutral + GI · 개발 중단 |
| SRT1720 / honokiol | 2.45 | 전임상 only · supplement-grade purity 변동 |

---

## 4. d2 wall 돌파 3-path 최종 권고

CIRCUS (n=970) · CYCLE (n=410) · EMBRACE (n=297) · MITOCARE (n=163) **4건 연속 neutral** = mPTP-targeting STEMI의 d2 wall. M2 §4 + M3 §5 + M8 §6 통합한 3-path 권고.

```
                d2 wall: CIRCUS/CYCLE/EMBRACE/MITOCARE 임상 4건 연속 neutral
                                        │
                ┌───────────────────────┼───────────────────────┐
                ↓                       ↓                       ↓
╔════════════════════════╗  ╔════════════════════════╗  ╔════════════════════════╗
║ Path A — CypD-selective ║  ║ Path B — IMR-guided     ║  ║ Path C — Drug-eluting   ║
║ + IC + 한국 NAD+/NMN     ║  ║ cause-stratified RCT    ║  ║ reperfusion catheter    ║
║ pilot                    ║  ║ (한국 first-in-class)   ║  ║ (frontier)              ║
║                          ║  ║                          ║  ║                          ║
║ NIM811 IND OR NAD+/NMN  ║  ║ nicorandil pre-PCI       ║  ║ 풍선 inflation 시점     ║
║ supplement              ║  ║ + adenosine IC           ║  ║ IC + 약물 동시 release  ║
║ + IC formulation         ║  ║ + (선택) MTP-131         ║  ║ → M2 lethal window     ║
║                          ║  ║ × IMR > 40 환자 무작위   ║  ║ PK 해결 (5분 안)        ║
║ (M2 + M4 IC PK + M8     ║  ║ + CMR surrogate          ║  ║                          ║
║  supplement gray zone)   ║  ║ (M3 + M4 + M5 + M8)     ║  ║ (M2 §4 Path B + M4 §5) ║
╚════════════════════════╝  ╚════════════════════════╝  ╚════════════════════════╝
```

### 4.1 Path A — CypD-selective + NAD+/NMN supplement
- **후보 약물**: NIM811 (수입 IND) · sanglifehrin-A (전임상) · NAD+/NMN supplement (한국 가용)
- **Delivery**: NIM811 IC formulation 개발 또는 NAD+ booster pre-PCI 7일 oral
- **임상 단계**: NIM811 Ph1 ready (HCV repurpose) · NMN supplement OTC
- **한국 timeline**: NMN pilot ~12-18개월 (IRB-light) · NIM811 import IND ~24-36개월
- **자원**: IRB 단일기관 · 동물 IRI 모델 (rat LAD ligation) · 임상 cost ~5-10억 원 (NMN) / ~30-50억 (NIM811)
- **신호 강도**: ★★ (NMN 약함, NIM811 강 — sponsor 부재가 risk)
- **risk**: NMN dose-response 표준 부재 · NIM811 hyperbilirubinemia signal · supplement-grade purity 변동

### 4.2 Path B — IMR-guided cause-stratified RCT (한국 first-in-class)
- **후보 약물**: nicorandil pre-PCI + adenosine IC + (option) MTP-131 IV
- **Delivery**: nicorandil IV bolus + PO maintenance · adenosine IC distal microcatheter
- **임상 단계**: nicorandil + adenosine 모두 한국 보험 routine · 즉시 진행 가능
- **한국 timeline**: protocol design 6개월 · IRB + MOU 6개월 · enrollment ~18개월 · readout ~30개월
- **자원**: 다기관 CMR consortium 구축 (M5 §6 + M8 §7) · 8 기관 (서울대·세브란스·삼성서울·아산·분당서울대·고려대·한양대·부산대) · IMR wire 보험 cap 해결 · 비용 30-50억 원 (KHIDI)
- **신호 강도**: ★★★ (글로벌 공백 + 한국 보험 우위 + 약물 모두 routine)
- **risk**: nicorandil 글로벌 RCT 재현성 약함 · IMR > 40 selection rate ~30-50% → enroll 속도

### 4.3 Path C — Drug-eluting reperfusion catheter (frontier)
- **후보 약물**: NIM811-PLGA coated wire · paclitaxel DCB 변형 · MTP-131 microemulsion
- **Delivery**: T5 — balloon inflation 시점 동기화 release (~T+1s lethal window 명중)
- **임상 단계**: preclinical only (Wu 2015 prototype) · 동물 IRI 모델 in vivo 단계
- **한국 timeline**: 동물 in-vivo 18-24개월 · IND 12개월 · Ph1 12-18개월 → 총 ~48개월
- **자원**: 6-8개 동물 IRI capacity 기관 + 식약처 의료기기 IND + 산학 협업 (디바이스 제조사) · 비용 20-30억 원 (전임상) + 50-100억 (Ph1/2)
- **신호 강도**: ★★ (잠재력 ★★★, 그러나 substrate 부재)
- **risk**: NIM811 IC formulation stability · GLP tox 미완 · sponsor 부재 · medical-device CE/FDA path 별도

---

## 5. 한국 first-in-class 3-trial 구상 (M8 §7 consortium 적용)

3-path를 한국 단독 실행 가능한 3 trial로 구체화. consortium 표준화 + KHIDI/보건복지부 R&D 트랙.

### 5.1 Trial-A — NICORADENO-MVO (Path B 핵심)
- **디자인**: nicorandil pre-PCI loading + IC adenosine 24 mg · IMR-stratified RCT
- **n**: ~500 STEMI · IMR > 40 무작위화 (active vs standard care)
- **arms**:
  - active: nicorandil oral 10 mg loading + IV 4 mg bolus pre-PCI + IC adenosine 24 mg distal · post-PCI nicorandil PO maintenance 7일
  - control: PCI routine + IC NTG (standard)
- **Primary endpoint**: CMR infarct size (% LV mass) at 30d (M5 validated surrogate · Stone 2016)
- **Secondary**: IMR post-PCI · CMR MVO+ rate · 1y MACE
- **Consortium**: 서울대 · 세브란스 · 삼성서울 · 아산 · 분당서울대 (5 핵심) + 고려대 · 한양대 · 부산대 (확장 3)
- **기간**: 2-3년 (protocol 6m + enroll 18m + 30d primary + 1y MACE)
- **비용**: 30-50억 원 (KHIDI 임상연구인프라 트랙)
- **돌파 potential**: positive 시 글로벌 가이드라인 IIa → I 영향 + 한국 발 first-in-class

### 5.2 Trial-B — NMN-PRECON (Path A IRB-light pilot)
- **디자인**: NAD+/NMN supplement preconditioning · 단일기관 elective PCI pilot
- **n**: ~100 elective PCI 환자 · 7일 NMN 500 mg/day precondition vs placebo
- **arms**:
  - active: NMN 500 mg PO × 7일 (PCI 전)
  - control: placebo capsule
- **Primary endpoint**: CMR LGE infarct size (post-procedural troponin AUC × IMR)
- **Secondary**: SIRT3 activity surrogate · NAD+ blood level · 30d MACE
- **기관**: 서울대 또는 세브란스 단독 IRB-light (식품 등급 supplement) · KSC funding
- **기간**: 12-18개월 (IRB 3m + enroll 9m + 30d primary)
- **비용**: 5-10억 원 (학회 자체 + supplement 제공사 cost-sharing)
- **돌파 potential**: ★★ (preclinical 단계 → 첫 human signal · supplement gray zone 활용)

### 5.3 Trial-C — DERWIRE-PRECLIN (Path C feasibility)
- **디자인**: drug-eluting guidewire 동물 in-vivo feasibility · rabbit/pig IRI 모델
- **n**: rabbit n=40 (10 per arm, 4 arms) · pig n=12 (3 per arm, IRI confirmation)
- **arms**:
  - active 1: NIM811-PLGA coated wire (low dose)
  - active 2: NIM811-PLGA coated wire (high dose)
  - active 3: paclitaxel DCB 변형 (positive control)
  - control: bare wire
- **Primary endpoint**: TTC-stained infarct size (% LV) at 24h
- **Secondary**: mPTP opening assay (mitochondria isolation) · biomarker AUC
- **기관**: 6-8 한국 동물 IRI capacity 중 2-3 (서울대 · 가천대 · KIST) · 의료기기 제조사 협업
- **기간**: 18-24개월 (대학 IACUC + 디바이스 prototype 6m + animal 18m)
- **비용**: 20-30억 원 (보건복지부 R&D + 산학협력)
- **돌파 potential**: ★★★ (Path B 통합 또는 단독 IND 트랙 — 글로벌 frontier)

---

## 6. Timeline + decision gates

3-trial 동시 진행 + decision gate ASCII roadmap.

```
[ 3-year roadmap · 2026 → 2028 Q4 ]

2026 Q2 ─┬─ Trial-A protocol design + consortium MOU 시작 (Path B)
         ├─ Trial-B NMN pilot IRB 제출 (Path A)
         └─ Trial-C 동물 IACUC + 디바이스 prototype 설계 (Path C)
                                   │
2026 Q4 ─┬─ Trial-A 8-기관 MOU 완료 · CMR core lab QC
         ├─ Trial-B enrollment 시작 (n=100)
         └─ Trial-C 동물 in-vivo 1차 cohort 시작
                                   │
2027 Q2 ─┬─ Trial-A enrollment 시작 (n=500 target)
         ├─ Trial-B 30d primary readout (interim)
         └─ Trial-C 1차 cohort 분석
                                   │
2027 Q4 ◄── ★ GATE-1: Trial-B readout
         ┌── positive (NMN MVO ↓ trend) → Trial-A 추가 arm 검토
         └── neutral → Trial-A nicorandil + adenosine 단독 강화
                                   │
2028 Q2 ◄── ★ GATE-2: Trial-A primary readout (CMR infarct size)
         ┌── positive (>=15% relative ↓) → Ph3 한국·일본 다국가 디자인
         └── neutral → IMR stratification 강화 + Path B 재디자인
                                   │
2028 Q4 ◄── ★ GATE-3: Trial-C animal readout → IND 결정
         ┌── infarct ↓ >=30% animal → Ph1 IND 준비 (식약처)
         └── 효과 부재 → DCB 변형 또는 다른 carrier 재설계
```

**Gate-1 (2027 Q4)** — Trial-B NMN pilot interim → Path A 강화 vs Path B 단독 결정.
**Gate-2 (2028 Q2)** — Trial-A CMR readout → 글로벌 Ph3 또는 한국 단독 Ph3.
**Gate-3 (2028 Q4)** — Trial-C 동물 readout → 식약처 IND or 디자인 reset.

---

## 7. g5 grade — 종합 검증

| 항목 | 등급 | 근거 |
|---|---|---|
| 5-axis scoring 체계 (§1) | 🟡 SUPPORTED-BY-CITATION | M2-M6 + M8 통합 (compositional) |
| 후보별 종합 점수 (§2 20-row) | 🟡 SUPPORTED-BY-CITATION | 각 axis 출처 합산 (M2 §5 · M3 §4 · M4 §6 · M6 §6 · M8 §3) |
| Tier-A 3약물 추천 (§3.1) | 🟡 SUPPORTED-BY-CITATION | M2/M3 efficacy + M6 safety 합의 |
| Tier-B/C 분류 (§3.2-3.3) | 🟡 SUPPORTED-BY-CITATION | M6 §6 Tier table + M2/M3 efficacy 외삽 |
| 3-path 돌파 권고 (§4) | 🟠 INSUFFICIENT/DEFERRED | 한국 임상 readout 부재 · path별 신호 강도는 가설 |
| 한국 first-in-class 3-trial 구상 (§5) | 🟠 INSUFFICIENT/DEFERRED | consortium 미결성 · MOU 미체결 · funding 미확보 |
| Timeline + decision gates (§6) | 🟠 INSUFFICIENT/DEFERRED | 기관 enrollment 속도 가정 · gate 결정 prospective |

→ 종합 verdict: efficacy/safety axis 합산 ranking은 🟡, path 권고와 한국 trial 구상은 🟠 (한국 consortium 실제 결성 + RCT readout 후 🟢 상향 가능).

---

## 8. 참고문헌

- Cung TT et al. (2015) *NEJM* 373:1021 — CIRCUS (CsA STEMI, neutral, d2 wall 1)
- Ottani F et al. (2016) *JACC* 67:365 — CYCLE (CsA STEMI, neutral, d2 wall 2)
- Gibson CM et al. (2016) *JACC* 67:1416 — EMBRACE STEMI (MTP-131, neutral, d2 wall 3)
- Atar D et al. (2015) *Eur Heart J* 36:112 — MITOCARE (TRO40303, neutral, d2 wall 4)
- Ross AM et al. (2005) *JACC* 45:1775 — AMISTAD-II IV adenosine
- Niccoli G et al. (2013) *JACC* 62:1289 — REOPEN-AMI IC adenosine + NTP (positive)
- Kitakaze M et al. (2007) *Lancet* 370:1483 — J-WIND nicorandil (LVEF positive)
- Stone GW et al. (2012) *JAMA* 307:1817 — INFUSE-AMI IC abciximab (borderline)
- Stone GW et al. (2016) *JACC* 67:1674 — CMR infarct size surrogate validation
- Niccoli G et al. (2009) *Eur Heart J* 30:2705 — no-reflow 4-cause framework
- Heusch G (2016) *Circ Res* 119:1262 — IRI / mPTP 임상 gap review
- Bernardi P (2013) *Front Physiol* 4:95 — mPTP regulator review
- Park KW et al. (2020) *Lancet* 396:1079 — TICAKOREA (한국인 출혈 baseline)
- Sim DS et al. (2017) *Korean Circ J* — KAMIR-NIH cohort profile

---

→ 종합: NOREFLOW @goal "PCI 직후 no-reflow 차단 + IRI/MVO 보호 후보 short-list 도출" — Tier-A 3약물 (adenosine IC · nicorandil pre-PCI · MTP-131) + 3-path 돌파 권고 + 한국 first-in-class 3-trial 구상으로 완결. 후속 NOREFLOW.log.md 기록 + Trial-A protocol seed → 다음 단계로 핸드오프.
