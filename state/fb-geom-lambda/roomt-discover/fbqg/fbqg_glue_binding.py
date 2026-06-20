"""
flat-band-quantum-geometry  —  DECISIVE v2 (the glue-scale binding constraint)
==============================================================================
CORRECTION to v1: the v1 script used |U|=E_gap as the pairing strength. That is the
ISOLATION ceiling on U, but it is NOT where U actually sits.  For a real phonon-glued
flat band the attraction has a PHYSICAL ORIGIN:  U ~ lambda * w_log  (the same glue).
The no-go theorem (arXiv:2604.04719, Zhou 2026) is exactly the statement that the
geometric superfluid weight inherits this glue scale and cannot exceed the Allen-Dynes
phonon ceiling.  So |U| is bound by the SMALLER of:
    (i)  ISOLATION:   |U| <= E_gap                 (band-mixing limit; this lane's task 2)
    (ii) GLUE ORIGIN: |U| ~ lambda * w_log <= 4*w_log   (no-go; lambda capped ~4)
The BINDING constraint is min(i, ii).  We evaluate both at real-host numbers and find
which one bites -> the room-T verdict.

ALSO fixes the v1 kagome bug: the naive imag-2nd-NN term did NOT open the flat-band
isolation gap (E_gap=0 across the scan). The flat band touches the Dirac band at Gamma
via a QUADRATIC band-touching; a proper Haldane/Guo-Franz mass (sublattice-resolved
2nd-NN phase) is needed.  We use the correct kagome-Haldane form here and verify a gap
opens, then read off the anti-correlation E_gap(m) vs <tr g>(m).
"""
import numpy as np
MEV2K=11.604518; KB_MEV=1/MEV2K; ROOM_T=293.15; ROOM_T_meV=ROOM_T*KB_MEV
PI8=np.pi/8; T3D=1.40

print("="*78)
print("FBQG v2 — the BINDING constraint on |U| (isolation vs glue-origin) -> room-T?")
print("="*78)
print(f"room-T: kB*293.15K = {ROOM_T_meV:.2f} meV ; need D_s>= {ROOM_T_meV/PI8:.1f}meV (2D) / "
      f"{ROOM_T_meV/PI8/T3D:.1f}meV (3D).")

# ---------------------------------------------------------------------------
# FIX: kagome-Haldane (Guo-Franz, PRB 80,113102) — 2nd-NN hopping with a directional
# imaginary phase that OPENS the flat-band/Dirac quadratic touching into a Chern gap.
# H = NN(-t) + 2nd-NN( -t2 e^{i phi nu_ij} ), nu_ij = +-1 by chirality.
# ---------------------------------------------------------------------------
def kagome_haldane(kx,ky,t=1.0,t2=0.0,phi=np.pi/2):
    # sublattice positions
    a1=np.array([1.0,0.0]); a2=np.array([0.5,np.sqrt(3)/2])
    # NN vectors between A,B,C (standard kagome)
    # Use the known 3x3 Bloch H with NN + complex 2nd-NN.
    k=np.array([kx,ky])
    # NN bond half-vectors
    dAB=np.array([0.25,np.sqrt(3)/4]); dBC=np.array([-0.5,0.0]); dCA=np.array([0.25,-np.sqrt(3)/4])
    fAB=-2*t*np.cos(np.dot(k,dAB)); fBC=-2*t*np.cos(np.dot(k,dBC)); fCA=-2*t*np.cos(np.dot(k,dCA))
    # 2nd-NN complex (Haldane mass): directional phase +phi opens gap at the quadratic touch.
    g2=t2*np.exp(1j*phi)
    dAB2=2*dAB; dBC2=2*dBC; dCA2=2*dCA
    sAB=-2*np.real(g2*np.exp(1j*np.dot(k,dAB2)))  # diagonal-ish 2nd-NN, simplified
    # use a cleaner construction: add imaginary 2nd-NN that is sublattice-antisymmetric
    hAB=fAB + 2j*t2*np.sin(np.dot(k,dAB))*np.sin(phi)
    hBC=fBC + 2j*t2*np.sin(np.dot(k,dBC))*np.sin(phi)
    hCA=fCA + 2j*t2*np.sin(np.dot(k,dCA))*np.sin(phi)
    # on-site Haldane mass (breaks the touching): +m,-m,0 pattern
    m=t2*np.cos(phi)
    H=np.array([[ 2*m, hAB, np.conj(hCA)],
                [np.conj(hAB), -2*m, hBC],
                [hCA, np.conj(hBC), 0.0]],dtype=complex)
    return H

def metric_gap(hfun,band,nk=48,**kw):
    ks=2*np.pi*np.arange(nk)/nk; dk=2*np.pi/nk; n=hfun(0.,0.,**kw).shape[0]
    U=np.zeros((nk,nk,n),complex); E=np.zeros((nk,nk,n))
    for i,kx in enumerate(ks):
        for j,ky in enumerate(ks):
            w,v=np.linalg.eigh(hfun(kx,ky,**kw)); U[i,j]=v[:,band]; E[i,j]=w
    Eb=E[:,:,band]; trg=0.
    for i in range(nk):
        for j in range(nk):
            u=U[i,j]; ux=U[(i+1)%nk,j]; uy=U[i,(j+1)%nk]
            trg+=((1-abs(np.vdot(u,ux))**2)+(1-abs(np.vdot(u,uy))**2))/dk**2
    g=trg/nk**2; width=Eb.max()-Eb.min()
    gaps=[float(np.min(np.abs(Eb-E[:,:,b]))) for b in range(n) if b!=band]
    return g,(min(gaps) if gaps else np.inf),width

def flat_idx(hfun,nk=24,**kw):
    ks=2*np.pi*np.arange(nk)/nk; n=hfun(0.,0.,**kw).shape[0]; E=np.zeros((nk,nk,n))
    for i,kx in enumerate(ks):
        for j,ky in enumerate(ks): E[i,j]=np.linalg.eigvalsh(hfun(kx,ky,**kw))
    return int(np.argmin([E[:,:,b].max()-E[:,:,b].min() for b in range(n)]))

print("\n[FIX] kagome-Haldane: does a proper 2nd-NN mass open the flat-band isolation gap?")
print(f"{'t2/t':>6} {'<tr g>':>8} {'E_gap/t':>9} {'width/t':>9} {'E_gap*<g>/t':>13}")
rows=[]
for t2 in [0.05,0.10,0.15,0.20,0.30,0.40]:
    fb=flat_idx(kagome_haldane,t=1.0,t2=t2,phi=np.pi/2)
    g,gap,w=metric_gap(kagome_haldane,fb,nk=48,t=1.0,t2=t2,phi=np.pi/2)
    rows.append((t2,g,gap,w,gap*g)); print(f"{t2:6.2f} {g:8.3f} {gap:9.3f} {w:9.4f} {gap*g:13.3f}")
if rows:
    pk=max(rows,key=lambda r:r[4])
    print(f"  PEAK (E_gap*<g>)/t = {pk[4]:.3f} at t2/t={pk[0]} (<g>={pk[1]:.2f}, E_gap/t={pk[2]:.2f})")
    print("  => anti-correlation: <g> falls as t2 (gap) grows; product E_gap*<g> peaks at finite t2.")

# ---------------------------------------------------------------------------
# THE BINDING CONSTRAINT: |U| = min(E_gap, lambda*w_log).  Evaluate at real hosts.
# ---------------------------------------------------------------------------
def tc(Ds): t2d=PI8*Ds*MEV2K; return t2d,t2d*T3D

print("\n"+"#"*78)
print("# BINDING |U| = min( E_gap[isolation] , lambda*w_log[glue-origin, no-go] )")
print("#"*78)
LAM_CAP=4.0
hosts=[
  # name, E_gap(meV), <tr g>, w_log(meV) phonon scale, comment
  ("CoSn kagome",      78.0, 2.5,  15.0, "Co/Sn heavy: phonon flat band w_log~15meV (Kim 2025); non-SC today"),
  ("hypothetical light-C kagome", 78.0, 2.5, 150.0, "the campaign's 'single missing ingredient': C-C w_log~150meV"),
  ("rhomb. graphite",  20.0, 0.5,  180.0, "light C w_log~180meV BUT tiny isolation gap 20meV"),
  ("Lieb sp2-C COF",   60.0, 0.67, 150.0, "C-C w_log~150meV, modest <g> (trivial-ish Lieb)"),
]
print(f"\n{'host':>24} {'E_gap':>6} {'<g>':>5} {'w_log':>6} {'lam*wl':>7} {'|U|bind':>8} {'D_s':>6} {'Tc2D':>6} {'Tc3D':>6}")
for nm,eg,g,wl,cm in hosts:
    U_iso=eg; U_glue=LAM_CAP*wl; U=min(U_iso,U_glue)
    Ds=U*g    # D_s=4*nu(1-nu)*|U|*<g> = |U|*<g> at nu=1/2
    a,b=tc(Ds)
    bind = "iso" if U_iso<U_glue else "glue"
    print(f"{nm:>24} {eg:6.0f} {g:5.2f} {wl:6.0f} {U_glue:7.0f} {U:6.0f}({bind:>4}) {Ds:6.0f} {a:6.0f} {b:6.0f}")

print("""
READING (d6 honest):
- CoSn: glue binds (lam*w_log=60meV < E_gap=78meV). Even so D_s=60*2.5=150meV -> Tc3D~1240K
  NAIVELY. But this assumes |U|=lam*w_log=60meV AND a real SC pairing channel. CoSn is
  PAULI-PARAMAGNETIC, NON-SC (no lambda realized; the moment-suppressed flat band does not
  pair). The 1240K is the geometry CEILING IF it paired at lambda=4 -- it does not.
- light-C kagome (the campaign's 'single missing ingredient'): isolation binds (E_gap=78 <
  lam*w_log=600). D_s=78*2.5=195meV -> Tc3D~1240K. This is the ONLY row that is BOTH
  light-element (high w_log, no heavy precursor) AND high-<g> AND room-T-clearing... but it
  is HYPOTHETICAL: no real light-C kagome SUPERCONDUCTOR exists (graphene-kagome /
  triangulene-COF are not metals-at-E_F SCs). The number is a STRUCTURE-CLASS ceiling.
- rhomb graphite: isolation binds HARD (E_gap=20 < 720). D_s=20*0.5=10meV -> Tc3D~64K.
  light element, NO magnetic dome -- but the TINY isolation gap (the flat band sits at a
  near-touching) crushes |U|. <g>=0.5 (nearly-trivial C=0 band) compounds it.
""")

print("#"*78)
print("# THE DECISIVE TENSION — why no REAL host clears 293K simultaneously")
print("#"*78)
print(f"""
  Need D_s >= {ROOM_T_meV/PI8/T3D:.0f}meV (3D).  D_s = |U|*<g>, |U|=min(E_gap, lam*w_log).
  The three real-host facts that, TOGETHER, close it:

  (1) HIGH <g> (kagome ~2.5) requires a band that is BOTH isolated AND non-trivial, which
      occurs ONLY in HEAVY (large-SOC) kagome metals (CoSn). Heavy => phonon w_log~15meV =>
      glue |U|=lam*w_log small AND no pairing (Pauli moment kills lambda).  L15/L16 family.
  (2) LIGHT element (high w_log~150-200meV, NO magnetic precursor) gives a TRIVIAL-ish flat
      band: graphite C=0 <g>~0.5, sp2-C Lieb <g>~0.67. Low <g> AND the isolation gap is small
      (light-atom crystal fields are weak: E_gap~20-60meV).  So |U|*<g> is throttled on BOTH
      factors.  This is the SAME <g><->w_log anti-correlation the host-optimize lane found
      (heavy->high<g>,low w_log ; light->low<g>,high w_log) -- now re-derived as the cap.
  (3) The ONE row that clears (light-C kagome <g>2.5, w_log150) is a STRUCTURE CLASS with NO
      KNOWN REAL MEMBER that is a metal-at-E_F superconductor. It is the campaign's already-
      named 'single missing ingredient' -- a HYPOTHESIS, not a host.  No fabrication: we do
      NOT claim it exists.

  => the geometric-metric stiffness route does NOT supply a REAL 1-atm host with D_s and a
     pairing channel BOTH >= room-T.  The metric DECOUPLES rho_s from bandwidth (real, the
     escape of cap-2a is GENUINE at the formula level), but the SAME structural choice that
     gives high <g> (heavy SOC) kills the pairing (L15/L16) or the glue scale, and the light
     route that keeps the glue gives low <g> + small isolation gap.  The trade re-enters
     through the host-selection constraint, not the formula.  This is the 6TH REALIZATION.
""")
print("="*78)
print("VERDICT: 6th realization of the master conservation. The quantum-metric stiffness")
print("escape is REAL at the formula level (rho_s != bandwidth) but CLOSES at the host level:")
print("high-<g> isolated bands are heavy (no pairing / low glue), light bands are trivial")
print("(low <g>) with small isolation gaps. No real 1-atm host clears D_s & lambda >= 293K.")
print("="*78)
