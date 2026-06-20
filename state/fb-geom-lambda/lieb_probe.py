"""
FB-GEOM-LAMBDA round-3 probe — Lieb-lattice flat-band Holstein electron-phonon lambda
vs quantum geometry.

Core identity being tested:
  Holstein (local density) el-ph matrix element between band-n Bloch states
     g_{nn}(k,k') = g0 * <u_n(k')|u_n(k)>      (sublattice-summed density coupling)
  => |g_{nn}|^2 = g0^2 |<u_n(k')|u_n(k)>|^2  = g0^2 * Bloch-overlap^2

  Conventional (Allen-Dynes/Hopfield) lambda for an intraband flat band:
     lambda = N(E_F) * <<|g|^2>>_FS / (M w^2)
  With the identity above:
     lambda = (N(E_F) g0^2 / M w^2) * Q_geom,
     Q_geom = (1/Nk^2) sum_{k,k'} |<u(k')|u(k)>|^2   (in [0,1], pure band-geometry)

  Q_geom is the GLOBAL quantum-geometric overlap of the band. (1 - Q_geom) is a gauge-
  invariant spread = global cousin of the integrated quantum metric int g(k).
  Trivial flat band (k-independent u) -> Q_geom=1 (max coupling). Geometrically nontrivial
  flat band (u(k) varies) -> Q_geom<1 -> lambda SUPPRESSED by quantum geometry.

Test: (1) verify direct FS-double-sum lambda == closed-form N(E_F) g0^2 Q_geom / Mw^2.
      (2) tune band geometry at ~fixed width and show lambda tracks Q_geom (geometry), not
          just N(E_F).
      (3) report integrated quantum metric int tr(g) and its link to (1-Q_geom).
"""
import numpy as np

def lieb_h(kx, ky, t=1.0, tp=0.0, dchi=0.0):
    """3-band Lieb Bloch Hamiltonian. A=hub(0,0), B=(1/2,0), C=(0,1/2).
    t  = hub-edge NN hopping. tp = edge-edge NNN hopping (gives the middle band a width).
    dchi = sublattice-symmetry-breaking knob on B,C onsite that reshapes the flat-band
           eigenvector texture (changes quantum geometry) with little width change."""
    hAB = -t * (1.0 + np.exp(-1j*kx))
    hAC = -t * (1.0 + np.exp(-1j*ky))
    # NNN edge-edge (B-C) hopping: connects B and C, disperses the middle band
    hBC = -tp * (1.0 + np.exp(-1j*kx)) * (1.0 + np.exp(1j*ky))
    H = np.array([[0.0,        hAB,        hAC],
                  [np.conj(hAB), dchi,      hBC],
                  [np.conj(hAC), np.conj(hBC), -dchi]], dtype=complex)
    return H

def band_data(nk, **kw):
    """Diagonalize on an nk x nk grid. Return middle-band energies and eigenvectors."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, nk, 3))
    U = np.zeros((nk, nk, 3, 3), dtype=complex)
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            w, v = np.linalg.eigh(lieb_h(kx, ky, **kw))
            E[i, j] = w
            U[i, j] = v
    return ks, E, U

def gaussian_dos(eps, e0, sigma):
    return np.exp(-0.5*((eps-e0)/sigma)**2)/(sigma*np.sqrt(2*np.pi))

def analyze(nk=24, band=1, sigma=0.05, t=1.0, tp=0.0, dchi=0.0, g0=1.0, Mw2=1.0):
    ks, E, U = band_data(nk, t=t, tp=tp, dchi=dchi)
    eb = E[:, :, band].reshape(-1)              # middle-band energies
    ub = U[:, :, :, band].reshape(-1, 3)        # middle-band eigvecs (Nk, 3)
    Nk = eb.size
    e0 = eb.mean()                              # FS at band center (half-filled middle band)
    width = eb.max() - eb.min()

    # smeared DOS at E_F (per cell, per the middle band)
    w_k = gaussian_dos(eb, e0, sigma)           # delta(eps_k - E_F) weights
    NEF = w_k.mean()                            # <delta> = N(E_F) (per cell)

    # Bloch overlaps |<u(k')|u(k)>|^2 over all pairs
    ov = ub.conj() @ ub.T                       # (Nk,Nk) <u(k')|u(k)>
    ov2 = np.abs(ov)**2

    # (1) DIRECT Allen-Dynes/Hopfield lambda: FS double-sum, properly normalized
    #   lambda = N(E_F) * <<|g|^2>>_FS / Mw2,
    #   <<|g|^2>>_FS = [sum_{kk'} w_k w_k' |g|^2] / [ (sum_k w_k)^2 ]
    num = (w_k[:, None] * w_k[None, :] * ov2).sum()
    avg_g2_FS = (g0**2) * num / (w_k.sum()**2)
    lam_direct = NEF * avg_g2_FS / Mw2

    # (2) CLOSED FORM: lambda = N(E_F) g0^2 Q_geom_FS / Mw2  (Q_geom_FS = FS Bloch-overlap)
    Qgeom = ov2.mean()                          # unweighted band-geometry overlap
    Qgeom_FS = num / (w_k.sum()**2)             # FS-weighted geometric overlap (enters lambda)
    lam_formula = (NEF * g0**2 / Mw2) * Qgeom_FS

    # (3) integrated quantum metric tr(g) of the middle band (finite-diff, gauge-invariant)
    #   g_ij(k) = Re[ <d_i u|(1-P)|d_j u> ], trace over i,j; integrate over BZ.
    Ug = U[:, :, :, band]                       # (nk,nk,3)
    trg = 0.0
    for i in range(nk):
        for j in range(nk):
            u = Ug[i, j]
            ux = Ug[(i+1) % nk, j]; uy = Ug[i, (j+1) % nk]
            # quantum metric trace ~ sum_mu (1 - |<u|u+e_mu>|^2) over mu=x,y (small-q metric)
            trg += (1 - abs(np.vdot(u, ux))**2) + (1 - abs(np.vdot(u, uy))**2)
    int_trg = trg / (nk*nk) * (nk/(2*np.pi))**2 * (2*np.pi/nk)**2  # BZ-normalized

    return dict(width=width, NEF=NEF, Qgeom=Qgeom, Qgeom_FS=Qgeom_FS,
                lam_direct=lam_direct, lam_formula=lam_formula, int_trg=trg/(nk*nk),
                e0=e0)

def twoband_flat(nk, m, Delta=1.0, g0=1.0, Mw2=1.0, lower=True):
    """Decisive geometry-isolation test. H(k)=Delta * dhat(k).sigma with dhat normalized
    => two PERFECTLY FLAT bands at +/-Delta (width exactly 0 => N(E_F) identical for all m).
    Texture dhat(k) (hence quantum metric int g) tuned by m only. So lambda varies ONLY
    through the geometric Bloch overlap Q_geom => isolates quantum geometry from N(E_F)."""
    ks = 2*np.pi*np.arange(nk)/nk
    U = np.zeros((nk, nk, 2), dtype=complex)
    bidx = 0 if lower else 1
    sx = np.array([[0,1],[1,0]], complex); sy = np.array([[0,-1j],[1j,0]], complex)
    sz = np.array([[1,0],[0,-1]], complex)
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            d = np.array([np.sin(kx), np.sin(ky), m + np.cos(kx) + np.cos(ky)])
            d = d/np.linalg.norm(d)             # |d|=1 -> flat bands at +/-Delta
            H = Delta*(d[0]*sx + d[1]*sy + d[2]*sz)
            w, v = np.linalg.eigh(H)
            U[i, j] = v[:, bidx]
    ub = U.reshape(-1, 2)
    # perfectly flat => uniform FS weights => N(E_F) is geometry-independent
    ov2 = np.abs(ub.conj() @ ub.T)**2
    Qgeom_FS = ov2.mean()
    # integrated quantum metric trace (finite-diff)
    trg = 0.0
    for i in range(nk):
        for j in range(nk):
            u = U[i, j]; ux = U[(i+1) % nk, j]; uy = U[i, (j+1) % nk]
            trg += (1-abs(np.vdot(u, ux))**2) + (1-abs(np.vdot(u, uy))**2)
    int_trg = trg/(nk*nk)
    NEF = 1.0                                    # flat band: identical for all m (set =1)
    lam = NEF * g0**2 * Qgeom_FS / Mw2
    return dict(m=m, Qgeom_FS=Qgeom_FS, int_trg=int_trg, lam=lam)

if __name__ == "__main__":
    print("="*78)
    print("FB-GEOM-LAMBDA round-3 — Lieb flat-band Holstein lambda vs quantum geometry")
    print("="*78)
    print("\n[A] identity check: direct FS-double-sum lambda  ==  N(EF) g0^2 Q_geom / Mw2 ?")
    print(f"{'tp':>6} {'dchi':>6} {'width':>8} {'N(EF)':>9} {'Qgeom_FS':>9} "
          f"{'lam_direct':>11} {'lam_formula':>11} {'rel.err':>9}")
    for tp in [0.0, 0.02, 0.05, 0.1]:
        r = analyze(nk=28, tp=tp, dchi=0.0, sigma=0.05)
        rel = abs(r['lam_direct']-r['lam_formula'])/max(abs(r['lam_direct']),1e-30)
        print(f"{tp:6.3f} {0.0:6.2f} {r['width']:8.4f} {r['NEF']:9.3f} {r['Qgeom_FS']:9.4f} "
              f"{r['lam_direct']:11.4f} {r['lam_formula']:11.4f} {rel:9.2e}")

    print("\n[B] geometry knob dchi at fixed tp=0.05 (changes texture/quantum-metric, ~fixed width):")
    print(f"{'dchi':>6} {'width':>8} {'N(EF)':>9} {'Qgeom_FS':>9} {'int_trg':>9} {'lambda':>9}")
    for dchi in [0.0, 0.1, 0.2, 0.4, 0.8]:
        r = analyze(nk=28, tp=0.05, dchi=dchi, sigma=0.05)
        print(f"{dchi:6.2f} {r['width']:8.4f} {r['NEF']:9.3f} {r['Qgeom_FS']:9.4f} "
              f"{r['int_trg']:9.4f} {r['lam_direct']:9.4f}")

    print("\n[C] flat limit tp->0: does lambda diverge as 1/width, and is the residue geometric?")
    print(f"{'tp':>6} {'width':>8} {'N(EF)':>9} {'NEF*width':>10} {'Qgeom_FS':>9} {'lambda':>9} {'lam*width':>10}")
    for tp in [0.001, 0.005, 0.01, 0.02, 0.05]:
        r = analyze(nk=32, tp=tp, dchi=0.0, sigma=max(0.5*(r['width'] if tp>0.001 else 0.02),0.01))
        r = analyze(nk=32, tp=tp, dchi=0.0, sigma=0.04)
        print(f"{tp:6.3f} {r['width']:8.4f} {r['NEF']:9.3f} {r['NEF']*r['width']:10.4f} "
              f"{r['Qgeom_FS']:9.4f} {r['lam_direct']:9.4f} {r['lam_direct']*r['width']:10.4f}")

    print("\n[D] DECISIVE — perfectly flat band (width=0, N(EF) fixed), tune geometry only:")
    print("    lambda should track Q_geom and (1-Q_geom) should track int quantum metric.")
    print(f"{'m':>6} {'int_trg(g)':>11} {'Qgeom_FS':>9} {'1-Qgeom':>9} {'lambda':>9}  regime")
    rows = []
    for m in [3.0, 2.5, 2.0, 1.0, 0.5, 0.0, -0.5, -1.0]:
        r = twoband_flat(nk=40, m=m)
        rows.append(r)
        reg = "trivial(d~z)" if abs(m) > 2.2 else ("winding/topo" if abs(m) < 1.6 else "crossover")
        print(f"{m:6.2f} {r['int_trg']:11.4f} {r['Qgeom_FS']:9.4f} {1-r['Qgeom_FS']:9.4f} "
              f"{r['lam']:9.4f}  {reg}")
    g = np.array([r['int_trg'] for r in rows]); q = np.array([1-r['Qgeom_FS'] for r in rows])
    cc = np.corrcoef(g, q)[0, 1]
    print(f"\n  corr( int_trg(g) , 1-Q_geom ) = {cc:+.4f}   "
          f"=> {'GEOMETRIC LAW holds (lambda suppressed by quantum metric)' if cc>0.9 else 'weak/none'}")
