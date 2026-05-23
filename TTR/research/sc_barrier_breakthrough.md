# TTR-CREAM M1 — Stratum corneum 통과 메커니즘 inventory (first-principles)

> 출처: `transdermal_delivery.md` (4 carrier 한계 깊이) + `ink_classes.md` (잉크 거주 500-2000 μm) + `moa_shortlist.md` (5 family payload) + `off_target_safety.md` (off-target 환경) + `external_libraries.md` (산업계 fail history)
> milestone: TTR-CREAM.md "SC barrier 돌파 메커니즘 short-list"
> scope: cream-only (no needles, no injection · home-use OTC device 일부 허용)

## TL;DR

Passive cream → 진피 500-2000 μm 도달 first-principles **불가능**. 표피 한계 (~150 μm) 가 SC + viable epidermis brick-and-mortar 의 자연 wall. 6 메커니즘 inventory 결과 도달 가능 ink 분율 시장 가중 **~30-50%** (sonophoresis/iontophoresis 보조 시) — TTR-CREAM @goal 90%와 ~40-50%p 갭. 정직 ceiling. d2 breakthrough 3 paths: ① sonophoresis (저주파 US · OTC home device), ② iontophoresis (소형 패치), ③ ethosome+CPP+microabrasion 결합 (boundary "no needles" 회색지대).

## SC brick-and-mortar geometry (first-principles)

```
표면 ━━━━━━━━━━━━━━━━━━━━━━━━━━━ 0 μm
   [SC]  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
         brick-and-mortar (20-30 corneocyte layer)
         lipid mortar = ceramide 50% · 콜레스테롤 25% · FFA 10-15%
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━ 20 μm
   [표피]  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
         viable cells (keratinocyte · 멜라닌 · Langerhans)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━ 120 μm   ← passive cream 자연 한계
   [진피] ░░░░ ● ● ● ● ● 잉크 거주
         (collagen matrix · 혈관 · 신경)
         ▓ ▓ ▓ ▓ ▓ ▓ macrophage
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━ 2000 μm
   [피하 지방]
```

자연 SC barrier wall: ~120 μm (SC 20 + 표피 100). 진피 잉크 (500-2000 μm) 는 480-1880 μm 추가 gap.

## 6 permeation 메커니즘 family

### (a) Lipid-disrupting solvents (CPE class)

| name | 작용기전 | 도달 깊이 (first-principles) | OTC | 한계 |
|---|---|---|---|---|
| Ethanol (50-70%) | SC lipid 부분 가용화 | SC + 표피 (~100 μm) | ✅ | 알레르기 · SC 회복 후 무효 |
| Isopropanol | 동상 | SC + 표피 | ✅ | 동상 |
| Terpenes (menthol·limonene) | lipid disrupt + 친수성 통로 | ~100 μm | ✅ | 자극 |
| Azone (1-dodecylazacycloheptan-2-one) | lipid bilayer fluidization | ~150 μm | ✗ (Rx) | 합성, 안전성 데이터 한정 |
| DMSO | universal solvent, SC 깊이 통과 | ~200-300 μm | ✗ (의약) | garlic breath · 자극 |
| Propylene glycol | 보습 + 부분 lipid | ~80 μm | ✅ | 약효 미미 |
| Oleic acid | lipid 친화 perturbation | ~100 μm | ✅ | 자극 |
| Urea | keratin 수화 + 분해 | ~50-80 μm | ✅ | 약효 미미 |

⇒ CPE 단독: 표피 한계, 진피 도달 X

### (b) Cell-penetrating peptide (CPP)

| name | cargo MW 한계 | 도달 깊이 | OTC | 한계 |
|---|---|---|---|---|
| TAT (HIV) | 5-30 kDa | SC bypass 어려움 (in vitro · 진피 데이터 sparse) | ✗ | dermal 도달 입증 미흡 |
| Penetratin | 5-20 kDa | 동상 | ✗ | 동상 |
| Transportan | 10-50 kDa | 동상 | ✗ | 동상 |
| R9 (arginine-rich) | 10-30 kDa | 동상 | ✗ | 동상 |

⇒ CPP 단독 cream-form: 단백질 자체 SC 통과 미입증. CPE/vehicle 결합 필요.

### (c) Lipid-degrading enzymes

| name | 작용 | depth | safety | OTC |
|---|---|---|---|---|
| Ceramidase | 세라마이드 분해 | SC 통과 가속 | barrier disruption risk | ✗ |
| Cholesterol esterase | 콜레스테롤 분해 | 동상 | 동상 | ✗ |
| Phospholipase A2 | phospholipid 분해 | 동상 | 동상 | ✗ |

⇒ SC barrier 직접 분해 = 위험 (barrier disruption permanent 우려). 임상 권장 X.

### (d) Physical assist (home-use device)

| name | 기전 | 도달 깊이 | OTC | 한계 |
|---|---|---|---|---|
| **Low-freq sonophoresis** (20-100 kHz US) | cavitation bubble → SC lipid 일시적 channel | **진피 1000-1500 μm** | ✅ (FDA Sontra) | device cost · 적용 시간 |
| Iontophoresis | DC ≤ 0.5 mA/cm² → 이온화 분자 transport | ~500 μm | ✅ (몇 home device) | 이온화 분자만 (MW ≤ 7 kDa) |
| Electroporation | high-voltage pulse → 일시적 pore | ~1000 μm | ✗ (clinic only) | clinic |
| Radio frequency | thermal lipid disrupt | ~500 μm | ✅ (home RF) | 통증 · 화상 risk |
| Near-IR diode | photothermal | ~500-1000 μm | △ (cosmetic-grade) | 멜라닌 흡수 risk (Fitzpatrick IV+) |

⇒ **sonophoresis = 최강 OTC path** (진피 1500 μm 도달, FDA 선례).

### (e) Advanced vehicle carrier

| name | 구성 | 도달 깊이 | OTC | M4 비교 |
|---|---|---|---|---|
| Ethosome (high ethanol liposome) | phospholipid + ethanol 20-45% | **200-400 μm** | ✅ | 기존 liposome (50-150) 보다 깊음 |
| Transfersome (ultradeformable) | phospholipid + edge activator | 300-500 μm | ✅ | 자가 변형 → SC 통과 |
| Niosome (non-ionic surfactant) | surfactant + cholesterol | 150-300 μm | ✅ | liposome variant |
| SLN/NLC (solid lipid nanoparticle) | 고체 lipid core | 100-300 μm | ✅ | 안정성 ↑, 깊이 ↓ |
| Deeper nano-emulsion | 친유성 droplet 20-100 nm | 300-500 μm | ✅ | M4 baseline 보다 약간 깊음 |

⇒ vehicle 단독 한계 ~500 μm. 진피 deep 도달 미흡.

### (f) Surface disruption boundary (no-needles 회색지대)

| name | 기전 | depth assist | "no needles" 정의 |
|---|---|---|---|
| Microabrasion (mild scrub) | SC 표면 박리 | + 50-100 μm | ✅ (no needles) |
| Dermaroller home device | 미세 needles 0.2-0.5 mm | + 200-500 μm | ❌ (needles 정의 위반) |
| Sandpaper / pumice | SC 표면 abrasion | + 50 μm | ✅ |
| Low-fluence diode patch | 광열 SC ablation | + 100-200 μm | ✅ |

⇒ microabrasion + 광열 patch = "no needles" 정의 안에서 추가 100-300 μm 가능.

## Mechanism × depth feasibility matrix

| family | 표피 ink (50-150 μm) | 진피 shallow (200-500 μm) | 진피 standard (500-1500 μm) | 진피 deep (1500-2000 μm) |
|---|:---:|:---:|:---:|:---:|
| (a) CPE | ●● | ◐ | ✗ | ✗ |
| (b) CPP only | ◐ | ✗ | ✗ | ✗ |
| (c) lipid enzyme | ●● (barrier disrupt risk) | △ | ✗ | ✗ |
| (d-sono) sonophoresis | ●●● | ●●● | **●●●** | ◐ |
| (d-ionto) iontophoresis | ●● | ●● | ◐ | ✗ |
| (d-RF) RF/IR | ●● | ●● | ◐ | ✗ |
| (e) ethosome | ●● | ●● | ✗ | ✗ |
| (e) transfersome | ●● | ●●● | ◐ | ✗ |
| (f) microabrasion+vehicle | ●● | ●● | △ | ✗ |

기호: ●●● robust · ●● viable · ◐ marginal · △ risky · ✗ blocked

## OTC-grade boundary 분석

| category | regulatory | 가정 사용 |
|---|---|---|
| Pure cream (CPE + vehicle) | OTC cosmetic | ✅ |
| Cream + microabrasion (sandpaper) | OTC cosmetic | ✅ |
| Cream + sonophoresis device | FDA 510(k) Class I | ✅ (device 따라) |
| Cream + iontophoresis patch | OTC class I device | ✅ |
| Cream + low-fluence diode | Cosmetic device | △ (state-by-state) |
| Cream + dermaroller (needles) | medical device | ❌ ("no needles" 정의 위반) |
| Cream + ceramidase/lipase enzyme | Rx | ❌ (barrier disrupt risk) |
| Cream + DMSO | Rx/cosmetic 경계 | △ |

⇒ OTC ceiling = sonophoresis + ethosome + CPE 결합 (3-component combination).

## Combination paths — first-principles synergy 추정

1. **CPE + ethosome + ascorbate** → 표피 200 μm + 진피 shallow 200 μm = **~400 μm 도달**. 도달 ink 분율 시장 가중 ~5-10%.
2. **CPP + ethosome + ascorbate** → 단백질 cargo 일부 SC 통과. ~300 μm. 시장 분율 ~5%.
3. **Microabrasion + ethosome + payload** → SC bypass + ethosome 200 μm = ~300-400 μm. 시장 분율 ~10%.
4. **Sonophoresis + ethosome + payload (★)** → US channel + ethosome = **진피 800-1500 μm 도달**. 시장 분율 **~40-60%**.
5. **Iontophoresis + ascorbate/DFO (이온화)** → ~500 μm. 시장 분율 ~15-25%.
6. **Sonophoresis + iontophoresis + ethosome (triple)** → ~1500 μm + 깊은 잉크 일부. 시장 분율 **~50-70%**.

## 🚨 Honest cream-only depth bound

| route | first-principles depth | 시장 가중 ink 도달 분율 |
|---|---|---|
| Pure passive cream (no device) | ~50-100 μm | **< 5%** |
| Cream + CPE/ethosome | ~300-500 μm | **~10-20%** |
| Cream + sonophoresis (OTC) | ~1500 μm | **~50-60%** |
| Cream + sonophoresis + ethosome + microabrasion | ~1500-2000 μm | **~60-70%** |
| Cream + dermaroller (정의 위반) | ~2000 μm | ~80-90% |

⇒ **TTR-CREAM @goal 90% 와 first-principles bound ~60-70% 갭 ≈ 20-30%p**. 정직 ceiling.

⇒ d2 breakthrough — @goal 재정의 path:
- A. **OTC sonophoresis 결합 허용** → @goal 60-70% 가능 (TTR-CREAM ceiling 정확화)
- B. **@goal 분리** — 표피 잉크 (rare professional/decorative) 만 90%, 진피 잉크는 별도
- C. **multi-cycle 누적** → 12회/년 × 5년 = 60회 누적, 점진 60-70% per cycle → 누적 효과

## M3-CREAM handoff — cream-specific molecule constraint

(SC 통과 위한 분자 특성)
| 축 | 통과 가능 범위 | M2 5 family 매핑 |
|---|---|---|
| MW (passive) | < 500 Da | F2 ascorbate 176 · F3 DFO 656 borderline · F1 small molecule OK · F4 NP X · F5 효소 X |
| MW (with sonophoresis) | < 70 kDa | F5 효소 일부 (AzoR 23 kDa · DyP 50 kDa) |
| logP | 1-3 | 친유 약 활성 |
| H-bond donor | < 5 | 친수 제한 |
| Ionization | iontophoresis 시 이온화 필요 | F3 chelate (DFO ionizable) · F2 ascorbate |

⇒ Sonophoresis 결합 시 F5 효소 (≤ 70 kDa) 도 진피 도달 가능 — TTR-MN M3와 일부 candidate 공유 가능 (AzoR · DyP partial).

## TTR-MN M3 결과와 비교 (cross-track)

| 후보 | TTR-MN (MN direct) | TTR-CREAM (sonophoresis+ethosome) |
|---|---|---|
| CeO₂ nanozyme | ✅ direct deposit | ✅ NP 50 nm = ethosome 운반 가능 |
| DyP + DFO | ✅ direct | △ DyP 50 kDa = sonophoresis 보조 필요 |
| AzoR + ascorbate | ✅ direct | ✅ AzoR 23 kDa · ascorbate 176 Da = 가능 |

⇒ Cream 트랙은 sonophoresis 결합 시 MN 트랙의 일부 candidate 재사용 가능. M3-CREAM 별 작업은 분자 constraint 정합 중심.

## Honest unknowns

- Sonophoresis 도달 깊이 in vivo (대부분 ex-vivo Franz cell)
- Ethosome ethanol 농도 SC 회복 시간
- multi-cycle 누적 효과 비선형성
- mouse → human SC permeability translation (mouse SC ≪ human)
- long-term SC 반복 disruption 안전성
- microabrasion + ethosome combination 임상 데이터 부재
- Sonophoresis OTC device 시장 (FDA Sontra · 가정용 모델 제한적)
- CPP 가 cream-form 으로 SC 통과한다는 in-vivo 입증 sparse

## 진행 상태

- ✅ 6 mechanism family inventory · depth feasibility matrix
- ✅ OTC-grade boundary · combination paths 6개
- ✅ honest cream-only ceiling (60-70% with sonophoresis OTC stack)
- ✅ M3-CREAM molecule constraint
- ✅ TTR-MN M3 결과와 cross-track 비교
- next: TTR-CREAM M2 (진피 도달 wall 정량화) → M3-CREAM (constraint 적용 활성성분)
