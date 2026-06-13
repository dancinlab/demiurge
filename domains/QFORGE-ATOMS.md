@title: ⚛️ QFORGE-ATOMS — molecular wavefunction methods ("원자/분자 gold-standard")

@goal: QFORGE 범용 엔진의 **atoms scale** front-end 완성 — GFN-xTB 반경험 stack 에서
출발해 진짜 Roothaan ab-initio HF → 해석 force → geometry opt → post-HF correlation ladder
(MP2/CCSD/CCSD(T)) → complete-basis-set (CBS) 외삽 → open-shell (UHF/ROHF) gold standard
까지, atom-centered Gaussian 분자/원자/클러스터의 단일참조 method 격자를 g5 검증으로 닫는다.
모든 적분/SCF brick 은 MOLSCF 공통코어를 재사용(d19)하고, CC tensor contraction 은
`stdlib/flame` matmul 로 라우팅한다. PySCF / Crawford-projects 앵커.

## method

atoms scale 은 MOLSCF 가 개통한 atom-centered Gaussian SCF 위에 올라간다 (d19). 두 갈래:
(1) **반경험 GFN-xTB** stack — EEQ 전하 → D4 분산 → EHT-SCC → Löwdin → Harris-Foulkes 변분
functional + 해석 force (빠른 screening 격자); (2) **진짜 ab-initio** — MOLSCF 의 `gaussian_integrals`
S, `coulomb_integrals` ERI+V, `rhf_scf`/`md_shell`/`uhf`/`rohf` brick 을 소비해 Roothaan RHF →
완전해석 force (HF + Pulay ∂S 항) → BFGS geometry opt → AO→MO 4-index 변환 위의 post-HF
correlation ladder (RMP2 → RCCSD → RCCSD(T)) → cc-pVDZ/cc-pVTZ + 2-점 X⁻³ CBS 외삽 →
open-shell (UHF→UMP2→UCCSD→UCCSD(T), spin-pure ROHF-CCSD(T)). CC tensor contraction 은
`stdlib/flame` native matmul 로 라우팅 (d19). 모든 correlation 앵커 = Crawford-projects
참조값 (≤1e-9), HF/CBS 앵커 = PySCF 2.13.1.

## milestones

### GFN-xTB 반경험 stack (round 1-8)
- [x] round-1/2 — EEQ partial charge + 해석 ∂q/∂R gradient (g5 selftest · 닫힌형 monotone-decay 앵커)
      `eeq.hexa` · `eeq_grad.hexa`
- [x] round-3 — coordination number CN(R) + 해석 ∂CN/∂R + χ dressing (g5) `coordination.hexa`
- [x] round-4 — DFT-D4 dispersion: charge×CN-scaled C₆ + BJ damping + ATM 3-body + 해석 ∂E/∂R (g5)
      `d4_disp.hexa`
- [x] round-5 — EHT-SCC Hamiltonian + periodic torsion (GFN-xTB skeleton 완성) (g5) `eht_scc.hexa` · `torsion.hexa`
- [x] round-6 — SCC self-consistency driver: fixed-point loop 가 R5 kernel 을 배선 `scc_scf.hexa`
- [x] round-7 — Löwdin S^{−½} orthogonalization + Blondel-Karplus dihedral Jacobian (g5) `lowdin.hexa` · `torsion_grad.hexa`
- [x] round-8 — Harris-Foulkes / Mermin 변분 functional: dE/dδq=0 stationarity (r6/r7 gap CLOSED, g5)
      `harris_foulkes.hexa`

### 진짜 Roothaan ab-initio HF + 해석 force (round 9-15)
- [x] round-9 — 해석 nuclear force F=−∂E_HF/∂R: Hellmann-Feynman + Pulay overlap-derivative (g5 selftest)
      `forces.hexa`
- [x] round-10 — real STO-3G overlap (MOLSCF S 소비) + 해석 ∂S/∂R force path `real_overlap.hexa`
- [x] round-11 — true Roothaan RHF force: MOLSCF ERI+V 소비, 반경험→ab-initio 전환 `rhf_force.hexa`
- [x] round-12 — 완전해석 RHF force: 닫힌형 ∂T/∂V/∂ERI/∂R (MD/Obara-Saika), 마지막 FD 제거 `integral_grads.hexa`
- [x] round-13 — p/d-shell RHF force: 실 first-row (H₂O) ab-initio 에너지+force via MOLSCF `md_shell` `rhf_force_pd.hexa`
- [x] round-14 — d-basis RHF force: d-bearing 분자 해석 force == FD, s/p/d 봉인 (L-general) `rhf_force_gen.hexa` · `shell_grads.hexa`
- [x] round-15 — geometry optimization: BFGS/line-search on 해석 gradient → H₂ R*=1.346 bohr, H₂O equilibrium
      `geom_opt.hexa`

### post-HF correlation ladder (round 16-23, Crawford-anchored)
- [x] round-16 — RMP2 correlation energy: 수렴 RHF 위의 post-HF 전자상관 `mp2.hexa`
- [x] round-17 — RCCSD: coupled-cluster singles & doubles on the MP2 MO-ERI tensor `ccsd.hexa`
- [x] round-18 — RCCSD(T): perturbative connected-triples gold standard on 수렴 CCSD amplitudes `ccsd_t.hexa`
- [x] round-19 — cc-pVDZ basis: full HF→MP2→CCSD→CCSD(T) ladder on a non-minimal basis (CI-tractable gate, GREEN)
- [x] round-20 — CC tensor-contraction 가속: AO→MO 4-index 변환을 `stdlib/flame` native matmul 로 라우팅 (13×) `cc_accel.hexa`
- [x] round-21 — spatial-orbital closed-shell CCSD: 16× tensor reduction + flame routing, cc-pVDZ CCSD live 18.6s (41×) `ccsd_rhf.hexa`
- [x] round-22 — spatial-orbital (T): cc-pVDZ CCSD(T) gold-standard fully live 24s `ccsd_t_rhf.hexa`
- [x] round-23 — cc-pVTZ + 2-point X⁻³ CBS extrapolation: CCSD(T)/CBS −0.3339 (toward complete-basis limit)

### DIIS + open-shell gold standard (round 24-29)
- [x] round-24 — DIIS-accelerated RHF SCF (MOLSCF DIIS 재사용): cc-pVTZ RHF 14-iter live convergence `rhf_diis.hexa`
- [x] round-25 — open-shell UMP2: unrestricted MP2 on UHF reference (radicals/triplets, CH₃) `ump2.hexa`
- [x] round-26 — open-shell UCCSD: unrestricted CCSD on UHF reference (radical gold standard) `uccsd.hexa`
- [x] round-27 — open-shell UCCSD(T): open-shell gold standard 완성 `uccsd_t.hexa`
- [x] round-28 — ROHF-CCSD(T): spin-pure-reference open-shell gold standard (MOLSCF ROHF 재사용, ⟨S²⟩=0.75 exact)
      `rohf_ccsd_t.hexa` · `rohf_mp2.hexa`
- [x] round-29 — open-shell CBS extrapolation: both-shell basis-set-limit 완성 (atoms natural completion)

### named refinement frontier (within-class — NO method-class gap)
- [ ] cc-pVTZ CCSD(T) live timing — AOT-perf bound (현재 cc-pVDZ live; cc-pVTZ correctness anchored,
      live walltime 은 flame matmul AOT 가속 frontier, NOT a method gap) (d6 honest)
- [ ] analytic CC gradients / geometry opt at correlated level (현재 RHF-level geom opt; correlated
      force = autograd-through-CC frontier)

## reuse (d19) — atoms ↔ MOLSCF / flame

| atoms 소비 brick          | 재사용 코어 (rebuild 안 함)                                   |
|---------------------------|--------------------------------------------------------------|
| overlap S                 | MOLSCF `gaussian_integrals` (real-STO S, round-10)           |
| ERI + V                   | MOLSCF `coulomb_integrals` (round-11 true Roothaan force)    |
| RHF SCF                   | MOLSCF `rhf_scf` (Löwdin S^{−½} + eigh)                      |
| d-orbital integrals       | MOLSCF `md_shell` (p/d/f McMurchie-Davidson, round-13/14)    |
| open-shell SCF + DIIS     | MOLSCF `uhf` (round-24 DIIS, round-25/26/27 UHF reference)   |
| spin-pure reference       | MOLSCF `rohf` (round-28 ROHF-CCSD(T) ⟨S²⟩ exact)            |
| CC tensor contractions    | `stdlib/flame` native matmul (round-20/21/22, 13-41× accel)  |

NEXUS edge: `QFORGE/atoms reuses qforge/molscf/{gaussian_integrals,coulomb_integrals,rhf,md_shell,uhf,rohf}
+ stdlib/flame matmul`. 이 cross-lane 재사용 edge = "one engine, six scales" thesis 의 핵심.

## honest scope (d6 / @L5)

atoms scale = single-reference method 격자가 COMPLETE (both shells, gold-standard, CBS). 모든 correlation
앵커는 Crawford-projects 참조값(≤1e-9), HF/CBS 는 PySCF 2.13.1. 남은 frontier 는 method-class 가 아닌
within-class refinement: (1) cc-pVTZ CCSD(T) live walltime (AOT-perf bound — correctness 는 anchored,
live timing 은 flame matmul AOT 가속 frontier); (2) correlated-level analytic gradients/geom opt
(autograd-through-CC). multireference (static/dynamic correlation) 는 MOLSCF scale 의 CASCI/CASSCF/NEVPT2
가 담당 — atoms 는 single-reference gold standard 가 deliverable.

## depletion judgment

atoms 스케일의 단일참조 wavefunction 격자는 METHOD-COMPLETE: GFN-xTB 반경험 → 진짜 Roothaan ab-initio HF
→ 완전해석 force (s/p/d, L-general) → geometry opt → RMP2/RCCSD/RCCSD(T) → cc-pVDZ/cc-pVTZ/CBS →
open-shell (UHF/UMP2/UCCSD/UCCSD(T)) → spin-pure ROHF-CCSD(T) → open-shell CBS. 모든 method-CLASS 봉인.
남은 것은 AOT-perf (cc-pVTZ live timing) 과 correlated-gradient 의 두 within-class refinement 뿐.
