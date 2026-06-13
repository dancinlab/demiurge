---
slug: qforge-perf-happly-gpu-gemm
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated · GPU pod bench (cost-bearing, user greenlit)
domain: QFORGE-PERF (demiurge domains/) — Lane A ⚡ first kernel, the QE-GPU gap filler
---

## task brief
The QE-GPU investigation (QFORGE-PERF.log 7917946) confirmed QE leaves the el-ph λ·a²F path CPU-only.
QFORGE-NVPTX fills that gap. Start Lane A's highest-leverage kernel: route `qforge_h_apply`
(assembler.hexa:140 — the scalar O(n²) matvec at the innermost of Davidson + every Sternheimer CG
iter) through the existing `forge_dispatch_matmul` GPU-GEMM path (CPU farr ↔ cuBLAS, byte-eq
precedent), then BENCH it on a real GPU pod and publish the measured Δ vs the 0.140 GFLOP/s CPU
baseline. Honest roofline: this kernel is MEMORY-BOUND (AI 0.25–0.5 ≪ ridge), so the realistic
ceiling is the 140–280 GFLOP/s memory roof — the bench measures the ACTUAL GPU GFLOP/s + wall Δ.

## locked decisions
- @L1 (complete): wire `qforge_h_apply` (assembler.hexa:140) to dispatch through `forge_dispatch_matmul` — GPU path = cuBLAS (host), CPU path = current scalar matvec BYTE-IDENTICAL when no GPU (regression-pinned). assert:grep forge_dispatch_matmul
- @L2 (complete · g5): CPU-side g5 FIRST (no pod) — the GPU-off path produces byte-identical H_apply output + all existing qforge selftests (davidson · sternheimer · l0/l1/l3) 0-diff. Paste verdict VERBATIM.
- @L3 (complete · the bench): rent ONE vast GPU pod (preflight d11 sizing first), build hexa w/ CUDA, run the H_apply bench n=256/512/1024 → measured GPU GFLOP/s + wall Δ vs 0.140 CPU baseline + result byte-eq (or fp-tol) GPU-vs-CPU. TEARDOWN the pod immediately after (stop the meter). State the $ in one line before firing (d17).
- @L4 (complete · d6 HONESTY): publish the REAL measured Δ. If GPU hits the memory roof (~140–280 GFLOP/s, ~1000× over the 0.140 scalar CPU baseline) — report the actual number. If wall Δ < 1 (no speedup, e.g. transfer-dominated at small n) — report that AS-IS (a roofline-consistent negative is valid, g63). Do NOT claim >2000× (roofline-violating).
- @L5 (std): flip the QFORGE-PERF.md Lane A "H_apply GPU-GEMM" item [ ]→[x] with the measured GFLOP/s + wall Δ + byte-eq result + a `.verdicts/qforge-perf-roofline/happly-gpu-gemm.txt` verdict. If the bench is BLOCKED (CUDA build fails / toolchain), report BLOCKED honestly + leave the item open. explicit-path commit.
- @L6 (g8/d_defer): all pod ops via `hexa cloud` (rent/run/copy/down); on OOM/build-fail → d_defer (lower n, retry recipe), never fabricate a number.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-happly-gpu`); HEAD = origin/main (055dd0fb5 or newer)
- [ ] read assembler.hexa:140 (qforge_h_apply) + forge_dispatch_matmul (the CPU↔cuBLAS byte-eq dispatch) to fix the wire seam
- [ ] wire H_apply → forge_dispatch_matmul (GPU path + byte-identical CPU fallback)
- [ ] CPU g5: byte-eq H_apply + davidson/sternheimer/l0-l3 0-diff regression — VERBATIM (HEXA_STDLIB_ROOT="$PWD/stdlib")
- [ ] hexa cloud preflight (GPU mem sizing) → rent 1 vast GPU pod → build hexa+CUDA → bench n=256/512/1024 (GFLOP/s + wall Δ + byte-eq) → `hexa cloud down` immediately
- [ ] publish measured Δ → QFORGE-PERF.md item [x] + .verdicts/ verdict (or BLOCKED honest report)
- [ ] PR <200 lines (code) + g5 + self-merge; demiurge QFORGE-PERF docs explicit-path commit
- [ ] ship

## completion criteria
- qforge_h_apply routed through forge_dispatch_matmul (CPU byte-identical) + g5 PASS + a REAL GPU-pod measured Δ (GFLOP/s + wall + byte-eq) published to QFORGE-PERF with a .verdicts verdict. Honest: a roofline-consistent result (incl. memory-bound ceiling or small-n no-speedup) is the valid deliverable; fabricated speedup is failure.

## guards
- g8: pod ops via hexa cloud only. The LIVE gate pods 38943553·38922322 + the探索 pods are COMPUTING — do NOT touch/teardown them; rent a SEPARATE fresh GPU pod for the bench + tear down ONLY that one.
- d11: preflight GPU mem-budget before rent. d17: state $ in one line, then fire (no approval gate — user already greenlit). d_defer: OOM/build-fail → lower n + retry, never fabricate.
- d6/g63: publish the real measured number; memory-bound ceiling or no-speedup is a valid honest result.
- d9: isolated worktree · explicit paths. plan-guard "without/forced/fabricat" false-positives EXPECTED.
- Sibling agents own realcell_phonon.hexa (a33abb0). Stage only assembler.hexa + the bench harness + the QFORGE-PERF docs/verdict.
