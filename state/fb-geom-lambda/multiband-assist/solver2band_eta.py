"""
multiband-assist/solver2band_eta.py  —  RTSC breakthrough-lens R2a:
add INTER-BAND COHERENT PAIR-HOPPING (eta-pairing) to the two-band bond-SSH
bipolaron solver, and test whether it breaks the r1 conservation-law cap.

THE r1 RESULT WE ARE ATTACKING
------------------------------
r1 (solver2band.py) added single-particle inter-orbital HYBRIDIZATION t_AB to let a
flat-band-bound pair borrow the dispersive band's stiffness for its COM motion.
Finding: it only TIES the tens-of-K cap (best lift = 1.03x at the two-gap-touching
point, and ONLY because the pair was being unbound). The conservation law:

        |Δb| · t**  ≈  const

t_AB raises t** (lighter COM) but the SAME hybridization splits the pair and lowers
|Δb| in lock-step. Single-particle hopping cannot transfer stiffness to the
condensate without unbinding it.

THE DISTINCT LEVER — eta-PAIRING / COHERENT PAIR-HOPPING
-------------------------------------------------------
Add a term that moves the WHOLE on-site pair coherently between the flat orbital A
and the dispersive orbital B, NEVER splitting it:

    H_J  =  J Σ_i ( a_i↑^† a_i↓^† b_i↓ b_i↑   +   h.c. )
         =  J Σ_i ( P_A(i)^†  P_B(i)  +  h.c. )

where P_m(i)^† = c_{i m ↑}^† c_{i m ↓}^† creates an on-site SINGLET pair in orbital m.
This is fundamentally different from t_AB:
  * t_AB is a ONE-BODY operator: it moves ONE electron A->B, so it can break a pair.
  * H_J is a TWO-BODY operator: it moves a BONDED on-site pair A<->B as a unit.
    It commutes with the pair number; it can NEVER leave one electron behind.

HYPOTHESIS: H_J lets the pair-as-an-object delocalize over the dispersive B sublattice
(its COM hops via the B band) WHILE the two electrons stay bonded on the same site.
If true, t** rises with J while |Δb| stays put -> |Δb|·t** conservation BROKEN ->
Tc above the cap with a bound pair.

REPRESENTATION
--------------
Same spatial-orbital singlet representation as r1: the 2-electron spin-singlet sector
is spanned by ordered pairs (p,q) of spin-orbital SITES s=(site i, orbital m),
s = i*ORB + m, tensored with the bond-phonon Fock space. An ON-SITE singlet pair in
orbital m at site i is the diagonal basis state (s,s) with s=so_index(i,m).
=> H_J connects the basis pair (so(i,0), so(i,0))  <->  (so(i,1), so(i,1)) with amp J.
This is the ONLY new matrix element (it lives on the doubly-occupied "same s" states,
exactly where the Hubbard U also lives). Everything else is identical to r1's
build_H_2e, so J=0 reproduces r1 byte-for-byte (validation V_J0 below).
"""

import numpy as np
import scipy.sparse as sp
from scipy.sparse.linalg import eigsh
import json, os

ORB = 2  # A=0 (flat), B=1 (dispersive)


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


def so_index(i, m):
    return i * ORB + m


def electron_pairs(L):
    Ns = L * ORB
    return [(p, q) for p in range(Ns) for q in range(Ns)]


def ring_bonds(L):
    return [(i, (i + 1) % L) for i in range(L)]


# ---------------------------------------------------------------------------
# 2-electron Hamiltonian WITH eta-pairing inter-band pair-hopping J
# strict superset of r1's build_H_2e (J=0 -> identical)
# ---------------------------------------------------------------------------
def build_H_2e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0,
               twist=0.0, U=0.0, J=0.0):
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

    bond_of = {}
    for bi, (i, j) in enumerate(bonds):
        bond_of[(i, j)] = bi
        bond_of[(j, i)] = bi

    hop_table = {}
    for i in range(L):
        for m in range(ORB):
            s = so_index(i, m)
            lst = []
            tt = tA if m == 0 else tB
            for j in (((i + 1) % L), ((i - 1) % L)):
                b = bond_of[(i, j)]
                lst.append((so_index(j, m), b, tt, m))
            hop_table[s] = lst

    hyb_table = {}
    for i in range(L):
        hyb_table[so_index(i, 0)] = so_index(i, 1)
        hyb_table[so_index(i, 1)] = so_index(i, 0)

    twfac_p = np.exp(1j * twist / L)
    twfac_m = np.exp(-1j * twist / L)

    for pidx, (p, q) in enumerate(epairs):
        ip, mp = divmod(p, ORB)
        iq, mq = divmod(q, ORB)
        for bk, bc in enumerate(bcfgs):
            k = pidx * Nbos + bk
            nbt = tot_b[bk]

            # ---- diagonal: phonon + B offset + Hubbard U ----
            diag = Omega * nbt
            if mp == 1:
                diag += Delta
            if mq == 1:
                diag += Delta
            if p == q:
                diag += U
            if diag:
                add(k, k, diag)

            # ---- bare intra-orbital hopping ----
            for which, s in ((0, p), (1, q)):
                ii = ip if which == 0 else iq
                for (s_to, b, tt, m_ssh) in hop_table[s]:
                    j_to = s_to // ORB
                    ph = twfac_p if j_to == (ii + 1) % L else twfac_m
                    newpair = (s_to, q) if which == 0 else (p, s_to)
                    npi = epi[newpair]
                    add(npi * Nbos + bk, k, -tt * ph)

            # ---- single-particle inter-orbital hybridization (r1 lever) ----
            for which, s in ((0, p), (1, q)):
                s_to = hyb_table[s]
                newpair = (s_to, q) if which == 0 else (p, s_to)
                npi = epi[newpair]
                add(npi * Nbos + bk, k, -tAB)

            # ---- *** NEW: eta-pairing coherent inter-band pair-hopping J *** ----
            # only acts on ON-SITE pairs (p==q, both electrons same spin-orbital
            # site s=(i,m)).  Move the whole pair A<->B at the SAME site i, SAME
            # boson config (on-site, no twist phase, no phonon).
            if p == q and J != 0.0:
                i_site, m_site = divmod(p, ORB)
                s_other = so_index(i_site, 1 - m_site)   # flip orbital, same site
                newpair = (s_other, s_other)             # whole pair moved as a unit
                npi = epi[newpair]
                add(npi * Nbos + bk, k, J)               # h.c. supplied by symmetrization

            # ---- SSH electron-phonon ----
            for which, s in ((0, p), (1, q)):
                ii = ip if which == 0 else iq
                for (s_to, b, tt, m_ssh) in hop_table[s]:
                    gg = gA if m_ssh == 0 else gB
                    if gg == 0.0:
                        continue
                    newpair = (s_to, q) if which == 0 else (p, s_to)
                    npi = epi[newpair]
                    if nbt < Nb:
                        lst = list(bc); lst[b] += 1
                        add(npi * Nbos + bidx[tuple(lst)], k, gg * np.sqrt(bc[b] + 1))
                    if bc[b] > 0:
                        lst = list(bc); lst[b] -= 1
                        add(npi * Nbos + bidx[tuple(lst)], k, gg * np.sqrt(bc[b]))

    H = sp.csr_matrix((vals, (rows, cols)), shape=(dim, dim), dtype=complex)
    H = 0.5 * (H + H.getH())
    return H, dim


def build_H_1e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0, twist=0.0):
    # single-particle Hamiltonian is UNCHANGED by J (J is a 2-body operator that
    # vanishes on the 1-electron sector — there is no pair to hop). Identical to r1.
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


def single_energy(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0):
    H, _ = build_H_1e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta)
    return gs_energy(H)


def bipolaron(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta=0.0, dphi=0.2, U=0.0, J=0.0):
    twists = (0.0, dphi, 2 * dphi)
    Es = []
    dim2 = None
    for tw in twists:
        H, dim2 = build_H_2e(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta,
                             twist=tw, U=U, J=J)
        Es.append(gs_energy(H))
    E2_0 = Es[0]
    E1 = single_energy(L, Nb, tA, tB, tAB, Omega, gA, gB, Delta)
    binding = E2_0 - 2 * E1
    d2E = (Es[2] - 2 * Es[1] + Es[0]) / (dphi * dphi)
    # free (g=0) two-particle COM curvature at the SAME band structure AND SAME J
    # = the normalization the bound pair's COM stiffness is measured against.
    # NOTE J is KEPT in the free reference so that t_eff captures the pair-hopping-
    # induced bandwidth a NON-binding pair would have (apples-to-apples vs r1's t_eff).
    Ef = []
    for tw in twists:
        Hf, _ = build_H_2e(L, 0, tA, tB, tAB, Omega, 0.0, 0.0, Delta,
                           twist=tw, U=0.0, J=J)
        Ef.append(gs_energy(Hf))
    d2E_free = (Ef[2] - 2 * Ef[1] + Ef[0]) / (dphi * dphi)
    mstar = (d2E_free / d2E) if d2E > 1e-10 else np.inf
    return dict(E2=E2_0, E1=E1, binding=binding, d2E=d2E, d2E_free=d2E_free,
                mstar_over_m0=mstar, dim2=dim2, Es=Es)


def tc_over_omega(mstar_over_m0, t_eff, Omega, n=0.1):
    """SAME anchor as r1 / single-band solver."""
    if not np.isfinite(mstar_over_m0) or mstar_over_m0 <= 0:
        return 0.0
    enh_anchor = 1.55
    C = 0.1 * enh_anchor / (1.0 * n ** (2.0 / 3.0))
    t_pair = t_eff / mstar_over_m0
    return (C * t_pair * n ** (2.0 / 3.0)) / Omega


def main():
    res = {}
    print("=" * 96)
    print("eta-PAIRING (coherent inter-band pair-hopping J) two-band bipolaron — lens R2a")
    print("=" * 96)
    Om = 1.0
    L, Nb = 6, 5
    tA_fix = 0.3

    # ---- V_J0: J=0 must reproduce r1 EXACTLY ----
    print("\n[V_J0] J=0 reproduction of r1 (must match r1 results2band.json)")
    r0 = bipolaron(L, Nb, tA_fix, 4.0, 0.0, Om, 1.0, 1.0, Delta=0.0, J=0.0)
    # r1 touch tB=4 DB=0 tAB=0 gA=gB=1: not in table; use the two-gap baseline check
    rbase = bipolaron(L, Nb, tA_fix, 4.0, 0.6, Om, 1.0, 1.0, Delta=0.0, J=0.0)
    print(f"  J=0 (tB4,DB0,tAB0.6,gB1): binding={rbase['binding']:+.5f}  m**={rbase['mstar_over_m0']:.4f}")
    print(f"  r1 reference for same pt:  binding=-1.19657   m**=1.1036  (touching_twogap[4])")
    res['V_J0'] = dict(binding=rbase['binding'], mstar=rbase['mstar_over_m0'],
                       r1_binding=-1.1965684831777104, r1_mstar=1.1035513646557376)

    # ---- single-FLAT-band CAP (the r1 baseline we must beat) ----
    print("\n[BASE] single flat band cap (t_A=0.3, B parked at Δ=50): the WALL")
    rb = bipolaron(L, Nb, tA_fix, 3.0, 0.0, Om, 1.0, 0.0, Delta=50.0, J=0.0)
    base_tcO = min(tc_over_omega(rb['mstar_over_m0'], tA_fix, Om), abs(rb['binding']))
    base_bind = rb['binding']
    print(f"  CAP: Tc/Ω={base_tcO:.4f}  bind={base_bind:+.4f}  m**={rb['mstar_over_m0']:.3f}")
    res['baseline_cap'] = dict(tcO=base_tcO, binding=base_bind)

    # =====================================================================
    # MAIN SWEEP: eta-pairing J on the FLAT-BAND-BOUND pair.
    # Geometry: flat A (t_A=0.3, g_A=1) does the binding; dispersive B is the
    # stiffness reservoir. We test whether J (pair-as-unit hops to B) raises
    # t_eff while keeping |binding| fixed -> break the |Δb|·t** conservation.
    # Two B placements:
    #   (i) B ABOVE flat band  (Δ_B = 2 t_B + 0.5)  -> A stays the binding band
    #   (ii) two-gap touching   (Δ_B = 0)            -> best COM-mobility case
    # =====================================================================
    Jgrid = (0.0, 0.3, 0.6, 1.0, 1.5, 2.0, 3.0)
    print("\n[ETA-SWEEP] flat A + dispersive B + coherent PAIR-HOPPING J  (t_AB=0: pure eta lever)")
    print(f"  {'cfg':>14}{'J':>5}{'bind/Ω':>9}{'m**enh':>8}{'t_eff':>8}{'Tc/Ω':>9}{'lift':>7}{'|Δb|·t**':>10}")
    sweep = []
    configs = [
        ("Babove tB4", dict(tB=4.0, Delta=8.5, gB=0.0)),
        ("touch  tB4", dict(tB=4.0, Delta=0.0, gB=1.0)),
        ("touch  tB6", dict(tB=6.0, Delta=0.0, gB=1.0)),
    ]
    for cname, cfg in configs:
        for J in Jgrid:
            r = bipolaron(L, Nb, tA_fix, cfg['tB'], 0.0, Om, 1.0, cfg['gB'],
                          Delta=cfg['Delta'], J=J)
            mstar = r['mstar_over_m0']
            t_eff = 0.5 * r['d2E_free']
            tcO = min(tc_over_omega(mstar, t_eff, Om), abs(r['binding']))
            lift = tcO / base_tcO if base_tcO > 0 else np.inf
            tstar = t_eff / mstar if np.isfinite(mstar) else 0.0
            cons = abs(r['binding']) * tstar     # the r1 conserved product
            sweep.append(dict(cfg=cname, tB=cfg['tB'], Delta=cfg['Delta'],
                              gB=cfg['gB'], J=J, binding=r['binding'],
                              mstar=mstar, t_eff=t_eff, tstar=tstar,
                              tcO=tcO, lift=lift, cons=cons))
            print(f"  {cname:>14}{J:>5.1f}{r['binding']:>9.4f}{mstar:>8.3f}"
                  f"{t_eff:>8.4f}{tcO:>9.4f}{lift:>7.2f}{cons:>10.4f}")
    res['eta_sweep'] = sweep

    # ---- COMBINED: does eta-pairing STACK on single-particle hybridization t_AB? ----
    print("\n[STACK] eta J on top of the r1 best hybridization point (touch tB4 t_AB=0.6)")
    print(f"  {'J':>5}{'t_AB':>6}{'bind/Ω':>9}{'m**enh':>8}{'t_eff':>8}{'Tc/Ω':>9}{'lift':>7}")
    stack = []
    for J in (0.0, 0.6, 1.5, 3.0):
        r = bipolaron(L, Nb, tA_fix, 4.0, 0.6, Om, 1.0, 1.0, Delta=0.0, J=J)
        mstar = r['mstar_over_m0']; t_eff = 0.5 * r['d2E_free']
        tcO = min(tc_over_omega(mstar, t_eff, Om), abs(r['binding']))
        lift = tcO / base_tcO if base_tcO > 0 else np.inf
        stack.append(dict(J=J, tAB=0.6, binding=r['binding'], mstar=mstar,
                          t_eff=t_eff, tcO=tcO, lift=lift))
        print(f"  {J:>5.1f}{0.6:>6.2f}{r['binding']:>9.4f}{mstar:>8.3f}"
              f"{t_eff:>8.4f}{tcO:>9.4f}{lift:>7.2f}")
    res['stack_with_hyb'] = stack

    # ---- VERDICT ----
    # The CORRECT breakthrough test is NOT "does Tc rise vs the cap" (the dispersive
    # band geometry alone does that at J=0). It is: "does turning on J -- the eta
    # lever -- raise the COM stiffness t** while keeping the pair bound?".
    # So we measure dTc/dJ and dt**/dJ AT FIXED CONFIG. If J is inert (or worse)
    # the eta route adds nothing on top of the band geometry already in the J=0 point.
    bound = [p for p in sweep if p['binding'] < -1e-4]
    best = max(bound, key=lambda p: p['tcO']) if bound else None

    print("\n[VERDICT]")
    print(f"  single-flat-band CAP:      Tc/Ω={base_tcO:.4f}  bind={base_bind:+.4f}")
    eta_lifts_tc = False
    eta_raises_stiff = False
    per_cfg = {}
    for cname, _ in configs:
        rows = sorted([p for p in sweep if p['cfg'] == cname], key=lambda p: p['J'])
        j0, jmax = rows[0], rows[-1]
        dTc = (jmax['tcO'] - j0['tcO']) / j0['tcO'] if j0['tcO'] else 0.0
        dteff = (jmax['t_eff'] - j0['t_eff']) / j0['t_eff'] if j0['t_eff'] else 0.0
        dbind = (abs(jmax['binding']) - abs(j0['binding'])) / abs(j0['binding'])
        per_cfg[cname] = dict(dTc_frac=dTc, dteff_frac=dteff, dbind_frac=dbind,
                              tcO_J0=j0['tcO'], tcO_Jmax=jmax['tcO'])
        if dTc > 0.02: eta_lifts_tc = True
        if dteff > 0.02: eta_raises_stiff = True
        print(f"  cfg {cname:>12}: J 0->{jmax['J']:.0f}  Tc/Ω {j0['tcO']:.4f}->{jmax['tcO']:.4f}"
              f" ({dTc*100:+.1f}%)  t** {j0['t_eff']:.4f}->{jmax['t_eff']:.4f}"
              f" ({dteff*100:+.1f}%)  |bind| {dbind*100:+.1f}%")
    res['per_cfg_Jslope'] = per_cfg
    # eta-pairing breaks the conservation law ONLY IF turning J up raises t** (stiffness
    # transfer) AND keeps the pair bound. It does NOT count if Tc>cap merely from the
    # dispersive-band geometry already present at J=0.
    cons_break = bool(eta_raises_stiff)
    breakthrough_from_eta = bool(eta_lifts_tc and any(
        per_cfg[c]['dbind_frac'] > -0.5 for c in per_cfg))
    res['best_eta'] = best
    res['eta_lifts_tc'] = eta_lifts_tc
    res['eta_raises_stiffness'] = eta_raises_stiff
    res['conservation_broken_by_eta'] = cons_break
    res['breakthrough_from_eta'] = breakthrough_from_eta
    # the J=0 geometric lift (dispersive band only) -- this is the r1 ceiling, NOT eta
    geom_only_lift = best['tcO'] / base_tcO if best else 0.0
    res['breakthrough'] = breakthrough_from_eta
    geom_cof_K = 86.0
    print(f"  best bound point Tc/Ω={best['tcO']:.4f} (lift {geom_only_lift:.2f}x) "
          f"-- but this is the J={best['J']:.0f} GEOMETRY, not eta")
    print(f"  eta lever RAISES COM stiffness t** with J = {eta_raises_stiff}")
    print(f"  eta lever RAISES Tc with J             = {eta_lifts_tc}")
    print(f"  |Δb|·t** conservation BROKEN by eta     = {cons_break}")
    print(f"  BREAKTHROUGH ATTRIBUTABLE TO eta-pairing = {breakthrough_from_eta}")
    print(f"  (geometric route reference: COF {geom_cof_K} K, the rival escape lane)")

    def jdef(x):
        if isinstance(x, float) and not np.isfinite(x): return None
        if isinstance(x, (np.floating,)):
            v = float(x); return v if np.isfinite(v) else None
        if isinstance(x, (np.integer,)): return int(x)
        if isinstance(x, (np.bool_,)): return bool(x)
        return None
    outp = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results2band_eta.json')
    with open(outp, 'w') as f:
        json.dump(res, f, indent=2, default=jdef)
    print(f"\n[done] {outp}")
    return res


if __name__ == '__main__':
    main()
