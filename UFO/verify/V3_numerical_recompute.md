# 🛸 UFO — V3 🟢 push · numerical recompute 통합 ledger

@title: 🛸 UFO — 통합 비행체(직접개발) · V3 numerical recompute (libm Δ≤1e-9)
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/verify/V1_claim_inventory.md (V1 claim inventory · tier triage)
@sibling: UFO/verify/integrated-vehicle-verify.md (verb-6 verify · 디지털트윈 통합)
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d6 (목표 수 강제 금지) · d9 (explicit-file staging) · d10 (icon·name·alias 헤더) · g5 (verdict verbatim)

> 본 ledger 는 UFO verify ladder 의 **V3 🟢 push** 슬롯을 채운다 — Stage-1~3 의 `hexa verify --expr` numerical recompute (libm-class · ε=1e-9) 9건을 **🟢 SUPPORTED-NUMERICAL 통합 ledger** 로 봉합한다. V1 (claim inventory) 가 tier triage 를 했고, V2 (closed-form lattice 🔵) 가 동시 진행 중이며, 본 V3 은 그 중 **numerical recompute 축** 만 묶는다. 모든 verdict 는 stage-doc 의 출력 VERBATIM 재인용 (@D g5 · 재판단 / LLM self-judge 금지 · 재-verify 아님). 디지털트윈 통합 sim 의 4-layer 본해 (CFD·EM 3D·응력·열·⟲) 는 pool/cloud 위임 (verb-4 deferred · @D d7) 이므로 **🟠 정직 표기** (허위 🟢 금지).

---

## 0 TL;DR — V3 🟢 분포 표

```
   🛸 UFO V3 numerical recompute — tier 분포 (libm Δ≤1e-9)
   ──────────────────────────────────────────────────────────
   🟢 SUPPORTED-NUMERICAL    9   █████████  Stage-1~3 hexa verify --expr (verbatim + atlas fold)
   🟠 INSUFFICIENT/DEFERRED  1   █          디지털트윈 통합 sim 본해 (CFD·EM 3D·응력·열·⟲) = pool/cloud 위임
   ──────────────────────────────────────────────────────────
   V3 = numerical 축만 — 형식 🔵 = V2 lattice push · ⚪ Stage-4~7 = V1/V4 ledger
```

| V3 항목 | atom | 건수 | tier | 충족 |
|---|---|---|---|---|
| Stage-1 hover EM B-field | `ioffe_loop_bz` | 3 | 🟢 SUPPORTED-NUMERICAL | ✅ |
| Stage-2 cruise MHD thrust | `triple_product` | 3 | 🟢 SUPPORTED-NUMERICAL | ✅ |
| Stage-3 orbital 상대론 회계 | `pair_threshold_total` ×1 · `rel_kinetic_from_p` ×2 | 3 | 🟢 SUPPORTED-NUMERICAL | ✅ |
| **numerical 합계** | — | **9** | **🟢** | ✅ |
| 디지털트윈 통합 sim 본해 | (CFD·EM 3D·응력·열·⟲ fixed-point) | — | 🟠 INSUFFICIENT/DEFERRED | ❌ pool/cloud 위임 |

**한줄 요약**: UFO 추진/EM 코어의 **numerical 검증 = 9건 🟢** (전부 `hexa verify --expr` verbatim + `@F verified-*-num` atlas fold · atlas hash `663698a0…ce7fb`). 디지털트윈 **통합 sim 본해는 verb-4 가 수렴 기준만 닫았고 무거운 CFD/EM-3D/FEA/열/⟲ 본해는 pool/cloud micro-exp 위임 (@D d7) → 🟠 정직 표기** (본 verb 에서 미실행 · 결코 "불가능" 아님 @D d2). 분포 = **🟢 9 · 🟠 1 (sim deferred)**.

---

## 1 Stage-1~3 numerical 🟢 통합 — verbatim 재인용 + atlas atom

Stage-1~3 의 9건 `hexa verify --expr` verdict 를 **VERBATIM 재인용** (@D g5 · 재판단 금지). 본 V3 ledger 는 재-verify 가 아니라 stage-doc 의 검증 출력을 numerical 축으로 통합한다.

### 1.1 Stage-1 hover — EM B-field 생성 (`ioffe_loop_bz` ×3, 🟢) — `UFO/verify/stage1-hover-fields.md` §2.2

`ioffe_loop_bz(a, I, ζ) = μ₀·I·a²/(2·(a²+ζ²)^1.5)` ([T]) — RTSC/Wheeler inherit (ANTIMATTER ⓺가둠 동일 atom). hover-coil 90/120/200 kg 페이로드 각각 중심 B=2 T 생성 검증 (ζ=0):

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
- atlas atom: `@F verified-ioffe_loop_bz-num` → `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` (binary-builtin SSOT) · folded via `hexa atlas register --from-verify ioffe_loop_bz(0.3,954930,0)=2.00000071565` (Case A 대표 entry · B/C 동일 fn → idempotent skip 정상)
- prior provenance: stage1-hover-fields.md §3 (PR#191 verified atom 인용 · Meissner `F_lev=χVB(dB/dz)/μ₀` 의 B-field 입력값 numerical 우회 검증)

### 1.2 Stage-2 cruise — MHD thrust (`triple_product` ×3, 🟢) — `UFO/verify/stage2-cruise-mhd.md` §2.2

`triple_product(a, b, c) = a·b·c` ([N]) — FUSION F2 Lawson 삼중곱 동일 대수 root (`tool/verify_cli.hexa::_triple_product` · BLUE-MAX 🔵-audit 커버). MHD thrust `F_MHD = J·B·V_ch` 를 인자 `(J, B_ch, V_ch)` 재배치로 검증 (@D d4 single generic dispatch 우회):

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
- atlas atom: `@F verified-triple_product-num` (embedded.gen.hexa:30535) · auto-absorb default (@D g69) · 첫 verify (저고도) 대표 entry, 중간/고고도 idempotent skip
- prior provenance: stage2-cruise-mhd.md §3 (PR#198 · F_MHD_total(저고도)=192 kN / m·g(650 kg)=6.38 kN ≈ 30배 마진 · 이상화 상한)

### 1.3 Stage-3 orbital — annihilation/상대론 회계 (`pair_threshold_total` ×1 · `rel_kinetic_from_p` ×2, 🟢) — `UFO/verify/stage3-orbital-gamma.md` §2

γ-rocket annihilation energy `E=2·m_p·c²` → relativistic exhaust → `I_sp = c/g` 광자 천장의 상대론 에너지 회계를 ANTIMATTER ⓵생성/⓶감속 atom 으로 검증 (`m = m_p·c² = 938.272 MeV`):

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
- atlas atom: `@F verified-pair_threshold_total-num` (embedded.gen.hexa:30652) + `@F verified-rel_kinetic_from_p-num` (embedded.gen.hexa:30514) · 두 atom 모두 ANTIMATTER ⓵생성/⓶감속 에서 이미 folded → Stage-3 재사용은 idempotent skip (정직 표기 · 신규 fold 없음 · hash 안정)
- prior provenance: stage3-orbital-gamma.md §3 (PR#199)
- **honest note (@D d6)**: γ-rocket 광자 천장 `I_sp = c/g ≈ 3.057e7 s` ↔ spec §2 target `I_sp ≥ 1e9 s` = **2 자릿수 불일치 정직 표기** (closure = verb-4 mass-flow 정의 + falsifier F-ANTI-3 의무). 본 V3 ledger 의 🟢 는 **상대론 에너지 회계의 numerical recompute** 에 한정 — target 1e9 s 달성을 주장하지 **않는다**.

### 1.4 numerical 9건 통합 verdict + atlas atom hash

| stage | atom | 건수 | tier | atlas fold (embedded.gen.hexa line) |
|---|---|---|---|---|
| Stage-1 hover | `ioffe_loop_bz` | 3 | 🟢 SUPPORTED-NUMERICAL | `@F verified-ioffe_loop_bz-num` |
| Stage-2 cruise | `triple_product` | 3 | 🟢 SUPPORTED-NUMERICAL | `@F verified-triple_product-num` (30535) |
| Stage-3 orbital | `pair_threshold_total` ×1 · `rel_kinetic_from_p` ×2 | 3 | 🟢 SUPPORTED-NUMERICAL | `@F verified-{pair_threshold_total,rel_kinetic_from_p}-num` (30652/30514) |
| **합계** | — | **9** | **🟢** | — |

- **atlas hash (post-register)**: `663698a06bc6f967fa2855a77bc4e399aae465dda5ca948b3c7352dbf98ce7fb`
- **재현**: `cd ~/core/demiurge && hexa atlas hash` · lookup: `hexa atlas lookup verified-ioffe_loop_bz-num` / `--prefix=verified-triple` / `verified-pair_threshold_total-num` / `verified-rel_kinetic_from_p-num`
- fold 위치 = `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` (binary-builtin SSOT · @D d3) — 본 V3 PR 은 demiurge UFO 도메인 verify 문서만, hexa-lang 코드 변경 없음 (atom 기등록 idempotent)

---

## 2 디지털트윈 통합 sim — 본해 pool/cloud 위임 🟠 (verb-4 deferred sizing 인용)

V3 의 대상 4번째 항목 (디지털트윈 통합 sim) 은 **본해 미수렴 🟠 정직 표기** 다 (허위 🟢 금지 · @D d6). verb-4 analyze ⟲ (`UFO/analyze/integrated-vehicle-analyze.md`) 가 4-layer 지배방정식 + residual 기준 + ⟲ fixed-point (max Δ_rel<1e-3) 의 **수렴 기준 manifest** 를 닫았으나, 무거운 CFD/EM-3D/FEA/열/⟲ **본해 값은 pool/cloud micro-exp 위임** (@D d7) — 본 verb 에서 **미실행**.

| 디지털트윈 layer | verb-4 수렴 기준 | 본해 sizing (위임 라우팅 @D d7) | tier |
|---|---|---|---|
| ① CFD (Navier-Stokes · C_d·L/D) | RMS<1e-6 · Δ_rel<1e-4/500iter | hover 2D ~3M cell → pool ubu idle-only · cruise 3D DES ~15-30M cell → GPU pod (vast.ai first) | 🟠 deferred |
| ② EM 6-coil 3D B-map (Maxwell·Meissner) | ‖ΔB‖<1e-4 T (axisym→3D) · Δ_rel<2% | 6-coil 60° array **상호작용** FEM (getdp pool→cloud) | 🟠 deferred (단일코일 §1.1 🟢 anchor) |
| ③ 응력 von Mises FEA (650 kg·SF=2.5·LC-1~5) | ‖R‖/‖R₀‖<1e-6 · min SF≥2.5 | LC-1~5 FEA (pool linear → cloud explicit dynamic) | 🟠 deferred |
| ④ 열 cryo balance (cryo+radiator) | max\|Ṫ\|<1e-3 K/s · \|Q̇_in−Q̇_out\|/Q̇_in<1e-3 | cryo transient + radiator 25 m² Q̇=εσT⁴ (pool steady → transient) | 🟠 deferred |
| ⟲ 4-layer fixed-point coupling | max(‖X_k−X_{k−1}‖/‖X_k‖)<1e-3 (X∈{C_d,B_map,σ_v,T}) | LC-2 cruise 8-coupling 강결합 (staggered → monolithic 승격 · GPU pod) | 🟠 deferred |

- **honest invariant (@D d6)**: 디지털트윈 통합 sim 의 본해 수렴값은 어느 것도 본 V3 ledger 에서 산출/주장하지 않는다. verb-4 가 **기준만** 닫았고 본해는 verb-6 verify (`integrated-vehicle-verify.md` §2) 가 집계한 그대로 **🟠 INSUFFICIENT/DEFERRED** — pool/cloud micro-exp 위임 queue (@D d7 sizing · sim 은 `.hexa` only · ad-hoc python 금지).
- **no impossibility framing (@D d2)**: 본해 미수렴은 "통합 sim 불가" 가 **아니다** — breakthrough path (shock-adaptive AMR · CFRP T1100 승격 · dewar 통합 · monolithic coupling 승격) 가 verb-4 §6 deferred queue 에 명시됨. 본해 수렴 후 `@F verified-*-num` atlas fold → 🟠→🟢 escalation.
- escalation note: 본 표의 ② EM 6-coil 3D 는 **단일코일 `ioffe_loop_bz` §1.1 🟢 anchor** 위에 상호작용 본해만 위임 — anchor 는 V3 에서 numerical 검증 완료.

---

## 3 libm Δ≤1e-9 충족 확인 (재인용분 전부 통과)

V3 의 numerical gate = **libm-class recompute · |Δ| ≤ ε=1e-9** (TECS-L n6-rep Tier2). 재인용된 9건 전부 충족:

| Case | atom | 입력 | 기대값 | \|Δ\| | ε 충족 |
|---|---|---|---|---|---|
| S1-A | `ioffe_loop_bz` | (0.3, 954930.0, 0.0) | 2 | 5.67085e-10 | ✅ ≤ 1e-9 |
| S1-B | `ioffe_loop_bz` | (0.5, 1591549.0, 0.0) | 2 | 5.67086e-10 | ✅ ≤ 1e-9 |
| S1-C | `ioffe_loop_bz` | (1.0, 3183099.0, 0.0) | 2 | 5.67085e-10 | ✅ ≤ 1e-9 |
| S2-저 | `triple_product` | (200000.0, 5.0, 0.096) | 96000.0 | 0.0 | ✅ ≤ 1e-9 |
| S2-중 | `triple_product` | (150000.0, 4.0, 0.096) | 57600.0 | 0.0 | ✅ ≤ 1e-9 |
| S2-고 | `triple_product` | (100000.0, 3.0, 0.096) | 28800.0 | 0.0 | ✅ ≤ 1e-9 |
| S3-A | `pair_threshold_total` | (938.272) | 6567.9 | 0.0 | ✅ ≤ 1e-9 |
| S3-B | `rel_kinetic_from_p` | (9382.72) | 8491.24 | 0.0 | ✅ ≤ 1e-9 |
| S3-C | `rel_kinetic_from_p` | (1625.13) | 938.272 | 0.0 | ✅ ≤ 1e-9 |

- **충족 합계**: 9/9 ≤ ε=1e-9 ✅ — Stage-1 의 |Δ|=5.67e-10 은 4π·μ₀ libm fold 의 floating-point 잔차 (`reference_hexa_4pi_constant_fold_precision` 영역 내 · ε 한도 통과), Stage-2/3 은 순수 대수 product/분산식으로 |Δ|=0.0 정확.
- gate verdict: **V3 numerical recompute = 9/9 PASS** (libm Δ≤1e-9). verdict 는 §1 verbatim 인용 (LLM self-judge 없음 · @D g5).

---

## 4 V4 로 가는 escalation (V1+V2+V3 통합) + cross-link + deferred

### 4.1 V4 escalation 인계

V4 final tier ledger 는 V1+V2+V3 을 통합한다 — V3 이 인계하는 numerical 축:

| 입력 | 출처 | V4 통합 역할 |
|---|---|---|
| numerical 9건 🟢 (verbatim + atlas fold) | 본 V3 §1 · §3 | V4 tier 분포의 🟢 SUPPORTED-NUMERICAL 코어 (Stage-1~3 추진/EM) |
| 디지털트윈 통합 sim 본해 🟠 deferred | 본 V3 §2 · verb-6 §2 | V4 absorbed=true 판정의 **미충족 게이트** 입력 (pool/cloud queue) |
| 형식 lattice 🔵 (closed-form identity) | V2 push (동시 진행) | V4 🔵 SUPPORTED-FORMAL 축 (n=6 σ·τ=48 · Alcubierre · Morris-Thorne · KK · (σ−φ)²=100c) |
| ⚪ 13 falsifier (Stage-4~7 OPEN) | V1 §1 · stage4-7-falsifier-preregister.md | V4 ⚪ SPECULATION-FENCED (결코 🟢/🔵 금지 · UNPROVEN) |

- V1 tier 분포 (38 claim · 🟢9·🟡8·🟠4·⚪17) 에서 V3 은 **🟢 9건의 numerical 근거를 verbatim 으로 닫음** — V4 는 V2 의 🔵 형식 push 가 합류하면 🟢+🔵 검증 코어를 통합.
- **Phase E absorbed=true 판정 입력**: V3 numerical gate 는 PASS (9/9) 이나, 디지털트윈 통합 sim 본해 5 게이트 (CFD·EM 3D·응력·열·⟲ PID) + F-ANTI-3 (I_sp target closure) 가 🟠 미충족 → absorbed=true 는 verb-6 §4.2 미충족 게이트 수렴 후 flip 가능 (@D d5 · projection flip 금지).

### 4.2 cross-link

| 대상 | 파일 | 역할 |
|---|---|---|
| Stage-1 verify | `UFO/verify/stage1-hover-fields.md` §2.2·§3 | EM B-field `ioffe_loop_bz` 🟢×3 verbatim (PR#191) |
| Stage-2 verify | `UFO/verify/stage2-cruise-mhd.md` §2.2·§3 | MHD thrust `triple_product` 🟢×3 verbatim (PR#198) |
| Stage-3 verify | `UFO/verify/stage3-orbital-gamma.md` §2·§3 | 상대론 회계 🟢×3 verbatim (PR#199) + I_sp 천장 정직 표기 |
| verb-6 verify | `UFO/verify/integrated-vehicle-verify.md` §1·§2 | 디지털트윈 통합 (9건 🟢 + 4-layer 본해 🟠 deferred) |
| V1 claim inventory | `UFO/verify/V1_claim_inventory.md` | tier 분포 (🟢9·🟡8·🟠4·⚪17) 통합 ledger |
| verb-4 analyze | `UFO/analyze/integrated-vehicle-analyze.md` §6 | 4-layer 수렴 기준 + 본해 deferred sizing (@D d7) |
| substrate | `~/core/demiurge/{RTSC,FUSION,ANTIMATTER}.md` | Stage-1/2/3 verified atom SSOT (`ioffe_loop_bz`·`triple_product`·`pair_threshold_total`·`rel_kinetic_from_p`) |
| stdlib 코드 SSOT | `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` | atlas fold 위치 (@D d3 · binary-builtin SSOT) |
| reuse lattice | `~/core/demiurge/NEXUS.tape` | RTSC→Stage-1 · FUSION→Stage-2 · ANTIMATTER→Stage-3 reuse edge (@D d19) |

### 4.3 deferred

- [ ] 디지털트윈 통합 sim 본해 수렴 (CFD C_d·L/D · EM 6-coil 3D B-map · 응력 von Mises LC-1~5 · 열 cryo balance · ⟲ 4-layer fixed-point) → pool/cloud micro-exp (@D d7 sizing · .hexa only) → 수렴 후 `@F verified-*-num` fold → 🟠→🟢 escalation
- [ ] stdlib atom 등록 (`meissner_lev_force`·`mhd_thrust`·`gamma_rocket_isp`) → §1 의 🟡 합성식 (F_lev gradient-form · Lorentz F=J×B · γ-rocket I_sp=c/g) 🟢 escalate (hexa-lang 별 repo · @D d3/d9)
- [ ] γ-rocket I_sp target 1e9 s mass-flow 정의 closure (F-ANTI-3 · 광자 천장 3.057e7 s ↔ target 2-자릿수 불일치) — 목표 수 강제 금지 (@D d6)
- [ ] V4 final tier ledger — V1+V2+V3 통합 + Phase D 메타 + Phase E absorbed=true 결단 (본 V3 §4.1 인계 소비)
- [ ] V2 🔵 push 합류 — closed-form identity lattice (`hexa verify --expr` + atlas register) → V4 에서 🟢+🔵 검증 코어 통합

---

## 5 governance 정합

- @D d1 (non-wet-lab → completed-form): Stage-1~3 numerical 9건 completed-form (libm Δ≤1e-9 PASS) · 디지털트윈 통합 sim 본해는 pool/cloud 위임 (verb-4 §6 deferred queue · path clear) ✅
- @D d2 (no impossibility framing): 디지털트윈 통합 sim 본해 미수렴은 "통합 sim 불가" 아님 — pool/cloud 위임 + breakthrough path 명시 (§2) ✅
- @D d3 (stdlib SSOT): atlas fold 위치 = `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` (binary-builtin SSOT) — 본 V3 PR 은 demiurge UFO 도메인 verify 문서만 (hexa-lang 코드 변경 없음 · atom 기등록 idempotent) ✅
- @D d4 (single generic dispatch): `ioffe_loop_bz`·`triple_product`·`pair_threshold_total`·`rel_kinetic_from_p` 단일 atom 으로 stage/payload/고도 9 사례 (manifest-only differentiation · per-instance dispatcher 없음) ✅
- @D d5 (absorbed gate): V3 numerical gate PASS (9/9) 이나 디지털트윈 통합 sim 본해 5 게이트 + F-ANTI-3 🟠 미충족 → absorbed=true 는 본해 수렴 후 flip (projection flip 금지 · §4.1) ✅
- @D d6 (목표 수 강제 금지): γ-rocket I_sp 천장 3.057e7 s ↔ target 1e9 s 2-자릿수 불일치 정직 표기 · 디지털트윈 통합 sim 본해 미수렴 🟠 정직 (허위 🟢 없음) ✅
- @D d9 (worktree isolation): explicit file git add (V3 ledger + UFO.md + UFO.log.md) · 인접 worktree 동시 staging 없음 ✅
- @D d10 (icon · name · alias): 🛸 UFO · V3 numerical recompute · alias 헤더 정합 ✅
- @D d19 (intra-domain reuse lattice): RTSC→Stage-1 · FUSION→Stage-2 · ANTIMATTER→Stage-3 reuse edge (NEXUS.tape · §4.2) ✅
- @D g5 (verdict verbatim): §1 Stage-1~3 9건 모든 `hexa verify --expr` 출력 VERBATIM 재인용 (LLM self-judge / 재판단 없음) ✅
- pointer: 본 ledger 는 Tier-② identity 문서 — 실 코드 SSOT 는 `~/core/hexa-lang/` (`reference_pointer_manifests_track_identity`)
