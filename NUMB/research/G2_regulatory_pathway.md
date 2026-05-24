# NUMB G2 — regulatory pathway 매트릭스 (US/EU/KR · 농도별 결정 트리)

> 🧊 **NUMB milestone G2** — hexa-LAC v1 (lid 7% + tet 7% + LA 5% + EtOH 20% + epi 1:200k + HPC peel-film) 듀얼 SKU (OTC 저농도 ↔ Rx 고농도+epi) 의 **regulatory pathway** 정량 매트릭스.
> **sim** = `NUMB/sim/g2_regulatory_matrix.hexa` (cost·timeline 단순 추정 PK 류와 별개로 regulatory cite-only).
>
> **honest framing (@D d5/d6)**: regulatory pathway 의 *결과* 는 본질적으로 cite-based (🟡) — "FDA 가 받아들일 확률 70%" 같은 추측 ✗. 다만 **선례 매핑** 으로 *가장 가까운 path* 와 *최소·최대 envelope* 는 정량 가능.
> **결론 요약**: Rx variant = US 505(b)(2) (Pliaglis 직접 선례, ~$15-100M·5-7 yr), EU = national/MRP (centralized 비현실), KR = 신약 NDA. OTC variant (lid 2.5+tet 2.5, no epi) = US Part 348 monograph BUT **tetracaine 1-2% 한도 → 2.5% 초과 ✗** → 사실상 NDA 강제 · KR 의약외품 분류 **불가** (마취제는 의약품).

---

## 1. 핵심 선례 (precedent landscape — 5+ paper/approval)

| # | product | mode | 농도 | 승인 | pathway | 면적/시간 |
|---|---|---|---|---|---|---|
| **P1** | **Pliaglis** | cream → phase-change peel-film | **lid 7% + tet 7%** | **FDA 2006 (NDA 21-717) · sNDA 2012** | **505(b)(2)** | 400 cm² × 30 min (cream) / 60 min (peel) |
| P2 | EMLA | cream (eutectic) | lid 2.5% + pril 2.5% | FDA 1992 · EU 1984 (스웨덴 첫 승인) | NDA (US) · 국가별 (EU) | 600 cm² × 60 min (성인) |
| P3 | LMX-4 / LMX-5 | liposomal cream | lid 4% (OTC) / 5% | **US OTC (Part 348 ANDA-like)** · 처방 없음 | **OTC monograph** | 일반 사용 (라벨 가이드) |
| P4 | Synera | patch + 산소-활성 가열 | lid 70 mg + tet 70 mg | FDA 2005 (NDA 21-623) | **NDA + drug-led combination** | venous access · 작은 면적 |
| P5 | DESCRIBE PFD | 펄스 1.4 GPa needle-free liquid | lid (jet-injection) | FDA 2014 (510(k) device + Rx drug) | **device-led 510(k) + drug Rx** | 점-단위 |
| P6 | LET (lidocaine+epi+tet) | compounded gel | 4+0.1+0.5 % | **compounded** (no FDA approval) | per-state compounding pharmacy | 열상 봉합 (laceration) |
| P7 | BLT (benzocaine+lid+tet) | compounded cream | 20+6+4 % (대표) | **compounded** (no FDA approval) | 의사 처방 + 압축 약국 | 미용 시술 |
| P8 | 리도카겔(국내) | 5% 겔 | lid 5% | KR 식약처 일반의약품 | KR 일반의약품 | 1일 4 g (lid 200 mg) max |
| P9 | 엠마오플러스크림 | 9.6% lid | lid 9.6% | KR 식약처 의약품 (마취제) | KR 의약품 (전문) | 시술 직전 |

**핵심 인사이트**:
1. **lid+tet 7+7 % path = Pliaglis 그 자체** = 505(b)(2) 직행 (NUMB Rx variant 의 RLD 후보).
2. **OTC 한도 = lid 0.5-4% · tet 1-2%** (21 CFR 348.10) — NUMB OTC 2.5+2.5 는 *tetracaine 초과* → OTC monograph 직진 불가.
3. **peel-film / patch / heat / jet** 형식별 분기 → CDER lead (drug PMOA) 가 대부분, 자체 device 메커니즘 (DESCRIBE) 만 510(k) device.
4. **소아 prilocaine 금기** (MetHb) — NUMB lid+tet 조합은 *EMLA 대비 소아 안전 헤드룸* (정합).

---

## 2. US pathway — 3 갈래

### 2.1 Rx 505(b)(2) (Pliaglis 선례 직접 활용) — **NUMB Rx variant 의 main path**

| 축 | 값 | 근거 |
|---|---|---|
| RLD | **Pliaglis (lid 7% + tet 7%)** | FDA NDA 021717 |
| bridging study | Phase 1 BA/BE (single-dose, n~20-40) | 505(b)(2) 표준 bridging |
| Phase 3 pivotal | n=50-200/indication (Pliaglis 1차 = n=50 laser hair removal · 4건 임상으로 NDA) | Pliaglis NDA 패키지 |
| **timeline** | **5-7 yr** (IND → NDA → approval) | 505(b)(2) 평균 (vs NCE 10-15 yr) |
| **cost** | **$15-100M** (505(b)(2) 일반 envelope; 토픽 derm 은 ~$30-50M 중심) | sciencedirect.com/S1359644623001344 · Premier Research |
| MFDS 비교 | 60-80% 절감 vs 505(b)(1) NCE ($2.6B) | DrugPatentWatch 2025 review |

**NUMB 차별 요소 (vs Pliaglis)**:
- LA 5% + EtOH 20% (CPE) 추가 → bridging study 에서 in-vivo flux ↑ 입증 필요
- epi 1:200k → epi 함유 sub-NDA 별도 임상 (LAST 안전 + duration 변화)
- HPC peel-film → Pliaglis 와 동등 또는 개선 (제거 편의성)

**완화 path** (501(b)(2) 동시 옵션):
- in-vitro permeation test (IVPT, Franz cell) → in-vivo bridging 감면 (FDA 2022 토픽 가이던스 인정 강화)
- Pliaglis 임상 데이터 ↑ 활용 → pivotal 1건 (n=100-150) 가능

### 2.2 OTC monograph (Part 348 · M017) — **NUMB OTC variant 의 한도 wall**

`21 CFR 348.10` (analgesic/anesthetic/antipruritic):

| 성분 | 한도 | NUMB OTC 5+5% (round-1 G1 가정) | NUMB OTC 2.5+2.5% (revised) | 통과? |
|---|---|---|---|---|
| lidocaine | **0.5-4%** | 5% | 2.5% | OTC 5% **✗** / 2.5% ✓ |
| **tetracaine** | **1-2%** | 5% | 2.5% | **둘 다 ✗** (tet 2% 초과) |
| benzocaine | 5-20% (categorical) | n/a | n/a | (NUMB 미포함) |
| pramoxine | 0.5-1% | n/a | n/a | (n/a) |

> 🚨 **wall**: 21 CFR 348 의 **tetracaine 한도 = 1-2%**. NUMB OTC variant 가 OTC monograph path 를 *직접* 가려면 **tet ≤ 2%** 필수. 2.5% 도 초과.
>
> **breakthrough**:
> 1. **lid-only OTC** (lid 4% · tet 0%) → Aspercreme 4%/LMX-5 와 같은 클래스 (✓ 즉시 가능)
> 2. **lid 4 + tet 2 (monograph 한도 내)** → 새 조합이지만 둘 다 한도 내 — 다만 *Part 348* 은 "각 성분이 한도 내" + "조합 미규정" → time-limited rule (TLR) 또는 OTC 신청 (NDA 경로) 필요 가능성
> 3. **OTC NDA (505(b)(2)) 로 lid 5 + tet 5 OTC 출시** = Rx → OTC switch 선례 (e.g., Diclofenac Voltaren) → 가능하지만 *OTC switch trial* (적정사용 라벨 이해 study) 필수
> 4. **compounded route** (BLT/LET 류) → per-state pharmacy = 마케팅 한계 (FDA 미승인 라벨)

### 2.3 device-drug combination (peel-film + drug) — **Synera 선례 적용**

| 결정 | 결과 | 근거 |
|---|---|---|
| HPC peel-film 의 mechanism | **수동 carrier** (Pliaglis 와 동일 evaporation peel · 가열 X · 활성 X) | g1 §2 |
| Primary Mode of Action (PMOA) | **drug** (lidocaine + tetracaine Na-channel block) | 21 CFR Part 3 |
| **lead center** | **CDER** (drug PMOA → NDA path) | Synera (가열 patch) 도 CDER NDA |
| device 요건 | constituent part 디자인 컨트롤 (21 CFR 820.30) | 결합 제품 가이던스 |
| RFD 가능 | 사전 분류 결정 가능 (Request for Designation) | combination product office |

> **결정**: NUMB peel-film 은 **drug-led combination → 단일 NDA path** (별도 510(k) 불필요). DESCRIBE 같은 *능동 device-led* 가 아님.

---

## 3. EU pathway — 3 갈래

| path | 적용 | NUMB Rx | NUMB OTC | timeline | cost |
|---|---|---|---|---|---|
| **centralized (EMA)** | biotech · cancer · orphan · 일부 NCE 의무 | △ (의무 X · 선택 시 1국 단일 라벨) | △ | 12-18 mo (review) | $1-3M (EMA fee + EC submission) |
| **decentralized (DCP)** | 2+ MS 동시 + RMS 리딩 | ✓ (typical for derm) | ✓ | 13 mo (legal) | $200-800K |
| **mutual recognition (MRP)** | 1 MS 승인 후 다른 MS 확장 | ✓ (스타터 path) | ✓ | 90 days (per addl MS) | $50-200K per MS |
| **national** | 1 MS only | EMLA 가 1984 스웨덴에서 시작한 path | EMLA 의 *원조* path | 6-12 mo | $50-150K |

**핵심 선례 매핑**:
- **EMLA** = **1984 스웨덴 national** 시작 → 점진적으로 20+ MS 확장 (centralized 가 아님). 2025 현재 EMA Article 30 referral 로 SmPC 통일 진행. NUMB 도 *동일 path* 가 비용/시간 합리적.
- **Pliaglis EU** = Galderma → 국가별 (centralized 안 거침).
- **EU 의료기기 CE** (peel-film 단독) = peel-film 의 PMOA 가 drug 인 한 → **drug-led combination (의약품)** 으로 분류 → CE 단독 ✗.

**EU 결론**: NUMB Rx variant = **national → MRP** (스웨덴 또는 독일 시작 권장). 비용 $0.5-1.5M, 18-30 mo.

---

## 4. KR (식약처 MFDS) pathway

| 분류 | 적용 | NUMB Rx | NUMB OTC (lid 2.5+tet 2.5) |
|---|---|---|---|
| **신약 (의약품 NDA)** | 새 조합 · 새 형태 · Rx | ✓ (메인) | △ (의약외품 ✗ → 의약품으로 강제 분류) |
| **자료제출의약품 (한국형 505(b)(2))** | 새 조합 but 활성 성분 기허가 | ✓ (lid+tet 기허가 활용) | ✓ (활성 성분 기허가) |
| **일반의약품 (OTC)** | 안전성 검증 + 약국 판매 | △ (epi+고농도 = 전문) | ✓ (저농도 가능, 리도카겔 5% 선례 있음) |
| **의약외품 (quasi-drug)** | 인체 *경미* 영향 · 살균/방충 위주 | ✗ | ✗ (**마취제는 의약외품 분류 ✗**) |

**핵심 선례 매핑**:
- **리도카겔 5%** (국내 일반의약품 OTC) — lid 5% 까지 OTC 가능 선례 ✅ → NUMB OTC 2.5+2.5 는 *농도상* 한국 일반의약품 path 가능.
- **엠마오플러스크림 9.6% lid** (국내 전문의약품) — lid 9.6% 까지 전문 가능 — NUMB Rx (lid 7+tet 7+epi) 도 전문의약품 path 가능.
- **테트라카인 단독** 국내 허가 약물 = 마이너 (안과용 위주) → NUMB Rx (tet 7%) 는 **새 농도 + 새 조합** → *자료제출의약품* 또는 *신약* 분류.

**MFDS 2025 reform** (intoinworld.com):
- 신약 NDA 검토 단축: **420 → 295 일** (총)
- IND 검토: **30 영업일**
- NDA 검토: **115 일** (제출 후)
- 신청 fee: **₩410M** (인상)
- 시간: 표준 **12-18 mo** (NDA review)

**KR 결론**: NUMB Rx = **자료제출의약품 (전문의약품)** path · NUMB OTC = **자료제출의약품 (일반의약품)** path. fee 합산 ~₩500M-1B · 임상 별도 ₩2-10B (in-country bridging 포함). 총 timeline 3-5 yr.

---

## 5. 매트릭스 표 (농도 × 지역 × pathway × cost × timeline × precedent)

### 5.1 NUMB Rx variant (hexa-LAC v1 · lid 7%+tet 7%+epi 1:200k)

| 지역 | pathway | cost (USD) | timeline | precedent | tier |
|---|---|---|---|---|---|
| **US** | **505(b)(2) NDA (Pliaglis RLD)** | **$15-50M** | **5-7 yr** | Pliaglis 2006/2012 | 🟡 |
| EU | national (DE/SE) → MRP | $0.5-1.5M | 1.5-3 yr | EMLA 1984 SE | 🟡 |
| EU | centralized (EMA) | $1-3M | 1-2 yr | (선택적 · 보통 안 함) | 🟡 |
| KR | 자료제출의약품 (전문) | ₩2-10B (~$1.5-7.5M) | 3-5 yr | 엠마오플러스(9.6%) | 🟡 |

### 5.2 NUMB OTC variant (lid 2.5%+tet 2.5%, no epi)

| 지역 | pathway | cost (USD) | timeline | precedent | tier |
|---|---|---|---|---|---|
| US (intended OTC) | **Part 348 직접 ✗** (tet 2.5% > 한도 2%) | n/a | n/a | — | 🟠 wall |
| US (workaround A) | **lid-only 4% Aspercreme-class** | $2-5M (FDA 등록 + cGMP) | 1-2 yr | LMX-4 / Aspercreme 4% | 🟡 |
| US (workaround B) | **lid 4 + tet 2 (한도 내)** → TLR 또는 505(b)(2) OTC | $10-30M | 4-6 yr | (정확 선례 없음) | 🟠 |
| US (workaround C) | **OTC NDA (505(b)(2)) lid 5+tet 5 OTC switch** | $30-60M | 6-8 yr | Voltaren OTC switch | 🟡 |
| EU | national OTC (DE 약국 OTC) | $0.5-1.5M | 1.5-3 yr | EMLA 일부 MS OTC | 🟡 |
| KR | **자료제출의약품 (일반의약품)** | ₩1-5B (~$0.75-3.75M) | 2-4 yr | **리도카겔 5% OTC ✅** | 🟢 |

> 💡 **KR 가 OTC variant 의 *가장 빠른* commercial path** = 리도카겔 5% 선례 + MFDS 295일 reform.

### 5.3 envelope summary (각 지역 *총 entry cost* min/max)

```
   $M
   60 │                                     ┌─────┐
      │                                     │ OTC │
   50 │              ┌─────┐                │switch│
      │              │ Rx  │                │ US  │
   40 │              │505b2│                └─────┘
      │              │ US  │
   30 │              └─────┘     ┌──┐
      │   ┌──┐                   │OTC│
   20 │   │OTC│                  │work│
      │   │KR │                  │ B │
   10 │   └──┘  ┌──┐    ┌──┐    └──┘
      │         │ Rx│    │ Rx│
    5 │   ┌──┐  │ KR│    │ EU│   ┌──┐
      │   │OTC│  └──┘    └──┘    │OTC│
      │   │ EU│                  │US-A│
    0 └───┴──┴──────────────────┴───┴───
        OTC-KR Rx-KR  Rx-EU   OTC-US-A
       (best for OTC)         (lid-only)
```

---

## 6. 결정 트리 (SKU/농도 → path 선택)

```
                    NUMB 제품 계획
                          │
            ┌─────────────┴─────────────┐
            │                            │
       Rx variant                   OTC variant
       (lid 7+tet 7+epi)            (lid 2.5+tet 2.5)
            │                            │
       ┌────┴────┐                ┌──────┴──────┐
       │         │                │              │
      US       EU/KR         US (path-wall)    EU/KR
       │         │                │              │
   ┌───┴───┐  ┌──┴──┐         ┌───┴───┐      ┌───┴───┐
   │505(b) │  │EU:  │         │A: lid-│      │KR: 일반│
   │ (2)   │  │nat'l│         │only 4%│      │의약품  │
   │Pliaglis│  │→MRP │         │       │      │리도카겔│
   │RLD    │  │EMLA │         │B: lid+│      │ 선례  │
   │       │  │선례 │         │tet (한 │      │       │
   │$15-50M│  │KR:  │         │도내)  │      │EU: nat │
   │5-7yr  │  │자료 │         │       │      │l OTC  │
   └───────┘  │제출 │         │C: OTC │      └───────┘
              │의약품│         │ switch│
              │$1-7M │         │       │
              │2-5yr │         │A 권장 │
              └─────┘         └───────┘

   🎯 SHORTEST path to revenue:
      ① KR 일반의약품 lid 2.5+tet 2.5 (자료제출의약품, 2-4yr, ~$2M)
      ② US lid-only 4% (Part 348, 1-2yr, ~$3M) — OTC variant 의 *부분* SKU
      ③ EU national OTC (3yr, ~$1M)

   🎯 LONGEST but largest TAM:
      ① US 505(b)(2) Rx (Pliaglis-class, 5-7yr, $15-50M) — NUMB Rx full SKU
```

---

## 7. NUMB G1 듀얼 SKU gap 해소

G1 round-1 식별 gap (OTC 5+5% ↔ Rx 7+7%+epi+peel-film) → G2 path 가 *OTC 5+5% 농도가 미국 OTC monograph 한도 초과* 임을 발견 → **G1 OTC variant 재정의 필요**:

| variant 옵션 | US OTC 가능? | KR 일반의약품? | EU OTC? | 권장 |
|---|---|---|---|---|
| lid 5 + tet 5 (G1 원안) | ✗ (둘 다 한도 초과) | △ (자료제출의약품) | △ (national) | ✗ |
| **lid 4 + tet 2** | △ (조합 미규정 · TLR/NDA) | ✓ (자료제출의약품) | ✓ (national) | 🟡 |
| **lid 2.5 + tet 2.5** | ✗ (tet 초과) | ✓ (리도카겔 선례) | ✓ (national) | 🟡 |
| **lid 4 단독 (no tet)** | ✓ (Aspercreme/LMX class) | ✓ | ✓ | 🟢 (가장 빠름) |
| **lid 5 단독 (no tet)** | ✗ (lid 한도 4% 초과) | ✓ (리도카겔 5% 선례) | △ | 🟡 |

> **G2 결정**: OTC variant 의 **flagship = lid 4% 단독 (LMX-5 class)** + **regional variant = lid 5% (KR)** + **research variant = lid 4 + tet 2** (가능 시).

---

## 8. honest framing — unknowable / 추측 영역

| 항목 | 상태 | 이유 |
|---|---|---|
| FDA 가 NUMB 505(b)(2) NDA 를 1차 cycle 에 승인할 확률 | ⚪ 추측 ✗ | 개별 application 결과는 historical base rate 외 추측 불가 |
| 정확한 임상시험 비용 ($30M ± ?) | 🟠 envelope only | 임상 site 수·indication 수·CRO 선택 의존 → ±50% 범위 |
| MFDS 295일 reform 이 NUMB-class 에 실제 적용될지 | 🟠 stated policy | 2025 발표 reform · 실제 derm 분야 적용 사례 미축적 |
| OTC switch trial (lid 5+tet 5) 통과 가능성 | ⚪ 추측 ✗ | 라벨 이해 study 결과 의존 |

---

## 9. 다음 단계 (G3 · G4 연결)

- **G3 소아 LAST**: lid 4% OTC variant 가 EMLA prilocaine MetHb 회피 → **소아 SKU 1순위 후보**.
- **G4 제형 variant**: 본 G2 결정 트리에 따라 *flagship lid 4% + tet 2%* (또는 lid 4% 단독) 를 OTC 라인의 G4 spec 으로 fix.
- **G7 사용자 가이드**: regulatory class 별 *라벨 가이드* (OTC vs Rx) 자동 분기.

---

## tier ledger

| claim | tier | 근거 |
|---|---|---|
| Pliaglis = NDA 21-717 lid 7+tet 7 (2006/2012) | 🟡 | FDA accessdata 021717 |
| 21 CFR 348 lid 0.5-4% / tet 1-2% | 🟡 | law.cornell.edu/cfr/text/21/348.10 |
| 505(b)(2) cost $15-100M · 5-7 yr | 🟡 | sciencedirect S1359644623001344 · Premier Research |
| EMLA EU = 1984 스웨덴 national 시작 | 🟡 | EMA Article 30 referral doc |
| MFDS reform 420→295 일 (2025) | 🟡 | intoinworld.com · pharmaregulatory.in |
| MFDS NDA fee ₩410M | 🟡 | 동일 source |
| 리도카겔 5% = KR 일반의약품 OTC | 🟡 | 약학정보원·식약처 nedrug.mfds |
| 엠마오플러스크림 9.6% lid = KR 의약품 | 🟡 | omnidr.kr 상품 인용 (제조사 카탈로그 단계) |
| Synera (lid 70+tet 70 mg patch) = NDA 21-623 (2005) drug-led combination | 🟡 | drugs.com history + FDA label 021623 |
| 의약외품 정의 = "인체 경미·살균/방충" → 마취제 ✗ | 🟡 | MFDS eng wpge + 한국 약사법 |
| FDA NUMB 1-cycle 승인 확률 | ⚪ | speculation |

---

## sources

- [21 CFR 348.10 — analgesic/anesthetic/antipruritic active ingredients](https://www.law.cornell.edu/cfr/text/21/348.10)
- [FDA OTC Monograph M017 (2023)](https://www.accessdata.fda.gov/drugsatfda_docs/omuf/Order/Final%20Administrative%20Order%20OTC000033_M017-External%20Analgesic%20Drug%20Products%20for%20OTC%20Human%20Use.pdf)
- [Pliaglis FDA label 021717 (2013)](https://www.accessdata.fda.gov/drugsatfda_docs/label/2013/021717s005lbl.pdf)
- [Pliaglis 2006 original NDA label](https://www.accessdata.fda.gov/drugsatfda_docs/label/2006/021717lbl.pdf)
- [FDA approves Pliaglis (2012) — Medscape](https://www.medscape.com/viewarticle/773122)
- [Synera FDA label 021623 (2014)](https://www.accessdata.fda.gov/drugsatfda_docs/label/2014/021623s015s017lbl.pdf)
- [EMLA EMA Article 30 referral](https://www.ema.europa.eu/en/documents/referral/emla-cream-article-30-referral-annex-ii_en.pdf)
- [LMX-4 DailyMed label](https://dailymed.nlm.nih.gov/dailymed/fda/fdaDrugXsl.cfm?setid=f0e7c92f-8b0b-4045-b659-af9f6e81260f)
- [LMX-5 DailyMed label](https://dailymed.nlm.nih.gov/dailymed/lookup.cfm?setid=34f8ed6b-4a52-4a99-9c1b-254196dc29b0)
- [505(b)(2) cost/timeline — ScienceDirect 2024](https://www.sciencedirect.com/science/article/abs/pii/S1359644623001344)
- [DrugPatentWatch 2025 — 505(b)(2) IP/strategy guide](https://www.drugpatentwatch.com/blog/review-of-drugs-approved-via-the-505b2-pathway-uncovering-drug-development-trends-and-regulatory-requirements/)
- [Korea MFDS 2025 reform — IntoIn World](https://intoinworld.com/korea-mfds-2025-faster-drug-approval-teams/)
- [MFDS quasi-drug definition (English)](https://www.mfds.go.kr/eng/wpge/m_25/de011015l001.do)
- [리도카겔 5% — 약학정보원](https://www.health.kr/searchDrug/search_detail.asp)
- [EU MDR 2017/745 device classification — Greenlight Guru](https://www.greenlight.guru/blog/eu-medical-device-classification)
- [FDA Combination Product Designation guidance — McGuireWoods 2022](https://www.mcguirewoods.com/client-resources/alerts/2022/2/fda-guidance-clarifies-classification-of-combination-drug-device-products/)
- [Pliaglis dermal PK study (Göttingen minipig) — PMC12845211](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12845211/)
- [Topical lid+tet Phase 3 — Chinese fractional laser RCT (PMC12308782)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12308782/)

— G2 완 (✅ honest framing 유지 · Rx & OTC 결정 트리 fix · KR fastest-OTC path 식별 · OTC monograph wall 노출 · 듀얼 SKU spec G1 → G2 보정 필요 식별)
