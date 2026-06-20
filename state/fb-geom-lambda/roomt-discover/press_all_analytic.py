#!/usr/bin/env python3
"""
press_all_analytic.py — the CLEAN analytic no-go, stripped of heuristics.
The question: is the master conservation ONE sum rule? The decisive object is
whether D_s (=> Tc) has a single upper bound that no joint configuration beats.

Strip the condensate-fraction heuristic. Use the TIGHTEST defensible chain:

  kB Tc = (π/2) D_s            (2D-BKT; 3D ~×1.4, use 2D as the conservative floor)
  D_s ≤ ALPHA13 · ε_F          (L13 Homes/Emery-Kivelson ceiling; ALPHA13=0.04/(π/2))
  D_s_eff = D_s · Z_FC(g,Ω)    (L14 dressing) · (1-Uχ) (L15)

So:  kB Tc ≤ 0.04 · ε_F · Z_FC(g,Ω) · (1-Uχ).

THE ONE-SUM-RULE TEST: is ε_F (the L13 handle) FREE, or is it forced down by the
SAME (g,Ω) that the binding needs? Two sub-questions:
  (Q1) decouple the glue band (deep g) from a SEPARATE wide carrier band (big ε_F):
       L14 (Franck-Condon transfer) shows the deep-glue pair CANNOT transfer its
       pairing to the wide band — V_AB_req > V_AB_max ∀g (two_band_decouple result).
       => the ε_F that condenses is the GLUE band's own ε_F, not the wide band's.
  (Q2) the glue band's own ε_F is bounded by L9: strong off-diagonal glue <=> narrow
       band (κ-H3: deep glue <=> W_AB=0.37eV <=> ε_F≤0.187eV).

Therefore the operative bound is  ε_F ≤ ε_F^glue(g,Ω), and we maximize
  kB Tc ≤ 0.04 · ε_F^glue(g,Ω) · Z_FC(g,Ω) · (1-Uχ)
over (g,Ω,Uχ). Best case Uχ=0 (no magnetism). The remaining single-variable
optimum in g (at fixed Ω) reveals the universal ceiling and WHICH wall binds.
"""
import numpy as np
kB=8.617333262e-5; T_ROOM=293.15
ALPHA13=0.04/(np.pi/2.0)

def epsF_glue(g_over_t, Omega_over_t, W0_eV):
    # L9/L13 lock: dressed carrier band narrows as exp(-g^2/Ω^2) (polaron narrowing)
    lam=(g_over_t**2)/(Omega_over_t**2)
    return 0.5*W0_eV*np.exp(-lam)

def Z_FC(g_over_t, Omega_over_t):
    return np.exp(-(g_over_t**2)/(2.0*Omega_over_t**2))

def Tc_ceiling(g_over_t, Omega_meV, t_eV, W0_eV, Uchi, dim3=True):
    Om_over_t=(Omega_meV/1000.0)/t_eV
    epsF=epsF_glue(g_over_t,Om_over_t,W0_eV)
    z=Z_FC(g_over_t,Om_over_t)
    Ds = ALPHA13*epsF*z*max(0.0,1-Uchi)
    fac = 2.2 if dim3 else (np.pi/2)/kB*kB  # 3D-XY prefactor vs 2D
    kBTc = (2.2*Ds) if dim3 else (np.pi/2)*Ds
    return kBTc/kB, epsF, z, Ds

print("=== CLEAN ANALYTIC NO-GO (3D-XY, most generous: Uχ=0) ===")
print(f"room-T needs ε_F·Z_FC ≥ {kB*T_ROOM/2.2/ALPHA13:.3f} eV  (3D; 2D needs {kB*T_ROOM/(np.pi/2)/ALPHA13:.3f} eV)\n")

# The crux: ε_F^glue * Z_FC = 0.5 W0 exp(-g^2/Ω^2) * exp(-g^2/2Ω^2)
#         = 0.5 W0 exp(-1.5 g^2/Ω^2)  -> MONOTONE DECREASING in g.
# => the product is MAXIMIZED at g->0, where there is NO binding (no SC at all).
# This is the conservation made explicit: any nonzero glue strictly lowers
# ε_F·Z_FC below 0.5 W0. So:  kB Tc ≤ 0.04 · 0.5 · W0 = 0.02 W0  (g->0 limit, no SC),
# and STRICTLY below that for any real (binding) g>0.
print("KEY IDENTITY: ε_F^glue·Z_FC = 0.5 W0 · exp(-1.5 g²/Ω²)  [monotone ↓ in g]")
for W0 in [0.5,1.0,2.0,4.0]:
    Tc_g0 = 2.2*ALPHA13*0.5*W0/kB
    print(f"  W0={W0}eV: absolute sup (g->0, NO binding) Tc < {Tc_g0:6.0f} K  "
          f"-> {'≥293 possible ONLY at g→0 (no SC)' if Tc_g0>=293 else 'BELOW 293 even at g→0'}")

# Now the REALISTIC optimum: g must be large enough to BIND (g/t ≳ 0.38 dome onset).
print("\n=== with a REAL binding constraint g/t ≥ 0.38 (dome onset) ===")
best=None
for W0 in [0.5,1.0,2.0,4.0,8.0]:
  for t in [0.2,0.5,1.0]:
    for Om in [50,100,150,200,300]:
      for g in np.linspace(0.38,2.5,40):
        Tc,epsF,z,Ds=Tc_ceiling(g,Om,t,W0,0.0,dim3=True)
        if best is None or Tc>best[0]:
            best=(Tc,W0,t,Om,g,epsF,z,Ds)
Tc,W0,t,Om,g,epsF,z,Ds=best
print(f"  MAX Tc over all (W0,t,Ω,g≥0.38, Uχ=0) = {Tc:.1f} K")
print(f"    at W0={W0}eV t={t}eV Ω={Om}meV g/t={g:.2f} -> ε_F={epsF:.3f}eV Z_FC={z:.3f} D_s={Ds:.4f}eV")
print(f"  ROOM-T (293K)? {'YES' if Tc>=293 else 'NO — NO-GO confirmed'}")

# Sensitivity: how big would W0 have to be to reach 293K at the dome onset g/t=0.38?
print("\n=== how wide a band would room-T REQUIRE (at minimal binding g/t=0.38)? ===")
g=0.38
for Om in [100,150,200,300]:
    # solve 2.2*ALPHA13*0.5*W0*exp(-1.5 g^2/Ω_t^2)/kB = 293 for W0, with Ω_t=(Om/1000)/t, t=1
    t=1.0; Om_t=(Om/1000.0)/t
    z_eff=np.exp(-1.5*g**2/Om_t**2)
    W0_req = 293*kB/(2.2*ALPHA13*0.5*z_eff)
    print(f"  Ω={Om}meV (t=1eV): need W0 ≥ {W0_req:8.1f} eV   "
          f"(exp narrowing factor {z_eff:.2e}; physical bandwidths are ≤~10 eV)")
