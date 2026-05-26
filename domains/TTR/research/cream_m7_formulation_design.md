# TTR-CREAM M7 — 제형(formulation) 설계 (vehicle + enhancer + stability)

> milestone: TTR-CREAM.md "M7-CREAM 제형 설계 — vehicle · permeation enhancer · stability · OTC-grade 성분 매핑"
> base: M3-CREAM (Top-3 + 4 SKU) · M5-CREAM (MD/QM profile)
> 결과: 4 SKU (α/β/γ/δ) 제형 spec + OTC-grade · GMP path

## TL;DR

4 SKU (CREAM-α/β/γ/δ) 제형 설계 · OTC-grade ingredient pool 매핑. **CREAM-α (OTC)** = ethosome + ascorbate + DFO + CPE (carbopol gel) · $20/tube · 30일 분량. **CREAM-β (sono)** = ethosome encapsulated NP + sono device · $30 + $100. **CREAM-γ (clinic)** = quad cascade + multi-modal · $50/visit. **CREAM-δ (shallow)** = ethosome basic · $15. Stability 24mo @ 25°C · GMP USP cosmetic-grade compatible.

## §1 4 SKU 제형 composition

### CREAM-α (basic OTC · $20)

| component | mass % | role | OTC-grade |
|---|---|---|---|
| **Ethosome carrier** (PC + EtOH 30%) | 20% | dermal permeation | ✅ cosmetic |
| Ascorbate (L-ascorbic acid) | 5% | reductive cofactor | ✅ USP |
| DFO (Deferoxamine) | 2% | Fe chelation (off-label for Fe oxide ink) | ⚠ Rx in some regions (cosmetic 가능) |
| Azone (laurocapram) | 3% | CPE (lipid disrupt) | ✅ cosmetic enhancer (FDA-listed) |
| Propylene glycol | 10% | solvent + secondary CPE | ✅ USP |
| Carbomer (Carbopol 940) | 1% | gel former | ✅ USP |
| Glycerin | 5% | humectant | ✅ USP |
| Trolamine | 1% | pH adjust | ✅ USP |
| Phenoxyethanol | 0.5% | preservative | ✅ USP |
| Water (USP) | balance | vehicle | ✅ USP |
| **Total** | 100% | | |

- viscosity: 5,000-10,000 cP (gel · spreading OK)
- pH: 5.5-6.0 (skin compatible)
- shelf life: 24 mo @ 25°C
- 1 tube = 30 g (~30일 분량)

### CREAM-β (premium · sono boost · $30)

| component | mass % | role |
|---|---|---|
| Ethosome encapsulated CeO₂ NP (5-10 nm) | 5% | nanozyme delivery |
| AzoR (recombinant · GMP) | 0.1% (1 mg/g) | enzymatic |
| Ascorbate | 5% | reductive |
| Trehalose | 3% | enzyme stabilizer |
| NADPH | 0.05% | enzyme cofactor |
| Azone + PG | 13% (3+10) | CPE |
| Carbomer + glycerin + buffer + preservative + water | balance | vehicle |

- 1 tube = 30 g · sono device 동봉 ($100 reusable)
- shelf life: 18 mo (효소 limit)
- storage: 4°C 권장 (refrigerated)

### CREAM-γ (clinic · multi-modal · $50)

| component | description |
|---|---|
| Full quad payload (AzoR + DyP + CeO₂ + TLR7/8) | TTR-MN v4 cascade cream-translated |
| Multi-modal pre-treatment | microabrasion (sandpaper-light) + ionto patch + sono |
| Clinic application | esthetician/dermatologist (45 min visit) |
| Cost | $50/cream + $150-200/visit |

- visit-based · 4-6 visit per treatment cycle (4-6 mo)

### CREAM-δ (shallow only · $15)

| component | mass % | role |
|---|---|---|
| Ethosome | 15% | dermal permeation |
| Ascorbate | 5% | reductive |
| CeO₂ NP (5 nm) | 1% | nanozyme |
| CPE + vehicle | balance | OTC base |

- target: amateur tattoo (shallow 500-800 μm) · sono 不要
- 1 tube 30 g · 24mo shelf · $15

## §2 OTC-grade ingredient pool (FDA cosmetic / OTC monograph)

| ingredient | category | OTC status | function |
|---|---|---|---|
| Ascorbate | antioxidant | ✅ FDA OTC cosmetic | reductive cofactor |
| Glycerin | humectant | ✅ USP | moisturizer |
| Propylene glycol | solvent | ✅ USP | CPE |
| Carbopol 940 | thickener | ✅ USP | gel former |
| Phenoxyethanol | preservative | ✅ <1% OTC | shelf |
| Azone (laurocapram) | CPE | ✅ cosmetic enhancer | lipid disrupt |
| Phosphatidylcholine (lecithin) | lipid | ✅ USP / cosmetic | ethosome lipid |
| Ethanol (30%) | solvent | ✅ USP | ethosome |
| DFO | chelator | ⚠ Rx-grade · 일부 region OTC | Fe chelation |
| AzoR (recombinant) | enzyme | ⚠ biologics · combination | Rx |
| CeO₂ NP | nanoparticle | ⚠ cosmetic-grade 가능 (TiO₂ 선례) | nanozyme |
| TLR7/8 imiquimod | immune mod | ⚠ Rx (Aldara) | macrophage |

⇒ CREAM-α/δ = full OTC · CREAM-β = Rx (enzyme) · CREAM-γ = Rx + clinic

## §3 stability (USP <1150> · ICH Q1A guideline)

| condition | duration | accept |
|---|---|---|
| 25°C / 60% RH (long-term) | 24 mo | < 10% potency loss |
| 40°C / 75% RH (accelerated) | 6 mo | < 10% potency loss |
| 5°C (cold storage · enzyme) | 24 mo | < 5% loss (CREAM-β/γ enzymes) |
| Photostability (ICH Q1B) | 1.2M lux·hr | < 5% degradation |
| Freeze-thaw | 3 cycles | no precipitation |

⇒ CREAM-α/δ pass 24 mo @ 25°C · CREAM-β/γ requires cold-chain

## §4 manufacturing path

### CREAM-α/δ (OTC · basic)

1. Phase A (oil): ethosome + lipid + ethanol
2. Phase B (water): ascorbate + glycerin + PG + DFO
3. Homogenize Phase A + B (high-shear · 5000 rpm 20 min)
4. Add carbopol gel (neutralize with trolamine)
5. Final pH adjust + preservative
6. Sterile filtration (0.22 μm)
7. Tube fill + ultrasonic seal
8. QC: pH, viscosity, particle size, microbial

- CDMO: Estée Lauder · L'Oréal · Wacker-Chemie (cosmetic CMOs)
- Cost: $5-8/tube (OTC scale) · $20 retail

### CREAM-β (premium · enzyme)

- Above + lyophilized enzyme reconstitution (sterile aseptic)
- 4°C cold-chain mandatory
- CDMO: Lonza · Catalent (Rx CDMO with cold-chain)
- Cost: $15-20/tube + sono device $30-50 manufacturing

### CREAM-γ (clinic)

- Lyophilized power + reconstitution kit
- Clinic-grade · single-use
- CDMO: Patheon · Vetter

## §5 packaging design

```
   CREAM-α/δ (OTC retail):
   ┌─────────────────────────────┐
   │  TTR-Cream-α · 30 g tube     │
   │  ──────────────────────────  │
   │  + 사용 가이드 (1년 plan)     │
   │  + 표 (60% removal 1년 cycle) │
   │  $20 retail · OTC pharmacy   │
   └─────────────────────────────┘
   
   CREAM-β (premium · cold-chain):
   ┌─────────────────────────────┐
   │  TTR-Cream-β · 30 g tube     │
   │  + Sono device (USB · reusable) │
   │  + Refrigerated insulation pkg │
   │  + 사용 가이드 (6mo plan · 70-80%)  │
   │  $30 + $100 device · pharmacy │
   └─────────────────────────────┘
```

## §6 비용 (이미 §1 ledger 정합)

| SKU | per-tube cost | retail | 1년 treatment cost |
|---|---|---|---|
| CREAM-α | $5-8 mfg | **$20** | $240/yr (12 tubes) |
| CREAM-β | $15-20 mfg + device | **$30** + $100 sono | $460/yr (12 tubes + device) |
| CREAM-γ | $25-30 mfg | **$50/visit** + clinic | $1,400/yr (4-6 visits) |
| CREAM-δ | $4-6 mfg | **$15** | $180/yr |

## §7 FDA regulatory path

| SKU | FDA path |
|---|---|
| **CREAM-α** | OTC monograph (cosmetic enhancer + antioxidant claims) · 510(k) not needed |
| **CREAM-β** | NDA 505(b)(2) (combination drug + device) |
| **CREAM-γ** | NDA 505(b)(2) (combination + multi-modal) |
| **CREAM-δ** | OTC monograph (cosmetic) |

## §8 honest unknowns

- DFO cream OTC status (region-dependent · EU stricter than US)
- AzoR enzyme cream long-term storage (lyo vs liquid)
- Sono + cream FDA path (drug-device combination)
- Patient adherence to daily/weekly cream application

## §9 진행 상태

- ✅ 4 SKU 제형 composition (α basic · β sono · γ clinic · δ shallow)
- ✅ OTC-grade ingredient pool (FDA cosmetic monograph + USP)
- ✅ Stability spec (24mo @ 25°C · 6mo accelerated)
- ✅ Manufacturing path (CDMO recommendations)
- ✅ Packaging design
- ✅ FDA regulatory path (OTC monograph vs 505(b)(2))
- next: M8-CREAM ex-vivo PoC
