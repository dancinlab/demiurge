# 🛸 UFO — verb-2 structure · 통합 비행체 구조 정의

@title: 🛸 UFO — 통합 비행체(직접개발) · structure
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/spec/integrated-vehicle-spec.md (verb-1 spec · PR#187)
@verb: 2/7 (structure) — demiurge 7-verb pipeline 두 번째 슬롯
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-2 structure** 슬롯을 채운다. verb-1 spec 이 명세한 1인승 통합 비행체의 **외형 OML + 내부 구획 + 자석 어셈블리 + Stage-1~7 모듈 인터페이스 + 구조 응력 budget** 5개 축을 docs/manifests-only 로 정의한다. 구현 코드 없음 (@D d3) — 모든 CFD/FEA/EM 계산은 `~/core/hexa-lang/stdlib/` SSOT, UFO/structure/ 는 docs/manifests only.

---

## 0. TL;DR — 외형 + 내부 + 자석 + stage 인터페이스 ASCII

```
                            🛸 UFO — 1인승 통합 비행체 STRUCTURE (verb-2)
   ──────────────────────────────────────────────────────────────────────────────────
                              ▲ z (yaw 축, 0~+H/2)
                              │
                              │           디스크 OML (직경 D=6.0m · 두께 H=1.6m)
            ╭─────────────────┴─────────────────╮
            │  ┌────────[AVIONICS RACK]─────┐   │   ← top dome (canopy + sensor mast)
            │  │  HUD · IMU x2 · FBW · BMS  │   │     cone-tail 없음 (대칭 lenticular)
            │  └────────────────────────────┘   │
            │  ┌────────[CABIN 1.8×1.2m]────┐   │   ← 조종사 1명 · 좌석 reclining
            │  │  LSS 12h · LCG · canopy    │   │     EM-cloak overlay (HEXA-CLOAK)
            │  └────────────────────────────┘   │
            │ ┌─[MAGNET BAY]────┬─[POWER BAY]┐  │   ← 자석실 (LN₂/LHe cryostat) +
            │ │ RTSC 솔레노이드 × │ Stage-1~3   │  │     동력실 (Stage-1~3 module bay)
            │ │ 6 (vertical lift)│ module rack │  │     Stage-4~7 = falsifier-only
            │ │ + gyro mount × 3 │ + heat-pipe │  │     (formal slot, no hardware)
            │ │ + flux-pin array │ + EM-shield │  │
            │ └──────────────────┴─────────────┘  │
            │       ┌─[LSS BAY]──────────┐        │   ← O₂ PSA · CO₂ scrub · H₂O loop
            │       │  PSA · LiOH · H₂O  │        │     · UCD · LCG return
            │       └────────────────────┘        │
            ╰─────────────────┬───────────────────╯
                              │  ▼ −z (landing skid + RTSC lift surface)
                              ▼   직경 D=6.0 m / 두께 H=1.6 m / AR=H/D=0.27
                                  (lenticular 양볼록 — Mach 0~25 stage 1-2 envelope)

   STAGE 인터페이스 mount map (외주 등각도 배치, 60° 간격 6슬롯)
       ┌─ Stage-1 hover (RTSC 48T) ─ 6슬롯 모두 · structural primary
       │  Stage-2 cruise (FUSION MHD) ─ slot 1·4 (대각 페어) · ducted intake
       │  Stage-3 orbital (γ-rocket) ─ slot 2·5 (대각 페어) · γ-shield 4π sr
       │  Stage-4~7 (warp/wormhole/dim) ─ slot 3·6 falsifier-only formal mount
       └─ jet trim (cold-gas) ─ 6 슬롯 모두 (자세제어 backup, §3.x of spec)
```

**structure 요약 (5-line claim)**

| key | value | 근거/cross-link |
|-----|-------|-----------------|
| 외형 (OML) | 디스크 lenticular · D=6.0 m · H=1.6 m · AR=0.27 | §1 |
| 내부 구획 | 5 bay (cabin · LSS · magnet · power · avionics) | §2 |
| 자석 어셈블리 | RTSC 솔레노이드 × 6 (60° 간격) + gyro × 3 + flux-pin array | §3 |
| stage 인터페이스 | 6 슬롯 등각 mount · Stage-1~3 실설계 · 4~7 falsifier-only | §4 |
| 응력 budget | total m=650 kg · safety factor 2.5 (FAA Pt.25 base) | §5 |

---

## 1. 외형 (frame OML) — 디스크 lenticular

### 1.1 형상 — lenticular 양볼록 디스크

| 항목 | 값 | 비고 |
|------|----|------|
| 외경 D | 6.0 m | hover stability + cruise lift balance |
| 두께 H | 1.6 m | cabin + magnet + power bay 수직 stack |
| 종횡비 AR=H/D | 0.27 | 양볼록 · cone-tail 없음 |
| 대칭축 | z-축 (수직) · 회전대칭 | yaw 자세 자유, gyro CMG 친화 |
| 표면 곡률 | top/bottom dome · R_top=8.0 m · R_bot=10.0 m | 비대칭 (lift bias top) |
| 가장자리 | 1.0 m 반경 회전체 fillet | edge vortex 완화 · radar return 분산 |

### 1.2 항공역학 — Stage-1 hover · Stage-2 cruise

| 영역 | 메커니즘 | 정량 (target) | 근거 |
|------|---------|---------------|------|
| Stage-1 hover (0~20 km) | RTSC Meissner 부상 · OML 의 lift는 보조 | F_lift ≥ m·g (자석 우선) | spec §2 Stage-1 |
| Stage-2 cruise (Mach 0.3~25) | top/bot 비대칭 + 회전 양력 (선택) · plasma sheath MHD | L/D ≥ 4 (Mach 0.5~5 envelope) | spec §2 Stage-2 |
| 천이 (hover→cruise) | 자석 thrust vector + ducted MHD intake spool-up | Δt < 30 s | spec §2.1 state machine |
| 항력 (Stage-2 high-Mach) | lenticular shock-shaping + plasma MHD drag-reduction | C_d ≤ 0.8 (Mach 5~25 추정) | downstream CFD verify (verb-4) |

### 1.3 radar / EM 가시성 — caveats

- **lenticular 디스크**의 자연적 RCS 는 정면/측면 모두 큰 편 (디스크 → 정면 = 큰 평면 반사). 본 verb-2 structure 는 **HEXA-CLOAK overlay** (UFO/CLOAK.md · UFO/HEXA-CLOAK.md) 를 OML 외피에 적층 가정 — manifest cross-link only, 실제 EM cloak 성능은 verb-4 analyze ⟲ 슬롯에서 시뮬 검증 의무.
- **plasma sheath (Stage-2)**: cruise 시 OML 외피에 plasma layer 생성 → EM 흡수 영향. caveat = HEXA-CLOAK 의 dielectric metasurface 와 plasma layer 간섭은 downstream 시뮬 의무.
- **IR signature**: γ-rocket (Stage-3) 운용 시 γ-shield 의 2차 흑체복사. caveat = Stage-3 mount slot 2·5 (대각) 의 γ-shield 4π sr coverage 명세 (§4.3).

> @D d2 — radar cross-section 의 wet-lab 측정은 wet-lab 단계 의무 / 본 verb-2 는 manifest-only. 비-wet-lab 검증 경로 (CFD/EM 시뮬) 는 verb-4 analyze ⟲ 슬롯에서 닫는다.

---

## 2. 내부 구획 — 5 bay layout

### 2.1 구획 매트릭스 (top → bottom 수직 stack)

| Bay | 위치 (z 축, m) | 점유 m³ | 무게 (kg) | 핵심 sub-system | cross-link |
|-----|----------------|---------|-----------|-----------------|------------|
| AVIONICS rack | +0.5 ~ +0.8 (top) | 0.3 | 45 | HUD · IMU × 2 · FBW · BMS · GNSS | spec §3 자세제어 |
| CABIN | +0.0 ~ +0.5 (mid-top) | 2.16 | 80 | 좌석 · canopy · LCG · LSS interface | spec §1 페이로드 |
| MAGNET bay | −0.4 ~ +0.0 (mid) | 5.4 | 120 | RTSC 솔레노이드 × 6 · gyro CMG × 3 · flux-pin | §3 자석 어셈블리 |
| POWER bay | −0.6 ~ −0.4 (mid-low) | 2.2 | 150 | Stage-1~3 module rack · heat-pipe · EM-shield | §4 stage 인터페이스 |
| LSS bay | −0.8 ~ −0.6 (bottom) | 1.5 | 80 | O₂ PSA · CO₂ LiOH · H₂O loop · UCD · LCG return | spec §1.2 LSS |
| **frame 자체** | 외피 + 격벽 | — | 180 | structural primary (CFRP + Al honeycomb) | §5 응력 budget |
| **합계** | — | ~11.6 | **650** | — | §5 |

### 2.2 캐빈 (조종사 1.8 × 1.2 × 1.0 m) — spec §1 인용

- **좌석**: reclining 30° (g-tolerance 향상 · Mach 25 cruise 인체 보호)
- **canopy**: polycarbonate 5cm + HEXA-CLOAK overlay (UFO/CLOAK.md cross-link)
- **시야**: 180° 전방 · AR HUD 오버레이 (spec §1.3)
- **압력/온도**: 0.7 atm · 18~24 °C (spec §1.3) — LSS bay 와 ducted return loop

### 2.3 LSS bay — 12h 자급 (spec §1.2 인용)

| 모듈 | 점유 (L) | 무게 (kg) | 비고 |
|------|---------|-----------|------|
| O₂ PSA (zeolite mol-sieve) | 200 L tank + 30 L sieve | 25 | 99.5% pure · 0.84 kg/12h |
| CO₂ scrub (LiOH primary) | 60 L canister | 12 | 1.6 kg LiOH · backup zeolite swing |
| H₂O loop (closed 60% recovery) | 80 L total (drink + condensate) | 18 | 3.6 L/12h net |
| ration + UCD/FCS | 20 L stowage | 8 | 3000 kcal + 12h waste cap |
| LCG return loop | 30 L coolant | 12 | 100~150 W metabolic load |
| HVAC + valve manifold | 50 L 공간 | 5 | dual redundant fans |
| **LSS bay 소계** | ~470 L | **80** | spec §1.2 LSS 12h |

### 2.4 자석실 (cryostat 환경)

- **냉매 dewar**: LHe 추정 4.2K (Stage-1 hover 48T RTSC 운용 시) · 절환 LN₂ 77K (HTS proxy 시) — RTSC.md axis-B (HTS REBCO 77K) cross-link
- **단열**: 다층 절연 (MLI) + 진공 자켓 5cm — heat leak ≤ 10 W (target, verb-4 시뮬 의무)
- **자기 차폐**: Mu-metal liner 1cm — cabin / avionics 영역 B_field ≤ 0.5 mT 유지

### 2.5 동력실 (Stage-1~3 module bay)

- **layout**: 외주 60° 간격 6 slot (§4 매트릭스) · 중심부 = 자석실 (자석이 lift primary)
- **벽 격벽**: 진동 isolation (rubber-bushing + active damper, 0.1 ~ 200 Hz)
- **냉각 IF**: heat-pipe → top dome radiator (디스크 외피 외측, 표면적 25 m²)
- **EM-shield**: Faraday cage (Al 1mm + Mu-metal liner) — RTSC magnetic bay 와 의 cross-talk 차단

### 2.6 avionics rack (top dome)

- **IMU × 2**: FOG primary + RLG backup (spec §3.2)
- **FBW (fly-by-wire)**: triplex redundant · 30-state Kalman (gyro + jet + EM trim 통합)
- **BMS (battery management)**: 28V DC LSS bus + 400V DC stage bus dual
- **GNSS**: 다중 constellation (GPS/Galileo/BeiDou/GLONASS) · INS aiding 의무
- **HUD**: AR canopy overlay (spec §1.3) · stage status + falsifier dashboard

---

## 3. 자석 어셈블리 — RTSC 솔레노이드 array + gyro mount + flux-pin

### 3.1 RTSC 솔레노이드 배치 — 6 슬롯 등각 array

| 슬롯 | 방위각 (deg) | 솔레노이드 축 방향 | 1차 역할 |
|------|--------------|-------------------|---------|
| S1 | 0° | z (vertical) | lift primary (Stage-1) |
| S2 | 60° | z | lift primary |
| S3 | 120° | z | lift primary |
| S4 | 180° | z | lift primary |
| S5 | 240° | z | lift primary |
| S6 | 300° | z | lift primary |

- **배치**: 외주 반경 r = 2.4 m (디스크 외경 6.0 m, 중심부 = 자석실 코어 1.0 m + 외주 array 1.4 m envelope)
- **수직 부상력 (target)**: F_lift_total = 6 × F_lift_per_solenoid ≥ m·g = 650 × 9.8 = 6,370 N
- **closed-form** (per RTSC.md Wheeler on-axis B): F_lift = (B²/2µ₀) · A · 효율계수 — verb-3 design 슬롯에서 sizing
- **6-DOF stiffness**: 6 솔레노이드의 current independent 제어 → roll/pitch/yaw + x/y/z 6-DOF active 제어 가능 (Earnshaw bypass via active feedback, UFO/hover/README.md cross-link)
- **redundancy**: 1슬롯 fail 시 5슬롯으로 hover 유지 (single-failure FAA Pt.25 base)

### 3.2 gyro CMG mount × 3

| 축 | mount 위치 | 각운동량 (target) | source |
|----|-----------|-------------------|--------|
| roll | r=1.2 m · 90° | H_roll ≥ 500 N·m·s | spec §3.1 |
| pitch | r=1.2 m · 210° | H_pitch ≥ 500 N·m·s | spec §3.1 |
| yaw | 중심 z 축 | H_yaw ≥ 500 N·m·s | spec §3.1 |

- **mount 구조**: 진동 isolation bushing (Stage-2 cruise vibration spectrum 0.1~200 Hz 흡수)
- **gimbal range**: ±60° each axis · driven by torque motor + position encoder
- **failure mode**: 1축 fail → 2축 + EM trim coil 으로 자세 유지 (spec §3.1 redundancy 2x)

### 3.3 flux-pinning array — Type-II SC pinning

- **배치**: 디스크 하부 외주 (z = −0.8 m, r = 2.6~3.0 m) · 8 슬롯 등각 (45° 간격)
- **재료**: Type-II HTS REBCO bulk puck (cross-link: RTSC.md axis-B HTS REBCO)
- **역할**: 지면 안내 레일 (수평 alignment) + Earnshaw bypass (수직 stability 추가 마진)
- **상호작용**: Stage-1 솔레노이드의 B-field 와 lock-in (flux-pinning force vs Meissner force 비율 → verb-4 analyze ⟲ 시뮬 의무)

### 3.4 자석 어셈블리 → 다른 도메인 cross-link

| cross-link 대상 | 인터페이스 | 흡수 status |
|-----------------|-----------|------------|
| RTSC.md (자석 SSOT) | Wheeler on-axis B closed-form · solenoid_axisym getdp | M318 cross-check 의무 (verb-3 design) |
| UFO/hover/README.md | Stage-1 hover Meissner 사양 흡수 (HEXA-HOVER 축 흡수 LANDED #183) | manifest cross-link |
| ~/core/hexa-lang/stdlib/em/ | EM 시뮬 코드 SSOT (@D d3) | downstream verb-3/4 호출 |

---

## 4. Stage 모듈 인터페이스 — Stage-1~7 mount 표

### 4.1 mount 매트릭스 (외주 6 slot 등각, S1~S6 방위각 §3.1 와 공유)

| Stage | 슬롯 | 무게 (kg) | 전원 IF | 냉각 IF | 진동 isolation | 비고 |
|-------|------|-----------|---------|---------|----------------|------|
| 1 hover | S1~S6 (전체 6) | 6 × 20 = 120 | 400V DC bus | LHe loop (4.2K) | active damper 0.1~200 Hz | RTSC 솔레노이드 array (§3.1) |
| 2 cruise | S1 + S4 (대각 페어) | 2 × 50 = 100 | 400V DC bus + plasma DC link | heat-pipe → top dome radiator | rubber bushing + tuned mass damper | FUSION MHD ducted intake; spec §4.2 |
| 3 orbital | S2 + S5 (대각 페어) | 2 × 30 = 60 | 28V DC pulsed | active He cryocooler | γ-shield 4π sr ($§4.3$) | ANTIMATTER γ-rocket; spec §4.3 |
| 4 warp | S3 (formal mount) | 0 (falsifier-only) | — | — | — | Alcubierre δ=1/σ; spec §4.4 |
| 5 wormhole | S3 (공유 formal) | 0 | — | — | — | Morris-Thorne; spec §4.4 |
| 6 dim-jump | S6 (formal mount) | 0 | — | — | — | KK ladder; spec §4.4 |
| 7 dim-use | S6 (공유 formal) | 0 | — | — | — | (σ−φ)² composite; spec §4.4 |
| **stage 합계** | — | **280** | — | — | — | Stage-1~3 실설계 only |
| jet trim | S1~S6 (전체 6) | 6 × 5 = 30 (이미 §5 frame/aux 에 포함) | 28V DC valve | N/A (cold-gas) | rigid mount | spec §3.1 backup |

### 4.2 전원 IF 표준 — single generic dispatch (@D d4)

- **전원 bus 2 종**: 28V DC (LSS · avionics · jet valve · IMU) + 400V DC (자석 · MHD · stage 추진)
- **dispatch**: instance = manifest only — stage 추가/변경/제거 = 본 §4.1 표 한 행 수정만 (per @D d4)
- **재구성**: 슬롯 재할당 = 본 §4.1 표 행 swap; 코드 변경 없음

### 4.3 γ-shield 4π sr — Stage-3 운용 시 의무

- **재료**: depleted uranium 3cm + W liner 1cm + B₄C neutron poison 2cm (총 두께 6cm, 무게 ≈ 80 kg, S2/S5 slot 내 통합)
- **coverage**: Stage-3 γ-rocket nozzle 방향 (외측 −z) 만 open · 다른 5π sr 모두 차폐
- **interface**: γ-flux monitor (ion-chamber) → BMS feedback · Stage-3 throttle cap 트리거

### 4.4 진동 isolation 등급 (3-tier)

| tier | 적용 | spec | 비고 |
|------|------|------|------|
| T1 (rigid) | jet trim · γ-shield · LSS valve | <0.1 mm clearance | cold-gas valve 의 즉응성 우선 |
| T2 (bushing) | gyro CMG · 자석 어셈블리 outer · stage-2 intake | rubber bushing · 0.1~10 Hz | 캐빈 진동 등급 ISO 2631 C 만족 |
| T3 (active) | stage-1~3 module · 자석 어셈블리 inner | active damper 0.1~200 Hz | feedback gain → verb-4 analyze ⟲ 의무 |

---

## 5. 구조 응력 budget — 650 kg total · safety factor 2.5

### 5.1 무게 (mass budget) — 합계

| 항목 | 무게 (kg) | 출처 |
|------|-----------|------|
| payload (조종사 + 좌석 + 개인 장구) | 120 | spec §1.1 (75 kg 조종사 + 45 kg 장구/좌석) |
| LSS (O₂/CO₂/H₂O/UCD/HVAC) | 80 | §2.3 |
| 자석 어셈블리 (RTSC 솔레노이드 × 6 + cryostat + gyro + flux-pin) | 120 | §3.1~3.3 |
| 동력원 (Stage-1~3 module 280 kg 중 자석 제외 추가 모듈 + jet trim 30 + γ-shield 80 → net 추가 ≈ 150) | 150 | §4.1, §4.3 |
| frame + 외피 (CFRP + Al honeycomb + canopy + 격벽) | 180 | §1.1 |
| **합계 m_total** | **650** | (점검: §2.1 표 sum = 80+45+120+150+180+80(LSS)−5=650) |

### 5.2 응력 / safety factor

| 영역 | 최대 응력 (target) | 허용 응력 σ_allow | safety factor | 근거 |
|------|-------------------|--------------------|---------------|------|
| frame 외피 (CFRP T700 quasi-isotropic) | ≤ 240 MPa | 600 MPa (rupture 1500 MPa / 2.5) | 2.5 | FAA Pt.25 base |
| 격벽 (Al 7075-T6) | ≤ 180 MPa | 460 MPa | 2.5 | FAA Pt.25 |
| 자석 mount (Ti-6Al-4V) | ≤ 350 MPa | 880 MPa | 2.5 | low cryo-fatigue |
| canopy (PC + EM-cloak) | ≤ 60 MPa | 150 MPa | 2.5 | bird-strike margin |

### 5.3 하중 케이스 (load cases)

| case | 가속 | 핵심 부하 | 검증 의무 |
|------|------|-----------|----------|
| LC-1: hover (Stage-1) | 1 G (sustain) | 자석 부상 모멘트 + gyro reaction | verb-4 analyze ⟲ FEA |
| LC-2: cruise (Stage-2) | 3 G (10 min) | aerodynamic + MHD intake duct | verb-4 analyze ⟲ CFD + FEA coupled |
| LC-3: orbital boost (Stage-3) | 9 G (5s peak) | γ-rocket thrust + g-suit | verb-4 analyze ⟲ FEA dynamic |
| LC-4: landing (skid impact) | 6 G (impact) | landing skid + frame 분포 | verb-4 analyze ⟲ FEA explicit |
| LC-5: emergency abort | 12 G (3s) | g-suit + 좌석 retention | verb-4 analyze ⟲ FEA dynamic |

> 본 verb-2 structure 는 무게 budget · 응력 표 · LC 카탈로그 **선언**만 닫는다. **응력 closed-form / FEA 시뮬 의무는 verb-4 analyze ⟲** 슬롯 (per @D d1, d3 — 구현 코드는 hexa-lang/stdlib/fea SSOT).

### 5.4 무게 마진 (margin) — verb-2 deferred

- **현재 m_total = 650 kg · safety factor 2.5** 는 baseline. verb-3 design / verb-4 analyze 단계에서 ±10% margin 추적 의무 (per @D d1).
- **추가 마진 path** (@D d2 wall-breakthrough 후보): (a) frame CFRP T1100 승격 (10% 무게 감소) · (b) cryostat dewar 통합화 (8% 무게 감소) · (c) 자석 솔레노이드 수 6→4 (lift 마진 trade-off 시뮬 의무).

---

## 6. cross-link

### 6.1 sibling demiurge 도메인

| 대상 | 파일 | 역할 |
|------|------|------|
| UFO spec (verb-1) | `UFO/spec/integrated-vehicle-spec.md` | 본 structure 의 사양 입력 (1인승 LSS · stage matrix · 자세제어 · 동력 IF) |
| UFO HEXA-UFO main spec | `UFO/HEXA-UFO.md` | HEXA-Disc 1890-LOC 아틀라스 — 7-stage ladder + 부수 5축 |
| RTSC (자석 SSOT) | `~/core/demiurge/RTSC.md` | Stage-1 자석 substrate (Meissner 48T solenoid · Wheeler on-axis B) |
| FUSION (Stage-2) | `~/core/demiurge/FUSION.md` | MHD intake/추진 |
| ANTIMATTER (Stage-3) | `~/core/demiurge/ANTIMATTER.md` | γ-rocket + Penning 3-freq |
| CERN (auxiliary) | `~/core/demiurge/CERN.md` | 자장 boundary cross-link |
| UFO/hover | `UFO/hover/README.md` | Meissner hover 사양 (HEXA-HOVER 흡수 LANDED) |
| UFO/sim | `UFO/sim/README.md` | 디지털트윈 sim engine (HEXA-SIM 흡수 LANDED) — verb-4 analyze ⟲ 가 호출 |

### 6.2 UFO/spec 와의 분담

| 슬롯 | spec (verb-1) | structure (verb-2, 본 문서) |
|------|---------------|------------------------------|
| 페이로드 1명 / 75 kg | 사양 명세 | 캐빈 envelope + 좌석 + LCG mount (§2.2) |
| 7-stage matrix | 고도/속도/동력원/전환 | mount slot 6 등각 + 무게/IF (§4.1) |
| 자세제어 (gyro/jet/EM) | 액추에이터 topology + IMU 사양 | gyro CMG mount × 3 + 진동 isolation tier (§3.2, §4.4) |
| 동력 IF (RTSC/FUSION/ANTIMATTER) | record schema + consumer 요구 | 전원/냉각 IF 표 + γ-shield (§4.1, §4.3) |

### 6.3 stdlib (구현 SSOT, @D d3)

- **CFD/EM/FEA 코드 home**: `~/core/hexa-lang/stdlib/{cfd,em,fea,heat_cryo}/` — UFO/structure/ 는 docs/manifests only
- **single generic dispatch**: instance = manifest only (@D d4) — 본 §4.1 / §3.1 표가 manifest, 코드는 어느 stage/slot 도 분기 없이 generic 으로 통과

### 6.4 verify 의무 (downstream verb 슬롯 위임)

| verify 항목 | 책임 verb | tier |
|-------------|-----------|------|
| 자석 closed-form (Wheeler on-axis B) | verb-3 design (RTSC.md 인용) | 🔵/🟢 |
| 응력 FEA (LC-1~5) | verb-4 analyze ⟲ | 🟢 |
| 무게 margin sweep | verb-4 analyze ⟲ | 🟢 |
| CFD (Stage-2 cruise drag) | verb-4 analyze ⟲ | 🟢 |
| EM cloak overlay 성능 | verb-4 analyze ⟲ (HEXA-CLOAK cross-link) | 🟠 → 🟢 promote 의무 |
| stage 전환 시퀀스 (state machine) | verb-6 verify | 🟢 |

본 verb-2 structure 자체는 manifest 이므로 closed-form verify 대상 아님 (verb-1 spec 과 동일). lattice 일관성 (n=6 σ·τ=48) 은 spec §verify 가 이미 선언.

---

## 마감

- **author**: UFO domain verb-2 structure milestone (PR pending — pr-cycle 훅이 다음 라운드에서 stamp)
- **base ref**: `origin/main` (18a0737)
- **branch**: `feat/ufo-verb2-structure`
- **prev verb**: verb-1 spec LANDED (PR#187)
- **next verb**: verb-3 design — closed-form 통합 설계 (stages 1-3 실설계 · 4-7 falsifier-only)
- **governance**: @D d1 (비-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)
