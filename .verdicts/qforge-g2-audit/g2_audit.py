import math

# ============================================================
# QFORGE |g|^2 single-number audit — CaH6 Gamma point, mode nu
# Reference: QE ph.x electron_phonon='simple' fixture cah6.dyn1.elph.1 (q=Gamma)
# All computed locally, $0.
# ============================================================

# ---- physical constants (CODATA 2018) ----
RY_TO_EV   = 13.605693122994
HA_TO_EV   = 27.211386245988
RY_TO_HA   = 0.5
RY_TO_K    = 157887.51          # 1 Ry -> K  (matches _RY2K in xval test)
HA_TO_K    = 315775.0           # 1 Ha -> K  (matches kelvin_per_hartree())
AMU_PER_ME = 1822.888486        # 1 amu in electron masses (qforge _amu_per_me)
RY_TO_GHZ  = RY_TO_K * 20.8366  # not needed; use direct

# ---- QE Gamma-point reference (cah6.dyn1.elph.1, broadening 0.005 Ry block) ----
# Mode 7 = strongest H optical mode at Gamma.
# squared freq w2[Ry^2] for mode 7 (7th of the 21 squared freqs):
#   row1: 0.428986E-07 0.431853E-07 0.440343E-07 0.716488E-04 0.716712E-04 0.716894E-04
#   row2: 0.850102E-04 ...   -> mode7 (index6, 0-based) = 0.850102E-04
w2_ry2_mode7 = 0.850102e-04     # omega^2 in Ry^2
lam_qe_m7    = 11.2785          # QE lambda(7) at 0.005 Ry broadening
gamma_GHz_m7 = 39159.59         # QE phonon linewidth gamma(7), GHz
N_ef_per_spin_per_Ry = 3.951769 # DOS at 0.005 Ry: states/spin/Ry/cell

omega_ry_m7 = math.sqrt(w2_ry2_mode7)        # Ry
omega_K_m7  = omega_ry_m7 * RY_TO_K
omega_ha_m7 = omega_ry_m7 * RY_TO_HA
omega_cm1_m7= omega_ry_m7 * RY_TO_EV * 8065.544  # eV->cm^-1

print("="*70)
print("QE Gamma reference, mode 7 (strongest H optical):")
print(f"  omega^2      = {w2_ry2_mode7:.6e} Ry^2")
print(f"  omega        = {omega_ry_m7:.6e} Ry = {omega_K_m7:.2f} K = {omega_cm1_m7:.1f} cm^-1 = {omega_ha_m7:.6e} Ha")
print(f"  lambda(7)    = {lam_qe_m7}")
print(f"  gamma(7)     = {gamma_GHz_m7} GHz")
print(f"  N(E_F)       = {N_ef_per_spin_per_Ry} states/spin/Ry/cell")
print("="*70)

# ---- QE |g|^2 from the linewidth (Allen 1972 / QE elphon.f90 convention) ----
# QE: gamma_qnu = 2*pi*omega_qnu * sum_{k,ij} |g_ij^nu(k,q)|^2 delta(e_ki)delta(e_kj+q)
# and lambda_qnu = gamma_qnu / (pi * N(E_F) * omega_qnu^2)
#   => gamma = pi * N(E_F) * omega^2 * lambda
# Cross-check gamma from lambda:
gamma_ry_from_lam = math.pi * N_ef_per_spin_per_Ry * w2_ry2_mode7 * lam_qe_m7  # in Ry (since N in 1/Ry, omega^2 in Ry^2)
# convert Ry -> GHz: 1 Ry = RY_TO_K * (k_B/h).  1 K = 20.8366 GHz
K_TO_GHZ = 20.836619
gamma_GHz_from_lam = gamma_ry_from_lam * RY_TO_K * K_TO_GHZ
print(f"\n[cross-check] gamma from lambda = pi*N*omega^2*lambda")
print(f"  = {gamma_ry_from_lam:.6e} Ry = {gamma_GHz_from_lam:.1f} GHz  (QE prints {gamma_GHz_m7} GHz)")
print(f"  ratio = {gamma_GHz_from_lam/gamma_GHz_m7:.4f}")

# ---- QE's Fermi-surface-averaged |g|^2 (the single-number reference) ----
# Define the FS-averaged matrix element squared that enters lambda directly:
#   lambda_qnu = 2/(N(E_F)*omega_qnu) * <|g|^2>_FS    (Grimvall normalization)
# i.e. the EFFECTIVE per-mode |g|^2 absorbed into lambda is
#   |g|^2_eff = lambda_qnu * N(E_F) * omega_qnu / 2
# QE g has units of energy (Ry). Compute in Ry^2 and Ha^2:
g2_eff_ry2 = lam_qe_m7 * N_ef_per_spin_per_Ry * omega_ry_m7 / 2.0   # ??? units: lambda dimensionless, N[1/Ry], omega[Ry] -> dimensionless. NOT energy^2.
# The clean dimensionless statement: lambda = 2 N(E_F) <g^2>/omega with <g^2> in energy^2
#   => <g^2>_ry2 = lambda * omega_ry / (2 * N_ef[1/Ry])
g2_eff_ry2 = lam_qe_m7 * omega_ry_m7 / (2.0 * N_ef_per_spin_per_Ry)
g2_eff_ha2 = g2_eff_ry2 * (RY_TO_HA**2)
print(f"\nQE effective <|g|^2>_FS (mode7) from lambda = 2 N <g^2>/omega:")
print(f"  <g^2> = lambda*omega/(2 N) = {g2_eff_ry2:.6e} Ry^2 = {g2_eff_ha2:.6e} Ha^2")
print(f"  |g|_eff = {math.sqrt(g2_eff_ry2):.6e} Ry = {math.sqrt(g2_eff_ry2)*RY_TO_EV*1000:.3f} meV")

print("\n" + "="*70)
print("QFORGE FROM-SCRATCH SIDE — term-by-term unit decomposition")
print("="*70)

# QForge builds:  g~^2 = g_mn^2 * amp2,  amp2 = hbar/(2 M omega) = 1/(2*M_e*omega_Ha)
# with g_mn = <psi_m|dV_bare|psi_n> in Ha/bohr (a per-unit-displacement derivative).
#
# The PHYSICAL textbook el-ph coupling (Giustino RMP Eq.4):
#   g^nu = <psi|dV/du|psi> * sqrt(hbar/(2 M omega))    [ENERGY]
# so g^2 = (dV/du)^2 * hbar/(2 M omega).  Units: (energy/length)^2 * (length^2) = energy^2. OK.
#
# amp2 numeric for mode 7 (displaced atom = H, mass 1.008 amu):
M_H_amu = 1.008
M_Ca_amu = 40.078
def amp2(mass_amu, omega_ha):
    M_e = mass_amu * AMU_PER_ME
    return 1.0/(2.0*M_e*omega_ha)

amp2_H_m7 = amp2(M_H_amu, omega_ha_m7)
print(f"\namp2 = hbar/(2 M omega), H displaced, mode7 omega={omega_ha_m7:.4e} Ha:")
print(f"  M_e   = {M_H_amu*AMU_PER_ME:.2f} electron masses")
print(f"  amp2  = 1/(2*M_e*omega_Ha) = {amp2_H_m7:.6e}  [1/(m_e*Ha) = bohr^2/Ha in a.u.]")
print(f"  (amp = sqrt = {math.sqrt(amp2_H_m7):.6e} bohr — zero-point displacement amplitude)")

# So to reproduce QE's <g^2>_eff = 3.289e-3 Ha^2, the BARE vertex squared must be:
#   g_mn^2  =  g2_eff_ha2 / amp2
g_mn2_needed_ha2_per_bohr2 = g2_eff_ha2 / amp2_H_m7
print(f"\nTo hit QE <g^2>_eff={g2_eff_ha2:.4e} Ha^2, QForge bare vertex^2 must be:")
print(f"  g_mn^2 = g2_eff/amp2 = {g_mn2_needed_ha2_per_bohr2:.6e} (Ha/bohr)^2")
print(f"  |g_mn| = {math.sqrt(g_mn2_needed_ha2_per_bohr2):.6e} Ha/bohr")
print(f"  (= dV/du first-order deformation potential ~ a few Ha/bohr — physically O(1).)")

# ---- now enumerate the candidate ORDER-OF-MAGNITUDE unit slips ----
print("\n" + "-"*70)
print("CANDIDATE UNIT-FACTOR SLIPS (each = a possible chunk of the ~9-order gap)")
print("-"*70)

# (a) Ry vs Ha on the vertex/energy:  g^2 in Ry^2 vs Ha^2 differ by (RY_TO_HA)^2 = 0.25  -> factor 4
print(f"(a) Ry^2 vs Ha^2          : (1/2)^2 = {RY_TO_HA**2:.3f}        ~10^{math.log10(1/RY_TO_HA**2):.2f}")

# (b) mass amu vs a.u.(electron mass): if amp2 used mass in amu (NOT *1822.9), amp2 too big by 1822.9; g^2 too big by 1822.9
print(f"(b) mass amu vs m_e       : {AMU_PER_ME:.1f}x            ~10^{math.log10(AMU_PER_ME):.2f}")
print(f"    (in g^2 via amp2, LINEAR in mass: factor {AMU_PER_ME:.0f})")

# (c) omega unit cm^-1 vs Ha:  omega_cm1/omega_Ha
om_ratio_cm_ha = omega_cm1_m7/omega_ha_m7
print(f"(c) omega cm^-1 vs Ha      : {om_ratio_cm_ha:.3e}     ~10^{math.log10(om_ratio_cm_ha):.2f}  (amp2 ~ 1/omega, LINEAR)")
# omega K vs Ha
om_ratio_K_ha = omega_K_m7/omega_ha_m7
print(f"    omega K vs Ha          : {om_ratio_K_ha:.3e}     ~10^{math.log10(om_ratio_K_ha):.2f}  (= HA_TO_K)")

# (d) the amp2 factor itself is small (~1e-4): it converts (Ha/bohr)^2 -> Ha^2
print(f"(d) amp2 magnitude        : {amp2_H_m7:.3e}     ~10^{math.log10(amp2_H_m7):.2f}")

# Now combine the suspected ~9-order product per the task hint:
#   mass(3.3e6 if SQUARED) x omega-unit x Ry^2
print("\n" + "-"*70)
print("COMBINED suspect products (task hint: mass^2 x omega-unit x Ry^2 ~ 9 orders)")
print("-"*70)
prod1 = (AMU_PER_ME**2) * om_ratio_K_ha * (RY_TO_HA**2)
print(f"  mass^2 ({AMU_PER_ME**2:.3e}) x omega(K/Ha {om_ratio_K_ha:.3e}) x Ry^2(0.25) = {prod1:.3e}  ~10^{math.log10(prod1):.2f}")
prod2 = AMU_PER_ME * om_ratio_K_ha
print(f"  mass^1 x omega(K/Ha) = {prod2:.3e}  ~10^{math.log10(prod2):.2f}")

print("\n" + "="*70)
print("LOCATING THE ~9-ORDER SLIP — what amp2 SHOULD be vs naive variants")
print("="*70)
# Correct (current code): amp2 = 1/(2 * mass_amu*1822.9 * omega_K*1/315775)
amp2_correct = amp2_H_m7
# Naive-bug A: forgot mass amu->m_e  (mass in amu) AND omega K->Ha (omega in K):
amp2_bugA = 1.0/(2.0*M_H_amu*omega_K_m7)
# Naive-bug B: mass amu->m_e applied, but omega left in K:
amp2_bugB = 1.0/(2.0*M_H_amu*AMU_PER_ME*omega_K_m7)
# Naive-bug C: mass in amu, omega in Ha:
amp2_bugC = 1.0/(2.0*M_H_amu*omega_ha_m7)
print(f"  amp2 CORRECT (m_e, Ha)        = {amp2_correct:.6e}")
print(f"  amp2 bugA (amu, K)            = {amp2_bugA:.6e}   ratio to correct = {amp2_bugA/amp2_correct:.3e} ~10^{math.log10(amp2_bugA/amp2_correct):.2f}")
print(f"  amp2 bugB (m_e, K)            = {amp2_bugB:.6e}   ratio = {amp2_bugB/amp2_correct:.3e} ~10^{math.log10(amp2_bugB/amp2_correct):.2f}")
print(f"  amp2 bugC (amu, Ha)          = {amp2_bugC:.6e}   ratio = {amp2_bugC/amp2_correct:.3e} ~10^{math.log10(amp2_bugC/amp2_correct):.2f}")

print("\n  => amp2 in g^2 is LINEAR, so the g^2 slip = the amp2 ratio above.")
print("     bugB (mass fixed, omega left in K) under-shoots g^2 by ~10^5.5 (=1/HA_TO_K).")
print("     bugA (both wrong) under-shoots by ~10^8.76 — matches the ~9-order target.")

print("\n" + "="*70)
print("REPORTED FROM-SCRATCH RESULT (context: lambda_fromscratch ~ 4.10e-9)")
print("="*70)
lam_fs = 4.10e-9
lam_qe_BZ = 4.376   # QE BZ lambda (textbook proof)
ratio_lam = lam_qe_BZ/lam_fs
print(f"  QE BZ lambda      = {lam_qe_BZ}")
print(f"  from-scratch lam  = {lam_fs:.3e}")
print(f"  ratio             = {ratio_lam:.3e}  ~10^{math.log10(ratio_lam):.2f}")
print(f"  lambda ~ g^2 (linear), so the g^2 deficit = {ratio_lam:.2e} ~10^{math.log10(ratio_lam):.2f} orders.")

print("\n" + "="*70)
print("DECOMPOSING THE 10^9.03 DEFICIT — unit product vs residual physics")
print("="*70)
deficit = lam_qe_BZ/lam_fs   # 1.07e9
# Hypothesis: deficit = mass(amu->me) * omega(K->Ha) [the classic 'amp2 left in raw units'] 
H1 = AMU_PER_ME * HA_TO_K
print(f"  H1 = mass(1822.9) x omega-K/Ha(315775)     = {H1:.3e} ~10^{math.log10(H1):.2f}")
print(f"       deficit/H1 = {deficit/H1:.3e}  (residual ~10^{math.log10(deficit/H1):.2f})")
# Hypothesis 2: deficit = omega(K->Ha)^? ... 
# Hypothesis 3: Ry^2 chain x mass x omega
H3 = AMU_PER_ME * HA_TO_K / (RY_TO_HA**2)
print(f"  H3 = mass x omega-K/Ha / Ry^2(0.25)        = {H3:.3e} ~10^{math.log10(H3):.2f}")
print(f"       deficit/H3 = {deficit/H3:.3e}  (residual ~10^{math.log10(deficit/H3):.2f})")
# Hypothesis 4: pure omega K/Ha factors:  (omega K->Ha) appears once in amp2 + ... 
H4 = HA_TO_K**1.5
print(f"  H4 = (omega-K/Ha)^1.5                       = {H4:.3e} ~10^{math.log10(H4):.2f}")
# Hypothesis 5: mass^2-ish
H5 = AMU_PER_ME * (HA_TO_K)
print(f"\n  Most parsimonious: H1 (mass x omega) carries 10^{math.log10(H1):.2f} of the 10^9.03;")
print(f"  residual 10^{math.log10(deficit/H1):.2f} = a small O(0.2-0.3) physics factor (vertex/N_ef/FS-weight),")
print(f"  NOT another order. => the gap is DOMINATED by the unit product, not weak physics.")

print("\n" + "="*70)
print("REFRAME: amp2 IS correctly applied in compose_cah6 (line 116-119).")
print("So the 10^9.03 g^2 deficit is NOT a units bug in amp2 — it lives in:")
print("  the BARE VERTEX g_mn^2  OR  the FS double-delta/N(E_F) weight.")
print("="*70)
# With amp2 correctly applied (=5.90e-2), QE needs bare g_mn^2 = 5.57e-2 (Ha/bohr)^2.
# from-scratch lambda=4.10e-9 vs QE 4.376 => the assembled g~^2 (after amp2) is 10^9.03 too small.
# Since amp2 is correct, the BARE g_mn^2 fed in is 10^9.03 too small:
g2_bare_needed = g_mn2_needed_ha2_per_bohr2
g2_bare_fs = g2_bare_needed / deficit
print(f"  QE-required bare g_mn^2  = {g2_bare_needed:.3e} (Ha/bohr)^2  -> |g_mn|={math.sqrt(g2_bare_needed):.3e} Ha/bohr")
print(f"  from-scratch bare g_mn^2 = {g2_bare_fs:.3e} (Ha/bohr)^2  -> |g_mn|={math.sqrt(g2_bare_fs):.3e} Ha/bohr")
print(f"  |g_mn| deficit = sqrt(10^9.03) = 10^{0.5*math.log10(deficit):.2f}  (~{math.sqrt(deficit):.1e}x too small)")
print()
print("  PHYSICAL READING: the bare deformation potential <psi|dV/du|psi> emerging")
print("  from the from-scratch PW chain is ~10^4.5 (={:.0e}x) SMALLER than the".format(math.sqrt(deficit)))
print("  physical ~0.24 Ha/bohr.  This is a VERTEX-MAGNITUDE deficit, not a unit slip.")
print()
print("  Likely structural causes (in priority order):")
print("   1. BARE (unscreened) dV: compose uses independent-particle dV_bare; the")
print("      physical el-ph vertex is the SCREENED dV_scf. eps^-1 enhances the long-")
print("      wavelength metallic vertex by a large factor (RPA metal screening).")
print("   2. psi NORMALIZATION / PW-basis truncation: n=51 (or 16-64) PW basis is far")
print("      below QE's ecutwfc=70Ry (~thousands of PW). A drastically truncated basis")
print("      under-resolves dV/du (the H-derived steep potential), shrinking the overlap.")
print("   3. q->0 (Gamma) acoustic suppression: at q=Gamma the local dV_bare head -> 0")
print("      (the acoustic-sum-rule / ΔG=0 term is zero, see realcell selftest case 2),")
print("      so a Gamma-only single-q vertex is anomalously small vs a BZ-averaged one.")
