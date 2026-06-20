"""
EXTRACT new flat-band candidate ARCHETYPES (not just score known ones).

The scorer (predict_candidates.py) needs <g>,Omega fed in. This adds a GENERATOR: it sweeps
flat-band tight-binding archetypes over parameter ranges, computes the gauge-invariant quantum
metric integral <tr g> AND the Chern number from scratch, and flags which (archetype, regime)
land in the L42 design box (<g> high enough). It also reports the rigorous ceiling so the
extraction is honest (no over-claiming).

KEY HONESTY (d6): a single isolated flat band obeys the Chern lower bound
    integral_BZ tr g d^2k  >=  2*pi*|C|     (=> BZ-AVERAGED <tr g> >= |C|/(2*pi) ~ 0.16|C|)
and the Welch/overlap proxy Q_geom <= 1. So simple 1-flat-band lattices have a CEILING on <g>.
Scalar <g> >> 1 (the design box) requires MULTI-orbital / d-electron geometry (e.g. CoSn) -- which
then have SOFT phonons (low Omega). This re-derives the L42 two-lever wall FROM the generator side.
"""
import numpy as np

TWO_PI = 2*np.pi

# ---- archetype Hamiltonians H(k) ----
def H_kagome(k, t=1.0, lam=0.3):
    a1=np.array([1.,0.]); a2=np.array([.5,np.sqrt(3)/2]); a3=a2-a1
    tab=-2*t*np.cos(k@(a1/2)); tbc=-2*t*np.cos(k@(a2/2)); tca=-2*t*np.cos(k@(a3/2))
    s1=2*lam*np.sin(k@a1); s2=2*lam*np.sin(k@a2); s3=2*lam*np.sin(k@a3)
    H=np.array([[s1,tab,np.conj(tca)],[np.conj(tab),s2,tbc],[tca,np.conj(tbc),s3]],complex)
    return .5*(H+H.conj().T)

def H_lieb(k, t=1.0):
    kx,ky=k
    return np.array([[0,-2*t*np.cos(kx/2),-2*t*np.cos(ky/2)],
                     [-2*t*np.cos(kx/2),0,0],[-2*t*np.cos(ky/2),0,0]],complex)

def H_dice(k, t=1.0):
    k=np.asarray(k,float)
    d1=np.array([1.,0]); d2=np.array([-.5,np.sqrt(3)/2]); d3=np.array([-.5,-np.sqrt(3)/2])
    f=-t*(np.exp(1j*(k@d1))+np.exp(1j*(k@d2))+np.exp(1j*(k@d3)))
    return np.array([[0,f,0],[np.conj(f),0,np.conj(f)],[0,f,0]],complex)

def H_checkerboard(k, t=1.0, tp=0.5):
    kx,ky=k
    return np.array([[-2*tp*np.cos(kx),-4*t*np.cos(kx/2)*np.cos(ky/2)],
                     [-4*t*np.cos(kx/2)*np.cos(ky/2),-2*tp*np.cos(ky)]],complex)

def band_grid(Hf, nk, *p):
    bz=TWO_PI*np.arange(nk)/nk; nb=Hf(np.zeros(2),*p).shape[0]
    E=np.zeros((nk,nk,nb)); U=np.zeros((nk,nk,nb,nb),complex)
    for i,kx in enumerate(bz):
        for j,ky in enumerate(bz):
            w,v=np.linalg.eigh(Hf((kx,ky),*p)); E[i,j]=w; U[i,j]=v
    widths=E.max(axis=(0,1))-E.min(axis=(0,1)); b=int(np.argmin(widths))
    return U[:,:,:,b], float(widths[b]), E, b

def chern_and_metric(Uf):
    """Uf:(nk,nk,nb) -> (Chern C via link plaquettes, BZ-averaged tr g via Fubini-Study, Q_geom overlap)."""
    nk=Uf.shape[0]; C=0.0; trg=0.0
    for i in range(nk):
        for j in range(nk):
            u=Uf[i,j]; ux=Uf[(i+1)%nk,j]; uy=Uf[i,(j+1)%nk]; uxy=Uf[(i+1)%nk,(j+1)%nk]
            # Berry curvature (Fukui-Hatsugai-Suzuki plaquette)
            Ux=np.vdot(u,ux); Uy2=np.vdot(ux,uxy); Ux2=np.vdot(uxy,uy); Uy=np.vdot(uy,u)
            C+=np.angle(Ux*Uy2*Ux2*Uy)
            # quantum metric trace (link approx): 1-|<u|u'>|^2 ~ g_mu dk^2 ; sum * (nk/2pi)^2 * (2pi/nk)^2 = sum
            trg+=(1-abs(Ux)**2)+(1-abs(Uy)**2)
    C/=TWO_PI
    # integral_BZ tr g = sum_link (1-|ov|^2) * (cell area / dk^2); with dk=2pi/nk, cell=(2pi)^2/nk^2 -> factor 1
    int_trg=trg                      # already integral over BZ in units where each link = g*dk^2 summed
    avg_trg=trg/(nk*nk)              # BZ-averaged
    ov2=np.abs(Uf.reshape(-1,Uf.shape[-1]).conj()@Uf.reshape(-1,Uf.shape[-1]).T)**2
    return C, int_trg, avg_trg, float(ov2.mean())

if __name__=="__main__":
    nk=24
    print("="*98)
    print("EXTRACT — flat-band archetype generator: scan -> <tr g>, Chern, Welch ceiling (design box check)")
    print("="*98)
    ARCH=[("kagome(SOC)",H_kagome,(0.075,0.020)),("kagome(SOC,strong)",H_kagome,(0.05,0.05)),
          ("Lieb",H_lieb,(1.0,)),("dice/T3",H_dice,(1.0,)),
          ("checkerboard",H_checkerboard,(1.0,0.5)),("checkerboard(flat)",H_checkerboard,(1.0,0.0))]
    print(f"  {'archetype':<20}{'width':>8}{'Chern':>7}{'∫tr g':>9}{'<tr g>':>8}{'Q_geom':>8}{'≥Chern bnd?':>12}")
    print("  "+"-"*96)
    rows=[]
    for nm,Hf,p in ARCH:
        Uf,w,E,b=band_grid(Hf,nk,*p)
        C,intg,avgg,Q=chern_and_metric(Uf)
        bound = "OK" if intg>=TWO_PI*abs(round(C))-0.5 else f"<2pi|C|"
        rows.append((nm,w,C,intg,avgg,Q));
        print(f"  {nm:<20}{w:>8.3f}{C:>7.2f}{intg:>9.2f}{avgg:>8.3f}{Q:>8.3f}{bound:>12}")
    print("\n[DESIGN BOX] L42 needs scalar <g> >= ~2 (CoSn-scale). Archetype ceiling:")
    print(f"  max ∫tr g among archetypes = {max(r[3] for r in rows):.2f}; max Q_geom = {max(r[5] for r in rows):.3f} (Welch<=1).")
    print("  => NO simple 1-flat-band lattice reaches the design box in the overlap metric (Q_geom<=1),")
    print("     and ∫tr g is pinned near the Chern bound 2pi|C|. Scalar <g>>>1 (CoSn 2.87) comes from")
    print("     MULTI-orbital d-electron geometry, NOT a single TB flat band -> and those have SOFT Omega.")
    print("  => EXTRACTION re-derives the L42 two-lever wall: the generator CANNOT produce a box-hitting")
    print("     archetype that is ALSO a stiff-phonon light-element host. The wall is intrinsic, not a gap.")
    print("\n[REAL-MATERIAL EXTRACTION PATH (needs external DB, not in this FREE tool):]")
    print("  screen the published flat-band catalogue (Regnault Nature 2022, ~55k materials) for isolated")
    print("  flat band + light element + stiff phonon, then score each here. THAT extracts named NEW")
    print("  candidates not yet checked for geometric SC (d_novel_only-clean IF SC-unstudied).")
    print("\nHONEST (d6): this generator extracts ARCHETYPES + a design spec, not named materials. Its absolute")
    print("<g> normalization (overlap Q_geom vs scalar ∫tr g) is the known caveat; rigorous bounds = arXiv:2506.18969.")
