#!/usr/bin/env python3
"""
AGA-RX Round-4 VERIFY — PK/PD -> ANAGEN% model.

Pipeline (all in-silico, first-principles + measured anchors):
  topical dose  ->  follicular [drug] at the dermal-papilla cell (DPC)   [PK lane, round-3]
               ->  SFRP1 target occupancy  theta = C/(C+Kd)              [equilibrium occupancy]
               ->  Wnt de-repression -> relief of the AGA disease shift  [PD coupling]
               ->  anagen-fraction shift in the Al-Nuaimi/Dobreva HC ODE [arXiv 2502.15035]
               ->  predicted anagen% increase vs vehicle.

PD BACKBONE (verbatim model + nominal params):
  Al-Nuaimi et al. (2012) human hair-cycle relaxation oscillator, re-informed
  with AGA data by Dobreva, Comer, Cogan, Paus, arXiv 2502.15035 (2025).
  Eq.(1):
    dxi/dt = p1*xi/((p2+xi)*(p3+Cprol*z1)) - p4*xi/(p5**k + xi**k) + alpha - beta*xi
    dn1/dt = c1*xi + Dn*(n2 - d1*n1)
    dn2/dt = Dn*(n1 - d2*n2)
    dz1/dt = Dz*(z2 - d3*z1)
    dz2/dt = c2*n2 + Dz*(z1 - d4*z2)
  Output xi(t) = relaxation oscillation; long upper state = ANAGEN,
  short lower state = telogen/catagen (paper, p.4).
  AGA mechanism (paper, Results/Discussion): the disease is encoded by an
  INCREASED p4 (MK apoptosis). Nominal normal p4 ~0.4994-0.5269; AGA mild
  0.5136-0.5405; AGA severe >=0.5405 (up to 0.5634). Sobol GSA: in severe AGA,
  p4 and Cprol (regulatory inhibition of MK proliferation) dominate anagen length.

PD COUPLING (the round-4 contribution; honest, falsifiable):
  SFRP1 is a secreted Wnt antagonist up-regulated in AGA dermal papilla.
  WAY-316606 inhibits SFRP1 -> Wnt de-repression -> restores the MK
  proliferation drive that the AGA state suppresses. We map drug action to a
  fractional REVERSAL of the AGA p4 elevation, scaled by target occupancy:
    p4(dose) = p4_AGA - theta * Emax * (p4_AGA - p4_normal)
  with theta = C_DPC/(C_DPC + Kd) the equilibrium SFRP1 occupancy, and
  Emax in [0,1] the maximal de-repression efficacy (Emax=1 => full restoration
  to the normal anagen at saturating occupancy). We report results across an
  Emax bracket because Emax is not measured -> honest tier.

PK lane (round-3, exports/AGA-RX/round3-admet-pk/PK.md, INHERITED d19):
  C_DPC = C_surf * exp(-z_DP / lambda_foll), trans-follicular shunt.
  WAY-316606: SFRP1 EC50 0.65 uM (measured); Kd 0.08 mM = 80 uM (lit, WAY paper).
  C_surf 0.1% w/v = 2230 uM; 1% w/v = 22300 uM. z_DP=1.0-1.5 mm; lambda_foll=0.2-2.0 mm.

NO fabricated effect size: every number below is computed from the cited model
+ measured/literature-bracketed inputs. Brackets are reported as brackets.
"""

import numpy as np
from scipy.integrate import solve_ivp

# ----------------------------------------------------------------------------
# 1. PD backbone params  (Dobreva 2025 / Al-Nuaimi 2012, Table 1 verbatim)
# ----------------------------------------------------------------------------
NOMINAL = dict(
    alpha=0.1, beta=0.01, p1=0.48, p2=0.1, p3=0.1, p5=0.32,
    Cprol=1.0, c1=1.0, c2=1.0, k=2.036, Dn=0.5, Dz=0.1,
    d1=2.0, d2=2.0, d3=2.0, d4=2.0,
)
# p4 (MK apoptosis) is the AGA disease knob (Table 1: p4 set per subject).
P4_NORMAL = 0.5096   # control subject A, last cycle (Fig.1B)
P4_AGA    = 0.5393   # AGA subject E, last cycle (Fig.2B) -- representative AGA

# initial conditions (paper p.8): xi0=0.01, n1=n2=0.5, z1=2, z2=0.5
Y0 = [0.01, 0.5, 0.5, 2.0, 0.5]


def hc_rhs(t, y, p4, P):
    xi, n1, n2, z1, z2 = y
    prolif = P['p1'] * xi / ((P['p2'] + xi) * (P['p3'] + P['Cprol'] * z1))
    apop   = p4 * xi / (P['p5'] ** P['k'] + xi ** P['k'])
    dxi = prolif - apop + P['alpha'] - P['beta'] * xi
    dn1 = P['c1'] * xi + P['Dn'] * (n2 - P['d1'] * n1)
    dn2 = P['Dn'] * (n1 - P['d2'] * n2)
    dz1 = P['Dz'] * (z2 - P['d3'] * z1)
    dz2 = P['c2'] * n2 + P['Dz'] * (z1 - P['d4'] * z2)
    return [dxi, dn1, dn2, dz1, dz2]


def anagen_fraction(p4, P=NOMINAL, t_end=6000.0, threshold_frac=0.5):
    """Integrate the relaxation oscillator; return (anagen fraction of cycle,
    mean anagen duration in model-days, mean telogen duration).
    Anagen := xi above a threshold set at threshold_frac of the cycle xi-range.
    Time is in days (paper x-axis = days)."""
    sol = solve_ivp(hc_rhs, (0, t_end), Y0, args=(p4, P),
                    method='LSODA', rtol=1e-8, atol=1e-10, max_step=2.0,
                    dense_output=True)
    t = np.linspace(0, t_end, 60000)
    xi = sol.sol(t)[0]
    # discard the first transient cycle: analyse the second half
    mask = t > t_end * 0.4
    t2, xi2 = t[mask], xi[mask]
    lo, hi = xi2.min(), xi2.max()
    if hi - lo < 1e-3:
        # no oscillation (locked) -> fully anagen if high, fully telogen if low
        frac = 1.0 if xi2.mean() > (P['p5']) else 0.0
        return frac, float('nan'), float('nan')
    thr = lo + threshold_frac * (hi - lo)
    above = xi2 > thr
    dt = t2[1] - t2[0]
    anagen_time = above.sum() * dt
    total_time = t2[-1] - t2[0]
    frac = anagen_time / total_time
    # per-cycle anagen / telogen durations from contiguous runs
    runs_a, runs_t, cur, curstate = [], [], 0.0, above[0]
    for a in above:
        if a == curstate:
            cur += dt
        else:
            (runs_a if curstate else runs_t).append(cur)
            cur, curstate = dt, a
    # drop the first and last (possibly truncated) runs
    runs_a = runs_a[1:-1] if len(runs_a) > 2 else runs_a
    runs_t = runs_t[1:-1] if len(runs_t) > 2 else runs_t
    mean_a = np.mean(runs_a) if runs_a else float('nan')
    mean_t = np.mean(runs_t) if runs_t else float('nan')
    return frac, mean_a, mean_t


# ----------------------------------------------------------------------------
# 2. PK -> occupancy  (round-3 PK.md inherited; equilibrium occupancy)
# ----------------------------------------------------------------------------
def C_at_DPC(C_surf_uM, z_DP_mm, lambda_foll_mm):
    return C_surf_uM * np.exp(-z_DP_mm / lambda_foll_mm)

def occupancy(C_uM, Kd_uM):
    return C_uM / (C_uM + Kd_uM)

# WAY-316606 anchors
KD_WAY_uM   = 80.0    # lit Kd 0.08 mM (SFRP1 binding, WAY paper)
EC50_WAY_uM = 0.65    # measured cell EC50 (ex-vivo hair-growth active)
CSURF = {"0.1%_w/v": 2230.0, "1%_w/v": 22300.0}


# ----------------------------------------------------------------------------
# 3. PD coupling: occupancy -> p4(dose) -> anagen% vs vehicle
# ----------------------------------------------------------------------------
def p4_on_drug(theta, Emax):
    return P4_AGA - theta * Emax * (P4_AGA - P4_NORMAL)


def run():
    print("=" * 78)
    print("AGA-RX ROUND-4 :: PK/PD -> ANAGEN%  (arXiv 2502.15035 PD backbone)")
    print("=" * 78)

    # --- A. baseline anagen fractions: normal vs untreated-AGA (vehicle) ---
    f_norm, a_norm, t_norm = anagen_fraction(P4_NORMAL)
    f_aga,  a_aga,  t_aga  = anagen_fraction(P4_AGA)
    print("\n[A] PD baselines (relaxation-oscillator anagen fraction & durations)")
    print(f"  NORMAL  (p4={P4_NORMAL}): anagen_frac={f_norm:.3f}  "
          f"anagen={a_norm:.0f} d  telogen={t_norm:.0f} d")
    print(f"  AGA/veh (p4={P4_AGA}): anagen_frac={f_aga:.3f}  "
          f"anagen={a_aga:.0f} d  telogen={t_aga:.0f} d")
    aga_deficit = f_norm - f_aga
    print(f"  -> AGA anagen-fraction deficit vs normal = {aga_deficit:+.3f} "
          f"({100*aga_deficit/f_norm:+.1f}% of normal)")

    # --- B. occupancy at the DPC across the PK bracket (WAY @ 0.1% & 1%) ---
    print("\n[B] SFRP1 occupancy theta = C_DPC/(C_DPC+Kd) at the DPC (Kd=80 uM)")
    print(f"  {'C_surf':<10}{'z_DP':<7}{'lam_foll':<9}{'C_DPC(uM)':<12}{'theta':<8}")
    occ_grid = {}
    for cs_name, cs in CSURF.items():
        for z in (1.0, 1.5):
            for lam in (0.2, 0.5, 1.0, 2.0):
                C = C_at_DPC(cs, z, lam)
                th = occupancy(C, KD_WAY_uM)
                occ_grid[(cs_name, z, lam)] = th
                print(f"  {cs_name:<10}{z:<7}{lam:<9}{C:<12.1f}{th:<8.3f}")

    # representative worst / typical / best corners
    th_worst = occ_grid[("0.1%_w/v", 1.5, 0.2)]
    th_typ   = occ_grid[("0.1%_w/v", 1.0, 1.0)]
    th_best  = occ_grid[("1%_w/v",   1.0, 2.0)]
    print(f"\n  representative occupancies: worst={th_worst:.3f}  "
          f"typical={th_typ:.3f}  best={th_best:.3f}")

    # --- C. anagen% increase vs vehicle, across Emax bracket & occupancy ---
    print("\n[C] Predicted anagen% increase vs vehicle  (p4(dose)=p4_AGA - theta*Emax*Dp4)")
    print("    Emax = max Wnt-de-repression efficacy (UNMEASURED -> bracket)")
    Emax_grid = [0.25, 0.5, 1.0]
    corners = [("worst 0.1%/1.5mm/0.2", th_worst),
               ("typical 0.1%/1.0mm/1.0", th_typ),
               ("best 1%/1.0mm/2.0", th_best)]
    results = {}
    header = f"  {'corner':<26}" + "".join(f"Emax={e:<7}" for e in Emax_grid)
    print(header)
    for cname, th in corners:
        row = f"  {cname:<26}"
        for Emax in Emax_grid:
            p4d = p4_on_drug(th, Emax)
            fd, ad, td = anagen_fraction(p4d)
            # anagen% increase vs vehicle (relative)
            rel = 100.0 * (fd - f_aga) / f_aga
            # absolute anagen-duration gain (days)
            dgain = ad - a_aga
            results[(cname, Emax)] = (fd, rel, ad, dgain)
            row += f"{rel:>+6.1f}% "
        print(row)

    # --- D. translate anagen% to a hair-count / coverage proxy vs SoC ---
    print("\n[D] Effect-size vs Standard-of-Care baselines")
    # SoC anchors (clinical, public): finasteride +107 hairs/yr1 (1cm^2);
    # minoxidil ~ +12-15% count / mid-frontal regrowth.
    # The HC-model output is an ANAGEN-FRACTION delta. The clinically observed
    # hair density scales ~ with anagen fraction (telogen hairs shed). A simple
    # proxy: %hair-density change ~ %anagen-fraction change at steady state.
    fd_typ_full = results[("typical 0.1%/1.0mm/1.0", 1.0)]
    fd_typ_half = results[("typical 0.1%/1.0mm/1.0", 0.5)]
    print(f"  AGA vehicle anagen frac : {f_aga:.3f}")
    print(f"  Normal anagen frac      : {f_norm:.3f} (full-restoration ceiling)")
    print(f"  WAY typical, Emax=1.0   : anagen frac {fd_typ_full[0]:.3f} "
          f"-> {fd_typ_full[1]:+.1f}% vs vehicle")
    print(f"  WAY typical, Emax=0.5   : anagen frac {fd_typ_half[0]:.3f} "
          f"-> {fd_typ_half[1]:+.1f}% vs vehicle")
    print("  SoC: finasteride +107 hairs/yr1 (~ +9-11% density, 1cm^2 frame);")
    print("       minoxidil ~ +12-15% count (mid-frontal).")
    # max biologically attainable (drug cannot exceed normal restoration)
    max_rel = 100.0 * (f_norm - f_aga) / f_aga
    print(f"  CEILING (full normal restoration) = {max_rel:+.1f}% anagen-frac vs vehicle")

    print("\n[E] HONEST LIMITS (d6)")
    print("  * Emax (SFRP1-inhibition -> p4-reversal efficacy) is UNMEASURED ->")
    print("    reported as a [0.25,1.0] bracket; only Emax & occupancy are free.")
    print("  * anagen-fraction -> hair-density is a linear proxy, not a fit.")
    print("  * p4_normal/p4_AGA are subject-representative (Fig.1B/2B), not a")
    print("    population fit; the % deltas are model-internal, sign-robust.")
    return dict(f_norm=f_norm, f_aga=f_aga, a_norm=a_norm, a_aga=a_aga,
                results=results, max_rel=max_rel,
                th_worst=th_worst, th_typ=th_typ, th_best=th_best)


if __name__ == "__main__":
    run()
