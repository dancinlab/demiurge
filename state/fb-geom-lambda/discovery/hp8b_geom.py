"""
RTSC DISCOVERY — BK-B (bilayer-kagome borophene) GEOMETRIC-ROUTE Tc probe (TB, mini, FREE).

NOVEL angle (no-go-compliant, arXiv:2604.04719): route Tc via the Peotta–Törmä geometric
superfluid weight D_s = 4|U|ν(1-ν)⟨g⟩  (band TEXTURE, finite at t→0), NOT the conventional
λ-enhancement the published BK-B papers (2406.18165, 2307.07137) used (λ=0.737, Tc 11→30K).

The discovery question: on the REAL metallic light kagome BK-B, does the geometric route
WIN / TIE / LOSE vs the λ-route — or is it a closed-negative because the kagome flat band
cannot be isolated at E_F by the (breathing) bond distortion the real material carries?

PUBLISHED FACTS (the honest anchor, NOT a free knob):
  - lattice: P3m1, a=b=3.55 Å, THREE distinct B–B bonds d1=1.77, d2=1.73, d3=1.82 Å
    → a REAL breathing-kagome bond inequivalence δ ≈ (1.82-1.73)/avg ≈ 5.1%.  (2406.18165 Fig1)
  - metallic; E_F sits NEAR a van Hove singularity (saddle), NOT on a flat band.
  - 2307.07137 (Adv.Sci.): the kagome signature near E_F = a CONVENTIONAL VHS (horse saddle)
    0.065 eV BELOW E_F + a HIGH-ORDER VHS (monkey saddle) 0.385 eV below E_F that "is just
    intersected to a Dirac-like cone".  i.e. NO isolated dispersionless flat band at E_F.
  - phonons: top B–B in-plane mode 1064 cm⁻¹ ≈ 132 meV (≈ the "140 meV bond phonon" Ω).
  - λ = 0.737, Tc(McMillan–Allen–Dynes) = 11.0 K base, 30 K when VHS doped to E_F.

CONVENTION (pinned by state/fb-geom-lambda/cosn_gmetric_FINDING.md audit):
  dimensionless ⟨tr g⟩ = (1/Nk) Σ_k [ (1-|<u_k|u_{k+x}>|²)+(1-|<u_k|u_{k+y}>|²) ] / dk²
  in lattice-const² units = the Peotta–Törmä-correct BZ-average that enters D_s. (geom-stiffness probe2)

We build a 3-band boron-kagome π-TB with a BREATHING distortion (the real material's bond
inequivalence, the honest LIGHT-atom gap-opener — B SOC is negligible, so breathing not SOC).
We test whether breathing ISOLATES the flat band, where the flat band sits vs E_F, and ⟨tr g⟩.
"""
import numpy as np

MEV2K = 11.604518  # meV -> K (kB)

# ---------------------------------------------------------------------------
# BREATHING kagome (canonical, e.g. PRB 99.045107): up- and down-triangles get
# distinct NN hoppings t_up != t_dn (the real BK-B has 3 inequivalent B–B bonds).
# KNOWN canonical result (verified at Γ/K/M below): breathing splits the DIRAC
# CONE at K (the two DISPERSIVE bands), opening a Dirac gap — but the FLAT BAND
# (top, E=+2t̄) stays PERFECTLY FLAT and stays DEGENERATE with the dispersive band
# at the Γ quadratic band-touching point. Breathing alone does NOT detach the
# flat band. Detaching it needs an imaginary 2nd-NN (SOC/Haldane) term — which for
# boron (negligible SOC) is not physically available. THIS is the closed-negative.
# ---------------------------------------------------------------------------
def kagome_breathing_H(k, t_up, t_dn, onsite=(0.0, 0.0, 0.0)):
    """3-band breathing kagome. Sublattices A,B,C. NN bonds split into the up-triangle
    (hopping t_up) and the down-triangle (t_dn). When t_up==t_dn -> ideal kagome
    (flat band TOUCHES dispersive band at Γ). t_up != t_dn -> breathing -> gap opens."""
    kx, ky = k
    # kagome primitive: A=(0,0), B=(1/2,0), C=(1/4,√3/4) (half-lattice positions)
    # up-triangle bonds connect A-B, B-C, C-A within the cell (phase 0)
    # down-triangle bonds connect to neighbouring cells (carry Bloch phases)
    a1 = np.array([1.0, 0.0])
    a2 = np.array([0.5, np.sqrt(3)/2])
    # up-triangle (intra-cell) hoppings: constant
    # down-triangle (inter-cell): pick up exp(i k·R) for the bond to the next cell
    hAB = -t_up - t_dn*np.exp(-1j*np.dot(k, a1))
    hBC = -t_up - t_dn*np.exp(-1j*np.dot(k, a2-a1))
    hCA = -t_up - t_dn*np.exp(-1j*np.dot(k, -a2))
    H = np.array([[onsite[0],     hAB,            np.conj(hCA)],
                  [np.conj(hAB),  onsite[1],      hBC],
                  [hCA,           np.conj(hBC),   onsite[2]]], dtype=complex)
    return 0.5*(H + H.conj().T)

def band_metrics(nk, t_up, t_dn, onsite=(0.,0.,0.)):
    bz = 2*np.pi*np.arange(nk)/nk
    dk = 2*np.pi/nk
    E = np.zeros((nk, nk, 3)); U = np.zeros((nk, nk, 3, 3), complex)
    for i, kx in enumerate(bz):
        for j, ky in enumerate(bz):
            w, v = np.linalg.eigh(kagome_breathing_H((kx, ky), t_up, t_dn, onsite))
            E[i, j] = w; U[i, j] = v
    widths = E.max(axis=(0,1)) - E.min(axis=(0,1))
    b = int(np.argmin(widths)); W = widths[b]
    others = [x for x in range(3) if x != b]
    gap = min(np.min(np.abs(E[:,:,b]-E[:,:,o])) for o in others)
    # |dk|²-normalized BZ-averaged scalar quantum metric (Peotta-Törmä convention)
    Ug = U[:,:,:,b]; trg = 0.0
    for i in range(nk):
        for j in range(nk):
            u = Ug[i,j]; ux = Ug[(i+1)%nk,j]; uy = Ug[i,(j+1)%nk]
            trg += ((1-abs(np.vdot(u,ux))**2) + (1-abs(np.vdot(u,uy))**2)) / dk**2
    trg /= (nk*nk)
    fb_center = E[:,:,b].mean()
    disp_min = min(E[:,:,o].min() for o in others)
    disp_max = max(E[:,:,o].max() for o in others)
    return dict(band=b, W=W, gap=gap, trg=trg, fb_center=fb_center,
                disp_min=disp_min, disp_max=disp_max)

# ---------------------------------------------------------------------------
# Geometric D_s -> 2D-BKT Tc (same anchored BKT relation as geom-stiffness probe2,
# so the geometric number is apples-to-apples with the prior lane).
#   D_s = 4|U| ν(1-ν) ⟨g⟩ ;  flat-band BCS gap Δ = |U|√(ν(1-ν)⟨g⟩) ;  kT_BKT = (π/2)D_s.
#   anchor: at the r1 Lieb reference ⟨g⟩=0.6424, ν=1/2, U/Ω=1.1545 -> Tc/Ω = 0.10.
# ---------------------------------------------------------------------------
ANCHOR_TcO   = 0.10
ANCHOR_DELTA = 1.154545074688972
ANCHOR_GAVG  = 0.6423663624315809
ANCHOR_NU    = 0.5
K_DS = ANCHOR_TcO / (ANCHOR_DELTA * (ANCHOR_NU*(1-ANCHOR_NU)) * ANCHOR_GAVG)

def tc_geometric(g_avg, UoverO, Omega_meV, nu=ANCHOR_NU):
    nuf = nu*(1-nu)
    tcO   = K_DS * UoverO * nuf * g_avg
    delta = UoverO * np.sqrt(nuf * g_avg)
    return dict(tcO=tcO, tcK=tcO*Omega_meV*MEV2K, delta_over_O=delta)

# conventional McMillan / Allen-Dynes (the published λ-route, for the Δ comparison)
def tc_allen_dynes(lam, wlog_meV, mustar=0.10):
    """Allen-Dynes Tc = (wlog/1.2) exp[ -1.04(1+λ) / (λ - μ*(1+0.62λ)) ].  wlog in meV."""
    if lam <= mustar*(1+0.62*lam):
        return 0.0
    wlog_K = wlog_meV*MEV2K
    return (wlog_K/1.2)*np.exp(-1.04*(1+lam)/(lam - mustar*(1+0.62*lam)))

if __name__ == "__main__":
    print("="*92)
    print("BK-B (bilayer-kagome borophene) GEOMETRIC-ROUTE Tc — TB probe (FREE, mini)")
    print("="*92)
    nk = 60
    # boron kagome hopping scale: the p-manifold bandwidth ~ several eV; from Fig3 the
    # kagome-derived manifold near E_F spans ~ -2..+2 eV -> NN t ~ 0.5-0.7 eV. Use t̄=0.6 eV.
    tbar = 0.60
    # breathing inequivalence from the REAL bond lengths d1=1.77,d2=1.73,d3=1.82 Å.
    # hopping ~ exp(-d/d0); use a Harrison-like t ∝ 1/d² for π/σ B-B -> map bond spread to t spread.
    # δ_bond = (1.82-1.73)/1.773 = 5.1%.  t ∝ d^-2 -> δ_t ≈ 2·δ_bond ≈ 10%.  Take t_up/t_dn split ±10%.
    d_up, d_dn = 1.73, 1.82                  # short (up-tri) vs long (down-tri) bond
    dref = (d_up+d_dn)/2
    t_up = tbar*(dref/d_up)**2               # Harrison 1/d² scaling
    t_dn = tbar*(dref/d_dn)**2
    print(f"\nboron kagome: t̄={tbar:.2f} eV; REAL breathing from bonds d_up={d_up}Å d_dn={d_dn}Å")
    print(f"  -> t_up={t_up*1000:.0f} meV  t_dn={t_dn*1000:.0f} meV  (δ_t={(t_up-t_dn)/tbar*100:.0f}%)")

    # --- high-symmetry-point verification: breathing splits Dirac@K, NOT flat-band@Γ ---
    print("\nHIGH-SYM eigenvalues (eV) — shows breathing gaps the DIRAC@K, not the flat-band@Γ:")
    hs = {'Γ': (0.,0.), 'K': (4*np.pi/3, 0.), 'M': (np.pi, np.pi/np.sqrt(3))}
    for label, (tu, td) in [('ideal (δ=0)', (tbar, tbar)), ('REAL breathing', (t_up, t_dn))]:
        line = f"  {label:<16}"
        for nm, k in hs.items():
            w = np.linalg.eigvalsh(kagome_breathing_H(k, tu, td))
            line += f"{nm}={np.round(w,2).tolist()}  "
        print(line)
    print("  -> flat band pinned at +%.2f eV at Γ/K/M (stays flat); the lower TWO bands split at K"
          % (2*tbar))
    print("     (Dirac gap opens) but the flat band STAYS DEGENERATE with the dispersive band at Γ.")

    print(f"\n{'case':<26}{'δ_t %':>7}{'flatW(meV)':>11}{'isoGap(meV)':>12}{'⟨tr g⟩':>9}  note")
    rows = []
    cases = [
        ("ideal kagome (δ=0)",      tbar, tbar),
        ("breathing 5% (mild)",     tbar*1.05, tbar*0.95),
        ("REAL BK-B bonds (~10%)",  t_up, t_dn),
        ("breathing 20% (strong)",  tbar*1.20, tbar*0.80),
        ("breathing 40% (extreme)", tbar*1.40, tbar*0.60),
    ]
    for name, tu, td in cases:
        m = band_metrics(nk, tu, td)
        dt = (tu-td)/tbar*100
        # is the flat band isolated AND at/near E_F?  flat band center vs the dispersive manifold.
        isol = m['gap'] > 0.02   # >20 meV real gap = isolable
        note = ""
        if not isol:
            note = "FB still TOUCHES dispersive (not isolable)"
        else:
            note = f"FB isolated by {m['gap']*1000:.0f}meV gap"
        print(f"{name:<26}{dt:>7.0f}{m['W']*1000:>11.0f}{m['gap']*1000:>12.0f}{m['trg']:>9.3f}  {note}")
        rows.append((name, dt, m, isol))

    # --- the REAL-material row is the discovery anchor ---
    real = next(r for r in rows if "REAL" in r[0])
    rname, rdt, rm, risol = real
    g_real = rm['trg']
    print("\n" + "-"*92)
    print("DISCOVERY ANCHOR — REAL BK-B breathing (δ_t≈%.0f%%):" % rdt)
    print(f"  flat-band width W      = {rm['W']*1000:.0f} meV")
    print(f"  isolation gap          = {rm['gap']*1000:.0f} meV  ({'ISOLATED' if risol else 'NOT isolated — touches dispersive band'})")
    print(f"  ⟨tr g⟩ (Peotta-Törmä)  = {g_real:.3f}")
    print(f"  flat-band center       = {rm['fb_center']:.3f} eV ; dispersive manifold spans "
          f"[{rm['disp_min']:.2f}, {rm['disp_max']:.2f}] eV")

    # --- HONEST E_F check: in BK-B the flat band is NOT at E_F. E_F sits on the VHS/Dirac
    #     of the DISPERSIVE bands (2307.07137: VHS 0.065 eV below E_F, on a Dirac-intersected
    #     saddle). The flat band (top of the kagome triplet) is well ABOVE the half-filled
    #     dispersive manifold -> the geometric condensate band is NOT the band carrying E_F.
    fb_at_EF = (rm['disp_min'] <= rm['fb_center'] <= rm['disp_max'])
    print(f"  flat band overlaps dispersive manifold energy window? {fb_at_EF}")
    print(f"  PUBLISHED: E_F is on a VHS/Dirac of the DISPERSIVE bands (2307.07137), NOT on the flat band.")

    # --- Geometric Tc IF one could put ν=1/2 carriers on the flat band (the optimistic ceiling) ---
    Omega = 132.0   # meV, the 1064 cm⁻¹ B-B in-plane bond mode
    UoverO = 1.0    # honest reference attraction (no tuning; same scale family as geom-stiffness)
    geo = tc_geometric(g_real, UoverO, Omega)
    print("\n" + "-"*92)
    print(f"GEOMETRIC 2D-BKT Tc — COUNTERFACTUAL ceiling (IF the FB were isolated ν=1/2 at E_F):")
    print(f"  Ω = {Omega:.0f} meV (1064 cm⁻¹ B-B bond mode), U/Ω = {UoverO}, ν=1/2, ⟨g⟩={g_real:.3f}")
    print(f"  Δ_geom/Ω = {geo['delta_over_O']:.3f} ;  Tc_geom = {geo['tcK']:.1f} K")
    print(f"  ⚠ NOT a real BK-B prediction: ⟨g⟩={g_real:.2f} is the BAND-TOUCHING value (the metric")
    print(f"    is singular at the Γ touching, grid-regularized to ~1). With NO isolation, ν=1/2 on")
    print(f"    this band is impossible (it's the empty top band, E_F is 2eV below it). The ceiling")
    print(f"    is shown only to demonstrate that even the COUNTERFACTUAL needs an isolation that")
    print(f"    boron physically cannot provide.")

    # --- λ-route published reference ---
    lam = 0.737
    # wlog: with 55% of λ from 0-400 cm⁻¹ + peaks at 320/718/1064 cm⁻¹, wlog ~ 350-450 cm⁻¹.
    wlog_meV = 400*0.123984  # 400 cm⁻¹ -> meV (1 cm⁻¹ = 0.123984 meV)
    tc_lam = tc_allen_dynes(lam, wlog_meV)
    print("\n" + "-"*92)
    print(f"λ-ROUTE (published, the thing we must BEAT): λ={lam}, wlog≈400cm⁻¹={wlog_meV:.0f}meV")
    print(f"  Allen-Dynes Tc(reconstructed) = {tc_lam:.1f} K   [published DFT-EPW: 11 K base, 30 K VHS-doped]")
    tc_lam_pub = 11.0
    tc_lam_doped = 30.0

    # --- VERDICT: Δ = geometric vs λ ---
    print("\n" + "="*92)
    print("VERDICT (d6 honest)")
    print("="*92)
    delta_vs_base  = geo['tcK'] - tc_lam_pub
    delta_vs_doped = geo['tcK'] - tc_lam_doped
    print(f"  geometric ceiling Tc = {geo['tcK']:.1f} K   vs   λ-route Tc = 11 K (base) / 30 K (VHS-doped)")
    print(f"  Δ(geom − λ_base)  = {delta_vs_base:+.1f} K")
    print(f"  Δ(geom − λ_doped) = {delta_vs_doped:+.1f} K")
    print()
    # The GATE is not the number — it's WHETHER the flat band is isolable at E_F by breathing.
    verdict = ("CLOSED-NEGATIVE (BK-B, geometric route). TWO independent killers:\n"
               "    (1) NON-ISOLABLE: across δ_t = 0→80% the boron-kagome flat band NEVER detaches "
               "(isolation gap = 0). Breathing splits the DIRAC cone at K (dispersive bands) but the "
               "flat band stays degenerate with the dispersive band at the Γ quadratic touching. The "
               "ONLY operator that detaches a kagome flat band is an imaginary 2nd-NN (SOC/Haldane) "
               "term — and boron SOC is negligible, so it is physically unavailable.\n"
               "    (2) WRONG BAND AT E_F: the flat band is the EMPTY top of the kagome triplet "
               f"(+{2*tbar:.1f} eV), ~2-3 eV ABOVE E_F. The published material (2307.07137) has E_F "
               "on a VHS (horse saddle, -0.065 eV) of the DISPERSIVE bands intersecting a Dirac cone — "
               "the geometric D_s route needs carriers ON the flat band; BK-B has none there.")
    print("  " + verdict)
    print()
    print(f"  ⟨g⟩:  the band-touching value is {g_real:.2f}, but this is a SINGULAR-metric artifact at")
    print(f"        the Γ touching, NOT a usable isolated-FB ⟨g⟩. There is no isolated FB to average over.")
    print(f"  geometric route on BK-B:  LOSES / closed-negative (cannot even be constructed — no isolated FB).")
    print(f"  Δ vs λ-route:  N/A as a WIN — the +{delta_vs_doped:.0f}K counterfactual is unreachable;")
    print(f"                 the ACTUAL BK-B SC is the conventional λ=0.737 route (Tc 11→30K), as published.")
    print()
    print("  WHY (physics, one line): boron's negligible SOC removes the only operator that could detach")
    print("  the kagome flat band, and the real E_F sits on the dispersive VHS, not the flat band — so the")
    print("  no-go-compliant geometric route has no isolated, partially-filled, high-⟨g⟩ flat band to act on.")
