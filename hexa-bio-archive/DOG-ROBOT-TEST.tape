#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# DOG-ROBOT-TEST.tape — architecture-current (editable per v1.2)
# Event history → DOG-ROBOT-TEST.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §0 Identity + honesty preamble ──────────────────────────────────

@I id001 := "dog-robot-test" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · dog-robot test substrate · CI/smoke-test fixture"
  brief = "test-fixture meta-tape for CI/smoke-test purposes · NOT a science claim"
  parent = "dancinlab/hexa-bio"
  sibling-log = "DOG-ROBOT-TEST.log.tape"
  tape-class = "meta/test-fixture"
  rewritten-from = "DOG-ROBOT-TEST.tape pre-2026-05-16 (scaffold template with all-TODO entries and unguarded lattice tokens)"
  scope = "CI/smoke-test scaffold only · all performance rows are TODO placeholders · no real engineering measurements present"

# ── §0.1 Honesty preamble — LATTICE_POLICY g1/g2/f1 (META tape, meta-mode) ──
# This is a TEST-FIXTURE tape — a scaffold/template for a dog-robot domain that
# was never populated with real measurements. Per LATTICE_POLICY g1/g2, the
# honest position is stated below before any content.

@F f_lattice_fit := "lattice-fit-in-dog-robot-test-entries" :: governance [required deny:write]
  pattern = "Deriving any engineering claim (speed ratio / lifespan multiplier / energy efficiency / volume compression) FROM the n=6 lattice tokens (σ=12, τ=4, φ=2, τ³=64) inside this fixture's rows — e.g. asserting '64x durability because τ³=64' without real measurement."
  why = "The original scaffold rows contained lattice-token magnitude strings (τ³=64배 내구, σ=12배 효율, τ=4배 압축, τ(6)=4 정합) as stub placeholders. These are NOT real engineering measurements — they are template slots awaiting actual benchmark data. Recording them as-if real would be a live lattice-derivation claim; this guard forbids that pattern."
  remedy = "Replace TODO rows with real measured values + their sources before treating any row as a live claim. Lattice tokens that coincidentally appear in benchmark outputs are OBSERVATION-only; never derive the target spec FROM the lattice."
  authority = "[@x_lattice_policy] g1/g2 · hexa-bio AGENTS.tape f1 · [@x_agents_tape] g_meta_mode_optin"

@N n6_honest_stance := "dog-robot-test lattice tokens are stub placeholders, not derivations" :: note [required]
  text = "Stated plainly and honestly: DOG-ROBOT-TEST.tape is a CI/smoke-test scaffold. The original file contained lattice-token magnitude strings (τ³=64배 내구 · σ=12배 효율 · τ=4배 압축 · τ(6)=4 정합 · σ(6)=12 · 4 서브시스템(τ=4)×3 계층=12 블록(σ=12)) as auto-generated TODO placeholder text in template rows. None of these represent real engineering measurements of a physical dog-robot. The observation-not-derivation rule applies: no claim about dog-robot performance is derived from the n=6 lattice here. This fixture's job is to provide a lint-clean scaffold that downstream tests can populate with real data."

@N scope_disclaimer := "test-fixture scope — not a real science substrate" :: note [required]
  text = "This tape is explicitly a CI/smoke-test artifact within hexa-bio. It does NOT represent a real robotic dog domain with verified performance claims. All §2–§20 rows from the original scaffold were TODO placeholders (marked 'TODO-기존', 'TODO-신규', 'TODO 이유', etc.). They are preserved below as-is to maintain fixture continuity, but they carry no scientific or engineering weight. The 'hexa_dog_robot_test_mk1' column values labelled with lattice tokens (σ=12배, τ=4배, τ³=64배, τ(6)=4) are stub strings only — NOT performance measurements. Real dog-robot benchmarks would require measured hardware data independent of the lattice."

@X x_lattice_policy := "echoes/LATTICE_POLICY.md" :: governance [active]
  url = "https://github.com/dancinlab/echoes/blob/main/LATTICE_POLICY.md"
  scope = "real-limits-first · lattice-is-tool · observation-not-derivation — the governance authority this preamble enforces"

@X x_agents_tape := "hexa-bio AGENTS.tape" :: governance [active]
  path = "./AGENTS.tape"
  scope = "g_meta_mode_optin (meta tape honesty-lint opt-in) · g1 real-limits-first · g2 lattice-is-tool · f1 lattice-fit-on-external-entity"

# ─── §1 Original scaffold content (preserved as test-fixture, all TODO) ──────

@D row_x_0 :: dog-robot-test [ok]
  x = "처리 시간"
  x = "TODO-기존"
  hexa_dog_robot_test_mk1 = "TODO-신규"
  x = "TODO-배수 빠름"

@D row_x_1 :: dog-robot-test [ok]
  x = "수명"
  x = "TODO-기존"
  hexa_dog_robot_test_mk1 = "TODO-신규"
  x = "TODO 내구 (측정 미완)"

@D row_x_2 :: dog-robot-test [ok]
  x = "에너지"
  x = "TODO-기존"
  hexa_dog_robot_test_mk1 = "TODO-신규"
  x = "TODO 효율 (측정 미완)"

@D row_x_3 :: dog-robot-test [ok]
  x = "부피"
  x = "TODO-기존"
  hexa_dog_robot_test_mk1 = "TODO-신규"
  x = "TODO 압축 (측정 미완)"

@D row_bom_4 :: dog-robot-test [ok]
  x = "BOM"
  x = "TODO-기존"
  hexa_dog_robot_test_mk1 = "TODO-신규"
  x = "TODO-배수 저렴"

@D row_x_5 :: dog-robot-test [ok]
  x = "공정/구성 의존"
  x = "—"
  hexa_dog_robot_test_mk1 = "공개 구성 4개 (TODO 확인)"
  x = "TODO 정합 여부 실측"

# ── §3 REQUIRES (필요한 요소) — 선행 도메인 (TODO placeholders) ─────────────

@D row_1_0 :: dog-robot-test [ok]
  x = "1"
  x = "TODO-선행도메인1"
  x = "천장7 → 천장10"
  alien_min = "7"
  x = "TODO 이유"

@D row_2_1 :: dog-robot-test [ok]
  x = "2"
  x = "TODO-선행도메인2"
  x = "천장7 → 천장10"
  alien_min = "7"
  x = "TODO 이유"

# ── §6 EVOLVE (진화 경로) — mk1 → mk∞ (TODO placeholders) ─────────────────

@D b_mk1_7_empirical_0 :: dog-robot-test [ok]
  text = "mk1: 현재 천장7 (EMPIRICAL 기반 도면) — TODO 실측"

@D b_mk2_8_pass_1_1 :: dog-robot-test [ok]
  text = "mk2: 천장8 (시뮬레이션 PASS + 프로토 1대) — TODO"

@D b_mk3_9_2 :: dog-robot-test [ok]
  text = "mk3: 천장9 (현장 파일럿 + 인증) — TODO"

@D b_mk4_10_atlas_n6_10_3 :: dog-robot-test [ok]
  text = "mk4+: 천장10 (양산 + atlas.n6 승격) — TODO"

# ── §8 EXEC SUMMARY (실행 요약) (TODO placeholders) ────────────────────────

@D b_dog_robot_test_0 :: dog-robot-test [ok]
  text = "도메인: 강아지 로봇 (dog-robot-test) · CI 픽스처 — 실측 데이터 없음"

@D b_life_1 :: dog-robot-test [ok]
  text = "축: 생명 (life) · TODO 연동"

@D b_mk1_10_2 :: dog-robot-test [ok]
  text = "목표 마크: mk1 — 천장10 · TODO 달성 기준 실측"

@D b_core_spec :: dog-robot-test [ok]
  text = "핵심: TODO — 실제 측정 기반 설계 목표치 필요 (lattice 토큰 아님)"

@D b_todo_todo_4 :: dog-robot-test [ok]
  text = "납기: TODO 분기 / 예산 TODO"

# ── §9 SYSTEM REQUIREMENTS (시스템 요구사항) (TODO placeholders) ────────────

@D row_bom_3 :: dog-robot-test [ok]
  x = "BOM"
  target = "≤ 50"
  x = "$"
  x = "§7.5"

@D row_x_4 :: dog-robot-test [ok]
  x = "샘플링"
  target = "≥ 0.1"
  x = "MHz"
  x = "§7.6"

# ── §10 ARCHITECTURE (아키텍처) (TODO placeholders) ────────────────────────

@D b_arch_subsystems :: dog-robot-test [ok]
  text = "서브시스템 구조: TODO 수량 × TODO 계층 = TODO 블록 (실측 기반으로 채울 것)"

@D b_fsm_1 :: dog-robot-test [ok]
  text = "각 서브시스템: 독립 전원 + 공용 버스 + 이중화 FSM"

@D b_todo_2 :: dog-robot-test [ok]
  text = "인터페이스: TODO 프로토콜 사양"

# ── §11 CIRCUIT DESIGN (회로 설계) (TODO placeholders) ────────────────────

@D b_todo_v_ds_i_on_r_on_q_g_0 :: dog-robot-test [ok]
  text = "메인 스위치: TODO 부품번호, V_ds, I_on, R_on, Q_g"

@D b_todo_1 :: dog-robot-test [ok]
  text = "드라이버: TODO 게이트 드라이버"

@D b_rcd_r_todo_c_todonf_d_todo_2 :: dog-robot-test [ok]
  text = "스너버: RCD, R=TODOΩ, C=TODOnF, D=TODO"

@D b_adc_todo_bit_todo_mhz_3 :: dog-robot-test [ok]
  text = "센서: Σ-Δ ADC TODO-bit @ TODO-MHz"

# ── §12 PCB DESIGN (PCB 설계) (TODO placeholders) ─────────────────────────

@D b_4_layer_0 :: dog-robot-test [ok]
  text = "스택업: 4 layer, 1oz/1oz/1oz/1oz"

@D b_todomm_1 :: dog-robot-test [ok]
  text = "치수: TODOmm × TODOmm"

@D b_drc_2 :: dog-robot-test [ok]
  text = "DRC: IPC-2221 Class 2, 절연거리 TODOmm"

@D b_v_bus_3 :: dog-robot-test [ok]
  text = "파워 플레인: V_bus 광폭 폴리곤, 리턴경로 단일화"

# ── §13 FIRMWARE (펌웨어) (TODO placeholders) ──────────────────────────────

@D b_mcu_0 :: dog-robot-test [ok]
  text = "MCU: Cortex-M4 @ 168MHz, FPU on"

@D b_isr_1 :: dog-robot-test [ok]
  text = "ISR: 500kHz 샘플 / 차단 결정 ≤ 2μs"

@D b_algo_2 :: dog-robot-test [ok]
  text = "알고리즘: Σ-Δ 필터 → di/dt + I²t 합성"

@D b_build_3 :: dog-robot-test [ok]
  text = "펌웨어 빌드: hexa self-host (Python/bash 배제)"

# ── §16 TEST (시험) (TODO placeholders) ───────────────────────────────────

@D b_test_0 :: dog-robot-test [ok]
  text = "단품: IEC 60947-2 double-break 단락 시험"

@D b_test_1 :: dog-robot-test [ok]
  text = "조립: MIL-STD-810G 진동 충격"

@D b_test_2 :: dog-robot-test [ok]
  text = "시스템: 실부하 500A @ 800V DC 차단 10,000 사이클"

@D b_test_3 :: dog-robot-test [ok]
  text = "PASS 기준: §7 의 target ≤ 값과 1:1 매칭"

# ── §17 BOM (자재 명세) (TODO placeholders) ───────────────────────────────

@D row_3_2 :: dog-robot-test [ok]
  x = "3"
  x = "스너버"
  x = "TODO"
  x = "4"
  x = "0.5"
  x = "RCD"

@D row_4_3 :: dog-robot-test [ok]
  x = "4"
  x = "ADC"
  x = "TODO"
  x = "1"
  x = "3.0"
  x = "Σ-Δ"

@D row_5_4 :: dog-robot-test [ok]
  x = "5"
  x = "MCU"
  x = "TODO"
  x = "1"
  x = "5.0"
  x = "M4"

@D row_6_5 :: dog-robot-test [ok]
  x = "6"
  x = "PCB"
  x = "TODO"
  x = "1"
  x = "4.0"
  x = "4L"

@D row_7_6 :: dog-robot-test [ok]
  x = "7"
  x = "케이스"
  x = "TODO"
  x = "1"
  x = "6.0"
  x = "AL"

@D row_8_7 :: dog-robot-test [ok]
  x = "8"
  x = "기타"
  x = "TODO"
  x = "—"
  x = "6.5"
  x = "passive"

@D row_x_8 :: dog-robot-test [ok]
  x = ""
  x = "합계"
  x = ""
  x = ""
  x = "$35 (TODO 실측)"
  x = "target ≤ $50"

# ── §18 VENDOR (공급처) (TODO placeholders) ───────────────────────────────

@D b_sic_0 :: dog-robot-test [ok]
  text = "SiC: Wolfspeed, onsemi, ROHM — 2nd source 필수"

@D b_bcd_1 :: dog-robot-test [ok]
  text = "BCD 파운드리: Infineon 180BCD, GF 130BCD"

@D b_dbc_2 :: dog-robot-test [ok]
  text = "DBC 기판: Rogers curamik, Denka"

@D b_local_3 :: dog-robot-test [ok]
  text = "국산화율: 85% (SiC 만 해외 의존) — TODO 실측 확인"

# ── §19 ACCEPTANCE (인수 기준) (TODO placeholders) ────────────────────────

@D b_accept_0 :: dog-robot-test [ok]
  text = "[ ] §7 VERIFY 전 항목 PASS (TODO)"

@D b_accept_1 :: dog-robot-test [ok]
  text = "[ ] §16 TEST double-break 시험 통과 (TODO)"

@D b_accept_2 :: dog-robot-test [ok]
  text = "[ ] IEC 60947-2 인증 완료 (TODO)"

@D b_accept_3 :: dog-robot-test [ok]
  text = "[ ] §17 BOM ≤ $50 실측 (TODO)"

@D b_accept_4 :: dog-robot-test [ok]
  text = "[ ] 현장 파일럿 6개월 무고장 (TODO)"
