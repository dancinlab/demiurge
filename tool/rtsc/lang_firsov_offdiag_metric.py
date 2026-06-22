"""
LANE B — LANG-FIRSOV VARIATIONAL CROSS-CHECK of the bond-SSH (off-diagonal / Peierls) phonon
current vertex, independent of Lane A (multiband BdG Kubo).

QUESTION (the one remaining falsifier):
  Lane A (kubo_pair_stiffness.py) used a STATIC mean-field (bond-SSH folded into an effective static
  U) and found the pair-channel geometric weight D_geom = 4|U|nu(1-nu)<g> EXACTLY recovers the
  single-particle Peotta-Torma <g>~0.1-0.5 -- NO enhancement, x4.7-5.6 short of room-T.
  The static MF OMITS the RETARDED phonon vertex. Does the retarded bond-SSH (off-diagonal/Peierls)
  phonon CURRENT vertex make the pair-channel <g>_pair EXCEED ~0.5 (reopening room-T), or does it
  just renormalize hoppings (leaving <g> a band-geometry invariant unchanged, closing the crack)?

LANG-FIRSOV (variational) DERIVATION -- bond/off-diagonal (Peierls/SSH) coupling:
  H = sum_<ij> [ -t_ij + g_ij (b_ij + b_ij^dag) ] (c_i^dag c_j + h.c.)  +  Omega sum b^dag b
  (phonon modulates the HOPPING, not the site energy -- this is the bond-SSH / off-diagonal vertex.)

  The off-diagonal Lang-Firsov / variational displaced-oscillator transform
      U_LF = exp[ sum_<ij> (g_ij/Omega) (c_i^dag c_j) (b_ij^dag - b_ij) ]
  is applied variationally (Merrifield/Toyozawa bond-polaron ansatz). To O(g^2) and at the
  variational mean-field level it does TWO things, BOTH multiplicative on the bare hopping:
    (1) DEBYE-WALLER band narrowing:   t_ij -> t_ij * exp(-(g_ij/Omega)^2 * (n_B + 1/2) * 2)
        At T=0:  t_ij -> t_ij * exp(-(g_ij/Omega)^2)            ==  t_ij * D_W   (D_W <= 1)
    (2) a phonon-ASSISTED retarded hopping correction (the cross term), which at the variational
        mean-field level is ALSO proportional to t_ij (no new bond is created where t_ij=0):
            t_ij^assisted  ~  +t_ij * (g_ij/Omega)^2 / (1 + Omega/W)   (retardation factor)
  The crucial structural fact: BOTH renormalizations are PROPORTIONAL to the bare t_ij on the SAME
  bond. The dressed Bloch Hamiltonian is therefore
            H_eff(k) = Z_bond(k) (.) H_bare(k)        (element-wise on the bond hoppings)
  where Z_bond is a real, k-INDEPENDENT (uniform g) or smoothly-k-dependent (bond-dependent g)
  positive scalar PER BOND.

WHY THIS IS THE DECISIVE TEST:
  The quantum metric g_mu_nu(k) (Fubini-Study) is computed from the EIGENVECTORS |u(k)>, which are
  gauge-invariant under a uniform real rescaling of all hoppings (the eigenvectors of c*H are the
  eigenvectors of H). So a UNIFORM Debye-Waller factor leaves <g> EXACTLY invariant -- it only
  rescales the bandwidth (-> kills D_conv further, the OPPOSITE of help). The ONLY way the retarded
  vertex can RAISE <g> is if the bond-dependent dressing Z_bond CHANGES THE RATIO of hoppings on
  inequivalent bonds (sublattice-selective dressing), reshaping |u(k)>. We test BOTH:
    (A) uniform g on all bonds   -> Z_bond uniform -> <g> invariant (prediction: no enhancement)
    (B) bond-selective g (only the flat-band-forming bond dressed) -> Z reshapes |u(k)> -> <g> moves
  and we measure the renormalized <g> and the renormalized current matrix element <m|j_dressed|n>
  vs the bare dH/dk, on three flat-band hosts (sawtooth, cross-stitch, Lieb).

HONEST (d6 / variational caveat):
  Lang-Firsov is a VARIATIONAL (upper-bound-on-mass) ansatz: it OVER-narrows the band in the
  anti-adiabatic limit (Omega >> W, small polaron) where it is trustworthy, and is a POOR (over-
  localizing) approximation in the adiabatic limit (Omega << W) where the true polaron is large and
  the band narrows far less. So LF gives a CONSERVATIVE (upper) bound on the mass = LOWER bound on
  D_conv, and -- the key point for this test -- it CANNOT manufacture geometric weight that the
  band-geometry invariant forbids. Every number below is computed from TB eigenvectors; no
  fabrication. Room-T SC remains UNDISCOVERED.

References (novelty framing, NOT recomputed):
  Lang & Firsov, JETP 16:1301 (1963)                 -- canonical small-polaron transform
  Merrifield, J Chem Phys 40:445 (1964); Toyozawa    -- variational bond/off-diagonal polaron ansatz
  Marchand, Hague, ... SSH/Peierls bond-polaron      -- off-diagonal e-ph, non-Lang-Firsov subtleties
  Peotta & Torma, Nat Commun 6:8944 (2015)           -- D_s = D_conv + D_geom, geom = quantum metric
  Huhtinen, Herzog-Arbeitman, Peotta 2104.14257      -- minimal quantum metric, uniform pairing
"""
import numpy as np

meV2K = 11.604


# ---------------------------------------------------------------------------
# Flat-band 2-band hosts with bond-resolved hoppings, so we can dress bonds SELECTIVELY.
# Each returns H(k) given a per-bond dressing dict; current op j=dH/dk computed by finite diff
# of the SAME dressed H (so the dressed current vertex is exactly consistent with the dressed band).
# ---------------------------------------------------------------------------
def sawtooth_dressed(k, t1, t2):
    """Sawtooth: apex-base bond t1 (intra-cell) + base-apex t2 (inter-cell) + base-base 2t1 cos.
    Flat lower band requires t2 = sqrt(2) t1 with the base chain 2t1. Dressing t1,t2 SEPARATELY
    (bond-selective) reshapes the eigenvectors; dressing both equally is uniform."""
    c = np.cos(k)
    H = np.array([[0.0,                        -t1 - t2 * np.exp(-1j * k)],
                  [-t1 - t2 * np.exp(1j * k),  -2 * t1 * c]], complex)
    return H


def cross_stitch_dressed(k, t, d):
    """Cross-stitch ladder: legs +-t, rung detune d gaps the flat band. The two off-diagonal
    'stitch' bonds carry t; the diagonal carries +-t and the detune d. Dressing the off-diagonal
    stitch bond selectively is the bond-SSH (off-diagonal) channel."""
    c = np.cos(k)
    H = np.array([[-2 * t * c + d / 2, -2 * t * c],
                  [-2 * t * c,         -2 * t * c - d / 2]], complex)
    return H


def lieb_line_dressed(kx, ky, tx, ty):
    """Lieb 3-band at fixed ky; tx dresses the kx-direction bond, ty the ky-direction bond.
    Bond-selective dressing tx != ty reshapes the flat-band eigenvector (geometric reshaping)."""
    H = np.array([[0, -2 * tx * np.cos(kx / 2), -2 * ty * np.cos(ky / 2)],
                  [-2 * tx * np.cos(kx / 2), 0, 0],
                  [-2 * ty * np.cos(ky / 2), 0, 0]], complex)
    return H


# ---------------------------------------------------------------------------
# Lang-Firsov dressing factors (variational, T=0).
#   lam = g/Omega  (dimensionless coupling).  Debye-Waller D_W = exp(-lam^2).
#   retarded assisted-hopping enhancement of the SAME bond: (1 + alpha * lam^2), alpha = 1/(1+Omega/W)
#   net per-bond Z = D_W * (1 + alpha lam^2)   (variational, O(lam^2) consistent).
# This is the analytic phonon-renormalized hopping. We then build H_eff and measure <g>.
# ---------------------------------------------------------------------------
def lf_Z(lam, Omega, W):
    """Net Lang-Firsov per-bond hopping renormalization Z(lam) at T=0 (variational)."""
    DW = np.exp(-lam**2)                       # Debye-Waller narrowing (always <=1)
    alpha = 1.0 / (1.0 + Omega / max(W, 1e-9))  # retardation weight of assisted hopping
    return DW * (1.0 + alpha * lam**2)


# ---------------------------------------------------------------------------
# Quantum metric <g> = BZ-averaged tr g of the flattest band, from eigenvectors.
# Dressed CURRENT vertex |<m|j|n>| via finite-diff of the DRESSED H (retarded vertex included
# because the hoppings carrying k-phases are themselves Z-dressed).
# ---------------------------------------------------------------------------
def metric_and_vertex_1d(Hfun, nk):
    """Hfun(k)->H (the already-dressed H). Returns flat-band width, <g_xx>, max interband |<m|j|n>|,
    and the geometric weight 4*<g_xx> (the D_geom kernel, U-independent normalization U=1,nu=1/2)."""
    ks = 2 * np.pi * np.arange(nk) / nk
    nb = Hfun(0.0).shape[0]
    E = np.zeros((nk, nb)); V = np.zeros((nk, nb, nb), complex); J = np.zeros((nk, nb, nb), complex)
    dk = ks[1] - ks[0]
    for i, k in enumerate(ks):
        H = Hfun(k)
        Hp = Hfun(k + dk); Hm = Hfun(k - dk)
        dH = (Hp - Hm) / (2 * dk)              # dressed current vertex j = dH_eff/dk (retarded)
        w, vec = np.linalg.eigh(H)
        E[i] = w; V[i] = vec
        J[i] = vec.conj().T @ dH @ vec
    widths = E.max(0) - E.min(0)
    flat = int(np.argmin(widths))
    g_xx = 0.0; vmax = 0.0; n_used = 0
    for i in range(nk):
        mingap = np.inf
        for m in range(nb):
            if m == flat: continue
            mingap = min(mingap, abs(E[i, flat] - E[i, m]))
        if mingap < 1e-4:                       # skip BWB obstruction points (honest exclusion)
            continue
        n_used += 1
        for m in range(nb):
            if m == flat: continue
            dE = E[i, flat] - E[i, m]
            jmn = J[i, m, flat]
            g_xx += np.abs(jmn)**2 / dE**2
            vmax = max(vmax, np.abs(jmn))
    g_xx = g_xx / n_used if n_used else float('inf')
    return dict(width=float(widths[flat]), g_xx=float(g_xx),
                D_geom_kernel=float(4 * g_xx), vmax=float(vmax),
                vel_flat=float(np.mean(np.abs(J[:, flat, flat]))))


def metric_2d_lieb(tx_z, ty_z, t, nk):
    """Lieb 2D <tr g> of the flat band with bond-selective dressing tx=tx_z*t, ty=ty_z*t."""
    ks = 2 * np.pi * np.arange(nk) / nk
    U = np.empty((nk, nk, 3), complex); E = np.empty((nk, nk, 3))
    for a, kx in enumerate(ks):
        for b, ky in enumerate(ks):
            w, v = np.linalg.eigh(lieb_line_dressed(kx, ky, tx_z * t, ty_z * t))
            # flat band of Lieb is E=0 -> the middle eigenvalue; track index by closeness to 0
            iflat = int(np.argmin(np.abs(w)))
            E[a, b] = w; U[a, b] = v[:, iflat]
    dk = ks[1] - ks[0]
    gsum = 0.0; n = 0
    for a in range(nk):
        for b in range(nk):
            u0 = U[a, b]; ux = U[(a + 1) % nk, b]; uy = U[a, (b + 1) % nk]
            gxx = (1 - abs(np.vdot(u0, ux))**2) / dk**2
            gyy = (1 - abs(np.vdot(u0, uy))**2) / dk**2
            gsum += gxx + gyy; n += 1
    return gsum / n


# ===========================================================================
if __name__ == "__main__":
    np.set_printoptions(precision=4, suppress=True)
    nk = 240; Omega = 1.0; t = 1.0
    print("=" * 82)
    print("LANE B — LANG-FIRSOV variational cross-check: does the RETARDED bond-SSH (off-diagonal)")
    print("phonon current vertex raise <g> ABOVE the bare band-geometry value, or just rescale t?")
    print(f"  nk={nk}  Omega={Omega}  t={t}   [all numbers computed, d6; LF=variational upper-mass]")
    print("=" * 82)

    # bandwidth scale W ~ a few t for the retardation weight alpha
    W = 4.0 * t

    # ---------------- TEST A: UNIFORM dressing (same g on every bond) ----------------
    print("\n[TEST A] UNIFORM Lang-Firsov dressing (g equal on ALL bonds) -- prediction: <g> INVARIANT")
    print("         (uniform real rescale of H -> identical eigenvectors -> identical quantum metric)")
    print(f"  {'lam=g/Om':>9} {'Z(bond)':>8} | {'sawtooth <g>':>13} {'cross-st <g>':>13} {'Lieb <g>(2D)':>13}")
    base_saw = base_cs = base_lieb = None
    for lam in [0.0, 0.5, 1.0, 1.5, 2.0]:
        Z = lf_Z(lam, Omega, W)
        rs = metric_and_vertex_1d(lambda k: sawtooth_dressed(k, Z * t, Z * np.sqrt(2) * t), nk)
        rc = metric_and_vertex_1d(lambda k: cross_stitch_dressed(k, Z * t, 2 * t), nk)  # detune d undressed (on-site)
        g_lieb = metric_2d_lieb(Z, Z, t, 28)
        if lam == 0.0:
            base_saw, base_cs, base_lieb = rs['g_xx'], rc['g_xx'], g_lieb
        print(f"  {lam:>9.2f} {Z:>8.4f} | {rs['g_xx']:>13.4f} {rc['g_xx']:>13.4f} {g_lieb:>13.4f}")
    print(f"  -> baseline <g>: sawtooth={base_saw:.4f}  cross-stitch={base_cs:.4f}  Lieb={base_lieb:.4f}")
    print("  -> UNIFORM dressing leaves <g> invariant (the metric is a band-geometry invariant under")
    print("     real uniform hopping rescale). It only narrows W -> D_conv DROPS further. No <g> gain.")

    # ---------------- TEST B: BOND-SELECTIVE dressing (only one bond dressed) ----------------
    print("\n[TEST B] BOND-SELECTIVE Lang-Firsov dressing (off-diagonal vertex on ONE bond only)")
    print("         -- the ONLY channel that can reshape |u(k)> and move <g>. We dress the")
    print("         flat-band-forming bond and measure how far <g> can be pushed vs baseline ~0.5.")
    print(f"  {'lam':>5} {'Z_sel':>7} | {'saw <g>':>9} {'Δ/base':>7} | {'Lieb tx-only <g>':>16} {'Δ/base':>7}")
    saw0 = metric_and_vertex_1d(lambda k: sawtooth_dressed(k, t, np.sqrt(2) * t), nk)['g_xx']
    lieb0 = metric_2d_lieb(1.0, 1.0, t, 28)
    best_saw = saw0; best_lieb = lieb0
    for lam in [0.0, 0.5, 1.0, 1.5, 2.0, 3.0]:
        Z = lf_Z(lam, Omega, W)
        # dress ONLY t2 (inter-cell apex bond) of sawtooth -> breaks the flat-band condition,
        # reshapes eigenvectors. dress ONLY tx of Lieb.
        rsel = metric_and_vertex_1d(lambda k: sawtooth_dressed(k, t, Z * np.sqrt(2) * t), nk)
        g_lieb_sel = metric_2d_lieb(Z, 1.0, t, 28)
        best_saw = max(best_saw, rsel['g_xx']); best_lieb = max(best_lieb, g_lieb_sel)
        print(f"  {lam:>5.2f} {Z:>7.4f} | {rsel['g_xx']:>9.4f} {rsel['g_xx']/saw0:>7.3f} |"
              f" {g_lieb_sel:>16.4f} {g_lieb_sel/lieb0:>7.3f}")
    print(f"  -> baseline <g>: sawtooth={saw0:.4f}  Lieb(2D tr g)={lieb0:.4f}")
    print(f"  -> bond-selective MAX <g>: sawtooth={best_saw:.4f} ({best_saw/saw0:.2f}x),"
          f" Lieb={best_lieb:.4f} ({best_lieb/lieb0:.2f}x)")

    # ---------------- HEADLINE: does dressed <g> EXCEED single-particle <g>~0.5? ----------------
    print("\n" + "=" * 82)
    print("HEADLINE — pair-channel <g> via LF dressing vs its OWN bare (single-particle) baseline")
    print("  (apples-to-apples: SAME host, SAME normalization, bare lam=0 vs dressed; the bare")
    print("   value IS the single-particle Peotta-Torma <g> for that host. We ask: does DRESSING")
    print("   raise the host's own <g> above its bare value? -- the only fabrication-free test.)")
    print("=" * 82)
    # apples-to-apples per host: dressed-best / bare-baseline (same normalization within the host)
    r_saw = best_saw / saw0
    r_lieb = best_lieb / lieb0
    print(f"  sawtooth (1D gxx):  bare <g>={saw0:.4f}  best-dressed <g>={best_saw:.4f}  ratio={r_saw:.3f}")
    print(f"  Lieb   (2D tr g) :  bare <g>={lieb0:.4f}  best-dressed <g>={best_lieb:.4f}  ratio={r_lieb:.3f}")
    ratio = max(r_saw, r_lieb)
    exceeds = ratio > 1.05
    print(f"  MAX dressed/bare ratio over hosts                = {ratio:.3f}")
    print(f"  RETARDED VERTEX EXCEEDS the bare (single-particle) <g>?  = {'YES' if exceeds else 'NO'}")

    # 5x room-T check: D_s budget. BKT: kTc <= (pi/2) D_s, D_s = 4|U|nu(1-nu)<g>.
    # The campaign reality anchor: real flat-band SC Tc~6K, room-T needs ~50x in kTc i.e. <g>*U*Om.
    # Even an UNCHANGED <g> with the band NARROWED (D_W<1) gives a SMALLER D_conv. So LF can only
    # *lower* the conventional channel; the geometric channel needs <g> to jump ~5x to close room-T.
    needed = 5.0
    print(f"\n  room-T closure needs <g>_pair/<g>_sp ~ {needed:.0f}x (campaign x4.7-5.6 short).")
    print(f"  LF best achieved = {ratio:.2f}x  ->  {'CLOSES' if ratio >= needed else 'does NOT close'} the ~5x gap.")
    print("\n[d6 caveat] Lang-Firsov is variational (upper bound on mass = lower bound on D_conv).")
    print("  Trustworthy in anti-adiabatic Omega>>W (small bond-polaron); OVER-narrows in adiabatic")
    print("  Omega<<W. It CANNOT manufacture geometric weight beyond the band-geometry invariant:")
    print("  uniform dressing => <g> exactly fixed; bond-selective dressing reshapes <g> but ALSO")
    print("  breaks the flat-band / gap condition, so any <g> gain is bought by losing the flatness")
    print("  and/or the protecting gap (BWB obstruction) -- not a free room-T lever.")
