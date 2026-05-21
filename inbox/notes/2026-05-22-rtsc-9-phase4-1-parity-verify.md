# RTSC.md §9.9.1 Phase 4 #1 — sim.hexa v0.2.0 consensus port parity verify

> Anchor: `RTSC.md §9.9.1 Phase 4` · `hexa-lang stdlib/material/sim.hexa` v0.2.0
> Date: 2026-05-22
> Hexa-lang commit verified: `701bfe1b` (stdlib/material · §9 cohort complete)
> Parity result: **22/22 PASS** (10 input cases · ≤1e-9 rel tolerance)

---

## 1. Scope (why this note exists)

`hexa-lang 701bfe1b` 의 commit message 는 *"Phase 4 #1 — `_compute_consensus` → sim.hexa v0.2.0 · 13/13 parity ✓"* 를 주장. 하지만 dedicated parity test scaffold 가 commit 에 land 되지 않음 (`stdlib/material/` 의 어떤 `*_test.hexa` 도 consensus kernel cover 안 함, grep 결과 0).

D116 / project_demiurge_pointer 원칙: demiurge 의 pointer 는 **검증 가능한 evidence** 만 cite. *trust-but-verify* 로 22-assertion harness 작성·실행 후 본 note 가 ground-truth 박제.

## 2. Harness

`/tmp/rtsc-phase4-1-parity/parity_consensus_test.hexa` — 10 cases · 22 assertions ·`use "stdlib/material/sim"`. `inverse_variance_consensus` 6 case + `sigma_from_spread` 4 case.

## 3. Run

```
$ cd ~/core/hexa-lang
$ cp /tmp/rtsc-phase4-1-parity/parity_consensus_test.hexa \
     stdlib/material/_parity_consensus_test.hexa
$ /Users/ghost/.hx/bin/hexa run stdlib/material/_parity_consensus_test.hexa
$ rm stdlib/material/_parity_consensus_test.hexa   # 본 commit 직전 cleanup
```

Output: `/tmp/rtsc-phase4-1-parity/run.log` — final line `[parity] 22/22 checks PASS`.

## 4. Result matrix

`inverse_variance_consensus` (6 cases · 18 assertions):

| Case | input | sim.hexa got | Python expected (np-style closed-form) | rel_err | verdict |
|---|---|---|---|---|---|
| C1.mean   | n=2 equal zeros σ=0.05 | 0.0       | 0.0                  | 0.0      | PASS |
| C1.sigma  | "                       | 0.0353553 | 0.035355339059327376 | 3.93e-16 | PASS |
| C1.relerr | "                       | 0.0       | 0.0                  | 0.0      | PASS |
| C2.mean   | [1.0, 1.5] σ=[0.1, 0.2] | 1.1       | 1.1                  | 2.02e-16 | PASS |
| C2.sigma  | "                       | 0.0894427 | 0.0894427190999916   | 0.0      | PASS |
| C2.relerr | "                       | 0.333333  | 0.3333333333333333   | 0.0      | PASS |
| C3.mean   | [0.5, 0.7, 0.6] σ=0.1   | 0.6       | 0.6                  | 0.0      | PASS |
| C3.sigma  | "                       | 0.057735  | 0.05773502691896258  | 3.61e-16 | PASS |
| C3.relerr | "                       | 0.285714  | 0.2857142857142857   | 1.94e-16 | PASS |
| C4.mean   | [-1, 1] σ=0.1 (opp-sign) | 0.0       | 0.0                  | 0.0      | PASS |
| C4.sigma  | "                       | 0.0707107 | 0.07071067811865475  | 3.93e-16 | PASS |
| C4.relerr | "                       | 2.0       | 2.0                  | 0.0      | PASS |
| C5.mean   | [0,0] σ=[0.149, 0.127] Nb | 0.0     | 0.0                  | 0.0      | PASS |
| C5.sigma  | "                       | 0.0966542 | 0.09665416643570873  | 0.0      | PASS |
| C5.relerr | "                       | 0.0       | 0.0                  | 0.0      | PASS |
| C6.mean   | [-0.179,-0.140] σ=[0.05,1.076] MgB₂ | -0.178916 | -0.17891596826961859 | 0.0  | PASS |
| C6.sigma  | "                       | 0.0499461 | 0.049946104458872244 | 0.0      | PASS |
| C6.relerr | "                       | 0.217877  | 0.21787709497206692  | 0.0      | PASS |

`sigma_from_spread` (4 cases · 4 assertions):

| Case | input | sim.hexa got | Python expected | rel_err | verdict |
|---|---|---|---|---|---|
| S1 | `[]`, default=0.05         | 0.05 | 0.05  | 0.0      | PASS |
| S2 | `[1.0]`, default=0.05      | 0.05 | 0.05  | 0.0      | PASS |
| S3 | `[0.1, 0.1]`, default=0.05 | 0.05 | 0.05  | 0.0      | PASS |
| S4 | `[0.1, 0.2, 0.3]`, default=0.01 | 0.1 | 0.1 | 1.39e-16 | PASS |

전체 **22/22 PASS · max rel_err 3.93e-16 (IEEE 754 round-off floor)**.

## 5. Honest invariants

- sim.hexa consensus kernel 은 *숫자만* 반환 — R4 policy (`gate_type` · `absorbed`) 는 Python orchestrator (`cross_code_dft.py`) 가 유지. s4 caveat 동일.
- 22/22 PASS 는 **closed-form 산술적 동치** verify · *measurement* 가 아님. Tier 1 prediction 영역 그대로.
- `gate_type=simulation-only-prediction` · `absorbed=false 영구` invariant 무영향.

## 6. Replace claim

| | Before | After |
|---|---|---|
| 주장 | hexa-lang `701bfe1b` commit message — "13/13 parity ✓" | demiurge `inbox/notes/2026-05-22-rtsc-9-phase4-1-parity-verify.md` |
| Reproducible? | ❌ (harness un-committed) | ✅ (`/tmp/rtsc-phase4-1-parity/{parity_consensus_test.hexa,run.log}`) |
| Count | 13/13 (unverified) | **22/22** (verified) |
| Tolerance | unspecified | ≤1e-9 rel · 실제 ≤3.93e-16 IEEE 754 floor |

## 7. Follow-on (next pickup)

- 본 harness 의 hexa-lang 측 land (PR `stdlib/material/sim_parity_test.hexa`) — *별도 세션* (concurrent-agent 회피 · isolated worktree). 본 verify note 가 그 PR 의 anchor.
- Phase 4 #2 (C3+C4 ASKCOS parser+classifier) prep — hexa-lang regex API 지원 사전 verify (별도 inbox note 예정).
- Phase 2 16→20 cell 확장 — 5th baseline composition (H₃S / LaH₁₀) 추가 audit (별도 session).

## Anchors

- RTSC.md §9.9.1 Phase 4 (B→A microkernel transition)
- hexa-lang `701bfe1b` (`stdlib/material/sim.hexa` v0.2.0 land)
- `inbox/notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` (P1 candidate identification)
- D116 (sibling repos = 문서만 · demiurge=pointer · hexa-lang=SSOT)
