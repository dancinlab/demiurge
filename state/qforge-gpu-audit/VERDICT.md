# QFORGE GPU 전환 감사 — 판정: 🧱 미작동 (production GPU 경로 없음) 2026-06-19

## 핵심 (c2 캡처 기반)
"QFORGE가 davidson/H-apply/DFPT를 GPU로 돌린다"는 주장은 **코드존재 기준으로도 미성립** + 실행 100% CPU 폴백.

## 발견 (캡처·파일:라인)
1. block-GEMM H-apply(qforge_h_apply_forge_block)·block davidson(qforge_davidson_block) **함수 정의 0개** —
   호출은 벤치 3개뿐, 셋 다 **컴파일 실패**("undeclared identifier 'qforge_h_apply_forge_block'" davidson_block_e2e_bench.hexa:78). dead bench.
2. 실재 경로=single-vector qforge_h_apply_forge(assembler.hexa:299)→forge_dispatch_matmul→runtime hexa_farr_matmul.
3. 진짜 GPU 백엔드는 #ifdef HEXA_CUDA/HEXA_METAL 가드 안에만(runtime.c:8272 cuBLAS Dgemm, M*K|K*N>8192시). 
4. mini 바이너리: Metal/CUDA/MPS 미링크, -DHEXA_CUDA/-DHEXA_METAL 빌드플래그 없음. _hexa_cuda_available=0 스텁.
   → mini forge 경로 100% CPU ikj GEMM 폴백.
5. 수치정합(c2 실측 happly_gpu_bench): forge==scalar |Δ|~1e-14(FP64 동급)·단 양쪽 CPU. "1.30×"=ikj vs 나이브 matvec(CPU-vs-CPU), GPU 아님.
6. ★74.9×=미검증 주석값(davidson_block_e2e_bench.hexa:6 주석 유일출처)·측정 verdict/로그 없음·언급된 .cu twin 파일 부재.
7. 진짜 측정 GPU perf(H100 1.08×, F-GPU-ROUTEA #3094)는 **별개 flame/ML TF32 GEMM** — qforge FP64 davidson 아님(정직 attributed).
8. production wired: NO. production davidson(davidson.hexa:83) 내부 dv_project가 W.push(H_apply(basis[j])) 한벡터씩 스칼라.
   SCF/GGA-SCF/orchestrator 전부 스칼라 closure·_block 호출 0건.
9. kgrid 444 CPU 이유: GPU davidson 부재(block 미구현)+mini GPU 백엔드 미컴파일(Apple FP64=MPS 미지원).

## 막는 것(🧱 substrate)
(1)block-GEMM/block-davidson 함수 자체 미구현(벤치만·dead) (2)mini GPU 백엔드 미컴파일(-DHEXA_CUDA=H100/A100 pod 전용·Metal FP64 MPS미지원) (3)single-vector forge조차 production davidson 미연결.

## 정직 결론(c9)
GPU 전환은 **미구현·미연결·미검증**. CUDA pod서 -DHEXA_CUDA 빌드시 single-vector forge는 cuBLAS 가능(M*K>8192 게이트)이나 batched block은 함수 부재라 그조차 불가. 74.9×는 근거없는 주석 — c9 정직성 이슈(코드 내 미검증 주장).

## ⟲ 정정 (c9 후속 정리 2026-06-19 — 발견6의 근본원인 재추적)
발견6("74.9× 미검증 주석 + .cu twin 부재 + dead bench")의 **귀속이 틀렸다**. 근본원인 = repo 코드결함이 아니라 **stale install 위생 문제**:
- 세 block 벤치(`davidson_block_e2e_bench`·`happly_block_bench`·`sternheimer_block_e2e_bench`)는 **main 에 부재**. git history상 미머지 WIP 브랜치 `qforge/happly-gpu-perf`(OPEN PR #3442, commit ac70097ce)에만 존재.
- `~/.hx/src` 인스톨은 **main(#3636 8f020716) 체크아웃**인데, 그 워킹트리에 위 3벤치가 `??` **untracked stray**로 남아있었음(이전 WIP 브랜치 체크아웃의 잔재가 main 리싱크때 안 지워짐). 함수정의(`davidson.hexa`/`sternheimer.hexa`/`assembler.hexa`)·`.cu` twin·provenance 문서는 안 복사돼서 컴파일실패 → 감사가 "dead bench"로 본 것.
- **브랜치 #3442에는 74.9×가 정직하게 측정·박제돼 있음**: `nvptx_happly_block_host.cu`(.cu twin 존재) + `domains/QFORGE-PERF.bench.md:270` 전체 측정표(2048×64 → 4.144ms = 74.9× vs CPU 310.463ms, parity max_rel 4.7e-11, RTX 5070 sm_120 VERBATIM) + `QFORGE-PERF.md:72` 마일스톤. **c9 위반 아님** — 만지면 안 됨.
- **조치(c9 정직)**: main 체크아웃 인스톨에서 stray 3벤치만 `rm`(untracked라 커밋손실 0). 잔여 dangling block-fn 참조 0건 확인. 정직한 `happly_gpu_bench.hexa`(별개)는 untouched. main 으로의 PR 불필요(main엔 손댈 게 없음), #3442 으로의 "수정" 금지(측정 정직함).
- 결론: 감사의 "코드 내 미검증 주장" 판정은 **stale-install 아티팩트를 repo 결함으로 오귀속**한 것. 실제 시정 = 인스톨 위생(stray 제거)뿐. (단 발견 1·8·9의 "production davidson 미연결·mini GPU 백엔드 미컴파일" = main 기준 여전히 유효 — GPU 기능구현은 별건 cost-gated.)
