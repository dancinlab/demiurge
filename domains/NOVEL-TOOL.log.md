# NOVEL-TOOL — log

Append-only history sister of `NOVEL-TOOL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25 — 13 stdlib primitive atlas tier 승급: self-test 13/13 PASS · atlas-register 0/13 (path gap, honest)

자료: `exports/sweep/novel_tool_atlas_tier_2026-05-25.json`

### self-test 13/13 PASS (canonical root · mini `~/core/hexa-lang`)

- [x] 13개 primitive 전부 self-test sentinel `__HEXA_STDLIB_<PATH>__ PASS` 출력 (N/N checks passed + FALSIFIERS 게이트 통과)
  - 실행법: origin/main(bf9f9840·#924) 소스를 canonical root 에 additive-copy → working `hexa.real` 로 실행 → 즉시 cleanup (canonical root 원상복구, stdlib 수정 0). #921 worktree-binary gap 회피 (worktree cached runtime.o 는 `_sqrt_pure` 미포함 → linker fail; canonical root runtime.o 만 정상).
  - wheeler #892 (5/5) · solenoid_endleakage #896 (5/5) · elliptic_K_E #897 (`special/elliptic.hexa`, 8/8) · current_loop_offaxis #900 (7/7) · mutual_M_coaxial #902 (6/6) · ks_two_sample #903 (5/5) · gauss_legendre_6 #905 (`quadrature/gauss_legendre.hexa`, 7/7) · demag_factor #908 (5/5) · welford #909 (5/5) · halbach_envelope #915 (5/5) · logsumexp #916 (5/5) · kahan_sum #918 (5/5) · lambert_w #919 (`special/lambert_w.hexa`, 5/5)

### atlas register 0/13 — 🟠 INSUFFICIENT (honest: register path gap)

- [x] `hexa atlas register --from-verify <fn> ...` 시도 → 13개 전부 🟠 INSUFFICIENT
  - 실증: `register --from-verify lambert_w 1.0 0.5671...` → `tier=🟠 INSUFFICIENT · reason=hexa verify --expr lambert_w has no calculator path · gap=add lambert_w to tool/verify_cli.hexa`. wheeler 동일.
  - root cause: register 의 recompute 는 `tool/verify_cli.hexa::_recompute_float` / `_is_float_fn` HARDCODED whitelist(~67 closed-form fn) 만 인정. NOVEL-TOOL 13개 primitive 중 0개가 whitelist 에 존재. register 두 arm(`--from-verify`·`--from-drill`) 어느 것도 stdlib self-test sentinel 을 register 근거로 못 씀 — `--from-selftest` arm 부재.
  - 정직한 tier: 13개 모두 **🟢-by-selftest** (sentinel PASS = libm-class numerical match + FALSIFIER 게이트) — 그러나 **atlas-registered = 0**. "진짜 atlas-registered" 0 / "self-test-only 🟢" 13.

### INBOX handoff 후보 (hexa-lang)

- [ ] slug `stdlib-primitive-atlas-register-path-gap` → hexa-lang INBOX.log.md
  - 제안 (a) `hexa atlas register --from-selftest <hexa-file>` arm: sentinel PASS 시 🟢 SUPPORTED-NUMERICAL 등록 (d4 single-generic-dispatch 부합, per-primitive 하드코딩 회피) · (b) 13개를 `_recompute_float`/`_is_float_fn` 에 일괄 등록 (@D g20 single-calc-home 준수). (a) 선호.

### round 1 · /cycle (3 milestones)

- [x] Wheeler primitive stdlib promotion
  - demiurge PR #106 verifier (281 lines · `RTSC/magnet/getdp/wheeler_axis_b.hexa` initial · §4.2.1 FEM cross-check OK · `|Δ|=1.42 %` < 3 % target)
  - demiurge PR #111 thin wrapper refactor (281 → 179 lines · −36 % · stdlib import)
  - hexa-lang PR #892 stdlib primitive (`stdlib/material/magnet/wheeler.hexa` · 5 FALSIFIERS · `__HEXA_STDLIB_MATERIAL_MAGNET_WHEELER__ PASS`)
  - demiurge PR #109 `wheeler_axis_b_result.md` verbatim 보관
  - @D d3 + g61 violation cleared

- [x] /brainstorm magnetostatics primitive depletion
  - 34 ideas · 6 rounds · paraphrase ≥50 % at R6 → STOP
  - axes: geometry / field-component / closed-form class / coupling / regime / role
  - top-5 ✓✓✓: `mutual_M_two_coaxial_loops` · `demag_factor_ellipsoid` · `finite_solenoid_endleakage_ratio` · `current_loop_offaxis_B` · `halbach_remanent_envelope`
  - pre-req gap surfaced: `elliptic_K_E` (3 of top-5 의존) → round 2 진입
  - uncovered: Bessel/Kelvin · Jiles-Atherton hysteresis · arbitrary-orientation pair M · London-vortex · magnetostriction

- [x] /brainstorm cross-domain primitive depletion
  - 47 ideas · 6 rounds · ~55 % paraphrase at R6 → saturation
  - axes: stats · info · signal · numerics · linalg · combi · streaming · robustness/ML
  - top-5 ✓✓✓: `welford_running_stats` · `logsumexp` · `kahan_babuska_sum` · `lambert_w` · `ks_two_sample`
  - uncovered: symbolic/CAS · graph · sparse linalg · PRNG TestU01 · interval-arith · special-fn tails · constrained-opt · time-series state-space

### /gap mode C — 42-lens audit (사이 turn)

- F1·F2·F4·F5·F6·F7·F8 hot (F3 only clean)
- priority shortlist: #1 NOVEL-VERIFIER schema (F4 epistemic) · #2 over-seed + pre-req cascade (F6+F1) · #3 concurrent stdlib race (F2)
- → round 2 의 next-list 에 #1 epistemic + pre-req unblock 반영

### round 2 · /cycle-full · phase 0 = prior-turn aggregate (3 milestones)

- [x] elliptic_K_E AGM stdlib 신규
  - hexa-lang PR #897 (`stdlib/math/special/elliptic.hexa` · 292 lines · AGM 5-iter to 1e-15)
  - surface: `elliptic_K(k)` · `elliptic_E(k)` · `elliptic_K_E(k) → [K,E]` joint
  - 5 FALSIFIERS: K(0)=π/2 · E(0)=π/2 · E(1)=1 · K(1/√2)=1.85407 · E(1/√2)=1.35064 + Legendre relation
  - M2.x cascade unblocked: `mutual_M_coaxial` · `current_loop_offaxis` · `vector_potential_A_φ` 진입 가능
  - 부수 발견: `hexa cloud` preflight 가 worktree path 없으면 fail — INBOX handoff 후보 (d8)

- [x] NOVEL-VERIFIER schema 명문화
  - demiurge PR #113 (`NOVEL-TOOL.md` scaffold + schema section verbatim)
  - pre-falsifier 2 + output triad 7-field (claim · proof · severity · as_of_date · scipy_grep · stdlib_grep · arxiv_ref)
  - 적용: M2/M3 round 2 부터 강제 · round 1 retroactive fill-in (별 cycle)

- [x] solenoid_endleakage_calibrator libm-only
  - hexa-lang PR #896 (`stdlib/material/magnet/solenoid_endleakage.hexa` · 202 lines · `sqrt_pure` only)
  - 공식: `ratio(L,R) = √(L² + 4R²) / (2·√(L² + R²))` (Wheeler z=L/2 / z=0 의 닫힌형)
  - 5 FALSIFIERS ✓: long-asymp 0.5 (err 7.5e-7) · short-asymp 1.0 (3.75e-7) · L=R √5/(2√2) exact · monotone decreasing in L · scale-invariant
  - 정정: round 1 의 task 가정 (ratio increases with L) 은 오답 — 실제는 decrease (`∂/∂L < 0`). agent 가 올바르게 잡음.
  - atlas tier: ⚪ INSUFFICIENT (file landed · `hexa run` self-test 미실행) — pool 실행 후 🟢 SUPPORTED-NUMERICAL 진입 예상

### deferred (round 3 후보)

- m3e-ks2 KS two-sample · M2.1 mutual_M_coaxial (elliptic 의존, unblocked) · M2.4 current_loop_offaxis (elliptic 의존, unblocked) · M2.5 halbach_remanent_envelope
- governance: 3-wave 정책 · stdlib SemVer+CHANGELOG · hexa-lang CI stdlib lint guard · domain spec owner field

## 2026-05-25T07:50Z — cycle round 3 batch land (3/3 milestones · 9/9 total)

### round 3 · /cycle · 3 milestones (deferred → unblocked → DONE)

- [x] M2.1 mutual_M_coaxial_loops
  - hexa-lang PR #902 (`stdlib/material/magnet/mutual_M_coaxial.hexa` · 254 LOC)
  - 공식: `M(R1,R2,d) = μ₀·sqrt(R1·R2)·[(2/k − k)·K(k) − (2/k)·E(k)]`, `k² = 4·R1·R2/[(R1+R2)² + d²]`
  - 5 FALSIFIERS ✓: dipole asymptote rel<5e-4 · k=1 sentinel · Maxwell-Lyle anchor rel<1e-10 · R₁↔R₂ symmetry rel<1e-14 · α-scale rel<1e-12
  - elliptic_K_E (PR #897) 활용 — cascade 의 첫 응용
  - triad: severity=high (coil-pair coupling 의 ground truth · NMR·HTS pancake·RTSC·EMI 적용)

- [x] M2.4 current_loop_offaxis_B
  - hexa-lang PR #900 (`stdlib/material/magnet/current_loop_offaxis.hexa` · 342 LOC)
  - 공식: `B_z = (μ₀I/(2π·α²·β))·[(a²-r²-z²)·E + α²·K]`, `B_ρ = (μ₀·I·z/(2π·r·α²·β))·[(a²+r²+z²)·E - α²·K]`
  - 7/7 PASS: center exact · on-axis 2.14e-16 · far-field dipole rel 6e-6 · on-loop K-divergence sentinel · scale invariance exact · I-linearity · z-parity
  - elliptic_K_E joint API (Bz·Brho 한 번 호출, 일관성)
  - triad: severity=high (모든 coil family Green's fn building block · Helmholtz·Maxwell·thick-coil·saddle 진입 해제)

- [x] m3e-ks2 KS two-sample
  - hexa-lang PR #903 (`stdlib/stats/ks_two_sample.hexa` · 342 LOC, `stdlib/stats/` 신규 dir)
  - 공식: D = sorted-merge sup-Δ, p = Stephens-corrected Kolmogorov series
  - 5 FALSIFIERS ✓: identical D=0 p=1 · disjoint D=1 p=0.0038 · textbook D=0.6 p=0.209 (hand-derive 4-dec match) · H0 n=m=200 D=0 p=1 · symmetry
  - 부수 발견: C-keyword collision (`signed` → `contrib` rename), worktree wrong-repo trap fixed
  - triad: severity=medium (scipy.stats.ks_2samp cover most cases · stdlib 의 atlas-foldable 분리 가치는 Stephens correction + stable series-termination)

### 부수 발견

- hexa-lang PR #898 concurrent (M2.1/M2.4 작업 중 rebase 필요) — explicit `git add` + 격리 worktree 패턴 안전 작동 확인
- d8 후속 INBOX handoff 후보: `hexa cloud preflight worktree-path missing fallback` (PR #897 agent 가 surfaced) — 미해소
- d8 후속 #2: `sidecar skill family context-awareness audit` — INBOX 던지기 진행 중 (user feedback "맥락따라 작동하게" 2026-05-25T07:30Z 직후)

### deferred (round 4 후보)

- M2.2 demag_factor_ellipsoid · M2.5 halbach_remanent_envelope (M2 top-5 잔여)
- m3a-welford · m3b-logsumexp · m3c-kahan · m3d-lambert_w (M3 top-5 round 2 deferred)
- governance: hexa-lang CI stdlib lint guard (별 repo INBOX) · domain spec owner field (sidecar PR · sign-gated)
- atlas tier 진입: 모든 round 1-3 primitive (8개) ⚪ → 🟢 승급 (pool 실행 self-test)
