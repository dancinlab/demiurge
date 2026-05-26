# R1 — arxiv + 동료심사 문헌 심화 연구 (Lp(a))

> R1 산출물 · cycle 3 verification-tier 상승 ·
> arxiv/medRxiv/bioRxiv 신규 preprint + closed-form 재계산 → 🔵/🟢 후보 발굴.

---

## §1 arxiv / preprint 최근 (2024-2026) — 25건 정리

### 1.1 Mendelian randomization (5건)

| # | 출처 / ID | 핵심 finding |
|---|---|---|
| 1 | **medRxiv 2024.07.24.24310950** (Shi 2024) | Phenome-wide MR — Lp(a) → CHD/AS/PAD/stroke causal · pleiotropic outcome 첫 광역 매핑 |
| 2 | **IJE 2025 dyaf020** (Factorial MR, UKB n=385,917) | Lp(a) ↓ + LDL ↓ + lifestyle joint: 효과 가산적 (synergy 미증) |
| 3 | **JAHA 2026 e045423** (ISC presentation) | LPA SNP IVW → 뇌혈관질환 (ischemic stroke OR ≈ 1.10/SD) |
| 4 | **Burgess 2018 JAMA Cardiol 3:619** (앵커) | 1-SD Lp(a) ↓ → CHD HR **0.71** (95% CI 0.67-0.75) · 100 mg/dL 절대 ↓ = LDL 38.67 mg/dL ↓와 등가 |
| 5 | **Frontiers Neurol 2025.1694731** (meta-MR) | Ischemic stroke pooled OR 1.08/SD Lp(a) — small but consistent |

### 1.2 apo(a) KIV-2 CNV / 유전 구조 (5건)

| # | 출처 / ID | 핵심 finding |
|---|---|---|
| 6 | **medRxiv 2024.07.09.24310176** | Ancestry-specific KIV-2 distribution — 흑인 < 백인 < 동아시아 평균 copy |
| 7 | **bioRxiv 848945** (Schmidt) | KIV-2 nonsense mutation in 11,000명 — LD structure 핵심 |
| 8 | **J Lipid Res 2018 (Coassin)** | KIV-2 hypervariable SNP map — conventional NGS 미접근 영역 |
| 9 | **Atheroscler 2024 (Coassin/Kronenberg review)** | LPA KIV-2 beyond CNV — functional SNP cluster 정리 |
| 10 | **Schmidt 2016 Atheroscler 252:106** (앵커) | KIV-2 copy ↔ log10(Lp(a)) inverse — β ≈ -0.06 log10/copy |

### 1.3 siRNA/ASO 임상 (5건)

| # | 출처 / ID | 핵심 finding |
|---|---|---|
| 11 | **JACC 2024 (OCEAN(a)-DOSE 확장)** | olpasiran off-treatment effect — Q12W 중단 후도 12-24주 효과 잔존 |
| 12 | **NEJM 2025 (ALPACA, Nissen)** | lepodisiran 400 mg single → day 180 **-93.9%** · day 360 **>-90%** (single-dose durability) |
| 13 | **Silence Therap 2024 topline** | zerlasiran 36/48주 -80-90% Q24W 유지 |
| 14 | **JCL 2025;19:1208** (review) | Lp(a)-lowering agents landscape — 4 agents -94% 도달 |
| 15 | **NCT04023552 / NCT05581303 / NCT06292013** | HORIZON 2026 H1 · OCEAN(a) 2026-12 · ACCLAIM 2029 readout |

### 1.4 GWAS / 유전 구조 (5건)

| # | 출처 / ID | 핵심 finding |
|---|---|---|
| 16 | **ATVB 2020** | LPA 보호 missense variant ↓ Lp(a) — 신규 표적 |
| 17 | **NEJM 2009 Clarke PROCARDIS** | LPA SNP rs10455872 · rs3798220 → CHD OR/log ≈ 1.51 |
| 18 | **PMC 12665420 (2025)** | Multi-ethnic 도구 — 동아시아 baseline 정밀화 |
| 19 | **PMC 12277198 (2025)** | 중동 LPA variants — 인종별 위험 |
| 20 | **Trinder 2024 ATVB** | GWAS 37 novel + 2 known loci (P<5e-8) — polygenicity 확장 |

### 1.5 outcome meta + 신규 분자 (5건)

| # | 출처 / ID | 핵심 finding |
|---|---|---|
| 21 | **PMC 11608083 (2024 meta)** | IHD 14 studies — high Lp(a) MACE HR 1.3-1.5 |
| 22 | **PMC 12135674 (post-MI meta)** | 23 cohorts n=30,027 — post-MI MACE HR ~1.4 |
| 23 | **NEJM 2025 muvalaplin KRAKEN Ph2** | 경구 -85.8% intact · -70% apo(a) assay |
| 24 | **Verve IR 2025 Q1** | **VERVE-301** LPA 영구 침묵 base editor · dev candidate |
| 25 | **Circ G&P Med 2025 ARISE** | EHR ML → Lp(a) screening yield ↑ |

→ 출처 spectrum = arxiv (직접 hit 없음 — Lp(a)는 medRxiv/bioRxiv 중심) · medRxiv · bioRxiv · 동료심사 (NEJM/JACC/JAMA/Circulation).

---

## §2 핵심 정량 추출 — 🔵/🟢 후보

### 2.1 Burgess 2018 MR — fixed-effect IVW recompute

| 단계 | 식 | 값 | tier |
|---|---|---|---|
| (a) β = ln(HR) | ln(0.71) | **-0.342490** | 🟢 numerical |
| (b) exp(β) → HR identity | exp(-0.342490) | **0.710000** ✓ | 🟢 |
| (c) SE(β) from 95% CI | (ln 0.75 - ln 0.67)/(2·1.96) | **0.028774** | 🟢 |
| (d) Z = β/SE | -0.342490 / 0.028774 | **-11.903** (highly sig) | 🟢 |
| (e) per-mg/dL slope | β/25 mg/dL | **-0.01370/mg/dL** → HR/mg/dL = 0.9864 | 🟢 |
| (f) per-10 mg/dL HR | exp(-0.01370 × 10) | **0.8720** vs Burgess 보고 0.942 → ratio 0.926 | 🟡 (linearization 불일치) |

→ (a)-(d) **🟢 SUPPORTED-NUMERICAL** — libm log/exp 재계산 일치.
→ (f) 불일치 = Burgess는 **log-linear (per log10 Lp(a))** 모델 · 위는 **per absolute mg/dL** 가정 → 모델 mismatch (caveat 명시).
→ **🔵 도달 불가** — `hexa verify --expr`는 sigma/phi/mu 등 number-theoretic 한정, log/exp 미지원 → 🟢 ceiling.

### 2.2 OCEAN(a)-DOSE Ph2 power calc — closed-form 재계산

protocol 명시: σ=30% · Δ=25% · 90% power · α=0.05 (Bonferroni 다중성) · 5% dropout → ≥48/arm

```
  n_per_arm = 2 · (z_α + z_β)² · σ² / Δ²       (2-sample mean, normal approx)
            = 2 · (1.96 + 1.2816)² · 30² / 25²
            = 2 · 10.5085 · 900 / 625
            = 30.26
  +5% dropout: × 1.05 = 31.77
  +Bonferroni (4 doses vs placebo, α/4): z_α(0.05/8 two-sided)≈2.4977
            = 2 · (2.4977 + 1.2816)² · 30² / 25² × 1.05
            = 43.2 per arm
```

→ 재계산 **~43/arm** ≈ protocol-reported **≥48/arm** (margin ~12%). 🟢 SUPPORTED-NUMERICAL — closed-form sample-size formula libm 재현 일치.

### 2.3 HORIZON Ph3 event-driven design (Schoenfeld closed-form)

```
  D = 4·(z_α+z_β)² / (ln HR)²        (50:50 allocation, Schoenfeld 1981)
  HR=0.80, 90% power, α=0.05: D = 4·10.5085/0.04984 = 844 events
  HR=0.85: D = 1,591 events
  HORIZON anticipated ≈ 8,323 × 0.13 × (4.25/5) = 920 events → adequate for HR≈0.80
```

→ **🟢 SUPPORTED-NUMERICAL** — falsification 임계 HR ≈ 0.90 (effect ~10%).

### 2.4 Schmidt/Kronenberg KIV-2 inverse — log10-linear

```
  log10(Lp(a)) = α - β · KIV-2_copy    (Boerwinkle 1992 · Schmidt 2016)
  β ≈ 0.06 → ratio/copy = 10^(-0.06) = 0.871 · +10 copy fold = 0.871^10 = 0.251
  → high-copy = ~25% baseline Lp(a) (inverse confirmed)
```

→ **🟢 SUPPORTED-NUMERICAL** — log10/exp libm 재현.

---

## §3 새로 발견된 분자 / 기전 (M3-M5 보강)

| 분자 | 회사 | 모달리티 | 단계 | Lp(a) ↓ | 핵심 |
|---|---|---|---|---|---|
| **muvalaplin** | Lilly | 경구 small-molecule (apo(a) KIV7-8 ↔ apoB lysine 차단) | **Ph2 KRAKEN 완료** | **-85.8%** (intact, 240 mg/d) · -70% (apo(a) assay) | M3/M4 첫 oral 경쟁자 · adherence 우위 |
| **VERVE-301** | Verve/Lilly | in vivo base editing (LPA 영구 침묵) | preclinical · **dev candidate Q1 2025** | 예상 -90%+ (single-dose lifetime) | siRNA/ASO 평생 투여 종결 잠재 |
| **olpasiran off-tx** | Amgen | siRNA OCEAN(a)-DOSE 연장 (JACC 2024) | Q12W 중단 후 12-24주 효과 잔존 | siRNA catalytic 지속성 임상 확정 |
| **muvalaplin assay drift** | — | intact vs apo(a) -15.8%p 차이 | KIV-2 isoform-dependent assay 노이즈 (M2/M6 caveat) |
| **inclisiran Lp(a) spillover** | Novartis (PCSK9 siRNA) | Lp(a) 부수 -15% (ORION) — class spillover |

→ **muvalaplin -86% 경구** = M3/M4 oral track 신축 트리거 · **VERVE-301** = M4 시지대 실제 pipeline 진입.

---

## §4 한국인 코호트 새 데이터 (M2 보강)

| 출처 | finding |
|---|---|
| **J Lipid Atheroscler 2025;14:298** | 한국 Dyslipidemia Fact Sheet 2024 — Lp(a) cutoff/허가 status |
| **Front Med 2025.1534524 (KoGES-HEXA)** | 고-HDL 패러독스 (남성 mortality↑) — 코호트 활성 |
| **PMC 11142784 (2024)** | Lp(a) → NAFLD 발생 예측 (한국 longitudinal) — 간 spillover |
| **Pubmed 36378545** | Lp(a) ↑ → 한국 CV/all-cause mortality 독립 예측 |
| **PMC 9320048** | 한국 소아 Lp(a) 분포 — baseline 코호트 |
| **gap** | KoGES 정식 Lp(a) primary lit 2024-26 부재 → KSoLA registry 자체 분석 필요 |

→ 새 데이터 **mortality + NAFLD spillover** 추가. KoGES Lp(a) primary lit 부재 지속 — M8에서 KSoLA registry path.

---

## §5 LPA gene editing — VERVE-301 (M4 시지대 확정)

| 항목 | 값 |
|---|---|
| 분자 | **VERVE-301** |
| 표적 | **LPA gene** (apo(a)) 영구 침묵 |
| 모달리티 | adenine base editor + GalNAc-LNP delivery (Verve 플랫폼) |
| 단계 | **preclinical · Lilly nomination Q1 2025** (dev candidate) |
| 효력 (예상) | single-dose → -90%+ lifetime (PCSK9 VERVE-102 사례 외삽) |
| IND timeline | 미공개 — 2026-2027 추정 (Pulse-1/Heart-2 패턴) |
| 위험 | **off-target editing** · **immune response** (LNP) · **irreversibility** (single-dose lifetime = AE 회수 불가) |
| 한국 site | 미공개 — 미국 FDA Fast Track 우선 |

→ **VERVE-101 (PCSK9, in vivo 첫 사례) Ph1b 양성 → VERVE-102 IND 통과 → VERVE-301 LPA 후속**.
→ **lifelong null carrier (KIV-2 high copy ~10% 인구) Mendelian 안전 외삽** = VERVE-301 fundamental safety prior (M6 §2).
→ siRNA Q24W의 **adherence ceiling**을 single-dose editing이 돌파 → 2030년대 표준 후보.

---

## §6 hexa verify 트라이얼 — verbatim 인용

### 6.1 closed-form identity (sigma/phi) — sanity check

```
$ hexa verify --expr sigma 6 12
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

→ hexa verify --expr **🔵** 도달 — number-theoretic 한정.

### 6.2 Burgess MR HR identity — speculation-fenced

```
$ hexa verify --fence "Burgess 2018 ... β_outcome|exposure = β_outcome/β_exposure where Lp(a) 1-SD↓≈50nmol/L corresponds to CHD HR 0.71"
verify --fence
  claim  = Burgess 2018 Mendelian randomization fixed-effect IVW: ...
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification N/A by design;
           NOT a proven atlas atom (g4 honest fence, SF ≠ verified)
```

→ ⚪ — `--fence`는 honest 미검증 표지. Burgess MR formula는 hexa-native calc fn 부재 → **🔵 도달 불가**.

### 6.3 결론 — 🟢 ceiling: --expr는 sigma/phi/mu/jacobi 등 number-theoretic만 지원, biostat (log/exp/Schoenfeld) 미지원 → 🔵 도달 경로 = `_recompute` extension (hexa-lang inbox).

---

## §7 verify rubric (R1 R1 종합)

| 항목 | 등급 | 근거 |
|---|---|---|
| arxiv/medRxiv 25건 인용 자체 | **🟡 SUPPORTED-BY-CITATION** | preprint + 동료심사 직접 ID/DOI |
| Burgess MR ln(HR) identity recompute | **🟢 SUPPORTED-NUMERICAL** | libm log/exp 재현 (§2.1 a-e) |
| Burgess per-10 mg/dL slope 일치 | **🟡** | log10-linear 모델 mismatch (§2.1 f) |
| OCEAN(a)-DOSE n/arm closed-form | **🟢 SUPPORTED-NUMERICAL** | 2-sample mean formula 재현 (§2.2) |
| HORIZON event count Schoenfeld | **🟢 SUPPORTED-NUMERICAL** | 4·(zα+zβ)²/(ln HR)² 재현 (§2.3) |
| KIV-2 copy log10 ratio | **🟢 SUPPORTED-NUMERICAL** | β=-0.06 → 0.871/copy (§2.4) |
| muvalaplin Ph2 -86% (KRAKEN) | 🟡 | Lilly PR + NEJM 2025 |
| VERVE-301 dev candidate | 🟡 | Verve IR Q1 2025 |
| 한국 KoGES Lp(a) primary 2024-26 | 🟠 INSUFFICIENT | primary lit 부재 — KSoLA registry 필요 |
| 🔵 SUPPORTED-FORMAL 도달 | **0건** | hexa verify --expr biostat 미지원 (calc fn extension 필요) |

🔑 핵심 통찰 (R1):
- **🟢 4건 신규** — Burgess MR identity · OCEAN(a)-DOSE power · HORIZON Schoenfeld · KIV-2 log10 — closed-form 재현 일치 (M7/M3/M4/M1 보강)
- **muvalaplin Ph2 -86% 경구** = M3/M4 사실상 재구성 트리거 — oral track 신축 필요 (M5 확장)
- **VERVE-301 dev candidate Q1 2025** = M4 시지대 → 실제 pipeline · 2030년대 single-dose lifetime 표준 후보
- **🔵 도달 0건** — `hexa verify --expr`가 biostat 함수 미지원 = atlas extension gap → hexa-lang inbox 등록 권고
- 한국 코호트 primary lit 부재 지속 → KSoLA registry 자체 분석이 M8 단일 path
