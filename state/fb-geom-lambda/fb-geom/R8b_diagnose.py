"""
FB-GEOM-LAMBDA R8b -- diagnose the R8 split signal.

R8 found: aggregate r(<IPR>,Q_geom)=-0.14 (NEGATIVE), BUT per-family Lieb r=+0.9996 (near
perfect) and dice_phi r=-0.64 (contaminated). Many tuned points were NON-FLAT (stub/sawtooth
flat only at isolated knob values -> dropped). This diagnostic asks the sharper question:

  Q1. Is the orbital-IPR -> Q_geom map FAMILY-CLEAN (high |r| within each family) but with a
      family-dependent OFFSET (so the law is "Q_geom = f_lattice(orbital support)", not a single
      universal 1/N_orb)?  -> would be a PARTIAL/conditional law, not the clean universal one.
  Q2. The dice_phi contamination: near phi~pi/3 the flat eigvec becomes nearly k-INDEPENDENT
      (Q->1). That is the OPPOSITE of orbital spread -- it is k-dependence COLLAPSE. Removing
      that confound, does dice obey the orbital law?
  Q3. The real geometric content: Q_geom = <|<u|u'>|^2> is the BZ-AVERAGED state overlap. For a
      2-orbital-support band whose weights w_A(k),w_B(k) and relative phase vary, what actually
      sets <|<u|u'>|^2>?  Test the closed form for a generic 2-orbital flat band.
"""
import numpy as np

def qgeom(Uf):
    ov2 = np.abs(Uf.conj() @ Uf.T)**2
    return float(ov2.mean())

# ---- exact 2-orbital model: u(k) = (cos t(k), sin t(k) e^{i ph(k)}) ----------------------------
# Q_geom for a great-circle / general path on the Bloch sphere. This is the IRREDUCIBLE geometry.
def two_orbital_Q(theta, phi):
    """theta(k), phi(k): arrays. Q_geom of u=(cos th, sin th e^{i ph})."""
    U = np.stack([np.cos(theta), np.sin(theta)*np.exp(1j*phi)], axis=-1)
    return qgeom(U), float((np.cos(theta)**2).mean()), float((np.sin(theta)**2).mean())

print("="*96)
print("R8b -- what does Q_geom of a 2-orbital flat band actually measure? (Bloch-sphere closed form)")
print("="*96)
print("\nu(k) = (cos th(k), sin th(k) e^{i ph(k)}).  Sweep the polar SPREAD and the phase WINDING.\n")

# Case A: pure phase winding at fixed polar angle th0 (equal-ish weight, only the PHASE moves)
print("[A] fixed polar th0 (fixed orbital weights), phase ph winds 0..2pi*w:")
print(f"   {'th0(deg)':>8} {'wA':>6} {'wB':>6} {'wind w':>7} {'Q_geom':>8}")
for th0_deg in [10, 30, 45, 60, 80]:
    th0 = np.deg2rad(th0_deg)
    k = np.linspace(0, 2*np.pi, 400, endpoint=False)
    for w in [1, 2]:
        ph = w*k
        Q, wA, wB = two_orbital_Q(np.full_like(k, th0), ph)
        if w == 1:
            print(f"   {th0_deg:>8} {wA:6.3f} {wB:6.3f} {w:>7} {Q:8.4f}")

# Case B: equal average weight (wA=wB=1/2) but TUNABLE polar oscillation amplitude
print("\n[B] th(k)=pi/4 + A sin k  (orbital weights OSCILLATE around equal; A = spread amplitude):")
print(f"   {'A(rad)':>7} {'<wA>':>6} {'<wB>':>6} {'Q_geom':>8}")
k = np.linspace(0, 2*np.pi, 400, endpoint=False)
for A in [0.0, 0.2, 0.4, 0.6, 0.785]:
    th = np.pi/4 + A*np.sin(k)
    ph = k
    Q, wA, wB = two_orbital_Q(th, ph)
    print(f"   {A:7.3f} {wA:6.3f} {wB:6.3f} {Q:8.4f}")

# Case C: the KEY test -- does Q depend on the polar angle (orbital imbalance) at FIXED winding?
print("\n[C] phase winds once (w=1); slide the FIXED polar angle th0 (pure orbital IMBALANCE):")
print(f"   {'th0(deg)':>8} {'wA':>6} {'wB':>6} {'IPR=wA^2+wB^2':>14} {'Q_geom':>8} {'1-2 wA wB <e^iph>? ':>20}")
k = np.linspace(0, 2*np.pi, 800, endpoint=False)
ph = k
for th0_deg in [0.1, 15, 30, 45, 60, 75, 89.9]:
    th0 = np.deg2rad(th0_deg)
    th = np.full_like(k, th0)
    Q, wA, wB = two_orbital_Q(th, ph)
    ipr = wA**2 + wB**2
    # closed form guess: Q = wA^2 + wB^2 + 2 wA wB |<e^{i ph}>|^2 = IPR + 2 wA wB |mean phase|^2
    meanphase = np.abs(np.mean(np.exp(1j*ph)))**2
    guess = ipr + 2*wA*wB*meanphase
    print(f"   {th0_deg:>8} {wA:6.3f} {wB:6.3f} {ipr:14.4f} {Q:8.4f}   guess={guess:.4f}")

print("\n" + "="*96)
print("CLOSED FORM (derived): for u=(sqrt(wA), sqrt(wB) e^{i ph(k)}), wA+wB=1 fixed,")
print("   <|<u(k)|u(k')>|^2>_{k,k'} = wA^2 + wB^2 + 2 wA wB |<e^{i ph}>_k|^2")
print("                            = IPR        + 2 wA wB |<e^{i ph}>|^2")
print("So Q_geom = orbital-IPR  ONLY IF the relative phase fully decorrelates ( <e^{i ph}> = 0,")
print("i.e. the phase winds >=1 full turn).  If the phase does NOT wind (<e^{i ph}>!=0) Q_geom")
print("RISES ABOVE the IPR by 2 wA wB |<e^{i ph}>|^2  ->  that is the dice_phi Q->1 leak (no winding).")
print("="*96)
