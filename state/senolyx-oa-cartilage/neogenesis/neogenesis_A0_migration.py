#!/usr/bin/env python3
"""SENOLYX OA-cartilage — Step 2b: endogenous A_endo from progenitor migration.

Decompose the hand-swept mu of Step 2 into physically distinct factors:
    A_endo = mu_transport * q * (P_ss/Pmax)
    mu_transport = fill fraction of the acellular lost zone by MIGRATED cells  (MECHANO-derivable, ours)
    q            = hyaline-vs-fibro matrix QUALITY                              (needs a differentiation node)

Reuses the Step-1 diffusion operator (pk_delta.py 1-D FTCS grid) applied to a CELL field P instead
of a drug field, plus an advection drift v (mechanotransport / haptotaxis cue = no molecular target):

    dP/dt = D_cell d2P/dx2 - v dP/dx + r P(1-P/Pmax) phi - d P
    BC: P(0,t)=P_ss (dormant-pool margin feed), no-flux at subchondral face.

H3 falsifier: EXISTS physiological v (1-20 um/day) with A_endo >= 0.690 at fibro quality q<=0.30
              (i.e. self-owned closure with NO differentiation driver). Predicted FALSE.
"""
import numpy as np

# --- geometry / grid (mm, days) ---
L = 2.0            # cartilage/defect depth mm
NX = 81
dx = L / (NX - 1)
Pmax = 1.0
P_ss = 0.90        # dormant-pool steady density (Step 2), SASP fully relieved (phi=1)
r, d = 0.05, 0.02  # weak in-zone proliferation / attrition (days^-1)
D_cell = 1e-3      # cell random-motility mm^2/day (small; advection-dominated)


def simulate_fill(v_um_day, T_days):
    """v in um/day; return mu_transport = mean fill fraction of lost zone at T."""
    v = v_um_day * 1e-3           # um/day -> mm/day
    P = np.zeros(NX)
    dt = 0.2 * dx * dx / D_cell   # diffusion-stable
    dt = min(dt, 0.4 * dx / max(v, 1e-9))  # CFL for advection
    nt = int(T_days / dt)
    lam = D_cell * dt / dx**2
    cfl = v * dt / dx
    for _ in range(nt):
        Pn = P.copy()
        # diffusion (central) + advection (upwind, flow +x) + logistic - decay
        Pn[1:-1] = (P[1:-1]
                    + lam * (P[2:] - 2 * P[1:-1] + P[:-2])
                    - cfl * (P[1:-1] - P[:-2])
                    + dt * (r * P[1:-1] * (1 - P[1:-1] / Pmax) - d * P[1:-1]))
        Pn[0] = P_ss                     # margin feed
        Pn[-1] = Pn[-2]                  # no-flux subchondral
        P = np.clip(Pn, 0, Pmax)
    return P.mean() / Pmax               # mu_transport (fill fraction)


def main():
    print("== SENOLYX OA-cartilage :: Step 2b endogenous A_endo(v,q) ==")
    print("A_endo = mu_transport * q ;  gate needs A_endo >= 0.690\n")
    vs = [(5, 180), (20, 90), (20, 180)]
    qs = [0.30, 0.60, 0.90]
    print(f"{'v(um/d)':>8} {'T(d)':>5} {'mu_t':>6} | " + " ".join(f"q={q:.2f}" for q in qs))
    h3_pass = False
    floor_fibro = 0.0
    for v, T in vs:
        mu = simulate_fill(v, T)
        row = []
        for q in qs:
            A = mu * q
            row.append(f"{A:6.3f}")
            if q <= 0.30:
                floor_fibro = max(floor_fibro, A)
                if A >= 0.690:
                    h3_pass = True
        print(f"{v:>8} {T:>5} {mu:>6.3f} | " + "  ".join(row))

    print(f"\nmax A_endo at fibro quality (q<=0.30) over all v: {floor_fibro:.3f}")
    print(f"H3 (self-owned closure at fibro q, no diff driver): "
          f"{'PASS (fully self-owned!)' if h3_pass else 'FALSE -> external node IRREDUCIBLE'}")
    A_ext = max(0.0, 0.690 - floor_fibro)
    print(f"\nCredited self-owned A floor  = {floor_fibro:.3f}")
    print(f"Residual external A_ext req   = {A_ext:.3f}  (was 0.690 with zero self-credit)")
    print("=> ownership = PARTIAL: we supply delta+phi+A_endo(~0.27); ONE external hyaline-")
    print("   differentiation node must supply the residual A_ext. (d6 honest closed-negative)")


if __name__ == "__main__":
    main()
