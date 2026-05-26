#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "ufo_verb1_spec" :: identity-claim [d=2026-05-25 active]
  kind = "UFO verb-1 spec — 1인승 통합 비행체 사양 명세 (single-pilot integrated craft spec)"
  brief = "demiurge 7-verb pipeline · verb-1 spec slot · sibling of integrated-vehicle-spec.md"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "integrated-vehicle-spec.md"
  verb = "1/7 (spec)"

@I id002 := "ufo_title_head" :: identity [d=2026-05-25 active]
  icon  = "🛸"
  name  = "UFO"
  alias = "통합 비행체(직접개발)"
  goal  = "RTSC 자석 + FUSION/ANTIMATTER 동력 + CERN 자장 자산을 통합한 1인승 비행체를 demiurge 7-verb 로 spec→handoff 완성"

# ─── §Cross-link (sibling demiurge domains + hexa-ufo atlas) ──────────
#
@C id010 := "rtsc_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/RTSC.md"
  role = "Stage-1 hover · Meissner 48T 자석 substrate"

@C id011 := "fusion_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/FUSION.md"
  role = "Stage-2 cruise · D-T/p-11B MHD 추진 substrate"

@C id012 := "antimatter_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/ANTIMATTER.md"
  role = "Stage-3 orbital · γ-rocket substrate"

@C id013 := "cern_link" :: cross-link [d=2026-05-25]
  to = "~/core/demiurge/CERN.md"
  role = "auxiliary · 자장/입자 boundary cross-link"

@C id014 := "hexa_ufo_atlas" :: cross-link [d=2026-05-25]
  to = "~/core/hexa-ufo/HEXA-UFO.md"
  role = "HEXA-Disc 1890-LOC atlas SSOT · Stage-1~7 + 부수 5축 + 13 falsifier"

# ─── §Stage matrix (7-stage propulsion ladder) ────────────────────────
#
# Stage-1 hover     | 0~20 km          | Mach 0~0.3        | RTSC 48T Meissner             | F-RTSC-{1,2,3}
# Stage-2 cruise    | 20~200 km        | Mach 0.3~25       | FUSION (D-T/p-11B) + MHD      | F-FUSION-{1,2,3}
# Stage-3 orbital   | 200km ~ 1 AU     | v_e ~ 0.1 c       | ANTIMATTER γ-rocket           | F-ANTI-{1,2,3}
# Stage-4 warp      | 1 AU ~ galactic  | v_s = σ²·c        | Alcubierre (δ=1/σ · R=n=6)    | F-WARP-{1,2,3}   [falsifier-only]
# Stage-5 wormhole  | intergalactic    | instantaneous     | Morris-Thorne (b₀=ℓ_Pl·σ)     | F-WORM-{1,2,3}   [falsifier-only]
# Stage-6 dim-jump  | bulk (KK ladder) | brane-cross       | KK 4D→6D→10D→11D→24D→26D     | F-DIM-{1,2,3}    [falsifier-only]
# Stage-7 dim-use   | Calabi-Yau 6-fold| (σ−φ)²=100c τ=4   | composite (CY navigation)     | F-USE-{1,2,3,4}  [falsifier-only]

# ─── §Payload (single-pilot LSS) ──────────────────────────────────────
#
# pilot_count    = 1 (single-pilot)
# pilot_mass     = 75 kg ± 15 kg
# cabin_envelope = 1.8 m × 1.2 m × 1.0 m (W×D×H)
# g_peak         = 9 G (5s peak)
# g_sustained    = 3 G (10 min sustained)
#
# LSS 12h autonomy:
#   O₂        = 0.84 kg
#   CO₂ scrub = 1.6 kg (LiOH primary, zeolite backup)
#   H₂O       = 3.6 L (closed-cycle 60% recovery)
#   ration    = 3000 kcal
#   cabin_P   = 0.7 atm (8000 ft equiv · O₂ enriched)
#   cabin_T   = 18 ~ 24 °C
#   LSS bus   = 200 W (28V DC, RTSC SMES tap)

# ─── §Attitude control (gyro + jet + EM trim · 2x redundancy) ────────
#
# primary_actuator   = gyro x3 (orthogonal CMG)
# backup_actuator    = cold-gas jet x6 (3-axis pair)
# trim_actuator      = EM coil (RTSC 자장 vector)
# imu_count          = 2 (FOG+MEMS primary · RLG+quartz backup)
# imu_rate           = 1 kHz
# bias_stability    = 0.001 °/h primary · 0.005 °/h backup
# fusion_filter      = Kalman 15-state · GNSS aiding

# ─── §Power interface (record consume contract per @D d4) ─────────────
#
# RTSC → Stage-1:
#   schema = { B_applied: T, T_op: K, J_c: A/m², geometry, B_axis_closed_form: T }
#   req    = B_app ≥ B_c1(T_op) AND F_lift = (B²/2µ₀)·A ≥ m_total·g
#   verify = Wheeler on-axis B closed-form (RTSC commit 3b33c26) · M318 cross-check
#
# FUSION → Stage-2:
#   schema = { Q_fusion, P_thermal: W, plasma_ne: m⁻³, T_ion: keV, B_coil: T }
#   req    = Q ≥ 1 · MHD σ_e ≥ 10⁴ S/m · F_MHD = J × B
#   verify = FUSION BLUE-MAX 🔵 audit (PR #1102) · 8 algebraic-root int atoms · 12 libm covered
#
# ANTIMATTER → Stage-3:
#   schema = { p_bar_rate: s⁻¹, trap_freq_3: (ω_c', ω_z, ω_-), I_sp: s, thrust_N: N }
#   req    = I_sp ≥ 10⁹ s (target 10¹⁰) · Brown-Gabrielse invariance
#   verify = Penning 3-freq closed-form (commit 4cda3f2) · BLUE-MAX 11/11 g69 PASS (PR #1107)
#
# Stage-4~7 (falsifier-only):
#   source = ~/core/hexa-ufo/{warp,wormhole,dimjump,dimuse}/
#   schema = formal (Alcubierre δ=1/σ · MT b₀=ℓ_Pl·σ · KK n²/R² · CY 6-fold)
#   req    = falsifier set {OPEN, CONFIRMED, DEMOTED} monotone · 13-falsifier closure
#   verify = formal lattice 일관성 only (no wet-lab) — n=6, σ·τ=48

# ─── §Absorption ledger (assets folded into this spec) ────────────────
#
# demiurge sibling domains:
#   RTSC       → Stage-1 (§2 spec.md) + record interface (§4.1)
#   FUSION     → Stage-2 (§2) + record interface (§4.2)
#   ANTIMATTER → Stage-3 (§2) + record interface (§4.3)
#   CERN       → auxiliary boundary (§4.5)
#
# hexa-ufo HEXA-Disc 1890-LOC atlas:
#   Stage-1~7 ladder           = fully mapped (§2 spec.md)
#   HEXA-HOVER                  = §2 Stage-1 보강 (downstream verb-2)
#   HEXA-CLOAK                  = §1.3 canopy overlay 명세
#   HEXA-GRAV/TELEPORT/SIM      = deferred — Phase B
#   13-falsifier catalog        = §2 stage-row falsifier column
#   n=6 σ·τ=48 lattice          = §2.2 verify 의무 · §4.4 lattice 일관성

# ─── §Governance (do / dont per @D d1, d3, d4, d10) ───────────────────
#
@D id070 := "ufo_verb1_governance" :: governance [d=2026-05-25 required active]
  do   = "stage 1-3 = 실설계 closed-form verify 의무 · stage 4-7 = falsifier-only preregister · UFO/spec/ = docs/manifests only · 🛸 UFO 통합비행체(직접개발) 헤더 유지"
  dont = "UFO/spec/ 에 실행 코드 두지 않는다 (stdlib home only) · instance 분기 코드 작성 금지 (single generic dispatch) · wet-lab 측정 기다리며 비-wet-lab gate 닫지 않는 일 금지"

# ─── §Log (append @A / @D events here, chronological) ────────────────
#
# @A commit_<hash> :: UFO/verb-1-spec [d=<YYYY-MM-DD> ok]
#   <- <prev-id>
#   => "<one-line description>"
#
# See ~/core/tape/spec/tape.md for full grammar.
