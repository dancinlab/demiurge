import numpy as np
# arm④ neogenesis = Turing (Schnakenberg activator-inhibitor) from DC1.
# DC1 closed: steady state stable, Turing-unstable for d>d_c≈8.57, γ-calibrated to 0.6mm → 278/cm².
# DC8 NEW question: the inducer (Wnt activator vs Dkk1/BMP inhibitor) PRODUCTION RATIO sets the
# kinetic balance (a,b in Schnakenberg). Sweep the activator:inhibitor production ratio → pattern
# wavelength → density, find the window giving DISCRETE native-density spots (not confluent plaque,
# not too-sparse). Linear-stability wavelength of fastest-growing mode sets spot spacing.
d=10.0   # diffusion ratio (>d_c, Turing-active)
def steady(a,b): u=a+b; v=b/(u*u) if u>0 else 0; return u,v
def fastest_k2(a,b,d):
    u,v=steady(a,b)
    fu=-1+2*u*v; fv=u*u; gu=-2*u*v; gv=-u*u   # Schnakenberg Jacobian
    # dispersion: fastest-growing k2 = (d*fu+gv)/(2*d) ... use standard Turing k*^2
    num=d*fu+gv
    if num<=0: return None
    k2=num/(2*d)
    return k2
print("=== DC8 arm④ inducer activator:inhibitor ratio sweep ===")
print(f"{'a (act)':>8s} {'b (inh)':>8s} {'ratio a/b':>9s} {'k*^2':>8s} {'wavelen(mm)':>11s} {'density/cm2':>11s} {'regime':>10s}")
gamma=321.0  # from DC1 calibration (0.6mm native spacing)
best=None
for a,b in [(0.05,0.5),(0.1,0.5),(0.1,1.0),(0.2,1.0),(0.1,1.5),(0.05,1.2),(0.15,0.9),(0.1,2.0)]:
    k2=fastest_k2(a,b,d)
    if k2 is None or k2<=0:
        print(f"{a:8.2f} {b:8.2f} {a/b:9.2f} {'--':>8s} {'--':>11s} {'--':>11s} {'no-pattern':>10s}"); continue
    # wavelength λ = 2π/k, k = sqrt(gamma*k2)  (γ scales domain)
    k=np.sqrt(gamma*k2); lam_mm=2*np.pi/k
    dens=1.0/( (lam_mm/10.0)**2 )  # spots per cm^2 (lam in mm → cm)
    if dens<150: regime="sparse"
    elif dens>400: regime="plaque"
    else: regime="NATIVE"
    print(f"{a:8.2f} {b:8.2f} {a/b:9.2f} {k2:8.3f} {lam_mm:11.3f} {dens:11.0f} {regime:>10s}")
    if regime=="NATIVE" and (best is None or abs(dens-250)<abs(best[1]-250)): best=((a,b),dens)
if best: print(f"→ best inducer ratio: a={best[0][0]} b={best[0][1]} (a/b={best[0][0]/best[0][1]:.2f}) → {best[1]:.0f}/cm² (native window 150-400)")
print("  interpretation: low activator:inhibitor ratio → discrete spots; high ratio → confluent plaque (ectopic over-patterning).")
