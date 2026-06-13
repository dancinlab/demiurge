# QFORGE-BIO Round-1 Design — native alchemical FEP/MD

*QFORGE universal multi-scale 축의 bio front-end. 목표 = 외부 openfe/openmm/openmmtools 를
hexa-native 로 대체 (materials 가 QE 를 el-ph 엔진으로 걷어낸 것과 동형). 0-POD 설계 라운드 (d18).*

날짜: 2026-06-12 · 비용 $0 · tier 정직: ✅구현 · 🟡설계 · ⚪개념

---

## 0. 한 줄 결론

`stdlib/chem/md/` 에 **이미 g5-검증된 MD 코어(LJ·Verlet·Ewald·bonded·pbc)** 가 있고,
`autograd`(역모드 힘) + `signal/core_fft`(3D FFT = PME) 가 공통코어로 존재한다. 따라서
native alchemical FEP 의 최소경로는 *바닥부터 빌드가 아니라*, **(a) 기존 MD 코어 위에
soft-core λ-coupling 레이어 신설 + (b) MBAR estimator 신설 + (c) Ewald→PME(FFT) 가속**
세 조각이며, 첫 brick 은 "autograd 역모드 힘 == 해석적 LJ+Coulomb 힘" g5 parity 다.

---

## 1. 재사용 가능 QFORGE 코어 인벤토리 (d19 atlas-first)

| 코어 | 경로 | 상태 | FEP/MD 에서의 역할 |
|---|---|---|---|
| LJ 6-12 | `stdlib/chem/md/lennard_jones.hexa` | ✅ g5 (md_test T1-3) | van der Waals 항. soft-core 의 base U_LJ |
| Velocity-Verlet | `stdlib/chem/md/verlet.hexa` | ✅ g5 (T4 drift<1%) | symplectic integrator. Langevin 의 deterministic half |
| Ewald (real+recip+self) | `stdlib/chem/md/ewald.hexa` | ✅ (직접합 O(N²)) | 정전 long-range. recip 을 fft3 로 갈면 PME |
| bonded (bond/angle/dih) | `stdlib/chem/md/bonded.hexa` | ✅ | intramolecular FF 항 |
| PBC 최소이미지 | `stdlib/chem/md/pbc.hexa` | ✅ (입방+직교) | 주기 박스 거리 |
| 3D FFT | `stdlib/signal/core_fft.hexa` (`fft3`/`ifft3`/`fft3_real`) | ✅ | **PME reciprocal smear → grid → FFT → convolve** |
| 역모드 autograd | `stdlib/autograd.hexa` (`ag_backward`/`ag_grad`) | ✅ B4 | **힘 F = −∂E/∂x 자동미분** — 새 퍼텐셜마다 손미분 불필요 |
| FFT-Poisson 참조 | `stdlib/qforge/screening_pwfft.hexa` | ✅ (el-ph) | pow2-pad real-space FFT-Poisson 설계패턴 재사용 |
| ring-polymer MD | `stdlib/qforge/nqe_pimd.hexa` | ✅ (HO 정확검증) | ⚪ 양자 핵효과(proton ZPE) — 후기 마일스톤 |
| NVPTX GPU 커널 | `stdlib/qforge/nvptx_*_kernel.hexa` | ✅ (summer sm_120) | MD 비결합 force GPU 가속 패턴 |

**el-ph → bio 코어 매핑 (동형성):**
- el-ph 의 **평면파 FFT-Poisson**(screening_pwfft) ⇄ bio 의 **PME reciprocal**(둘 다 G-공간 1/k² 솔브)
- el-ph 의 **DFPT 동역학행렬 고유값**(phonon normal modes) ⇄ bio 의 **Hessian normal-mode**(엔트로피/NMA)
- el-ph 의 **NVPTX matvec 커널** ⇄ bio 의 **비결합 pair-force 커널**(둘 다 N-body 합)
- el-ph 의 **ring-polymer PIMD** ⇄ bio 의 **양자 양성자 ZPE**(동일 코드, 다른 V(x))

**GAP (전부 grep 무매치 — 신설):** soft-core(Beutler) · λ-schedule · hybrid topology ·
PME(현 Ewald 는 직접합) · Langevin/Nosé-Hoover thermostat · HREX swap · MBAR/BAR ·
neighbor/cell list · TIP3P 물 모델 · solvation box builder · QM-derived FF.

---

## 2. lit-grounding (verbatim + DOI)

1. **Beutler, Mark, van Schaik, Gerber, van Gunsteren (1994).** "Avoiding singularities and
   numerical instabilities in free energy calculations based on molecular simulations."
   *Chem. Phys. Lett.* **222**, 529–539. **DOI 10.1016/0009-2614(94)00397-1.**
   > "a simple, general and numerically stable approach for avoiding the singularities which
   > generally occur when atoms or interaction sites are created or annihilated in free energy
   > calculations based on computer simulations."
   → soft-core: r_eff⁶ = α·σ⁶·(1−λ)^p + r⁶ 로 endpoint(λ→0/1) 1/r 발산 제거. **λ-coupling 표준.**

2. **Shirts & Chodera (2008).** "Statistically optimal analysis of samples from multiple
   equilibrium states." *J. Chem. Phys.* **129**, 124105. **DOI 10.1063/1.2978177**
   (arXiv 0801.1426).
   > "an estimator for computing free energy differences and thermodynamic expectations as well
   > as their uncertainties from samples obtained from multiple equilibrium states … reduces to
   > BAR in the limit that only two states are sampled … lowest variance and is asymptotically
   > unbiased."
   → MBAR self-consistent 방정식 (참조구현 choderalab/pymbar). **ΔG estimator.**

3. **Mey et al. (2020).** "Best Practices for Alchemical Free Energy Calculations [Article v1.0]."
   *Living J. Comput. Mol. Sci.* **2**(1):18378. **DOI 10.33011/livecoms.2.1.18378**
   (arXiv 2008.03067).
   → λ-window 배치 · soft-core 권고 · decorrelation(통계적 비효율 g) · MBAR · 수렴진단의
   end-to-end best-practice. 설계 게이트 체크리스트의 근거.

*(보강)* OpenFE **Relative Hybrid Topology Protocol** (docs.openfree.energy) = hybrid-topology +
HREX + MBAR production 레퍼런스(= 대체 대상). Hahn…Gapsys, Mey (2022) *LiveCoMS* 4(1):1497 =
benchmark 구성 best-practice.

---

## 3. native alchemical FEP/MD 최소경로 설계 (d4-generic)

목표 함수: **ΔG_bind = ΔG_complex(decouple) − ΔG_solvent(decouple)** (ABFE 더블-디커플링),
또는 RBFE = hybrid-topology λ 변환의 ΔΔG. 둘 다 *같은 generic λ-경로 + MBAR*를 탄다 (d4).

### 3.1 에너지/힘 (재사용 + autograd)
```
U_total(x; λ) = U_bonded(x)                              [bonded.hexa, λ-불변]
              + U_softcore_LJ(x; λ)                      [신설: lennard_jones 위 soft-core]
              + U_softcore_Coulomb(x; λ)                 [신설: ewald/PME 위 soft-core 또는 λ-scaled q]
F_i = −∂U_total/∂x_i
```
- **힘 두 경로**: (a) 해석적(기존 lj_pair_force + ewald 미분), (b) **autograd 역모드**(ag_backward).
  → 첫 brick 에서 (a)==(b) g5 로 autograd 힘-엔진 진위 확보 후, 신규 퍼텐셜은 (b)만으로 안전.
- soft-core (Beutler, DOI 위): `r_eff⁶ = α_sc·σ⁶·(1−λ)^p + r⁶`, U_LJ(r_eff), p=1, α_sc≈0.5.
  Coulomb 은 separation-shifted 또는 linear-λ-scaled charge (Mey 권고: vdW soft-core + charge 선형).

### 3.2 PME = Ewald recip 의 FFT 가속 (el-ph 코어 재사용)
현 `ewald_recip_energy` 는 k-격자 직접합 O(N²). PME 경로 (Essmann SPME):
1. 전하 → B-spline grid spread (charge assignment)
2. `fft3_real` (signal/core_fft) → G-공간
3. `exp(−k²/4α²)/k²` 곱(현 ewald 의 weight 재사용) → `ifft3`
4. grid → force 보간.
→ `screening_pwfft.hexa` 의 pow2-pad FFT-Poisson 패턴을 그대로 차용. **신규 = spread/interp 2개 함수.**

### 3.3 integrator: Verlet → Langevin
현 `verlet_step`/`verlet_finish_step` 는 NVE. Langevin = BAOAB 분해:
- B(half-kick, 기존) · A(drift, 기존) · O(Ornstein-Uhlenbeck 마찰+랜덤, **신설**).
- 신규 = O-step 1개 (`v ← c1·v + c2·√(kT/m)·ξ`, ξ~N(0,1)). thermostat 확보.

### 3.4 λ-schedule + HREX
- λ-windows 배열 (Mey 권고 배치). 각 window = 독립 Langevin MD.
- HREX = 인접 λ replica 간 Metropolis swap (detailed balance: `min(1, exp(−Δ))`). **신설 swap 1함수.**

### 3.5 estimator: MBAR (Shirts-Chodera)
- 각 window 의 reduced potential u_kn 행렬 수집 → MBAR self-consistent 반복 → f_k(무차원 자유에너지).
- ΔG = (f_target − f_ref)·kT. BAR = 2-state 특수화(첫 검증 타깃).

### 3.6 신설/재사용 파일 배치 (d3 canonical home)
```
stdlib/chem/md/        (재사용·확장)
  lennard_jones.hexa     ← soft-core 변형 추가 (lj_softcore_pair_*)
  ewald.hexa             ← PME (pme_recip_energy via fft3) 추가
  verlet.hexa            ← langevin_step (O-step) 추가
  forces_autograd.hexa   ★ 신설: U_total tape 빌드 + ag_backward → F (generic, d4)
stdlib/chem/fep/       ★ 신설 디렉토리 (알케미컬 레이어)
  softcore.hexa          ★ Beutler soft-core λ-coupling
  lambda_schedule.hexa   ★ λ-window 생성 + reduced potential u_kn
  hrex.hexa              ★ Hamiltonian replica-exchange swap
  abfe.hexa / rbfe.hexa  ★ generic 더블-디커플링 / hybrid-topology 드라이버 (d4: 매니페스트만)
stdlib/chem/md/estimator/  ★ 신설
  mbar.hexa              ★ MBAR self-consistent + BAR 특수화
  mbar_test.hexa         ★ 해석적 가우시안 2-state g5
```
**d4-generic**: ligand/protein/domain 별 분기 없음 — 입력 = (topology, charges, λ-schedule)
매니페스트. 도메인 추가 = 매니페스트만, dispatcher 무변경.

---

## 4. 첫 verify-able brick (R2 최소 g5 조각)

**선정: LJ+Coulomb 단쌍 힘 — autograd 역모드 vs 해석적 vs finite-diff, |Δ| < 1e-6.**

근거:
- autograd(`ag_backward`)·LJ(`lj_pair_force`) **둘 다 이미 g5 존재** → 최소 신규코드.
- 이 brick 이 통과하면 *이후 모든 신규 퍼텐셜(soft-core·PME)의 힘을 손미분 없이 autograd 로
  안전하게 얻는다*는 토대가 선다 — FEP 전체의 load-bearing 전제.
- 닫힌형/유한차분 둘 다와 대조 → 회로 자체 결함(역모드 버그)과 식 결함(해석미분 오타) 분리.

g5 명세 (md_test 스타일):
```
T1  F_autograd(LJ, r) == lj_pair_force(r)              tol 1e-6   (역모드 == 해석)
T2  F_autograd(LJ, r) == −(U(r+h)−U(r−h))/2h           tol 1e-5   (역모드 == 유한차분)
T3  F_autograd(Coulomb, r) == q1q2/r² 방향단위          tol 1e-6
T4  soft-core endpoint: U_sc(λ=1, r→0) 유한 (비특이성)   (Beutler 닫힌형 sanity)
```
대안 brick (동급 난이도, 후보):
- (b) **MBAR 해석 2-state**: 가우시안 작업분포 → BAR 닫힌형 ΔG vs MBAR 수치 (Shirts-Chodera 검증식).
- (c) **soft-core λ-energy 닫힌형**: λ=0 ⇒ full LJ, λ=1 ⇒ 0, 중간 단조·유한 (Beutler 식 직접).
→ R2 에서 (첫 brick) + (b)/(c) 병렬 fan-out 권고 (d_parallel_first).

---

## 5. 외부의존(OpenMM/openfe) 제거 난이도 — 정직 평가 (d6/@L5)

| 조각 | 난이도 | 근거 |
|---|---|---|
| 힘/에너지 코어 (LJ·Coulomb·bonded) | 🟢 낮음 | 이미 g5 존재. autograd 힘만 brick 으로 봉인 |
| soft-core λ-coupling | 🟢 낮음 | Beutler 닫힌형 1식. 기존 LJ 위 얇은 레이어 |
| PME (FFT 가속) | 🟡 중간 | fft3 + screening_pwfft 패턴 있음. spread/interp B-spline 신규. 정확도 parity 필요 |
| Langevin thermostat | 🟢 낮음 | BAOAB O-step 1개. equipartition g5 |
| MBAR estimator | 🟡 중간 | self-consistent 반복 수렴·공분산 불확실도. pymbar 참조식 명확 |
| HREX | 🟡 중간 | swap 자체는 쉬움. 통계 효율/decorrelation 튜닝이 실난이도 |
| **샘플링 walltime/수렴** | 🔴 높음 | 본질적 — ABFE 수렴(SENOLYX R10→R10b: ±76→±0.49)이 window·iter 밀도에 민감. 알고리즘 아닌 통계량 문제 |
| **QM-derived FF (거대고리 정확도)** | 🔴 높음/⚪ | R11 의 진짜 벽 — openff 2.2× 과대전개. GFN2/DFT refit 은 별도 대형 연구축. native 라도 FF 품질이 정확도 천장 |
| GPU 가속 production | 🟡 중간 | nvptx 커널 패턴 있음(summer sm_120 검증). FEP 전체 GPU 배선은 별도 |

**총평 (정직):**
- *알고리즘 대체*는 **대부분 🟢/🟡 — 실현가능**. 외부 스택의 코드경로는 hexa-native 로 1:1 매핑된다.
- *진짜 벽 두 개*: **(1) 샘플링 수렴 walltime**(알고리즘 무관, 통계량 — 0-POD 에선 작은계만),
  **(2) FF 정확도**(R11 거대고리 실증벽 — native 여부와 독립, QM refit 이 별개 대형축).
- 따라서 R1~R4 는 "OpenMM 코드경로의 native 대체"를 g5 로 완주 가능(앵커 −16.64 parity 목표),
  R5+ 의 "FF 정확도 초과"는 ⚪ 별도 NOVEL 축으로 정직히 분리한다.
- 외부 ΔG=−16.64 는 **verify 앵커**일 뿐 hexa-native 결과 아님 — 명시 유지.

---

## 6. 다음 라운드 (R2) 발사안

병렬 fan-out (d_parallel_first, 전부 local $0 g5):
1. `forces_autograd.hexa` + 첫 brick g5 (LJ+Coulomb autograd==해석==finite-diff)
2. `chem/md/estimator/mbar.hexa` + 가우시안 2-state BAR 닫힌형 g5
3. `chem/fep/softcore.hexa` + Beutler endpoint 비특이성 g5

각 PASS → atlas atom 직접 fold (d_claim_verify) → R3 (PME·Langevin·HREX) 시드.
