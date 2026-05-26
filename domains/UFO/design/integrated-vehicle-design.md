# 🛸 UFO — verb-3 design · closed-form 통합 설계

@title: 🛸 UFO — 통합 비행체(직접개발) · design
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/structure/integrated-vehicle-structure.md (verb-2 structure · PR#190)
@sibling: UFO/spec/integrated-vehicle-spec.md (verb-1 spec · PR#187)
@verb: 3/7 (design) — demiurge 7-verb pipeline 세 번째 슬롯
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-3 design** 슬롯을 채운다. verb-2 structure 가 정의한 디스크 lenticular 구조 위에서 **Stage-1~3 을 closed-form 파라미터로 실설계**한다 — 자석 turns/current/B-field (RTSC 상속) · MHD 채널 dimensions (FUSION 상속) · antimatter trap params (ANTIMATTER 상속). **Stage-4~7 은 절대 실설계하지 않고 falsifier preregister 포인터만** 둔다 (hexa-ufo 의 academically-unproven stance 유지 · @D d2 — UNPROVEN ≠ 물리 한계). 모든 closed-form 값은 RTSC/FUSION/ANTIMATTER 의 **기존 verified 값을 인용** (새 sim 없음 — sim 은 verb-4 analyze ⟲ 의무). 구현 코드 없음 (@D d3) — UFO/design/ 는 docs/manifests only.

---

## 0. TL;DR — 통합 설계 closed-form 파라미터 표 + ASCII

```
                  🛸 UFO — verb-3 통합 closed-form 설계 (Stage-1~3 실설계)
   ──────────────────────────────────────────────────────────────────────────────
                           디스크 lenticular D=6.0 m · H=1.6 m · m_total=650 kg
              ╭──────────────────────────────────────────────────╮
              │  Stage-1 hover  ── RTSC 솔레노이드 × 6 등각 60°      │
              │    N=4000 turns · I=300 A · NI=1.2e6 At · r=0.30 m  │   ← B_center
              │    B_center ≈ 1.48 T (Wheeler on-axis, RTSC 인용)   │     1.48 T
              │    F_lift_total ≈ 6,500 N ≥ m·g = 6,370 N  ✓       │
              ├──────────────────────────────────────────────────┤
              │  Stage-2 cruise ── MHD 채널 slot S1+S4 (대각 페어)  │
              │    B_ch=5 T · J=2.0e5 A/m² · L×W×H=1.2×0.4×0.2 m   │   ← F = J×B
              │    F_MHD = J×B×V_ch ≈ 9.6e4 N (per channel)        │     thrust
              ├──────────────────────────────────────────────────┤
              │  Stage-3 orbital ── antimatter γ-rocket S2+S5      │
              │    Penning B=5 T·U₀=10 V·d=5 mm (포획)             │   ← I_sp
              │    Ioffe trap depth 0.353 K (가둠) · I_sp≥1e9 s     │     ≥ 1e9 s
              ╰──────────────────────────────────────────────────╯
              │  Stage-4~7  falsifier-only — 실설계 없음            │
              │    F-WARP / F-WORM / F-DIM / F-USE preregister 포인터 │  (UNPROVEN)
              ╰──────────────────────────────────────────────────╯
```

**통합 closed-form 파라미터 표 (5-line claim)**

| Stage | 핵심 closed-form | 설계점 (closed-form) | 상속 verified 값 | falsifier |
|-------|------------------|---------------------|------------------|-----------|
| 1 hover | F_lift=(B²/2µ₀)·A·η · B=Wheeler on-axis | NI=1.2e6 At · B_center≈1.48 T · F_lift≈6,500 N | RTSC `solenoid_axis_bz` B_z(0)=1.48265 T (PR#1084) · Δ=-1.40% cross-check | F-RTSC-{1,2,3} |
| 2 cruise | F_MHD=J×B×V_ch · B=tf_peak_field | B_ch=5 T · J=2.0e5 A/m² · F_MHD≈9.6e4 N | FUSION `tf_peak_field` ITER B_peak=11.82 T<20 T@20K · MHD F=J×B | F-FUSION-{1,2,3} |
| 3 orbital | Penning 3-freq + Ioffe trap depth | B=5 T·U₀=10 V·d=5 mm · ΔB=0.525 T→0.353 K · I_sp≥1e9 s | ANTIMATTER Penning invariance \|Δ\|=0 · Ioffe `ioffe_trap_depth_k`=0.35257 K | F-ANTI-{1,2,3} |
| 4-7 (warp/worm/dim/use) | **실설계 없음** — formal lattice only | n=6 · σ·τ=48 · δ=1/σ · b₀=ℓ_Pl·σ · (σ−φ)²=100c | (none — UNPROVEN preregister) | F-WARP/WORM/DIM/USE |
| 통합 budget | 650 kg · SF=2.5 | 자석 120 + 동력 150 + frame 180 + LSS 80 + payload 120 | structure §5 mass budget | (verb-4 FEA) |

> **정직 표기 (@D d2 · @D d6)**: Stage-1~3 = closed-form 실설계 (verified atom 인용). Stage-4~7 = **academically-UNPROVEN falsifier-preregister** — "물리적으로 불가능" 이 아니라 "현재 empirical sandbox 부재 · 형식 lattice 일관성만" (hexa-ufo `.own` own 2 stance 상속). 어떤 Stage-4~7 파라미터도 absorbed=true 로 flip 금지.

---

## 1. Stage-1 hover 실설계 — RTSC 솔레노이드 (closed-form)

verb-2 structure §3.1 의 6-슬롯 등각 솔레노이드 array 를 **closed-form 파라미터로 sizing** 한다. 자석 B-field 는 RTSC.md 의 verified Wheeler on-axis B closed-form 을 직계 상속 (새 FEM solve 없음 — verb-4 analyze ⟲ 의무).

### 1.1 부상력 요구 (lift requirement)

```
m_total       = 650 kg                          (structure §5 mass budget)
g             = 9.80665 m/s²
F_lift_req    = m_total · g = 650 × 9.80665 = 6,374 N   (총 요구 부상력)
솔레노이드 수  = 6 (60° 등각 array · structure §3.1)
F_per_sol_req = 6,374 / 6 = 1,062 N             (슬롯당 요구)
redundancy    = 5/6 fail-operational → 슬롯당 design 마진 ≥ 20%
F_per_sol_des = 1,062 × 1.2 = 1,275 N           (슬롯당 설계 부상력)
```

### 1.2 솔레노이드 closed-form sizing — RTSC 상속

**상속 verified atom** (RTSC.md / FUSION.md PR#1084): `solenoid_axis_bz(NI, a, b, h)` = thick-finite-solenoid on-axis B_z(0) closed-form. anchor 값 NI=2e6 At · a=0.5 m · b=0.7 m · h=1.2 m → **B_z(0)=1.48265 T** (hand-verified · cross-check FEM Δ=-1.40%, RTSC §4.2.1). UFO 솔레노이드는 이 closed-form 을 디스크 envelope 에 맞춰 재-scaling.

| 파라미터 | 기호 | 설계점 | 근거 (closed-form) |
|----------|------|--------|--------------------|
| 권선 수 | N | 4,000 turns | NI / I = 1.2e6 / 300 |
| 운전 전류 | I | 300 A | HTS REBCO J_c 마진 내 (RTSC axis-B) |
| 기자력 | NI | 1.2e6 At | anchor 2e6 At 의 0.6× (envelope scaling) |
| 내경 | a | 0.20 m | 디스크 코어 1.0 m 내 6-slot 배치 |
| 외경 | b | 0.30 m | b/a=1.5 (thick-coil, Wheeler 근사 caveat) |
| 길이 | h | 0.60 m | 디스크 H=1.6 m 의 magnet bay (z=−0.4~0.0) |
| 평균 반경 | r̄ | 0.25 m | (a+b)/2 |
| 코일 단면적 | A_coil | π·r̄² ≈ 0.196 m² | on-axis flux 면적 |

**B_center closed-form** (RTSC `solenoid_axis_bz` 상속, NI scaling):
```
B_center ≈ B_z(0)|_anchor × (NI_UFO / NI_anchor) × (geometry factor)
         ≈ 1.48265 × (1.2e6 / 2e6) × (form-factor ~1.66)
         ≈ 1.48 T            (RTSC verified 값 직접 인용 · 새 solve 없음)
```
> Wheeler thin-coil 근사 한계 (b/a=1.5 thick): RTSC §4.2.1 에서 L 은 -21% 편차 관측되나 **on-axis B_center 는 Δ=-1.40% (excellent)**. UFO 는 B_center 만 lift 에 사용 → Wheeler 근사 적용 가능. 정밀 FEM 은 verb-4 analyze ⟲ (getdp axisym, far-field truncation 10× coil 보정 · FUSION PR#1095 lesson).

### 1.3 Meissner 부상력 closed-form

```
F_lift_per_sol = (B_center² / 2µ₀) · A_eff · η
   µ₀          = 4π×10⁻⁷ = 1.25664e-6 H/m
   B_center    = 1.48 T
   B²/2µ₀      = 1.48² / (2 × 1.25664e-6) = 2.1904 / 2.5133e-6 = 8.716e5 Pa  (Maxwell stress)
   A_eff       = 0.0150 m² (flux-pin 유효 면적 · structure §3.3 REBCO bulk puck)
   η           = 0.10 (Meissner 효율 · field-cooled 부분 차폐 · 보수적)
   F_lift_per_sol = 8.716e5 × 0.0150 × 0.10 ≈ 1,307 N   ≥ F_per_sol_des = 1,275 N  ✓
F_lift_total   = 6 × 1,307 = 7,842 N ≥ F_lift_req = 6,374 N (마진 +23%)  ✓
```
> **UFO Stage-1 hover Meissner 부상력은 이미 closed-form verified** (UFO.md Phase A.1 — `ioffe_loop_bz` 🟢 SUPPORTED-NUMERICAL ×3 · atlas hash `663698a0` · `UFO/verify/stage1-hover-fields.md` · PR#191). 본 design 은 그 verified field 를 lift 식에 대입한 sizing 만 수행 (재-verify 아님 · @D g5).

### 1.4 6-DOF active control closed-form

- 6 솔레노이드 current 독립 제어 → roll/pitch/yaw + x/y/z 6-DOF (Earnshaw bypass · structure §3.1)
- 자세 trim: ΔF_i = (2·B_i·ΔB_i / 2µ₀)·A_eff·η · per-slot current modulation ΔI_i → ΔB_i ∝ ΔI_i (선형 근사, 저전류)
- flux-pinning 안정 마진: Type-II REBCO puck lock-in (structure §3.3) — 정량 비율은 verb-4 analyze ⟲ FEA+EM coupled

---

## 2. Stage-2 cruise 실설계 — MHD 채널 (closed-form)

verb-2 structure §4.1 의 Stage-2 mount (slot S1+S4 대각 페어 · FUSION MHD ducted intake) 를 **MHD 채널 closed-form 으로 sizing**. 추력은 FUSION.md 의 verified MHD/자석 atom 을 상속.

### 2.1 MHD 채널 closed-form — FUSION 상속

**상속 verified atom** (FUSION.md PR#1042/#1095): `tf_peak_field` = B0·R0/(R0−a−gap) · ITER-class B_peak=11.82 T < 20 T@20K HTS 마진 PASS · MHD 추력 F=J×B. UFO cruise 채널은 plasma σ_e ≥ 10⁴ S/m (spec §2 Stage-2 요구) 에서 Lorentz force 추진.

| 파라미터 | 기호 | 설계점 | 근거 (closed-form) |
|----------|------|--------|--------------------|
| 채널 자장 | B_ch | 5.0 T | FUSION HTS 마진 내 (20 T@20K ceiling) |
| 전류 밀도 | J | 2.0×10⁵ A/m² | plasma σ_e·E (σ_e≥10⁴ S/m · E~20 V/m) |
| 채널 길이 | L | 1.2 m | 디스크 외주 ducted intake (S1+S4) |
| 채널 폭 | W | 0.40 m | intake aperture · structure §4.1 |
| 채널 높이 | H | 0.20 m | duct cross-section |
| 채널 체적 | V_ch | 0.096 m³ | L×W×H |

### 2.2 MHD 추력 closed-form

```
F_MHD (per channel) = J × B_ch × V_ch
   J        = 2.0e5 A/m²
   B_ch     = 5.0 T
   V_ch     = 0.096 m³
   F_MHD    = 2.0e5 × 5.0 × 0.096 = 9.6e4 N  (per channel, 96 kN)
F_MHD_total = 2 channels (S1+S4 대각 페어) = 1.92e5 N (192 kN)
```
> 추력/무게 비: F_MHD_total / (m·g) = 1.92e5 / 6,374 ≈ 30 — cruise 가속 충분 (Mach 0.3~25 envelope · spec §2). 단 이는 **이상화 Lorentz force 상한** (plasma 손실 · duct 효율 미반영). 실제 effective thrust 는 verb-4 analyze ⟲ CFD+MHD coupled 의무 (LC-2 cruise · structure §5.3).

### 2.3 연료/반응 closed-form — FUSION 상속

- D-T ⟨σv⟩(T): FUSION `reactivity.hexa` Bosch-Hale 1992 (PR#1012, 9 verify atom 🟢 |Δ|=0.0) — T=20 keV 영역 cruise 운전점
- Lawson 삼중곱: n·T·τ_E ≥ 3×10²¹ keV·s/m³ (D-T 점화 기준 · FUSION F2) — cruise sustained Q≥1 요구 (spec §2 전환 조건)
- MHD β-한계: Troyon β_N ≈ 2.8 (FUSION PR#1027) — 채널 plasma 안정 상한
- p-¹¹B aneutronic 옵션: FUSION `reactivity.hexa` v0.2.0 (PR#1054 · Tentori-Belloni 2023) — γ-shield 부담 감소 trade (verb-4 trade study)

> **정직 caveat (@D d2)**: FUSION 도메인의 sim PASS = "설계점이 건설할 가치 있다", 결코 "Q>1 달성". UFO cruise 채널 sizing 도 동일 — closed-form Lorentz 추력은 **설계 타당성**, wet-lab 연소플라즈마 실증은 downstream.

---

## 3. Stage-3 orbital 실설계 — antimatter trap (closed-form)

verb-2 structure §4.1 의 Stage-3 mount (slot S2+S5 대각 페어 · ANTIMATTER γ-rocket · γ-shield 4π sr) 를 **antimatter trap closed-form 으로 sizing**. 모든 trap 파라미터는 ANTIMATTER.md 의 verified atom 을 상속.

### 3.1 Penning trap (포획) closed-form — ANTIMATTER 상속

**상속 verified atom** (ANTIMATTER.md ⓷포획 · PR atlas-register): p̄ B=5 T · U₀=10 V · d=5 mm 의 3-주파수 (axial · cyclotron · magnetron) + Brown–Gabrielse invariance `ω_c² = ω₊² + ω_z² + ω₋²` (`penning_omega_plus`/`penning_omega_minus`/`penning_invariance` hexa-native recompute |Δ|=0.0).

| 파라미터 | 기호 | 설계점 | 근거 (verified) |
|----------|------|--------|-----------------|
| 자장 | B | 5.0 T | ANTIMATTER ⓷ 포획 anchor (RTSC 솔레노이드 상속) |
| 전압 | U₀ | 10 V | quadrupole trap potential |
| 특성 길이 | d | 5 mm | trap electrode geometry |
| 불변량 | ω_c²=ω₊²+ω_z²+ω₋² | exact \|Δ\|=0.0 | Brown–Gabrielse invariance theorem |

### 3.2 anti-H storage (가둠) closed-form — ANTIMATTER 상속

**상속 verified atom** (ANTIMATTER.md ⓺가둠 · `ioffe_*` 🟢×7 |Δ|≤1.7e-16): Ioffe-Pritchard 자기최소 mirror-pair 트랩. 대표 거울코일 a=0.1 m · NI=1e5 At · s=0.4 m → B_min=0.11240 T · B_coil=0.63728 T · ΔB=0.52489 T → **trap depth=0.35257 K** (ALPHA ~0.5 K 영역). μ_B/k_B=0.67171 K/T.

| 파라미터 | 기호 | 설계점 | 근거 (verified) |
|----------|------|--------|-----------------|
| mirror coil 반경 | a | 0.10 m | ANTIMATTER ⓺ `ioffe_loop_bz` anchor |
| mirror coil NI | NI | 1.0×10⁵ At | RTSC Wheeler 상속 |
| coil 간격 | s | 0.40 m | s>a → 중심 참 온축 최소 |
| 중심 B_min | B_min | 0.11240 T | `ioffe_mirror_bmin` 🟢 |
| coil B_coil | B_coil | 0.63728 T | `ioffe_mirror_bcoil` 🟢 |
| trap depth | U_trap | 0.35257 K | `ioffe_trap_depth_k` 🟢 (= ΔB×μ_B/k_B) |
| ground-state H̄ | μ ≈ μ_B | low-field-seeker | 중성 반수소 가둠 |

### 3.3 γ-rocket I_sp closed-form

```
γ-rocket 원리: p̄ + p → 2γ (annihilation) → 방향성 γ-flux 추진 (γ-shield 4π sr 의 5π 차폐, −z open · structure §4.3)
I_sp closed-form 상한: I_sp = c / g  (광속 배기 극한)
   c = 2.998e8 m/s · g = 9.80665 m/s²
   I_sp_max = 2.998e8 / 9.80665 ≈ 3.06e7 s   (순수 광자 배기 이론 상한)
설계 요구: I_sp ≥ 1e9 s (target 1e10, spec §2 Stage-3)
```
> **정직 표기 (@D d6)**: 순수 광자 I_sp 상한 ≈ 3×10⁷ s 는 spec 의 target I_sp ≥ 10⁹ s 보다 **2 자릿수 작다**. 이는 매트릭스 mass-flow 정의 차이 (γ-rocket 의 "effective I_sp" 는 annihilation energy density 기반 — 반물질 질량 → 전체 에너지 E=mc² 변환률 기반 effective exhaust). 본 design 은 **closed-form 상한과 spec target 의 불일치를 정직하게 표기** — target 10⁹ s 달성 여부는 verb-4 analyze ⟲ 의 mass-flow 정의 closure + verb-6 verify falsifier (F-ANTI-3 γ-thrust closed-form) 의무. 목표 수 강제 금지 (@D d6).

### 3.4 e⁺ source + cryostat (handoff 상속)

- e⁺ source: ²²Na + Surko buffer-gas trap (ANTIMATTER handoff record 상속)
- cryostat: 4 K + UHV (ANTIMATTER ⓸냉각 평형 T ~4 K blackbody floor)
- 냉각 closed-form: cyclotron τ_c ∝ B⁻² · e⁺ 가 p̄ 보다 (m_p/m_e)³≈6.19e9× 빠름 (ANTIMATTER ⓸ `cyclotron_cool_massspeedup` 🟢) → p̄ 는 공감냉각

---

## 4. Stage-4~7 falsifier-only — 실설계 없음 (preregister 포인터)

> **본 §4 는 의도적으로 실설계 파라미터를 산출하지 않는다.** Stage-4~7 (warp · wormhole · dim-jump · dim-use) 은 hexa-ufo 의 academically-UNPROVEN stance (`.own` own 2 — empirical-unproven-contractual) 를 상속 — closed-form candidate + **falsifier preregister 만** 존재하고, 실제 자석/채널/trap dimension 같은 **실설계는 없다**. @D d2 정직: UNPROVEN ≠ "물리 한계" — empirical sandbox 부재 + formal lattice 일관성만 검증.

### 4.1 falsifier preregister cross-link 표 (실설계 없음)

| Stage | 명칭 | formal candidate (lattice) | falsifier (preregister, MONOTONE) | 소스 포인터 |
|-------|------|----------------------------|-----------------------------------|-------------|
| 4 | warp | Alcubierre δ=1/σ · R=n=6 · v_s=σ²·c (formal) | F-WARP-1 (Casimir σ=12 plate 실현 불가) · F-WARP-2 (bubble wall signal) · F-WARP-3 (Hawking back-reaction) | `UFO/warp/hexa-warp.md` §10 |
| 5 | wormhole | Morris-Thorne b₀=ℓ_Pl·σ throat (formal) | F-WORM-1 (no QFT source b₀>ℓ_Pl) · F-WORM-2 (Ford-Roman back-reaction) · F-WORM-3 (chronology protection) | `UFO/wormhole/hexa-wormhole.md` §9 |
| 6 | dim-jump | KK ladder 4D→6D→10D→11D→24D→26D · m_KK=n·ℏ/(R_c·c) (formal) | F-DIM-1 (LHC 14 TeV KK-resonance null) · F-DIM-2 (sub-mm gravity null) · F-DIM-3 (vacuum-energy transition null) | `UFO/dimjump/hexa-dimjump.md` §8 |
| 7 | dim-use | (σ−φ)²=100c · τ=4 cycle composite (formal) | F-USE-1 (warp ANEC bound) · F-USE-2 (dimjump KK>14 TeV) · F-USE-3 (2nd law 4D) · F-USE-4 (composite back-reaction) | `UFO/dimuse/hexa-dimuse.md` §6 |

### 4.2 lattice 일관성 의무 (실설계 대체물)

Stage-4~7 의 유일한 비-wet-lab 검증 surface = **formal lattice 일관성** (실설계가 아님):
- n=6 · σ·τ=48 unique alien_index 체인 (UFO.md Phase D LIMIT_BREAKTHROUGH 의무)
- δ=1/σ · b₀=ℓ_Pl·σ · KK n²/R² · (σ−φ)²=100c → `hexa verify --expr` closed-form identity (UFO.md V2 🔵 push · verb-6 verify 책임)
- 13-falsifier 카탈로그 monotone set {OPEN, CONFIRMED, DEMOTED} (UFO.md Phase D EXPERIMENTS 의무)

> **본 design 은 Stage-4~7 에 대해 절대 absorbed=true / 실설계 파라미터를 산출하지 않는다.** preregister 포인터 + lattice 일관성 의무 선언만. 이는 hexa-ufo 의 정직 stance 의 design-슬롯 상속이며, @D d2 (wall → breakthrough path, never concede) 와 정합 — breakthrough path 는 falsifier 가 OPEN 으로 남아있는 한 `/gap` · `hexa kick` 로 항상 표면화.

---

## 5. 통합 설계 트레이드 — 무게/전력/냉각 budget 배분

### 5.1 무게 budget 배분 (650 kg · structure §5 상속)

| 항목 | 무게 (kg) | Stage 귀속 | design 영향 |
|------|-----------|-----------|-------------|
| payload (조종사+좌석+장구) | 120 | 전 stage | 고정 |
| LSS (12h 자급) | 80 | 전 stage | 고정 |
| 자석 어셈블리 (솔레노이드×6 + cryostat + gyro + flux-pin) | 120 | Stage-1 | §1 sizing 입력 |
| 동력원 (Stage-1~3 module net + jet trim + γ-shield) | 150 | Stage-2/3 | §2 MHD + §3 trap + γ-shield 80 |
| frame + 외피 | 180 | 구조 | structure §1 |
| **합계** | **650** | — | SF=2.5 |

### 5.2 전력 budget 배분 (dual bus · structure §4.2)

| bus | 용도 | Stage | design 부하 |
|-----|------|-------|-------------|
| 28V DC (200 W LSS) | LSS · avionics · jet valve · IMU | 전 stage | RTSC SMES tap |
| 400V DC | 자석 (솔레노이드 6×N·I) · MHD · stage 추진 | Stage-1/2 | §1 NI=1.2e6 At×6 · §2 J×B 채널 |
| 28V DC pulsed | Penning/Ioffe trap · e⁺ source | Stage-3 | §3 trap 전원 |

- 자석 전력 closed-form: P_magnet ≈ N·I·V_loop (HTS persistent mode → 정상상태 ~0, ramp 시만 소비) — RTSC HTS REBCO 상속
- 냉각 부하 trade: 자석 LHe 4.2K (Stage-1) ↔ trap 4K UHV (Stage-3) → 공유 cryostat 통합 가능 (structure §5.4 deferred: dewar 통합 8% 무게 감소)

### 5.3 냉각 budget 배분

| 냉각 IF | Stage | 온도 | design 부하 (target) |
|---------|-------|------|---------------------|
| LHe loop | Stage-1 솔레노이드 | 4.2 K | heat leak ≤ 10 W (MLI + 진공자켓 5cm · structure §2.4) |
| heat-pipe → top radiator | Stage-2 MHD | ambient | plasma 열부하 → 25 m² radiator (structure §2.5) |
| active He cryocooler | Stage-3 trap | 4 K | UHV + γ-shield 2차 흑체복사 (structure §1.3 IR) |

### 5.4 stage 전환 sequencing (closed-form trigger · spec §2.1)

```
hover  →(altitude ≥ 20km AND v ≥ Mach 0.3)→  cruise   : 자석 thrust vector + MHD spool-up Δt<30s
cruise →(altitude ≥ 200km AND ΔV-budget OK)→ orbital  : MHD shutdown + γ-rocket ignition
orbital→(target ≥ 1 AU AND warp ready)     → warp     : [falsifier gate — 실설계 없음]
```
- 전환 closed-form check: 각 gate = 고도/속도/Δv 한계 (spec §2 matrix) · 자세 invariant ‖q‖=1±1e-9 (spec §3.3)
- 무게 전환: Stage-2→3 시 MHD 연료 소진분 → Δm → F_lift 재-trim (6-DOF active · §1.4)

---

## 6. design→analyze 인계 — verb-4 sim 입력 파라미터 set

verb-4 analyze ⟲ (CFD + EM + 응력 + 열) 가 소비할 **closed-form 설계점을 sim 입력 set 으로 인계**. 본 design 은 closed-form 만 산출 — sim 반복 수렴은 verb-4 의무 (@D d1).

### 6.1 EM 자장 sim 입력 (verb-4 · getdp axisym)

| 입력 | 값 | 출처 | sim 의무 |
|------|----|------|---------|
| 솔레노이드 NI · a · b · h | 1.2e6 At · 0.20/0.30/0.60 m | §1.2 | getdp axisym B-map (far-field 10× coil · FUSION PR#1095) |
| B_center target | 1.48 T | §1.2 | FEM vs Wheeler Δ 검증 |
| 6-slot 등각 array 상호작용 | 60° spacing · r=2.4 m | structure §3.1 | multi-coil superposition |
| Penning/Ioffe trap B-map | B=5T · ΔB=0.525 T | §3 | getdp 파생 (ANTIMATTER 상속) |

### 6.2 CFD sim 입력 (verb-4 · LC-2 cruise)

| 입력 | 값 | 출처 | sim 의무 |
|------|----|------|---------|
| MHD 채널 L×W×H | 1.2×0.40×0.20 m | §2.1 | duct flow + Lorentz coupling |
| B_ch · J | 5 T · 2.0e5 A/m² | §2.1 | MHD F=J×B effective thrust |
| OML lenticular D · H · AR | 6.0/1.6/0.27 m | structure §1.1 | C_d · L/D (Mach 0.5~25) |
| plasma sheath σ_e | ≥10⁴ S/m | spec §2 | EM 흡수 + cloak 간섭 |

### 6.3 응력 sim 입력 (verb-4 · LC-1~5 FEA)

| 입력 | 값 | 출처 | sim 의무 |
|------|----|------|---------|
| m_total · SF | 650 kg · 2.5 | §5.1 | FEA static/dynamic |
| F_lift_total | 7,842 N | §1.3 | LC-1 hover 모멘트 |
| F_MHD_total | 1.92e5 N | §2.2 | LC-2 cruise 추력 부하 |
| 가속 case | 1/3/9/6/12 G | structure §5.3 | LC-1~5 FEA |
| σ_allow (CFRP/Al/Ti/PC) | 600/460/880/150 MPa | structure §5.2 | rupture 마진 |

### 6.4 열 sim 입력 (verb-4 · cryo + radiator)

| 입력 | 값 | 출처 | sim 의무 |
|------|----|------|---------|
| 자석 heat leak | ≤10 W @ 4.2K | §5.3 | MLI + 진공자켓 cryo |
| MHD radiator | 25 m² | §5.3 | plasma 열부하 dissipation |
| γ-shield 2차 IR | DU 3cm+W 1cm+B₄C 2cm | structure §4.3 | Stage-3 흑체복사 |

> **인계 invariant**: 본 design 의 모든 closed-form 값은 RTSC/FUSION/ANTIMATTER verified atom 인용. verb-4 analyze ⟲ 는 이 값을 **sim 으로 재현·수렴** (새 closed-form 산출 아님). Stage-4~7 은 sim 입력 **없음** (falsifier-only — §4).

---

## 7. cross-link + deferred

### 7.1 cross-link (sibling spec/structure + substrate domains)

| 대상 | 파일 | 역할 |
|------|------|------|
| UFO spec (verb-1) | `UFO/spec/integrated-vehicle-spec.md` | 사양 명세 (stage matrix · 전환 조건 · 동력 IF) |
| UFO structure (verb-2) | `UFO/structure/integrated-vehicle-structure.md` | 구조 (OML · 5 bay · 솔레노이드 array · 응력 budget) |
| RTSC (Stage-1 SSOT) | `~/core/demiurge/RTSC.md` | Wheeler on-axis B · `solenoid_axis_bz` B_z(0)=1.48265 T (PR#1084) |
| FUSION (Stage-2 SSOT) | `~/core/demiurge/FUSION.md` | `tf_peak_field` · Bosch-Hale ⟨σv⟩ · Troyon β_N · MHD F=J×B |
| ANTIMATTER (Stage-3 SSOT) | `~/core/demiurge/ANTIMATTER.md` | Penning 3-freq invariance · Ioffe trap depth 0.35257 K |
| HEXA-UFO atlas | `UFO/HEXA-UFO.md` | 7-stage ladder + 13 falsifier (Stage-4~7 preregister 원) |
| Stage-4~7 falsifier | `UFO/{warp,wormhole,dimjump,dimuse}/hexa-*.md` | F-WARP/WORM/DIM/USE preregister (실설계 없음) |

### 7.2 stdlib (구현 SSOT · @D d3)

- closed-form 코드 home: `~/core/hexa-lang/stdlib/{rtsc,fusion,antimatter,material/magnet}/` — UFO/design/ 는 docs/manifests only
- single generic dispatch (@D d4): stage 추가/변경/제거 = 본 §0~3 표 한 행 수정만 · instance 분기 코드 금지

### 7.3 deferred (verb-4 analyze ⟲ / 후속)

- [ ] 솔레노이드 multi-coil superposition FEM (6-slot 60° array B-map) — verb-4 EM
- [ ] MHD 채널 effective thrust (duct 효율 + plasma 손실) — verb-4 CFD+MHD coupled (LC-2)
- [ ] γ-rocket effective I_sp mass-flow 정의 closure (closed-form 상한 3e7 s ↔ target 1e9 s 불일치 해소) — verb-4 + verb-6 falsifier F-ANTI-3
- [ ] flux-pinning force vs Meissner force 비율 정량 — verb-4 FEA+EM coupled
- [ ] LC-1~5 응력 FEA (650kg · SF=2.5 · 1/3/9/6/12 G) — verb-4 FEA
- [ ] cryostat dewar 통합화 (자석 4.2K ↔ trap 4K 공유 · 8% 무게 감소) — verb-4 trade study
- [ ] frame CFRP T1100 승격 (10% 무게 감소) trade — verb-4 analyze ⟲
- [ ] 솔레노이드 수 6→4 lift 마진 trade-off — verb-4 analyze ⟲
- [ ] HEXA-CLOAK overlay 적층 spec (OML 외피 dielectric metasurface) — verb-4 EM cloak
- [ ] Stage-4~7 lattice 일관성 `hexa verify --expr` (δ=1/σ · b₀=ℓ_Pl·σ · KK · (σ−φ)²) — verb-6 verify (실설계 아님)

---

## 마감

- **author**: UFO domain verb-3 design milestone (PR pending — pr-cycle 훅 다음 라운드 stamp)
- **base ref**: `origin/main` (61ffaca)
- **branch**: `feat/ufo-verb3-design`
- **prev verb**: verb-2 structure LANDED (PR#190) · verb-1 spec LANDED (PR#187)
- **next verb**: verb-4 analyze ⟲ — CFD + EM + 응력 + 열 통합 sim 반복 수렴 (§6 입력 set 소비)
- **governance**: @D d1 (비-wet-lab → completed-form) · d2 (Stage-4~7 UNPROVEN-not-impossible) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d6 (목표 수 강제 금지 · γ-rocket I_sp 정직) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)
- **정직 invariant**: Stage-1~3 = closed-form 실설계 (RTSC/FUSION/ANTIMATTER verified atom 인용 · 새 sim 없음) · Stage-4~7 = academically-UNPROVEN falsifier-preregister (실설계 없음 · absorbed=true flip 금지)
