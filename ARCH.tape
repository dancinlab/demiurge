#!/usr/bin/env tape
# ARCH.tape — hexa-arch identity + domain map + absorption pattern index
# tape v1.2. Grammar primer: github.com/dancinlab/tape/blob/main/spec/tape.md

@V := "tape" :: spec [active]
  version = "1.2"

@I arch_id := "hexa-arch" :: identity-claim [d=2026-05-18 draft]
  kind = "universal hexa-native technical-design architecture program"
  brief = "명세→구조→설계→해석⟲→합성→검증→인계 (7-verb cited), 분야 플러그인; chip 첫/리드 도메인"
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

@N pipeline := "범용 7-verb 파이프라인 (cited, design.md D5)" :: note [d=2026-05-18 active]
  verbs = "명세 SPECIFY → 구조 ARCHITECT → 설계 DESIGN → 해석 ANALYZE ⟲ → 합성 SYNTHESIZE → 검증 VERIFY (+VALIDATE) → 인계 HANDOFF"
  basis = "9개 라이프사이클 (ISO/IEC/IEEE 15288 · V-model · NASA SE · FDA · EDA · MBSE/OOSEM · PLM · 가속기 · spacecraft) 전수조사 — design.md Decision 5"
  analyze_iterates = "ANALYZE 는 반복 게이트 (CAE↔CAD), terminal 아님"
  verify_validate = "표준상 별 verb 이나 같은 게이트 위치 — 의도된 압축"
  domain_neutral = "명시 코호트 = chip · cern · antimatter · rtsc · space · energy · brain (design.md D3)"

@N chip_absorb_map := "chip 도메인 외부 공개면 매핑 (7-verb 1:1)" :: note [d=2026-05-18 active]
  source = "HANDOFF.md §5 (SSOT — 7-verb 행 × OSS/상용공개문서 열 + 횡단자원 + 흡수순서)"
  boundary = "공개면 클린룸 (design.md D1) — OSS+arxiv+특허+표준+상용툴 공개문서, closed-binary RE 0"
  first_absorption = "BookSim2 (gem5 아님 — Agent-2 cited) + per-link wire-delay 모델 + Leighton oracle"
  rfc = "proposals/rfc_001_booksim2_noc_absorption.md"
  shared_abstraction = "MC transport (Geant4/OpenMC) + FEM EM/thermal (FEMM/COMSOL공개) = 6 도메인 중 5 공통 (Agent-3)"

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

@N status := "scaffold + redesign-applied" :: note [d=2026-05-18 active]
  state = "문서 6개 (design.md 추가) + 첫 RFC 골격; 코드 0"
  next = "proposals/rfc_001_booksim2_noc_absorption.md (BookSim2 + per-link wire-delay + Leighton oracle)"
  decisions = "design.md D1..D5 (research-boundary · matter/bio-decouple · cohort-sequencing · research-first · 7-verb spine)"
