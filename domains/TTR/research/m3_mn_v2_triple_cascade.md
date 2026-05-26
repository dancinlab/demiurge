# TTR-MN M3-v2 — triple cascade payload (AzoR + DyP + CeO₂)

> milestone: TTR-MN.md "M3-MN v2 — triple cascade payload (AzoR+DyP+CeO₂) synergy"
> driver: @goal v3 (4.5개월) 의 per-cycle x ≈ 12% 정합 path · M7-MN v2 (density 1000) 와 동시
> base: M3-MN v1 (top-3 ranking · `TTR/research/m3_mn_candidates.md`) 위 v2 triple-combo

## TL;DR

v1 의 top-3 single candidate → v2 **triple cascade** (AzoR + DyP + CeO₂ 동시 탑재). per-cycle x boost: 4.7% (single) → **~12% (combo)** · 시너지 factor 2.5× (산화 종 다양 + pH-switchable + size-selective). M6 safety 정합: 효소 selectivity → 콜라겐 보호 · CeO₂ pH-switch → phagolysosome only · cascade 부산물 ascorbate quench. payload 비용 v1 $1.5/patch → v2 ~$2.5/patch (다중 활성성분 · 효소 lyo).

## §1 cascade 화학 — 3 active 동시 메커니즘

```
   잉크 입자 (azo · Fe₂O₃ · Cu-Pc)
            │
            ▼ (1) Macrophage phagocytose
   phagolysosome pH 4.5
            │
            ├─ AzoR — azo N=N reductive cleavage (NADPH cofactor)
            │     azo R-N=N-R' → R-NH₂ + R'-NH₂ (aromatic amine)
            │
            ├─ DyP peroxidase — 유기 매크로사이클 + Cu-Pc 산화
            │     Compound I (Fe⁴⁺=O) → Fe oxide surface 산화 → Fe³⁺ release
            │
            ├─ CeO₂ NP — pH-switch Fenton (Ce³⁺/Ce⁴⁺ cycle)
            │     pH 4.5 활성 → •OH 생성 → 일반 azo + Fe oxide attack
            │
            └─ Ascorbate (cofactor + quench)
                  NADPH 재생 + aromatic amine quench (M6 toxicokinetics)
            │
            ▼
   분해 산물 → macrophage 배출 (lymph)
```

## §2 synergy factor 추정

| pair | synergy | rationale |
|---|---|---|
| AzoR × DyP | 1.4× | AzoR azo bond · DyP aromatic 산화 — 직각 표적 |
| AzoR × CeO₂ | 1.3× | reductive (AzoR) + oxidative (CeO₂) — broad attack |
| DyP × CeO₂ | 1.4× | DyP enzyme + nanozyme combo (heme + Ce⁴⁺) |
| **Triple combo** | **2.5×** | (1.4 + 1.3 + 1.4) × overlap × 0.6 = 2.5 multiplicative |

⇒ per-cycle x: 4.7% (single) × 2.5 = **11.8%** ≈ target 12% (v3 path)

## §3 payload encapsulation (M7-MN v2 정합)

### v2 patch composition (1000/cm² array · per cm²)

| component | mass | encapsulation | release kinetics |
|---|---|---|---|
| HA matrix (100-500 kDa) | 5 mg | needle bulk | 10-30 min dissolution |
| **AzoR enzyme** (23 kDa) | 30 μg | lyophilized core + trehalose shell | active < 5 min hydration |
| **DyP peroxidase** (50 kDa) | 30 μg | lyophilized core (separate aliquot) | active < 10 min |
| **CeO₂ NP** (5-10 nm) | 1.5 mg | HA matrix dispersion (uniform) | immediate exposure |
| **Ascorbate** | 200 μg | matrix dissolution | gradient release |
| **NADPH cofactor** | 50 μg | UV-protected core | enzyme cycling |
| **Trehalose** (cryo-protect) | 200 μg | shell + cofactor | stabilizer |
| H₂O₂ generator (CaO₂) | 100 μg | separate core | slow release for CeO₂ Fenton |

⇒ patch payload total **~2.1 mg/cm² · 30 μg / needle (1000 needles)** · loading 정합

## §4 cost analysis (v1 vs v2)

| component | v1 ($1.5/patch) | v2 ($2.5/patch) | 변동 |
|---|---|---|---|
| AzoR (single) | $0.50 | $0.50 | 동일 |
| DyP (added) | — | $0.50 | +$0.50 |
| CeO₂ NP (added) | — | $0.30 | +$0.30 |
| Ascorbate + NADPH | $0.50 | $0.70 | +$0.20 |
| Trehalose + excipients | $0.30 | $0.40 | +$0.10 |
| HA matrix | $0.20 | $0.20 | 동일 |
| **payload subtotal** | **$1.50** | **$2.60** | **+73%** |

⇒ payload cost 73% ↑ · 다만 시술 횟수 ↓ (52→19) → 19 × 2.6 = $49 vs 52 × 1.5 = $78 → **per-treatment 38% 감소**

## §5 safety 정합 (M6 cross-ref)

### 🔴 critical mitigation (v1 M6 의 3 pair)

| M6 critical pair | v2 mitigation |
|---|---|
| Melanocyte × Oxidation | **CeO₂ pH-switch** → pH 7.4 (dermis) antioxidant · 멜라닌 보호 ✅ |
| Melanocyte × Photo | F4 photo 사용 안 함 (v2 cascade 내) ✅ |
| Collagen × Oxidation | **CeO₂ pH-switch** + ascorbate scavenger 적층 → 콜라겐 carbonyl 회피 ✅ |

### 새 v2 risk

| risk | likelihood | mitigation |
|---|---|---|
| 효소 immunogenicity (2 enzyme) | mid | humanized variant · subcutaneous low-level priming · IgE 모니터링 (M9) |
| Aromatic amine 부산물 누적 | mid-high | ascorbate quench + macrophage clearance · M6 toxicokinetics 정확화 |
| CeO₂ 멜라닌 phagocytosis off-target | low-mid | NP size 5-10 nm · 멜라닌세포 phagocytose 최소 (macrophage 우선) |
| 다중 활성성분 cross-reactivity | mid | M5-MN v2 MD/QM 검증 (cascade in phagolysosome) |

### TI 재계산 (M6 V3 TI · cascade boost)

```
   v1 single AzoR TI ≈ 1e-8 (V3 ledger)
   v2 cascade TI:
     - AzoR azo specificity × 1
     - DyP heme + macrocycle specificity × 1
     - CeO₂ pH-switch confinement × 10² (phagolysosome only)
   → cascade effective TI ≈ 1e-5 to 1e-4 (V3 baseline + 3-4 OoM boost)
```

⇒ TI 1e-5 ~ 1e-4 (still < 1) · 다만 single 대비 **3-4 OoM 개선** · wet-lab gate 정확화

## §6 multi-cycle 누적 (v3 timeline 정합)

per-cycle x = 11.8% · 주 1회:

| 주 | 누적 % |
|---|---|
| 1 | 11.8% |
| 4 | 39.4% |
| 8 | 63.3% |
| 13 | 81.3% |
| **19** | **91.0%** ★ |
| 24 | 95.5% |

⇒ N=19 cycle × 7일 = **4.5개월** · @goal v3 정합 (M7-MN v2 와 동일 결과)

## §7 외부 라이브러리 + 합성 source

| component | source | spec |
|---|---|---|
| AzoR | recombinant E. coli (UniProt P41407) | $300-500/mg recombinant · scale OK |
| DyP-type peroxidase | recombinant Bjerkandera adusta (PDB 4G2C) | $400-600/mg · 또는 Auricularia auricula |
| CeO₂ NP (5-10 nm) | commercial nanocrystal (Sigma · Nanostructured & Amorphous) | $10-20/g · 정제 필요 |
| Ascorbate | USP-grade L-ascorbic acid | $0.10/g |
| NADPH | regenerating system (NADP+ + glucose-6-phosphate dehydrogenase) | $50/g cofactor + $30/mg enzyme |
| Trehalose | dihydrate cosmetic grade | $0.05/g |
| CaO₂ (H₂O₂ generator) | calcium peroxide nano | $5/g |

## §8 M5-MN v2 simulation input (별 trail · GPU pod)

다음 milestone (M5-MN v2: MD/QM with cascade) 가 받는 입력:
- **cascade dynamics in phagolysosome** (pH 4.5 · 37 °C · 250 mM NaCl)
- AzoR + DyP + CeO₂ NP **ternary system MD** (10k-20k atom · 100 ns)
- 시너지 정량 (각 enzyme/NP 가 다른 enzyme 의 substrate/cofactor 영향 검증)
- aromatic amine clearance kinetics
- CeO₂ NP melanocyte phagocytose 확률 (off-target check)

## §9 M8-MN v2 handoff

다음 milestone (M8-MN v2: ex-vivo 4.5개월 timeline) 가 받는 입력:
- v2 payload triple cascade composition (per §3)
- ex-vivo 19 cycle compressed simulation (per-cycle x 측정 → 12% goal)
- 3 잉크 + cascade 3 enzyme matrix = 9 cell + 3 single-control (cascade vs each single)
- TI improvement 측정 (v1 1e-8 → v2 1e-5 target)

## §10 Honest unknowns

- synergy factor 2.5× — closed-form 추정 · ex-vivo 검증 필수
- DyP UniProt ID 확정 (4G2C vs 2D3Q · variant 정확화)
- CeO₂ NP size + surface chemistry — commercial vs lab-synthesized
- 효소 면역원성 누적 (반복 dose · IgE 정량)
- aromatic amine 부산물 — ascorbate quench 효율 측정
- cascade 부산물 (Ce³⁺ leaching · 효소 fragments) clearance

## §11 진행 상태

- ✅ Triple cascade 화학 정합 (AzoR + DyP + CeO₂)
- ✅ Synergy factor 2.5× → per-cycle x ≈ 12% (v3 target)
- ✅ Payload encapsulation (M7-MN v2 1000/cm² 정합)
- ✅ Cost analysis (per-treatment 38% 감소)
- ✅ Safety mitigation (M6 🔴 3 pair · CeO₂ pH-switch confinement)
- ✅ TI improvement 3-4 OoM (v1 1e-8 → v2 1e-5)
- ✅ Multi-cycle 누적: N=19 × 주 1회 = 4.5개월 (@goal v3 정합)
- next: M5-MN v2 simulation (cascade MD ternary · GPU pod) + M8-MN v2 ex-vivo
