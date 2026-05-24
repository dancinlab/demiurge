# TTR-MN v5 R&D paths — physical floor (2개월) 우회 가능성

> milestone: v5 path · v4 physical floor (격일 × 2개월) 보다 더 단축 가능 R&D 후보
> driver: physical floor wall (SC + macrophage + amine clearance) 우회 가능성 탐색 · long-term R&D
> base: timeline_compression_paths.md (4축 sweep · v4 floor) 위 5 우회 path

## TL;DR

v4 (격일 2개월 physical floor) 우회 = **5 R&D paths**: ① enzyme directed evolution (K_cat 10×) · ② macrophage chemotaxis 가속 (체감 timeline) · ③ micro-bubble cavitation (sono + MN) · ④ multi-stage cocktail · ⑤ gene therapy one-shot. timeline 목표: **2주-1개월** (v4 2mo 보다 2-4× 빠름) · 그러나 R&D 1-3년 + 비용 $5-50M (Phase 2-3 별 트랙).

## §1 5 R&D paths overview

| path | mechanism | timeline target | R&D 기간 | cost (R&D + Phase) |
|---|---|---|---|---|
| **A. enzyme directed evolution** | AzoR/DyP K_cat 10× boost | 1mo (15→8 cycle) | 1-2yr | $3-5M |
| **B. macrophage chemotaxis ↑** | lymph drainage 가속 (체감 timeline) | 2mo nominal · 1mo 체감 | 1-1.5yr | $2-3M |
| **C. micro-bubble cavitation (sono + MN)** | ultrasound bubble + MN deposition combo | 1mo | 1-2yr | $3-4M |
| **D. multi-stage cocktail** | cycle 마다 다른 payload (saturation 회피) | 1.5mo | 6mo-1yr | $1-2M |
| **E. gene therapy one-shot** | AAV-delivered azoreductase (in-situ enzyme) | 1회 (단일 시술) | 3-5yr | $20-50M |

⇒ A/B/C/D = incremental (v4 + R&D) · E = paradigm shift (one-shot · 별 modality)

## §2 Path A — enzyme directed evolution (K_cat 10×)

### Mechanism

```
   wild-type AzoR K_cat ~ 10² s⁻¹
        ↓ directed evolution (yeast surface display + FACS)
        ↓ 10-20 round selection
   engineered AzoR K_cat ~ 10³ s⁻¹ (10× boost)
        ↓
   per-cycle x boost: 14% × 1.5 = 21%
        ↓
   N for 90%: (1-0.21)^N = 0.1 → N=10
        ↓
   격일 × 10 cycle = 35일 ≈ 5주 = 1.2mo ★
```

### 실현성

- Yeast surface display: Cetuximab 등 임상 precedent
- Random mutagenesis + selection: 1-2년 R&D
- Cost: lab + screening ~$2-3M
- Phase 1 추가 dose escalation: $1-2M
- ★ **best return** (incremental investment + significant boost)

## §3 Path B — macrophage chemotaxis ↑ (lymph drainage)

### Mechanism

```
   normal: 잉크 분해 후 macrophage → 림프 → 배출 (3-7일)
        ↓ chemotaxis agonist (e.g., S1P agonist · CCL19 mimetic)
        ↓ recruit + 가속 drainage
   체감 timeline 가속:
        - 실제 분해 동일 (v4 2mo)
        - 가시적 사라짐 가속 (배출 빠름)
        - 사용자 만족도 ↑ (체감 1mo)
```

### 실현성

- S1P agonist (fingolimod 등): FDA-precedent (MS)
- 격일 patch + 림프 drainage 보조 (micro-stim?)
- R&D 1-1.5년 · $2-3M

## §4 Path C — micro-bubble cavitation (sono + MN combined)

### Mechanism

```
   격일 cycle에 sono (저주파 1 MHz) 추가:
        ↓ micro-bubble cavitation in skin
        ↓ MN deposition + payload spread enhancement
        per-cycle x boost ~30% (literature: sonophoresis 10-30× depth)
   ↓
   v4 14% × 1.3 = 18%
   N for 90%: 12 cycle
   격일 × 12 = 42일 ≈ 1.4mo ★
```

### 실현성

- Sontra ultrasound device (FDA-cleared · home use)
- MN + sono 결합 — 임상 precedent 부족 (별 R&D)
- safety: cavitation in dermis (controlled vs uncontrolled?)
- R&D 1-2년 · $3-4M

## §5 Path D — multi-stage cocktail (saturation 회피)

### Mechanism

```
   v4 same payload 격일 → cycle 누적 시 saturation:
        - macrophage M1 over-activation
        - aromatic amine 누적
        - patient adherence drop
   ↓
   multi-stage cocktail (cycle 마다 다른 payload):
        cycle 1: AzoR + ascorbate (reductive)
        cycle 2: DyP + DFO (oxidative + chelation)
        cycle 3: CeO₂ + photo (nanozyme + photo-Fenton)
        cycle 4: TLR7/8 + macrophage refresh
        cycle 5: AzoR (재돌입 · saturation 회피)
        ...
   ↓
   per-cycle x boost: orthogonal mechanism rotation → 17%
   N for 90%: 12 cycle · 격일 × 12 = 42일 = 1.4mo ★
```

### 실현성

- SKU multiplication (5 different patches)
- Production cost ↑ (별 batch per SKU)
- 사용자 schedule 복잡 (cycle 1/2/3/... rotation)
- R&D 6mo-1년 · $1-2M (incremental)
- ★ **fastest R&D** (same payload base · new combinations)

## §6 Path E — gene therapy one-shot (paradigm shift)

### Mechanism

```
   AAV-mediated gene therapy:
        ↓
   AAV (skin-tropic · serotype 6) + AzoR/DyP gene
        ↓
   single intradermal injection (1회)
        ↓
   in-situ enzyme expression (1-3 month duration)
        ↓
   continuous local cascade (no cycle needed)
        ↓
   잉크 분해 + 자연 클리어런스 (3-6 mo total)
```

### 실현성

- AAV gene therapy: Luxturna · Zolgensma 등 FDA-approved
- Skin-tropic AAV serotype: AAV6, AAV9
- Risk: 영구 enzyme expression (off-target · immune response)
- R&D 3-5년 · $20-50M Phase 1-2
- Regulatory: BLA (biologics) vs IND (small molecule) 차이
- ★ paradigm shift — 별 트랙 (long-term R&D)

## §7 우선순위 ranking (R&D cost vs timeline boost)

```
   Phase 2 candidate path ranking:
   ────────────────────────────────────
   ★★★★ D. Multi-stage cocktail (fastest R&D · $1-2M · 6mo · timeline 1.4mo)
   ★★★ A. Directed evolution (K_cat 10× · $3-5M · 1-2yr · timeline 1.2mo)
   ★★ C. Micro-bubble sono (combo device · $3-4M · 1-2yr · timeline 1.4mo)
   ★★ B. Chemotaxis ↑ (체감 · $2-3M · 1-1.5yr · 실제 동일 2mo)
   ★ E. Gene therapy (paradigm · $20-50M · 3-5yr · one-shot)
```

⇒ **Phase 2 우선**: D (cocktail) · 그 후 A (directed evolution) · 그 후 C/B/E 별 R&D 트랙

## §8 통합 timeline view (v1 → v5)

| version | timeline | mechanism | R&D | cost (treatment) |
|---|---|---|---|---|
| v1 | 5yr | baseline (single AzoR) | done | $1.2-2.4k |
| v2 | 1yr | frequency only | done | $1.0k |
| v3 | 4.5mo | density + cascade | $620k IND | $627 |
| v4 | 2mo (floor) | + photo + TLR7/8 | $1.4M | $705 |
| **v5-D** (cocktail) | **1.4mo** | cycle 마다 다른 payload | $1-2M extra | $750 (5 SKU) |
| **v5-A** (evolution) | **1.2mo** | engineered enzyme | $3-5M extra | $800 |
| v5-E (gene tx) | **1회** (3-6mo natural) | AAV in-situ enzyme | $20-50M | $5-10k (gene tx) |

## §9 honest unknowns

- Path D rotation 실제 saturation 회피 정합 (Hypothesis)
- Path A K_cat 10× 달성 확률 (yeast display screen 1-2 yr)
- Path C cavitation safety in dermis (controlled bubble size)
- Path B chemotaxis 실제 visual fade 효과 (subjective)
- Path E AAV skin immune response (clinical precedent 부족)

## §10 진행 상태

- ✅ 5 R&D paths defined (A/B/C/D/E)
- ✅ Mechanism + timeline + R&D cost + 우선순위
- ✅ Phase 2 candidate priority (D > A > C/B > E)
- ✅ v1-v5 통합 timeline view
- next (별 작업): Path D multi-stage cocktail design (별 R&D 트랙 · Phase 2 prerequisite)
