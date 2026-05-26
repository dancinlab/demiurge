# X5 — 한국 first-in-class 4-trial portfolio 통합

> CARDIO+ 메타도메인 X5 산출물 · current-state · no history.
> 목적 = 4개 한국 first-in-class 임상시험 설계를 단일 portfolio로 통합 — 공유 인프라 시너지 · 3-axis (ALDH2\*2 × CYP2C19 LoF × Lp(a)) stratification · 순차 timeline · 기존 NHIS 급여 안 배포 가능성을 드러낸다.

---

## §0. g5 인용 규약 (필수 — 본 X5 전체 적용)

- 정량 주장 중 **X1 / sub-V verify 파일에 `hexa verify` (또는 pool simulation) verdict 가 있는 항목**은 verbatim 인용 + 출처 표기.
- verdict 없는 trial DESIGN 의 가설(예상치)은 모두 ⚪ **proposal / 설계 가정** 으로 명시.
- ❌ LLM self-judge 로 🟢/🔵 부여 금지. 추정 n · 예상 효과크기는 전부 "설계 가정" 라벨.

| 표기 | 의미 (X5 내 용법) |
|---|---|
| 🟢 (인용) | sub-V verify 파일에 SUPPORTED-NUMERICAL verdict 존재 — verbatim carry |
| 🟠 (인용) | sub-V verify 파일에 INSUFFICIENT/DEFERRED verdict 존재 — verbatim carry |
| ⚪ proposal | trial DESIGN 가설 — verify verdict 부재 · 설계 가정 |

---

## §1. portfolio 마스터 표

> 4 trial = X1 §7.2 4-domain layered care 구체화 (NOREFLOW M7§5.1 + DAPTPGX M8 + ISR M8§4.1 + LPA M9).
> 추정 n · phase · 효과크기는 ⚪ proposal (설계 가정) — verify verdict 가 있는 칸만 별도 표기 (§6 참조).

| trial | 대상 인구 (한국 특이) | 중재 | 1차 종결점 | 추정 n | phase | 규제 경로 (MFDS/IRB) | 한국 특이 근거 |
|---|---|---|---|---|---|---|---|
| **A. NICORADENO-MVO** | STEMI primary PCI · IMR > 40 (MVO+ subset, screen 의 ~40%) · ALDH2\*2 subgroup 사전지정 | nicorandil PO 10 mg loading + IV 4 mg bolus pre-PCI + IC adenosine 24 mg distal microcatheter · post-PCI nicorandil PO 7일 | **CMR infarct size (% LV mass) at 30d** (Stone 2016 validated surrogate) | **~500** (IMR>40 무작위, active vs standard) ⚪ | Ph2 (한국 단독, off-label routine 약물 조합) ⚪ | nicorandil·adenosine 모두 한국 보험 routine → **신규 IND 불요** · 단일 protocol IRB + KAMIR consortium | nicorandil 한국 보험 등재 (J-WIND 후, 글로벌 우위) · ALDH2\*2 East Asian ~40% → NO bioavailability ↓ → alternative NO donor 우위 가능 (ALDH2 stratified RCT 글로벌 부재) [NOREFLOW M8§5 · M9§5] |
| **B. DAPT-PGx-K** | 한국인 PCI 환자 · CYP2C19 LoF (\*2/\*3) 합계 ~40% allele · IM+PM ~60% diplotype | CYP2C19 PCR (C5946 선별급여) → S4 targeted PGx 결정맵: NM=clopidogrel · IM/PM=prasugrel 5 mg (한국 dose) / 선택적 ticagrelor 60 mg · HBR×시술복잡도 layered de-escalation | **1y MACE (S4 targeted vs S1 universal clopidogrel)** · 공동 1차 major bleeding (GUSTO/BARC) | **설계 가정** (NHIS S4 sensitivity 후 확정 · M8 econ 모델 기반) ⚪ | Ph3/pragmatic RCT 또는 NHIS registry-embedded ⚪ | CYP2C19 PCR 선별급여 기존재 → 검사 자체 급여 안 · prasugrel/ticagrelor 기존 급여 약제 → **신규 약물 IND 불요** | 한국인 CYP2C19 LoF allele ~40% = 글로벌 최고 (\*3 백인 대비 20-50배) · IM+PM ~60% · TICAKOREA ticag bleed 2.8% (서구 PLATO 1.4% 의 2배) → universal ticag 부적합 [DAPTPGX M1§3 · M8§3] |
| **C. ISR-non-mTOR (ROCK-DCB IIT-1)** | 한국인 ISR 환자 · Mehran pattern I/II · small vessel 多 · NA risk 高 · OCT-guided | fasudil-coated DCB (lipophilic prodrug / sugar microreservoir carrier) — 비-mTOR ROCK 억제, single-arm first-in-human (후속 IIT-2 = biolimus+fasudil dual-DCB RCT) | **6m OCT-derived LLL (late lumen loss) + 30d safety (procedural · LST)** | **60** (multi-center 6-8 sites) ⚪ | first-in-human / pre-pivotal IIT ⚪ | **MFDS first-in-human IND** (신규 device·coating) + Japan PMDA cross-recognition (fasudil 일본 1995 승인) | 한국 ISR cohort = NA risk 高 + small vessel 多 + OCT-guided = 비-mTOR adjunct·DCB 최적 검증 platform (K-DCB·K-iDES registry) · fasudil 일본 30y 안전성 → 한일 cross-recognition leverage [ISR M8§1.2 · M3 · M4§2.1] |
| **D. LPA-siRNA-K (K-LpA-OUTCOMES)** | 한국인 ASCVD 2차 예방 · Lp(a) ≥ 100 (또는 KSoLA ≥50 high) · KIV-2 copy 3-tier stratified | arm A = optimized background (statin + PCSK9 mAb 급여) · arm B = pelacarsen SC Q4W 80 mg **또는** olpasiran SC Q12W 75 mg (HORIZON 2026 H1 readout 후 분기) | **4-point MACE (CV death + non-fatal MI + non-fatal stroke + urgent revasc) at 24m interim / 60m final** | **~3,000** (n=2,500 + buffer 500) ⚪ | Ph3 outcome IIT (PROBE adaptive) ⚪ | KCTRN (MFDS 의무 등록) + KMA central IRB · **siRNA/ASO = 신규 승인 필요** (현 비급여) · RSA 우선 협상 | 한국 ≥50 mg/dL 약 12-13% (절대수 ~520만 명) · KIV-2 copy stratified efficacy = 글로벌 trial (HORIZON·OCEAN(a)) 미시도 영역 → K-LpA-OUTCOMES 가 첫 정량 [LPA M2§2 · M9§2] |

⚠ **g5 fence**: 추정 n (A 500 · C 60 · D 3,000) · phase · 효과크기 (HR 0.80 등) 는 모두 **trial DESIGN 의 설계 가정 (⚪ proposal)**. 단, A 의 n=500 power · D 의 Schoenfeld events 는 sub-V 에 simulation verdict 존재 → §6 에서 verbatim 분리 인용.

---

## §2. 공유 인프라 시너지 — single-build 4-trial unlock

> X1 §3 cross-domain 시너지 + CARDIO+.md d2 governance (single PR이 4-domain 동시 unlock) 적용.
> 핵심 = "한 번 구축하면 둘 이상의 trial 이 동시에 쓰는" 인프라 = consortium 비용·시간 절감 leverage.

### 2.1 카테터 국소전달 공통 — IC delivery PK ↔ drug-eluting balloon

```
[ 공유 자산 1 : 관상동맥 국소 약물전달 (catheter-based local delivery) ]

  NOREFLOW M4 (IC delivery PK)          ISR M5 (drug-eluting balloon, DCB)
  ─────────────────────────            ──────────────────────────────────
  T1 IC bolus (microcatheter distal)    T5 drug-eluting catheter/balloon
  도달 ~0-1 s · 국소농도 IC/IV 30-100×   inflation 30-60s vessel-wall 전달
  재관류 5분 lethal window 우회           "leave nothing behind" carrier
                  │                                    │
                  └──────────────┬─────────────────────┘
                                 ▼
        ★ 공유 = microcatheter distal access + 국소농도 PK 모델 + carrier 화학
          NOREFLOW M4 "풍선 직전 IC bolus" delivery 시퀀스 (T-3s IC inject → inflation)
          = ISR fasudil-DCB inflation 약물전달과 동일 카테터 워크플로
          → IC delivery PK 핵심 (도달시간 · 국소농도 ratio · carrier release) 1회 정량 =
            Trial-A (adenosine IC distal) + Trial-C (fasudil-DCB) 동시 입력
```

- **공유 인프라**: microcatheter distal access 술기 · 국소농도 vs systemic PK 모델 (도달 ~0-1s · IC/IV ratio 30-100×) · DCB/wire carrier 화학 (lipophilic prodrug / sugar microreservoir).
- **leverage**: NOREFLOW M4 의 "IC bolus → 풍선 inflation 동기화" 시퀀스 (M4 §5 frontier · T5 drug-eluting catheter) = ISR M5 DCB inflation 약물전달과 **동일 물리·동일 워크플로**. 카테터 국소전달 core lab (PK 측정 + carrier release assay) 1회 구축 → Trial-A · Trial-C 공용.
- **g5**: IC PK 우위 (도달시간·국소농도 ratio) = NOREFLOW M4 🟡 SUPPORTED-BY-CITATION (literature, hexa recompute 없음, M4 §header). carrier release 정량 = ISR V3 🟢 (drug release recompute 일부). 시너지 자체는 ⚪ proposal (consortium 미결성).

### 2.2 supplement / siRNA delivery 공통 — IRB-light pilot

```
[ 공유 자산 2 : 비-IND supplement · 분자전달 pilot 인프라 (IRB-light) ]

  NOREFLOW Path A (NAD+/SIRT3 supplement)     LPA (siRNA/ASO delivery)
  ─────────────────────────────────────      ─────────────────────────
  NMN/NAD+ = 한국 건강기능식품 시판             pelacarsen ASO / olpasiran siRNA
  → IRB-light 단일기관 pilot (식품 등급)        GalNAc-conjugate SC delivery
  SIRT3 → NAD+-dependent mPTP·IRI 보호           간세포 표적 침묵화
                  │                                    │
                  └──────────────┬─────────────────────┘
                                 ▼
        ★ 공유 = 분자전달 PK/PD pilot 플랫폼 + SC/PO 투여 cohort 운영
          NOREFLOW Trial-B (NMN-PRECON) 단일기관 IRB-light pilot 운영 노하우
          = LPA K-LpA-OUTCOMES siRNA arm 초기 한국 PK/PD sub-cohort 운영과 공유
          (양쪽 모두 "신약 IND 전 / 비-침습 분자전달 cohort" 운영 표준)
```

- **공유 인프라**: 비-침습 분자전달 cohort 운영 표준 (SC/PO 투여 · PK/PD 채혈 schedule · adherence 모니터) · 단일기관 IRB-light pilot 거버넌스.
- **leverage**: NOREFLOW Path A (NMN-PRECON, M7§5.2 — 한국 건강기능식품 NMN 으로 IRB-light 단일기관 pilot) 운영 노하우 = LPA siRNA arm 의 한국 PK/PD sub-cohort 운영 (M9§7 KIV-2 copy 측정 protocol 동반) 과 cohort 운영 측면 공유. 양쪽 모두 mitochondrial NAD+ ↔ siRNA 라는 다른 modality 지만 "비-IND / 분자전달 pilot 운영" 인프라는 공통.
- **g5**: NMN supplement preconditioning 효과 = NOREFLOW M7§5.2 ⚪ proposal (Trial-B, simulation 미실시 — M12 §8 "Path A 단독 Path 보다는 Trial-B 로만" 명시). siRNA delivery PK = LPA V3a 🟢 (siRNA ODE pool ubu-1, 4분자 PK · LPA V4 §38). 시너지 자체 = ⚪ proposal.

### 2.3 공유 인프라 매트릭스

| 공유 자산 | Trial-A | Trial-B (NOREFLOW pilot) | Trial-C | Trial-D | 1회 구축 효과 |
|---|:---:|:---:|:---:|:---:|---|
| 카테터 국소전달 PK + carrier core lab | ● (IC adenosine) | — | ● (fasudil-DCB) | — | A·C 공용 |
| 다기관 CMR / OCT imaging consortium | ● (CMR) | ● (CMR pilot) | ● (OCT) | — (MACE adjudication) | A·B·C imaging core lab 공용 (X1 §3 CMR/OCT 자산) |
| 비-IND 분자전달 pilot 거버넌스 | — | ● (NMN PO) | — | ● (siRNA SC) | B·D 공용 |
| 3-axis genotype 측정 (PCR) | ● (ALDH2) | — | — | ● (KIV-2) | A·D + Trial-B(CYP2C19) 공용 PCR lab (§3) |
| KAMIR / 한국 registry backbone | ● (KAMIR-NIH) | ● | ● (K-DCB·K-iDES) | ● (KAMIR PI MOU) | 4-trial 전부 (X1 CX02) |

→ **single-build leverage**: 다기관 imaging consortium (CMR+OCT) + 3-axis PCR lab + KAMIR registry backbone 3개를 1회 구축하면 4-trial 전부의 인프라 의존이 동시에 해소. (X1 §3 "한국 다기관 imaging consortium 결성 시 동시 unlock" 구체화.)

---

## §3. 3-axis stratification 통합 — ALDH2\*2 × CYP2C19 LoF × Lp(a)

> X1 §3 + §7.2 "한국인 PCI layered care 의 leverage point" 구체화. 동아시아/한국 특이 유전·표현형 3축이 각 trial 의 stratification axis 로 매핑.

### 3.1 3-axis 분포 (한국 특이 — 출처 verbatim)

| axis | 한국/동아시아 빈도 | tier (sub-V) | 출처 |
|---|---|---|---|
| **ALDH2\*2** (rs671) | East Asian ~40% 보유 · NO bioavailability ↓ · STEMI IRI 악화 (남성) | 🟡 SUPPORTED-BY-CITATION | NOREFLOW M9§5 (JAHA 2021 · *J Am Heart Assoc* 2024) |
| **CYP2C19 LoF** (\*2/\*3) | allele 합계 ~40% (글로벌 최고) · IM ~45% + PM ~14-16% = IM+PM ~60% | 🟢 (PM freq 0.1521 · IM+PM 0.6279) | DAPTPGX M1§3 · V3 recompute 🟢 (V3 §61) |
| **Lp(a) high** | ≥50 mg/dL ~12-13% (~520만 명) · ≥75 mg/dL ~5% · KIV-2 low copy = high Lp(a) responder | 🟢 (MR/IVW β=-0.3413) · 분포는 🟡 | LPA M2§2 · V3b 🟢 (V4 §70) |

### 3.2 axis → trial 매핑

```
                  ALDH2*2 (~40%)        CYP2C19 LoF (~40% allele)      Lp(a) high (~12-13%)
                  NO ↓ · IRI 악화        clopidogrel 무반응 ~60%         잔여 위험 30%
                       │                        │                              │
   ┌───────────────────┼────────────────────────┼──────────────────────────────┼─────────────────┐
   │                   ▼                        ▼                              ▼                 │
   │   Trial-A      ● PRIMARY axis 후보       (cross — DAPT 처방 환자가          (cross — Lp(a)     │
   │   NICORADENO     ALDH2*2 subgroup 사전     STEMI cohort 와 겹침)            high = MVO 악화     │
   │                  지정 (exploratory)                                        risk modifier)     │
   │                                                                                              │
   │   Trial-B      ● ALDH2*2 군 alternative   —                              —                  │
   │   DAPT-PGx-K    —                        ● PRIMARY axis                  (cross — Lp(a) =     │
   │                                            CYP2C19 diplotype             residual MACE        │
   │                                            (IM/PM 분류 = 무작위 층화)     driver, secondary)  │
   │                                                                                              │
   │   Trial-C      —                        —                              —                    │
   │   ISR-non-mTOR  (ALDH2*2 = NO 의존 fasudil  (cross — DAPT 병용)            (cross — PCSK9/Lp(a) │
   │                  eNOS 효과 modifier 가설)                                  systemic adjunct)   │
   │                                                                                              │
   │   Trial-D      (cross — ALDH2*2 = IRI       (cross — DAPT 병용)          ● PRIMARY axis       │
   │   LPA-siRNA-K    수정 인자)                                              KIV-2 copy 3-tier    │
   │                                                                          stratified           │
   └──────────────────────────────────────────────────────────────────────────────────────────┘

   ● = 해당 trial 의 PRIMARY/사전지정 stratification axis
   cross = 다른 trial 의 axis 가 modifier/secondary 로 cross-cut
```

| axis | PRIMARY 매핑 trial | cross-cut (modifier/secondary) trial |
|---|---|---|
| **ALDH2\*2** | Trial-A (사전지정 subgroup) | Trial-B (ALDH2\*2 군 NO donor 선택) · Trial-C (eNOS modifier 가설) · Trial-D (IRI 수정인자) |
| **CYP2C19 LoF** | Trial-B (IM/PM 층화) | Trial-A/C/D 전부 (DAPT 병용 환자 cohort 중첩) |
| **Lp(a) high (KIV-2)** | Trial-D (KIV-2 copy 3-tier) | Trial-A (MVO 악화 risk modifier) · Trial-B (잔여 MACE driver) · Trial-C (PCSK9 systemic adjunct) |

→ **통합 leverage**: 한 명의 한국 PCI 환자가 동시에 ALDH2\*2 보유 × CYP2C19 LoF × Lp(a) high 일 확률이 비-동아시아 대비 현저히 높음 (각 ~40% · ~40% allele · ~12-13%). 따라서 **3-axis 동시 측정 PCR/lab 1회** = 4-trial 의 stratification 입력 동시 확보 (§2.3 PCR lab 공유) + X6 환자 본인 retroactive 4-axis 적용 (CARDIO+ X6) 연결.

⚠ **g5 fence**: ALDH2\*2 subgroup (Trial-A) 의 power 는 NOREFLOW M12.4 에서 **0.654 — 🟠 INSUFFICIENT (exploratory only)** verdict 보유 (§6). 3-axis 동시 stratification 의 효과 상호작용 (P_interaction) 은 ⚪ proposal — 어느 trial 도 prospective 측정 전.

---

## §4. 순차 timeline — first patient 배치

> NOREFLOW M7§6 roadmap + LPA M9 timeline + ISR M8§4 + DAPTPGX M8 sensitivity gate 통합.
> 즉시(0m) = 신규 IND 불요 · 6m = consortium/IRB lift 후 · 3y = 신규 승인 / 글로벌 readout 의존.

```
시점     trial            first-patient 게이트                         규제 lift
══════════════════════════════════════════════════════════════════════════════════════

즉시     ┌─ Trial-B (DAPT-PGx-K)  ── CYP2C19 PCR 선별급여 기존재         ★ 최저
(0m)     │   "S4 결정맵"             prasugrel/ticagrelor 기존 급여 약제      신규 IND 불요
         │                          → registry-embedded / pragmatic        (NHIS S4 sensitivity
         │                            즉시 시작 가능                          → 정식 RCT 분리)
         │
         └─ Trial-A (NICORADENO) protocol+consortium MOU 시작 (NOREFLOW M7§6 2026 Q2)
            ※ 약물(nicorandil·adenosine)은 보험 routine → IND 불요 ·
              그러나 8-기관 CMR consortium MOU + IMR wire cap 해결 lift 필요

──────────────────────────────────────────────────────────────────────────────────────

6m       ┌─ Trial-A (NICORADENO)  ── 8-기관 MOU + CMR core lab QC 완료 후      ★ 중
(6m~)    │   first patient            enrollment 시작 (M7§6: 2026 Q4 enroll,    consortium 결성 +
         │   (enroll)                 2027 Q2 n=500 target)                     CMR/IMR cap
         │
         └─ Trial-C (ROCK-DCB IIT-1) MFDS first-in-human IND 제출 → 승인 후       ★ 중-고
             pre-IND                  first-in-human · Japan PMDA cross-recog     신규 device IND
                                      (fasudil 일본 승인 leverage)

──────────────────────────────────────────────────────────────────────────────────────

3y       ┌─ Trial-D (LPA-siRNA-K) ── HORIZON 2026 H1 readout → arm B 분기 →       ★ 최고
(2-3y~)  │   K-LpA-OUTCOMES          KCTRN+IRB → 2027-H2 enrollment 본격            siRNA/ASO 신규
         │   first patient           (M9: n=3,000 × 18mo, 2032 H1 primary)         승인 + RSA 협상
         │
         └─ Trial-C IIT-2 (dual-DCB) ── IIT-1 6m LLL readout 후 RCT 확장

──────────────────────────────────────────────────────────────────────────────────────

decision gates (NOREFLOW M7§6 + LPA M9 §10):
  ★ 2027 Q4  Trial-B(NOREFLOW pilot) readout → Path A 강화 vs Path B 단독
  ★ 2028 Q2  Trial-A CMR primary readout → 글로벌 Ph3 or 한국 단독 Ph3
  ★ 2026 H1  HORIZON readout → Trial-D arm B (pelacarsen vs olpasiran) 분기
  ★ 2032 H1  Trial-D 60m MACE primary → KSoLA 가이드라인 신규 chapter
```

| 시점 | trial | first-patient 조건 | 규제 장벽 |
|---|---|---|---|
| **즉시 (0m)** | **B. DAPT-PGx-K** | CYP2C19 PCR 선별급여 + 기존 급여 약제 → registry-embedded 즉시 가능 | 최저 (신규 IND 불요) |
| 즉시→6m | A. NICORADENO (protocol/MOU) | 약물 IND 불요 · 8-기관 consortium MOU + CMR core lab lift | 중 (consortium) |
| **6m** | **A. NICORADENO (enroll)** | consortium MOU + CMR/IMR cap 해결 후 first patient | 중 |
| 6m | **C. ROCK-DCB IIT-1 (pre-IND)** | MFDS first-in-human IND 제출 + PMDA cross-recognition | 중-고 (신규 device) |
| **3y (2-3y)** | **D. K-LpA-OUTCOMES** | HORIZON readout (2026 H1) → arm B 분기 → KCTRN+IRB → enroll | 최고 (siRNA 신규 승인 + RSA) |

---

## §5. 규제 / 급여 노트 — 기존 NHIS 안 vs 신규 승인

> X1 §9 한국 우선순위 + 각 sub M8 보험 매트릭스 통합. d2 — 규제/registry 장벽에 돌파 path 명시.

### 5.1 기존 한국 급여 안에서 배포 가능 (신규 승인 불요)

| 항목 | 급여 근거 | 적용 trial | 한국 우위 |
|---|---|---|---|
| CYP2C19 PCR (real-time) | C5946 선별급여 (PCI 환자 대상, ₩50,000, 1회) | **B (즉시)** | NHIS 급여 + 한국 PCR cap 충분 [DAPTPGX M8§2] |
| clopidogrel · prasugrel 5 mg · ticagrelor | 기존 급여 약제 (S4 결정맵 = 약제 재배치만) | **B (즉시)** | 신규 약물 IND 불요 |
| nicorandil PO/IV | J-WIND 후 한국 보험 등재 (글로벌 우위 — 일본·한국만 보편 보험) | **A** | adenosine IC 와 조합 시 추가 cost 0 [NOREFLOW M8§5] |
| adenosine IC 24 mg | off-label routine (광범위 사용) | **A** | — |
| PCSK9 mAb (evolocumab/alirocumab) | ASCVD 2차 급여 ✅ (Lp(a) -25% 부분효과) | **D (arm A background)** | 즉시 가용 [LPA M8 Tier-1] |

### 5.2 신규 승인 / 협상 필요

| 항목 | 장벽 | 적용 trial | d2 돌파 path |
|---|---|---|---|
| fasudil-coated DCB | MFDS first-in-human IND (신규 device·coating) | **C** | **Japan PMDA cross-recognition** (fasudil 일본 1995 승인, 30y 안전성) → IND data package 단축 [ISR M8§4.1 regulator hook] |
| pelacarsen / olpasiran (siRNA/ASO) | 현 비급여 · NHIS WTP 0% 통과 (V3c 🟢 — 387-645× 약가 격차) | **D** | **RSA (risk-sharing arrangement)** outcome-based 환불 (60m RRR<15% → sponsor ≥50% refund) + **narrow staging** (≥180 mg/dL · ASCVD 2차 ~52만 명 우선) + **bridge therapy** 3축 [LPA M8 d2 5축 · M9§5] |
| IMR pressure-wire 일회용 cap | 한국 ~10 기관 한정 · 일회용 wire 보험 cap | **A** | KHIDI 임상연구 인프라 트랙 funding + IMR>40 subset 선별 (screen 의 40%) 로 wire 사용 효율화 [NOREFLOW M8§4] |
| 다기관 CMR consortium | **한국 현재 0개** (NOREFLOW 최대 gap) | **A (+B·C imaging)** | 보건복지부 R&D (KHIDI 임상연구 인프라) ~2-3년 빌드 → A·B·C imaging core lab 공유 (§2.3) [NOREFLOW M8§4] |
| ICER cost-effectiveness (Trial-B) | DAPTPGX V5 ICER -503 M/QALY (cited +34, **sign 미반전 — 🟠 DEFERRED**) | **B** | V6 P5 patch closed-form sign 반전 예측 (+5,500 M/QALY, sim pool-route 차단 defer) · vicagrel 도입 시 ICER ~22-28M/QALY = NHIS WTP 충족 [DAPTPGX V5 · V6 · M8§6] |

### 5.3 규제 lift 순위 (낮음 → 높음)

```
B. DAPT-PGx-K   ░░░░░░░░░░  최저 — PCR 급여 + 약제 재배치 (즉시)
A. NICORADENO   ████░░░░░░  중 — 약물 IND 불요, but CMR/IMR consortium lift
C. ROCK-DCB     ██████░░░░  중-고 — MFDS device IND (PMDA cross-recog 로 완화)
D. siRNA-K      ██████████  최고 — siRNA 신규 승인 + NHIS RSA 협상 (글로벌 readout 의존)
```

---

## §6. verify verdict verbatim 인용 (g5 — 설계 가정과 분리)

> 아래는 trial DESIGN 의 ⚪ proposal 이 **아닌**, sub-V verify 파일에 실제 verdict 가 land 된 정량 항목. verbatim carry.

| trial | 정량 항목 | verdict (verbatim) | 출처 |
|---|---|---|---|
| **A** | n=500 @ 15% rel reduction, primary continuous power 0.80 | **0.798 (≈0.80 target, within 0.3%) — 🟢 SUPPORTED-NUMERICAL** | NOREFLOW M12.4 (V4 ledger · M12 §6) |
| **A** | Cox 1y MACE HR 0.75 powered @ n=500 | **power 0.157 — 🟠 INSUFFICIENT (secondary only, n=1500+ 필요)** | NOREFLOW M12.4 |
| **A** | ALDH2\*2 subgroup powered (sub n=201) | **power 0.654 — 🟠 INSUFFICIENT (exploratory only)** | NOREFLOW M12.4 |
| **A** | IMR>40 enrol-to-screen ratio | **2.5× (40% IMR>40 발생률) — closed-form** | NOREFLOW M12.4 |
| **B** | CYP2C19 PM phenotype freq | **0.1521 (cited 0.14-0.15) — 🟢 SUPPORTED-NUMERICAL (exact)** | DAPTPGX V3 §61 (C05) |
| **B** | IM+PM 합 | **0.6279 (cited 0.60) — 🟢 SUPPORTED-NUMERICAL (within)** | DAPTPGX V3 (C06) |
| **B** | S4 ICER (M KRW/QALY) | V3 -3,221 → **V5 -503 (cited +34) — 🟠 DEFERRED (sign 미반전, model reconciliation)** | DAPTPGX V5 §100 |
| **C** | fasudil-DCB IIT-1 전체 설계 | **verify verdict 부재 — ⚪ proposal (설계 가정)** · fasudil porcine NH 40-50%↓ (Matsumoto 2004) = 🟡 cite only | ISR M8§4.1 · M3§2.3 |
| **D** | Schoenfeld events (HR 0.80, 90% power) | M9 design D≈842 · V4: HORIZON Schoenfeld **D=844 (anticipated 920, adequate) — 🟢** (C08) | LPA V4 §46 · M9§2 |
| **D** | OCEAN(a)-DOSE 2-sample power | **n/arm=43 (protocol ≥48 정합) — 🟢 SUPPORTED-NUMERICAL** (C12) | LPA V4 §45 |
| **D** | MR/IVW β (Lp(a)→CHD 인과) | **β_IVW = -0.3413 (Burgess -0.34249, Δ=0.0012) — 🟢 SUPPORTED-NUMERICAL** | LPA V3b · V4 §70 |
| **D** | NHIS ICER WTP pass rate | **0% (₩25M·₩30M 양 threshold, 387-645× 약가 격차) — 🟢** | LPA V3c · V4 |

→ **g5 종합**: power (A primary 0.80 · D Schoenfeld 842/844) · genotype freq (B PM 0.1521) · 인과 추정 (D β_IVW) 는 simulation verdict 보유 → verbatim. 효과크기 가설 (A CMR -15% · B 1y MACE Δ · C LLL · D HR 0.80) 자체와 추정 n 은 **설계 가정 (⚪ proposal)** — wet-lab/RCT readout 후 🟢 상향 가능 (d1 non-wet-lab 완결, wet-lab downstream).

---

## §7. X5 산출 요약

- **4 trial portfolio**: A. NICORADENO-MVO (NOREFLOW) · B. DAPT-PGx-K (DAPTPGX) · C. ROCK-DCB IIT-1 / ISR-non-mTOR (ISR) · D. K-LpA-OUTCOMES / LPA-siRNA-K (LPA).
- **공유 인프라 시너지**: (1) 카테터 국소전달 PK+carrier core lab = A·C 공용 (NOREFLOW M4 IC delivery ↔ ISR M5 DCB), (2) 비-IND 분자전달 pilot = B(NMN)·D(siRNA) 공용, (3) imaging consortium (CMR+OCT) + 3-axis PCR lab + KAMIR backbone = 4-trial single-build unlock.
- **3-axis stratification**: ALDH2\*2 (~40%, Trial-A primary) × CYP2C19 LoF (~40% allele, Trial-B primary) × Lp(a) high/KIV-2 (~12-13%, Trial-D primary) — 동아시아/한국 특이 3축이 trial 별 PRIMARY + cross-cut modifier 로 매핑.
- **timeline**: 즉시 = B (PCR 급여 + 약제 재배치) · 6m = A enroll + C pre-IND · 3y = D (HORIZON readout + siRNA 승인 + RSA).
- **규제/급여**: 기존 NHIS 안 = CYP2C19 PCR · nicorandil · adenosine IC · PCSK9 (B 즉시 · A 약물). 신규 승인 = fasudil-DCB (PMDA cross-recog 돌파) · siRNA (RSA+narrow+bridge 돌파).
- **g5**: power (A 0.798 · D 842/844) · genotype freq (B 0.1521) · MR β (D -0.3413) = sub-V verify 🟢 verbatim. ICER (B V5 -503) = 🟠 DEFERRED. 추정 n · 효과크기 가설 · 시너지 = ⚪ proposal (설계 가정).

### 가장 강한 한국 leverage

**ALDH2\*2 stratified IRI 보호 trial (Trial-A 의 ALDH2\*2 axis)** — East Asian ~40% 가 ALDH2\*2 보유 → NO bioavailability ↓ → STEMI IRI 악화. ALDH2 genotype 으로 층화한 no-reflow/MVO 보호 RCT 는 **글로벌 부재 (한국 first-in-class 기회)**. nicorandil 이 한국 보험 등재 (글로벌 우위) 라 추가 cost 0 으로 ALDH2\*2 군에서 alternative NO donor 전략을 즉시 검증 가능. (단, ALDH2\*2 subgroup power 는 0.654 — exploratory only, 🟠.)

### 즉시 시작 가능한 trial (규제 장벽 최저)

**B. DAPT-PGx-K** — CYP2C19 PCR 이 이미 선별급여 (C5946) 이고 clopidogrel/prasugrel/ticagrelor 모두 기존 급여 약제라 **신규 IND·신규 약물 승인이 전혀 불요**. S4 targeted 결정맵 = 약제 재배치 + registry-embedded 로 다음 PCI 환자부터 즉시 적용 가능. 유일한 잔여 작업은 NHIS ICER sensitivity (V5 -503 sign 미반전, V6 patch 후속).
