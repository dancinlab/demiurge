#!/usr/bin/env python3
"""
press_all_strong.py — the HONEST optimum with a REAL strong-binding requirement.
press_all_analytic.py exposed a near-escape at t=0.2eV, Ω=300meV, g/t=0.38 (Ω/t=1.5).
That point is an ARTIFACT: g/t=0.38 is the bare dome ONSET — the condensate fraction
(superfluid density n_s, hence D_s) there is ~0, not the L13-ceiling value. A real
room-T condensate needs a SUBSTANTIAL paired fraction, which needs g/t well above
onset (strong binding) — and THAT is exactly what re-triggers the narrowing & FC walls.

So we must couple D_s to the ACTUAL paired density, not just take the L13 ceiling as
if it were always saturated. The honest chain:

  D_s = (n_s/m*) ∝ f_pair(g) · ε_F^dressed(g,Ω) · Z_FC(g,Ω) · (1-Uχ),  capped by L13.

  f_pair(g) = paired fraction, rises from 0 at dome onset g*/t≈0.38 to ~1 deep in the
              bipolaron regime. Model: f_pair = 1 - exp(-(g/t-g*)/Δ), Δ~0.3 (smooth).
  ε_F^dressed = 0.5 W0 exp(-g²/Ω²)   (L9/L13 polaron narrowing).
  Z_FC = exp(-g²/2Ω²)                (L14 dressing/transfer).

  D_s ≤ ALPHA13 · ε_F^dressed  (L13 ceiling still caps it).
  D_s_used = min( ALPHA13·ε_F^dressed,  k_ns·f_pair·ε_F^dressed ) · Z_FC · (1-Uχ)

We scan and report the honest max Tc and the binding wall.
"""
import numpy as np
kB=8.617333262e-5; T_ROOM=293.15
ALPHA13=0.04/(np.pi/2.0)
GSTAR=0.38; DELTA=0.30; K_NS=0.05   # k_ns ~ stiffness-per-εF for a dense condensate

def f_pair(g):  # paired fraction 0->1 above onset
    return np.clip(1-np.exp(-(g-GSTAR)/DELTA),0,1) if g>GSTAR else 0.0

def epsF_dressed(g,Om_t,W0): return 0.5*W0*np.exp(-(g**2)/(Om_t**2))
def Z_FC(g,Om_t): return np.exp(-(g**2)/(2*Om_t**2))

best=None; near=[]
for W0 in [0.5,1.0,2.0,4.0,8.0]:
  for t in [0.1,0.2,0.5,1.0]:
    for Om in [50,100,150,200,300,400]:
      Om_t=(Om/1000.0)/t
      for g in np.linspace(0.38,3.0,60):
        for Uchi in [0.0,0.9]:
          eps=epsF_dressed(g,Om_t,W0); z=Z_FC(g,Om_t); fp=f_pair(g)
          Ds_L13=ALPHA13*eps
          Ds_ns =K_NS*fp*eps
          Ds=min(Ds_L13,Ds_ns)*z*max(0,1-Uchi)
          Tc=2.2*Ds/kB   # 3D-XY, generous
          if Tc>=200: near.append((Tc,W0,t,Om,g,eps,z,fp,Uchi,Ds))
          if best is None or Tc>best[0]:
              best=(Tc,W0,t,Om,g,eps,z,fp,Uchi,Ds)

Tc,W0,t,Om,g,eps,z,fp,Uchi,Ds=best
print("=== HONEST STRONG-BINDING OPTIMUM (3D-XY generous, paired fraction enforced) ===")
print(f"  MAX Tc = {Tc:.1f} K")
print(f"    W0={W0}eV t={t}eV Ω={Om}meV g/t={g:.2f} (Ω/t={(Om/1000)/t:.2f})")
print(f"    ε_F^dressed={eps:.3f}eV  Z_FC={z:.3f}  f_pair={fp:.2f}  Uχ={Uchi}  D_s={Ds:.4f}eV")
print(f"  ROOM-T? {'YES — feasible point exists' if Tc>=293 else 'NO — NO-GO confirmed'}")
print(f"  #points ≥293K: {sum(1 for x in near if x[0]>=293)}  ;  ≥200K: {len(near)}")

# Which wall binds at the optimum?
Om_t=(Om/1000)/t
print(f"\n  At optimum: D_s_L13={ALPHA13*eps:.4f}  D_s_ns={K_NS*fp*eps:.4f}  "
      f"=> {'L13 ceiling binds' if ALPHA13*eps<K_NS*fp*eps else 'paired-fraction/ns binds'}")
print(f"  trade-off: ε_F·Z_FC·f_pair = {eps*z*fp:.4f} eV  "
      f"(room-T needs ε_F·Z_FC·f_pair ≳ {293*kB/(2.2*min(ALPHA13,K_NS)):.3f} eV via the tighter cap)")

# The clean conserved-quantity statement: define the SUM-RULE functional
#   Φ(g,Ω,W0) = ε_F^dressed · Z_FC = 0.5 W0 exp(-1.5 g²/Ω²)
# and the binding needs f_pair(g)→1 i.e. g ≳ g*+Δ ~ 0.68. At g=0.68:
print("\n=== the conserved functional Φ = ε_F·Z_FC at the MINIMUM binding for f_pair≈0.63 (g/t=0.68) ===")
g=0.68
for W0 in [1,2,4,8]:
  for Om in [100,200,300,400]:
    for t in [0.2,0.5,1.0]:
      Om_t=(Om/1000)/t
      Phi=0.5*W0*np.exp(-1.5*g**2/Om_t**2)
      Tc=2.2*ALPHA13*Phi/kB
      if Tc>=293:
        print(f"  *** Φ-feasible: W0={W0} Ω={Om} t={t} (Ω/t={Om_t:.1f}) Φ={Phi:.3f} Tc={Tc:.0f}K")
print("  (lines above are the ONLY ≥293K points with real binding g/t=0.68; empty => clean no-go)")
