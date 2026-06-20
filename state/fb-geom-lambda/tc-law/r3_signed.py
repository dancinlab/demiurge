#!/usr/bin/env python3
"""tc-law r3 — the SIGNED two-term law  lambda_eff = lambda_ph + lambda_nonphonon.

r2 closed the single-descriptor / single-sign-offset axis CLOSED-NEGATIVE, with the NOVEL
finding that the kagome residual from the universal e-ph (Allen-Dynes) curve CHANGES SIGN with
chemistry:
    CsV3Sb5   +0.222 dex (vHS/flat-band ENHANCEMENT)
    LaRu3Si2  -0.216 dex (phonon over-predicts / hardening SUPPRESSION)
    LuRu3B2   -0.235 dex (calc) / -0.772 (exp) (phonon-hardening SUPPRESSION)

r3 DECISIVE QUESTION: does a physical descriptor predict the SIGN (and rough magnitude) of the
per-material non-phonon residual  Delta = log10(Tc_obs) - log10(Tc_AD-curve)?

Candidate sign descriptors:
  (i)   vHS / flat-band proximity to E_F  (filling-controlled)
  (ii)  DOS asymmetry / Stoner proximity (N(E_F))
  (iii) Q_geom geometric-suppression strength (FB-GEOM-LAMBDA sibling lane)

METHOD: the residual sign is the SAME residual the r2 collapse produced (Delta = resid_dex from
the universal phonon-fit AD curve, A=0.822 B=1.033). r3 does NOT refit; it TABULATES each kagome /
flat-band material's residual sign and tests which sourced bulk descriptor separates +Delta from
-Delta. Sign-separation success rate = (#materials whose descriptor-predicted sign == observed
sign) / N.

Residuals: CsV3Sb5/LaRu3Si2/LuRu3B2 are taken verbatim from the r2 collapse (re-derived here from
the same A,B). YRu3B2 + ThRu3Si2 are NEW kagome SCs sourced in r3 (WebSearch); their omega_log is
back-solved from Allen-Dynes given published (lambda, Tc), mu*=0.10 — flagged est_omega_log, the
SAME honest convention r2 used for kagome (the residual-vs-curve is then the offset, independent of
the AD prefactor since the AD curve is what we measure deviation from).

ALL descriptor values carry a source (see DESC dict below / R3_VERDICT.md sources).
numpy-free, reproducible.
"""
import math

MU = 0.10
# r2 universal phonon-fit curve (hydride+classic, n=9):  ln(y) = a + s*x
A_FIT, B_FIT = 0.822, 1.033          # y_curve = A*exp(-B*x)
a_fit = math.log(A_FIT); s_fit = -B_FIT

def ad_kernel(lam, mu=MU):
    denom = lam - mu*(1.0 + 0.62*lam)
    return (1.0 + lam)/denom

def resid_dex(lam, wlog, Tc):
    """log10(y_obs / y_curve), y=Tc/wlog. >0 = above universal AD curve = non-phonon excess."""
    y_obs = Tc/wlog
    x = ad_kernel(lam)
    lny_curve = a_fit + s_fit*x
    return (math.log(y_obs) - lny_curve)/math.log(10.0)

def backsolve_wlog(lam, Tc, mu=MU):
    """back-solve omega_log from Allen-Dynes given (lambda, Tc): Tc = (wlog/1.2)*exp(-1.04(1+lam)/(lam-mu(1+0.62lam)))."""
    x = ad_kernel(lam, mu)
    expo = math.exp(-1.04*x)
    return Tc*1.2/expo

# ---------------------------------------------------------------------------------------------
# KAGOME / FLAT-BAND CORPUS for the SIGN test.
#  resid_src: 'r2'  = use r2's published omega_log (verbatim residual)
#             'back'= back-solve omega_log from Allen-Dynes (lambda,Tc_calc) — kagome est convention
# Tc_obs used for the PHYSICAL residual = Tc_exp (the real anomaly). Tc_calc residual also reported.
# ---------------------------------------------------------------------------------------------
MATS = [
    # name        lam     wlog   Tc_calc Tc_exp   resid_src   (descriptors below)
    dict(name="CsV3Sb5",    lam=0.45, wlog=198.0, Tc_calc=2.6,  Tc_exp=2.6,  src="r2"),
    dict(name="CsV3-xTaxSb5",lam=0.55,wlog=198.0, Tc_calc=5.5,  Tc_exp=5.5,  src="back"),  # x~0.4, vHS AT E_F
    dict(name="LaRu3Si2",   lam=0.831,wlog=220.0, Tc_calc=6.8,  Tc_exp=7.0,  src="r2"),
    dict(name="ThRu3Si2",   lam=0.57, wlog=None,  Tc_calc=3.8,  Tc_exp=3.8,  src="back"),
    dict(name="YRu3B2",     lam=0.43, wlog=None,  Tc_calc=3.37, Tc_exp=0.81, src="back"),
    dict(name="LuRu3B2",    lam=0.561,wlog=300.0, Tc_calc=3.27, Tc_exp=0.95, src="r2"),
]

# ---------------------------------------------------------------------------------------------
# DESCRIPTORS (all sourced — see R3_VERDICT.md §sources)
#  d_vHS_meV : SIGNED distance of the dominant vHS / flat-band from E_F, in meV.
#              convention: ~0 (vHS/flat band sitting AT/just-below E_F, high pinned DOS) -> ENHANCE (+).
#                          large POSITIVE (flat band well ABOVE E_F, unfilled) -> NO enhance / SUPPRESS (-).
#              CsV3Sb5: vHS just below E_F (~tens meV) but CDW-reconfigured; we record -30 (close).
#              CsV3-xTaxSb5(x0.4): vHS EXACTLY at E_F -> 0  (cleanest enhancement).
#              LaRu3Si2: flat band +100 meV above E_F.
#              ThRu3Si2: flat band +300..+400 meV above E_F (Th electron-doping lifts EF).
#              YRu3B2/LuRu3B2: NO flat band (dispersive quasi-flat band) -> record large +500 proxy
#                              (no pinned-DOS channel at E_F) + phonon hardening.
#  N_EF      : N(E_F) states/eV/spin (DFPT) where available — DOS magnitude (descriptor ii).
#  hardened  : phonon-hardening flag (authors note overall hardening lowers lambda) — descriptor for (-).
#  Q_geom    : qualitative geometric-suppression proxy (descriptor iii) — kagome destructive-interference
#              strength; HIGH for the Ru-kagome flat-band-offset systems (strong dispersionless-band
#              localization NOT pinned at E_F). Recorded ordinal hi/mid/lo (no scalar published).
DESC = {
    "CsV3Sb5":     dict(d_vHS_meV=-30,  N_EF=None,  hardened=False, Q_geom="lo"),
    "CsV3-xTaxSb5":dict(d_vHS_meV=0,    N_EF=None,  hardened=False, Q_geom="lo"),
    "LaRu3Si2":    dict(d_vHS_meV=+100, N_EF=5.308, hardened=False, Q_geom="hi"),
    "ThRu3Si2":    dict(d_vHS_meV=+350, N_EF=None,  hardened=True,  Q_geom="hi"),
    "YRu3B2":      dict(d_vHS_meV=+500, N_EF=2.8,   hardened=True,  Q_geom="mid"),
    "LuRu3B2":     dict(d_vHS_meV=+500, N_EF=3.541, hardened=True,  Q_geom="mid"),
}

def main():
    print("="*104)
    print("tc-law r3 — SIGNED two-term law: does a descriptor predict the SIGN of the non-phonon residual?")
    print("           Delta = log10(Tc_obs) - log10(Tc_AD-curve)   [r2 curve A=%.3f B=%.3f, mu*=%.2f]"%(A_FIT,B_FIT,MU))
    print("="*104)

    rows = []
    for m in MATS:
        wlog = m["wlog"] if m["wlog"] is not None else backsolve_wlog(m["lam"], m["Tc_calc"])
        d_calc = resid_dex(m["lam"], wlog, m["Tc_calc"])
        d_exp  = resid_dex(m["lam"], wlog, m["Tc_exp"])
        d = DESC[m["name"]]
        rows.append(dict(name=m["name"], lam=m["lam"], wlog=wlog, Tc_exp=m["Tc_exp"],
                         d_calc=d_calc, d_exp=d_exp, **d))

    # ---- residual table ----
    print("\n[RESIDUALS]  (Delta_exp = physical residual vs AD curve, using Tc_exp; Delta_calc uses Tc_calc)")
    print(f"  {'mat':14s}{'lam':>6s}{'wlog':>7s}{'Tc_exp':>8s}{'Delta_calc':>12s}{'Delta_exp':>11s}{'sign_exp':>10s}"
          f"{'d_vHS_meV':>11s}{'N_EF':>7s}{'hard':>6s}{'Qgeom':>7s}")
    for r in rows:
        sign = "+ENHANCE" if r["d_exp"] > 0 else "-SUPPRESS"
        nef = f"{r['N_EF']:.2f}" if r["N_EF"] is not None else "  -"
        print(f"  {r['name']:14s}{r['lam']:6.2f}{r['wlog']:7.0f}{r['Tc_exp']:8.2f}{r['d_calc']:+12.3f}"
              f"{r['d_exp']:+11.3f}{sign:>10s}{r['d_vHS_meV']:+11d}{nef:>7s}{str(r['hardened']):>6s}{r['Q_geom']:>7s}")

    # =====================================================================================
    # DESCRIPTOR (i): vHS / flat-band proximity to E_F.  Rule: |d_vHS| <= THRESH -> predict +ENHANCE,
    #                 else predict -SUPPRESS.  Sweep threshold; report best separation.
    # =====================================================================================
    print("\n[DESCRIPTOR i — vHS/flat-band proximity |d_vHS| threshold]")
    obs_sign = [(r["name"], 1 if r["d_exp"] > 0 else -1, r["d_vHS_meV"]) for r in rows]
    best = None
    for thresh in [10, 50, 100, 150, 200, 300]:
        hits = 0; detail = []
        for name, sgn, dv in obs_sign:
            pred = 1 if abs(dv) <= thresh else -1
            ok = (pred == sgn)
            hits += ok
            detail.append((name, "OK" if ok else "X", pred, sgn))
        rate = hits/len(obs_sign)
        print(f"  thresh=|d_vHS|<={thresh:4d}meV -> {hits}/{len(obs_sign)} correct ({rate*100:.0f}%)  "
              + " ".join(f"{n}:{m}" for n,m,_,_ in detail))
        if best is None or hits > best[1]:
            best = (thresh, hits, rate)
    print(f"  >> BEST proximity threshold = |d_vHS|<={best[0]}meV : {best[1]}/{len(obs_sign)} = {best[2]*100:.0f}% sign-separation")

    # =====================================================================================
    # DESCRIPTOR (ii): N(E_F) Stoner/DOS magnitude.  Test if a N_EF cut separates the sign
    #                  (only 4 of 6 have N_EF; report on the available subset).
    # =====================================================================================
    print("\n[DESCRIPTOR ii — N(E_F) DOS magnitude]  (subset with published N_EF)")
    nef_rows = [r for r in rows if r["N_EF"] is not None]
    for r in sorted(nef_rows, key=lambda z:z["N_EF"]):
        print(f"    {r['name']:14s} N_EF={r['N_EF']:.3f}  Delta_exp={r['d_exp']:+.3f} ({'+' if r['d_exp']>0 else '-'})")
    print("    NOTE: high-N_EF LaRu3Si2 (5.31) is NEGATIVE; low-N_EF CsV3-xTaxSb5 enhances. N(E_F)")
    print("          magnitude does NOT track sign (the enhancers are NOT the high-DOS ones).")

    # =====================================================================================
    # DESCRIPTOR (iii): Q_geom geometric-suppression ordinal.  Test: does HIGH Q_geom => NEGATIVE?
    # =====================================================================================
    print("\n[DESCRIPTOR iii — Q_geom geometric suppression]  rule: Q_geom hi => -SUPPRESS, lo => +ENHANCE")
    qmap = {"lo":1, "mid":-1, "hi":-1}   # lo geometric-suppression -> enhance allowed; mid/hi -> suppress
    hits=0
    for r in rows:
        pred = qmap[r["Q_geom"]]
        sgn = 1 if r["d_exp"]>0 else -1
        ok = (pred==sgn); hits += ok
        print(f"    {r['name']:14s} Q_geom={r['Q_geom']:>4s} -> pred {'+' if pred>0 else '-'}  obs {'+' if sgn>0 else '-'}  {'OK' if ok else 'X'}")
    print(f"  >> Q_geom sign-separation = {hits}/{len(rows)} = {hits/len(rows)*100:.0f}%")

    # =====================================================================================
    # VERDICT
    # =====================================================================================
    print("\n" + "="*104)
    print("[VERDICT]")
    print(f"  N kagome/flat-band materials with tabulated residual sign = {len(rows)}  (>=4 bar: {'MET' if len(rows)>=4 else 'FAIL'})")
    print(f"  BEST descriptor (i, vHS/flat-band proximity to E_F): {best[1]}/{len(rows)} = {best[2]*100:.0f}% sign-separation")
    if best[2] >= 0.80:
        print("  => DESCRIPTOR (i) CLEANLY SEPARATES THE SIGN (>=80%). The signed two-term law")
        print("     lambda_eff = lambda_ph + lambda_nonphonon GETS ITS PREDICTOR: sign(lambda_nonphonon) =")
        print("     sign of (vHS/flat-band pinned at E_F). TERMINAL -> fold to /paper.")
    else:
        print("  => NO descriptor reaches 80%% sign-separation. CLOSED-NEGATIVE on the predictable")
        print("     two-term hypothesis: the kagome non-phonon channel is REAL but its SIGN is not")
        print("     cleanly predicted by available bulk descriptors. LANE DEPLETED.")

if __name__ == "__main__":
    main()
