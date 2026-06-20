# CaB3C3 — RTSC Pm-3n boron-carbon clathrate runbook (BUILD output)

> Boron-carbon SODALITE clathrate, cubic Pm-3n (SG #223), 14-atom cell
>   (2 Ca + 6 B + 6 C). MgB2-like sigma-bonded covalent SC — NO hydrogen.
> Reference: Zhu/Strobel et al. arXiv:1708.03483 (CaB3C3, lambda~0.9-1.0,
>   Tc~27-43 K predicted; synthesized ~50 GPa, RECOVERABLE toward ambient).
> PRESSURE: 0 GPa (default AMBIENT 1 atm — the campaign ambient-stability gate).
>
> AMBIENT-STABILITY GATE (PRIMARY · per the Mg2IrH6 lesson — VEC sweet-spot != lattice
>   stability): DFPT phonon -> NO imaginary modes (omega^2 < 0) = ambient dynamically
>   stable. Soft modes @ 1 atm -> note min stabilizing pressure (d_defer, NOT discard).
>   el-ph -> lambda, omega_log -> Tc ONLY for the dynamically-stable ones. NO Tc pre-DFT.
>
> ibrav=1 + celldm(1) start 8.957 Bohr (~4.74 Ang); vc-relax finds equilibrium.
> nosym=.true. — ordered B/C decoration lowers symmetry below the Pm-3n parent.
> Pseudos auto-fetched (PSL 1.0.0): Ca · B.pbe-n · C.pbe-n. La = spfn (d13 f-states).

Chain: vc-relax -> scf (12^3 k) -> ph (el-ph simple, 2^3 q). recover=.true.
