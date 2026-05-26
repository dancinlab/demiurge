# TTR-MN M7 — MN array engineering design (needle 재료 · payload encapsulation · 분해성 polymer)

> 출처: `m3_mn_candidates.md` (Top-3 candidate payload spec) + `m5_mn_md_qm_design.md` (분자 spec · stability profile) + `external_libraries.md` (12 MN supplier · 9 polymer)
> milestone: TTR-MN.md "M7-MN MN array engineering"
> scope: needle 재료 비교 + payload encapsulation + array geometry + 제조 + 보관 design doc

## TL;DR

분해성 microneedle (MN) array: needle 재료 = **HA (히알루론산) primary** + PVP/PVA secondary (Vaxxas 선례 정합) · payload = Top-3 별 encapsulation 전략 (CeO₂ NP 직접 disperse · DyP/AzoR lyophilization shell · DFO co-formulate) · geometry = L 1200 μm × 300/cm² × tip 10 μm. 제조 = **micromold casting** (저비용 · scalable) · 보관 = aluminum pouch + desiccant (≤ 30% RH · 24mo). FDA combination product 505(b)(2) path 정합.

## Needle 재료 비교 (5 후보)

| polymer | 분해 시간 (피부 내) | 기계강도 (penetration) | payload 호환 | FDA 선례 | 비용 | priority |
|---|---|---|---|---|---|---|
| **HA (히알루론산)** | 10-30 min | 우수 (1000-1500 μm 침투) | broad (단백질·NP·small molecule) | ✅ cosmetic + vaccine (Soluvia) | mid | ★★★ |
| **PVP (polyvinylpyrrolidone)** | 5-15 min | 우수 | broad | ✅ vaccine (Vaxxas HD-MAP) | low | ★★★ |
| PVA (polyvinyl alcohol) | 30-60 min | 우수 | broad | ✅ 다수 device | low | ★★ |
| CMC (carboxymethyl cellulose) | 15-45 min | 보통 | broad | ✅ cosmetic | low | ★★ |
| Maltose / trehalose | 1-5 min | 양호 (빠른 분해) | 단백질 보호 (cryo-protectant) | ✅ vaccine | low | ★★ (보조) |

⇒ **primary = HA**: 강도 + 분해 time + payload broad 호환 + FDA vaccine 선례 (Vaxxas mRNA-MN).
⇒ **secondary = PVP**: 더 빠른 분해 (15 min) 시 payload burst release 원할 때.

## Payload encapsulation 전략 (Top-3 candidate 별)

### CeO₂ NP (F1 nanozyme)

```
   ┌──────────────┐
   │  HA matrix    │      ← needle bulk
   │  ▒▒▒▒▒▒▒▒    │
   │  ░ ● ░ ● ░    │      ← CeO₂ NP (5-10 nm) disperse
   │  ░ ● ░ ● ░    │
   │  ▒▒▒▒▒▒▒▒    │
   │       ▼       │      ← tip 농축 (gradient)
   │     ╱─╲       │
   │    ╱   ╲      │
   └────────────────┘
```

- **방법**: HA matrix + CeO₂ NP suspension micromold cast · tip-loading (centrifugation 농축)
- **NP 크기**: 5-10 nm = HA pore size 정합 · dispersion stable
- **농도**: 1-5 mg/cm² (per cycle · M5 시뮬 농도 기준)
- **stability**: NP solid lyophilization stable · room temp 12-24 mo
- **trigger**: HA dissolution 후 NP가 phagocytosed → pH 4-5 phagolysosome 에서 Fenton-on

### DyP peroxidase + DFO 결합 (F5 + F3)

```
   ┌──────────────┐
   │  HA matrix    │      ← needle bulk
   │  ▒▒▒▒▒▒▒▒    │
   │  trehalose shell │   ← 효소 보호 (lyo-protectant)
   │  ╔════════╗   │
   │  ║ DyP+DFO ║   │      ← lyophilized payload core
   │  ╚════════╝   │
   │  ▒▒▒▒▒▒▒▒    │
   └────────────────┘
```

- **방법**: lyophilized DyP + DFO co-formulation core, trehalose shell (cryo-protect), HA matrix 외피
- **DyP**: recombinant E. coli · lyo 안정 12 mo · 활성 retention > 80%
- **DFO**: small molecule · 안정성 우수
- **농도**: DyP 50 μg/cm² · DFO 100 μg/cm² (per cycle)
- **trigger**: HA 분해 → trehalose 분해 → 효소 rehydrate (phagolysosome 진입 시 활성)

### AzoR + ascorbate cascade (F5 + F2)

```
   ┌──────────────┐
   │  HA matrix    │
   │  ▒▒▒▒▒▒▒▒    │
   │  ░ ▼ ░ ▼ ░    │      ← ascorbate 작은 분자 (HA 매트릭스 직접)
   │  ╔══════╗     │
   │  ║ AzoR  ║     │      ← lyophilized AzoR core
   │  ╚══════╝     │
   │  ▒▒▒▒▒▒▒▒    │
   └────────────────┘
```

- **방법**: AzoR lyo core (trehalose) + ascorbate HA matrix dispersion + NADPH co-formulate
- **AzoR**: recombinant · MW 23 kDa · lyo OK
- **NADPH cofactor**: light-sensitive (UV-protected packaging 필요)
- **농도**: AzoR 30 μg/cm² · ascorbate 200 μg/cm² · NADPH 50 μg/cm²

## Array geometry (first-principles)

| parameter | 값 | 근거 |
|---|---|---|
| Needle length (L) | **1200 μm** | M4 dermis penetration 정합 (잉크 거주 500-1500 μm 중심) · variant 1800 μm for deep ink |
| Needle density | **300/cm²** | Vaxxas HD-MAP 선례 · payload 농도 정합 |
| Tip diameter | 10 μm | sharp insertion · 통증 최소 |
| Base diameter | 200 μm | 강도 · 분해 speed |
| Aspect ratio | 6:1 | 변형 안 함 (penetration force ≥ 0.05 N/needle) |
| Patch area | 1-5 cm² | small tattoo 1 cycle, larger = multi-patch |
| 변형: L=1800 μm (deep) | for 전문가 시술 deep ink | SKU 변종 |
| 변형: L=800 μm (shallow) | 표피 + 진피 shallow | SKU 변종 |

## ASCII — needle plume × ink particle density (M5 정합)

```
   needle tip (depth 1200 μm, 농축)
          ●
          │
   ┌──────┴──────┐          
   │  plume     │  반경 ~30-50 μm (M5 §5)
   │     ▓     │
   │  ▓     ▓  │
   │     ▓     │   ← payload diffusion zone
   └─────────────┘
          ▼
   needle 간 거리 ~580 μm (300/cm² · √(1/300) cm = 577 μm)
   plume 30-50 μm × 2 = 60-100 μm coverage per needle
   ⇒ needle spacing > plume size · 진피 cover 부분적 (5-15%)
   ⇒ 시술 빈도 (12회/년) × 누적 = 점진 cover
```

## 제조 공정 비교

| 공정 | 비용 | scale | 분해성 polymer OK | priority |
|---|---|---|---|---|
| **Micromold casting** (PDMS mold + centrifugation) | 저 | mid (1000s/day) | ✅ | ★★★ primary |
| Drawing lithography | mid | low | ✅ | ★★ |
| Photolithography (UV-cured) | 고 | mid | △ (photo-stable polymer) | ★ |
| 3D printing (2-photon) | 고 | low | △ | ★ (research only) |
| Hot-embossing | mid | mid | ✅ | ★★ |
| Injection molding | 저 | high (10⁴/day) | ✅ (만 tooling cost ↑) | ★★ (scale 시) |

⇒ **primary = micromold casting**: 초기 PoC + clinical 1상 적합 (CDMO 다수 보유).

## 보관 + 안정성

| 조건 | 권장 | M9 handoff |
|---|---|---|
| 온도 | 4°C (lyophilized polymer) · -20°C (long-term) | cold chain 가능 |
| 습도 | ≤ 30% RH (HA hygroscopic) | desiccant pouch |
| 빛 | UV-protected (NADPH cofactor cell) | aluminum laminate |
| 산소 | 일부 산소 차단 (ascorbate oxidation) | nitrogen flush |
| 유효기간 | 12-24 mo (24 mo target) | accelerated stability test |
| 포장 | aluminum pouch · individual peel-off · desiccant + O₂ scavenger | combination product per @D regulatory |

## FDA combination product path

- **Class**: 21 CFR 3.2(e) — drug + device combination
- **Primary mode of action**: drug (active payload · 활성분자) — CDER lead
- **Device portion**: MN array — CDRH secondary
- **Pathway**: **505(b)(2)** (active payload 가 known small molecule/recombinant · novel formulation)
- **임상 1상 IND**: M9 in-vivo + GMP MN array lock 후 진입
- **참조 선례**: Soluvia (intradermal flu) · Zosano Qtrypta · Vaxxas HD-MAP mRNA

## M8 handoff — ex-vivo pig skin PoC 조건

다음 milestone (M8-MN: ex-vivo 돼지 피부) 가 받는 입력:
- MN array spec (HA · L=1200 μm · 300/cm² · 1 cm² patch)
- Top-3 payload encapsulation × 3 patch (CeO₂ · DyP+DFO · AzoR+ascorbate cascade)
- 적용 방법: thumb-press 30 sec → 5 min dissolution → wait 1-72 hr
- 측정 endpoint: ink removal % (digital photo · histology · OCT)
- 음성 대조: HA-only patch (payload 없음)

## 제조 SKU 안

| SKU | size | needle L | 표적 | 가격 추정 |
|---|---|---|---|---|
| TTR-MN-CeO2-S | 1 cm² | 1200 μm | small tattoo (default) | $20-30/패치 |
| TTR-MN-CeO2-M | 5 cm² | 1200 μm | medium | $80-120 |
| TTR-MN-CeO2-Deep | 1 cm² | 1800 μm | 전문가 시술 deep ink | $30-40 |
| TTR-MN-Cascade | 1 cm² | 1200 μm | F5+F2 multi-payload | $40-60 |
| TTR-MN-Color | 1 cm² | 1200 μm | DyP F5 색상 잉크 표적 | $30-50 |

⇒ 30일 1회 용법 (TTR @goal) · 12회/년 × 1년 = 12 패치/년 · $300-500/년 (소형 시술 기준) — 레이저 시술 대비 1/10.

## 비용 vs. 레이저 비교

| 항목 | 레이저 시술 (PicoSure 등) | TTR-MN |
|---|---|---|
| 1 회 비용 | $300-500 | $20-40 |
| 시술 횟수 (완전 제거) | 8-12 회 | 12 회 (cycle) |
| 총 비용 | $2400-6000 | $300-500 |
| 통증 | 강함 | 거의 없음 |
| 다운타임 | 1-2주 | 없음 |
| 의료진 | 필요 | self-applied (OTC 또는 처방) |
| 색상 잉크 효능 | 약함 | F5/F4 강함 |

## Honest unknowns

- **HA 분해 속도 in-vivo 변동**: 환자 피부 hyaluronidase 농도 변동
- **lyophilized 효소 활성 retention 정확** (storage 24 mo 후): accelerated stability test 필요
- **NADPH cofactor stability**: light + oxygen 의존 — 포장 challenge
- **needle spacing optimum**: 300/cm² vs 500/cm² 시뮬 vs 실측 차이
- **multi-patch coverage 비선형성**: 인접 needle plume 중첩 효과
- **patch 적용 force 일관성**: home user vs clinic
- **분해성 polymer 알러지/자극**: 반복 적용 시 면역 반응 (lot variability)
- **CDMO 단가**: Vaxxas 등 CDMO quote 별도 필요 (per external_libraries.md §5)

## 진행 상태

- ✅ Needle 재료 5종 비교 · HA primary 결정
- ✅ Top-3 candidate payload encapsulation 전략 각자
- ✅ Array geometry (L=1200 μm · 300/cm² · 1 cm²)
- ✅ 제조 공정 · 보관 · FDA path 정의
- ✅ SKU 5종 · 비용 추산
- ✅ M8 handoff (ex-vivo protocol) input
- next: M8-MN ex-vivo 돼지 피부 PoC protocol
