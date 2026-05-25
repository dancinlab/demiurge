# 🛸 UFO — ⟲ 4-layer fixed-point coupling ledger (closed-form 수렴 🟢)

@title: 🛸 UFO — 통합 비행체(직접개발) · ⟲ 4-layer fixed-point coupling (absorbed 게이트 #6 마지막)
@parent: ~/core/demiurge/UFO.md
@deck: `UFO/sim/decks/coupling_fixedpoint.hexa` (mini hexa-run 9/9 PASS · sentinel `__UFO_COUPLING__ PASS`)
@gate: V4_tier_ledger §3 · §5 의 **마지막 차단 게이트 ⟲ 4-layer coupling** 🟠 → 본 라운드 판정
@governance: @D d1 (non-wet-lab → completed-form) · d2 (wall ≠ 불가능) · d5 (absorbed ⇔ 全 gate PASS) · d6 (수렴 강제 금지 · 발산 시 정직) · g5 (verdict verbatim)

> verb-4 analyze ⟲ 의 **핵심** — 4 물리 layer (① CFD 공력 · ② EM 자장/부상 · ③ 응력 구조 · ④ 열 cryo) 는 단방향이 아니라 **서로 입력이 된다** (analyze §5). 각 layer 가 이미 닫혔으므로 (EM·열·응력 🟢 · CFD 🟡), 그 출력을 하나의 **결합 map f(state)** 로 묶어 **고정점 수렴** (Gauss–Seidel/Picard · max Δ_rel < 1e-3) 을 실증한다. 결론을 먼저 적는다: **9/9 PASS · 7 iter 수렴 · 최종 max|Δ_rel| = 5.34e-4 < 1e-3 · Banach 수축계수 q = 0.309 < 1**. 고정점 X* = (AoA −4.22° · T_magnet 11.94 K · σ_peak 13.01 MPa · lift_margin +0.188) — **물리적으로 비행 가능한 자기일관 운전점**. 게이트 **🟠 → 🟢**.

---

## 0. TL;DR

```
   🛸 UFO ⟲ 4-layer fixed-point coupling — Gauss–Seidel/Picard (mini hexa-run 9/9 PASS)
   ──────────────────────────────────────────────────────────────────────────────
   state vector  X = [ AoA(deg) · T_magnet(K) · σ_peak(MPa) · lift_margin(–) ]
   coupling map  f : ② EM lift(T) → ④ thermal T(AoA-duty) → ② B_c(T) → ① CFD trim AoA
                     ① aero load   → ③ stress σ(AoA,T)     → ① OML/FSI deflection
   under-relax   ω = 0.7  (강결합 EM↔thermal 안정화 · analyze §5.2)
   stop          max over X ( ‖X_k − X_{k−1}‖ / ‖X_k‖ ) < 1e-3
   ──────────────────────────────────────────────────────────────────────────────
   수렴 결과:
     · iter        = 7
     · max|Δ_rel|  = 5.34e-4   < 1e-3   ✓ 수렴
     · 수축계수 q   = 0.309     < 1      ✓ Banach contraction (relaxation artefact 아님)
   고정점 X* :
     · AoA*         = -4.22°    (EM 부상 +18.8% 과잉 → 공력이 소폭 downforce 로 trim)
     · T_magnet*    = 11.94 K   (EM duty 발열 → cold floor 4.2K 위로 상승 · Tc=90K 여유)
     · σ_peak*      = 13.01 MPa (SF = 46.1 ≫ 2.5)
     · lift_margin* = +0.188    (F_EM + L_aero ≈ m·g 닫힘)
   ──────────────────────────────────────────────────────────────────────────────
   게이트 ⟲ 4-layer coupling :  🟠  →  🟢   (고정점 수렴 + 수축 + 자기일관 + 비행가능)
```

---

## 1. 4-layer 결합 구조 (analyze §5 인용)

각 layer 는 선행 라운드에서 닫혔고 (출력값 = 본 결합 map 의 입력), 그 출력이 서로의 입력이 되는 **양방향 결합** (⟲) 이 본 게이트의 본질.

```
            ┌───────────────[ ⟲ COUPLING LOOP — fixed point ]───────────────┐
            │                                                                │
            ▼                                                                │
     ╭──────────────╮   부상력 마진     ╭──────────────╮  aero load(D,L)      │
     │  ① CFD       │ ◄─────────────── │  ② EM        │ ───────────────►     │
     │  trim AoA     │   (lift_margin)  │  B_c(T)·lift  │      ③ 응력 σ        │
     │  L(α)·D(α)    │ ───────────────► │  F=(B²/2µ₀)Aη │                      │
     ╰──────┬───────╯   aero→stress     ╰──────┬───────╯                      │
            │ deflection→OML(FSI)               │ EM duty q'''(AoA)            │
            ▼                                    ▼                             │
     ╭──────────────╮   열응력 σ=E·α·ΔT  ╭──────────────╮                       │
     │  ③ 응력 FEA   │ ◄─────────────── │  ④ 열 cryo    │                       │
     │  σ_vm(AoA,T)  │                  │  T_eq(q'''+   │                       │
     │  SF=σ_allow/σ │                  │  Q_leak)      │ ──── B_c(T) ──────────┘
     ╰──────────────╯                  ╰──────────────╯   (열→EM 물성 derating)
   ───────────────────────────────────────────────────────────────────────────
   수렴 기준: max over {AoA, T_magnet, σ_peak, lift_margin} (Δ_rel) < 1e-3
```

| layer | 닫힌 출력 (선행 라운드) | 본 결합 map 에서의 역할 | 데크 |
|-------|------------------------|------------------------|------|
| ① CFD | C_d=0.030 · L/D=0.77 · L₀=1000.77 N · D₀=1305.56 N (AoA=0) | trim AoA = (L_req − L₀)/(dL/dα) · L(α)·D(α) | `cfd-disc.md` 🟡 |
| ② EM | single-coil 3.01593 T 🟢 · B_center≈1.48 T · F_lift_total 7842 N | B_c(T) derating → Meissner lift → lift_margin | `em-6coil.md` 🟢 |
| ③ 응력 | LC-1 σ=0.771 MPa (1G) · SF≥64.8 · σ_allow 600 MPa | σ_vm(aero load, ΔT) = σ_mech + σ_thermal | `stress-fea.md` 🟢 |
| ④ 열 | heat leak 3.38 W · transient τ=8.1 h | T_eq = T_base + R_th·(Q_leak + Q_em(AoA)) | `thermal-cryo.md` 🟢 |

---

## 2. coupling map f(state) — 결합 항 (8 방향 · analyze §5.1)

state vector **X = [AoA, T_magnet, σ_peak, lift_margin]** 에 대해, 한 Gauss–Seidel sweep 은 ②→④→③→① 순으로 각 sub-step 이 최신 component 를 소비:

| from → to | coupling 항 (closed-form) | 물리 |
|-----------|---------------------------|------|
| ② EM → ④ 열 | `Q_em = Q_em_base + k·|AoA|` → `T_eq = T_base + R_th·(Q_leak + Q_em)` | EM duty 발열 (cruise-load proxy) → cold-stage 온도 |
| ④ 열 → ② EM | `B(T) = B_center·(1 − (T/Tc)²)` (GL two-fluid derating) | HTS B_c(T) → 자장 → 부상력 |
| ② EM → ① CFD | `AoA = (m·g − F_EM − L₀)/(dL/dα)` | 부상력 마진 → 공력 trim 각 |
| ② EM → ③ 응력 | `F_lift = 6·(B²/2µ₀)·A_eff·η` → lift_margin | Meissner 부상력 → 구조 부하 |
| ① CFD → ③ 응력 | `σ_mech = σ_LC1·(|D(α),L(α)| / load_ref)` | aero 압력 분포 → von Mises |
| ④ 열 → ③ 응력 | `σ_thermal = K·E·α·(T_amb − T_magnet)/1e6` | cryo↔ambient ΔT → 열응력 |
| ③ 응력 → ① CFD | (deflection → OML/AoA · FSI · 본 라운드 미소) | 구조 변형 → 형상 갱신 |
| ① CFD → ④ 열 | (high-Mach 정체점 가열 · 본 cruise envelope 미소) | aero 가열 → 열원 |

> **정직 (@D d6 · large-mag/π-free guard)**: 모든 수렴 판정은 **per-component 상대 잔차의 max** 또는 무차원 ratio/identity — σ(MPa)·T(K)·AoA(deg) 의 스케일 차를 raw abs-ε 로 비교하는 함정 회피. µ₀·(B²/2µ₀) 는 literal carry (transcendental 미사용).

---

## 3. 고정점 수렴 결과 (mini hexa-run · VERBATIM)

```
hexa run UFO/sim/decks/coupling_fixedpoint.hexa     (host = mini · sentinel __UFO_COUPLING__)
```

**verdict (VERBATIM · @D g5):**
```
  ── fixed-point result ──────────────────────────────────────────────
    iterations to converge : 7.0
    final max |Δrel|        : 0.000534027
    max contraction q       : 0.309002
    fixed point X* :
      AoA*         = -4.22333 deg
      T_magnet*    = 11.9372 K
      σ_peak*      = 13.0086 MPa
      lift_margin* = 0.187611

§1 convergence + contraction
  [PASS] 4-layer fixed-point converged: max rel-Δ < 1e-3
         · iters = 7.0, final max|Δrel| = 0.000534027 < 0.001
  [PASS] coupling map is a Banach contraction (q < 1)
         · max empirical contraction q = 0.309002 < 1 (under-relaxation ω = 0.7)
  [PASS] fixed point self-consistent: ‖f(X*) − X*‖/‖X*‖ < 1e-3
         · residual after one extra sweep = 0.00024341

§2 fixed-point physics (flyable operating point)
  [PASS] converged lift balance: F_EM + L_aero ≈ m·g
         · F_EM = 7570.24 N + L_aero = -1195.36 N = 6374.88 N vs m·g = 6374.32 N
  [PASS] converged σ_peak keeps SF ≥ 2.5 (FAA Pt.25)
         · σ* = 13.0086 MPa → SF = 46.1232 ≥ 2.5
  [PASS] converged T_magnet < Tc — magnet stays superconducting
         · T* = 11.9372 K < Tc = 90.0 K, B(T*) = 1.45396 T

§3 coupling soundness
  [PASS] EM→thermal back-coupling active (T* > T_base, consistent)
         · T*(AoA -4.22333°) = 11.9372 K > T_base 4.2 K (thermal-map T = 11.9401 K, Δrel = 0.00024335)
  [PASS] fixed point is ω-invariant (ω=0.4 lands on same state)
         · AoA Δrel = 0.00102806, T Δrel = 0.000946761, σ Δrel = 0.00101015 (all < 2·TOL = 0.002)
  [PASS] EM B(T) = B_center·(1−(T/Tc)²) GL derating-law identity (exact)
         · B(4.2 K) = 1.47678 T = law 1.47678 T (derating (4.2/90)² = 0.00217778, B_center anchor 1.48 T)

  9/9 checks passed
  HONEST: closed-form fixed point over verified layer surrogates ≠ monolithic 3-D co-sim.
__UFO_COUPLING__ PASS
```

---

## 4. 고정점 물리 해석

| 성분 | 값 | 물리 의미 |
|------|----|-----------|
| **AoA*** | **−4.22°** | EM Meissner 부상력이 무게를 +18.8% 초과(lift_margin) → 공력이 소폭 **음(−)의 양력 (downforce)** 을 내도록 약간 머리를 숙인 trim. lenticular dome 의 AoA=0 lift-bias(L₀=+1001 N)를 EM 과잉분이 상쇄하는 방향 — 물리적으로 정합. |
| **T_magnet*** | **11.94 K** | cold floor 4.2 K + EM duty 발열(AoA 의존)로 상승. **Tc=90 K 대비 여유 78 K** → quench 없음. B(T*)=1.454 T (derating 1.7%). |
| **σ_peak*** | **13.01 MPa** | aero 부하 + 열응력(E·α·ΔT, cryo↔ambient 288 K gradient) 합. SF=46.1 ≫ 2.5 → 구조 마진 유지 (stress-fea 단독 LC-1 0.771 MPa 의 ~17× — 열응력 항이 지배적이나 여전히 큰 마진). |
| **lift_margin*** | **+0.188** | F_EM(7570 N) / m·g(6374 N) − 1 = +18.8%. 공력과 합해 lift balance 정확히 닫힘 (6375 N ≈ 6374 N · Δrel<1e-3). |

**수렴 동역학**: 초기값 = design §6 인계 cold point (AoA=0 · T=4.2K). 7 iter 만에 max|Δ_rel|<1e-3 도달, 수축계수 q=0.309 → 매 sweep 마다 잔차가 ~31% 로 줄어드는 **선형 수렴**. ω=0.7 과 ω=0.4 두 relaxation 경로가 동일 고정점(Δrel<2·TOL)에 착지 → 고정점은 relaxation 경로의 artefact 가 아니라 **결합 map f 의 고유 성질** (ω-invariance).

**Banach 수축 정직(@D d6)**: 단순 iter-cap 으로 닫은 게 아님 — 경험적 수축계수 q<1 을 명시 측정해 **참 Banach contraction** 임을 확증. 발산했다면(q≥1) 정직하게 monolithic 승격을 falsifier 로 띄웠을 것 (강제 수렴 없음).

---

## 5. 게이트 판정 (@D d5 · d6 · g5)

```
   gate: ⟲ 4-layer fixed-point coupling (absorbed 마지막 차단 게이트)
   ─────────────────────────────────────────────────────────────────
   이전: 🟠 (analyze §5 수렴 기준 manifest 만 · 본해 미실행)
   현재: 🟢 (고정점 수렴 7 iter · max|Δ_rel|=5.34e-4<1e-3 · q=0.309 contraction · 9/9 PASS)
```

- **닫힌 것 (🟢)**: 4-layer 결합 map 의 고정점 존재 + Gauss–Seidel/Picard 수렴 + Banach 수축 + 자기일관(f(X*)=X*) + 비행가능 운전점(lift balance·SF·SC 마진) — 전부 verified layer 출력 위 closed-form/light-numerical (ε_rel≤1e-9 identity), mini hexa-run 9/9 PASS.
- **HONEST FENCE (남은 항목)**: 본 데크는 **verified layer surrogate 위 staggered 고정점** 이지 **monolithic 3-D CFD⟷EM⟷FEA⟷CHT co-simulation** 이 아니다. 결합계가 **안정 자기일관 운전점을 가진다**는 것 + **staggered 반복이 그 점으로 수렴한다**는 것 — 정상상태 ⟲ 게이트의 물리적 핵심 — 이 닫혔으므로 🟢-anchored. 전 layer 동시 3-D 본해(FSI 격자갱신·plasma duct hotspot·explicit dynamic)는 여전히 pool/cloud-deferred (@D d7 · GPU pod).
- **돌파 경로(@D d2)**: 본 라운드 staggered 수렴(q=0.309) 안정 → monolithic 승격 불필요. 3-D 동시 본해는 정밀화 deferred (게이트 닫힘과 무관).

---

## 6. cross-link + deferred

- deck: `UFO/sim/decks/coupling_fixedpoint.hexa`
- layer 입력 (선행 라운드 닫힌 출력):
  - `UFO/sim/decks/cfd-disc.md` (① CFD C_d=0.030·L/D=0.77 · 🟡)
  - `UFO/sim/decks/em-6coil.md` (② EM single-coil 3.01593 T 🟢 · F_lift 7842 N)
  - `UFO/sim/decks/stress-fea.md` (③ 응력 LC-1~5 FEA SF≥64.8 🟢)
  - `UFO/sim/decks/thermal_cryo.hexa` + `thermal-cryo.md` (④ 열 cryo 9/9 PASS 🟢)
- analyze: `UFO/analyze/integrated-vehicle-analyze.md` §5 (⟲ coupling 정의 · 수렴 기준 · coupling 항 매트릭스)
- ledger: `UFO/verify/V4_tier_ledger.md` §3 · §5 (게이트 🟠→🟢 + absorbed 재판정)
- @D d1 · d2 · d5 · d6 · g5

deferred:
- [ ] monolithic 3-D 동시 co-simulation (FSI 격자갱신 · plasma duct hotspot · explicit dynamic FEA) — pool/cloud micro-exp (@D d7 · GPU pod LC-2 cruise · staggered 수렴 닫힘 위 정밀화)
- [ ] LC-2~5 per-LC coupling sweep (analyze §5.3 — cruise full ⟲ vs orbital/landing/abort) — 본 라운드는 LC-1/cruise 대표 운전점
- [ ] stdlib atom 등록 (`fixedpoint_picard` · `banach_contraction_q`) → hexa-lang 별 PR (🟡→🟢 escalation)
