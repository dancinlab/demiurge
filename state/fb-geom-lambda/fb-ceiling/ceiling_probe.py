"""
FB-GEOM-LAMBDA round-r1 (fb-ceiling lane) — does the geometry stack imply a
closed-form CEILING on Tc for flat-band conventional superconductors?

Stack:
  (a) lambda_FB = N(E_F) g0^2 Q_geom / (M w^2),   1/N_band <= Q_geom <= 1   (Welch, R5)
  (b) lambda <~ 4                                  (arXiv:2407.12922 fundamental upper limit)
  (c) Tc_max ~= 0.182 * w_log * sqrt(lambda)       (strong-coupling Allen-Dynes asymptote)
  (d) flat-band trade-off: flatter band -> larger N(E_F) but smaller w_log; Q_geom<1.

Two distinct "ceilings" can come out of this stack, and they answer DIFFERENT questions:

  CEILING-1 (lambda-saturated):  Tc_max <= 0.182 * w_log * sqrt(lambda_max),  lambda_max ~= 4
       -> Tc_ceil = 0.182 * 2 * w_log = 0.364 * w_log.
       This is NOT special to flat bands: it is just (b)+(c). The flat-band content is
       that flat bands are the regime where lambda actually REACHES the saturating value
       (large N(E_F)), so the bound is TIGHT there. The physical quantity that sets it is
       the lattice phonon scale w_log (equivalently w_log = w * <some moment>).

  CEILING-2 (geometry-limited, the genuinely new flat-band statement):
       Use (a) to express lambda, then ask what caps Tc when the band is made flatter.
       Flattening raises N(E_F) ~ n_b/W (W=bandwidth) which RAISES lambda, but lowers w_log.
       The geometric factor Q_geom in [1/N_band, 1] cannot rescue an arbitrarily small w_log.
       If we DON'T impose lambda<4 we'd get Tc -> grow; the lambda<4 cap (b) is exactly the
       physical reason a real material cannot ride N(E_F)->inf. So CEILING-2 collapses to
       CEILING-1 with lambda pinned at its physical max -> the operative ceiling is set by
       w_log, and Q_geom only controls HOW FLAT the band must be to reach lambda_max.

So the closed-form ceiling is:
       Tc_ceiling = 0.182 * sqrt(lambda_max) * w_log_max(at lambda_max)
with lambda_max ~= 4 from (b). The non-trivial flat-band refinement is the *condition*
to reach it, which Q_geom and the trade-off set:
       lambda_max = N(E_F) g0^2 Q_geom / (M w^2)  must equal ~4
   =>  the required electronic prefactor N(E_F) g0^2 = 4 M w^2 / Q_geom
   =>  geometry (Q_geom<1) DEMANDS a LARGER N(E_F) (flatter band) to hit lambda_max,
       i.e. quantum geometry RAISES the bar to reach the ceiling but does NOT lower the
       ceiling value itself (which is fixed by w_log at saturation).

This script sanity-checks: (i) every model-lattice flat band has lambda respecting the
Welch floor AND, once we attach a phonon scale + the lambda<4 cap, Tc<=ceiling; (ii) the
geometric-demand relation N_req ~ 1/Q_geom.
"""
import numpy as np, json, sys, os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from lieb_probe import twoband_flat, analyze  # reuse the R3/R5 machinery

# ---------- constants ----------
LAM_CAP = 4.0          # arXiv:2407.12922 fundamental el-ph lambda upper limit
AD_PREF = 0.182        # Allen-Dynes strong-coupling asymptote Tc ~ 0.182 w_log sqrt(lambda)

def tc_allen_dynes_asymptote(w_log, lam):
    """Strong-coupling (lambda>>1) Allen-Dynes asymptote, in same energy units as w_log."""
    return AD_PREF * w_log * np.sqrt(lam)

def tc_ceiling(w_log):
    """Closed-form Tc ceiling: lambda pinned at the fundamental cap LAM_CAP."""
    return AD_PREF * w_log * np.sqrt(LAM_CAP)

# ---------- (1) Welch floor + ceiling respected on the model lattices ----------
# Model flat-band lambda is lambda = N(EF) g0^2 Q_geom / Mw2 (lieb_probe units g0=Mw2=NEF=1
# for the perfectly-flat two-band family). To get a Tc we must attach a phonon scale w_log
# and an electronic prefactor P == N(EF) g0^2 / Mw2 that scales lambda up to physical size.
# We test: for ANY P that drives lambda up to LAM_CAP, is Tc <= ceiling(w_log)?  (tautology
# check that the cap is the binding constraint) AND the geometric DEMAND P_req = LAM_CAP/Q.

def probe():
    out = {}

    # --- model lattices: flat-band Q_geom (geometry-only lambda at unit prefactor) ---
    lattices = []
    # decisive 2-band d.sigma family across topological regimes (R3/R5 machinery)
    for m in [3.0, 2.0, 1.0, 0.0, -1.0]:
        r = twoband_flat(nk=40, m=m)
        lattices.append(dict(name=f"d.sigma m={m:+.1f}", N_band=2,
                             Q=r["Qgeom_FS"], lam_unit=r["lam"]))
    # Lieb middle band (nearly flat) via analyze at small tp
    rL = analyze(nk=28, tp=0.01, dchi=0.0, sigma=0.04)
    lattices.append(dict(name="Lieb(tp=.01)", N_band=3, Q=rL["Qgeom_FS"], lam_unit=rL["lam_formula"]))

    # phonon scale: use a representative hydride-class w_log and a moderate-phonon class
    W_LOG = {"hydride~100meV": 0.100, "carbide~60meV": 0.060, "kagome-metal~20meV": 0.020}  # eV

    rows = []
    for lat in lattices:
        Q = lat["Q"]; N = lat["N_band"]
        welch_floor = 1.0/N
        welch_ok = Q >= welch_floor - 1e-2
        # geometric DEMAND: prefactor P needed to reach the lambda cap given this geometry
        #   lambda = P * Q  ->  P_req = LAM_CAP / Q  (Q<1 => need LARGER P, i.e. flatter band)
        P_req = LAM_CAP / Q
        P_req_trivial = LAM_CAP / 1.0     # if band were geometrically trivial (Q=1)
        demand_ratio = P_req / P_req_trivial   # == 1/Q : extra electronic weight geometry costs
        # Tc ceiling test: drive lambda to the cap, attach each phonon scale, check Tc<=ceiling
        tc_tests = {}
        for wname, wlog in W_LOG.items():
            lam_at_cap = LAM_CAP
            tc_at_cap = tc_allen_dynes_asymptote(wlog, lam_at_cap)
            tc_ceil = tc_ceiling(wlog)
            tc_tests[wname] = dict(w_log_eV=wlog,
                                   Tc_at_cap_K=tc_at_cap/8.617e-5,   # eV->K (kB)
                                   Tc_ceiling_K=tc_ceil/8.617e-5,
                                   respects_ceiling=bool(tc_at_cap <= tc_ceil + 1e-9))
        rows.append(dict(lattice=lat["name"], N_band=N, Q_geom=round(Q,4),
                         welch_floor=round(welch_floor,4), welch_ok=bool(welch_ok),
                         lam_unit_prefactor=round(lat["lam_unit"],4),
                         P_req_to_reach_cap=round(P_req,3),
                         geometric_demand_1overQ=round(demand_ratio,3),
                         Tc=tc_tests))
    out["rows"] = rows

    # --- closed-form ceiling value, evaluated at the phonon scales ---
    out["ceiling_closed_form"] = {
        "expr": "Tc_ceiling = 0.182 * sqrt(lambda_cap) * w_log,  lambda_cap = 4",
        "coefficient_0182_sqrt4": AD_PREF*np.sqrt(LAM_CAP),   # = 0.364
        "Tc_ceiling_K": {w: tc_ceiling(v)/8.617e-5 for w, v in W_LOG.items()},
    }
    # sanity: is every model row's saturated Tc <= ceiling? (must be, by construction — the
    # POINT is that NO geometry/N(EF) choice can beat 0.364*w_log once lambda is capped)
    all_ok = all(all(t["respects_ceiling"] for t in r["Tc"].values()) and r["welch_ok"]
                 for r in rows)
    out["all_respect_ceiling_and_welch"] = bool(all_ok)
    return out

if __name__ == "__main__":
    res = probe()
    print(json.dumps(res, indent=2))
    print("\n" + "="*70)
    print("CEILING:  Tc <= 0.182*sqrt(lambda_cap)*w_log = 0.364 * w_log   (lambda_cap=4)")
    print("Physical quantity that SETS it: the phonon scale w_log.")
    print("Quantum geometry (Q_geom) sets the DEMAND 1/Q on N(EF) to REACH the cap,")
    print("not the ceiling value. ALL model rows respect ceiling + Welch:",
          res["all_respect_ceiling_and_welch"])
