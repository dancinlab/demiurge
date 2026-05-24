# NOVEL-TOOL — log

Append-only history sister of `NOVEL-TOOL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T07:30Z — cycle round 1·2 batch land (6/6 milestones done)

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
