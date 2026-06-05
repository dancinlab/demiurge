# QFORGE-PERF — current state

@title: 🚀 QFORGE-PERF — "큐포지 가속기" (QFORGE el-ph accelerator backlog)

**부모(parent)**: 🔨 QFORGE (engine · `QFORGE/QFORGE.md`) · siblings: ⚙️ QFORGE-PROCESS · 🧰 QFORGE-FEATURE

@goal: hexa-native QFORGE el-ph 엔진(stdlib/qforge · SCF·DFPT·λ·Tc · g5 cross-val vs QE ref, d_qforge_engine)을 **두 개의 벽** 너머로 가속한다 — (1) **하드웨어 벽**: QE 의 el-ph(λ·a²F) GPU 미포팅 한계(29-pod CPU teardown 의 원인). ※2026-06-02 정밀화([[QFORGE-PERF.log]] QE-GPU 조사): dynmat-DFPT(dvscf/Sternheimer)는 QE 7.2+ 에서 GPU-가속됨(4–6×) → "전 ph.x no-GPU"는 **부분 outdated**. 그러나 우리가 쓰는 `electron_phonon='simple'` λ·a²F 스텝은 QE 수석저자 확인 **GPU 미포팅(7.5 크래시) + nvfortran/.dvscf↔gfortran 비호환** → λ·Tc end-to-end GPU 경로 부재 ⇒ **실효 벽 유지**, QFORGE 존재 이유 VALIDATE · (2) **알고리즘 벽**: O(N³) 대각화 + dense per-q DFPT 의 본질적 스케일링. 세 LANE(⚡hardware · 🧮algorithmic · 🧠paradigm)로 정렬. **각 아이디어는 PROPOSAL** — 실 `hexa bench` roofline + Δ-vs-baseline 으로 닫기 전에는 ⚡/🧮 closed 아님 (g6/g63 정직 scope). **21/21 백로그 항목이 terminal** (`## closure status`): 6 항목 CLOSED — 5 closed-form (SIMD-INERT 🔴 / mixedprec-2× / multigrid-fav / symmetry-48 / threading-10) + 1 measured (Lanczos vs Davidson · docs-only bench) · 4 항목 측정-grounded (분모 박제 · [[QFORGE-PERF.bench]] §2/§7) · 11 항목 GATED (GPU pod / 엔진 edit / ML infra 외부 의존 명시). docs-only 도메인에서 가능한 100% closure.

## baseline — measured anchor (2026-06-01 · [[QFORGE-PERF.bench]])

모든 ⚡/🧮 speedup 비율의 **분모**. 측정·박제 완료 (mini · Apple M4 · `hexa 0.1.0-dispatch`):

```
hot-path 커널           CPU-scalar baseline   RTX 5070 메모리 천장      headroom
────────────────────    ───────────────────   ────────────────────     ──────────
qforge_h_apply v↦H·v    0.140 GFLOP/s          fp64 139.88 · fp32 279.76  ~1000–2000×
(assembler.hexa:140)    (n=256/512/1024 평탄)  GFLOP/s (BW·AI)            (memory roof)
```

- 🟢 **MEMORY-BOUND** (closed-form, verdict 박제): `AI 0.25–0.5 ≪ ridge_fp32 60.96 ≪ ridge_tc 226.1` → 단일 GEMV 는 tensor-core peak(126 TFLOP/s) **도달 불가**. tensor roof 는 matvec 을 GEMM 으로 **batch** 할 때만 열림(Davidson-block 경로). 따라서 ⚡ 현실 천장 = 140–280 GFLOP/s 메모리 roof — 단일 GEMV 에 > ~2000× 주장은 roofline 위배.
- verdict: `.verdicts/qforge-perf-roofline/h-apply-membound.txt` (🟢 SUPPORTED-NUMERICAL).
- 측정치 평탄(n-독립 GFLOP/s) = memory-bound 지문 — `AI = 2/b` 가 n 독립이라 이론과 일치.

**네 hot loop 전부 grounding 완료** (per-call wall · user_s 기준 · [[QFORGE-PERF.bench]] §7):

```
hot loop (engine fn)        size sweep         per-call wall (user)   feeds
─────────────────────       ──────────────     ───────────────────    ──────────────────────
H_apply (matvec)            n 256/512/1024     0.140 GFLOP/s (평탄)    ⚡ H_apply GPU-GEMM
FFT-Poisson  vhartree…      nz 256/1024/4096   11.5 / 217 / 4180 ms   ⚡ cuFFT / NVPTX-FFT
Davidson     qforge_davidson n 128/256/512     15.2 / 54.7 / 169 ms   ⚡ Davidson VᵀHV · 🧮 CheFSI
Sternheimer  qforge_sternh… n 128/256/512      15.8 / 107 / 1372 ms   ⚡ Sternheimer CG resident
```

- FFT-Poisson 은 radix-2 FFT(O(N log N))인데 per-call wall 은 ~O(N²) — butterfly 가 아니라 **call 당 O(N) scratch 할당** + 캐시 압박이 원인. cuFFT 이득이 mesh 크기에 따라 log-linear 예측보다 빠르게 커짐. 부차 관측(handoff): 큰 grid 반복 호출 시 메모리 누적 → 부하 하 OOM (stdlib/signal·runtime 영역 · 본 docs-only 도메인 범위 밖).
- 모든 ⚡/🧮 `🟢bench-needed` 항목이 이제 측정된 분모를 가짐. 구현 항목은 자기 GPU Δ 를 게시할 때 비로소 closed (g6/g63).

## 전제 — hot loops (선행 grounding, 2026-06-01)

QFORGE el-ph 의 측정된 hot path (재분석 금지, 사용):

```
hot loop                         위치                         성격
────────────────────────────    ─────────────────────────    ──────────────────────────────
qforge_h_apply                   assembler.hexa:140           dense O(n²) scalar matvec ·
                                                              Davidson + 모든 Sternheimer CG
                                                              iter 의 innermost kernel
  └ dense H build                 (structure-factor pass)      O(n³)-effective
dv_project (VᵀHV)                davidson.hexa:67             batched matvec + GEMM, scalar
Sternheimer CG                   sternheimer.hexa            per-pert projected CG
                                                              (H_apply + GS project_out / iter)
  └ elph_scf 가 호출               (m_occ× per SC iter,         **el-ph hot path**
                                   nested in max_iter)
FFT-Poisson V_H[ρ]               screening.hexa             CPU fft3_real/ifft3 (stdlib/signal)
                                                              매 SCF iter · **cuFFT path 없음**
```

```
현재 (CPU-scalar · dense-DFPT)          가속 목표 (이 도메인)
──────────────────────────────────    ───────────────────────────────────────
scalar O(n²) H_apply matvec       →    forge_dispatch_matmul GPU-GEMM (byte-eq 선례)
dense per-q DFPT Sternheimer      →    EPW-style coarse-q DFPT + Wannier interp (|g|)
CPU fft3_real Poisson (매 iter)   →    cuFFT / NVPTX-FFT V_H path
O(N³) Davidson 대각화             →    Chebyshev-filtered subspace iter (CheFSI)
finite-diff + Sternheimer LR      →    differentiable-DFT reverse-mode (AD) LR
seed-from-zero 매 candidate       →    MLIP/Δ-ML pre-screen + transfer across pool
```

## ── ⚡ LANE A · hardware accel (CPU/GPU) ──

> reuse: NVPTX target(compiler/codegen/nvptx_target.hexa · WMMA · RFC 055/071) · cuda_rtc(self/ml/cuda_rtc.hexa · rtc_launch · PTX cache) · `forge_dispatch_matmul`(CPU farr↔cuBLAS byte-eq) · FLAME GPU device-routing 선례([[FLAME-PERF]]) · 측정 roofline [[GPU-ROOFLINE]] (RTX 5070 · A100).

- [x] **fft_native in-place butterfly** ⚡shipped 🟢verified — radix-2 버터플라이가 버터플라이마다 전체 배열 재구축(O(n²·log n) alloc/FFT)하던 것을 4-원소 in-place 수정(O(1))으로 교체. converged el-ph OOM 근원(RSS 4-5GB→508MB) 제거 + 대폭 속도↑. **모든 FFT user(signal·qforge) 수혜**. g5 fft3 selftest ALL PASS(round-trip 8.88e-16, byte-identical). hexa-lang #2787.
- [x] **FFT-Poisson scratch-buffer reuse** ⚡shipped 🟢verified — screened el-ph fold churn(per-band scatter+2 real transform×8band×Anderson iter×3dir)의 per-call Ntot grid alloc을 module scratch(PWFFT_SCAT·REAL0/1 distinct·DRHO/RHO) 재사용으로 제거. correctness-neutral(smoke byte-identical). hexa-lang #2786.
- [ ] **H_apply GPU-GEMM** ⚡hardware-PR 🟢bench-MEASURED 🔴NOT-FASTER-at-size(d6 정직) — `qforge_h_apply_forge`(assembler.hexa) seam → `forge_dispatch_matmul`(CUDA host=cuBLAS DGEMM). **2026-06-06 RTX A5000(sm_86) 실측**(hexa CUDA build · happly_gpu_bench.hexa · PR#2807): parity PASS 이나 **wall Δ < 1** — `n=256 scalar 0.0847 GFLOP/s vs forge 0.000411(wallΔ 0.0049×) · n=512 0.0848 vs 0.0793(0.935×) · n=1024 0.0852 vs 0.0757(0.889×)` · maxAbsDiff 1.42e-14/3.20e-14/8.88e-14(FP64-tol). **단일 GEMV(n×n·n×1)는 memory-bound + per-call farr-marshal+H2D/D2H 전송 지배** → roofline verdict(140–280 GFLOP/s membound, `.verdicts/qforge-perf-roofline/h-apply-membound.txt`)대로 **단일 matvec GPU 승리 불가 실측 확인**. tensor-roof 는 batch-GEMM 일 때만 열림 → 그 실현이 K2(Davidson VᵀHV, 아래 [x] 45–61× 측정). **grounded [ ] 유지**(correct-but-not-faster, d6 강제승리 거부) · falsifier(wall Δ ≥ 1) 미충족.
- [x] **Davidson VᵀHV GPU-GEMM** ⚡hardware-PR 🟢bench-VERIFIED — `dv_project`(davidson.hexa:67) 의 W=H·basis[b] + Hs=Vᵀ·W 를 **두 cuBLAS DGEMM**(W=H·Vᵀ, Hs=V·W)으로. **2026-06-06 RTX A5000 실측**(nvptx_davidson_vthv_host.cu · PR#2807): parity PASS 전 size + **representative size 에서 큰 win** — `n=256 m=16 cpu 0.857ms gpu 28.2ms (0.030×, 작은-n transfer 지배) · n=512 m=32 7.27/9.26ms (0.784×) · n=1024 m=64 59.4/1.30ms (45.814×) · n=2048 m=64 237.5/3.89ms (61.007×)` · max_rel_err 1.18e-12/2.38e-13/1.12e-12/4.34e-11 (tol 1e-9 ALL PASS). **batch-GEMM 경로가 H-application 의 tensor-roof 를 열어 45–61× 실현** — K1 단일-GEMV 가 못한 win 을 batched 가 달성. falsifier(스펙트럼 tol 일치 ∧ wall Δ) PASS @ n≥1024.
- [x] **Sternheimer CG GPU-resident** ⚡hardware-PR 🟢bench-VERIFIED — per-pert projected CG(matvec/shift_sub/axpy/xpay/proj_out)를 device-resident NVPTX 커널로, n-벡터는 CG iter 전체 동안 VRAM 상주(스칼라 α/β/잔차만 host 왕복 — documented d6 scope). **2026-06-06 RTX A5000(sm_86) 실측**(nvptx_sternheimer_host.cu + emitted PTX · PR#2807; B200 sm_100 선행 PASS 재확인): `max_rel_err = 3.018825e-16` (max_abs 5.55e-17 · gpu_iters=3 · tol 1e-5) **PARITY: PASS** — CPU projected-CG ≡ GPU-resident projected-CG 기계정밀. correctness-anchor(5×5 fixture, 속도주장 아님 — 큰-셀 wall 은 K1/K2 GEMM 경로가 담당). falsifier(응답 ψ' tol 일치 ∧ device-resident) PASS.
- [x] **cuFFT / NVPTX-FFT Poisson V_H** ⚡hardware-PR 🟢bench-VERIFIED — screening.hexa 의 CPU `fft3_real`/`ifft3` Poisson(`qforge_vhartree_from_drho`)을 **cuFFT Z2Z**(fwd → 4π/|G|² → inv ÷N)로. **2026-06-06 RTX A5000 실측**(nvptx_poisson_cufft_host.cu · PR#2807): parity PASS 전 mesh(per-elem hybrid gate abs≤1e-12 OR rel≤1e-9 · max_abs 2.0e-15/1.3e-15/4.7e-16) + **mesh 클수록 win 증가** — `16³ cpu 0.430ms gpu 0.246ms (1.751×) · 32³ 3.21/0.467ms (6.870×) · 64³ 26.7/3.40ms (7.845×)`. 64³ 의 max_rel 1.38e-8 은 V_H≈1e-8 near-zero 상쇄 bin 의 metric artifact(abs-err 는 FP64 eps 4.7e-16) — hybrid abs/rel gate 로 정직 close. **FFT 가 유일 CPU-only 잔여 경로였음 → cuFFT 로 6.9–7.8× 가속 실측**(arxiv 2412.01695 큰-mesh cuFFT 우위 confirm). falsifier(V_H fp-tol ∧ 매-iter wall Δ) PASS. d8: Vast 특이사항 없음(cuFFT 표준 경로).
- [x] **mixed-precision inner / FP64 refine** ⚡hardware-PR ⚪speculative ✅CLOSED-FORM — fp32 는 memory-bound 커널에서 byte-halving 으로 **정확히 2×** (AI 0.25→0.5, 여전히 ≪ ridge) — arxiv 6× 는 compute-bound regime 으로 본 BW-bound 커널에 비적용. FP64-refine 추가 pass → <2×. **verdict: `.verdicts/qforge-perf-roofline/mixedprec-2x.txt` (🟢)**.
- [x] **CPU SIMD band-loop vectorize** ⚡hardware-PR ⚪speculative 🔴CLOSED-NEGATIVE — band-loop 지배 커널 = memory-bound H_apply matvec (측정 0.140 GFLOP/s, n-평탄). SIMD 는 *compute* throughput 만 올림 → BW-bound wall 불변 → **wall speedup = 1.0 (무력)**. 벡터 폭 확대는 ridge 만 올려 더 memory-bound 화. **verdict: `.verdicts/qforge-perf-roofline/simd-inert.txt` (🟢)**.
- [x] **k/q-loop threading + q-point batching** ⚡hardware-PR 🟢bench-needed ✅CLOSED-FORM — 독립 k/q-point (no data dep) + λ=Σ_q 가환 reduction → 순서 불변. Amdahl serial≈0 ⇒ ideal speedup = min(N_q, N_core). mini M4 10-core → **천장 10×**. **verdict: `.verdicts/qforge-perf-roofline/threading-10.txt` (🟢)**.

## ── 🧮 LANE B · algorithmic (hardware-AGNOSTIC) ──

- [x] **EPW-style Wannier |g| interpolation** 🧮algorithmic 🟢bench-VERIFIED — **dense per-q DFPT 를 회피**: coarse-q DFPT |g| → real-space g(R) (forward DFT) → inverse DFT 로 ANY dense q (Wannier interp · arxiv 1005.4418 Noffsinger-Giustino CPC 181 2140 · Giustino 2017 RMP Eq.78-82). **q-축 Fourier pair** 구현(`stdlib/qforge/wannier_ginterp.hexa` · PR#2802 draft) — q 가 DFPT-당-1-run 비용 축이라 q-interp 이 dense-DFPT killer. **g5 (synthetic short-range g(q)=Σ_R c_R e^{i2πq·R}): coarse-nq=64(4³) → dense-nq=512(8³), rbox=1 · direct dense-DFPT λ=127592 · Wannier-interp λ=127592 · rel-ε=1.14e-16 (기계정밀 EXACT)** · coarse-only λ=126541 (rel-Δ 0.82% = 실제 interp) · round-trip 3.3e-16 · g(R) 박힌 c_R 정확복원. **d6 NEG control**: long-range g(R)(|R|=3) on too-coarse 3³(rbox=1) → rel-ε=0.64 (재현 실패 — exactness 는 short-range 조건부, polar-Fröhlich tail 은 mesh 확대/polar-subtraction 필요 = EPW 방식). 즉 **coarse→dense interp 은 g(R) short-range 일 때 exact** 임을 g5 박제. honest scope: synthetic g 검증(실 DFPT |g| 미실행) — CaH6/LaH10 실셀 cross-val 은 별도 GATED. 5/5 g5 PASS · metallic_a2f regression PASS. **= priority #1.**
- [x] **Chebyshev-filtered subspace iter (CheFSI)** 🧮algorithmic 🟢bench-VERIFIED — Davidson 의 growing-subspace O(N³) 명시적 직교화 회피 — degree-m Chebyshev 필터 p_m(H)로 wanted(저) eigenspace 증폭(3-항 점화 c=(b+a)/2·e=(b-a)/2·t₀=X·t₁=(HX−cX)/e·t_{k+1}=2(Ht_k−ct_k)/e−t_{k-1}, unwanted 상부 [a,b]→[-1,1] 감쇠) + Rayleigh-Ritz(QᵀHQ small dense eigh, reuse d19) 1회/outer pass·블록폭 고정(=nocc). **g5 (synthetic 대칭 diag-dominant H · n=64 · nocc=6 · degree m=18): CheFSI 최저-6 고유값 == dense-eigh ref == 엔진 Davidson, max|Δλ|=5.83e-13 (기계정밀) → VERDICT_CHEFSI=MATCH**. degree 수렴 단조(m=4→1.27e-8 · m=8→1.49e-9 이미 gate clear · m=12→1.55e-10 · m=16→2.14e-11 · m=18→5.83e-13). **d6 정직**: 이 작은 dense 64×64(well-separated 저스펙트럼 + Jacobi-precond Davidson)에선 CheFSI matvec 더 비쌈(570 vs 66) — CheFSI 이점은 large-N 점근(Davidson growing-subspace 직교화 O(N³)/restart vs CheFSI 고정 블록폭 + 3-항 점화, Zhou et al. §4-5). g5 주장 = **스펙트럼 회수**(정확성 게이트); large-N matvec 이점은 문서화된 근거로 n=64 에서 주장 안 함. docs-only bench-driver(`bench/qforge/chefsi_vs_davidson.hexa` · stdlib/qforge 미편집 d3) · CPU-only no-rent. **Lit: Y. Zhou·Y. Saad·M. L. Tiago·J. R. Chelikowsky, J.Comp.Phys. 219 (2006) 172-184 · companion Phys. Rev. E 74, 066704 (2006) · arxiv cond-mat/0703239**. PR#2803 draft.
- [x] **better SCF preconditioner + mixing** 🧮algorithmic 🟢bench-VERIFIED — linear mixing → Pulay/Broyden DIIS(arxiv 1803.01763). DIIS density mixer(`qforge_anderson_next` · mixing.hexa)는 이미 SCF 드라이버에 배선됨(`qforge_scf_smeared` `and_depth>0` 분기 · 첫 iter linear fallback). **g5 driver-level 게이트 추가**(hexa-lang `scf_diis_speedup_selftest.hexa` · PR#2794 draft): 같은 드라이버·같은 금속 셀(ρ-피드백 charge-slosh + E_F 근접퇴화 + Fermi-Dirac smearing)·같은 β/σ/시작점에서 linear(and_depth=0) vs DIIS(and_depth=5). **측정: linear 58 → DIIS 16 iter (3.6× 절감) · 같은 고정점**(|ΔE_tot|=1.10e-9<1e-8 · max|Δρ|=7.66e-10<1e-7)·둘 다 수렴. falsifier(SCF iter-count Δ ∧ 수렴값 불변) PASS. **honest scope**: docs-bench 드라이버 iter-count 검증(GPU/wall-time 아님) · TPA kinetic preconditioner 부분은 미구현(별 항목). 고gain(g=2.4)에선 linear 발산(400 iter cap) DIIS 18 iter — 더 강한 win이나 "같은 고정점" 앵커가 깨져 g=1.2 사용(둘 다 수렴 apples-to-apples).
- [x] **k/q symmetry reduction + Γ-only fast path** 🧮algorithmic 🟢bench-needed ✅CLOSED-FORM — irreducible BZ wedge 는 **정확** (λ=Σ_q w_q λ_q 가 star-sum 복원에 불변 · 근사 아님). q-count 천장 = 결정 점군 위수: LaH10(Fm-3m)·CaH6(Im-3m) 입방정 Oh → **|G|=48×** (Γ-only → q-count=1). **verdict: `.verdicts/qforge-perf-roofline/symmetry-48.txt` (🟢)**.
- [x] **randomized / sketched eigensolver** 🧮algorithmic ⚪speculative 🟢bench-VERIFIED — Halko-Martinsson-Tropp randomized subspace iteration(SIAM Rev. 53 (2011) 217 "Finding Structure with Randomness" · Alg.4.3 + Alg.5.3 Rayleigh-Ritz)로 occupied subspace 최저-nocc 고유쌍 추출. **eigensolver catch(d6)**: 랜덤 sketch 는 DOMINANT(최대-|λ|) subspace 만 찾음 → 최저 occupied 는 잘못된 끝. 따라서 **스펙트럼 변환** `A=(cI−H)`(c=Gershgorin bound ≥ λ_max → 최저 H-고유값이 A 의 최대 고유값) + q power-iter `Y=A^q·Ω` + QR + **원 H 에 Rayleigh-Ritz** `Hs=QᵀHQ` → small eigh → 최저-nocc Ritz. 재현가능 난수(hexa Math.random 없음): hashed-index LCG→Box-Muller Gaussian sketch, FIXED seed=1234567. **g5 (n=64 · nocc=6 · p=6 · seed=1234567 · synthetic diag-dominant H · shift c=131.744): randomized sketch 최저-6 고유값 == dense-eigh ref == 엔진 Davidson, max|Δλ|=2.13e-14 (기계정밀) @ q=128 → VERDICT_RANDEIG=MATCH** (hexa verify 🟢 SUPPORTED-NUMERICAL). q-수렴 단조: q=1→25.24 · q=8→2.381 · q=16→0.184 · q=32→6.92e-4 · q=64→7.85e-8(gate 1e-6 clear) · q=128→2.13e-14. lowest-6 @ q=128: k0 1.86296 · k1 3.93966 · k2 5.96720 · k3 7.97990 · k4 9.98664 · k5 11.99060 (ref==davidson==randomized). **d6 정직(⚪speculative)**: 방법은 CORRECT(기계정밀 회수·단조수렴)이나 spec-target q=1-2 에선 **Davidson(5 iter/~66 matvec) 대비 matvec-비경쟁** — 이 clustered LOW 스펙트럼(gaps≈2, A 에서 magnitudes≈120-130)은 per-power-iter 수렴비 ~1.017 라 (cI−H) 변환이 occupied subspace 분리에 q≈64-128 필요. grounded fix = 더 sharp 한 shift-invert `(H−σI)^{-1}`(Halko §6.2 · per-matvec linear solve = 별 항목). fast-decay 행렬엔 q=1-2 sketch 승리, 이 QFORGE-like occupied band 엔 미승. 양방향 다 valid ⚪ close (d6 — no forcing). docs-only bench-driver(`bench/qforge/randomized_eig.hexa` · stdlib/qforge 미편집 d3) · CPU-only no-rent · **PR#2804 draft**.
- [x] **Lanczos vs Davidson 비교** 🧮algorithmic ⚪speculative ✅CLOSED-MEASURED — docs-only bench 에 대칭 Lanczos(full-reorth) 구현 → 엔진 Davidson 과 동일 행렬에서 λ₀ **1e-8 일치**. 동일 정확도에서 Lanczos 75 matvec vs Davidson 11 preconditioned iter → **Lanczos matvec 이점 없음, Davidson 유지**. **verdict: `.verdicts/qforge-perf-roofline/lanczos-vs-davidson.txt` (🟢)** · driver `bench/qforge/lanczos_vs_davidson.hexa`.
- [x] **adaptive q-grid sampling** 🧮algorithmic ⚪speculative — α²F(ω) 기여 큰 q 영역 적응 조밀화, flat 영역 coarse. falsifier: λ tol 일치 at 더 적은 총 q. — 🟢bench-VERIFIED #2801: adaptive curvature-bisection q-refinement, 2.25× q-point saving at 0.11% λ-accuracy vs dense (fair off-grid sharp peak); uniform nq=81→adaptive nq=36. g5 ALL PASS.
- [x] **real-space multigrid vs G-space Poisson** 🧮algorithmic ⚪speculative ✅CLOSED-FORM — multigrid V-cycle O(N) 가 **측정된** FFT-Poisson wall ~O(N^2.1) (bench §7a: nz 4×→~19×) 대비 scaling-favorable (ideal FFT O(N log N) 대비도 log N 우위). **verdict: `.verdicts/qforge-perf-roofline/multigrid-fav.txt` (🟢)**.

## ── 🧠 LANE C · paradigm shift ──

- [ ] **differentiable-DFT reverse-mode LR** 🧠paradigm 🔬research-probe — finite-diff + Sternheimer linear-response 를 reverse-mode AD 로 대체 (Jrystal · Grad-DFT · QEX · JAX-XC · arxiv 2311.18727 · 2602.05345 LR-TDDFT through SCF fixed point). forces AND linear response 둘 다 autodiff. hexa 가 자체 AD 보유 시 hexa-native 경로. falsifier: AD-그래디언트 == finite-diff 응답 (tol) ∧ Sternheimer-call 제거.
- [ ] **equivariant GNN phonons + el-ph (MACE-class)** 🧠paradigm 🔬research-probe — E(3)-equivariant GNN 으로 phonon(Hessian 2nd-deriv) + α²F(ω) (arxiv 2403.11347 · BETE-NET arxiv 2401.16611 Tc MAE 2.5K · BEE-NET 0.87K). DFT seed/skip. falsifier: GNN α²F == DFPT α²F (held-out) ∧ Tc MAE.
- [ ] **Δ-ML correction (cheap + ML→DFT accuracy)** 🧠paradigm 🔬research-probe — 저렴한 method + ML 보정으로 DFT 정확도. HamGNN/DeepH = KS Hamiltonian 예측 + 변위-미분 AD el-ph (Nature Comp Sci s43588-024-00668-7). falsifier: Δ-ML λ == full-DFPT λ (tol) ∧ DFPT-call Δ.
- [ ] **MLIP foundation-model pre-screen** 🧠paradigm 🔬research-probe — MACE/CHGNet-class universal MLIP 로 candidate pool 사전선별(동적안정·phonon) → DFT 는 통과분만 (arxiv 2503.20005 AI-accel SC discovery workflow). falsifier: MLIP-pass 후보가 DFT 동적안정 recall ∧ pool DFT-fire Δ.
- [ ] **active-learning on-the-fly training** 🧠paradigm ⚪speculative — D-optimality uncertainty-driven 표본선택(arxiv 1611.09346) 으로 surrogate on-the-fly 학습. falsifier: extrapolation 0 ∧ DFPT-label budget Δ.
- [ ] **transfer / reuse across candidate pool** 🧠paradigm ⚪speculative — 검증된 후보(LaH10·CaH6)의 Wannier/surrogate 를 인접 화학종에 transfer (d19 reuse-lattice). falsifier: transfer-seed 수렴 iter Δ ∧ 정확도 유지.

## priority — 최고-leverage 상위 5 (lane 횡단)

prior-art 로 정당화된 랭킹:

1. **🧮 EPW-style Wannier |g| interpolation** (Lane B) — **field 의 단일 최대 el-ph 속도향상.** coarse-q DFPT(4³) → Wannier Fourier interp → dense (k,q). dense per-q DFPT(29-pod teardown 의 원인)를 **본질적으로 제거** — 하드웨어 가속이 아닌 *연산량 자체*를 죽임. 확립된 prior art: EPW(arxiv 1005.4418 · 1604.03525 · npj s41524-023-01107-3) 가 정확히 이 패턴으로 표준이 됨. **dense-DFPT killer 확정.**
2. **⚡ H_apply / Davidson GPU-GEMM** (Lane A) — innermost kernel(assembler.hexa:140)을 `forge_dispatch_matmul`(byte-eq 선례)로. EPW interp 후에도 잔존하는 coarse-DFPT + SCF 의 dense matvec 을 가속. FLAME-PERF 가 동일 경로(CLM matmul→forge)를 이미 H100 실증.
3. **🧠 differentiable-DFT reverse-mode LR** (Lane C) — Sternheimer finite-diff LR 를 AD 로 — 패러다임 교체. Jrystal/Grad-DFT/QEX 가 SCF fixed-point 통과 AD 를 실증(arxiv 2602.05345). hexa AD 보유 시 가장 hexa-native.
4. **🧮 CheFSI** (Lane B) — O(N³) Davidson 대각화의 sub-cubic 대안 (arxiv cond-mat/0703239). 셀이 커질 때(≥20 atom, d7 GPU 영역) 알고리즘 벽을 직접 완화. GPU-GEMM 과 직교 — 둘 다 적용 가능.
5. **🧠 MLIP foundation-model pre-screen** (Lane C) — pool 단계 leverage: DFT 를 *덜 자주* 실행. MACE/CHGNet pre-screen 으로 동적불안정 후보를 DFT 전에 탈락 (arxiv 2503.20005). λ·Tc 정밀도는 여전히 DFPT 가 닫지만, fire 횟수를 줄임.

랭킹 근거: 1·4 는 *연산 복잡도*를 줄이고(hardware-agnostic), 2 는 *상수항*을 줄이며(여전히 큰 win, 선례 확실), 3·5 는 *패러다임*을 바꾼다(최고 상한, 최고 불확실성). EPW 가 dense-DFPT killer 라는 가설은 prior art 로 **확정**.

## reuse — cross-domain / cross-repo (g67/g68 정직 scope)

- **intra-repo (g67)**: `forge_dispatch_matmul`(CPU farr↔cuBLAS byte-eq) · NVPTX target(compiler/codegen/nvptx_target.hexa · WMMA · RFC 055/071) · cuda_rtc(self/ml/cuda_rtc.hexa · rtc_launch · PTX cache) · FFT(stdlib/signal fft3_real/ifft3 — cuFFT path 미존재, Lane A 항목). 측정 잣대 [[GPU-ROOFLINE]] (RTX 5070 · A100 roofline). GPU device-routing 선례 [[FLAME-PERF]] (CLM matmul→forge H100 실증).
- **cross-repo (g68)**: demiurge PWFORGE/QFORGE 캠페인(RTSC el-ph)이 이 엔진의 down-stream 소비자 — 가속은 거기서 wall-time·$ 로 실현됨. **honest scope**: 이 도메인은 hexa-lang stdlib/qforge 의 PROPOSAL 백로그일 뿐, demiurge 캠페인 코드는 건드리지 않음(d3 canonical home · d9 worktree isolation). 별도 QFORGE CaH6-run agent 활성 — stdlib/qforge edit 회피, 이 도메인은 docs-only.

## closure status — 21/21 terminal (g63 정직 · 2026-06-01 · DIIS-mixing closed 2026-06-06)

도메인의 모든 백로그 항목이 **terminal** 상태에 있다. terminal = ① 측정-grounded(분모
박제) · ② closed-form CLOSED(verdict 박제) · ③ GATED(외부 blocker 명시 + unblock
trigger). 각 항목은 이 셋 중 하나로 분류되며 verdict 또는 blocker 가 명시된다 — docs-only
도메인에서 가능한 100% closure.

```
terminal 상태       건수   항목
─────────────────   ────   ─────────────────────────────────────────────────────
✅ closed-form (🟢)   5    SIMD-INERT(🔴neg) · mixedprec-2× · multigrid-fav ·
                            symmetry-48 · threading-10  (verdicts 박제)
✅ closed-measured    2    Lanczos vs Davidson (docs-only bench · λ₀ 1e-8 일치 ·
                            75 vs 11 iter → Davidson 유지 · 🟢) · DIIS-mixing
                            (driver g5 · linear 58 vs DIIS 16 iter · 같은 고정점
                            |ΔE|=1.1e-9 · PR#2794 · 🟢)
📊 grounded (분모)    4    H_apply 0.140 GFLOP/s · FFT/Davidson/Sternheimer wall
                            (bench §2/§7 — speedup 비율의 분모, GPU-Δ 게시 시 close)
⛔ GATED-GPU         4    H_apply/Davidson/Sternheimer/cuFFT GPU-GEMM
                            → blocker: GPU pod (전부 STOPPING) · trigger: pod READY
✅ closed-measured  +3    randomized/sketched eigensolver (HMT subspace iter ·
                            docs-only bench · g5 n=64 nocc=6 p=6 seed=1234567 ·
                            (cI−H) spectral-shift + QR + RR · max|Δλ|=2.13e-14
                            @ q=128 vs dense-ref == Davidson · MATCH 🟢 · d6:
                            정확하나 q=1-2 Davidson 대비 matvec-비경쟁
                            (~1.017 수렴비) → shift-invert 별항목 · PR#2804)
✅ closed-measured  +1    CheFSI (docs-only bench-driver · g5 n=64 nocc=6
                            degree m=18 · max|Δλ|=5.83e-13 vs dense-ref ==
                            Davidson · MATCH · degree 단조수렴 m≥8 gate-clear ·
                            d6: large-N 점근이점 문서화 n=64 미주장 · PR#2803 · 🟢)
✅ closed-measured  +2    EPW-Wannier |g| q-interp (g5 coarse 64→dense 512
                            rel-ε=1.14e-16 EXACT · NEG-ctrl rel-ε=0.64 d6 ·
                            PR#2802 🟢) · adaptive-q (#2801 위 closed)
⛔ GATED-RESEARCH    6    🧠 LANE C 전부 → blocker: ML 학습 infra + GPU + 연구 ·
                            trigger: 별도 ML 도메인 (CLM-KOSMOS 류)
─────────────────   ────
합계                21    (= 8 closed + 4 grounded + 9 gated · 0 ambiguous)
```

> grounded 4 는 `🟢bench-needed` ⚡ 항목 — 분모는 측정됐고(close 의 절반), 실 GPU-Δ
> 만 남음. 따라서 `- [ ]` 유지가 정직(천장≠구현, H_apply 선례). GATED 11 은 외부 의존이
> 명시돼 terminal — 본 docs-only 도메인이 더 진행할 수 없는 honest 경계. DIIS-mixing 은
> 2026-06-06 driver-level g5(linear 58 → DIIS 16 iter · 같은 고정점)로 GATED-IMPL →
> closed-measured 승격(PR#2794) — docs-bench 드라이버로 닫을 수 있었던 알고리즘 항목.
> randomized/sketched eigensolver 도 2026-06-06 docs-only bench-driver g5(HMT
> (cI−H) sketch · max|Δλ|=2.13e-14 @ q=128 · MATCH)로 GATED-IMPL → closed-measured
> 승격(PR#2804) — d6: 정확하나 q=1-2 Davidson 대비 비경쟁(clustered low spectrum
> ~1.017 수렴비, shift-invert 별항목), 그래도 grounded close 가 valid ⚪.

## scope — 정직 (g6/g63)

각 항목의 closure 근거는 `## closure status` 가 SSOT 다. **closed (12):** 5 closed-form + 1 measured (Lanczos · `.verdicts/qforge-perf-roofline/` — SIMD-INERT 🔴 · mixedprec-2× · multigrid-fav · symmetry-48 · threading-10 · lanczos-vs-davidson, 전부 🟢) + DIIS-mixing(PR#2794) + CheFSI(PR#2803) + EPW-Wannier|g|(PR#2802) + adaptive-q(#2801) + randomized/sketched-eig(HMT (cI−H) sketch · max|Δλ|=2.13e-14 @ q=128 · PR#2804 🟢) + 4 측정-grounded 분모 (H_apply 0.140 GFLOP/s · FFT/Davidson/Sternheimer per-call wall · roofline 천장 fp64 139.88 / fp32 279.76 GFLOP/s · 🟢 MEMORY-BOUND verdict · [[QFORGE-PERF.bench]] §2/§3/§7). **GATED (10):** GPU pod(전부 STOPPING) / stdlib/qforge edit(타 에이전트 소유) / ML 학습 infra 외부 의존 — blocker + unblock trigger 가 closure-status 에 명시됨. GATED ⚡항목은 자기 GPU `hexa bench` Δ-vs-분모 를 게시할 때 closed-grounded → closed-measured 로 승격. cross-val gate(d_qforge_engine): QFORGE vs QE λ·Tc 가 LaH10·CaH6·Li2MgH16 에서 g5-일치할 때 full migration. NOVEL kick probe(2026-06-01) verdict = skip(⚪ unverified proposals — g63 정직, fold 된 atom 없음).
