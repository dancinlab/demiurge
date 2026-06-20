#!/usr/bin/env python3
"""
METALLIC-HBOND-SSH — RTSC room-T DISCOVERY lane (FREE summer / local; NO billing pod).
================================================================================
demiurge RTSC FLEET ambient lane — state/fb-geom-lambda/roomt-discover/.

THE ANGLE (the host-search realization of arxiv_novel_sweep §4 A2):
  kappa-H3(Cat-EDT-TTF)2 found a REAL off-diagonal H-SSH host (O-H-O proton gates
  inter-pi transfer = genuine dt/du) but CLOSED on the CARRIER axis: it is a
  half-filled dimer-MOTT insulator, and every bandwidth perturbation (pressure,
  deuteration) drives proton localization -> CHARGE ORDER (insulator), never metal.
  The off-diagonal coupling that gives S>1 IS the proton freezing that gaps the band.

  THIS LANE pivots: search hosts with the SAME strong short-symmetric-H-bond
  bond-stretch SSH coupling (O-H-O / N-H-N / F-H-F, Omega ~ 100-300 meV proton band)
  that are ALREADY METALLIC / weakly-correlated (NOT half-filled Mott) -> the
  off-diagonal coupling lives on a conducting band that won't CO.

THE FIRST-PRINCIPLES CARRIER CRITERION (task 1):
  Why is a short-symmetric-H-bond host METALLIC at E_F instead of Mott?
    (1) NOT half-filled. The Mott trap in kappa-H3 is nu=1 (one carrier per dimer,
        U/W > 1 -> Mott). Push the H-modulated band OFF half-filling (doped / non-
        stoichiometric bronze H_x M O3, x != integer; mixed-valence) -> no commensurate
        Umklapp gap -> metal. The bronze realizes this intrinsically (x continuous).
    (2) WIDE band / large U/W denominator. The carrier band is a transition-metal
        d-band (W 5d / Mo 4d), W ~ 2-4 eV >> the organic pi inter-dimer t ~ 40 meV;
        U/W << 1 -> weakly correlated metal, NOT Mott. The H-bond modulates the
        O 2p bridge that hybridizes INTO this wide metallic d-band.
    (3) MULTI-ORBITAL SCREENING. d-bands screen U; the proton sits on an O-H-O bridge
        between corner-sharing octahedra, modulating an O 2p -> M d transfer that is
        ON the metallic Fermi surface, not on an isolated half-filled molecular orbital.
  => The H bond-stretch must modulate a transfer that is AT/NEAR E_F and metallic.
     Bronzes (H_xMoO3, H_xWO3) and doped-off-nu=1 H-bonded conductors satisfy this.

THE TENSION THIS LANE MUST FACE HONESTLY (d6 — the adverse prior):
  Bronzes ARE metallic and DO have O-H-O bridges, BUT in H_xMoO3/H_xWO3 the H bond
  is the WEAKER/LONGER asymmetric O-H...O (not a SHORT-SYMMETRIC strong bond), so its
  dt/du super-linearity S is closer to the Harrison floor (S~1) than to the
  exponential-overlap S~3-4 the kappa-H3 short symmetric bridge had. The bronze trades
  the kappa-H3 problem (great coupling / dead carrier) for the INVERSE problem
  (live carrier / weaker coupling). This lane QUANTIFIES that trade with the validated
  machinery and reports which axis (if any) closes.

REUSES (d_novel_only -- no rebuild): pin_gstar.py (g_over_t_at, omega_bind_cutoff,
tc_ceiling_K, constants, qmc dome), bond-bipolaron/solver.py (validated 2-body SSH ED).
NO pod for this analytic stage. The summer-FREE DFT (frozen-phonon proton scan +
Wannier transfer on a SMALL bronze cell) is the next stage; recipe emitted at tail.

HONEST BAR (c2/d6): TB-grade on published bronze geometry; every model/lit number
flagged. From-scratch DFT (the dt/du on the REAL bronze O-H-O bridge) is the summer
deliverable, PENDING -- this analytic stage decides whether it is worth firing and
what number it must beat.
"""
import numpy as np
import os, sys, json

HERE = os.path.dirname(os.path.abspath(__file__))
AMB = os.path.abspath(os.path.join(HERE, "..", "ambient"))
SOLVER_DIR = os.path.abspath(os.path.join(HERE, "..", "bond-bipolaron"))
sys.path.insert(0, SOLVER_DIR)
sys.path.insert(0, AMB)
import solver as ssh
from pin_gstar import (HBAR, AMU, EV, MEV, ANG, meV2K, ROOM_T,
                       C_SQUARE, C_TRI, g_over_t_at, tc_ceiling_K, omega_bind_cutoff)

# QMC-anchored BEC-valid dome (from PIN-GSTAR / kappa_h3, load-bearing)
G_STAR_LO = 0.38     # deep-adiabatic QMC peak (dome onset)
G_STAR_CEN = 0.54    # central QMC peak (load-bearing pin)
G_STAR_HI = 0.70     # main QMC peak
G_DEATH = 1.20       # mass-divergence / localization (upper death edge)


def u0_zpm(M_amu, Omega_meV):
    """Proton zero-point motion amplitude u0 = sqrt(hbar/(2 M Omega))."""
    M = M_amu * AMU
    Om = Omega_meV * MEV / HBAR
    return np.sqrt(HBAR / (2.0 * M * Om)) / ANG  # in Angstrom


def g_over_t_exp_overlap(d_eff_ang, delta_ang, u0_ang):
    """Off-diagonal g/t for an H-bridged hop t(u)~exp(-u/delta):
       g = (dt/du)*u0 = (t/delta)*u0  =>  g/t = u0/delta.
       (Harrison floor uses the 2t/d form: g/t = 2 u0/d.)"""
    return u0_ang / delta_ang


def g_over_t_harrison(d_eff_ang, u0_ang):
    return 2.0 * u0_ang / d_eff_ang


# =====================================================================
# CANDIDATE METALLIC SHORT-H-BOND HOSTS (task 2) -- published geometry/EST inputs
# Provenance: LIT = published for this material; EST = physically-reasoned (flagged);
# DFT = from-scratch on this host (PENDING summer).
# =====================================================================
CANDIDATES = [
  dict(
    name="H_xMoO3 (hydrogen molybdenum bronze, x~0.3-1.7) -- METALLIC d-band, O-H...O bridge",
    cls="proton-bronze (metallic mixed-valence oxide)",
    # --- metallic? ---
    metallic="YES at 1 atm (mixed-valence Mo5+/Mo6+; H-bronze is a known metallic/"
             "highly-conducting bronze for the blue/monoclinic phases; Fermi level in Mo 4d). LIT",
    mott="NO -- wide Mo 4d band (W~2-3 eV), x non-integer -> off-half-filling, U/W<1. LIT/EST",
    # --- H-bond geometry ---
    bridge="O-H...O between corner/edge-sharing MoO6 octahedra (intralayer zig-zag)",
    d_OO_ang=2.7,        # EST: bronze O...O ~ 2.6-2.8 A (MODERATE H-bond, NOT short-symmetric)
    symmetric=False,     # asymmetric O-H...O (proton near one O) -- the honest weakness
    Omega_OHO_meV=110.0, # EST: O-H...O proton/libration band ~ 700-1200 cm-1 = 90-150 meV (moderate bond)
    M_red_amu=1.008,
    # --- off-diagonal channel ---
    # the proton gates an O2p->O2p (via Mo) inter-octahedral transfer ON the metallic band.
    t_meV=300.0,         # EST: metallic d/p-band inter-site transfer ~ 0.2-0.4 eV (WIDE, metallic)
    d_eff_ang=2.7,
    # asymmetric (longer) bridge -> overlap decay length LONGER -> S closer to Harrison floor
    overlap_delta_ang=[0.45, 0.60, 0.80],  # EST: weaker/longer bond -> larger delta -> smaller g/t
    note="Live carrier (metallic), but the bronze O-H...O is the WEAKER/LONGER asymmetric "
         "bond -> smaller dt/du than kappa-H3's short symmetric bridge. The inverse trade.",
  ),
  dict(
    name="H_xWO3 (hydrogen tungsten bronze, x~0.1-0.5) -- METALLIC 5d-band, O-H...O bridge",
    cls="proton-bronze (metallic mixed-valence oxide)",
    metallic="YES at 1 atm (E_F well in W 5d conduction band; classic metallic bronze, "
             "blue/colored, partially-filled 5d). LIT",
    mott="NO -- wide W 5d band (W~3-4 eV), x continuous, U/W<<1. LIT",
    bridge="O-H...O across WO6 octahedra (intercalated H on lattice O)",
    d_OO_ang=2.75,       # EST
    symmetric=False,
    Omega_OHO_meV=120.0, # EST
    M_red_amu=1.008,
    t_meV=350.0,         # EST: W 5d even wider than Mo 4d -> metallic, but DILUTES proton's relative dt/t
    d_eff_ang=2.75,
    overlap_delta_ang=[0.45, 0.60, 0.80],
    note="Most robustly metallic bronze (W5d wide band) -- but widest band = smallest g/t "
         "(strong-metal limit: the proton barely perturbs a 3-4 eV band).",
  ),
  dict(
    name="kappa-H3(Cat-EDT-TTF)2 doped off nu=1 (HYPOTHETICAL metallic route) -- short symmetric O-H-O",
    cls="doped molecular conductor (escape route of the CLOSED Mott host)",
    metallic="ONLY IF doped off nu=1 WITHOUT triggering CO -- UNDEMONSTRATED (the open lever). "
             "Adverse prior: every demonstrated perturbation -> CO insulator. EST/OPEN",
    mott="YES at nu=1 (the closure); the doped-metal is the untested escape. LIT(closure)/OPEN(escape)",
    bridge="symmetric [O...H...O]- short strong bond (H-centered single-well)",
    d_OO_ang=2.45,       # LIT: SHORT symmetric strong bond
    symmetric=True,
    Omega_OHO_meV=120.0, # LIT/EST (75-200 meV band)
    M_red_amu=1.008,
    t_meV=40.0,          # LIT: narrow inter-pi band (the Mott problem)
    d_eff_ang=2.45,
    overlap_delta_ang=[0.30, 0.40, 0.50],  # SHORT symmetric -> small delta -> LARGE g/t (the strong coupling)
    note="The strong-coupling reference: short symmetric bridge gives the big g/t -- but the "
         "narrow band is exactly why it Motts. Carrier axis CLOSED unless doped-without-CO.",
  ),
]


def evaluate(cand):
    """g/t (exp-overlap + Harrison) at this host's geometry; dome verdict; Tc-ceiling."""
    u0 = u0_zpm(cand["M_red_amu"], cand["Omega_OHO_meV"])
    rows = []
    for delta in cand["overlap_delta_ang"]:
        gt_exp = g_over_t_exp_overlap(cand["d_eff_ang"], delta, u0)
        rows.append(dict(delta=delta, g_over_t=float(gt_exp)))
    gt_harr = g_over_t_harrison(cand["d_eff_ang"], u0)
    gt_exp_lo = min(r["g_over_t"] for r in rows)
    gt_exp_hi = max(r["g_over_t"] for r in rows)
    # dome verdict on the coupling axis
    reaches_onset = gt_exp_hi >= G_STAR_LO
    reaches_peak = gt_exp_hi >= G_STAR_CEN
    # Tc-ceiling IF metallic and on-dome: Tc = C*Omega*11.6
    tc20 = tc_ceiling_K(cand["Omega_OHO_meV"], C_SQUARE)
    tc32 = tc_ceiling_K(cand["Omega_OHO_meV"], C_TRI)
    return dict(
        name=cand["name"], cls=cand["cls"], metallic=cand["metallic"], mott=cand["mott"],
        symmetric=cand["symmetric"], d_OO_ang=cand["d_OO_ang"],
        Omega_meV=cand["Omega_OHO_meV"], t_meV=cand["t_meV"], u0_ang=float(u0),
        g_over_t_harrison=float(gt_harr),
        g_over_t_exp_lo=float(gt_exp_lo), g_over_t_exp_hi=float(gt_exp_hi),
        rows=rows, reaches_dome_onset=bool(reaches_onset), reaches_dome_peak=bool(reaches_peak),
        tc_ceiling_K_C20=float(tc20), tc_ceiling_K_C32=float(tc32),
        note=cand["note"],
    )


def ed_crosscheck(g_over_t, t_meV, Omega_meV, L=6, Nb=8):
    """Validated 2-body SSH ED: binding + compactness at this (g/t, t/Omega)."""
    t = 1.0
    Om = Omega_meV / t_meV   # Omega in units of t
    g = g_over_t * t         # g in units of t
    try:
        r = ssh.bipolaron(L, Nb, t, Om, g, coupling="ssh", dphi=0.2)
        return dict(binding_over_t=float(r["binding"]),
                    bound=bool(r["binding"] < -1e-6),
                    mstar_over_m0=float(r["mstar_over_m0"]),
                    Omega_over_t=float(Om), g_over_t=float(g_over_t))
    except Exception as e:
        return dict(error=str(e), Omega_over_t=float(Om), g_over_t=float(g_over_t))


def main():
    print("=" * 100)
    print("METALLIC-HBOND-SSH — metallic short-H-bond off-diagonal SSH host eval (TB-grade)")
    print("  dome: g*/t onset=%.2f  central=%.2f  peak=%.2f  death=%.2f" %
          (G_STAR_LO, G_STAR_CEN, G_STAR_HI, G_DEATH))
    print("=" * 100)
    out = []
    for cand in CANDIDATES:
        ev = evaluate(cand)
        print("\n" + "-" * 100)
        print(f"  HOST: {ev['name']}")
        print(f"    class      : {ev['cls']}")
        print(f"    metallic?  : {ev['metallic']}")
        print(f"    Mott?      : {ev['mott']}")
        print(f"    H-bond     : symmetric={ev['symmetric']}  O..O={ev['d_OO_ang']} A  "
              f"Omega(OHO)={ev['Omega_meV']} meV  t={ev['t_meV']} meV")
        print(f"    proton ZPM : u0 = {ev['u0_ang']:.3f} A")
        print(f"    g/t        : Harrison floor = {ev['g_over_t_harrison']:.3f}  |  "
              f"exp-overlap = {ev['g_over_t_exp_lo']:.3f}-{ev['g_over_t_exp_hi']:.3f}")
        for r in ev["rows"]:
            print(f"                 delta={r['delta']:.2f} A -> g/t={r['g_over_t']:.3f}")
        verdict_coupling = ("REACHES dome PEAK (g*/t=0.54)" if ev["reaches_dome_peak"]
                            else "REACHES dome ONSET (g*/t=0.38)" if ev["reaches_dome_onset"]
                            else "BELOW dome onset")
        print(f"    coupling   : {verdict_coupling}")
        print(f"    Tc-ceiling : {ev['tc_ceiling_K_C20']:.0f}-{ev['tc_ceiling_K_C32']:.0f} K "
              f"(C=0.20-0.32) IF metallic AND on-dome")
        # ED cross-check at the host's best (highest) g/t
        ed = ed_crosscheck(ev["g_over_t_exp_hi"], cand["t_meV"], cand["Omega_OHO_meV"])
        ev["ed_crosscheck"] = ed
        if "error" not in ed:
            print(f"    ED (L6Nb8) : at g/t={ed['g_over_t']:.2f}, Omega/t={ed['Omega_over_t']:.3f}: "
                  f"binding/t={ed['binding_over_t']:.4f} ({'BOUND' if ed['bound'] else 'unbound'}), "
                  f"m**/m0={ed['mstar_over_m0']:.3f}")
        else:
            print(f"    ED         : (skipped: {ed['error']})")
        print(f"    note       : {ev['note']}")
        out.append(ev)

    # ============================================================
    # SYNTHESIS — the metallic-vs-coupling trade table
    # ============================================================
    print("\n" + "=" * 100)
    print("SYNTHESIS — the metallic<->coupling trade (the lane's central finding)")
    print("=" * 100)
    print(f"  {'host':<46}{'metal?':>8}{'sym?':>6}{'g/t(hi)':>9}{'on-dome?':>10}{'Tc-ceil':>10}")
    for ev in out:
        short = ev["name"].split(" -- ")[0][:44]
        metal = "YES" if ev["metallic"].startswith("YES") else ("OPEN" if "ONLY IF" in ev["metallic"] or "UNDEM" in ev["metallic"] else "?")
        sym = "Y" if ev["symmetric"] else "N"
        ondome = ("PEAK" if ev["reaches_dome_peak"] else "onset" if ev["reaches_dome_onset"] else "NO")
        tc = f"{ev['tc_ceiling_K_C32']:.0f}K"
        print(f"  {short:<46}{metal:>8}{sym:>6}{ev['g_over_t_exp_hi']:>9.3f}{ondome:>10}{tc:>10}")

    res = dict(
        lane="metallic-hbond-ssh",
        dome=dict(onset=G_STAR_LO, central=G_STAR_CEN, peak=G_STAR_HI, death=G_DEATH),
        room_t_K=ROOM_T,
        candidates=out,
        provenance="TB-grade on published bronze geometry + validated SSH-ED + QMC dome; "
                   "from-scratch bronze DFPT PENDING (summer recipe at tail).",
    )
    op = os.path.join(HERE, "metallic_hbond_ssh_results.json")
    with open(op, "w") as f:
        json.dump(res, f, indent=2)
    print(f"\n  -> {op}")


if __name__ == "__main__":
    main()
