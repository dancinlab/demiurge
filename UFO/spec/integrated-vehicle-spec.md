# 🛸 UFO — verb-1 spec · 1인승 통합 비행체 사양 명세

@title: 🛸 UFO — 통합 비행체(직접개발) · spec
@parent: ~/core/demiurge/UFO.md
@verb: 1/7 (spec) — demiurge 7-verb pipeline first slot
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d10 (icon · name · alias 헤더)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-1 spec** 슬롯을 채운다. 페이로드(1인승) · 7-stage propulsion ladder · 자세제어 · 동력 인터페이스 · cross-link · 흡수 ledger 6개 섹션으로 통합 비행체 사양을 명세한다. 구현 코드 없음(@D d3) — 모든 implementation 은 `~/core/hexa-lang/stdlib/` 가 SSOT, UFO/spec/ 는 docs/manifests only.

---

## 0. TL;DR — 1인승 통합 비행체 spec 요약

```
                    🛸 UFO — 1인승 통합 비행체 (single-pilot integrated craft)
   ───────────────────────────────────────────────────────────────────────────
                              ┌────────────────────┐
                              │   조종사 1명         │  ← 75 kg + 12h 자급
                              │   캐빈 1.8 × 1.2 m  │     (페이로드 §1)
                              └─────────┬──────────┘
                                        │  IMU x2 · gyro x3 · jet trim x6
                                        ▼  (자세제어 §3)
   ┌──────────────────────────────────────────────────────────────────────┐
   │   동력 인터페이스 (§4) — record consume                                │
   │   ┌──────────┐  ┌──────────┐  ┌────────────┐  ┌──────────────────┐   │
   │   │  RTSC    │  │  FUSION  │  │ ANTIMATTER │  │  Stage-4~7        │   │
   │   │  48T     │  │  D-T /   │  │  γ-rocket  │  │  (Alcubierre /    │   │
   │   │ Meissner │  │  p-11B   │  │  anti-H+H  │  │   Morris-Thorne / │   │
   │   │  부상     │  │   MHD    │  │  Isp=10¹⁰s │  │   KK / dim-use)   │   │
   │   └────┬─────┘  └────┬─────┘  └─────┬──────┘  └────────┬──────────┘   │
   └────────┼─────────────┼──────────────┼──────────────────┼──────────────┘
            ▼             ▼              ▼                  ▼
        Stage-1       Stage-2         Stage-3         Stage-4 ~ Stage-7
        hover         cruise          orbital         (falsifier-only)
        0~20 km       20~200 km       200km~1AU       1AU~galactic ~ τ=4
        Mach 0.3      Mach 10         escape v        warp / wormhole /
                                                      KK 4D→26D / (σ−φ)²

   stage 전환 = closed-form trigger (고도/속도/Δv 한계) — §2 matrix 참고
```

**spec 요약 (5-line claim)**

| key | value | 근거/falsifier |
|-----|-------|----------------|
| 페이로드 | 조종사 1명 · 75 kg · 12h 자급 (LSS) | §1 |
| 통합 stage | 7 (1-3 실설계 · 4-7 falsifier-only) | §2 matrix |
| 동력원 | RTSC · FUSION · ANTIMATTER · Stage-4~7 lattice | §4 cross-link |
| 자세제어 | gyro x3 + jet x6 + EM trim · IMU 2x redundancy | §3 |
| 흡수 자산 | RTSC + FUSION + ANTIMATTER + CERN + hexa-ufo HEXA-Disc 1890-LOC | §5 §6 |

---

## 1. 페이로드 — 조종사 1명

### 1.1 인적 사양

| 항목 | 값 | 비고 |
|------|----|------|
| 탑승 인원 | **1 명** (single-pilot) | 무인 모드 토글 가능 (deferred) |
| 표준 체중 | 75 kg ± 15 kg | 95-percentile 한국 성인 |
| 체적 envelope | 1.8 m × 1.2 m × 1.0 m (W×D×H, 좌석 기준) | 직립/누운 자세 모두 수용 |
| 가속 한계 | 9 G (peak, 5s) / 3 G (sustained, 10 min) | g-suit 통합 |

### 1.2 12h 자급 LSS (Life Support System)

| 시스템 | 사양 | 출처/cross-link |
|--------|------|----------------|
| O₂ | 0.84 kg/12h (PSA, 99.5% pure) | atmosphere.cabin = 21% O₂ / 79% N₂ |
| CO₂ scrub | LiOH 1.6 kg / 12h · backup zeolite swing | CO₂ < 0.5% (FAA Pt.25) |
| H₂O | 3.6 L / 12h (drink + condensate recovery) | closed-cycle 60% recovery |
| 식량 | 3000 kcal / 12h · ration pack | freeze-dried, no prep |
| 폐기물 | UCD/FCS 12h capacity | EVA suit 호환 |
| 열관리 | 100~150 W metabolic load · LCG | LCG = liquid cooling garment |
| 전원 | 28V DC · 200 W LSS bus | RTSC SMES tap (§4.1) |

### 1.3 캐빈 환경

- **압력**: 0.7 atm (8000 ft 등가) · O₂ enriched → 해수면 PO₂ 매치
- **온도**: 18~24 °C · LCG + 캐빈 HVAC dual
- **시야**: 180° 전방 + 90° 측방 · canopy = polycarbonate + EM-cloak overlay (HEXA-CLOAK 흡수)
- **HUD**: AR overlay · navigation + stage status + falsifier dashboard

---

## 2. Stage matrix — 7-stage 통합 ladder

각 stage 의 고도범위/속도/동력원/전환조건/falsifier 를 한 행으로 명세. **stage 1-3 = 실설계 · stage 4-7 = falsifier-only preregister (lattice-consistent)**.

| Stage | 명칭 | 고도범위 | 속도 (target) | 동력원 | 전환 조건 (closed-form) | falsifier (preregister) |
|-------|------|---------|--------------|--------|------------------------|------------------------|
| **1** | hover | 0 ~ 20 km | Mach 0 ~ 0.3 (hover/VTOL) | RTSC 48T Meissner | F_lift ≥ m·g · B_app ≥ B_c1(T) | F-RTSC-{1,2,3} — Meissner 부상력 closed-form ≥ measured Δ ≤ 1e-9 |
| **2** | cruise | 20 ~ 200 km | Mach 0.3 ~ Mach 25 | FUSION (D-T / p-11B) + MHD | Q ≥ 1 (fusion gain) · plasma σ_e ≥ 10⁴ S/m | F-FUSION-{1,2,3} — MHD F = J×B closed-form 정합 |
| **3** | orbital | 200 km ~ 1 AU | escape v_e (11.2 km/s) ~ 0.1 c | ANTIMATTER γ-rocket (anti-H + H) | Δv ≥ Δv_req(target) · I_sp ≥ 10⁹ s | F-ANTI-{1,2,3} — Penning trap 3-freq invariance + γ-thrust closed-form |
| **4** | warp | 1 AU ~ galactic (~10⁵ ly) | v_s = σ² c (formal) | Alcubierre bubble (δ=1/σ · R=n=6) | T_μν exotic budget OK (formal) | F-WARP-{1,2,3} — exotic matter inequality · σ-φ lattice 일관성 |
| **5** | wormhole | intergalactic (~10⁹ ly) | instantaneous (formal) | Morris-Thorne ER bridge (b₀=ℓ_Pl·σ) | throat stability · NEC violation budget | F-WORM-{1,2,3} — throat metric 일관성 · NEC budget 추적 |
| **6** | dim-jump | bulk transit (KK ladder) | brane-cross (formal) | KK tower 4D→6D→10D→11D→24D→26D | mass spectrum n²/R² ≤ 4.8 TeV | F-DIM-{1,2,3} — KK 격자 알려진 string-theory 격자와 일관 |
| **7** | dim-use | Calabi-Yau 6-fold | (σ−φ)² = 100c · τ=4 cycle | composite (CY navigation) | τ=4 closure invariant | F-USE-{1,2,3,4} — 6-fold 위 trajectory closure |

### 2.1 전환 시퀀스 (state machine)

```
   hover  →(altitude ≥ 20km AND v ≥ Mach 0.3)→  cruise
   cruise →(altitude ≥ 200km AND ΔV-budget OK)→  orbital
   orbital→(target ≥ 1 AU AND warp ready)     →  warp     [falsifier gate]
   warp   →(target ≥ galactic)                →  wormhole [falsifier gate]
   wormhole→(target ≥ intergalactic)          →  dim-jump [falsifier gate]
   dim-jump→(KK transit completed)            →  dim-use  [falsifier gate]

   재진입 (re-entry) = 역순 (dim-use → ... → hover) · 각 gate = closed-form check
```

### 2.2 stage 별 verify 의무 (per @D d1)

- **Stage 1-3**: 실설계 · `hexa verify --expr` 🟢 + atlas register 의무 (RTSC/FUSION/ANTIMATTER 도메인 V1-V4 ledger 참조)
- **Stage 4-7**: falsifier-only preregister · 13-falsifier 카탈로그 (`~/core/hexa-ufo/EXPERIMENTS.md`) 에서 monotone set {OPEN, CONFIRMED, DEMOTED} 추적
- **lattice 일관성**: n=6 σ·τ=48 unique alien_index 체인 (UFO.md Phase D 의무)

---

## 3. 자세제어 — gyro + jet + EM trim · redundancy 2×

### 3.1 액추에이터 토폴로지

| 축 | 1차 (primary) | 2차 (backup) | 3차 (trim) |
|----|---------------|--------------|------------|
| roll | gyro x3 (orthogonal CMG) | cold-gas jet x2 | EM coil (RTSC 자장 vector) |
| pitch | gyro x3 | cold-gas jet x2 | EM coil |
| yaw | gyro x3 | cold-gas jet x2 | EM coil |
| translate (X/Y/Z) | EM thrust vector | jet x6 (3-axis pair) | — |

**redundancy = 2x** — 1차 fail 시 2차 단독 자세 유지 (FAA Pt.25 single-failure)

### 3.2 IMU spec (sensor fusion)

| 항목 | 1차 IMU | 2차 IMU (redundant) |
|------|---------|---------------------|
| 종류 | FOG (fiber-optic gyro) + MEMS accel | ring-laser gyro (RLG) + quartz accel |
| 갱신 rate | 1 kHz | 1 kHz |
| 정밀도 (각속도) | 0.001 °/h (bias stability) | 0.005 °/h |
| 정밀도 (가속도) | 1 µg | 5 µg |
| 정렬 절차 | gyrocompassing 15 min · 정지 시 | gyrocompassing 15 min |
| sensor fusion | Kalman filter (15-state) · GNSS aiding | 동일 · 독립 채널 |

### 3.3 제어법 (control law) — manifest

- **제어 알고리즘**: stdlib SSOT — `~/core/hexa-lang/stdlib/control/` (LQR + adaptive PID 후보, @D d3/d4)
- **자세 quaternion**: q = [w, x, y, z] · normalize 매 tick
- **dispatch**: single generic — instance = manifest only (@D d4)
- **falsifier**: stage 전환 시 자세 invariant `‖q‖ = 1 ± 1e-9` (closed-form)

---

## 4. 동력 인터페이스 — record consume contract

UFO 자체는 동력원을 가지지 않는다. **선행 4개 demiurge 자산이 출력 record 를 발행**, UFO 는 consumer 로서 인터페이스만 명세 (@D d4 single generic dispatch).

### 4.1 RTSC 자석 (Meissner) — Stage-1 hover

- **출처**: `~/core/demiurge/RTSC.md` (RT-SC 48T magnet · feat/rtsc-magnet-wheeler-v2)
- **producer record**: `{ B_applied: T, T_op: K, J_c: A/m², geometry: torus/disc, B_axis_closed_form: T }`
- **consumer 요구**: B_applied ≥ B_c1(T_op) AND F_lift = (B²/2µ₀) · A ≥ m_total · g
- **verify**: Wheeler on-axis B closed-form (RTSC #3b33c26) · M318 cross-check
- **SMES tap**: 200 W LSS bus (1.2 항) 도 동일 RTSC SMES 에서 분기

### 4.2 FUSION (MHD) — Stage-2 cruise

- **출처**: `~/core/demiurge/FUSION.md` (D-T / p-11B BLUE-MAX 🔵 audit · #1102)
- **producer record**: `{ Q_fusion: ratio, P_thermal: W, plasma_ne: m⁻³, T_ion: keV, B_coil: T }`
- **consumer 요구**: Q ≥ 1 (가속 조건) · MHD σ_e ≥ 10⁴ S/m · F_MHD = J × B
- **verify**: FUSION 도메인 V1-V4 ledger · 8 algebraic-root int atoms · 12 libm covered

### 4.3 ANTIMATTER (γ-rocket) — Stage-3 orbital

- **출처**: `~/core/demiurge/ANTIMATTER.md` (BLUE-MAX 11/11 g69 PASS · #1107)
- **producer record**: `{ p_bar_rate: s⁻¹, trap_freq_3: (ω_c', ω_z, ω_-), I_sp: s, thrust_N: N }`
- **consumer 요구**: I_sp ≥ 10⁹ s (target 10¹⁰) · Brown-Gabrielse invariance `ω_c² = ω_c'² + ω_z² + ω_-²`
- **verify**: Penning 3-freq closed-form (commit 4cda3f2) · γ-thrust closed-form

### 4.4 Stage-4 ~ 7 (falsifier-only)

- **출처**: `~/core/hexa-ufo/{warp,wormhole,dimjump,dimuse}/` + lattice (n=6, σ·τ=48)
- **producer record**: formal (Alcubierre δ=1/σ · MT b₀=ℓ_Pl·σ · KK n²/R² · CY 6-fold)
- **consumer 요구**: falsifier set {OPEN, CONFIRMED, DEMOTED} monotone · 13-falsifier 카탈로그 닫기
- **verify**: 실측 불가 — formal lattice 일관성 + closed-form identity 만 검증 (@D d2 — wall encountered, breakthrough paths via /gap · hexa kick)

### 4.5 CERN (자장/입자 cross-link) — boundary

- **출처**: `~/core/demiurge/CERN.md` (tabletop 기준 구현 완료 · #180)
- **role**: 자장/입자 cross-link · 비-wet-lab 검증 surface · UFO 직접 동력 아님 (auxiliary)
- **interface**: 자장 boundary condition + 입자 cross-section table (lookup-only)

---

## 5. cross-link

### 5.1 demiurge 도메인 (sibling)

| 도메인 | 파일 | 역할 |
|--------|------|------|
| RTSC | `~/core/demiurge/RTSC.md` | Stage-1 Meissner 부상 자석 substrate |
| FUSION | `~/core/demiurge/FUSION.md` | Stage-2 D-T/p-11B MHD 추진 substrate |
| ANTIMATTER | `~/core/demiurge/ANTIMATTER.md` | Stage-3 γ-rocket substrate |
| CERN | `~/core/demiurge/CERN.md` | 자장/입자 cross-link (auxiliary) |

### 5.2 hexa-ufo 아틀라스 (외부 SSOT 흡수)

| 파일 | LOC (approx) | 흡수 대상 |
|------|--------------|-----------|
| `~/core/hexa-ufo/HEXA-UFO.md` | ~1890 | main 7-stage ladder + 부수 5축 + 13 falsifier |
| `~/core/hexa-ufo/HEXA-HOVER.md` | — | hover Meissner 추가 사양 |
| `~/core/hexa-ufo/HEXA-GRAV.md` | — | gravity-wave + quantum-gravity-sensor |
| `~/core/hexa-ufo/HEXA-CLOAK.md` | — | EM 가시성 차단 layer |
| `~/core/hexa-ufo/HEXA-TELEPORT.md` | — | quantum entangle protocol |
| `~/core/hexa-ufo/HEXA-SIM.md` | — | 디지털트윈 sim engine spec |
| `~/core/hexa-ufo/warp/`, `wormhole/`, `dimjump/`, `dimuse/` | — | Stage-4~7 in-tree spec + falsifier |
| `~/core/hexa-ufo/EXPERIMENTS.md` | — | 13-falsifier preregister 카탈로그 |
| `~/core/hexa-ufo/CROSS-DOMAIN-MEGA.md` | — | RTSC↔FUSION↔ANTIMATTER↔CERN cross-link tab |

### 5.3 stdlib (구현 SSOT, @D d3)

- **구현 코드 home**: `~/core/hexa-lang/stdlib/` (UFO/spec/ 는 docs/manifests only)
- **단일 generic dispatch**: instance = manifest only (@D d4) — UFO add/rename/remove = spec/manifest 수정만

---

## 6. 흡수 ledger — 본 spec 이 흡수한 자산 매핑

### 6.1 demiurge 자산 흡수 (4 도메인)

| 자산 | 본 spec 흡수 슬롯 | 흡수 status |
|------|------------------|------------|
| RTSC (Meissner 48T) | §2 Stage-1 · §4.1 record interface | 흡수 ledger 항목 추가 (Phase A.1 Stage-1 milestone gate) |
| FUSION (MHD D-T/p-11B) | §2 Stage-2 · §4.2 record interface | 흡수 ledger 항목 추가 (Phase A.2 Stage-2 milestone gate) |
| ANTIMATTER (γ-rocket) | §2 Stage-3 · §4.3 record interface | 흡수 ledger 항목 추가 (Phase A.3 Stage-3 milestone gate) |
| CERN (자장/입자) | §4.5 boundary auxiliary | 흡수 ledger 항목 추가 (cross-link) |

### 6.2 hexa-ufo HEXA-Disc 자산 흡수 (1890-LOC 아틀라스)

| HEXA-Disc 슬롯 | 본 spec 매핑 | 비고 |
|---------------|-------------|------|
| Stage-1 hover | §2 Stage-1 · §4.1 RTSC | 실설계 |
| Stage-2 cruise | §2 Stage-2 · §4.2 FUSION+MHD | 실설계 |
| Stage-3 orbital | §2 Stage-3 · §4.3 ANTIMATTER | 실설계 |
| Stage-4 warp | §2 Stage-4 · §4.4 falsifier-only | F-WARP-{1,2,3} preregister |
| Stage-5 wormhole | §2 Stage-5 · §4.4 | F-WORM-{1,2,3} preregister |
| Stage-6 dim-jump | §2 Stage-6 · §4.4 | F-DIM-{1,2,3} preregister |
| Stage-7 dim-use | §2 Stage-7 · §4.4 | F-USE-{1,2,3,4} preregister |
| HEXA-HOVER | §2 Stage-1 보강 | downstream verb-2 structure |
| HEXA-GRAV | (deferred) | UFO/grav 통합 — Phase B |
| HEXA-CLOAK | §1.3 canopy overlay 명세 | downstream verb-2 structure |
| HEXA-TELEPORT | (deferred) | UFO/teleport 통합 — Phase B |
| HEXA-SIM | (deferred) | UFO/sim 디지털트윈 — verb-4 analyze ⟲ |
| 13-falsifier catalog | §2 stage-row falsifier 컬럼 | EXPERIMENTS.md monotone set |
| n=6, σ·τ=48 lattice | §2.2 verify 의무 · §4.4 lattice 일관성 | LIMIT_BREAKTHROUGH (Phase D) |

### 6.3 본 spec 이 닫은 milestone (UFO.md 기준)

- **Phase C verb-1 spec** — `[ ] verb-1 spec — 1인승 통합 비행체 사양 명세 (페이로드/항속/고도/안정성/추진 stage matrix)` → 본 PR 로 LANDED

### 6.4 본 spec 이 deferred 한 sub-items

본 verb-1 spec 슬롯은 **사양 명세** 만 닫는다. 아래는 downstream verb 슬롯으로 이월:

- frame + 자석 어셈블리 + stage 모듈 인터페이스 도면 → **verb-2 structure** (Phase C)
- closed-form 통합 설계 (stages 1-3 실설계 + 4-7 falsifier-only) → **verb-3 design**
- CFD + EM + 응력 + 열관리 통합 sim 반복 수렴 → **verb-4 analyze ⟲**
- BOM + 도면 + firmware 산출물 → **verb-5 synthesize**
- 디지털트윈 통합 🟢 verify → **verb-6 verify**
- 외부 제작소 패키지 → **verb-7 handoff**
- HEXA-GRAV / HEXA-TELEPORT / HEXA-SIM 부수 3축 → **Phase B**

---

## verify (@D d1, d5)

본 spec 자체는 manifest (문서) 이므로 closed-form verify 대상 아님. 단, **stage matrix 의 lattice 일관성** (n=6, σ·τ=48, δ=1/σ, b₀=ℓ_Pl·σ, (σ−φ)²=100c) 은 UFO.md `V2 🔵 push` 슬롯에서 `hexa verify --expr` 로 검증 의무.

- `hexa verify --expr alcubierre_v_s 6 144` → v_s = σ² c (formal)
- `hexa verify --expr mt_throat_b0_lattice 6 48` → b₀ = σ·τ
- `hexa verify --expr kk_mass_spectrum 6 4800` → n²/R² ≤ 4.8 TeV

(위 expr 슬롯은 downstream verb-6 verify 의 책임 — 본 spec 은 verify 의무를 **선언**만 한다.)

---

## 마감

- **author**: UFO domain verb-1 spec milestone (PR #<TBD>)
- **base ref**: `origin/main` (47083ec → 7447d9d 동기)
- **branch**: `feat/ufo-verb1-spec`
- **next verb**: verb-2 structure (frame + 자석 어셈블리 + stage 모듈 인터페이스)
- **governance**: @D d1 (비-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d10 (icon·name·alias 헤더)
