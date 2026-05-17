#!/usr/bin/env tape
# ARCH.tape — hexa-arch identity + domain map + absorption pattern index
# tape v1.2. Grammar primer: github.com/dancinlab/tape/blob/main/spec/tape.md

@V := "tape" :: spec [active]
  version = "1.2"

@I arch_id := "hexa-arch" :: identity-claim [d=2026-05-18 draft]
  kind = "universal hexa-native technical-design architecture program"
  brief = "설계→쌓기→적층→검증→계산, 분야는 플러그인 도메인; chip 첫 도메인"
  alias = "📐 만능 설계 아키텍쳐 프로그램"
  repo = "standalone ~/core/hexa-arch (own git, created 2026-05-18)"
  family = "hexa-matter(물질·소재) · hexa-bio(화학분자) 형제 — 외부-흡수 패턴 동일"
  ssot = "CHARTER.md + HANDOFF.md (architecture/why) · PLAN.md (progress/measured)"

@L l1 := "hexa-arch-layout" :: structure [active]
  README.md -> "콜드 엔트리 · 가족 위치"
  HANDOFF.md -> "완전 자기완결 인수인계 (0-context, 외부매핑 전수, RESUME)"
  CHARTER.md -> "mission · scope · non-goals · 거버넌스"
  PLAN.md -> "진행 로그 SSOT (measured-distance)"
  ARCH.tape -> "this · identity · 도메인맵 · 흡수 패턴"

@N pipeline := "범용 5-verb 파이프라인" :: note [d=2026-05-18 active]
  verbs = "설계(model) → 쌓기(synthesize) → 적층(layer) → 검증(verify) → 계산(simulate)"
  domain_neutral = "분야 무관 — chip 은 인스턴스 1개; space/mech 후속"

@N chip_absorb_map := "chip 도메인 외부 오픈소스 전수 (흡수 대상)" :: note [d=2026-05-18 active]
  noc_sim = "gem5(+Garnet) · BookSim2 · Noxim · Ratatoskr  — 첫 흡수, comb F1/F2 직격"
  synth = "Yosys (RTL→netlist)"
  layout = "OpenROAD/OpenLane2 · Magic · KLayout (place&route→GDSII)"
  verify = "Verilator · cocotb · SymbiYosys(formal) · OpenSTA(timing)"
  analog = "ngspice"
  pdk = "SkyWater SKY130 · IHP SG13G2 (fab-free, tapeout-ready 설계용)"
  rtl_gen = "Chisel/FIRRTL · Amaranth"
  full = "HANDOFF.md §5"

@D d_absorption := "도메인별 외부-흡수 패턴" :: decision [d=2026-05-18 active]
  rule = "각 외부 도구 = proposals/rfc_0NN_<tool>_absorption.md 1개. python 0 · shell-out 0 · 측정 · 가짜진전 0."
  mirror = "hexa-lang/proposals/rfc_047_mc_integrate · rfc_048_xeno (동형)"
  order = "NoC sim 먼저 (빅뱅 금지, 증분·측정)"

@D d_comb_decouple := "comb 와 분리" :: decision [d=2026-05-18 active]
  rule = "hexa-lang `comb` 는 hexa-arch[chip] 의 *소비자*. comb 는 EDA 흡수 주체 아님. hexa-arch ≠ comb."
  comb_needs = "T1 NoC sim (F1/F2) · T2 RTL+cycle sim · T3 tapeout-ready 설계 (fab X)"

@D d_nongoal := "non-goals" :: governance [required d=2026-05-18 active]
  no_fab = "실제 fab/FPGA 안 함 — 설계 산출물만"
  no_overclaim = "측정 feature-parity 전엔 '흡수' 주장 금지 (g1·g2·g3)"
  hexa_native = "외부도구는 hexa stdlib+cli 로 흡수, shell-out X (g5)"

@N related := "구분 — 별개 기존 repo" :: note [d=2026-05-18 active]
  hexa_chip = "~/core/hexa-chip — 5G/6G·packaging·accel. hexa-arch chip 도메인과 다름"
  hexa_space = "~/core/hexa-space — 별개; 향후 space 도메인 연계 가능"
  hexa_lang = "~/core/hexa-lang — substrate; comb/ 첫 소비자; 흡수-RFC 패턴 출처"

@N status := "scaffold" :: note [d=2026-05-18 active]
  state = "문서 5개만, 코드 0"
  next = "proposals/rfc_001_noc_sim_absorption.md (BookSim2/gem5-Garnet)"
