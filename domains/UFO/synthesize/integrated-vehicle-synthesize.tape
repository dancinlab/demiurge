#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/synthesize" :: identity-claim [d=2026-05-26 active]
  kind = "UFO verb-5 synthesize — BOM + 도면 tree + firmware stack 산출물 manifest (제작 사양)"
  brief = "demiurge 7-verb pipeline · verb-5 synthesize slot · sibling of integrated-vehicle-synthesize.md"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "integrated-vehicle-synthesize.md"
  verb = "5/7 (synthesize)"

@I id002 := "ufo_synthesize_head" :: identity [d=2026-05-26 active]
  icon  = "🛸"
  name  = "UFO/synthesize"
  alias = "synthesize"
  goal  = "verb-3 design closed-form + verb-2 structure 5-bay + verb-4 analyze schema 를 외부 제작소-readable 제작 산출물 3종 (BOM·도면·firmware) + QA 시퀀스로 명세 · 실 제작 아님 (@D d1)"

# ─── §Cross-link (sibling spec/structure/design/analyze) ──────────────────
#
@C id010 := "spec_link" :: cross-link [d=2026-05-26]
  to = "UFO/spec/integrated-vehicle-spec.md"
  role = "verb-1 spec — stage matrix · 자세제어 topology (firmware 모듈) · LSS 12h"

@C id011 := "structure_link" :: cross-link [d=2026-05-26]
  to = "UFO/structure/integrated-vehicle-structure.md"
  role = "verb-2 structure — 5-bay layout (도면 tree) · 응력 budget 650kg/SF=2.5 (BOM 무게) · LC (QA 게이트)"

@C id012 := "design_link" :: cross-link [d=2026-05-26]
  to = "UFO/design/integrated-vehicle-design.md"
  role = "verb-3 design — Stage-1~3 closed-form 설계점 (BOM sizing · firmware 6-DOF/전환 게인 원)"

@C id013 := "analyze_link" :: cross-link [d=2026-05-26]
  to = "UFO/analyze/integrated-vehicle-analyze.md"
  role = "verb-4 analyze ⟲ — §7.1 analyze→synthesize 산출 schema (BOM/도면/firmware 입력) · QA 게이트 LC cross-link"

# ─── §① BOM (Bill of Materials) — 7 카테고리 부품표 ────────────────────────
#
# A frame + 외피 (180 kg · structure §1.1 / §5.1):
#   A1/A2 디스크 외피 패널 (CFRP T700 · top/bottom dome) · A3 격벽 ×6 (Al 7075-T6)
#   A4 외주 fillet 링 · A5 랜딩 skid ×3 (Ti-6Al-4V) · A6 canopy (PC 5cm + cloak)
#
# B RTSC 솔레노이드 자석 (120 kg · design §1.2 / structure §3.1):
#   B1 솔레노이드 ×6 (HTS REBCO · N=4000 · I=300A · NI=1.2e6 At · a/b/h=0.20/0.30/0.60 m)
#   B2 flux-pin puck ×8 (Type-II REBCO) · B3 gyro CMG ×3 (H≥500 N·m·s)
#   B4 Mu-metal liner (B≤0.5 mT) · B5 current driver ×6 (400V DC · 6-DOF)
#
# C cryostat (structure §2.4 / design §5.3):
#   C1 LHe dewar (4.2K · heat leak ≤10W) · C2 He cryocooler (4K UHV)
#   C3 MLI · C4 radiator 25 m² · C5 transfer line + boil-off 회수
#
# D LSS (80 kg · structure §2.3):
#   D1 O₂ PSA (99.5% · 0.84 kg/12h) · D2 CO₂ scrub (LiOH 1.6 kg) · D3 H₂O loop (60% recovery)
#   D4 LCG return + 좌석 (reclining 30°) · D5 HVAC (0.7 atm · 18~24°C)
#
# E avionics (45 kg · structure §2.6):
#   E1 IMU ×2 (FOG+RLG) · E2 FBW ×3 (triplex · DAL-A) · E3 GNSS ×2 · E4 BMS (dual bus) · E5 HUD
#
# F power (net 150 kg · design §5.2):
#   F1 28V DC bus · F2 400V DC bus · F3 28V pulsed (trap) · F4 EM-shield · F5 cold-gas jet ×6
#
# G stage 추진 (Stage-1~3 실 제작 · Stage-4~7 formal only):
#   G1 MHD 채널 ×2 (B_ch=5T · J=2.0e5 · 1.2×0.40×0.20 m · S1+S4)
#   G2 Penning trap (B=5T · U₀=10V · d=5mm) · G3 Ioffe trap (depth 0.35257 K)
#   G4 e⁺ source (²²Na + Surko) · G5 γ-shield (DU 3cm+W 1cm+B₄C 2cm · ≈80 kg)
#   G6 Stage-4~7 formal mount (S3·S6) — 제작 산출물 없음 · 단가 $0 (design §4)
#
# 무게 reconcile: A 180 + B 120 + (C/D LSS) 80 + (E payload) 120 + (F/G net) 150 = 650 kg (SF=2.5)
# 단가 = sizing 기반 추정 범위 (조달 견적 아님 · @D d1) — verb-7 handoff 입찰 갱신

# ─── §② 도면 tree — 조립 계층 L0→L3 + 인터페이스 도면 ─────────────────────
#
# L0 UFO-VEHICLE [DWG-L0-000]   D=6.0m · H=1.6m · 650 kg · SF=2.5
#  ├ L1 AVIONICS  [DWG-L1-AVI]  IMU/FBW/HUD-GNSS (L2 ×3 → L3 E1~E5)
#  ├ L1 CABIN     [DWG-L1-CAB]  좌석+LCG / canopy+cloak (L2 ×2 → L3 D4·A6)
#  ├ L1 MAGNET    [DWG-L1-MAG]  솔레노이드 array / cryostat / gyro / flux-pin (L2 ×4 → L3 B1~B5·C1~C5)
#  ├ L1 POWER     [DWG-L1-PWR]  전원 bus / Stage-2 MHD / Stage-3 trap / Stage-4~7 formal (L2 ×4 → L3 F·G)
#  ├ L1 LSS       [DWG-L1-LSS]  대기재생 / 수분-열 loop (L2 ×2 → L3 D1~D5)
#  └ L1 frame     [DWG-L1-FRM]  외피+격벽 (A1~A5)
#
# 인터페이스 도면 (bay 간 + stage mount IF):
#   IF-PWR-01  전원 IF (28V/400V/28V pulsed · single generic dispatch @D d4)
#   IF-CRYO-01 냉각 IF (LHe 4.2K · heat-pipe · He cryocooler 4K · 공유 dewar trade)
#   IF-STR-01  구조 mount IF (6-slot 60° · r=2.4m · 진동 isolation 3-tier)
#   IF-EM-01   자기차폐 경계 (Mu-metal · cabin B≤0.5 mT)
#   IF-DATA-01 데이터 bus (CAN/avionics → 액추에이터 · triplex FBW)
#   IF-GS-01   γ-shield IF (4π sr · ion-chamber → BMS throttle cap)
#   IF-THERM-01 열 IF (q''' → radiator · 열응력 4.2K→300K gradient)
#
# DWG-ID = 명세 placeholder (조립 traceability) · CAD geometry = verb-7 / 제작소

# ─── §③ firmware stack — 제어 SW 아키텍처 (HAL/RTOS/app) ──────────────────
#
# 3-계층:
#   app   : ① 자세제어 Kalman 15-state · ② stage 전환 SM · ③ 자석 PID 6-DOF · ④ LSS 모니터 · ⑤ 안전 인터록
#   RTOS  : rate-monotonic scheduler · IPC · watchdog · triplex voter (2-of-3) · ARINC-653 partition (DO-178C DAL-A)
#   HAL   : ADC/DAC · CAN/AFDX · cryo sensor (RTD/diode) · IMU/GNSS/gyro driver · current driver IF
#
# 5 모듈 (loop rate · DAL · redundancy):
#   ① Kalman 15-state (q4+ω3+v3+bias6) ‖q‖=1±1e-9 | 200~1000 Hz | DAL-A | triplex 2-of-3
#   ② stage 전환 SM (guarded · closed-form gate)   | 10~50 Hz    | DAL-A | dual + manual override
#   ③ 자석 PID 6-DOF (per-slot ΔI_i→ΔB_i 선형화)    | 1~10 kHz    | DAL-A | per-slot 독립 (5/6 fail-op)
#   ④ LSS 모니터 (12h budget threshold+trend)       | 1~10 Hz     | DAL-B | dual sensor
#   ⑤ 안전 인터록 (γ-shield/cryo/over-current/g)    | hard RT     | DAL-A | hardware-backed
#
# 코드 SSOT = ~/core/hexa-lang/stdlib/ (@D d3 · UFO/synthesize 구현 코드 0줄)
# 게인 sizing (Kalman Q/R · PID K_p/K_i/K_d · SM threshold) = verb-4 ⟲ 수렴 design point (analyze §7.1)
# SW-in-the-loop (SIL) 검증 = verb-6 디지털트윈
# Stage-4~7 = app layer 모듈 없음 (formal only · design §4)

# ─── §④ 제작 시퀀스 — 8 단계 + QA 게이트 G0~G7 ────────────────────────────
#
# S0 부품 입고/수입검사     | G0 수입검사    | 재료 인증·치수·HTS J_c·cryo leak
# S1 frame + 외피 조립      | G1 구조 정합   | 격벽 alignment · CFRP ply Tsai-Wu (analyze §3.1)
# S2 5-bay 통합            | G2 bay 통합    | 무게 reconcile · IF-DATA/PWR 연결
# S3 자석 + cryostat 통합   | G3 자석/cryo   | 권선 · LHe leak ≤10W · B≤0.5mT 차폐
# S4 stage 추진 mount (1~3) | G4 추진 mount  | MHD IF · trap UHV · γ-shield 4π sr
# S5 avionics + firmware    | G5 firmware SIL| triplex voter · EKF ‖q‖=1±1e-9 · stage SM
# S6 통합 기능검사 (지상)    | G6 통합검사    | 6-DOF current 응답 · LSS 12h · 안전 인터록 (LC-1)
# S7 인계 패키지 (verb-7)    | G7 인계 게이트 | BOM·도면·firmware·인증서류 완비
#
# QA 게이트 정량 기준 (heat leak · σ 마진 · effective thrust) = verb-4 analyze ⟲ sim 본해 + verb-6 디지털트윈

# ─── §synthesize→verify 인계 (verb-6 디지털트윈 입력) ─────────────────────
#
# ① BOM (물성·무게·수량)     → 디지털트윈 질량/관성 텐서 · 재료 모델
# ② 도면 tree (L0~L3 + IF)   → 조립 geometry · IF 토폴로지 (FSI/coupling 격자)
# ③ firmware stack (5 모듈)  → SW-in-the-loop (SIL) · EKF/PID/SM 검증
# ④ 제작 시퀀스 (QA G0~G7)   → 통합검사 시나리오 · LC-1~5 falsifier 매핑
#
# handoff (verb-7) 준비물: BOM 최종판 · CAD 도면 패키지 · firmware 코드 패키지 (stdlib) · 인증서류 · QA 절차서

# ─── §Governance (do / dont per @D d1, d3, d4, d9, d10) ───────────────────
#
@D s1 := "ufo_synthesize_spec_not_build" :: governance [d=2026-05-26 required active]
  do   = "verb-5 = 제작 산출물의 사양 manifest (BOM·도면·firmware·QA) · 외부 제작소 readable · 단가 = sizing 추정"
  dont = "실 부품 구매/가공/조립 · 조달 견적 주장 · CAD geometry 산출 (verb-7/제작소 의무 · @D d1)"

@D s2 := "ufo_synthesize_firmware_arch_only" :: governance [d=2026-05-26 required active]
  do   = "firmware = 아키텍처 명세 (계층·모듈 IF·loop rate·DAL) · 제어 코드 SSOT = hexa-lang/stdlib (@D d3)"
  dont = "UFO/synthesize/ 에 제어 구현 코드 (EKF/PID/SM) · 게인 본해 강행 (verb-4 ⟲ 수렴 / verb-6 SIL 위임)"

@D s3 := "ufo_synthesize_single_generic" :: governance [d=2026-05-26 required active]
  do   = "BOM line-item / 도면 tree 노드 / firmware 모듈 추가·변경·제거 = 본 표 한 행 수정만 (@D d4)"
  dont = "per-부품 / per-모듈 dispatcher 클래스 · stage/bay/모듈 이름 hardcoding · 분기 코드"

@D s4 := "ufo_synthesize_stage47_no_artifact" :: governance [d=2026-05-26 required active]
  do   = "Stage-4~7 = formal mount slot only (제작 산출물 0 · 단가 $0 · app layer 모듈 없음 · design §4 상속)"
  dont = "Stage-4~7 제작 산출물/BOM/firmware 모듈 산출 · absorbed=true flip · 물리 한계/불가능 framing (@D d2)"

# ─── §Provenance ledger (synthesize 가 인용한 sibling 산출) ────────────────
#
# UFO design (verb-3 PR#195):
#   Stage-1~3 closed-form (NI=1.2e6 At · B_center 1.48 T · MHD J×B · trap 0.35257 K) → §1 BOM sizing
#   §1.4 6-DOF active control · §5.4 stage 전환 sequencing                          → §3 firmware ②③
#   §5.1 mass budget 650 kg · §5.2 dual bus · §5.3 cryo                             → §1.8 reconcile · §2 IF
#
# UFO structure (verb-2 PR#190):
#   §2.1 5-bay layout (avionics/cabin/magnet/power/LSS)  → §2 도면 tree L1
#   §3.1 솔레노이드 6-slot · §4.1 mount 표 · §4.3 γ-shield → §1 BOM B/G · §2 IF
#   §5.2 σ_allow · §5.3 LC-1~5                            → §4 QA 게이트
#
# UFO analyze (verb-4):
#   §7.1 analyze→synthesize 산출 schema (C_d·B-map·σ·heat leak·게인) → §1/§3/§4 입력
#   §3 FEA 수렴 · §4.2 heat leak ≤10W · §6.3 effective thrust       → §4.2 QA cross-link
#
# RTSC / FUSION / ANTIMATTER (Stage-1~3 substrate SSOT):
#   RTSC solenoid_axis_bz 1.48265 T → B1 솔레노이드
#   FUSION MHD F=J×B               → G1 MHD 채널
#   ANTIMATTER Penning/Ioffe trap  → G2/G3/G4/G5 trap + γ-shield

# ─── §Log (append @A / @D events here, chronological) ─────────────────────
#
# @A commit_<hash> :: UFO/verb-5-synthesize [d=2026-05-26 ok]
#   <- 9c8abe4  # verb-4 analyze ⟲ LANDED (PR pending) · verb-3 design (PR#195) · verb-2 (PR#190) · verb-1 (PR#187)
#   => "verb-5 synthesize — BOM + 도면 tree + firmware stack 산출물 manifest + QA 시퀀스"
#
# See ~/core/tape/spec/tape.md for full grammar.
