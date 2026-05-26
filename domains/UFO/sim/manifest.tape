#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.6"

@I id001 := "ufo_sim" :: identity-claim [d=2026-05-25 active]
  kind     = "🛸 UFO/sim — 디지털트윈 통합 sim 엔진 사양 (HEXA-SIM 축 흡수)"
  brief    = "CFD + EM + 추진 + 응력 + 열관리 6-layer multiscale n=6 sim 엔진 manifest — UFO verb-4 analyze ⟲ + verb-6 verify 디지털트윈 통합을 받쳐주는 사양 SSOT (코드는 hexa-lang/stdlib/sim + hexa-ufo)"
  parent   = "dancinlab/demiurge"
  sibling-md = "README.md"
  source   = "github.com/dancinlab/hexa-ufo/HEXA-SIM.md"
  source-sha = "305174e70c99bb52f74beeb83a1b55e68ede6911"
  source-loc = 679

# ─── §Decisions (governance · UFO/sim absorption) ────────────────────

@D d1 := "sim 코드는 단일 SSOT" :: ufo-sim [required active]
  do   = "sim 엔진 코드는 hexa-lang/stdlib/sim/* 또는 hexa-ufo/hexa-sim/ 한 곳에만; UFO/sim 은 사양 manifest 만 유지"
  dont = "UFO/sim 내부에 sim 엔진 구현 코드 작성 — @D d3 위반"

@D d2 := "sim 디스패치는 4축 generic only" :: ufo-sim [required active]
  do   = "(domain, verb, formulation, solver) 4축 매트릭스 단일 traversal — UFO stage 별 분기 금지"
  dont = "Stage-1/2/3 별 dispatcher 클래스 분기 · stage 이름 하드코드 — @D d4 위반"

@D d3 := "n=6 산술 관통 (하드코딩 0)" :: ufo-sim [required active]
  do   = "모든 layer 의 closed-form identity 는 σ(6)·τ(6)·φ(6)·sopfr(6) 수론 함수 폐형에서 자동 유도"
  dont = "12 · 4 · 2 · 5 등 n=6 family 상수 직접 하드코딩 — assertion `σ(n)==2n` 자기검증 필수"

@D d4 := "Stage-4~7 = falsifier-only" :: ufo-sim [required active]
  do   = "warp / wormhole / dim-jump / dim-use 는 falsifier preregister + closed-form identity 만 유지; CFD/EM 실설계 sim 미적용"
  dont = "Stage-4~7 을 실설계 sim 으로 진입시켜 🟢 라벨 부여 — ⚪ falsifier-only 유지"

@D d5 := "absorbed=true ⇔ 모든 비-wet-lab gate PASS" :: ufo-sim [required active]
  do   = "sim manifest 흡수 시점 = 사양 SSOT 동기화 완료 + cross-link 4 carrier 도메인 (RTSC·FUSION·ANTIMATTER·CERN) 매핑 완결"
  dont = "코드 SSOT 미작성을 이유로 manifest 흡수를 보류 — manifest 와 코드 SSOT 는 독립 게이트"

# ─── §sim 4축 매트릭스 (instance = manifest only) ─────────────────────

@A axis_001 := "domain={cfd,em,prop,stress,therm}" :: ufo-sim
@A axis_002 := "verb={analyze,verify,synthesize}" :: ufo-sim
@A axis_003 := "formulation={NS,RANS,Maxwell,Meissner,Lorentz,MHD,gamma_rocket,FEA,heat_cond,heat_rad}" :: ufo-sim
@A axis_004 := "solver={hexa_lang.stdlib.sim.*, hexa_lang.stdlib.em_getdp, hexa_lang.stdlib.{rtsc,fusion,antimatter}.*, hexa_ufo.hexa_sim.*}" :: ufo-sim

# ─── §layer stack (6-layer multiscale n=6) ────────────────────────────

@A layer_0 := "MATERIAL · CN=6 격자 · DFT/ρ/κ/σ_e" :: ufo-sim
@A layer_1 := "MESOSCALE · n=6 · Meissner/GetDP/MHD coupling" :: ufo-sim
@A layer_2 := "CONTINUUM · φ(6)=2 · Navier-Stokes ⊗ Maxwell" :: ufo-sim
@A layer_3 := "MODULE · J2(6)=24 · 응력 FEA + 열관리 cryo" :: ufo-sim
@A layer_4 := "SYSTEM · τ(6)=4 · Stage-1~7 추진 ladder" :: ufo-sim
@A layer_5 := "INTEGRATION · σ(6)=12 · Cross-DSE 자가치유" :: ufo-sim

# ─── §Log (append @A / @D events here, chronological) ────────────────
#
# @A commit_<hash> :: ufo-sim [d=<YYYY-MM-DD> ok]
#   <- <prev-id>
#   => "<one-line description>"
#
# See ~/core/tape/spec/tape.md for full grammar.
