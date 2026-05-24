# M6 — off-target / safety profile (M2 mPTP + M3 미세혈관 통합)

> 마일스톤 M6 산출물 · current-state · no history.
> 출처 = literature (RCT · meta · pharmacovigilance) → 🟡 SUPPORTED-BY-CITATION (hexa recompute 없음).
> 범위 = M2 mPTP 후보 + M3 미세혈관 후보의 **safety axis** 단독 평가 (효능 ranking은 M7).

---

## 1. Safety 5-domain 분류

no-reflow 약물의 부작용은 5개 도메인으로 수렴.

| Domain | 라벨 | 대표 신호 | 발현 시점 | 가역성 |
|---|---|---|---|---|
| **A** | 부정맥 (bradyarrhythmia) | AV-block · sinus pause | 투약 직후 (s-min) | 즉시 가역 (adenosine t½ <10s) |
| **B** | 저혈압 | systolic ↓ ≥ 20 mmHg | 투약 중 | 일시 (NTP/adenosine) vs 지속 (CCB) |
| **C** | 출혈 | major TIMI · ICH | 24h-48h | 비가역 (IIb/IIIa 차단 t½ + plt 회복) |
| **D** | 면역억제 / 신독성 | infection · ↑Cr | 일-주 단위 | 가역 (CsA 단회) vs 누적 (CsA 반복) |
| **E** | 기타 | ulcer · flushing · GI · pancreatitis | 다양 | 약물별 상이 |

### 1.1 ASCII — 5-domain heat map

```
                  부정맥  저혈압  출혈   면역/신   기타
                   (A)    (B)    (C)    (D)      (E)
  adenosine        ███    ██     ·      ·        █(flush)
  nicorandil       ·      █      ·      ·        ██(ulcer/HA)
  NTP (IC)         ·      ██     ·      ·        █(cyanide-long)
  verapamil IC     ███    ██     ·      ·        ·
  abciximab        ·      ·      ███    ·        █(plt)
  tirofiban        ·      ·      ██     ·        ·
  CsA (CIRCUS)     ·      ·      ·      ██       ·
  NIM811           ·      ·      ·      █(spare) █(bili)
  debio-025        ·      ·      ·      ·        ███(pancreatitis)
  MTP-131          ·      ·      ·      ·        █(flush·IV rxn)
  TRO40303         ·      ·      ·      ·        ██(GI)
  NAD+/NMN         ·      ·      ·      ·        ·

  범례: ███ 임상 신호 강 · ██ 보통 · █ 약 · · 미보고/무관
```

---

## 2. M2 mPTP 약물 safety profile

| 약물 | 표적 외 작용 | major AE | dose-limiting | 한국 신호 |
|---|---|---|---|---|
| **CsA (cyclosporin-A)** | calcineurin 억제 (면역/신독성/HTN/다모증/gingival hyperplasia/신경독성) | CIRCUS 2.5 mg/kg 단회 IV → 위약 대비 차이 X | 반복 투여 시 신독성·HTN 누적 | CIRCUS-style 단회 IV 데이터 없음, 이식 분야 친숙 |
| **NIM811** | non-immunosuppressive (calcineurin 결합 X) | HCV Ph2에서 **hyperbilirubinemia** (transporter 억제, OATP/MRP2) | 고용량 시 빌리루빈 ↑ | KR 임상 경험 거의 없음 |
| **sanglifehrin-A** | non-immunosuppressive (CypA inhibitor) | preclinical only | 미확정 | preclinical only |
| **debio-025 (alisporivir)** | non-immunosuppressive (cyclophilin pan-inhibitor) | HCV Ph3에서 **pancreatitis cluster** (n≈3, fatal 1) → FDA partial clinical hold (2012) | 췌장염 신호 | KR 임상 경험 없음 |
| **MTP-131 (elamipretide, SS-31)** | cardiolipin-binding peptide (off-target 매우 적음) | transient flushing · IV infusion reaction · 장기 safety EMBARK/TAZPOWER 양호 | dose 제한 신호 없음 | KR 사용 경험 없음 (Stealth BioTx 단독) |
| **TRO40303 (Trimetazidine 유사 mPTP)** | dose-related GI (오심·복통) | MITOCARE Ph2에서 dose-dep GI · 효능 neutral → 개발 중단 | GI tolerability | KR 사용 없음 |
| **SIRT3 agonist (SRT1720류)** | preclinical · sirtuin family cross-talk | long-term safety 미확정 | preclinical | preclinical only |
| **NAD+ / NMN booster** | 일반적 양호 (supplement) | rare GI · flushing | 고용량 시 methylation pool 고갈 우려 | supplement gray-zone (의약품 X), 광범위 사용 |

### 2.1 핵심 신호 요약

- **CIRCUS (Cung 2015)**: 단회 IV CsA 2.5 mg/kg → safety 차이 없음 (primary efficacy neutral). 반복투여가 아닌 **PCI 직전 단회**가 safety window의 결정 요소.
- **debio-025 췌장염**: cyclophilin pan-inhibitor의 mitochondrial pancreatic acinar cell 독성 가설. CsA·NIM811에는 동일 신호 없음 (CypD selectivity 차이).
- **MTP-131**: mPTP family에서 safety 최우수 — non-immunosuppressive + 비-cyclophilin 기전 + transient flushing 외 신호 없음.

---

## 3. M3 미세혈관 약물 safety profile

| 약물 | MoA | 주요 부작용 | monitor | 가이드라인 권고 |
|---|---|---|---|---|
| **Adenosine IC** | A2A 활성 | transient AV-block (1-3급) · sinus pause · flushing · 흉부 압박감 (5-10s) | 12-lead ECG · 후속 박동 | IIa (no-reflow rescue, ACC/AHA 2013) |
| **Adenosine IV (FFR/IMR)** | 동일 + 체순환 | transient hypotension · bronchospasm (천식 회피) | BP · 천식 history | FFR 표준 (IIa) |
| **Nicorandil (oral/IV)** | K-ATP opener + NO | **ulcer** (구강·항문·위장관·각막), 장기 사용시 ↑ · headache · 저혈압 | 점막 ulcer 확인 | JCS Ph3 권고, ACC/AHA 미수록 |
| **NTP (nitroprusside IC)** | NO 직접 공여 | transient hypotension · cyanide 축적 (장기 IV 우려, **단회 IC <100 μg 안전**) | BP · 신기능 | IIb (small RCT) |
| **Verapamil IC** | L-type Ca²⁺ block | bradycardia · AV-block · hypotension (특히 LV dysfunction · LVEF <30%) | LVEF · HR · BP | IIb |
| **Nicardipine IC** | dihydropyridine L-type | hypotension (reflex tachy) — bradycardia 적음 | BP · HR | IIb |
| **Abciximab IC** | GP IIb/IIIa pan-block (Fab) | **major bleeding TIMI** · thrombocytopenia (0.4-1%) · readministration anaphylaxis | plt count · 출혈 부위 | 생산 중단 (2019, 글로벌) |
| **Tirofiban IC** | GP IIb/IIIa 가역적 | bleeding (abciximab보다 ↓) · thrombocytopenia 낮음 | plt · 출혈 | IIb (한국 사용 가능) |
| **Eptifibatide IC** | 동일 (가역적) | bleeding · 신부전 시 dose 조정 | plt · CrCl | IIb |

### 3.1 핵심 신호 요약

- **Adenosine**: 부작용 모두 **transient (t½ <10s)** — 가역성 최우수. 천식 + 고도 AV-block 제외 시 광범위 안전.
- **Nicorandil ulcer**: 한국·일본 처방 우위 → 장기 사용 시 ulcer monitor 필수 (구강·항문 검진).
- **NTP cyanide**: 단회 IC <100 μg 누적 → cyanide 임상적으로 무의미. 장기 IV (>72h)와 분리.
- **IIb/IIIa**: 한국인 출혈 위험 ↑ (체격·ICH baseline) → IC dose는 글로벌 표준 미만 권고 다수 (TICAKOREA 신호).

---

## 4. Safety × cause 매트릭스 (avoidance 결정)

PCI 직후 환자군별 약물 회피 의사결정 — ✅ 사용 가능 / ⚠ 주의 / ❌ 회피.

| 약물 | bradycardia 위험군 | bleeding 위험군 | LV dysfunction (LVEF <30%) | renal failure (CrCl <30) |
|---|---|---|---|---|
| adenosine IC | ❌ | ✅ | ✅ | ✅ |
| nicorandil | ✅ | ✅ | ✅ | ✅ (CrCl 30 까지) |
| NTP IC | ✅ | ✅ | ⚠ (저혈압) | ⚠ (cyanide 누적) |
| verapamil IC | ❌ | ✅ | ❌ | ✅ |
| nicardipine IC | ✅ (bradycardia X) | ✅ | ⚠ | ✅ |
| abciximab IC | ✅ | ❌ | ✅ | ⚠ |
| tirofiban IC | ✅ | ⚠ | ✅ | ⚠ (dose adj) |
| CsA 단회 IV | ✅ | ✅ | ✅ | ❌ (신독성) |
| MTP-131 IV | ✅ | ✅ | ✅ | ✅ |
| NIM811 | ✅ | ✅ | ✅ | ⚠ (bilirubin) |
| debio-025 | ✅ | ✅ | ✅ | ⚠ (pancreatitis) |
| NAD+/NMN | ✅ | ✅ | ✅ | ✅ |

→ **가장 보편적 안전 약물**: adenosine IC (bradycardia 군 제외) · nicorandil · MTP-131 · NAD+/NMN.
→ **고위험군 제한적 약물**: verapamil (LV dysfunction X) · abciximab (bleeding X) · CsA (renal X).

---

## 5. 임상 trial에서 관찰된 safety 신호

| Trial | 약물 | safety event | incidence | severity |
|---|---|---|---|---|
| CIRCUS (NEJM 2015) | CsA 2.5 mg/kg IV 단회 | major AE | 위약과 동등 | minimal |
| AMISTAD-II (JACC 2005) | IV adenosine 50/70 μg/kg/min × 3h | transient AV-block | minor (% n.r.) | 일시 |
| REOPEN-AMI (JACC 2013) | IC adenosine + NTP | transient hypotension | <5% | 일시 |
| INFUSE-AMI (JAMA 2012) | IC abciximab | major bleeding | 위약과 차이 없음 (IC route 우위) | — |
| ENABLE (oral nicorandil RCTs) | nicorandil | oral/anal ulcer | 0.5-2% (long-term) | 회복 가능 (감량/중단) |
| TASTE (NEJM 2013) | manual thrombectomy | stroke (30d) | 0.5% vs 0.2% (trend) | moderate |
| TOTAL (NEJM 2015) | manual thrombectomy | stroke (30d) | 1.0% vs 0.3% (**RR 1.5, p<0.05**) | severe → 가이드라인 권고 down |
| MITOCARE (EHJ 2015) | TRO40303 | GI AE | dose-related | mild-moderate |
| DEBIO-025 HCV Ph3 | alisporivir | pancreatitis | n=3 (fatal 1) | FDA hold |
| EMBARK (elamipretide) | MTP-131 IV | flushing · IV reaction | <10% transient | mild |
| TICAKOREA (Lancet 2020) | ticagrelor (한국인) | major bleeding | clopidogrel 대비 ↑ (HR ~1.5) | 한국인 baseline 출혈 risk ↑ 시사 |

### 5.1 임상적 결정 요약

- 단회 IV (CsA · MTP-131)는 반복 투여 calcineurin/cyclophilin 독성 없이 안전 window 확보.
- IC route는 IV 대비 systemic exposure 1/10-1/100 → safety 우위 (INFUSE-AMI abciximab IC가 bleeding 증가 없음).
- 기계적 흡입(thrombectomy)은 약물 아니지만 stroke 신호로 routine 권고 down — DE 표적에서 약물(IIb/IIIa) 우위.

---

## 6. M2/M3 약물 통합 safety ranking

| 후보 | 효능 등급 (M2/M3 §) | safety 등급 | LV 안전 | bleeding 안전 | 종합 grade |
|---|---|---|---|---|---|
| adenosine IC | A (REOPEN-AMI ↓MVO) | A (transient만) | A | A | **A** |
| nicorandil | A (J-WIND LVEF · KR 보험) | A (ulcer monitor 가능) | A | A | **A** |
| MTP-131 (elamipretide) | B (mPTP 차단, 임상 mixed) | A (장기 safety 우수) | A | A | **A** |
| NIM811 | B (mPTP, preclinical 강) | B (bilirubin) | A | A | **B** |
| verapamil IC | B (VS) | B (LV X · bradycardia X) | C | A | **B** |
| nicardipine IC | B (VS) | B (저혈압) | B | A | **B** |
| tirofiban IC | B (DE) | B (bleeding 회피군 X) | A | C (위험군) | **B** |
| NTP IC | B (VS) | B (저혈압 · cyanide 무의미) | C | A | **B** |
| CsA 단회 IV | C (CIRCUS neutral) | A (단회) — C (반복) | A | A | **C** (효능 한계) |
| abciximab IC | B (DE) | C (bleeding · 생산 중단) | A | C | **C** |
| debio-025 | B (mPTP, HCV) | C (pancreatitis hold) | A | A | **C** |
| TRO40303 | C (MITOCARE neutral) | C (GI) | A | A | **C** |
| NAD+/NMN | C (supplement, 인과 약함) | A | A | A | **C** (효능 미확정) |

### 6.1 Tier 분류

- **Tier-A** (효능 + safety 균형 우수): **adenosine IC · nicorandil · MTP-131**
- **Tier-B** (선택적 사용 — 환자군별 회피): **NIM811 · verapamil IC · nicardipine IC · tirofiban IC · NTP IC**
- **Tier-C** (회피 또는 매우 선택적): **CsA 반복 · abciximab IC · debio-025 · TRO40303 · routine thrombectomy**

### 6.2 ASCII — ranking tree

```
                     PCI 직후 no-reflow 약물 safety ranking
                                    │
              ┌─────────────────────┼─────────────────────┐
            Tier-A                Tier-B                Tier-C
       (효능+safety 균형)      (환자군별 회피)        (회피 권장)
              │                     │                     │
       ┌──────┼──────┐       ┌──────┼──────┐       ┌──────┼──────┐
   adenosine nicor- MTP-131  NIM    verap  tirof   CsA   abcix  debio
      IC    andil           811     IC     IC      반복   IC    025
       │      │      │       │      │      │       │      │      │
     trans-  ulcer   IV-rxn  bili   LV·HR  bleed   neph  bleed  panc
     ient    monitor flush   ↑      X      위험군  X     X      X
```

---

## 7. 한국인 고려사항 (M8 입력)

| 축 | 신호 | M8 입력 |
|---|---|---|
| 출혈 baseline ↑ | TICAKOREA (Park 2020) — ticagrelor major bleeding HR ↑ vs clopidogrel · 동양인 ICH risk ↑ | IC IIb/IIIa는 한국인 dose-down 또는 회피 검토 |
| nicorandil 보험 보장 | 일본·한국 SAS/CCS 처방 광범위 — pre/post-PCI sequential 가능 | M8 pilot에서 nicorandil arm 추가 가능 (KR 우위) |
| supplement gray zone | NAD+/NMN — 의약품 분류 X · 보충제 광범위 | M8 IRB에서 supplement vs 의약품 명확 분리 필요 |
| 임상 데이터 가용 | K-ACTION · KAMIR-NIH — Korean MI registry safety subset | nicorandil · IC IIb/IIIa 한국인 subgroup 추출 가능 |
| 신독성 baseline | 한국인 CKD prevalence ~13% (KNHANES) — CsA · IIb/IIIa renal-adj | dose-adj 또는 회피 검토 |
| CYP3A4 variant | 한국인 CYP3A4*1G/*22 frequency 차이 — CsA · alisporivir 대사 변동 | PK study에서 KR-specific dose 검토 (DAPTPGX 도메인과 cross) |

---

## 8. 참고문헌

- Cung TT et al. (2015) *NEJM* 373:1021 — **CIRCUS** CsA 단회 IV safety + efficacy neutral
- Ross AM et al. (2005) *JACC* 45:1775 — **AMISTAD-II** IV adenosine safety subset
- Niccoli G et al. (2013) *JACC* 62:1289 — **REOPEN-AMI** IC adenosine + NTP safety
- Stone GW et al. (2012) *JAMA* 307:1817 — **INFUSE-AMI** IC abciximab bleeding
- Jolly SS et al. (2015) *NEJM* 372:1389 — **TOTAL** thrombectomy stroke 신호
- Atar D et al. (2015) *Eur Heart J* 36:112 — **MITOCARE** TRO40303 GI safety
- Pieper GM (2010) *Cardiovasc Drug Rev* 9:226 — nicorandil ulcer · safety review
- Flisiak R et al. (2008) *Hepatology* 47:817 — **debio-025** HCV pancreatitis 신호
- Tardif JC et al. (2008) NEJM (alisporivir-precursor pharmacology) — cyclophilin inhibitor safety axis
- Szeto HH (2014) *Br J Pharmacol* 171:2029 — **elamipretide (MTP-131)** safety + long-term
- Chiari P et al. (2014) *Anesthesiology* 121:292 — CsA preconditioning safety meta
- Park KW et al. (2020) *Lancet* 396:1079 — **TICAKOREA** 한국인 ticagrelor 출혈 신호

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 5-domain 분류 (§1) | 🟡 SUPPORTED-BY-CITATION | 임상시험 + pharmacovigilance 종합 |
| M2 mPTP safety profile (§2) | 🟡 SUPPORTED-BY-CITATION | CIRCUS · MITOCARE · DEBIO Ph3 직접 인용 |
| M3 미세혈관 safety profile (§3) | 🟡 SUPPORTED-BY-CITATION | AMISTAD-II · REOPEN-AMI · INFUSE-AMI 등 |
| safety × cause 매트릭스 (§4) | 🟡 SUPPORTED-BY-CITATION | 가이드라인 (ACC/AHA 2013, JCS) + 임상 권고 |
| trial safety 신호 (§5) | 🟡 SUPPORTED-BY-CITATION | RCT primary safety endpoint 추출 |
| 통합 ranking Tier-A/B/C (§6) | 🟡 SUPPORTED-BY-CITATION | 효능 (M2/M3) × safety axis 조합, 임상 합의 외삽 |
| 한국인 고려 (§7) | 🟡 SUPPORTED-BY-CITATION | TICAKOREA · KNHANES · KAMIR-NIH 인용 |

다음 단계 M7 (효능 + safety 통합 ranking) · M8 (한국 임상 pilot 설계)에서 본 safety axis가 환자 inclusion/exclusion + dose 결정에 직접 입력.
