#!/usr/bin/env tape
# UFO verb-6 verify — 디지털트윈 통합 verify ledger (Stage-1~3 🟢 통합 + 4-layer 수렴 + 안정성 falsifier)
# Sibling of UFO/verify/integrated-vehicle-verify.md (numbers derive from the .md SSOT).
# 17-type alphabet only (@V @I @C @D::governance). No name-hardcoded dispatch (@D d4).

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/verify" :: identity-claim [d=2026-05-26 active]
  kind = "UFO verb-6 verify — 디지털트윈 통합 verify ledger (Stage-1~3 9건 🟢 통합 + 4-layer 수렴 충족 여부 + 안정성 falsifier · 본해 deferred 정직 표기)"
  brief = "demiurge 7-verb pipeline · verb-6 verify slot · sibling of integrated-vehicle-verify.md"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "integrated-vehicle-verify.md"
  verb = "6/7 (verify)"

@I id002 := "ufo_verify_head" :: identity [d=2026-05-26 active]
  icon  = "🛸"
  name  = "UFO/verify"
  alias = "verify"
  goal  = "비행체의 비-wet-lab 검증 정도를 정직 집계 — Stage-1~3 numerical 9건 🟢 통합 + 4-layer 디지털트윈 수렴 충족 여부 (본해 pool/cloud 위임 = 🟠 정직 표기) + 안정성 falsifier 통과 여부 → Phase E absorbed 판정 입력"

# ─── §Verdict tiers (verb-6 통합 검증 등급 분포 · NOT physics proof) ─────────
@C c_tiers := "디지털트윈 통합 verify tier 분포 (verb-6 시점)" :: config [d=2026-05-26 active]
  formal = "🔵 SUPPORTED-FORMAL = 0 (V2 lattice 🔵 push 예정)"
  numerical = "🟢 SUPPORTED-NUMERICAL = 10 (Stage-1~3 9건 + Penning invariance anchor)"
  citation = "🟡 SUPPORTED-BY-CITATION = 4 (F_lev · Lorentz F=J×B · gamma-rocket I_sp 천장 · Earnshaw active)"
  deferred = "🟠 INSUFFICIENT/DEFERRED = 5 (CFD · EM 3D · 응력 · 열 · ⟲ PID 본해 pool/cloud 위임)"
  falsified = "🔴 FALSIFIED = 0"
  unproven = "⚪ SPECULATION-FENCED = 13 (Stage-4~7 13 falsifier 전부 OPEN UNPROVEN)"

# ─── §① Stage-1~3 numerical 🟢 통합 (verbatim verdict 재인용 · g5) ──────────
@C c_stage123 := "Stage-1~3 numerical 9건 🟢 (verbatim 재인용 · atlas folded)" :: config [d=2026-05-26 active]
  stage1 = "ioffe_loop_bz ×3 — 90/120/200kg hover-coil B=2T · |Δ|<=5.67e-10 · @F verified-ioffe_loop_bz-num"
  stage2 = "triple_product ×3 — MHD thrust 저/중/고고도 96000/57600/28800 N · |Δ|=0.0 · @F verified-triple_product-num (30535)"
  stage3 = "pair_threshold_total ×1 + rel_kinetic_from_p ×2 — annihilation/상대론 회계 · |Δ|=0.0 · @F (30652/30514)"
  atlas-hash = "663698a0..ce7fb (binary-builtin SSOT embedded.gen.hexa · 재-verify 아님 · 인용만)"
  honest = "gamma-rocket I_sp=c/g~3.057e7 s ↔ spec target 1e9 s 2-자릿수 불일치 정직 표기 (closure=F-ANTI-3 · 목표 수 강제 금지 @D d6)"

# ─── §② 4-layer 디지털트윈 수렴 — 본해 deferred 정직 표기 (허위 🟢 금지) ─────
@C c_4layer := "4-layer 디지털트윈 수렴 충족 여부 (verb-4 수렴 기준 · 본해 pool/cloud 위임)" :: config [d=2026-05-26 active]
  cfd = "① CFD C_d·L/D — residual RMS<1e-6 · Δ_rel<1e-4 — 🟠 본해 deferred (hover 2D pool · cruise 3D DES GPU pod)"
  em = "② EM 6-coil 3D B-map — 단일코일 ioffe_loop_bz 🟢 anchor + 6-coil 상호작용 ‖ΔB‖<1e-4 T FEM 🟠 deferred"
  stress = "③ 응력 von Mises LC-1~5 — min SF>=2.5 · Newton ‖R‖/‖R₀‖<1e-6 — 🟠 본해 deferred (pool linear → cloud explicit)"
  thermal = "④ 열 cryo balance — max|Ṫ|<1e-3 K/s · |Q̇_in-Q̇_out|/Q̇_in<1e-3 — 🟠 본해 deferred"
  coupling = "⟲ 4-layer fixed-point — max(‖X_k-X_{k-1}‖/‖X_k‖)<1e-3 (X∈{C_d,B_map,σ_v,T}) — 🟠 LC-2 강결합 본해 deferred"

# ─── §③ 안정성 falsifier — 자세제어/stage 전환/6-DOF PID (충족/미충족 honest) ─
@C c_stability := "안정성 falsifier 통과 여부 (Earnshaw active · stage 전환 · 6-DOF PID 마진)" :: config [d=2026-05-26 active]
  trap = "Penning 3-freq invariance ω_c²=ω₊²+ω_z²+ω₋² |Δ|=0.0 (ANTIMATTER ⓷ anchor) — 🟢 PASS"
  earnshaw = "정적 자기부상 Earnshaw 불안정 → active feedback 필수 — 🟡 citation · 안정 마진은 PID 본해 🟠"
  transition = "Stage-1→2 (20km Mach0.3 MHD spool-up) · Stage-2→3 (200km MHD shutdown + γ-rocket ignition) — 🟡 transition graph · 천이 마진 🟠"
  pid = "6-DOF PID gain/phase margin (모달 f_natural>=2×f_drive · firmware K_p/K_i/K_d sizing) — 🟠 ⟲ 수렴 design point 위임"

# ─── §④ 통합 verdict — absorbed 미충족 게이트 (Phase E 판정 입력) ────────────
@C c_verdict := "통합 verdict — 비-wet-lab 검증 등급 + 미충족 게이트" :: config [d=2026-05-26 active]
  pass = "Stage-1~3 추진/EM numerical 9건 🟢 + Penning trap invariance 🟢 = 검증된 코어 PASS"
  unmet-bonhae = "① CFD · ② EM 3D · ③ 응력 · ④ 열 · ⟲ PID 5 게이트 = 🟠 본해 pool/cloud 위임 미충족"
  unmet-isp = "gamma-rocket I_sp target 1e9 s closure (F-ANTI-3 mass-flow 정의) 미충족 (정직 표기)"
  absorbed = "Phase E absorbed=true 미충족 — 본해 5 + F-ANTI-3 closure 후 flip (@D d5 · projection flip 금지)"
  stage47 = "Stage-4~7 13 falsifier = ⚪ UNPROVEN · absorbed gate 아님 (formal lattice V2 까지만 · 측정 downstream)"

# ─── §Cross-link (Stage verify docs + analyze/synthesize + V1 inventory) ────
@C id010 := "stage1_verify" :: cross-link [d=2026-05-26]
  to = "UFO/verify/stage1-hover-fields.md"
  role = "Stage-1 hover EM B-field ioffe_loop_bz 🟢×3 verbatim (§1.1) — 재-verify 아님"

@C id011 := "stage2_verify" :: cross-link [d=2026-05-26]
  to = "UFO/verify/stage2-cruise-mhd.md"
  role = "Stage-2 cruise MHD thrust triple_product 🟢×3 verbatim (§1.2) — 30배 마진 (이상화 상한)"

@C id012 := "stage3_verify" :: cross-link [d=2026-05-26]
  to = "UFO/verify/stage3-orbital-gamma.md"
  role = "Stage-3 orbital 상대론 회계 🟢×3 + Penning invariance + I_sp 천장 정직 표기 (§1.3·§3.1)"

@C id013 := "stage47_falsifier" :: cross-link [d=2026-05-26]
  to = "UFO/verify/stage4-7-falsifier-preregister.md"
  role = "Stage-4~7 13 falsifier 전부 OPEN UNPROVEN (§4 ⚪) — 디지털트윈 검증 대상 아님 (결코 🟢/🔵 금지)"

@C id014 := "v1_inventory" :: cross-link [d=2026-05-26]
  to = "UFO/verify/V1_claim_inventory.md"
  role = "tier 분포 통합 ledger (🟢9·🟡8·🟠4·⚪17 · 38 claim) — verb-6 통합 verdict 의 V1 입력"

@C id015 := "analyze_link" :: cross-link [d=2026-05-26]
  to = "UFO/analyze/integrated-vehicle-analyze.md"
  role = "verb-4 analyze ⟲ — 4-layer 수렴 기준 + ⟲ coupling 8-매트릭스 + sim 위임 plan (§2·§3)"

@C id016 := "synthesize_link" :: cross-link [d=2026-05-26]
  to = "UFO/synthesize/integrated-vehicle-synthesize.md"
  role = "verb-5 synthesize — firmware 5-모듈 (자세제어 EKF · 자석 PID 6-DOF · 안전 인터록) (§3)"

@C id017 := "antimatter_link" :: cross-link [d=2026-05-26]
  to = "~/core/demiurge/ANTIMATTER.md"
  role = "Stage-3 trap SSOT — Penning 3-freq invariance |Δ|=0.0 (⓷) · Ioffe trap depth 0.35257 K (⓺) — 안정성 anchor"

@C id018 := "stdlib_link" :: cross-link [d=2026-05-26]
  to = "~/core/hexa-lang/stdlib/"
  role = "코드 SSOT (@D d3) — atlas fold 위치 embedded.gen.hexa · 본해 verified atom fold 위치 · UFO/verify 구현 코드 0줄"

# ─── §Governance (do / dont per @D d1, d5, d6, g5) ──────────────────────────
@D v1 := "ufo_verify_integrate_not_resolve" :: governance [d=2026-05-26 required active]
  do   = "verb-6 = 기존 🟢 verdict 통합 (verbatim 재인용 g5) + 4-layer 수렴 기준 충족 집계 + 안정성 falsifier 판정"
  dont = "UFO/verify 에서 무거운 sim 본해 실행 · sim 결과 값 산출/주장 · ad-hoc python (본해 = pool/cloud per @D d7 verb-4 deferred)"

@D v2 := "ufo_verify_honest_deferred" :: governance [d=2026-05-26 required active]
  do   = "본해 미수렴 layer (CFD·EM 3D·응력·열·⟲ PID) 는 🟠 INSUFFICIENT/DEFERRED 정직 표기 · breakthrough path 명시"
  dont = "본해 미수렴분을 허위 🟢 도장 · 안정성 PID 마진 미충족을 충족으로 가장 · 불가능 framing (@D d2)"

@D v3 := "ufo_verify_absorbed_gate" :: governance [d=2026-05-26 required active]
  do   = "통합 verdict 에서 absorbed 미충족 게이트 (본해 5 + F-ANTI-3) 명시 → Phase E absorbed=true 미충족 정직 판정 (@D d5)"
  dont = "projection 으로 absorbed flip · 비-wet-lab gate 미완을 PASS 로 집계 · gamma-rocket I_sp target 수 강제 (@D d6)"

@D v4 := "ufo_verify_head_isolation" :: governance [d=2026-05-26 required active]
  do   = "🛸 UFO · verify · alias verify 헤더 (@D d10) · explicit file git add (@D d9 · 4 files) · g5 verdict verbatim 재인용"
  dont = "icon/이름 변형 · 인접 worktree file 동시 staging · Stage-4~7 ⚪ 을 Stage-1~3 🟢 줄과 혼동 (UNPROVEN 유지)"

# ─── §Log (append @A / @D events here, chronological) ─────────────────────
#
# @A commit_<hash> :: UFO/verb-6-verify [d=<YYYY-MM-DD> ok]
#   <- fb5334c  # verb-5 synthesize LANDED (#203) · verb-4 analyze · Stage-1~3 verify 🟢
#   => "verb-6 verify — 디지털트윈 통합 verify ledger (Stage-1~3 9건 🟢 통합 + 4-layer 수렴 + 안정성 falsifier · 본해 deferred 정직)"
#
# See ~/core/tape/spec/tape.md for full grammar.
