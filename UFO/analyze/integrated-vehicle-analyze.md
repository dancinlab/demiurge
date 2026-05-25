# 🛸 UFO — verb-4 analyze ⟲ · CFD+EM+응력+열 통합 분석 manifest

@title: 🛸 UFO — 통합 비행체(직접개발) · analyze ⟲
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/design/integrated-vehicle-design.md (verb-3 design · PR#195)
@sibling: UFO/structure/integrated-vehicle-structure.md (verb-2 structure · PR#190)
@sibling: UFO/sim/README.md (디지털트윈 sim 엔진 4축 매트릭스 · 6-layer stack · HEXA-SIM 흡수)
@verb: 4/7 (analyze ⟲) — demiurge 7-verb pipeline 네 번째 슬롯 (반복 수렴 ⟲)
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d7 (compute sizing) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-4 analyze ⟲** 슬롯을 채운다. verb-3 design 이 산출한 **closed-form 설계점 (§6 design→analyze 인계 set)** 을 입력으로, 4 물리 도메인 (CFD · EM · 응력 · 열) 의 **통합 sim 분석 계획 + 지배방정식 + 격자/수렴 기준 + 4-layer coupling ⟲ 반복 수렴 기준** 을 manifest 로 정의한다. **무거운 CFD/FEA 본해는 pool/cloud (@D d7) micro-exp 으로 위임 (deferred)** — 본 verb 는 analyze manifest (각 layer 의 지배방정식 · Re/격자 해상도 · residual 수렴 기준 · 기존 verified atom 인용) + sim 위임 sizing 만 닫는다. 구현 코드 없음 (@D d3) — UFO/analyze/ 는 docs/manifests only · 해석 코드 SSOT 는 `~/core/hexa-lang/stdlib/sim/{cfd,em,fea,heat_cryo}/`.

---

## 0. TL;DR — 4-layer 통합 analyze ⟲ (CFD ⟷ EM ⟷ 응력 ⟷ 열 coupling loop)

```
                  🛸 UFO — verb-4 analyze ⟲ 4-layer 통합 분석 coupling loop
   ──────────────────────────────────────────────────────────────────────────────
        verb-3 design closed-form 입력 set (§6 인계) → analyze ⟲ 반복 수렴 → verb-5
   ──────────────────────────────────────────────────────────────────────────────

            ┌───────────────[ ⟲ COUPLING LOOP ]────────────────┐
            │                                                    │
            ▼                                                    │
     ╭──────────────╮   부상력 분포     ╭──────────────╮          │
     │  ① CFD       │ ───────────────► │  ③ 응력 FEA   │          │
     │  Navier-     │   (LC-1 hover)   │  von Mises    │          │
     │  Stokes      │ ◄─────────────── │  650kg·SF2.5  │          │
     │  Re·C_d·L/D  │   air load        ╰──────┬───────╯          │
     ╰──────┬───────╯                          │ 변형→격자 갱신    │
            │ plasma σ_e                        ▼                  │
            │ (sheath)              ╭──────────────╮               │
            ▼                       │  ④ 열관리     │               │
     ╭──────────────╮  EM 발열 q'''  │  cryo+rad     │               │
     │  ② EM        │ ─────────────►│  LN₂·LHe·4K   │               │
     │  Maxwell     │               │  Q̇=εσT⁴       │               │
     │  B-field·J×B │ ◄─────────────│  T→ρ,σ_e,B_c  │               │
     │  Meissner    │   T 의존 물성   ╰──────────────╯               │
     ╰──────┬───────╯                                              │
            │ Lorentz F=J×B (추력 → 응력 LC-2/3)                    │
            └──────────────────────────────────────────────────────┘
                       수렴 기준: max(Δ_rel) < 1e-3 across all 4 layers (§5)
```

**4-layer 통합 analyze 요약 (5-line claim)**

| Layer | 물리 | 지배방정식 | 핵심 출력 | 기존 verified 인용 |
|-------|------|-----------|-----------|--------------------|
| ① CFD | 디스크 항공역학 | Navier-Stokes (compressible) | C_d · L/D · F_drag (Mach 0.5~25) | sim/README §3 cfd_ns · structure §1.2 L/D≥4 |
| ② EM | 자장 + 부상 | Maxwell-Ampère · Meissner | B-map · F_lift · F_MHD=J×B | RTSC `solenoid_axis_bz` 1.48265 T (PR#1084) · UFO Stage-1 `ioffe_loop_bz` 🟢×3 (PR#191) |
| ③ 응력 | 구조 FEA | linear-elastic · von Mises | σ_v ≤ σ_allow · SF 마진 (LC-1~5) | structure §5.2 σ_allow · §5.3 LC 카탈로그 |
| ④ 열 | cryostat 열부하 | k∇²T=ρcṪ · Q̇=εσ_SB T⁴ | heat leak · radiator A · cryo 안정 | structure §2.4 heat leak ≤10W · §2.5 radiator 25m² |
| ⟲ coupling | 4-layer 상호 | fixed-point 반복 | max(Δ_rel)<1e-3 수렴 | design §6 인계 set (입력 closed-form) |

> **정직 invariant (@D d1 · @D d6)**: 본 verb-4 는 **analyze 계획 + 수렴 기준 manifest** — 실제 무거운 본해 (compressible CFD · 6-coil 3D FEM · explicit dynamic FEA · transient cryo) 는 pool/cloud micro-exp 으로 **deferred** (§6). 어떤 sim 결과 값도 본 manifest 에서 산출/주장하지 않는다 (V3 무거운 sim 은 pool/cloud per @D d7 · ad-hoc python 금지). 기존 verified atom (RTSC getdp · UFO Stage-1 PR#191) 만 인용.

---

## 1. CFD layer — 디스크 항공역학 (Navier-Stokes)

verb-3 design §6.2 CFD 입력 set (OML D=6.0 m · H=1.6 m · AR=0.27 · MHD 채널 1.2×0.40×0.20 m · plasma σ_e≥10⁴ S/m) 를 소비. structure §1.2 의 L/D≥4 · C_d≤0.8 target 을 sim 으로 닫는 계획.

### 1.1 지배방정식 — compressible Navier-Stokes

```
연속      : ∂ρ/∂t + ∇·(ρv) = 0
운동량    : ρ Dv/Dt = -∇p + ∇·τ + ρg + F_body      F_body = J×B  (② EM coupling)
에너지    : ρ De/Dt = -p∇·v + ∇·(k∇T) + Φ_visc + q'''  (④ 열 coupling)
점성응력  : τ_ij = µ(∂v_i/∂x_j + ∂v_j/∂x_i − ⅔δ_ij ∇·v)
난류      : RANS k-ω SST (Mach 0.5~5) → DES/LES (Mach 5~25 shock-shaping)
```
- carrier: sim/README §2 `(cfd, analyze, Navier-Stokes compressible, hexa-lang/stdlib/sim/cfd_ns)` + `(cfd, analyze, RANS k-ω SST, cfd_rans)`
- F_body = J×B 항이 ② EM layer 의 Lorentz force 를 받는다 (⟲ coupling · §5)

### 1.2 Re 범위 + 비행 envelope (격자 sizing 입력)

| 구간 | Mach | 고도 | Re_D (D=6 m) | 모델 | 격자 해상도 (target) |
|------|------|------|--------------|------|---------------------|
| Stage-1 hover | 0~0.3 | 0~20 km | 10⁵~10⁷ | RANS k-ω SST | y⁺<1 wall · ~3M cell (2D axisym 가능) |
| Stage-2 cruise low | 0.5~5 | 20~80 km | 10⁶~10⁸ | RANS → DES | y⁺<1 · ~15M cell (3D half) |
| Stage-2 cruise high | 5~25 | 80~200 km | 희박 (Kn↑) | DSMC/슬립 보정 | shock-adaptive AMR ~30M cell |

- Re_D = ρ·v·D/µ · 고고도 (Stage-2 high) 는 연속체 가정 한계 → Knudsen Kn=λ/D 점검 · 슬립/DSMC 보정 (deferred · §6)
- plasma sheath (cruise): σ_e≥10⁴ S/m → MHD drag-reduction + EM 흡수 (② EM ⟷ ① CFD coupling)

### 1.3 수렴 기준 (residual)

| 항목 | 수렴 기준 | 비고 |
|------|-----------|------|
| 연속/운동량 residual | RMS < 1e-6 | scaled residual |
| 적분량 (C_d · C_l · L/D) | Δ_rel < 1e-4 over 500 iter | 적분 모니터 plateau |
| y⁺ (wall-adjacent) | < 1 (SST low-Re) | 경계층 해상 확보 |
| 격자 독립성 (GCI) | Richardson GCI < 3% | coarse/medium/fine 3-mesh |

### 1.4 기존 verified 인용 + 산출 target (sim 의무)

- target (structure §1.2): L/D ≥ 4 (Mach 0.5~5) · C_d ≤ 0.8 (Mach 5~25) — **본 verb 에서 sim 으로 산출하지 않음 · pool/cloud micro-exp deferred (§6)**
- caveat (@D d2): lenticular 디스크의 high-Mach C_d 는 shock-shaping 의존 → DES/LES 본해 필요 (deferred) · "고-Mach 비행 불가" framing 금지 — breakthrough path = shock-adaptive AMR + plasma MHD drag-reduction

---

## 2. EM layer — 자장 (Maxwell · RTSC 솔레노이드 · Meissner 부상)

verb-3 design §6.1 EM 입력 set (솔레노이드 NI=1.2e6 At · a/b/h=0.20/0.30/0.60 m · B_center 1.48 T · 6-slot 60° array r=2.4 m · Penning/Ioffe trap B-map) 를 소비. **EM layer 의 핵심 closed-form 은 이미 RTSC/UFO Stage-1 에서 verified** — 본 verb 는 6-coil 3D superposition FEM (단일 코일 closed-form → 다중 코일 상호작용) 만 sim 위임.

### 2.1 지배방정식 — Maxwell-Ampère · Meissner

```
Ampère    : ∇×B = µ₀(J + ε₀ ∂E/∂t)          (자기준정적 → ∇×B = µ₀J)
Faraday   : ∇×E = −∂B/∂t
Gauss     : ∇·B = 0 · ∇·E = ρ_q/ε₀
Meissner  : B_inside = 0 · B_surface = B_appl·exp(−x/λ_L)   (London 침투깊이 λ_L)
부상력    : F_lift = (B²/2µ₀)·A_eff·η          (Maxwell stress · η=Meissner 효율)
Lorentz   : F_MHD = J×B (체적적분 ∫J×B dV)     → ① CFD F_body · ③ 응력 추력 부하
```
- carrier: sim/README §2 `(em, analyze, GetDP solenoid axisym, hexa-lang/stdlib/em_getdp)` + `(em, verify, Meissner exclusion London, rtsc/getdp_hts.py)`

### 2.2 기존 verified atom 인용 (재-verify 아님 · @D d5 invariant)

| atom | 값 | 소스 | 본 verb 역할 |
|------|----|------|-------------|
| `solenoid_axis_bz` B_z(0) | 1.48265 T @ NI=2e6 At | RTSC.md / FUSION PR#1084 · Wheeler Δ=−1.40% cross-check | 단일 코일 anchor (6-coil FEM 의 검증 baseline) |
| UFO Stage-1 `ioffe_loop_bz` 🟢×3 | SUPPORTED-NUMERICAL | UFO/verify/stage1-hover-fields.md · atlas `663698a0` · PR#191 | Meissner lift field 입력 (재-verify 아님) |
| Penning 3-freq invariance | \|Δ\|=0.0 exact | ANTIMATTER ⓷ · Brown–Gabrielse | Stage-3 trap B-map 파생 |
| `ioffe_trap_depth_k` | 0.35257 K | ANTIMATTER ⓺ `ioffe_*` 🟢×7 | trap depth (가둠 B-map) |

### 2.3 sim 위임 계획 (격자 + 수렴)

| sim 항목 | 입력 | 격자/수렴 기준 | 위임 |
|----------|------|----------------|------|
| 6-coil 60° array B-map | NI=1.2e6 At · r=2.4 m · 6 coil | getdp axisym→3D · far-field truncation 10× coil (FUSION PR#1095 lesson) · ‖ΔB‖<1e-4 T | pool/cloud (§6) |
| FEM vs Wheeler Δ 검증 | B_center 1.48 T target | Δ_rel < 2% (RTSC §4.2.1 on-axis 기준) | pool free dry-run → cloud |
| Meissner η (flux-pin vs Meissner force 비율) | A_eff=0.0150 m² · η=0.10 | London λ_L + Type-II pinning coupled FEM | pool/cloud (§6) deferred |

> **인용 invariant**: B_center≈1.48 T 는 RTSC verified atom 의 NI-scaling 인용 (design §1.2) — 본 verb 는 6-coil **상호작용** 만 FEM 위임. 단일 코일 closed-form 재-solve 금지 (이미 🟢).

---

## 3. 응력 layer — 구조 FEA (650 kg · SF=2.5 · LC-1~5)

verb-3 design §6.3 + structure §5 응력 budget 을 소비. F_lift_total=7,842 N (② EM 부상) · F_MHD_total=1.92e5 N (② EM 추력) 을 ③ 응력 입력 부하로 받아 von Mises σ_v 를 LC-1~5 에 대해 FEA 위임.

### 3.1 지배방정식 — linear-elastic + von Mises

```
평형      : ∇·σ + f_body = ρü          (정적: ü=0 · 동적: explicit dynamic)
구성      : σ = C:ε     (Hooke · C=강성 텐서)  ε = ½(∇u + ∇uᵀ)
von Mises : σ_v = √(½[(σ₁−σ₂)² + (σ₂−σ₃)² + (σ₃−σ₁)²])
안전계수  : SF = σ_allow / σ_v ≥ 2.5     (FAA Pt.25 base · structure §5.2)
복합재    : Tsai-Wu (CFRP ply) — F_i σ_i + F_ij σ_i σ_j ≤ 1
```
- carrier: sim/README §2 `(stress, analyze, Linear-elastic FEA, hexa-lang/stdlib/sim/fea)` + `(stress, analyze, Composite ply stress, fea_ply, Tsai-Wu)`

### 3.2 하중 케이스 (LC-1~5 · structure §5.3) + 재료 한계 (§5.2)

| LC | 가속 | 핵심 부하 | 해석 유형 | σ_allow 한계 (재료) |
|----|------|-----------|-----------|---------------------|
| LC-1 hover | 1 G sustain | 자석 부상 모멘트 + gyro reaction (F_lift 7,842 N) | static | CFRP 600 / Al 460 / Ti 880 / PC 150 MPa |
| LC-2 cruise | 3 G (10 min) | aero + MHD intake duct (F_MHD 1.92e5 N) | CFD+FEA coupled (⟲) | 동일 |
| LC-3 orbital boost | 9 G (5 s peak) | γ-rocket thrust + g-suit | dynamic | 동일 |
| LC-4 landing | 6 G impact | landing skid + frame 분포 | explicit dynamic | 동일 |
| LC-5 emergency abort | 12 G (3 s) | g-suit + 좌석 retention | dynamic | 동일 |

### 3.3 수렴 기준 (FEA)

| 항목 | 기준 | 비고 |
|------|------|------|
| 변위 residual (Newton) | ‖R‖/‖R₀‖ < 1e-6 | 비선형 시 |
| 메시 수렴 (응력 hot-spot) | Δσ_peak < 2% (h-refine) | stress singularity 회피 (fillet 모델) |
| SF 마진 | min SF ≥ 2.5 across LC-1~5 | rupture 마진 (structure §5.2) |
| 모달 (공진 회피) | f_natural ≥ 2× f_drive | 추진 vibration 0.1~200 Hz (sim/README §6.1) |

### 3.4 sim 위임 + breakthrough path

- LC-1~5 static/dynamic/explicit FEA → pool/cloud micro-exp (§6) deferred
- caveat (@D d2): LC-5 12 G abort 시 σ_v > σ_allow 발생 가능 → "구조 불가" framing 금지 · breakthrough path = (a) frame CFRP T1100 승격 (structure §5.4 · 10% 무게 감소 + 강성↑) (b) 국소 Ti-6Al-4V 보강재 (c) 좌석 stroking energy-absorber

---

## 4. 열관리 layer — cryostat 열부하 (LN₂/LHe · radiator · Stage 추진 발열)

verb-3 design §6.4 + structure §2.4/§2.5 냉각 budget 을 소비. ② EM (자석 ohmic/AC loss · γ-shield 2차 IR) + ① CFD (aero 가열) + Stage 추진 발열을 열원으로 받아 cryo loop 정상상태 + radiator 면적을 닫는 계획.

### 4.1 지배방정식 — heat conduction + radiation + cryo boil-off

```
전도      : k∇²T = ρc Ṫ + q'''          (transient · q'''=체적 발열원 ② EM)
복사      : Q̇_rad = εσ_SB(T⁴ − T_amb⁴)·A   (radiator 경계 · σ_SB=5.67e-8 W/m²K⁴)
cryo      : ṁ = Q̇ / h_fg                 (LN₂/LHe boil-off · h_fg=잠열)
부하 결합 : q''' = (자석 AC loss + γ-shield 2차 IR + aero 가열) → ③ 응력 (열응력)·② EM (B_c(T))
```
- carrier: sim/README §2 `(therm, analyze, Heat conduction + radiation, hexa-lang/stdlib/sim/heat)` + `(therm, analyze, Cryo radiator balance, heat_cryo, LN₂·LHe Q̇)`

### 4.2 냉각 IF budget (structure §2.4/§2.5/§5.3) + target

| 냉각 IF | Stage | 온도 | 열부하 (target) | sim 의무 |
|---------|-------|------|----------------|---------|
| LHe loop | Stage-1 솔레노이드 | 4.2 K | heat leak ≤ 10 W (MLI + 진공자켓 5 cm) | MLI 층수 · 진공 conduction sim |
| heat-pipe → top radiator | Stage-2 MHD | ambient | plasma 열부하 → 25 m² radiator | Q̇=εσT⁴ 면적 검증 |
| active He cryocooler | Stage-3 trap | 4 K UHV | γ-shield 2차 IR (DU 3cm+W 1cm+B₄C 2cm) | 흑체복사 부하 |

### 4.3 온도-물성 coupling (⟲ feedback)

- T → ② EM: HTS B_c(T) 한계 · σ_e(T) 전도도 (cruise plasma) · Meissner λ_L(T)
- T → ③ 응력: 열응력 σ_thermal = E·α·ΔT (cryo ↔ ambient 경계 4.2K→300K gradient) · cryo-fatigue (Ti mount)
- T → ① CFD: ρ(T) · µ(T) 물성 (compressible NS 온도 의존)

### 4.4 수렴 기준 + breakthrough path

- 정상상태: max\|Ṫ\| < 1e-3 K/s · energy balance closure |Q̇_in − Q̇_out|/Q̇_in < 1e-3
- caveat (@D d2): radiator 25 m² 가 plasma 열부하 부족 시 → "냉각 불가" framing 금지 · breakthrough path = (a) cryostat dewar 통합화 (design §6 deferred · 8% 무게 + 공유 냉량) (b) 전개형 radiator (deployable fin) (c) 상변화 열저장 (PCM) buffer

---

## 5. ⟲ coupling — 4-layer 상호작용 반복 수렴

본 verb 가 "analyze ⟲" 인 이유 = 4 layer 가 **단방향이 아니라 상호 결합** → fixed-point 반복으로 수렴시켜야 한다. design §6 인계 closed-form 을 초기값으로 4-layer 를 한 바퀴 돌리고, 갱신된 부하/물성을 재투입하는 ⟲ 루프.

### 5.1 coupling 항 매트릭스 (방향성)

| from → to | coupling 항 | 물리 | 영향 layer |
|-----------|-------------|------|-----------|
| ② EM → ④ 열 | 자석 AC loss · ohmic q''' → 열원 | EM 발열 → 열 | §4.1 q''' |
| ② EM → ③ 응력 | F_lift · F_MHD=J×B → 구조 부하 | 추력 → 응력 | §3.2 LC-1/2/3 |
| ② EM → ① CFD | F_body=J×B (plasma) · Meissner 부상 | 부상 → CFD F_body | §1.1 F_body |
| ① CFD → ③ 응력 | aero 압력 분포 → 표면 하중 | air load → 응력 | §3.2 LC-2 |
| ① CFD → ④ 열 | aero 가열 (high-Mach 정체점) | 가열 → 열 | §4.1 q''' |
| ④ 열 → ② EM | T → B_c(T) · σ_e(T) · λ_L(T) | 물성 온도 의존 | §4.3 |
| ④ 열 → ③ 응력 | 열응력 σ=E·α·ΔT (cryo gradient) | 열변형 → 응력 | §4.3 |
| ③ 응력 → ① CFD | 구조 변형 → OML 격자 갱신 (FSI) | 변형 → 형상 | §1 격자 갱신 |

### 5.2 ⟲ 반복 수렴 기준 (fixed-point)

```
초기값  : design §6 인계 closed-form (B_center 1.48 T · F_lift 7,842 N · F_MHD 1.92e5 N · heat leak ≤10 W)
반복 k  : ① CFD(v,p) → ② EM(B,J) → ③ 응력(σ,u) → ④ 열(T) → 갱신 부하·물성 재투입
수렴    : max over all layers ( ‖X_k − X_{k−1}‖ / ‖X_k‖ ) < 1e-3   (relative)
         X ∈ {C_d, B_map, σ_v, T-field}
완화    : under-relaxation ω=0.5~0.7 (강결합 EM↔열 안정화)
발산 시 : staggered → monolithic coupling 승격 (breakthrough path · @D d2)
```

### 5.3 per-LC coupling 적용 (어느 LC 가 어느 coupling 을 켜는가)

| LC | 켜지는 coupling | 비고 |
|----|-----------------|------|
| LC-1 hover | ② EM → ③ 응력 (부상 모멘트) · ② EM → ④ 열 (자석 loss) | 정적 약결합 |
| LC-2 cruise | 전 8 coupling (① CFD ⟷ ② EM ⟷ ③ ⟷ ④ full ⟲) | 강결합 — monolithic 후보 |
| LC-3 orbital | ② EM(γ-rocket) → ③ · ④ (γ-shield IR) | 동적 |
| LC-4 landing | ① CFD(skid 충격 무시) · ③ explicit dynamic | 구조 주도 |
| LC-5 abort | ③ dynamic · ④ (g-suit 열) | 구조 주도 |

> **정직 (@D d6)**: 본 §5 는 coupling **계획 + 수렴 기준** 만 정의 — 실제 fixed-point 반복 본해는 pool/cloud micro-exp (§6) 위임. 어떤 수렴 결과 값도 본 manifest 에서 주장하지 않는다.

---

## 6. sim 위임 계획 — pool/cloud micro-exp (@D d7 · deferred)

무거운 4-layer 본해는 **pool/cloud micro-exp 으로 위임** (@D d7 compute sizing · @D d16 free dry-run → @D d17 autonomous fire). 본 verb 는 sizing + 위임 plan 만 닫는다 (V3 무거운 sim = pool/cloud · ad-hoc python 금지 · sim 은 `.hexa` only).

### 6.1 compute sizing (격자 cell / DOF / method scaling · @D d7/d11)

| sim | 규모 (격자/DOF) | method scaling | @D d7 라우팅 | 1차 dry-run |
|-----|-----------------|----------------|--------------|-------------|
| ① CFD hover (2D axisym) | ~3M cell | RANS O(N) | pool ubu-1/2 (idle-only · @D d18) | 1-iter free dry-run (@D d16) |
| ① CFD cruise (3D DES) | ~15–30M cell | DES O(N log N) | GPU pod (vast.ai first · @D d7/d17) | coarse mesh validate |
| ② EM 6-coil FEM | ~1–5M DOF (axisym→3D) | FEM O(N^1.5) | pool free (getdp) → cloud if 3D dense | getdp 1-iter pool |
| ③ 응력 FEA LC-1~5 | ~0.5–2M DOF | linear O(N), explicit O(N·Δt) | pool free (linear) · cloud (explicit dynamic) | static LC-1 pool |
| ④ 열 cryo transient | ~0.5M DOF | transient O(N·steps) | pool free | steady-state pool |
| ⟲ full coupling (LC-2) | 위 합산 ×k iter | fixed-point ×5–10 | GPU pod (강결합) | staggered 1-pass |

### 6.2 위임 워크플로 (@D d16 → @D d17)

```
1. deck 작성 (.hexa · stdlib/sim/* 호출)        — UFO/analyze 는 manifest only
2. pool free 1-iter dry-run (@D d16)             — 격자/directive/물성 syntax 검증
3. 검증 통과 → cost 1-line + autonomous fire (@D d17)  — vast.ai first · runpod fallback
4. 🛰️ Monitor (pw.x/ph.x alive-check)            — micro-exp skill 패턴
5. JOB DONE → harvest + down + parse Agent        — exports/sweep/<batch>/
6. 🟢 → atlas register (verify-delegation · embedded.gen.hexa fold)
```

### 6.3 위임 invariant

- 코드 SSOT (@D d3): `~/core/hexa-lang/stdlib/sim/{cfd_ns,cfd_rans,em_maxwell,em_getdp,fea,fea_ply,heat,heat_cryo}/` — UFO/analyze/ 에 실행 코드 0줄
- single generic dispatch (@D d4): sim/README §2 의 `(domain, verb, formulation, solver)` 4축 매트릭스를 generic engine 으로 통과 · layer/LC 이름 hardcoding 금지
- Stage-4~7 = analyze 입력 **없음** (falsifier-only · design §4 상속 · 실설계/sim 없음)

---

## 7. analyze→synthesize 인계 + cross-link + deferred

### 7.1 analyze→synthesize 인계 (verb-5 가 소비할 분석 산출 schema)

verb-5 synthesize (BOM + 도면 + firmware) 가 소비할 **analyze 산출 schema** (값은 §6 sim 위임 후 채워짐):

| analyze 산출 | synthesize 소비 | 상태 |
|--------------|-----------------|------|
| C_d · L/D map (Mach 0.5~25) | OML 형상 동결 · 항력 BOM 마진 | sim 위임 (§6) deferred |
| 6-coil B-map · F_lift 분포 | 솔레노이드 BOM (N·I·도체 길이) · cryostat 사양 | sim 위임 deferred · anchor=RTSC verified |
| σ_v · SF 마진 (LC-1~5) | frame 재료/두께 BOM · 보강재 도면 | sim 위임 deferred |
| heat leak · radiator A | cryo loop BOM · radiator 도면 · MLI 층수 | sim 위임 deferred |
| ⟲ 수렴 design point | firmware 제어 게인 (6-DOF · FBW Kalman) | sim 위임 deferred |

### 7.2 cross-link

| 대상 | 파일 | 역할 |
|------|------|------|
| UFO design (verb-3) | `UFO/design/integrated-vehicle-design.md` | §6 design→analyze 인계 closed-form 입력 set |
| UFO structure (verb-2) | `UFO/structure/integrated-vehicle-structure.md` | OML · 5 bay · 솔레노이드 array · LC-1~5 · σ_allow |
| UFO sim 엔진 | `UFO/sim/README.md` | 디지털트윈 4축 매트릭스 · 6-layer stack (solver SSOT 포인터) |
| RTSC (EM SSOT) | `~/core/demiurge/RTSC.md` | `solenoid_axis_bz` 1.48265 T · Wheeler Δ=−1.40% · getdp axisym |
| FUSION (MHD SSOT) | `~/core/demiurge/FUSION.md` | MHD F=J×B · tf_peak_field · getdp far-field truncation lesson (PR#1095) |
| ANTIMATTER (trap SSOT) | `~/core/demiurge/ANTIMATTER.md` | Penning invariance · Ioffe trap depth 0.35257 K |
| UFO Stage-1 verify | `UFO/verify/stage1-hover-fields.md` | `ioffe_loop_bz` 🟢×3 · atlas `663698a0` (PR#191) — EM lift 인용 |
| stdlib 코드 SSOT | `~/core/hexa-lang/stdlib/sim/{cfd,em,fea,heat_cryo}/` | 해석 코드 home (@D d3) |

### 7.3 deferred (verb-4 sim 본해 · pool/cloud micro-exp)

- [ ] ① CFD hover 2D axisym RANS (C_d · L/D · y⁺<1) — pool ubu free dry-run → 본해 (§6.1)
- [ ] ① CFD cruise 3D DES (Mach 0.5~25 C_d ≤ 0.8 · shock-adaptive AMR) — GPU pod (vast.ai)
- [ ] ② EM 6-coil 60° array B-map FEM (single-coil closed-form → 다중 상호작용 ‖ΔB‖<1e-4 T) — getdp pool→cloud
- [ ] ② EM flux-pinning force vs Meissner force 비율 정량 (Type-II λ_L coupled) — design §6 deferred
- [ ] ③ 응력 LC-1~5 FEA (650 kg · SF=2.5 · 1/3/9/6/12 G · von Mises) — pool linear → cloud explicit dynamic
- [ ] ④ 열 cryo transient + radiator 25 m² Q̇=εσT⁴ 검증 — pool steady → transient
- [ ] ⟲ full coupling LC-2 cruise fixed-point (staggered → monolithic 승격 if 발산) — GPU pod
- [ ] MHD 채널 effective thrust (duct 효율 + plasma 손실 vs 이상화 1.92e5 N 상한) — ① CFD ⟷ ② EM coupled
- [ ] HEXA-CLOAK overlay EM 성능 (RCS · plasma sheath 간섭) — ② EM (structure §1.3 cross-link)
- [ ] cryostat dewar 통합 trade (자석 4.2K ↔ trap 4K · 8% 무게) — ④ 열 trade study
- [ ] 🟢 atlas register (sim 본해 verified atom → embedded.gen.hexa fold · verify-delegation)

---

## 마감

- **author**: UFO domain verb-4 analyze ⟲ milestone (PR pending — pr-cycle 훅 stamp)
- **base ref**: `origin/main` (d8d981b · verb-3 design PR#195 LANDED)
- **branch**: `feat/ufo-verb4-analyze`
- **prev verb**: verb-3 design LANDED (PR#195) · verb-2 structure (PR#190) · verb-1 spec (PR#187)
- **next verb**: verb-5 synthesize — BOM + 도면 + firmware (§7.1 analyze 산출 schema 소비, §6 sim 위임 채워진 후)
- **governance**: @D d1 (비-wet-lab → completed-form) · d3 (stdlib SSOT · UFO/analyze 코드 0줄) · d4 (single generic dispatch · 4축 매트릭스) · d7 (compute sizing · pool/cloud 위임) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)
- **정직 invariant**: 본 verb-4 = analyze 계획 + 수렴 기준 manifest · 무거운 본해 (CFD/FEA/cryo) 는 pool/cloud micro-exp deferred (§6 · @D d7) · 기존 verified atom (RTSC getdp · UFO Stage-1 PR#191) 만 인용 · 새 무거운 sim 본 verb 에서 실행 0
