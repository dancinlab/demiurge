"""
multiband-assist/solver2band.py  —  RTSC breakthrough-lens R1:
a TWO-BAND (flat + dispersive) bond-SSH bipolaron exact-diagonalization solver.

MOTIVATION (d2 breakthrough lens against the bond-bipolaron wall)
-----------------------------------------------------------------
The single-band bond-bipolaron wall (../bond-bipolaron/R2_RESULTS.md):
    compact pair  <=>  flat band  <=>  small t  <=>  small t**  <=>  small BKT stiffness.
ONE band has to both BIND the pair (wants small t) and carry the CONDENSATE
(wants large t).  Those pull opposite ways -> tens-of-K Tc cap.

THE LENS — DECOUPLE the two jobs with TWO orbitals per site:
  * orbital A = FLAT band  (t_A ~ 0)   -> does the BINDING (strong SSH e-ph on A)
  * orbital B = DISPERSIVE band (t_B large) -> carries the STIFFNESS
  * inter-orbital hybridization t_AB (and/or a B-channel SSH) lets a pair that is
    BOUND on the flat band HOP coherently through the dispersive band.
If the bound pair can borrow B's dispersion for its center-of-mass motion, the COM
effective mass drops (t** rises) WITHOUT untying the pair -> BKT Tc above the
single-flat-band cap.  This is the flat+dispersive two-band SC structure
(proximitized flat bands; FeSe flat+dispersive; MgB2 two-gap).

This file is a STRICT generalization of ../bond-bipolaron/solver.py to 2 orbitals.
Setting t_AB=0 and putting both electrons on a single orbital reproduces the
single-band numbers (validation V0 below).

MODEL  (1D ring, L sites, PBC + uniform COM twist phi; hbar=a=kB=1)
-------------------------------------------------------------------
Per site i two orbitals m in {A,B}.  Electronic 1-body Hamiltonian:
  H_t  = -t_A Σ_i (a_i^† a_{i+1} + h.c.)          (flat band: t_A small)
       -t_B Σ_i (b_i^† b_{i+1} + h.c.)            (dispersive band: t_B large)
       -t_AB Σ_i (a_i^† b_i + h.c.)               (on-site inter-orbital hybridization)
       + Δ Σ_i (b_i^† b_i)                         (B-orbital onsite offset, band alignment)
Phonons: bond-indexed Einstein modes Ω (one set, SSH lives on orbital A bonds; an
optional B-bond SSH g_B and inter-band-bond SSH are togglable).
  H_ph = Ω Σ_bond n_bond
  H_ep(A) = g_A Σ_bond (a_i^† a_j + h.c.)(d_bond + d_bond^†)
  H_ep(B) = g_B Σ_bond (b_i^† b_j + h.c.)(d_bond + d_bond^†)     [optional]
Hubbard U on double occupancy (same site & orbital).

SECTOR: 2 electrons, spin-singlet (spatial-symmetric) => full ordered-pair space
over the 2L spin-orbital sites {(i,m)}, ⊗ truncated global-cutoff boson Fock space.

OBSERVABLES (identical definitions to the single-band solver, so numbers compare):
  * binding   Δb = E2 − 2 E1
  * COM mass enhancement m**/m_free from twist curvature
  * t** = t_eff_free / (m**/m_free), Tc via the SAME anchor (Zhang/Berciu light-bip.)
"""

import numpy as np
import scipy.sparse as sp
from scipy.sparse.linalg import eigsh
import json, os, time

ORB = 2  # A=0 (flat), B=1 (dispersive)

# ---------------------------------------------------------------------------
# Boson Fock space — bond-indexed Einstein modes, global cutoff Σ n_bond ≤ Nb
# (on a ring, #bonds = L)
# ---------------------------------------------------------------------------
def boson_configs(Nbond, Nb):
    configs = []
    def rec(site, remaining, cur):
        if site == Nbond - 1:
            for n in range(remaining + 1):
                cur.append(n); configs.append(tuple(cur)); cur.pop()
            return
        for n in range(remaining + 1):
            cur.append(n); rec(site + 1, remaining - n, cur); cur.pop()
    rec(0, Nb, [])
    return configs


def boson_index(configs):
    return {c: k for k, c in enumerate(configs)}


# single-particle index over (site, orbital): s = i*ORB + m
def so_index(i, m):
    return i * ORB + m


# ordered two-(spin-orbital) pairs (full (2L)^2 space)
def electron_pairs(L):
    Ns = L * ORB
    return [(p, q) for p in range(Ns) for q in range(Ns)]


# ---------------------------------------------------------------------------
# bond list (ring) — bonds are between consecutive SITES; each bond carries one
# Einstein phonon.  Hopping/SSH acts within an orbital across the bond.
# ---------------------------------------------------------------------------
def ring_bonds(L):
    return [(i, (i + 1) % L) for i in range(L)]


def build_H_2e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0,
               twist=0.0, U=0.0):
    bonds = ring_bonds(L)
    Nbond = len(bonds)
    bcfgs = boson_configs(Nbond, Nb)
    bidx = boson_index(bcfgs)
    Nbos = len(bcfgs)
    epairs = electron_pairs(L)
    epi = {ep: k for k, ep in enumerate(epairs)}
    Npair = len(epairs)
    dim = Npair * Nbos
    tot_b = [sum(c) for c in bcfgs]

    rows, cols, vals = [], [], []
    def add(r, c, v):
        rows.append(r); cols.append(c); vals.append(v)

    # bond index lookup for a (site i, site j) ordered hop within ring
    bond_of = {}
    for bi, (i, j) in enumerate(bonds):
        bond_of[(i, j)] = bi
        bond_of[(j, i)] = bi

    # precompute, for each spin-orbital s=(i,m), the list of intra-orbital
    # hop targets across bonds:  (s_to, bond, t_amp)
    hop_table = {}   # s -> list of (s_to, bond_index, hopping_t, is_ssh_orbital)
    for i in range(L):
        for m in range(ORB):
            s = so_index(i, m)
            lst = []
            tt = tA if m == 0 else tB
            for j in (((i + 1) % L), ((i - 1) % L)):
                b = bond_of[(i, j)]
                lst.append((so_index(j, m), b, tt, m))
            hop_table[s] = lst

    # inter-orbital on-site hybridization targets (no bond/phonon)
    hyb_table = {}   # s -> s_other
    for i in range(L):
        hyb_table[so_index(i, 0)] = so_index(i, 1)
        hyb_table[so_index(i, 1)] = so_index(i, 0)

    twfac_p = np.exp(1j * twist / L)   # +1 hop
    twfac_m = np.exp(-1j * twist / L)  # -1 hop

    for pidx, (p, q) in enumerate(epairs):
        ip, mp = divmod(p, ORB)
        iq, mq = divmod(q, ORB)
        for bk, bc in enumerate(bcfgs):
            k = pidx * Nbos + bk
            nbt = tot_b[bk]

            # ---- diagonal: phonon energy + B-orbital offset Δ + Hubbard U ----
            diag = Omega * nbt
            if mp == 1:
                diag += Delta
            if mq == 1:
                diag += Delta
            if p == q:                       # same spin-orbital double occupancy
                diag += U
            if diag:
                add(k, k, diag)

            # ---- bare intra-orbital hopping (both particles, both directions) ----
            for which, s in ((0, p), (1, q)):
                ii = ip if which == 0 else iq
                for (s_to, b, tt, m_ssh) in hop_table[s]:
                    j_to = s_to // ORB
                    # twist phase by hop direction (+1 if going to (i+1)%L)
                    if j_to == (ii + 1) % L:
                        ph = twfac_p
                    else:
                        ph = twfac_m
                    newpair = (s_to, q) if which == 0 else (p, s_to)
                    npi = epi[newpair]
                    add(npi * Nbos + bk, k, -tt * ph)

            # ---- inter-orbital on-site hybridization (no twist, no phonon) ----
            for which, s in ((0, p), (1, q)):
                s_to = hyb_table[s]
                newpair = (s_to, q) if which == 0 else (p, s_to)
                npi = epi[newpair]
                add(npi * Nbos + k * 0 + bk, k, -tAB)

            # ---- SSH electron-phonon: bond hop dressed by that bond's phonon ----
            # orbital A (g_A) and optionally orbital B (g_B)
            for which, s in ((0, p), (1, q)):
                ii = ip if which == 0 else iq
                for (s_to, b, tt, m_ssh) in hop_table[s]:
                    gg = gA if m_ssh == 0 else gB
                    if gg == 0.0:
                        continue
                    newpair = (s_to, q) if which == 0 else (p, s_to)
                    npi = epi[newpair]
                    # raise on bond b
                    if nbt < Nb:
                        lst = list(bc); lst[b] += 1
                        add(npi * Nbos + bidx[tuple(lst)], k, gg * np.sqrt(bc[b] + 1))
                    # lower on bond b
                    if bc[b] > 0:
                        lst = list(bc); lst[b] -= 1
                        add(npi * Nbos + bidx[tuple(lst)], k, gg * np.sqrt(bc[b]))

    H = sp.csr_matrix((vals, (rows, cols)), shape=(dim, dim), dtype=complex)
    H = 0.5 * (H + H.getH())
    return H, dim


def build_H_1e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0, twist=0.0):
    bonds = ring_bonds(L)
    Nbond = len(bonds)
    bcfgs = boson_configs(Nbond, Nb)
    bidx = boson_index(bcfgs)
    Nbos = len(bcfgs)
    tot_b = [sum(c) for c in bcfgs]
    Ns = L * ORB
    dim = Ns * Nbos
    bond_of = {}
    for bi, (i, j) in enumerate(bonds):
        bond_of[(i, j)] = bi; bond_of[(j, i)] = bi
    twfac_p = np.exp(1j * twist / L); twfac_m = np.exp(-1j * twist / L)
    rows, cols, vals = [], [], []
    def add(r, c, v): rows.append(r); cols.append(c); vals.append(v)
    for i in range(L):
        for m in range(ORB):
            s = so_index(i, m)
            tt = tA if m == 0 else tB
            gg = gA if m == 0 else gB
            for bk, bc in enumerate(bcfgs):
                k = s * Nbos + bk
                nbt = tot_b[bk]
                diag = Omega * nbt + (Delta if m == 1 else 0.0)
                if diag:
                    add(k, k, diag)
                # intra-orbital hopping + SSH
                for j in (((i + 1) % L), ((i - 1) % L)):
                    b = bond_of[(i, j)]
                    s_to = so_index(j, m)
                    ph = twfac_p if j == (i + 1) % L else twfac_m
                    add(s_to * Nbos + bk, k, -tt * ph)
                    if gg != 0.0:
                        if nbt < Nb:
                            lst = list(bc); lst[b] += 1
                            add(s_to * Nbos + bidx[tuple(lst)], k, gg * np.sqrt(bc[b] + 1))
                        if bc[b] > 0:
                            lst = list(bc); lst[b] -= 1
                            add(s_to * Nbos + bidx[tuple(lst)], k, gg * np.sqrt(bc[b]))
                # inter-orbital hybridization
                s_to = so_index(i, 1 - m)
                add(s_to * Nbos + bk, k, -tAB)
    H = sp.csr_matrix((vals, (rows, cols)), shape=(dim, dim), dtype=complex)
    H = 0.5 * (H + H.getH())
    return H, dim


def gs_energy(H):
    n = H.shape[0]
    if n <= 2:
        return float(np.min(np.linalg.eigvalsh(H.toarray())))
    vals = eigsh(H, k=1, which='SA', return_eigenvectors=False, maxiter=20000, tol=1e-9)
    return float(np.min(vals))


# ---------------------------------------------------------------------------
# physical quantities
# ---------------------------------------------------------------------------
def single_energy(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0):
    H, _ = build_H_1e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta)
    return gs_energy(H)


def bipolaron(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0, dphi=0.2, U=0.0):
    twists = (0.0, dphi, 2 * dphi)
    Es = []
    dim2 = None
    for tw in twists:
        H, dim2 = build_H_2e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta, twist=tw, U=U)
        Es.append(gs_energy(H))
    E2_0 = Es[0]
    E1 = single_energy(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta)
    binding = E2_0 - 2 * E1
    d2E = (Es[2] - 2 * Es[1] + Es[0]) / (dphi * dphi)
    # free (g=0) two-particle COM curvature at the SAME band structure = normalization
    Ef = []
    for tw in twists:
        Hf, _ = build_H_2e(L, 0, tA, tB, tAB, Omega, 0.0, 0.0, Delta, twist=tw, U=0.0)
        Ef.append(gs_energy(Hf))
    d2E_free = (Ef[2] - 2 * Ef[1] + Ef[0]) / (dphi * dphi)
    mstar = (d2E_free / d2E) if d2E > 1e-10 else np.inf
    return dict(E2=E2_0, E1=E1, binding=binding, d2E=d2E, d2E_free=d2E_free,
                mstar_over_m0=mstar, dim2=dim2, Es=Es)


def tc_over_omega(mstar_over_m0, t_eff, Omega, n=0.1):
    """SAME anchor as single-band solver: at t/Ω=1, enh=1.55 -> Tc/Ω=0.1.
    t_eff = the *free-band* COM hopping scale the pair would have (here the
    effective single-particle bandwidth-derived hopping the pair inherits)."""
    if not np.isfinite(mstar_over_m0) or mstar_over_m0 <= 0:
        return 0.0
    enh_anchor = 1.55
    C = 0.1 * enh_anchor / (1.0 * n ** (2.0 / 3.0))
    t_pair = t_eff / mstar_over_m0
    return (C * t_pair * n ** (2.0 / 3.0)) / Omega


# ---------------------------------------------------------------------------
# driver
# ---------------------------------------------------------------------------
def main():
    res = {}
    print("=" * 92)
    print("TWO-BAND (flat+dispersive) bond-SSH BIPOLARON — breakthrough lens R1")
    print("=" * 92)
    Om = 1.0
    L, Nb = 6, 5

    # ---- V0: single-band reproduction (tAB=0, t_B large but B empty via Δ huge) ----
    # Put orbital B far up (Δ=50) so both electrons live on flat A => single A-band.
    print("\n[V0] single-band reproduction check: A-only (Δ_B=50, t_AB=0)")
    print("     compare vs ../bond-bipolaron single-band SSH (t=1)")
    r = bipolaron(L, Nb, 1.0, 3.0, 0.0, Om, 1.0, 0.0, Delta=50.0)
    print(f"     A-only t_A=1 g_A=1: binding/t={r['binding']:+.4f}  m**enh={r['mstar_over_m0']:.4f}")
    res['V0_single_band'] = dict(binding=r['binding'], mstar=r['mstar_over_m0'])

    # ---- SINGLE-FLAT-BAND BASELINE (the cap we must beat) ----
    # flat band: small t_A; this is the R2 regime. No dispersive help.
    print("\n[BASE] single FLAT band (t_A small, no dispersive band): the WALL")
    print(f"  {'t_A':>5}{'bind/Ω':>9}{'m**enh':>8}{'t**':>7}{'Tc/Ω':>8}")
    base = []
    for tA in (0.2, 0.3, 0.5):
        r = bipolaron(L, Nb, tA, 3.0, 0.0, Om, 1.0, 0.0, Delta=50.0)
        tstar = tA / r['mstar_over_m0'] if np.isfinite(r['mstar_over_m0']) else 0
        tcO = tc_over_omega(r['mstar_over_m0'], tA, Om)
        tcO = min(tcO, abs(r['binding']))   # pair-breaking cap, same convention
        base.append(dict(tA=tA, binding=r['binding'], mstar=r['mstar_over_m0'],
                         tstar=tstar, tcO=tcO))
        print(f"  {tA:>5.2f}{r['binding']:>9.4f}{r['mstar_over_m0']:>8.3f}"
              f"{tstar:>7.3f}{tcO:>8.4f}")
    res['baseline_flat'] = base
    tA_fix = 0.3
    base_tcO = next(b['tcO'] for b in base if b['tA'] == tA_fix)
    base_bind = next(b['binding'] for b in base if b['tA'] == tA_fix)
    print(f"  --> single-flat-band CAP at t_A={tA_fix}: Tc/Ω={base_tcO:.4f}, bind={base_bind:+.4f}")

    # ---- TWO-BAND: dispersive band B placed ABOVE the flat band so the pair forms ----
    #      on flat A; hybridization lets the COM borrow B's dispersion VIRTUALLY.
    #      Band geometry: B bottom = Δ_B - 2 t_B.  To keep the flat band (E~0) the
    #      LOWEST single-particle states we need Δ_B - 2 t_B >~ 0, i.e. Δ_B >~ 2 t_B.
    print("\n[2BAND] flat A (t_A=0.3, g_A=1) + dispersive B ABOVE it (Δ_B≈2t_B) + hybridization t_AB")
    print("        B is the STIFFNESS reservoir; pair must (a) still BIND on A and (b) get lighter COM.")
    print(f"  {'t_B':>4}{'Δ_B':>5}{'t_AB':>5}{'gB':>4}{'bind/Ω':>9}{'m**enh':>8}{'t_eff':>7}{'Tc/Ω':>8}{'lift':>7}")
    twob = []
    for tB in (2.0, 4.0):
        DB = 2.0 * tB + 0.5            # keep flat band lowest (B bottom just above A)
        for gB in (0.0, 1.0):         # gB=1 => the dispersive band ALSO binds (two-gap)
            for tAB in (0.0, 0.6, 1.2, 2.0):
                r = bipolaron(L, Nb, tA_fix, tB, tAB, Om, 1.0, gB, Delta=DB)
                mstar = r['mstar_over_m0']
                t_eff = 0.5 * r['d2E_free']           # COM hopping the pair inherits (cos-band)
                tcO = tc_over_omega(mstar, t_eff, Om)
                tcO_capped = min(tcO, abs(r['binding']))
                lift = tcO_capped / base_tcO if base_tcO > 0 else np.inf
                twob.append(dict(tB=tB, Delta=DB, tAB=tAB, gB=gB, binding=r['binding'],
                                 mstar=mstar, t_eff=t_eff, tcO=tcO_capped, lift=lift))
                print(f"  {tB:>4.1f}{DB:>5.1f}{tAB:>5.2f}{gB:>4.1f}{r['binding']:>9.4f}"
                      f"{mstar:>8.3f}{t_eff:>7.3f}{tcO_capped:>8.4f}{lift:>7.2f}")
    res['two_band'] = twob

    # ---- TWO-GAP TOUCHING limit (MgB2/FeSe): B near-degenerate with flat A, both
    #      strongly coupled (g_A=g_B=1), strong hybridization. Best case for the lens:
    #      pair condensate lives partly on the stiff band. ----
    print("\n[TOUCH] two-gap limit: B nearly degenerate (Δ_B small), g_A=g_B=1, strong t_AB")
    print(f"  {'t_B':>4}{'Δ_B':>5}{'t_AB':>5}{'bind/Ω':>9}{'m**enh':>8}{'t_eff':>7}{'Tc/Ω':>8}{'lift':>7}")
    touch = []
    for tB in (2.0, 4.0):
        for DB in (0.0, 1.0):
            for tAB in (0.6, 1.5):
                r = bipolaron(L, Nb, tA_fix, tB, tAB, Om, 1.0, 1.0, Delta=DB)
                mstar = r['mstar_over_m0']
                t_eff = 0.5 * r['d2E_free']
                tcO = min(tc_over_omega(mstar, t_eff, Om), abs(r['binding']))
                lift = tcO / base_tcO if base_tcO > 0 else np.inf
                touch.append(dict(tB=tB, Delta=DB, tAB=tAB, binding=r['binding'],
                                  mstar=mstar, t_eff=t_eff, tcO=tcO, lift=lift))
                print(f"  {tB:>4.1f}{DB:>5.1f}{tAB:>5.2f}{r['binding']:>9.4f}"
                      f"{mstar:>8.3f}{t_eff:>7.3f}{tcO:>8.4f}{lift:>7.2f}")
    res['touching_twogap'] = touch

    # ---- best two-band point vs cap ----
    bound_pts = [p for p in (twob + touch) if p['binding'] < -1e-4]
    best = max(bound_pts, key=lambda p: p['tcO']) if bound_pts else None
    res['baseline_cap'] = dict(tA=tA_fix, tcO=base_tcO, binding=base_bind)
    res['best_two_band'] = best
    print("\n[COMPARE]")
    print(f"  single-flat-band CAP:  Tc/Ω={base_tcO:.4f}  bind={base_bind:+.4f}")
    if best:
        print(f"  best 2-band (still bound): Tc/Ω={best['tcO']:.4f}  bind={best['binding']:+.4f}"
              f"  t_AB={best['tAB']}  Δ={best['Delta']}  enh={best['mstar']:.3f}")
        print(f"  ==> lift = {best['tcO']/base_tcO:.2f}x  "
              f"(breakthrough if >1 AND pair still bound)")
    res['breakthrough'] = bool(best and best['tcO'] > base_tcO * 1.05 and best['binding'] < -1e-4)
    print(f"  BREAKTHROUGH (>1.05x lift & bound) = {res['breakthrough']}")

    def jdef(x):
        if isinstance(x, float) and not np.isfinite(x): return None
        if isinstance(x, (np.floating,)):
            v = float(x); return v if np.isfinite(v) else None
        if isinstance(x, (np.integer,)): return int(x)
        if isinstance(x, (np.bool_,)): return bool(x)
        return None
    outp = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results2band.json')
    with open(outp, 'w') as f:
        json.dump(res, f, indent=2, default=jdef)
    print(f"\n[done] {outp}")
    return res


if __name__ == '__main__':
    main()
