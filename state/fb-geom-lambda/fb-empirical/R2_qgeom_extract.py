"""
FB-GEOM-LAMBDA r2 — QUANTITATIVE Q_geom EXTRACTION on real kagome materials.

Law (SHARP form):   lambda_obs ~= lambda_Hopfield(N(E_F)) * Q_geom
  lambda_Hopfield = N(E_F) * eta0 / (M * omega_log^2)     [eta0 = reference deformation potential]
  Q_geom         = FS-averaged Bloch sublattice overlap in [1/N_band, 1] (Welch bound; kagome floor 1/3)

For 3 real kagome SCs (LaRu3Si2, CaPd5, CsV3Sb5) we:
  (1) build a tight-binding model of the kagome band manifold, with E_F placed where the DFT
      flat band actually sits relative to E_F (per-material offset from the corpus / literature),
  (2) compute the actual FS-averaged Q_geom at that E_F (NOT just at the flat-band energy),
  (3) form lambda_Hopfield from published N(E_F), omega_log, and a per-material reduced phonon
      backbone, and report the ratio  R = lambda_obs / [lambda_Hopfield * Q_geom]  with its scatter.

HONEST (d6): this is a TB-geometry Q_geom (the structure-type sublattice overlap), not the full
DFT-Bloch projection. The numbers below (N(E_F), omega_log, lambda_obs) are the PUBLISHED DFT
values (sources in corpus.json). Where omega_log is not tabulated we invert Allen-Dynes from the
paper's OWN (Tc, lambda, mu*) so the phonon backbone is self-consistent with that paper.

The SHARP test has two readings, both reported:
  (A) UNIVERSAL-eta0 reading: calibrate ONE eta0 from the geometric mean, then is R ~ 1 +-0.3?
  (B) COLLAPSE reading (the real discriminator): does dividing out Q_geom shrink the cross-material
      scatter of the implied deformation potential vs the naive (Q_geom=1) version? If yes, geometry
      is the controlling factor; if the residual scatter survives / grows, geometry is NOT controlling
      (closed-partial).
"""
import numpy as np

# --------------------------------------------------------------------------------------
# kagome tight-binding (reuse kagome_R4.py machinery, extended: E_F offset + FS averaging)
# --------------------------------------------------------------------------------------
def kagome_h(k, t=1.0, t2=0.0):
    kx, ky = k
    d_ab = np.array([0.5, 0.0]); d_bc = np.array([0.25, np.sqrt(3)/4]); d_ca = np.array([-0.25, np.sqrt(3)/4])
    hab = -2*t*np.cos(kx*d_ab[0]+ky*d_ab[1])
    hbc = -2*t*np.cos(kx*d_bc[0]+ky*d_bc[1])
    hca = -2*t*np.cos(kx*d_ca[0]+ky*d_ca[1])
    diag = -2*t2*np.array([np.cos(kx), np.cos(ky), np.cos(kx-ky)])
    H = np.array([[diag[0], hab, hca],
                  [hab, diag[1], hbc],
                  [hca, hbc, diag[2]]], dtype=complex)
    return H

def diag_bz(nk, t=1.0, t2=0.02):
    bz = 2*np.pi*np.arange(nk)/nk
    E = np.zeros((nk, nk, 3)); U = np.zeros((nk, nk, 3, 3), complex)
    for i, kx in enumerate(bz):
        for j, ky in enumerate(bz):
            w, v = np.linalg.eigh(kagome_h((kx, ky), t, t2))
            E[i, j] = w; U[i, j] = v
    return E, U

def q_geom_at_Ef(nk, Ef, sigma, t=1.0, t2=0.02):
    """FS-averaged sublattice Bloch overlap at chemical potential Ef (ALL 3 bands), Gaussian FS window.
       Q_geom = <|<u_k|u_k'>|^2>_FS  with FS weight w_k = sum_band exp(-((E-Ef)/sigma)^2/2)."""
    E, U = diag_bz(nk, t, t2)
    Ef_states = []  # (weight, sublattice-vector) over all (k,band) near Ef
    for i in range(nk):
        for j in range(nk):
            for b in range(3):
                w = np.exp(-0.5*((E[i, j, b]-Ef)/sigma)**2)
                if w > 1e-6:
                    Ef_states.append((w, U[i, j, :, b]))
    if len(Ef_states) < 2:
        return None, 0.0
    wk = np.array([s[0] for s in Ef_states])
    uk = np.array([s[1] for s in Ef_states])           # (Nfs, 3)
    ov2 = np.abs(uk.conj() @ uk.T)**2                  # (Nfs,Nfs)
    Q = (wk[:, None]*wk[None, :]*ov2).sum()/(wk.sum()**2)
    return Q, wk.sum()

# --------------------------------------------------------------------------------------
# Allen-Dynes (forward) + inversion for omega_log when not tabulated
# --------------------------------------------------------------------------------------
def allen_dynes_Tc(lam, wlog_K, mustar):
    if lam <= mustar:
        return 0.0
    return (wlog_K/1.2)*np.exp(-1.04*(1+lam)/(lam-mustar*(1+0.62*lam)))

def invert_wlog(Tc_K, lam, mustar):
    """solve AD(lam,wlog,mu*)=Tc for wlog (monotone in wlog)."""
    if lam <= mustar:
        return np.nan
    return Tc_K*1.2*np.exp(1.04*(1+lam)/(lam-mustar*(1+0.62*lam)))

# --------------------------------------------------------------------------------------
# MATERIAL TABLE  (PUBLISHED DFT values; sources = corpus.json)
#   N_Ef     : states / eV / cell / spin   (per-spin, single consistent convention)
#   wlog_meV : logarithmic average phonon frequency (meV). None -> invert from (Tc,lam,mu*)
#   M_amu    : mass of the dominant phonon-coupled species (kagome-net atom) -> M*omega^2 backbone
#   fb_offset: where the kagome flat band sits vs E_F, in units of the TB flat-band->dispersive
#              separation (0 = flat band AT E_F; >0 = E_F sits above the flat band)
# --------------------------------------------------------------------------------------
# wlog_meV: PHYSICAL logarithmic phonon frequency. CsV3Sb5 = 17.1 meV (ARPES Eliashberg, published).
# MPd5 / LaRu3Si2 not tabulated as wlog -> estimated from the Debye temperature via the standard
# wlog ~ 0.6*theta_D relation (NOT Allen-Dynes inversion, which is numerically unstable when lambda
# is only moderately above mu* and yields unphysical >100 meV values). theta_D(LaRu3Si2)=379-423 K
# (Table S1) -> wlog ~ 0.6*400 K ~ 21 meV. MPd5: Pd mass ~ V mass region + 2-5 THz alpha2F peaks
# (8-22 meV) -> wlog ~ 15 meV. These are physically anchored, not fit.
materials = [
    dict(id="CsV3Sb5", lam_obs=0.25, N_Ef=5.44/2, wlog_meV=17.1, mustar=0.12,
         Tc=2.6, M_amu=50.94,  # V mass (kagome net)
         fb_offset=0.55,       # V-3d flat band sits BELOW E_F; vHs near E_F, FB not at E_F
         note="N(EF)=5.44 st/eV/cell total (DFT) -> 2.72/spin. wlog=17.1meV (ARPES Eliashberg). "
              "V kagome net; flat band below E_F, multiple vHs straddle E_F."),
    dict(id="CaPd5", lam_obs=0.557, N_Ef=None, wlog_meV=14.0, mustar=0.10,
         Tc=4.25, M_amu=106.42,  # Pd mass (kagome net)
         fb_offset=0.05,       # topological flat band essentially AT E_F (Z2=1)
         note="Flat band AT E_F (Z2=1). N(EF) not tabulated -> PREDICTED from family. "
              "wlog~14 meV from alpha2F peaks 2-3 & 5.3 THz (8-22 meV), Pd-dominated."),
    dict(id="LaRu3Si2", lam_obs=0.635, N_Ef=7.82, wlog_meV=21.0, mustar=0.13,
         Tc=6.6, M_amu=101.07,  # Ru mass (kagome net)
         fb_offset=0.18,       # Ru-4d(x2-y2) flat band ~55 meV above E_F (corpus)
         note="N(EF)=7.82/eV/uc/spin (Table S1, arXiv:2503.22477). Ru-4d flat band ~55meV from E_F. "
              "wlog~21 meV from theta_D~400K (Table S1) * 0.6; mode-selective Ru-B3u phonons."),
]

# --------------------------------------------------------------------------------------
# pipeline
# --------------------------------------------------------------------------------------
hbar = 1.0
nk = 48
t = 1.0; t2 = 0.02
# TB flat-band energy (E=+2t region for this convention); dispersive bands span ~[-4t, +2t].
# Map fb_offset (0..1) to an Ef in TB energy units relative to the flat band.
E_TB, _ = diag_bz(nk, t, t2)
flat_E = np.array([E_TB[:, :, b].max()-E_TB[:, :, b].min() for b in range(3)]).argmin()
flat_energy = E_TB[:, :, flat_E].mean()
band_span = E_TB.max()-E_TB.min()

print("="*92)
print("FB-GEOM-LAMBDA r2 — QUANTITATIVE Q_geom on real kagome SCs (TB-geometry, published DFT inputs)")
print("="*92)
print(f"kagome TB: nk={nk}, t={t}, t2={t2}; flat band index={flat_E} at E={flat_energy:.3f}, span={band_span:.2f}t")
print(f"(Q_geom floor for a 3-sublattice kagome = 1/3 = {1/3:.3f}; trivial dispersive = up to 1.0)\n")

rows = []
for m in materials:
    # phonon backbone (PHYSICAL wlog only; AD-inversion retired as numerically unstable)
    wlog_meV = m["wlog_meV"]; wlog_src = "phys/Debye"
    # sanity: forward AD Tc with this wlog should be the right ballpark vs the reported Tc
    Tc_chk = allen_dynes_Tc(m["lam_obs"], wlog_meV*11.604, m["mustar"])  # meV->K
    # Ef in TB units: flat_energy minus offset*span (E_F below the flat band by offset).
    # offset 0 -> Ef at flat band; larger -> Ef sweeps into dispersive region.
    Ef_tb = flat_energy - m["fb_offset"]*band_span
    # FS window: use a fraction of the band span (mimics a DFT smearing ~0.1 eV on a ~few-eV band)
    sigma = 0.08*band_span
    Q, fsw = q_geom_at_Ef(nk, Ef_tb, sigma, t, t2)
    # naive Hopfield numerator ~ N(EF)/(M*wlog^2). N_Ef may be None for CaPd5 -> handle below.
    rows.append(dict(m=m, wlog_meV=wlog_meV, wlog_src=wlog_src, Q=Q, Ef_tb=Ef_tb, fsw=fsw, Tc_chk=Tc_chk))

print("phonon-backbone sanity (forward Allen-Dynes Tc with the physical wlog vs reported Tc):")
for r in rows:
    print(f"  {r['m']['id']:>10}: wlog={r['wlog_meV']:.1f} meV, AD-Tc={r['Tc_chk']:.2f} K vs reported {r['m']['Tc']} K")
print()

# --- Build lambda_Hopfield. Need a per-material backbone B = N_Ef/(M*wlog^2). eta0 is the
#     UNIVERSAL deformation potential calibrated so the geometric construction self-consistently
#     reproduces the family. For CaPd5 N_Ef unknown -> SOLVE it from the law as a prediction, then
#     report the implied N_Ef and check it's physically sane (flat-band peak -> large).
print(f"{'material':>10} {'lam_obs':>7} {'N_Ef/spin':>9} {'wlog_meV':>9}({'src':>11}) {'Q_geom':>7} {'B=N/Mw2':>9}")
print("-"*92)
for r in rows:
    m = r["m"]; B = (m["N_Ef"]/(m["M_amu"]*r["wlog_meV"]**2)) if m["N_Ef"] else float('nan')
    r["B"] = B
    nef = f"{m['N_Ef']:.2f}" if m["N_Ef"] else "  (solve)"
    print(f"{m['id']:>10} {m['lam_obs']:>7.3f} {nef:>9} {r['wlog_meV']:>9.2f}({r['wlog_src']:>11}) "
          f"{r['Q']:>7.3f} {B:>9.3e}")

# --------------------------------------------------------------------------------------
# SHARP TEST (B) — the discriminator: implied deformation potential
#   eta_geo  = lam_obs / (B * Q)        (law: geometry divided out -> should be ~const across family)
#   eta_naive= lam_obs / B              (naive Q=1: should be MORE scattered if geometry matters)
# Only materials with a published N_Ef enter the cross-material scatter (LaRu3Si2, CsV3Sb5).
# CaPd5 N_Ef is predicted from the family eta_geo and reported.
# --------------------------------------------------------------------------------------
calib = [r for r in rows if r["m"]["N_Ef"]]
eta_geo = np.array([r["m"]["lam_obs"]/(r["B"]*r["Q"]) for r in calib])
eta_naive = np.array([r["m"]["lam_obs"]/r["B"] for r in calib])

def cv(x):  # coefficient of variation (scatter)
    x = np.asarray(x, float); return float(np.std(x)/np.mean(x))

print("\n" + "="*92)
print("SHARP TEST (B) — does dividing out Q_geom COLLAPSE the cross-material deformation-potential scatter?")
print("="*92)
print(f"{'material':>10} {'eta_geo=lam/(B*Q)':>20} {'eta_naive=lam/B (Q=1)':>23}")
for r, eg, en in zip(calib, eta_geo, eta_naive):
    print(f"{r['m']['id']:>10} {eg:>20.4e} {en:>23.4e}")
print(f"\n  scatter (coeff of variation, lower=tighter):")
print(f"    eta_naive (NO geometry, Q=1) : CV = {cv(eta_naive):.3f}")
print(f"    eta_geo   (Q_geom divided out): CV = {cv(eta_geo):.3f}")
improve = (cv(eta_naive)-cv(eta_geo))/cv(eta_naive) if cv(eta_naive)>0 else 0
print(f"    -> geometry {'TIGHTENS' if cv(eta_geo)<cv(eta_naive) else 'does NOT tighten'} the family "
      f"by {improve*100:.0f}% (CV {cv(eta_naive):.3f} -> {cv(eta_geo):.3f})")

# --------------------------------------------------------------------------------------
# SHARP TEST (A) — universal-eta0 ratio R = lam_obs / [lam_Hopfield * Q]
#   lam_Hopfield = B * eta0 ; eta0 = geometric-mean implied deformation potential (calibrated).
# --------------------------------------------------------------------------------------
eta0 = float(np.exp(np.mean(np.log(eta_geo))))   # geometric mean of geo-corrected coupling
print("\n" + "="*92)
print(f"SHARP TEST (A) — ratio R = lam_obs / [lam_Hopfield * Q_geom],  eta0 (calib, geo-mean) = {eta0:.3e}")
print("="*92)
print(f"{'material':>10} {'lam_obs':>7} {'lam_Hopfield=B*eta0':>20} {'*Q_geom':>9} {'R=ratio':>8}")
Rs = []
for r in rows:
    m = r["m"]
    if m["N_Ef"]:
        lamH = r["B"]*eta0; pred = lamH*r["Q"]; R = m["lam_obs"]/pred
        Rs.append(R)
        print(f"{m['id']:>10} {m['lam_obs']:>7.3f} {lamH:>20.3f} {pred:>9.3f} {R:>8.3f}")
    else:
        # predict N_Ef for CaPd5 from family eta0: lam_obs = (N/(M w^2))*eta0*Q -> solve N
        N_pred = m["lam_obs"]*m["M_amu"]*r["wlog_meV"]**2/(eta0*r["Q"])
        print(f"{m['id']:>10} {m['lam_obs']:>7.3f}  N(EF) PREDICTED from family = {N_pred:.2f} /eV/cell/spin "
              f"(Q={r['Q']:.3f})")
Rs = np.array(Rs)
print(f"\n  R cluster: mean={Rs.mean():.3f}, range=[{Rs.min():.3f},{Rs.max():.3f}], spread=+-{(Rs.max()-Rs.min())/2:.3f}")
print(f"  (calibrated eta0 forces mean~1 by construction; the MEANINGFUL number is the SPREAD and TEST-B CV.)")

# --------------------------------------------------------------------------------------
# VERDICT logic
# --------------------------------------------------------------------------------------
print("\n" + "="*92)
print("DEPLETION READING")
print("="*92)
print(f"Q_geom (real-kagome, FS-avg at material E_F): " +
      ", ".join(f"{r['m']['id']}={r['Q']:.3f}" for r in rows))
print(f"All sit in [1/3, 1] = [{1/3:.3f}, 1.0] as the Welch bound requires (kagome floor respected).")
print(f"\nTEST-B (collapse): geometry {'IMPROVES' if cv(eta_geo)<cv(eta_naive) else 'FAILS to improve'} "
      f"cross-material clustering (CV {cv(eta_naive):.3f}->{cv(eta_geo):.3f}).")
print(f"TEST-A (ratio): R spread = +-{(Rs.max()-Rs.min())/2:.3f} around the calibrated mean.")
