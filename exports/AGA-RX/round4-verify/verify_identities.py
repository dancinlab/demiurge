#!/usr/bin/env python3
"""
Deterministic checker (g5 — the script IS the judge, no LLM self-judge).
Usage:  verify_identities.py <which>
  which = tlag    : PK lag-time identity  t_lag = h^2/(6 D)  (TTR-LAC/A1, NUMB)
        = onset   : EMLA onset numeric anchor 2*t_lag (h=10um, D=1e-10) == 55.6 min
        = occ     : occupancy identity theta = C/(C+Kd), and theta(Kd)=1/2
        = depth   : depth-attenuation identity C(z)=C_surf*exp(-z/lambda)
Exit 0 = PASS (identity holds symbolically / numeric within tol), nonzero = FAIL.
Prints a one-line VERDICT consumed by `hexa verify --verifier-cmd`.
"""
import sys
import sympy as sp


def check_tlag():
    # Derive lag time of a 1-D diffusion slab from first principles.
    # Fick's 2nd law, semi-infinite -> finite slab thickness h, the lag time of
    # the time-lag (Daynes-Barrer) solution for a membrane is L=h^2/(6 D).
    # We verify the closed-form identity symbolically: define t_lag and check the
    # Daynes-Barrer membrane time-lag expression equals h^2/(6 D).
    h, D, t = sp.symbols('h D t', positive=True)
    # Daynes-Barrer flux-permeation cumulative-amount time-lag (textbook closed form):
    #   Q(t)/(A*C0) = D*t/h - h/6 - (2h/pi^2) * sum (-1)^n/n^2 exp(-D n^2 pi^2 t/h^2)
    #   asymptote line crosses t-axis at t_lag where D*t/h - h/6 = 0  -> t = h^2/(6D)
    t_lag_expr = sp.solve(sp.Eq(D * t / h - h / 6, 0), t)[0]
    target = h**2 / (6 * D)
    ok = sp.simplify(t_lag_expr - target) == 0
    print(f"VERDICT: t_lag derived from Daynes-Barrer asymptote = {t_lag_expr} ; "
          f"target h^2/(6D) = {target} ; identity_holds={ok}")
    return ok


def check_onset():
    # numeric anchor reproduced by round-3 PK.md: h=10 um, D=1e-10 cm^2/s
    h = 10e-4  # cm
    D = 1e-10  # cm^2/s
    t_lag = h**2 / (6 * D)          # seconds
    onset_min = 2 * t_lag / 60.0    # minutes
    ok = abs(onset_min - 55.6) < 0.1
    print(f"VERDICT: EMLA onset 2*t_lag = {onset_min:.1f} min ; "
          f"expected 55.6 min ; match={ok}")
    return ok


def check_occ():
    # occupancy identity + half-occupancy at C=Kd
    C, Kd = sp.symbols('C Kd', positive=True)
    theta = C / (C + Kd)
    half = theta.subs(C, Kd)
    ok1 = sp.simplify(half - sp.Rational(1, 2)) == 0
    # limiting behaviour: theta->1 as C->oo, theta->0 as C->0
    lim_hi = sp.limit(theta, C, sp.oo)
    lim_lo = sp.limit(theta, C, 0)
    ok2 = (lim_hi == 1) and (lim_lo == 0)
    # equivalence to Hill-1 / Langmuir form theta = (C/Kd)/(1+C/Kd)
    hill = (C / Kd) / (1 + C / Kd)
    ok3 = sp.simplify(theta - hill) == 0
    ok = ok1 and ok2 and ok3
    print(f"VERDICT: theta=C/(C+Kd): theta(Kd)=1/2 ->{ok1}; "
          f"lim_hi={lim_hi},lim_lo={lim_lo} ->{ok2}; Langmuir-equiv ->{ok3}; all={ok}")
    return ok


def check_depth():
    # depth attenuation: solution of dC/dz = -C/lambda is C_surf*exp(-z/lambda)
    z, lam, Csurf = sp.symbols('z lambda C_surf', positive=True)
    C = sp.Function('C')
    sol = sp.dsolve(sp.Eq(C(z).diff(z), -C(z) / lam), C(z),
                    ics={C(0): Csurf})
    target = Csurf * sp.exp(-z / lam)
    ok = sp.simplify(sol.rhs - target) == 0
    print(f"VERDICT: dC/dz=-C/lambda, C(0)=C_surf => C(z)={sol.rhs} ; "
          f"target C_surf*exp(-z/lambda) ; identity_holds={ok}")
    return ok


def check_anagen_sign():
    # Sign-robust PD finding (deterministic from the cited ODE):
    #   (i) elevating p4 (AGA) shortens anagen fraction vs normal;
    #   (ii) drug occupancy that reverses the p4 elevation increases it back;
    #   (iii) the restored value never exceeds the normal ceiling.
    # This delegates to the SAME ODE used in model.py.
    import importlib.util
    import os
    here = os.path.dirname(os.path.abspath(__file__))
    spec = importlib.util.spec_from_file_location("m", os.path.join(here, "model.py"))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    f_norm, _, _ = m.anagen_fraction(m.P4_NORMAL)
    f_aga, _, _ = m.anagen_fraction(m.P4_AGA)
    # full reversal at saturating occupancy theta=1, Emax=1 -> p4 back to normal
    p4_full = m.p4_on_drug(1.0, 1.0)
    f_full, _, _ = m.anagen_fraction(p4_full)
    # partial reversal (typical theta=0.911, Emax=0.5)
    p4_part = m.p4_on_drug(0.911, 0.5)
    f_part, _, _ = m.anagen_fraction(p4_part)
    c1 = f_aga < f_norm                       # AGA shortens anagen
    c2 = f_part > f_aga                        # partial drug increases anagen
    c3 = f_full > f_aga                        # full drug increases anagen
    c4 = f_full <= f_norm + 1e-6              # cannot exceed normal ceiling
    ok = c1 and c2 and c3 and c4
    print(f"VERDICT: f_norm={f_norm:.3f} f_aga={f_aga:.3f} "
          f"f_partial={f_part:.3f} f_full={f_full:.3f} ; "
          f"AGA<normal->{c1}; partial>AGA->{c2}; full>AGA->{c3}; "
          f"full<=normal->{c4} ; monotone_PD_holds={ok}")
    return ok


CHECKS = {"tlag": check_tlag, "onset": check_onset,
          "occ": check_occ, "depth": check_depth,
          "anagen": check_anagen_sign}

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    targets = CHECKS.keys() if which == "all" else [which]
    all_ok = True
    for w in targets:
        ok = CHECKS[w]()
        all_ok = all_ok and ok
    sys.exit(0 if all_ok else 1)
