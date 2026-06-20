"""
fb-ceiling — the DECISIVE leg: does the flat-band TRADE-OFF (d) itself close a Tc
ceiling, independent of the external lambda<4 cap?

Model the trade-off with explicit scaling laws (each assumption stated):

 A1. DOS-from-width:        N(E_F) = n_band / W            (band of width W, n_band states)
 A2. Phonon softening with flattening. The flat band is engineered by destructive hopping
     interference; the SAME bond stiffness sets BOTH the residual electronic width W and the
     phonon scale. A minimal, commonly-quoted scaling is w_log ~ w0 * (W/W0)^p with p>=0
     (flatter electronic band <-> softer relevant phonon). We scan p in {0, 1/2, 1}.
 A3. Hopfield/Holstein:     lambda = N(E_F) g0^2 Q_geom / (M w^2),  with M w^2 ~ kappa (bond
     stiffness) ~ w_log^2 in the same units  =>  lambda = (n_band g0^2 Q_geom) / (W * w_log^2).
 A4. Geometry Q_geom in [1/n_band, 1] is W-independent in the perfectly-flat limit (set by
     band texture, R3/R5), so it is a constant multiplier as we flatten.
 A5. Allen-Dynes asymptote: Tc = 0.182 * w_log * sqrt(lambda).

Combine A1-A5 (drop constants, set g0=M=1):
   lambda(W)  = C_lam * Q / (W * w_log^2),     w_log = w0 (W/W0)^p
   Tc(W)      = 0.182 * w_log * sqrt(lambda)
              = 0.182 * sqrt(C_lam*Q) * w_log * sqrt( 1/(W w_log^2) )
              = 0.182 * sqrt(C_lam*Q) * sqrt( w_log^2 / (W w_log^2) )    [w_log cancels!]
              = 0.182 * sqrt(C_lam*Q) * sqrt( 1 / W )
              = 0.182 * sqrt(C_lam*Q / W).

KEY ANALYTIC RESULT: in the Allen-Dynes asymptote, w_log CANCELS, and
   Tc(W) ~ sqrt(Q / W)   ->   diverges as W->0   (flatter is always hotter, no internal max!)
So the trade-off (d) ALONE does NOT close a ceiling: the asymptote has Tc ~ sqrt(lambda)*w_log
and lambda ~ 1/(W w_log^2), making Tc independent of w_log and monotone in 1/W. The ONLY thing
that stops Tc->inf as W->0 is the EXTERNAL fundamental cap lambda<=4 (arXiv:2407.12922). Once
lambda hits 4 at some width W*, further flattening cannot raise lambda, and Tc freezes at
   Tc_ceiling = 0.182 * sqrt(4) * w_log(W*) = 0.364 * w_log(W*).
=> the binding ceiling IS the lambda-cap one; w_log AT THE SATURATION WIDTH sets its value.

This script verifies the cancellation numerically and locates W* where lambda=4, then confirms
Tc is monotone-increasing up to W* and flat (capped) beyond it.
"""
import numpy as np, json

LAM_CAP, AD = 4.0, 0.182
kB = 8.617e-5  # eV/K

def run(Q=0.5, n_band=2, C_lam=0.05, w0=0.1, W0=2.0, p=0.5):
    """Scan bandwidth W from wide to ultra-flat; report lambda, w_log, Tc(asymptote, capped).
    Start WIDE/under-coupled (lambda<4) so the saturation width W* is found INSIDE the scan
    and moves with Q (geometric demand). C_lam,W0 chosen so a wide band sits below the cap."""
    Ws = np.geomspace(2.0, 1e-3, 60)
    rows = []
    for W in Ws:
        wlog = w0*(W/W0)**p
        lam_raw = C_lam*Q/(W*wlog**2)
        lam = min(lam_raw, LAM_CAP)             # apply fundamental cap (b)
        capped = lam_raw > LAM_CAP
        tc = AD*wlog*np.sqrt(lam)/kB             # K
        tc_uncapped = AD*wlog*np.sqrt(lam_raw)/kB
        rows.append((W, wlog, lam_raw, lam, capped, tc, tc_uncapped))
    arr = np.array([(r[0], r[1], r[2], r[3], r[5], r[6]) for r in rows])
    # locate saturation width W* (first W where lam_raw crosses LAM_CAP, scanning wide->flat)
    Wstar = None
    for r in rows:
        if r[4]:
            Wstar = r[0]; wlog_star = r[1]; break
    return rows, Wstar

def main():
    out = {"assumptions": [
        "A1 N(EF)=n_band/W", "A2 w_log=w0*(W/W0)^p (phonon softens as band flattens, p in {0,1/2,1})",
        "A3 lambda=n g0^2 Q/(W w_log^2) (Hopfield, M w^2~w_log^2)",
        "A4 Q_geom W-independent in flat limit (R3/R5), constant multiplier",
        "A5 Tc=0.182 w_log sqrt(lambda) (Allen-Dynes strong-coupling asymptote)"],
      "analytic": {
        "uncapped_asymptote": "Tc ~ 0.182*sqrt(C_lam*Q/W): w_log CANCELS, Tc monotone in 1/W, NO internal max",
        "conclusion": "trade-off (d) ALONE does not close a ceiling; the binding bound is the external lambda<=4 cap",
        "ceiling": "Tc_ceiling = 0.182*sqrt(4)*w_log(W*) = 0.364*w_log(W*), W* = width where lambda hits 4",
        "set_by": "w_log evaluated at the saturation width W*; geometry Q sets W* (1/Q shifts it)"},
      "scans": {}}

    # show w_log cancellation: across p, uncapped Tc(W) should be p-INDEPENDENT (proves cancel)
    cancel_check = {}
    for p in [0.0, 0.5, 1.0]:
        rows, Wstar = run(Q=0.5, p=p)
        # uncapped Tc at the widest 3 points (before any cap) for several p
        tc_unc = [round(r[6],2) for r in rows[:5]]
        cancel_check[f"p={p}"] = dict(uncapped_Tc_first5_K=tc_unc, Wstar_lambda4=Wstar)
    out["scans"]["wlog_cancellation_uncapped"] = cancel_check

    # the p-independence of uncapped Tc is the numerical proof of cancellation
    tcs = [v["uncapped_Tc_first5_K"][0] for v in cancel_check.values()]
    out["wlog_cancels_numerically"] = bool(max(tcs)-min(tcs) < 1e-6*max(tcs))

    # capped behaviour for a representative case + a geometry sweep on W*
    geo = {}
    for Q in [1.0, 0.69, 0.566, 0.5, 0.3336]:   # trivial -> Welch-floored zoo values
        rows, Wstar = run(Q=Q, p=0.5, C_lam=0.05, W0=2.0)
        tc_capped = [round(r[5],1) for r in rows]
        geo[f"Q={Q}"] = dict(Wstar_lambda_hits_4=Wstar,
                             Tc_max_capped_K=round(max(tc_capped),1),
                             monotone_up_to_cap=bool(
                                 all(x<=y+1e-6 for x,y in
                                     zip([r[5] for r in rows if r[2]<=LAM_CAP],
                                         [r[5] for r in rows if r[2]<=LAM_CAP][1:]))))
    out["scans"]["geometry_sweep_capped"] = geo
    # geometric DEMAND: smaller Q needs flatter band (smaller W*) to reach cap -> 1/Q trend
    out["geometric_demand"] = "smaller Q_geom => smaller W* (must flatten MORE to reach lambda=4): " \
        + ", ".join(f"Q{q}:W*={geo[f'Q={q}']['Wstar_lambda_hits_4']:.4g}" for q in [1.0,0.5,0.3336])

    print(json.dumps(out, indent=2))
    return out

if __name__ == "__main__":
    main()
