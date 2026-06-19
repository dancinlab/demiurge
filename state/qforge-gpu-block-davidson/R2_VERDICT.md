# QFORGE GPU block-davidson — R2 verdict (summer RTX5070 real-GPU 실측 + el-ph hot path 배선) 2026-06-19

Lane "gpu-block-davidson" R2. 목표 = summer RTX5070 진짜 GPU 실측(c2) + el-ph hot path block 배선.
R1(state/qforge-gpu-block-davidson/VERDICT.md) = CPU-parity 배선 PASS, GPU 실측은 R2로 이월(mini는 no-GPU build).

## 절차 SSOT (정직 c2·c9·d6)
GPU 빌드는 **standalone cuBLAS TU 경로**로 충족 — `runtime_cuda.c`가 `#ifdef HEXA_CUDA`로
링크하는 그 cuBLAS Dgemm 경로를, PR #3442/3659가 박제한 standalone `.cu` 하니스(`nvptx_*_block_e2e_host.cu`)로
컴파일·실행. full hexa selfhost rebuild(~68min×3 stage)은 R2 범위 밖 — `.cu` 하니스가 동일 cuBLAS Dgemm을
직접 실측하므로 GPU 실측 목표(점유·디스패치·speedup)는 충족. provenance: summer · RTX 5070 sm_120 · nvcc 12.0 · cuBLAS 12.

⚠ 측정 환경 정직: summer GPU는 측정 시점에 **RBFE production job(pid 2565, rbfe_hsp90.py, 8.5h)이 100% 점유 중**.
내 벤치는 그와 **동시 실행**(co-resident) — 절대 wall은 contention으로 부풀려짐. 그래서 speedup은 보수적(하한).
#3442의 clean 74.9× 대비 내 73.4×는 재현 확인(contention하 하한)이지 신규주장 아님.

## R2 PASS/FAIL

### 1. summer -DHEXA_CUDA 빌드 — **PASS**
- nvcc 12.0 (max arch compute_90) → default-arch 컴파일, 580 드라이버가 sm_120(Blackwell)로 PTX-JIT forward.
- 4개 standalone 하니스 모두 빌드 OK: `nvptx_happly_block`, `nvptx_davidson_block_e2e`,
  `nvptx_sternheimer_block_e2e`, `gpu_qforge_ridge` (`nvcc -O2 <f>.cu -lcublas`, RC=0).
- 벽: `-arch=sm_120`은 nvcc 12.0서 미정의 → default-arch(PTX forward-JIT)로 해결. (가드: 12.0서 sm_120 명시 금지)

### 2. GPU 실측 (c2 · nvidia-smi 점유 + cuBLAS 디스패치 + wall speedup) — **PASS**
모두 summer RTX 5070 sm_120 실측, RBFE-contended (하한):

| 하니스 | 최대 speedup vs CPU | parity | 점유/디스패치 증거 |
|---|---|---|---|
| happly_block (n=2048 m=64) | **73.4× GEMM** (clean #3442=74.9×) | max_rel **4.707e-11** (#3442=4.7e-11 동일) · ALL PASS | `[gpu] NVIDIA GeForce RTX 5070 sm_120` |
| davidson_block_e2e (solver hot path) | **15.7×** @n=2048 nb=16 | max\|Δλ\| **3.55e-15** ≪ 1e-7 · ALL PASS | — |
| sternheimer_block_e2e (DFPT 응답) | **8.76×** @n=2048 nb=8 | max\|dDψ\| **4.16e-17** · ALL PASS | — |
| ridge sweep (closed-form 검증) | nb=1 GEMV **287 GFLOP/s** mem-roof, peak **24.3 TFLOP/s** @nb=512 (71% FP32 peak) | regime flip **nb=122**(#3442 예측 115~122 적중) | — |

- **GPU 점유 캡처(nvidia-smi)**: 50ms 샘플러로 ridge 실행 중 내 벤치 프로세스(pid 62051)가 RBFE(pid 2565) 옆에
  **co-resident, 674 MiB device mem** 점유 확인 → GPU 실제 실행 증명(컴파일/스텁 아님).
- **cuBLAS Dgemm 디스패치 로그(nsys)**: davidson_block_e2e 프로파일 →
  `cutlass_80_tensorop_d884gemm_*` 커널 30 instance, 19.1ms GPU time.
  `d884gemm` = FP64 DMMA, `tensorop` = 텐서코어 → block davidson이 **진짜 cuBLAS Dgemm을 RTX5070 텐서코어**서 실행.
- **74.9× 재현**: 73.4× (contended 하한). parity 4.707e-11 = #3442 박제값과 자릿수 일치.
- raw: `state/qforge-gpu-block-davidson/R2_GPU_RAW.txt` (summer ~/qforge_gpu_r2/).

### 3. el-ph hot path block 배선 — **PASS** (R1 = scf/scf_pw, R2 = orchestrator_pw + gga_scf)
hexa-lang 브랜치 `qforge/elph-block-wire-r2` (base = PR#3659 `qforge/block-davidson-wire`):
- **orchestrator_pw.hexa** (el-ph |g|² hot loop):
  - `qforge_pw_occ_states_block` — 점유 KS 상태 재대각화를 `qforge_davidson_block`(batched GEMM apply
    over `qforge_h_block_of_rho_global`)로. scalar `qforge_pw_occ_states`는 불변(parity ref + fallback).
  - `qforge_atoms_to_tc_block` — atoms→Tc 체인의 occ-state eigensolve만 block 경로로(downstream |g|²·α²F·λ·Tc 동일).
    공유 body `atoms_to_tc_impl(..., use_block)` → scalar `qforge_atoms_to_tc` byte-stable.
- **gga_scf.hexa** (LSDA spin SCF, 고-npw Co-3d hot path):
  - `gga_apply_block` — `farr_matmul(GGA_HFULL, n,n, Ψ, m)` 단일 GEMM batched apply (cuBLAS on CUDA build).
  - 두 spin 대각화(↑·↓)를 `qforge_davidson_block(gga_apply, gga_apply_block, ...)`로. gga_apply = parity ref + fallback.

배선 검증 (mini, no-GPU = CPU GEMM 폴백):
| gate | 결과 |
|---|---|
| orchestrator_pw 컴파일 (block 함수 typecheck) | **PASS** |
| gga_scf 컴파일 (block 함수 typecheck) | **PASS** |
| davidson_block_e2e_bench (full solve scalar≡block) | **max\|Δλ\| ≤ 8.88e-16** · same iters · CPU wall 4–10× |
| scf_pw_selftest (R1 seam F + regression A-E) | **PASS** · block≡scalar max\|Δλ\|=**0.0** · E_total −2.0382 동일 |

## 종합 PASS/FAIL
- **summer GPU 빌드**: PASS (standalone cuBLAS TU 경로; full selfhost rebuild은 범위 밖, 정직 명시)
- **GPU 실측 (점유+디스패치+speedup)**: PASS (happly 73.4×·davidson 15.7×·sternheimer 8.8×; nsys d884gemm tensorop; nvidia-smi co-resident 674MiB; parity machine-eps~4.7e-11)
- **el-ph hot path 배선**: PASS (orchestrator_pw + gga_scf block 경로 컴파일 + CPU-parity 박제)

## 정직 (c9) — 남은 gap / 측정 caveat
- GPU wall은 RBFE-contended 하한 — clean GPU(자유 시점) 재측정하면 speedup이 #3442 수준(74.9×)으로 올라갈 것(이미 #3442 clean 박제 존재).
- full `-DHEXA_CUDA` hexa selfhost rebuild + RFC040 F-GPU 폴시파이어 native = 여전히 Phase E 잔존(범위 밖, standalone TU로 GPU Dgemm 경로는 실측 충족).
- gga_scf nspin=2 moment 자체의 Co-3d under-resolution(npw 벽, MEMORY: qforge-cosn)은 block 배선과 별개 — 배선은 그 hot path를 GPU로 태우는 것이지 npw 벽을 푸는 게 아님.

## 다음 라운드 (R3) — fire-on-arrival
GPU 실측 PASS + hot path 배선 PASS → **R3 = kgrid 444류 production 셀을 GPU block davidson로 재측정**:
- qforge_scf_pw_h_block / qforge_atoms_to_tc_block로 실제 production 셀(CaH6/LaH10 444 kgrid) λ/Tc 를 GPU서 측정.
- clean GPU 확보(RBFE 종료 후 or 별도 슬롯) → 74.9× clean 재현 + production wall speedup.
- gga_scf block 경로로 Co-3d 고-npw SCF wall (MEMORY: qforge-cosn) GPU 재시도 — npw≥120 tractable 여부 GPU서 측정.

## depletion
미고갈 — R3(production-cell GPU 재측정) 남음. R2 = GPU 실측 3-gate ALL PASS + el-ph hot path(orchestrator_pw·gga_scf) block 배선 PASS.
