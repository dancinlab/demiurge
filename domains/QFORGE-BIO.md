🧬 **QFORGE-BIO** — *알케미컬 결합 자유에너지를 직접 굽는 분자엔진* (native FEP/MD)

@title: 🧬 QFORGE-BIO — 결합엔진(알케미컬 FEP/MD)
@goal: QFORGE universal multi-scale 축의 **bio front-end** — 외부 openfe/openmm/openmmtools 를 hexa-native alchemical FEP/MD 로 완전 대체. 부모 = QFORGE (공통코어: 평면파 DFT + 선형응답 DFPT + stdlib/autograd·flame ML). 6스케일(atoms·materials·bio·chem·chip·system) 중 **bio**. verify-ref = 실험 ΔΔG(redox-matched). materials(el-ph)가 QE 를 걷어낸 것과 동형으로 bio 가 OpenMM 스택을 걷어낸다.

## 정체성 (d10)
- icon: 🧬
- NAME: QFORGE-BIO
- alias: 결합엔진 — "리간드가 단백질에 얼마나 세게 붙는지를 외부 라이브러리 없이 직접 계산하는 엔진"
- parent: QFORGE (`stdlib/qforge/`) · sibling scale: materials(el-ph, ✅DONE) · atoms · chem · chip · system
- canonical home (d3): `stdlib/chem/md/` (MD 코어) + 신설 `stdlib/chem/fep/` (알케미컬 레이어) + `stdlib/chem/md/estimator/` (MBAR/BAR)

## why (실증된 외부의존 3대 실패)
SENOLYX RBFE 캠페인(2026-06-06~07)이 외부 스택 3대 실패를 실증:
1. **FF 부정확** — openff-2.1.0 이 거대고리 퀴논(안사마이신) 형태에너지를 2.2× 과대전개 · RMSE 75.5 kcal/mol (SENOLYX R11c, 용매-강건 CONFIRMED)
2. **openfe conda-solve 무한대기** — RBFE env 설치 막힘 → ABFE 차분으로 피벗 강요
3. **CUDA PTX 불일치** — vast 3-pod 전부 CUDA_ERROR_UNSUPPORTED_PTX_VERSION(222) 소멸
→ verify 앵커(외부, hexa-native 아님): SENOLYX ABFE ΔG=−16.64±0.49 kcal/mol (R10b, OpenMM 20-window 수렴 PASS).

## 재사용 가능 QFORGE/stdlib 코어 인벤토리 (d19 atlas-first)
✅ 검증·구현됨 (g5 통과 테스트 보유):
- `stdlib/chem/md/lennard_jones.hexa` — LJ 6-12 pair force/energy + KE/PE 누적 (md_test T1-T3 PASS)
- `stdlib/chem/md/verlet.hexa` — Velocity-Verlet symplectic integrator (T4 energy-drift<1% PASS)
- `stdlib/chem/md/ewald.hexa` — Ewald real+recip+self 정전 (tolerance-driven α/kmax 자동, 입방박스)
- `stdlib/chem/md/bonded.hexa` — harmonic bond/angle + Fourier dihedral
- `stdlib/chem/md/pbc.hexa` — 최소-이미지 (입방+직교)
- `stdlib/signal/core_fft.hexa` — `fft3`/`ifft3`/`fft3_real` (3D FFT) ⇒ **PME reciprocal 직결**
- `stdlib/autograd.hexa` — tape 역모드 autograd (ag_add/mul/pow/sin/cos/exp/backward/grad) ⇒ **힘 = −∂E/∂x**
- `stdlib/qforge/screening_pwfft.hexa` — pow2-padded real-space FFT-Poisson (PME 설계 참조)
- `stdlib/qforge/nqe_pimd.hexa` — ring-polymer 경로적분 MD (양자 핵효과 — 정확 HO 검증식 보유)
- `stdlib/qforge/nvptx_*_kernel.hexa` — NVPTX GPU 커널 (summer RTX5070 sm_120 검증) ⇒ MD GPU 가속 참조

🟡 / ⚪ GAP (없음 — 신설 대상):
- ✅R3 soft-core λ-coupling (Beutler) — `stdlib/chem/fep/softcore.hexa` (g5 PASS) · 🟡 λ-schedule · 하이브리드 토폴로지
- PME (Ewald 의 FFT 가속판 — 현 ewald 는 O(N²) 직접합)
- Langevin/Nosé-Hoover thermostat (현 verlet 은 NVE 진공)
- HREX (Hamiltonian replica exchange) swap
- MBAR/BAR estimator (Shirts-Chodera)
- neighbor list / cell list · TIP3P 물 · solvation box builder
- QM-derived FF (GFN2/DFT 전하·토션 refit · 거대고리 인지)

## 마일스톤
- [x] R1: native FEP/MD 최소경로 설계 + lit-grounding + 첫 verify-able brick 명시 (이 라운드, 설계만)
- [x] R2-brick: LJ+Coulomb 힘 = autograd 역모드 vs 해석적/finite-diff < 1e-6 (g5) — 첫 native brick ✅ PASS 5/5 (a=1.78e-15·b=2.46e-9; PR hexa-lang#3076)
- [x] R3-brick: soft-core λ-energy 닫힌형 (Beutler 1994) — endpoint 비특이성 + dU/dλ autograd g5 ✅ PASS 5/5 (λ=1 회복 |ΔU|=0·dU/dλ ag==an 3.55e-15; PR hexa-lang#3078←#3079)
- [ ] R2: MBAR 해석적 2-state(=BAR) 검증 — 가우시안 작업분포 닫힌형 ΔG g5
- [ ] R3: PME = ewald recip 의 fft3 가속 — 직접합 vs FFT < 1e-8 parity g5
- [ ] R3: Langevin integrator — 평형 ⟨KE⟩ = (3/2)NkT equipartition g5
- [ ] R4: HREX swap detailed-balance + end-to-end ABFE re-derive SENOLYX 앵커(−16.64) parity
- [ ] R5: QM-derived FF (GFN2 전하 refit) — R11 거대고리 2.2× 과대전개 해소 측정

## verify-ref / falsifier
- 1차 앵커(외부): SENOLYX ABFE ΔG=−16.64±0.49 kcal/mol (OpenMM, R10b) — hexa-native 결과가 ±2 안에 들면 엔진 parity
- 거대고리 FF falsifier: native QM-FF 가 R11 conformer ensemble 에서 RMSE<75.5 (외부 openff 베이스라인 깸)

## 비용
0-POD only (mini local + summer-free RTX 5070). R1=$0 설계. R2-3 brick = local g5, $0.

## 정직 스코프 (d6/@L5)
- 외부 OpenMM 결과(−16.64)는 **verify 앵커**일 뿐 hexa-native 아님 — 명시 유지
- 큰 프로젝트 — R1은 설계+첫 brick까지. tier: ✅구현(md코어) · 🟡설계(FEP레이어) · ⚪개념(QM-FF)
