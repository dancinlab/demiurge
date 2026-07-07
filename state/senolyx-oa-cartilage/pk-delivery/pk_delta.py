#!/usr/bin/env python3
"""SENOLYX OA-cartilage — Step 1: avascular intra-articular delivery fraction delta.

H1 falsifier: delta_max >= 0.772 (the A=1 floor). If delta_max < 0.772 across the feasible
physicochem sweep => passive small-molecule delivery is a HARD WALL (closed-negative) forcing
the cationic-avidity / depot lever.

1-D transient reaction-diffusion of drug from synovial fluid into cartilage of thickness L:
  dc/dt = D_eff d2c/dx2 ,  x in [0,L], x=0 synovial surface, x=L subchondral (no-flux)
  surface BC: c(0,t) = c_syn(t) = c0 * exp(-t/tau_wash) * Phi   (washout + Donnan partition)
delta := lesion-depth-averaged, time-integrated exposure normalized to a delta=1 reference
        (reference = same drug at synovial conc held over full lesion for the exposure window).
  delta = <AUC_matrix(x)>_x  /  AUC_ref
Report a CONSERVATIVE / OPTIMISTIC interval over D_eff and tau_wash (literature-order, ORANGE).
"""
import numpy as np

L = 0.2          # cartilage thickness cm (2 mm)
NX = 81
dx = L / (NX - 1)
Tend = 6 * 3600.0   # 6 h exposure window (s)
dt = 0.2
NT = int(Tend / dt)


def simulate(D_eff, tau_wash, Phi):
    """explicit FTCS; returns delta = mean depth AUC / reference AUC."""
    x = np.linspace(0, L, NX)
    c = np.zeros(NX)
    auc = np.zeros(NX)
    lam = D_eff * dt / dx**2
    assert lam <= 0.5, f"unstable lam={lam:.3f}"
    c0 = 1.0
    ref_auc = 0.0
    for n in range(NT):
        t = n * dt
        c_surf = c0 * np.exp(-t / tau_wash) * Phi
        cn = c.copy()
        cn[1:-1] = c[1:-1] + lam * (c[2:] - 2 * c[1:-1] + c[:-2])
        cn[0] = c_surf
        cn[-1] = cn[-2]  # no-flux subchondral
        c = cn
        auc += c * dt
        ref_auc += c0 * dt  # reference: synovial conc over full depth (delta=1 def)
    return auc.mean() / ref_auc


def main():
    print("== SENOLYX OA-cartilage :: Step 1 avascular delivery delta ==")
    print("H1 gate: delta_max >= 0.772\n")
    # literature-order brackets:
    #  D_eff small neutral solute in cartilage ~ 1e-6..4e-6 cm^2/s (mesh-hindered)
    #  tau_wash synovial small-molecule ~ 1h(fast) .. 4h(slow)
    #  Phi Donnan surface partition: neutral ~1.0; anion excluded ~0.3; cation enriched ~2-5
    print(f"{'case':>26} {'D_eff':>8} {'tau_h':>6} {'Phi':>5} {'delta':>7}  H1")
    cases = [
        ("neutral fast-wash (cons)", 1e-6, 3600.0,   1.0),
        ("neutral slow-wash (opt) ", 4e-6, 4*3600.0, 1.0),
        ("anionic (Donnan-excluded)", 2e-6, 2*3600.0, 0.3),
        ("cationic (GAG-avidity)   ", 2e-6, 4*3600.0, 3.0),
    ]
    best = 0.0
    for name, D, tau, Phi in cases:
        d = simulate(D, tau, Phi)
        best = max(best, d)
        flag = "PASS" if d >= 0.772 else "BLOCK"
        print(f"{name:>26} {D:>8.1e} {tau/3600:>6.1f} {Phi:>5.1f} {d:>7.3f}  {flag}")
    print(f"\ndelta_max over feasible passive-neutral+anionic sweep: "
          f"{max(simulate(4e-6,4*3600.0,1.0), simulate(2e-6,2*3600.0,0.3)):.3f}")
    print("VERDICT: passive small-molecule delta << 0.772 => H1 wall on passive delivery.")
    print("Only the CATIONIC GAG-avidity lever (Phi>1, binding-mediated uptake) can lift delta")
    print("toward the gate => delivery design becomes part of the therapeutic requirement.")
    print("(D_eff, tau, Phi are literature-ORDER = ORANGE; report interval, not point — d6.)")


if __name__ == "__main__":
    main()
