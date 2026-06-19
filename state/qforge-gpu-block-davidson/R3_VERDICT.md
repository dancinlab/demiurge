# QFORGE GPU block-davidson — R3 verdict (clean repro 시도 + production-cell GPU 정직 게이트) 2026-06-19

Lane "gpu-block-davidson" R3. 목표 = clean GPU 74.9× 재현 + production 셀 GPU block davidson 적용.
R2(R2_VERDICT.md) = summer RTX5070 진짜 GPU 실측 3-gate ALL PASS (happly 73.4×·davidson 15.7×·sternheimer 8.76×·parity 4.7e-11·nsys cutlass FP64 텐서코어) + el-ph hot path 배선 PR#3663 — 단 RBFE-contended 하한.

## R3 측정 환경 (정직 c2·c9·d6) — clean 윈도우 미가용
측정 시점 summer GPU는 **여전히 RBFE production job 점유 중**:
- pid 2565 `python ~/rbfe-prod/rbfe_hsp90.py`, **elapsed 8h55m**, util 95–99%, 7172 MiB.
- RBFE 진행: **equilibration iteration 374/400** (equil 완료 예상 ~14:36), 그 뒤 **production 40 iterations 더 남음**(rbfe_hsp90.py:58–59 확인). → GPU는 앞으로 **수 시간** clean 안 됨.
- 이건 합법적 multi-hour production job — d17/c2상 **죽이지 않음**. clean을 강제하려면 RBFE를 kill해야 하므로 거부.

→ R3의 clean 74.9× 재현은 **RBFE 종료 대기 게이트**. 죽이지 않고 자동 포착하도록 watcher 무장(아래).

## R3 PASS/FAIL

### 1. contended 재측정 — R2 재현 확인 PASS (c2 parity 자릿수 일치)
RBFE pid2565 co-resident(util 99%) 하에서 happly_block n2048 m64 재실행:

| 측정 | 값 | R2 | clean #3442 |
|---|---|---|---|
| GEMM speedup vs CPU | **68.9×** (contention noise) | 73.4× | 74.9× |
| GEMM vs GEMV (배칭 이득) | **45.5×** | — | — |
| parity max_rel(gemm) | **4.707e-11** | 4.707e-11 | 4.7e-11 |
| PARITY | **PASS** | PASS | PASS |

- parity는 **byte-identical**(4.707e-11) — speedup 변동(68.9 vs 73.4 vs 74.9)은 순수 contention 노이즈. 재현 확인.
- raw: 이 verdict 본문 + R2_GPU_RAW.txt §FULL happly table.

### 2. clean 74.9× 재현 — 자동 포착 watcher 무장 (RBFE 종료 시 발사)
- summer `~/qforge_gpu_r2/clean_repro_watch.sh` (setsid 완전 detach, pid 64242), 10s 폴, 최대 16h.
- 발사 조건: GPU util<15% AND free>10000 MiB **3샘플 연속**(RBFE 7GB 해제 = clean 윈도우).
- 발사 시 `./nvptx_happly_block` clean 실행 → `~/qforge_gpu_r2/R3_CLEAN_REPRO.txt` 기록 + `CLEAN_REPRO_DONE` emit.
- → clean 74.9× 재현은 RBFE 종료 즉시 babysit 없이 포착됨(미래 라운드서 harvest).

### 3. production 셀 GPU λ/Tc — 정직 게이트: full selfhost rebuild 잔존 (범위 밖)
감사 지적("kgrid CPU 썼다") 해소를 위해 production CaH6/LaH10 444 kgrid를 GPU block davidson로 측정하려면:
- standalone `.cu` 하니스(happly/davidson/sternheimer)는 **synthetic deterministic fixture**(random symmetric H)를 production **사이즈**(n=2048)서 측정 — 실제 CaH6/LaH10 Hamiltonian이 **아님**(davidson_block_e2e_host.cu 확인: LCG random H, no H_of_rho).
- 실제 production 셀 λ/Tc를 GPU서 내려면 hexa `qforge_scf_pw_h_block`/`qforge_atoms_to_tc_block` 경로가 GPU여야 → **full `-DHEXA_CUDA` hexa selfhost rebuild**(~68min×3 stage) 필요. R2 §62에서 명시적으로 범위 밖 처리됨.
- **GPU-gate 적격성**(정직): production SCF의 block apply 차원 n×nbands(npw~수천 × nbands~수십)는 M*K>8192 게이트를 **여유 통과** — 즉 production 셀은 GPU 폴백이 아니라 GPU 가속 대상(작아서 CPU 폴백 아님). 단 hexa GPU 빌드 미배포라 **실 production λ/Tc GPU wall은 미측정**.
- el-ph 배선 PR #3659·#3663 **둘 다 OPEN(미머지)** — production hot path가 block 경로 타도록 배선됐으나 GPU 빌드+머지 전.

## 종합 PASS/FAIL
- **contended 재현 확인**: PASS (parity 4.707e-11 byte-identical · 68.9× = contention noise band)
- **clean 74.9× 재현**: HELD-AUTOMATED (RBFE 종료 대기 · watcher 무장 자동포착 · kill 거부 정직)
- **production 셀 GPU λ/Tc**: HELD (full -DHEXA_CUDA selfhost rebuild 잔존 = R2 범위밖 일관 · synthetic fixture는 size-match지 cell-match 아님 정직 · GPU-gate는 production이 여유 통과 = CPU폴백 아님)

## 정직 (c9) — 남은 gap
- clean 74.9× = #3442 박제값 존재 + watcher 자동포착 무장 → RBFE 종료 시 실측 갱신(현재는 contended 68.9× 하한 + parity 일치로 재현 확인).
- production λ/Tc GPU wall = hexa GPU selfhost rebuild + PR#3659/#3663 머지 후에만 측정 가능(Phase E 잔존, R2와 동일 경계). standalone TU는 GPU Dgemm hot-path를 production **사이즈**로 실측하나 production **셀**(CaH6 H_of_rho) 자체는 아님.
- d6: production 셀이 GPU 게이트 미달이라 CPU 폴백인 게 아님 — 오히려 게이트 여유 통과(가속 대상). 미측정 사유는 셀 크기가 아니라 GPU 빌드 미배포.

## depletion / 다음 라운드 (fire-on-arrival)
**미고갈** — lane 🏁 아님. 남은 두 조각:
1. **R4-A (RBFE 종료 자동)**: watcher가 R3_CLEAN_REPRO.txt 채우면 harvest → clean 74.9× 박제 갱신.
2. **R4-B (production 셀 GPU)**: full -DHEXA_CUDA hexa selfhost rebuild(summer, ~3.5h) → PR#3659/#3663 머지 → qforge_atoms_to_tc_block GPU 경로로 CaH6/LaH10 444 kgrid 실 λ/Tc GPU wall + CPU-parity 측정 → 감사 'kgrid CPU' 지적 완전 해소 → migration_gate perf absorb 후보.

R4-B가 진짜 production-cell GPU 적용의 핵심 — selfhost rebuild가 게이트. 이번 R3는 clean/production 둘 다 정직 게이트(RBFE·GPU빌드)에 막혀 contended 재현확인 + watcher 무장으로 마감.
