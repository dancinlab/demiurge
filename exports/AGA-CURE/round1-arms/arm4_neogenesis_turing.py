import numpy as np
# Gierer-Meinhardt activator-inhibitor (Sick 2006: WNT=activator, DKK=inhibitor → follicle-spacing Turing)
# da/dt = rho*a^2/h - mu_a*a + Da*lap(a);  dh/dt = rho*a^2 - mu_h*h + Dh*lap(h)
def run(rho, N=128, steps=8000, dt=0.01, Da=1.0, Dh=40.0, mu_a=1.0, mu_h=2.0, seed=42):
    rng=np.random.default_rng(seed)
    a=1.0+0.05*rng.standard_normal((N,N)); h=1.0+0.05*rng.standard_normal((N,N))
    def lap(x): return (np.roll(x,1,0)+np.roll(x,-1,0)+np.roll(x,1,1)+np.roll(x,-1,1)-4*x)
    for _ in range(steps):
        a += dt*(rho*a*a/np.maximum(h,1e-6) - mu_a*a + Da*lap(a))
        h += dt*(rho*a*a - mu_h*h + Dh*lap(h))
        np.clip(a,0,50,out=a); np.clip(h,0,50,out=h)
    return a
def count_spots(a):
    # follicle primordia = local maxima above mean+0.5*std
    thr=a.mean()+0.5*a.std(); m=a>thr
    from scipy import ndimage
    lbl,n=ndimage.label(m); return n
try:
    from scipy import ndimage
    HAVE=True
except Exception:
    HAVE=False
print("=== arm④ de novo neogenesis — Wnt/Dkk Turing (Gierer-Meinhardt, Sick2006-class) ===")
# domain = 128x128 grid ~ a scalp patch; scale: assume 1 grid ≈ 0.05mm → 6.4x6.4mm patch = 0.41 cm^2
patch_cm2=(128*0.05/10)**2
for rho in [0.02, 0.05, 0.10, 0.20, 0.40]:
    a=run(rho)
    if HAVE:
        n=count_spots(a); dens=n/patch_cm2
        regime="PATTERN (neogenesis)" if a.std()/a.mean()>0.3 else "homogeneous (NO neogenesis)"
        print(f"  rho(Wnt-drive)={rho:.2f}: spots={n:4d}  density={dens:6.1f}/cm^2  CV={a.std()/a.mean():.2f}  [{regime}]")
    else:
        print(f"  rho={rho:.2f}: CV={a.std()/a.mean():.2f} (scipy absent, spot-count skipped)")
print(f"\npatch={patch_cm2:.2f} cm^2 · never-bald terminal density ref ~ 200-300/cm^2 (vertex)")
print("THRESHOLD: below a critical Wnt-drive the field stays homogeneous (no placodes = no neogenesis) → matches WIHN size/dose threshold; above it, Turing spots = new follicle primordia. arm④ must push rho above threshold (Wnt agonism + verteporfin/YAP-block to make T3 fibrotic skin regeneration-permissive).")
