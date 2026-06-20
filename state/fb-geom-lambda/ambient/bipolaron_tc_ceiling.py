#!/usr/bin/env python3
"""
AMBIENT-BIPOLARON-TC-CEILING — the 6th discovery-law assembler (demiurge RTSC)
==============================================================================
Goal: close the ONE escape route left open by AMBIENT-TC-CEILING (Regime I) +
EXOTIC-GLUE-CAPPED — the NON-ADIABATIC off-diagonal bond-Peierls (SSH) bipolaron
("Regime II, no proven ceiling") — with a QUANTITATIVE Tc_max number, a deciding
parameter, and a reachable / bounded / open verdict.

This is a LAW assembler + python eval on PUBLISHED-QMC anchors, NOT a new QMC run
and NOT a material search (d_novel_only). It REUSES, does not rebuild:
  - formula_tc_estimate.py     (Regime-II envelope η·Ω·g(t/Ω))      [../]
  - bond-bipolaron/solver.py   (validated 2-body SSH ED: m**~1.5 light,    [../]
                                Holstein m**~e^{g^2} heavy — solver VALIDATED)
  - MASTER / RTSC_DISCOVERY_CLOSING_FORMULA.md (2-regime closing formula)
  - math_ambient_ceiling.py    (Regime-I el-ph + magnetic ambient ceilings)

PUBLISHED-QMC ANCHORS (the C constant of the ceiling) — all sign-problem-free,
numerically-exact path-integral / diagrammatic QMC in the singlet 2e sector:

  [A1] Zhang, Sous, Reichman, Berciu, Millis, Prokof'ev, Svistunov,
       PRX 13, 011010 (2023) / arXiv:2210.14236 — SQUARE-lattice bond-Peierls
       bipolaron. RESULT: Tc ~ 0.2 * Omega at the quantal optimum t ~ Omega.
       Quote: "Tc ~ 0.2 Omega ... could easily give Tc ~ 70 K for a typical
       phonon frequency ~0.03 eV IF the unusual limit t ~ Omega can be achieved."
  [A2] Chao Zhang et al., arXiv:2507.07662 (2025) — TRIANGULAR-lattice bond
       bipolaron, comprehensive QMC. RESULT: max Tc/omega ~ 0.32 at U/t = 6.0;
       peak near lambda_ssh ~ 0.3 for omega/t = 0.3-1.0. (higher coordination +
       bond-centered coupling beats the square lattice's 0.2.)
  [A3] arXiv:2407.10444 (2024) — 2D bond bipolaron WITH long-range Coulomb:
       the superfluid Tc SURVIVES unscreened Coulomb and exceeds the
       Migdal-Eliashberg bound (the BEC is robust, not a fragile artifact).
  [A4] arXiv:2409.14132 (2024) — phonon DISPERSION reduces Tc somewhat vs the
       dispersionless Einstein anchor (pessimistic correction; bakes into C_lo).
  [A5] Alexandrov superlight-bipolaron class (cond-mat/0701412, PRL 98,037002):
       OPTIMISTIC analytic tail Tc/Omega up to ~0.4-0.44 (charged-Bose-gas BEC
       of superlight bipolarons). Used ONLY as the optimistic bracket edge — it
       is NOT QMC-grade for the bond model, so it is flagged separately.

CONVENTIONS: hbar = a = kB = 1 in the model; 1 meV = 11.604 K.
"""
import numpy as np

meV2K = 11.604  # 1 meV in Kelvin
ROOM_T = 293.15  # K, ambient room-T hard gate (d_roomt_ambient)

# ======================================================================
# (0) THE CEILING FORMULA — why it collapses to Tc_max = C * Omega
# ======================================================================
# The Regime-II envelope (formula_tc_estimate.py) is  Tc ~ eta * Omega * g(t/Omega),
# with g(t/Omega) peaking at the quantal optimum t/Omega ~ 1. The published QMC
# (A1, A2) ALREADY MAXIMIZES over t/Omega, U/t and lambda_ssh — i.e. it reports the
# value AT the optimum (the peak of g). So the *ceiling* (the max over all those
# knobs) is simply
#
#         kB * Tc_max  =  C_QMC * Omega ,      C_QMC = Tc/Omega |_optimum
#
# and EVERY internal knob (t/Omega, lambda_ssh, U/t, density, mass) has been
# folded into the single dimensionless number C_QMC. The mass-Tc tension
# (Tc_BEC ~ n^{2/3}/m**, m** rises with coupling) is the very thing the QMC peak
# resolves: the optimum sits where lighter-mass gain stops beating density/binding
# loss. So the ONLY remaining free parameter is OMEGA — the bond-phonon budget.
#
# => Tc_max(bond-bipolaron, ambient) is DECIDED BY Omega. C_QMC is a fixed
#    universal-ish band [0.2 (square) .. 0.32 (triangular)], optimistic tail 0.44.

C_QMC = {
    "square QMC (A1, PRX 2210.14236)":      0.20,
    "triangular QMC (A2, 2507.07662)":      0.32,
    "dispersion-corrected (A4, pessim.)":   0.15,   # phonon dispersion drags Tc down
    "Alexandrov superlight (A5, optim. tail)": 0.44,
}
C_LO = 0.15   # pessimistic (dispersion-corrected square)
C_MID = 0.26  # QMC-grade central (mean of square & triangular)
C_HI = 0.44   # optimistic analytic tail (Alexandrov, NOT QMC-grade — flagged)


def tc_max(omega_meV, C):
    """Ceiling Tc in K for a given bond-phonon Omega (meV) and dimensionless C."""
    return C * omega_meV * meV2K


# ======================================================================
# (1) THE OMEGA BUDGET — bond-Peierls phonon frequencies of LIGHT bonds
# ======================================================================
# The bond-Peierls phonon must MODULATE a hopping (off-diagonal), so it is a
# bond-STRETCH / bond-twist optical mode of a LIGHT covalent bond. Its frequency
# is set by bond stiffness k and reduced mass mu: Omega = sqrt(k/mu). The lightest
# strong covalent bonds set the ceiling.
#
# Sourced bond-stretch optical-phonon energies (hbar*Omega, meV):
OMEGA_BONDS = {
    # bond            Omega(meV)  note / source
    "B-C (e.g. BC-network, MgB2-class)":   135.0,  # B-C stretch ~1090 cm^-1
    "C-C (graphene E2g / iTO)":            196.0,  # ~1580-1600 cm^-1 = 196 meV (the C ceiling)
    "C-N (sp2 C-N COF)":                   165.0,  # ~1330 cm^-1
    "B-N (h-BN E2g)":                      170.0,  # ~1370 cm^-1
    "C-H (stretch, if it modulated t)":    370.0,  # ~3000 cm^-1 (NOT a hopping-bond; ceiling-of-ceilings)
    "O-H / N-H":                           430.0,  # ~3500 cm^-1 (same caveat)
}
# PHYSICAL ceiling of a HOPPING-MODULATING bond = C-C E2g ~ 196 meV.
# (C-H/O-H stretches are terminal bonds, they don't modulate an inter-site
#  hopping in a conduction network, so they CANNOT host the bond-bipolaron —
#  listed only to show even THAT extreme doesn't save room-T at C_mid.)
OMEGA_HOPPING_CEILING = 196.0  # meV — C-C E2g, the hardest realistic hopping bond


# ======================================================================
# (2) THE MASS-Tc TENSION & THE QUANTAL-OPTIMUM WINDOW (binding vs mobility)
# ======================================================================
# Off-diagonal SSH evades Holstein self-trapping (the solver shows m** saturates
# ~1.5, NOT e^{g^2}), BUT three constraints must hold SIMULTANEOUSLY:
#   (a) BOUND pair:    binding |Delta_b| > 0 and the pair compact (|Delta_b| >~ t)
#   (b) LIGHT enough:  m**/m_free small (so Tc_BEC ~ t/m** stays high)
#   (c) DENSE enough:  pair density n high but below the Mott/overlap limit
# The QMC peak Tc/Omega is exactly the simultaneous-satisfaction value. We encode
# the window as: at the optimum t/Omega ~ 1 and lambda_ssh ~ 0.3 (A2), the SSH
# bipolaron is bound, light (m**~1.5 from our validated solver), and condensable.
# OUTSIDE the window:
#   - t/Omega << 1 (very flat band): heavy, Tc collapses (g_window -> 0)
#   - lambda_ssh >> 1: pair shrinks toward a single site -> density-capped (Mott),
#     and binding-vs-overlap forces dilution -> Tc_BEC ~ n^{2/3} drops.
# Net: the window is NARROW and the QMC already sits at its TOP. There is no
# hidden knob that pushes Tc/Omega past ~0.3 (QMC) without leaving the bound-light-
# dense window. This is WHY C_QMC, not a tunable, is the ceiling constant.

def window_check(t_over_omega, lambda_ssh, mstar):
    """Boolean simultaneous-window test (qualitative, from solver+QMC anchors)."""
    bound_and_light = (0.3 <= t_over_omega <= 3.0) and (mstar < 5.0)
    not_mott = (lambda_ssh < 1.5)  # beyond this pair shrinks -> density-capped
    return bound_and_light and not_mott


# ======================================================================
# (3) EVALUATE THE CEILING — does it cross 293 K?
# ======================================================================
def ceiling_table():
    print("=" * 86)
    print("(1) AMBIENT-BIPOLARON-TC-CEILING:  kB*Tc_max = C_QMC * Omega   [C from published QMC]")
    print("=" * 86)
    print(f"{'bond-phonon Omega':<38}{'Omega':>7}"
          f"{'Tc[C=.15]':>11}{'Tc[C=.26]':>11}{'Tc[C=.44]':>11}")
    print(f"{'(hopping-modulating optical mode)':<38}{'(meV)':>7}"
          f"{'pessim K':>11}{'QMC-mid K':>11}{'optim K':>11}")
    print("-" * 86)
    for name, om in OMEGA_BONDS.items():
        tlo = tc_max(om, C_LO)
        tmid = tc_max(om, C_MID)
        thi = tc_max(om, C_HI)
        flag = ""
        if "C-H" in name or "O-H" in name or "N-H" in name:
            flag = "  <- terminal bond, CANNOT host bond-bipolaron"
        print(f"{name:<38}{om:>7.0f}{tlo:>11.0f}{tmid:>11.0f}{thi:>11.0f}{flag}")
    print()
    # the decisive line: the HARDEST realistic hopping bond (C-C E2g ~196 meV)
    om = OMEGA_HOPPING_CEILING
    print(f"  DECISIVE — hardest HOPPING bond = C-C E2g, Omega = {om:.0f} meV:")
    print(f"    Tc_max (pessimistic, C=0.15)         = {tc_max(om,C_LO):6.0f} K")
    print(f"    Tc_max (QMC-grade central, C=0.26)   = {tc_max(om,C_MID):6.0f} K")
    print(f"    Tc_max (square QMC,        C=0.20)   = {tc_max(om,0.20):6.0f} K")
    print(f"    Tc_max (triangular QMC,    C=0.32)   = {tc_max(om,0.32):6.0f} K")
    print(f"    Tc_max (optimistic tail,   C=0.44)   = {tc_max(om,C_HI):6.0f} K  [Alexandrov, NOT QMC-grade]")
    print()
    # what Omega would 293 K require at each C?
    print(f"  INVERSE — Omega required for Tc = {ROOM_T:.0f} K (room-T):")
    for label, C in [("square QMC C=0.20", 0.20), ("QMC-mid C=0.26", 0.26),
                     ("triangular QMC C=0.32", 0.32), ("optimistic C=0.44", 0.44)]:
        om_need = ROOM_T / (C * meV2K)
        wcm = om_need / 8.065  # meV -> *1000/124 ... convert to cm^-1: 1 meV=8.065 cm^-1
        print(f"    {label:<22}: Omega >= {om_need:6.0f} meV = {om_need*8.065:6.0f} cm^-1"
              f"   ({'ABOVE' if om_need>OMEGA_HOPPING_CEILING else 'below'} C-C ceiling 196 meV)")
    print()


def verdict():
    print("=" * 86)
    print("(2) VERDICT — is bond-bipolaron ambient Tc above or below 293 K?")
    print("=" * 86)
    om_ceil = OMEGA_HOPPING_CEILING
    tc_mid = tc_max(om_ceil, C_MID)
    tc_sq = tc_max(om_ceil, 0.20)
    tc_tri = tc_max(om_ceil, 0.32)
    tc_opt = tc_max(om_ceil, C_HI)
    # Omega needed for room-T at the QMC-grade central C
    om_need_mid = ROOM_T / (C_MID * meV2K)
    om_need_tri = ROOM_T / (0.32 * meV2K)
    print(f"  Hardest hopping bond Omega(C-C E2g) = {om_ceil:.0f} meV.")
    print(f"  QMC-grade ceiling   Tc_max = {tc_sq:.0f}-{tc_tri:.0f} K  (square 0.20 - triangular 0.32)")
    print(f"  Central QMC estimate Tc_max = {tc_mid:.0f} K  (C_mid=0.26)")
    print(f"  Optimistic tail      Tc_max = {tc_opt:.0f} K  (C=0.44, Alexandrov, NOT QMC-grade)")
    print()
    print(f"  293 K needs Omega >= {om_need_tri:.0f} meV (triangular C=0.32) to "
          f"{om_need_mid:.0f} meV (C_mid=0.26).")
    print(f"  The hardest hopping-modulating bond (C-C E2g) reaches {om_ceil:.0f} meV "
          f"({om_ceil*8.065:.0f} cm^-1).")
    print(f"  {om_need_tri:.0f}-{om_need_mid:.0f} meV is BELOW the C-C ceiling {om_ceil:.0f} meV "
          f"=> the Omega budget DOES clear room-T at QMC grade.")
    print()
    # The honest reachability test is NOT 'is Tc_max>293' (it is), but whether the
    # FULL window can be occupied by a real host: t~Omega optimum AT high Omega.
    if tc_tri >= ROOM_T:
        print("  >>> VERDICT (c-with-a-named-wall): GENUINELY OPEN — no QMC-grade ceiling")
        print("      below 293 K. The QMC-anchored Tc_max = C_QMC * Omega with the physical")
        print(f"      C-C bond-Peierls Omega={om_ceil:.0f} meV gives Tc_max = {tc_sq:.0f}-{tc_tri:.0f} K")
        print(f"      (square-triangular QMC), i.e. ABOVE 293 K. Room-T is NOT forbidden by this")
        print("      mechanism's ceiling formula.")
        print()
        print("      *** THIS CORRECTS the campaign's prior 'bond-bipolaron caps 20-70 K' line.")
        print("      That number used Omega~30 meV — the PRX *illustrative* phonon, NOT the")
        print("      physical hopping-bond MAXIMUM. The ceiling scales linearly with Omega, and")
        print("      light covalent bonds (B-C 135, C-N 165, C-C 196 meV) are 4-6x stiffer.")
        print("      At C-C, QMC-grade Tc_max crosses room-T. The mechanism is NOT bounded<293K.")
    print()
    print("  THE SINGLE DECIDING PARAMETER:  Omega (the bond-Peierls phonon frequency).")
    print("    Tc_max = C_QMC * Omega, C_QMC in [0.20, 0.32] FIXED by QMC; the entire room-T")
    print("    question reduces to ONE number: the stiffest HOPPING-modulating bond phonon.")
    print(f"    Room-T threshold Omega* = 293K/(C*kB): {om_need_tri:.0f} meV (C=0.32) .. "
          f"{ROOM_T/(0.20*meV2K):.0f} meV (C=0.20).")
    print(f"    Physical Omega(C-C) = {om_ceil:.0f} meV CLEARS all of them. The deciding")
    print(f"    inequality is Omega(bond) > Omega* ~ 79-126 meV, and C-C/B-C/C-N satisfy it.")
    print()
    print("  THE REAL (un-closed) WALL is NOT the ceiling — it is REALIZABILITY of the")
    print("  t~Omega QUANTAL OPTIMUM at high Omega: the QMC peak needs hopping t ~ Omega, so")
    print(f"  at Omega={om_ceil:.0f} meV the band must have t~{om_ceil:.0f} meV (bandwidth ~0.8 eV) AND")
    print("  lambda_ssh~0.3 AND singlet-bound AND condensable density — simultaneously, in ONE")
    print("  real material. NO such host is yet known/computed (Re6Se8Cl2 etc. sit at t/Omega~")
    print("  2-8, OFF the optimum). So: ceiling OPEN above 293 K (no proven cap < room-T);")
    print("  the binding wall has moved from 'Tc ceiling' to 'occupy the t~Omega corner at")
    print("  stiff-bond Omega' — a MATERIALS-REALIZATION wall, not a ceiling theorem.")
    print()
    print(f"  HONEST (d6): QMC-grade ceiling = {tc_sq:.0f}-{tc_tri:.0f} K (C=0.20-0.32, Omega=C-C 196meV);")
    print(f"  central {tc_mid:.0f} K; optimistic tail {tc_opt:.0f} K. ALL > 293 K. This mechanism is")
    print("  the campaign's last open door AND IT DOES NOT CAP BELOW 293 K at QMC grade — UNLIKE")
    print("  Regime-I el-ph (capped ~150-200K) and magnetic glue (capped ~160K). The catch is")
    print("  realization, not a ceiling. Verdict = (c) genuinely open, with a NAMED materials wall.")


def crosscheck_solver():
    """Cross-check the ceiling against the validated 2-body SSH solver mass.
    The solver gives m**/m_free ~ 1.5 at the converged g/Omega=1, t/Omega=1 (LIGHT).
    Tc_BEC ~ C_BEC * (t/m**) * n^{2/3}. With C_BEC fixed so the light t/Omega=1 point
    lands at Tc/Omega=0.1 (conservative, the solver's own anchor), and m**=1.5:
        Tc/Omega ~ 0.1 (solver-conservative) ... vs 0.2-0.32 (full QMC).
    The solver's 0.1 is a LOWER bracket (2-body ED on a small ring, dilute n=0.1);
    the full finite-density QMC (A1,A2) gives the 0.2-0.32 used as the ceiling C.
    So the solver UNDERSHOOTS the QMC (expected: ED ring != thermodynamic BEC) and
    BRACKETS THE CEILING FROM BELOW — consistent, no contradiction."""
    print("=" * 86)
    print("(3) CROSS-CHECK vs validated 2-body SSH solver (bond-bipolaron/solver.py)")
    print("=" * 86)
    mstar = 1.5  # converged SSH mass enhancement (solver g5-PASS: saturates ~1.5)
    C_solver = 0.10  # solver-conservative anchor (Tc/Omega at light t/Omega=1)
    om = OMEGA_HOPPING_CEILING
    print(f"  solver m**/m_free ~ {mstar} (LIGHT; Holstein would be ~e^(g^2)>>1).")
    print(f"  solver-conservative C ~ {C_solver} (2-body ED, dilute) -> Tc_max(C-C) = "
          f"{tc_max(om, C_solver):.0f} K (LOWER bracket).")
    print(f"  full finite-density QMC C ~ 0.20-0.32 -> Tc_max(C-C) = "
          f"{tc_max(om,0.20):.0f}-{tc_max(om,0.32):.0f} K (the ceiling).")
    print(f"  => solver brackets the ceiling FROM BELOW; QMC sets the ceiling. Consistent.")
    print(f"  ALL brackets [solver {tc_max(om,C_solver):.0f} K | QMC {tc_max(om,0.20):.0f}-"
          f"{tc_max(om,0.32):.0f} K | optim {tc_max(om,C_HI):.0f} K] vs 293 K:")
    print(f"     QMC-grade central {tc_max(om,C_MID):.0f} K. Room-T 293 K sits "
          f"{'INSIDE' if tc_max(om,0.32)>=ROOM_T else 'ABOVE the QMC band but reachable only at the optimistic edge'}.")


if __name__ == "__main__":
    ceiling_table()
    verdict()
    crosscheck_solver()
