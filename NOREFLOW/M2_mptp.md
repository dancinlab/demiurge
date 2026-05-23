# M2 — mPTP 차단 후보 inventory + d2 wall 돌파 3-path

> 마일스톤 M2 산출물 · current-state · no history.
> 출처 = literature + 임상시험 결과 → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).
> M1 d2 wall 정량 + 5-family 후보 + 3-path 돌파 도출.

---

## 1. mPTP 분자 구조 + 개방 조건

mitochondrial Permeability Transition Pore — 내막을 가로지르는 비선택적 고전도 채널. 개방 시 ΔΨ 붕괴 → ATP 합성 정지 → matrix swelling → 외막 파열 → cyt-c 방출 → apoptosis/necrosis. **재관류 첫 5-10분이 lethal window**.

### 1.1 구조 가설 — 두 학파

| 가설 | 핵심 단백 | 근거 | 현 위상 |
|---|---|---|---|
| **F0F1-ATPase c-ring** (Giorgio 2013) | ATP synthase c-subunit dimer | 정제 c-ring이 lipid bilayer에서 pore 형성 | 2013- 우세 |
| **ANT/VDAC** (Halestrap 전통) | adenine nucleotide translocator + VDAC | knockout 시 mPTP 감소 (ANT) · CypD KO 결정적 | 부분 modulator로 후퇴 |
| 공통 regulator | **CypD (PPIF, peptidyl-prolyl isomerase F)** | CypD KO 마우스 mPTP 개방 threshold 2-3× ↑ + IRI 50% ↓ | **합의** |

CypD = matrix 측 peptidyl-prolyl cis-trans isomerase. Ca²⁺ 결합 시 conformational change → pore 개방 sensitize. **거의 모든 차단제의 1차 표적**.

### 1.2 개방 트리거 (재관류 시 동시 발생)

- **Ca²⁺ matrix 폭주** (허혈 중 cytosol Ca²⁺ ↑ + Na⁺/Ca²⁺ exchanger 역방향)
- **ROS burst** (재관류 첫 수 분 · complex I/III 누출 + xanthine oxidase)
- **ΔΨ 회복** (paradox — 회복 자체가 Ca²⁺ uptake 가속)
- **pH 정상화** (허혈 중 산성 pH는 보호적 · 재관류로 pH 7.4 회복 시 mPTP 개방 허용)

### 1.3 ASCII — 닫힘 vs 개방

```
[정상 mPTP (닫힘)]                  [개방 mPTP (재관류 첫 5-10분)]
                                    Ca²⁺↑ + ROS↑ + ΔΨ회복 + pH↑
 ┌──── 외막 ────┐                     ┌──── 외막 (파열) ──┐
 │              │                     │  ↑ cyt-c · AIF   │
 │  ┌── 내막 ──┤                     │  ┌── 내막 ──┤
 │  │ ATPsyn  │ ← CypD 비활성       │  │ ATPsyn  │ ← CypD 활성
 │  │ ◤◣◤◣◤◣  │                     │  │ ◤  ◣◤  ◣│ ← pore 열림
 │  │ matrix  │ ΔΨ = -180 mV        │  │ matrix  │ ΔΨ ≈ 0
 │  │ ATP→    │ pH 7.8              │  │ swelling│ pH 7.4
 │  └─────────┘                     │  └─────────┘
 └──────────────┘                     └─────────────────┘
       ATP 합성 정상                       apoptosis / necrosis
```

---

## 2. mPTP 차단제 inventory — 5 family

| family | drug | MoA (1차 표적) | CypD 선택성 | calcineurin off-target | 임상 단계 | KR 접근 |
|---|---|---|---|---|---|---|
| **A. CypD-binding** | cyclosporin-A (CsA) | CypD + cyclophilin-A 동시 | 낮음 (paralog 광범위) | **YES** (면역억제) | STEMI Ph3 (CIRCUS · neutral) | 시판 (Sandimmun) |
| A | NIM811 | CypD selective | 중-높 | NO (calcineurin sparing) | HCV Ph2 종료 · IRI 전임상 | 미승인 |
| A | sanglifehrin-A (SfA) | CypD (novel scaffold) | 높음 | NO | 전임상 | 미승인 |
| A | debio-025 / alisporivir | CypD (HCV repurpose) | 중-높 | NO | HCV Ph3 · 췌장염 hold → IRI Ph1/2 재개 | 미승인 |
| **B. F0F1-ATPase** | DS16570511 | ATPase c-subunit (CypD 독립) | n/a | NO | 전임상 | 미승인 |
| B | bongkrekic acid | ANT (m-state lock) | n/a | NO | 독성 (tool only) | 시약 |
| **C. mitochondrial peptide** | MTP-131 / elamipretide / SS-31 | cardiolipin 결합 → IMM 안정화 · 간접 mPTP | 간접 | NO | STEMI Ph2 (EMBRACE · neutral) · MELAS · dry AMD Ph3 | 미승인 |
| C | SS-20 | cardiolipin (SS-31 analog) | 간접 | NO | 전임상 | 미승인 |
| **D. sirtuin axis** | SRT1720 | SIRT1 agonist → CypD deacetyl | 간접 | NO | 전임상 | 미승인 |
| D | NAD⁺ / NMN / NR | SIRT3 substrate ↑ → CypD K166 deacetyl | 간접 | NO | 노화·심부전 Ph2 (NR) | NMN 식품 (KR 가능) · NR supplement |
| D | honokiol | SIRT3 activator (magnolol analog) | 간접 | NO | 전임상 + supplement | supplement |
| **E. UCP2 modulator** | genipin | UCP2 inhibitor → 간접 ROS ↓ | 간접 | NO | 전임상 | natural product |
| E | TRO40303 | OMM cholesterol carrier (TSPO) · mPTP 간접 | 간접 | NO | STEMI Ph2 (MITOCARE · neutral) | 미승인 (개발 중단) |

**Family 합산: 14 candidate · 5 family**.

---

## 3. 임상 실패 분석 (M1 d2 wall 정량)

### 3.1 4건 neutral 임상 (mPTP-targeting STEMI)

| trial | drug | year | n | dosing | timing (재관류 대비) | primary endpoint | 결과 |
|---|---|---|---|---|---|---|---|
| **CIRCUS** (Cung NEJM 2015) | CsA 2.5 mg/kg IV bolus | 2015 | 970 | single bolus | PCI 직전 10분 | LV remodeling + 1y death/HF | **neutral** (OR 1.04, p=0.69) |
| **CYCLE** (Ottani JACC 2016) | CsA 2.5 mg/kg IV bolus | 2016 | 410 | single bolus | PCI 직전 | ST-resolution ≥70% 1h | **neutral** (OR 0.99, p=0.94) |
| **EMBRACE STEMI** (Gibson JACC 2016) | MTP-131 (elamipretide) 0.05 mg/kg/h IV | 2016 | 297 | 1h infusion | 재관류 -15분 → +1h | infarct size (CK-MB AUC) | **neutral** (p=0.78) |
| **MITOCARE** (Atar EHJ 2015) | TRO40303 6 mg/kg IV bolus | 2015 | 163 | single bolus | PCI 직전 | infarct size cMRI 30d | **neutral** + safety signal (sepsis ↑) |

### 3.2 실패 원인 3-axis 분해

```
    [전임상 50-60% infarct ↓]   →   [임상 0% (4건 연속)]
              │                              │
              └──── 3-axis gap ──────────────┘
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
   (a) 선택성    (b) 타이밍      (c) PK / 미토침투
```

| axis | gap | 정량 근거 |
|---|---|---|
| **(a) 선택성 부족** | CsA = CypD + calcineurin 동시 → 면역억제 off-target · cyclophilin-A도 동시 결합 → 항-ROS 효과 부분 상쇄 | CsA Ki(CypD) ≈ Ki(CypA), calcineurin inhibition IC50 ≈ 5 nM (clinical dose에서 immunosuppressive 농도) |
| **(b) 타이밍 부족** | 재관류 첫 **5분 lethal window** vs IV bolus arm-to-heart lag 30-120s + Cmax 도달 추가 1-3분 | mPTP 개방 peak = 재관류 1-3분, IV bolus 도달 시 이미 절반 사멸 |
| **(c) PK / 미토침투** | CsA = 친지질이나 미토 침투 % 낮음 (<5% in vivo) · MTP-131 cardiolipin binding은 빠르나 ischemic membrane 진입 PK 불명 · TRO40303 TSPO 의존 → 1차 표적 자체 불확실 | EMBRACE post-hoc: plasma Cmax 도달 = 재관류 +15분 (window 놓침) |

---

## 4. d2 wall 돌파 3-path

```
            d2 wall = 전임상 → 임상 4건 연속 neutral
                            │
        ┌───────────────────┼───────────────────┐
        ↓                   ↓                   ↓
   Path A           Path B              Path C
   CypD-selective    IC + reperfusion-       신규 표적축
   2nd-gen          synced delivery        (SIRT3 · UCP2 · SS-peptide 2nd-gen)
        │                   │                   │
   NIM811·SfA·         IC bolus · drug-       NAD⁺ / NMN booster
   debio-025           eluting catheter      MTP-131 successor
   alisporivir         (PCI guidewire)       UCP2 activator
        │                   │                   │
        └─→ axis (a) 해결    └─→ axis (b) 해결   └─→ axis (a)+(c) 우회
```

### Path A — CypD-selective (calcineurin sparing)
- **NIM811** · sanglifehrin-A · debio-025 (alisporivir)
- CsA의 calcineurin off-target 제거 → 더 높은 dose 가능 + 면역 부작용 없음
- **위험**: HCV trial 췌장염 signal (debio-025) — IRI 단회 dose에서 발생 여부 미확인

### Path B — IC + 재관류 동기 전달
- IC (intracoronary) bolus via PCI guidewire — 재관류 -30s 시점 직접 관상동맥 주입
- drug-eluting reperfusion catheter (실험적) — balloon 디플레이션 시점에 약물 방출
- **목적**: arm-to-heart lag 우회 → window 정확히 명중
- 전례: REOPEN-AMI (adenosine IC) · TAPAS-style aspirate-then-deliver

### Path C — 신규 표적축
- **SIRT3 axis**: SIRT3는 CypD K166 deacetylation → mPTP threshold ↑. NAD⁺ / NMN / NR로 SIRT3 substrate boost. 한국 supplement 가용 → fast track.
- **MTP-131 successor**: SS-20 등 차세대 peptide · PK 개선
- **UCP2 activator**: matrix proton leak ↑ → ΔΨ 약간 감소 → Ca²⁺ uptake driving force ↓ → mPTP 우회

---

## 5. 후보 ranking (M3 입력)

| 후보 | family | 선택성 | 임상 단계 | d2 path | KR 접근 | 우선순위 |
|---|---|---|---|---|---|---|
| **NIM811** | A | 높 | IRI 전임상 + Ph1 ready | A | 미승인 (research) | **★★★** |
| **debio-025 (alisporivir)** | A | 중-높 | HCV Ph3 종료 · IRI Ph1/2 재개 | A | 미승인 | **★★★** |
| **sanglifehrin-A** | A | 높 | 전임상 | A | 미승인 | ★★ |
| **MTP-131 (elamipretide)** | C | 간접 | Ph3 (dry AMD) · Ph2 (MELAS) | B (IC delivery) | 미승인 | **★★★** (재시도 가치) |
| **NAD⁺ / NMN booster** | D | 간접 | Ph2 (NR · 심부전) | C | **supplement 가용** | **★★★** (한국 immediate) |
| **SRT1720** | D | 간접 | 전임상 | C | 미승인 | ★ |
| **CsA (IC re-trial)** | A | 낮 | Ph3 (CIRCUS neutral) | B | 시판 | ★ (재시도 한정) |
| **TRO40303** | E | 간접 | 개발 중단 | — | 미승인 | × |
| **DS16570511** | B | n/a | 전임상 | A (대체축) | 미승인 | ★ |
| **honokiol** | D | 간접 | supplement | C | supplement | ★ |

→ M3 후속: **NIM811 + debio-025 + MTP-131 IC + NMN** 4축 deep dive.

---

## 6. 한국인 / 동아시아 hooks (M8 입력)

| 축 | 현황 | gap |
|---|---|---|
| KAMIR-NIH STEMI cohort | mPTP biomarker sub-study 가용 가능 | mPTP-targeting 단독 RCT 부재 |
| Ethnicity gap 가설 | CIRCUS/CYCLE = 유럽 cohort · ALDH2 동아시아 변이 (rs671)로 acetaldehyde + ROS 처리 차이 가능 | 한국인 mPTP threshold 직접 측정 없음 |
| 한국 단독 mPTP 임상 | 없음 (adenosine IC retrospective만) | de novo RCT design 필요 |
| supplement track | NMN · NR · honokiol = OTC/식품 — IRB-light pilot 가능 | KAMIR-V sub-arm 제안 가치 |

---

## 7. 참고문헌

- Bernardi P (2013) *Front Physiol* 4:95 — mPTP regulator review
- Giorgio V et al. (2013) *PNAS* 110:5887 — F-ATPase c-ring forms mPTP
- Halestrap AP, Richardson AP (2015) *J Mol Cell Cardiol* 78:129 — mPTP review (ANT/VDAC 학파)
- Baines CP et al. (2005) *Nature* 434:658 — CypD KO 마우스 IRI 50% ↓
- Cung TT et al. (2015) *NEJM* 373:1021 — CIRCUS
- Ottani F et al. (2016) *JACC* 67:365 — CYCLE
- Gibson CM et al. (2016) *JACC* 67:1416 — EMBRACE STEMI (MTP-131)
- Atar D et al. (2015) *Eur Heart J* 36:112 — MITOCARE (TRO40303)
- Hansson MJ et al. (2009) *J Bioenerg Biomembr* 41:299 — NIM811 mPTP
- Clarke SJ et al. (2002) *J Biol Chem* 277:34793 — sanglifehrin-A CypD
- Szeto HH (2014) *Br J Pharmacol* 171:2029 — elamipretide (SS-31) MoA
- Sun J et al. (2014) *Cardiovasc Res* 102:447 — SIRT3 deacetylates CypD K166
- Heusch G (2016) *Circ Res* 119:1262 — IRI mPTP 임상 gap review

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| CypD 핵심 regulator 지위 | 🟡 SUPPORTED-BY-CITATION | Baines 2005 KO + 일관된 후속 |
| F-ATPase c-ring vs ANT 학파 | 🟡 SUPPORTED-BY-CITATION | Giorgio 2013 + Halestrap 2015 (논쟁 중) |
| 4건 neutral 임상 정량 | 🟡 SUPPORTED-BY-CITATION | NEJM/JACC/EHJ 1차 출처 |
| 3-axis 실패 원인 분해 | 🟡 SUPPORTED-BY-CITATION | post-hoc 분석 + Heusch 2016 review |
| 3-path 돌파 가설 | 🟠 INSUFFICIENT/DEFERRED | 후보 inventory 단계 · M3-M5에서 in silico/전임상 검증 필요 |
| 한국인 ethnicity gap | 🟠 INSUFFICIENT/DEFERRED | ALDH2 hypothesis 단계 · 직접 데이터 부재 |

→ M3: **NIM811 · debio-025 · MTP-131(IC) · NMN** 4축 docking + PK 모델 + IC delivery 시뮬레이션으로 🟢 SUPPORTED-NUMERICAL 목표.
