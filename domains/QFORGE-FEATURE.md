@title: 🧰 QFORGE-FEATURE — "기능 위시리스트" (the capability backlog)

@goal: track the capabilities QFORGE still needs to become a fully self-contained, QE-independent el-ph engine + dispatch toolchain. Each entry = a concrete feature with a why (which wall it breaks) and a fitness gate (g5/cross-val). NOT bugs (those go to hexa-lang inbox) — this is the FORWARD feature backlog. Seeded from gaps surfaced during the 2026-06-01/02 QFORGE migration-gate campaign.

icon 🧰 · name QFORGE-FEATURE · alias "기능 위시리스트" (capability backlog)

- 하는 일: QFORGE가 QE를 완전히 걷어내고 독립 엔진이 되려면 아직 무엇이 필요한지 — 기능 단위로 목록·우선순위·완료게이트를 기록
- 비유: 새 차에 "아직 없는 옵션" 위시리스트 — 어떤 옵션이 어떤 불편을 없애는지 + 언제 "장착 완료"로 칠지
- 비교: hexa-lang inbox = 버그/결함 신고함 · QFORGE-FEATURE = 앞으로 만들 기능 백로그 (결함 아닌 미구현)

## engine features (the physics QFORGE still can't do alone)

- [ ] **correlation-XC functional (PZ81 / PW92)** — screening.hexa is Hartree + LDA-exchange only (`xc_mode=2` unsupported, deferred). Until correlation is wired, the fully-independent path starts from a QE moment boundary. **why**: closes the last "starts-from-QE" seam in the migration gate (commit 73b7d56 reason-a). **gate**: g5 selftest vs closed-form PZ81 c-energy + DFPT end-to-end symmetry/sum-rule preserved.
- [ ] **metallic SCF beyond Γ-only Einstein** — M5.8 (#2437/2438/2440) gives smeared+Anderson convergence, but the el-ph λ is a Γ-only single-Einstein coarse estimate. **why**: independent λ·Tc that can actually cross-val QE needs a real q-mesh α²F, not a 1-mode estimate. **gate**: QFORGE-NC λ within 1% of QE λ_BZ on CaH6 (same bar as L3 YH10).
- [ ] **self-controlled GPU el-ph hot kernels (NVPTX)** — fft3 · eigh · davidson · sternheimer · α²F BZ-sum backed by hexa NVPTX codegen (nvptx_target.hexa exists, gemm/reduce tested). **why**: "QE diff = unimplemented, not impossible" — our compiler, our kernels. Tracked in detail by QFORGE-PERF. **gate**: 1-kernel pilot CPU-parity g5, then roadmap.
- [ ] **full DFPT q-star symmetry reduction in QFORGE** — currently leans on QE star weights for BZ sums. **why**: independent IBZ→full-BZ unfolding removes another QE dependency. **gate**: reconstruct YH10 star weights [1,8,4,6,24,12,3,6] from QFORGE symmetry analyzer.

## dispatch / toolchain features (the campaign plumbing)

- [ ] **dft-run start_q corrupt-recover auto-salvage** — DONE in PR#2459/2460 (classifier + salvage). Listed here as the pattern: detect PARSE_ERR/runParser → purge broken `_ph0/q_N` → start_q recover=.false. **follow-on**: extend salvage to scf-restart corruption, not just phon.
- [ ] **dft-run proxy-only offer scp fallback** — DONE in PR#2451/2453 (proxy-fallback + offer-blacklist). **follow-on**: surface a `--prefer-direct` ranking so direct-sshd offers win selection, not just survive scp.
- [ ] **dft-run detached HostPort-map lag orphan guard** — filed (hexa-lang 9e2347d6). **why**: first-fire transport lag → orphan → teardown wastes a rent cycle. **gate**: retry-on-lag before destroy.
- [ ] **resume-in-place across pod teardown (.save/.phsave bank)** — currently `.save` is never banked (too big for git) so every fresh pod re-runs SCF. **why**: banked dynN is only cross-check data, not a resume baton. A compressed scratch-bank (object store, not git) would make true resume possible. **gate**: LaH10 q4 crash → resume from banked scratch without SCF re-run.
- [ ] **per-stage wall/RAM telemetry emit → QFORGE-PROCESS** — dft-run should emit structured stage timings (relax/scf/ph-per-q) the PROCESS domain can ingest. **why**: PROCESS observability is manual pod-probe today. **gate**: one JSONL line per stage transition.

## verification / gate features

- [ ] **3-anchor cross-val harness (CaH6·LaH10·Li2MgH16) one-shot** — a `qforge_migration_gate_test` that ingests the three QE λ·Tc references + QFORGE-NC outputs and emits ALL_PASS/HELD. **why**: the migration default-flip is gated on this; today it's a manual matrix. **gate**: green only when all three agree at g5.

## notes
- migration default-flip remains **HELD** until the engine features above (correlation-XC + real-q metallic λ) AND the 3-anchor cross-val all close. d6/@L4 — no forced flip.
- bugs/defects do NOT go here — they go to `hexa-lang/inbox/patches/` (d8). This file is forward features only.
