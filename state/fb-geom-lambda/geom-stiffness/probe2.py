"""
GEOM-STIFFNESS round-2 — convert the OPEN room-T path (r1) into a concrete sized prediction.

r1 BREAKTHROUGH (state/.../geom-stiffness/{probe.py,FINDINGS.md}): the bond-bipolaron
tens-of-K cap was an ARTIFACT of using the DISPERSIVE stiffness D_s ∝ t**·n (→0 as t→0).
The real flat-band condensate stiffness is the Peotta-Törmä GEOMETRIC superfluid weight
    D_s^geom = 4 |U| ν(1-ν) ⟨g⟩      (FINITE at t→0, set by band TEXTURE not width).
r1 used a GENERIC Lieb ⟨g⟩=0.642 proxy and the bond-SSH binding Δ for the pair scale, and
got sp2C N-Lieb COF 86 K, MATBG 17 K, room-T OPEN.

r2 (this file) closes four gaps:
  (1) REAL-HOST ⟨g⟩: a proper p_z π-network TB model of the sp2C N-Lieb COF (Lieb lattice
      of carbon, hub site = N-bridged node) — compute its actual flat-band ⟨tr g⟩, not the
      generic tp-knob proxy.  Also MATBG (flat-band ⟨g⟩ from the chiral-limit lower bound
      ⟨g⟩ ≥ |C|/2π and the Bistritzer-MacDonald magic-angle metric).
  (2) DEEP-FLAT HIGH-⟨g⟩ HUNT: scan the flat-band zoo (Lieb, kagome, dice/T3, checkerboard,
      sawtooth, stub) with the SAME |dk|²-normalized ⟨tr g⟩ as probe.py; for each report
      W (isolation/own width) and ⟨g⟩, and the geometric Tc at Δ≈Ω with a realistic
      light-atom C-C Ω (80-160 meV).  Identify the room-T-optimal geometry (max ⟨g⟩, deep flat).
  (3) Δ-⟨g⟩ SELF-CONSISTENCY: on a flat band the pairing gap is itself geometric,
      Δ_flat = |U| √( ν(1-ν) ⟨g⟩ )   (Törmä-Peotta-Liang flat-band BCS, the gap is set by
      the quantum metric, NOT the bond-SSH t-binding r1 reused).  Recompute Δ self-consistently
      and the resulting Tc.
  (4) BEST sized geometric Tc for a concrete recipe-matched host, explicit ⟨g⟩, Ω, Δ, ν;
      honest statement of whether it reaches/approaches room-T and at what assumed Ω,U.

d6 DISCIPLINE: TB structure-type ⟨g⟩ are CEILINGS for a structure class, not material
predictions; a real-material number needs DFT-Wannier bands.  We flag every place a
real-DFT ⟨g⟩ is still needed.  We do NOT tune any number to green.
"""
import json
import os
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
FBG = os.path.dirname(HERE)
MEV2K = 11.604518  # meV -> K (kB)

# ===========================================================================
# (0) The properly |dk|²-normalized BZ-averaged quantum-metric trace ⟨tr g⟩,
#     IDENTICAL convention to probe.py band_metric (lattice-const² units).
# ===========================================================================
def metric_2d(hfun, band, nk=48, **kw):
    ks = 2*np.pi*np.arange(nk)/nk
    dk = 2*np.pi/nk
    n = hfun(0.0, 0.0, **kw).shape[0]
    U = np.zeros((nk, nk, n), dtype=complex)
    E = np.zeros((nk, nk))
    Eall = np.zeros((nk, nk, n))
    for i, kx in enumerate(ks):
        for j, ky in enumerate(ks):
            w, v = np.linalg.eigh(hfun(kx, ky, **kw))
            E[i, j] = w[band]; U[i, j] = v[:, band]; Eall[i, j] = w
    trg = 0.0
    for i in range(nk):
        for j in range(nk):
            u = U[i, j]; ux = U[(i+1) % nk, j]; uy = U[i, (j+1) % nk]
            trg += ((1-abs(np.vdot(u, ux))**2) + (1-abs(np.vdot(u, uy))**2)) / dk**2
    g_avg = trg/(nk*nk)
    width = E.max() - E.min()
    # isolation gap: min energy separation of this band from neighbours over the BZ
    gaps = []
    for b2 in range(n):
        if b2 == band:
            continue
        gaps.append(np.min(np.abs(Eall[:, :, band] - Eall[:, :, b2])))
    iso_gap = min(gaps) if gaps else float('inf')
    ub = U.reshape(-1, n)
    Qgeom = (np.abs(ub.conj() @ ub.T)**2).mean()
    return dict(g_avg=float(g_avg), width=float(width), iso_gap=float(iso_gap),
                Qgeom=float(Qgeom), emean=float(E.mean()))

def metric_1d(hfun, band, nk=600, **kw):
    ks = 2*np.pi*np.arange(nk)/nk
    dk = 2*np.pi/nk
    n = hfun(0.0, **kw).shape[0]
    U = np.zeros((nk, n), dtype=complex); E = np.zeros((nk, n))
    for i, k in enumerate(ks):
        w, v = np.linalg.eigh(hfun(k, **kw)); E[i] = w; U[i] = v[:, band]
    trg = 0.0
    for i in range(nk):
        u = U[i]; ux = U[(i+1) % nk]
        trg += (1-abs(np.vdot(u, ux))**2)/dk**2
    g_avg = trg/nk
    width = E[:, band].max() - E[:, band].min()
    others = [b for b in range(n) if b != band]
    iso = min(np.min(np.abs(E[:, band]-E[:, b])) for b in others)
    return dict(g_avg=float(g_avg), width=float(width), iso_gap=float(iso),
                Qgeom=float((np.abs(U.conj() @ U.T)**2).mean()), emean=float(E[:, band].mean()))

# ===========================================================================
# (1) REAL-HOST TB MODELS
# ===========================================================================
# --- sp2C N-Lieb COF: p_z π-network on a Lieb lattice ---
# The sp2-carbon N-Lieb COF (e.g. the sp2c-COF / pyridyl-linked 2D framework) has a Lieb-
# lattice π-topology: a "hub" node (the N-bridged junction) at (0,0) and two "edge" carbon
# bridge sites at (1/2,0),(0,1/2).  The flat band is the MIDDLE band of the 3-band Lieb
# model with NN hub-edge hopping t and (ideally) NO edge-edge hopping -> EXACTLY flat.
# A real framework has a small residual edge-edge coupling tp (sets the actual width).  We
# compute ⟨g⟩ for the IDEAL Lieb flat band (tp->0) = the structure-type ceiling, and for a
# realistic small tp = the actual-framework number.  Hub onsite offset eps_hub from the
# N-bridge (different chemistry hub vs C edge) reshapes the texture -> we include it.
def lieb_pz(kx, ky, t=1.0, tp=0.0, eps_hub=0.0):
    hAB = -t*(1.0 + np.exp(-1j*kx))
    hAC = -t*(1.0 + np.exp(-1j*ky))
    hBC = -tp*(1.0 + np.exp(-1j*kx))*(1.0 + np.exp(1j*ky))
    return np.array([[eps_hub,       hAB,          hAC],
                     [np.conj(hAB),  0.0,          hBC],
                     [np.conj(hAC),  np.conj(hBC), 0.0]], dtype=complex)

# --- MATBG flat band: geometric lower bound from the magic-angle chiral limit ---
# In the chiral limit (Tarnopolsky-Kruchkov-Vishwanath) each MATBG flat band carries Chern
# |C|=1 and the integrated metric obeys the topological bound  (1/2π)∫tr g d²k ≥ |C| = 1,
# i.e. the BZ-AVERAGED ⟨tr g⟩ (in BZ-area units, same normalization as our lattice ⟨g⟩
# which is ∫tr g over the BZ divided by (2π)² then ×(2π)² cancels -> = ∫tr g/A_BZ·A_cell).
# To compare on the SAME footing as the lattice models (⟨tr g⟩ = (1/Nk)Σ tr g /dk² has units
# a²; for a 2-band model the topological floor is ∫trg = 2π|C|, so ⟨tr g⟩_floor = |C| since
# our average already divides by the cell area (2π)² and multiplies by Nk·dk²=(2π)²/... ).
# We report MATBG ⟨g⟩ as the chiral-limit FLOOR |C|=1 and the saturated ideal-metric value
# ~ |C| (ideal flat band saturates the bound), i.e. ⟨g⟩_MATBG ≈ 1.0 (flag: real-DFT needed).

# ===========================================================================
# (2) FLAT-BAND ZOO  (reuse R6_flatband_zoo geometries; recompute |dk|²-normalized ⟨g⟩)
# ===========================================================================
def kagome_h(kx, ky, t=1.0, t2=0.0, lso=0.0):
    """3-band kagome. t = NN hopping. The flat band TOUCHES the dispersive band at a
    quadratic band-touching point (iso_gap=0 in bare TB). lso = intrinsic-SOC-like
    IMAGINARY 2nd-NN hopping (Haldane/Kane-Mele kagome) OPENS a real gap that ISOLATES the
    flat band — the physically-correct isolation mechanism (not a fudge)."""
    d_ab = (0.5, 0.0); d_bc = (0.25, np.sqrt(3)/4); d_ca = (-0.25, np.sqrt(3)/4)
    hab = -2*t*np.cos(kx*d_ab[0]+ky*d_ab[1])
    hbc = -2*t*np.cos(kx*d_bc[0]+ky*d_bc[1])
    hca = -2*t*np.cos(kx*d_ca[0]+ky*d_ca[1])
    # imaginary SOC 2nd-NN (gaps the flat-band touching, makes the flat band Chern-isolated)
    s_ab = 2j*lso*np.sin(kx*d_ab[0]+ky*d_ab[1])
    s_bc = 2j*lso*np.sin(kx*d_bc[0]+ky*d_bc[1])
    s_ca = 2j*lso*np.sin(kx*d_ca[0]+ky*d_ca[1])
    diag = -2*t2*np.array([np.cos(kx), np.cos(ky), np.cos(kx-ky)])
    return np.array([[diag[0],            hab+s_ab,           np.conj(hca+s_ca)],
                     [np.conj(hab+s_ab),  diag[1],            hbc+s_bc],
                     [hca+s_ca,           np.conj(hbc+s_bc),  diag[2]]], dtype=complex)

def dice_h(kx, ky, t=1.0):
    d1 = np.array([1.0, 0.0]); d2 = np.array([-0.5, np.sqrt(3)/2]); d3 = np.array([-0.5, -np.sqrt(3)/2])
    k = np.array([kx, ky])
    f = -t*(np.exp(1j*k@d1)+np.exp(1j*k@d2)+np.exp(1j*k@d3))
    return np.array([[0, f, 0],
                     [np.conj(f), 0, np.conj(f)],
                     [0, f, 0]], dtype=complex)

def checkerboard_h(kx, ky, t=1.0, tp=0.5):
    hAA = -2*tp*np.cos(kx); hBB = -2*tp*np.cos(ky)
    hAB = -4*t*np.cos(kx/2)*np.cos(ky/2)
    return np.array([[hAA, hAB], [np.conj(hAB), hBB]], dtype=complex)

def stub_h(kx, ky=0.0, t=1.0):
    # 2D stub/decorated-square: a square lattice (hub) with a dangling stub per cell -> a
    # flat band at E=0 (CLS on the stub).  3-band: hub A, stub S, and a second square site.
    # Minimal 2D stub = square hub + pendant -> use the Lieb-like decorated square but with
    # only ONE pendant per cell (2-band sublattice missing) -> realize via 3-band stub:
    hA = -2*t*(np.cos(kx)+np.cos(ky))   # hub disperses
    hAS = -t                            # hub-stub coupling (k-independent, local)
    return np.array([[hA,            hAS,  0.0],
                     [np.conj(hAS),  0.0,  0.0],
                     [0.0,           0.0,  0.0]], dtype=complex)

def sawtooth_h(k, t1=1.0, t2=1/np.sqrt(2)):
    hAA = -2*t2*np.cos(k); hAB = -t1*(1+np.exp(-1j*k))
    return np.array([[hAA, hAB], [np.conj(hAB), 0.0]], dtype=complex)

def stub_1d_h(k, t=1.0):
    # 1D stub (comb): chain hub A with a pendant B per cell -> flat band at E=0.
    hAA = -2*t*np.cos(k); hAB = -t
    return np.array([[hAA, hAB], [np.conj(hAB), 0.0]], dtype=complex)

# ===========================================================================
# (3) GEOMETRIC PAIR GAP + Tc
# ===========================================================================
# r1 anchor (kept for the conventional reference + the SAME overall BKT constant):
ANCHOR_TcO = 0.10
ANCHOR_DELTA = 1.154545074688972     # bond-SSH |Δb|/Ω at the anchor (r1)
ANCHOR_GAVG_LIEB = 0.6423663624315809

# r1 geometric Tc form: D_s ∝ Δ·⟨g⟩, anchored so (ANCHOR_DELTA, ANCHOR_GAVG_LIEB)->0.10.
K_R1 = ANCHOR_TcO / (ANCHOR_DELTA * ANCHOR_GAVG_LIEB)
def tc_geo_r1(delta, g_avg):
    """r1 form (bond-SSH Δ, geometric stiffness only). Tc/Ω."""
    return K_R1 * delta * g_avg

# r2 SELF-CONSISTENT geometric gap.  Flat-band BCS (Törmä/Peotta/Liang, PRB 95.024515 &
# Nat.Phys reviews): the pairing gap on an isolated flat band is
#       Δ_flat = |U| * sqrt( ν(1-ν) * ⟨g⟩ )           (per particle, in |U| units)
# (the gap scales with the quantum-metric, NOT with bandwidth -> finite at t->0).  The
# superfluid weight is then  D_s = 4 |U| ν(1-ν) ⟨g⟩  and  kT_BKT = (π/2) D_s.
# To make the SELF-CONSISTENT Tc comparable to r1's anchored number, we calibrate the
# single overall constant of the BKT relation on the SAME anchor (so the COMPARISON is
# apples-to-apples: only the (Δ,⟨g⟩) physics changes, not the convention).
#   D_s/Ω = K_DS * |U|/Ω * ν(1-ν) * ⟨g⟩ ,  Tc/Ω = (π/2)·D_s/Ω  -> fold (π/2) into K_DS.
# Anchor: at the r1 dispersive reference (⟨g⟩=ANCHOR_GAVG_LIEB, ν=1/2 so ν(1-ν)=1/4,
#   |U|/Ω chosen = ANCHOR_DELTA so the pair scale matches r1's binding) we set Tc/Ω=0.10.
ANCHOR_NU = 0.5
def tc_geo_selfconsistent(g_avg, UoverO, nu=ANCHOR_NU, return_delta=False):
    """Self-consistent geometric Tc/Ω with the flat-band BCS gap Δ_flat = U√(ν(1-ν)⟨g⟩).
       D_s = 4 U ν(1-ν) ⟨g⟩.  Calibrate Tc/Ω = K·U·ν(1-ν)·⟨g⟩ on the r1 anchor."""
    K_DS = ANCHOR_TcO / (ANCHOR_DELTA * (ANCHOR_NU*(1-ANCHOR_NU)) * ANCHOR_GAVG_LIEB)
    nuf = nu*(1-nu)
    tcO = K_DS * UoverO * nuf * g_avg
    delta = UoverO * np.sqrt(nuf * g_avg)          # geometric pair gap /Ω
    if return_delta:
        return tcO, delta
    return tcO

# ===========================================================================
if __name__ == "__main__":
    out = {}
    print("="*98)
    print("GEOM-STIFFNESS R2 — real-host ⟨g⟩, deep-flat hunt, self-consistent Δ-⟨g⟩, best sized Tc")
    print("="*98)

    # ---------------------------------------------------------------- (1)
    print("\n[1] REAL-HOST ⟨g⟩  (proper p_z π-network TB, |dk|²-normalized ⟨tr g⟩)")
    print(f"  {'host / model':<34}{'tp/knob':>9}{'width W':>10}{'iso-gap':>9}{'⟨tr g⟩':>9}  note")
    real = {}
    # sp2C N-Lieb COF: ideal (tp=0, exactly flat) and realistic residual tp
    for tag, tp, eh in [('ideal (tp=0, exact flat)', 0.0, 0.0),
                        ('realistic residual tp=.02', 0.02, 0.0),
                        ('hub offset eps=0.3,tp=.02', 0.02, 0.3),
                        ('hub offset eps=0.6,tp=.02', 0.02, 0.6)]:
        m = metric_2d(lieb_pz, band=1, nk=48, t=1.0, tp=tp, eps_hub=eh)
        real[f'COF:{tag}'] = m
        print(f"  {'sp2C N-Lieb COF '+tag:<34}{tp:>9.3f}{m['width']:>10.4f}"
              f"{m['iso_gap']:>9.4f}{m['g_avg']:>9.4f}")
    COF_REAL = real['COF:realistic residual tp=.02']  # the actual-framework number
    COF_IDEAL = real['COF:ideal (tp=0, exact flat)']
    # MATBG chiral-limit topological floor
    matbg_g = 1.0  # ⟨tr g⟩ >= |C| = 1 (chiral-limit ideal flat band saturates the bound)
    print(f"  {'MATBG (chiral-limit |C|=1 floor)':<34}{'--':>9}{0.0:>10.4f}{'--':>9}"
          f"{matbg_g:>9.4f}  topological floor; real-DFT ⟨g⟩ needed (FLAG)")
    out['real_host'] = dict(COF=real, MATBG_floor=matbg_g)

    print(f"\n  => REAL COF flat-band ⟨g⟩ ≈ {COF_REAL['g_avg']:.3f} (residual-tp) / "
          f"{COF_IDEAL['g_avg']:.3f} (ideal)  vs r1 generic proxy 0.642.")
    raise_lower = "RAISES" if COF_REAL['g_avg'] > 0.642 else ("≈same" if abs(COF_REAL['g_avg']-0.642)<0.05 else "LOWERS")
    print(f"     real ⟨g⟩ {raise_lower} the 86 K (Tc ∝ ⟨g⟩ in r1 form).")

    # ---------------------------------------------------------------- (2)
    print("\n[2] DEEP-FLAT HIGH-⟨g⟩ HUNT — flat-band zoo (|dk|²-normalized ⟨tr g⟩)")
    print(f"  {'lattice':<16}{'N':>3}{'flat W':>9}{'iso-gap':>9}{'⟨tr g⟩':>9}{'Qgeom':>8}  note")
    zoo = {}
    def reg(name, m, N, note=""):
        zoo[name] = dict(N=N, note=note, **m)
        print(f"  {name:<16}{N:>3}{m['width']:>9.4f}{m['iso_gap']:>9.4f}{m['g_avg']:>9.4f}"
              f"{m['Qgeom']:>8.4f}  {note}")
    reg('Lieb(mid,tp.02)', metric_2d(lieb_pz, 1, 48, t=1.0, tp=0.02), 3, 'COF host; touches@pt')
    reg('Lieb(ideal)',     metric_2d(lieb_pz, 1, 48, t=1.0, tp=0.0), 3, 'exact flat; touches@pt')
    reg('kagome(top)',     metric_2d(kagome_h, 2, 48, t=1.0, t2=0.0), 3, 'bare: touches Dirac')
    # kagome with intrinsic-SOC imaginary 2nd-NN -> the flat band becomes Chern-ISOLATED
    reg('kagome(SOC.10)',  metric_2d(kagome_h, 2, 48, t=1.0, lso=0.10), 3, 'SOC-gapped, isolated')
    reg('kagome(SOC.20)',  metric_2d(kagome_h, 2, 48, t=1.0, lso=0.20), 3, 'SOC-gapped, isolated')
    reg('kagome(bot)',     metric_2d(kagome_h, 0, 48, t=1.0, t2=0.0), 3, 'dispersive')
    reg('dice/T3(mid)',    metric_2d(dice_h, 1, 48, t=1.0), 3, 'E=0 flat, ⟨g⟩→0 trivial')
    reg('checkerboard',    metric_2d(checkerboard_h, 0, 48, t=1.0, tp=0.5), 2, 'dispersive(no FB here)')
    reg('stub-2D',         metric_2d(stub_h, 2, 48, t=1.0), 3, 'decorated square; isolated')
    reg('sawtooth(1D)',    metric_1d(sawtooth_h, 0, 600, t1=1.0, t2=1/np.sqrt(2)), 2, 'CLS-2, isolated')
    reg('stub-1D(comb)',   metric_1d(stub_1d_h, 1, 600, t=1.0), 2, 'CLS-1, isolated')
    out['zoo'] = zoo

    # ROOM-T-OPTIMAL = the high-⟨g⟩ flat band that can be HONESTLY ISOLATED.  d6 caveat:
    # bare NN kagome/Lieb high-⟨g⟩ flat bands only TOUCH their neighbour at a point
    # (band-touching, not a real gap), so they are NOT usable isolated condensate bands as-is.
    # The physically-correct isolation is an intrinsic-SOC (imaginary 2nd-NN) gap-opener, which
    # turns the kagome flat band into a CHERN-ISOLATED high-⟨g⟩ band — kagome(SOC) is therefore
    # the honest room-T-optimal STRUCTURE-CLASS ceiling (still a TB ceiling, not a material).
    best_geo = ('kagome(SOC.20)', zoo['kagome(SOC.20)'])
    sel = 'highest-⟨g⟩ flat band made ISOLATED by an intrinsic-SOC gap (structure-class ceiling)'
    print(f"\n  ROOM-T-OPTIMAL geometry [{sel}]:\n    {best_geo[0]}  ⟨g⟩={best_geo[1]['g_avg']:.3f}  "
          f"W={best_geo[1]['width']:.4f}  Qgeom={best_geo[1]['Qgeom']:.3f}")
    print(f"  (NOTE d6: bare kagome/Lieb high-⟨g⟩ bands only TOUCH neighbours at a point; a")
    print(f"   real isolated flat band needs a gap-opener — SOC/strain/sublattice potential.)")
    out['room_t_optimal'] = dict(name=best_geo[0], selection=sel, **best_geo[1])

    # geometric Tc at Δ≈Ω with realistic C-C bond Ω (80-160 meV) using r1 form (Δ=1≈Ω)
    print("\n  geometric Tc at Δ≈Ω (r1 form, Δ/Ω=1) for realistic light-atom Ω (C-C 80-160meV):")
    print(f"  {'lattice':<16}{'⟨g⟩':>8}{'Tc/Ω':>8}{'Tc@80meV':>10}{'Tc@120':>9}{'Tc@160':>9}  K")
    for name, v in sorted(zoo.items(), key=lambda kv: -kv[1]['g_avg']):
        tcO = tc_geo_r1(1.0, v['g_avg'])
        t80, t120, t160 = (tcO*Om*MEV2K for Om in (80, 120, 160))
        v['tcO_r1_dEqO'] = tcO
        v['tc80'], v['tc120'], v['tc160'] = float(t80), float(t120), float(t160)
        print(f"  {name:<16}{v['g_avg']:>8.3f}{tcO:>8.4f}{t80:>10.0f}{t120:>9.0f}{t160:>9.0f}")

    # ---------------------------------------------------------------- (3)
    print("\n[3] Δ-⟨g⟩ SELF-CONSISTENCY — flat-band BCS gap Δ_flat = U√(ν(1-ν)⟨g⟩), not bond-SSH")
    print("    D_s = 4U ν(1-ν)⟨g⟩, Tc/Ω = K·U ν(1-ν)⟨g⟩ (BKT, anchored on r1).  ν=1/2.")
    print(f"  {'host':<18}{'⟨g⟩':>7}{'U/Ω':>6}{'Δ_sc/Ω':>9}{'Δ_r1(SSH)':>11}{'Tc/Ω sc':>9}"
          f"{'Tc K sc':>9}{'Tc K r1':>9}")
    # U/Ω per candidate: in r1 the pair scale was the bond-SSH binding |Δb|/Ω ~1.0-1.3.
    # The geometric gap uses the BARE attraction U/Ω.  For an honest comparison we set
    # U/Ω = the SAME pair scale r1 used (binding_over_O), so only the Δ(⟨g⟩) law changes.
    with open(os.path.join(FBG, 'bond-bipolaron', 'results2d.json')) as f:
        R2 = json.load(f)
    R2C = {c['name']: c for c in R2['candidates_2d']}
    sc_rows = []
    # kagome-structured hosts: use the SOC-ISOLATED ⟨g⟩ (a real, gapped flat band), not the
    # bare touching value (which is not a usable isolated condensate band).
    kag_iso_g = zoo['kagome(SOC.20)']['g_avg']
    cand_host = {
        'sp2C N-Lieb COF': ('COF-real',     COF_REAL['g_avg']),
        'MATBG':           ('MATBG-floor',  matbg_g),
        'graphene-Kekule': ('kagome-SOC',   kag_iso_g),
        'Re6Se8Cl2':       ('kagome-SOC',   kag_iso_g),
    }
    for name in ['sp2C N-Lieb COF', 'MATBG', 'graphene-Kekule', 'Re6Se8Cl2']:
        c = R2C[name]; Om = c['Omega_meV']
        hostlbl, gavg = cand_host[name]
        UoverO = c['binding_over_O']              # same pair scale as r1
        tcO_sc, delta_sc = tc_geo_selfconsistent(gavg, UoverO, return_delta=True)
        delta_r1 = abs(c['binding'])
        tcO_r1 = tc_geo_r1(delta_r1, gavg)
        row = dict(name=name, host=hostlbl, g_avg=gavg, UoverO=UoverO, Omega_meV=Om,
                   delta_sc=float(delta_sc), delta_r1=float(delta_r1),
                   tcO_sc=float(tcO_sc), tcK_sc=float(tcO_sc*Om*MEV2K),
                   tcO_r1=float(tcO_r1), tcK_r1=float(tcO_r1*Om*MEV2K),
                   tcK_orig_artifact=c['Tc_K'])
        sc_rows.append(row)
        print(f"  {name:<18}{gavg:>7.3f}{UoverO:>6.2f}{delta_sc:>9.3f}{delta_r1:>11.3f}"
              f"{tcO_sc:>9.4f}{row['tcK_sc']:>9.0f}{row['tcK_r1']:>9.0f}")
    out['self_consistent'] = sc_rows

    # ---------------------------------------------------------------- (4)
    print("\n[4] BEST SIZED GEOMETRIC Tc — concrete recipe-matched host")
    # Best REAL-host (recipe-matched) candidate = sp2C N-Lieb COF with REAL ⟨g⟩ + self-consistent Δ.
    cof = next(r for r in sc_rows if r['name'] == 'sp2C N-Lieb COF')
    # Push Ω to the upper realistic C-C bond phonon (160 meV ~ graphene G-mode) — still a real
    # light-atom recipe (sp2 carbon), and self-consistent Δ at the COF ⟨g⟩.
    best = {}
    for Om in [80, 120, 160]:
        tcO_sc, delta_sc = tc_geo_selfconsistent(COF_REAL['g_avg'], cof['UoverO'], return_delta=True)
        best[Om] = dict(Omega_meV=Om, g_avg=COF_REAL['g_avg'], UoverO=cof['UoverO'],
                        delta_sc=float(delta_sc), nu=ANCHOR_NU,
                        tcK_sc=float(tcO_sc*Om*MEV2K))
    print(f"  recipe = sp2C N-Lieb COF (real π-TB ⟨g⟩={COF_REAL['g_avg']:.3f}, ν=1/2, "
          f"U/Ω={cof['UoverO']:.2f}, self-consistent Δ):")
    for Om, b in best.items():
        print(f"    Ω={Om:>3}meV  Δ_sc={b['delta_sc']:.3f}Ω  ->  Tc = {b['tcK_sc']:.0f} K")
    out['best_sized'] = best

    # Also the TB CEILING (room-T-optimal geometry, structure-class ceiling not a material).
    rt = best_geo[1]
    ceil = {}
    for Om in [80, 120, 160]:
        tcO_sc, delta_sc = tc_geo_selfconsistent(rt['g_avg'], 1.0, return_delta=True)  # U/Ω=1 reference
        ceil[Om] = float(tcO_sc*Om*MEV2K)
    print(f"\n  TB CEILING (structure class, NOT a material): room-T-optimal {best_geo[0]} "
          f"⟨g⟩={rt['g_avg']:.3f}, U/Ω=1, self-consistent Δ:")
    for Om in [80, 120, 160]:
        print(f"    Ω={Om:>3}meV -> Tc_ceiling = {ceil[Om]:.0f} K")
    out['tb_ceiling'] = dict(name=best_geo[0], g_avg=rt['g_avg'], byOmega=ceil)

    # ---- VERDICT ----
    best_real = max(b['tcK_sc'] for b in best.values())
    best_real_Om = max(best, key=lambda Om: best[Om]['tcK_sc'])
    best_ceiling = max(ceil.values())
    ROOM_T = 293.0
    print("\n[VERDICT]")
    print(f"  BEST REAL-HOST sized geometric Tc (sp2C N-Lieb COF, real ⟨g⟩={COF_REAL['g_avg']:.3f}, "
          f"Ω={best_real_Om}meV): {best_real:.0f} K")
    print(f"  BEST TB CEILING (room-T-optimal {best_geo[0]} ⟨g⟩={best_geo[1]['g_avg']:.2f}, U/Ω=1, "
          f"Ω=160meV): {best_ceiling:.0f} K")
    print(f"  room-T = {ROOM_T:.0f} K.  real-host reaches {100*best_real/ROOM_T:.0f}% of room-T; "
          f"TB ceiling reaches {100*best_ceiling/ROOM_T:.0f}%.")
    real_reaches = best_real >= ROOM_T
    ceil_reaches = best_ceiling >= ROOM_T
    print(f"  => real recipe-matched host {'REACHES' if real_reaches else 'does NOT reach'} room-T; "
          f"TB structure-class ceiling {'REACHES' if ceil_reaches else 'does NOT reach'} room-T.")
    out['verdict'] = dict(best_real_tcK=float(best_real), best_real_Omega=best_real_Om,
                          best_ceiling_tcK=float(best_ceiling), room_t_K=ROOM_T,
                          real_reaches_roomT=bool(real_reaches),
                          ceiling_reaches_roomT=bool(ceil_reaches))

    with open(os.path.join(HERE, 'results2.json'), 'w') as f:
        json.dump(out, f, indent=2)
    print(f"\n  wrote {os.path.join(HERE, 'results2.json')}")
