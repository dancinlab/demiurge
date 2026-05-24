# NUCLEAR.md §6 Phase 4 #1 — sim.hexa v0.1.0 NP1 bundle (NC1+NC2+NC3) parity verify

> Anchor: `NUCLEAR.md §6` Phase 4 #1 · `hexa-lang stdlib/nuclear/sim.hexa` v0.1.0
> Date: 2026-05-22
> Hexa-lang commit verified: `bf16ebdd` (stdlib/nuclear · NP1 bundle land)
> Parity result: **31/31 PASS** (15 input cases · ≤1e-9 rel tolerance · 실제 모두 0.0 bit-for-bit)
> Cross-anchor: `inbox/notes/2026-05-22-rtsc-9-phase4-1-parity-verify.md` (RTSC §9.9.1 Phase 4 #1 pattern source · 22/22 PASS)
> Cross-anchor: `inbox/notes/2026-05-22-nuclear-9-phase2-stabilization.md` §7 (NC1+NC2+NC3 candidate identification)

---

## 1. Scope (why this note exists)

`hexa-lang bf16ebdd` 의 commit message 는 *"31/31 parity PASS"* 를 주장. RTSC §9.9.1 Phase 4 #1 의 D116 / trust-but-verify pattern 그대로: dedicated parity harness 를 `/tmp/rtsc-nuclear-phase4-1-parity/sim_nuclear_parity_test.hexa` 에 박제 + run.log 박제 + 본 note 가 ground-truth.

NUCLEAR.md §6 Phase 4 #1 = N7 cohort 의 closed-form kernels (Viola-Seaborg + Royer + consensus reducer) 를 `wkb_alpha_decay.py` → `stdlib/nuclear/sim.hexa` v0.1.0 hexa-native port. NP1 bundle = NC1 + NC2 + NC3 (Phase 2 audit §7 에서 식별된 3 후보).

## 2. Harness

`/tmp/rtsc-nuclear-phase4-1-parity/sim_nuclear_parity_test.hexa` — 15 cases · 31 assertions · `use "stdlib/nuclear/sim"`.
- NC1 `viola_seaborg_log10_t` 5 case (VS1-VS5)
- NC2 `royer_log10_t` 5 case (R1-R5)
- NC3 `consensus_alpha` 5 case (C1-C5 · 21 assertion · n=0/1/2/3 edges)

Expected values: Python `math.sqrt` + `pow(A, 1/6)` 으로 독립 계산 (double-precision IEEE 754 closed-form).

## 3. Run

```
$ cd ~/core/hexa-lang-nuclear-phase4-1
$ cp /tmp/rtsc-nuclear-phase4-1-parity/sim_nuclear_parity_test.hexa \
     stdlib/nuclear/_parity_test.hexa
$ /Users/ghost/.hx/bin/hexa run stdlib/nuclear/_parity_test.hexa
$ rm stdlib/nuclear/_parity_test.hexa   # commit 직전 cleanup
```

Output: `/tmp/rtsc-nuclear-phase4-1-parity/run.log` — final line `[parity] 31/31 checks PASS`.

## 4. Result matrix

### NC1 `viola_seaborg_log10_t` (5 cases · 5 assertions)

| Case | input (Z, Q_α MeV) | sim.hexa got | Python expected | rel_err | verdict |
|---|---|---|---|---|---|
| VS1 | ²³⁸U  (92, 4.27)   | 17.34616978... | 17.346169783299004  | 0.0 | PASS |
| VS2 | ²⁹⁴Og (118, 11.65) | -2.82182931... | -2.8218293069777403 | 0.0 | PASS |
| VS3 | ²¹²Po (84, 8.954)  | -7.09620427... | -7.096204271052628  | 0.0 | PASS |
| VS4 | ²²⁶Ra (88, 4.871)  | 10.69176466... | 10.691764656952024  | 0.0 | PASS |
| VS5 | ²⁴⁴Cm (96, 5.902)  | 8.83409483...  | 8.834094830657953   | 0.0 | PASS |

### NC2 `royer_log10_t` (5 cases · 5 assertions)

| Case | input (Z, A, Q_α MeV) | sim.hexa got | Python expected | rel_err | verdict |
|---|---|---|---|---|---|
| R1 | ²³⁸U  (92, 238, 4.27)   | 17.55235197... | 17.55235196694545   | 0.0 | PASS |
| R2 | ²⁹⁴Og (118, 294, 11.65) | -3.03993148... | -3.0399314826567334 | 0.0 | PASS |
| R3 | ²¹²Po (84, 212, 8.954)  | -6.80268136... | -6.802681358992011  | 0.0 | PASS |
| R4 | ²²⁶Ra (88, 226, 4.871)  | 11.02003152... | 11.020031523631687  | 0.0 | PASS |
| R5 | ²⁴⁴Cm (96, 244, 5.902)  | 8.89560708...  | 8.895607077377313   | 0.0 | PASS |

### NC3 `consensus_alpha` (5 cases · 21 assertions, mean/min/max/spread/n)

| Case | input | mean | min | max | spread | n | verdict |
|---|---|---|---|---|---|---|---|
| C1 | ²³⁸U VS+Royer    | 17.44926088  | 17.34616978  | 17.55235197  | 0.20618218 | 2 | 5/5 PASS |
| C2 | ²⁹⁴Og VS+Royer   | -2.93088039  | -3.03993148  | -2.82182931  | 0.21810218 | 2 | 5/5 PASS |
| C3 | [10.0] (n=1)     | 10.0         | 10.0         | 10.0         | 0.0        | 1 | 3/3 PASS |
| C4 | [] (n=0)         | 0.0          | 0.0          | 0.0          | 0.0        | 0 | 3/3 PASS |
| C5 | [10,11,12] (n=3) | 11.0         | 10.0         | 12.0         | 2.0        | 3 | 5/5 PASS |

전체 **31/31 PASS · 모든 rel_err = 0.0 (exact IEEE 754 bit-for-bit match)**. Tolerance 1e-9 는 floor; 실제로 closed-form 산술이 Python ↔ hexa double-precision 에서 동치이기 때문에 모든 assertion 이 정확히 0.0.

Phase 2 audit anchor 비교:
- C1.mean = **17.4493** dex (²³⁸U) ↔ Phase 2 audit table §2 row "²³⁸U mean +17.45 ± 0.21 dex" 일치.
- C2.mean = **-2.93088** dex (²⁹⁴Og) ↔ Phase 2 audit row "²⁹⁴Og mean -2.93 ± 0.22 dex" 일치.
- 즉 Phase 2 audit 의 두 simulation 셀이 Phase 4 #1 hexa-native port 에서 bit-for-bit 재현 — **regression 0**.

## 5. Cross-stack reuse decision (NC3)

**선택: Option B (dedicated struct)**. `stdlib/material/sim.hexa::Consensus { mean, combined_sigma, n_sources, rel_err_max_pairwise }` 은 inverse-variance σ² weighting; nuclear N7 `_consensus` 은 unweighted mean + raw spread (max-min). 두 reducer 의 *의도된* 의미가 다르므로 (material 은 source 간 σ 신뢰도 기반 combine, nuclear 는 formula ensemble 의 disagreement band 가시화) struct 를 합치면 의미 충돌.

Option A (import 후 σ=1 으로 reduce) 도 numerically 가능하지만 `spread_dex = max - min` 가 inverse-variance kernel 에 없음 → 어차피 nuclear-side 에서 별도 계산. 따라서 **dedicated `ConsensusAlpha` struct + `consensus_alpha` fn 로 separate land**. "MIRROR of stdlib/material/sim.hexa Consensus — keep in sync" 주석을 NC3 머리에 박제.

LOC 영향: NC3 = 29 LOC (struct 7 + fn 22). 250-LOC 모듈 전체에서 12% — 합리적.

## 6. Honest invariants

- sim.hexa nuclear kernel 은 *숫자만* 반환 — R4 policy (`gate_type` · `absorbed`) 는 Python orchestrator (`wkb_alpha_decay.py`) 가 유지. s1-s5 caveat 동일.
- 31/31 PASS 는 **closed-form 산술적 동치** verify · *measurement* 가 아님. Tier 1 prediction 영역 그대로 (NUCLEAR.md §7 + RTSC.md §8.7 honest 한계).
- `gate_type=nuclear-novel-discovery-simulation` · `absorbed=false 영구` invariant 무영향.
- Anti-pattern carve-outs 무영향: HFBTHO Fortran ecosystem (N6) + KSHELL Lanczos (N9) + ML mass-formula training (NUCLEAR.md §3.3) 은 wrap-as-is 영구. Phase 4 #1 은 N7 closed-form 한정.

## 7. Replace claim

| | Before | After |
|---|---|---|
| 주장 | hexa-lang `bf16ebdd` commit message — "31/31 parity PASS" | demiurge `inbox/notes/2026-05-22-nuclear-phase4-1-parity-verify.md` |
| Reproducible? | (worktree 내부) | ✅ (`/tmp/rtsc-nuclear-phase4-1-parity/{sim_nuclear_parity_test.hexa,run.log}`) |
| Count | 31/31 (unverified externally) | **31/31** (verified · per-case matrix) |
| Tolerance | unspecified | ≤1e-9 rel · 실제 모두 0.0 (IEEE 754 bit-for-bit floor) |
| Phase 2 anchor regression | 미언급 | **0** (²³⁸U mean 17.4493 + ²⁹⁴Og mean -2.93088 가 Phase 2 audit §2 와 verbatim 일치) |

## 8. Follow-on (next pickup)

- **Phase 4 #1 의 hexa-lang 측 land (PR)** — 본 commit `bf16ebdd` 은 isolated worktree `nuclear-phase4-1-microkernel-2026-05-22` 에 land · PR 은 별도 세션 (concurrent-agent 회피). 본 verify note 가 PR anchor.
- **Phase 4 #2** — N6 0 candidates per Phase 2 audit §7 anti-pattern reject (HFBTHO SCF stays wrap-as-is forever). 따라서 N7 만이 Phase 4 대상이고 NP1 bundle 로 끝. *Phase 4 자체 종료* — 추가 N7-port 없음.
- **Phase 5 (N8/N9/N10 wrap land)** — 별도 세션, 각 cohort 의 external lib install audit 분리.
- **Phase 6 (N11 funnel cohort)** — 별도 세션, (Z, N) candidate space 열거 + top-K 우선순위.
- **Brown 1992 / Denisov-Khudenko 2009 third formula** — Phase 3+ follow-on per Phase 2 audit §4. NP1 bundle 은 2-formula floor (VS + Royer) 만 land · 추가 formula 는 별도 세션 (verbatim 계수 substitution, 재유도 금지).

## Anchors

- NUCLEAR.md §6 Phase 4 #1 (microkernel port · NP1 bundle = NC1+NC2+NC3)
- RTSC.md §9.9.1 Phase 4 (B→A microkernel transition 패턴 소스)
- hexa-lang `bf16ebdd` (`stdlib/nuclear/sim.hexa` v0.1.0 land · 250 LOC)
- `inbox/notes/2026-05-22-nuclear-9-phase2-stabilization.md` §7 (NC1+NC2+NC3 identification)
- `inbox/notes/2026-05-22-rtsc-9-phase4-1-parity-verify.md` (22/22 RTSC pattern source)
- D116 (sibling repos = 문서만 · demiurge=pointer · hexa-lang=SSOT)
