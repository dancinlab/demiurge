# QFORGE-BIO — append-only step log

## 2026-06-12 · R1 설계라운드 (d18) — native alchemical FEP/MD 설계 + lit-grounding + 첫 brick

### 스캔 결과 (기존 머신 전수조사)
- `stdlib/chem/md/` 이미 존재 — LJ·Verlet·Ewald·bonded·pbc 5모듈, md_test 4케이스 g5 PASS (T1-T4)
- `stdlib/signal/core_fft.hexa` — fft3/ifft3/fft3_real 3D FFT 보유 ⇒ PME reciprocal 직결
- `stdlib/autograd.hexa` — tape 역모드 (ag_backward/ag_grad) ⇒ 힘 = −∂E/∂x autodiff
- `stdlib/qforge/` el-ph 엔진 — screening_pwfft(FFT-Poisson) · nqe_pimd(ring-polymer MD) · nvptx 커널(summer GPU 검증)
- GAP 확정 (grep 무매치): soft-core · λ-schedule · HREX · MBAR/BAR · Langevin thermostat · PME · solvation box — 전부 신설 대상
- hexa-bio 본체엔 FEP impl 없음 (worktree 노이즈 제외) — 실제 ABFE/RBFE 는 demiurge SENOLYX 도메인이 외부 OpenMM/openmmtools/openfe 호출로 수행

### lit-grounding (verbatim + DOI)
- Beutler, Mark, van Schaik, Gerber, van Gunsteren (1994). "Avoiding singularities and numerical
  instabilities in free energy calculations based on molecular simulations." Chem. Phys. Lett. 222,
  529–539. DOI 10.1016/0009-2614(94)00397-1 — soft-core (separation-shifted) 정전기/LJ 비특이성 표준.
- Shirts & Chodera (2008). "Statistically optimal analysis of samples from multiple equilibrium
  states." J. Chem. Phys. 129, 124105. DOI 10.1063/1.2978177 (arXiv 0801.1426) — MBAR (BAR 다중상태
  일반화, 최소분산·점근무편). pymbar 참조구현 choderalab/pymbar.
- Mey, Allen, Bruce Macdonald, Chodera, Kuhn, Michel, Mobley, Naden, Prasad, Rizzi, Scheen, Shirts,
  Tresadern, Xu (2020). "Best Practices for Alchemical Free Energy Calculations [Article v1.0]."
  Living J. Comput. Mol. Sci. 2(1):18378. DOI 10.33011/livecoms.2.1.18378 (arXiv 2008.03067) —
  λ-schedule·soft-core·decorrelation·MBAR·수렴진단 best-practice.
- (보강) OpenFE Relative Hybrid Topology Protocol (docs.openfree.energy) — hybrid-topology + HREX +
  MBAR 의 production 레퍼런스 구성 (대체 대상 자체).
- (보강) Hahn, Bayly, ... Gapsys, Mey (2022). LiveCoMS 4(1):1497 — benchmark 구성 best-practice.

### 설계 + 첫 brick → drafts/qforge-bio-round1-design.md 에 본문
- 등록: DOMAINS.tape `@domain QFORGE-BIO := "domains/QFORGE-BIO.md"`
- 첫 verify-able brick (R2): LJ+Coulomb 단쌍 힘을 autograd 역모드로 계산 → 해석적 lj_pair_force / Coulomb 해석미분 및 finite-diff 와 |Δ|<1e-6 g5. (autograd·LJ 둘 다 이미 존재 → 최소 신규코드로 native 힘-엔진 진위 확보)

## 2026-06-12 · R2-brick ✅ SEALED — autograd-force = analytic = finite-diff (g5 PASS 5/5)

### 감사 (R1 인벤토리 확정)
- `stdlib/autograd.hexa` — tape 역모드 (ag_var/const, ag_add/sub/mul/pow/neg, ag_backward, ag_grad). ⚠ reduce 연산 없음 + division primitive 없음.
  - → 설계대응: 각 스칼라 좌표를 shape-[1] Tensor 로 → 모든 중간값이 [1]-Tensor → 스칼라 에너지 U 도 [1]-Tensor → `ag_backward` 가 ones_like(U)=[1.0]=dU/dU 시드 → `ag_grad(coord_i)` = ∂U/∂x_i. r⁻ⁿ 은 `ag_pow(r², −n/2)` (음수 지수로 1/r·1/r⁶·1/r¹² 대체).
- `stdlib/chem/md/lennard_jones.hexa` — `lj_pair_force` analytic 존재 확인 (F=24ε(2σ¹²/r¹²−σ⁶/r⁶)/r²·r⃗). `md_test` 재실행 4/4 PASS (T1-T4) 베이스라인 확인.
- Coulomb 항: `ewald.hexa` 에 ke·q_i q_j/r 실공간 형태 존재 — 단쌍 force 는 ke q1q2/r³·r⃗ 해석미분으로 selftest 내 독립 재유도.

### 구현 (신규, d4-generic)
- `stdlib/chem/md/forces_autograd.hexa` (169줄) — U_total(좌표) 를 autograd tape 로 빌드 → ag_backward → F_i=−∂U/∂x_i. **손미분 0줄.**
  - `pair_energy_autograd` / `pair_force_autograd` / `pair_energy_value`. generic term-builder fold (LJ·Coulomb) — 항 추가 = energy-only builder 하나, per-term force 코드 無, potential-이름 분기 無.

### g5 selftest VERBATIM (`hexa run`, exit 0)
- `stdlib/chem/md/forces_autograd_selftest.hexa` (193줄):
```
  fixture: eps=0.65 sigma=3.15 q1=0.84 q2=-0.42 ke=138.935
  F_autograd = [-3.34922,-1.67461,-1.15935,3.34922,1.67461,1.15935]
  F_analytic = [-3.34922,-1.67461,-1.15935,3.34922,1.67461,1.15935]
  F_finitedf = [-3.34922,-1.67461,-1.15935,3.34922,1.67461,1.15935]
  ok : (a) autograd == analytic     max|Δ|=1.77636e-15
  ok : (b) autograd == finite-diff  max|Δ|=2.45893e-09
  ok : (c) Newton 3rd F_i=−F_j      max|F1+F2|=0.0
  ok : (d1) r→∞ ⇒ F→0 (r=1e6)       max|F(r=1e6)|=4.90164e-11
  ok : (d2) r=500 Coulomb tail==analytic  max|Δ|=2.71051e-20  (Fx≈-1.96e-4, LJ≈0)
  PASS: forces_autograd 5/5
```

### 정직 노트 (d6/@L5) — (d) 1차 FAIL → 수정
- 초기 `r→∞ ⇒ F→0` 를 r=500·tol 1e-6 로 두자 1.96e-4 로 FAIL. **autograd 버그 아님** — 이는 정확한 Coulomb 장거리 꼬리 ke·q1·q2/r² (1/r² = long-range, Ewald/PME 존재 이유 그 자체). falsifier 임계값이 물리적으로 순진했던 것.
- 정정: (d1) r=1e6 (Coulomb 도 <1e-6) + (d2) r=500 에서 autograd F == 해석 Coulomb 꼬리(2.7e-20) — autograd 가 장거리항을 spurious 하게 0으로 만들지 않고 정확히 추적함을 봉인.

### 봉인 확정
**autograd-force == analytic == finite-diff (|Δ|<1e-6) ⇒ 모든 후속 포텐셜(soft-core λ · PME real-space · bonded)은 energy-only 만 작성하면 autograd 가 힘을 공급. 손미분 불필요.** load-bearing 전제 SEALED.

### 산출
- stacked PR: hexa-lang#3076 (L1 impl, base=main) ← #3077 (L2 selftest, merged into L1). 머지=사용자. 0-POD·$0 (local g5).
- 다음 brick (R3 후보): soft-core λ-energy 닫힌형 (Beutler 1994) — λ=0/1 endpoint 비특이성 g5. autograd-force 봉인을 직접 소비 (soft-core U 만 tape 에 쓰면 dU/dλ·force 자동).

## 2026-06-12 · R3-brick ✅ SEALED — Beutler soft-core + dU/dλ autograd = alchemical 코어

### 감사 (round-2 봉인 소비 가능성 확인)
- `stdlib/chem/md/forces_autograd.hexa` (#3076 merged·origin/main): U_total 를 autograd tape 로 빌드(스칼라=[1]-Tensor) → `ag_backward` → F_i=−∂U/∂x_i. 손미분 0줄. → **energy 닫힌식만 tape 에 쓰면 force 자동** 봉인 확인.
- `stdlib/autograd.hexa`: `ag_var/const · ag_add/sub/neg/mul · ag_pow(handle, 상수지수) · ag_backward · ag_grad/value`. ⚠ division primitive 없음 → r⁻ⁿ 은 `ag_pow(base, 음수상수)`. base 는 임의 tape 식 가능 ⇒ soft-core 분모 (α(1−λ)²+(r/σ)⁶) 전체가 미분가능.
- **핵심 확장 가능성 확인**: λ 를 `ag_var` 로 leaf 에 넣으면, coord leaf 와 동일하게 같은 reverse pass 가 ∂U/∂λ 를 공급 → dU/dλ 도 autograd. 손-dU/dλ 불필요.

### 구현 (신규, d4-generic)
- `stdlib/chem/fep/softcore.hexa` (218줄, 코드 ~120) — **energy-only**. U_sc^LJ = 4ε·λⁿ·[D⁻²−D⁻¹], D=α_LJ(1−λ)²+(r/σ)⁶ ; U_sc^C = λᵐ·k_e·q₁q₂/(α_C(1−λ)²+r²)^(1/2). λ·coord 모두 tape VARIABLE leaf → 한 reverse pass 가 force + dU/dλ 둘 다.
  - `softcore_energy_autograd` (U+coords+lam 핸들 반환) · `softcore_force_autograd` (F=−∂U/∂x) · `softcore_dUdlam_autograd` (∂U/∂λ) · `softcore_energy_value` (forward).
  - λ·α_LJ·α_C·n·m = generic param dict (`_p_get` 디폴트 α=0.5·n=m=1). 이름하드코딩·인스턴스분기 無 (d4). 선형결합 = α=0,n=m=1 로 동일 경로.

### g5 selftest VERBATIM (`hexa run`, exit 0)
- `stdlib/chem/fep/softcore_selftest.hexa` (285줄):
```
── softcore selftest (Beutler λ-coupled LJ+Coulomb) ──
  fixture: eps=0.65 sigma=3.15 q1=0.84 q2=-0.42 alpha_lj=0.5 alpha_c=0.5 n=1.0 m=1.0
  [overlap r=0.0001, λ=0.3]
    softcore: U=-19.8975  max|F|=0.0121259
    plainLJ : U=2.48142e+54  max|F|=2.9777e+59
  ok : (a) endpoint non-singular (λ<1,r→0) softcore |U|=19.8975 finite vs plain |U|=2.48142e+54
  [λ=1] U_sc=-15.3709 U_plain=-15.3709
        F_sc=[-3.34922,-1.67461,-1.15935,3.34922,1.67461,1.15935]
        F_pl=[-3.34922,-1.67461,-1.15935,3.34922,1.67461,1.15935]
  ok : (b) λ=1 == plain LJ+Coulomb |ΔU|=0.0 max|ΔF|=2.66454e-15
  ok : (c) λ=0 ⇒ U_sc=0 (decoupled) U=-0.0 max|F|=0.0
    λ=0.15  dU/dλ_ag=-16.0663  dU/dλ_an=-16.0663  |Δ|=0.0
    λ=0.4  dU/dλ_ag=-15.4949  dU/dλ_an=-15.4949  |Δ|=1.77636e-15
    λ=0.65  dU/dλ_ag=-14.8244  dU/dλ_an=-14.8244  |Δ|=0.0
    λ=0.9  dU/dλ_ag=-14.9674  dU/dλ_an=-14.9674  |Δ|=3.55271e-15
  ok : (d) dU/dλ autograd == analytic max|Δ| over λ-grid=3.55271e-15
  [λ=0.5] F_ag=[-0.0763858,-0.0381929,-0.0264412,0.0763858,0.0381929,0.0264412]
            F_fd=[-0.0763858,-0.0381929,-0.0264412,0.0763858,0.0381929,0.0264412]
  ok : (e) F=−∂U/∂x autograd == finite-diff max|Δ|=4.64306e-10

PASS: softcore 5/5
```

### 봉인 확정
- **(a) endpoint 비특이성**: λ=0.3·r=1e-4 에서 soft-core U=−19.9·F=0.012 유한 ; 동일 r 의 plain LJ 는 U=2.48e54·F=2.98e59 로 발산. soft-core 가 r→0 특이점을 제거함 봉인.
- **(b) λ=1 회복**: soft-core == plain LJ+Coulomb, |ΔU|=0.0·max|ΔF|=2.66e-15 (<1e-9). 원래 포텐셜 정확 회복.
- **(c) λ=0 decouple**: U_sc=0·F=0 정확.
- **(d) dU/dλ autograd == analytic**: λ-grid(0.15·0.4·0.65·0.9) 전체 max|Δ|=3.55e-15 (<1e-6). **round-2 force-봉인을 λ leaf 로 확장 — 연금술 그래디언트도 autograd.**
- **(e) force == finite-diff**: max|Δ|=4.64e-10 (<1e-6).
- ⇒ **soft-core + dU/dλ autograd = alchemical 코어 봉인 확정.** TI 적분의 ⟨dU/dλ⟩ integrand 가 손미분 없이 native 로 공급되고, endpoint 발산이 제거됨. FEP 의 두 핵심 난제(특이성·연금술 그래디언트)가 한 봉인으로 닫힘.

### 정직 노트 (d6/@L5)
- 첫 실행에서 5/5 PASS — FAIL→수정 사이클 없음 (round-2 와 달리 falsifier 임계값이 처음부터 물리적으로 타당).
- soft-core 는 단쌍·진공. neighbor-list·PBC·물상자·λ-schedule·decorrelation 은 후속 round (앵커 ΔΔG parity 는 R4+). 본 brick 은 알케미컬 *코어 수식*의 봉인이며 end-to-end ΔG 아님 — 명시.

### 산출
- stacked PR: hexa-lang#3078 (L1 impl, base=main) ← #3079 (L2 selftest, base=L1). 머지=사용자. 0-POD·$0 (local g5). ISOLATED worktree `qforge-bio-softcore-l1/l2`.
- 다음 brick (R4 후보): **HREX** (Hamiltonian replica-exchange swap, detailed-balance g5) — soft-core λ-사다리 위 인접 λ 교환 · **MBAR/BAR** (Shirts-Chodera, 가우시안 작업분포 닫힌형 ΔG g5, dU/dλ·U_kn 행렬 소비) · **PME** (ewald recip 의 fft3 가속, 직접합 parity). 권장 우선순위 = MBAR (soft-core dU/dλ 를 직접 소비하는 estimator — TI/FEP 적분을 닫는 다음 논리 단계).
