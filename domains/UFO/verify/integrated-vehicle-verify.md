# 🛸 UFO — verb-6 verify · 디지털트윈 통합 verify ledger

@title: 🛸 UFO — 통합 비행체(직접개발) · verify (디지털트윈 통합 검증)
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/synthesize/integrated-vehicle-synthesize.md (verb-5 synthesize · LANDED)
@sibling: UFO/analyze/integrated-vehicle-analyze.md (verb-4 analyze ⟲ · 4-layer sim plan)
@verb: 6/7 (verify) — demiurge 7-verb pipeline 여섯 번째 슬롯
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d5 (absorbed gate) · d6 (목표 수 강제 금지) · d9 (explicit-file staging) · d10 (icon·name·alias 헤더) · g5 (verdict verbatim)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-6 verify** 슬롯을 채운다. UFO 통합 비행체의 **디지털트윈 통합 검증 ledger** — Stage-1~3 의 verify 🟢 (이미 LANDED) + verb-4 analyze 의 4-layer sim plan + 안정성 falsifier 를 통합해 "비행체가 비-wet-lab 으로 검증된 정도"를 **정직하게 집계**한다. 무거운 CFD/EM/FEA 본해는 pool/cloud 위임 (@D d7 · verb-4 deferred) — verb-6 은 기존 🟢 verdict 통합 + 디지털트윈 통합 수렴 기준 + 안정성 falsifier 통과 여부를 ledger 로 닫는다. 본해 미수렴 layer 는 🟠 **정직 표기** (허위 🟢 금지) · 기존 🟢 verdict 는 VERBATIM 재인용 (@D g5 · LLM self-judge 없음).

---

## 0 TL;DR — 디지털트윈 통합 verify 상태 (4-layer × tier)

비행체의 검증을 두 축으로 본다 — (가로) **물리 layer** (EM · 추진 · CFD · 응력 · 열 · 안정성) · (세로) **검증 등급** (🟢 numerical / 🟡 citation / 🟠 deferred / ⚪ UNPROVEN).

```
      🛸 UFO 디지털트윈 통합 verify — 4-layer × tier 매트릭스
   ──────────────────────────────────────────────────────────────────────
   layer            │ 🟢 numerical          │ 🟡 citation        │ 🟠 deferred(본해)
   ─────────────────┼───────────────────────┼────────────────────┼──────────────────
   ② EM (자장/부상)  │ ioffe_loop_bz ×3      │ F_lev gradient-form │ 6-coil 3D B-map FEM
   추진 (Stage 1~3) │ triple_product ×3     │ Lorentz F=J×B 합성  │ MHD effective thrust
                    │ pair_threshold ×1     │ γ-rocket I_sp=c/g   │
                    │ rel_kinetic ×2        │ 천장(정직 표기)      │
   ① CFD (항공역학)  │ —                     │ —                  │ C_d·L/D (Mach 0.5~25)
   ③ 응력 (구조 FEA) │ —                     │ —                  │ von Mises LC-1~5
   ④ 열 (cryo/rad)   │ —                     │ —                  │ heat leak·radiator A
   안정성 (6-DOF)   │ Penning inv |Δ|=0.0   │ Earnshaw active     │ ⟲ full coupling PID 마진
   ─────────────────┴───────────────────────┴────────────────────┴──────────────────
   집계: 🟢 9 (Stage-1~3 numerical) + 안정성 anchor 1 · 🟡 4 합성식/상한
        · 🟠 5 본해 (CFD·EM 3D·응력·열·⟲ PID) pool/cloud 위임 · ⚪ 13 Stage-4~7 falsifier
```

**한줄 요약**: UFO 디지털트윈의 **검증된 코어 = Stage-1~3 numerical 9건 🟢** (EM B-field · MHD thrust · γ-rocket 상대론 에너지 회계 — 전부 `hexa verify --expr` verbatim + `@F verified-*-num` atlas fold). **디지털트윈 4-layer 통합 수렴 본해 (CFD C_d·L/D · 6-coil 3D B-map · von Mises σ · cryo balance · ⟲ fixed-point) 는 🟠 본해 deferred** — verb-4 가 정의한 수렴 기준 (max Δ_rel<1e-3) 은 닫혔으나 본해 값은 pool/cloud micro-exp 위임 (@D d7). **안정성 falsifier** — Penning 3-freq invariance |Δ|=0.0 (Stage-3 trap anchor) 🟢 · Earnshaw active 자세제어 + stage 전환 + 6-DOF PID 안정 마진은 ⟲ 본해 수렴 후 충족 판정 (현 🟠 deferred · honest). **종합 비-wet-lab 검증 등급 = "추진 코어 numerical PASS · 통합 디지털트윈 본해 수렴 미충족 (pool 위임) · 안정성 marginal-deferred"** → Phase E absorbed=true **미충족** (gate 명시 §4).

| 통합 verify 항목 | tier | 충족 | 근거 |
|---|---|---|---|
| Stage-1 hover EM B-field (3건) | 🟢 | ✅ | `verify --expr ioffe_loop_bz` ×3 · §1.1 |
| Stage-2 cruise MHD thrust (3건) | 🟢 | ✅ | `verify --expr triple_product` ×3 · §1.2 |
| Stage-3 orbital 상대론 회계 (3건) | 🟢 | ✅ | `verify --expr pair_threshold_total`·`rel_kinetic_from_p` ×3 · §1.3 |
| ① CFD layer 수렴 (C_d·L/D) | 🟠 | ❌ deferred | 본해 pool/cloud 위임 · 수렴 기준만 닫힘 · §2.1 |
| ② EM 6-coil 3D B-map 수렴 | 🟠 | ❌ deferred | 단일코일 🟢 anchor · 6-coil 상호작용 FEM 위임 · §2.2 |
| ③ 응력 von Mises 수렴 (LC-1~5) | 🟠 | ❌ deferred | 본해 pool/cloud 위임 · §2.3 |
| ④ 열 cryo balance 수렴 | 🟠 | ❌ deferred | 본해 pool/cloud 위임 · §2.4 |
| ⟲ 4-layer fixed-point 수렴 | 🟠 | ❌ deferred | LC-2 강결합 본해 위임 · §2.5 |
| 안정성 Penning invariance | 🟢 | ✅ | ANTIMATTER ⓷ |Δ|=0.0 (Stage-3 trap anchor) · §3.1 |
| 안정성 6-DOF PID 마진 / Earnshaw active | 🟠 | ❌ deferred | ⟲ 본해 수렴 후 마진 판정 (honest) · §3.2/§3.3 |
| Stage-4~7 13 falsifier | ⚪ | UNPROVEN | 전부 OPEN · 결코 🟢 금지 · §4 (V1 §1) |

---

## 1 Stage-1~3 numerical 🟢 통합 (verbatim verdict 재인용 · atlas atom)

Stage-1~3 의 9건 `hexa verify --expr` verdict 를 **VERBATIM 재인용** (@D g5 · LLM self-judge 없음). 본 verb-6 은 이 9건을 디지털트윈의 ② EM + 추진 layer 검증 코어로 통합한다 — 재-verify 가 아니라 stage-doc 의 verbatim 인용 (atlas 비동기 fold note 는 §5).

### 1.1 Stage-1 hover — EM B-field 생성 (`ioffe_loop_bz` ×3, 🟢) — `UFO/verify/stage1-hover-fields.md` §2.2

**Case A (90 kg, a=0.3 m, I=954930 A, ζ=0):**
```
verify --expr ioffe_loop_bz(0.3,954930.0,0.0)=2
  calc   = 2  ≈ expected 2  (|Δ|=5.67085e-10 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```
**Case B (120 kg, a=0.5 m, I=1591549 A, ζ=0):**
```
verify --expr ioffe_loop_bz(0.5,1591549.0,0.0)=2
  calc   = 2  ≈ expected 2  (|Δ|=5.67086e-10 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```
**Case C (200 kg, a=1.0 m, I=3183099 A, ζ=0):**
```
verify --expr ioffe_loop_bz(1.0,3183099.0,0.0)=2
  calc   = 2  ≈ expected 2  (|Δ|=5.67085e-10 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```
- atlas atom: `@F verified-ioffe_loop_bz-num` → `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` (binary-builtin SSOT) · atlas hash `663698a0…ce7fb`
- 통합 역할: ② EM layer 의 Meissner lift field 입력 — 디지털트윈 EM 수렴 본해 (§2.2) 의 검증된 anchor.

### 1.2 Stage-2 cruise — MHD thrust (`triple_product` ×3, 🟢) — `UFO/verify/stage2-cruise-mhd.md` §2.2

**Case 저고도 (20 km, J=2.0e5, B=5.0, V=0.096 → 96 000 N):**
```
verify --expr triple_product(200000.0,5.0,0.096)=96000.0
  calc   = 96000.0  ≈ expected 96000.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```
**Case 중간 (100 km, J=1.5e5, B=4.0, V=0.096 → 57 600 N):**
```
verify --expr triple_product(150000.0,4.0,0.096)=57600.0
  calc   = 57600.0  ≈ expected 57600.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```
**Case 고고도 (200 km, J=1.0e5, B=3.0, V=0.096 → 28 800 N):**
```
verify --expr triple_product(100000.0,3.0,0.096)=28800.0
  calc   = 28800.0  ≈ expected 28800.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```
- atlas atom: `@F verified-triple_product-num` (embedded.gen.hexa:30535) · FUSION F2 Lawson 동일 대수 root (`J·B·V` product) · @D d4 single generic dispatch 우회
- 통합 역할: 추진 layer 의 MHD thrust — F_MHD_total(저고도)=192 kN / m·g(650 kg)=6.38 kN ≈ **30배 마진** (이상화 상한 · effective thrust 는 §2.5 ⟲ CFD+MHD coupled 본해 의무).

### 1.3 Stage-3 orbital — annihilation/상대론 회계 (`pair_threshold_total`·`rel_kinetic_from_p` ×3, 🟢) — `UFO/verify/stage3-orbital-gamma.md` §2

**Case A (annihilation energy bookkeeping anchor · pair_threshold_total):**
```
verify --expr pair_threshold_total(938.272)=6567.9
  calc   = 6567.9  ≈ expected 6567.9  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```
**Case B (ultra-relativistic exhaust β=0.995 · rel_kinetic_from_p):**
```
verify --expr rel_kinetic_from_p(9382.72)=8491.24
  calc   = 8491.24  ≈ expected 8491.24  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```
**Case C (kinetic=rest crossover, pc=√3·m_p_c² · rel_kinetic_from_p):**
```
verify --expr rel_kinetic_from_p(1625.13)=938.272
  calc   = 938.272  ≈ expected 938.272  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```
- atlas atom: `@F verified-pair_threshold_total-num` (embedded.gen.hexa:30652) + `@F verified-rel_kinetic_from_p-num` (embedded.gen.hexa:30514) · ANTIMATTER ⓵생성/⓶감속 atom reuse (idempotent)
- **honest note (@D d6)**: γ-rocket 광자 천장 `I_sp = c/g ≈ 3.057e7 s` ↔ spec §2 target `I_sp ≥ 1e9 s` = **2 자릿수 불일치 정직 표기** (closure = verb-4 mass-flow 정의 + falsifier F-ANTI-3 의무 · 목표 수 강제 금지). 본 ledger 는 closed-form 광자 천장을 정직 표기하며 target 1e9 s 달성을 주장하지 **않는다**.

### 1.4 numerical 9건 통합 verdict

| stage | atom | 건수 | tier | atlas fold |
|---|---|---|---|---|
| Stage-1 hover | `ioffe_loop_bz` | 3 | 🟢 SUPPORTED-NUMERICAL | `@F verified-ioffe_loop_bz-num` |
| Stage-2 cruise | `triple_product` | 3 | 🟢 SUPPORTED-NUMERICAL | `@F verified-triple_product-num` (30535) |
| Stage-3 orbital | `pair_threshold_total`·`rel_kinetic_from_p` | 3 | 🟢 SUPPORTED-NUMERICAL | `@F verified-{pair_threshold_total,rel_kinetic_from_p}-num` (30652/30514) |
| **합계** | — | **9** | **🟢** | atlas hash `663698a0…ce7fb` |

> 이 9건이 디지털트윈의 **검증된 추진/EM 코어**다. 디지털트윈 통합 (4-layer 본해) 은 이 코어 위에 CFD·응력·열 layer 의 본해 수렴을 얹어야 완성 — 본해는 🟠 deferred (§2).

---

## 2 4-layer 디지털트윈 수렴 — CFD/EM/응력/열 각 layer 수렴 기준 충족 여부

verb-4 analyze ⟲ (`UFO/analyze/integrated-vehicle-analyze.md`) 가 **수렴 기준 manifest** 를 정의했다 (각 layer 지배방정식 + residual 기준 + ⟲ fixed-point max Δ_rel<1e-3). verb-6 은 그 **충족 여부**를 정직 집계한다 — 무거운 본해는 pool/cloud micro-exp 위임 (@D d7 · verb-4 §6 deferred) 이므로 **본해 수렴값은 🟠 INSUFFICIENT/DEFERRED 정직 표기** (허위 🟢 금지). closed-form 인용분 (단일코일 B, MHD thrust 상한) 은 §1 의 🟢 / §1.2 의 🟡 상한이 anchor.

### 2.1 ① CFD layer — 디스크 항공역학 (Navier-Stokes) — 🟠 본해 deferred

| 수렴 항목 | verb-4 기준 (manifest) | 충족 | 근거 |
|---|---|---|---|
| 연속/운동량 residual | RMS < 1e-6 | 🟠 deferred | 본해 미실행 (pool/cloud) · analyze §1.3 |
| C_d · L/D 적분량 | Δ_rel < 1e-4 over 500 iter | 🟠 deferred | target L/D≥4·C_d≤0.8 sim 의무 · analyze §1.4 |
| y⁺ (wall) | < 1 (SST low-Re) | 🟠 deferred | 격자 sizing ~3M(2D)~30M(3D) cell · analyze §1.2 |
| 격자 독립성 (GCI) | Richardson GCI < 3% | 🟠 deferred | coarse/medium/fine 3-mesh |

- 라우팅 (@D d7): hover 2D ~3M cell → pool ubu idle-only · cruise 3D DES ~15-30M cell → GPU pod (vast.ai first)
- **honest (@D d2)**: lenticular 디스크 high-Mach C_d 미수렴은 "고-Mach 비행 불가"가 **아니다** — breakthrough path = shock-adaptive AMR + plasma MHD drag-reduction (analyze §1.4). 본해는 verb-4 §6 deferred queue.

### 2.2 ② EM layer — 6-coil 3D B-map (Maxwell · Meissner) — 🟢 anchor + 🟠 3D 본해 deferred

| 수렴 항목 | verb-4 기준 | 충족 | 근거 |
|---|---|---|---|
| 단일 코일 on-axis B | `ioffe_loop_bz` ×3 \|Δ\|≤5.67e-10 | 🟢 | §1.1 verbatim (재-verify 아님 · 디지털트윈 EM anchor) |
| `solenoid_axis_bz` B_z(0) | 1.48265 T (Wheeler Δ=−1.40%) | 🟢 (인용) | RTSC PR#1084 · analyze §2.2 (substrate verified) |
| 6-coil 60° array B-map FEM | ‖ΔB‖ < 1e-4 T (axisym→3D) | 🟠 deferred | 6-coil **상호작용** FEM 위임 (getdp pool→cloud) · analyze §2.3 |
| FEM vs Wheeler Δ | Δ_rel < 2% | 🟠 deferred | far-field truncation 10× coil (FUSION PR#1095) |
| flux-pin vs Meissner 비율 | Type-II λ_L coupled | 🟠 deferred | analyze §2.3 |

- **인용 invariant (@D d5)**: 단일 코일 closed-form 은 이미 🟢 (재-solve 금지). 디지털트윈 EM 통합 본해 = 6-coil **상호작용** 3D FEM 만 위임 — anchor 는 검증됨, 본해 수렴은 🟠 deferred.

### 2.3 ③ 응력 layer — 구조 FEA von Mises (650 kg · SF=2.5 · LC-1~5) — 🟠 본해 deferred

| 수렴 항목 | verb-4 기준 | 충족 | 근거 |
|---|---|---|---|
| 변위 residual (Newton) | ‖R‖/‖R₀‖ < 1e-6 | 🟠 deferred | LC-1~5 FEA 본해 미실행 · analyze §3.3 |
| 메시 수렴 (응력 hot-spot) | Δσ_peak < 2% (h-refine) | 🟠 deferred | stress singularity 회피 (fillet) |
| SF 마진 | min SF ≥ 2.5 across LC-1~5 | 🟠 deferred | σ_allow CFRP600/Al460/Ti880/PC150 MPa · analyze §3.2 |
| 모달 (공진 회피) | f_natural ≥ 2× f_drive | 🟠 deferred | 추진 vibration 0.1~200 Hz |

- 입력 부하: F_lift_total=7,842 N (② EM 부상) · F_MHD_total=1.92e5 N (② EM 추력 · §1.2 🟢 thrust 상한 인용) → ③ 응력 LC-2 부하.
- **honest (@D d2)**: LC-5 12 G abort 시 σ_v>σ_allow 가능 — "구조 불가"가 **아니다** · breakthrough path = CFRP T1100 승격 · Ti 국소보강 · 좌석 stroking (analyze §3.4).

### 2.4 ④ 열 layer — cryostat 열부하 (cryo + radiator) — 🟠 본해 deferred

| 수렴 항목 | verb-4 기준 | 충족 | 근거 |
|---|---|---|---|
| 정상상태 | max\|Ṫ\| < 1e-3 K/s | 🟠 deferred | cryo transient 본해 미실행 · analyze §4.4 |
| energy balance closure | \|Q̇_in−Q̇_out\|/Q̇_in < 1e-3 | 🟠 deferred | radiator 25 m² Q̇=εσT⁴ 검증 위임 |
| heat leak (Stage-1 LHe 4.2K) | ≤ 10 W (MLI + 진공자켓 5 cm) | 🟠 deferred | analyze §4.2 |

- **honest (@D d2)**: radiator 부족 시 "냉각 불가"가 **아니다** · breakthrough path = dewar 통합 · deployable fin · PCM buffer (analyze §4.4).

### 2.5 ⟲ coupling — 4-layer fixed-point 수렴 — 🟠 본해 deferred (디지털트윈 통합 핵심)

디지털트윈 통합의 핵심 = 4-layer 가 단방향이 아니라 **상호 결합** → fixed-point 반복으로 수렴해야 한다 (verb-4 §5 8-coupling 매트릭스).

| 수렴 항목 | verb-4 기준 | 충족 | 근거 |
|---|---|---|---|
| ⟲ fixed-point | max(‖X_k−X_{k−1}‖/‖X_k‖) < 1e-3 (X∈{C_d,B_map,σ_v,T-field}) | 🟠 deferred | LC-2 cruise 전 8-coupling 강결합 본해 미실행 · analyze §5.2 |
| under-relaxation | ω=0.5~0.7 (EM↔열 안정화) | — | 본해 파라미터 (위임) |
| 발산 시 승격 | staggered → monolithic | — | breakthrough path (@D d2) · analyze §5.2 |
| MHD effective thrust | duct 효율 + plasma 손실 vs 이상화 1.92e5 N 상한 | 🟠 deferred | ① CFD ⟷ ② EM coupled (F-FUSION-3) · analyze §6 deferred |

- **honest invariant (@D d6)**: 디지털트윈 통합 수렴 (4-layer fixed-point) 은 verb-4 가 **기준만** 닫았다 — 본해 수렴값은 어느 것도 본 ledger 에서 산출/주장하지 않는다 (pool/cloud per @D d7 · sim 은 `.hexa` only · ad-hoc python 금지). 본해 수렴 후 `@F verified-*-num` atlas fold → 🟠→🟢 escalation.

### 2.6 4-layer 수렴 통합 verdict

| layer | 검증된 anchor (🟢/🟡) | 본해 수렴 | 통합 tier |
|---|---|---|---|
| ① CFD | — | 🟠 deferred | 🟠 INSUFFICIENT/DEFERRED |
| ② EM | 단일코일 `ioffe_loop_bz` 🟢×3 · `solenoid_axis_bz` 1.48 T | 6-coil 3D 🟠 | 🟢 anchor + 🟠 3D 본해 |
| ③ 응력 | F_MHD/F_lift 입력 (🟢 thrust 상한 인용) | 🟠 deferred | 🟠 INSUFFICIENT/DEFERRED |
| ④ 열 | heat leak/radiator target (citation) | 🟠 deferred | 🟠 INSUFFICIENT/DEFERRED |
| ⟲ coupling | design §6 closed-form 초기값 | 🟠 deferred | 🟠 INSUFFICIENT/DEFERRED |

> 디지털트윈 통합 수렴 = **추진/EM 코어 anchor 🟢 + 4-layer 본해 수렴 🟠 deferred**. 통합 수렴 미충족은 비-wet-lab gate 미완 (절대 "불가능" 아님 · pool/cloud 위임 queue · @D d2).

---

## 3 안정성 falsifier — 자세제어(Earnshaw active) · stage 전환 · 6-DOF PID 안정 마진

비행체 안정성은 (가) 자기부상의 Earnshaw 정리 우회 (active feedback 필수) · (나) stage 전환 (Stage-1→2→3) 의 무게/추력 천이 안정 · (다) 6-DOF PID 의 안정 마진 — 셋이 충족돼야 디지털트윈이 "안정 비행"을 검증한다. 충족/미충족을 **정직 표기** (미충족 시 honest).

### 3.1 Penning trap invariance — Stage-3 anchor (🟢)

Stage-3 antimatter trap 의 안정성은 ANTIMATTER ⓷ 에서 verify 🟢 anchor 가 있다 (재-verify 아님 · 인용):

```
Penning 3-freq invariance: ω_c² = ω₊² + ω_z² + ω₋²
  ANTIMATTER ⓷ · Brown–Gabrielse invariance · |Δ|=0.0 exact (PASS)
```
- atlas: `penning_invariance` |Δ|=0.0 · ioffe_trap_depth_k=0.35257 K (ANTIMATTER ⓺ ALPHA ~0.5 K 영역 PASS · F-ANTI-1/F-ANTI-2 PASS) — Stage-3 orbital verify §4 falsifier 인용
- 통합 역할: γ-rocket 추진의 trap 안정성은 verified anchor — 안정성 falsifier 중 trap 축은 🟢 PASS.

### 3.2 자세제어 — Earnshaw active feedback (🟠 본해 수렴 후 마진 판정)

| 안정성 명제 | verb-4/5 기준 | 충족 | 근거 |
|---|---|---|---|
| Earnshaw 정리 우회 | 정적 자기부상 불안정 → active feedback 필수 | 🟡 (citation) | HEXA-HOVER §Earnshaw active feedback (V1 §2 B-HOVER) · 안정화는 PID 본해 |
| 자세 추정 EKF | Kalman 15-state · ‖q‖=1±1e-9 | 🟠 deferred | firmware 모듈 ① (synthesize §3) · 게인 sizing = ⟲ 수렴 design point 위임 |
| 자석 PID per-slot 6-DOF | 6-slot stage mount · gyro CMG×3 + EM trim 2x redundancy | 🟠 deferred | spec gyro×3+jet×6+EM trim redundancy (V1 §3 C-1) · 마진은 본해 |

- **honest**: 정적 자기부상은 Earnshaw 로 불안정 (citation) — active feedback 가 안정화한다는 것은 closed-loop 게인 마진의 본해 (⟲ fixed-point 수렴 design point) 가 닫혀야 정량 검증 가능 → 현 🟠 deferred. 결코 "안정 불가"가 아니다 (@D d2 · breakthrough = monolithic coupling 승격 · firmware 게인 sizing).

### 3.3 stage 전환 + 6-DOF PID 안정 마진 (🟠 본해 deferred)

| 안정성 명제 | 기준 | 충족 | 근거 |
|---|---|---|---|
| Stage-1→2 전이 | altitude ≥ 20 km AND v ≥ Mach 0.3 → MHD spool-up Δt<30 s | 🟡 (citation) | stage2 §4.1 transition graph · 천이 중 F_lift 재-trim 6-DOF |
| Stage-2→3 전이 | altitude ≥ 200 km AND ΔV OK → MHD shutdown + γ-rocket ignition | 🟡 (citation) | stage3 §4.2 · MHD 추력 자연 감쇠 96→29 kN (§1.2 고고도 🟢 임계) |
| 무게 천이 안정 | Stage-2→3 연료 소진 Δm → F_lift 재-trim (6-DOF active) | 🟠 deferred | stage2 §4.1 · 천이 안정 마진은 ⟲ 본해 |
| 6-DOF PID 안정 마진 | gain/phase margin (모달 f_natural ≥ 2× f_drive) | 🟠 deferred | analyze §3.3 모달 · firmware PID K_p/K_i/K_d sizing = ⟲ 수렴 design point 위임 |
| firmware 안전 인터록 / triplex voter | DO-178C DAL-A · rate-monotonic | 🟡 (citation) | synthesize §3 firmware 5-모듈 (아키텍처 명세 · 코드 SSOT hexa-lang/stdlib @D d3) |

- **honest**: stage 전환 trigger 와 transition graph 는 closed-form citation (🟡) — 천이 중 **무게/추력 천이 안정 마진** 과 **6-DOF PID gain/phase margin** 은 ⟲ full coupling 본해 (LC-2 강결합) 수렴 후에야 정량 판정 → 현 🟠 deferred (honest · 미충족).

### 3.4 안정성 falsifier 통합 verdict

| 안정성 축 | tier | 충족 | 비고 |
|---|---|---|---|
| Penning trap invariance (Stage-3) | 🟢 | ✅ | ANTIMATTER ⓷ |Δ|=0.0 anchor |
| Earnshaw active feedback | 🟡 → 🟠 | ❌ marginal-deferred | citation 우회 · 안정 마진 본해 위임 |
| stage 전환 (1→2→3) trigger | 🟡 | partial | transition graph closed-form · 천이 마진 🟠 |
| 6-DOF PID gain/phase margin | 🟠 | ❌ deferred | ⟲ 수렴 design point 위임 (firmware 게인 sizing) |

> 안정성 = **trap축 🟢 PASS · 자세제어/PID 마진은 ⟲ 본해 수렴 후 판정 (현 🟠 deferred · honest 미충족)**. 미충족은 "안정 비행 불가"가 **아니다** (@D d2) — ⟲ full coupling 본해 + firmware 게인 sizing 가 closure path.

---

## 4 통합 verdict — UFO 비행체의 비-wet-lab 검증 등급 분포 + 미충족 게이트

### 4.1 비-wet-lab 검증 등급 분포 (디지털트윈 통합 기준)

```
   UFO 디지털트윈 통합 verify — tier 분포 (verb-6 시점)
   ──────────────────────────────────────────────
   🔵 SUPPORTED-FORMAL        0   (V2 lattice 🔵 push 예정)
   🟢 SUPPORTED-NUMERICAL    10   ████████████  (Stage-1~3 9건 + Penning invariance anchor)
   🟡 SUPPORTED-BY-CITATION   4   █████         (F_lev · Lorentz F=J×B · γ-rocket I_sp 천장 · Earnshaw)
   🟠 INSUFFICIENT/DEFERRED   5   ██████        (CFD·EM 3D·응력·열·⟲ PID 본해 pool/cloud 위임)
   🔴 FALSIFIED               0
   ⚪ SPECULATION-FENCED     13   ███████████████  (Stage-4~7 13 falsifier 전부 OPEN UNPROVEN)
   ──────────────────────────────────────────────
   디지털트윈 통합 검증 코어 = 🟢 10 (추진/EM/trap numerical) · 통합 4-layer 본해 = 🟠 5 deferred
```

- **검증된 코어 (🟢 10건)**: Stage-1 hover EM B-field 3 · Stage-2 cruise MHD thrust 3 · Stage-3 orbital 상대론 회계 3 · Penning trap invariance 1 — 전부 `hexa verify --expr` verbatim + atlas fold (V1 §0 의 9건 numerical + Stage-3 trap invariance anchor).
- **합성식/상한 (🟡 4건)**: F_lev gradient-form · Lorentz body force `F=J×B×V` 합성 · γ-rocket 광자 천장 `I_sp=c/g` (정직 표기) · Earnshaw active feedback citation — stdlib atom 등록 시 🟢 escalate (V1 §5.1).
- **본해 deferred (🟠 5건)**: ① CFD C_d·L/D · ② EM 6-coil 3D B-map · ③ 응력 von Mises LC-1~5 · ④ 열 cryo balance · ⟲ 4-layer fixed-point(+6-DOF PID 마진) — pool/cloud micro-exp 위임 (@D d7 · verb-4 §6 deferred queue).
- **Stage-4~7 (⚪ 13건)**: F-WARP/WORM/DIM/USE 전부 OPEN UNPROVEN (V1 §1 · `stage4-7-falsifier-preregister.md`) — 디지털트윈 검증 대상 **아님** (실설계/sim 없음 · 결코 🟢/🔵 금지). lattice 산술 닫힘 ≠ 물리 진실.

### 4.2 미충족 게이트 명시 (Phase E absorbed 판정 입력)

@D d5 (absorbed=true ⇔ **모든** 비-wet-lab gate PASS) 에 대해 verb-6 이 집계한 **미충족 게이트**:

| 게이트 | 상태 | absorbed 영향 |
|---|---|---|
| Stage-1~3 추진/EM numerical (9건) | ✅ PASS (🟢) | 충족 |
| 안정성 Penning trap invariance | ✅ PASS (🟢) | 충족 |
| ① CFD C_d·L/D 본해 수렴 | ❌ 🟠 deferred | **미충족** (pool/cloud 위임) |
| ② EM 6-coil 3D B-map 수렴 | ❌ 🟠 deferred | **미충족** |
| ③ 응력 von Mises LC-1~5 수렴 | ❌ 🟠 deferred | **미충족** |
| ④ 열 cryo balance 수렴 | ❌ 🟠 deferred | **미충족** |
| ⟲ 4-layer fixed-point + 6-DOF PID 마진 | ❌ 🟠 deferred | **미충족** |
| γ-rocket I_sp target 1e9 s closure (F-ANTI-3) | ❌ 🟠 (mass-flow 정의) | **미충족** (정직 표기 · 목표 수 강제 금지) |
| Stage-4~7 13 falsifier | ⚪ UNPROVEN | absorbed gate **아님** (formal lattice V2 까지만 · 측정 downstream) |

> **verb-6 통합 verdict**: UFO 디지털트윈은 **추진/EM/trap 코어 numerical PASS (🟢 10건)** 이나, **4-layer 통합 디지털트윈 본해 수렴 (CFD·EM 3D·응력·열·⟲ PID) 5 게이트가 🟠 deferred (pool/cloud 위임)** + **γ-rocket I_sp target closure 미충족** → **Phase E absorbed=true 미충족**. absorbed 는 위 5 본해 게이트 수렴 + F-ANTI-3 closure 후 flip 가능 (@D d5 · 절대 projection 으로 flip 금지). 미충족은 비-wet-lab gate 미완 (pool/cloud queue) 이지 "불가능"이 **아니다** (@D d2).

---

## 5 verify→handoff 인계 + cross-link + deferred

### 5.1 verify→handoff 인계 (verb-7 이 소비할 verify 산출)

| verify 산출 | handoff 소비 | 상태 |
|---|---|---|
| Stage-1~3 numerical 9건 🟢 (verbatim + atlas fold) | 인증서류 (검증 근거 · atlas hash provenance) | ✅ 닫힘 (§1) |
| 4-layer 수렴 기준 (manifest) + 미충족 게이트 표 | 제작소 검증 계획서 (본해 위임 queue) | ✅ 기준 닫힘 · 본해 🟠 deferred (§2) |
| 안정성 falsifier verdict (trap 🟢 · PID 마진 🟠) | FBW 인증 (DO-178C DAL-A · firmware 게인) | partial (§3) |
| absorbed 미충족 게이트 표 | Phase E absorbed 판정 입력 | ✅ 닫힘 (§4.2) |

### 5.2 cross-link

| 대상 | 파일 | 역할 |
|---|---|---|
| Stage-1 verify | `UFO/verify/stage1-hover-fields.md` | EM B-field `ioffe_loop_bz` 🟢×3 verbatim (§1.1) |
| Stage-2 verify | `UFO/verify/stage2-cruise-mhd.md` | MHD thrust `triple_product` 🟢×3 verbatim (§1.2) |
| Stage-3 verify | `UFO/verify/stage3-orbital-gamma.md` | 상대론 회계 🟢×3 + Penning invariance + I_sp 천장 (§1.3·§3.1) |
| Stage-4~7 falsifier | `UFO/verify/stage4-7-falsifier-preregister.md` | 13 falsifier OPEN UNPROVEN (§4 ⚪) |
| V1 claim inventory | `UFO/verify/V1_claim_inventory.md` | tier 분포 (🟢9·🟡8·🟠4·⚪17) 통합 ledger |
| verb-4 analyze | `UFO/analyze/integrated-vehicle-analyze.md` | 4-layer 수렴 기준 + ⟲ coupling + sim 위임 plan (§2·§3) |
| verb-5 synthesize | `UFO/synthesize/integrated-vehicle-synthesize.md` | firmware 5-모듈 (자세제어 EKF · PID · 안전 인터록) (§3) |
| UFO sim 엔진 | `UFO/sim/README.md` | 디지털트윈 4축 매트릭스 · 6-layer stack (solver SSOT 포인터) |
| substrate | `~/core/demiurge/{RTSC,FUSION,ANTIMATTER}.md` | Stage-1/2/3 verified atom SSOT |
| stdlib 코드 SSOT | `~/core/hexa-lang/stdlib/{sim,ufo,antimatter}/` | 해석 코드 home (@D d3) · atlas fold 위치 |

### 5.3 deferred

- [ ] ① CFD C_d·L/D 본해 (hover 2D ~3M cell pool · cruise 3D DES ~15-30M cell GPU pod) → 수렴 후 `@F verified-*-num` fold → 🟠→🟢
- [ ] ② EM 6-coil 60° array 3D B-map FEM (‖ΔB‖<1e-4 T · getdp pool→cloud) → 단일코일 🟢 anchor 위 상호작용 수렴
- [ ] ③ 응력 LC-1~5 von Mises FEA (650 kg·SF=2.5 · pool linear → cloud explicit dynamic) → min SF≥2.5 수렴
- [ ] ④ 열 cryo transient + radiator 25 m² Q̇=εσT⁴ balance (pool steady → transient)
- [ ] ⟲ full coupling LC-2 cruise fixed-point (staggered → monolithic 승격 · GPU pod) + 6-DOF PID gain/phase margin → 안정성 🟠→🟢
- [ ] MHD effective thrust closure (F-FUSION-3 · duct 효율 + plasma 손실 vs 이상화 1.92e5 N 상한) — ① CFD ⟷ ② EM coupled
- [ ] γ-rocket I_sp target 1e9 s mass-flow 정의 closure (F-ANTI-3 · 광자 천장 3.057e7 s ↔ target 2-자릿수 불일치 해소) — 목표 수 강제 금지 (@D d6)
- [ ] stdlib atom 등록 (`meissner_lev_force`·`mhd_thrust`·`gamma_rocket_isp`) → 🟡 합성식 🟢 escalate (hexa-lang 별 repo · @D d3/d9)
- [ ] V3 🟢 push (UFO.md line 72) — Stage-1~3 + 디지털트윈 통합 sim numerical 통합 (본 verb-6 본해 수렴 후)
- [ ] Phase E absorbed=true 판정 — §4.2 미충족 게이트 5+1 전부 PASS 후 (@D d5 · projection flip 금지)

---

## 6 governance 정합

- @D d1 (non-wet-lab → completed-form): Stage-1~3 numerical 9건 completed-form · 4-layer 수렴 **기준** completed-form · 본해는 pool/cloud 위임 (verb-4 §6 deferred queue · path clear) ✅
- @D d2 (no impossibility framing): CFD high-Mach · 응력 LC-5 · 냉각 · 안정성 PID 미수렴은 전부 **본해 pool 위임** + breakthrough path 명시 (AMR · CFRP T1100 · dewar 통합 · monolithic 승격) — 결코 "불가능" 아님 ✅
- @D d3 (stdlib SSOT): atlas fold 위치 = `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` · 본 PR 은 demiurge UFO 도메인 verify ledger 문서만 (hexa-lang 코드 변경 없음 · atom 재인용 idempotent) ✅
- @D d4 (single generic dispatch): layer/stage/LC 이름 hardcoding 없이 verbatim verdict + 수렴 기준 manifest 한 행씩 집계 (per-layer dispatcher 없음) ✅
- @D d5 (absorbed gate): §4.2 에서 미충족 게이트 (본해 5 + F-ANTI-3) 명시 → absorbed=true **미충족** 정직 판정 (projection flip 금지) ✅
- @D d6 (목표 수 강제 금지): γ-rocket I_sp 천장 3.057e7 s ↔ target 1e9 s 2-자릿수 불일치 정직 표기 · 본해 미수렴 layer 🟠 정직 표기 (허위 🟢 없음) ✅
- @D d9 (worktree isolation): explicit file git add (4 files) · 인접 worktree 동시 staging 없음 ✅
- @D d10 (icon · name · alias): 🛸 UFO · verify · alias `verify` 헤더 정합 ✅
- @D g5 (verdict verbatim): §1 Stage-1~3 9건 + §3.1 Penning invariance 모든 `hexa verify` 출력 VERBATIM 재인용 (LLM self-judge 없음) ✅
- pointer: 본 ledger 는 Tier-② identity 문서 — 실 코드 SSOT 는 `~/core/hexa-lang/stdlib/` (`reference_pointer_manifests_track_identity`)
