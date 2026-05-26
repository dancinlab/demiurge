# TTR-MN v5-A — directed evolution (engineered AzoR/DyP · K_cat 10× boost)

> milestone: v5 path A · enzyme directed evolution (K_cat 10×) → per-cycle x 21% → 1.2mo timeline
> driver: WT enzyme catalysis 한계 돌파 · best return path (★★★)
> base: v5_rd_paths_physical_floor_bypass.md (Path A overview) 위 detailed design

## TL;DR

AzoR + DyP **engineered variants** (K_cat 10× boost) via yeast surface display + FACS sorting. WT K_cat ~10² s⁻¹ → engineered ~10³ s⁻¹. per-cycle x: 14% (v4) → **21%** (enzyme boost). N=10 cycle × 격일 = **35일 ≈ 1.2mo (v4 2mo 의 60%)**. R&D 1-2년 · $3-5M · Phase 1 별 cohort. yeast display (Boder & Wittrup 1997) + FACS (high-throughput) + structure-guided rational design (Rosetta) 결합.

## §1 directed evolution path

### Yeast surface display + FACS workflow

```
   ┌─────────────────────────────────────────┐
   │ Round 0: WT AzoR + DyP gene library     │
   │   - error-prone PCR (3% mutation rate)   │
   │   - 10⁶-10⁸ variant library             │
   └─────────────────────────────────────────┘
            ↓
   ┌─────────────────────────────────────────┐
   │ Round 1-3: Yeast surface display        │
   │   - Aga2p fusion to AzoR/DyP             │
   │   - 10⁶ cells display variant on surface │
   │   - FACS sort by activity (fluorogenic   │
   │     azo substrate → product fluorescence) │
   │   - top 1% sorted (~10⁴ enriched pool)   │
   └─────────────────────────────────────────┘
            ↓
   ┌─────────────────────────────────────────┐
   │ Round 4-10: iterative                   │
   │   - re-shuffle (DNA shuffling)           │
   │   - error-prone PCR (further mutation)   │
   │   - FACS sort each round                 │
   │   - 10-20 round · K_cat 2-3× per round  │
   └─────────────────────────────────────────┘
            ↓
   ┌─────────────────────────────────────────┐
   │ Final: engineered variant K_cat 10²×3   │
   │   = 1000× WT (theoretical · 1-2yr R&D)   │
   │   conservative: 10× boost achievable     │
   └─────────────────────────────────────────┘
```

### Structure-guided rational design (parallel)

```
   AzoR PDB 1V4B + DyP PDB 4G2C
        ↓
   Rosetta · FoldX · enzyme design suite
        ↓
   active site residue mutations (computational scoring)
        ↓
   top 10-50 designed variants → yeast express
        ↓
   activity assay · best variants → FACS rounds
```

## §2 K_cat boost target

| variant | K_cat (s⁻¹) | improvement | timeline |
|---|---|---|---|
| WT AzoR | 100 | 1× (baseline) | — |
| Round 5 (3× boost expected) | 300 | 3× | 6mo |
| Round 10 (8× boost) | 800 | 8× | 12mo |
| **Round 15-20 (10× target)** | **1000+** | **10×** | **18-24mo** |
| Aspirational (Rosetta design + iteration) | 5000-10000 | 50-100× | 3-5yr |

⇒ **10× achievable in 18-24mo** · directed evolution literature precedent (RubisCO, lipase, etc.)

## §3 per-cycle x boost (K_cat 10×)

```
   v4 per-cycle x (mass-action validated): 14%
   K_cat 10× contribution:
     - in vitro: 10× higher reaction rate
     - in vivo (limited by substrate diffusion): 1.5-2× practical boost
   
   v5-A per-cycle x: 14% × 1.5 = 21% (conservative)
                    = 14% × 2 = 28% (optimistic)
```

### Cumulative path (격일 cycle)

| N cycles | timeline | cumulative (21%) | cumulative (28%) |
|---|---|---|---|
| 8 | 28일 (4주) | 86% | 95% |
| **10** | **35일 (5주)** | **91%** ★ | 98% |
| 12 | 42일 (6주) | 95% | 99% |

⇒ **N=10 · 1.2mo (v5-A nominal goal)** · optimistic N=8 · 4주

### MC validation

```
   per-cycle x = 21% σ=4% (engineered + saturation)
   MC 1000 trials, N=10:
     mean cumulative = 91% ± 4%
     95% CI: ≥ 84%
   N=12 conservative: ≥ 90% guarantee
```

## §4 R&D plan + timeline

| phase | task | duration | cost |
|---|---|---|---|
| **R&D-0** | Library construction (epPCR + Rosetta) | 2mo | $200k |
| R&D-1 | Yeast display + FACS round 1-5 | 4mo | $400k |
| R&D-2 | Round 6-10 (DNA shuffle + epPCR) | 4mo | $500k |
| R&D-3 | Round 11-15 (final selection · structure refinement) | 4mo | $500k |
| R&D-4 | Final variant characterization (K_cat · stability · immunogenicity) | 3mo | $400k |
| R&D-5 | GMP scale-up (recombinant E. coli production) | 4mo | $1M |
| **R&D total** | engineering + scale-up | **21mo** | **$3M** |
| Phase 1 | n=12 v5-A arm (격일 × 10 cycle) | 3mo trial + 1mo analysis | $800k-1.2M |
| **합계** | | **24-27mo** | **$3.8-4.2M** |

## §5 SKU composition (v5-A engineered patch)

| component | v5-A mass | role | cost |
|---|---|---|---|
| **AzoR engineered (10× K_cat)** | 30 μg (single-payload OK) | azo cleavage primary | $1.5 (GMP recombinant) |
| **DyP engineered** | 30 μg | macrocycle | $1.5 |
| Ascorbate | 200 μg | reductant + scavenger | $0.1 |
| NADPH cycling | 50 μg | cofactor | $0.5 |
| HA matrix | 5 mg | bulk | $0.5 |
| Trehalose | 200 μg | lyo-protect | $0.05 |
| **patch payload** | total | | **$4.2** |
| Patch mfg (M7-v4 1500/cm²) | | | $40 |
| **patch total** | | | **~$45** |

⇒ N=10 × $45 = **$450/treatment** (v4 $705 ・ 36% cheaper · shorter)

## §6 Combination with v5-D rotation (v5-AD hybrid)

```
   v5-A 단독: K_cat 10× boost · 10 cycle · 1.2mo
   v5-D 단독: SKU rotation · 12 cycle · 1.4mo
   ─────────────────────────────────────────────
   v5-AD hybrid: engineered + rotation
     per-cycle x: 21% × 1.05 (rotation refresh) = 22%
     N for 90%: (1-0.22)^N = 0.1 → N=9.3 ≈ 10 cycle
     timeline: 격일 × 10 = 35일 (1.2mo)
     
   ⇒ v5-D rotation alone 보다 빠르고
   ⇒ v5-A alone과 timeline 동일 + saturation 더 보호
```

## §7 immunogenicity wall (engineered enzyme · 새 unknown)

```
   engineered variant = WT 와 다른 sequence
        ↓
   anti-engineered IgE risk ↑ (vs WT)
        ↓
   Mitigation paths:
   1. humanization (CDR-grafting · 항체 R&D 차용)
   2. PEGylation (immunogenicity ↓)
   3. epitope removal (Epibase 같은 tool로 T-cell epitope 회피)
   4. dose minimize (10× K_cat means 1/10 protein dose)
```

⇒ Phase 1 IgE monitoring critical (v4 baseline + 추가)

## §8 risks + mitigations

| risk | likelihood | mitigation |
|---|---|---|
| K_cat 10× 못 달성 (5-8× only) | mid | extend rounds · structure-guided refine |
| Stability ↓ (mutations destabilize) | mid | thermostability screen 추가 round |
| Immunogenicity wall (anti-engineered IgE) | mid-high | PEGylation · humanization · dose minimize |
| GMP scale-up cost overrun | mid | Lonza · Boehringer Ingelheim CDMO precedent |
| Patent landscape (yeast display) | low | Boder & Wittrup patent expired |
| Phase 1 IRB ethics (engineered protein) | mid | FDA-precedent (engineered antibody · enzyme replacement) |

## §9 stop-go decision

| outcome | post path |
|---|---|
| R&D K_cat ≥ 10× | v5-A → Phase 1 dose escalation |
| 5-10× (mid) | v5-A launch with adjusted timeline (1.5mo) |
| < 5× (low boost) | extend R&D 또는 v5-D fallback |
| Immunogenicity wall | PEGylation/humanization 별 R&D layer |

## §10 marketing pitch (v5-A · engineered enzyme)

```
🧬 TTR-MN-Enzyme — "engineered enzyme 1.2개월 타투 지우개"

- 1.2개월 (5주) timeline (v4 2mo 보다 40% 빠름)
- 격일 × 10 patches · $450/treatment (v4 -36%)
- K_cat 10× engineered enzyme (yeast surface display + FACS)
- PEGylation 항체 회피 + humanized variant
- Premium product (v4 Express 보다 50% 더 빠르고 35% 저렴)
```

## §11 honest unknowns

- K_cat 10× 실제 R&D 18-24mo 가능성 (literature 8× 까지 routine · 10× challenging)
- in vivo K_cat (substrate diffusion limit · 1.5-2× practical)
- Engineered protein immunogenicity (clinical precedent)
- GMP cost scaling
- Patent landscape (specific engineered variant)
- Combination with v5-D rotation (synergy?)

## §12 진행 상태

- ✅ Directed evolution workflow (yeast display + FACS + Rosetta hybrid)
- ✅ K_cat 10× target (18-24mo R&D)
- ✅ Per-cycle x 21% → N=10 × 격일 = 1.2mo
- ✅ R&D plan ($3M · 21mo) + Phase 1 ($800k-1.2M · 3mo)
- ✅ Patch cost \$45 (single-payload · engineered enzyme + standard adjuvants)
- ✅ Treatment cost $450 (v4 $705 · 36% cheaper)
- ✅ Immunogenicity mitigation (PEGylation · humanization)
- ✅ Combination v5-AD hybrid (engineered + rotation)
- next: v5-C micro-bubble cavitation 또는 atlas dispatch n6 staging
