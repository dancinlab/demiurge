#!/usr/bin/env tape
# ARCH.tape — hexa-arch identity + domain map + absorption pattern index
# tape v1.2. Grammar primer: github.com/dancinlab/tape/blob/main/spec/tape.md

@V := "tape" :: spec [active]
  version = "1.2"

@I arch_id := "hexa-arch" :: identity-claim [d=2026-05-19 active]
  kind = "universal hexa-native technical-design architecture program + meta-conductor (design.md D11)"
  brief = "명세→구조→설계→해석⟲→합성→검증→인계 (7-verb cited, D5), 분야 플러그인; chip = lead deep 도메인, component = chain 3rd-pass 신규 top-level 도메인 (D21)"
  alias = "📐 만능 설계 아키텍쳐 프로그램"
  repo = "standalone ~/core/hexa-arch (own git, created 2026-05-18)"
  family = "typed-interface consumer (NOT absorber) of hexa-matter / hexa-bio (D2); hexa-matter 흡수 SSOT = hexa-lang (D17), hexa-arch = 소비-포인터"
  ssot = "CHARTER.md + HANDOFF.md (architecture/why) · design.md (decision audit D1..D22) · GOAL.md (north-star + 정직 위치) · PLAN.md (progress/measured) · AGENTS.tape (enforced governance)"

@L l1 := "hexa-arch-layout" :: structure [active d=2026-05-19]
  readme = "README.md — 콜드 엔트리 · 가족 위치 · Current-state snapshot"
  handoff = "HANDOFF.md — 완전 자기완결 인수인계 (0-context, §10 RESUME, D22 정합)"
  charter = "CHARTER.md — mission · scope · non-goals · 거버넌스 (D22 정합)"
  goal = "GOAL.md — 한 문장 north-star + NOT/IS + 정직한 현 위치 (g3)"
  design_audit = "design.md — 결정 감사추적 D1..D22 (gated picks SSOT)"
  plan = "PLAN.md — 진행/측정 거리 (append-only `## 진행 로그`)"
  agents_tape = "AGENTS.tape — 강제 거버넌스 (`g_stdlib_ownership` D15 · `g3_no_over_claim` · `@F f1..f5` denies)"
  arch_tape = "ARCH.tape — this · identity · 도메인맵 · 흡수/seam 패턴 인덱스"
  proposals_dir = "proposals/ — rfc_001..009 (흡수+seam+cockpit 설계 RFC 9건)"
  domains_dir = "domains/ — 15 도메인맵 (13 Cohort cited + component.md D21 + matter/ pointer D17)"
  exports_dir = "exports/ — chip/noc/f1f2/ (rfc_002 v1.0, 실 records) + seams/{materials_to_chip, chip_to_component}/ (rfc_007/008 v0, records 의도적 빈칸 = g3 위조 0)"

@N pipeline := "범용 7-verb 파이프라인 (cited, design.md D5)" :: note [d=2026-05-18 active]
  verbs = "명세 SPECIFY → 구조 ARCHITECT → 설계 DESIGN → 해석 ANALYZE ⟲ → 합성 SYNTHESIZE → 검증 VERIFY (+VALIDATE) → 인계 HANDOFF"
  basis = "9개 라이프사이클 (ISO/IEC/IEEE 15288 · V-model · NASA SE · FDA · EDA · MBSE/OOSEM · PLM · 가속기 · spacecraft) 전수조사 — design.md Decision 5"
  analyze_iterates = "ANALYZE 는 반복 게이트 (CAE↔CAD), terminal 아님"
  verify_validate = "표준상 별 verb 이나 같은 게이트 위치 — 의도된 압축"
  domain_neutral = "Cohort 1+2 (D3+D6) = chip(deep) + 13 shallow (cern·antimatter·rtsc·space·energy·brain·fusion·scope·sscb·mobility·bot·grid·aura); plus component(D21) = chain 3rd-pass 신규 top-level 도메인. Meta-conductor chain (D11): materials→chip→component, 각 seam = rfc_007/008 typed contract."

@N chip_absorb_map := "chip 도메인 외부 공개면 매핑 (7-verb 1:1)" :: note [d=2026-05-18 active]
  source = "HANDOFF.md §5 (SSOT — 7-verb 행 × OSS/상용공개문서 열 + 횡단자원 + 흡수순서)"
  boundary = "공개면 클린룸 (design.md D1) — OSS+arxiv+특허+표준+상용툴 공개문서, closed-binary RE 0"
  first_absorption = "BookSim2 (gem5 아님 — Agent-2 cited) + per-link wire-delay 모델 + Leighton oracle"
  rfc = "proposals/rfc_001_booksim2_noc_absorption.md"
  shared_abstraction = "MC transport (Geant4/OpenMC) + FEM EM/thermal (FEMM/COMSOL공개) = 6 도메인 중 5 공통 (Agent-3)"

@D d_absorption := "도메인별 외부-흡수 패턴" :: decision [d=2026-05-19 active]
  rule = "각 외부 도구 = proposals/rfc_0NN_<tool>_absorption.md 1개. 측정 게이트 전 흡수 주장 0 (g3). 재도출 모듈은 hexa-lang/stdlib/ 행 (D15 — hexa-arch 는 소비자, stdlib 미보유)."
  bounded_exception = "rfc_048-precedented bounded-subprocess: verbatim 외부기질을 문서화된 fail-loud subprocess 로 호출 가능 (선례 D14 hexa-matter shim — D17으로 무효; D18 Yosys ABC — 활성). 재도출 = scheduled follow-on."
  mirror = "hexa-lang/proposals/rfc_047_mc_integrate · rfc_048_xeno (동형)"
  order = "NoC sim 먼저(rfc_001/003 done) → Yosys(rfc_006 설계, 모듈 D19로 hexa-lang 세션) → ..."

@D d_comb_decouple := "comb 와 분리" :: decision [d=2026-05-18 active]
  rule = "hexa-lang `comb` 는 hexa-arch[chip] 의 *소비자*. comb 는 EDA 흡수 주체 아님. hexa-arch ≠ comb."
  comb_needs = "T1 NoC sim (F1/F2) · T2 RTL+cycle sim · T3 tapeout-ready 설계 (fab X)"

@D d_nongoal := "non-goals" :: governance [required d=2026-05-19 active]
  no_fab = "실제 fab/FPGA 안 함 — 설계 산출물만"
  no_overclaim = "측정 게이트 전 'absorbed/parity/resolved' 주장 금지 (g3 · AGENTS.tape `g3_no_over_claim` · `@F f2/f4`)"
  hexa_native = "외부도구 흡수는 hexa intrinsics 로 (g5). 재도출 모듈은 hexa-lang/stdlib/ 행(D15 · `@F f1`). bounded-subprocess 예외 = rfc_048-precedented, D18(Yosys ABC) 활성 선례."
  no_bigbang = "증분·도메인별 absorption-RFC. D10 design-only 비목표는 D12로 RESCIND — 풀스코프 허용, 게이트 규율이 진정성을 강제."

@N related := "관련 repo / 표면" :: note [d=2026-05-19 active]
  hexa_lang = "~/core/hexa-lang — substrate + **stdlib SSOT (D15)**; comb/ 첫 소비자; 흡수-RFC 패턴 출처. 재도출 모듈 호스트: stdlib/booksim/(rfc_003, commit d5a63a82 미push) · stdlib/yosys/(rfc_006 §4 미구현, D19 hexa-lang 세션 몫)."
  hexa_matter = "~/core/hexa-matter — sibling; **흡수 SSOT = hexa-lang (D17)**. hexa-arch 의 domains/matter/ 는 pointer README (사본 아님)."
  hexa_chip = "~/core/hexa-chip — **별개 기존 repo** (5G/6G·packaging·accel). hexa-arch chip 도메인과 다름."
  hexa_space = "~/core/hexa-space — 별개; 향후 space 도메인 연계 가능."
  product_surface = "macOS Swift cockpit (D16, rfc_009 spec) — typed-consumer of exports/. 빌드는 **범위밖** here (D22, downstream 세션). 공개 honest-audit = public GitHub repo 자체."

@D d_typed_interface := "타입드 인터페이스 / chain seam 인덱스" :: decision [d=2026-05-19 active]
  picked = "producer-owned exports/ (design.md D7)"
  carrier = "HXC v2 byte-canonical + tape v1.2 audit sibling (hexa-lang @D g_hxc — 불변)"
  f1f2_chip_to_comb = "rfc_002 (schema v1.0) · exports/chip/noc/f1f2/{schema, records, pair_verdicts} — 실제 records 다수 (NoC GATE_B_PINNED_MET 측정 기반)"
  seam_materials_to_chip = "rfc_007 (schema v0, D20) · exports/seams/materials_to_chip/{schema/v0.md, records/README.md} — records 의도적 빈칸(g3): producer = 외부 hexa-matter/hexa-lang(D17), hexa-arch 가 위조하면 @F f2"
  seam_chip_to_component = "rfc_008 (schema v0, D21) · exports/seams/chip_to_component/{schema/v0.md, records/README.md} — records 의도적 빈칸(g3): producer = hexa-arch[chip] 이나 측정된 chip HANDOFF 부재(NoC GATE_B_PINNED_MET, synth design-only)"
  atlas_promotion = "deferred until 2nd consumer beyond comb (e.g. cern/grid)"

@N status := "4-Phase design-complete (g3 — 측정 거리만)" :: note [d=2026-05-19 active]
  state = "rfc_001..009 (9 RFC) + design.md D1..D22 + exports/{chip/noc/f1f2 실 records, seams/*/ 빈 records×2 의도적} + domains/*.md ×15 (Cohort 1 6 + Cohort 2 7 + component D21 cited + matter/ pointer D17) + AGENTS.tape + CHARTER + HANDOFF + GOAL + PLAN reconciled to D22; **코드/앱 0, 어떤 도메인도 absorbed=true 아님**"
  baseline = "rfc_001 §8 외부-reference baseline complete (Agent-1, BookSim2 28f43299) — d=6 hex vs d=4 mesh at single (4 GHz · 22 nm) point; Leighton 6/6 PASS. chip NoC §B = GATE_B_PINNED_MET (pinned PASS; full-curve/§D 미입증). regime 주장 아님."
  next_in_boundary = "in-boundary 잔여 작업 0 — 외부 cold reader 정직성 닫힘 (README · CHARTER · HANDOFF · GOAL · AGENTS.tape · ARCH.tape 전부 D22 정합)."
  next_out_of_boundary = "② D19 rfc_006 §4 Yosys 모듈 (hexa-lang 세션) · ③ d5a63a82 push (hexa-lang 세션) · ④ chip 측정 (gated, 큰 투자) · ⑤ Swift 빌드 (D22 downstream). inbox handoff 적재: hexa-lang/inbox/notes/2026-05-19-hexa-arch-rfc006-yosys-handoff.md + PATCHES.yaml +2."
  decisions = "design.md D1..D22 — D1 클린룸·D2 typed-consume·D3 코호트1·D5 7-verb spine·D6 코호트2·D7 producer-owned·D9 GATE_B_PINNED_MET·D10 design-only(RESCINDED by D12)·D11 메타-컨덕터·D14 hexa-matter hybrid(MOOT by D17)·D15 stdlib⊂hexa-lang·D16 macOS Swift surface·D17 hexa-matter SSOT=hexa-lang·D18 Yosys ABC bounded-subprocess·D19 yosys impl→hexa-lang 세션·D20 rfc_007 seam·D21 component=신규 top-level 도메인·D22 rfc_009 cockpit spec(빌드 OOS)"
