# QFORGE GPU block-davidson — R1 verdict (production wiring) 2026-06-19

Lane "gpu-block-davidson" R1. 임무는 redirect 후 **재구현이 아니라 PR #3442 absorb + 검증 + production 배선**.

## c1 — 감사 오인 정정 (root-cause)
GPU 감사(state/qforge-gpu-audit)의 🧱 "함수 정의 0개·dead·74.9× 미검증" 판정은
**`~/.hx/src`가 main(#3636)을 가리켜** 미머지 PR #3442의 함수가 거기 없던 것이 원인.
실제로는 PR #3442 (branch `qforge/happly-gpu-perf`, head 5df7aacb)에 정직하게 구현·박제돼 있음:
- `qforge_h_apply_forge_block` (assembler.hexa) — H[n,n]@Ψ[n,m] 단일 GEMM 배치 apply
- `qforge_davidson_block` + `dv_project_block` (davidson.hexa) — block 형 davidson (scalar 와 공유 body `dv_run`)
- `qforge_sternheimer_block` (sternheimer.hexa)
- `.cu` parity twin: nvptx_happly_block_host.cu (+davidson/sternheimer)
- 실측표 (domains/QFORGE-PERF.bench.md §8): RTX5070 sm_120, n=2048 m=64 → 4.144ms = **74.9× vs CPU 310.463ms**, parity max_rel ≤ 4.7e-11.

74.9× 는 미검증 주석이 아니라 **실측**. 감사의 "코드존재 미성립"은 install-root 불일치 artifact.

## ⚠ PR #3442 머지 불가 (정직)
PR #3442 는 main 대비 **189 commits behind** + 14524줄 삭제 (구 `.tape` 인프라 — main 이 이미
ARCHITECTURE.json 으로 마이그레이션함). 그대로 머지하면 그 마이그레이션을 **되돌림**. → 머지 금지.
대신 qforge 소스 3파일이 main 의 merge-base 이후 **불변**(검증함)이라 branch 버전을 main 위에 그대로 cherry 가능.

## R1 작업 — production 배선 (감사 발견 8·9 = 진짜 gap)
PR #3442 의 함수는 있으나 **production davidson/SCF 가 block 경로 미연결** (감사 발견 8).
이 R1 이 그 배선을 메움:
1. `qforge_scf_block` (scf.hexa) — qforge_scf 와 동일 SCF 수학, 내부 diagonalize 를 `qforge_davidson_block` 로.
   `H_block_of_rho` 클로저 추가 인자. qforge_scf 는 byte-identical 유지 (qforge_scf_smeared 관례, d4 no-reg).
2. `qforge_pw_h_apply_block` + `qforge_h_block_of_rho_global` + `qforge_scf_pw_h_block` (scf_pw.hexa) —
   공유 PW_HAM 슬롯 위 batched apply, in-loop V_H[ρ] block SCF. SCF/DFPT 가 호출하는 production seam.

## 검증 (c2 · mini, no-GPU build = FP64 CPU GEMM 폴백)
| gate | 결과 |
|---|---|
| happly_block_bench (block ≡ m 스칼라 matvec) | **ALL PARITY PASS** · maxAbsDiff ≤ 3.2e-14 |
| davidson_block_e2e_bench (full solve scalar vs block) | **max\|Δλ\| ≤ 8.9e-16** (machine-eps) · same iters(7) · conv true · CPU wallΔ 4.6–12.6× |
| scf_pw_selftest (F) production 배선 parity | **PASS** · qforge_scf_pw_h_block ≡ qforge_scf_pw_h · max\|Δλ\|=**0.0** · E_total 동일(−2.0382) · same iters |
| davidson_selftest (scalar regression) | **PASS** · dv_run refactor 가 scalar davidson 깨지 않음 |
| scf_pw_selftest (D)(E) scalar regression | **PASS** · qforge_scf_pw / _h 불변 |

CPU 정합 PASS (감사가 요구한 |Δ|<1e-10 재현 — 실제 0.0). 컴파일 OK (dead 아님).

## R1 PASS/FAIL
- **PR #3442 검증 재현**: PASS (74.9× 실측표 + parity 박제 확인 · CPU parity 재현)
- **CPU 정합 (block == scalar)**: PASS (max|Δλ| 0.0~8.9e-16, 1e-10 게이트 통과)
- **production 배선**: PASS (qforge_scf_pw_h_block 구현 + parity selftest PASS)
- **GPU 실측 (summer RTX5070 -DHEXA_CUDA)**: **미실행** (R2) — no-GPU mini build 이라 CPU GEMM 폴백.
  74.9× 는 PR #3442 가 RTX5070 sm_120 에서 이미 실측 박제(재측정 가능·미검증 취급 아님).

## 정직 (c9) — 남은 gap
- mini -DHEXA_CUDA 미빌드 → R1 검증은 CPU GEMM 폴백 parity (배선 정합성 검증엔 충분, GPU 점유 캡처 아님).
- summer RTX5070 -DHEXA_CUDA 빌드 + nvidia-smi 점유 + wall 재측정 = **R2**.
- 74.9× 자체는 정직한 실측 (PR #3442, RTX5070) — R1 은 그 위에 배선을 얹어 SCF/DFPT 가 탈 수 있게 함.

## 다음 라운드 (R2)
1. summer RTX5070 서 hexa -DHEXA_CUDA 빌드 → davidson_block_e2e_bench / scf_pw block 경로 GPU 실측 (nvidia-smi + wall) → 74.9× 재현.
2. orchestrator_pw (qforge_pw_occ_states, el-ph hot path) + gga_scf 도 block 배선.
3. kgrid 444 류 production 셀을 qforge_scf_pw_h_block 로 재측정 (GPU davidson wall).

## depletion
미고갈 — R2 (GPU 실측 + el-ph/orchestrator 배선) 남음. R1 = CPU-parity 배선 PASS.
