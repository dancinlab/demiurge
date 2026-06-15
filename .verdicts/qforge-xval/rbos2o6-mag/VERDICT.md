# QFORGE-LSDA magnetism cross-val — RbOs2O6 / CsOs2O6 (2026-06-15) — ⏸ HONEST-SKIP (compute-wall)

**Deliverable #2** of the 2026-06-15 QFORGE cross-val (plan `drafts/qforge-update-plan.md` @L2a).
Goal: does the canonical hexa-native QFORGE-LSDA (nspin=2 spin-DFT) engine reproduce the QE
magnetic moments of the RTSC β-pyrochlore osmates with the same SIGN and ORDER of magnitude?

## QE reference (this session, `domains/rtsc.log.md` 2026-06-15)

| material  | QE moment (PBE, nspin=2 / SOC / rattling)                         |
|-----------|-------------------------------------------------------------------|
| RbOs2O6   | SOC (noncolin+lspinorb) ~3-4 μB · rattling ~2 μB · ideal nspin=2 ~5 μB — **PBE robust magnetic** (SOC does NOT quench) |
| CsOs2O6   | ~0.59 μB initial → ~1.8 μB (converging)                           |

Experiment: both are non-magnetic ambient SC (Tc 6.3 / 3.3 K) → the PBE moment is the known
flat-band-near-Stoner over-magnetization. The cross-val target was sign+order, not the exact μB.

## QFORGE-LSDA engine status — brick g5 PASS (engine works)

All spin-DFT bricks pass g5 verbatim on mini (`/Users/mini/.hx/bin/hexa run`):

```
qforge_scf_spin_selftest        PASS
qforge_scf_pw_spin_selftest     PASS   (V_xc^↑<V_xc^↓ for ρ↑>ρ↓ · spin Hartree · E_F bisection)
qforge_smearing_spin_selftest   PASS
qforge_xc_spin_selftest         PASS
qforge_pbe_spin_selftest        PASS   (spin-GGA |∇ρ| enhancement live; ζ=0 ≡ unpolarized)
```

The nspin=2 spin-LDA/PW92 + spin-GGA PBE V_xc, spin-bisection E_F, and magnetization machinery are
built and verified (same engine the CoSn kagome track built, hexa-lang `qforge-lsda-spin` stack).

## why the FULL real-cell moment SCF is skipped (d6/c9 — compute-wall, NOT physics)

Computing the actual RbOs2O6 self-consistent moment requires a converged spin-polarized PW SCF on:
- **9 atoms** (Rb + 2 Os + 6 O), **ecutwfc=70 / ecutrho=560 Ry**, **~77 valence e⁻**
  (Rb z=9 + 2·Os z=16 + 6·O z=6), with **Os-5d** states needing a high PW cutoff.
  (cell: `exports/rtsc/decks/anima_rbos2o6/scf.in`, celldm(1)=19.1845.)

This is strictly HEAVIER than the documented CoSn Co-3d PW compute wall
(`memory/qforge-cosn-co3d-pw-compute-wall.md`), which already failed:
- CoSn = 6 atoms, 93 val e⁻, Co-3d needs npw≥120 → ~580 s/iter in interpreted-tier hexa davidson
  on mini; only npw≈80 (ecut~4 Ry) is tractable, and at that basis the d-shell is grossly
  under-resolved → spurious **m≈0** (NOT QE's 0.43 — basis wall, not refutation).
- npw≥120 / npw≥300 → INTRACTABLE (timed out, davidson inner-convergence degrades super-quadratically).

Os-5d on a 9-atom cell at 70 Ry is well beyond npw=120, so forcing a QFORGE RbOs2O6 spin SCF on
mini would either be intractable, or (at a tractable-but-under-resolved basis) collapse to a
**spurious m≈0** that would FALSELY contradict QE's robust ~3-5 μB. Reporting such a number would be
a fabricated refutation — forbidden by c9. CsOs2O6 is the same family, same wall.

## verdict

- **VERDICT: ⏸ HONEST-SKIP — Os-5d high-ecut PW compute wall** (analogue of the CoSn Co-3d wall,
  worse: 9 atoms, 5d, ecut 70/560 Ry). The QFORGE-LSDA ENGINE is brick-g5-verified; the real-cell
  MOMENT is compute-walled on mini.
- **honest division (c9)**: RbOs2O6 / CsOs2O6 magnetism = **QE-production / QFORGE-gated** (not
  reproduced by the canonical engine). NO moment number fabricated.
- **breakthrough paths (d2)**: (1) GPU-accelerated davidson (affords npw~1000s); (2) reduced-basis
  (LCAO/Gaussian or PAW at lower ecut — QFORGE is PW-only today); (3) real HPC (days). On any of
  these the cross-val can be re-attempted; until then QE's moments stand as the reference.
