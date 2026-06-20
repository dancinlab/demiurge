"""
FB-GEOM-LAMBDA round-6 — flat-band lattice ZOO: universality of the geometric law +
Welch bound, and the CLS-support connection (bridge to MATH-SPECTRA CLS integer structure).

For each canonical flat-band lattice we isolate its flat band, compute
    Q_geom = (1/M^2) sum_{k,k'} |<u(k)|u(k')>|^2   (geometric el-ph suppression factor)
    int tr(g)                                       (integrated quantum metric)
and check the Welch lower bound Q_geom >= 1/N_band, plus whether Q_geom tracks the CLS support.
"""
import numpy as np

def qgeom(U_flat):
    """U_flat: (M, n) flat-band eigenvectors over the k-grid."""
    ov2 = np.abs(U_flat.conj() @ U_flat.T)**2
    return ov2.mean()

def int_metric(Ug):
    """Ug: (nk[,nk], n) flat-band eigvecs on a grid -> integrated quantum-metric trace."""
    if Ug.ndim == 2:  # 1D
        nk = Ug.shape[0]; trg = 0.0
        for i in range(nk):
            u = Ug[i]; ux = Ug[(i+1) % nk]
            trg += 1-abs(np.vdot(u, ux))**2
        return trg/nk
    nk = Ug.shape[0]; trg = 0.0
    for i in range(nk):
        for j in range(nk):
            u = Ug[i, j]; ux = Ug[(i+1) % nk, j]; uy = Ug[i, (j+1) % nk]
            trg += (1-abs(np.vdot(u, ux))**2)+(1-abs(np.vdot(u, uy))**2)
    return trg/(nk*nk)

def flat_band_index(E):
    """band with smallest width."""
    w = E.max(axis=tuple(range(E.ndim-1))) - E.min(axis=tuple(range(E.ndim-1)))
    return int(np.argmin(w)), float(w.min())

# ---- 1D lattices ----
def sawtooth(nk, t1=1.0, t2=1/np.sqrt(2)):
    """2-band sawtooth; flat band when t2=t1/sqrt2. CLS support = 2 sites (V)."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, 2)); U = np.zeros((nk, 2, 2), complex)
    for i, k in enumerate(ks):
        hAA = -2*t2*np.cos(k); hAB = -t1*(1+np.exp(-1j*k))
        H = np.array([[hAA, hAB], [np.conj(hAB), 0.0]], complex)
        w, v = np.linalg.eigh(H); E[i] = w; U[i] = v
    return E, U

# ---- 2D lattices ----
def dice_T3(nk, t=1.0):
    """3-band dice/T3: hub H + two rim A,B; flat band at E=0. CLS support = 6 (hexagon)."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, nk, 3)); U = np.zeros((nk, nk, 3, 3), complex)
    d1 = np.array([1.0, 0]); d2 = np.array([-0.5, np.sqrt(3)/2]); d3 = np.array([-0.5, -np.sqrt(3)/2])
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            k = np.array([kx, ky])
            f = -t*(np.exp(1j*k@d1)+np.exp(1j*k@d2)+np.exp(1j*k@d3))
            # hub (H) couples to both rims A,B; rims don't couple (dice)
            H = np.array([[0, f, 0],
                          [np.conj(f), 0, np.conj(f)],
                          [0, f, 0]], complex)
            w, v = np.linalg.eigh(H); E[i, j] = w; U[i, j] = v
    return E, U

def checkerboard(nk, t=1.0, tp=0.5):
    """2-band crossed-square (planar pyrochlore); flat band for suitable t,tp. CLS=4 plaquette."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, nk, 2)); U = np.zeros((nk, nk, 2, 2), complex)
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            hAA = -2*tp*np.cos(kx); hBB = -2*tp*np.cos(ky)
            hAB = -4*t*np.cos(kx/2)*np.cos(ky/2)
            H = np.array([[hAA, hAB], [np.conj(hAB), hBB]], complex)
            w, v = np.linalg.eigh(H); E[i, j] = w; U[i, j] = v
    return E, U

if __name__ == "__main__":
    print("="*72)
    print("FB-GEOM-LAMBDA R6 — flat-band ZOO: Welch-bound universality + CLS link")
    print("="*72)
    print(f"{'lattice':>14} {'N_band':>6} {'width':>8} {'Q_geom':>8} {'1/N':>7} "
          f"{'>=Welch':>8} {'int_g':>8} {'CLS':>4}")

    results = []
    # sawtooth (1D)
    E, U = sawtooth(400)
    b, w = flat_band_index(E)
    Uf = U[:, :, b]
    q = qgeom(Uf.reshape(-1, 2)); ig = int_metric(Uf)
    results.append(("sawtooth(1D)", 2, w, q, ig, 2))
    # dice/T3
    E, U = dice_T3(40)
    b, w = flat_band_index(E)
    Uf = U[:, :, :, b]
    q = qgeom(Uf.reshape(-1, 3)); ig = int_metric(Uf)
    results.append(("dice/T3", 3, w, q, ig, 6))
    # checkerboard
    E, U = checkerboard(40)
    b, w = flat_band_index(E)
    Uf = U[:, :, :, b]
    q = qgeom(Uf.reshape(-1, 2)); ig = int_metric(Uf)
    results.append(("checkerboard", 2, w, q, ig, 4))
    # prior rounds (known)
    results.append(("kagome(R4)", 3, 0.072, 0.497, 0.061, 6))
    results.append(("Lieb(R3)", 3, 0.0, 0.566, 0.0295, 4))
    results.append(("d.sigma m=0(R3)", 2, 0.0, 0.500, 0.0115, 1))

    for name, n, w, q, ig, cls in results:
        ok = "OK" if q >= 1/n - 1e-2 else "VIOL"
        print(f"{name:>14} {n:>6} {w:8.4f} {q:8.4f} {1/n:7.4f} {ok:>8} {ig:8.4f} {cls:>4}")

    print("\nWelch bound Q_geom >= 1/N_band: universal across the flat-band zoo? "
          + ("YES" if all(q >= 1/n-1e-2 for _, n, _, q, _, _ in results) else "NO"))
    # CLS link: within fixed N, does larger CLS support -> more geometry (lower Q_geom)?
    print("\nCLS-support link (bridge to MATH-SPECTRA CLS integer structure):")
    for n in [2, 3]:
        sub = [(nm, cls, q) for nm, nn, _, q, _, cls in results if nn == n]
        sub.sort(key=lambda r: r[1])
        s = "  ".join(f"{nm}:CLS{cls}->Q{q:.3f}" for nm, cls, q in sub)
        print(f"  N={n}: {s}")
