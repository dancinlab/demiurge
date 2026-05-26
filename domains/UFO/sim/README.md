# 🛸 UFO/sim — 디지털트윈 sim 엔진 사양 (HEXA-SIM 축 흡수)

icon · name · alias — 🛸 UFO/sim — 디지털트윈 통합 sim 엔진(다물리 다스케일)

## 0. TL;DR — UFO 디지털트윈 sim 엔진 흡수 요약

UFO 의 **verb-4 analyze ⟲** (CFD + EM + 추진 + 응력 + 열관리 반복 수렴) 와
**verb-6 verify** (디지털트윈 통합 🟢) 를 받쳐줄 sim 엔진 사양을 `~/core/hexa-ufo/HEXA-SIM.md`
(679 LOC · n=6 멀티스케일 해석기) 에서 받아 manifest-only 형태로 흡수한다.

- **흡수 범위** = sim 엔진 layer stack 사양 (CFD · EM · 추진 · 응력 · 열관리) + n=6 멀티스케일 산술 축
- **흡수 형태** = 사양 manifest (`README.md` + `manifest.tape`) — 실제 해석 코드는 `hexa-lang/stdlib/sim/*` 또는 `~/core/hexa-ufo/hexa-sim/` 의 SSOT 유지 (@D d3)
- **단일 디스패치 축** = `(domain, verb, formulation, solver)` 4-축 매트릭스 — UFO 별도 분기 없이 generic engine traversal (@D d4)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  UFO 디지털트윈 sim — layer stack (HEXA-SIM n=6 축 통합)                     │
├─────────────────────────────────────────────────────────────────────────────┤
│  Layer 5 · INTEGRATION  · 통합 OMEGA  · σ=12  · Cross-DSE 자가치유          │
│      ▲                                                                       │
│  Layer 4 · SYSTEM       · 추진 stage  · τ=4   · Stage-1~7 ladder            │
│      ▲                                                                       │
│  Layer 3 · MODULE       · 응력+열관리  · J₂=24 · 구조 + 냉각 (LN₂·LHe·rad)   │
│      ▲                                                                       │
│  Layer 2 · CONTINUUM    · CFD + EM    · φ=2   · Navier-Stokes ⊗ Maxwell    │
│      ▲                                                                       │
│  Layer 1 · MESOSCALE    · 자장 + 부상  · n=6   · Meissner · GetDP · MHD     │
│      ▲                                                                       │
│  Layer 0 · MATERIAL     · 격자 + 전도  · CN=6  · DFT · ρ · κ · σ_e          │
└─────────────────────────────────────────────────────────────────────────────┘
              UFO sim 엔진 = 6-층 멀티스케일 동일 산술 관통
```

## 1. 흡수 source

| 항목 | 값 |
|------|-----|
| Source | `~/core/hexa-ufo/HEXA-SIM.md` |
| SHA-1 | `305174e70c99bb52f74beeb83a1b55e68ede6911` |
| LOC | 679 |
| Sidecar | `~/core/hexa-ufo/HEXA-SIM.tape` (`@I id001 := "hexa_sim"`) |
| 흡수 일자 | 2026-05-25 |
| 흡수 형태 | manifest-only (코드 SSOT 는 hexa-ufo + hexa-lang) |
| 부수축 위치 | UFO 5 부수축 중 5/5 (sim) — hover · grav · cloak · teleport · sim |

## 2. sim 엔진 사양 — 4축 매트릭스

UFO 디지털트윈 sim 은 **`(domain, verb, formulation, solver)`** 4축으로 단일 generic dispatch.
어떤 stage 든 동일 traversal — instance = manifest only (@D d4).

| domain | verb | formulation | solver (SSOT) | 검증 layer |
|--------|------|-------------|---------------|-----------|
| cfd | analyze | Navier-Stokes (compressible) | hexa-lang/stdlib/sim/cfd_ns | F=ρ(v·∇)v |
| cfd | analyze | RANS k-ω SST | hexa-lang/stdlib/sim/cfd_rans | 난류 Re_x |
| em | analyze | Maxwell-Ampere · Faraday | hexa-lang/stdlib/sim/em_maxwell | ∇×B=μ₀J |
| em | analyze | GetDP solenoid (axisym) | hexa-lang/stdlib/em_getdp | B-axis closed-form |
| em | verify | Meissner exclusion (London) | rtsc/getdp_hts.py | λ_L · B<B_c |
| prop | analyze | Lorentz F=J·B·V | UFO/sim layer-1 dispatcher | F_thrust |
| prop | analyze | MHD momentum (FUSION carrier) | hexa-lang/stdlib/fusion/* | F_MHD = J×B |
| prop | analyze | γ-rocket I_sp (anti-H+H) | hexa-lang/stdlib/antimatter/* | I_sp = c·η |
| stress | analyze | Linear-elastic FEA | hexa-lang/stdlib/sim/fea | σ_v ≤ σ_y |
| stress | analyze | Composite ply stress | hexa-lang/stdlib/sim/fea_ply | Tsai-Wu |
| therm | analyze | Heat conduction + radiation | hexa-lang/stdlib/sim/heat | k∇²T = ρcṪ |
| therm | analyze | Cryo radiator balance | hexa-lang/stdlib/sim/heat_cryo | LN₂·LHe Q̇ |

핵심 invariant: **n=6 산술 관통** — σ(6)=12, τ(6)=4, φ(6)=2, sopfr(6)=5, σ·τ=48, σ-φ=10
모든 layer 의 closed-form identity 가 위 수론 함수 폐형에서 자동 유도 (하드코딩 0).

## 3. CFD layer — 공기역학

UFO Stage-1 hover (0~20km) + Stage-2 cruise (20~200km) 의 **공기역학 해석**.

- **Stage-1 hover** — Meissner 부상력 + 대기 항력 균형 (F_lev = F_drag + W)
- **Stage-2 cruise** — MHD 추력 + 압축성 NS (Re ≫ 10⁶, Ma 0.3~3.0)
- **Stage-3+** — 진공/희박 대기 → CFD 영향 미미, EM/추진 layer 가 주도

formulation:
```
ρ Dv/Dt = -∇p + ∇·τ + ρg + F_body  (Navier-Stokes · compressible)
                                    F_body = J×B  (EM coupling)
```

solver: `hexa-lang/stdlib/sim/cfd_ns` (예정) + 검증 case `hexa-ufo/hexa-sim/` shock-tube · channel-flow

cross-link:
- UFO/hover (Phase B sub-axis · LANDED PR#183) — Stage-1 hover 부상력 closed-form
- RTSC.md — Meissner 자석 사양 (Stage-1 carrier)

## 4. EM layer — 자장 + cloak

UFO 의 자장 sim — Stage-1 Meissner 부상 · Stage-2 MHD coupling · cloak layer (E-field 가시성 차단).

- **Maxwell-Ampere** ∇×B = μ₀(J + ε₀ ∂E/∂t) — 전 stage 공통 base
- **Meissner exclusion** B_inside = 0, B_surface = B_applied · exp(-x/λ_L) — RTSC 자석 closed-form
- **Lorentz force** F = q(E + v×B), F_density = J×B — 추진 layer 의 input
- **GetDP solenoid axisym** — RTSC 자석 closed-form 검증 (B_axis = μ₀nI · g(z))

solver: `hexa-lang/stdlib/em_getdp` (GetDP wrapper) + `rtsc/getdp_hts.py` (HTS coil)

cross-link:
- UFO/cloak (Phase B sub-axis · TBD) — EM 가시성 차단 layer
- CERN.md — 자장/입자 substrate
- RTSC.md — Meissner 자석 carrier

## 5. 추진 layer — Stage matrix integration

UFO Stage-1~7 추진 ladder 의 **추력/I_sp/효율** 통합 sim — Stage 별 verify 라벨 차이 (실설계 vs falsifier-only).

| Stage | 추진 메커니즘 | formulation | tier | 흡수 자산 |
|-------|--------------|-------------|------|----------|
| 1 hover | Meissner 부상력 | F_lev = ∇(B²/2μ₀)·V | 🟢 (실설계) | RTSC |
| 2 cruise | MHD 추진 | F = ∫J×B dV | 🟢 (실설계) | FUSION |
| 3 orbital | γ-rocket I_sp | I_sp = c·η_anti | 🟢 (실설계) | ANTIMATTER |
| 4 warp | Alcubierre δ=1/σ | ds² = -dt² + (dx-v_s f dt)² | ⚪ (falsifier-only) | hexa-ufo F-WARP |
| 5 wormhole | Morris-Thorne b₀=ℓ_Pl·σ | b(r)=b₀, Φ(r) | ⚪ (falsifier-only) | hexa-ufo F-WORM |
| 6 dim-jump | KK ladder 4D→26D | KK mode m_n=n/R | ⚪ (falsifier-only) | hexa-ufo F-DIM |
| 7 dim-use | τ=4 cycle | (σ−φ)²=100c composite | ⚪ (falsifier-only) | hexa-ufo F-USE |

핵심 falsifier (preregister 13 개) — Phase D 메타에서 닫힘 추적.

solver:
- Stage-1~3 → 각 carrier 도메인 stdlib (RTSC/FUSION/ANTIMATTER)
- Stage-4~7 → `~/core/hexa-ufo/{warp,wormhole,dimjump,dimuse}/` falsifier-only verify

## 6. 응력 + 열관리 layer — 구조 + 냉각

UFO 의 **구조 응력 + 냉각 sim** — 자석 quench 보호 + cryo loop 정상 상태.

### 6.1 응력 (FEA)

- Linear-elastic 1차 — frame · 자석 mounting bracket · skin
- Tsai-Wu 복합재 ply — CFRP skin 면압 안전계수
- Modal — 추진 vibration 공진 회피 (f_natural ≥ 2 × f_drive)

solver: `hexa-lang/stdlib/sim/fea` (예정) — Code_Aster · CalculiX wrapper

### 6.2 열관리 (cryo + radiator)

- **LN₂ 1차 loop** — 77K · RTSC pre-cool · 0.1 kW/m² 열속 한계
- **LHe 2차 loop** — 4.2K · HTS 자석 안정 · evaporation rate 모니터링
- **Radiator (vacuum)** — Stage-3+ 진공/우주 — Stefan-Boltzmann Q̇ = εσ_SB T⁴ A

formulation:
```
k∇²T = ρcṪ + q_source  (heat conduction · transient)
   q_radiative = εσ_SB(T⁴ - T_amb⁴)  (radiator boundary)
   ṁ_LN2 = Q̇ / h_fg  (cryo boil-off)
```

solver: `hexa-lang/stdlib/sim/heat_cryo` (예정) + RTSC 자석 quench 보호 link

## 7. cross-link

- **Source SSOT** — `~/core/hexa-ufo/HEXA-SIM.md` (679 LOC · n=6 멀티스케일 사양)
- **Source sidecar** — `~/core/hexa-ufo/HEXA-SIM.tape` (`@I id001 := "hexa_sim"`)
- **Source examples** — `~/core/hexa-ufo/hexa-sim/hexa-sim.md` (English mirror)
- **Code SSOT** — `~/core/hexa-lang/stdlib/sim/*` (예정 — cfd_ns · em_maxwell · fea · heat_cryo)
- **Carrier 자산** — RTSC (Stage-1) · FUSION (Stage-2) · ANTIMATTER (Stage-3) · CERN (자장/입자)
- **UFO 5 부수축** — hover (LANDED PR#183) · grav · cloak · teleport · **sim (본 manifest)**
- **거버넌스** — @D d1 (non-wet-lab → completed-form) · @D d3 (코드 SSOT 1곳) · @D d4 (single generic dispatch) · @D d10 (icon·name·alias 헤더)

## deferred

- [ ] hexa-lang/stdlib/sim/cfd_ns · em_maxwell · fea · heat_cryo 모듈 신설 (코드 SSOT 채움)
- [ ] verb-4 analyze ⟲ 통합 driver — 4축 매트릭스 generic dispatcher 구현 (@D d4)
- [ ] 13-falsifier preregister 매핑 — Stage-4~7 ⚪ falsifier-only 입력 형식 통일
- [ ] cross-domain 통합 ledger — Stage-1 (RTSC) + Stage-2 (FUSION) + Stage-3 (ANTIMATTER) record consume
