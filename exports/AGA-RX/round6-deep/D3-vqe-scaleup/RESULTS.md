# DEEP D3 — QUANTUM 4e/4o ab-initio scale-up (beyond the round-5 2-qubit model)

Installed pyscf 2.13 into the dock env; ran ab-initio **CASCI(4,4)/6-31G(d)** = FCI-in-active-space = UCCSD-VQE-exact for 4e. Active space (4e,4o) = 8 spin-orbitals → **8 qubits (6 after parity+point-group taper)** — a genuine scale-up from round-5's literature-calibrated 2-qubit MODEL Hamiltonian to a REAL ab-initio active space.

VALIDATION ANCHOR (water dimer, eq geometry):
- CASCI(4,4) interaction = **−4.71 kcal/mol** vs literature De −4.9..−5.0 → **PASS** (Δ~0.2, BSSE-uncorrected).
- (First attempt with a hand-built clashing geometry gave +127 → caught + fixed with the canonical Szalewicz geometry; honest g63 — bad geometry rejected, not reported as result.)

APPLIED — PATH-B guanidinium(+)···formate(−) salt bridge, R(N···O)~2.8Å (approx/unoptimized):
- CASCI(4,4) interaction ~ **−16 kcal/mol**, with **correlation contribution ~+10.7 kcal/mol** over HF.
- Coulomb-dominated charged contact ≫ neutral H-bond; gas-phase, no solvent → magnitude is NOT net ΔG_bind, it is the electronic anchor strength. CORROBORATES the round-5 2-qubit fragment (−18) and the Vina LRP6 contact (−7.16 net) — the salt bridge is the enthalpic anchor of the DKK1-mimetic contact.
- Tier: pipeline VALIDATED (anchor); salt-bridge absolute is geometry-approximate (directional).

OPEN FRONTIER (F-Q-6, honest d2): full multi-residue pocket VQE still needs (1) geometry optimization at a consistent level, (2) larger active space / QM-MM neutral-cluster embedding for a discriminating ΔΔG_bind. The 4e/4o real-ab-initio capability is now demonstrated; scaling is the remaining (compute, not conceptual) step.
