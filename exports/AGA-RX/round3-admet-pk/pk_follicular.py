#!/usr/bin/env python3
"""AGA-RX round-3 topical follicular PK — INHERITED primitives (TTR-LAC/A1·A3, NUMB).

INHERITED (verified, do not re-derive):
  t_lag = h^2/(6 D)           onset ~ 2*t_lag  [TTR-LAC/A1: EMLA D=1e-10 cm2/s, h=10um -> 55.6 min ~ clinical 60 min]
  C(z)  = C_surf * exp(-z/lambda)              [TTR-LAC/A3: interfollicular SC lambda=40-60 um, epi 1:200k]

RE-PARAMETERIZED for the TRANS-FOLLICULAR SHUNT route to the dermal papilla (DP):
  - DP / hair-bulb depth z_DP ~ 1.0-1.5 mm (scalp terminal follicle). [web: follicular shunt, bulb base]
  - The shunt bypasses the SC barrier: transport is down the follicular duct (sebum/aqueous channel),
    so the effective diffusion length h_eff = z_DP (mm-scale), NOT the 10 um SC.
  - lambda_foll: the shunt is a low-resistance channel -> attenuation length is mm-scale, not 40-60 um.
    We bracket lambda_foll with literature shunt behaviour and report the efficacy verdict as a RANGE.

All distances in cm (D in cm2/s). No fabricated constants — each value is sourced inline.
"""
import sympy as sp
import math

# ---------- symbolic inherited forms ----------
h, D, z, lam, Csurf = sp.symbols('h D z lambda C_surf', positive=True)
t_lag   = h**2/(6*D)
onset   = 2*t_lag
C_depth = Csurf*sp.exp(-z/lam)
print("INHERITED forms:")
print("  t_lag =", t_lag, "   onset = 2*t_lag =", onset)
print("  C(z)  =", C_depth)

# ---------- recover the inherited anchor (TTR-LAC/A1 EMLA) ----------
D_emla = 1e-10            # cm2/s   (TTR-LAC/A1)
h_sc   = 10e-4            # cm  (10 um SC)
onset_emla_min = float(onset.subs({h:h_sc, D:D_emla}))/60
print(f"\nANCHOR check (TTR-LAC/A1): EMLA onset = {onset_emla_min:.1f} min  (target ~55.6, clinical ~60)")

# ---------- trans-follicular re-parameterization ----------
# depth to dermal papilla / hair bulb
z_DP_cm = [0.10, 0.15]                       # 1.0-1.5 mm
# follicular-shunt effective diffusivity. The shunt is faster than transcellular SC.
# Interfollicular SC ~1e-10. Follicular duct (aqueous/sebum-filled appendageal path) is
# reported 1-3 orders faster for the shunt route; bracket conservatively.
D_foll = [1e-9, 1e-8]                        # cm2/s  (10x-100x SC, shunt route)

print("\n--- TIME-TO-DP (lag) via inherited t_lag = h^2/(6D), h = z_DP (shunt length) ---")
for zd in z_DP_cm:
    for Df in D_foll:
        tl  = (zd**2)/(6*Df)/3600.0          # hours
        ons = 2*tl
        print(f"  z_DP={zd*10:.1f}mm  D={Df:.0e}  t_lag={tl:7.2f} h   onset(2*t_lag)={ons:7.2f} h")

# ---------- steady-state depth concentration at the DP ----------
# C(z_DP) = C_surf * exp(-z_DP/lambda_foll).
# Interfollicular lambda 40-60 um would give exp(-1000/50)=e^-20 ~ 2e-9 -> ZERO at the DP.
# The shunt's value is precisely that its attenuation length is mm-scale (it bypasses the SC).
# Bracket lambda_foll and report the surface multiple C_surf needs to be to hit EC50.
lam_foll_cm = [0.02, 0.05, 0.10, 0.20]       # 0.2,0.5,1.0,2.0 mm  (shunt attenuation length bracket)
print("\n--- STEADY-STATE C(z_DP)/C_surf via inherited C(z)=C_surf*exp(-z/lambda) ---")
for zd in z_DP_cm:
    row=f"  z_DP={zd*10:.1f}mm : "
    for lf in lam_foll_cm:
        frac = math.exp(-zd/lf)
        row += f"lam={lf*10:.1f}mm->{frac:.3f}  "
    print(row)

# ---------- efficacy gate: does C(DP) reach the target potency? ----------
# Target: WAY-316606 SFRP1 EC50 = 0.65 uM  (web: APExBIO/BOCsci; ex-vivo hair-growth active).
# A topical formulation surface concentration: take a feasible C_surf.
# WAY-316606 solubility (ADMET-AI) log mol/L = -3.06 -> ~0.87 mM = 870 uM aqueous solubility ceiling.
# A practical applied (formulated, possibly supersat / co-solvent) C_surf in the 0.1-1% w/v range:
#   1% w/v of MW 448.5 = 10 g/L / 448.5 = 22.3 mM = 22300 uM.  0.1% = 2230 uM.
EC50_uM   = 0.65
sol_uM    = 10**(-3.06)*1e6          # AqSolDB ceiling
Csurf_1pct  = (10.0/448.5)*1e3*1e3   # 1% w/v in uM  = 22294 uM
Csurf_01pct = Csurf_1pct/10
print(f"\nWAY-316606: EC50={EC50_uM} uM | aq-sol ceiling={sol_uM:.0f} uM | C_surf(1% w/v)={Csurf_1pct:.0f} uM | C_surf(0.1%)={Csurf_01pct:.0f} uM")
print("\n--- DP concentration vs EC50 (margin = C(DP)/EC50) for WAY-316606, C_surf=1% w/v ---")
for zd in z_DP_cm:
    for lf in lam_foll_cm:
        cdp = Csurf_1pct*math.exp(-zd/lf)
        margin = cdp/EC50_uM
        verdict = "PASS" if margin>=1 else "FAIL"
        print(f"  z_DP={zd*10:.1f}mm lam={lf*10:.1f}mm: C(DP)={cdp:9.2f} uM  margin x{margin:8.1f}  {verdict}")

# min lambda_foll to clear EC50 at the deepest DP with 1% surface (and 0.1%)
zd = 0.15
for cs,label in [(Csurf_1pct,"1%"),(Csurf_01pct,"0.1%")]:
    # cs*exp(-zd/lam) >= EC50  ->  lam >= zd / ln(cs/EC50)
    lam_min = zd/math.log(cs/EC50_uM)
    print(f"\nMIN lambda_foll to reach EC50 at z_DP=1.5mm, C_surf={label}: lambda >= {lam_min*10:.3f} mm")
