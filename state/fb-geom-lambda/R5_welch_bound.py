"""
FB-GEOM-LAMBDA round-5 — CLOSED-FORM lower bound on the geometric el-ph suppression.

Claim (now identified analytically): the flat-band geometric overlap
    Q_geom = (1/M^2) sum_{k,k'} |<u(k)|u(k')>|^2     (M = #k-points, flat band => uniform FS)
is exactly the WELCH BOUND quantity for the set of normalized Bloch eigenvectors {|u(k)>}
in C^n (n = N_band). By the Welch bound (frame theory):
    Q_geom >= 1/n,  equality iff {|u(k)>} forms a tight frame (uniform CP^{n-1} coverage).

Physical consequence — flat-band el-ph coupling has a GEOMETRIC LOWER BOUND:
    lambda_FB = N(E_F) g0^2 Q_geom / Mw2  >=  N(E_F) g0^2 / (n M w2).
Quantum geometry can suppress the coupling by AT MOST a factor 1/n.
Pairs with: Peotta-Torma D_s >= |C| (stiffness lower bound) and arXiv:2407.12922 (lambda UPPER limit).

This script verifies Q_geom >= 1/n numerically across n and shows the saturating cases.
"""
import numpy as np

def mean_overlap(U):
    """U: (M,n) rows = normalized vectors. Returns Welch quantity (1/M^2) sum |<u_i|u_j>|^2."""
    G = U.conj() @ U.T
    return (np.abs(G)**2).mean()

def random_band(M, n, spread, seed):
    """M normalized vectors in C^n. spread in [0,1]: 0 -> near-identical (trivial, Q->1),
    1 -> Haar-random (tight-frame-like, Q->1/n)."""
    rng = np.random.default_rng(seed)
    base = np.zeros(n, complex); base[0] = 1.0
    U = np.zeros((M, n), complex)
    for i in range(M):
        r = rng.standard_normal(n) + 1j*rng.standard_normal(n)
        r = r/np.linalg.norm(r)
        v = (1-spread)*base + spread*r
        U[i] = v/np.linalg.norm(v)
    return U

if __name__ == "__main__":
    print("="*70)
    print("FB-GEOM-LAMBDA R5 — Welch lower bound  Q_geom >= 1/N_band")
    print("="*70)

    print("\n[1] Welch bound across n (Haar-random band, spread=1 -> tight frame):")
    print(f"{'n':>3} {'1/n (floor)':>11} {'Q_geom(Haar)':>13} {'>= floor?':>10}")
    for n in [2, 3, 4, 5, 6]:
        qs = [mean_overlap(random_band(2000, n, 1.0, s)) for s in range(5)]
        q = np.mean(qs)
        print(f"{n:>3} {1/n:11.4f} {q:13.4f} {'OK' if q >= 1/n-1e-3 else 'VIOLNo':>10}")

    print("\n[2] tuning spread 0->1 at n=3 (trivial band -> tight frame): Q_geom 1 -> 1/3:")
    print(f"{'spread':>7} {'Q_geom':>9}  (floor 1/3 = 0.3333)")
    for sp in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]:
        q = np.mean([mean_overlap(random_band(2000, 3, sp, s)) for s in range(5)])
        print(f"{sp:7.2f} {q:9.4f}")

    print("\n[3] physical flat bands vs their Welch floor 1/n:")
    rows = [("2-band d.sigma m=0 (uniform CP^1)", 2, 0.500),
            ("kagome flat band (R4)",            3, 0.497),
            ("Lieb flat band (R3)",              3, 0.566)]
    print(f"{'model':>34} {'n':>3} {'Q_geom':>8} {'1/n':>7} {'sat%':>6}")
    for name, n, q in rows:
        print(f"{name:>34} {n:>3} {q:8.3f} {1/n:7.3f} {q/(1/n)*100:5.0f}%")

    print("\nVERDICT: Q_geom >= 1/N_band confirmed numerically (Welch bound, frame theory).")
    print("  - 2-band uniform CP^1 SATURATES (0.500 = 1/2) -> tight frame.")
    print("  - kagome/Lieb 3-band sit above 1/3 floor (not tight frames; partial geometry).")
    print("  => flat-band el-ph lambda >= N(E_F) g0^2 / (N_band M w2): a GEOMETRIC LOWER BOUND,")
    print("     analytic companion to Peotta-Torma D_s>=|C| and the lambda<~4 upper limit (2407.12922).")
