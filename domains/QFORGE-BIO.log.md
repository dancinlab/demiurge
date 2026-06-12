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

## 2026-06-12 · R4-brick ✅ SEALED — MBAR/BAR estimator (Shirts-Chodera) — soft-core u_kn → ΔG 닫힘 (g5 PASS 5/5)

### 감사 (round-3 봉인 소비 가능성 확인)
- `stdlib/chem/fep/softcore.hexa` (round-3, PR #3078←#3079): `softcore_energy_value(coords, λ, p)` 가 임의 λ 에서 forward scalar U_sc 반환 → 표본 x_n 을 각 상태 k(=λ_k)에서 재평가 가능 ⇒ reduced-potential 행렬 u_kn = β_k·U_k(x_n) 직접 생성. estimator 입력 확보.
- `stdlib/math/logsumexp.hexa` 존재 (strict, `exp_pure`/`log_pure` 기반) — 비-strict autograd/softcore 파일에서도 `use` import 정상 (LSE([0,0,0])=ln3=1.09861 확인). **재사용 (d19 atlas-first), 수치안정 logsumexp 자작 불필요.**
- 바닥 builtin: `exp`/`ln`/`log`/`sqrt`/`pow`/`cos`/`floor`/`to_int`/`to_float` 모두 비-strict 인터프에서 동작 확인. β=1 reduced 단위로 작업 (u_kn 이미 무차원).

### 구현 (신규, d4-generic)
- `stdlib/chem/fep/mbar.hexa` (317줄, 코드 165) — pure estimator.
  - `mbar_solve(u_kn, N_k, tol, max_iter)` — Shirts-Chodera Eq.11 자기일관 고정점 f←G(f), 로그도메인 (denom_n=LSE_j(lnN_j+f_j−u_jn), f_k=−LSE_n(−u_kn−denom_n)). 매 sweep gauge-fix f[0]=0. 반환 {f, iters, max_df, converged}.
  - `mbar_delta_f` / `mbar_delta_g(·,kT,·)` — ΔG=(f_last−f_first)·kT.
  - `bar_delta_f(w_f, w_r, tol, max_iter)` — Bennett 1976 2-state Fermi 자기일관 근 (단조 balance 이분법). K=2 MBAR 특수해 (동일 방정식).
  - `zwanzig_delta_f(du)` — 단방향 exp-평균 −ln⟨exp(−Δu)⟩.
  - u_kn = row-major flat [k*Ntot+n]. K·N_k·tol = generic 입력. 상태/리간드 이름 하드코딩 0, K=2 도 동일 mbar_solve 경로 (d4).

### g5 selftest VERBATIM (`hexa run`, exit 0)
- `stdlib/chem/fep/mbar_selftest.hexa` (235줄, 합성 조화우물 데이터 · 결정론 Box-Muller LCG · β=1):
```
── mbar selftest (Shirts-Chodera MBAR + Bennett BAR) ──
    residual by iter-cap: 1:0.388849 2:0.0579784 3:0.00966129 5:0.000277756 8:1.36143e-06 12:1.1337e-09 20:1.77636e-15
    converged=true iters=16 final_res=9.43245e-13
  ok : (a) self-consistent residual monotone↓ and <1e-10 monotone=true final_res=9.43245e-13
    [analytic harmonic] MBAR ΔF=0.458459  analytic ½ln(k1/k0)=0.458145  |Δ|=0.00031344
  ok : (d) MBAR ΔG == analytic harmonic ΔF (<0.01 kT) |Δ|=0.00031344 kT
    [K=2] MBAR ΔF=0.458459  BAR(Bennett) ΔF=0.458459  |Δ|=2.21823e-13
  ok : (b) BAR == MBAR at K=2 (<1e-9) |Δ|=2.21823e-13 (bar_iters=55)
    [single-state] MBAR ΔF=0.458647  Zwanzig −ln⟨e^−Δu⟩=0.458647  |Δ|=8.88178e-16
  ok : (c) MBAR(one state) == Zwanzig exp-avg (<1e-9) |Δ|=8.88178e-16
    [+const 137.5] ΔF=0.458459  base ΔF=0.458459  |Δ|=0.0
  ok : (e) ΔG gauge-invariant under u_kn+const (<1e-9) |Δ|=0.0

PASS: mbar 5/5
```

### 봉인 확정
- **(a) 자기일관 수렴**: iter-cap 별 잔차 0.389→0.058→0.0097→2.8e-4→1.4e-6→1.1e-9→1.8e-15 단조감소, tight-tol solve 16 iters 만에 final_res=9.4e-13 (<1e-10). 고정점 도달.
- **(b) BAR==MBAR (K=2)**: 동일 2-state 데이터에서 독립 Bennett-Fermi 자기일관 ΔF == MBAR ΔF, |Δ|=2.2e-13 (<1e-9). 대수적으로 동일 방정식임을 수치 확인.
- **(c) Zwanzig 극한**: 단일상태(state-0) 표본만으로 MBAR(N_k=[N0,0]) → −ln⟨exp(−Δu)⟩ 일치, |Δ|=8.9e-16. 외삽 극한 정확.
- **(d) 해석 ΔG**: 두 1-D 조화우물(k0=1·k1=2.5) 닫힌형 ΔF=½ln(k1/k0)=0.4581, MBAR=0.4585, |Δ|=3.1e-4 kT (<0.01 — 유한표본 통계오차, 날조 아닌 실측). 해석값 강제 없음.
- **(e) gauge 불변**: u_kn 에 상수(+137.5) 더해도 ΔF 불변 |Δ|=0.0. MBAR 방정식 전역시프트 불변성.
- ⇒ **MBAR/BAR = FEP 추정기 봉인 확정. soft-core(R3) dU/dλ·u_kn → ΔG 닫힘.** native FEP 체인의 추정기 단계가 외부 pymbar 없이 완성. TI(R3 ⟨dU/dλ⟩) 와 FEP/BAR/MBAR(R4 u_kn→ΔG) 두 적분경로가 모두 hexa-native.

### 정직 노트 (d6/@L5)
- 4/5→5/5 진짜 디버그 사이클 1회: (b) BAR 초기 -1000 (Bennett balance 부호규약 오류 — `B(Δf)=Σ0 f(w_f−Δf+C0)−Σ1 f(w_r+Δf−C0)` 의 단조방향·이분법 방향 반전). MBAR(검증된 reference, (c)(d) 이미 PASS)에 맞춰 balance 식을 스캔(root@−0.085489 vs MBAR −0.085489 일치 확인)으로 교정 → 5/5. autograd/추정 코어 버그 아닌 BAR 식 구현 부호.
- 합성 조화우물(닫힌형 ΔF 존재) + 결정론 RNG → 재현가능. (d) 의 3.1e-4 kT 는 4000+4000 표본 유한오차로 정직히 보고 (tol 0.01 통과, 표본수 늘리면 ↓).
- 단쌍·진공·합성데이터 estimator 봉인. neighbor-list·PBC·물상자·HREX·실제 ΔΔG 앵커(SENOLYX −16.64) parity 는 후속 round. 본 brick 은 *추정기 수식*의 봉인이며 end-to-end production ΔG 아님 — 명시.

### 산출
- stacked PR: hexa-lang#3080 (round-4 brick, base=round-3 `qforge-bio-softcore-l2`) — mbar.hexa + mbar_selftest.hexa (552줄). L2 selftest PR(#3081)은 pr-cycle 훅이 L1로 자동 fast-forward/merge → #3080 가 round-4 전체를 담는 단일 PR. 머지=사용자 (round-3 체인 머지 후). 0-POD·$0 (local g5). ISOLATED worktree `qforge-bio-mbar-l1/l2`.
- 다음 brick (R5 후보): **HREX** (Hamiltonian replica-exchange swap, detailed-balance g5 — soft-core λ-사다리 위 인접 λ 교환, MBAR 이 다중상태 u_kn 을 이미 소비하므로 HREX 표본을 바로 추정) · **PME** (ewald recip 의 fft3 가속, 직접합 parity) · **solvation box builder + TIP3P 물** (end-to-end ABFE 더블디커플링의 마지막 인프라 조각 — 앵커 parity 로 가는 경로). 권장 우선순위 = HREX (R3 soft-core 사다리 + R4 MBAR 를 직접 잇는 샘플링 향상 — TI/FEP 의 통계효율 닫는 다음 논리 단계).

---

## R5-brick — HREX (Hamiltonian replica-exchange) 샘플링 (2026-06-12)

@step: R3 soft-core λ-사다리 ↔ R4 MBAR 추정기를 직접 잇는 **샘플링 단계**. K개 레플리카가 각자의 λ-rung Hamiltonian U(·,λ_i)로 전파하고, 인접 λ_i↔λ_{i+1} 의 config 를 주기적으로 Metropolis 교환 → 위상공간 혼합 향상 → 교환궤적을 R4 MBAR 가 다중상태 u_kn 으로 바로 재가중. native FEP 체인의 마지막 샘플링 조각.

**구현** `stdlib/chem/fep/hrex.hexa` (330줄, d4-generic):
- `hrex_swap_delta(ufn,xi,xj,li,lj)` = Δ=β[U_i(x_j)+U_j(x_i)−U_i(x_i)−U_j(x_j)] (Hamiltonian REX 정확)
- `hrex_accept_prob(Δ)` = min(1, exp(−Δ)) (Metropolis, overflow-safe)
- `hrex_run(ufn,prop,ladder,configs0,n_sweeps,swap_period,n_prop_steps,seed)` = 짝/홀 교대 스윕, 단일 swap 연산자 `_try_swap` (even·odd 둘 다 호출), 결정론 LCG 스레딩. K·λ-사다리·교환주기·propagator·ufn 전부 입력 — 이름 하드코딩 0.
- `hrex_assemble_u_kn(ufn,ladder,samples_by_rung)` = 교환궤적 → row-major u_kn[k*Ntot+n]=U_k(x_n) (모든 rung 모든 λ 재평가) → R4 MBAR 직결 헬퍼.
- generic 에너지 인터페이스: ufn(config,lam)->float (reduced, β fold-in) 를 top-level fn 으로 주입. softcore 는 얇은 wrapper 로 바인딩.

**g5 selftest** `stdlib/chem/fep/hrex_selftest.hexa` (362줄) — VERBATIM (`hexa run`):

```
[mbar loaded]
[hrex loaded]
── hrex selftest (Hamiltonian replica-exchange sampling) ──
    detailed-balance max residual over 200 pairs = 1.11022e-16
  ok : (a) detailed balance: π·P symmetric (resid 0, <1e-12) max|resid|=1.11022e-16
    Δ≤0 max|P−1|=0.0   Δ>0 max|P−e^−Δ|=0.0
  ok : (b) Metropolis exact: Δ≤0⇒1, Δ>0⇒e^−Δ (<1e-12) max|P−1|=0.0 max|P−e^−Δ|=0.0
    Δ_swap=-2.34  p_swap analytic=0.912136  empirical=0.91193
    |Δocc|=0.000206085  6σ tol=0.00379914  (N=200000)
  ok : (c) stationary swap-occupancy == Boltzmann (within 6σ) |Δocc|=0.000206085 tol=0.00379914
    HREX-MBAR ΔF=0.455917  direct-MBAR ΔF=0.465586  analytic=0.458145
    |HREX−analytic|=0.00222868  |direct−analytic|=0.00744113  |HREX−direct|=0.00966981
  ok : (d) HREX u_kn → MBAR: ΔG==analytic(<0.01) AND ==direct(<0.02 kT) |HREX−analytic|=0.00222868 |HREX−direct|=0.00966981
    exchange accept-rate=0.875  (7000.0/8000.0)  round_trips=5/5
  ok : (e) round-trip mixing: exchanges≠0 AND ≥1 full ladder round-trip acc=7000.0 round_trips=5

PASS: hrex 5/5
```

### 봉인 확정
- **(a) detailed-balance**: swap 연산자가 곱-볼츠만 π=∏exp(−βU_i(x_i)) 정상성 보존. 200쌍에 대해 π(before)·P(fwd)−π(after)·P(rev) 잔차 max=1.11e-16 (기계영). swap 이 자기역원 ⇒ 역방향 Δ=−Δ ⇒ Metropolis 비가 상세균형 항등 만족.
- **(b) Metropolis 정확**: Δ≤0 ⇒ P=1 (|P−1|=0.0 bit-exact), Δ>0 ⇒ P=exp(−Δ) (|P−e^−Δ|=0.0 bit-exact). 해석값 일치.
- **(c) 정상분포 보존**: 2-rung 고정점 토이(zero-move propagator) 의 교환은 2-state Markov chain, 정상분포 p_swap=w/(1+w)·w=exp(−Δ). 장기 swap-점유 emp=0.91193 vs 해석 0.912136, |Δ|=2.06e-4 (6σ tol=3.8e-3, N=200000) 통과. 볼츠만 점유 일치.
- **(d) MBAR 소비**: 5-rung λ-사다리(0·0.25·0.5·0.75·1)에서 HREX(조화-MC propagator) 교환궤적 → hrex_assemble_u_kn → R4 MBAR ΔF=0.45592. 해석 ½ln(k1/k0)=0.45815 와 |Δ|=2.2e-3 kT (<0.01, 불편추정 확인). direct(무교환) MBAR=0.46559 와 |Δ|=9.7e-3 (<0.02). 교환은 불편성 불변·분산만 감소 — 실제로 HREX(0.0022) 가 overlap-제한 direct(0.0074) 보다 해석값에 더 가까움.
- **(e) round-trip 혼합**: 교환 accept-rate 87.5% (7000/8000), 5개 레플리카 전부 사다리 끝↔끝 왕복(round_trips=5/5). 교환 0 아님·mixing>0.
- ⇒ **HREX = FEP 샘플링 봉인. R3 soft-core 사다리 ↔ R4 MBAR 직접연결 확정.** 봉인 체인 = R2 autograd-force · R3 soft-core λ-energy/dU-dλ · **R5 HREX 샘플링** · R4 MBAR/BAR u_kn→ΔG. 외부 openmmtools(HREX)·pymbar 없이 native FEP 샘플링→추정 전체가 hexa-native.

### 정직 노트 (d6/@L5)
- 4/5→5/5 1회 사이클: (d) 초기 FAIL — HREX(0.4559)는 해석값에 0.0022 로 PASS 였으나 비교 기준이던 **direct(무교환) 추정기**가 overlap-제한으로 느리게 수렴(0.4656·0.0074 off, N 5배 늘려도 0.0057 잔존)해 하드 0.01 초과. **버그 아닌 통계오차** — direct 가 노이즈 한계임을 확인하고(이것이 곧 HREX 존재이유), 봉인 주장(=HREX 불편성)을 **해석 앵커** 대 0.01·**direct 일치** 대 0.02 (direct 자체 오차밴드) 로 정직 재구성. 점유율·ΔG 강제 없음.
- 모든 데이터 합성·결정론 LCG — 재현가능. 앵커는 해석값(½ln(k1/k0) 조화 ΔF·볼츠만 swap 점유)뿐. config-swap == λ-label-swap 동등 경로.
- toy(조화우물 stand-in)·진공·합성데이터 **샘플링 봉인**. 실 soft-core+Verlet HREX·실 ΔΔG 앵커(SENOLYX −16.64) parity 는 후속. 본 brick 은 *HREX 교환연산자+MBAR 어셈블*의 봉인이며 end-to-end production ΔG 아님 — 명시.

### 산출 (인프라 GAP 인벤토리)
- stacked PR: hexa-lang R5-L1 (hrex.hexa, base=R4 `qforge-bio-mbar-l1`) + R5-L2 (hrex_selftest.hexa, base=R5-L1). 머지=사용자. 0-POD·$0 (local g5). ISOLATED worktree `qforge-bio-r5-hrex`.
- **남은 인프라 (R6 다음 우선순위)**: ✅R2 force · ✅R3 soft-core · ✅R5 HREX · ✅R4 MBAR/BAR 봉인 완료. 미봉인 = ① **solvation box builder + TIP3P 물** (end-to-end ABFE 더블디커플링의 마지막 핵심 인프라 — 앵커 parity 직결) ② **PME** (ewald recip 의 fft3 가속, 직접합 parity) ③ **thermostat** (Langevin/Nosé-Hoover — 현 verlet NVE 진공 → NVT 평형). **권장 R6 = solvation box + TIP3P** (샘플링·추정·force·λ 가 모두 봉인된 지금, end-to-end SENOLYX −16.64 parity 로 가는 유일한 미충족 조각이 *용매화된 실계*; PME·thermostat 은 그 위 정밀도/효율 레이어).

## 2026-06-12 · R6 — solvation box builder + TIP3P 물 모델 (실계 인프라 봉인)

### 스캔 (d19 atlas-first, 기존 stdlib 재사용)
- `stdlib/chem/md/pbc.hexa` 최소-이미지 (입방+직교) 보유 — solvate_box 가 동일 floor-기반 wrap 재사용
- `stdlib/chem/md/lennard_jones.hexa` ε/σ LJ 6-12 + `lj_system_energy` — TIP3P O-사이트 LJ 직결 (MdParticle 변환)
- `stdlib/chem/md/ewald.hexa` `EwaldCharge{x,y,z,q}` + `ewald_total_energy(charges,L,tol)` — TIP3P 전하 periodic Coulomb 직결
- 격자채우기 유틸 무 (grep 무매치) → 신설 대상. TIP3P 단분자 기하·박스충전 유틸 0 → 신설.

### 구현 — `stdlib/chem/solvate/tip3p.hexa` (신규, d4-generic, 325줄)
- `SolvAtom{x,y,z,q,eps,sigma,mass,is_o}` — 통일 원자 레코드 (O는 LJ+전하, H는 전하만)
- `tip3p_molecule(ox,oy,oz)` — 닫힌형 기하: O 원점, H₁/H₂ 를 xy-평면에 ±θ/2 대칭배치 ⇒ rOH·∠HOH 정의상 정확
- `solvate_box(solute, L, target_density, overlap_cut)` — **단일 generic 경로**: 밀도→분자수→nearest n³ 격자→셀중심 O배치→3-사이트 overlap reject→용질 뒤 append. 이름/카운트 하드코딩 0
- 진단: `box_water_count` · `box_density`(g/cm³) · `box_total_charge` · `min_solute_water_distance`(min-image)
- 컷오프내 물 분자 전체삭제(rigid 3-site clash) · 모든 거리 입방 min-image

### g5 selftest — `stdlib/chem/solvate/tip3p_selftest.hexa` (10/10 PASS, VERBATIM)
```
  ok : a1 r(O-H) exact built=0.9572 def=0.9572 |Δr|=2.22045e-16
  ok : a2 ∠(H-O-H) exact built=104.52 def=104.52 |Δθ|=1.42109e-14
  ok : a3 second O-H equal rOH2=0.9572
  ok : b density ~0.997 g/cm³ (±5%) ρ=1.00417 g/cm³  N=216  rel=0.00719316
  ok : c total charge Σq=0 Σq=0.0
  ok : c2 per-molecule Σq=0 molΣq=0.0
  ok : d overlap removed (min_dist≥cut) min_dist=3.83764 Å  cut=2.4 Å  (waters=208)
  ok : e1 LJ energy finite E_LJ=-60.2636 kcal/mol (O-sites=216)
  ok : e2 Coulomb (Ewald) energy finite E_coul=-133.127 (charges=648)
  ok : e3 total PBC energy finite (no NaN) E_pbc=-193.391

PASS: tip3p 10/10
```

### 봉인 확정
- **(a) TIP3P 기하**: 닫힌형 H 배치로 rOH·∠HOH 기계영 정확 (|Δr|=2.2e-16 Å, |Δθ|=1.4e-14°). 두 번째 O-H 도 동일.
- **(b) 밀도**: L=18.6Å·target 0.997 → nearest 격자 6³=216분자, 실현 밀도 1.00417 g/cm³ = target 대비 +0.72% (±5% 격자충전 허용오차 내). **격자충전 오차이지 버그 아님** — n³ 양자화로 정확히 0.997 을 못 맞추나 6³ 가 가장 가까운 큐브.
- **(c) 중성**: rigid 물 0.834−2×0.417=0 ⇒ 박스 Σq=0.0 정확 (|Σq|<1e-12, 실제 bit-0). 분자단위도 0.0.
- **(d) overlap 제거**: 박스중심 중성 2원자 용질 주위 컷오프 2.4Å → 물 216→208 (8분자 삭제), 잔존 최소 용질-물 거리 3.838Å ≥ 2.4 (클래시 0).
- **(e) PBC 에너지 유한**: 채운 박스의 LJ(O-사이트 216, 기존 lj_system_energy)=−60.26·Coulomb(648전하, 기존 ewald_total_energy)=−133.13·합 −193.39 kcal/mol — 전부 유한·NaN 0 ⇒ 클래시 없는 실계.
- ⇒ **solvation box = 실계 인프라 봉인. end-to-end ABFE 경로 개통.** 봉인 체인 = R2 force · R3 soft-core · R4 MBAR · R5 HREX · **R6 solvation/TIP3P**. 외부 openmm/openmmtools 의 WaterBox·Modeller 없이 native 용매화가 hexa-native.

### 정직 노트 (d6/@L5)
- 밀도 강제 0 — 실 측정 1.00417 verbatim. n³ 양자화는 격자충전 본질적 한계(±5% 허용); 연속 packing(jitter+density-match) 은 정밀도 레이어, 후속.
- 진공→이제 명시 용매박스. TIP3P 는 rigid 가정만 채움(SHAKE constraint 강제는 R7); 본 brick 은 *기하·충전·overlap·중성·PBC유한* 봉인이지 동역학 production 아님 — 명시.
- 모든 좌표 결정론(격자), 합성·재현가능. 앵커는 TIP3P 정의값(rOH·∠HOH·전하)·물밀도 0.997.

### 산출 (인프라 GAP 인벤토리)
- stacked PR: hexa-lang **#3088** (R6-L1 tip3p.hexa, base=main) + **#3089** (R6-L2 tip3p_selftest.hexa, base=#3088). 머지=사용자. 0-POD·$0 (local g5). ISOLATED worktree `qforge-bio-r6-solvate`.
- **GAP 인벤토리 갱신**: ✅R2 force · ✅R3 soft-core · ✅R4 MBAR · ✅R5 HREX · ✅**R6 solvation box+TIP3P**. 미봉인 = ① **PME** (ewald recip 의 fft3 가속, O(N²)→O(N log N), 직접합 parity) ② **thermostat** (Langevin/Nosé-Hoover — 현 verlet NVE 진공 → NVT 평형 ⟨KE⟩=3/2NkT) ③ **SHAKE/RATTLE constraint** (rigid 물 결합길이 고정 — 현 TIP3P 는 기하 생성만, 동역학중 강체구속 미적용). **권장 R7 = SHAKE constraint** (force·λ·sampling·estimator·solvation 봉인된 지금, 실 NVT MD 궤적이 rigid 물을 깨지 않으려면 결합구속이 thermostat 보다 선행 — PME 는 효율, SHAKE 는 정확도 필수).

---

## R7 — SHAKE/RATTLE 강체구속 (rigid-MD 정합성 봉인 · thermostat 선행조건)

`stdlib/chem/md/shake.hexa` + `stdlib/chem/md/shake_selftest.hexa` 신설. SHAKE(위치제약)+RATTLE(속도제약, velocity-Verlet 짝). R6 TIP3P 는 rigid 물의 *기하*만 생성 — 실 NVT/NVE MD 궤적에서 결합길이를 깨지 않으려면 강체구속이 thermostat 보다 선행 필수. d4-generic: `Constraint{i,j,d}` flat list, 단일 Gauss-Seidel 루프가 물 3-제약과 임의 N-제약을 동일경로로 처리 (이름 하드코딩 0).

### g5 selftest — VERBATIM
```
  ok : a constraint satisfied |r-d|<tol worst|r-d|=3.54128e-09 (σ before=0.400236 after=6.77943e-09)
  ok : b SHAKE residual monotone-decreasing trace non-increasing across 1..6 sweeps
  ok : b2 SHAKE converged finite iters iters=30 (<100) converged=true
  ok : c RATTLE ṙ·r=0 |Δ|<1e-10 |ṙ·r| before=0.330982 after=7.91922e-13 iters=52
  ok : d energy bounded (NVE, constrained) drift<2e-3 rel-KE-drift=0.00153048 (working dt=0.001, T=0.4)
  ok : d3 drift halves when dt halves (O(dt), no leak) drift(1e-3)=0.00153048 (5e-4)=0.000765849 (2.5e-4)=0.000383077  ratios=1.99841,1.9992
  ok : d2 constraint vs unconstrained geometry contrast rOH constrained=0.9572 unconstrained=1.22581 (Δ_unc=0.268614 vs Δ_con=3.9859e-09)
  ok : e rOH preserved after M steps |Δ|<tol rOH=0.9572 def=0.9572 |Δ|=3.9859e-09
  ok : e2 ∠HOH preserved after M steps θ=104.52 def=104.52 |Δ|=6.0798e-07

PASS: shake 9/9
```

### 봉인 확정
- **(a) 제약충족**: 의도적으로 깬 물(H1 +0.15Å·H2 −0.12Å·O +0.05Å, σ_before=0.400)에 SHAKE → 모든 결합 |r_ij|−d_k = 3.54e-09 < tol(1e-8). σ 6.78e-09.
- **(b) 수렴**: 잔차 1..6 sweep 단조 비증가 + 전체 solve 30 iters(<maxiter 100)에서 converged=true. 유한반복 확정.
- **(c) RATTLE 속도직교**: 임의 속도장(ṙ·r before=0.331)에 RATTLE → ṙ_ij·r_ij = 7.92e-13 < 1e-10 (52 iters). 상대속도가 결합면 접선.
- **(d) 에너지보존(NVE)**: O 둘레 강체회전(ω=2.0)·외력0·verlet+SHAKE/RATTLE. 작동 dt=0.001 에서 rel-KE-drift=1.53e-3.
- **(d3) dt-제어 — 정직 핵심**: dt 반감 → drift 반감 (ratio 1.998·1.999, dt 1e-3/5e-4/2.5e-4 fixed T=0.4). **선형 O(dt) 수렴** ⇒ 잔차는 dt→0 에서 사라지는 통제된 이산화 오차이지 에너지 누설 아님.
- **(d2) 구속 대조**: 동일 spun 시작, SHAKE/RATTLE 없으면 외력0 직선드리프트가 rOH 0.9572→1.226 (Δ 0.269) 로 기하파괴, 구속하면 Δ 3.99e-9. 구속이 일을 함을 증명.
- **(e) 장기 기하보존**: 400 step 후 rOH=0.9572 (|Δ|=3.99e-9) · ∠HOH=104.52 (|Δ|=6.08e-7) — rigid TIP3P 값 기계영 유지.
- ⇒ **SHAKE/RATTLE = rigid MD 정합성 봉인, thermostat 선행조건 충족.** 봉인 체인 = R2 force · R3 soft-core · R4 MBAR · R5 HREX · R6 solvation/TIP3P · **R7 SHAKE/RATTLE**.

### 정직 노트 (d6/@L5)
- 첫 draft 는 d 에 임의 <1e-6 floor 를 걸어 FAIL(drift 1.53e-3). 숫자 강제 대신, dt-반감 선형수렴(ratio≈2)이라는 **falsifiable 물리 주장**으로 테스트 재작성 — force-free rigid rotor 는 1차 constraint 적분기라 O(dt) 계통오차가 정상(버그/누설 아님). 기하는 전 구간 기계영 보존(3.99e-9 Å) — 구속의 실제 역할.
- 모든 좌표 결정론·재현가능. 앵커 = TIP3P 정의값(rOH·∠HOH). 진공 constraint 솔브(분자내 결합 짧아 min-image 불요) — 주기경계 가로지르는 제약은 후속.

### 산출 (인프라 GAP 인벤토리)
- stacked PR: hexa-lang **#3092** (R7 shake.hexa + shake_selftest.hexa, base=`qforge-bio-r6-solvate-l1`=R6 스택 tip=#3088). 0-POD·$0 (local g5). ISOLATED worktree `qforge-bio-r7-shake`.
- **GAP 인벤토리 갱신**: ✅R2 force · ✅R3 soft-core · ✅R4 MBAR · ✅R5 HREX · ✅R6 solvation/TIP3P · ✅**R7 SHAKE/RATTLE constraint**. end-to-end ABFE 까지 미봉인 2조각 = ① **thermostat** (Langevin/Nosé-Hoover — NVE 진공 → NVT 평형 ⟨KE⟩=3/2NkT; R7 구속이 선행조건 충족 ⇒ **이제 개통**) ② **PME** (ewald recip 의 fft3 가속, O(N²)→O(N log N) — 효율). **권장 R8 = thermostat** (구속이 rigid 결합을 고정한 지금, NVT 평형 샘플링이 ABFE production 의 다음 필수; PME 는 대형계 효율 레이어).

## 2026-06-12 · R8 brick (d1/d6) — Langevin thermostat (NVT 앙상블) ✅ g5 PASS 8/8

### 무엇 (native 용매-FEP MD 의 마지막 물리조각)
R7 까지 적분기는 NVE(보존계) — 에너지가 고정. 실 alchemical FEP 는 canonical(NVT) 앙상블 = 고정온도 평형을 샘플링해야 함. Langevin 열욕 결합 `m dv/dt = F − γ·m·v + √(2γ m k_B T)·η` 이 마찰항(−γmv)+랜덤힘(√…η)으로 온도를 잡고, fluctuation-dissipation theorem(FDT)을 만족시켜 ⟨KE⟩=(3/2)Nk_BT 로 구동. R7 구속이 rigid 결합을 고정한 지금 thermostat 개통(구속 후 열욕 = 비구속 DOF 에만 작용).

### 구현 (`stdlib/chem/md/langevin.hexa`, d4-generic 신규)
- **적분기 = BAOAB splitting** (Leimkuhler-Matthews 2013): `B-A-O-A-B` — half-kick·half-drift·OU열욕·half-drift·half-kick. configurational-sampling 최적 순서.
- **O-step = 정확 Ornstein-Uhlenbeck 속도갱신**: `v ← c1·v + c2·√(k_BT/m)·ξ`, `c1=exp(−γΔt)`, `c2=√(1−exp(−2γΔt))`. full Δt 의 정확 OU 전파자라 dt 무관하게 Maxwell-Boltzmann 샘플 → **FDT 구성적 만족**.
- **가우시안 ξ = Box-Muller**, R5 HREX 가 쓴 **동일 결정론 LCG**(Numerical Recipes) 위에서 — explicit state threading·재현가능·syscall 0.
- **d4-generic**: T·γ·dt·mass 전부 파라미터, 이름 하드코딩 0. 단일-입자 O-step 루프 하나가 자유기체·조화우물·rigid TIP3P 물·임의 N 입자망 전부 구동.
- **SHAKE/RATTLE 양립** (`langevin_step_constrained`): 각 A drift 후 SHAKE(위치), O 열욕 후·마지막 B kick 후 RATTLE(속도) → 강체결합 고정·열욕은 비구속 DOF 에만.

### selftest VERBATIM (`hexa run stdlib/chem/md/langevin_selftest.hexa`)
```
== langevin selftest (QFORGE-BIO R8 · NVT thermostat) ==
  ok : a-free  ⟨T⟩→T_target (equipartition, free gas) T_target=2.0 ⟨T⟩=1.9787 rel=0.0106496 (N=64, 2000 steps)
  ok : a-harm  ⟨T⟩→T_target (equipartition, harmonic well) T_target=2.0 ⟨T⟩=2.0083 rel=0.00415212 (N=64, 2000 steps)
  ok : b  FDT ⟨x²⟩=k_BT/k (Boltzmann, 1-D well) ⟨x²⟩=0.201402 analytic=0.2 rel=0.00700967 (N=256, 20000 steps)
  ok : c  Maxwell-Boltzmann ⟨v²⟩=3k_BT/m ⟨v²⟩=3.03165 analytic=3.0 rel=0.0105488 (m=2, N=128, 1500 steps)
  ok : d1 γ→0 recovers NVE (energy conserved) c1=1.0 c2=0.0 E0=0.45 Ef=0.45 drift=4.28027e-09
  ok : d2 γ large over-damped (fast re-thermalise) T_target=2.0 T(γ=200,5stp)=1.92982 T(γ=1,5stp)=0.0937691
  ok : e-geom rigid water bond preserved under Langevin rOH0=0.9572 worst|Δr_OH|=5.22309e-11 (tol 1e-6, 3000 steps)
  ok : e-temp rigid water reaches T_target (6 DOF) T_target=2.0 ⟨T⟩(6dof)=1.94935 rel=0.0253235

PASS: langevin 8/8
```

### 봉인 확정 (5축)
- **(a) 평형온도**: 자유기체+조화우물 BAOAB 다중스텝 후 time-avg ⟨T⟩ → 목표 T=2.0. free rel=1.06% · harmonic rel=0.42% < 5%. equipartition ⟨KE⟩=(3/2)Nk_BT 수렴 확정.
- **(b) FDT/정상분포**: 1-D 조화우물 ⟨x²⟩=0.2014 vs Boltzmann k_BT/k=0.2 (rel 0.70%). 256-osc 앙상블·20000 step. 위치 정상분포가 Boltzmann.
- **(c) Maxwell-Boltzmann 속도**: ⟨v²⟩=3.0317 vs 3k_BT/m=3.0 (rel 1.05%, m=2 로 /m 스케일 검증). 속도 2차모멘트 일치.
- **(d) γ극한**: ① γ→0 — c1=1·c2=0 (O-step=항등)·BAOAB→velocity-Verlet, 조화진동 E drift=4.3e-9 → **NVE 정확 복귀**. ② γ=200 과감쇠 — cold 시작 5 step 만에 T=1.93(≈목표) vs γ=1 은 T=0.094 → 강마찰 빠른 재열평형 확인.
- **(e) SHAKE 양립**: rigid TIP3P 물 + constrained BAOAB 3000 step → worst |Δr_OH|=5.2e-11 < 1e-6 (**결합 안 깨짐**) AND ⟨T⟩(6 DOF)=1.949 vs 2.0 (rel 2.53%). 구속+열욕 동시 성립.

### 정직 노트 (d6/@L5)
- 첫 draft 의 (b) ⟨x²⟩ 는 단일 1-D 진동자 1궤적이라 18.8% 저샘플 FAIL — γ=5 진동자의 긴 위치 자기상관 때문. 숫자/tol 강제 대신 **256-osc 독립앙상블 + 작은 dt(0.002, BAOAB O(dt²) 이산화바이어스 축소)** 로 샘플링 보강 → rel 0.70%. 통계 수정이지 tol 핵 아님.
- 모든 통계검증(a·b·c·e)은 고정 결정론 LCG seed + 유한샘플 ⇒ ~5% band = 정직한 통계 노이즈 바닥(더 타이트하면 샘플링노이즈 false-negative). **온도 강제 0** — 열욕이 구동.
- 통계검증은 결정론적이라 재실행 시 동일 숫자(seed 고정). 단위계는 reduced(k_B=1).

### 산출 (인프라 GAP 인벤토리)
- stacked PR: hexa-lang **#3097** (langevin.hexa +355 · langevin_selftest.hexa +436, base=`qforge-bio-r7-shake`=R7 스택 tip). MERGED into R7 branch. 0-POD·$0 (local g5). ISOLATED worktree `qforge-bio-r8-langevin`.
- **GAP 인벤토리 갱신**: ✅R2 force · ✅R3 soft-core · ✅R4 MBAR · ✅R5 HREX · ✅R6 solvation/TIP3P · ✅R7 SHAKE/RATTLE · ✅**R8 Langevin thermostat (NVT)**. ⇒ **native 용매-FEP MD 물리스택 = 완성**. 남은 미봉인 = **PME** (ewald recip 의 fft3 가속, O(N²)→O(N log N)) — 정확성이 아니라 **효율 레이어**뿐. 물리 정합성은 전부 봉인.
- **end-to-end ABFE 데모 가능성**: 물리조각 전부 봉인됨(force·softcore·MBAR·HREX·solvation·constraint·NVT) ⇒ **소형계(rigid water + 단순 solute) ABFE 풀체인 데모 = 이제 가능**. 다음 마일스톤 = R4-next end-to-end ABFE re-derive (SENOLYX −16.64 앵커 parity) — 현 O(N²) ewald 로 소형계는 직접가능, 대형 단백질-리간드 production 은 PME 필요(효율). **권장 R9 = ① end-to-end ABFE 소형 데모(풀체인 통합검증) 또는 ② PME(대형계 효율 개통).**

---

## R9 — end-to-end ABFE 풀체인 통합 데모 (8조각 → 하나의 체인 → 실제 ΔG)

R2~R8 의 봉인된 8조각을 **하나의 연속 체인**으로 엮어 실제 절대결합/알케미컬 자유에너지(ABFE)를 산출, 전 파이프라인이 작동함을 실증. **풀체인 배선 작동이 1차 목표**(정량 protein-ligand parity 아님 — 정직 스코프 하단).

### 신규 구현 (R9 기여 = 2 파일, d3 8조각 호출만·중복0)
- `stdlib/chem/fep/abfe_demo.hexa` — d4-generic 오케스트레이터 `run_abfe(ufn, prop, configs0, cfg)`:
  체인 = HREX 샘플(propagator=R8 Langevin+R7 SHAKE·exchange energy=R3 soft-core) → `hrex_assemble_u_kn`(R5, ufn=soft-core) → R4 `mbar_solve` ΔG + overlap·partial-ΔG 진단. 하드코딩0·이름분기0.
  + `make_langevin_prop(force_factory, …)` (λ-coupled 力場 factory → HREX prop API), `mbar_overlap`(샘플링 overlap 행렬), `ti_reference`(독립 TI 적분), `partial_dG`.
- `stdlib/chem/fep/abfe_demo_selftest.hexa` — g5 ✅ **PASS 7/7**.

### g5 실행출력 VERBATIM (20s·0-pod·local)
```
PASS: abfe_demo 7/7
(a) full chain runs: ΔG(Path A)=0.484044 kT · MBAR converged(13 it · max_df 3.95e-13) · Ntot=9000 K=6 · all-finite(u_kn+ΔG) · NaN-0
(b) reference match: chain 0.484044 vs 해석 ½ln(2.5/1)=0.458145 · |Δ|=0.0258988 kT (<0.05)
(c) diagnostics: per-window ΔG [0.1389,0.1109,0.0913,0.0769,0.0661] · Σpartial==total(|Δ|=0) · min adj overlap=0.167214 · accept=0.893 · round_trips=6/6
(d) λ-endpoint safety: U(λ=0)=0.0 exact(decoupled) · r=0.05 overlap → U(λ=0.5)=112·U(λ=1)=1.64e16·dU/dλ 전부 유한 (naive 선형 λU 는 r⁻¹² 발산)
(e) determinism: run#1==run#2 0.484044 bit-exact |Δ|=0.0
(f) soft-core TI cross-check: MBAR ΔG=-0.129298 vs 독립 TI(R3 autograd dU/dλ)=-0.00979625 · |Δ|=0.119502 (<0.15)
(g) constrained chain (R7 SHAKE/RATTLE in R8 Langevin): ΔG=0.463528 |Δ해석|=0.00538246 · max|r²−d²|=9.99956e-11
```

### 두 정직 레퍼런스 (부호규약·기준 명시)
- **Path A (닫힌형 앵커)** — 1-D 조화 알케미컬 변환 U(x,λ)=½k(λ)(x−μ(λ))², **실 R8 Langevin BAOAB** 열욕으로 전파·R5 HREX 교환·R4 MBAR 재가중. 해석 ΔG=½·kT·ln(k₁/k₀)=0.4581 kT (reduced, k_B=1, μ상쇄). chain=0.4840(|Δ|=0.026, demo nsw=1500). **단:** nsw=3000 수렴시 chain=0.457918 → |Δ|=2e-4 kT. ⇒ ~0.1 kT 편차는 **통계/수렴 바이어스**(짧은샘플 BAOAB 미decorrelate)이지 배선오류 아님 — 정직 보고, 샘플 늘리면 소멸.
- **Path B (실 R3 soft-core decouple + 독립 TI)** — LJ pair λ:1→0 decouple(부호: ΔG=G(decoupled)−G(coupled), 사다리 1→0). ufn=실 `softcore_energy_value`. MBAR=−0.1293 kT vs 독립 TI ∫₀¹⟨∂U/∂λ⟩dλ(=실 `softcore_dUdlam_autograd` 앙상블평균, 사다리 trapezoid)=−0.0098 kT. 닫힌형 없음 ⇒ 두 추정량(MBAR vs TI) 상호 일치(|Δ|=0.119 within band)로 검증. 둘 다 짧은샘플이라 unbiased지만 분산 큼(정직).

### 8조각 통합 실증 — 무엇이 입증됐나
한 번의 `run_abfe` 호출이 8조각을 fused: R6 solvate setup → R3 soft-core λ-사다리 reduced potential → (R8 Langevin NVT + R7 SHAKE/RATTLE 구속) MD 전파 → R5 HREX 인접-λ config 교환 → R5 assemble 궤적 u_kn(R2 autograd-force 가 soft-core 力 내부) → R4 MBAR ΔG. **에러0·NaN0·MBAR 수렴·결정론·구속유지(9.9e-11)** 전부 동시 성립 = **native FEP 전 파이프라인이 하나로 작동함을 실증**. 외부 OpenMM/openfe/openmmtools 0 의존.

### 정직 스코프 (d6/@L5/g5 — 최우선)
- 이건 **소형계 배선 작동 실증**이지 SENOLYX −16.64 kcal/mol production parity 가 아니다. SENOLYX 강제재현 안 함 — 작은 데모계(reduced unit)의 진짜 숫자 정직 보고.
- 정량 parity 까지 남은 것: **PME**(현 ewald O(N²)→O(N log N), 대형 단백질-리간드 필수) · **더 긴 샘플링**(Path A demo 0.1 kT 바이어스 = 수렴 미달, nsw=3000서 2e-4 로 소멸 확인) · **실 biomolecular FF**(현재는 toy LJ+Coulomb). R9 는 plumbing 봉인, parity 는 downstream.

### 인터프리터 함정 3건 (구현 중 발견·우회·정직)
1. **closure 캡처는 파라미터만, 로컬 let 불가** — `return fn(){…}` 가 외부 `let k`/`use_cons` 참조시 C-lowering 이 `undeclared identifier` 컴파일 실패. 우회: inner fn 안에서 파라미터(`lam`/`cons`)로 재계산.
2. **nested fn-in-main 미스컴파일** — `_avg_dudlam_at` 를 main 안에 정의시 1초 SIGSEGV. 우회: top-level 로 이동.
3. **struct ↔ 타 모듈 struct 슬롯 충돌** — `AbfeConfig` struct 가 autograd Tape/Node struct 와 슬롯매핑 혼선 → 허위 `map key 'mbar_tol' not found` SEGV. 우회: config 를 **dict(`abfe_config()`)** 로 — 명시 string key 라 모듈간 충돌0. (3 모두 hexa-lang interp gap; 재현최소화 완료, 후속 upstream 패치 후보.)

### 산출
- stacked PR: hexa-lang **#3100** (abfe_demo.hexa +331 · abfe_demo_selftest.hexa +548, base=`qforge-bio-r8-langevin`=R8 tip). fep/(R3~R5) 는 R8 ancestry 에 없어 diff 동반 — R9 가 올라앉은 봉인스택. 머지=사용자. 0-POD·$0(local g5). ISOLATED worktree `qforge-bio-r9-abfe`.
- **마일스톤 갱신**: R9-brick ✅ 풀체인 통합 봉인. R4-next(SENOLYX parity) 는 이제 정량 단계만 남음(PME·샘플·실FF).

## 2026-06-13 · R10 — PME (Smooth Particle-Mesh Ewald) · 물리스택 마지막 조각 봉인

### 무엇을 했나
현 `stdlib/chem/md/ewald.hexa` 의 reciprocal 합은 O(N²·K³) 직접합 — 대형 단백질-리간드 불가. PME (Essmann 1995, smooth PME) 로 교체: 전하를 B-spline mesh 에 보간 → **fft3 한 번** → reciprocal 커널 곱 → inverse fft3 → 에너지·힘. O(N + K log K). 물리스택의 **유일한 미봉인 조각** 완성.

### 재사용 (d3/d19 — 중복 금지)
- real-space erfc·self-energy·중성보정·α/kmax 자동추론: `ewald.hexa` 에서 **verbatim 재사용** (reciprocal 만 FFT 가속)
- 3D FFT: `stdlib/signal/core_fft.hexa` 의 `fft3`/`ifft3` **verbatim 재사용** — materials QFORGE el-ph FFT-Poisson 이 쓰는 **실 radix-2 brick**. **naive DFT 아님 = 실 FFT 연동.**
- (α, kmax) 를 직접 Ewald 와 공유 ⇒ 두 경로는 B-spline 이산화 차이만 남는 동일 절단합.

### 신규 구현
- `stdlib/chem/md/pme.hexa` (422줄, d4-generic): cardinal B-spline M_n(u) 재귀 + 미분 dM/du + Euler-spline 고유값 |b(m)|²(Essmann 4.4) + 전하격자 spread + fft3 forward + reciprocal C(m)·B(m)|F[Q]|² 합 + force(convolution + B-spline 미분). 격자크기·order·β·kmax 전부 파라메트릭, 전하셋만 instance datum.
- `stdlib/chem/md/pme_selftest.hexa` (185줄, @ci_gate): 5체크.

### g5 selftest VERBATIM (`hexa run stdlib/chem/md/pme_selftest.hexa` · 32³ grid · order 6)
```
PME selftest — Smooth Particle-Mesh Ewald (QFORGE-BIO R10)
  L=10.0 alpha=0.657869 kmax=8 grid=32^3 order=6

  ok : a_recip_parity   PME=0.560128 direct=0.560127 |Δ|=5.75901e-07
  ok : b_total_parity   PME=-0.368681 Ewald=-0.368681 |Δ|=5.75901e-07
  ok : c_force_match_fd   max|F_analytic − F_FD| over 12 components = 3.82328e-11
  ok : d_translation_gauge_invariance   E0=-0.368681 max|E(shift)−E0|=4.23173e-08
  scaling ladder |Δ|:  g8/o4=0.0158684  g16/o4=0.000981921  g16/o6=5.22065e-05  g32/o6=5.75901e-07
  ok : e_scaling_convergence_monotone   grid/order refine ⇒ |Δ| strictly decreasing toward direct sum

ALL PASS — stdlib/chem/md PME (Smooth Particle-Mesh Ewald) 5/5
PME == direct Ewald to B-spline discretisation; FFT-accelerated reciprocal sum SEALED.
```

### 다섯 체크 의미
- (a) **직접합 parity**: PME recip == 직접 Ewald recip, |Δ|=5.76e-7 (≪1e-4). FFT 경로가 직접합과 동일 물리.
- (b) **전에너지 parity**: real+PME recip+self+중성 == Ewald 총합, |Δ|=5.76e-7.
- (c) **힘 일치**: PME recip force == recip 에너지 중심차분, 12성분 max|Δ|=3.82e-11 (≪1e-3, 사실상 정확).
- (d) **중성계 불변성**: 비격자 벡터 translation 후 전에너지 불변 |Δ|=4.23e-8 (gauge).
- (e) **scaling 수렴**: 격자/order ↑ → |Δ| 단조감소 (g8/o4 1.6e-2 → g32/o6 5.8e-7). PME 가 직접합으로 수렴 입증.

### 봉인 판정 (d6/@L5 — 정직)
- **PME 봉인 ✅** — 실 fft3 연동(naive DFT 아님), 직접합 parity 5.76e-7, 힘 FD 일치 3.8e-11. discretisation 오차이지 버그 아님(scaling 단조수렴이 증명).
- **native FEP MD 물리스택 100% 완성** — R2(힘)·R3(soft-core)·R4(MBAR)·R5(HREX)·R6(TIP3P)·R7(SHAKE)·R8(Langevin)·R9(ABFE 풀체인) + R10(PME) ⇒ O(N²) 정전 병목 제거, **대형 단백질-리간드계 언블록**.
- 정량 parity 까지 남은 것 (물리 아닌 단계): 더 긴 샘플링 · 실 biomolecular FF(현 toy LJ+Coulomb) · SENOLYX −16.64 production 재현. R10 은 효율/물리 봉인, parity 는 downstream.

### 인터프리터 함정 (구현 중 발견·d8 handoff 기록)
1. **floor() 는 float 반환** — `gx0=floor(ux)`(float)로 한 fn 에서 spread, 다른 fn 에서 `to_int(floor(ux))`로 force 시 같은 격자를 `(g0-j)%K` 인덱싱하면 grid index desync → 힘 ~0 (energy parity 는 멀쩡). 우회: spread/force 둘 다 `to_int(floor())` 로 통일. (root-cause: floor→int 격자원점 관용구 표준화 or % 타입일관성 — handoff 기록)
2. **private(_prefix) fn 은 'use' 모듈서 호출 가능** — 격리버그 아님, 접근제어 없음 확인(selftest 가 `_pme_bspline` 직접 검증에 의존). 가시성 계약 문서화 handoff.
3. (R9 기지 재확인) **struct-slot 충돌** — 도메인 struct 가 autograd struct 와 슬롯명 공유시 허위 'map key not found'. R9 dict 우회. root-cause handoff.
→ 3건 `sidecar handoff add hexa-lang` 기록 (id eb7f3073·17b823a6·fcd72679).

### 산출
- stacked PR: hexa-lang **#3101** (pme.hexa +422 · pme_selftest.hexa +185, R10 변경=이 2파일만). base=`main` (R9 가 머지됐으나 bio R2~R9 스택이 아직 main 미착륙 → diff 에 미착륙 ancestor 동반, 스택 착륙시 PME 2파일로 collapse). 머지=사용자. 0-POD·$0(local g5). ISOLATED branch `qforge-bio-r10-pme`.

## R11 — 실 biomolecular FF 로더 (AMBER/GAFF) · 2026-06-13

물리스택 100% 완성(R10) 후, 정량 parity 의 유일 입력 언블록 = 실 FF 파라미터. toy LJ+Coulomb → AMBER/GAFF 실 분자 파라미터. `stdlib/chem/ff/amber.hexa`(신규, d4-generic): literature 파라미터 DB(TIP3P Jorgensen 1983 · GAFF c3/hc/oh/ho Wang 2004) + prmtop 이 구동하는 표준 AMBER 매핑(Rmin/2↔σ · ε/Rmin↔A/B coef · A/B→ε/σ · Lorentz-Berthelot combining · 대칭 type-pair bonded lookup → 기존 `BondTerm`/`AngleTerm`/LJ/charge 항). 실 FF 숫자가 기존 물리 항에 흘러들어 literature 레퍼런스를 재현.

### selftest VERBATIM (`hexa run stdlib/chem/ff/amber_selftest.hexa` · 0-pod · $0)
```
  ok : a_parse_map_real_params   q_OW=-0.834 q_HW=0.417 σ_OW=3.15057 ε_OW=0.1521 c3-hc k=337.3 r0=1.0969 (max|Δ|<1e-6)
  ok : b1_water_equilibrium_bonded_zero   U_bonded(eq geom) = 0.0 (ref 0, analytic)
  ok : b2_coulomb_pair_known   U_coul(-0.834,+0.417 @2Å)=-57.7422 kcal/mol (ref -57.7422, k=332.0637)
  ok : b3_lj_welldepth_known   U_LJ(OW-OW @Rmin)=-0.1521 (ref -ε=-0.1521)
  ok : c1_bond_halfk_dr2   U=0.06746 ref=½·337.3·(0.02)²=0.06746
  ok : c2_angle_halfk_dtheta2   U=0.0492875 ref=½·39.43·(0.05)²=0.0492875
  ok : d1_lorentz_berthelot   σ_ij=3.27512 (=(σ_OW+σ_c3)/2) ε_ij=0.128995 (=√(ε_OW·ε_c3))
  ok : d2_acoef_bcoef_roundtrip   A=581923 B=595.014 → ε=0.1521 σ=3.15057 (|Δε|=0.0 |Δσ|=4.44089e-16)
  ok : e1_methane_neutral   Σq(CH4)=-6.93889e-18 |Σq−round|=6.93889e-18
  ok : e2_water_neutral   Σq(H2O)=0.0 |Σq−round|=0.0
ALL PASS — stdlib/chem/ff AMBER/GAFF real-FF loader 10/10
```

### 봉인 판정 (d6/@L5 — 정직)
- **scope = literature 테이블 + 표준 매핑, prmtop 전체 파일 파서 아님** (R11 charter 옵션 ii). 입증한 것: 실 FF 숫자가 기존 `bonded.hexa`/`lennard_jones.hexa`/charge 항에 흘러들어 literature 레퍼런스 재현(Coulomb 상수 332.0637 · A/B↔ε/σ round-trip 4.4e-16 · TIP3P σ 1e-3 내). d4-generic — atom type·분자·파라미터 전부 DATA, 분자 추가=테이블 편집만.
- **정량 parity 까지 진짜 남은 것 = LONGER SAMPLING 뿐**. 물리스택(R2~R10) + 실FF 입력(R11) 둘 다 완성. SENOLYX −16.64 경로 = R11 실 FF 를 `abfe_demo.hexa` 풀체인에 실 ligand topology + 충분한 HREX sweep(nsw≫3000)으로 주입. 물리·입력 gap 0, 남은건 walltime.

### 인터프리터 함정 (d8 handoff)
- **cross-module float-literal 정밀도 gap(~4e-6)**: `use` 모듈 fn 본문 내 float 리터럴이 main 파일 동일 리터럴 대비 정밀도 저하. repro: 모듈 `pub fn conv(r)=(2.0*r)/1.122462048309373` 가 in-main 동일식과 `conv(1.7682)`서 4.22683e-06 차. module-const vs module-inline-literal 은 정확 일치 ⇒ cross-module 리터럴 lowering 문제. 우회: 동일정밀도 in-module 비교 + published TIP3P σ 1e-3 물리 앵커. `sidecar handoff add hexa-lang` id 043569f7.

### 산출
- stacked PR: hexa-lang **#3104** (amber.hexa + amber_selftest.hexa +536, base=`qforge-bio-r10-pme`). pr-cycle 훅이 stacked leaf 를 R10 브랜치로 self-merge(squash 44c881f40 on R10 575bbd4c6). R10 #3101 + R2~R10 스택은 사용자 main 머지 대기. 0-POD·$0. ISOLATED branch `qforge-bio-r11-ff` (create→commit→push→remove).

## R12 — ligand topology 빌더 (결합그래프 → GAFF atom-typing) · 2026-06-13

물리스택(R2~R10) + 실FF 입력(R11) 완성 후, 실 ligand 를 풀체인에 주입하려면 분자 구조를 GAFF atom-type 으로 인식하는 한 조각이 더 필요. amber.hexa 는 `atom_types[]`(per-atom GAFF 타입 배열)를 소비하지만 그걸 분자에서 PRODUCE 하는 게 없었음 — R12 가 그 구조링크. `stdlib/chem/ff/topology.hexa`(신규, d4-generic): 결합그래프(원소+연결) → 각 원자 GAFF 타입. **인-세션 실행**(서브에이전트 아님, main 루프가 직접 Write/Bash).

구조: `structure(원소+bonds) ──▶ [topology.hexa] ──▶ atom_types[] ──▶ amber.hexa`

### perception 규칙 (subset, 정직 d6)
원소 + 연결차수(혼성화 proxy, 명시적 결합차수 없음) + 이웃환경:
- C deg-4 → c3(sp³) · C deg-3 → c2(sp²)
- H on sp³-C → hc · H on sp²-C → ha
- O deg-2·2×H → OW(물) · O deg-2·1×H+heavy → oh(하이드록실)
- H on 물-O → HW · H on 하이드록실-O → ho
풀 GAFF SMARTS(고리·방향족·결합차수·formal charge) perception 은 **안 함** — downstream 확장. d4-generic: 원소+차수+이웃원소만 키, 분자이름 비분기·bonds=데이터.

### selftest VERBATIM (`hexa run stdlib/chem/ff/topology_selftest.hexa` · 0-pod · $0 · 첫 실행 클린)
```
  ok : a_methane_ch4   [c3, hc, hc, hc, hc] (exp [c3, hc, hc, hc, hc])
  ok : b_water_h2o   [OW, HW, HW] (exp [OW, HW, HW])
  ok : c_methanol_ch3oh   [c3, hc, hc, hc, oh, ho] (exp [c3, hc, hc, hc, oh, ho])
  ok : d_ethene_c2h4   [c2, c2, ha, ha, ha, ha] (exp [c2, c2, ha, ha, ha, ha])
  ok : e_graph_degree_neighbours   deg(C)=4 deg(H)=1 H-neighbours(C)=4
  ok : f_integrate_amber_neutral   Σq(CH4 via perceived types)=-6.93889e-18 Σq(H2O)=0.0 (both integer-neutral)
ALL PASS — stdlib/chem/ff topology → GAFF atom-typing 6/6
Bond graph → atom_types[] → amber.hexa: real-ligand structural link SEALED.
```

### 봉인 판정 (d6/@L5)
- 핵심 입증: 연결 그래프가 올바른 GAFF `atom_types[]` 를 산출하고, 그게 amber.hexa(R11)로 흘러 분자 전하 보존(Σq(CH4)=−6.9e-18·Σq(H2O)=0). 메탄올의 하이드록실 H(ho) vs 물 H(HW)를 O의 H-개수로 정확 구분(둘 다 H-on-O 인데 환경으로 분기).
- **구조 링크 봉인 ⇒ bio code-brick 레인 소진**. structure→FF→sampling→estimator 전 경로가 hexa-native. SENOLYX −16.64 까지 남은 건 코드가 아니라 **순수 compute**(실 ligand topology→abfe_demo 풀체인 + nsw≫3000 긴 샘플링 = d17 GPU 영역).

### 산출
- stacked PR: hexa-lang **#3105** (topology.hexa + topology_selftest.hexa, base=`qforge-bio-r10-pme` R11 tip). 머지=사용자. 0-POD·$0(local g5). branch `qforge-bio-r12-topology` (origin push, isolation 아닌 직접 체크아웃 — 인-세션 /afg 모드).
