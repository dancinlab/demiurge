#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/meta/lattice-policy" :: identity-claim [d=2026-05-26 active]
  kind = "UFO Phase D 메타 — LATTICE_POLICY 흡수 manifest (lattice arithmetic + token consistency + 13-falsifier monotone)"
  brief = "n=6 격자는 한계를 정하지 않는다 — 격자 산술은 검증 가능한 정수 항등식이되 물리 ceiling 이 아니다"
  parent = "dancinlab/demiurge/UFO"
  sibling-md = "lattice-policy.md"
  phase = "D (메타)"

@I id002 := "ufo_lattice_policy_head" :: identity [d=2026-05-26 active]
  icon  = "🛸"
  name  = "UFO/meta/lattice-policy"
  alias = "lattice-policy"
  source = "UFO/LATTICE_POLICY.md (SHA 187421115cead27da6fa115cbc90579829c3217e · 242 LOC · Wave K)"

# ─── §Config — n=6 lattice arithmetic (검증 가능한 정수 항등식) ──────────────
#
@C id010 := "n6_divisors" :: config [d=2026-05-26]
  n = "6 (첫 완전수 · perfect number)"
  divisors = "{1, 2, 3, 6}"

@C id011 := "n6_primitives" :: config [d=2026-05-26]
  sigma = "12 (Σd · OEIS A000203)"
  phi = "2 (Euler totient · OEIS A000010)"
  tau = "4 (약수 개수 · OEIS A000005)"
  sopfr = "5 (소인수 합 2+3 · OEIS A001414)"
  j2 = "24 (2·sigma · Mathieu/Leech)"

@C id012 := "n6_master_identity" :: config [d=2026-05-26]
  identity = "sigma(6)*phi(6) = n*tau(6) = J2 = 24 (12*2 = 6*4 = 24)"
  sigma_tau = "sigma(6)*tau(6) = 48 (12*4)"
  derived = "(sigma-phi)^2 = 100 · sigma^2 = 144"
  class = "Pi-0-1-arithmetical -> Delta-0-absolute (유한 검산 · 모든 모형 불변)"

# ─── §Decision — token consistency 정책 (source §1.3 흡수) ──────────────────
#
@D d1 := "격자 anchor 단독-HARD 금지" :: governance [required active]
  do = "lattice arithmetic 는 자기-일관성 보조 체크로만 · σ·φ=24 단독 HARD 배치 금지"
  dont = "격자-동어반복(tautology)을 단독 HARD 검증 anchor 로 배치 · 외부 도메인 적용"

@D d2 := "실제 한계 anchor 우선" :: governance [required active]
  do = "검증 anchor 는 real-limits (Shannon · Stefan-Boltzmann · Carnot · Lawson · 산업 ceiling) ≥1"
  dont = "프로젝트 ceiling 을 n=6 격자로 정의 · 산술 한계를 물리 한계로 위장"

@D d3 := "over-claim 회피 + falsifier threshold" :: governance [required active]
  do = "falsifier 는 physical/industry threshold 초과로 판정 · 외부는 그 도메인 고유 invariant 로"
  dont = "외부 entity 가 n=6 을 따른다 주장 · 격자-fit(χ² to lattice) falsifier 추가"

@D d4 := "산술 닫힘 ≠ 물리 닫힘 — token consistency PASS 의 의미" :: governance [required active]
  do = "verify PASS = lattice arithmetic + 식별자 토큰 일관성 (3-surface 정합) 검증 결과로 해석"
  dont = "PASS 를 empirical/물리 claim 검증으로 오독 · 13-falsifier OPEN 을 닫힘으로 위장"

# ─── §Config — 13-falsifier monotone 닫힘 상태 (source .roadmap §B 흡수) ─────
#
@C id020 := "falsifier_monotone" :: config [d=2026-05-26]
  set = "{OPEN, CONFIRMED, DEMOTED}"
  rule = "OPEN -> CONFIRMED 또는 OPEN -> DEMOTED 만 허용 · silent retract 금지"
  total = "13 (F-WARP=3 · F-WORM=3 · F-DIM=3 · F-USE=4)"
  state_at_v1 = "전부 OPEN @ v1.0 — 산술은 닫힘(검증 가능) · 물리는 OPEN(미증명)"

# ─── §Cross-link (sibling manifests + source SSOT) ─────────────────────────
#
@C id030 := "source_link" :: cross-link [d=2026-05-26]
  to = "UFO/LATTICE_POLICY.md"
  role = "SSOT 정책 원문 (흡수 source · SHA 187421115)"

@C id031 := "sister_link" :: cross-link [d=2026-05-26]
  to = "UFO/meta/limit-breakthrough.md"
  role = "sister manifest — n=6 uniqueness → alien_index 🛸6→🛸ABSOLUTE 체인"

@C id032 := "falsifier_link" :: cross-link [d=2026-05-26]
  to = "UFO/verify/stage4-7-falsifier-preregister.md"
  role = "13-falsifier 측정량·임계 상세 ledger (Phase A)"

@C id033 := "roadmap_link" :: cross-link [d=2026-05-26]
  to = "UFO/.roadmap.hexa_ufo"
  role = "§A.1 invariant lattice 표 + §B Stage-4~7 13-falsifier preregister (SSOT)"

# ─── §Log (append @A / @D :: decision events to .log.tape, chronological) ──
#
# Pre-existing log entries live in UFO.log.md (newest-on-top).
# 흡수 = manifest only · 구현 코드 0줄 (@D d3 demiurge governance).
# See ~/core/tape/spec/tape.md for full grammar (17-type alphabet closed).
