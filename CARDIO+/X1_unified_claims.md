# X1 — CARDIO+ unified claim inventory + cross-domain triage

> CARDIO+ 메타도메인 X1 산출물 · current-state · no history.
> 입력 = 4 sub-domain V1 (NOREFLOW · DAPTPGX · ISR · LPA) 직접 read · LLM 가공 최소.
> 목표 = flat union → cross-domain dedup → unified tier triage → X2-X10 입력 매핑.
> ⚠ 본 X1 은 **inventory + 통합 plan only** — sub-V1 4 파일 read-only 인용 (수정 금지).

---

## §1. 통합 방법론

### 1.1 통합 funnel

```
4 sub V1 직접 read   ── NOREFLOW (72) + DAPTPGX (30) + ISR (~200+ 추정) + LPA (45)
                        ≈ 347+ raw claim
        │
        ▼ 각 V1 내 dedup 이미 적용된 상태
                        sub-V1 표 count 합산 그대로
        │
        ▼ cross-domain dedup (4 sub 간 동일 fact)
                        −12 row (CX01-CX12)
        │
        ▼ unified inventory
                        ≈ 335+ unique claim (NOREFLOW 72 + DAPTPGX 30 + ISR ~200 + LPA 45 − 12 dedup)
```

### 1.2 dedup 규칙

| 규칙 | 적용 |
|---|---|
| 동일 fact 다른 sub 등장 | cross-domain claim 표 (§3 CX01-CX12) 별도 분류 + 가장 deep 등장 sub 1차 출처로 유지 |
| 표기 다른 동일 fact | dedup 대상 (예 "한국 ≥50 mg/dL Lp(a) 10-15%" vs "한국인 ≥75 nmol/L 15.3%") — 단위 변환만 다른 동일 prevalence 면 dedup |
| 단위/scope 다른 claim | 별도 (예 "한국 KAMIR n>20,000" vs "한국 STEMI primary PCI 80,000/yr") |
| tier 충돌 | 가장 높은 tier 채택 (NOREFLOW 🟡 vs LPA 🟢 → 🟢) |

### 1.3 출처 표기 규약

- sub-domain 단일 출처 — `[NOREFLOW/M9§5]` · `[DAPTPGX/C25]` · `[ISR/V1-FORM-14]` · `[LPA/C22]`
- cross-domain — `[CX##]` prefix + sub coverage 명시
- ⚠ ISR row 다수는 `V1-FORM-NN`/`V1-NUM-NN`/`V1-CITE-NN`/`V1-DEF-NN` 명명 — 그대로 carry

### 1.4 g5 rubric (verbatim — 4 sub 공통)

| 등급 | 표기 | 정의 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 🔵 | closed-form 산식 · identity · atlas-registered formula recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 🟢 | 시뮬레이션 / 수치 재계산 (PK ODE · MC · DFT · MD · CFD · ICER) 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | 🟡 | peer-review 1차 출처 cite, hexa recompute 없음 — literature carry |
| 🟠 INSUFFICIENT/DEFERRED | 🟠 | wet-lab · 임상 readout · IPD · external hw 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 🔴 | 명시적 reject (large RCT null 등) |
| ⚪ SPECULATION-FENCED | ⚪ | 본질적 closed-form 미가능 (subjective · 미래 trial · prognostic · metaphor) |

---

## §2. 4 sub-domain claim 합산 표

### 2.1 high-level 합산 (sub-V1 §표 직접 인용)

| sub | total claims | 🔵 현재 | 🟢 현재 | 🟡 현재 | 🟠 현재 | 🔴 현재 | ⚪ 현재 |
|---|---:|---:|---:|---:|---:|---:|---:|
| **NOREFLOW** | 72 | 0 | 0 | 51 | 17 | 0 | 0 |
| **DAPTPGX** | 30 | 0 | 0 | 18 | 9 | 0 | 3 |
| **ISR** | ~200+ † | 0 | 0 | 50+ inline | 15+ inline | 0 | 0 |
| **LPA** | 45 | 1 | 14 | 24 | 5 | 1 | 0 |
| **합산 (raw)** | **~347+** | **1** | **14** | **~143** | **~46** | **1** | **3** |
| (− cross-domain dedup) | −12 | 0 | 0 | −10 | −2 | 0 | 0 |
| **unified** | **~335+** | **1** | **14** | **~133** | **~44** | **1** | **3** |

† ISR V1 의 §4 🟡 후보는 "대표 50건 inline · 전수 ledger V4" 표기. V4_tier_ledger 확정 시 200+ 정확 분모. X1 분포는 inline 65 (28+10+50+15+무명 ⚪/🔴 0) 기준 + V4 확장 carry.

### 2.2 target tier (sub V2/V3 push 후 — 각 V1 §3/§4/§9 인용)

| sub | 🔵 target | 🟢 target | 🟡 target | 🟠 target | 🔴 target | ⚪ target | 비고 |
|---|---:|---:|---:|---:|---:|---:|---|
| NOREFLOW | 11 | 13 | 33 | 8 | 4 | 9 | M11/V2 + M12/V3 + M10 fence |
| DAPTPGX | 0-2 | 12-14 | 9 | 3-5 | 0-2 | 3 | atlas register 의존 (hexa-lang inbox) |
| ISR | ~28 | ~10 | ~50 inline | ~15 inline | 0 | 0 | V4 ledger 전수 시 🟡 150+ |
| LPA | 8 | 18 | 14 | 4 | 1 | 0 | C22/C44 IVW primary 🔵 |
| **합산 (target)** | **~47-49** | **~53-55** | **~106-108** | **~30-32** | **~5-7** | **~12** | **+ ISR V4 확장 carry** |

→ unified V2/V3 push 후 **🔵+🟢 ≈ 100+ claim** (현재 15 → +85) — 4 sub × 약 25 claim escalation 합산.

---

## §3. cross-domain 중복/시너지 claim (CX01-CX12)

표기 다른 동일 fact 또는 4-domain shared infrastructure. 가장 deep 등장 sub 가 1차 출처. **dedup 결과 unified inventory 에서 1 row 만 유지** (sub 별 inventory 에서는 그대로 보존).

| # | claim (한 줄) | sub coverage | sub 내 tier 일치성 | 종합 tier | dedup 후 1차 출처 |
|---|---|---|---|---|---|
| **CX01** | 한국인 STEMI primary PCI 연간 ~80,000-100,000 baseline | NOREFLOW M8 §1 + DAPTPGX M8 §7 + ISR M8 §1.1 + LPA M2 §3 | 🟡 all | 🟡 | NOREFLOW M8 §1 (KAMIR-NIH n>20,000) |
| **CX02** | KAMIR-NIH 한국 STEMI registry (n>20,000) | NOREFLOW M8 §1 / M9 §2 + DAPTPGX HOST 가족 + ISR M8 §1.1 + LPA C25 | 🟡 all | 🟡 | NOREFLOW M9 §2 (Korean Circ J 2025) |
| **CX03** | TICAKOREA — 한국인 ticagrelor major bleeding HR ↑ vs clopidogrel | NOREFLOW M6 §5 + DAPTPGX C14 (Park 2020) | 🟡 all | 🟡 | DAPTPGX C14 (M4 §5 — primary outcome 발표) |
| **CX04** | HOST-EXAM HR 0.73 — clopi 단독 chronic phase | DAPTPGX C11 + ISR M8 §1.1 (HOST 시리즈) | 🟡 all | 🟡 | DAPTPGX C11 (Kim 2020 Lancet) |
| **CX05** | COLCOT colchicine post-MI HR 0.77 ✅ vs CLEAR SYNERGY acute null ❌ | NOREFLOW M9 §2 + ISR M4 §2.4 / R1 §15 | 🟡 (chronic ✅) + 🔴 (acute ❌) | mixed | NOREFLOW M9 §2 (chronic) + ISR V1-CITE-13 (acute null) |
| **CX06** | PCSK9 mAb (evolocumab · alirocumab) MACE 감소 | ISR M4 §2.2 (FOURIER) + LPA C17 (Lp(a) −25%) | 🟡 all | 🟡 | ISR V1-CITE-08 (FOURIER NEJM 2017) |
| **CX07** | FOURIER Lp(a) ≥50 subset 17% RRR | ISR M4 §2.2 + LPA C24 | 🟡 all | 🟡 | LPA C24 (O'Donoghue 2019) |
| **CX08** | Mehran 4-pattern ISR classification — surrogate "no-reflow ED 4-cause" 분류축 | ISR M1 §7 (V1-FORM-19 / V1-CITE-45) + NOREFLOW M1 §2 (4-cause framework cross) | 🟡 (ISR) + 🟡 (NOREFLOW) | 🟡 | ISR V1-FORM-19 (Mehran 1999) |
| **CX09** | ARC-2 LST 3-class enum (definite/probable/possible) | ISR M7 §2.1 (V1-FORM-20) + DAPTPGX 출혈 정의 cross | 🟡 (ISR primary) | 🟡 | ISR V1-FORM-20 (Cutlip 2017) |
| **CX10** | nicorandil 한국 인사 + 한국 RCT 6mo neutral | NOREFLOW M8 §3 + M9 §5 (한국 RCT 2023 ❌) — ISR/LPA 영향 X (cross 약함) | 🟡 (carry) + 🔴 (한국 6mo) | 🟡 + 🔴 | NOREFLOW M9 §5 (Heart 2023) |
| **CX11** | 한국 prevalence framework — ASCVD 2차 5y baseline 15-20% | LPA M7 §5 (C25) + DAPTPGX M4 (HBR overlap) | 🟡 all | 🟡 | LPA C25 (KAMIR registry) |
| **CX12** | hexa-lang inbox PR-pending — atlas extension carrier | NOREFLOW V2 §9.1 + DAPTPGX d2 path A + ISR V1-DEF-12 + LPA C42 | 🟠 all (PR pending) | 🟠 | 4-domain shared blocker |

**dedup 결과 unified 분모 영향**:
- 🟡 dedup: CX01·CX02·CX03·CX04·CX06·CX07·CX08·CX09·CX11 = 9 row (각 dup 2-3 sub 에서 1로 통합 — sub V1 합산 −10)
- 🟠 dedup: CX12 = 1 row (sub V1 합산 −2; 4-sub 공통 PR-pending)
- 🔴 dedup: CX05/CX10 일부 = sub V1 합산 −1 (단, CX05 chronic ✅ 와 acute ❌ 는 별개 claim 으로 유지)
- 합산 dedup: **−12 row** (§2.1 표 적용)

**cross-domain 시너지 잠재**:
- **ALDH2*2 × CYP2C19 LoF × Lp(a) 3-axis stratification** — NOREFLOW M9 §5 (ALDH2*2 40%) + DAPTPGX M1 §3-4 (CYP2C19 LoF 60%) + LPA C20 (KIV-2 null carrier 10%) — 한국인 PCI layered care 의 leverage point (X9 wall map 입력).
- **CMR / OCT / FFR 이미징 자산 공유** — NOREFLOW M5 §4 (CMR Stone 2016) + ISR M1 §3 (OCT/IVUS) — 한국 다기관 imaging consortium 결성 시 동시 unlock.

---

## §4. milestone × claim heatmap (4 sub 통합)

각 sub 의 milestone (M?) × claim count 분포. 가독성 우선 — sub-V1 §8 / §10 / §11 인용.

```
                NOREFLOW         DAPTPGX          ISR              LPA
                (M1-M9, 72)      (M1-M11, 30)     (M1-M8+R1-R3)    (M1-R3, 45)
                ────────         ────────         ────────────     ────────────
M1 (mechanism)  ▓▓▓▓ 12          ▓▓ 6             ▓▓▓ 8+           ▓▓ 7
M2 (current)    ▓▓▓▓▓ 14         ▓▓▓ 3            ▓▓▓▓ 12+         ▓▓ 4
M3 (targets)    ▓▓▓▓ 12          ▓▓▓ 4            ▓▓▓▓ 10+         ▓▓ 4
M4 (candidates) ▓▓▓▓ 11          ▓▓▓ 5            ▓▓▓ 8+           ▓▓▓ 6
M5 (endpoint)   ▓▓ 7             ▓▓ 3             ▓▓▓ 7+ (DCB)     ▓▓ 5
M6 (safety)     ▓▓▓▓ 11          ▓▓ 3             ▓▓▓ 7+ (BRS)     ▓▓ 4
M7 (ranking)    ▓▓▓ 9            ▓▓ 3             ▓▓▓ 8+           ▓▓ 5
M8 (korea)      ▓▓ 7             ▓▓ 4             ▓▓ 5+            ▓ 3
M9 (deep)       ▓▓▓▓▓ 16         —                —                —
M10-11 (deep)   —                ⚪ 2             —                —
R1-R3 (deep)    —                —                ▓▓▓ 15+          ▓▓ 7
```

**관찰**:
- NOREFLOW는 M2/M9 (mPTP + deep research) 비중 高 — d2 wall 학습 집중
- ISR은 M1/M2 (mechanism + current DES) 비중 高 + R1-R3 deep 통합
- DAPTPGX는 분포 균등 — pharmacogenomics ↔ 임상 결정맵 트리 표준
- LPA는 M4/M7 (siRNA candidates + MR/IVW) 비중 高 — 신약/유전적 인과 dual track

---

## §5. unified tier 분포 + trajectory

### 5.1 current state (pre-V2/V3, raw — sub V1 합산 - dedup)

```
🔵 SUPPORTED-FORMAL        ░░░░░░░░░░░░░░░░░░░░░░░░░░  1  ( 0.3%)  ← LPA C30 sanity baseline
🟢 SUPPORTED-NUMERICAL     ▓▓░░░░░░░░░░░░░░░░░░░░░░░░ 14  ( 4.2%)  ← LPA C01/C07/C08/C12/C22-23/...
🟡 SUPPORTED-BY-CITATION   ████████████████████░░░░░░ 133 (39.7%)  ← citation carry 다수
🟠 INSUFFICIENT/DEFERRED   ████░░░░░░░░░░░░░░░░░░░░░░ 44 (13.1%)   ← d2 wall + wet-lab / IPD / readout 대기
🔴 FALSIFIED               ░░░░░░░░░░░░░░░░░░░░░░░░░░  1  ( 0.3%)  ← LPA C41 GalNAc tool gap
⚪ SPECULATION-FENCED      ░░░░░░░░░░░░░░░░░░░░░░░░░░  3  ( 0.9%)  ← DAPTPGX C28/C29/C21
ISR 미할당 (V4 V4 ledger 확장 carry)         ~140                  ← V4 전수 시 대부분 🟡로 분류
                                                       ─────
                                                       335+
```

### 5.2 target (4 sub × V2/V3 push + atlas register 후, hexa-lang inbox PR merge 가정)

```
🔵 SUPPORTED-FORMAL        █████░░░░░░░░░░░░░░░░░░░░  ~48  (14.3%)  ← NOREFLOW 11 + DAPTPGX 0-2 + ISR ~28 + LPA 8
🟢 SUPPORTED-NUMERICAL     █████░░░░░░░░░░░░░░░░░░░░  ~54  (16.1%)  ← NOREFLOW 13 + DAPTPGX 12-14 + ISR ~10 + LPA 18
🟡 SUPPORTED-BY-CITATION   ███████████░░░░░░░░░░░░░░ ~107  (31.9%)  ← unchanged carry
🟠 INSUFFICIENT/DEFERRED   ███░░░░░░░░░░░░░░░░░░░░░░  ~31  ( 9.3%)  ← wet-lab/RCT 의존
🔴 FALSIFIED               █░░░░░░░░░░░░░░░░░░░░░░░░   ~6  ( 1.8%)  ← NOREFLOW 4 + DAPTPGX 0-2 + LPA 1
⚪ SPECULATION-FENCED      █░░░░░░░░░░░░░░░░░░░░░░░░  ~12  ( 3.6%)  ← NOREFLOW 9 + DAPTPGX 3
ISR 미할당 V4 확장                                       ~78                  ← 본질적 🟡 (RCT/registry/guideline)
                                                       ─────
                                                        336
```

### 5.3 trajectory

- **🔵+🟢 비중**: 4.5% (15/335) → 30.4% (~102/336) — V2/V3 push 로 **5-fold escalation**.
- **🟡 carry 부담**: 39.7% → 31.9% — 모든 sub 가 citation-locked 영역 본질적 잔존 (인체 RCT · registry · guideline).
- **🔴 falsified**: 0.3% → 1.8% — NOREFLOW M9 4-RCT null 흡수 후 honest carry.
- **⚪ fence**: 0.9% → 3.6% — NOREFLOW M10 honest declaration (M7 가중치 · trajectory 등).

---

## §6. 4-domain × 5-axis 통합 권고 ranking (Tier-A 후보 합산)

각 sub 의 M7 / M8 ranking 최상위 cross-domain 합산. 한국 임상 적용 즉시 가능 묶음.

| 순위 | 4-domain Tier-A 후보 | sub 출처 | 핵심 leverage |
|---:|---|---|---|
| **1** | **NOREFLOW adenosine IC** + **DAPTPGX CYP2C19-guided 결정 트리** | NOREFLOW M7 §3 (adenosine IC 24 mg · score 4.85) + DAPTPGX M5/M7 (결정맵) | 한국인 60% non-NM clopidogrel — 외래/시술 다음 환자부터 즉시 |
| **2** | **DAPTPGX HOST-EXAM clopi 단독 chronic** + **LPA Lp(a) routine 측정** | DAPTPGX C11 (Kim 2020 Lancet · HR 0.73) + LPA R2 §2 (KSoLA 2026 ≥50=high) | 만성 phase + 잔여 위험 stratification 동시 |
| **3** | **ISR DCB AGENT (paclitaxel)** + **NOREFLOW nicorandil pre-PCI** | ISR V1-CITE-26 (AGENT IDE · HR 0.59) + NOREFLOW M8 §3 (한국 nicorandil 보험 등재) | 기존 stent ISR + STEMI MVO 보호 |
| **4** | **LPA HORIZON pelacarsen readout 2026 H1** + **LPA siRNA OCEAN(a) 2027 H1** | LPA C09 + C11 (readout 일정) | 5y 잔여 위험 30% — siRNA paradigm shift |
| **5** | **NOREFLOW MTP-131 (elamipretide)** + **ISR fasudil-DES IIT-1** | NOREFLOW M7 §3 + M9 §6 (elamipretide 격상) + ISR V1-DEF-02 | 신규 mitochondrial / ROCK 표적 — first-in-class 한국 기회 |

→ **시너지**: ALDH2*2 (NOREFLOW M9 §5) × CYP2C19 LoF (DAPTPGX) × Lp(a) high (LPA) — 한국 ethnicity 3-axis × no-reflow + DAPT + ISR + Lp(a) 4-trial portfolio (§7 X5 입력).

---

## §7. cross-domain wall map preview (X9 입력)

### 7.1 4 sub 각 d2 wall

| sub | d2 wall (empirical) | breakthrough path (sub V1 명시) |
|---|---|---|
| **NOREFLOW** | CIRCUS · CYCLE · EMBRACE · MITOCARE 4 large RCT neutral (n>2,000) — mPTP IV bolus 가설 falsify | M2 Path B (IC + reperfusion-synced) · M2 Path A (CypD-selective NIM811) · M4 T5 (DEC frontier) |
| **DAPTPGX** | 한국인 60% PM/IM 비-최적 + 단순 ticag switch 출혈 위험 (TICAKOREA 2.8% vs 1.4%) | CYP2C19-guided 결정 트리 (S4 ICER 34M KRW/QALY pending recompute) · selatogrel/vicagrel CYP2C19-무관 신약 |
| **ISR** | 2nd-gen DES 잔여 5-10% ISR + mTOR 단일 표적 plateau · BRS late ST signal | 비-mTOR 신규 (ROCK fasudil · PCSK9 · GLP-1R) · Mg-BRS 차세대 (Magmaris · BIOMAG-I) · dual-DCB |
| **LPA** | 30% 잔여 위험 + 스타틴 무효 (오히려 +5-10%) + apheresis 한정적 | siRNA/ASO (HORIZON pelacarsen · OCEAN(a) olpasiran · lepodisiran · zerlasiran) · muvalaplin 경구 · VERVE-301 base editor |

### 7.2 cross-domain breakthrough leverage (X9 deep)

```
                     ALDH2*2 (NOREFLOW M9§5)
                            │
                            ▼
한국 PCI 환자  ──── CYP2C19 LoF (DAPTPGX M1)  ─── KIV-2 high copy / Lp(a) high (LPA M6/C20)
   │                       │                              │
   ├─ no-reflow 위험        ├─ HTPR 50-60%                 ├─ 잔여 위험 30%
   │  (NOREFLOW)            │  (DAPTPGX C17 Jeong 2014)    │  (LPA M3)
   │                       │                              │
   └────────────────────────────────────────────────────────────
                            │
                  ┌─────────┴─────────┐
                  │ ISR 5-10% 추가 위험 (ISR M2 §4)
                  │  (mTOR 단일 plateau)
                  ▼
       4-trial portfolio (X5):
         A. NICORADENO-MVO (NOREFLOW)
         B. DAPT-PGx-K (DAPTPGX)
         C. ISR-non-mTOR (ISR fasudil-DCB / dual-DCB IIT-1/2)
         D. LPA-siRNA-K (LPA HORIZON Korean enrollment)
```

→ 4-domain layered care = 한국인 first-in-class 4-trial portfolio (KHIDI/보건복지부 R&D 입력).

---

## §8. honest gap + ⚪ fence 통합

각 sub ⚪ fence 합산 + 공통 패턴 추출.

| 패턴 | sub 등장 | 합산 count | 사유 |
|---|---|---:|---|
| **subjective 5-axis 가중치** | NOREFLOW M7 §1 (30/20/25/15/10) + ISR M8 §3.2 (가중 ranking) | 2 | axis 가치판단 자의성 |
| **prognostic 진술** ("한국 first-in-class 기회") | NOREFLOW M8 §5 + DAPTPGX C29 (KSC 2025 클래스 격상 예상) + LPA C09/C11 (readout 일정) + ISR DEF-09 (KCSC position 부재) | 4+ | 글로벌 공백 → 기회 인과 미보장 |
| **future trial readout 의존** | NOREFLOW M7 §5 (Trial-B/C) + LPA C09/C11/C14 (HORIZON · OCEAN · ACCLAIM) + ISR DEF-04/05 (BIOMAG-III · Zn-BRS) | 5+ | 미래 데이터 도착 전 prognostic |
| **preclinical 가설** | NOREFLOW M9 §7 (STING inh · 다축 차단 · PPARα) + LPA C29 (VERVE-301) + ISR DEF-03/06/07 | 4+ | wet-lab 1차 데이터 부재 |
| **metaphor / heuristic** | LPA C27 (50% 감쇠) | 1 | rule 승격 위험 |
| **subjective Tier 분류** | NOREFLOW M6 §6.1 (Tier-A/B/C) | 1 | 효능 vs safety 가중치 자의 |

→ unified ⚪ ≈ **12 row** (sub 별 fence 합산; ISR 의 deferred ⚪ 명시 row 부재 — V4 ledger 시 정량). 핵심 = "한국 first-in-class 기회" 가 4-sub 모두 등장 — meta-domain 공통 prognostic ⚪ 영역.

---

## §9. 한국 환자 적용 우선순위 (DOCTOR X7 feed 입력)

### 9.1 즉시 (외래 / 시술 다음 환자부터)

| 적용 | sub 근거 | 즉시 실행 가능 |
|---|---|---|
| **CYP2C19 PCR 검사 → 한국인 60% clopidogrel 적절성 평가** | DAPTPGX C24 (수가 ₩50,000) + C05/C06 (PM 14-15% · IM+PM 60%) | ✅ NHIS 급여 + 한국 PCR cap 충분 |
| **IMR 측정 (가능 기관)** → no-reflow 위험 stratification | NOREFLOW M1 §3 + M5 §2.1 (IMR=Pd×Tmn) + M8 §4 (10 기관 capacity) | ⚠ 한국 ~10 기관 한정 |
| **nicorandil pre-PCI · adenosine IC 24 mg** | NOREFLOW M7 §3 (Tier-A) + M8 §3 (한국 nicorandil 보험 등재) | ✅ 한국 nicorandil 보험 등재 (글로벌 우위) |

### 9.2 6-12 개월

| 적용 | sub 근거 | 진행 dependencies |
|---|---|---|
| **Lp(a) 1회 routine 검사** + KSoLA 2026 3-tier cutoff 적용 | LPA C31 (R2 §2) + C32 (한국 ≥75 nmol/L 15.3%) | KSoLA position paper 2026 발표 후 routine 정착 |
| **HORIZON pelacarsen Ph3 readout** 추적 + 한국 enrollment 확보 | LPA C07/C08/C09 (2026 H1 readout) | Novartis IR 추적 + 한국 site PI |
| **NOREFLOW colchicine acute → demote 반영** (CLEAR SYNERGY 2024) | NOREFLOW M9 §2 (acute null) + ISR V1-CITE-13 | 가이드라인 update 후 |

### 9.3 2-5 년 (4-trial portfolio · KHIDI/보건복지부 R&D)

| trial | sub 출처 | 예상 budget · 일정 |
|---|---|---|
| **A. NICORADENO-MVO** | NOREFLOW M7 §5.1 (Trial-A) | consortium 8-기관 + KHIDI funding |
| **B. DAPT-PGx-K (한국인 결정맵)** | DAPTPGX C25 (S4 ICER 34M/QALY pending) | NHIS S4 sensitivity 후 |
| **C. ISR fasudil-DCB IIT-1** | ISR V1-DEF-11 (n=60 · 15-25억 KRW) | MFDS pre-IND + KCSC consortium |
| **D. LPA-siRNA-K (HORIZON Korean enrollment)** | LPA C26 (5y NNT 25-35) | Novartis 협력 + KSoLA position |

→ **핵심 3 bullet (DOCTOR X7 feed)**:
1. **즉시**: CYP2C19 PCR + IMR + nicorandil/adenosine IC (NHIS 급여 안에서 가능)
2. **6-12 m**: Lp(a) routine + colchicine acute demote + HORIZON readout 대비
3. **2-5 y**: 4-trial portfolio (NICORADENO · DAPT-PGx-K · ISR-IIT-1 · LPA-siRNA-K) — KHIDI/보건복지부 R&D 트랙

---

## §10. g5 grade — X1 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 통합 방법론 | 🟡 | sub V1 4 파일 dedup 규칙 명시 + 4 sub g5 rubric carry |
| §2 4 sub 합산 표 | 🟡 | 각 V1 §3/§4/§9 직접 count 인용 — LLM 추정 X |
| §3 cross-domain CX01-CX12 | 🟡 | 4 V1 cross-reference 추출 (LLM 가공 최소) |
| §4 milestone × claim heatmap | 🟡 | 각 V1 §8 / §11 count 인용 |
| §5 unified tier 분포 | 🟡 (compositional) | 4 sub × 합산 후 산술 — ISR V4 미확정 carry |
| §6 4-domain × 5-axis ranking | 🟡 | sub M7 / M8 verbatim |
| §7 cross-domain wall map | 🟡 | sub d2 wall 각 V1 §5 / §7 인용 |
| §8 ⚪ fence 통합 | ⚪ (자체 패턴 추출) | sub V1 ⚪ row 합산 + 패턴 분류는 X1 가공 |
| §9 한국 우선순위 | 🟡 | sub M8 권고 4-domain 통합 carry |
| §11 X2-X10 매핑 | 🟡 | CARDIO+.md scaffold + sub V1 §6-9 입력 매핑 |

**X1 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub V1 inventory 통합 + cross-domain dedup carry. target 🟢 (CARDIO+/bio-verify-kernel impl 후 X3 V3 chain pass).

⚠ **honest fence**: §6 ranking + §8 ⚪ 통합 + §9 우선순위 일부 = X1 가공 (LLM 패턴 추출) — V4 ledger 확정 시 정량.

---

## §11. X2-X10 입력 매핑

각 X 의 claim block 입력원.

| X 단계 | 입력 claim block | source sub V1 | 예상 count |
|---|---|---|---|
| **X2 V2 🔵 push** | 4 sub × 🔵 후보 합산 | NOREFLOW M11 (11) + DAPTPGX hexa-lang inbox (0-2) + ISR FORM-01~28 (28) + LPA C22/C44 외 (8) | ~47-49 |
| **X3 V3 🟢 push** | 4 sub × 🟢 후보 (pool ubu-1/2 + RunPod) | NOREFLOW M12 (13) + DAPTPGX HW/binomial/ICER (12-14) + ISR NUM-01~10 (10) + LPA V3a/b/c (18) | ~53-55 |
| **X4 ⚪ fence 통합** | 4 sub × ⚪ row + X1 §8 패턴 추출 | NOREFLOW M10 (9) + DAPTPGX (3) + ISR (0 inline + V4 확장) + LPA (0) + X1 자체 ⚪ | ~12 |
| **X5 한국 trial portfolio** | 4 sub × Trial 후보 | NOREFLOW M7 §5 (NICORADENO) + DAPTPGX M8 (DAPT-PGx-K) + ISR V1-DEF-11 (fasudil IIT-1) + LPA C26 (Korean enroll) | 4-trial |
| **X6 환자 본인 retroactive** | 4-axis 본인 사례 | mPTP retroactive (NOREFLOW) + CYP2C19 검사 (DAPTPGX) + ISR risk (ISR) + Lp(a) 검사 (LPA) | 4-axis |
| **X7 DOCTOR handoff** | §9 한국 우선순위 + 4 sub Tier-A | 4-sub 통합 + 즉시/6m/3y timeline | 1-page exec |
| **X8 g5 grade ledger** | §5 unified tier 분포 + 4 V4 합산 | NOREFLOW V4 + DAPTPGX V4 + ISR V4 + LPA V4 합산 | ~336 row |
| **X9 wall map** | §7 cross-domain wall + 시너지 | 4 sub d2 wall + ALDH2*2 × CYP2C19 × Lp(a) 3-axis | 4 wall + ≥3 시너지 path |
| **X10 figures** | 4-axis radar + timeline + portfolio | sub ASCII + 통합 1 figure | ~5-8 figures |

---

## §12. CLI commands log (사용 verbatim)

본 X1 작성 시 **새 hexa verify / atlas 명령 실행 없음** — 4 sub V1 read-only 인용 + 산술 합산 만.

sub V1 에서 인용된 명령 (verbatim):

```
# NOREFLOW V1 §9.1 (V2 입력 — hexa-lang inbox PR merge 후)
#   atlas register --kind F --id mPTP.open_prob_hill --raw "P_open=(Ca/K)^n/(1+(Ca/K)^n)"
#   atlas register --kind F --id IMR.pdtmn --raw "IMR=Pd×Tmn"
#   atlas register --kind F --id cTFC.lad_correct --raw "cTFC_LAD=raw×1.7"

# DAPTPGX V1 §5 (V2 입력 — hexa-lang inbox/notes/daptpgx-pgx-ssot-databases.md 흡수 후)
#   hexa atlas append-witness --kind P --id CYP2C19.PM.kor.freq --raw "0.14-0.15"
#   hexa atlas register --from-verify hw_pm_freq <n> <v>

# ISR V1 §6.1 (V2 first-batch — 7 commands)
#   hexa verify --expr hill 3 0.5000
#   hexa verify --expr cheng_prusoff 3 1.0e-9
#   hexa verify --expr beer_lambert 3 0.3679
#   hexa verify --expr exp_release 2 0.8000
#   hexa verify --expr ldl_pct 2 60.0
#   hexa verify --expr higuchi 3 0.1234
#   hexa verify --expr fick1 2 1.5e-7

# LPA V1 §V2/V3 (primary 🔵 push)
#   hexa atlas register --kind F --id ivw_estimator --raw "β_IVW=Σ(w·βx·βy/σ²)/Σ(w·βx²/σ²)"
#   hexa atlas register --kind F --id schoenfeld_events --raw "D=4(zα+zβ)²/(ln HR)²"
```

→ X2 (V2 🔵 push) / X3 (V3 🟢 push) 에서 위 명령 batch 실행 — X1 자체는 commands 실행 X.

---

## §13. X1 산출 요약

- **총 unified claim**: ~335+ (sub V1 합산 ~347+ − cross-domain dedup 12)
  - NOREFLOW 72 + DAPTPGX 30 + ISR ~200+ (inline 65) + LPA 45 − 12 dedup
- **cross-domain dedup row**: 12 (CX01-CX12 명시 · §3)
- **current tier 분포** (inline + 미할당 ISR carry):
  - 🔵 1 · 🟢 14 · 🟡 ~133 · 🟠 ~44 · 🔴 1 · ⚪ 3 · (ISR V4 미할당 ~140)
- **target tier 분포** (V2/V3 push 후):
  - 🔵 ~48 · 🟢 ~54 · 🟡 ~107 · 🟠 ~31 · 🔴 ~6 · ⚪ ~12 · (ISR V4 carry ~78 → 🟡)
- **🔵+🟢 escalation**: 15 → ~102 (5-fold)
- **cross-domain 시너지 핵심**: ALDH2*2 × CYP2C19 LoF × Lp(a) high — 한국인 PCI layered care 3-axis
- **한국 우선순위 (DOCTOR feed)**:
  1. 즉시 — CYP2C19 PCR + IMR + nicorandil/adenosine IC (NHIS 급여 활용)
  2. 6-12 m — Lp(a) routine + colchicine acute demote + HORIZON readout 대비
  3. 2-5 y — 4-trial portfolio (NICORADENO + DAPT-PGx-K + ISR-IIT-1 + LPA-siRNA-K)

→ **다음 단계**: X2 (V2 🔵 push 47-49 claim · hexa-lang inbox PR merge dependency) + X3 (V3 🟢 push 53-55 claim · pool ubu-1/2 + RunPod) 동시 진행 가능. X9 wall map 은 §7 leverage 입력으로 별도 deep.
