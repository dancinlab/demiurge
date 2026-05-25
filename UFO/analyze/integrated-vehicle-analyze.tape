#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/analyze" :: identity-claim [d=2026-05-26 active]
  kind = "UFO verb-4 analyze ⟲ — CFD+EM+응력+열 통합 분석 manifest (수렴 기준 · sim 위임 plan · 무거운 본해 deferred pool/cloud)"
  brief = "demiurge 7-verb pipeline · verb-4 analyze ⟲ slot · sibling of integrated-vehicle-analyze.md"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "integrated-vehicle-analyze.md"
  verb = "4/7 (analyze ⟲)"

@I id002 := "ufo_analyze_head" :: identity [d=2026-05-26 active]
  icon  = "🛸"
  name  = "UFO/analyze"
  alias = "analyze"
  goal  = "verb-3 design closed-form 입력 set 을 CFD·EM·응력·열 4-layer 통합 sim 분석 계획 + 수렴 기준 + ⟲ coupling 으로 닫기 · 무거운 본해는 pool/cloud micro-exp 위임 (deferred)"

# ─── §Cross-link (sibling design/structure/sim + demiurge substrate) ───────
#
@C id010 := "design_link" :: cross-link [d=2026-05-26]
  to = "UFO/design/integrated-vehicle-design.md"
  role = "verb-3 design — §6 design→analyze 인계 closed-form 입력 set (B_center 1.48T · F_lift 7842N · F_MHD 1.92e5N · heat leak ≤10W)"

@C id011 := "structure_link" :: cross-link [d=2026-05-26]
  to = "UFO/structure/integrated-vehicle-structure.md"
  role = "verb-2 structure — OML D=6m/H=1.6m · 5 bay · 솔레노이드 array · LC-1~5 · σ_allow (CFRP600/Al460/Ti880/PC150)"

@C id012 := "sim_link" :: cross-link [d=2026-05-26]
  to = "UFO/sim/README.md"
  role = "디지털트윈 sim 엔진 — (domain,verb,formulation,solver) 4축 매트릭스 · 6-layer stack · solver SSOT 포인터"

@C id013 := "rtsc_link" :: cross-link [d=2026-05-26]
  to = "~/core/demiurge/RTSC.md"
  role = "EM SSOT — solenoid_axis_bz B_z(0)=1.48265 T (PR#1084) · Wheeler Δ=-1.40% cross-check · getdp axisym"

@C id014 := "fusion_link" :: cross-link [d=2026-05-26]
  to = "~/core/demiurge/FUSION.md"
  role = "MHD SSOT — MHD F=J×B · tf_peak_field · getdp far-field truncation 10× coil lesson (PR#1095)"

@C id015 := "antimatter_link" :: cross-link [d=2026-05-26]
  to = "~/core/demiurge/ANTIMATTER.md"
  role = "trap SSOT — Penning 3-freq invariance |Δ|=0.0 · Ioffe trap depth 0.35257 K"

@C id016 := "ufo_stage1_verify" :: cross-link [d=2026-05-26]
  to = "UFO/verify/stage1-hover-fields.md"
  role = "EM lift 인용 — ioffe_loop_bz 🟢×3 SUPPORTED-NUMERICAL · atlas 663698a0 (PR#191) · 재-verify 아님"

# ─── §① CFD layer — 디스크 항공역학 (Navier-Stokes) ────────────────────────
#
# 지배방정식: compressible Navier-Stokes
#   연속   : ∂ρ/∂t + ∇·(ρv) = 0
#   운동량 : ρ Dv/Dt = -∇p + ∇·τ + ρg + F_body   F_body = J×B (② EM coupling)
#   난류   : RANS k-ω SST (Mach 0.5~5) → DES/LES (Mach 5~25 shock-shaping)
# Re 범위 (격자 sizing 입력):
#   hover Mach 0~0.3   · Re_D 1e5~1e7 · y⁺<1 · ~3M cell (2D axisym)
#   cruise low Mach 0.5~5 · Re_D 1e6~1e8 · ~15M cell (3D half)
#   cruise high Mach 5~25 · 희박 Kn↑ · DSMC 보정 · AMR ~30M cell
# 수렴: residual RMS<1e-6 · C_d/L/D Δ_rel<1e-4 · y⁺<1 · GCI<3%
# target (sim 의무 · 본 verb 산출 X): L/D≥4 (Mach 0.5~5) · C_d≤0.8 (Mach 5~25)
# 인용: sim/README §3 cfd_ns · structure §1.2

# ─── §② EM layer — 자장 (Maxwell · RTSC 솔레노이드 · Meissner) ─────────────
#
# 지배방정식: Maxwell-Ampère · Meissner · Lorentz
#   ∇×B = µ₀J (자기준정적) · Meissner B_in=0 · B_surf=B_appl·exp(-x/λ_L)
#   F_lift = (B²/2µ₀)·A_eff·η · F_MHD = ∫J×B dV → ① CFD F_body · ③ 응력 부하
# 기존 verified atom (재-verify 아님 · @D d5):
#   solenoid_axis_bz B_z(0)=1.48265 T @ NI=2e6 (RTSC PR#1084 · Wheeler Δ=-1.40%)
#   UFO Stage-1 ioffe_loop_bz 🟢×3 (atlas 663698a0 · PR#191) → Meissner lift 입력
#   Penning 3-freq invariance |Δ|=0.0 · ioffe_trap_depth_k=0.35257 K
# sim 위임: 6-coil 60° array B-map FEM (getdp axisym→3D · far-field 10× coil)
#   · ‖ΔB‖<1e-4 T · FEM vs Wheeler Δ_rel<2% · flux-pin vs Meissner 비율
# 인용 invariant: 단일 코일 closed-form 재-solve 금지 (이미 🟢) · 상호작용만 FEM

# ─── §③ 응력 layer — 구조 FEA (650kg · SF=2.5 · LC-1~5) ───────────────────
#
# 지배방정식: linear-elastic + von Mises + Tsai-Wu
#   ∇·σ + f_body = ρü · σ = C:ε · σ_v = √(½Σ(σ_i-σ_j)²) · SF = σ_allow/σ_v ≥ 2.5
# LC-1~5 (structure §5.3):
#   LC-1 hover 1G static (F_lift 7842N) · LC-2 cruise 3G CFD+FEA coupled (F_MHD 1.92e5N)
#   LC-3 orbital 9G dynamic · LC-4 landing 6G explicit · LC-5 abort 12G dynamic
# σ_allow (structure §5.2): CFRP 600 / Al 460 / Ti 880 / PC 150 MPa
# 수렴: Newton ‖R‖/‖R₀‖<1e-6 · Δσ_peak<2% (h-refine) · min SF≥2.5 · f_nat≥2×f_drive
# breakthrough (LC-5 σ_v>σ_allow 시 · @D d2): CFRP T1100 승격 · Ti 국소보강 · 좌석 stroking

# ─── §④ 열관리 layer — cryostat 열부하 (LN₂/LHe · radiator) ────────────────
#
# 지배방정식: heat conduction + radiation + cryo boil-off
#   k∇²T = ρcṪ + q''' · Q̇_rad = εσ_SB(T⁴-T_amb⁴)·A · ṁ = Q̇/h_fg
#   q''' = 자석 AC loss + γ-shield 2차 IR + aero 가열
# 냉각 IF (structure §2.4/2.5/5.3):
#   LHe loop Stage-1 4.2K heat leak ≤10W (MLI + 진공자켓 5cm)
#   heat-pipe → top radiator Stage-2 25 m² · active He cryocooler Stage-3 4K UHV
# T-물성 coupling: B_c(T)·σ_e(T)·λ_L(T) → ② EM · σ_thermal=E·α·ΔT → ③ 응력 · ρ(T)·µ(T) → ① CFD
# 수렴: max|Ṫ|<1e-3 K/s · energy balance |Q̇_in-Q̇_out|/Q̇_in<1e-3
# breakthrough (radiator 부족 시 · @D d2): dewar 통합 · deployable fin · PCM buffer

# ─── §⑤ ⟲ coupling — 4-layer fixed-point 반복 수렴 ────────────────────────
#
# coupling 항 (방향성):
#   ② EM → ④ 열 (q''')· ② EM → ③ 응력 (F_lift·F_MHD)· ② EM → ① CFD (F_body)
#   ① CFD → ③ 응력 (air load)· ① CFD → ④ 열 (aero 가열)
#   ④ 열 → ② EM (T-물성)· ④ 열 → ③ 응력 (열응력)· ③ 응력 → ① CFD (FSI 격자 갱신)
# ⟲ 반복 수렴 (fixed-point):
#   초기값 = design §6 인계 closed-form
#   k: ① CFD → ② EM → ③ 응력 → ④ 열 → 갱신 부하·물성 재투입
#   수렴 = max( ‖X_k - X_{k-1}‖ / ‖X_k‖ ) < 1e-3  (X ∈ {C_d, B_map, σ_v, T-field})
#   완화 ω=0.5~0.7 · 발산 시 staggered → monolithic 승격 (@D d2 breakthrough)
# per-LC: LC-2 cruise = 전 8 coupling full ⟲ (monolithic 후보)

# ─── §⑥ sim 위임 계획 — pool/cloud micro-exp (@D d7 · deferred) ────────────
#
# compute sizing (@D d7/d11):
#   ① CFD hover 2D ~3M cell  → pool ubu idle-only (@D d18)
#   ① CFD cruise 3D DES ~15-30M cell → GPU pod (vast.ai first · @D d7/d17)
#   ② EM 6-coil FEM ~1-5M DOF → pool getdp → cloud if 3D dense
#   ③ FEA LC-1~5 ~0.5-2M DOF → pool linear · cloud explicit dynamic
#   ④ cryo transient ~0.5M DOF → pool
#   ⟲ full LC-2 = 위 합산 ×k iter → GPU pod (강결합)
# 워크플로: deck(.hexa) → pool free 1-iter dry-run (@D d16) → cost 1-line + autonomous fire (@D d17)
#   → Monitor (pw.x/ph.x) → JOB DONE harvest+down+parse → 🟢 atlas register (embedded.gen.hexa fold)
# 위임 invariant: 코드 SSOT hexa-lang/stdlib/sim/* (@D d3 · UFO/analyze 코드 0줄)
#   · Stage-4~7 = analyze 입력 없음 (falsifier-only · design §4 상속)

# ─── §Governance (do / dont per @D d1, d3, d4, d7, d9, d10) ────────────────
#
@D a1 := "ufo_analyze_plan_not_solve" :: governance [d=2026-05-26 required active]
  do   = "verb-4 = analyze 계획 + 수렴 기준 manifest · 무거운 본해 (CFD/FEA/cryo) 는 pool/cloud micro-exp 위임 (@D d7 deferred)"
  dont = "UFO/analyze 에서 무거운 sim 본해 실행 · sim 결과 값 산출/주장 · ad-hoc python (V3 무거운 sim = pool/cloud)"

@D a2 := "ufo_analyze_inherit_verified" :: governance [d=2026-05-26 required active]
  do   = "기존 verified atom (RTSC solenoid_axis_bz · UFO Stage-1 PR#191 · ANTIMATTER trap) 인용만 (재-verify 아님 · @D d5)"
  dont = "이미 🟢 인 단일 코일 closed-form 재-solve · verified atom 재산출 · 미검증 값 input 사용"

@D a3 := "ufo_analyze_single_generic" :: governance [d=2026-05-26 required active]
  do   = "sim/README §2 (domain,verb,formulation,solver) 4축 매트릭스를 generic engine 으로 통과 (single generic dispatch · @D d4)"
  dont = "layer/LC/stage 이름 hardcoding · per-layer dispatcher 클래스 · 코드를 UFO/analyze 에 (stdlib home only · @D d3)"

@D a4 := "ufo_analyze_coupling_honest" :: governance [d=2026-05-26 required active]
  do   = "🛸 UFO · analyze · alias analyze 헤더 (@D d10) · explicit file git add (@D d9) · ⟲ 4-layer coupling 수렴 기준 정직 표기"
  dont = "icon/이름 변형 · 인접 worktree file 동시 staging · sim 한계 시 불가능 framing (@D d2 breakthrough path · CFRP T1100 · dewar 통합 · monolithic 승격)"

# ─── §Absorption ledger (analyze 가 소비/인용한 입력) ──────────────────────
#
# verb-3 design (PR#195):
#   §6.1 EM 입력 (NI/a/b/h · B_center 1.48T · 6-slot) → ② EM §2.3 sim 위임
#   §6.2 CFD 입력 (OML D/H/AR · MHD 채널 · σ_e)       → ① CFD §1.2 envelope
#   §6.3 응력 입력 (650kg/SF2.5 · F_lift/F_MHD · 1/3/9/6/12 G) → ③ 응력 §3.2 LC
#   §6.4 열 입력 (heat leak ≤10W · radiator 25m² · γ-shield IR) → ④ 열 §4.2
#
# RTSC.md (② EM):
#   solenoid_axis_bz B_z(0)=1.48265 T (PR#1084) → §2.2 6-coil FEM anchor
#   getdp far-field truncation 10× coil (FUSION PR#1095) → §2.3 격자 기준
#
# UFO Stage-1 verify (PR#191):
#   ioffe_loop_bz 🟢×3 · atlas 663698a0 → §2.2 Meissner lift 입력 (재-verify 아님)
#
# UFO sim/README (HEXA-SIM 흡수):
#   4축 매트릭스 + 6-layer stack → §0~6 layer 지배방정식 + solver SSOT 포인터

# ─── §Log (append @A / @D events here, chronological) ─────────────────────
#
# @A commit_<hash> :: UFO/verb-4-analyze [d=<YYYY-MM-DD> ok]
#   <- d8d981b  # verb-3 design LANDED (PR#195) · verb-2 (PR#190) · verb-1 (PR#187)
#   => "verb-4 analyze ⟲ — CFD+EM+응력+열 통합 분석 manifest (수렴 기준 · sim 위임 deferred)"
#
# See ~/core/tape/spec/tape.md for full grammar.
