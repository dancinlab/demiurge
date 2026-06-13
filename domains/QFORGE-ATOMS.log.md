# QFORGE-ATOMS — append-only round log

Reconstructed (2026-06-13) from the verified hexa-lang commit ladder on branch `qforge-atoms-r29`
(rounds r1-r29, each g5-gated, PySCF/Crawford-anchored). Implementation home (d3):
`hexa-lang stdlib/qforge/atoms/`. This is the durable demiurge record of the per-round milestones.

---

## round-1/2 — EEQ partial charge + analytic ∂q/∂R (hexa-lang #3119)
EEQ (electronegativity-equilibration) atomic partial charges + analytic charge gradient ∂q/∂R.
(E) anchor uses exact closed form + monotone decay. `eeq.hexa` · `eeq_grad.hexa`. g5 selftest.

## round-3 — coordination number CN(R) (hexa-lang #3124)
CN(R) + analytic ∂CN/∂R + χ dressing. `coordination.hexa`. g5.

## round-4 — DFT-D4 dispersion (hexa-lang #3129)
charge×CN-scaled C₆ + BJ damping + ATM 3-body + analytic ∂E/∂R. `d4_disp.hexa`. g5 selftest.

## round-5 — EHT-SCC Hamiltonian + periodic torsion (hexa-lang #3131)
GFN-xTB skeleton complete. `eht_scc.hexa` · `torsion.hexa`. g5 selftest.

## round-6 — SCC self-consistency driver (hexa-lang #3136)
fixed-point loop wires R5 kernels. `scc_scf.hexa`.

## round-7 — Löwdin S^{−½} + Blondel-Karplus dihedral Jacobian (hexa-lang #3147)
`lowdin.hexa` · `torsion_grad.hexa`. g5.

## round-8 — Harris-Foulkes / Mermin variational functional (hexa-lang #3151)
dE/dδq=0 stationarity — r6/r7 gap CLOSED. `harris_foulkes.hexa`. g5.

## round-9 — analytic nuclear force F=−∂E_HF/∂R (hexa-lang #3160)
Hellmann-Feynman + Pulay overlap-derivative. `forces.hexa`. g5 selftest.

## round-10 — real STO-3G overlap + analytic dS/dR force (hexa-lang #3162)
consumes MOLSCF gaussian_integrals S (d19). `real_overlap.hexa`.

## round-11 — true Roothaan RHF force (hexa-lang #3168)
consume MOLSCF ERI+V, semi-empirical → ab-initio. `rhf_force.hexa`.

## round-12 — fully-analytic RHF force (hexa-lang #3171)
closed-form ∂T/∂V/∂ERI/∂R (MD/Obara-Saika), last FD removed. `integral_grads.hexa`.

## round-13 — p/d shell RHF force (hexa-lang #3174)
real first-row (H₂O) ab-initio energy+force via MOLSCF md_shell. `rhf_force_pd.hexa`.

## round-14 — d-basis RHF force (hexa-lang #3178)
d-bearing molecule analytic force == FD, s/p/d sealed (L-general). `rhf_force_gen.hexa` · `shell_grads.hexa`.

## round-15 — geometry optimization (hexa-lang #3182)
BFGS/line-search on analytic gradient → H₂ R*=1.346 bohr, H₂O → RHF equilibrium. `geom_opt.hexa`.

## round-16 — MP2 correlation energy (hexa-lang #3185)
post-HF electron correlation on the converged RHF (RMP2). `mp2.hexa`. Crawford-anchored.

## round-17 — CCSD (hexa-lang #3191)
coupled-cluster singles & doubles on the MP2 MO-ERI tensor (RCCSD). `ccsd.hexa`. Crawford ≤1e-9.

## round-18 — CCSD(T) (hexa-lang #3194)
perturbative connected-triples gold standard on converged CCSD amplitudes. `ccsd_t.hexa`. Crawford-anchored.

## round-19 — cc-pVDZ basis (hexa-lang #3198, #3203)
full HF→MP2→CCSD→CCSD(T) ladder on a non-minimal basis. CI-tractable gate + ref-literal fold fix (GREEN).

## round-20 — CC tensor-contraction acceleration (hexa-lang #3208)
AO→MO 4-index transform routed through stdlib/flame native matmul (13×). `cc_accel.hexa`. (d19 flame)

## round-21 — spatial-orbital closed-shell CCSD (hexa-lang #3213)
16× tensor reduction + flame routing — cc-pVDZ CCSD live 18.6s (41× overall). `ccsd_rhf.hexa`.

## round-22 — spatial-orbital (T) (hexa-lang #3216)
cc-pVDZ CCSD(T) gold-standard fully live 24s. `ccsd_t_rhf.hexa`.

## round-23 — cc-pVTZ + 2-point X⁻³ CBS extrapolation (hexa-lang #3223, #3226)
toward the complete-basis limit: CCSD(T)/CBS −0.3339. HONESTY FIX (#3226, d6): f-shell overlap
witness replaces a non-converged live SCF claim — cc-pVTZ CCSD(T) live timing is AOT-perf bound,
correctness anchored, live walltime is a flame-matmul AOT frontier (NOT a method gap).

## round-24 — DIIS-accelerated RHF SCF (hexa-lang #3228)
cc-pVTZ live convergence in 14 iters (MOLSCF DIIS reuse, d19). `rhf_diis.hexa`.

## round-25 — open-shell UMP2 (hexa-lang #3232)
unrestricted MP2 on UHF reference (radicals/triplets, CH₃). `ump2.hexa`.

## round-26 — open-shell UCCSD (hexa-lang #3234)
unrestricted CCSD on UHF reference (radical gold standard). `uccsd.hexa`.

## round-27 — open-shell UCCSD(T) (hexa-lang #3235)
open-shell gold standard complete. `uccsd_t.hexa`.

## round-28 — ROHF-CCSD(T) (hexa-lang #3237)
spin-pure-reference open-shell gold standard (MOLSCF ROHF reuse, ⟨S²⟩=0.75 exact).
`rohf_ccsd_t.hexa` · `rohf_mp2.hexa`.

## round-29 — open-shell CBS extrapolation
both-shell basis-set-limit complete (atoms natural completion). Single-reference method lattice
COMPLETE: both shells, gold-standard, CBS.

---

## method-completeness depletion (round-29)

atoms scale single-reference wavefunction lattice is METHOD-COMPLETE: GFN-xTB semi-empirical →
genuine Roothaan ab-initio HF → fully-analytic force (s/p/d, L-general) → geometry opt →
RMP2/RCCSD/RCCSD(T) → cc-pVDZ/cc-pVTZ/CBS → open-shell (UHF/UMP2/UCCSD/UCCSD(T)) → spin-pure
ROHF-CCSD(T) → open-shell CBS. All method-CLASSES sealed, PySCF/Crawford-anchored. The two named
residuals are within-class refinements, NOT method gaps (d6 honest): (1) cc-pVTZ CCSD(T) live
walltime is AOT-perf bound (correctness anchored; live timing = flame-matmul AOT frontier);
(2) correlated-level analytic gradients/geometry opt (autograd-through-CC). Multireference
correlation (static CASCI/CASSCF + dynamic NEVPT2) is the MOLSCF scale's responsibility — atoms
delivers the single-reference gold standard.
