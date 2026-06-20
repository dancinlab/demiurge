#!/usr/bin/env python3
"""tc-law r1: cross-family Tc descriptor unification.
Compare McMillan, Allen-Dynes (f1/f2), and the FoM Tc_max=0.182*w_log*sqrt(lambda)
against published calculated Tc across hydride/kagome/classic families.
RMSE computed in log10(Tc) space (Tc spans 1->250 K = 2.4 decades, so linear RMSE
is dominated by hydrides; log space is the physically meaningful relative-error metric).
Also report linear RMSE for completeness.
"""
import json, math, os

HERE = os.path.dirname(os.path.abspath(__file__))
MU = 0.10

def mcmillan(lam, wlog, mu=MU):
    # McMillan/Allen-Dynes prefactor wlog/1.2; classic McMillan exponent
    denom = lam - mu*(1.0 + 0.62*lam)
    if denom <= 0: return 0.0
    return (wlog/1.2) * math.exp(-1.04*(1.0+lam)/denom)

def allen_dynes(lam, wlog, mu=MU, w2_over_wlog=1.4):
    # Allen-Dynes 1975 with f1 (strong-coupling) and f2 (shape) corrections.
    # w2 = mean-square avg freq; approximate w2 ~ 1.4*wlog (typical ratio when only wlog known).
    Lam1 = 2.46*(1.0 + 3.8*mu)
    Lam2 = 1.82*(1.0 + 6.3*mu)*(w2_over_wlog)
    f1 = (1.0 + (lam/Lam1)**1.5)**(1.0/3.0)
    f2 = 1.0 + ((w2_over_wlog - 1.0)*lam**2)/(lam**2 + Lam2**2)
    denom = lam - mu*(1.0 + 0.62*lam)
    if denom <= 0: return 0.0
    base = (wlog/1.2) * math.exp(-1.04*(1.0+lam)/denom)
    return f1*f2*base

def fom_tcmax(lam, wlog):
    # Figure of merit Tc_max ~ 0.182 * w_log * sqrt(lambda)  (Pickard/Errea-style upper bound)
    return 0.182 * wlog * math.sqrt(lam)

def fom_calibrated(lam, wlog, c):
    return c * wlog * math.sqrt(lam)

def rmse_log(pred, obs):
    n=0; s=0.0
    for p,o in zip(pred,obs):
        if p<=0 or o<=0:
            # treat zero pred as large miss: clamp
            p = max(p, 1e-3)
        s += (math.log10(p)-math.log10(o))**2; n+=1
    return math.sqrt(s/n)

def rmse_lin(pred,obs):
    n=len(obs)
    return math.sqrt(sum((p-o)**2 for p,o in zip(pred,obs))/n)

def main():
    corpus = json.load(open(os.path.join(HERE,"tc_corpus.json")))
    mats = corpus["materials"]

    # Primary set = directly-sourced omega_log (est_omega_log == False)
    primary = [m for m in mats if not m.get("est_omega_log")]
    kagome  = [m for m in mats if m.get("est_omega_log")]

    print("="*92)
    print("tc-law r1 — cross-family descriptor unification (mu*=%.2f)"%MU)
    print("="*92)

    def evaluate(group, label):
        print("\n### %s (n=%d) ###"%(label,len(group)))
        hdr = f"{'mat':10s}{'fam':18s}{'lam':>6s}{'wlog':>7s}{'Tc_obs':>8s}{'McM':>8s}{'AD':>8s}{'FoM':>8s}"
        print(hdr)
        obs=[];mc=[];ad=[];fm=[]
        for m in group:
            o=m["Tc_calc_K"]; lam=m["lambda"]; w=m["omega_log_K"]
            a=mcmillan(lam,w); b=allen_dynes(lam,w); f=fom_tcmax(lam,w)
            obs.append(o);mc.append(a);ad.append(b);fm.append(f)
            print(f"{m['name']:10s}{m['family']:18s}{lam:6.2f}{w:7.0f}{o:8.1f}{a:8.1f}{b:8.1f}{f:8.1f}")
        print("-"*92)
        print(f"  RMSE_log10  McMillan={rmse_log(mc,obs):.3f}  AllenDynes={rmse_log(ad,obs):.3f}  FoM={rmse_log(fm,obs):.3f}")
        print(f"  RMSE_linear McMillan={rmse_lin(mc,obs):6.1f}K AllenDynes={rmse_lin(ad,obs):6.1f}K FoM={rmse_lin(fm,obs):6.1f}K")
        return obs,mc,ad,fm

    obs,mc,ad,fm = evaluate(primary, "PRIMARY (direct omega_log: hydrides + classic)")

    # Calibrate the FoM constant c on the primary set (least-squares in log space => geometric mean ratio)
    ratios=[o/(w_*math.sqrt(l_)) for o,w_,l_ in
            [(m["Tc_calc_K"],m["omega_log_K"],m["lambda"]) for m in primary]]
    import statistics
    c_fit = math.exp(statistics.fmean(math.log(r) for r in ratios))
    print(f"\n  >> Calibrated FoM constant c (geom-mean fit on primary) = {c_fit:.4f}  (vs canonical 0.182)")
    fm_cal=[fom_calibrated(m["lambda"],m["omega_log_K"],c_fit) for m in primary]
    print(f"  >> RMSE_log10 calibrated-FoM = {rmse_log(fm_cal,[m['Tc_calc_K'] for m in primary]):.3f}")

    # Kagome stress test (estimated omega_log) — out-of-family
    evaluate(kagome, "KAGOME STRESS (estimated omega_log — back-solved, circular for AD/McM by construction)")

    # Full cross-family with calibrated FoM (FoM is the only descriptor not fit to Tc per-point)
    print("\n### FULL CROSS-FAMILY — calibrated FoM vs McMillan vs Allen-Dynes ###")
    allg = primary + kagome
    obsA=[m["Tc_calc_K"] for m in allg]
    mcA=[mcmillan(m["lambda"],m["omega_log_K"]) for m in allg]
    adA=[allen_dynes(m["lambda"],m["omega_log_K"]) for m in allg]
    fmA=[fom_calibrated(m["lambda"],m["omega_log_K"],c_fit) for m in allg]
    print(f"  n={len(allg)}  RMSE_log10  McMillan={rmse_log(mcA,obsA):.3f}  AllenDynes={rmse_log(adA,obsA):.3f}  FoM_cal={rmse_log(fmA,obsA):.3f}")
    print(f"          RMSE_linear McMillan={rmse_lin(mcA,obsA):6.1f}K AllenDynes={rmse_lin(adA,obsA):6.1f}K FoM_cal={rmse_lin(fmA,obsA):6.1f}K")

    # Per-family residual of the calibrated single descriptor — does ONE c unify?
    print("\n### DOES ONE FoM CONSTANT UNIFY? per-family geom-mean ratio c_family = Tc/(wlog*sqrt(lam)) ###")
    from collections import defaultdict
    fam_ratios=defaultdict(list)
    famkey={"hydride":"hydride","classic-multiband":"classic","classic-A15":"classic",
            "classic-carbonitride":"classic","classic-elemental":"classic","kagome":"kagome"}
    for m in allg:
        k=famkey.get(m["family"],m["family"])
        fam_ratios[k].append(m["Tc_calc_K"]/(m["omega_log_K"]*math.sqrt(m["lambda"])))
    for k,rs in fam_ratios.items():
        cg=math.exp(statistics.fmean(math.log(r) for r in rs))
        spread=max(rs)/min(rs)
        print(f"  {k:10s} c={cg:.4f}  (n={len(rs)}, intra-family spread max/min={spread:.2f})")
    cs=[math.exp(statistics.fmean(math.log(r) for r in rs)) for rs in fam_ratios.values()]
    print(f"  >> cross-family c range: {min(cs):.4f} .. {max(cs):.4f}  (ratio {max(cs)/min(cs):.2f}x)")

if __name__=="__main__":
    main()
