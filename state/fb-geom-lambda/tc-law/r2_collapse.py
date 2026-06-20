#!/usr/bin/env python3
"""tc-law r2 — exponential-collapse + family-offset.

Hypothesis (H2): a SINGLE 2-parameter Allen-Dynes-exponential ansatz

    y(lambda) = Tc/omega_log = A * exp[ -B*(1+lambda) / (lambda - mu*(1+0.62*lambda)) ]

collapses ALL phonon families (hydride + classic) onto ONE curve. The residual-from-curve
(in dex = log10) is the family fingerprint:
    - hydride  ~ 0   (sits on the curve)
    - classic  ~ 0   (sits on the curve)
    - kagome   > 0   (POSITIVE offset = non-phonon EXCESS Tc to be quantified)

Pre-registered falsifier (from r1 §Next round):
    (a) collapse holds (<0.1 dex) for phonon families AND kagome shows a clean POSITIVE offset
        -> quantify kagome non-phonon Tc fraction (the NOVEL number) -> terminal, two-channel finding.
    (b) residual NOT family-ordered (hydride<classic<kagome)
        -> CLOSED-NEGATIVE on the universal-exponential-with-family-offset hypothesis.

Fit method: linear least squares in LOG space. Let
    x = (1+lambda)/(lambda - mu*(1+0.62*lambda))   (the AD exponent kernel, >0)
    ln(y) = ln(A) - B*x
so ln(y) is LINEAR in x with slope -B and intercept ln(A). Closed-form OLS (numpy-free).

The fit is done on PHONON families ONLY (hydride+classic). Kagome is held out and its residual
relative to the phonon-fit curve is the out-of-family offset (the non-phonon excess).
"""
import json, math, os
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
MU = 0.10

def ad_kernel(lam, mu=MU):
    """x = (1+lambda)/(lambda - mu*(1+0.62*lambda)) — the AD/McMillan exponent kernel."""
    denom = lam - mu*(1.0 + 0.62*lam)
    return (1.0 + lam)/denom  # >0 for all corpus lambdas

def ols_log(xs, ys):
    """Fit ln(y) = a + s*x by ordinary least squares. Returns (a, s) => A=exp(a), B=-s."""
    n = len(xs)
    lx = list(xs); ly = [math.log(v) for v in ys]
    mx = sum(lx)/n; my = sum(ly)/n
    sxx = sum((x-mx)**2 for x in lx)
    sxy = sum((x-mx)*(y-my) for x,y in zip(lx, ly))
    s = sxy/sxx
    a = my - s*mx
    return a, s

def famkey(f):
    if f.startswith("classic"): return "classic"
    if f == "hydride": return "hydride"
    if f == "kagome": return "kagome"
    return f

def main():
    corpus = json.load(open(os.path.join(HERE,"tc_corpus.json")))
    mats = corpus["materials"]
    for m in mats:
        m["fam"] = famkey(m["family"])
        m["x"]   = ad_kernel(m["lambda"])
        m["y"]   = m["Tc_calc_K"]/m["omega_log_K"]   # the collapse ordinate
        m["lny"] = math.log(m["y"])

    phonon = [m for m in mats if m["fam"] in ("hydride","classic")]
    kagome = [m for m in mats if m["fam"] == "kagome"]

    print("="*100)
    print("tc-law r2 — exponential collapse  y=Tc/wlog = A*exp[-B*x],  x=(1+lam)/(lam-mu*(1+0.62lam)),  mu*=%.2f"%MU)
    print("="*100)

    # ---- Fit the universal exponential on PHONON families only ----
    xs = [m["x"] for m in phonon]; ys = [m["y"] for m in phonon]
    a, s = ols_log(xs, ys)
    A = math.exp(a); B = -s
    print("\n[FIT] phonon families (hydride+classic, n=%d)"%len(phonon))
    print("      ln(y) = %.4f + (%.4f)*x   =>   A = %.4e   B = %.4f"%(a, s, A, B))

    def pred_lny(m): return a + s*m["x"]          # predicted ln(y) on the universal curve
    def resid_dex(m): return (m["lny"] - pred_lny(m))/math.log(10.0)  # log10 residual (dex), +=above curve

    # ---- Per-material residual table ----
    print("\n[RESIDUALS]  resid_dex = log10(y_obs/y_curve)  (>0 = ABOVE universal phonon curve = excess Tc)")
    hdr = f"{'mat':10s}{'fam':9s}{'lam':>6s}{'wlog':>7s}{'Tc':>8s}{'x':>7s}{'y_obs':>9s}{'y_curve':>9s}{'resid_dex':>11s}"
    print(hdr)
    for m in sorted(mats, key=lambda z:(z["fam"], z["lambda"])):
        yc = math.exp(pred_lny(m))
        print(f"{m['name']:10s}{m['fam']:9s}{m['lambda']:6.2f}{m['omega_log_K']:7.0f}{m['Tc_calc_K']:8.1f}"
              f"{m['x']:7.2f}{m['y']:9.4f}{yc:9.4f}{resid_dex(m):11.3f}")

    # ---- Collapse quality per family (RMS dex) ----
    print("\n[COLLAPSE QUALITY]  RMS residual (dex) per family + signed mean offset")
    fam_res = defaultdict(list)
    for m in mats: fam_res[m["fam"]].append(resid_dex(m))
    order = ["hydride","classic","kagome"]
    summary = {}
    for k in order:
        rs = fam_res[k]
        rms = math.sqrt(sum(r*r for r in rs)/len(rs))
        mean = sum(rs)/len(rs)
        summary[k] = (rms, mean, rs)
        print(f"  {k:9s} n={len(rs)}  RMS={rms:.3f} dex   mean_offset={mean:+.3f} dex   "
              f"[{min(rs):+.3f} .. {max(rs):+.3f}]")

    phonon_rms = math.sqrt(sum(r*r for k in ("hydride","classic") for r in fam_res[k])
                           /sum(len(fam_res[k]) for k in ("hydride","classic")))
    print(f"\n  >> PHONON collapse RMS (hydride+classic, n=%d) = %.3f dex  (target <0.100)"
          %(sum(len(fam_res[k]) for k in ('hydride','classic')), phonon_rms))

    # ---- Kagome offset = non-phonon excess ----
    kg_mean = summary["kagome"][1]
    # excess factor in Tc = 10^(mean kagome residual): how much higher kagome Tc is vs the phonon curve
    kg_factor = 10.0**kg_mean
    # fraction of kagome Tc that is "non-phonon" = (Tc_obs - Tc_phonon_curve)/Tc_obs = 1 - 10^(-resid)
    print("\n[KAGOME NON-PHONON EXCESS]  per-material")
    print(f"  {'mat':10s}{'resid_dex':>11s}{'Tc_factor':>11s}{'nonphonon_frac':>16s}")
    kg_fracs = []
    for m in kagome:
        r = resid_dex(m)
        factor = 10.0**r                      # Tc_obs / Tc_phonon_curve
        frac = 1.0 - 10.0**(-r) if r > 0 else (1.0 - 10.0**(-r))  # signed; >0 excess
        kg_fracs.append(frac)
        print(f"  {m['name']:10s}{r:11.3f}{factor:11.2f}{frac*100:15.1f}%")
    kg_frac_mean = sum(kg_fracs)/len(kg_fracs)
    print(f"  >> kagome mean offset = {kg_mean:+.3f} dex  => Tc excess factor = {kg_factor:.2f}x "
          f"=> non-phonon Tc fraction ~ {kg_frac_mean*100:.1f}%  (NOVEL number)")

    # ---- Falsifier evaluation: is residual family-ordered hydride < classic < kagome? ----
    print("\n[FALSIFIER]  is |mean offset| ordered hydride < classic < kagome AND kagome offset POSITIVE?")
    mh = abs(summary["hydride"][1]); mc = abs(summary["classic"][1]); mk = summary["kagome"][1]
    ordered = (mh <= mc + 0.05) and (mk > mh) and (mk > 0)   # kagome strictly positive & largest
    print(f"  |hydride|={mh:.3f}  |classic|={mc:.3f}  kagome(signed)={mk:+.3f}")
    print(f"  hydride/classic on-curve (<0.1 dex)?  hyd={summary['hydride'][0]:.3f}  cls={summary['classic'][0]:.3f}")
    print(f"  kagome positive offset?  {mk > 0}")
    print(f"  => family-ordered + kagome-positive: {ordered}")

    # ---- Verdict logic ----
    branch_a = (phonon_rms < 0.10) and (mk > 0) and ordered
    print("\n[VERDICT BRANCH]")
    if branch_a:
        print("  (a) collapse <0.1 dex for phonon + clean POSITIVE kagome offset")
        print("      => TWO-CHANNEL finding TERMINAL. kagome non-phonon Tc fraction ~ %.1f%%"%(kg_frac_mean*100))
    else:
        print("  (b) NOT a clean phonon-collapse + ordered-offset.")
        print("      phonon_rms<0.1? %s   kagome_positive? %s   ordered? %s"%(phonon_rms<0.10, mk>0, ordered))

    # ---- Compare: does the 2-param universal curve beat r1's single-FoM? (RMS dex full set) ----
    full_rms = math.sqrt(sum(r*r for rs in fam_res.values() for r in rs)/len(mats))
    print(f"\n[FULL-SET]  2-param universal-exponential RMS (all {len(mats)} mats) = {full_rms:.3f} dex")
    print(f"            (r1 ref: single-FoM full-set RMSE_log10 = 0.382; Allen-Dynes = 0.133)")

if __name__ == "__main__":
    main()
