# QFORGE converged k×q el-ph on GPU pod — CaH6 λ vs QE 4.376

WIP started 2026-06-10 (isolated agent worktree branch)

## Goal
Run CaH6 converged k-mesh × q-mesh + converged NPW QForge-GPU el-ph on a vast.ai
RTX 3090; measure whether from-scratch λ rises from Γ-only 1.1545 (best, NPW64) toward
QE λ_BZ=4.376 and reaches ≤1%. d6 VERBATIM — 4.376 NEVER forced.

## Prior 0-pod terminal (context)
- Γ-only best λ=1.1545 (rel-ε 0.736, NPW64), compose path screened ΔV wired.
- NPW sweep NON-MONOTONIC 0-pod: NPW128 λ=3.50 (basis accident, not asserted), NPW256 λ=0.876.
- g2-audit: residual = VERTEX-MAGNITUDE deficit (bare |g_mn| ~3.3e4× small), NOT BZ-mesh.
- Wannier+tetra FS-mesh axis CLOSED-NEGATIVE (λ barely moves with FS density).
- 0-pod d11-intractable: NPW256 SCF alone ~9min; converged k×q mesh needs GPU.

## GPU stack confirmed present (~/.hx/src/stdlib/qforge)
- NVPTX Sternheimer kernel + parity PASS on B200 (max_rel_err 3e-16).
- NVPTX Davidson V^T H V, cuFFT Poisson, A2F kernel + multi-GPU shard (A4000, 1.93× 2-GPU).
- GPU-resident H_apply seam (byte-eq, reuse-gated 10.6× on the H2D it eliminates).

## Plan
1. rent vast RTX 3090 (cuda>=12.4 verified host), durable harvester.
2. hexa-lang sync + QForge CUDA build, deck = exports/rtsc/decks/CaH6_NC.
3. NPW-convergence + q≠Γ sweep of cah6_screened_compose_sweep.hexa via QF_NPW/QF_KX knobs.
4. harvest converged λ + mesh-convergence curve; classify ≤1%? VERBATIM.

## 2026-06-11 — Pod live (vast 40418055, RTX 3090, $0.166/hr)
- Pod: ssh8.vast.ai:18054, RTX 3090 24GB, driver 570 (CUDA 12.8), nvcc 12.4, 192 cores/220GB.
- TOOLCHAIN FIX (memory-worthy): hexa release Linux binaries need GLIBC_2.38; cuda:12.4.1
  base = Ubuntu 22.04 GLIBC 2.35. Fix = download old-releases libc6_2.38-1ubuntu6_amd64.deb,
  extract, patchelf --set-interpreter+rpath on hexa/hexat/hexa_module_loader → runs clean.
  Runtime sources rsynced with `rsync -L` (native/*.c were macOS-path symlinks). Deck symlinked
  at hardcoded /Users/mini/.../CaH6_NC path → /root/hxsrc deck.
- d16 smoke NPW=16 PASS: SCF conv (27 it), Anderson screen conv, ω band 24 modes, N(E_F)=19.95,
  λ_all4=0.4077 (rel-ε 0.907). Pipeline runs end-to-end natively on pod.
- Sweep launched (durable nohup PID 3682): NPW {64,128,256,512,1024} at Γ + q≠Γ at NPW256.
