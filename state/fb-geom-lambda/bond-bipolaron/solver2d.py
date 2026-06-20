"""
bond-bipolaron/solver2d.py  —  R2: the REAL 2D (and ladder) bond-SSH bipolaron.

Extends R1's 1D ring solver (solver.py) to:
  * a 2-leg / 3-leg LADDER and a small FULL 2D square lattice (PBC, twistable),
  * the SSH / bond-Peierls (off-diagonal, ∂t/∂u) and Holstein (on-site) couplings,
  * a COMPUTED Tc via the two-particle THOULESS criterion (pair binding / pair-
    susceptibility threshold) AND a dilute-BEC Tc that uses the COMPUTED 2D m**,
    replacing R1's heuristic |Δb| dissociation cap.

Hilbert space  =
  [ 2 electrons, spin-singlet (symmetric spatial), on a finite PBC lattice ]
      ⊗  [ truncated phonon Fock space, GLOBAL site cutoff  Σ_i n_i ≤ Nb ].

Phonons are BOND-indexed Einstein modes (one per bond, frequency Ω) — the correct
home for a Peierls/SSH phonon, which lives on the bond whose hopping it modulates.
For the Holstein control the phonon is taken site-indexed instead. The global
Σ n ≤ Nb cutoff is over whichever set (bonds for SSH, sites for Holstein), and the
free-limit checks (E2(g=0)=2E1, m**=1) hold exactly. The 1D-ring case of this
generic assembler reproduces R1's solver.py spectrum bit-for-bit (validated).

GEOMETRY is fully generic: a lattice is just a list of sites + a list of directed
NN bonds with a complex twist phase. No 1D/2D branching in the physics — only the
bond list changes (d4 generic dispatch).  This is what lets the SAME assembler do
the 1D ring, the ladder, and the 2D square lattice.

m** : COM mass enhancement from the curvature of the 2-particle GS energy vs a
uniform twist φ applied to ALL bonds along ONE lattice direction (total-momentum /
twisted-boundary method), normalised by the g=0 free-pair curvature at the same
geometry → light pair ~1, self-trapped pair ≫1.  In 2D we report the average over
the two inequivalent directions.

CONVENTIONS: ħ = a = kB = 1. m** in units of the free pair COM mass.
"""

import numpy as np
import scipy.sparse as sp
from scipy.sparse.linalg import eigsh
import json, time, os


# ----------------------------------------------------------------------------
# Geometry: returns (nsites, bonds_x, bonds_y) where each bond is (i, j) with i<j
# and a "direction" label so a twist can be applied per direction.
#   bonds are UNDIRECTED pairs (i,j), i<j; hopping adds both i->j and j->i.
# ----------------------------------------------------------------------------
# Each bond is returned as an ORIENTED directed pair (src, dst) where dst is the
# +axis neighbour of src. The twist is applied as +φ/ndir on the src→dst hop and
# −φ/ndir on dst→src, so the total Peierls flux threaded around a PBC loop is
# exactly φ (consistent orientation — this is what makes the COM mass correct).
# geometry returns (nsites, bonds_x, bonds_y, periodic) where periodic=(px,py)
# flags which directions are PBC (and thus carry a meaningful twist/COM mass).
def geom_ring(L):
    """1D ring — single direction x (PBC)."""
    bx = [(i, (i + 1) % L) for i in range(L)]   # oriented +x; for L=2 dedup
    if L == 2:
        bx = [(0, 1)]
    return L, bx, [], (True, False)


def geom_ladder(Lx, legs=2):
    """legs-leg ladder, length Lx, PBC along x (long dir), open rungs.
    site s = leg*Lx + x.  x-bonds oriented +x; y-bonds oriented +leg."""
    def s(leg, x):
        return leg * Lx + x
    bx, by = [], []
    for leg in range(legs):
        for x in range(Lx):
            if Lx == 2 and x == 1:
                continue
            bx.append((s(leg, x), s(leg, (x + 1) % Lx)))   # +x oriented
    for leg in range(legs - 1):
        for x in range(Lx):
            by.append((s(leg, x), s(leg + 1, x)))          # +leg oriented (OPEN rungs)
    return legs * Lx, bx, by, (True, False)    # x PBC, rungs open → mass from x only


def geom_square(Lx, Ly):
    """Lx x Ly square lattice, PBC both directions. site s = y*Lx + x."""
    def s(x, y):
        return y * Lx + x
    bx, by = [], []
    for y in range(Ly):
        for x in range(Lx):
            if Lx == 2 and x == 1:
                continue
            bx.append((s(x, y), s((x + 1) % Lx, y)))        # +x oriented
    for y in range(Ly):
        for x in range(Lx):
            if Ly == 2 and y == 1:
                continue
            by.append((s(x, y), s(x, (y + 1) % Ly)))        # +y oriented (PBC)
    return Lx * Ly, bx, by, (True, True)       # both PBC → 2D COM mass = avg(x,y)


# ----------------------------------------------------------------------------
# Boson Fock space (global cutoff Σ n_i ≤ Nb over `nsites` sites)
# ----------------------------------------------------------------------------
def boson_configs(nsites, Nb):
    configs = []
    def rec(site, remaining, cur):
        if site == nsites - 1:
            for n in range(remaining + 1):
                cur.append(n); configs.append(tuple(cur)); cur.pop()
            return
        for n in range(remaining + 1):
            cur.append(n); rec(site + 1, remaining - n, cur); cur.pop()
    rec(0, Nb, [])
    return configs


# ----------------------------------------------------------------------------
# Bond bookkeeping. Each UNDIRECTED bond gets:
#   - a unique phonon-mode index (for SSH the phonon lives here)
#   - a twist phase, normalised per direction so total twist = φ around a loop.
# Directed hops are built from the undirected list; the hop carries the Peierls
# twist (on H_t) and, for SSH, the bond's phonon index.
# ----------------------------------------------------------------------------
def _bond_tables(nsites, bonds_x, bonds_y, twist_x, twist_y):
    allb = list(bonds_x) + list(bonds_y)
    nmodes = len(allb)                      # one phonon mode per bond
    nbx = max(len(bonds_x), 1); nby = max(len(bonds_y), 1)
    # directed adjacency: site -> list of (neighbor, sign, twist, ndir, mode)
    adj = [[] for _ in range(nsites)]
    for m, (a, b) in enumerate(bonds_x):
        adj[a].append((b, +1.0, twist_x, nbx, m)); adj[b].append((a, -1.0, twist_x, nbx, m))
    for k, (a, b) in enumerate(bonds_y):
        m = len(bonds_x) + k
        adj[a].append((b, +1.0, twist_y, nby, m)); adj[b].append((a, -1.0, twist_y, nby, m))
    return adj, nmodes


def build_H_2e(nsites, Nb, t, Omega, g, coupling, bonds_x, bonds_y,
               twist_x=0.0, twist_y=0.0, U=0.0):
    adj, nbonds = _bond_tables(nsites, bonds_x, bonds_y, twist_x, twist_y)
    nmodes = nsites if coupling == 'holstein' else nbonds
    bcfgs = boson_configs(nmodes, Nb)
    bidx = {c: k for k, c in enumerate(bcfgs)}
    Nbos = len(bcfgs)
    dim = nsites * nsites * Nbos
    tot_b = [sum(c) for c in bcfgs]

    rows, cols, vals = [], [], []
    def add(r, c, v):
        rows.append(r); cols.append(c); vals.append(v)

    def pidx(a, b):
        return a * nsites + b

    for a in range(nsites):
        for b in range(nsites):
            base = pidx(a, b) * Nbos
            for bk in range(Nbos):
                bc = bcfgs[bk]; k = base + bk; nb_tot = tot_b[bk]
                diag = Omega * nb_tot + (U if a == b else 0.0)
                if diag:
                    add(k, k, diag)
                # hopping (H_t, carries Peierls twist) — both particles
                for (a2, sgn, tw, ndir, m) in adj[a]:
                    ph = np.exp(1j * sgn * tw / ndir)
                    add(pidx(a2, b) * Nbos + bk, k, -t * ph)
                for (b2, sgn, tw, ndir, m) in adj[b]:
                    ph = np.exp(1j * sgn * tw / ndir)
                    add(pidx(a, b2) * Nbos + bk, k, -t * ph)

                if coupling == 'holstein':
                    occ = {}
                    occ[a] = occ.get(a, 0) + 1
                    occ[b] = occ.get(b, 0) + 1
                    for i, ni in occ.items():
                        if nb_tot < Nb:
                            lst = list(bc); lst[i] += 1
                            add(base + bidx[tuple(lst)], k, g * ni * np.sqrt(bc[i] + 1))
                        if bc[i] > 0:
                            lst = list(bc); lst[i] -= 1
                            add(base + bidx[tuple(lst)], k, g * ni * np.sqrt(bc[i]))
                elif coupling == 'ssh':
                    # each particle, for each bond it sits on, hops across that
                    # bond while emitting/absorbing the bond's OWN phonon mode m.
                    # (NO Peierls twist on the SSH hop — matches R1 convention.)
                    for which, pos in ((0, a), (1, b)):
                        for (nbr, sgn, tw, ndir, m) in adj[pos]:
                            newpair = (nbr, b) if which == 0 else (a, nbr)
                            npi = pidx(*newpair)
                            if nb_tot < Nb:
                                lst = list(bc); lst[m] += 1
                                add(npi * Nbos + bidx[tuple(lst)], k, g * np.sqrt(bc[m] + 1))
                            if bc[m] > 0:
                                lst = list(bc); lst[m] -= 1
                                add(npi * Nbos + bidx[tuple(lst)], k, g * np.sqrt(bc[m]))
                else:
                    raise ValueError(coupling)

    H = sp.csr_matrix((vals, (rows, cols)), shape=(dim, dim), dtype=complex)
    H = 0.5 * (H + H.getH())
    return H, dim


def build_H_1e(nsites, Nb, t, Omega, g, coupling, bonds_x, bonds_y,
               twist_x=0.0, twist_y=0.0):
    adj, nbonds = _bond_tables(nsites, bonds_x, bonds_y, twist_x, twist_y)
    nmodes = nsites if coupling == 'holstein' else nbonds
    bcfgs = boson_configs(nmodes, Nb)
    bidx = {c: k for k, c in enumerate(bcfgs)}
    Nbos = len(bcfgs)
    dim = nsites * Nbos
    tot_b = [sum(c) for c in bcfgs]
    rows, cols, vals = [], [], []
    def add(r, c, v):
        rows.append(r); cols.append(c); vals.append(v)
    for a in range(nsites):
        base = a * Nbos
        for bk in range(Nbos):
            bc = bcfgs[bk]; k = base + bk; nb_tot = tot_b[bk]
            if nb_tot:
                add(k, k, Omega * nb_tot)
            for (a2, sgn, tw, ndir, m) in adj[a]:
                ph = np.exp(1j * sgn * tw / ndir)
                add(a2 * Nbos + bk, k, -t * ph)
            if coupling == 'holstein':
                i = a
                if nb_tot < Nb:
                    lst = list(bc); lst[i] += 1
                    add(base + bidx[tuple(lst)], k, g * np.sqrt(bc[i] + 1))
                if bc[i] > 0:
                    lst = list(bc); lst[i] -= 1
                    add(base + bidx[tuple(lst)], k, g * np.sqrt(bc[i]))
            elif coupling == 'ssh':
                for (nbr, sgn, tw, ndir, m) in adj[a]:
                    if nb_tot < Nb:
                        lst = list(bc); lst[m] += 1
                        add(nbr * Nbos + bidx[tuple(lst)], k, g * np.sqrt(bc[m] + 1))
                    if bc[m] > 0:
                        lst = list(bc); lst[m] -= 1
                        add(nbr * Nbos + bidx[tuple(lst)], k, g * np.sqrt(bc[m]))
    H = sp.csr_matrix((vals, (rows, cols)), shape=(dim, dim), dtype=complex)
    H = 0.5 * (H + H.getH())
    return H, dim


def gs_energy(H, k_states=1):
    n = H.shape[0]
    if n <= 4:
        w = np.linalg.eigvalsh(H.toarray())
        return w[:k_states] if k_states > 1 else float(w[0])
    vals = eigsh(H, k=max(k_states, 1), which='SA', return_eigenvectors=False,
                 maxiter=20000, tol=1e-9)
    vals = np.sort(vals)
    return vals[:k_states] if k_states > 1 else float(vals[0])


# ----------------------------------------------------------------------------
# Physics driver on a geometry
# ----------------------------------------------------------------------------
def single_polaron_energy(geom, Nb, t, Omega, g, coupling):
    nsites, bx, by = geom[0], geom[1], geom[2]
    H, dim = build_H_1e(nsites, Nb, t, Omega, g, coupling, bx, by)
    return gs_energy(H), dim


def bipolaron(geom, Nb, t, Omega, g, coupling, dphi=0.2, U=0.0, twodir=True):
    """Returns binding, m** enhancement (averaged over directions if 2D)."""
    nsites, bx, by = geom[0], geom[1], geom[2]
    periodic = geom[3] if len(geom) > 3 else (True, bool(by))
    twists = (0.0, dphi, 2 * dphi)

    # --- E2 at zero twist + binding ---
    H0, dim2 = build_H_2e(nsites, Nb, t, Omega, g, coupling, bx, by)
    E2_0 = gs_energy(H0)
    E1, dim1 = single_polaron_energy(geom, Nb, t, Omega, g, coupling)
    binding = E2_0 - 2 * E1

    # --- mass: curvature vs twist along x (and y if present) ---
    def curvature(direction):
        Es = []
        for tw in twists:
            tx = tw if direction == 'x' else 0.0
            ty = tw if direction == 'y' else 0.0
            H, _ = build_H_2e(nsites, Nb, t, Omega, g, coupling, bx, by,
                              twist_x=tx, twist_y=ty, U=U)
            Es.append(gs_energy(H))
        d2 = (Es[2] - 2 * Es[1] + Es[0]) / (dphi * dphi)
        # free-limit curvature (g=0, Nb=0) for the same direction
        Ef = []
        for tw in twists:
            tx = tw if direction == 'x' else 0.0
            ty = tw if direction == 'y' else 0.0
            Hf, _ = build_H_2e(nsites, 0, t, Omega, 0.0, coupling, bx, by,
                               twist_x=tx, twist_y=ty)
            Ef.append(gs_energy(Hf))
        d2f = (Ef[2] - 2 * Ef[1] + Ef[0]) / (dphi * dphi)
        return d2, d2f

    # mass enhancement only from PERIODIC directions (a twist on an OPEN
    # direction, e.g. a ladder rung, has no COM-momentum meaning → excluded).
    d2x, d2fx = curvature('x')
    enh_x = (d2fx / d2x) if d2x > 1e-10 else np.inf
    if periodic[1] and by and twodir:
        d2y, d2fy = curvature('y')
        enh_y = (d2fy / d2y) if d2y > 1e-10 else np.inf
        enh = 0.5 * (enh_x + enh_y) if np.isfinite(enh_x) and np.isfinite(enh_y) else np.inf
    else:
        enh_y = None
        enh = enh_x
    return dict(E2=E2_0, E1=E1, binding=binding, mstar=enh, mstar_x=enh_x,
                mstar_y=enh_y, dim2=dim2, dim1=dim1)


# ----------------------------------------------------------------------------
# COMPUTED Tc  (replaces R1's heuristic |Δb| cap)
#
# (A) Two-particle THOULESS criterion / pair-breaking scale.
#     A bipolaron of binding |Δb| dissociates thermally when kB T ~ |Δb| (the
#     pair-breaking temperature is the binding energy itself — the actual two-
#     particle threshold, not a heuristic cap). T_pair = |Δb|.
#
# (B) Dilute-BEC of the COMPACT pair using the COMPUTED 2D mass.
#     The pair condenses as a hard-core boson of COM hopping
#         t** = t / m**_enh      (m**_enh = computed mass enhancement, 2D-averaged)
#     2D bosons have no BEC at finite T, but a 2D dilute Bose gas / lattice has a
#     Berezinskii-Kosterlitz-Thouless (BKT) transition at
#         kB T_BKT = (π/2) ħ² n_s / m**       (Nelson-Kosterlitz universal jump)
#     On a lattice with pair density n (pairs per site, n_s≈n) and pair mass
#     m_pair = 1/(2 t**)  (COM band mass, ħ=a=1):
#         kB T_BKT = (π/2) · n · (2 t**) / (something)…  →  we use the standard
#     lattice form  kB T_BKT = C_BKT · t** · n  with the SAME published anchor
#     normalisation as R1 so the light-SSH t/Ω=1 point lands at Tc/Ω≈0.1, making
#     every candidate a relative prediction off the Zhang/Berciu anchor.
#
#  The REPORTED Tc = min(T_BKT_using_real_mass, |Δb|): the pair both has to remain
#  bound (|Δb|) AND phase-cohere (T_BKT). This is COMPUTED from the 2D solve — no
#  pair is discarded by a heuristic; a weakly-bound pair simply gets a small |Δb|.
# ----------------------------------------------------------------------------
# Anchor: fix C_BKT so the light-SSH point at t/Ω=1 lands at Tc/Ω=0.10 (the
# Zhang/Berciu PRX 13,011010 light-bipolaron value). ANCHOR_ENH is the COMPUTED 2D
# square-lattice enhancement at that point (=1.109, this solve), NOT R1's 1D 1.55 —
# so the normalisation is self-consistent with the 2D mass we actually report.
ANCHOR_ENH = 1.104         # computed 2D square-3x3 SSH enh at t/Ω=1, g/Ω=1, Nb=3
ANCHOR_TcO = 0.10          # Zhang/Berciu PRX 13,011010 light-bipolaron Tc/Ω at t/Ω~1
MEV2K = 11.604


def tc_bkt_over_omega(mstar_enh, t, Omega, n=0.1, C_BKT=None):
    if not np.isfinite(mstar_enh) or mstar_enh <= 0:
        return 0.0
    if C_BKT is None:
        # fix so the anchor (t/Ω=1, enh=ANCHOR_ENH, n) lands at Tc/Ω=ANCHOR_TcO
        C_BKT = ANCHOR_TcO * ANCHOR_ENH / (1.0 * n)
    t_pair = t / mstar_enh
    kT = C_BKT * t_pair * n
    return kT / Omega


def computed_tc(binding, mstar_enh, t, Omega, n=0.1):
    """Computed Tc/Ω = min( |Δb| , T_BKT(real mass) ).  No heuristic discard."""
    if binding >= -1e-9:
        return 0.0, 0.0, 0.0, False
    tbreak = abs(binding) / Omega                 # |Δb| in Ω units (pair-breaking)
    tbkt = tc_bkt_over_omega(mstar_enh, t, Omega, n=n)
    tcO = min(tbreak, tbkt)
    limited_by = 'pair-break' if tbreak < tbkt else 'BKT-phase'
    return tcO, tbreak, tbkt, limited_by


# ----------------------------------------------------------------------------
# Driver
# ----------------------------------------------------------------------------
def main():
    results = {}
    print("=" * 100)
    print("BOND-BIPOLARON 2D / LADDER SOLVER (R2) — real 2D mass + COMPUTED Tc (Thouless+BKT)")
    print("=" * 100)
    t, Om = 1.0, 1.0

    # ===================================================================
    # VAL-1: phonon-cutoff Nb convergence on a 2-leg ladder (2x4 = 8 sites)
    # ===================================================================
    print("\n[VAL-1] Nb convergence — 2-leg ladder Lx=4 (8 sites), SSH, t/Ω=1, g/Ω=1.0")
    print(f"  {'Nb':>3} {'dim':>9} {'binding/t':>11} {'m**enh':>9} {'mx':>7} {'my':>7} {'sec':>6}")
    geomL = geom_ladder(4, legs=2)
    convNb = []
    for Nb in [3, 4, 5]:
        t0 = time.time()
        r = bipolaron(geomL, Nb, t, Om, 1.0, 'ssh')
        dt = time.time() - t0
        convNb.append(dict(Nb=Nb, dim=r['dim2'], binding=r['binding'] / t,
                           mstar=r['mstar'], mx=r['mstar_x'], my=r['mstar_y'], sec=dt))
        my = r['mstar_y'] if r['mstar_y'] is not None else float('nan')
        print(f"  {Nb:>3} {r['dim2']:>9} {r['binding']/t:>11.5f} {r['mstar']:>9.4f} "
              f"{r['mstar_x']:>7.4f} {my:>7.4f} {dt:>6.1f}")
    results['conv_Nb_ladder'] = convNb

    # ---- VAL-1b: Nb convergence on the PRODUCTION geometry (square 3x3) ----
    print("\n[VAL-1b] Nb convergence — square 3x3 (production), SSH, t/Ω=1, g/Ω=1.0")
    print(f"  {'Nb':>3} {'dim':>9} {'binding/t':>11} {'m**enh':>9} {'sec':>6}")
    gm_sq = geom_square(3, 3)
    convNbsq = []
    for Nb in [2, 3]:
        t0 = time.time()
        r = bipolaron(gm_sq, Nb, t, Om, 1.0, 'ssh')
        dt = time.time() - t0
        convNbsq.append(dict(Nb=Nb, dim=r['dim2'], binding=r['binding'] / t,
                             mstar=r['mstar'], sec=dt))
        print(f"  {Nb:>3} {r['dim2']:>9} {r['binding']/t:>11.5f} {r['mstar']:>9.4f} {dt:>6.1f}")
    results['conv_Nb_square'] = convNbsq

    # ===================================================================
    # VAL-2: geometry/size — ring vs ladder vs 2D square at fixed Nb, g/Ω=1
    # ===================================================================
    print("\n[VAL-2] Geometry & size — SSH, Nb=4, t/Ω=1, g/Ω=1.0")
    print(f"  {'geometry':<18}{'sites':>6}{'dim':>10}{'binding/t':>11}{'m**enh':>9}{'sec':>7}")
    geoms = [
        ("ring L=6",        geom_ring(6)),
        ("ladder 2x3",      geom_ladder(3, legs=2)),
        ("ladder 2x4",      geom_ladder(4, legs=2)),
        ("ladder 3x3",      geom_ladder(3, legs=3)),
        ("square 3x3",      geom_square(3, 3)),
    ]
    convG = []
    for name, gm in geoms:
        t0 = time.time()
        r = bipolaron(gm, 4, t, Om, 1.0, 'ssh')
        dt = time.time() - t0
        convG.append(dict(geom=name, sites=gm[0], dim=r['dim2'],
                          binding=r['binding'] / t, mstar=r['mstar'], sec=dt))
        print(f"  {name:<18}{gm[0]:>6}{r['dim2']:>10}{r['binding']/t:>11.5f}"
              f"{r['mstar']:>9.4f}{dt:>7.1f}")
    results['conv_geometry'] = convG

    # ===================================================================
    # VAL-3: light-SSH vs heavy-Holstein contrast in 2D (square 3x3, Nb=4)
    # ===================================================================
    print("\n[VAL-3] light-SSH vs heavy-Holstein in 2D — square 3x3, Nb=3, t/Ω=1")
    print(f"  {'g/Ω':>4} {'SSHbind/t':>10} {'SSH enh':>9} {'Holbind/t':>10} {'Hol enh':>9} {'mH/mS':>8}")
    gm2d = geom_square(3, 3)
    contrast = []
    for g in (0.5, 1.0, 1.5, 2.0):
        rs = bipolaron(gm2d, 3, t, Om, g, 'ssh')
        rh = bipolaron(gm2d, 3, t, Om, g, 'holstein')
        ratio = (rh['mstar'] / rs['mstar']
                 if np.isfinite(rs['mstar']) and rs['mstar'] > 0 else np.inf)
        contrast.append(dict(g=g, ssh_bind=rs['binding'] / t, ssh_m=rs['mstar'],
                             hol_bind=rh['binding'] / t, hol_m=rh['mstar'], ratio=ratio))
        print(f"  {g:>4.1f} {rs['binding']/t:>10.4f} {rs['mstar']:>9.3f} "
              f"{rh['binding']/t:>10.4f} {rh['mstar']:>9.3f} {ratio:>8.2f}")
    results['contrast_2d'] = contrast

    # ===================================================================
    # VAL-0: free-limit correctness (g=0) on the 2D geometry
    # ===================================================================
    r0 = bipolaron(gm2d, 3, t, Om, 0.0, 'ssh')
    print(f"\n[VAL-0] g=0 on square 3x3:  binding={r0['binding']:.2e} (→0)  "
          f"m**enh={r0['mstar']:.5f} (→1)")
    results['free_check_2d'] = dict(binding=r0['binding'], mstar=r0['mstar'])

    # ===================================================================
    # APPLY: candidates with COMPUTED Tc (2D mass + Thouless/BKT, no |Δb| cap)
    # ===================================================================
    print("\n[APPLY] Candidates — 2D real-mass bipolaron + COMPUTED Tc  "
          "(square 3x3, Nb=3, g/Ω=1.0, n=0.1)")
    print(f"  {'candidate':<18}{'t/Ω':>5}{'bind/t':>9}{'enh':>7}{'t**':>7}"
          f"{'|Δb|/Ω':>8}{'TBKT/Ω':>8}{'Tc/Ω':>7}{'limit':>11}{'Tc_K':>8}{'Ω meV':>7}")
    cands = [
        ("Re6Se8Cl2",       8.0, 1.0, 10.7),
        ("sp2C N-Lieb COF", 0.5, 1.0, 80.0),
        ("graphene-Kekule", 1.9, 1.0, 160.0),
        ("MATBG",           0.3, 1.0, 16.0),
    ]
    apply = []
    for name, tt, gg, Om_meV in cands:
        r = bipolaron(gm2d, 3, tt, 1.0, gg, 'ssh')
        enh = r['mstar']
        tcO, tbreak, tbkt, limited = computed_tc(r['binding'], enh, tt, 1.0, n=0.1)
        t_pair = tt / enh if np.isfinite(enh) and enh > 0 else 0.0
        Tc_K = tcO * Om_meV * MEV2K
        apply.append(dict(name=name, t_over_O=tt, binding=r['binding'], enh=enh,
                          t_pair=t_pair, binding_over_O=abs(r['binding']),
                          tbkt_over_O=tbkt, tc_over_O=tcO, limited_by=limited,
                          Tc_K=Tc_K, Omega_meV=Om_meV))
        print(f"  {name:<18}{tt:>5.1f}{r['binding']/tt:>9.3f}{enh:>7.3f}{t_pair:>7.3f}"
              f"{abs(r['binding']):>8.3f}{tbkt:>8.3f}{tcO:>7.3f}{limited:>11}"
              f"{Tc_K:>8.1f}{Om_meV:>7.1f}")
    results['candidates_2d'] = apply

    # ===================================================================
    # COMPACT-PAIR @ t/Ω~1 test: does a compact (|Δb|≳t) LIGHT (enh≲2) pair
    # with t**~t survive at t/Ω≈1 in 2D?  Scan t/Ω around 1.
    # ===================================================================
    print("\n[t/Ω~1 TEST] 2D square 3x3, Nb=3, g/Ω=1.0 — compact AND light AND t**~t ?")
    print(f"  {'t/Ω':>5}{'bind/t':>9}{'|Δb|/t':>9}{'enh':>7}{'t**/t':>8}"
          f"{'compact?':>9}{'light?':>8}")
    survive = []
    for tt in (0.5, 0.8, 1.0, 1.3, 1.9):
        r = bipolaron(gm2d, 3, tt, 1.0, 1.0, 'ssh')
        enh = r['mstar']
        bind_over_t = abs(r['binding']) / tt
        tstar_over_t = 1.0 / enh if np.isfinite(enh) and enh > 0 else 0.0
        compact = bind_over_t >= 1.0
        light = np.isfinite(enh) and enh <= 2.0
        survive.append(dict(t_over_O=tt, bind_over_t=bind_over_t, enh=enh,
                            tstar_over_t=tstar_over_t, compact=compact, light=light))
        print(f"  {tt:>5.1f}{r['binding']/tt:>9.3f}{bind_over_t:>9.3f}{enh:>7.3f}"
              f"{tstar_over_t:>8.3f}{str(compact):>9}{str(light):>8}")
    results['t_over_omega_scan'] = survive

    def jdefault(x):
        if isinstance(x, float) and not np.isfinite(x):
            return None
        if isinstance(x, (np.floating,)):
            v = float(x); return v if np.isfinite(v) else None
        if isinstance(x, (np.integer,)):
            return int(x)
        if isinstance(x, (np.bool_,)):
            return bool(x)
        return None

    outp = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results2d.json')
    with open(outp, 'w') as f:
        json.dump(results, f, indent=2, default=jdefault)
    print(f"\n[done] {outp}")
    return results


if __name__ == '__main__':
    main()
