import numpy as np
rng=np.random.default_rng(42); N=200000
# Uncertain inputs (ranges from round3-admet-pk / round4-verify)
E_max = rng.uniform(0.25,1.00,N)          # SFRP1-inhib→anagen efficacy (the unmeasured conditional)
Kd_uM = np.exp(rng.uniform(np.log(40),np.log(160),N))   # SFRP1 Kd ~80µM ×/÷2
lam_mm= rng.uniform(0.20,2.00,N)          # trans-follicular shunt decay length
z_mm  = rng.uniform(1.00,1.50,N)          # dermal-papilla depth
Csurf_mM = rng.uniform(80,140,N)          # 5% w/v topical surface conc (~112 mM nominal)
# pipeline: C_DPC = Csurf·exp(-z/λ) → occupancy θ → anagen gain (ceiling = full restoration +14.4%)
C_DPC_uM = Csurf_mM*1e3*np.exp(-z_mm/lam_mm)
theta = C_DPC_uM/(C_DPC_uM+Kd_uM)
CEIL=14.4  # % vs vehicle = full restoration 0.772→0.883
gain = E_max*theta*CEIL
def pct(a,p): return float(np.percentile(a,p))
print(f"anagen gain% vs vehicle: mean={gain.mean():.2f}  median={np.median(gain):.2f}  90%CI=[{pct(gain,5):.2f}, {pct(gain,95):.2f}]  min={gain.min():.2f} max={gain.max():.2f}")
print(f"theta (occupancy): median={np.median(theta):.3f}  5th={pct(theta,5):.3f}  (near-saturated except low-λ corner)")
# First-order Sobol-style: variance reduction when each var is frozen at its median (one-at-a-time conditional variance)
base=gain.var()
def froze(**kw):
    Em=kw.get('E',E_max); Kd=kw.get('K',Kd_uM); lm=kw.get('L',lam_mm); zz=kw.get('z',z_mm); cs=kw.get('C',Csurf_mM)
    c=cs*1e3*np.exp(-zz/lm); th=c/(c+Kd); return (Em*th*CEIL).var()
import numpy as _n
med=lambda x:_n.full(N,_n.median(x))
print("\nVariance contribution (freeze→Δvar/base, larger = more influential):")
for nm,kw in [("E_max",dict(E=med(E_max))),("lambda_foll",dict(L=med(lam_mm))),("z_DP",dict(z=med(z_mm))),("Kd",dict(K=med(Kd_uM))),("Csurf",dict(C=med(Csurf_mM)))]:
    red=1-froze(**kw)/base; print(f"  {nm:12s}: {red*100:5.1f}%")
# competitiveness vs SoC: P(gain >= finasteride ~9-11%) and (>= minoxidil ~12-15%)
print(f"\nP(gain ≥ 9%  [finasteride floor]) = {(gain>=9).mean()*100:.1f}%")
print(f"P(gain ≥ 12% [minoxidil band])    = {(gain>=12).mean()*100:.1f}%")
print(f"P(gain ≥ 6%  [clinically meaningful]) = {(gain>=6).mean()*100:.1f}%")
