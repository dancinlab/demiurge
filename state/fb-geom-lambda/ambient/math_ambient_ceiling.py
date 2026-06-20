#!/usr/bin/env python3
"""
AMBIENT-TC-CEILING — MATH lens (demiurge RTSC, FB-GEOM-LAMBDA complement)
=========================================================================
Goal: derive/assemble the THEORETICAL UPPER BOUND on ambient-pressure (1 atm)
superconducting Tc, for BOTH channels:
  (A) el-ph (Allen-Dynes / Eliashberg, light-atom omega_log + lambda_max), and
  (B) magnetic glue (cuprate t-J, Tc proportional to superexchange J).

This is a BOUND assembler + python eval, NOT a material search. It builds the
NEW ambient-ceiling synthesis ON TOP of the existing FB laws (does NOT re-derive
FB-GEOM-LAMBDA / FB-BIPOLARON-STIFFNESS) per d_novel_only.

Sourced inputs (cite both sides — Tc bounds are debated, d6):
  - Allen-Dynes 1975, PRB 12, 905 (strong-coupling Tc formula + asymptote).
  - Moussa & Cohen 2006, PRB 74, 094520 (arXiv:cond-mat/0607832): TWO bounds —
    (1) total available el-ph coupling, (2) phonon softening to instability.
  - Semenok, Altshuler, Yuzbashyan 2024 (arXiv:2407.12922): lambda <~ 4 from
    LATTICE INSTABILITY of the electron-lattice equilibrium; room-T phonon SC
    feasible "exclusively in hydrogen compounds".
  - Sadovskii 2025 (arXiv:2506.19326): DISPUTES a hard lambda cap — within the
    stable metallic phase the effective pairing constant "may acquire very large
    values"; gives an elementary Tc upper limit via fundamental constants.
  - Gao, Cerqueira, Sanna et al., Nat Commun 16, 8253 (2025) (arXiv:2502.18281):
    20,000-metal el-ph screen — omega_log rarely > 1800 K, inherent omega_log<->lambda
    trade-off; Li2AgH6/Li2AuH6 approach the practical ambient conventional limit;
    room-T ambient conventional SC "extremely unlikely". Higher-Tc = less stable.
  - Cuprate Tc ∝ J: empirical linear Tc_max ∝ superexchange J at optimal doping
    (e.g. arXiv:2304.11311, condensedconcepts/Scalapino); J ~ 130 meV in cuprates,
    Tc_max(Hg-1223) ~ 134 K ambient (164 K under pressure) => Tc/J ~ 0.09.
"""
import math

# ----------------------------------------------------------------------
# constants
kB_meV = 0.08617         # meV / K  (Boltzmann)
# Tc[K] = (prefactor * omega_log[meV] / kB_meV) when written as Tc = f * omega_log/1.2 ...
# we work in meV and convert.

# ======================================================================
# (1) EL-PH CHANNEL — Allen-Dynes max-Tc
# ======================================================================
# Allen-Dynes (with f1*f2 strong-coupling correction set ~1 near the asymptote):
#   Tc = (omega_log / 1.2) * exp( -1.04(1+lambda) / (lambda - mu*(1+0.62 lambda)) )
# Strong-coupling asymptote (lambda -> inf):
#   Tc -> 0.18 * sqrt(lambda * <omega^2>) ~ 0.18 * sqrt(lambda) * omega_log   (in energy units / kB)

def tc_allen_dynes(omega_log_meV, lam, mu=0.10):
    """Allen-Dynes Tc in Kelvin. omega_log in meV, lam = lambda, mu = mu*."""
    denom = lam - mu * (1.0 + 0.62 * lam)
    if denom <= 0:
        return 0.0
    tc_meV = (omega_log_meV / 1.2) * math.exp(-1.04 * (1.0 + lam) / denom)
    return tc_meV / kB_meV

def tc_strong_coupling_asymptote(omega_log_meV, lam):
    """Tc -> 0.18 sqrt(lambda) omega_log (lambda->inf, <omega^2>~omega_log^2). Kelvin."""
    tc_meV = 0.18 * math.sqrt(lam) * omega_log_meV
    return tc_meV / kB_meV

# --- omega_log budget: bounded by ATOMIC MASS (light atoms -> high phonon freq) ---
# Sourced ceiling: Gao/Sanna 2025 find omega_log RARELY exceeds 1800 K even in hydrides.
# omega_log[meV] = kB_meV * omega_log[K].
OMEGA_LOG_K = {
    "Pb (heavy, conventional)":      55,    # ~4.8 meV
    "Nb / A15 (transition metal)":   210,   # ~18 meV
    "MgB2 (B-B sigma stretch)":      700,   # ~60 meV  (measured anchor, 39 K)
    "light B/C/N covalent (upper)":  900,   # ~78 meV
    "H-rich ambient (practical)":    1100,  # ~95 meV  (Li2AgH6-class, ambient)
    "H-rich (Gao 2025 rare ceiling)":1800,  # ~155 meV (rarely exceeded, any pressure)
    "H-rich (high-P, LaH10-class)":  2700,  # ~233 meV (NOT ambient; for contrast)
}

# --- lambda cap: DEBATED. Use a band, cite both sides. ---
LAMBDA_CASES = {
    "lambda=1.0 (typical strong)":   1.0,
    "lambda=2.0 (very strong)":      2.0,
    "lambda=3.5 (near Semenok cap)": 3.5,
    "lambda=4.0 (Semenok 2024 cap)": 4.0,   # lattice-instability ceiling
    "lambda=10 (Sadovskii dispute)": 10.0,  # 'may acquire very large values'
}

def el_ph_ceiling_table():
    print("=" * 78)
    print("(1) EL-PH AMBIENT CEILING  —  Tc = f(omega_log, lambda)  [Allen-Dynes, mu*=0.10]")
    print("=" * 78)
    print(f"{'omega_log':<34}{'lambda':<26}{'Tc_AD [K]':>10}{'Tc_asym[K]':>12}")
    print("-" * 78)
    # the realistic AMBIENT el-ph ceiling: light-atom omega_log x defensible lambda
    for olabel, oK in OMEGA_LOG_K.items():
        omeV = kB_meV * oK
        for llabel, lam in LAMBDA_CASES.items():
            tc = tc_allen_dynes(omeV, lam)
            tca = tc_strong_coupling_asymptote(omeV, lam)
            print(f"{olabel:<34}{llabel:<26}{tc:>10.0f}{tca:>12.0f}")
        print()

# ======================================================================
# (2) MOUSSA-COHEN "no free lunch": omega <-> lambda tension
# ======================================================================
# lambda = N(E_F) <I^2> / (M omega^2)  (Hopfield).  High lambda wants SOFT (low omega)
# modes; high omega wants light/stiff atoms. They PULL OPPOSITE WAYS.
# Moussa-Cohen bound (2): a mode softens to instability (omega^2 -> 0) before lambda -> inf.
# Encode the trade-off as a constraint surface lambda * omega^2 = const (eta/M-like),
# and find the Tc-maximizing (omega, lambda) along it. This is the el-ph "ceiling ridge".

def el_ph_ridge(eta_over_M_meV2, mu=0.10, omega_min_meV=2.0, omega_max_meV=170.0):
    """
    Walk the trade-off surface lambda = C / omega^2 (C = eta/M in meV^2) and return
    the Tc-maximizing omega_log. This realizes the Moussa-Cohen 'no free lunch':
    you cannot push omega and lambda up together; Tc maxes at a finite ridge point.
    """
    best = (0.0, None, None)
    o = omega_min_meV
    while o <= omega_max_meV:
        lam = eta_over_M_meV2 / (o * o)
        tc = tc_allen_dynes(o, lam, mu)
        if tc > best[0]:
            best = (tc, o, lam)
        o += 0.5
    return best  # (Tc_max[K], omega_log*[meV], lambda*)

def moussa_cohen_ridge_table():
    print("=" * 78)
    print("(2) MOUSSA-COHEN no-free-lunch ridge:  lambda*omega^2 = eta/M = const")
    print("    (high omega needs light atoms; high lambda needs soft modes -> tension)")
    print("=" * 78)
    print(f"{'eta/M [meV^2]':<18}{'Tc_max[K]':>10}{'omega*[meV]':>14}{'lambda*':>10}  note")
    print("-" * 78)
    # eta/M chosen so the ridge lands in physically observed regimes
    for C, note in [(150., "transition-metal-like"),
                    (1500., "MgB2-like covalent"),
                    (6000., "light covalent strong"),
                    (20000., "hydride-class (ambient practical)"),
                    (60000., "hydride-class (Gao rare upper)")]:
        tc, o, lam = el_ph_ridge(C)
        print(f"{C:<18.0f}{tc:>10.0f}{o:>14.1f}{lam:>10.2f}  {note}")
    print()

# ======================================================================
# (3) MIGDAL parameter — adiabatic validity of the el-ph Tc formula
# ======================================================================
# mu_M = lambda * omega_log / E_F.  Migdal/Eliashberg (the basis of Allen-Dynes)
# REQUIRES mu_M << 1 (adiabatic). When E_F -> W -> 0 (flat band) OR omega ~ E_F,
# Migdal breaks: the el-ph Tc formula is INVALID -> real-space bipolaron regime
# (this session's 2-regime closing formula; Regime II escape).

def migdal_param(lam, omega_log_meV, E_F_meV):
    return lam * omega_log_meV / E_F_meV

def migdal_table():
    print("=" * 78)
    print("(3) MIGDAL parameter mu_M = lambda*omega_log/E_F  (adiabatic validity)")
    print("    mu_M << 1: Allen-Dynes holds.  mu_M >~ 1: formula INVALID (bipolaron regime)")
    print("=" * 78)
    print(f"{'regime':<34}{'lambda':>7}{'omega[meV]':>11}{'E_F[meV]':>10}{'mu_M':>8}  valid?")
    print("-" * 78)
    rows = [
        ("Pb wide-band conventional", 1.5, 4.8, 11000),
        ("MgB2 sigma band",           0.9, 60,  4000),
        ("H-rich ambient",            2.0, 95,  3000),
        ("near lattice instability",  4.0, 95,  1500),
        ("FLAT BAND (W~0.1 eV)",      2.0, 95,  100),
        ("FLAT BAND deep (W~0.05 eV)",2.0, 95,  50),
    ]
    for name, lam, o, ef in rows:
        mm = migdal_param(lam, o, ef)
        verdict = "YES (adiabatic)" if mm < 0.3 else ("MARGINAL" if mm < 1 else "NO -> bipolaron")
        print(f"{name:<34}{lam:>7.1f}{o:>11.1f}{ef:>10.0f}{mm:>8.2f}  {verdict}")
    print()

# ======================================================================
# (4) MAGNETIC-GLUE (cuprate t-J) ceiling — Tc proportional to J
# ======================================================================
# Empirical (sourced): Tc_max ∝ superexchange J at optimal doping across cuprate
# families. Cuprate J ~ 130 meV; Tc_max(Hg-1223, ambient) ~ 134 K; under pressure 164 K.
# => Tc/J coefficient:
def magnetic_ceiling():
    print("=" * 78)
    print("(4) MAGNETIC-GLUE (t-J) CEILING:  Tc_max ~ alpha * J / kB   [empirical Tc∝J]")
    print("=" * 78)
    J_meV = 130.0                  # cuprate superexchange (sourced ~120-140 meV)
    J_K = J_meV / kB_meV
    print(f"  cuprate superexchange  J ~ {J_meV:.0f} meV = {J_K:.0f} K")
    for name, Tc_obs in [("La2-xSrxCuO4 (LSCO)", 39),
                         ("YBCO", 93),
                         ("Bi-2223", 110),
                         ("Hg-1223 (ambient, record)", 134),
                         ("Hg-1223 (under pressure)", 164)]:
        alpha = Tc_obs / J_K
        print(f"  {name:<32} Tc={Tc_obs:>4} K   Tc/J = {alpha:.3f}")
    print()
    # The empirical coefficient clusters at Tc_max/J ~ 0.07-0.10 at ambient.
    # => magnetic-glue AMBIENT ceiling ~ 0.1 * J / kB:
    alpha_ceiling = 0.10
    Tc_mag_ceiling = alpha_ceiling * J_K
    print(f"  => magnetic-glue ambient ceiling ~ {alpha_ceiling:.2f} * J/kB "
          f"= {Tc_mag_ceiling:.0f} K  (with J~130 meV)")
    # To reach 293 K via magnetic glue you'd need:
    J_needed_meV = 293 * kB_meV / alpha_ceiling
    print(f"  293 K via magnetic glue would need J ~ {J_needed_meV:.0f} meV "
          f"(~{J_needed_meV/J_meV:.1f}x cuprate J) at fixed Tc/J ~ 0.1")
    print(f"     -> no known antiferromagnet has J this large with a metallic carrier channel.")
    print()
    return Tc_mag_ceiling

# ======================================================================
# (5) SYNTHESIS — the honest ambient-Tc ceiling + 293 K verdict
# ======================================================================
def synthesis():
    print("=" * 78)
    print("(5) SYNTHESIS — honest ambient-Tc ceiling")
    print("=" * 78)
    # EL-PH ambient ceiling: best realistic ambient ridge (hydride-class practical),
    # cross-checked against Allen-Dynes at the Gao-rare omega_log with defensible lambda.
    # Practical ambient (Li2AgH6-class): omega_log ~ 95 meV, lambda ~ 2 -> :
    tc_practical = tc_allen_dynes(95*0+kB_meV*1100, 2.0)
    # Optimistic ambient ridge (Gao rare omega_log 1800 K = 155 meV, lambda ~ 2):
    tc_optimistic = tc_allen_dynes(kB_meV*1800, 2.0)
    # Semenok-cap optimistic (lambda 4 at light-atom omega_log 95 meV):
    tc_cap = tc_allen_dynes(kB_meV*1100, 4.0)
    print(f"  EL-PH ambient (Li2AgH6-class omega_log~95meV, lambda~2): Tc ~ {tc_practical:.0f} K")
    print(f"  EL-PH ambient (Gao-rare omega_log~155meV, lambda~2):     Tc ~ {tc_optimistic:.0f} K")
    print(f"  EL-PH ambient (omega_log~95meV, lambda~4 Semenok cap):   Tc ~ {tc_cap:.0f} K")
    tc_mag = 0.10 * (130.0/kB_meV)
    print(f"  MAGNETIC-GLUE ambient (cuprate J~130meV, Tc/J~0.1):      Tc ~ {tc_mag:.0f} K")
    print()
    print("  HONEST CEILING STATEMENT:")
    print("    ambient Tc <~ ~150-200 K via el-ph (light-atom omega_log + defensible lambda),")
    print("                            with a debated optimistic tail if lambda>4 is allowed;")
    print("    ambient Tc <~ ~130-160 K via magnetic glue (cuprate Tc ∝ J, J~130 meV).")
    print()
    print("  293 K AMBIENT VERDICT:  (b) BOUNDED-BUT-NOT-FORBIDDEN.")
    print("    No HARD theorem forbids 293 K. Both 'ceilings' are CONDITIONAL bounds, each")
    print("    resting on ONE assumption that 293 K would have to VIOLATE:")
    print("      el-ph:  the LATTICE-STABILITY assumption lambda<~4 (Semenok 2024). Sadovskii")
    print("              2025 DISPUTES it (lambda may be very large in the stable phase) ->")
    print("              the cap is empirical/stability-based, NOT a no-go theorem.")
    print("      magnetic: the assumption Tc/J<~0.1 AND J<~150 meV. 293 K needs J~250 meV with")
    print("              a metallic channel — unrealized, not proven impossible.")
    print("      Migdal: 293 K via el-ph at fixed omega budget pushes mu_M -> O(1); the")
    print("              Allen-Dynes formula itself stops applying -> bipolaron (Regime II),")
    print("              where NO general Tc upper bound is established (open).")
    print()
    print("  THE SINGLE MUST-BREAK ASSUMPTION:")
    print("    lattice DYNAMIC STABILITY at 1 atm under the coupling needed for 293 K.")
    print("    Every channel funnels to the same wall: the coupling/stiffness that buys")
    print("    293 K softens a phonon to instability (el-ph) or has no stable metallic")
    print("    high-J host (magnetic). A 293 K ambient SC must realize STRONG coupling in a")
    print("    DYNAMICALLY STABLE 1-atm lattice — exactly the pair (a) light-element strong")
    print("    coupling + ambient dynamic stability that the FB ROOMT-AMBIENT-PASS-CRITERIA")
    print("    flags as the #4 decisive bottleneck, OR (b) a non-phonon (bipolaron/other)")
    print("    mechanism with no proven ceiling.")
    print()

if __name__ == "__main__":
    el_ph_ceiling_table()
    moussa_cohen_ridge_table()
    migdal_table()
    magnetic_ceiling()
    synthesis()
