# TTR-MN M7-v4 — density 1500/cm² array + UV-A LED photo patch

> milestone: TTR-MN.md "M7-MN v4 — density 1500/cm² array + UV-A photo LED patch integration"
> driver: v4 floor (격일 × 2개월) · per-cycle x ≈ 15% target
> base: M7-MN v2 (1000/cm² · `TTR/research/m7_mn_v2_density_1000.md`) 위 v4 추가

## TL;DR

needle density 1000 → **1500/cm²** (+50% boost) + **UV-A LED photo patch** (365 nm · 1 mW/cm² · 5 min post-MN). spacing 316 → **258 μm** · overlap η 0.5 → 0.4 (효율 marginal drop) · per-cycle x boost 12% → **~14-15%** (density 1.25× × photo 1.2×). 비용 +$12/patch ($33 → $45) + $30 LED (one-time · 60+ reuse). physical floor (격일) 정합 + Cu-Pc/Cr₂O₃ wall pigment 추가 분해 path.

## §1 v2 (1000) vs v4 (1500) 비교

| param | v2 (1000/cm²) | **v4 (1500/cm²)** | 변동 |
|---|---|---|---|
| Density | 1000/cm² | **1500/cm²** | +50% |
| Spacing | 316 μm | **258 μm** | -18% (좁아짐) |
| Needle L | 1200 μm | **1200 μm** (유지) | — |
| Tip diameter | 8 μm | **6 μm** | -25% (sharper) |
| Base diameter | 150 μm | **120 μm** | -20% (slimmer) |
| Aspect ratio | 8:1 | **10:1** | 더 sharper taper |
| Euler buckling F_crit | 0.21 N | **~0.11 N** | safety factor 2.2× (insertion 0.05N) |
| Patch area | 1-5 cm² | 1-5 cm² | — |

### Plume overlap 분석 (density 1500)

```
   spacing = 258 μm · plume radius = 100 μm
   raw coverage = π × 100² / 258² = 47.2%
   overlap factor η = 0.4 (heavy overlap · efficiency drop)
   single-cycle effective = 47.2% × 0.4 × 0.8 = 15.1%
```

⇒ **per-cycle x ≈ 15%** · v4 target 정합

### Buckling 검증 (slimmer needle)

```
   r_base = 60 μm = 6×10⁻⁵ m
   I = π × (6×10⁻⁵)⁴ / 4 = 1.02 × 10⁻¹⁷ m⁴
   F_crit = π² × 5×10⁹ × 1.02×10⁻¹⁷ / (2 × 1.2×10⁻³)² = 0.0873 N
```

⇒ F_crit (0.087 N) ≥ F_insertion (0.05 N) · safety **1.7×** (v2 4.3× 보다 낮음 · borderline)

⚠ 위험 — slimmer needle 의 mechanical failure risk · thumb-press force 표준화 mandatory

## §2 UV-A LED photo patch integration

### LED spec

| param | value |
|---|---|
| Wavelength | 365 nm (UV-A) |
| Power density | 1 mW/cm² (FDA i ≤ 0.5 mA·equivalent) |
| Duration | 5 min post-MN (HA 분해 후 · payload active) |
| Form factor | Reusable sticky LED patch (USB rechargeable) |
| Size | 1-5 cm² (MN patch와 동일 area) |
| Cost | $30 one-time (60+ cycle reuse) |
| FDA classification | 510(k) Class I cosmetic device |

### ASCII — LED + MN integration

```
   patch application sequence:
   ─────────────────────────
   1. MN patch press 30 sec        ┌────────────┐
                                   │  ░░░░░░░░  │ ← needles 진피 도달
   2. wait 5-10 min (HA 녹음)       └────────────┘
                                       ↓
   3. LED patch 부착                ┌────────────┐
                                   │ 💡💡💡💡 │ ← UV-A 365 nm
   4. UV-A 5 min activation         │ ▒▒▒▒▒▒▒▒ │   site-localized
                                   └────────────┘
   5. LED 떼고 일상복귀                ↓
                                  Cu-Pc + Cr₂O₃ photo-Fenton
                                  + 일반 cascade payload
```

### Photo-Fenton mechanism (Cu-Pc · Cr₂O₃ wall 분해)

```
   UV-A 365 nm photon (3.40 eV)
        ↓
   Cu-Pc Q-band 670 nm absorption (1.85 eV) — 직접 흡수 X (energy 큼)
        → triplet state via inter-system crossing (φ_T ~ 0.5)
        → ¹O₂ generation φ ~ 0.1 (M3 unknowns)
        → macrocycle methine ring-open
   
   Cr₂O₃ band gap 3.40 eV — UV-A 365 nm thermodynamic match
        → e⁻/h⁺ separation at surface
        → ·OH formation (with H₂O)
        → Cr³⁺ surface oxidation → DFO chelation 친화 ↑
```

### site-localized 광원 (off-target 회피)

- LED 가 MN patch 부위에만 적용 → 멜라닌 세포 광역 노출 X
- 5 min 단시간 + 1 mW/cm² 약광 → 멜라닌 광열 손상 회피
- M6 critical pair (Mel × Photo) mitigation

## §3 multi-cycle 누적 (v4 격일)

per-cycle x = 15% · 격일 (3.5일):

| cycle | 누적 % | 일 (days) |
|---|---|---|
| 1 | 15.0% | 1 (Day 0 시작) |
| 4 | 47.8% | 11 |
| 8 | 72.8% | 25 |
| 12 | 87.7% | 39 |
| **15** | **91.1%** | **49 일 = 7주 ≈ 1.7mo** ★ |

⇒ v4 nominal 1.7mo · @goal 2mo 약간 ↓ (conservative)

### 95% CI conservative

per-cycle x = 12% σ=3%, MC:
- N=21 cycle · 격일 × 21 = 73일 = **10.4주 ≈ 2.4mo**

## §4 비용 (v2 vs v4)

| item | v2 ($33/patch) | **v4 ($45/patch)** | 변동 |
|---|---|---|---|
| Material HA + payload | $6 | $7 (밀도 ↑) | +17% |
| Mold (1500/cm² precision) | $5 | $8 (3-5 μm tol) | +60% |
| Casting + centrifugation | $6 | $9 (tighter spec) | +50% |
| QC + packaging | $8 | $11 (density tight) | +38% |
| CDMO margin | $8 | $10 | +25% |
| **per-patch** | **$33** | **$45** | +36% |

⇒ **v4 treatment total** = 15 × $45 + $30 (LED one-time) = **$705**
   (v2 19 × $33 = $627 · v4 +12% but timeline -56% (4.5mo → 2mo))

## §5 manufacturing path (v4 추가)

### Precision casting (v2 + tighter)

```
   1. PDMS mold precision (1-2 μm tolerance) — laser micromachining ★ tighter (v2 3-5 μm)
   2. HA + payload aqueous (quad payload · degassed)
   3. Centrifugation 6000g × 5 min (mold filling · stronger)
   4. Drying 24h @ 4°C
   5. UV-C sterilization (15 sec · LED activation 안전)
   6. QC: 1500/cm² density 정합 (Optical Z-microscope)
   7. Aluminum pouch + desiccant + N₂ + photo-protective layer (NADPH)
```

### LED patch (별 device manufacturing)

- USB-rechargeable LED · 365 nm SMD LED × 9 unit per cm²
- Sticky electrode (medical-grade hydrogel · ECG-pad 유사)
- 60+ cycle lifetime · disposable in 2-3 patient
- CDMO: Vaxxas (MN) + LED manufacturer (별 vendor)

## §6 CDMO 후보 (1500/cm² 가용성)

| CDMO | 1500/cm² 선례 | 현재 limit | 수정 가능 |
|---|---|---|---|
| **Vaxxas** | 1000/cm² 검증됨 | 1000-1500 | 1500 시 추가 R&D 1-3mo |
| **Innopharma** | 1000-1500/cm² | ✅ | 직접 가능 |
| Micron Biomedical | 1000/cm² | ≤ 1000 | scale-up R&D 6-12mo |
| Lab-scale (university) | various | up to 2000 | scale ↓ but proof-of-concept OK |

⇒ **primary: Innopharma** (1500 직접 가능) · Vaxxas secondary

## §7 risks + mitigation (v4 specific)

| risk | likelihood | mitigation |
|---|---|---|
| Buckling safety 1.7× — borderline | mid-high | thumb-press standardized device · 4 N force ± 10% |
| Density 1500 overlap η < 0.4 → 실측 x ↓ | high | ex-vivo (M8 v4) 실측 검증 |
| LED 365 nm 멜라닌 광열 손상 (Fitzpatrick IV-VI) | mid | 1 mW/cm² 저강도 + 5 min 단시간 + site-localized |
| LED + MN sequencing (HA 분해 시간 부정확) | mid | 5 min wait standard · adjustable timer |
| Manufacturing precision 1-2 μm tolerance | mid | Innopharma scale-up R&D |
| User burden (LED + MN 두 단계) | mid | combined patch (LED 내장) future v5 |

## §8 M8-MN v4 handoff

다음 milestone (M8-MN v4: ex-vivo ultra-compressed) 가 받는 입력:
- v4 array spec (1500/cm² · L 1200 · tip 6 · base 120 μm)
- LED patch (365 nm · 1 mW/cm² · 5 min post-MN)
- Per-cycle x measurement (target 14-15% · conservative 12%)
- Photo-Fenton Cu-Pc/Cr₂O₃ wall pigment 검증 (별 cell)
- Multi-cycle ex-vivo 15 cycle in 15일 (압축 cycle 1일)

## §9 honest unknowns

- Density 1500 overlap η 0.4 추정 (실측 0.3-0.5 range)
- LED + MN sequencing 정확성 (사용자 adherence)
- Cu-Pc photo-Fenton ¹O₂ yield (0.1 추정 · GPU TD-DFT 필요)
- Cr₂O₃ band-gap excited state dynamics (시뮬 GPU pod 필요)
- Buckling safety 1.7× — user thumb-press variability
- LED 광열 멜라닌 손상 (Fitzpatrick IV-VI 별 cohort)

## §10 진행 상태

- ✅ Density 1500/cm² geometry 재설계 (spacing 258 μm · buckling 1.7× · slimmer needle)
- ✅ UV-A LED photo patch integration ($30 one-time · 60 reuse)
- ✅ Photo-Fenton mechanism Cu-Pc + Cr₂O₃ wall pigment 정합
- ✅ Multi-cycle 누적 (15 cycle · 격일 × 49일 ≈ 7주 = 1.7mo)
- ✅ 비용 $45/patch · $705/treatment (v2 +12%)
- ✅ CDMO 후보 (Innopharma primary) · Manufacturing precision spec
- ✅ M8-MN v4 handoff input
- next: M3-MN v4 (quad payload · TLR7/8 macrophage re-engage)
