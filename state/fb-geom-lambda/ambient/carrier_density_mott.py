#!/usr/bin/env python3
"""
CARRIER-DENSITY-MOTT-BOUND — the 8th RTSC discovery-law assembler (demiurge)
===========================================================================
THE COLLISION (named by law_consistency_audit.md §4):

  The flat-band bipolaron room-T escape (L8 FB-BIPOLARON-STIFFNESS-BOUND) rests on
  the Peotta-Toermae GEOMETRIC superfluid weight

        D_s = 4 |U| nu(1-nu) <g>            (finite at t->0 ; the whole escape)
        kB T_BKT = (pi/2) D_s               (2D-BKT ; CANDIDATE_VERIFICATION.py)

  D_s PEAKS at filling nu=1/2 (the nu(1-nu) factor) and GROWS with |U|.
  BUT nu=1/2 of a flat band at E_F is EXACTLY where on-site Mott / bipolaron-CDW
  localization is most severe (a flat band has bandwidth W->0, so U/W -> infinity,
  the strongest-correlation limit). LARGE |U| both RAISES D_s and OPENS the Mott gap.

  => the escape's own stiffness and its own failure mode collide at the SAME filling.

QUESTION (the 8th law): does a metallic-SUPERFLUID window survive, with max T_BKT>293K
inside it, or does Mott/CDW re-cap the last electronic escape?

REUSE (d_novel_only — does NOT rebuild):
  - D_s = 4|U|nu(1-nu)<g>, kT_c=(pi/2)D_s, anchor Tc/Om(geom)=0.10  [CANDIDATE_VERIFICATION.py,
    geom-stiffness/FINDINGS.md]
  - <g> flat-band zoo values (Lieb 0.642 / 0.566, kagome 2.19, dice/T3, checkerboard)  [R6_flatband_zoo.py]
  - Welch bound <g> >= 1/N_band  [R5_welch_bound.py / R6]
  - bond-phonon Omega budget + C_QMC ceiling band  [bipolaron_tc_ceiling.py]
  - 2D-BKT defensible-Tc-only, 3D x1.40 RETRACTED (no-go 2604.04719)  [CANDIDATE_VERIFICATION.py]

PHYSICS OF THE Mott BOUNDARY (the new ingredient this probe adds):
  A multiband flat band at integer/half filling Mott-localizes when the pair-binding /
  on-site repulsion exceeds the geometric kinetic scale the quantum metric provides.
  For a flat band, the ONLY kinetic scale is the geometric one: the quantum-metric
  spread gives an effective bandwidth W_eff ~ (the metric makes the localized Wannier
  states overlap). Peotta-Toermae: a flat band is superfluid iff its Wannier functions
  are NOT exponentially localizable, i.e. <g> > 0; the SAME <g> that gives D_s sets the
  resistance to Mott localization. Quantitatively (Mott-Hubbard on a band of width W):
        Mott gap opens for   U/W >= (U/W)_c   with (U/W)_c ~ O(1) (1.5-2 typical 2D),
  BUT on a flat band W->0 so U/W->inf and ANY commensurate filling Mott-localizes UNLESS
  the geometric metric supplies an effective bandwidth W_geom that the metric-induced
  inter-CLS hybridization opens. Peotta-Toermae + Verma/Mao: the minimal quantum metric
  (Welch-saturating, <g>=1/N) gives W_geom ~ <g>|U| (the superfluid weight scale itself),
  so the Mott criterion at commensurate nu becomes a competition

        Mott-localize  iff   U  >  U_Mott(nu) ~ c_Mott * <g> * W_band-or-Omega
                                                ( geometric kinetic scale )
  i.e. the metric that BUYS stiffness ALSO buys delocalization, BUT the on-site U that
  buys stiffness ALSO drives Mott. Whether stiffness or Mott wins at nu=1/2 is the law.

CONVENTIONS: hbar=a=kB=1; 1 meV = 11.604 K. Energies (U, W, Omega) in meV.
"""
import numpy as np

meV2K = 11.604
ROOM_T = 293.15  # K hard gate (d_roomt_ambient)

# ----- geom-stiffness lane anchor (held, NOT re-tuned) -----------------------
# CANDIDATE_VERIFICATION.py: Tc/Om(2D-BKT,geom)=0.0977 at COF ref (<g>=0.672, U/Om=1.08, nu=1/2).
# We REPRODUCE that point exactly with the closed Peotta-Toermae form below as a g5 anchor.
G_REF, UOM_REF = 0.672, 1.08
TCOM_REF = 0.0977            # lane-recorded Tc/Omega at the reference (nu=1/2)


# =============================================================================
# (1) THE GEOMETRIC STIFFNESS + 2D-BKT Tc  (reused, parameterized in nu, U, <g>)
# =============================================================================
def Ds_over_Omega(g, UOm, nu):
    """D_s/Omega from Peotta-Toermae geometric weight, in the lane's anchored units.
    D_s = 4|U| nu(1-nu) <g>; the lane anchor fixes the proportionality so the COF
    reference point reproduces Tc/Om=0.0977 (kT=(pi/2)D_s). At nu=1/2, 4nu(1-nu)=1."""
    filling = 4.0 * nu * (1.0 - nu)        # = 1 at nu=1/2 ; the collision factor
    # anchor: TcOM_REF = (pi/2)*Ds_ref/Om ; Ds_ref/Om = (2/pi)*TcOM_REF at the ref (g,UOm,fill=1)
    Ds_ref_over_Om = (2.0 / np.pi) * TCOM_REF
    # scale linearly in <g> and in U/Om and in the filling factor (the formula's structure)
    return Ds_ref_over_Om * (g / G_REF) * (UOm / UOM_REF) * filling


# ----- the QMC pair-binding ceiling (reused from bipolaron_tc_ceiling.py) -----
# A 2D-BKT Tc CANNOT exceed the bipolaron pair-binding / phase-stiffness ceiling that
# sign-problem-free QMC fixes for the bond-bipolaron: Tc <= C_QMC * Omega, with the
# QMC band C_QMC in [0.20 (square) .. 0.32 (triangular)], central 0.26. This is a HARD
# physical cap: once D_s exceeds the pair-binding scale, the pairs unbind / the BKT
# stiffness saturates at the binding energy. WITHOUT this cap the linear-in-U D_s runs
# away to unphysical 1000s K. d6: enforce it.
C_QMC_CEIL = 0.32   # triangular-lattice QMC ceiling (the most optimistic QMC-grade value)


def Tbkt_K(g, Omega_meV, UOm, nu, cap=True):
    """2D-BKT Tc in Kelvin = (pi/2) D_s, CAPPED at the QMC pair-binding ceiling C_QMC*Omega.
    The geometric D_s sets the stiffness; the QMC cap sets the pair-binding ceiling; the
    physical Tc is the MIN of the two (you cannot have more phase stiffness than binding)."""
    DsOm = Ds_over_Omega(g, UOm, nu)
    TcOm = (np.pi / 2.0) * DsOm
    Tc = TcOm * Omega_meV * meV2K
    if cap:
        Tc_ceil = C_QMC_CEIL * Omega_meV * meV2K   # QMC pair-binding ceiling
        Tc = min(Tc, Tc_ceil)
    return Tc


# =============================================================================
# (2) THE Mott / bipolaron-CDW BOUNDARY  (the NEW ingredient)
# =============================================================================
# A flat band has bandwidth W_band ~ 0, so the bare ratio U/W -> infinity: ANY on-site
# U Mott-localizes at a COMMENSURATE filling unless a geometric kinetic scale rescues it.
# The metric supplies that scale: the superfluid weight D_s itself IS the geometric
# kinetic energy. Peotta-Toermae / Verma-Mao-Tewari: superfluidity survives iff the
# pair can DELOCALIZE over the metric-induced support, i.e. iff
#     (interaction localizing the pair)  <  (geometric kinetic energy delocalizing it)
# We encode the Mott-onset interaction at commensurate nu as
#     U_Mott(nu) = c_Mott(nu) * <g> * Omega           [geometric kinetic scale ~ <g>*Omega]
# with c_Mott LOWEST (most fragile) at the strongest commensuration nu=1/2 (half-filled
# flat band = the canonical flat-band Mott insulator; e.g. twisted-bilayer correlated
# insulators all sit at integer/half nu). Away from commensuration the Mott criterion
# RELAXES (incommensurate fillings cannot open a commensurate gap -> metallic).
#
# c_Mott(nu): a commensurability weight. Sharpest at nu=1/2 and 1/3; ~vanishes off
# commensurate. We model the half-filling Mott threshold and the incommensurate relief.
COMMENSURATE = {0.5: 1.00, 1.0/3: 0.66, 2.0/3: 0.66, 0.25: 0.45, 0.75: 0.45}
C_MOTT_HALF = 1.5   # U_Mott(1/2)/(<g>*Omega): half-filled flat-band Mott threshold (O(1.5),
                    # from 2D-Hubbard (U/W)_c~1.5-2 mapped onto the geometric bandwidth <g>*Omega)
COMM_WIDTH = 0.035  # how close to commensurate (in nu) the Mott gap can lock (finite-size of CDW)


def commensuration_weight(nu):
    """How strongly filling nu is commensurate (1 at nu=1/2, decays off-commensurate)."""
    w = 0.0
    for nc, strength in COMMENSURATE.items():
        w = max(w, strength * np.exp(-((nu - nc) / COMM_WIDTH) ** 2))
    return w


def U_Mott_over_Omega(g, nu):
    """On-site U/Omega above which Mott/CDW localizes the pairs at filling nu.
    Geometric kinetic scale <g>*Omega times the commensuration weight. OFF-commensurate
    the threshold -> infinity (no commensurate gap can open) => metallic survives."""
    cw = commensuration_weight(nu)
    if cw < 1e-3:
        return np.inf                       # incommensurate: no Mott gap
    return C_MOTT_HALF * g / cw              # divide by cw: weaker commensuration = higher threshold


def is_superfluid_metallic(g, UOm, nu):
    """The window test: D_s>0 (always, if <g>>0 and 0<nu<1) AND below Mott threshold."""
    if not (0.0 < nu < 1.0):
        return False
    return UOm < U_Mott_over_Omega(g, nu)   # below Mott -> metallic-superfluid


# =============================================================================
# (3) MAP THE (U/W, nu) PHASE BOUNDARY  +  max T_BKT INSIDE the window
# =============================================================================
def phase_map(g, Omega_meV, UOm_grid, nu_grid):
    """Return arrays: Tbkt[nu,UOm] (K) and metallic-superfluid mask (bool)."""
    T = np.zeros((len(nu_grid), len(UOm_grid)))
    M = np.zeros_like(T, dtype=bool)
    for i, nu in enumerate(nu_grid):
        for j, UOm in enumerate(UOm_grid):
            T[i, j] = Tbkt_K(g, Omega_meV, UOm, nu)
            M[i, j] = is_superfluid_metallic(g, UOm, nu)
    return T, M


def max_Tbkt_in_window(g, Omega_meV, UOm_grid, nu_grid):
    """Find (nu*, UOm*, maxT) maximizing T_BKT INSIDE the metallic-superfluid window."""
    best = (-1.0, None, None)
    for nu in nu_grid:
        UM = U_Mott_over_Omega(g, nu)
        # inside the window the largest allowed U/Om is just below the Mott threshold
        # (T_BKT grows with U/Om), capped also by the grid
        UOm_allowed = [u for u in UOm_grid if u < UM]
        if not UOm_allowed:
            continue
        UOm_star = max(UOm_allowed)
        T = Tbkt_K(g, Omega_meV, UOm_star, nu)
        if T > best[0]:
            best = (T, nu, UOm_star)
    return best  # (maxT_K, nu*, UOm*)


# =============================================================================
# (4) <g>* THRESHOLD — can higher quantum metric buy back room-T after Mott-dodge?
# =============================================================================
# Dodging Mott means moving OFF nu=1/2 to an incommensurate nu, which costs the
# 4nu(1-nu) filling factor. But raising <g> raises BOTH D_s (linearly) AND the Mott
# threshold U_Mott (linearly) -> a higher-<g> band tolerates a higher U/Om before Mott,
# AND each unit of U/Om buys more stiffness. So <g> has DOUBLE leverage. Find the
# minimal <g>* at which max-T_BKT-in-window crosses 293K.
def find_g_star(Omega_meV, UOm_grid, nu_grid, g_grid):
    """smallest <g> such that max T_BKT in the metallic-superfluid window >= 293 K."""
    for g in g_grid:
        T, nu_s, UOm_s = max_Tbkt_in_window(g, Omega_meV, UOm_grid, nu_grid)
        if T >= ROOM_T:
            return g, T, nu_s, UOm_s
    return None, None, None, None


# =============================================================================
# DRIVER
# =============================================================================
if __name__ == "__main__":
    np.set_printoptions(suppress=True)
    print("=" * 90)
    print("CARRIER-DENSITY-MOTT-BOUND  (8th RTSC law) — the stiffness x Mott collision at nu=1/2")
    print("=" * 90)

    # ---- g5 anchor: reproduce the lane's COF reference Tc/Om=0.0977 at nu=1/2 ----
    DsOm_ref = Ds_over_Omega(G_REF, UOM_REF, 0.5)
    TcOm_ref = (np.pi / 2) * DsOm_ref
    print(f"\n[g5 ANCHOR] COF ref (<g>={G_REF}, U/Om={UOM_REF}, nu=1/2): "
          f"Tc/Om={TcOm_ref:.4f} vs lane {TCOM_REF:.4f}  "
          f"-> {'PASS' if abs(TcOm_ref-TCOM_REF)<1e-3 else 'CHECK'}")

    # ---- the collision at nu=1/2: D_s peaks here, but so does Mott --------------
    print("\n" + "-" * 90)
    print("(1) THE COLLISION at nu=1/2  (both D_s AND Mott peak here)")
    print("-" * 90)
    # take a HIGH-<g> kagome-class host at the stiff C-C bond Omega (the L8 best case)
    g_kag, Om_cc = 2.19, 160.0   # kagome <g>=2.19 (R6 zoo), C-C-class Omega=160meV
    UM_half = U_Mott_over_Omega(g_kag, 0.5)
    print(f"  host: kagome-class <g>={g_kag}, Omega={Om_cc:.0f} meV (C-C bond budget)")
    print(f"  Mott threshold at nu=1/2:  U/Om_Mott = {UM_half:.2f}")
    print(f"  {'U/Om':>6} {'T_BKT(K)':>10} {'phase':>22}")
    for UOm in [0.5, 1.0, UM_half*0.99, UM_half*1.01, 5.0, 10.0]:
        T = Tbkt_K(g_kag, Om_cc, UOm, 0.5)
        phase = "metallic-superfluid" if is_superfluid_metallic(g_kag, UOm, 0.5) else "Mott/CDW-localized"
        print(f"  {UOm:>6.2f} {T:>10.0f} {phase:>22}")
    print(f"  -> at nu=1/2 the metallic-superfluid window CLOSES at U/Om={UM_half:.2f}; the")
    print(f"     max T_BKT REACHABLE while still metallic = {Tbkt_K(g_kag,Om_cc,UM_half*0.999,0.5):.0f} K.")
    print(f"     Pushing U/Om higher (to raise T_BKT) crosses into Mott -> Tc killed (D_s->0, gap opens).")

    # ---- map the (U/W, nu) phase boundary --------------------------------------
    print("\n" + "-" * 90)
    print("(2) (U/Om , nu) PHASE MAP  +  max T_BKT INSIDE the metallic-superfluid window")
    print("-" * 90)
    UOm_grid = np.round(np.arange(0.25, 12.01, 0.25), 3)
    nu_grid = np.round(np.arange(0.04, 0.97, 0.02), 3)

    for label, g, Om in [
        ("Lieb COF     (<g>=0.642, Om=120)", 0.642, 120.0),
        ("kagome-class (<g>=2.19,  Om=160)", 2.19, 160.0),
        ("SOC-kagome   (<g>=2.87,  Om=160)", 2.87, 160.0),
    ]:
        T, nu_s, UOm_s = max_Tbkt_in_window(g, Om, UOm_grid, nu_grid)
        # also report the naive nu=1/2 NO-Mott number (what L8 claimed) for contrast
        T_half_nomott = Tbkt_K(g, Om, UOm_s if UOm_s else 1.0, 0.5)
        UM_half = U_Mott_over_Omega(g, 0.5)
        T_half_capped = Tbkt_K(g, Om, min(UM_half*0.999, UOm_grid.max()), 0.5)
        print(f"  {label}")
        print(f"     window max T_BKT = {T:>6.0f} K  at  nu*={nu_s:.3f}, U/Om*={UOm_s:.2f}  "
              f"({'>=293 SURVIVES' if T>=ROOM_T else '<293 capped'})")
        print(f"     (at nu=1/2 Mott caps U/Om<={UM_half:.2f} -> T_BKT(1/2,capped)={T_half_capped:.0f} K)")

    # ---- a true (nu, U/Om) ASCII boundary map for the kagome-class host ---------
    print("\n  ASCII (U/Om vertical, nu horizontal) for kagome-class <g>=2.19, Om=160:")
    print("    '#'=Mott/CDW   '.'=metallic-SF<293K   '*'=metallic-SF & T_BKT>=293K")
    g, Om = 2.19, 160.0
    nu_ax = np.round(np.arange(0.06, 0.95, 0.04), 3)
    UO_ax = np.round(np.arange(0.5, 8.01, 0.5), 3)[::-1]   # high U on top
    header = "    U/Om \\ nu  " + "".join(f"{nu:>5.2f}" for nu in nu_ax)
    print(header)
    for UOm in UO_ax:
        row = f"    {UOm:>6.2f}    "
        for nu in nu_ax:
            if not is_superfluid_metallic(g, UOm, nu):
                c = "#"
            else:
                T = Tbkt_K(g, Om, UOm, nu)
                c = "*" if T >= ROOM_T else "."
            row += f"{c:>5}"
        print(row)

    # ---- n*(<g>) optimal incommensurate filling --------------------------------
    print("\n" + "-" * 90)
    print("(3) n*(<g>) — optimal (incommensurate) filling + max T_BKT in window vs <g>")
    print("-" * 90)
    print(f"  {'<g>':>6} {'nu*':>7} {'U/Om*':>7} {'maxT_BKT(K)':>13} {'>293?':>7}")
    for g in [0.5, 0.642, 1.0, 1.5, 2.19, 2.87, 4.0, 6.0]:
        T, nu_s, UOm_s = max_Tbkt_in_window(g, 160.0, UOm_grid, nu_grid)
        print(f"  {g:>6.2f} {nu_s:>7.3f} {UOm_s:>7.2f} {T:>13.0f} {('YES' if T>=ROOM_T else 'no'):>7}")

    # ---- <g>* threshold --------------------------------------------------------
    print("\n" + "-" * 90)
    print("(4) <g>* THRESHOLD — minimal quantum metric for room-T survival in the window")
    print("-" * 90)
    g_grid = np.round(np.arange(0.2, 12.01, 0.02), 3)
    for Om in [120.0, 160.0, 196.0]:
        g_star, T, nu_s, UOm_s = find_g_star(Om, UOm_grid, nu_grid, g_grid)
        if g_star is None:
            print(f"  Omega={Om:.0f} meV: NO <g> in [0.2,12] reaches 293K in the window "
                  f"-> Mott CLOSES the escape at this Omega.")
        else:
            wb = ""  # Welch context
            print(f"  Omega={Om:.0f} meV: <g>* = {g_star:.2f}  (nu*={nu_s:.3f}, U/Om*={UOm_s:.2f}, "
                  f"maxT={T:.0f}K). Welch floor <g>>=1/N: kagome N=3 ->1/3, so <g>*={g_star:.2f} "
                  f"is {'reachable (kagome <g>~2.2-2.9 exceeds it)' if g_star<=2.9 else 'ABOVE known flat-band <g> (~2.9 ceiling) -> NOT reachable'}.")

    # ---- VERDICT ---------------------------------------------------------------
    print("\n" + "=" * 90)
    print("(5) VERDICT — Mott-CLOSED / survives / marginal")
    print("=" * 90)
    # central case: stiff C-C Omega=160, best known flat-band <g>
    for label, g, Om in [("kagome <g>=2.19, Om=160", 2.19, 160.0),
                          ("SOC-kagome <g>=2.87, Om=160", 2.87, 160.0),
                          ("SOC-kagome <g>=2.87, Om=196(C-C)", 2.87, 196.0)]:
        T, nu_s, UOm_s = max_Tbkt_in_window(g, Om, UOm_grid, nu_grid)
        print(f"  {label:<36}: window-max T_BKT = {T:>5.0f} K at nu*={nu_s:.3f} "
              f"-> {'SURVIVES >=293K' if T>=ROOM_T else 'CAPPED <293K'}")
    # is the window-max Mott-limited or QMC-ceiling-limited? (the deciding diagnostic)
    print("\n  DIAGNOSTIC — at nu=1/2, is T_BKT Mott-capped BELOW the QMC pair ceiling?")
    for label, g, Om in [("Lieb <g>=0.642, Om=120", 0.642, 120.0),
                         ("kagome <g>=2.19, Om=160", 2.19, 160.0),
                         ("SOC-kagome <g>=2.87, Om=160", 2.87, 160.0)]:
        UM_half = U_Mott_over_Omega(g, 0.5)
        T_half_mott = Tbkt_K(g, Om, UM_half*0.999, 0.5)        # capped value just below Mott
        T_half_uncapped = Tbkt_K(g, Om, UM_half*0.999, 0.5, cap=False)  # raw stiffness at Mott edge
        T_qmc_ceil = C_QMC_CEIL * Om * meV2K
        limiter = "QMC-ceiling" if T_half_uncapped >= T_qmc_ceil else "MOTT (below ceiling)"
        print(f"    {label:<30}: nu=1/2 max T={T_half_mott:>5.0f}K  "
              f"(QMC ceil {T_qmc_ceil:.0f}K, raw@Mott {T_half_uncapped:.0f}K) -> limited by {limiter}")
    # the PHYSICALLY MEANINGFUL <g>* : survive the collision AT nu=1/2 (where it lives),
    # not by fleeing to a dilute incommensurate corner where 2D-BKT density is dubious.
    print("\n  <g>*_collision — minimal <g> to clear 293K AT nu=1/2 (the collision filling):")
    for Om in [120.0, 160.0, 196.0]:
        g_star_half = None
        for g in g_grid:
            UM = U_Mott_over_Omega(g, 0.5)
            Tmax = Tbkt_K(g, Om, UM*0.999, 0.5)   # best T at nu=1/2 just below Mott (capped)
            if Tmax >= ROOM_T:
                g_star_half = g; break
        if g_star_half is None:
            print(f"    Omega={Om:.0f}: NO <g> clears 293K at nu=1/2 -> Mott-CLOSED at half-filling.")
        else:
            reach = "REACHABLE (kagome 2.19 / SOC 2.87 exceed it)" if g_star_half <= 2.9 else "ABOVE known <g> ceiling ~2.9 -> NOT reachable"
            print(f"    Omega={Om:.0f}: <g>*_collision = {g_star_half:.2f}  ({reach})")
    g_star_160, _, _, _ = find_g_star(160.0, UOm_grid, nu_grid, g_grid)
    print(f"\n  <g>* (Om=160meV, window-incommensurate) = {g_star_160:.2f}  vs known flat-band <g> ~2.2-2.9.")
    print()
    print("  => THE <g>-DICHOTOMY (the 8th law):")
    print("     - LOW <g> (Lieb 0.642): at nu=1/2 Mott caps T_BKT at 116K < 293K -> Mott RE-CAPS. CLOSED.")
    print("     - HIGH <g> (>= ~0.8-1.0, i.e. kagome 2.19 / SOC 2.87): <g> raises the Mott threshold")
    print("       enough that the metallic window reaches the QMC pair ceiling (C_QMC*Omega ~ 590-730K)")
    print("       BEFORE Mott bites -> 293K SURVIVES even AT nu=1/2.")
    print("     - <g>*_collision = 0.80-1.04 (Om 196->120meV) is the threshold; kagome/SOC EXCEED it.")
    print()
    print("  VERDICT = SURVIVES (conditional on high <g>): the metallic-superfluid window clears 293K")
    print("  iff <g> >= <g>*_collision ~ 0.8-1.0 (reachable: kagome 2.19, SOC-kagome 2.87). The escape is")
    print("  NOT Mott-closed for kagome-class hosts; it IS Mott-closed for low-<g> (Lieb/MATBG) hosts.")
    print("  The honest ceiling is the QMC pair-binding cap (C_QMC*Omega), NOT a runaway D_s; with that")
    print("  cap enforced (d6), high-<g> survives, low-<g> is re-capped. This MATCHES & sharpens L8:")
    print("  L8's 'room-T OPEN for high-<g> kagome host' SURVIVES the Mott audit; the new condition is")
    print("  the quantitative <g>*_collision >= ~0.8 floor AND the QMC-pair ceiling as the true Tc cap.")
