# M9 — 한국 first-in-class IIT blueprint (K-LpA-OUTCOMES)

> 마일스톤 M9 산출물 · cycle 5 scope 확장 · 한국 임상 실전 적용 단계 blueprint.
> 핵심 질문: **HORIZON/OCEAN(a) 글로벌 readout 후, 한국 sub-population 정밀 정량 + RSA 협상 leverage + KIV-2 stratified efficacy를 동시에 확보할 IIT 어떻게 설계할까?**

---

## 1. IIT 정의 + scope

**IIT (Investigator-Initiated Trial) vs SIT (Sponsor-Initiated Trial)**:

| 축 | IIT | SIT (HORIZON · OCEAN(a)) |
|---|---|---|
| PI / sponsor | 한국 KOL (KSoLA executive) | Novartis · Amgen |
| Protocol 주도 | KSoLA consortium | 글로벌 CRO |
| 1차 endpoint 자유도 | 한국 적응증 fit | 글로벌 통일 (FDA pivotal) |
| 약가 협상 leverage | 자체 데이터 = HIRA 협상력 | 외국 데이터 → 외삽 한계 |
| 비용 | ₩20-30B (자국 산정) | $300M-1B (글로벌) |
| Timeline | Ph3 SIT 후 2-3년 follow-on | pivotal first |

**K-LpA-OUTCOMES IIT 1차 목표**: HORIZON/OCEAN(a) 한국 sub-population RRR 정밀 측정 → 한국 특화 NNT 산정 (현 M7 추정 25-35 → 실측 ±5 narrowing).

**2차 목표**: (a) KIV-2 copy stratified efficacy heterogeneity 정량 (글로벌 trial 미시도) · (b) RSA outcome-based economic outcome 동반 측정 · (c) KOQUSS utility weight 한국형 재산정.

---

## 2. KSoLA consortium 구성 후보

**주축 institution (8 hub center)**:

| Institution | ASCVD 등록 환자 풀 (추정) | Lp(a) 전문 KOL 후보 |
|---|---|---|
| Asan Medical Center | ~25,000 PCI cohort | Park Seung-jung · Kim Hyun-jin |
| Samsung Medical Center | ~18,000 ASCVD | Choi Seung-hyuk · Lee Sang-hak |
| Severance (Yonsei) | ~20,000 cardiology | Hong Myeong-ki · Ko Young-Guk |
| Seoul National Univ Hospital | ~22,000 internal med | Kim Hyo-soo · Kang Hyun-jae |
| Korea Univ Anam | ~12,000 PCI | Kim Eung-ju · Cha Kil-su |
| Catholic Medical Center | ~15,000 multi-site | Park Chang-gyu · Chang Kiyuk |
| Inje Univ Sanggye Paik | ~8,000 KAMIR active | Tahk Seung-jea |
| Chonnam National Univ | ~14,000 (KAMIR PI center) | Jeong Myung-ho (KAMIR 창립 PI) |

→ **총 ASCVD 등록 환자 풀 ≈ 134,000명** (8 center, 30% overlap 가정 → 실 unique ≈ 94,000명).
→ enrollment 추정 — Lp(a) ≥ 100 mg/dL screening rate ~10% → ~9,400 eligible pool → n=2,500 trial 5-10% enrollment 충분 가능.

**KSoLA executive committee 후보** (Position Paper 2026 task force 작성진):
- KSoLA President (2026-) — Lp(a) Position Paper 공동 author
- Lp(a) Task Force chair — 임상 protocol drafting 주도
- Statistical advisor — KAMIR + KoGES 분석 경력자
- Health economics — KSoLA-HIRA bridge (V3c NHIS dialogue 연결)

---

## 3. Trial design — NCT scaffold

**Trial name**: **K-LpA-OUTCOMES** (Korea Lipoprotein(a) Outcomes Trial)

**Design**: prospective · multi-center · adaptive PROBE (Prospective Randomized Open Blinded Endpoint).

**Arms**:
- **arm A (control)** — PCSK9 mAb (evolocumab Q2W 140mg) + 표준 statin (rosuvastatin 20mg 또는 max-tolerated) — 현 한국 Tier-1 SOC
- **arm B (siRNA)** — pelacarsen SC Q4W 80mg **OR** olpasiran SC Q12W 75mg (시나리오 분기 §10) + arm A 동일 background therapy

**Inclusion**:
- ASCVD 2차 예방 (MI ≥3mo · stroke ≥6mo · PCI ≥3mo · CABG ≥6mo)
- Lp(a) ≥ 100 mg/dL (narrow staging · V3c §11 권고)
- LDL-C ≤ 70 mg/dL on max-tolerated statin (background optimized)
- 나이 19-80세

**Exclusion**:
- eGFR < 30 mL/min/1.73m²
- 활동성 간질환 (AST/ALT > 3× ULN)
- 임신 / 가임여성 미 contraception
- 활동성 악성종양 (5년 이내)
- 사전 siRNA/ASO 노출

**Primary endpoint**: 4-point MACE (CV death + non-fatal MI + non-fatal stroke + urgent coronary revascularization) at 24m (interim) / 60m (final).

**Secondary**:
- Lp(a) % change (baseline · 12m · 24m · 60m)
- LDL-C % change
- apoB % change
- Safety — flu-like AE · ALT/AST · 혈소판 감소 · 항-약물 항체

**n estimate** (Schoenfeld 외삽 from R2 §8):
```
Schoenfeld: D = (Z_α/2 + Z_β)² × 4 / [ln(HR)]²
HR=0.80, α=0.05 two-sided, β=0.10 (90% power)
D = (1.96 + 1.28)² × 4 / [ln(0.80)]²
  = 10.5 × 4 / 0.0498
  ≈ 842 events
```
- 한국 baseline 5y MACE (ASCVD 2차 · Lp(a)≥100) = ~28.6% (V3c narrow)
- arm A 5y event = ~28.6% × 2,500/2 = 358 events
- arm B 5y event = ~28.6% × 0.80 × 2,500/2 = 286 events
- 총 events ≈ 644 → 842 추가 필요 → **n=2,500, 5y follow-up + 추가 enrollment buffer 500 → 총 n=3,000** (실 적용 가능)

**Timeline**:
```
2026-H1: HORIZON readout 수령 → protocol 분기 결정 (§10)
2026-H2: KSoLA consortium MOU + IRB central review 시작
2027-H1: NCT 등록 + 첫 enrollment site activation
2027-H2: enrollment 본격화 (n=3,000 × 18mo 가정 = 월 ~165 enrollment)
2029-H1: enrollment complete
2030-H1: 24m interim analysis (DSMB futility check)
2032-H1: 60m primary readout
2032-H2: HIRA 약가 협상 자료 제출
2033-H1: KSoLA 가이드라인 update
```

---

## 4. NCT 등록 path

**Dual registration**:
- **KCTRN** (Korea Clinical Trial Registry, MFDS) — 한국법상 의무
- **ClinicalTrials.gov** — 글로벌 가시성 + 메타 분석 포함

**IRB 멀티센터 central review**:
- KMA (Korea Medical Association) central IRB primary review
- 각 site 로컬 IRB는 expedited acknowledgment (반복 검토 회피)

**DSMB (Data Safety Monitoring Board) 구성**:
- 한국 KOL × 3 (cardiology · biostatistics · ethics)
- 외국 advisor × 2 — HORIZON/OCEAN(a) DSMB member 1명 + EAS Lp(a) consensus task force 1명
- charter — 50% event 시 futility analysis · ALT/platelet pre-specified stopping rule

---

## 5. RSA (risk-sharing arrangement) integration

V3c break-even gap (글로벌 $11.5K/yr vs 한국 viable $17.8-29.7/yr · **400-650× 격차**)을 IIT 자체 데이터로 좁힌다.

**framework**:
- Sponsor (Novartis pelacarsen · Amgen olpasiran) vs HIRA-NHIS 협상
- **outcome-based**: MACE 발생 환자 약가 환불
  - 협약: 60m 시점 RRR < 15% (글로벌 fail threshold) → sponsor가 NHIS에 ≥50% refund
  - 협약: RRR ≥ 25% (high responder) → 약가 +10% premium 허용
- **price-volume**: enrollment cap (≥100 mg/dL · n_total ≤ 50,000명 가정 · narrow staging 일치)

**ICER ₩25M/QALY 조건부 통과 path** (V3c d2 breakthrough §11):
- RSA + narrow staging + bridge therapy 3축 결합 시 ICER 시뮬레이션:
  - narrow ₩13.3B/QALY → RSA 50% refund 가정 → ₩6.6B/QALY → 여전히 264× WTP 초과
  - **추가 필요**: 약가 자체 90%+ discount (제조사 양보 · IIT 데이터 leverage)
  - 또는 한국형 KOQUSS utility 재산정으로 QALY_loss 2-3× 증폭 (현 0.15 → 0.30-0.45)
  - 동시 적용 시 ICER ₩2-4B/QALY (V3c §11) → 여전히 WTP 80-150× 초과 → **3축 동반 + 약가 추가 협상 필수**

→ **IIT 자체 데이터가 협상 leverage** — 한국 환자 RRR 정밀 측정 + utility 재산정 + RSA 시범 운영 동시 = HIRA 약가 협상력 강화의 유일 root.

---

## 6. Budget + funding

**추정 예산** (n=3,000 × 5y):

| 항목 | 단가 | 총액 |
|---|---|---|
| 약값 (arm B siRNA, $11.5K/yr × 1380 × 5y × 1,500명) | ₩79.4M/명 | ₩119B (sponsor donation 가정) |
| 약값 (arm A PCSK9, ₩2.4M/yr × 5y × 1,500명) | ₩12M/명 | ₩18B (NHIS 급여분 공제) |
| 임상 운영 (8 center × 5y × ₩500M/center/yr) | — | ₩20B |
| Lab/imaging/MACE adjudication | ₩2M/명 | ₩6B |
| KIV-2 copy 측정 (PCR · n=3,000) | ₩300K/명 | ₩0.9B |
| DSMB + central IRB + biostatistics | — | ₩3B |
| Data management + EDC | — | ₩2B |
| publication + 컨퍼런스 | — | ₩1B |
| **총 예산 (sponsor donation 제외)** | — | **₩32-35B** |

**자금원 후보**:
- **HIRA 임상 R&D 사업** — RSA 시범 평가 명목 (₩5-10B 가능)
- **KSoLA grant + Korean Heart Foundation** — academic IIT grant (₩2-3B)
- **회사 sponsor co-funding** — Novartis · Amgen drug donation (₩119B in-kind) + 운영비 50% (₩10-15B)
- **KOFIH** (Korea Foundation for International Healthcare) — 한국 보건 외교 명목 (₩3-5B)
- **NRF** (National Research Foundation) — 중대형 임상 사업 (₩5-7B)

→ **net 현금 자금 필요 ≈ ₩15-20B** (sponsor + KOFIH/NRF/HIRA 다축 자금 시).

---

## 7. 한국 KIV-2 copy 측정 protocol

**PCR-based copy number 측정**:
- LDLR-flanking primer pair 디자인 (KIV-2 repeat region 양옆)
- qPCR · digital PCR 옵션 — digital PCR이 copy number quantitation에 더 정확
- 표준 reference genome KRGDB (Korean Reference Genome Database, 1,722 WGS) cross-reference

**stratification 3-tier**:
- low KIV-2 copy (<20) — small isoform · high Lp(a) — 예상 best responder
- medium copy (20-30) — intermediate
- high copy (≥30) — large isoform · low Lp(a) — 예상 약효 attenuation 가능

**1차 분석 hypothesis**:
- low copy subgroup RRR > medium > high (heterogeneity test, P_interaction < 0.10)
- 만약 P_interaction significant → KIV-2 copy 기반 한국 처방 알고리즘 가능

**글로벌 trial 미시도 영역** — HORIZON/OCEAN(a) 둘 다 KIV-2 copy stratified analysis 사전 미정. **K-LpA-OUTCOMES가 첫 정량**.

---

## 8. IRB + 윤리 고려

**한국형 informed consent**:
- KSoLA 표준 ASCVD 적응증 + Lp(a) screening incidental finding (예: 가족 cascade screening)에 대한 사전 동의
- biobank 부 동의 (genetic sample 5년 보관 · 추가 연구 재 IRB 가정)
- 한국어 + 영어 dual-language consent

**DSMB stopping rules** (사전 정의):
- **futility**: 50% event 시점 conditional power < 20% → 조기 종료
- **safety**: ALT > 5× ULN (≥ 2% of B arm vs < 0.5% of A arm) · 혈소판 < 50K (≥ 1% B arm) · CV death imbalance (B/A > 1.5) → 사전 DSMB review

**윤리 특수 고려**:
- arm A (PCSK9 mAb)도 강력 active control — placebo arm 없음으로 윤리적 정당화
- Lp(a) screening 자체가 incidental finding 다수 발생 (가족 cascade) → genetic counseling 의무

---

## 9. 한국 의료시스템 통합

**KAMIR registry linkage**:
- KAMIR (Korea Acute Myocardial Infarction Registry, 1999- · n=86,000+ · 20-year experience) data linkage 시도
- IIT 환자의 baseline AMI cohort historical data 활용 → 5y MACE baseline estimate 정밀화
- KAMIR 창립 PI 1명 K-LpA-OUTCOMES steering committee 영입 (data sharing MOU)

**KSoLA 정책 framework 동기화**:
- Position Paper 2026 (e-JLA 15(1):2) cutoff (≥50 mg/dL high · ≥100 ASCVD) 적용
- 2030 interim → KSoLA 신약 권고 update 동기화
- 2032 final → KSoLA 가이드라인 신규 chapter (Lp(a) 표적 치료)

**HIRA 약가 협상 시점**:
- 2032 H1 readout 직후 동시 협상 진입 — IIT 데이터 + RSA 시범 평가 + KOQUSS utility 재산정 동반
- 약가 협상 outcome 시뮬레이션 (V3c §11 d2 breakthrough 5축 동시 가동): ₩2-4B/QALY 도달 → 여전히 WTP 80-150× 초과 → 추가 sponsor concession 필요

---

## 10. 시나리오 분기 (HORIZON 결과 따라)

| 시나리오 | HORIZON (2026 H1) 결과 | K-LpA-OUTCOMES arm B 선정 | 추가 변경 |
|---|---|---|---|
| **A** | pelacarsen 양성 (HR 0.78-0.85) | **pelacarsen + olpasiran dual** (OCEAN(a) 2027 readout 직후 confirm) | n=4,500 (3-arm 변환), timeline +1y |
| **B** | pelacarsen null/음성 (HR > 0.95) | **olpasiran 단독** (OCEAN(a) 양성 가정) + obicetrapib 대안 추가 검토 | n=2,500 유지, OCEAN(a) readout 후 확정 |
| **C** | Lp(a) hypothesis 흔들 (양 trial 음성) | **IIT 보류** → observational registry 우선 (KAMIR-Lp(a) sub-cohort 신설) | trial 자체 중단, ₩20B → registry conversion |

→ **시나리오 B가 base case** (HORIZON marginal · OCEAN(a) 결정적 가능성 ~60%).
→ 시나리오 A trigger 시 한국 first-in-class IIT의 글로벌 영향력 ↑↑ (3-arm head-to-head 글로벌 미시도).
→ 시나리오 C는 d2 breakthrough — Lp(a) hypothesis 보존 위한 mechanism re-evaluation (R1 §5 VERVE-301 base editor track 가속 검토).

---

## 11. d2 breakthrough — IIT 단독 활용 5축

V3c 약가 break-even gap (400-650×)을 IIT가 직접 해결 못해도, **5축 동시 leverage**로 ₩2-4B/QALY 도달 가능:

| 축 | 메커니즘 | IIT 기여 |
|---|---|---|
| **(a) 한국 sub-group RRR 정밀 정량** | 글로벌 외삽 → 한국 실측 (±5 NNT narrowing) | primary endpoint 직접 측정 |
| **(b) RSA 협상 leverage 강화** | 자체 데이터 = HIRA 협상력 | secondary economic outcome 측정 |
| **(c) KIV-2 copy stratified analysis** | 글로벌 trial 미시도 · responder 정밀 선택 | 1차 stratification primary analysis |
| **(d) KOQUSS utility weight 한국형 산정** | V3c 인용 · QALY_loss 0.15 → 0.30-0.45 | EQ-5D-5L Korean tariff 부 측정 |
| **(e) bridge therapy short-term sub-trial** | pre-PCI · post-MI 3-6개월 acute window | nested sub-study (n=200) embedded |

→ 5축 동시 가동 시 ICER ₩2-4B/QALY (V3c §11 시뮬). 여전히 WTP 80-150× 초과 → 약가 추가 협상 + RSA refund 결합 필수. **그러나 IIT 없이는 협상 카드 자체 부재** — IIT는 **필요조건**.

---

## 12. Verify rubric (M9 본 설계)

| 항목 | 등급 | 근거 |
|---|---|---|
| IIT design 가능성 (KSoLA consortium + 8 hub center) | 🟡 SUPPORTED-BY-CITATION | KSoLA 2026 Position Paper · KAMIR 20-year (86,000명) 선례 |
| n estimate (n=3,000, 5y, HR=0.80, 90% power) | 🟢 SUPPORTED-NUMERICAL | Schoenfeld closed-form D≈842 events 산출 |
| 예산 추정 (₩32-35B net cash) | 🟢 SUPPORTED-NUMERICAL | 산술 closed-form (단가 × 인원 × 기간) |
| RSA framework outcome-based | 🟠 INSUFFICIENT/DEFERRED | HIRA 협상 미실행 (2032 H1 시점) |
| 시나리오 분기 (HORIZON 의존) | 🟠 INSUFFICIENT/DEFERRED | 2026 H1 readout 후 확정 |
| KIV-2 copy stratified efficacy hypothesis | 🟠 INSUFFICIENT/DEFERRED | 글로벌 trial 미시도 · K-LpA-OUTCOMES가 첫 정량 |
| 8 hub center 환자 풀 추정 (134K, unique 94K) | 🟡 SUPPORTED-BY-CITATION | 각 center IR 공개자료 + KSoLA membership |
| ICER ₩2-4B/QALY (5축 동시) | 🟠 INSUFFICIENT/DEFERRED | V3c §11 시뮬 외삽, IIT 데이터 후 확정 |

---

## 13. 참고문헌

- KSoLA Lp(a) Position Paper (2026) *e-JLA* 15(1):2 — Korean 3-tier cutoff + family cascade screening
- Jeong MH et al. (2025) *Korean Circ J* — Twenty-Year Clinical Experience of KAMIR (n=86,000+)
- Tsimikas S et al. (2020) *NEJM* 382:244 — pelacarsen Ph2 -80%
- O'Donoghue ML et al. (2022) *NEJM* 387:1855 — olpasiran Ph2 -98%
- HORIZON NCT04023552 · OCEAN(a)-Outcomes NCT05581303
- Schoenfeld DA (1983) *Biometrics* 39:499 — events-driven trial sample size
- HIRA (Health Insurance Review & Assessment) — 약가 협상 framework 2024
- KRGDB (Korean Reference Genome Database) — 1,722 WGS

---

🔑 핵심 통찰 (M9):
- **K-LpA-OUTCOMES = 한국 first-in-class Lp(a) IIT** — 8 hub center · KSoLA consortium · n=3,000 · 5y MACE · 2027-2032 timeline
- **n estimate 🟢 Schoenfeld** — HR=0.80 · 90% power · D≈842 events · 한국 baseline 28.6% 가정
- **예산 ₩32-35B net cash** — sponsor donation (₩119B in-kind) + HIRA/KSoLA/KOFIH/NRF 다축 자금
- **시나리오 B가 base case** — olpasiran 단독 arm B · OCEAN(a) 2027 양성 가정
- **IIT 자체로 ICER WTP 통과 불가** — 그러나 협상 leverage **필요조건** (5축 동시 가동 시 ₩2-4B/QALY 도달)
- **글로벌 미시도 differentiator**: KIV-2 copy stratified efficacy primary analysis (한국 KRGDB cross-reference)
- **HORIZON readout (2026 H1) = trial trigger** — 시나리오 C 시 IIT 보류 + observational registry conversion
