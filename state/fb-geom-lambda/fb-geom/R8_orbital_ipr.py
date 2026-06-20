"""
FB-GEOM-LAMBDA round-8 — does CLS orbital/sublattice participation set Q_geom?

r7 g5 PASS: ALL THREE topological determinants of Q_geom FALSIFIED (band-touching,
Berry/Wannier-Chern, Fubini-Study). KEY FACT: Q_geom clusters 0.493..0.520 (std 0.0097)
across topologically-distinct lattices (Chern 0..3); N=3 bands sit ~0.50, NOT at the Welch
floor 1/3. The SURVIVING hypothesis: Q_geom is set by the *orbital/sublattice support* of
the compact localized state (CLS) -- the number of orbitals the flat-band eigenvector u(k)
has weight on -- NOT by topology.

  hypothesis:   Q_geom  ~=  1 / N_orb_eff      where  N_orb_eff = effective # orbitals
                                                the flat band lives on.

dice flat band lives on 2 of 3 sublattices (hub=0)  -> N_orb_eff = 2 -> Q ~ 1/2  (r7: 0.520)
Lieb flat band lives on 2 edge sublattices          -> N_orb_eff = 2 -> Q ~ 1/2  (r7: 0.500)
checkerboard 2-band, both orbitals                  -> N_orb_eff = 2 -> Q ~ 1/2  (r7: 0.500)
kagome flat band spreads over all 3 sublattices*    -> N_orb_eff = 3 -> Q ~ 1/3  ??? (r7: 0.493 -- NO!)
                                                      (* r7 kagome Q~0.493 ~ 1/2 not 1/3 -> tension)

DEFINITION of orbital support (gauge-fixed, k-resolved IPR over orbitals):
  At each k, |u_m(k)|^2 is a probability over orbitals m (sum_m |u_m|^2 = 1, eigvec normalised).
  Per-k inverse participation ratio (IPR) and its participation (effective orbital count):
      IPR(k)      = sum_m |u_m(k)|^4
      N_orb(k)    = 1 / IPR(k)            (the standard "participation number")
  BZ-mean predictor:
      <N_orb>     = < 1/IPR(k) >_BZ       (mean effective orbital count)
      pred_Q_recip = < IPR(k) >_BZ        (mean IPR; the 1/N_orb-consistent predictor of Q_geom)
  Two readouts of the law are tested:
      (A) correlation:  Q_geom  vs  <IPR>_BZ  across a TUNED family (clean = |r|>=0.9)
      (B) quantization: Q_geom  ==  1/round(<N_orb>)  with residual < 0.02  (Welch-tight pin)

TUNABLE FAMILY (continuously varies orbital participation at FIXED N_band):
  (1) dice-phi   : 3-band chiral dice, rim-B rotated by phi in [0, pi/2].  At phi=0 both rims
                   share structure factor -> flat eigvec (1,0,-1)/sqrt2 sits on 2 orbitals, BUT
                   k-INDEPENDENT (Q=1, trivial). As phi grows the rims decouple, the eigvec
                   becomes k-dependent and acquires hub weight only if the bipartite null is
                   broken -- a clean knob on (k-dependence x orbital spread).
  (2) stub-w     : 1D stub/comb lattice, backbone-stub coupling t_s and on-site detuning eps on
                   the stub.  The flat band is a CLS on {backbone, stub}; eps continuously shifts
                   the flat-band orbital weight between the two orbitals (0 -> backbone-only,
                   inf -> stub-only), tuning N_orb_eff continuously in (1, 2].
  (3) lieb-w     : 3-band Lieb with anisotropic edge couplings (tx != ty); the flat-band weight
                   redistributes between the two edge orbitals, tuning their *relative* support
                   (N_orb_eff in (1,2]) at fixed corner=0.
  (4) sawtooth-w : 1D sawtooth (delta) chain with tunable apex/base coupling ratio r; the CLS
                   spreads over a tunable number of sites -> continuous N_orb_eff.

mini python3 + numpy only. Captured stdout is the evidence (c2).
"""
import numpy as np
import json, os

# ----------------------------------------------------------------------------- core observables
def qgeom(U_flat):
    """U_flat: (M, n). Q_geom = <|<u(k)|u(k')>|^2>_{k,k'} (the r7 Welch / FS overlap measure)."""
    ov2 = np.abs(U_flat.conj() @ U_flat.T)**2
    return float(ov2.mean())

def orbital_ipr(Ug):
    """Ug: (..., n) flat-band eigvecs over the BZ grid (each |u|=1).
    Per-k orbital IPR = sum_m |u_m|^4, participation N_orb = 1/IPR.
    Returns (mean_IPR over BZ, mean N_orb over BZ, mean N_orb via harmonic <1/IPR>).
    NOTE: |u_m|^2 is gauge-INVARIANT (a U(1) phase on u cancels), so the orbital IPR
    is a fully gauge-fixed observable -- no Wannier/Berry gauge ambiguity."""
    p = np.abs(Ug)**2                          # (..., n) probability over orbitals, sums to 1
    ipr = (p**2).sum(axis=-1)                   # (...,) per-k IPR
    Norb = 1.0/ipr                              # (...,) per-k participation number
    return float(ipr.mean()), float(Norb.mean()), p

def flat_band_index(E):
    w = E.max(axis=tuple(range(E.ndim-1))) - E.min(axis=tuple(range(E.ndim-1)))
    return int(np.argmin(w)), float(w.min())

# ----------------------------------------------------------------------------- tunable lattices
def dice_phi(nk, phi, t=1.0):
    """3-band chiral dice: rim-B bonds = rim-A bonds rotated by phi. phi=pi/2 = r7 'dice/T3*'."""
    ks = 2*np.pi*np.arange(nk)/nk
    a = [np.array([1.0, 0.0]),
         np.array([-0.5,  np.sqrt(3)/2]),
         np.array([-0.5, -np.sqrt(3)/2])]
    R = np.array([[np.cos(phi), -np.sin(phi)], [np.sin(phi), np.cos(phi)]])
    c = [R @ v for v in a]
    E = np.zeros((nk, nk, 3)); U = np.zeros((nk, nk, 3, 3), complex)
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            k = np.array([kx, ky])
            fA = -t*sum(np.exp(1j*(k@v)) for v in a)
            fB = -t*sum(np.exp(1j*(k@v)) for v in c)
            H = np.array([[0, fA, 0],
                          [np.conj(fA), 0, fB],
                          [0, np.conj(fB), 0]], complex)
            w, v = np.linalg.eigh(H); E[i, j] = w; U[i, j] = v
    return E, U, 3

def stub_chain(nk, eps, ts=1.0, t=1.0):
    """1D stub/comb: backbone site b (with NN hop t along chain) + dangling stub site s
    (on-site energy eps, coupled to backbone by ts). 2-orbital cell.
        H(k) = [[ -2t cos k ,  ts        ],
                [  ts        ,  eps       ]]
    A genuine FLAT band exists ONLY for the destructive-interference CLS. The pure stub-comb
    has a flat band at E=eps_stub when the backbone dispersion is decoupled; to get an EXACT
    flat band that lives on a TUNABLE 2-orbital mix we use the bipartite-stub form below
    (stub_flat) instead. This raw form is kept for reference / sanity only."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, 2)); U = np.zeros((nk, 2, 2), complex)
    for i, k in enumerate(ks):
        H = np.array([[-2*t*np.cos(k), ts], [ts, eps]], complex)
        w, v = np.linalg.eigh(H); E[i] = w; U[i] = v
    return E, U, 2

def stub_flat(nk, alpha, t=1.0):
    """1D 3-orbital flat-band 'cross-stub' chain with a TUNABLE orbital-weight knob alpha.
    Cell = {A (backbone), B (backbone), S (stub)}. The stub S couples to A with t and to B
    with alpha*t. A bipartite CLS sits on {A,B} with amplitude ratio (alpha:-1) and ZERO on S
    (destructive interference at S), giving an EXACT flat band at E=0 whose orbital weight on
    {A,B} is tuned by alpha:
        |u> propto (1, 0_S, -alpha)/sqrt(1+alpha^2)   (orbital order A, S, B)
        weight_A = 1/(1+alpha^2), weight_B = alpha^2/(1+alpha^2)  -> N_orb_eff in (1,2].
    Backbone A-B hop t makes the two backbone orbitals k-dependent -> Q_geom<1, k-dependent.
        H(k) = [[ 0,         t e^{ik}+t,  t        ],
                [ t e^{-ik}+t, 0,         alpha*t  ],
                [ t,           alpha*t,   0        ]]   (orbitals A, B, S)
    The S row/col is the stub; the CLS (alpha, -? )... we instead read the flat band numerically
    and measure its orbital IPR -- robust to the exact CLS algebra."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, 3)); U = np.zeros((nk, 3, 3), complex)
    for i, k in enumerate(ks):
        hAB = t*(np.exp(1j*k) + 1.0)            # A-B backbone (two bonds per cell)
        H = np.array([[0.0,        hAB,        t       ],
                      [np.conj(hAB), 0.0,       alpha*t ],
                      [t,          alpha*t,    0.0      ]], complex)
        w, v = np.linalg.eigh(H); E[i] = w; U[i] = v
    return E, U, 3

def lieb_w(nk, tx, ty):
    """3-band anisotropic Lieb: corner(0), edge-x(1), edge-y(2) with edge couplings tx,ty.
        hx = -2 tx cos(kx/2),  hy = -2 ty cos(ky/2)
    Flat band at E=0 with eigvec propto (0_corner, hy, -hx)/norm -> lives on the two EDGE
    orbitals with k-dependent weight set by (tx,ty). tx=ty=t recovers r7 Lieb (Q~0.50)."""
    ks = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, nk, 3)); U = np.zeros((nk, nk, 3, 3), complex)
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            hx = -2*tx*np.cos(kx/2); hy = -2*ty*np.cos(ky/2)
            H = np.array([[0, hx, hy],
                          [hx, 0, 0],
                          [hy, 0, 0]], complex)
            w, v = np.linalg.eigh(H); E[i, j] = w; U[i, j] = v
    return E, U, 3

def sawtooth(nk, r, t=1.0):
    """1D sawtooth (Delta) chain: base sites B (NN hop t along the base) + apex sites A coupled
    to two neighbouring base sites with coupling r*t. The CLS occupies a base bond + apex with
    amplitudes set by r; at r=sqrt(2) it is the canonical sawtooth flat band. 2-orbital cell:
        H(k) = [[ -2t cos k ,  g(k)            ],
                [ g*(k)      ,  e_apex          ]]
      g(k) = r t (1 + e^{ik})  (apex couples to base sites in cell n and n+1)
      e_apex chosen so the lower band is flat (= -2t for the canonical line graph).
    The flat-band orbital weight between {base, apex} is tuned by r -> N_orb_eff in (1,2]."""
    ks = 2*np.pi*np.arange(nk)/nk
    e_apex = 0.0
    E = np.zeros((nk, 2)); U = np.zeros((nk, 2, 2), complex)
    for i, k in enumerate(ks):
        g = r*t*(1.0 + np.exp(1j*k))
        H = np.array([[-2*t*np.cos(k), g], [np.conj(g), e_apex]], complex)
        w, v = np.linalg.eigh(H); E[i] = w; U[i] = v
    return E, U, 2

# ----------------------------------------------------------------------------- analysis
def analyze(name, E, U, N_band, ndim):
    """ndim = BZ dimensionality (1 or 2). Returns Q_geom, orbital-IPR predictors, flatness."""
    b, w = flat_band_index(E)
    if ndim == 2:
        Ug = U[..., b]                          # (nk,nk,n)
        Uf = Ug.reshape(-1, N_band)
    else:
        Ug = U[:, :, b]                         # (nk,n)
        Uf = Ug
    q = qgeom(Uf)
    mean_ipr, mean_Norb, _ = orbital_ipr(Ug)
    return dict(name=name, N_band=N_band, ndim=ndim, width=w, Q_geom=q,
                mean_IPR=mean_ipr, mean_Norb=mean_Norb,
                pred_Q_from_IPR=mean_ipr, pred_Q_quant=1.0/round(mean_Norb))

def pearson(x, y):
    x = np.asarray(x, float); y = np.asarray(y, float)
    if np.std(x) < 1e-12 or np.std(y) < 1e-12:
        return float('nan')
    return float(np.corrcoef(x, y)[0, 1])

if __name__ == "__main__":
    print("="*100)
    print("FB-GEOM-LAMBDA R8 -- is Q_geom set by CLS orbital/sublattice support (orbital IPR)?")
    print("="*100)

    nk = 96
    rows = []

    # --- tuned family 1: dice-phi (rim rotation) ---------------------------------------------
    print("\n[family 1] dice-phi  (3-band chiral dice, rim-B rotated by phi)")
    for phi in np.linspace(0.05, np.pi/2, 7):
        rows.append(analyze(f"dice_phi={phi:.3f}", *dice_phi(nk, phi), ndim=2))

    # --- tuned family 2: stub_flat (alpha redistributes A/B backbone weight) -----------------
    print("[family 2] stub_flat (3-orbital cross-stub chain, alpha tunes A:B backbone weight)")
    for alpha in [0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0]:
        rows.append(analyze(f"stub_a={alpha:.2f}", *stub_flat(nk, alpha), ndim=1))

    # --- tuned family 3: lieb-w (tx/ty redistributes edge-orbital weight) --------------------
    print("[family 3] lieb_w   (3-band Lieb, anisotropic edge couplings tx,ty)")
    for ty in [0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0]:
        rows.append(analyze(f"lieb_ty={ty:.2f}", *lieb_w(nk, 1.0, ty), ndim=2))

    # --- tuned family 4: sawtooth (r redistributes base/apex weight) -------------------------
    print("[family 4] sawtooth (1D Delta chain, r tunes base:apex weight)")
    for r in [0.5, 0.8, 1.0, np.sqrt(2), 1.7, 2.0, 3.0]:
        rows.append(analyze(f"saw_r={r:.2f}", *sawtooth(nk, r), ndim=1))

    # --------------------------------------------------------------------------- flatness gate
    print("\n" + "-"*100)
    hdr = f"{'lattice':>18} {'N':>2} {'dim':>3} {'width':>10} {'Q_geom':>8} {'<IPR>':>8} {'<N_orb>':>8} {'1/rnd(No)':>10} {'flat?':>6}"
    print(hdr); print("-"*len(hdr))
    for r in rows:
        flat = r['width'] < 1e-6
        print(f"{r['name']:>18} {r['N_band']:>2} {r['ndim']:>3} {r['width']:10.2e} "
              f"{r['Q_geom']:8.4f} {r['mean_IPR']:8.4f} {r['mean_Norb']:8.4f} "
              f"{r['pred_Q_quant']:10.4f} {str(flat):>6}")

    # keep ONLY genuinely-flat bands for the law test (a dispersive 'flat-band index' is meaningless)
    flat = [r for r in rows if r['width'] < 1e-6]
    disp = [r for r in rows if r['width'] >= 1e-6]
    print(f"\ngenuinely-flat (width<1e-6): {len(flat)} / {len(rows)}   "
          f"(dropped {len(disp)} non-flat: {[r['name'] for r in disp]})")

    # --------------------------------------------------------------- (A) correlation Q vs <IPR>
    qs   = np.array([r['Q_geom'] for r in flat])
    iprs = np.array([r['mean_IPR'] for r in flat])
    norb = np.array([r['mean_Norb'] for r in flat])
    rA = pearson(iprs, qs)
    print("\n" + "="*100)
    print("(A) CORRELATION  Q_geom  vs  <IPR>_BZ  across the tuned flat family")
    print(f"     N points = {len(flat)},  Q_geom range [{qs.min():.4f}, {qs.max():.4f}] (std {qs.std():.4f})")
    print(f"     <IPR>    range [{iprs.min():.4f}, {iprs.max():.4f}]")
    print(f"     Pearson r( <IPR>, Q_geom )       = {rA:.4f}")

    # per-family correlation too (each family is an independent tuned axis)
    fams = {"dice_phi": "dice_phi", "stub": "stub_a", "lieb": "lieb_ty", "saw": "saw_r"}
    print("\n     per-family Pearson r( <IPR>, Q_geom ):")
    perfam = {}
    for fam, pref in fams.items():
        sub = [r for r in flat if r['name'].startswith(pref)]
        if len(sub) >= 3:
            rf = pearson([s['mean_IPR'] for s in sub], [s['Q_geom'] for s in sub])
            perfam[fam] = dict(n=len(sub), r=rf,
                               Q_range=[min(s['Q_geom'] for s in sub), max(s['Q_geom'] for s in sub)])
            print(f"        {fam:>10}: n={len(sub)}  r={rf:+.4f}  "
                  f"Q in [{perfam[fam]['Q_range'][0]:.4f},{perfam[fam]['Q_range'][1]:.4f}]")

    # ------------------------------------------------------- (B) quantization Q == 1/round(N_orb)
    preds = np.array([r['pred_Q_quant'] for r in flat])
    resid = np.abs(qs - preds)
    print("\n" + "="*100)
    print("(B) QUANTIZATION  Q_geom  ?=  1/round(<N_orb>)   (Welch-tight orbital pin)")
    print(f"     max |Q - 1/round(N_orb)| residual = {resid.max():.4f}")
    print(f"     mean residual                     = {resid.mean():.4f}")
    worst = flat[int(np.argmax(resid))]
    print(f"     worst: {worst['name']}  Q={worst['Q_geom']:.4f}  pred={worst['pred_Q_quant']:.4f}  "
          f"<N_orb>={worst['mean_Norb']:.4f}")

    # ----------------------------------------------------------- (B') continuous 1/<N_orb> match
    pred_cont = 1.0/norb
    resid_cont = np.abs(qs - pred_cont)
    rB = pearson(pred_cont, qs)
    print(f"\n(B') CONTINUOUS  Q_geom  vs  1/<N_orb>_BZ   (continuous, non-quantized)")
    print(f"     Pearson r( 1/<N_orb>, Q_geom )    = {rB:.4f}")
    print(f"     max |Q - 1/<N_orb>| residual      = {resid_cont.max():.4f}   mean {resid_cont.mean():.4f}")

    # ------------------------------------------------------------------------------- honest gate
    cleanA = abs(rA) >= 0.9 and qs.std() >= 0.02
    quantB = resid.max() < 0.02
    print("\n" + "="*100)
    print("HONEST VERDICT GATE (c2):")
    print(f"   (A) clean predictor  |r(<IPR>,Q)|>=0.9 AND Q std>=0.02 : {cleanA}  (r={rA:.4f}, std={qs.std():.4f})")
    print(f"   (B) quantized pin    max|Q-1/round(N_orb)|<0.02        : {quantB}  (maxres={resid.max():.4f})")
    g5 = cleanA or quantB
    if cleanA:
        verdict = ("CLEAN PREDICTOR -- Q_geom is set by CLS orbital support: "
                   f"r(<IPR>,Q_geom)={rA:.4f} across the tuned flat-band family")
    elif quantB:
        verdict = ("QUANTIZED PIN -- Q_geom = 1/(CLS orbital support), Welch-tight, "
                   f"max residual {resid.max():.4f} < 0.02, topology-independent")
    else:
        verdict = ("HONEST NEGATIVE (d6) -- CLS orbital IPR does NOT cleanly determine Q_geom: "
                   f"r(<IPR>,Q)={rA:.4f} (<0.9), quant residual {resid.max():.4f} (>=0.02)")
    print(f"\n   g5 PASS (clean OR quantized) : {g5}")
    print(f"   VERDICT: {verdict}")

    out_json = {
        "id": "FB-GEOM-LAMBDA", "round": 8, "date": "2026-06-19",
        "hypothesis": "Q_geom = 1/(CLS orbital/sublattice support), via mean orbital IPR of |u(k)|^2",
        "predictor_def": {
            "mean_IPR": "< sum_m |u_m(k)|^4 >_BZ  (gauge-invariant orbital IPR; predicts Q_geom directly)",
            "mean_Norb": "< 1 / sum_m |u_m(k)|^4 >_BZ  (effective orbital count)",
            "quant_pred": "1 / round(mean_Norb)",
        },
        "nk": nk,
        "n_flat": len(flat), "n_total": len(rows),
        "dropped_nonflat": [r['name'] for r in disp],
        "flat_rows": [{k: r[k] for k in ('name','N_band','ndim','width','Q_geom',
                                         'mean_IPR','mean_Norb','pred_Q_quant')} for r in flat],
        "A_correlation": {
            "pearson_r_IPR_vs_Q": rA, "Q_std": float(qs.std()),
            "Q_range": [float(qs.min()), float(qs.max())],
            "IPR_range": [float(iprs.min()), float(iprs.max())],
            "per_family": perfam,
            "clean_predictor": bool(cleanA),
        },
        "B_quantization": {
            "max_residual_quant": float(resid.max()), "mean_residual_quant": float(resid.mean()),
            "quantized_pin": bool(quantB),
            "worst": {"name": worst['name'], "Q_geom": worst['Q_geom'],
                      "pred": worst['pred_Q_quant'], "mean_Norb": worst['mean_Norb']},
        },
        "Bp_continuous": {
            "pearson_r_recipNorb_vs_Q": rB,
            "max_residual_cont": float(resid_cont.max()), "mean_residual_cont": float(resid_cont.mean()),
        },
        "g5_pass": bool(g5),
        "verdict": verdict,
    }
    out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "R8_VERDICT.json")
    with open(out, "w") as f:
        json.dump(out_json, f, indent=2)
    print(f"\nwrote {out}")
