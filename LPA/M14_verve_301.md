# M14 — VERVE-301 LPA base editor 심화 (Verve/Lilly)

> 마일스톤 M14 산출물 · current-state · no history.
> R1 §5 발견 (VERVE-301 dev candidate Q1 2025) → Tier-5 moonshot 후보를 정식 doc 으로 승격.
> 출처 = Verve IR 2025-01-13 · Lilly acquisition 2025-06-17 · VERVE-101 heart-1 DSMB 2024-04-02 → 🟡 SUPPORTED-BY-CITATION (dev candidate) · 🟠 INSUFFICIENT/DEFERRED (Ph1 timeline · 한국 약가).

---

## 1. Verve Therapeutics 플랫폼 개요

Verve = in vivo gene editing (간 hepatocyte 특화) cardiovascular biotech. 2018 founded · 2025-07 Lilly acquisition ($1.3B 최대 · upfront $10.50/주 + CVR $3.00/주).

**핵심 플랫폼 3 축**:
- (a) **adenine base editor (ABE)** — Cas9 nickase + adenosine deaminase fusion · A·T → G·C 단일 염기 교정 (double-strand break 없음 → off-target 위험 ↓ vs 1세대 CRISPR)
- (b) **LNP delivery** — lipid nanoparticle · IV infusion 1회 → 간 hepatocyte 흡수
- (c) **GalNAc-LNP** (VERVE-301 신규) — GalNAc 컨쥬게이션 + LNP 융합 → ASGPR 매개 hepatocyte 정밀 표적 (M4 siRNA 와 같은 GalNAc 원리)

```
   IV infusion (1회)
        │
        ▼
   LNP / GalNAc-LNP (간 hepatocyte 표적)
        │
        ▼
   mRNA → ABE + gRNA 발현 (transient)
        │
        ▼
   DNA 표적 염기 교정 (영구) → premature stop codon / splice 차단
        │
        ▼
   apo(a) 합성 영구 침묵 (lifelong)
```

**파이프라인 4 분자** (2026 시점):
- **VERVE-101** (PCSK9 ABE · 1세대 LNP) → 2024-04 DSMB pause → 2024 중반 deprioritize
- **VERVE-102** (PCSK9 ABE · 2세대 LNP) → Heart-2 Ph1b 진행 · 2025-04 FDA Fast Track (HeFH + premature CAD)
- **VERVE-201** (ANGPTL3 · GalNAc-LNP) → Ph1b 진행
- **VERVE-301** (LPA · GalNAc-LNP) → **dev candidate Q1 2025** · 전임상 진행

---

## 2. VERVE-301 specifics

- **표적**: LPA gene exon (premature stop codon 도입 또는 splice site disruption 추정 — Verve 공식 mech 미공시)
- **delivery**: **GalNAc-LNP** (Verve 자체 cargo · M4 siRNA 와 동일한 ASGPR ligand 원리)
- **편집 기전**: ABE (adenine base editor) — DSB 없음 · off-target 위험 ↓
- **투여**: **IV infusion 1회** → 평생 효과 (이론)
- **dev candidate 선언**: 2025년 1분기 (Verve IR · Lilly milestone payment 수령)
- **현재 상태** (2026-05): **여전히 전임상** — Ph1 IND 미제출
- **예상 Ph1 enrollment**: 2026-27 (Lilly acquisition 후 일정 미공식화 · 🟠 추정)
- **Ph1 readout**: 2028+ (🟠 추정 · 24-36개월 follow-up 필요)
- **적응증 추정**: severe Lp(a) ≥ 180 mg/dL ASCVD 환자 (M1 ~52만 명 한국 inclusive)
- **Lilly 통합**: 2025-07 acquisition 완료 → Lilly cardiometabolic franchise (tirzepatide · lepodisiran) 합류

---

## 3. LPA gene editing vs siRNA (M4) — modality 비교

| 축 | siRNA (lepodisiran 등 M4) | gene editing (VERVE-301) |
|---|---|---|
| **표적 layer** | mRNA (post-transcriptional) | DNA (germline-equivalent · permanent) |
| **투여 빈도** | SC Q12-48W (분기-반기 1회) | **IV 1회** (lifetime) |
| **회수 가능성** | 가능 (3-12개월 washout) | **불가능** (DNA 영구) |
| **누적 비용** | 평생 ~30년 × $8-15K = $240-450K | one-time $1M+ (추정 · Spinraza/Zolgensma analog) |
| **adherence** | 분기 방문 필요 | one-shot ↓ |
| **off-target 위험** | mRNA seed match 만 | DNA editing — **염색체 영구** |
| **임신 / 가임 여성** | washout 후 재고려 | 평생 영향 (germline 영향 부재 가정 시에도 lifelong 표현형) |
| **Lp(a) ↓ (추정)** | -90 ~ -98% (M4 입증) | **-90%+ (예상 · 아직 임상 zero)** |

→ **trade-off 핵심**: gene editing = **adherence + 누적비용 우위** · siRNA = **회수가능성 + 임상 데이터 5-10년 선행 우위**.

---

## 4. 안전성 — VERVE-101 heart-1 학습

### 4.1 heart-1 trial AE (2024-04-02 DSMB pause)

VERVE-101 (PCSK9 ABE · 1세대 LNP) Heart-1 Ph1b — 0.45 mg/kg 코호트 6번째 피험자에서:
- **Grade 3 ALT 증가** (transient, drug-induced)
- **Grade 3 thrombocytopenia** (serious AE · 4일 이내)
- 출혈 / 임상 증상 없음 · 수일 내 fully resolved
- DSMB 권고로 enrollment pause → 2024 중반 Verve VERVE-101 deprioritize · VERVE-102 (2세대 LNP) 우선화

### 4.2 LPA editing off-target hot-zone

LPA 유전자 = **PLG (plasminogen) homolog** — kringle 도메인 9중복 (apo(a) KIV-2 = plasminogen kringle IV duplicates) → guide RNA sequence overlap 위험.
- **off-target #1**: PLG (plasminogen) — fibrinolysis 핵심 · 침묵 시 출혈/혈전 균형 붕괴
- **off-target #2**: 이미 VERVE-102 (PCSK9) 받은 환자 → 두 부위 동시 편집 누적 위험
- **off-target #3**: 일반 hepatocyte gene set (cytochrome P450 등) — LNP 비특이 흡수

→ **mitigation**: GalNAc-LNP 정밀화 + ABE (DSB 회피) + 사전 in-silico off-target 스크리닝 (CIRCLE-seq · GUIDE-seq) 표준.

### 4.3 M6 Mendelian null carrier 안전 보증 적용

- **KIV-2 high copy lifelong null carrier ~10% 인구** (M6 §2) = Lp(a) <1 mg/dL 평생 + CV 보호 + 부정 표현형 없음
- → **target safety (축 A) = 강한 Mendelian 보증** · gene editing 으로 Lp(a) null 도달해도 lifelong null carrier 와 동등 표현형
- 우려는 **축 B (platform)** = LNP 급성 toxicity (thrombocytopenia · ALT) + off-target editing

---

## 5. 한국 적용 (먼 timeline · 2030+)

### 5.1 한국 정책 사전 단계

- **KSoLA 2026 Position Paper** (R2 §2) — PR ≥50 mg/dL cutoff + 모든 성인 1회 측정 → 위험군 식별만 확립
- 신약 권고는 **HORIZON 2026 H1 + OCEAN(a) 2027 readout 후** update 예상 → siRNA/ASO 우선
- VERVE-301 등 gene editing 권고는 **2030+ moonshot** (Lp(a) outcome 입증 후속)

### 5.2 한국 첫 gene therapy 시판 경험

- **Spinraza (nusinersen · SMA ASO)** — 2019 시판 · NHIS 급여 (이용 환자 제한)
- **Zolgensma (onasemnogene · SMA AAV)** — 2022 시판 · 약가 ₩20억/회 · NHIS 위험분담 (RSA) 적용
- **Casgevy (sickle cell CRISPR)** — 2024-12 美 FDA · 한국 미허가 (시장 부재)
- → 한국 gene therapy 인프라 = Spinraza ZMUC (Zolgensma Managed Use Contract) 운영 경험 (RSA · 환자 selection · 장기 추적) 활용 가능

### 5.3 한국 NHIS 약가 모형 부재

- gene editing **평생 1회 IV** = NHIS 표준 WTP ₩25-30M/QALY (V3c) 모형 자체 부재
- one-time $1M+ → 분할 지급 / RSA / outcome-based pricing 필요
- 한국 NHIS gene therapy 운영 사례 = Zolgensma RSA (제한적 환자 · 다년 분할)
- VERVE-301 한국 시판 시점 = **2030+** (Ph1 2026-27 · Ph2 2028-29 · Ph3 2030-32 · 한국 허가 2033+) — 🟠 INSUFFICIENT

---

## 6. vs muvalaplin (oral SM) — modality 격자

> M13 muvalaplin (oral SM, KRAKEN Ph2 -85.8%) doc 아직 부재 — R1 §1.5 row 23 + Nicholls 2025 NEJM 기준 비교.

| 축 | muvalaplin (oral SM) | VERVE-301 (gene editor) |
|---|---|---|
| **작용 시점** | pre-secretory (apo(a)-apoB Lys-Asn-Glu 결합 방해) | DNA 영구 편집 (germline-equivalent) |
| **투여** | daily oral | **1회 IV** |
| **회수** | 가능 (1-2일 stop) | **불가능** |
| **Lp(a) ↓** | -85.8% intact (KRAKEN Ph2) | -90%+ (추정 · 임상 zero) |
| **약가** | ~$2-4K/yr (oral SM 추정) | **$1M+ one-time** (추정) |
| **adherence** | daily 의존 | one-shot |
| **한국 timeline** | 2028+ (Ph3 readout 후) | **2030+ moonshot** |

→ **muvalaplin = adherence 의존 · 회수 가능 · 저비용** · **VERVE-301 = one-shot · 불가역 · 고비용** = 환자 가치 함수에서 정반대 극단.

---

## 7. cycle 5+ 한국 IIT 통합 시나리오

- **K-LpA-OUTCOMES** (M9 후보) — 2032 readout 후 확장 가능 시:
  - 신규 arm = **gene editing arm** (VERVE-301 + 한국 ZMUC 운영 경험)
  - 비교 arm = siRNA (lepodisiran 또는 olpasiran) · oral SM (muvalaplin)
- **한국 gene therapy 인프라**:
  - Spinraza ZMUC 운영 경험 (서울아산 · 삼성서울 · 세브란스) → VERVE-301 deliv center 후보
  - KSoLA + **KSGCT (Korean Society of Gene & Cell Therapy)** 공동 협력 candidate
- **한국 first-in-class gene therapy** 후보 = Spinraza (SMA) · Zolgensma (SMA) · ?Casgevy → **VERVE-301 = 4번째 시판 시 ASCVD 분야 1st** (2033+)

---

## 8. verify rubric

| 항목 | 등급 | 근거 |
|---|---|---|
| Verve IR (dev candidate Q1 2025) | 🟡 SUPPORTED-BY-CITATION | Verve 2025-01-13 IR + Lilly milestone payment Q1 2025 |
| Lilly acquisition $1.3B (2025-07) | 🟡 SUPPORTED-BY-CITATION | Lilly investor 2025-06-17 · BioPharma Dive |
| GalNAc-LNP delivery | 🟡 SUPPORTED-BY-CITATION | Verve pipeline slide (공식 mech 부분 공개) |
| Ph1 timeline (2026-27 enroll) | 🟠 INSUFFICIENT/DEFERRED | Lilly 통합 후 공식 일정 미공시 · 전임상 진행 |
| off-target PLG homolog 위험 | 🟡 SUPPORTED-BY-CITATION | LPA-PLG kringle homology = 정설 (M1 §2) |
| VERVE-101 heart-1 thrombocytopenia | 🟡 SUPPORTED-BY-CITATION | Verve 2024-04-02 PR · 6th 피험자 0.45 mg/kg |
| Mendelian null safety 외삽 (target axis) | 🟡 SUPPORTED-BY-CITATION | M6 §2 Kronenberg 2022 |
| 한국 NHIS gene therapy 약가 모형 | 🟠 INSUFFICIENT/DEFERRED | Spinraza/Zolgensma 사례만 · Lp(a) gene editing precedent 부재 |
| Lp(a) ↓ -90%+ (VERVE-301 예상) | ⚪ SPECULATION-FENCED | 임상 데이터 zero · 전임상 추정만 |

---

## 9. M8 ranking 갱신 시그널

- **현재 ranking** = **Tier-5 moonshot 유지** (timeline 2030+ · 임상 zero)
- **Tier-4 진입 조건** (시나리오 분기):
  - (a) VERVE-101/102 Heart-1/2 Ph1 safety 클리어 → ABE 플랫폼 안전성 검증 (2026-27)
  - (b) VERVE-301 Ph1 IND 제출 (2026-27 예상)
  - (c) K-LpA-OUTCOMES (M9) 2032 readout → Lp(a) ↓ MACE 인과 RCT 입증 후 gene editing arm 추가 정당화
- **Tier-3 진입 조건** = VERVE-301 Ph1 first-in-human dose 도달 (2027+) — **현 시점 4-5년 거리**
- **한국 first-in-class gene therapy for ASCVD** 후보 = 2033+ 시판 시 (Spinraza/Zolgensma 후 4번째 · 첫 cardiovascular)

---

## 10. 참고문헌 / 출처

- **Verve Therapeutics 2025-01-13** — *Pipeline Progress and Anticipated 2025 Milestones* (VERVE-301 dev candidate 선언)
- **Verve Therapeutics 2025-05-14** — *Q1 2025 Financial Results* (Lilly milestone payment 명시)
- **Lilly investor 2025-06-17 / 2025-07** — *Lilly to acquire Verve Therapeutics* ($1.3B 최대)
- **Verve Therapeutics 2024-04-02** — *Updates on PCSK9 Program* (Heart-1 DSMB pause · VERVE-101 thrombocytopenia + ALT)
- **Tandfonline 2024** — *VERVE-101 base-editing therapy* (mech 리뷰)
- M1 §2 / M4 §1 / M6 §2 — KIV-2 PLG homolog · GalNAc-ASGPR 간 표적 · null carrier Mendelian 안전 외삽

---

🔑 핵심 통찰 (M14):
- **VERVE-301 = LPA base editor 정식 pipeline 진입** — Verve IR 2025-01 dev candidate · Lilly acquisition 2025-07 ($1.3B) = 단순 시지대 → 실제 자본 투입
- **Ph1 timeline 2026-27 enroll · 2028+ readout** = 한국 시판 **2033+** (M9 K-LpA-OUTCOMES 2032 readout 동행 가능)
- **회수 불가능성 = siRNA 와 결정적 차이** — idiosyncratic AE 발생 시 DNA 영구 변경 reversal 부재 → VERVE-101 heart-1 thrombocytopenia 학습 결정적
- **off-target PLG (plasminogen) homolog** = LPA editing 의 고유 위험 영역 (apo(a) KIV-2 = plasminogen kringle IV 9중복)
- **한국 NHIS gene editing 약가 모형 부재** — Spinraza/Zolgensma RSA 경험 활용 + Lp(a) outcome 입증 (2027+) 후 단계 진입
- **M8 ranking = Tier-5 moonshot 유지** — Ph1 first-in-human 도달 시 Tier-4 → 2032 K-LpA-OUTCOMES readout 후 Tier-3 진입 시나리오
