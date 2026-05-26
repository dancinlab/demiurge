# TTR-MN v5-E — gene therapy (AAV-mediated in-situ enzyme · 1회 시술)

> milestone: v5 path E · paradigm shift (one-shot · 분해 자동) · long-term R&D
> driver: 반복 patch cycle → 단일 시술로 변경 · 3-6mo 자동 분해
> base: v5_rd_paths_physical_floor_bypass.md (Path E overview) 위 detailed

## TL;DR

**AAV6/9 skin-tropic vector + AzoR/DyP gene cassette** → 단일 intradermal 시술 → **in-situ enzyme expression 1-3개월** → 잉크 자동 분해 + natural drainage **3-6개월 total**. 1회 시술 (vs v4 15회) · paradigm shift. R&D 3-5년 · $20-50M · Phase 1/2/3 별 트랙. Luxturna/Zolgensma 선례.

## §1 mechanism

```
   v4 single patch cycle (15회 격일):
   ─────────────
   Day 0/3/7/.../52 cycle
        ↓
   각 cycle 마다 fresh payload (enzyme · NP)
        ↓
   2개월 90% 분해
   
   v5-E AAV gene therapy:
   ─────────────
   Day 0: single intradermal injection
        ↓
   AAV6 transduces dermal cells (~10⁴-10⁵ per cm²)
        ↓
   AzoR/DyP gene cassette (CMV promoter · ITR flanked)
        ↓
   1-2 weeks: protein expression detectable
        ↓
   ★ in-situ enzyme expression (3-month duration · self-clearance)
        ↓
   잉크 + endogenous H₂O₂/NADPH → 자동 cascade
        ↓
   3-6 month: 90%+ removal (natural macrophage drainage)
```

## §2 AAV vector design

### Serotype selection

| AAV serotype | tropism | precedent | TTR fit |
|---|---|---|---|
| **AAV6** | skin · muscle | various R&D | ★★★ primary |
| AAV9 | broad (CNS · liver) | Zolgensma · Luxturna | broad · less skin-specific |
| **AAV-DJ** | skin · liver hybrid | engineered serotype | ★★ secondary |
| AAV-Anc80 | broad | Beam · Chroma | ★ research |
| AAVrh10 | various | research | ★ |

⇒ **primary: AAV6** (skin-tropic precedent) · secondary: AAV-DJ

### Cassette design

```
   5'-ITR — CMV promoter — AzoR gene — IRES — DyP gene — bGH polyA — 3'-ITR
       │           │              │       │          │
       AAV         constitutive   azo    bicistr     stable
       packaging   expression     attack            transcript
       
   variant: TRE (tetracycline-responsive) for switchable expression (safety)
   variant: tissue-specific promoter (keratin K14 · stratum-basale-restricted)
```

## §3 dose + delivery

| param | spec |
|---|---|
| AAV titer | 10¹⁰-10¹¹ vg/cm² (vector genome per cm²) |
| Injection volume | 100 μL per cm² (intradermal · 30G needle) |
| Injection pattern | 5×5 grid per cm² (transduction uniformity) |
| Tattoo area | typical 5-50 cm² (multi-injection 25-250 sites) |
| Total dose | small tattoo: 5×10¹¹ vg · large: 5×10¹² vg |
| Cost per dose | $5,000-15,000 (AAV manufacturing scale) |

## §4 timeline

```
   Day 0: AAV intradermal injection
   Day 1-7: transduction (AAV → cells)
   Day 7-14: gene expression ramp-up
   Day 14-30: peak enzyme expression
   Day 30-90: continuous enzyme · 잉크 분해
   Day 90-180: ★ 잉크 90% removal · enzyme clearance
   ─────────────
   total visible: 3-6 mo (1회 시술)
   user burden: 1 visit (vs v4 15회 patch · 2개월)
```

## §5 비용 + economic

| component | cost (per treatment) |
|---|---|
| AAV manufacturing (GMP · single dose) | $5,000-15,000 |
| Clinical injection (medical office) | $500-1,000 |
| Pre/post-treatment monitoring | $300-500 |
| **per-treatment total** | **$6,000-17,000** |

⇒ v4 $705 → v5-E $6-17k · **8-24× 비용 ↑**

### Insurance / market

- gene therapy 가격대 (Luxturna $850k · Zolgensma $2.1M)
- TTR-MN-Gene 가격대: $5-15k (재발성 melanoma 등 별 indication 정합 시 보험)
- 자가 비용 시장: cosmetic premium 단일 시술

## §6 R&D + Phase 1/2/3

| phase | task | duration | cost |
|---|---|---|---|
| Preclinical | AAV6 + cassette engineering · vector lot | 12mo | $3M |
| Preclinical | in-vivo Tier 2 (mini-pig) · single-dose | 9mo | $4M |
| Preclinical | toxicology + biodistribution | 12mo | $5M |
| **Phase 1** | n=12 dose escalation · 6mo follow | 12mo | $8-12M |
| **Phase 2** | n=80 efficacy · 6mo | 18mo | $15-25M |
| **Phase 3** | n=300 · 12mo | 24mo | $30-50M |
| **합계 (BLA filing)** | | **5-6yr** | **$65-100M** |

⇒ paradigm shift · long-term R&D · biotech-scale funding

## §7 safety + risks (gene therapy specific)

| risk | likelihood | mitigation |
|---|---|---|
| AAV systemic spread | mid | intradermal · skin-restricted vector design |
| Insertional mutagenesis | low (AAV episomal) | self-limiting expression (3-month duration · genome integration low) |
| Immune response to AAV capsid | mid-high | pre-screening for anti-AAV antibody (subject exclusion · ~30%) |
| Off-target enzyme expression | mid | tissue-specific promoter (K14 · basal layer only) |
| Long-term enzyme expression (chronic Fenton) | low-mid | self-limiting (episomal · 3-month decay) |
| Tumorigenicity | low | episomal · short-lived |
| Regulatory complexity | high | BLA · ICH-GTP · ICH-GMP-GT |

⇒ Phase 1 cohort: anti-AAV6 antibody screening · careful dose escalation

## §8 stop-go decision (per phase)

| Phase | gate | next |
|---|---|---|
| Preclinical | mini-pig efficacy ≥ 70% + safety | Phase 1 |
| Phase 1 | n=12 safety + biomarker | Phase 2 |
| Phase 2 | n=80 efficacy ≥ 85% · safety | Phase 3 |
| Phase 3 | n=300 efficacy · safety · pivotal | BLA filing |
| BLA | FDA approval | post-market |

## §9 marketing pitch (v5-E TTR-Gene)

```
🧬 TTR-MN-Gene — "한 번 주사 + 자동 분해"

- 1회 시술 (vs v4 15회 patch)
- 3-6개월 자연 분해 (1회 visit · 2개월 patch 부담 없음)
- $6-15k per treatment (premium gene therapy 가격)
- 멜라노마 등 별 indication (보험 시 cosmetic 가격)
- AAV6 skin-restricted (전신 회피)
- 3-month enzyme expression · self-limiting
```

⇒ paradigm shift product · 별 시장 segment

## §10 honest unknowns

- AAV6 skin transduction efficiency in human (in-vivo 검증 필수)
- 3-month enzyme expression in human tissue (episomal stability)
- 잉크 분해 by enzyme alone (without separate H₂O₂/NADPH supply)
- AAV6 pre-existing antibody prevalence (population ~30-40%)
- Insurance reimbursement (cosmetic vs medical)
- Long-term safety (5-yr post-market registry)
- Pediatric eligibility (gene therapy ethics)

## §11 cumulative R&D portfolio (v1-v5)

| version | mechanism | timeline | R&D total | viable? |
|---|---|---|---|---|
| v1 | single patch monthly | 5yr | done | ✅ |
| v2 | weekly frequency | 1yr | done | ✅ |
| v3 | density + cascade | 4.5mo | $620k IND | ✅ |
| v4 | + photo + TLR7/8 | 2mo | $1.4M | ✅ |
| v5-A | engineered enzyme | 1.2mo | +$3-5M | ✅ |
| v5-B | chemotaxis (visible) | 1mo 체감 | +$1.7-2M | ✅ |
| v5-C | + sonophoresis | 1.3mo | +$2.7-3M | ✅ |
| v5-D | cocktail rotation | 1.4mo | +$1.1M | ✅ |
| **v5-E** | **gene therapy** | **3-6mo (1회)** | **+$65-100M** | **paradigm** |

⇒ v5-E = long-term R&D (5-6yr) · 별 트랙

## §12 진행 상태

- ✅ AAV6 vector design (cassette · ITR · promoter)
- ✅ Dose + delivery protocol (10¹⁰-10¹¹ vg/cm² · intradermal grid)
- ✅ Timeline (3-6mo · 1회 시술)
- ✅ Cost analysis ($6-17k · premium gene therapy)
- ✅ R&D plan (5-6yr · $65-100M)
- ✅ Safety profile (AAV-specific risks + mitigation)
- ✅ Cumulative v1-v5 portfolio (5 paradigm levels)
- next: v5 integration ledger (final 정리 · 5 paths 분석)
