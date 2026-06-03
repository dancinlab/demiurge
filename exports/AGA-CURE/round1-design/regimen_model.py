import numpy as np
rng=np.random.default_rng(42); N=200000
# Scalp follicle population (advanced Norwood V-VI bald scalp), AGA preserves stem cells → reversible-dominant
fT1=0.45; fT2=0.35; fT3=0.20            # tier fractions (T1 reversible · T2 partial · T3 lost)
N0=250.0                                 # never-bald vertex terminal density /cm^2
resid=0.25                               # residual terminal fraction at baseline (rest miniaturized→vellus)
# arm efficacies (bracketed; arm② anagen-restore from D5 E_max-dominated UQ)
E2 = rng.uniform(0.25,1.00,N)            # arm② Wnt-restore conversion efficacy (D5: E_max is THE lever)
E1 = rng.uniform(0.30,0.85,N)           # arm① HFSC reactivation (CD200/CD34 progenitor rescue)
f4 = rng.uniform(0.30,0.90,N)           # arm④ neogenesis T3-restore fraction (Gray-Scott band achievable)
lock = rng.uniform(0.90,0.999,N)        # arm③ durability (relapse suppression)
# T1/T2 vellus→terminal restoration via Bliss independence of arm① & arm② (occupancy θ~0.99 from D5, fold in)
theta=0.99
p_restore = 1-(1-E2*theta)*(1-E1)        # combined conversion prob (Bliss)
# arm① alone slightly less effective on T2 (APM-detached) → scale T2 by 0.8
restore_T1 = p_restore
restore_T2 = 0.8*p_restore
# final terminal density (×lock for durable retention)
final = N0*lock*( resid + fT1*(1-resid)*restore_T1 + fT2*(1-resid)*restore_T2 + fT3*f4 )
cov = final/N0
def pc(a,p): return float(np.percentile(a,p))
print("=== AGA-CURE 4-arm combination regimen — '있는→없는' conversion (200k MC) ===")
print(f"baseline bald density ≈ {N0*resid:.0f}/cm^2 ({resid*100:.0f}% of never-bald {N0:.0f})")
print(f"final coverage vs never-bald: mean={cov.mean()*100:.1f}%  median={np.median(cov)*100:.1f}%  90%CI=[{pc(cov,5)*100:.1f}, {pc(cov,95)*100:.1f}]%")
print(f"P(CURE gate① ≥90% terminal density restored) = {(cov>=0.90).mean()*100:.1f}%")
print(f"P(≥70% restored, strong cosmetic)            = {(cov>=0.70).mean()*100:.1f}%")
# per-arm marginal: drop each arm, see coverage loss
def cover(rT1,rT2,F4,Lk): return (N0*Lk*(resid+fT1*(1-resid)*rT1+fT2*(1-resid)*rT2+fT3*F4)/N0)
base=cov.mean()
drop2=cover(0.8* (1-(1-0)*(1-E1)), 0.8*(1-(1-0)*(1-E1)),f4,lock)  # arm② off (E2=0)
drop1=cover((1-(1-E2*theta)),0.8*(1-(1-E2*theta)),f4,lock)        # arm① off (E1=0)
drop4=cover(restore_T1,restore_T2,np.zeros(N),lock)              # arm④ off (no T3 neogenesis)
drop3=cover(restore_T1,restore_T2,f4,np.full(N,0.5))             # arm③ off (50% relapse)
print("\nper-arm marginal (coverage drop if arm removed):")
for nm,d in [("arm② 되돌리기",drop2),("arm① 깨우기",drop1),("arm④ 신생(T3)",drop4),("arm③ 잠금",drop3)]:
    print(f"  −{nm:16s}: {(base-d.mean())*100:5.1f}%p loss → {d.mean()*100:.1f}%")
print("\nsequencing: ④prep(verteporfin)→②③Wnt-restore+neogenesis(band)→①reactivate→③lock. arm④ matters most where fT3 large (very-late Norwood); arms①② carry the reversible majority.")
