#!/usr/bin/env python3
"""
press_all_sumrule.py  — RTSC room-T META/SYNTHESIS lane "press-all-sumrule"
============================================================================
THE DECISIVE TEST: are the four closure faces (L9/L13/L14/L15) projections of
ONE conserved quantity (a superfluid-stiffness sum rule -> no-go META-THEOREM),
or a set of SEPARABLE pairwise trade-offs (-> multi-objective optimization with
a possible feasible interior point = the threading room-T candidate)?

FREE local numpy/scipy only. NO billing pod. NEVER fabricate (d6). TB/analytic-grade.

Common variable set (all four laws written on these):
    t      hopping of the carrier band (sets bandwidth W = 2*z*t in d-dim; ε_F ≤ W)
    g/t    off-diagonal (SSH/bond-Peierls) dimensionless coupling
    Ω      phonon (bond) frequency  [meV]
    ε_F    carrier Fermi energy (coherent) [eV]      -> the L13 stiffness handle
    ξ_pair pair size (∝ 1/binding)                   -> the L9/L14 binding handle
    Uχ     Stoner factor of the host                  -> the L15 magnetic handle
    D_s    superfluid stiffness (the candidate single conserved quantity) [eV]

THE FOUR FACES as inequalities on a COMMON D_s:
  D_s is the SUPERFLUID WEIGHT; kB*Tc = (π/2)*D_s in 2D (BKT), kB*Tc ≈ C3D*D_s in 3D.
  D_s = D_s^conv (kinetic, ∝ n/m*) + D_s^geom (quantum-geometric, ∝ ⟨g_geom⟩).
  Each law puts a SEPARATE upper bound on a SEPARATE multiplicative factor of D_s:

   L9  (g↔Ω same-band)      : the product g*Ω is capped by lattice stability ->
                              D_s gets at most a FIXED binding-energy budget E_b^max.
   L13 (Tc ≲ 0.04 ε_F)      : D_s ≤ (2/π) kB * 0.04 ε_F / (with Tc=π/2 D_s) ->
                              D_s ≤ 0.04 ε_F * (kB/(π/2 kB)) ... i.e. D_s is *capped by ε_F*.
                              Equivalently the stiffness cannot exceed the band's own
                              kinetic scale: D_s ≤ α13 * ε_F.
   L14 (Franck-Condon)      : transfer/phase-coherence factor Z_FC = exp(-g²/2Ω²);
                              D_s_effective = D_s_bare * Z_FC  (dressing suppression).
   L15 (Stoner/SDW)         : the pairing channel is pre-empted unless Uχ<1; the
                              *available* D_s before order sets in scales (1-Uχ).
                              D_s_available = D_s * (1 - Uχ).

THE UNIFICATION QUESTION:
  Write Tc as Tc = (1/kB)*(π/2)* D_s0 * Z_FC(g,Ω) * (1-Uχ),  with D_s0 ≤ α13 ε_F,
  AND ε_F itself bounded by the SAME (g,Ω) through L9 (narrow band <=> strong glue).
  If ε_F = ε_F(g,Ω) is FORCED DOWN by the very (g,Ω) that Z_FC and binding want UP,
  then all four are coupled through ONE chain  g,Ω -> {ε_F, Z_FC, Uχ} -> D_s -> Tc,
  and the question is whether max over (g,Ω,...) of Tc can reach 293 K.

We do BOTH:
  (A) treat the faces as INDEPENDENT multiplicative penalties on a generous D_s0
      (the "separable" hypothesis) and maximize Tc over the joint feasible region;
  (B) impose the L9 coupling ε_F = ε_F(g,Ω) (narrow-band-from-strong-glue) that ties
      them together (the "one sum rule" hypothesis) and re-maximize.
  The GAP between (A) and (B) tells us whether unification (B) is what kills room-T.
"""
import numpy as np

kB = 8.617333262e-5  # eV/K
T_ROOM = 293.15      # K

# --- Tc from superfluid stiffness ---------------------------------------------
# 2D BKT:   kB Tc = (pi/2) D_s          (Nelson-Kosterlitz universal jump)
# 3D-XY:    kB Tc ≈ 2.20 * (D_s * a)    ; we use a dimensionless O(1) prefactor.
def Tc_from_Ds_2D(Ds):
    return (np.pi/2.0) * Ds / kB
def Tc_from_Ds_3D(Ds, c3d=2.2):
    return c3d * Ds / kB

# --- L13: stiffness-ceiling  Tc ≲ 0.04 ε_F  <=>  D_s ≤ α13 ε_F ------------------
# arXiv:2505.02894 / Emery-Kivelson / Homes-Uemura: kB Tc ≤ 0.04 ε_F (empirical
# upper edge of the Uemura/Homes correlation across all SCs). With kB Tc=(pi/2)Ds:
#   (pi/2) D_s ≤ 0.04 ε_F  =>  D_s ≤ (0.04/(pi/2)) ε_F = 0.02546 ε_F
ALPHA13 = 0.04 / (np.pi/2.0)   # ≈ 0.02546   (D_s ≤ ALPHA13 * ε_F)

# --- L9: g↔Ω same-band binding budget -----------------------------------------
# Off-diagonal binding |Δ_b| ≈ a * (g²/Ω) * Ω = a g²  ... but g and Ω anticorrelate:
# a SOFT bond (large g/t=2u0/d, u0∝1/sqrt(MΩ)) has SMALL Ω; a STIFF bond (large Ω)
# has SMALL g. Empirically (this campaign's validated ED) the *product that sets
# binding* g²·Ω is lattice-stability-capped: g²·Ω ≤ B9.  Calibrate B9 so the best
# real off-diagonal bipolaron (Tc~40-80K dome) sits at the cap.
#   binding scale E_b that feeds the bare condensate: E_b ≈ kappa * g² * Ω(meV)/1000 [eV]
def Eb_offdiag(g_over_t, t_eV, Omega_meV):
    # 2-body binding from the validated SSH map (light bipolaron, |Δb|/t ~ c*(g/t)^2)
    cb = 0.13   # |Δb|/t per (g/t=1)^2 anchored to ED row g/t=0.44->Δb/t≈0.127->cb≈0.66? use ED fit
    # ED anchor: g/t=0.44 gave |Δb|/t=0.127 -> cb = 0.127/0.44^2 = 0.656
    cb = 0.127/0.44**2
    return cb * (g_over_t**2) * t_eV     # binding energy in eV

# --- L14: Franck-Condon dressing/transfer factor -------------------------------
def Z_FC(g_over_t, Omega_over_t):
    # Lang-Firsov:  exp(-g^2/(2 Ω^2)) with g,Ω in same (t) units
    return np.exp(-(g_over_t**2) / (2.0 * Omega_over_t**2))

# --- L15: Stoner/SDW pre-emption availability ---------------------------------
def stoner_available(Uchi):
    # condensate available only below the magnetic instability; (1-Uχ), Uχ in [0,1)
    return max(0.0, 1.0 - Uchi)

# --- L9-coupled ε_F(g,Ω): narrow-band-from-strong-glue -------------------------
# The SAME localization that makes g/t=2u0/d large (short, soft bond) NARROWS the
# coherent band, capping ε_F. Model: W_coh = W0 * exp(-lambda_pol) with polaron
# narrowing lambda_pol = g²/Ω² (Holstein-like band narrowing of the *dressed*
# carrier), and ε_F ≤ W_coh/2. This is the L13<->L9 lock seen empirically in
# κ-H3 (deep glue <=> narrow dimer band <=> low ε_F).
def epsF_coupled(g_over_t, Omega_over_t, W0_eV):
    lam_pol = (g_over_t**2) / (Omega_over_t**2)        # band-narrowing exponent
    W_coh = W0_eV * np.exp(-lam_pol)
    return 0.5 * W_coh                                  # ε_F ~ half-bandwidth (half filling-ish)

# ==============================================================================
#  SCAN
# ==============================================================================
def scan(coupled_epsF):
    """coupled_epsF=False -> (A) separable (ε_F free, generous wide band).
       coupled_epsF=True  -> (B) one-sum-rule (ε_F forced down by g,Ω via L9)."""
    best = None
    # generous but physical ranges
    t_grid      = [0.20, 0.50, 1.00]            # eV  carrier hopping (wide band wants big t)
    g_grid      = np.linspace(0.2, 2.5, 24)     # g/t
    Om_grid     = np.array([50, 100, 150, 200]) # meV bond phonon (light element budget)
    W0_grid     = [0.5, 1.0, 2.0, 4.0]          # eV  bare carrier bandwidth (for coupled ε_F)
    Uchi_grid   = [0.0, 0.5, 0.9]               # Stoner factor (0 = no magnetism; 0.9 = QCP edge)
    rows = []
    for t in t_grid:
        for W0 in W0_grid:
            for g in g_grid:
                for Om_meV in Om_grid:
                    Om_over_t = (Om_meV/1000.0)/t
                    # ε_F handle
                    if coupled_epsF:
                        epsF = epsF_coupled(g, Om_over_t, W0)
                    else:
                        epsF = 0.5*W0   # free wide band, independent of glue (separable)
                    # bare stiffness budget: take the L13 ceiling as the MAX bare D_s
                    Ds_bare_max = ALPHA13 * epsF
                    # but bare D_s also can't exceed what the binding can condense:
                    # require a bound pair: Eb>0; condensate weight ∝ min(Eb, epsF) heuristic
                    Eb = Eb_offdiag(g, t, Om_meV)
                    cond_cap = min(1.0, Eb/max(epsF,1e-6))   # crude pair-density fraction ≤1
                    Ds_bare = Ds_bare_max * cond_cap
                    # apply L14 and L15 multiplicative penalties
                    zfc = Z_FC(g, Om_over_t)
                    for Uchi in Uchi_grid:
                        avail = stoner_available(Uchi)
                        Ds_eff = Ds_bare * zfc * avail
                        Tc2D = Tc_from_Ds_2D(Ds_eff)
                        Tc3D = Tc_from_Ds_3D(Ds_eff)
                        rows.append(dict(t=t,W0=W0,g=g,Om=Om_meV,epsF=epsF,Eb=Eb,
                                         zfc=zfc,Uchi=Uchi,Ds=Ds_eff,Tc2D=Tc2D,Tc3D=Tc3D))
                        Tc = max(Tc2D, Tc3D)
                        if best is None or Tc>best['Tc']:
                            best=dict(mode=('coupled' if coupled_epsF else 'separable'),
                                      t=t,W0=W0,g=g,Om=Om_meV,epsF=epsF,Eb=Eb,zfc=zfc,
                                      Uchi=Uchi,Ds=Ds_eff,Tc=Tc,Tc2D=Tc2D,Tc3D=Tc3D)
    return best, rows

def report(best, label):
    print(f"\n===== {label} =====")
    print(f"  max Tc = {best['Tc']:.1f} K  (room-T target 293.15 K)  -> "
          f"{'>=293 REACHES' if best['Tc']>=293 else 'BELOW room-T'}")
    print(f"  at  g/t={best['g']:.2f}  Ω={best['Om']}meV  t={best['t']}eV  "
          f"W0={best['W0']}eV  ε_F={best['epsF']:.3f}eV  Eb={best['Eb']:.3f}eV")
    print(f"      Z_FC={best['zfc']:.3e}  (1-Uχ) via Uχ={best['Uchi']}  "
          f"D_s={best['Ds']:.4f}eV   [Tc2D={best['Tc2D']:.0f} Tc3D={best['Tc3D']:.0f}]")

if __name__ == "__main__":
    print("press_all_sumrule.py — FREE local numpy synthesis (d6 honest, TB/analytic-grade)")
    print(f"ALPHA13 (D_s ≤ ALPHA13·ε_F) = {ALPHA13:.5f}")
    print(f"room-T needs D_s ≥ {kB*T_ROOM/(np.pi/2):.4f} eV (2D-BKT) "
          f"or {kB*T_ROOM/2.2:.4f} eV (3D-XY)")
    print(f"  => via L13, room-T needs ε_F ≥ {kB*T_ROOM/(np.pi/2)/ALPHA13:.3f} eV (2D) "
          f"/ {kB*T_ROOM/2.2/ALPHA13:.3f} eV (3D)")

    bestA, rowsA = scan(coupled_epsF=False)   # (A) separable
    bestB, rowsB = scan(coupled_epsF=True)    # (B) one sum rule (L9-coupled ε_F)
    report(bestA, "(A) SEPARABLE  — faces treated as independent penalties, ε_F free/wide")
    report(bestB, "(B) ONE-SUM-RULE — L9 ties ε_F=ε_F(g,Ω): strong glue narrows the band")

    # The decisive diagnostic: in (A), CAN we simultaneously satisfy all four loosely?
    # find the interior feasible point with the LEAST-bad worst-margin (multi-objective)
    print("\n===== DECISIVE: is there a feasible interior point ≥293K? =====")
    feasA = [r for r in rowsA if max(r['Tc2D'],r['Tc3D'])>=293]
    feasB = [r for r in rowsB if max(r['Tc2D'],r['Tc3D'])>=293]
    print(f"  (A) separable : #points ≥293K = {len(feasA)} / {len(rowsA)}")
    print(f"  (B) coupled   : #points ≥293K = {len(feasB)} / {len(rowsB)}")
    if feasA:
        # among separable-feasible, what ε_F do they demand? is it physical for a
        # LIGHT (Ω≥100meV) off-diagonal host?  print the coordinate envelope
        eps_needed = [r['epsF'] for r in feasA]
        g_used     = [r['g'] for r in feasA]
        print(f"     separable-feasible demand: ε_F ∈ [{min(eps_needed):.2f},{max(eps_needed):.2f}] eV, "
              f"g/t ∈ [{min(g_used):.2f},{max(g_used):.2f}]")
    # WHICH inequality binds at the optimum of (B)?
    b=bestB
    margins = dict(
        L13_epsF = b['epsF'] - (kB*T_ROOM/2.2/ALPHA13),     # need ε_F ≥ this; negative => binds
        L14_ZFC  = b['zfc'] - 0.3,                            # want Z_FC not tiny
        L15_avail= (1-b['Uchi']) - 0.1,
        binding  = b['Eb'] - 0.05)
    print(f"\n  Binding inequality at (B)-optimum (negative = THIS WALL binds):")
    for k,v in margins.items():
        print(f"    {k:10s} margin = {v:+.3f}   {'<-- BINDS' if v<0 else ''}")
