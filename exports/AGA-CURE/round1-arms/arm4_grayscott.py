import numpy as np
from scipy import ndimage
# Gray-Scott RD (canonical spot patterns) — v-spots = follicle primordia; F (feed) = Wnt/regenerative drive proxy
def run(F, k=0.062, Du=0.16, Dv=0.08, N=128, steps=12000, dt=1.0, seed=42):
    rng=np.random.default_rng(seed)
    u=np.ones((N,N)); v=np.zeros((N,N))
    # seed central perturbation (a "wound"/dose focus)
    r=N//10; c=N//2
    u[c-r:c+r,c-r:c+r]=0.50; v[c-r:c+r,c-r:c+r]=0.25
    u+=0.02*rng.standard_normal((N,N)); v+=0.02*rng.standard_normal((N,N))
    def lap(x): return (np.roll(x,1,0)+np.roll(x,-1,0)+np.roll(x,1,1)+np.roll(x,-1,1)-4*x)
    for _ in range(steps):
        uvv=u*v*v
        u+=dt*(Du*lap(u)-uvv+F*(1-u)); v+=dt*(Dv*lap(v)+uvv-(F+k)*v)
        np.clip(u,0,1,out=u); np.clip(v,0,1,out=v)
    return v
patch_cm2=(128*0.05/10)**2  # 0.41 cm^2
print("=== arm④ de novo neogenesis — Gray-Scott RD (v-spots = follicle primordia) ===")
print(f"patch {patch_cm2:.2f} cm^2 · never-bald vertex ref ~200-300 terminal/cm^2")
for F in [0.010, 0.022, 0.030, 0.040, 0.055]:
    v=run(F)
    m=v>0.25; lbl,n=ndimage.label(m); dens=n/patch_cm2
    cv=v.std()/max(v.mean(),1e-6)
    regime="PATTERN→primordia" if n>=3 else ("decay (no neogenesis)" if v.max()<0.2 else "sparse")
    print(f"  F(Wnt/regen drive)={F:.3f}: primordia={n:4d}  density={dens:6.1f}/cm^2  CV={cv:.2f}  [{regime}]")
print("THRESHOLD: low F → spots decay (no neogenesis); a mid-F band sustains/multiplies spots = new follicle primordia → arm④ pushes the T3 field into this band (Wnt agonism + verteporfin YAP-block to remove the fibrotic damping).")
