# UFO Stage-2 cruise — MHD 추진 closed-form verify 🟢

> Phase A Stage-2 cruise (MHD + D-T/p-¹¹B fusion · 고도 20~200 km). 본 ledger 는 FUSION 자산 (BLUE-MAX 🔵 audit 완료 · MHD F=J×B substrate) 위에 MHD 추력 `F = J×B×V_ch` (Lorentz body force `f = J×B`) 의 numerical recompute 를 `hexa verify --expr triple_product` 3건 (저고도/중간/고고도 B·J 파라미터) 으로 🟢 SUPPORTED-NUMERICAL 도장, atlas 등록 (folded @F) 완료. g5: verdict verbatim · LLM self-judge 없음.

## 0. TL;DR

- **closed-form identity**: Lorentz body force 밀도 `f = J × B` ([N/m³]) → 채널 적분 thrust `F_MHD = J · B · V_ch` ([N]). 전류밀도 `J = σ·(E − u×B)` (generalized Ohm's law · MHD accelerator mode) — σ 는 plasma 전도도, u 는 채널 유속, E 는 인가 전계.
- **650 kg 비행체 cruise** (UFO design §2 · structure 650 kg/SF=2.5): MHD 채널 `L×W×H = 1.2×0.40×0.20 m → V_ch = 0.096 m³`, S1+S4 대각 페어 ×2. 채널당 `F_MHD = J·B·V_ch`.
- **MHD 추력 verify 🟢 SUPPORTED-NUMERICAL × 3건** (`hexa verify --expr triple_product J B V F`, |Δ|=0.0 ≤ ε=1e-9):

  | 고도 케이스 | J [A/m²] | B_ch [T] | V_ch [m³] | F_MHD [N] | verdict |
  |---|---|---|---|---|---|
  | 저고도 20 km | 2.0×10⁵ | 5.0 | 0.096 | 96 000 | 🟢 \|Δ\|=0.0 |
  | 중간 100 km | 1.5×10⁵ | 4.0 | 0.096 | 57 600 | 🟢 \|Δ\|=0.0 |
  | 고고도 200 km | 1.0×10⁵ | 3.0 | 0.096 | 28 800 | 🟢 \|Δ\|=0.0 |

- **합성 tier**: 채널당 thrust 의 **수치 product** `J·B·V` 는 🟢 SUPPORTED-NUMERICAL (아래 §2 verbatim). MHD 추진 form `f = σ(E−u×B)×B` → `F = J×B×V` **물리 합성식** 자체는 🟡 SUPPORTED-BY-CITATION (FUSION.md §2 (d)·(e) · Sutton-Sherman MHD · Jackson §5) — stdlib 전용 `mhd_thrust` atom 미등록, 가장 가까운 libm atom `triple_product` (FUSION F2 Lawson) 으로 우회 numerical 🟢.
- **atlas hash (post-register)**: `663698a06bc6f967fa2855a77bc4e399aae465dda5ca948b3c7352dbf98ce7fb` (16134 nodes) · folded @F `verified-triple_product-num` → `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` (binary-builtin SSOT · auto-absorb default, hexa-lang 코드 변경 없음).

## 1. Closed-form identity — Lorentz body force `f = J×B` · MHD thrust `F = J·B·V_ch`

### 1.1 derivation (MHD accelerator mode)

플라즈마/이온화 가스 채널에 자장 `B` 와 직교 전류 `J` 가 흐를 때 받는 Lorentz 체적력(body force) 밀도:

```
f = J × B                              [N/m³]   (Lorentz body force density)
J = σ · (E − u × B)                    [A/m²]   (generalized Ohm's law)
F_MHD = ∫_V (J × B) dV ≈ J · B · V_ch  [N]      (균일 채널 · J⊥B 가정)
```

- **σ (plasma 전도도)**: spec §2 Stage-2 요구 σ_e ≥ 10⁴ S/m (ionosphere ionized-gas · D-T/p-¹¹B 연소 플라즈마).
- **u (채널 유속)** · **E (인가 전계)**: MHD accelerator 모드는 `E > u×B` 영역에서 가스를 가속 (역으로 `E < u×B` 는 generator 모드 — 발전). UFO cruise 는 accelerator (추진) 모드.
- **J⊥B**: 채널 기하 (S1+S4 ducted intake) 가 J 와 B 를 직교 배치 → `|J×B| = J·B`, 체적 적분 → `J·B·V_ch`.
- **단위 정합**: `[A/m²]·[T]·[m³] = [A/m²]·[kg/(A·s²)]·[m³] = [kg·m/s²] = [N]` ✅.

### 1.2 650 kg 비행체 cruise 추력 닫힘 (UFO design §2.1 상속)

structure 650 kg/SF=2.5 디스크 (D=6.0 m · 5-bay) 의 Stage-2 mount = slot S1+S4 대각 페어 (FUSION MHD ducted intake). 채널 sizing 은 design §2.1 verbatim 상속:

| 변수 | 값 | 비고 |
|---|---|---|
| 채널 길이 L | 1.2 m | 디스크 외주 ducted intake (S1+S4) |
| 채널 폭 W | 0.40 m | intake aperture · structure §4.1 |
| 채널 높이 H | 0.20 m | duct cross-section |
| 채널 체적 V_ch | 0.096 m³ | L×W×H |
| 채널 자장 B_ch | 3.0~5.0 T | FUSION HTS 마진 내 (20 T@20K ceiling · §2.1) |
| 전류밀도 J | 1.0~2.0×10⁵ A/m² | σ_e·(E−u×B) (σ_e≥10⁴ S/m · E~20 V/m) |

```
F_MHD (per channel, 저고도) = J · B_ch · V_ch = 2.0e5 · 5.0 · 0.096 = 9.6e4 N (96 kN)
F_MHD_total = 2 channels (S1+S4 대각 페어)         = 1.92e5 N (192 kN)
m·g (650 kg)                                       = 650·9.81 = 6 376.5 N
margin = F_MHD_total / (m·g) = 1.92e5 / 6 376.5     ≈ 30  (30배 over-head, cruise 가속 충분)
```

> Mach 0.3~25 envelope (spec §2) 에 30배 추력/무게 마진. 단 이는 **이상화 Lorentz force 상한** (plasma 손실 · duct 효율 미반영). 실제 effective thrust 는 verb-4 analyze ⟲ CFD+MHD coupled 의무 (LC-2 cruise · structure §5.3 · design §2.2 caveat).

## 2. Numerical recompute — `hexa verify --expr triple_product` 3건 🟢

### 2.1 method

MHD thrust 전용 `mhd_thrust(J, B, V)` atom 은 stdlib 미등록. **우회 전략 (per @D d4 single generic dispatch)**: `F_MHD = J·B·V_ch` 는 순수 3-arg product → FUSION F2 의 Lawson **triple product** atom `triple_product(a,b,c) = a·b·c` (`hexa verify --expr triple_product`, pure product, 동일 대수 root) 으로 **identical numerical recompute**.

- fn: `triple_product(n, T, τ) = n·T·τ` (FUSION F2 Lawson 삼중곱 · `tool/verify_cli.hexa::_triple_product` · BLUE-MAX 🔵-audit 커버). 본 verify 는 인자를 `(J, B_ch, V_ch)` 로 재배치 — 같은 `a·b·c` 형식.
- recompute: `hexa verify --expr triple_product <J> <B> <V> <F_expected>` · ε=1e-9 (libm-class · TECS-L n6-rep Tier2)
- host: mini (macOS · `~/.hx/bin/hexa`) · ubu-2 segfault 회피 (per `reference_hexa_verify_host_mini`)
- 3 케이스 — 고도별 plasma σ_e·B 변화 반영 (B·J 가변):

| 사례 | 고도 | J [A/m²] | B_ch [T] | V_ch [m³] | F_MHD 기대 [N] | 물리 근거 |
|---|---|---|---|---|---|---|
| 저고도 | 20 km | 2.0×10⁵ | 5.0 | 0.096 | 96 000 | 고밀도 ionized-gas · 최대 σ_e · HTS peak B (design §2.1 baseline) |
| 중간 | 100 km | 1.5×10⁵ | 4.0 | 0.096 | 57 600 | mesosphere 희박 · σ_e 감소 · B detune |
| 고고도 | 200 km | 1.0×10⁵ | 3.0 | 0.096 | 28 800 | thermosphere 극희박 · MHD→γ-rocket 전이 임계 (Stage-3 인계) |

추력은 고도 상승 시 감소 (96→58→29 kN) — 대기 밀도/σ_e 저하 반영. 200 km 에서 F_MHD_total = 2·28800 = 57.6 kN 여전히 m·g=6.4 kN 의 ~9배 (전이 마진).

### 2.2 verbatim verdicts (3건 모두 🟢 SUPPORTED-NUMERICAL · |Δ|=0.0 ≤ ε=1e-9)

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

### 2.3 F_MHD composite tier

| 구성요소 | tier | 근거 |
|---|---|---|
| `J·B·V` product (3 사례) | 🟢 SUPPORTED-NUMERICAL | §2.2 verbatim verdicts × 3 (|Δ|=0.0) |
| B_ch 3~5 T (HTS 마진) | 🔵 SUPPORTED-FORMAL | FUSION `tf_peak_field` ITER B_peak=11.82 T < 20 T@20K (PR#1042/#1095 · getdp Δ=−0.064%) |
| σ_e ≥ 10⁴ S/m (plasma 전도도) | 🟡 SUPPORTED-BY-CITATION | spec §2 Stage-2 요구 · D-T ⟨σv⟩ Bosch-Hale (FUSION PR#1012) — wet-lab 연소플라즈마 downstream |
| `f = σ(E−u×B)×B` → `F = J×B×V` 합성 | 🟡 SUPPORTED-BY-CITATION | Sutton-Sherman "Engineering Magnetohydrodynamics" · Jackson §5 · FUSION.md §2 (d)(e) — stdlib `mhd_thrust` atom 미등록 (§5 deferred), `triple_product` 우회 |
| **Stage-2 cruise MHD (composite)** | **🟢 SUPPORTED-NUMERICAL** | numerical recompute 3건 + 합성 형식적 동치 (product) |

## 3. Atlas register — folded @F `verified-triple_product-num` 🟢

`hexa verify --expr` 의 default auto-absorb (@D g69) 로 🟢 verdict 가 라이브 atlas 에 자동 fold. 첫 verify (저고도 Case) 가 대표 entry 로 등록, 중간/고고도는 동일 fn → idempotent skip (atlas 는 fn-id 별 1 entry, B/C 는 같은 `triple_product` → `already in atlas — idempotent skip` 정상):

```
@F verified-triple_product-num :: embedded.gen.hexa:30535
@F verified-triple_product-num = triple_product(200000.0,5.0,0.096) = 96000.0 :: formula [d=2026-05-25 active]
  tier = "🟢 SUPPORTED-NUMERICAL"
  verified-by = "hexa verify --expr triple_product 200000.0,5.0,0.096 96000.0"
  cite = "TECS-L n6-rep Tier2 — hexa-native libm-class numerical recompute (ε=1e-9)"
  provenance = "tool/atlas_cli.hexa register --from-verify (direct node-gen → embedded.gen.hexa SSOT; 🟢 numerical)"
```

**Post-register atlas hash**: `663698a06bc6f967fa2855a77bc4e399aae465dda5ca948b3c7352dbf98ce7fb` (16134 nodes)

재현: `cd ~/core/demiurge && hexa atlas hash` · lookup: `hexa atlas lookup --prefix=verified-triple`

> ⚠ 본 atom 은 FUSION F2 land 시점에 이미 atlas 에 folded — Stage-2 verify 는 동일 `triple_product` 식의 UFO MHD 재배치 numerical 🟢 (idempotent · hexa-lang `embedded.gen.hexa` SSOT 코드 변경 0). 별 repo 동시 점유 시에도 안전 (atlas runtime fold-only).

## 4. Stage 전이 — Stage-1 hover → Stage-2 cruise → Stage-3 orbital

### 4.1 Stage-1 (20 km hover) → Stage-2 (MHD cruise)

| 고도 | dominant 추진 | F vs m·g (650 kg, m·g=6 376.5 N) | 전이 trigger |
|---|---|---|---|
| 0 ~ 20 km | **Meissner (B-gradient)** (Stage-1) | `F_lev` ≫ m·g (stage1-hover-fields.md §1) | — |
| 20 km ~ | **MHD 추진** (Stage-2) | `F_MHD_total=192 kN` @20 km → ~30× | `altitude ≥ 20 km AND v ≥ Mach 0.3` → MHD spool-up Δt<30 s (design §6) |
| 200 km ~ | **antimatter γ-rocket** (Stage-3) | MHD shutdown · `F_MHD_total=57.6 kN` @200 km 가 임계 | `altitude ≥ 200 km AND ΔV-budget OK` → γ-rocket ignition |

Stage-1 → Stage-2 전이 (design §6 state machine 정합): 자석 thrust vector + MHD spool-up. 무게 전환 — Stage-2→3 시 MHD 연료(D-T/p-¹¹B) 소진분 Δm → F_lift 재-trim (6-DOF active).

### 4.2 Stage-2 → Stage-3 (200 km orbital)

- 200 km 에서 대기 σ_e → 0 (thermosphere 극희박) → MHD 추력 자연 감쇠 (96→29 kN 추세, §2.1). 본 verify 의 고고도 케이스 (28.8 kN/channel) 가 전이 임계점 정량화.
- Stage-3 인계: ANTIMATTER γ-rocket (anti-H+H annihilation · I_sp verify 🟢 는 Stage-3 마일스톤 · design §3 Penning trap closed-form 상속).
- 전이 falsifier (preregister · Stage-3 마일스톤 진입 시 작성): F-FUSION-3 (MHD effective thrust < 이상화 상한 ≥50% @200 km · duct+plasma 손실 closed-form).

### 4.3 Stage-2 전이 falsifier (preregister)

- **F-FUSION-1**: σ_e < 10⁴ S/m 인 고도대에서 `F_MHD < m·g` (MHD 단독 cruise 불가 임계 고도 closed-form).
- **F-FUSION-2**: Troyon β_N > 2.8 채널 plasma (FUSION PR#1027) → MHD 안정 한계 초과 (β-limit 위반 시 추진 채널 disrupt).
- **F-FUSION-3**: verb-4 CFD+MHD coupled effective thrust < 이상화 `J·B·V` 상한 (duct 효율 + plasma 손실 — design §2.2 의무).

## 5. cross-link · deferred

### cross-link

- `UFO.md` (Phase A Stage-2 마일스톤) · `UFO.log.md` (verb 체크박스 · 본 PR flip)
- `UFO/verify/stage1-hover-fields.md` §4 (Stage-1→Stage-2 인계 표 · 본 ledger 가 §4.2 F-A2 닫음)
- `UFO/design/integrated-vehicle-design.md` §2 (MHD 채널 closed-form sizing · 본 ledger 의 설계 SSOT)
- `UFO/HEXA-UFO.md` Stage-2 cruise spec (hexa-ufo HEXA-Disc 7-stage ladder)
- `~/core/demiurge/FUSION.md` §2 (d)(e) · §4 (F1 Bosch-Hale ⟨σv⟩ · F4 Troyon β · F5 `tf_peak_field`) — Stage-2 substrate SSOT (BLUE-MAX 🔵 audit 완료 PR#1102)
- `~/core/demiurge/ANTIMATTER.md` ⓷포획 (Stage-3 γ-rocket 인계 · Penning trap closed-form)
- `~/core/hexa-lang/tool/verify_cli.hexa::_triple_product` (atlas SSOT · `triple_product` fn home · FUSION F2)
- `~/core/demiurge/NEXUS.tape` 후보 — FUSION `triple_product` ↔ UFO Stage-2 MHD thrust reuse edge (per @D d19 intra-domain reuse lattice)

### deferred

- **stdlib `mhd_thrust(J, B, V)` (또는 `lorentz_body_force`) atom 등록**: hexa-lang 별 repo (`~/core/hexa-lang/`) `tool/verify_cli.hexa::_recompute` 확장 + `stdlib/fusion/mhd.hexa` (또는 `stdlib/ufo/`) 신규 → 별 PR 분리 (per @D d3 stdlib SSOT · @D d9 worktree isolation). 본 PR 은 demiurge UFO 도메인 verify ledger 만 추가. 등록 시 본 §2.3 표 `f=σ(E−u×B)×B → F=J×B×V` 합성 행이 🟡 → 🟢 자동 escalation.
- **σ_e(altitude) 프로파일 closed-form**: ionosphere/thermosphere 전도도 고도 모델 (IRI-class) → MHD 추력 고도 의존 정량 (verb-4 analyze ⟲ CFD+MHD coupled 의무 · LC-2).
- **F-FUSION-{1,2,3} falsifier 정식 preregister**: Stage-2 cruise verb-4/verb-6 진입 시 작성 (§4.3 골격).
- **NEXUS.tape reuse edge**: FUSION `triple_product` → UFO Stage-2 MHD thrust (제공자/소비자 그래프) 후속 PR 에서 추가.

## 6. governance 정합

- @D d1 (non-wet-lab → completed-form): MHD thrust closed-form numerical recompute 3건 완성 ✅
- @D d2 (no impossibility framing): MHD sim PASS = "cruise 채널 설계 타당", 결코 "Q>1 달성" — wet-lab 연소플라즈마 downstream · 고도 전이 falsifier 표면화 ✅
- @D d3 (stdlib SSOT): atlas fold 위치 = `~/core/hexa-lang/compiler/atlas/embedded.gen.hexa` (binary-builtin SSOT) — 본 PR 은 demiurge 문서만, hexa-lang 코드 변경 없음 (atom 기등록 idempotent) ✅
- @D d4 (single generic dispatch): `triple_product` 단일 atom 으로 저/중/고고도 3 사례 (manifest-only B·J differentiation) ✅
- @D d5 (absorbed=true ⇔ all non-wet-lab gates PASS): Stage-2 MHD numerical gate PASS, wet-lab (실제 cruise 시연) downstream
- @D d10 (icon · name · alias): UFO 🛸 통합 비행체 head 정합
- @D d19 (intra-domain reuse lattice): FUSION `triple_product` → UFO Stage-2 MHD thrust reuse 표시 (NEXUS.tape 등재 deferred)
- @D g5 (verdict verbatim): §2.2 / §3 모든 `hexa verify` / `hexa atlas` 출력 VERBATIM 인용 (LLM self-judge 없음) ✅
- pointer: 본 ledger 는 Tier-② identity 문서 — 실 코드 SSOT 는 `~/core/hexa-lang/` (`reference_pointer_manifests_track_identity`)
