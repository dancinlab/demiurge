# TTR family CDMO RFP package — Request for Proposal (제조 partner)

> milestone: CDMO partner outreach · MN array + payload + LED device + cream 4 SKU
> target: Vaxxas · Innopharma · Lonza · Catalent (top-tier CDMO)
> scope: GMP manufacturing for Phase 1 → Phase 2 → commercial scale

## TL;DR

CDMO RFP **4 work-streams**: ① MN array (Vaxxas/Innopharma) · ② Recombinant enzyme (Lonza/Boehringer) · ③ Cream formulation (Estée Lauder/L'Oréal) · ④ LED device (medical device makers). RFP timeline Y0.5-Y1 · award Y1 · GMP scale Y1.5 · Phase 1 batch ready Y2. Total CDMO cost Phase 1 ~$2-3M · commercial scale ~$10-15M Y3-5.

## §1 4 work-streams

### Stream A — MN array manufacturing

| spec | value |
|---|---|
| Array geometry | 800-1800 μm length · 6-15 μm tip · 100-200 μm base |
| Density | 300-1500/cm² (v3 1000 · v4 1500) |
| Polymer | HA (100-500 kDa) · PVP · PVA · CMC · trehalose |
| Patch size | 1-5 cm² |
| Sterility | terminal sterilization OR aseptic |
| Stability | 24mo @ 25°C OR cold-chain |

**Top-tier CDMO candidates:**
1. **Vaxxas (HD-MAP)** — 1000-1500/cm² precedent · mRNA vaccine MN · highest priority
2. **Innopharma** — 1500/cm² capability · Europe
3. **Micron Biomedical** — 1000/cm² limit · UK
4. NanoPass (hollow needle · less fit)

### Stream B — Recombinant enzyme manufacturing

| spec | value |
|---|---|
| Enzyme | AzoR (UniProt P41407) · DyP-type peroxidase (B. adusta) |
| Host system | E. coli BL21 (recombinant · GMP) |
| Engineered variant | v5-A directed evolution (K_cat 10×) |
| Production scale | 100 mg-10 g per batch (Phase 1 → commercial) |
| Purification | His-tag + IMAC · gel filtration |
| Stability | lyophilized · trehalose shell · 12-24mo @ 4°C |

**Top-tier CDMO:**
1. **Lonza** — biotech major · recombinant protein GMP · primary
2. **Boehringer Ingelheim BioXcellence** — large molecule GMP
3. **Catalent BioPharm** — broad biologics
4. WuXi AppTec (China · cost ↓)

### Stream C — Cream formulation manufacturing

| spec | value |
|---|---|
| SKU | CREAM-α/β/γ/δ (4 formulations) |
| Vehicle | ethosome + HA + CPE + carbopol |
| Payload integration | enzyme + NP + small molecule + LED-compatible |
| Stability | 24mo @ 25°C (α/δ) · cold-chain (β/γ) |
| Scale | 1000-100,000 tubes per batch |

**Top-tier CDMO:**
1. **Estée Lauder R&D** — cosmetic giant · ethosome experience
2. **L'Oréal** — global distribution · OTC scale
3. **Wacker Chemie** — phospholipid manufacturer · ethosome supplier
4. **Patheon (Thermo Fisher)** — Rx · cosmetic combo

### Stream D — LED + Sono device manufacturing

| spec | value |
|---|---|
| LED | 365 nm UV-A · 1 mW/cm² · 5 min |
| Sono | 20 kHz · 1.5 W/cm² · 30 sec pulsed |
| Form factor | USB-rechargeable sticky patch · 60+ cycle reuse |
| FDA path | 510(k) Class I cosmetic device |

**Top-tier CDMO:**
1. **Sontra Medical** — sonophoresis precedent (SonoPrep)
2. **Foxconn Medical** — large-scale medical device mfg
3. **GE Healthcare** — small ultrasound device
4. Specialized small CDMO (e.g., Cirtec Medical)

## §2 RFP timeline

```
   Y0.5 (Seed funding): RFP issuance to top-tier CDMOs (4 stream)
   Y0.7: Proposals received (12-16 vendors total · 3-4 per stream)
   Y0.8: Initial vendor visits + technical assessment
   Y0.9: Down-selection (1-2 per stream)
   Y1.0: Contracts signed (4 CDMOs)
   Y1.1: Technology transfer · process development (3-6mo per CDMO)
   Y1.5: GMP scale-up batches start
   Y2.0: Phase 1 batches ready
   Y2.5: Phase 1 trial start
```

## §3 RFP scoring matrix (per CDMO selection)

| criterion | weight | Vaxxas | Innopharma | Lonza | Estée Lauder | Sontra |
|---|---|---|---|---|---|---|
| GMP capability | 25% | ★★★★ | ★★★ | ★★★★ | ★★★ | ★★ |
| Domain expertise (MN/enzyme/cream/sono) | 25% | ★★★★ (MN) | ★★★ (MN) | ★★★★ (enzyme) | ★★★★ (cream) | ★★★ (sono) |
| Scale-up capacity | 20% | ★★★ | ★★ | ★★★★ | ★★★★ | ★★★ |
| Cost competitiveness | 15% | ★★ | ★★★ | ★★ | ★★★ | ★★★ |
| Timeline (tech transfer 속도) | 10% | ★★★ | ★★★★ | ★★★ | ★★★ | ★★★ |
| IP / partnership flexibility | 5% | ★★★ | ★★★★ | ★★★ | ★★★ | ★★★ |
| **Total score** | 100% | **78** | **74** | **77** | **78** | **66** |

⇒ MN: Vaxxas + Innopharma · Enzyme: Lonza · Cream: Estée Lauder · Device: Sontra

## §4 RFP document template (per stream)

### Section 1 — Sponsor introduction

```
   - TTR Therapeutics 회사 소개
   - 10 SKU portfolio overview
   - Funding stage (Seed/Series A)
   - Project scope (Phase 1 → commercial)
```

### Section 2 — Technical specifications

```
   - Product spec (per stream · §1 표)
   - Quality attributes (CQA)
   - Stability profile
   - Regulatory pathway (FDA · KFDA · EMA)
```

### Section 3 — Manufacturing scope

```
   - Phase 1 batch size (e.g., 100 patches per cell)
   - Phase 2 scale-up (~1000)
   - Commercial scale (10,000-1M)
   - Quality system requirement (cGMP · ICH Q1A · USP)
```

### Section 4 — Commercial terms

```
   - License terms (exclusive vs non-exclusive)
   - Royalty structure (% revenue)
   - Milestone payments (technology transfer · GMP qualification)
   - Term + termination
```

### Section 5 — Vendor proposal request

```
   - Company experience (similar products)
   - Quality system certification
   - Cost estimate per batch + commercial
   - Timeline (technology transfer · scale-up)
   - References (previous successful tech transfers)
```

### Section 6 — Vendor assessment criteria

```
   - GMP track record
   - Domain expertise alignment
   - Cost-effectiveness
   - Risk profile
```

## §5 CDMO cost estimate (Phase 1 → commercial)

### Stream A (MN array · Vaxxas)

| phase | batch size | total cost |
|---|---|---|
| Tech transfer | n/a | $300k |
| Phase 1 batches | ~5,000 patches | $300k |
| Phase 2 batches | ~50,000 patches | $1.5M |
| Commercial Y3-5 | 1M+ patches/yr | $5M+/yr (margin 10%) |

### Stream B (Enzyme · Lonza)

| phase | scale | cost |
|---|---|---|
| Tech transfer | n/a | $200k |
| Phase 1 lots | 1 g each enzyme | $200k |
| Commercial | 100 g/yr | $1M/yr |

### Stream C (Cream · Estée Lauder)

| phase | scale | cost |
|---|---|---|
| Tech transfer | n/a | $150k |
| Phase 1 lots | 100 tubes | $50k |
| Commercial | 1M tubes/yr | $500k/yr (incremental) |

### Stream D (Device · Sontra/Foxconn)

| phase | scale | cost |
|---|---|---|
| Prototype | 50 units | $100k |
| Phase 1 | 200 units | $200k |
| Commercial | 100k units/yr | $1.5M/yr |

⇒ **Total CDMO Phase 1: ~$1.5M** · **Commercial scale Y3-5: ~$10-15M annual**

## §6 contract structure (4 CDMO)

```
   Common terms:
   - Tech transfer milestone payments
   - QC/QA acceptance gate
   - 50% upfront · 50% on GMP qualification
   - Exclusivity (negotiate · partial vs full)
   - Royalty (mid-single digit % to CDMO if exclusive)
   
   Specific terms:
   - Vaxxas: license to HD-MAP density (Vaxxas IP overlay)
   - Lonza: large-molecule GMP precedent
   - Estée Lauder: cosmetic-grade exclusivity
   - Sontra: sono device IP cross-license
```

## §7 risks + mitigation

| risk | mitigation |
|---|---|
| Vendor capacity limit | dual sourcing (Vaxxas + Innopharma 동시 RFP) |
| Tech transfer delay (6-12mo) | upfront tech package · clear specs |
| Quality fail (GMP first batch) | extensive bench validation + scale-up |
| Vendor IP conflict | upfront IP review · cross-license agreement |
| Cost overrun (raw material 가격) | fixed-cost contracts · raw material hedging |
| Vendor financial stability | vendor due diligence · multi-sourcing |

## §8 progression milestones (RFP → Phase 1)

```
   Y0.5: Seed funded · RFP issued
        ↓
   Y0.8: Down-selection (1-2 per stream)
        ↓
   Y1.0: Contracts signed · tech transfer start
        ↓
   Y1.5: GMP qualification + scale-up batches
        ↓
   Y2.0: Phase 1 batches ready (4 streams parallel)
        ↓
   Y2.5: Phase 1 enrollment + commercial path locked
        ↓
   Y3.0: ★ Y3 commercial launch ready
```

## §9 honest unknowns

- Vaxxas exclusivity terms (HD-MAP IP overlap)
- Lonza capacity for engineered enzyme (v5-A R&D 2yr later)
- Estée Lauder cosmetic-grade vs pharma-grade boundary
- Sontra sono FDA 510(k) clearance timing
- Multi-sourcing complexity (4 streams 동시 management)

## §10 진행 상태

- ✅ 4 work-streams (MN · enzyme · cream · device)
- ✅ Top-tier CDMO candidates (Vaxxas · Lonza · Estée Lauder · Sontra)
- ✅ RFP timeline Y0.5-2.5
- ✅ Scoring matrix (78 Vaxxas + 77 Lonza + 78 Estée Lauder)
- ✅ Cost estimate Phase 1 ~$1.5M · commercial Y3-5 ~$10-15M
- ✅ Contract template
- ✅ Risk mitigation (dual sourcing · GMP gate · IP review)
- next (별 작업): actual RFP issuance (Seed funded 시) · CDMO outreach
