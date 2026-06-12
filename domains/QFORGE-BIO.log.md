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
