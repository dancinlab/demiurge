"""
escape_9th_anharmonic.py  —  RTSC FLEET d2 wall-breakthrough probe on the 9th law
STIFF-BOND-WEAK-SSH-BINDING:  g/t = 2 u0/d_bond ∝ 1/√Ω  (harmonic, Harrison).

The 9th law CLOSED the ambient bond-bipolaron room-T escape: BK-borophene's
per-bond SSH coupling g/t = 0.057 is ~21× below the 2-body ED binding threshold
g*/t ≈ 1.2, and the closure is STRUCTURAL (t cancels; u0 ∝ 1/√Ω, so making the
bond stiffer to keep Ω high makes the zero-point amplitude — hence g/t — SMALLER).

This script tests whether physics BEYOND the harmonic / linear-Harrison / 2-body
assumptions reopens the escape. Each assumption is a candidate loophole:

  L1  ANHARMONIC large-amplitude u_eff  (does u_eff break 1/√Ω?)
  L2  NON-LINEAR / 2nd-order SSH  g2·u^2  (does ∂²t/∂u² evade suppression?)
  L3  MULTI-BOND / COORDINATION  Z bonds per site  (highest priority recheck of
        BK-borophene's per-bond 0.057 → should it be ×coordination?)
  L4  QUANTUM-NUCLEAR / isotope / path-integral

For each: a closed-form scaling argument + a numerical estimate of whether it can
push g/t (or the EFFECTIVE binding metric) ≳ 1.2 at high Ω, an explicit REAL-
LOOPHOLE / COLLAPSES verdict, ranked by plausibility. Honest (d6): most loopholes
also fail; this names which (if any) survives.

Pure numpy. NO pod, NO commit. Reuses BK-borophene anchors from bkborophene_dft.

ANCHORS (from bkborophene_dft_results.json):
  t = 0.075 eV ;  Ω(B-B stiff) = 167 meV ;  u0 = 4.81 pm ;  d_bond = 1.70 Å
  g_SSH = 4.25 meV ;  g/t = 0.0566 ;  g*/t (2-body ED binding) ≈ 1.20
  coupling shortfall = 21.2×
"""

import numpy as np
import json

HBAR = 1.054571817e-34      # J s
AMU  = 1.66053907e-27       # kg
EV   = 1.602176634e-19      # J
MEV  = 1e-3 * EV
ANG  = 1e-10                # m
PM   = 1e-12               # m

# ---- BK-borophene anchors (terminal compute) -------------------------------
T_EV      = 0.075           # band hopping
OMEGA_MEV = 167.0           # stiff B-B stretch mode
U0_PM     = 4.812           # harmonic zero-point amplitude = sqrt(hbar/2 M Omega)
D_BOND_A  = 1.70            # B-B bond length
M_B_AMU   = 10.81           # boron mass (reduced mass of B-B ~ 10.81/2 = 5.4)
GT_REAL   = 0.0566          # per-bond SSH g/t
GT_THRESH = 1.20            # 2-body ED binding threshold
SHORTFALL = GT_THRESH / GT_REAL    # ~21.2


def u0_harmonic(Mred_amu, Omega_meV):
    """harmonic zero-point amplitude u0 = sqrt(hbar/(2 M Omega))  [pm]."""
    Mred = Mred_amu * AMU
    Omega = Omega_meV * MEV / HBAR        # rad/s
    u0 = np.sqrt(HBAR / (2.0 * Mred * Omega))   # m
    return u0 / PM


def gt_harmonic(u0_pm, d_A):
    """Harrison per-bond dimensionless SSH coupling g/t = 2 u0 / d  (t cancels)."""
    return 2.0 * (u0_pm * PM) / (d_A * ANG)


# ============================================================================
# L1  ANHARMONIC / large-amplitude soft mode
# ============================================================================
def loophole_anharmonic():
    """
    Claim: a soft anharmonic double-well / quartic mode has a LARGER effective
    zero-point spread u_eff than the harmonic sqrt(hbar/2MΩ) at the same nominal Ω,
    lifting g/t = 2 u_eff/d above threshold while keeping Ω high.

    TEST the scaling. Two regimes:

    (a) PURE QUARTIC well  V = (1/2) c4 u^4 (no harmonic term).
        Dimensional analysis: the only length is l4 = (hbar^2/(M c4))^(1/6).
        The ground-state spread <u^2>^(1/2) ~ l4, and the level spacing
        (an "effective Ω") is hbar ω_eff ~ hbar^2/(M l4^2) = (hbar^4 c4 / M^2)^(1/3).
        Eliminate c4:  <u^2> ~ (hbar/(M ω_eff)) * O(1)  — IDENTICAL Ω-scaling to
        harmonic. A quartic well gives u_eff ∝ 1/√(M ω_eff): NO new scaling, only
        an O(1) prefactor (~1.3 for pure quartic). 1/√Ω SURVIVES.

    (b) DOUBLE-WELL  V = -(1/2)κ u^2 + (1/4)b u^4, wells at ±u_min, barrier Δ.
        IF the proton/H tunnels between wells (low barrier), the spatial spread
        is set by u_min (the well separation), NOT by sqrt(hbar/2MΩ_local). This
        CAN give u_eff ≫ harmonic — BUT only when the RELEVANT mode frequency is
        the SPLITTING ω_tun ≪ Ω_local, i.e. the mode is SOFT, not stiff.
        The 9th law / target box REQUIRES Ω ≳ 160 meV (criterion-2, for a high
        prefactor in Tc and for the Eliashberg/bipolaron energy scale). A soft
        tunneling mode has ω_tun of meV-scale → it FAILS criterion-2. You cannot
        simultaneously have (high Ω for the energy scale) AND (large u_eff from a
        soft well) — they are the SAME mode. So the double-well buys u_eff at the
        cost of Ω: the product g·Ω-budget is conserved.

    Quantify the trade. For a double well, the USABLE coupling-energy is
    g_eff ~ (∂t/∂u)·u_min and the phonon energy is ω_tun. The binding metric in
    the SSH bipolaron is governed by g/t (dimensionless coupling) AND Ω/t
    (anti-adiabaticity). We compute the EFFECTIVE g/t boost vs the Ω penalty.
    """
    # harmonic baseline at the stiff Ω
    Mred = M_B_AMU / 2.0
    u0_h = u0_harmonic(Mred, OMEGA_MEV)
    gt_h = gt_harmonic(u0_h, D_BOND_A)

    # (a) pure quartic prefactor: <u^2>^(1/2)/u0_harmonic at matched level spacing.
    # For V=(1/2)Mω0^2 u^2 vs pure quartic matched so the ground gap equals hbar ω0:
    # numeric solution of the quartic oscillator gives <u^2>_quartic / <u^2>_harm ~ 1.7
    # at matched fundamental gap -> u_eff ratio ~ sqrt(1.7) ~ 1.30.
    quartic_ueff_boost = 1.30
    gt_quartic = gt_h * quartic_ueff_boost

    # (b) double-well: scan well separation u_min and the resulting tunneling Ω.
    # WKB-ish: for a symmetric double well, ω_tun = ω0 * exp(-S/hbar) with barrier
    # action S ~ sqrt(2 M Δ)·(2 u_min). Larger u_min -> larger u_eff (~u_min) BUT
    # exponentially smaller ω_tun. We require Ω_eff >= 160 meV (criterion-2).
    rows = []
    Mred_kg = Mred * AMU
    omega0_rad = (OMEGA_MEV * MEV) / HBAR    # local-well curvature freq
    for umin_pm in [10, 20, 40, 80, 160]:
        umin = umin_pm * PM
        # barrier height for a double well whose well-curvature is omega0:
        # V'' at well = M omega0^2 ; for V=-a u^2/2 + b u^4/4, u_min=sqrt(a/b),
        # curvature at min = 2a = M omega0^2 -> a = M omega0^2/2, barrier Δ = a^2/4b
        #   = a u_min^2/4 = (M omega0^2/2) u_min^2 /4 = M omega0^2 umin^2 /8
        Delta = Mred_kg * omega0_rad**2 * umin**2 / 8.0      # J
        # tunneling action across barrier (instanton, order of magnitude)
        S = np.sqrt(2.0 * Mred_kg * Delta) * (2.0 * umin)    # J s
        omega_tun = omega0_rad * np.exp(-S / HBAR)
        Omega_eff_meV = omega_tun * HBAR / MEV
        # effective spread ~ umin (delocalized over both wells) -> g/t boost
        gt_dw = gt_harmonic(umin_pm, D_BOND_A)               # treat umin as u_eff
        meets_stiff = Omega_eff_meV >= 160.0
        rows.append(dict(umin_pm=umin_pm, Delta_meV=Delta/MEV,
                         Omega_eff_meV=Omega_eff_meV, gt_eff=gt_dw,
                         meets_stiff_160=bool(meets_stiff),
                         gt_x_thresh=gt_dw / GT_THRESH))

    # verdict: does ANY double-well row reach gt>=1.2 WHILE Omega_eff>=160?
    survivor = any(r["gt_eff"] >= GT_THRESH and r["meets_stiff_160"] for r in rows)

    return dict(
        name="L1 ANHARMONIC large-amplitude / double-well soft mode",
        gt_harmonic=gt_h,
        gt_pure_quartic=gt_quartic,
        quartic_boost=quartic_ueff_boost,
        double_well_scan=rows,
        survivor=bool(survivor),
        verdict=("COLLAPSES — pure quartic gives only an O(1) (~1.3×) prefactor, "
                 "still 1/√Ω; double-well buys large u_eff ONLY by softening the "
                 "mode (ω_tun ≪ 160 meV), which FAILS criterion-2. The high-Ω and "
                 "large-u_eff requirements are the SAME mode and trade off — "
                 "g·(Ω-budget) conserved. NOT a real loophole."),
        plausibility="LOW",
        boost_factor=quartic_ueff_boost,   # the only honest boost: ~1.3×
    )


# ============================================================================
# L2  NON-LINEAR / 2nd-order SSH  (g2 u^2)
# ============================================================================
def loophole_2nd_order_ssh():
    """
    Claim: when the linear ∂t/∂u is symmetry-forbidden or small, the 2nd-order
    term t(u) = t0 + (1/2)(∂²t/∂u²) u^2 dominates, with different M,Ω scaling that
    might evade the 1/√Ω suppression.

    The 2nd-order coupling matrix element involves <u^2> = u0^2 (not u0). The
    effective coupling acts at TWO-phonon order:
        g2_eff / t = (1/2)|∂²t/∂u²| u0^2 / t.
    With Harrison t ~ 1/d^2:  ∂²t/∂u² = +6 t0 / d^2  (from d^-2 second derivative,
    |∂²t/∂u²| = (2)(3) t0/d^2 = 6 t0/d^2). So
        g2/t = (1/2)(6/d^2) u0^2 = 3 (u0/d)^2.
    Compare linear g1/t = 2 u0/d. Ratio g2/g1 = (3/2)(u0/d). With u0/d = 0.028
    (=0.0566/2), g2/g1 = 0.042 -> the 2nd-order term is ~24× SMALLER than the
    (already too-small) linear term. And it scales as u0^2 ∝ 1/Ω — a STEEPER
    suppression with stiffness, not a milder one.

    Even if symmetry KILLS the linear term entirely (g1=0, e.g. a bond at an
    inversion center where ∂t/∂u=0 by parity), the surviving g2/t = 3(u0/d)^2 =
    3·(0.028)^2 = 0.0024 — ~500× below threshold and ∝1/Ω. WORSE, not better.
    """
    u0_over_d = (U0_PM * PM) / (D_BOND_A * ANG)
    g1_t = 2.0 * u0_over_d
    g2_t = 3.0 * u0_over_d**2
    ratio = g2_t / g1_t
    return dict(
        name="L2 NON-LINEAR / 2nd-order SSH (g2 u^2)",
        u0_over_d=u0_over_d,
        g1_over_t=g1_t,
        g2_over_t=g2_t,
        g2_to_g1_ratio=ratio,
        scaling="g2/t = 3(u0/d)^2 ∝ u0^2 ∝ 1/Ω (STEEPER suppression than linear 1/√Ω)",
        survivor=False,
        verdict=("COLLAPSES — 2nd-order g2/t = 3(u0/d)^2 = %.4f is ~%.0f× smaller "
                 "than the linear coupling and scales as 1/Ω (steeper). Even with "
                 "the linear term symmetry-forbidden, g2/t ~ 0.002 (~500× short). "
                 "Higher-order SSH makes the wall WORSE, not better."
                 % (g2_t, 1.0 / ratio)),
        plausibility="VERY LOW",
        boost_factor=ratio,    # < 1: anti-boost
    )


# ============================================================================
# L3  MULTI-BOND / COORDINATION  (HIGHEST PRIORITY — BK recheck)
# ============================================================================
def loophole_coordination():
    """
    HIGHEST PRIORITY. The terminal BK-borophene verdict used the PER-BOND SSH
    coupling g/t = 0.057. But each site in a kagome line-graph sits on Z bonds
    (kagome coordination Z=4: each kagome site is shared by 2 triangles, 4 NN
    bonds). A carrier hopping on/off a site modulates ALL Z bonds. Does the
    site-resolved coupling that enters the bipolaron binding pick up a factor of
    coordination — turning 0.057 into ~Z·0.057 or √Z·0.057?

    This is the concrete "factor-of-few the terminal lane may have missed."
    We work out the correct power of Z carefully — INCOHERENT vs COHERENT sum.

    SETUP. SSH Hamiltonian:  H_ep = Σ_<ij> g_ij (c_i^† c_j + h.c.)(b_ij + b_ij^†),
    one INDEPENDENT Einstein phonon per BOND (b_ij). The per-bond coupling is
    g_bond = (∂t/∂u) u0 = 0.057 t.

    The polaron self-energy / binding is governed by the dimensionless
    coupling that appears in the lattice polaron problem,
        λ_SSH = (effective coupling^2) / (phonon energy × bandwidth).
    The relevant question for the 2-body binding THRESHOLD g*/t ≈ 1.2 is: what is
    the EFFECTIVE single g that a pair of electrons feels, summing over the bonds
    that connect to the sites they occupy.

    KEY PHYSICS — the phonons are PER-BOND and INDEPENDENT (each bond has its own
    b_ij). A site connected to Z bonds couples to Z DISTINCT, uncorrelated
    oscillators. The static lattice relaxation energy (polaron energy) from a
    carrier sitting at a site is the SUM of independent bond relaxations:
        E_pol = Σ_{Z bonds} g_bond^2 / Ω  =  Z · g_bond^2 / Ω.
    So the EFFECTIVE single-channel coupling squared is g_eff^2 = Z·g_bond^2, i.e.
        g_eff = √Z · g_bond.     <-- INCOHERENT (independent-phonon) sum.
    NOT Z·g_bond: that would require all Z bond-phonons to respond COHERENTLY to
    a single collective coordinate, which they do NOT (independent Einstein modes).

    THEREFORE the coordination boost to the dimensionless coupling is √Z, not Z.
    For kagome Z=4:  g_eff/t = √4 · 0.057 = 2 · 0.057 = 0.113.

    BUT — there is a crucial subtlety that the simple √Z sum HIDES, and it CUTS
    THE OTHER WAY for the BINDING threshold. The 2-body bipolaron BINDS when two
    electrons SHARE a phonon cloud (bond-deformation) so the lattice mediates an
    attraction. For an SSH/bond phonon, the SHARED bond is the one BETWEEN the two
    electrons (they must occupy the two ends of the SAME bond to both couple to
    its b_ij). The coordination Z multiplies the SELF-energy (single-particle
    polaron, both electrons) but the mutual ATTRACTION still flows through the
    shared bond(s). For a pair localized on a single bond, only that 1 bond is
    shared; for a pair delocalized over a triangle (kagome plaquette), up to ~2-3
    bonds are mutually shared.

    So the binding-relevant boost is between:
       √(Z_shared) for the attraction  (Z_shared ~ 1-3 for a kagome plaquette pair)
    and the threshold g*/t≈1.2 was computed for a SINGLE shared bond. The honest
    upper bound on the coordination enhancement of the binding-relevant coupling is
       g_eff/t ≈ √Z · g_bond/t  with Z up to the full coordination 4 (most
    generous: every bond touching the pair contributes coherently to the cloud).

    We report BOTH the conservative (√Z_shared, Z_shared~2) and the generous
    (√Z_full, Z=4) and even the (physically WRONG but worst-case) coherent Z=4
    estimate, then check each against threshold 1.2.
    """
    g_bond_t = GT_REAL
    Z_full = 4          # kagome site coordination
    Z_shared_pair = 2   # bonds mutually shared by a plaquette-localized pair (gen.)

    estimates = {
        "per_bond (terminal verdict)":      g_bond_t,
        "sqrt(Z_shared=2) incoherent":      np.sqrt(Z_shared_pair) * g_bond_t,
        "sqrt(Z_full=4) incoherent":        np.sqrt(Z_full) * g_bond_t,
        "Z_full=4 COHERENT (wrong/worst)":  Z_full * g_bond_t,
    }
    # which (if any) crosses threshold?
    crossings = {k: (v, v >= GT_THRESH, GT_THRESH / v) for k, v in estimates.items()}

    # The BEST honest estimate = sqrt(Z_full) incoherent = 0.113.
    best_honest = np.sqrt(Z_full) * g_bond_t
    best_honest_shortfall = GT_THRESH / best_honest
    # Even the physically-too-generous coherent Z=4 = 0.226, still short:
    coherent_shortfall = GT_THRESH / (Z_full * g_bond_t)

    survivor = any(v >= GT_THRESH for v in estimates.values())

    return dict(
        name="L3 MULTI-BOND / COORDINATION (kagome line-graph, Z=4)",
        g_bond_over_t=g_bond_t,
        Z_full=Z_full,
        estimates={k: float(v) for k, v in estimates.items()},
        crossings={k: dict(g_over_t=float(v[0]), crosses_thresh=bool(v[1]),
                           remaining_shortfall=float(v[2]))
                   for k, v in crossings.items()},
        best_honest_g_over_t=float(best_honest),
        best_honest_shortfall=float(best_honest_shortfall),
        coherent_worst_case_g_over_t=float(Z_full * g_bond_t),
        coherent_worst_case_shortfall=float(coherent_shortfall),
        physics=("Per-bond phonons are INDEPENDENT Einstein modes -> coordination "
                 "enters the polaron self-energy as a SUM of squares -> g_eff = "
                 "√Z·g_bond (incoherent), NOT Z·g_bond. Kagome Z=4 -> ×2 boost -> "
                 "g/t = 0.113. The mutual ATTRACTION flows through SHARED bonds "
                 "only (Z_shared~1-3 for a plaquette pair), so the binding-relevant "
                 "boost is ≤ ×2. The threshold g*/t≈1.2 was per-shared-bond."),
        survivor=bool(survivor),
        verdict=("REAL but INSUFFICIENT — coordination IS a genuine factor the "
                 "per-bond number missed: kagome Z=4 gives a √Z=×2 boost, "
                 "g/t: 0.057 -> 0.113. The terminal verdict's per-bond 0.057 was "
                 "an UNDER-estimate by ~2×. HOWEVER even the most generous "
                 "(physically-too-strong COHERENT Z=4) estimate g/t=0.226 is still "
                 "%.1f× below the binding threshold 1.2. The √Z=×2 honest boost "
                 "leaves a %.1f× shortfall. The wall MOVES but does NOT break: "
                 "21× -> ~11× (honest) or ~5× (worst-case). NO escape."
                 % (coherent_shortfall, best_honest_shortfall)),
        plausibility="MEDIUM (real factor) but NON-ESCAPING",
        boost_factor=float(np.sqrt(Z_full)),   # honest ×2
    )


# ============================================================================
# L4  QUANTUM-NUCLEAR / isotope / path-integral
# ============================================================================
def loophole_quantum_nuclear():
    """
    Claim: treating nuclei quantum (path-integral) rather than classical changes
    the binding.

    But the 9th law ALREADY treats the nucleus quantum-mechanically: u0 =
    sqrt(hbar/2MΩ) IS the quantum zero-point amplitude (hbar present). There is
    no further "quantum boost" to extract — the harmonic ground-state spread is
    the full quantum result for a harmonic mode. Anharmonic quantum corrections
    are L1 (already shown ~1.3× at most). ISOTOPE: lighter isotope (e.g. H vs D)
    INCREASES u0 ∝ 1/√M -> increases g/t. This is the ONLY lever inside the
    quantum-nuclear family that helps, and it is bounded by the lightest stable
    nucleus.

    Quantify the isotope lever. g/t ∝ u0 ∝ 1/√M. Going from boron (M=10.8) to
    the lightest covalent former that still makes a stiff bond:
       - H (M=1): 1/√M boost = √(10.8/1) = 3.29× -> g/t = 0.057·3.29 = 0.187.
         BUT a hydrogen "bond" at Ω=167 meV with H zero-point is exactly the
         hydride regime (already exhausted, Regime I), and H doesn't form the
         stiff covalent FRAMEWORK bonds of a kagome line-graph — it's an
         interstitial. Treating the framework atom AS hydrogen is unphysical.
       - Li/Be (M~7-9): negligible vs boron.
       - The honest framework-former floor is boron/carbon (M~11-12); going to
         the lightest plausible STIFF-FRAMEWORK former buys at most √(11/9)~1.1×.

    So quantum-nuclear adds NO new scaling (it IS the harmonic quantum result)
    and the isotope lever, restricted to physical stiff-framework formers, gives
    ≤1.1×; the unphysical "make it hydrogen" gives 3.3× but lands back in the
    exhausted hydride/Regime-I space and is not a kagome framework bond.
    """
    Mb = 10.81
    iso = {}
    for el, M in [("H (unphysical framework)", 1.008),
                  ("Be", 9.012), ("B (anchor)", 10.81),
                  ("C", 12.011)]:
        boost = np.sqrt(Mb / M)
        iso[el] = dict(M=M, u0_boost=float(boost),
                       g_over_t=float(GT_REAL * boost))
    # physical floor: lightest stiff-framework former that is NOT hydride space
    phys_boost = np.sqrt(Mb / 9.012)   # ~Be/B framework, ~1.09x
    return dict(
        name="L4 QUANTUM-NUCLEAR / isotope / path-integral",
        isotope_scan=iso,
        physical_framework_boost=float(phys_boost),
        physical_g_over_t=float(GT_REAL * phys_boost),
        survivor=False,
        verdict=("COLLAPSES — u0=√(ħ/2MΩ) is ALREADY the quantum (path-integral, "
                 "harmonic) result; there is no extra quantum boost. The only "
                 "lever is isotope mass (g/t ∝ 1/√M). Restricted to physical "
                 "stiff-FRAMEWORK formers (B/C/Be) it gives ≤1.1×. The 3.3× "
                 "'make it hydrogen' lands back in the exhausted hydride/Regime-I "
                 "space and is an interstitial, not a kagome framework bond. No "
                 "new scaling, no escape."),
        plausibility="VERY LOW",
        boost_factor=float(phys_boost),   # ~1.1x physical
    )


# ============================================================================
# COMBINED best-case stack (are the loopholes multiplicative? honest ceiling)
# ============================================================================
def combined_ceiling(results):
    """
    Most generous HONEST stack: multiply the independent boost factors and ask if
    the product crosses threshold. (This OVER-counts — the boosts are not all
    independent: anharmonic u_eff and isotope both act on u0; coordination is a
    separate channel. We still stack them as a strict upper bound.)
    """
    # honest boosts: anharmonic quartic 1.3, coordination √4=2, isotope 1.1
    # (L2 2nd-order is an ANTI-boost, excluded from the favorable stack)
    b_anh = results["L1"]["boost_factor"]        # 1.30
    b_coord = results["L3"]["boost_factor"]      # 2.00
    b_iso = results["L4"]["boost_factor"]        # ~1.09
    stacked = GT_REAL * b_anh * b_coord * b_iso
    # also the WORST-CASE (physically-too-strong) stack with coherent Z=4:
    worst = GT_REAL * b_anh * 4.0 * b_iso
    return dict(
        honest_boosts=dict(anharmonic=b_anh, coordination=b_coord, isotope=b_iso),
        stacked_g_over_t_honest=float(stacked),
        stacked_shortfall_honest=float(GT_THRESH / stacked),
        crosses_threshold_honest=bool(stacked >= GT_THRESH),
        worst_case_g_over_t=float(worst),
        worst_case_shortfall=float(GT_THRESH / worst),
        crosses_threshold_worst=bool(worst >= GT_THRESH),
        note=("Even multiplying ALL favorable boosts (anharmonic 1.3 × coordination "
              "2.0 × isotope 1.1 = 2.9×) the realistic g/t reaches only %.3f, still "
              "%.1f× below threshold 1.2. The physically-too-generous coherent-Z=4 "
              "stack reaches %.3f, still %.1f× short. The 9th-law closure is ROBUST."
              % (GT_REAL * 1.30 * 2.00 * 1.09,
                 GT_THRESH / (GT_REAL * 1.30 * 2.00 * 1.09),
                 GT_REAL * 1.30 * 4.0 * 1.09,
                 GT_THRESH / (GT_REAL * 1.30 * 4.0 * 1.09))),
    )


def main():
    L1 = loophole_anharmonic()
    L2 = loophole_2nd_order_ssh()
    L3 = loophole_coordination()
    L4 = loophole_quantum_nuclear()
    results = {"L1": L1, "L2": L2, "L3": L3, "L4": L4}
    comb = combined_ceiling(results)

    any_escape = any(r["survivor"] for r in results.values()) or \
                 comb["crosses_threshold_honest"]

    print("=" * 78)
    print("9th-law (STIFF-BOND-WEAK-SSH-BINDING) escape probe — loophole scoreboard")
    print("=" * 78)
    print(f"Anchor: BK-borophene per-bond g/t = {GT_REAL:.3f}, threshold g*/t = "
          f"{GT_THRESH:.2f}, shortfall {SHORTFALL:.1f}×\n")
    print(f"{'loophole':<46}{'boost':>7}{'g/t':>8}{'verdict':>10}")
    print("-" * 78)
    order = sorted(results.items(),
                   key=lambda kv: -kv[1]["boost_factor"])
    for k, r in order:
        gt = GT_REAL * r["boost_factor"]
        v = "SURVIVES" if r["survivor"] else "COLLAPSES"
        print(f"{r['name'][:45]:<46}{r['boost_factor']:>6.2f}x{gt:>8.3f}{v:>10}")
    print("-" * 78)
    print(f"{'COMBINED honest stack (all favorable)':<46}"
          f"{2.9:>6.1f}x{comb['stacked_g_over_t_honest']:>8.3f}"
          f"{'COLLAPSES' if not comb['crosses_threshold_honest'] else 'SURVIVES':>10}")
    print(f"{'COMBINED worst-case (coherent Z=4 stack)':<46}"
          f"{'':>7}{comb['worst_case_g_over_t']:>8.3f}"
          f"{'COLLAPSES' if not comb['crosses_threshold_worst'] else 'SURVIVES':>10}")
    print("=" * 78)
    print("\nPER-MECHANISM VERDICTS\n")
    for k in ["L3", "L1", "L4", "L2"]:   # ranked by plausibility
        r = results[k]
        print(f"[{k}] {r['name']}  — plausibility {r['plausibility']}")
        print(f"    {r['verdict']}\n")

    print("KEY RECHECK — BK-borophene coordination enhancement:")
    print(f"    per-bond g/t (terminal) = {L3['g_bond_over_t']:.3f}")
    for k, v in L3["estimates"].items():
        sh = GT_THRESH / v
        print(f"    {k:<34} g/t = {v:.3f}   ({sh:.1f}× short)")
    print(f"    -> honest √Z=4 boost: g/t = {L3['best_honest_g_over_t']:.3f} "
          f"({L3['best_honest_shortfall']:.1f}× short)")
    print(f"    -> the terminal per-bond 0.057 was an under-estimate by ~2×, "
          f"but 0.113 still does NOT bind.\n")

    final = ("ESCAPE REOPENS" if any_escape else
             "CLOSURE ROBUST — all four loopholes fail; 9th law holds")
    print("=" * 78)
    print(f"FINAL VERDICT: {final}")
    print("=" * 78)
    print(comb["note"])

    out = dict(
        anchor=dict(g_over_t_per_bond=GT_REAL, threshold=GT_THRESH,
                    shortfall=SHORTFALL),
        loopholes=results,
        combined=comb,
        any_escape=bool(any_escape),
        final_verdict=final,
    )
    # strip numpy types
    def clean(o):
        if isinstance(o, dict):
            return {k: clean(v) for k, v in o.items()}
        if isinstance(o, (list, tuple)):
            return [clean(x) for x in o]
        if isinstance(o, (np.floating,)):
            return float(o)
        if isinstance(o, (np.integer,)):
            return int(o)
        if isinstance(o, (np.bool_,)):
            return bool(o)
        return o
    with open(__file__.replace(".py", "_results.json"), "w") as f:
        json.dump(clean(out), f, indent=2)
    print("\nwrote escape_9th_anharmonic_results.json")
    return out


if __name__ == "__main__":
    main()
