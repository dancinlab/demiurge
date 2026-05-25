# 🛸 UFO — verb-5 synthesize · BOM + 도면 + firmware 산출물 manifest

@title: 🛸 UFO — 통합 비행체(직접개발) · synthesize
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/analyze/integrated-vehicle-analyze.md (verb-4 analyze ⟲ · PR pending)
@sibling: UFO/design/integrated-vehicle-design.md (verb-3 design · PR#195)
@sibling: UFO/structure/integrated-vehicle-structure.md (verb-2 structure · PR#190)
@sibling: UFO/spec/integrated-vehicle-spec.md (verb-1 spec · PR#187)
@verb: 5/7 (synthesize) — demiurge 7-verb pipeline 다섯 번째 슬롯
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-5 synthesize** 슬롯을 채운다. verb-3 design 의 closed-form 설계점 + verb-2 structure 의 5-bay 디스크 구조 + verb-4 analyze 의 산출 schema 를 입력으로, **외부 제작소가 받아 제작을 시작할 수 있는 수준의 제작 산출물 명세** 3종 — ① BOM (부품표) · ② 도면 tree (조립 계층) · ③ firmware stack (제어 SW 아키텍처) — 와 ④ 제작 시퀀스(QA 게이트) 를 manifest 로 정의한다. **실 제작/부품 구매가 아닌 사양·명세** (@D d1 — 비-wet-lab 산출물의 completed-form). firmware 는 **아키텍처 명세** 이고 실제 제어 코드 SSOT 는 `~/core/hexa-lang/stdlib/` (@D d3) — UFO/synthesize/ 는 docs/manifests only · 구현 코드 0줄.

---

## 0. TL;DR — BOM + 도면 tree + firmware stack ASCII

```
                  🛸 UFO — verb-5 synthesize 제작 산출물 3종 + QA 시퀀스
   ──────────────────────────────────────────────────────────────────────────────
        verb-3 design closed-form + verb-2 structure 5-bay + verb-4 analyze schema
                              ↓ synthesize (제작 사양)
   ┌─────────────────┬─────────────────────┬──────────────────────────────────────┐
   │ ① BOM (부품표)   │ ② 도면 tree (조립)    │ ③ firmware stack (제어 SW)             │
   ├─────────────────┼─────────────────────┼──────────────────────────────────────┤
   │ frame CFRP       │ L0 vehicle           │  ┌──────── app layer ──────────┐      │
   │ RTSC 솔레노이드×6 │  └ L1 bay (×5)        │  │ 자세제어 Kalman 15-state     │      │
   │ cryostat (LHe/4K)│     └ L2 assembly     │  │ stage 전환 state machine     │      │
   │ MHD 채널×2        │        └ L3 part      │  │ 자석 PID 6-DOF · LSS 모니터  │      │
   │ Penning/Ioffe trap│  + 인터페이스 도면      │  │ 안전 인터록                  │      │
   │ LSS · avionics    │  (전원·냉각·구조 IF)   │  ├──── RTOS (DO-178C DAL-A) ──┤      │
   │ power · stage mod │                       │  │ scheduler · IPC · watchdog   │      │
   │                   │                       │  ├──── HAL (board support) ───┤      │
   │ 수량·재료·공급원   │                       │  │ ADC/DAC · CAN · cryo sensor  │      │
   │  카테고리·단가범위 │                       │  └──────────────────────────────┘      │
   └─────────────────┴─────────────────────┴──────────────────────────────────────┘
                              ↓ ④ 제작 시퀀스 (QA checkpoint G0~G7)
        부품 입고 → frame → bay 통합 → 자석 → 동력 → avionics → 통합검사 → 인계(verb-7)
   ──────────────────────────────────────────────────────────────────────────────
        Stage-1~3 = 실 제작 산출물 명세 · Stage-4~7 = formal mount only (제작 산출 없음)
```

**synthesize 산출물 요약 (5-line claim)**

| 산출물 | 핵심 내용 | 행/항목 수 | 입력 출처 | downstream 소비 |
|--------|----------|-----------|-----------|-----------------|
| ① BOM | 7 카테고리 부품표 (frame · 자석 · cryostat · LSS · avionics · power · stage) | ~32 line-item | design §0~3 · structure §2~5 | verb-7 handoff 제작소 |
| ② 도면 tree | L0→L3 조립 계층 + 인터페이스 도면 목록 | L0×1 · L1×5 · L2×~14 · L3×~40 | structure §2.1 5-bay · §4.1 mount | verb-6 디지털트윈 · verb-7 |
| ③ firmware stack | 3-layer (HAL/RTOS/app) · 5 제어 모듈 | 5 모듈 · 3 계층 | design §1.4 6-DOF · §5.4 전환 · analyze §5 coupling | verb-6 digital-twin SW-in-loop |
| ④ 제작 시퀀스 | 8 단계 + QA 게이트 G0~G7 | 8 step · 8 gate | structure §5.3 LC · analyze §3 FEA | verb-7 인증서류 |
| invariant | 제작 사양 명세 (실 제작 아님) · firmware = 아키텍처 (코드 = stdlib SSOT) | — | — | @D d1/d3/d4 |

> **정직 표기 (@D d1 · @D d3)**: 본 verb-5 = **제작 산출물의 사양 manifest** — 실제 부품 구매·가공·조립이 아니다. BOM 의 단가는 **추정 범위** (조달 견적 아님) · 도면 tree 는 **조립 계층 + 도면 목록** (CAD 파일 아님) · firmware 는 **아키텍처 명세** (실제 제어 코드 SSOT = hexa-lang/stdlib · @D d3). Stage-4~7 은 design §4 falsifier-only stance 상속 — formal mount slot 만 있고 **제작 산출물 없음**.

---

## 1. BOM (Bill of Materials) — 5-bay 부품표

verb-2 structure §2.1 의 5-bay layout (avionics · cabin · magnet · power · LSS) + frame + stage 모듈을 7 카테고리 부품표로 전개. 수량/재료/공급원 카테고리/추정 단가 범위 (조달 견적 아님 — sizing 기반 추정 · @D d1).

### 1.1 카테고리 A — frame + 외피 (180 kg · structure §1.1 / §5.1)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| A1 | 디스크 외피 패널 (top dome) | 1 set | CFRP T700 quasi-isotropic · R_top=8.0 m | 복합재 성형소 (autoclave) | $80k~150k |
| A2 | 디스크 외피 패널 (bottom dome + skid surface) | 1 set | CFRP T700 · R_bot=10.0 m | 복합재 성형소 | $80k~150k |
| A3 | 방사형 격벽 (radial bulkhead) | 6 | Al 7075-T6 · 60° 등각 | 항공 가공소 | $5k~12k ea |
| A4 | 외주 fillet 링 (edge vortex 완화) | 1 | CFRP + Al honeycomb · r=1.0 m | 복합재 성형소 | $30k~60k |
| A5 | 랜딩 skid (−z) | 3 | Ti-6Al-4V + energy absorber | 항공 가공소 | $8k~15k ea |
| A6 | canopy (조종석 투명) | 1 | polycarbonate 5cm + HEXA-CLOAK overlay | 광학/메타표면 | $40k~90k |

### 1.2 카테고리 B — RTSC 솔레노이드 자석 어셈블리 (120 kg · design §1.2 / structure §3.1)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| B1 | RTSC 솔레노이드 (lift) | 6 | HTS REBCO · N=4000 turns · I=300 A · NI=1.2e6 At · a/b/h=0.20/0.30/0.60 m | HTS 자석 제조 | $120k~250k ea |
| B2 | flux-pinning bulk puck (Type-II) | 8 | REBCO bulk · r=2.6~3.0 m 외주 · 45° 등각 | HTS bulk 공급 | $15k~35k ea |
| B3 | gyro CMG (자세) | 3 | control moment gyro · H≥500 N·m·s · ±60° gimbal | 항공 ACS | $200k~400k ea |
| B4 | Mu-metal 자기차폐 liner | 1 set | Mu-metal 1cm · cabin B≤0.5 mT | 차폐재 | $20k~45k |
| B5 | 솔레노이드 current driver (per-slot) | 6 | 400V DC · 독립 제어 6-DOF (design §1.4) | 전력전자 | $25k~50k ea |

### 1.3 카테고리 C — cryostat (자석 4.2K + trap 4K · structure §2.4 / design §5.3)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| C1 | LHe dewar (Stage-1 솔레노이드) | 1 | 4.2 K · heat leak ≤10 W · MLI + 진공자켓 5cm | cryo 시스템 | $150k~300k |
| C2 | active He cryocooler (Stage-3 trap) | 1 | 4 K UHV · pulse-tube/GM | cryo 시스템 | $80k~180k |
| C3 | MLI (multi-layer insulation) | 1 set | aluminized mylar · 층수 verb-4 sim 의무 | cryo 단열재 | $10k~25k |
| C4 | top-dome radiator (Stage-2 MHD) | 1 | 25 m² · heat-pipe 연결 | 열관리 | $40k~80k |
| C5 | LHe/cryogen 충전 IF + boil-off 회수 | 1 set | transfer line + recovery | cryo 시스템 | $20k~50k |

### 1.4 카테고리 D — LSS (생명유지 80 kg · structure §2.3)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| D1 | O₂ PSA (zeolite mol-sieve) | 1 | 99.5% pure · 0.84 kg/12h · 230 L | 생명유지 | $30k~60k |
| D2 | CO₂ scrub (LiOH primary + zeolite swing) | 1 | 1.6 kg LiOH · 60 L canister | 생명유지 | $8k~18k |
| D3 | H₂O loop (60% recovery closed) | 1 | 80 L · 3.6 L/12h net | 생명유지 | $15k~30k |
| D4 | LCG return loop + 좌석 | 1 set | reclining 30° · 100~150 W metabolic | 우주복/좌석 | $40k~80k |
| D5 | HVAC + valve manifold (dual redundant) | 1 set | 0.7 atm · 18~24 °C | 환경제어 | $20k~40k |

### 1.5 카테고리 E — avionics (45 kg · structure §2.6)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| E1 | IMU (FOG primary + RLG backup) | 2 | navigation-grade · triplex FBW 입력 | 관성센서 | $80k~200k ea |
| E2 | FBW 비행제어 컴퓨터 (triplex) | 3 | DO-178C DAL-A · 15-state Kalman host | 항공 컴퓨터 | $60k~120k ea |
| E3 | GNSS 수신기 (multi-constellation) | 2 | GPS/Galileo/BeiDou/GLONASS · INS aiding | 항법 | $15k~35k ea |
| E4 | BMS (battery management) | 1 | 28V DC + 400V DC dual bus | 전력관리 | $25k~50k |
| E5 | AR HUD + 디스플레이 | 1 set | 180° 전방 · stage status + falsifier dashboard | 디스플레이 | $40k~90k |

### 1.6 카테고리 F — power (동력원 net 150 kg · design §5.2 / structure §2.5)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| F1 | 28V DC bus (LSS/avionics 200 W · RTSC SMES tap) | 1 set | LSS · jet valve · IMU | 전력분배 | $20k~45k |
| F2 | 400V DC bus (자석/MHD/추진) | 1 set | 솔레노이드 6×NI · MHD · stage | 전력분배 | $30k~60k |
| F3 | 28V DC pulsed (trap · e⁺ source) | 1 set | Penning/Ioffe trap 전원 | 전력전자 | $20k~40k |
| F4 | EM-shield (Faraday cage) | 1 set | Al 1mm + Mu-metal liner · cross-talk 차단 | 차폐재 | $15k~30k |
| F5 | cold-gas jet trim (자세 backup) | 6 | 28V DC valve · S1~S6 등각 | RCS | $10k~22k ea |

### 1.7 카테고리 G — stage 추진 모듈 (Stage-1~3 실 제작 · Stage-4~7 formal only)

| ID | 부품 | 수량 | 재료/규격 | 공급원 카테고리 | 추정 단가 범위 (USD) |
|----|------|------|-----------|-----------------|----------------------|
| G1 | MHD 채널 (Stage-2 cruise) | 2 | B_ch=5 T · J=2.0e5 A/m² · L×W×H=1.2×0.40×0.20 m (S1+S4) | MHD/플라즈마 | $200k~450k ea |
| G2 | Penning trap (Stage-3 포획) | 1 | B=5 T · U₀=10 V · d=5 mm · quadrupole | 반물질 trap | $300k~600k |
| G3 | Ioffe-Pritchard trap (Stage-3 가둠) | 1 set | mirror coil a=0.10 m · NI=1e5 At · s=0.40 m · trap depth 0.35257 K | 반물질 trap | $250k~500k |
| G4 | e⁺ source + buffer-gas trap | 1 | ²²Na + Surko buffer-gas (handoff 상속) | 반물질 source | $150k~350k |
| G5 | γ-shield (4π sr · 5π 차폐 −z open) | 1 set | DU 3cm + W 1cm + B₄C 2cm · ≈80 kg | 방사선 차폐 | $80k~180k |
| G6 | Stage-4~7 formal mount slot (S3·S6) | 4 slot | **제작 산출물 없음** — formal mount only (design §4) | (없음 · falsifier-only) | $0 |

### 1.8 BOM 무게 reconcile (structure §5.1 650 kg cross-check)

| 카테고리 | 합산 무게 (kg) | structure §5.1 항목 |
|----------|----------------|---------------------|
| A frame + 외피 | 180 | frame + 외피 180 |
| B 자석 어셈블리 | 120 | 자석 어셈블리 120 |
| C cryostat + D LSS | 80 (LSS) + cryostat (자석 120 내 분담) | LSS 80 |
| E avionics + payload | 120 (payload 포함) | payload 120 |
| F power + G stage (net) | 150 | 동력원 net 150 |
| **합계** | **650** | SF=2.5 (structure §5.2) |

> **단가 invariant (@D d1)**: 위 단가 범위는 **sizing 기반 추정** (조달 견적 아님) — 외부 제작소 입찰 시 갱신 의무. Stage-4~7 (G6) 은 design §4 falsifier-only stance 상속하여 **제작 산출물 0 · 단가 $0** (formal mount slot 만 BOM 에 기재).

---

## 2. 도면 tree — 조립 계층 (L0→L3) + 인터페이스 도면

verb-2 structure §2.1 5-bay layout 을 조립 계층 도면 tree 로 전개. **CAD 파일이 아니라 조립 계층 + 도면 목록** (@D d1).

### 2.1 조립 계층 tree (L0 vehicle → L1 bay → L2 assembly → L3 part)

```
L0  UFO-VEHICLE (디스크 D=6.0 m · H=1.6 m · m=650 kg · SF=2.5)         [DWG-L0-000]
│
├─ L1  AVIONICS bay (+0.5~+0.8 m · top dome · 45 kg)                  [DWG-L1-AVI]
│   ├─ L2  IMU 어셈블리 (FOG×1 + RLG×1)                                [DWG-L2-AVI-01]
│   │   └─ L3  E1 IMU · 진동 isolation bushing · 케이블 하니스
│   ├─ L2  FBW 컴퓨터 rack (triplex)                                   [DWG-L2-AVI-02]
│   │   └─ L3  E2 FBW ×3 · E4 BMS · backplane
│   └─ L2  HUD/디스플레이 + GNSS                                       [DWG-L2-AVI-03]
│       └─ L3  E5 HUD · E3 GNSS ×2 · AR canopy 광학
│
├─ L1  CABIN bay (+0.0~+0.5 m · 1.8×1.2 m · 80 kg)                    [DWG-L1-CAB]
│   ├─ L2  좌석 + LCG 어셈블리                                          [DWG-L2-CAB-01]
│   │   └─ L3  D4 좌석 reclining 30° · LCG return · 5-point harness
│   └─ L2  canopy + cloak overlay                                     [DWG-L2-CAB-02]
│       └─ L3  A6 canopy PC 5cm · HEXA-CLOAK metasurface 적층
│
├─ L1  MAGNET bay (−0.4~+0.0 m · 120 kg · cryostat 환경)              [DWG-L1-MAG]
│   ├─ L2  솔레노이드 array (6-slot 60° 등각 · r=2.4 m)               [DWG-L2-MAG-01]
│   │   └─ L3  B1 솔레노이드 ×6 · B5 current driver ×6 · 권선 winding
│   ├─ L2  cryostat 통합 (LHe dewar + MLI)                            [DWG-L2-MAG-02]
│   │   └─ L3  C1 LHe dewar · C3 MLI · C5 transfer line
│   ├─ L2  gyro CMG mount (×3 · roll/pitch/yaw)                       [DWG-L2-MAG-03]
│   │   └─ L3  B3 gyro ×3 · gimbal torque motor · encoder
│   └─ L2  flux-pin array + 자기차폐                                   [DWG-L2-MAG-04]
│       └─ L3  B2 puck ×8 · B4 Mu-metal liner
│
├─ L1  POWER bay (−0.6~−0.4 m · 150 kg · stage module rack)          [DWG-L1-PWR]
│   ├─ L2  전원 bus 어셈블리 (dual bus)                                [DWG-L2-PWR-01]
│   │   └─ L3  F1 28V DC · F2 400V DC · F3 28V pulsed · F4 EM-shield
│   ├─ L2  Stage-2 MHD 채널 mount (S1+S4)                             [DWG-L2-PWR-02]
│   │   └─ L3  G1 MHD 채널 ×2 · ducted intake · heat-pipe IF
│   ├─ L2  Stage-3 antimatter trap mount (S2+S5)                     [DWG-L2-PWR-03]
│   │   └─ L3  G2 Penning · G3 Ioffe · G4 e⁺ source · G5 γ-shield
│   └─ L2  Stage-4~7 formal mount slot (S3·S6)                       [DWG-L2-PWR-04]
│       └─ L3  G6 formal mount only (제작 산출물 없음 · design §4)
│
└─ L1  LSS bay (−0.8~−0.6 m · bottom · 80 kg)                        [DWG-L1-LSS]
    ├─ L2  대기재생 어셈블리 (O₂/CO₂)                                  [DWG-L2-LSS-01]
    │   └─ L3  D1 O₂ PSA · D2 CO₂ scrub · valve manifold
    └─ L2  수분/열 loop                                               [DWG-L2-LSS-02]
        └─ L3  D3 H₂O loop · D5 HVAC · LCG return 연결

   + frame 자체 (외피 + 격벽 180 kg): A1~A5 · 랜딩 skid                [DWG-L1-FRM]
```

### 2.2 인터페이스 도면 목록 (bay 간 + stage mount IF)

| 도면 ID | 인터페이스 | 표준 | 출처 |
|---------|-----------|------|------|
| IF-PWR-01 | 전원 IF (28V DC · 400V DC · 28V pulsed) | single generic dispatch (@D d4) | structure §4.2 / design §5.2 |
| IF-CRYO-01 | 냉각 IF (LHe 4.2K · heat-pipe · He cryocooler 4K) | 공유 dewar (verb-4 trade) | design §5.3 / structure §2.4 |
| IF-STR-01 | 구조 mount IF (6-slot 60° 등각 · r=2.4 m) | 진동 isolation 3-tier (T1/T2/T3) | structure §4.1 / §4.4 |
| IF-EM-01 | 자기차폐 경계 (Mu-metal · cabin B≤0.5 mT) | Faraday cage cross-talk 차단 | structure §2.4 / §4.1 |
| IF-DATA-01 | 데이터 bus (CAN/avionics → 액추에이터) | triplex redundant FBW | structure §2.6 / firmware §3 |
| IF-GS-01 | γ-shield IF (4π sr · ion-chamber monitor → BMS) | Stage-3 throttle cap | structure §4.3 |
| IF-THERM-01 | 열 IF (q''' → radiator · 열응력 gradient 4.2K→300K) | analyze §4.3 coupling | analyze §4 |

> **도면 invariant (@D d1)**: 본 §2 는 **조립 계층 tree + 도면 ID 목록** — 실제 CAD geometry/치수 도면은 외부 제작소 또는 verb-7 handoff 패키지에서 생성. DWG-ID 는 명세 placeholder (조립 traceability) · L3 part 는 §1 BOM ID 와 cross-link. Stage-4~7 (DWG-L2-PWR-04) 은 formal mount only (제작 산출물 없음).

---

## 3. firmware stack — 제어 SW 아키텍처 명세

verb-3 design §1.4 (6-DOF active control) · §5.4 (stage 전환 sequencing) + verb-4 analyze §5 (4-layer coupling) 를 제어 SW 아키텍처로 전개. **아키텍처 명세** 이고 실제 제어 코드 SSOT = `~/core/hexa-lang/stdlib/` (@D d3) — UFO/synthesize/ 는 구현 코드 0줄.

### 3.1 3-계층 아키텍처 (HAL / RTOS / app)

```
┌───────────────────────── app layer (제어 application) ──────────────────────────┐
│  ① 자세제어 Kalman 15-state    ② stage 전환 state machine                          │
│  ③ 자석 PID 6-DOF              ④ LSS 모니터       ⑤ 안전 인터록                     │
├───────────────────────── RTOS (실시간 OS · DO-178C DAL-A) ──────────────────────┤
│  rate-monotonic scheduler · IPC (message queue) · watchdog · health monitor       │
│  triplex redundancy voter (FBW 2-of-3) · partition (ARINC 653 스타일)              │
├───────────────────────── HAL (board support · 하드웨어 추상화) ──────────────────┤
│  ADC/DAC · CAN/AFDX bus · cryo sensor (RTD/diode) · 자석 current driver IF         │
│  IMU(E1) driver · GNSS(E3) · gyro CMG(B3) torque · cold-gas valve(F5)              │
└────────────────────────────────────────────────────────────────────────────────┘
                          코드 SSOT = ~/core/hexa-lang/stdlib/ (@D d3)
```

### 3.2 제어 모듈 명세 (5 모듈)

| 모듈 | 기능 | 입력 (센서) | 출력 (액추에이터) | 알고리즘 | 출처 |
|------|------|-------------|-------------------|----------|------|
| ① 자세제어 Kalman | 15-state EKF 자세/속도/바이어스 추정 | IMU×2 (FOG/RLG) · GNSS×2 | gyro CMG · 자석 trim · jet | 15-state EKF (자세 q 4 + ω 3 + v 3 + 바이어스 acc/gyro 6) · ‖q‖=1±1e-9 invariant (spec §3.3) | structure §2.6 30-state FBW · design §1.4 |
| ② stage 전환 SM | hover→cruise→orbital→[warp gate] 전환 | 고도 · 속도(Mach) · Δv-budget | stage module enable/disable · MHD spool-up | guarded state machine (closed-form gate · design §5.4) | design §5.4 |
| ③ 자석 PID 6-DOF | 6 솔레노이드 current 독립 제어 → roll/pitch/yaw + x/y/z | 자세 EKF · flux-pin force 센서 | B5 current driver ×6 (ΔI_i→ΔB_i) | per-slot PID · ΔF_i=(2B_iΔB_i/2µ₀)A_eff η 선형화 | design §1.4 |
| ④ LSS 모니터 | O₂/CO₂/H₂O/압력/온도 12h 자급 추적 | D1~D5 센서 (gas · 압력 · 온도) | HVAC valve · scrub swing · alarm | threshold + trend (12h budget · spec §1.2) | structure §2.3 |
| ⑤ 안전 인터록 | γ-shield · cryo · over-current · g-limit 보호 | γ-flux ion-chamber · cryo T · current · g-load | Stage-3 throttle cap · 자석 quench dump · abort | 우선순위 인터록 (hard real-time) | structure §4.3 / design §3 |

### 3.3 제어 loop rate + 안전 등급 (DO-178C 매핑)

| 모듈 | loop rate (target) | DO-178C DAL | redundancy | 비고 |
|------|--------------------|-------------|------------|------|
| ① 자세제어 Kalman | 200~1000 Hz | DAL-A (catastrophic) | triplex 2-of-3 voter | FBW 핵심 |
| ② stage 전환 SM | 10~50 Hz | DAL-A | dual + manual override | 전환 1회성 critical |
| ③ 자석 PID 6-DOF | 1~10 kHz | DAL-A | per-slot 독립 (5/6 fail-op) | μ-second 응답 (hover) |
| ④ LSS 모니터 | 1~10 Hz | DAL-B (hazardous) | dual sensor | 느린 추세 |
| ⑤ 안전 인터록 | hard RT (이벤트 구동) | DAL-A | hardware-backed | 최고 우선순위 |

> **firmware invariant (@D d3 · @D d4)**: 본 §3 는 **아키텍처 명세** (계층 · 모듈 IF · loop rate · 안전 등급) — 실제 제어 코드 (EKF · PID · state machine 구현) SSOT 는 `~/core/hexa-lang/stdlib/` (sim/control/* 또는 동등 home). single generic dispatch (@D d4): 모듈 추가/변경 = 본 §3.2 표 한 행 수정만 · 모듈 이름 hardcoding 금지. Stage-4~7 은 firmware app layer 에 **모듈 없음** (formal only · design §4 상속).

### 3.4 제어 게인 sizing → verb-4/6 위임

- Kalman Q/R 공분산 · PID 게인 (K_p/K_i/K_d) · state machine gate threshold = **verb-4 analyze ⟲ 의 ⟲ 수렴 design point** 에서 도출 (analyze §7.1 — "⟲ 수렴 design point → firmware 제어 게인" schema)
- SW-in-the-loop (SIL) 검증 = verb-6 디지털트윈 (UFO/sim 엔진 · analyze §6 sim 본해 후)
- 게인 본해는 pool/cloud micro-exp (@D d7) deferred — 본 verb 는 아키텍처 + IF 명세만 닫는다

---

## 4. 제작 시퀀스 — 조립 순서 + 검사 게이트 (QA checkpoint)

structure §5.3 LC 카탈로그 + analyze §3 FEA 수렴 기준을 제작/검사 게이트로 매핑. **제작 순서 명세** (실 제작 아님 · @D d1).

### 4.1 8-단계 조립 시퀀스 + QA 게이트 (G0~G7)

| step | 단계 | 입력 BOM | QA 게이트 | 검사 기준 |
|------|------|----------|-----------|-----------|
| S0 | 부품 입고 · 수입검사 | 전 카테고리 A~G | **G0 수입검사** | 재료 인증서 · 치수 · HTS J_c · cryo leak |
| S1 | frame + 외피 조립 | A1~A6 (180 kg) | **G1 구조 정합** | 격벽 alignment · CFRP ply (Tsai-Wu · analyze §3.1) |
| S2 | 5-bay 통합 (avionics·cabin·power·LSS) | E·D·F | **G2 bay 통합** | bay 무게 reconcile · IF-DATA/PWR 연결 |
| S3 | 자석 어셈블리 + cryostat 통합 | B1~B5 · C1~C5 | **G3 자석/cryo** | 솔레노이드 권선 · LHe leak ≤10 W (analyze §4.2) · B≤0.5 mT 차폐 (IF-EM-01) |
| S4 | stage 추진 모듈 mount (Stage-1~3) | G1~G5 | **G4 추진 mount** | MHD 채널 IF · trap UHV · γ-shield 4π sr coverage (IF-GS-01) |
| S5 | avionics + firmware 통합 | E1~E5 + §3 stack | **G5 firmware SIL** | triplex voter · EKF ‖q‖=1±1e-9 · stage SM gate (verb-6 digital-twin) |
| S6 | 통합 기능 검사 (지상) | 전체 | **G6 통합검사** | 6-DOF current 응답 · LSS 12h · 안전 인터록 (LC-1 hover static) |
| S7 | 인계 패키지 (verb-7 handoff) | 전체 + 문서 | **G7 인계 게이트** | BOM·도면·firmware·인증서류 완비 (verb-7 준비물 §5.2) |

### 4.2 QA 게이트 ↔ verb-4 analyze LC / 수렴 기준 cross-link

| QA 게이트 | 검증 의무 | 책임 verb | analyze cross-link |
|-----------|-----------|-----------|--------------------|
| G1 구조 정합 | CFRP ply Tsai-Wu · 격벽 응력 | verb-4 FEA (LC-1) | analyze §3.1 / §3.2 |
| G3 자석/cryo | heat leak ≤10 W · 6-coil B-map | verb-4 EM + 열 | analyze §2.3 / §4.2 |
| G4 추진 mount | MHD effective thrust · γ-shield | verb-4 CFD+EM coupled | analyze §6.3 deferred |
| G5 firmware SIL | EKF/PID 게인 · stage SM | verb-6 digital-twin | analyze §7.1 게인 schema |
| G6 통합검사 | LC-1~5 FEA 마진 · 모달 | verb-4 FEA + verb-6 | analyze §3.3 |

> **제작 시퀀스 invariant (@D d1)**: 본 §4 는 **조립 순서 + QA 게이트 명세** — 실제 제작 공정/지그/공차는 외부 제작소 또는 verb-7 handoff 에서 상세화. QA 게이트의 정량 검사 기준 (heat leak · σ 마진 · effective thrust) 은 **verb-4 analyze ⟲ sim 본해** (pool/cloud micro-exp deferred) + verb-6 디지털트윈 에서 채워진다.

---

## 5. synthesize→verify 인계 + handoff 준비물 + cross-link + deferred

### 5.1 synthesize→verify 인계 (verb-6 디지털트윈 입력)

verb-6 verify (디지털트윈 통합 🟢) 가 소비할 **synthesize 산출 schema**:

| synthesize 산출 | verb-6 디지털트윈 소비 | 상태 |
|-----------------|------------------------|------|
| ① BOM (재료 물성 · 무게 · 수량) | 디지털트윈 질량/관성 텐서 · 재료 모델 입력 | manifest (단가는 verb-7) |
| ② 도면 tree (L0~L3 + IF) | 조립 geometry · IF 토폴로지 (FSI/coupling 격자) | manifest (CAD = 제작소) |
| ③ firmware stack (5 모듈 · loop rate) | SW-in-the-loop (SIL) · EKF/PID/SM 검증 | 아키텍처 (게인 = analyze 위임) |
| ④ 제작 시퀀스 (QA 게이트 G0~G7) | 통합검사 시나리오 · LC-1~5 falsifier 매핑 | manifest |

### 5.2 handoff (verb-7) 준비물

verb-7 handoff (외부 제작소 패키지) 가 요구하는 산출물 체크리스트:

- [ ] BOM 최종판 (조달 견적 갱신 · 공급원 입찰 · long-lead item 식별 — HTS 솔레노이드 B1 · 반물질 trap G2/G3)
- [ ] CAD 도면 패키지 (본 §2 도면 tree → 실제 geometry/치수/공차 도면)
- [ ] firmware 코드 패키지 (본 §3 아키텍처 → hexa-lang/stdlib 구현 + DO-178C 인증 산출물)
- [ ] 인증서류 (FAA Pt.25 base SF=2.5 · DO-178C DAL-A · cryo/반물질 안전 · γ-shield 방사선)
- [ ] QA 게이트 G0~G7 검사 절차서 + verb-4/6 sim 본해 결과 첨부

### 5.3 cross-link

| 대상 | 파일 | 역할 |
|------|------|------|
| UFO analyze (verb-4) | `UFO/analyze/integrated-vehicle-analyze.md` | §7.1 analyze→synthesize 산출 schema (BOM/도면/firmware 입력) |
| UFO design (verb-3) | `UFO/design/integrated-vehicle-design.md` | Stage-1~3 closed-form 설계점 (BOM sizing · firmware 게인 원) |
| UFO structure (verb-2) | `UFO/structure/integrated-vehicle-structure.md` | 5-bay layout (도면 tree) · 응력 budget (BOM 무게) · LC (QA 게이트) |
| UFO spec (verb-1) | `UFO/spec/integrated-vehicle-spec.md` | stage matrix · 자세제어 topology (firmware 모듈) · LSS 12h |
| RTSC (Stage-1 SSOT) | `~/core/demiurge/RTSC.md` | 솔레노이드 B1 · `solenoid_axis_bz` 1.48265 T |
| FUSION (Stage-2 SSOT) | `~/core/demiurge/FUSION.md` | MHD 채널 G1 · F=J×B |
| ANTIMATTER (Stage-3 SSOT) | `~/core/demiurge/ANTIMATTER.md` | Penning/Ioffe trap G2/G3 · γ-shield G5 |
| stdlib 코드 SSOT | `~/core/hexa-lang/stdlib/` | firmware 제어 코드 home (@D d3 · UFO/synthesize 코드 0줄) |

### 5.4 deferred (verb-6 verify / verb-7 handoff / 후속)

- [ ] BOM 조달 견적 갱신 (추정 범위 → 입찰 · long-lead HTS 솔레노이드 + 반물질 trap) — verb-7 handoff
- [ ] CAD 도면 geometry/치수/공차 (도면 tree → 실 도면) — verb-7 / 외부 제작소
- [ ] firmware 제어 게인 sizing (Kalman Q/R · PID K_p/K_i/K_d · SM threshold) — verb-4 analyze ⟲ 수렴 design point
- [ ] firmware SW-in-the-loop (SIL) 검증 — verb-6 디지털트윈 (UFO/sim 엔진)
- [ ] DO-178C DAL-A 인증 산출물 (자세제어 · 자석 PID · 안전 인터록) — verb-7 handoff
- [ ] cryostat dewar 통합 BOM 반영 (자석 4.2K ↔ trap 4K 공유 · 8% 무게 감소) — verb-4 trade study
- [ ] frame CFRP T1100 승격 BOM trade (10% 무게 감소) — verb-4 analyze ⟲
- [ ] QA 게이트 G0~G7 검사 절차서 정량 기준 (heat leak · σ 마진 · effective thrust) — verb-4 sim 본해
- [ ] Stage-2 MHD 채널 G1 effective thrust BOM 마진 (duct 효율 · plasma 손실) — verb-4 CFD+EM coupled
- [ ] γ-rocket I_sp mass-flow 정의 closure 반영 (G2~G5 trap BOM sizing) — verb-4 + verb-6 F-ANTI-3
- [ ] Stage-4~7 formal mount slot (G6) — 제작 산출물 없음 (design §4 falsifier-only 상속 · absorbed=true flip 금지)

---

## 마감

- **author**: UFO domain verb-5 synthesize milestone (PR pending — pr-cycle 훅 다음 라운드 stamp)
- **base ref**: `origin/main` (9c8abe4)
- **branch**: `feat/ufo-verb5-synthesize`
- **prev verb**: verb-4 analyze ⟲ LANDED (PR pending) · verb-3 design (PR#195) · verb-2 structure (PR#190) · verb-1 spec (PR#187)
- **next verb**: verb-6 verify — 디지털트윈 통합 🟢 (§5.1 synthesize 산출 schema 소비 · SIL + LC-1~5 falsifier)
- **governance**: @D d1 (비-wet-lab → completed-form · 제작 사양 manifest) · d3 (stdlib SSOT · firmware 코드 0줄) · d4 (single generic dispatch · BOM/도면/모듈 = manifest 한 행) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)
- **정직 invariant**: 본 verb-5 = 제작 산출물의 **사양 manifest** (실 제작/구매 아님 · 단가 = sizing 추정) · firmware = **아키텍처 명세** (제어 코드 SSOT = hexa-lang/stdlib · @D d3) · Stage-4~7 = formal mount only (제작 산출물 없음 · design §4 falsifier-only 상속 · absorbed=true flip 금지)
