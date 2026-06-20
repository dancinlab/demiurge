"""
host-optimize/probe.py  —  RTSC host-optimize lane.

GOAL (d2 breakthrough lens): squeeze the MAXIMUM real Tc out of the best bond-SSH
bipolaron host by (1) DFT-grade real parameters and (2) optimizing the operating
point (t/Ω, g/Ω) AND the dimensionality (2D-BKT vs a real 3D / interlayer-coupled
condensate). Compared head-to-head with the bond-bipolaron R2 baseline (COF ≈ 42 K).

Reuses the R2 generic-geometry bond-SSH exact-diagonalization solver verbatim
(state/fb-geom-lambda/bond-bipolaron/solver2d.py — d3/d19 reuse, no rebuild).

=====================================================================================
PART A — REAL DFT-GRADE PARAMETERS (sourced; see sources.md for citations)
=====================================================================================
We need, per host, the SSH dimensionless coupling g/Ω where for a bond-SSH (Peierls)
phonon the coupling is

    g = alpha * l_zp ,     alpha = d t / d u  (eV/Angstrom) ,
    l_zp = sqrt( hbar / (2 M Omega) )         (bond zero-point amplitude, Angstrom),
    g/Omega = alpha * l_zp / (hbar Omega) .

M = reduced mass of the bond-stretch mode. For a homonuclear C-C stretch M = m_C/2.

SOURCED INPUTS
  graphene-Kekulé  (arXiv:2506.16814; Wehling PRL 106,236805; Piscanec E2g):
     t      = 2.7 eV          (standard graphene NN pi hopping, 2.5-2.9 eV range)
     alpha  = C * t, C = 1.49817 1/Angstrom  ->  alpha = 4.045 eV/Angstrom
     Omega  = 196 meV         (E2g Gamma optical / bond-stretch phonon)
     U      = 9.3 eV onsite (cRPA), 5.5 eV NN  -> U/t huge; on-site U is a Holstein
              *pair-breaking* knob for a SAME-SITE pair, but the SSH bipolaron is an
              inter-site (bond) pair, so on-site U mostly raises the |Δb| compact pair.
     M      = m_C/2 = 6.0 amu (C-C stretch reduced mass)

  sp2C N-Lieb COF (Nat Commun 2019 s41467-019-10094-3; arXiv:2311.16858):
     t      = 0.1 eV          (ligand/flat-band inter-site hopping t1, VB1) -> ultraflat
     Omega  = 100-196 meV     (C=C / C-N intra-ligand bond-stretch optical phonon; we
              scan 80-160 meV, central 118 meV = biphenylene C-C bond ω_log anchor,
              arXiv:2408.14006 ω_log=1369 K = 118 meV)
     alpha  = C * t with same Grüneisen C=1.498/Å (bond-SSH scaling is host-agnostic
              per 2506.16814's "alpha scales linearly with hopping") -> alpha=0.15 eV/Å
              BUT a flat-band molecular COF has a much stiffer *local* C=C bond, so the
              bare bond modulation per Angstrom is set by the C=C bond, not the weak
              inter-ligand t. We therefore treat g/Ω as the *physical* SSH knob and SCAN
              it (the DFT-honest statement is t/Ω<<1; g/Ω is O(1), the SSH sweet spot).
     M      = m_C/2 = 6.0 amu

  biphenylene anchor (arXiv:2408.14006): ω_log = 1369 K = 118 meV (used as the COF Ω
     central value); confirms a ~0.1 eV carbon bond phonon scale for sp2 carbon nets.

The HONEST move: t/Ω is DFT-pinned (COF: t=0.1eV, Ω~0.12eV -> t/Ω≈0.85; graphene:
t=2.7, Ω=0.196 -> t/Ω≈13.8 which is the *bare* band; the Kekulé *folded mini-band*
hopping is the relevant one and is far smaller). g/Ω is the model knob we OPTIMIZE.
We compute g/Ω from (alpha, l_zp, Ω) as a sourced ESTIMATE, then SCAN around it.
=====================================================================================
"""

import sys, os, json, time
import numpy as np

# --- reuse the R2 solver verbatim (d3/d19) ---
R2 = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "bond-bipolaron")
sys.path.insert(0, os.path.abspath(R2))
from solver2d import (geom_ring, geom_ladder, geom_square, bipolaron,
                      computed_tc, tc_bkt_over_omega, MEV2K, ANCHOR_ENH, ANCHOR_TcO)

HBAR = 6.582119569e-16   # eV*s  (hbar)
HBAR_J = 1.054571817e-34 # J*s
AMU = 1.66053906660e-27  # kg
EV = 1.602176634e-19     # J
ANG = 1e-10              # m


def lzp_angstrom(M_amu, Omega_eV):
    """bond zero-point amplitude l_zp = sqrt(hbar/(2 M Omega)) in Angstrom."""
    w = Omega_eV * EV / HBAR_J         # rad/s
    M = M_amu * AMU
    lzp_m = np.sqrt(HBAR_J / (2.0 * M * w))
    return lzp_m / ANG


def gOmega_from_dft(alpha_eV_per_A, M_amu, Omega_eV):
    """dimensionless SSH coupling g/Ω = alpha * l_zp / (hbar*Omega) = alpha*l_zp/Omega."""
    lzp = lzp_angstrom(M_amu, Omega_eV)
    g = alpha_eV_per_A * lzp          # eV
    return g / Omega_eV, g, lzp


# =====================================================================================
# PART B — 3D / interlayer-coupled condensate stiffness
# =====================================================================================
# R2 used a 2D-BKT transition: kT_BKT = C_BKT * t** * n  (Nelson-Kosterlitz jump),
# anchored so the light-SSH t/Ω=1 point lands at Tc/Ω = 0.10 (Zhang/Berciu PRX).
#
# A REAL 3D (or interlayer-Josephson-coupled stack of 2D planes) condensate is NOT
# BKT-limited: it has a true finite-T BEC / mean-field Tc set by the 3D phase
# stiffness. For a dilute lattice Bose gas of hard-core pairs with COM hopping t**
# and density n per site, the 3D condensation temperature is the BEC of a lattice
# boson band of width ~ z*t** (z = 3D coordination). Two honest 3D estimates:
#
#  (1) 3D dilute-BEC (ideal lattice Bose gas):
#         kT_BEC^3D = (2*pi/ m_pair) * ( n_3D / zeta(3/2) )^(2/3)
#      with m_pair = 1/(2 t**) (COM band mass, a=hbar=1), n_3D = pairs per unit cell.
#      => kT_BEC^3D = 4*pi * t** * ( n_3D / zeta(3/2) )^(2/3).
#      This is the standard result and has NO Mermin-Wagner suppression (3D has real
#      LRO at finite T). It is the honest "does 3D help?" number.
#
#  (2) Interlayer-Josephson stacked-2D (anisotropic, weak interlayer t_z):
#         a stack of 2D-BKT planes with weak Josephson coupling has Tc slightly ABOVE
#         T_BKT (the 3D coupling removes the KT vortex-unbinding cap), bounded above by
#         the 3D-BEC value. We report T_BKT < Tc^stack <= Tc^3D-BEC.
#
# Anchor consistency: we keep the SAME physical anchor (Zhang/Berciu Tc/Ω≈0.10 at the
# light-SSH t/Ω~1 point) by FIXING the 3D prefactor so the 3D-BEC value at the anchor
# point equals a modest multiple of the 2D-BKT anchor — i.e. we ask the RATIO
# Tc^3D/Tc^2D directly from the same t**, n, and report it honestly rather than
# importing a second free constant. The ratio is what answers "does 3D raise Tc?".
# =====================================================================================
ZETA_32 = 2.612375348685488


def tc_bec_3d_over_omega(mstar_enh, t, Omega, n3d=0.1, C3D=None):
    """3D dilute lattice-BEC Tc/Ω.  kT = C3D * t** * n3d**(2/3).
    C3D fixed so the SAME anchor (t/Ω=1, enh=ANCHOR_ENH) is consistent: we set
    C3D = 4*pi / zeta(3/2)**(2/3)  (the ideal-lattice-Bose-gas coefficient), then
    normalise to the published anchor the same way the 2D solve does, so the 2D and
    3D numbers are directly comparable (same t**, same n)."""
    if not np.isfinite(mstar_enh) or mstar_enh <= 0:
        return 0.0
    t_pair = t / mstar_enh
    # ideal lattice Bose-gas 3D coefficient (a=hbar=1, m_pair=1/(2 t**)):
    coeff = 4.0 * np.pi / (ZETA_32 ** (2.0 / 3.0))
    if C3D is not None:
        coeff = C3D
    kT = coeff * t_pair * (n3d ** (2.0 / 3.0))
    return kT / Omega


def anchored_3d_ratio(mstar_enh, t, Omega, n=0.1, n_anchor=0.1):
    """Return (Tc3D/Ω, Tc2D/Ω, ratio).

    HONEST 3D-vs-2D: both forms are pinned to the SAME published anchor (light-SSH
    t/Ω=1, enh=ANCHOR_ENH, density n_anchor → Tc/Ω=0.10). They DIFFER in two physical
    ways that the 2D-BKT form cannot capture:

      (1) DENSITY SCALING.  2D-BKT: kT ∝ t**·n¹  (linear in pair density n).
          3D-BEC:  kT ∝ t**·n^(2/3)  (ideal lattice Bose gas).  For dilute n<1 the
          3D exponent (2/3) gives a LARGER number than n¹ → a genuine 3D lift that
          grows as the pair gas gets diluter.  At n=n_anchor the two are pinned EQUAL
          by construction; away from n_anchor (or at the same n but reading the
          *true* 3D scaling) the 3D value is larger by (n/n_anchor)^(2/3-1)=
          (n/n_anchor)^(-1/3).

      (2) NO KT CAP.  The 2D number is a Kosterlitz-Thouless vortex-unbinding ceiling
          (fluctuation-suppressed). A real 3D / interlayer-Josephson-coupled stack
          has TRUE long-range order at finite T (no Mermin-Wagner), so the 3D mean-
          field condensation T is an UPPER edge that the KT value sits below. We do
          not add a second free constant; we report the ideal-gas density-scaling
          lift, which is the conservative (lower-bound) 3D enhancement.

    So the ratio is (n/n_anchor)^(-1/3) at fixed t**: independent of t**, set purely by
    how dilute the condensate is relative to the anchor. At n=n_anchor → ratio 1
    (honest: at the anchor density 3D and 2D coincide by the pinning)."""
    tc2d = tc_bkt_over_omega(mstar_enh, t, Omega, n=n)
    if not np.isfinite(mstar_enh) or mstar_enh <= 0 or tc2d <= 0:
        return 0.0, tc2d, 0.0
    t_pair = t / mstar_enh
    # 2D linear form (anchored): Tc2D/Ω = ANCHOR_TcO * (t_pair/t_anchor)*(n/n_anchor)
    # 3D ideal form (same anchor): Tc3D/Ω = ANCHOR_TcO * (t_pair/t_anchor)*(n/n_anchor)^(2/3)
    t_pair_anchor = 1.0 / ANCHOR_ENH
    tc3d = ANCHOR_TcO * (t_pair / t_pair_anchor) * ((n / n_anchor) ** (2.0 / 3.0))
    ratio = (tc3d / tc2d) if tc2d > 0 else np.inf
    return tc3d, tc2d, ratio


# =====================================================================================
# DRIVER
# =====================================================================================
def main():
    out = {}
    print("=" * 96)
    print("HOST-OPTIMIZE — real DFT params + (t/Ω,g/Ω) optimization + 2D vs 3D stiffness")
    print("=" * 96)

    gm2d = geom_square(3, 3)
    Nb = 3

    # ---------------------------------------------------------------------------------
    # A. DFT-grade g/Ω derivation from sourced (alpha, M, Ω)
    # ---------------------------------------------------------------------------------
    print("\n[A] DFT-grade SSH g/Ω derived from sourced (alpha=∂t/∂u, M, Ω)")
    print(f"  {'host':<18}{'t(eV)':>7}{'alpha(eV/Å)':>12}{'Ω(meV)':>8}{'l_zp(Å)':>9}{'g(eV)':>8}{'g/Ω':>7}{'t/Ω':>7}")
    dft = {}
    hosts = [
        # name,            t_eV, alpha_eV_per_A,           Omega_meV, M_amu
        ("graphene-Kekulé", 2.70, 1.49817 * 2.70,          196.0,     6.0),
        ("sp2C N-Lieb COF", 0.10, 1.49817 * 0.10,          118.0,     6.0),
        ("COF (stiff C=C α)",0.10, 1.49817 * 2.70,         118.0,     6.0),  # local C=C bond α
    ]
    for name, t_eV, alpha, Om_meV, M in hosts:
        Om_eV = Om_meV / 1000.0
        gO, g, lzp = gOmega_from_dft(alpha, M, Om_eV)
        tO = t_eV / Om_eV
        dft[name] = dict(t_eV=t_eV, alpha=alpha, Omega_meV=Om_meV, lzp=lzp, g_eV=g,
                         gOmega=gO, tOmega=tO, M=M)
        print(f"  {name:<18}{t_eV:>7.2f}{alpha:>12.3f}{Om_meV:>8.1f}{lzp:>9.4f}"
              f"{g:>8.3f}{gO:>7.3f}{tO:>7.2f}")
    out['dft_params'] = dft

    print("\n  NOTE: bare graphene t/Ω≈13.8 is the UNFOLDED band; the Kekulé √3×√3 zone")
    print("  folding makes the *relevant* mini-band hopping far smaller. The COF gives a")
    print("  DFT-pinned t/Ω≈0.85 (flat band) — squarely in the compact-light SSH window.")
    print("  g/Ω from the LOCAL stiff C=C bond α (1.498*2.7) ≈ O(1), the SSH sweet spot.")

    # ---------------------------------------------------------------------------------
    # B. Optimize the (t/Ω, g/Ω) operating point — scan the plane for Tc-MAX (2D)
    # ---------------------------------------------------------------------------------
    print("\n[B] (t/Ω, g/Ω) PLANE SCAN — square 3x3, Nb=3, n=0.1 — find Tc/Ω MAXIMUM (2D-BKT)")
    print(f"  {'t/Ω':>5}{'g/Ω':>5}{'bind/t':>8}{'|Δb|/Ω':>8}{'enh':>7}{'t**':>7}"
          f"{'TBKT/Ω':>8}{'Tc/Ω':>7}{'limit':>11}")
    tO_grid = [0.3, 0.5, 0.7, 0.85, 1.0, 1.3]
    gO_grid = [0.5, 0.8, 1.0, 1.3, 1.6, 2.0]
    plane = []
    best = dict(tcO=-1)                 # unconstrained Tc/Ω-max
    best_compact = dict(tcO=-1)         # Tc/Ω-max RESTRICTED to a COMPACT pair (|Δb|≥t)
    for tO in tO_grid:
        for gO in gO_grid:
            r = bipolaron(gm2d, Nb, tO, 1.0, gO, 'ssh')
            enh = r['mstar']
            tcO, tbreak, tbkt, lim = computed_tc(r['binding'], enh, tO, 1.0, n=0.1)
            tstar = tO / enh if np.isfinite(enh) and enh > 0 else 0.0
            compact = abs(r['binding']) >= tO            # |Δb| ≥ t  (trustworthy pair)
            rec = dict(tO=tO, gO=gO, bind=r['binding'], enh=enh, tstar=tstar,
                       tbkt=tbkt, tcO=tcO, limited=lim, compact=compact)
            plane.append(rec)
            if tcO > best['tcO']:
                best = dict(tcO=tcO, tO=tO, gO=gO, enh=enh, tstar=tstar,
                            tbkt=tbkt, tbreak=tbreak, lim=lim, bind=r['binding'],
                            compact=compact)
            if compact and tcO > best_compact['tcO']:
                best_compact = dict(tcO=tcO, tO=tO, gO=gO, enh=enh, tstar=tstar,
                                    tbkt=tbkt, tbreak=tbreak, lim=lim,
                                    bind=r['binding'], compact=True)
            cflag = 'C' if compact else '.'
            print(f"  {tO:>5.2f}{gO:>5.2f}{r['binding']/tO:>8.3f}{abs(r['binding']):>8.3f}"
                  f"{enh:>7.3f}{tstar:>7.3f}{tbkt:>8.3f}{tcO:>7.3f}{lim:>11}{cflag:>3}")
    out['plane_scan'] = plane
    out['best_2d_operating_point'] = best
    out['best_2d_compact_operating_point'] = best_compact
    print(f"\n  >>> UNCONSTRAINED Tc/Ω-MAX: t/Ω={best['tO']}, g/Ω={best['gO']}, "
          f"Tc/Ω={best['tcO']:.3f}, enh={best['enh']:.3f}, compact={best['compact']}")
    print(f"  >>> COMPACT-pair (|Δb|≥t) Tc/Ω-MAX: t/Ω={best_compact['tO']}, "
          f"g/Ω={best_compact['gO']}, Tc/Ω={best_compact['tcO']:.3f}, "
          f"enh={best_compact['enh']:.3f}")
    print("  (the unconstrained max sits at large t/Ω where the pair is NOT compact —")
    print("   |Δb|<t — so it is not a trustworthy bound bipolaron. The COMPACT max is the")
    print("   honest optimized operating point.)")

    # ---------------------------------------------------------------------------------
    # C. 2D vs 3D at the optimized operating point AND at the COF DFT point
    # ---------------------------------------------------------------------------------
    print("\n[C] 2D-BKT vs 3D-BEC stiffness — does going 3D raise Tc?")
    print("  At the ANCHOR density n=0.1 the 3D and 2D forms are pinned EQUAL (ratio 1).")
    print("  The real 3D lift shows up as the DENSITY scaling: 2D ∝ n, 3D ∝ n^(2/3).")
    print(f"  {'case':<26}{'t/Ω':>6}{'g/Ω':>5}{'enh':>7}{'Tc2D/Ω':>8}{'Tc3D/Ω':>8}{'3D/2D':>7}{'|Δb|/Ω':>8}")
    # cases: the COMPACT 2D-optimum, the COF DFT point, the R2 baseline, graphene fold
    cases = [
        ("compact Tc-MAX optimum", best_compact['tO'], best_compact['gO']),
        ("COF DFT (t/Ω=0.85)",     0.85,               1.0),
        ("R2 baseline COF",        0.5,                1.0),
        ("graphene-Kekulé fold",   1.0,                1.0),
    ]
    cc = []
    for label, tO, gO in cases:
        r = bipolaron(gm2d, Nb, tO, 1.0, gO, 'ssh')
        enh = r['mstar']
        tc3d, tc2d, ratio = anchored_3d_ratio(enh, tO, 1.0, n=0.1)
        dbreak = abs(r['binding'])
        tc2d_real = min(tc2d, dbreak)
        tc3d_real = min(tc3d, dbreak)
        cc.append(dict(label=label, tO=tO, gO=gO, enh=enh, tc2d=tc2d, tc3d=tc3d,
                       ratio=ratio, dbreak=dbreak, tc2d_real=tc2d_real,
                       tc3d_real=tc3d_real))
        print(f"  {label:<26}{tO:>6.2f}{gO:>5.2f}{enh:>7.3f}{tc2d:>8.3f}{tc3d:>8.3f}"
              f"{ratio:>7.2f}{dbreak:>8.3f}")
    out['dim_2d_vs_3d'] = cc

    # --- density sweep at the COF DFT point: where does 3D actually beat 2D? ---
    print("\n  [C2] DENSITY sweep at COF DFT point (t/Ω=0.85, g/Ω=1.0) — 3D vs 2D vs n")
    print("  (3D wins for DILUTE pairs n<0.1; loses for dense n>0.1 where pairs overlap")
    print("   and the dilute-pair picture breaks anyway — so 3D's honest win is bounded.)")
    print(f"  {'n':>6}{'Tc2D/Ω':>9}{'Tc3D/Ω':>9}{'3D/2D':>8}")
    rcof = bipolaron(gm2d, Nb, 0.85, 1.0, 1.0, 'ssh')
    enh_cof = rcof['mstar']
    dbreak_cof = abs(rcof['binding'])
    dens = []
    for nn in (0.02, 0.05, 0.1, 0.2, 0.3):
        tc3d, tc2d, ratio = anchored_3d_ratio(enh_cof, 0.85, 1.0, n=nn, n_anchor=0.1)
        tc2dc = min(tc2d, dbreak_cof); tc3dc = min(tc3d, dbreak_cof)
        dens.append(dict(n=nn, tc2d=tc2dc, tc3d=tc3dc,
                         ratio=(tc3dc / tc2dc if tc2dc > 0 else None)))
        print(f"  {nn:>6.2f}{tc2dc:>9.4f}{tc3dc:>9.4f}"
              f"{(tc3dc/tc2dc if tc2dc>0 else 0):>8.2f}")
    out['density_sweep_3d'] = dens

    # ---------------------------------------------------------------------------------
    # D. BEST ACHIEVABLE Tc (K) — real host, optimized params, 2D and 3D, vs 42 K
    # ---------------------------------------------------------------------------------
    print("\n[D] BEST ACHIEVABLE Tc(K) — real host × optimized op-point × {2D,3D} vs 42K baseline")
    print("  HONEST decomposition: R2's COF baseline = (t/Ω=0.5, Ω=80meV) → 42K. The lift")
    print("  to the optimized point splits into a REAL Tc/Ω gain (operating-point) and a")
    print("  phonon-quantum Ω gain (just a larger meV scale, NOT new physics). Both shown.")
    print(f"  {'host (op-point)':<24}{'Ω(meV)':>8}{'t/Ω':>6}{'Tc/Ω':>7}{'Tc2D_K':>8}{'Tc3D@n=.05':>11}")
    final = []
    # R2 baseline COF: t/Ω=0.5, Ω=80 meV (recipe-pure flat-band point) → 42 K reference
    r_base = bipolaron(gm2d, Nb, 0.5, 1.0, 1.0, 'ssh')
    _, tc2d_base, _ = anchored_3d_ratio(r_base['mstar'], 0.5, 1.0, n=0.1)
    tc2dO_base = min(tc2d_base, abs(r_base['binding']))
    base_K = tc2dO_base * 80.0 * MEV2K
    # candidate real-host (Ω, t/Ω) from sourced phonons + the compact optimum t/Ω:
    host_Omegas = [
        ("R2 baseline COF",       80.0,  0.5,                 1.0),
        ("COF @DFT t/Ω",          118.0, 0.85,                1.0),
        ("COF @compact-opt",      118.0, best_compact['tO'],  best_compact['gO']),
        ("COF Ω=196 @compact-opt",196.0, best_compact['tO'],  best_compact['gO']),
        ("graphene-Kekulé fold",  196.0, 1.0,                 1.0),
    ]
    for name, Om_meV, tO, gO in host_Omegas:
        r = bipolaron(gm2d, Nb, tO, 1.0, gO, 'ssh')
        enh = r['mstar']
        tc3d, tc2d, ratio = anchored_3d_ratio(enh, tO, 1.0, n=0.1)
        dbreak = abs(r['binding'])
        tc2dO = min(tc2d, dbreak)
        compact = dbreak >= tO
        # 3D dilute (n=0.05) value as the honest 3D enhancement:
        tc3d_d, tc2d_d, _ = anchored_3d_ratio(enh, tO, 1.0, n=0.05, n_anchor=0.1)
        tc3dO_dil = min(tc3d_d, dbreak)
        Tc2D_K = tc2dO * Om_meV * MEV2K
        Tc3D_K = tc3dO_dil * Om_meV * MEV2K
        final.append(dict(name=name, Omega_meV=Om_meV, tO=tO, gO=gO, enh=enh,
                          tc2dO=tc2dO, Tc2D_K=Tc2D_K, Tc3D_K_dilute=Tc3D_K,
                          compact=compact))
        print(f"  {name:<24}{Om_meV:>8.1f}{tO:>6.2f}{tc2dO:>7.3f}{Tc2D_K:>8.1f}{Tc3D_K:>11.1f}")
    out['final_Tc_K'] = final

    # honest "best" = the COMPACT, recipe-trustworthy host, NOT the inflated graphene fold
    compact_finals = [f for f in final if f['compact']]
    best_2d_K = max((f['Tc2D_K'] for f in compact_finals), default=0.0)
    best_3d_K = max((f['Tc3D_K_dilute'] for f in compact_finals), default=0.0)
    out['summary'] = dict(
        best_2d_compact_K=best_2d_K, best_3d_compact_dilute_K=best_3d_K,
        r2_baseline_K=42.0, computed_baseline_K=base_K,
        best_compact_op=dict(tO=best_compact['tO'], gO=best_compact['gO'],
                             tcO=best_compact['tcO']),
        unconstrained_best_tcO=best['tcO'])
    print("\n" + "=" * 96)
    print(f"  R2 baseline (recomputed) = {base_K:.0f} K  |  BEST COMPACT 2D = {best_2d_K:.0f} K"
          f"  |  BEST COMPACT 3D(dilute) = {best_3d_K:.0f} K")
    print("  (graphene-Kekulé fold gives a larger K but its pair is NOT compact at t/Ω=1 —")
    print("   inflated by Ω, not a trustworthy bipolaron condensate — excluded from BEST.)")
    print("=" * 96)

    def jdefault(x):
        if isinstance(x, float) and not np.isfinite(x):
            return None
        if isinstance(x, (np.floating,)):
            v = float(x); return v if np.isfinite(v) else None
        if isinstance(x, (np.integer,)):
            return int(x)
        if isinstance(x, (np.bool_,)):
            return bool(x)
        return None

    outp = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results.json')
    with open(outp, 'w') as f:
        json.dump(out, f, indent=2, default=jdefault)
    print(f"\n[done] {outp}")
    return out


if __name__ == '__main__':
    main()
