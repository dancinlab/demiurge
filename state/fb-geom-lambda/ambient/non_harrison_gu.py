#!/usr/bin/env python3
"""
NON-HARRISON g(u) PROBE — the last genuinely-open physical question of the RTSC
ambient bond-bipolaron lane (d2 wall-breakthrough on the 9th law).

9th law STIFF-BOND-WEAK-SSH-BINDING assumes the HARRISON law:
    t(d) = C / d^2           (covalent two-center, Harrison solid-state-table)
    => dt/du = -2 t / d       (linear, evaluated at equilibrium bond length d)
    => g = (dt/du) u0,  u0 = sqrt(hbar / (2 M Omega))   (zero-point amplitude)
    => g/t = 2 u0 / d   (HARRISON g/t — fixed by zero-point/bond-length ratio)
And u0/d ∝ 1/sqrt(M Omega) d -> g/t ∝ 1/sqrt(Omega) at fixed bond geometry,
which is what closes the room-T escape (need g/t >~ 1.2 for a bound light bipolaron,
but stiff high-Omega bonds give g/t ~ 0.05-0.11).

THIS PROBE: is there a NON-Harrison, anomalous SUPER-LINEAR dt/du from special
bond chemistry that beats 2u0/d enough to reach g/t >~ 1.2 at a stiff/light bond?
And does the same instability that gives super-linear g also destroy the metal?

Three candidate classes (arxiv-grounded):
  C1  negative-U / Peierls-SSH critical point (dimerization inflection)
  C2  charge-transfer / covalent-ionic crossover (negative charge-transfer, oxygen holes)
  C3  lone-pair s^2 breathing (bismuthate BaBiO3 / Tl perovskite family)

Pure numpy, no pod. Order-of-magnitude bond-chemistry estimates; the SIGN is the deliverable.
"""
import numpy as np, json

HBAR = 1.054571817e-34
EV   = 1.602176634e-19
AMU  = 1.66053907e-27
ANG  = 1e-10

def u0_zpt(M_amu, Omega_meV):
    """zero-point rms amplitude (Angstrom) of an Einstein mode."""
    M = M_amu*AMU; Om = Omega_meV*1e-3*EV/HBAR
    return np.sqrt(HBAR/(2*M*Om))/ANG

def harrison_g_over_t(u0_A, d_A):
    """Harrison covalent: g/t = 2 u0 / d."""
    return 2.0*u0_A/d_A

# ----------------------------------------------------------------------------
# Reference bond / mode parameters for a STIFF LIGHT covalent bond
# (the regime the 9th law lives in: high Omega so harmonic g/t is small).
# anchor it to the BK-borophene terminal: per-bond g/t = 0.057 (Harrison).
# ----------------------------------------------------------------------------
REF = dict(d=1.65, M=11.0, Omega=160.0)  # B-B-like: d~1.65A, M~11, Omega 160 meV
u0  = u0_zpt(REF['M'], REF['Omega'])
gt_harrison = harrison_g_over_t(u0, REF['d'])
THRESH = 1.20  # 2-body bond-bipolaron binding threshold g*/t (campaign anchor)

print(f"REF stiff-light bond: d={REF['d']}A M={REF['M']} Omega={REF['Omega']}meV")
print(f"  u0(zpt)={u0:.4f} A,  Harrison g/t = 2u0/d = {gt_harrison:.4f}")
print(f"  binding threshold g*/t = {THRESH}, Harrison shortfall = {THRESH/gt_harrison:.1f}x")
print()

# ----------------------------------------------------------------------------
# SUPER-LINEARITY FACTOR S = (dt/du)_actual / (dt/du)_Harrison
# For each class we estimate S from the bond chemistry, AT a displacement u ~ u0
# (zero-point), because g is sampled at the zero-point amplitude, NOT at the
# instability point itself. This is the crux: the divergence of dt/du lives AT
# u_c (the dimerization/disproportionation displacement), but the relevant g
# samples dt/du at u~u0, a finite distance BEFORE u_c.
# ----------------------------------------------------------------------------

def superlinear_factor_inflection(u0_A, uc_A, p=2.0):
    """
    C1 model: t(u) has an inflection at the dimerization point u_c.
    Generic soft-mode / Landau form near a 2nd-order Peierls point:
        t(u) = t0 * (1 - (u/uc)^?) ... the hopping ASYMMETRY (bond alternation)
    For a Peierls/SSH soft phonon the hopping modulation is to LEADING order
    STILL LINEAR (g1 u); the 'divergence' is in the PHONON SUSCEPTIBILITY
    (omega_soft -> 0), NOT in dt/du itself. dt/du = -2t/d stays Harrison.
    The genuine non-linearity enters as a higher-order g2 u^2 term whose
    coefficient grows as the inflection sharpens:
        t(u) = t0 - g1 u - (1/2) g2 u^2,  g2/g1 ~ 1/(uc - u)  near uc.
    Super-linear factor at sampling amplitude u0:
        S = 1 + (g2/g1) u0 = 1 + u0/(uc - u0).
    As uc -> u0 (right at the edge) S diverges, BUT see metal_survives().
    """
    return 1.0 + u0_A/max(uc_A - u0_A, 1e-6)

def superlinear_factor_crossover(u0_A, w_A):
    """
    C2 / C3 model: covalent<->ionic (or s^2 lone-pair s0<->s2) crossover.
    The hopping t_eff between two orbitals that switch character is a
    LEVEL-CROSSING / avoided-crossing function of the bond coordinate:
        t_eff(u) = t_bare * Delta / sqrt(Delta^2 + (alpha u)^2)   (charge-transfer
        admixture), OR a smoothed step of width w in the crossover region.
    Near the crossover the slope dt/du is set by 1/w (crossover width), which can
    be MUCH steeper than the Harrison 2t/d when w << d. Model the local slope ratio
    as S = d / (pi w)  (the avoided-crossing tanh has max slope ~ 1/w, Harrison ~ 1/d).
    """
    return REF['d']/(np.pi*w_A)

def metal_survives(uc_A, u0_A, gap_meV_at_uc=None):
    """
    The instability-vs-metal tension. The super-linear S is only USABLE if the
    bond does NOT freeze/dimerize/gap at the relevant filling+temperature, i.e.
    there is a window where u0 < uc (zero-point amplitude does not reach the
    dimerization point) AND the static distortion is zero (metal, no static CDW).
    Returns the dimensionless margin (uc-u0)/u0 ; >0 means a metallic window exists,
    but small margin means strong CDW fluctuations / proximity to the gap.
    """
    return (uc_A - u0_A)/u0_A

# ----------------------------------------------------------------------------
# CLASS ESTIMATES
# ----------------------------------------------------------------------------
results = {"ref": dict(REF, u0=u0, gt_harrison=gt_harrison, thresh=THRESH), "classes": {}}

# --- C1: negative-U / SSH-Peierls critical (polyacetylene, CDW-edge metals) ---
# Real bond alternation in polyacetylene: u_dimerization ~ 0.03-0.04 A.
# Zero-point u0 of the C-C stretch (~0.05-0.06 A for Omega~150-200meV, but the
# RELEVANT soft Peierls mode is much softer). Take uc = 0.10 A (dimerized bond
# offset at the Peierls gap) so the metal sits a finite distance before it.
for label, uc in [("just-before (uc=2.5 u0)", 2.5*u0),
                  ("near-edge (uc=1.5 u0)", 1.5*u0),
                  ("at-edge (uc=1.1 u0)", 1.1*u0)]:
    S = superlinear_factor_inflection(u0, uc)
    margin = metal_survives(uc, u0)
    gt = gt_harrison*S
    results["classes"].setdefault("C1_negU_SSH_critical", []).append(
        dict(window=label, uc_A=round(uc,4), S=round(S,3),
             gt=round(gt,4), metal_margin=round(margin,3),
             reaches_1p2=bool(gt>=THRESH)))

# --- C2: charge-transfer / covalent-ionic crossover (negative-charge-transfer) ---
# crossover width w: for a sharp covalent<->ionic flip w ~ 0.1-0.3 A (a few % of d).
for label, w in [("broad (w=0.30A)",0.30),("moderate (w=0.15A)",0.15),
                 ("sharp (w=0.08A)",0.08),("ultra-sharp (w=0.04A)",0.04)]:
    S = superlinear_factor_crossover(u0, w)
    gt = gt_harrison*S
    # the crossover is itself an instability: if it is sharp it triggers
    # charge disproportionation (a static CDW). model the static-distortion
    # onset as proportional to S (sharper crossover -> stronger CDW tendency).
    # heuristic: metal survives only if S * gt_harrison < ~ a static-CDW order
    # parameter onset. encode as a 'CDW pressure' = S (dimensionless).
    cdw_pressure = S
    results["classes"].setdefault("C2_charge_transfer_crossover", []).append(
        dict(window=label, w_A=w, S=round(S,3), gt=round(gt,4),
             cdw_pressure=round(cdw_pressure,2),
             reaches_1p2=bool(gt>=THRESH)))

# --- C3: lone-pair s^2 breathing (bismuthate / Tl) — anchored to DFT lambda ---
# Bismuthate breathing mode is modeled (npj CompMat 2023; Sci.Direct 2024) as a
# Bi-O HOPPING MODULATION (off-diagonal) with lambda ~ 0.89, Omega(breathing) ~ 60-70 meV.
# Extract an effective g/t from lambda: for an Einstein bond mode,
#   lambda = 2 g^2 N(0) / Omega ... but in the bond-Peierls convention the campaign
# uses g/t directly. Convert via the campaign's own anchor: the BBO geometric audit
# found <tr g>(BBO)=0.0465 (bismuthate_FINDINGS) — i.e. measured off-diagonal g is
# SMALL, comparable to Harrison, NOT super-linearly enhanced.
# Here we ask: does the s^2 lone-pair make dt/du super-linear vs Harrison?
# DFT anchor: bismuthate Omega ~ 65 meV (SOFT, not stiff!) and d(Bi-O)~2.2A, M(O)=16.
bbo = dict(d=2.20, M=16.0, Omega=65.0)
u0_bbo = u0_zpt(bbo['M'], bbo['Omega'])
gt_harr_bbo = harrison_g_over_t(u0_bbo, bbo['d'])
# campaign-measured off-diagonal g/t for BBO (geometric audit): ~0.0465
gt_measured_bbo = 0.0465
S_bbo = gt_measured_bbo/gt_harr_bbo
results["classes"]["C3_lonepair_s2_breathing"] = dict(
    d_A=bbo['d'], M=bbo['M'], Omega_meV=bbo['Omega'],
    u0_A=round(u0_bbo,4), gt_harrison=round(gt_harr_bbo,4),
    gt_measured_audit=gt_measured_bbo, S_vs_harrison=round(S_bbo,3),
    note="Omega SOFT (65meV) not stiff; even with S, soft mode fails box criterion-2 (Omega>=160meV)",
    reaches_1p2=bool(gt_measured_bbo>=THRESH),
    # the deciding tension: BBO gaps (CDW insulator) at half-filling; metal needs K-doping
    # which dilutes the breathing coupling; and Omega is soft -> 1/sqrt(Omega) is the WRONG
    # direction for the box (need stiff for ambient/light bipolaron).
    metal_only_when_doped_away_from_CDW=True)

# ----------------------------------------------------------------------------
# THE WINDOW TEST: can ANY class hold g/t>=1.2 AND metal_margin>0 AND stiff (Omega>=160)?
# ----------------------------------------------------------------------------
print("="*78)
print("C1 negative-U / SSH-Peierls critical (inflection super-linearity):")
for r in results["classes"]["C1_negU_SSH_critical"]:
    flag = "REACHES 1.2" if r["reaches_1p2"] else f"short {THRESH/r['gt']:.1f}x"
    print(f"  {r['window']:24s} S={r['S']:6.2f} g/t={r['gt']:.3f} "
          f"metal_margin={r['metal_margin']:+.2f} -> {flag}")
print()
print("C2 charge-transfer / covalent-ionic crossover (avoided-crossing slope):")
for r in results["classes"]["C2_charge_transfer_crossover"]:
    flag = "REACHES 1.2" if r["reaches_1p2"] else f"short {THRESH/r['gt']:.1f}x"
    print(f"  {r['window']:22s} S={r['S']:6.2f} g/t={r['gt']:.3f} "
          f"CDW_pressure={r['cdw_pressure']:.1f} -> {flag}")
print()
c3=results["classes"]["C3_lonepair_s2_breathing"]
print("C3 lone-pair s^2 breathing (bismuthate DFT anchor):")
print(f"  Omega={c3['Omega_meV']}meV(SOFT) g/t_harrison={c3['gt_harrison']:.3f} "
      f"g/t_measured={c3['gt_measured_audit']} S={c3['S_vs_harrison']} -> "
      f"{'REACHES 1.2' if c3['reaches_1p2'] else 'short '+f'{THRESH/c3['gt_measured_audit']:.0f}x'}")
print()

# ----------------------------------------------------------------------------
# THE DEEP TENSION quantified: super-linear S requires proximity (uc->u0 or w->0),
# but proximity drives the static distortion (CDW gap). Define a JOINT figure:
#   g/t(S) must exceed 1.2  WHILE  the static order parameter Delta_static = 0.
# For C1: Delta_static turns on when u0 >= uc, i.e. metal_margin <= 0.
#   S(metal_margin) = 1 + 1/metal_margin  -> g/t = gt_harrison*(1+1/margin).
#   set g/t = 1.2 -> required margin:
req_S = THRESH/gt_harrison
req_margin_C1 = 1.0/(req_S-1.0)
print("="*78)
print("JOINT WINDOW (C1): to hit g/t=1.2 need S=%.1f -> metal_margin=%.3f" %
      (req_S, req_margin_C1))
print("  i.e. uc must be only %.1f%% beyond u0 (zero-point reaches %.0f%% of the way"
      " to dimerization)." % (req_margin_C1*100, 100/(1+req_margin_C1)))
print("  => zero-point bond fluctuation is ~%.0f%% of the dimerization displacement"
      " -> dynamic CDW / bond freezes; no stable metal." % (100/(1+req_margin_C1)))
results["joint_window_C1"] = dict(required_S=round(req_S,2),
    required_metal_margin=round(req_margin_C1,4),
    zpt_fraction_of_uc=round(1/(1+req_margin_C1),3),
    verdict="margin so small the zero-point motion itself reaches the dimerization point -> no metal")

# For C2: same logic — required S = req_S -> required width w = d/(pi*req_S)
req_w_C2 = REF['d']/(np.pi*req_S)
print("\nJOINT WINDOW (C2): to hit g/t=1.2 need S=%.1f -> crossover width w=%.3f A"
      " (=%.1f%% of bond)." % (req_S, req_w_C2, 100*req_w_C2/REF['d']))
print("  a crossover sharper than ~%.2fA = a charge-disproportionation step ="
      " a static CDW insulator (the bismuthate gap)." % req_w_C2)
results["joint_window_C2"] = dict(required_S=round(req_S,2),
    required_width_A=round(req_w_C2,4),
    pct_of_bond=round(100*req_w_C2/REF['d'],2),
    verdict="width that sharp = a disproportionation step = CDW gap, not a metal")

# ----------------------------------------------------------------------------
# VERDICT
# ----------------------------------------------------------------------------
any_escape = (any(r["reaches_1p2"] for r in results["classes"]["C1_negU_SSH_critical"]
                  if r["metal_margin"]>0.5)  # require a REAL metallic window
              or any(r["reaches_1p2"] for r in results["classes"]["C2_charge_transfer_crossover"]
                     if r["cdw_pressure"]<3.0)
              or results["classes"]["C3_lonepair_s2_breathing"]["reaches_1p2"])
results["verdict"] = ("REOPENS" if any_escape else "CLOSES")
print("\n"+"="*78)
print("VERDICT: non-Harrison super-linear g(u) escape ->",
      "REOPENS" if any_escape else "CLOSES (instability tension generalizes 9th law)")

with open("non_harrison_gu_results.json","w") as f:
    json.dump(results,f,indent=2)
print("wrote non_harrison_gu_results.json")
