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
