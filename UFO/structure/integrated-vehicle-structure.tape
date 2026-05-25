#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/structure" :: identity-claim [d=2026-05-25 active]
  kind = "UFO verb-2 structure — 통합 비행체 구조 정의 (frame OML + 내부 구획 + 자석 어셈블리 + stage 모듈 인터페이스 + 응력 budget)"
  brief = "demiurge 7-verb pipeline · verb-2 structure slot · sibling of integrated-vehicle-structure.md"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "integrated-vehicle-structure.md"
  verb = "2/7 (structure)"

@I id002 := "ufo_structure_head" :: identity [d=2026-05-25 active]
  icon  = "🛸"
  name  = "UFO/structure"
  alias = "structure"
  goal  = "verb-1 spec 의 사양을 frame + 내부 구획 + 자석 + stage 인터페이스 + 응력 budget 으로 정의 (manifest-only)"

# ─── §Cross-link (sibling spec + demiurge domains + hexa-ufo atlas) ──────
#
@C id010 := "spec_link" :: cross-link [d=2026-05-25]
  to = "UFO/spec/integrated-vehicle-spec.md"
  role = "verb-1 spec — 본 structure 의 사양 입력 (페이로드 · LSS · stage matrix · 자세제어 · 동력 IF)"

@C id011 := "hexa_ufo_main" :: cross-link [d=2026-05-25]
  to = "UFO/HEXA-UFO.md"
  role = "HEXA-Disc 1890-LOC atlas SSOT · 7-stage ladder + 부수 5축 + 13 falsifier"

@C id012 := "rtsc_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/RTSC.md"
  role = "자석 SSOT — Stage-1 RTSC 솔레노이드 array · Wheeler on-axis B closed-form · M318 cross-check"

@C id013 := "fusion_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/FUSION.md"
  role = "Stage-2 MHD intake / 추진 — D-T / p-11B · ducted intake slot S1+S4 (대각 페어)"

@C id014 := "antimatter_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/ANTIMATTER.md"
  role = "Stage-3 γ-rocket — Penning 3-freq · γ-shield 4π sr · slot S2+S5 (대각 페어)"

# ─── §Frame OML (lenticular disc) ────────────────────────────────────────
#
# diameter_D       = 6.0 m
# thickness_H      = 1.6 m
# aspect_ratio     = 0.27 (양볼록 · cone-tail 없음)
# top_curvature_R  = 8.0 m
# bot_curvature_R  = 10.0 m
# edge_fillet      = 1.0 m radius (vortex 완화 · radar 분산)
# symmetry         = z-axis 회전대칭 (yaw 자유 · CMG 친화)

# ─── §Internal bay layout (5 bay, top → bottom) ──────────────────────────
#
# AVIONICS rack | z=+0.5 ~ +0.8 | 0.3 m³ |  45 kg | HUD · IMU x2 · FBW · BMS · GNSS
# CABIN         | z= 0.0 ~ +0.5 | 2.16 m³|  80 kg | 좌석 reclining 30° · canopy + EM-cloak
# MAGNET bay    | z=-0.4 ~  0.0 | 5.4 m³ | 120 kg | RTSC 솔레노이드 x6 · gyro CMG x3 · flux-pin
# POWER bay     | z=-0.6 ~ -0.4 | 2.2 m³ | 150 kg | Stage-1~3 module rack · heat-pipe · EM-shield
# LSS bay       | z=-0.8 ~ -0.6 | 1.5 m³ |  80 kg | O₂ PSA · CO₂ LiOH · H₂O loop · UCD · LCG
# frame 자체     | 외피 + 격벽    | -       | 180 kg | CFRP T700 + Al 7075 honeycomb + Ti mount
#
# total_mass    = 650 kg
# safety_factor = 2.5 (FAA Pt.25 base)

# ─── §Magnet assembly (6 솔레노이드 등각 + gyro x3 + flux-pin) ───────────
#
# Solenoid array (외주 r = 2.4 m, 60° 간격 6 slot)
#   S1 azimuth=0°    axis=z  role=lift_primary
#   S2 azimuth=60°   axis=z  role=lift_primary
#   S3 azimuth=120°  axis=z  role=lift_primary
#   S4 azimuth=180°  axis=z  role=lift_primary
#   S5 azimuth=240°  axis=z  role=lift_primary
#   S6 azimuth=300°  axis=z  role=lift_primary
#
# lift_target   = F_lift_total ≥ m·g = 650·9.8 = 6,370 N (6 솔레노이드 분담)
# closed-form   = F_lift = (B²/2µ₀)·A · η  (Wheeler on-axis B, RTSC.md SSOT)
# control       = 6-DOF active (per-solenoid current independent) — Earnshaw bypass
# redundancy    = 5/6 솔레노이드 fail-operational (single-failure FAA Pt.25)
#
# gyro CMG x3 (roll · pitch · yaw)
#   roll  r=1.2 m  azimuth=90°   H_target ≥ 500 N·m·s
#   pitch r=1.2 m  azimuth=210°  H_target ≥ 500 N·m·s
#   yaw   r=0      axis=z        H_target ≥ 500 N·m·s
#
# Flux-pinning array (z=-0.8 m, r=2.6~3.0 m, 8 slot @ 45°)
#   재료 = HTS REBCO bulk puck (Type-II SC, cross-link RTSC.md axis-B)
#   역할 = 지면 안내 레일 (수평 alignment) + Earnshaw 추가 마진

# ─── §Stage interface mount table (6-slot 등각 외주, S1~S6 §Magnet 공유) ──
#
# Stage 1 hover     | slot S1~S6 (전체) | 120 kg | 400V DC bus       | LHe loop 4.2K              | active damper 0.1~200 Hz
# Stage 2 cruise    | slot S1 + S4      | 100 kg | 400V DC + plasma  | heat-pipe → top radiator   | bushing + tuned mass damper
# Stage 3 orbital   | slot S2 + S5      |  60 kg | 28V DC pulsed     | active He cryocooler       | γ-shield 4π sr (DU 3cm + W 1cm + B₄C 2cm)
# Stage 4 warp      | slot S3 (formal)  |  0 kg  | -                 | -                          | -                              [falsifier-only]
# Stage 5 wormhole  | slot S3 (공유)    |  0 kg  | -                 | -                          | -                              [falsifier-only]
# Stage 6 dim-jump  | slot S6 (formal)  |  0 kg  | -                 | -                          | -                              [falsifier-only]
# Stage 7 dim-use   | slot S6 (공유)    |  0 kg  | -                 | -                          | -                              [falsifier-only]
# jet trim          | slot S1~S6 (전체) |  30 kg | 28V DC valve      | N/A (cold-gas)             | rigid mount
#
# stage_real_mass_total = 280 kg (Stage 1~3 + jet trim · §5 응력 budget 의 동력원 ≈ 150 kg net)
# power_bus = { 28V DC (LSS/avionics/jet/IMU), 400V DC (자석/MHD/stage 추진) } — single generic dispatch (@D d4)

# ─── §Stress budget (load cases LC-1 ~ LC-5) ─────────────────────────────
#
# LC-1 hover         | 1 G sustain   | 자석 부상 모멘트 + gyro reaction       | verb-4 FEA static
# LC-2 cruise        | 3 G (10 min)  | aero + MHD intake duct                 | verb-4 CFD+FEA coupled
# LC-3 orbital boost | 9 G (5s peak) | γ-rocket thrust + g-suit               | verb-4 FEA dynamic
# LC-4 landing       | 6 G (impact)  | landing skid + frame 분포               | verb-4 FEA explicit
# LC-5 emergency abort| 12 G (3s)    | g-suit + 좌석 retention                 | verb-4 FEA dynamic
#
# σ_allow (safety factor 2.5):
#   CFRP T700 quasi-iso  = 600 MPa
#   Al 7075-T6 격벽       = 460 MPa
#   Ti-6Al-4V 자석 mount  = 880 MPa
#   PC canopy (+ cloak)   = 150 MPa

# ─── §Governance (do / dont per @D d1, d3, d4, d9, d10) ──────────────────
#
@D s1 := "ufo_structure_manifest_only" :: governance [d=2026-05-25 required active]
  do   = "UFO/structure/ 는 docs/manifests only — frame · bay · 자석 array · stage mount 표만 정의"
  dont = "UFO/structure/ 에 실행 코드 두지 않는다 (stdlib home only · @D d3) · 실측값 강제 금지"

@D s2 := "ufo_structure_single_generic" :: governance [d=2026-05-25 required active]
  do   = "stage 추가 / 변경 / 제거 = §4.1 표 한 행 수정만 · instance 분기 코드 작성 금지 (@D d4)"
  dont = "per-stage dispatcher 클래스 · slot 이름 hardcoding 코드 작성 금지 (single generic dispatch)"

@D s3 := "ufo_structure_verify_delegation" :: governance [d=2026-05-25 required active]
  do   = "응력 FEA · CFD · EM cloak 시뮬은 verb-4 analyze ⟲ 슬롯 위임 · 본 structure 는 LC 카탈로그 선언만"
  dont = "verb-2 structure 에 closed-form / numeric verify 강행 금지 (downstream verb 책임)"

@D s4 := "ufo_structure_identity_head" :: governance [d=2026-05-25 required active]
  do   = "🛸 UFO · structure · alias structure · canonical head 유지 (@D d10) · explicit file 만 git add (@D d9)"
  dont = "icon/이름 변형 · 헤더 누락 · 인접 worktree 의 file 동시 staging 금지"

# ─── §Absorption ledger (structure 가 흡수한 자산) ───────────────────────
#
# UFO/spec/integrated-vehicle-spec.md (verb-1 PR#187):
#   §1 페이로드 1명 · 75 kg · 12h LSS    → §2.2 CABIN + §2.3 LSS bay (mass + envelope)
#   §2 Stage matrix 7-row                  → §4.1 mount 표 (slot 매핑 추가)
#   §3 자세제어 (gyro/jet/EM trim)         → §3.2 gyro CMG mount + §4.4 진동 isolation tier
#   §4 동력 IF (RTSC/FUSION/ANTIMATTER)   → §4.1 전원/냉각 IF + §4.3 γ-shield
#
# RTSC.md (자석 SSOT):
#   Wheeler on-axis B closed-form           → §3.1 lift_target 식 (verb-3 sizing 위임)
#   axis-B HTS REBCO / axis-A 솔레노이드   → §3.3 flux-pin 재료 · §3.1 device 선택
#
# UFO/hover/README.md (HEXA-HOVER LANDED PR#183):
#   Meissner active feedback 3-경로 hybrid  → §3.1 6-DOF active control + flux-pin
#
# UFO/sim/README.md (HEXA-SIM LANDED PR#186):
#   6-layer multiscale n=6 stack            → §5.3 LC-1~5 verb-4 위임 (sim engine 호출)

# ─── §Log (append @A / @D events here, chronological) ────────────────────
#
# @A commit_<hash> :: UFO/verb-2-structure [d=<YYYY-MM-DD> ok]
#   <- a9e7439  # verb-1 spec LANDED (PR#187)
#   => "verb-2 structure — frame + 자석 어셈블리 + stage 모듈 인터페이스 정의"
#
# See ~/core/tape/spec/tape.md for full grammar.
