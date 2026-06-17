# QFORGE-PERF B2 — GPU-resident H_apply seam (stage H once, reuse across iters)

Branch: `qforge-gpu-resident-seam` (hexa-lang, isolated worktree /tmp/hx-resident-wt)
Checkpoint: 44a447f1 "feat(qforge): GPU-resident H_apply seam — stage H once, reuse across Davidson/CG iters"
Impl: `stdlib/qforge/assembler.hexa` (3-call lifecycle) · selftest `stdlib/qforge/h_resident_selftest.hexa` · bench `bench/qforge/h_resident_bench.hexa`
Run host: mini native-CPU (no pod). 0-POD task — paid pods forbidden. summer RTX 5070 = UNREACHABLE (sshd reset/banner-timeout — overloaded). HEXA_LANG = isolated worktree.

## The lever
The shipping `qforge_h_apply_forge` (assembler.hexa) re-stages the ENTIRE H[n×n] into a
fresh farr handle EVERY matvec (`farr_zeros(n²)` + n² `farr_set` + `farr_free`). On a CUDA
build that is an n²·8-byte H2D upload per call — the per-call floor that makes the GPU-GEMM
seam LOSE to the scalar CPU path below the measured n≈4096 re-stage crossover
(size_dispatch.hexa). Davidson (`dv_project`: H_apply per band per iter) and Sternheimer
projected-CG (H·ψ per CG step) call H_apply many times with the SAME H, only v varying — so
re-uploading H every call is pure waste.

The resident seam stages H ONCE (`farr_to_device` → farr lands device-resident,
loc∈{DEVICE,MIRRORED}, host clean) and then per matvec transfers ONLY v[n]. The matmul's
internal `_h2d(H)` hits the runtime **RFC 056 §6.1 H2D-skip** (device-resident + host-clean
+ len-match ⇒ the cudaMemcpy HostToDevice is provably byte-eq-skippable, falsifier
F-RFC056-BYTEEQ-PRESERVE max|Δ|=0.0). Per-call transfer drops from O(n²) (full H) to O(n)
(just v). **NO engine change required** — the residency machinery (`_h2d` skip +
`farr_to_device`) already exists in `self/cuda/runtime_cuda_emit.hexa`. The earlier
size_dispatch.hexa note ("needs an engine change not yet merged") is SUPERSEDED — the lever
is expressible at the hexa level by hoisting the H farr handle out of the per-call body.

## API (d4-generic — one path, no per-kernel branch)
    let res = qforge_h_apply_resident_open(ham)          // stage H to device ONCE (single n² marshal + 1 H2D)
    ... loop: let hv = qforge_h_apply_resident(res, ham, v)  // transfer v only; H upload SKIPPED
    res = qforge_h_apply_resident_close(res)             // free resident H + v handles
On a no-GPU build `farr_to_device` is a no-op returning 1 and the matmul routes to the CPU
`hexa_farr_matmul` ⇒ result element-identical to scalar at EVERY size.

## Correctness (selftest, worktree stdlib) — PASS
qforge_h_apply_resident vs scalar qforge_h_apply, 5 distinct v's per H, n∈{4,17,64,256}:
- n=4   max|Δ| 1.11e-16     - n=17  max|Δ| 5.55e-16
- n=64  max|Δ| 3.55e-15     - n=256 max|Δ| 7.99e-15
ALL < 1e-9 (FP-tol) ⇒ resident == scalar == forge element-eq. **4/4 PASS.**

## CPU-build bench (VERBATIM, d6 — host-marshal proxy for the H2D it eliminates)
matvecs/H = 30 (≈ Davidson iters × bands — H reused 30× per open), per-call walls (ns):

    n     scalar_ns      restage_ns     resident_ns    restage/resident   scalar/resident
    256   26,147,000     21,742,000      2,448,000      8.88×              10.68×
    512  104,138,000     86,830,000      9,752,000      8.90×              10.68×
    1024 401,423,000    349,434,000     37,834,000      9.24×              10.61×
    2048 1,642,523,000  1,467,993,000   158,516,000     9.26×              10.36×

Reuse-gated control — matvecs/H = 1 (no reuse to amortize):

    n     restage/resident   scalar/resident
    256   1.01×              1.22×
    512   1.08×              1.24×
    1024  0.98×              1.23×
    2048  1.01×              1.26×

→ at matvecs=1 resident ≈ restage (open's single n² stage == restage's single n² stage);
the win is REUSE-GATED and grows with iters — exactly the Davidson/CG access pattern.

## HONEST CEILING (d6) — what the CPU number does and does NOT prove
The CPU-build bench measures elimination of the per-call **host farr-marshal** (n² farr_set ×
matvecs collapsed to n² once + n×matvecs). That IS a real cost the seam removes, and it is the
host-side analogue of the GPU H2D. It is NOT the GPU launch-overhead measurement: on a CPU
build there is no GPU launch floor and no cudaMemcpy, so the 8.6–9.3× / 10.4–11.2× figures are
the host-marshal ceiling, NOT the device-resident-vs-CPU ratio the SPEED axis needs to promote
parity→win.

The real-RTX-5070 H2D bench (resident-GPU wall vs scalar-CPU wall at n=256·512·1024·2048) is
**DEFERRED — summer sshd unreachable** (ping OK 2.8ms, but ssh banner-exchange reset/timeout
across 5 backoff attempts → host overloaded, the documented 94%-util busy state). No paid pod
fired (0-POD task). The mechanism is verified (residency machinery exists + H2D-skip is byte-eq
+ resident==scalar correctness PASS); only the on-silicon GPU ratio is pending.

## Verdict
- **Impl: SHIPPED** (44a447f1) — d4-generic 3-call resident seam, no engine change.
- **Correctness: GATE PASS** — resident element-eq scalar/forge, max|Δ| ≤ 8e-15 (FP-tol).
- **CPU host-marshal bench: measured** — resident 8.6–9.3× over restage, 10.4–11.2× over scalar
  at n=256..2048 when H is reused (matvecs≥30); ≈1.0× at matvecs=1 (reuse-gated, honest).
- **SPEED-axis parity→win promotion: NOT YET** — gated on the real RTX 5070 H2D measurement,
  which summer's overload blocked. The CPU result strongly predicts a small-cell GPU win (the
  eliminated H2D is exactly the floor size_dispatch.hexa names as the crossover cause), but per
  d6 the promotion stays PENDING until the on-silicon GPU ratio is recorded. Honest ceiling:
  resident is the correct lever and is MERGED; the win is PROVEN reuse-gated on CPU, PENDING-MEASURED on GPU.
