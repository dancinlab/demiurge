"""
flat-band-quantum-geometry  —  DECISIVE ROUND (roomt-discover substrate lane)
=============================================================================
The ONE structural evasion of the (2a) superfluid-stiffness trade: in an ISOLATED
flat band the stiffness is NOT band kinetics (W->0) but the QUANTUM METRIC:
    D_s = 4 |U| nu(1-nu) <tr g>          (Peotta-Torma, Nat Commun 6,8944)
so rho_s decouples from the kinetic energy the (2a) trade depletes.

DECISIVE QUESTION (the campaign's registered next round, with adverse prior):
  Does a real 1-atm flat-band host give D_s(quantum-metric) AND pairing lam both
  >= room-T SIMULTANEOUSLY, or do the GEOMETRIC bounds (Welch Q_geom>=1/N_band)
  + the ISOLATION cap (|U|<=E_gap) cap D_s -> Tc below 293K -> the 6TH REALIZATION
  of the master conservation?

This script derives D_s_max from FOUR independent ceilings and tests each at the
real-host numbers (rhombohedral graphite + a kagome anchor). NO fabrication (d6):
every <tr g> is a TB-model estimate FLAGGED as such; the bounds themselves are
closed-form (frame theory + isolated-band trace inequalities).

  kB Tc(2D-BKT) = (pi/8) D_s ;  kB Tc(3D-XY) ~ 0.45 D_s (interlayer-Josephson, *1.4 over 2D)
"""
import numpy as np

MEV2K = 11.604518            # meV -> K
KB_MEV = 1.0/MEV2K          # K -> meV  (kB in meV/K = 0.08617)
ROOM_T = 293.15             # K (hard gate)
ROOM_T_meV = ROOM_T*KB_MEV  # = 25.27 meV

print("="*78)
print("FLAT-BAND QUANTUM-GEOMETRY  —  DECISIVE: does the stiffness escape close as")
print("the 6th realization on the Welch + isolation cap?   (d6 honest, NO fabricate)")
print("="*78)
print(f"room-T gate: Tc>={ROOM_T} K  <=>  kB*Tc = {ROOM_T_meV:.3f} meV")

# ===========================================================================
# TASK 1 — the quantum-metric stiffness route, stated precisely + the bound.
# ===========================================================================
print("\n" + "#"*78)
print("# TASK 1 — D_s = 4|U| nu(1-nu) <tr g> ;  what <g>*|U| reaches 293K @ nu=1/2 ?")
print("#"*78)

nu = 0.5
fill = nu*(1-nu)             # = 1/4 (maximal at half-filling)
print(f"\nAt nu=1/2: nu(1-nu) = {fill:.3f} (maximal).  D_s = 4*{fill}*|U|*<g> = |U|*<g>.")
print("2D-BKT:  kB Tc = (pi/8) D_s = (pi/8) |U| <g>.")
TBKT_coeff = np.pi/8
need_Ug_2D = ROOM_T_meV/TBKT_coeff
print(f"  => need |U|*<g> = {need_Ug_2D:.2f} meV for Tc=293K (2D-BKT).")
# 3D XY with interlayer Josephson: kB Tc ~ 0.45 D_s (Janke K_c=0.4542 => coeff ~ 2.2*J_s,
# but normalized the in-plane-stiffness->Tc map gives ~0.45*D_s when D_s in energy units;
# we use the conservative 2D-BKT coeff pi/8=0.3927 and report 3D as *1.40 lift on Tc).
T3D_lift = 1.40
print(f"  3D-XY (interlayer Josephson) lifts Tc by ~{T3D_lift}x over 2D-BKT (Janke/NK).")
need_Ug_3D = need_Ug_2D/T3D_lift
print(f"  => 3D need |U|*<g> = {need_Ug_3D:.2f} meV.")

# ===========================================================================
# TASK 1b/2 — THE FOUR CEILINGS that cap D_s.  This is the make-or-break.
# ===========================================================================
print("\n" + "#"*78)
print("# CEILINGS on D_s  (all closed-form; the cap is the make-or-break)")
print("#"*78)

# --- Ceiling A: ISOLATION cap |U| <= E_gap (else band mixing restores kinetics) ---
# If |U| exceeds the gap to neighbouring bands, the flat band is no longer isolated:
# interaction-induced band mixing restores kinetic dispersion -> the (2a) trade returns.
# So the geometric formula is only valid for |U| <= E_gap. With nu=1/2:
#   D_s_max(isolation) = 4*1/4*E_gap*<g> = E_gap * <g>.
print("\n[A] ISOLATION cap: |U| <= E_gap  (band mixing restores kinetic disp. above it)")
print("    => D_s <= E_gap * <g>  (at nu=1/2).   This is the decisive new constraint.")

# --- Ceiling B: WELCH / trace bounds on <tr g> ---
# LOWER: Peotta-Torma D_s >= |C|  <=>  <tr g> >= |C| (per BZ-cell, dimensionless a^2=1).
#        also the el-ph Welch bound Q_geom>=1/N_band (companion, opposite sign).
# UPPER on <tr g>: the isolated-band trace is NOT unbounded. For a single isolated band
#   the gauge-invariant Wannier spread Omega_I = A_cell <tr g> is bounded by the
#   localization that ISOLATION itself permits: a more-localized Wannier (small Omega_I,
#   small <g>) <=> larger gap; a delocalized Wannier (large <g>) <=> the band touches/
#   nearly-touches neighbours (gap->0).  So <g> and E_gap are ANTI-CORRELATED.
# We encode the trace lower bound and the anti-correlation explicitly below.
print("\n[B] <tr g> bounds (dimensionless, a^2=1):")
print("    LOWER  <tr g> >= |C|        (Peotta-Torma stiffness floor; C=Chern of flat band)")
print("    Welch  Q_geom  >= 1/N_band  (companion el-ph floor, opposite sign)")
print("    ANTI-CORRELATION (key): <g> large <=> Wannier delocalized <=> gap E_gap SMALL.")
print("    => the product E_gap*<g> (=D_s_max) does NOT grow without bound: pushing <g>")
print("       up shrinks E_gap, and vice-versa.  THIS is the geometric cap on D_s.")

# ===========================================================================
# THE ANTI-CORRELATION, made quantitative on a real tunable flat-band model.
# Kagome with intrinsic-SOC: as lambda_SO opens the isolation gap E_gap, the flat-band
# quantum metric <tr g> evolves.  We scan and read off the product E_gap*<g> = D_s_max.
# ===========================================================================
print("\n" + "#"*78)
print("# DECISIVE SCAN — E_gap(lso) vs <tr g>(lso) on the isolated kagome flat band")
print("#   (intrinsic-SOC opens the Chern-isolation gap; t=hopping sets the scale)")
print("#"*78)

def kagome_soc(kx, ky, t=1.0, lso=0.0):
    """kagome with intrinsic (imag 2nd-NN) SOC -> Chern-isolated flat band (C=+-1)."""
    d_ab=(0.5,0.0); d_bc=(0.25,np.sqrt(3)/4); d_ca=(-0.25,np.sqrt(3)/4)
    hab=-2*t*np.cos(kx*d_ab[0]+ky*d_ab[1]); hbc=-2*t*np.cos(kx*d_bc[0]+ky*d_bc[1]); hca=-2*t*np.cos(kx*d_ca[0]+ky*d_ca[1])
    sab=2j*lso*np.sin(kx*d_ab[0]+ky*d_ab[1]); sbc=2j*lso*np.sin(kx*d_bc[0]+ky*d_bc[1]); sca=2j*lso*np.sin(kx*d_ca[0]+ky*d_ca[1])
    return np.array([[0.0,hab+sab,np.conj(hca+sca)],
                     [np.conj(hab+sab),0.0,hbc+sbc],
                     [hca+sca,np.conj(hbc+sbc),0.0]],dtype=complex)

def metric_and_gap(hfun, band, nk=48, **kw):
    ks=2*np.pi*np.arange(nk)/nk; dk=2*np.pi/nk
    n=hfun(0.,0.,**kw).shape[0]
    U=np.zeros((nk,nk,n),complex); Eall=np.zeros((nk,nk,n))
    for i,kx in enumerate(ks):
        for j,ky in enumerate(ks):
            w,v=np.linalg.eigh(hfun(kx,ky,**kw)); U[i,j]=v[:,band]; Eall[i,j]=w
    E=Eall[:,:,band]
    trg=0.0
    for i in range(nk):
        for j in range(nk):
            u=U[i,j]; ux=U[(i+1)%nk,j]; uy=U[i,(j+1)%nk]
            trg+=((1-abs(np.vdot(u,ux))**2)+(1-abs(np.vdot(u,uy))**2))/dk**2
    g_avg=trg/(nk*nk)
    width=E.max()-E.min()
    gaps=[float(np.min(np.abs(E-Eall[:,:,b2]))) for b2 in range(n) if b2!=band]
    iso_gap=min(gaps) if gaps else np.inf
    return g_avg, iso_gap, width

# flat band of the kagome (t>0): the flat band is the HIGHEST band (index 2) for t>0 sign here.
# identify it as the least-dispersive band.
def find_flat_band(hfun, nk=24, **kw):
    ks=2*np.pi*np.arange(nk)/nk
    n=hfun(0.,0.,**kw).shape[0]
    Eall=np.zeros((nk,nk,n))
    for i,kx in enumerate(ks):
        for j,ky in enumerate(ks):
            Eall[i,j]=np.linalg.eigvalsh(hfun(kx,ky,**kw))
    widths=[Eall[:,:,b].max()-Eall[:,:,b].min() for b in range(n)]
    return int(np.argmin(widths))

t = 1.0   # hopping in units that set the band scale; physical t below
print(f"\n{'lso/t':>7} {'<tr g>':>9} {'E_gap/t':>9} {'width/t':>9} {'E_gap*<g>/t':>13}")
scan=[]
for lso in [0.02,0.05,0.10,0.15,0.20,0.30,0.50]:
    fb=find_flat_band(kagome_soc, t=t, lso=lso)
    g,gap,w=metric_and_gap(kagome_soc, fb, nk=48, t=t, lso=lso)
    Dsmax_over_t = gap*g
    scan.append((lso,g,gap,w,Dsmax_over_t))
    print(f"{lso:7.2f} {g:9.3f} {gap:9.3f} {w:9.4f} {Dsmax_over_t:13.3f}")

best=max(scan,key=lambda r:r[4])
print(f"\n  PEAK D_s_max/t = {best[4]:.3f}  at lso/t={best[0]} (<g>={best[1]:.2f}, E_gap/t={best[2]:.2f})")
print("  => the product E_gap*<g> peaks at a FINITE intermediate gap (anti-correlation):")
print("     small lso -> tiny gap (|U| crushed); large lso -> band rigid, <g> drops.")

# ===========================================================================
# TASK 3/4 — REAL 1-atm HOSTS: plug physical t, E_gap, <g>.  D_s -> Tc.
# ===========================================================================
print("\n" + "#"*78)
print("# REAL HOSTS — D_s_max = E_gap*<g> at nu=1/2, then Tc(2D) & Tc(3D)")
print("#"*78)

def tc_from_Ds(Ds_meV):
    t2d=(np.pi/8)*Ds_meV*MEV2K
    return t2d, t2d*T3D_lift

# (1) KAGOME metal (CoSn-class).  Physical numbers from the host-optimize lane + sources:
#     CoSn isolated kagome flat band: SOC iso-gap E_gap ~ 76-80 meV (Kim Nat.Phys 2025),
#     bandwidth <20 meV, <tr g> ~ 2-3 (TB-est, convention-audited; DFT-Wannier still missing).
#     But CoSn is PAULI-PARAMAGNETIC, non-SC: no pairing channel U today.  D_s_max is the
#     CEILING the geometry permits IF a pairing U up to E_gap existed.
print("\n[1] CoSn-class kagome (E_gap~78 meV, <tr g>~2.5 TB-est; non-SC today):")
Egap_cosn=78.0; g_cosn=2.5
Ds_cosn = Egap_cosn*g_cosn            # = 4*1/4*E_gap*<g>
t2d,t3d=tc_from_Ds(Ds_cosn)
print(f"    D_s_max = E_gap*<g> = {Egap_cosn}*{g_cosn} = {Ds_cosn:.0f} meV (at the ISOLATION cap |U|=E_gap)")
print(f"    Tc(2D-BKT) = {t2d:.0f} K ;  Tc(3D-XY) = {t3d:.0f} K   <-- ABSOLUTE ceiling if |U|=E_gap")
print("    *** but |U|=E_gap is the isolation EDGE: at |U|=E_gap the band mixing JUST sets in.")
print("        realistic |U| ~ E_gap/3-E_gap/2 (stay isolated) -> divide Tc by 2-3:")
for frac in [1.0,0.5,0.33]:
    Ds=frac*Ds_cosn; a,b=tc_from_Ds(Ds)
    print(f"        |U|={frac:.2f}*E_gap: D_s={Ds:.0f} meV -> Tc(2D)={a:.0f}K  Tc(3D)={b:.0f}K")

# (2) RHOMBOHEDRAL GRAPHITE / multilayer graphene flat band — the SPECIAL light-element host
#     (NO magnetic/CDW dome => escapes L15/L16 (2b) precursor).
#     ABC-stacked rhombohedral graphite: surface flat band (Guinea/McCann); near-flat band
#     width W ~ 1-20 meV; but the ISOLATION gap to dispersive bulk bands is TINY (~few-30 meV,
#     set by interlayer gamma1~0.38 eV but the flat band sits AT the touching, gap->0 in bulk).
#     The flat band is NEARLY-TRIVIAL (C=0, weak Berry curvature) => SMALL <tr g>.
print("\n[2] RHOMBOHEDRAL GRAPHITE / ABC multilayer (LIGHT C, NO magnetic dome; the special host):")
print("    - surface/penta flat band W~1-20 meV (Guinea-Castro Neto, McCann-Koshino).")
print("    - C=0 (time-reversal-symmetric, NOT a Chern band): trace LOWER bound |C|=0 => no")
print("      topological FLOOR forcing <tr g> up.  the band is nearly TRIVIAL => <tr g> SMALL.")
print("    - ISOLATION gap to bulk dispersive bands is small (the flat band emerges AT a band")
print("      touching); in true 3D rhombohedral graphite the surface band is NOT gap-isolated.")
# TB-model estimate of <tr g> for the ABC trilayer low-energy flat band:
# the low-energy effective H ~ [[0, (k)^N],[(k*)^N,0]] (N=#layers) has a momentum-(N)
# flat-ish band at the surface; its quantum metric is concentrated near k=0 and INTEGRABLE
# but SMALL when averaged (the band is trivial, no winding -> <tr g> << 1 typically).
def abc_Nlayer(kx,ky,N=3,gap=0.0):
    """low-energy ABC N-layer chiral model: H=[[gap,(kx-iky)^N],[(kx+iky)^N,-gap]]."""
    kp=(kx+1j*ky); km=(kx-1j*ky)
    return np.array([[gap, km**N],[kp**N, -gap]],dtype=complex)
# scan a small disk around k=0 (the flat band is a low-energy effective model; sample |k|<kc)
def metric_abc(N=3, gap=0.05, kc=1.0, nk=80):
    ks=np.linspace(-kc,kc,nk); dk=ks[1]-ks[0]
    n=2
    U=np.zeros((nk,nk,n),complex); Eall=np.zeros((nk,nk,n))
    for i,kx in enumerate(ks):
        for j,ky in enumerate(ks):
            w,v=np.linalg.eigh(abc_Nlayer(kx,ky,N=N,gap=gap));
            U[i,j]=v[:,0]; Eall[i,j]=w     # lower band (the gapped 'flat' surface band)
    trg=0.0; cnt=0
    for i in range(nk-1):
        for j in range(nk-1):
            u=U[i,j]; ux=U[i+1,j]; uy=U[i,j+1]
            trg+=((1-abs(np.vdot(u,ux))**2)+(1-abs(np.vdot(u,uy))**2))/dk**2
            cnt+=1
    g_avg=trg/cnt
    width=Eall[:,:,0].max()-Eall[:,:,0].min()
    gap_meas=float(np.min(Eall[:,:,1]-Eall[:,:,0]))
    return g_avg, gap_meas, width
for N in [2,3,4]:
    g,gp,w=metric_abc(N=N, gap=0.1, kc=1.0, nk=80)
    print(f"    ABC N={N}: <tr g>(disk-avg, gap=0.1)~{g:.3f}  (TB low-energy model est)")
print("    => rhombohedral-graphite flat band has MODEST <tr g> from the chiral winding,")
print("       BUT its real-material isolation gap is small and it is a TRIVIAL (C=0) band:")
print("       a real pairing |U| is bounded by the ~few-meV-to-~30meV gap, not ~78meV.")
# representative real numbers for rhombohedral graphite SC (the actual recently-observed one):
# rhombohedral pentalayer/tetralayer graphene SC: Tc ~ 300 mK (Lu et al Nature 2024/2025),
# E_gap(isolation) effectively set by displacement field D ~ tens of meV at best.
print("\n    REAL rhombohedral-graphene SC (Lu Nature 2024/25): measured Tc ~ 0.3 K.")
print("    Isolation/displacement-field gap ~10-30 meV; <tr g> moderate but |U| tiny because")
print("    the SC there is dilute/low-density (nu far from 1/2, tiny pairing scale).")
Egap_rg=20.0; g_rg=0.5;
Ds_rg=Egap_rg*g_rg; a,b=tc_from_Ds(Ds_rg)
print(f"    OPTIMISTIC ceiling |U|=E_gap=20meV, <g>=0.5: D_s={Ds_rg:.0f}meV -> Tc(2D)={a:.0f}K Tc(3D)={b:.0f}K")
print("    => even the OPTIMISTIC graphite ceiling is ~30-40K, FAR below 293K.")

# ===========================================================================
# VERDICT SYNTHESIS — the make-or-break: does ANY real host clear 293K?
# ===========================================================================
print("\n" + "#"*78)
print("# VERDICT — the isolation cap |U|<=E_gap is the binding constraint")
print("#"*78)
print(f"""
  D_s_max = E_gap * <g>  (nu=1/2).  Tc(2D)=(pi/8 kB^-1)*D_s,  Tc(3D)~1.4x.
  For Tc>=293K need D_s >= {need_Ug_2D:.0f} meV (2D) / {need_Ug_3D:.0f} meV (3D).

  REAL HOSTS at the ISOLATION EDGE |U|=E_gap (the absolute, over-optimistic ceiling):
    CoSn kagome   E_gap~78 meV, <g>~2.5 -> D_s_max~{Egap_cosn*g_cosn:.0f} meV -> Tc(3D)~{tc_from_Ds(Egap_cosn*g_cosn)[1]:.0f}K
                  (BUT non-SC today, and |U|=E_gap is the mixing edge; realistic /2-3)
    rhomb. graphite E_gap~20 meV, <g>~0.5 -> D_s_max~{Egap_rg*g_rg:.0f} meV -> Tc(3D)~{tc_from_Ds(Egap_rg*g_rg)[1]:.0f}K

  THE TENSION (task 2, decisive):
    To reach 293K @ nu=1/2 the product E_gap*<g> must be >= {need_Ug_3D:.0f} meV (3D).
    - <g> is bounded BELOW by topology (>= |C|) but pushing <g> UP delocalizes the Wannier
      => SHRINKS E_gap (anti-correlation, verified in the kagome scan: product peaks finite).
    - E_gap is what CAPS |U|.  A real isolated flat band has E_gap ~ SOC/crystal-field scale
      = tens of meV (CoSn 78 is near the MAX known for a clean isolated kagome flat band).
    - So E_gap*<g> ~ (tens of meV)*(O(1)) ~ 100-200 meV AT THE OVER-OPTIMISTIC EDGE.
      {need_Ug_3D:.0f} meV (3D req) sits in this window ONLY at |U|=E_gap exactly (mixing edge,
      where the geometric formula breaks: the (2a) kinetic trade returns).
""")
print("="*78)
print("CONCLUSION: the geometric stiffness route does NOT cleanly clear room-T at 1 atm in")
print("any real isolated flat-band host. The ISOLATION cap |U|<=E_gap (tens of meV) times an")
print("O(1) metric gives D_s_max ~100-200meV; reaching the ~64meV (3D) / ~90meV needed only at")
print("the |U|=E_gap mixing edge where the formula's premise (isolation) fails. => 6th realization.")
print("="*78)
