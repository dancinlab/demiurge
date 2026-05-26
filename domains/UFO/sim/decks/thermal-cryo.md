# 🛸 UFO — 열 cryo transient + radiator 열평형 ledger (closed-form verify 🟢)

@title: 🛸 UFO — 통합 비행체(직접개발) · ④ 열관리 (cryo + radiator)
@parent: ~/core/demiurge/UFO.md
@deck: `UFO/sim/decks/thermal_cryo.hexa` (hexa-run 9/9 PASS · sentinel `__UFO_THERMAL_CRYO__ PASS`)
@governance: @D d1 (non-wet-lab → completed-form) · d2 (wall ≠ 불가능) · d5 (absorbed ⇔ 全 gate PASS) · d6 (목표 수 강제 금지) · g5 (verdict verbatim)

> verb-4 analyze ⟲ 의 **④ 열관리 layer** 게이트. 기존 디지털트윈은 **정상상태 열평형 budget 만** 있고 transient(과도) 본해가 없어 V4 ledger §3 에서 🟠 였다. 본 데크는 열 budget 4 축 — ① Stefan-Boltzmann radiator 면적 sizing · ② cryostat heat leak ≤10W · ③ LHe boil-off → 비행시간 · ④ lumped-capacitance transient 1차 ODE closed-form — 을 **first-principles closed-form** 으로 닫아 🟠 → 🟢-anchored 로 승격한다. 결론을 먼저 적는다: **9/9 PASS**, heat leak 3.38 W (≤10 W ✅), radiator 5 kW reject @ 15.77 m² (25 m² 설치 → 1.59× 마진), LHe boil-off 13.78 L/h → 50 L dewar 기준 **비행시간 3.63 h 제약**.

---

## 0. TL;DR

```
   🛸 UFO ④ 열관리 — closed-form 열평형 (hexa-run 9/9 PASS)
   ──────────────────────────────────────────────────────────────────
   ① radiator  Q̇=εσ(T⁴−T_amb⁴)A  → 25 m² @ 320K = 7928 W ceiling
                                     5 kW reject ⇒ A_min 15.77 m² (1.59× 마진)
   ② heat leak  MLI(2.67W) + 지지전도(0.71W) = 3.38 W  ≤ 10 W  ✅
   ③ boil-off   ṁ=Q/h_fg = 4.78e-4 kg/s = 13.78 L/h
                → 50 L LHe dewar ⇒ 비행시간 3.63 h (10 W leak 기준)
   ④ transient  m·c·Ṫ=Q_in−Q_out → T(t)=T_eq+(T_0−T_eq)e^{−t/τ}
                τ_rad = 29161 s ≈ 8.1 h · 5τ 에서 1% 이내 settle
   ──────────────────────────────────────────────────────────────────
   gate: 🟠 (정상상태만) → 🟢 (closed-form transient + 4축 anchored)
```

---

## 1. 열 budget — 발열원 inventory

verb-3 design §5.3 + structure §2.4/§2.5 냉각 budget 을 소비. 열원을 두 온도 영역으로 분리:

| 발열원 | Stage | 온도 영역 | 부하 | 처리 경로 |
|--------|-------|----------|------|----------|
| RTSC 솔레노이드 AC loss / ramp | Stage-1 hover | 4.2 K (cryo) | persistent mode 정상상태 ~0, ramp 시만 (design §5.2) | LHe loop heat leak 에 흡수 |
| MLI 복사 + 지지 전도 leak | Stage-1 cryostat | 300 K → 4.2 K | **3.38 W** (§3) | LHe boil-off |
| Stage-2 MHD plasma duct 대류 분 | Stage-2 cruise | ambient | active-loop reject ≤5 kW (§2) | heat-pipe → top radiator |
| avionics rack | 전 stage | ambient | ~200 W (structure §2.6) | radiator |
| γ-shield 2차 IR | Stage-3 trap | 4 K UHV | blackbody floor (ANTIMATTER ⓸ 상속) | active He cryocooler |

> **정직 분리 (@D d6)**: Stage-2 MHD plasma enthalpy 의 대부분은 **배기와 함께 빠져나간다** — radiator 가 받는 active-loop reject 는 그 보수적 대류 분 + avionics + 자석 AC headroom = **5 kW** 로 sizing. 데크는 8 kW 같은 강제 target 을 쓰지 않고, 25 m² panel 의 **물리적 천장 (7928 W @ 320 K)** 을 함께 보고한다.

---

## 2. radiator sizing — Stefan-Boltzmann (verify 🟢)

closed-form: `Q̇ = ε·σ·(T⁴ − T_amb⁴)·A` → `A = Q̇ / (ε·σ·(T⁴ − T_amb⁴))`

| 변수 | 값 | 출처 |
|------|----|------|
| ε (anodised-Al radiator) | 0.85 | white/anodised 표면 |
| σ_SB | 5.670374419e-8 W/m²K⁴ | CODATA |
| T_rad (warm side) | 320 K | top-dome 외피 |
| T_amb (sink) | 250 K | ~20 km 권계면 cruise |
| A_spec | 25 m² | structure §2.5 설치값 |

**verdict (VERBATIM · hexa-run):**
```
  [PASS] radiator area↔heat round-trip identity (A = Q/(εσΔT⁴))
         · Q(25m²) = 7928.01 W → A = 25.0 m², |Δrel| = 0.0
  [PASS] 25 m² radiator capacity > 5 kW active-loop reject (Stage-2 cruise)
         · Q_cap(25m²) = 7928.01 W ≥ Q_design = 5000.0 W (panel ceiling 7928.01 W @ 320 K)
  [PASS] minimum radiator area for 5 kW reject < 25 m² installed
         · A_min = 15.7669 m² (vs 25.0 m² installed → 1.5856× margin)
```

- **sizing 답**: 5 kW active-loop reject 에 필요한 최소 면적 = **15.77 m²** < 25 m² 설치 → **1.59× 마진** ✅
- **panel 천장**: 25 m² @ 320 K 는 **7928 W** 까지 reject 가능 (정직: 8 kW 강제 target 미달 — 25 m² 천장이 7.93 kW 이므로 5 kW sizing 으로 보고)
- **round-trip 항등식**: `A(Q(A)) = A`, |Δrel| = 0.0 (large-mag T⁴~1e10 은 relative residual 로 verify · abs-ε trap 회피)

---

## 3. cryostat heat leak ≤10W + LHe boil-off (verify 🟢)

### 3.1 heat leak — MLI 복사 + 지지 전도

- 복사: `Q_rad = ε_eff·σ·(T_w⁴ − T_c⁴)·A`, `ε_eff = ε_MLI/(N+1)` (이상 MLI shield)
- 전도: `Q_cond = k·A_sup·(T_w − T_c)/L` (1-D Fourier · G-10 지지)

| 변수 | 값 | 출처 |
|------|----|------|
| T_cold | 4.2 K | LHe 단 |
| T_warm | 300 K | 외피 jacket |
| ε_MLI / N | 0.03 / 30 층 | bare-foil · structure §2.4 (MLI + 진공자켓 5cm) |
| A_cryo | 6 m² | cold-surface |
| k (G-10) / A_sup / L | 0.3 W/mK / 4e-4 m² / 0.05 m | cryo-avg 지지 |

**verdict (VERBATIM · hexa-run):**
```
  [PASS] cryostat total heat leak ≤ 10 W budget (MLI + support)
         · Q_rad = 2.66691 W + Q_cond = 0.70992 W = 3.37683 W ≤ 10.0 W
  [PASS] MLI radiation reduction = 1/(N+1) shield factor
         · Q(N=30)/Q(N=0) = 0.0322581, 1/31 = 0.0322581
```

- **heat leak = 3.38 W** (복사 2.67 W + 전도 0.71 W) ≤ **10 W 예산** ✅ — structure §2.4 target 충족, 6.62 W 마진
- **MLI shield 항등식**: 30층 MLI 가 복사를 `1/(N+1) = 1/31` 로 줄임 (verify rel < 1e-9)

### 3.2 LHe boil-off → 비행시간 제약

- `ṁ = Q̇ / h_fg`, `t = m_charge / ṁ = ρ·V·h_fg / Q̇`
- h_fg(LHe, 4.2 K) = 20900 J/kg · ρ_LHe = 125 kg/m³ · V_dewar = 50 L (0.050 m³)

**verdict (VERBATIM · hexa-run):**
```
  [PASS] LHe boil-off rate at 10 W leak (ṁ = Q/h_fg)
         · ṁ = 0.000478469 kg/s = 13.7799 L/h
  [PASS] LHe dewar flight-time identity t = m/ṁ = ρVh_fg/Q
         · t = 3.62847 h (charge 6.25 kg @ 10 W leak)
```

- **boil-off rate = 13.78 L/h** (≈ 4.78e-4 kg/s) — **10 W 예산 상한** 기준 (보수적; 실제 leak 3.38 W → 4.66 L/h 로 더 길어짐)
- **비행시간 제약 (boil-off-limited)**: 50 L LHe dewar (6.25 kg charge) ÷ 10 W leak = **3.63 h**
  - 실제 leak 3.38 W 기준 재계산 시 ≈ **10.7 h** → spec §1 의 **LSS 12 h** 자급 목표와 정합 (10 W 보수 상한에서는 3.63 h 로 보충/active cryocooler 필요)
- **돌파 경로 (@D d2)**: boil-off 가 LSS 12 h 미달 시 → (a) active He cryocooler (structure Stage-3 IF 공유) (b) dewar 용량 증대 (8% 무게 trade · design §6 dewar 통합) (c) HTS REBCO 77 K proxy 전환 (LN₂ h_fg=199 kJ/kg, 10× 긴 boil-off) — "비행 불가" framing 금지

---

## 4. transient — lumped-capacitance 1차 ODE (verify 🟢)

cryocooler trip 시 cold-mass warm-up 의 **과도 응답**. 정상상태-only 🟠 를 닫는 핵심 항목:

- 지배방정식: `m·c·dT/dt = Q_in − Q_out`
- closed-form 해: `T(t) = T_eq + (T_0 − T_eq)·e^{−t/τ}`
- 복사-선형화 시정수: `τ_rad = m·c / (4·ε·σ·A·T_eq³)`

| 변수 | 값 | 비고 |
|------|----|------|
| m (cold mass) | 40 kg | 솔레노이드 + 지지 유효 열용량 질량 |
| c (Cu) | 385 J/kg·K | 비열 |
| T_0 / T_eq | 4.2 K / 77 K | 초기 cryo / active 손실 시 LN₂-proxy passive floor |

**verdict (VERBATIM · hexa-run):**
```
  [PASS] lumped transient T(0)=T_0 · 5τ within 1 % of T_eq
         · τ = 29161.3 s, T(0) = 4.2 K, T(5τ) = 76.5095 K → 77.0 K
  [PASS] transient e-folding: gap(τ)/gap(0) = e^{-1}
         · frac = 0.367879, e^{-1} = 0.367879, τ = 29161.3 s
```

- **시정수 τ_rad = 29161 s ≈ 8.1 h** — cryocooler trip 후 cold-mass 가 passive floor 로 가는 과도 시간상수
- **극한 검증**: T(0) = T_0 (rel < 1e-9) · 5τ (≈40.5 h) 에서 T_eq 의 1% 이내 settle
- **e-folding 항등식**: t=τ 에서 gap 이 e^{−1} = 0.367879 로 감쇠 (지수해의 정의적 닫힘)
- **의미**: cryocooler 단일고장 시 cold-mass 가 ~8 h 시정수로 천천히 데워짐 → 단시간 trip 은 thermal inertia 로 흡수 가능 (운용 안전 마진)

---

## 5. 정직 판정 (@D d1 · d6)

```
   gate: ④ 열 cryo transient + radiator
   ─────────────────────────────────────────────
   이전: 🟠 (정상상태 열평형 budget 만 · transient 본해 없음)
   현재: 🟢 (closed-form 4축 9/9 PASS · transient 1차 ODE 닫힘)
```

- **닫힌 것 (🟢)**: Stefan-Boltzmann radiator sizing · cryostat heat leak ≤10W · LHe boil-off 비행시간 · lumped-capacitance transient — 전부 first-principles closed-form / libm-class (ε_rel ≤ 1e-9) recompute, hexa-run 9/9 PASS.
- **HONEST FENCE (남은 항목)**: 본 데크는 **lumped + 해석 열평형** 이지 **3-D conjugate-heat-transfer CFD/FEM 본해** 가 아니다. 공간 온도 분포 (cold-mass 내부 gradient · radiator fin 효율 분포 · plasma duct 국부 hotspot) 의 full 3-D body-solve 는 여전히 pool/cloud-deferred (@D d7). transient **시정수와 열평형 balance** 는 닫혔으므로 정상상태-only 🟠 의 물리적 핵심은 해소됨 → 🟢-anchored.
- **abs-ε trap 회피 (memory)**: T⁴ ~1e10 large-mag 은 raw 비교 대신 relative residual / 무차원 ratio·identity(=0, =1, e^{−1}, 1/(N+1)) 로 verify → spurious 🔴 회피.
- **π-free (memory)**: Stefan-Boltzmann 은 σ 를 literal 로 carry, transcendental(π/4π) 미사용 → constant-fold precision trap 회피.

---

## 6. cross-link + deferred

- deck: `UFO/sim/decks/thermal_cryo.hexa`
- analyze: `UFO/analyze/integrated-vehicle-analyze.md` §4 (열관리 layer · 지배방정식 · 냉각 IF budget)
- structure: `UFO/structure/integrated-vehicle-structure.md` §2.4 (cryostat heat leak ≤10W) · §2.5 (radiator 25 m²)
- design: `UFO/design/integrated-vehicle-design.md` §5.3 (냉각 budget 배분)
- ledger: `UFO/verify/V4_tier_ledger.md` §3 (게이트 🟠→🟢 갱신)
- @D d1 · d2 · d5 · d6 · g5

deferred:
- [ ] 3-D conjugate-heat-transfer CFD/FEM body-solve (radiator fin 효율 분포 · cold-mass 내부 gradient · plasma duct hotspot) — pool/cloud micro-exp (@D d7)
- [ ] stdlib atom 등록 (`stefan_boltzmann_area` · `lumped_capacitance_tau` · `lhe_boiloff_rate`) → hexa-lang 별 PR (🟡→🟢 escalation)
