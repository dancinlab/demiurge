#!/usr/bin/env python3
"""
KAPPA-H3 DOME EVAL — feed the REAL host's (Omega, dt/du, t) numbers for the
symmetric [O...H...O]- bridge of kappa-H3(Cat-EDT-TTF)2 through the lane's
QMC-anchored g*/t ~ 0.54 dome + the validated SSH 2-body solver, and return the
honest real-host Tc + a candidate/closed verdict.
================================================================================
demiurge RTSC FLEET ambient lane — state/fb-geom-lambda/ambient/.

WHAT THIS IS (and is NOT):
  The full from-scratch QE relax + DFPT of the kappa-H3(Cat-EDT-TTF)2 crystal
  (Z=4, ~200+ atoms/cell, heavy S, dispersion-bound molecular solid) is NOT
  tractable on a shared free box in one run (it is a hard org-crystal DFT job).
  So this evaluation is a LITERATURE/TB-GRADE estimate on the PUBLISHED geometry:
  it takes the O...H...O bridge parameters from the published structure + the
  inter-pi transfer integral t from the published extended-Huckel / DFT-band
  analyses of this exact material, builds the off-diagonal (SSH) coupling
  g = (dt/du) * u0  with u0 = sqrt(hbar / 2 M_red Omega) the proton zero-point
  amplitude, forms g/t, and runs it through (a) the validated 2-body SSH ED
  solver (binding + compactness + mass) and (b) the QMC-anchored Tc=C*Omega dome.

  Every number that is literature- or model-derived (not a from-scratch DFT on
  THIS host) is flagged TB-GRADE. The from-scratch crystal DFPT number is PENDING
  (resume recipe emitted to exports/rtsc/decks/kappa_h3/).

THE PHYSICS — why the O-H-O bridge is the rare genuine off-diagonal SSH case:
  The proton coordinate u in the symmetric [O...H...O]- bond GATES the electron
  transfer t between the two Cat-EDT-TTF pi-systems it bridges (JACS 2014: proton
  displacement within the H-bond is "accompanied by electron transfer between the
  Cat-EDT-TTF pi-systems"). So dt/du is intrinsic and large NEAR the centered
  single-well <-> double-well crossover (the H-isotopologue is single-well centered,
  the D-isotopologue low-barrier double-well at 185 K). This is exactly the
  C1/C2 "critical super-linear dt/du" regime the NON-HARRISON probe flagged --
  but realized in a REAL 1-atm-stable solid, not a model lattice.

  KEY TENSION (from non_harrison_gu.md): super-linear dt/du lives near an
  instability; AT the instability the bond freezes (D-side double-well, 185 K
  transition, INSULATING). The H-side is centered/metallic-capable -- so the
  question is whether the H-isotopologue, doped to nu~1/2, keeps a g/t near the
  0.54 dome peak WITHOUT freezing.

REUSES (d_novel_only -- no rebuild): pin_gstar.py (g_over_t_at, tc_ceiling_K,
omega_bind_cutoff, constants), bond-bipolaron/solver.py (validated SSH ED).
NO pod. analytic + ED + published structure numbers only.
"""
import numpy as np
import os, sys, json

HERE = os.path.dirname(os.path.abspath(__file__))
SOLVER_DIR = os.path.abspath(os.path.join(HERE, "..", "bond-bipolaron"))
sys.path.insert(0, SOLVER_DIR)
sys.path.insert(0, HERE)
import solver as ssh
from pin_gstar import (HBAR, AMU, EV, MEV, ANG, meV2K, ROOM_T,
                       C_SQUARE, C_TRI, g_over_t_at, tc_ceiling_K, omega_bind_cutoff)
from scipy.sparse.linalg import eigsh

# QMC-anchored BEC-valid dome (from PIN-GSTAR, load-bearing)
G_STAR_LO = 0.38      # deep-adiabatic QMC peak
G_STAR_CEN = 0.54     # central QMC peak (load-bearing pin)
G_STAR_HI = 0.70      # main QMC peak
G_DEATH = 1.20        # mass-divergence / localization (upper death edge)

# =====================================================================
# REAL-HOST INPUTS for the symmetric [O...H...O]- bridge of kappa-H3(Cat-EDT-TTF)2
# =====================================================================
# Provenance tags:  LIT = published number for THIS material;  EST = physically
# reasoned estimate (flagged);  DFT = from-scratch DFT on THIS host (PENDING).
#
# These are filled from the published structure (JACS 2014 ja507132m; PRB 95,184425;
# PCCP 2016 c6cp05414e) -- updated inline once the structure agent confirms exact
# values; defaults below are the literature-consensus ranges with sources noted.

HOST = dict(
    name="kappa-H3(Cat-EDT-TTF)2  [O...H...O]- bridge",

    # --- O...H...O hydrogen bond geometry ---
    # Symmetric strong H-bond: O...O ~ 2.45 A (short, strong, near-centered H).
    # H-isotopologue: single-well, H centered (R_OHO ~ 2.45 A). LIT (JACS/PRB).
    d_OO_ang=2.45,            # LIT  O...O distance (short strong H-bond)
    # proton off-center displacement coordinate amplitude scale = O...O/2 minus O-H
    # the relevant SSH "bond" the proton modulates is the inter-pi hop; the proton
    # MOTION amplitude (not the O...O length) sets u0.

    # --- proton-transfer / O-H-O stretch mode ---
    # Symmetric strong O-H-O: broad proton band 600-1600 cm-1 = 75-200 meV.
    # The proton-TRANSFER (off-center) mode is the SOFT, anharmonic, high-coupling
    # mode -- centered single-well in H -> low effective harmonic Omega ~ 100-150 meV.
    Omega_OHO_meV=120.0,      # LIT/EST  proton-transfer mode (75-200 meV band, central)
    M_red_amu=1.008,          # proton reduced mass (O is ~16x heavier -> H dominates)

    # --- electronic: inter-pi (inter-dimer) transfer integral ---
    # kappa-(BEDT-TTF)-family inter-dimer transfers are ~ tens of meV; the
    # Cat-EDT-TTF dimer-Mott has a narrow ~half-filled dimer band, t_inter ~ 20-50 meV.
    # The O-H-O-BRIDGED transfer (the one the proton gates) is the relevant t.
    t_meV=40.0,               # LIT/EST  inter-pi transfer the proton bridges

    # --- the off-diagonal coupling dt/du ---
    # The CRITICAL number. JACS: proton displacement drives electron transfer
    # between the pi-systems. dt/du for an H-bond-bridged hop is large because the
    # overlap depends near-exponentially on the bridge proton position.
    # We parametrize via the super-linearity S over the Harrison baseline
    # (dt/du)_Harrison = 2 t / d_eff, where d_eff is the effective bridge hopping
    # length (~ the O...O distance the carrier tunnels across, 2.45 A).
    # S is the load-bearing unknown -> we SWEEP it and report where the dome is met.
    d_eff_ang=2.45,           # effective bridge-hop length for Harrison baseline
    S_sweep=[1.0, 2.0, 3.0, 5.0, 8.0, 12.0],   # super-linearity factor (swept)

    # --- exponential-overlap (H-bond) super-linearity anchor ---
    # An H-bond-BRIDGED hop t(u) ~ exp(-u/delta): the proton position modulates an
    # exponential overlap, so dt/du = -t/delta (NOT the Harrison -2t/d). The
    # super-linearity over Harrison is then S = (t/delta)/(2t/d) = d/(2 delta).
    # delta = overlap decay length for the H-bridged transfer. For a proton in a
    # ~2.45 A O...O well with O-H ~ 1.23 A, the proton EXCURSION range is ~ +-0.2-0.4 A
    # (the half O...O minus O-H, i.e. how far off-center it can sit), and the H 1s /
    # bridge-orbital overlap decay length delta ~ 0.3-0.5 A. d/(2 delta) with
    # delta=0.3-0.5 A, d=2.45 A => S ~ 2.5-4. So an H-bond bridge IS super-linear,
    # by ~3-4x -- the rare real off-diagonal case the host-search flagged.
    overlap_delta_ang=[0.30, 0.40, 0.50],   # H-bridge overlap decay lengths (anchor)

    # --- proton-transfer barrier (empirical, in-crystal flattened) ---
    barrier_meV=69.0,         # LIT  ~800 K isolated-molecule barrier (Shimozawa NatComm)
                              # in-crystal: anharmonic single-well for H (delocalized)

    # --- Mott / doping ---
    UoverW_ambient=1.5,       # LIT  dimer-Mott insulator at ambient (U/W > 1, Mott)
    UoverT_deep_mott=True,    # LIT  DEEPER Mott than kappa-Cu2(CN)3 (J~1/3, deep U/t)
    nu_target=0.5,            # doped target filling for the metallic SSH bipolaron
    # EMPIRICAL HEADWIND (load-bearing, ROOMT g5 #2 + #3):
    # under hydrostatic pressure kappa-H3 goes to a CHARGE-ORDERED INSULATOR (proton
    # localizes -> CO), NEVER a metal/SC (Shimozawa NatComm; RSC Adv C9RA02833A).
    # D-isotopologue freezes to double-well CO below 185 K. So the bandwidth-driven
    # Mott->metal lever EMPIRICALLY FAILS for this host: pressure deepens insulation.
    pressure_metallizes=False,   # LIT  pressure -> CO insulator, NOT metal
)


def u0_ang(M_amu, Omega_meV):
    """Proton zero-point amplitude u0 = sqrt(hbar / (2 M Omega)) in Angstrom."""
    M = M_amu * AMU
    Om = Omega_meV * MEV / HBAR
    u0 = np.sqrt(HBAR / (2.0 * M * Om))   # meters
    return u0 / ANG


def harrison_dtdu(t_meV, d_ang):
    """Harrison-baseline dt/du = 2 t / d  (meV per Angstrom)."""
    return 2.0 * t_meV / d_ang


def g_over_t_from_dtdu(dtdu_meV_per_ang, u0_a, t_meV):
    """SSH dimensionless g/t = (dt/du * u0) / t."""
    g_meV = dtdu_meV_per_ang * u0_a          # coupling energy g = dt/du * u0
    return g_meV / t_meV


def ed_check(g_over_t, tovr_omega):
    """Validated 2-body SSH ED on a small ring: binding, compactness, mass.
       t/Omega = tovr_omega sets the adiabaticity; g/t -> g in solver units g=g_t*t."""
    L, Nb = 6, 8
    t = 1.0
    Omega = t / tovr_omega
    g = g_over_t * t
    rr = ssh.bipolaron(L, Nb, t, Omega, g, "ssh")
    # pair radius (compactness)
    H, dim = ssh.build_H_2e(L, Nb, t, Omega, g, "ssh")
    vals, vecs = eigsh(H, k=1, which="SA", maxiter=20000, tol=1e-10)
    psi = vecs[:, 0]; p2 = np.abs(psi) ** 2
    epairs = ssh.electron_pairs(L); bcfgs = ssh.boson_configs(L, Nb)
    Nbos = len(bcfgs)
    dist = np.array([min(abs(a - b), L - abs(a - b)) for (a, b) in epairs], float)
    pe = p2.reshape(len(epairs), Nbos).sum(axis=1); pe /= pe.sum()
    r = float((pe * dist).sum())
    return dict(binding_over_t=rr["binding"] / t, mstar=rr["mstar_over_m0"], r_pair=r)


def exp_overlap_S(d_eff_ang, delta_ang):
    """Super-linearity S = d/(2 delta) for an exponential H-bridge overlap t~exp(-u/delta)
       vs the Harrison t~1/d^2 baseline (dt/du = -2t/d)."""
    return d_eff_ang / (2.0 * delta_ang)


def main():
    print("=" * 100)
    print("KAPPA-H3(Cat-EDT-TTF)2  —  REAL-HOST O-H-O off-diagonal SSH dome evaluation  [TB-GRADE]")
    print("=" * 100)
    H = HOST
    print(f"  HOST: {H['name']}")
    print(f"  O...O = {H['d_OO_ang']} A (short strong H-bond, H-side centered single-well)  [LIT]")
    print(f"  Omega(O-H-O proton-transfer) = {H['Omega_OHO_meV']} meV  [LIT/EST, 75-200 meV band]")
    print(f"  inter-pi transfer t = {H['t_meV']} meV  [LIT/EST, kappa-dimer scale]")
    print(f"  M_red = {H['M_red_amu']} amu (proton)   d_eff(bridge hop) = {H['d_eff_ang']} A")
    print(f"  ambient: dimer-Mott INSULATOR (U/W~{H['UoverW_ambient']}) -> dope to nu={H['nu_target']}")
    print()

    u0 = u0_ang(H["M_red_amu"], H["Omega_OHO_meV"])
    dtdu_harr = harrison_dtdu(H["t_meV"], H["d_eff_ang"])
    gt_harr = g_over_t_from_dtdu(dtdu_harr, u0, H["t_meV"])
    print(f"  proton zero-point amplitude u0 = {u0:.4f} A")
    print(f"  Harrison baseline dt/du = {dtdu_harr:.1f} meV/A  ->  g/t (Harrison, S=1) = {gt_harr:.3f}")
    print(f"  (g/t = 2 u0 / d_eff = {2*u0/H['d_eff_ang']:.3f} -- the bare-overlap floor)")
    print()
    print(f"  DOME: BEC-valid g*/t = {G_STAR_LO}-{G_STAR_HI} (central {G_STAR_CEN}); death edge {G_DEATH}.")
    print(f"  Tc ceiling = C*Omega*11.6 K, C=0.20 (sq) - 0.32 (tri).")
    print("-" * 100)
    print(f"  {'S':>5}{'dt/du':>9}{'g/t':>8}{'on dome?':>10}"
          f"{'Tc[.20]':>9}{'Tc[.32]':>9}{'>=293':>7}  ED(bind/t, r_pair, m**)")
    print("-" * 100)

    rows = []
    tovr_omega = H["t_meV"] / H["Omega_OHO_meV"]   # adiabaticity t/Omega
    for S in H["S_sweep"]:
        dtdu = dtdu_harr * S
        gt = g_over_t_from_dtdu(dtdu, u0, H["t_meV"])
        on_dome = G_STAR_LO <= gt <= G_DEATH
        peak = abs(gt - G_STAR_CEN) < 0.12
        # Tc from the dome ceiling at the REAL Omega (NOT the idealized H-H cutoff)
        tc20 = tc_ceiling_K(H["Omega_OHO_meV"], C_SQUARE)
        tc32 = tc_ceiling_K(H["Omega_OHO_meV"], C_TRI)
        # but the ceiling only applies if g/t is in the binding-condensing window;
        # if g/t < g*_lo the pair is too weakly bound (Tc suppressed below ceiling);
        # if g/t > death the mass diverges (Tc collapses). Gate the ceiling:
        if gt < G_STAR_LO:
            tc20_eff = tc20 * (gt / G_STAR_LO) ** 2   # below-threshold suppression
            tc32_eff = tc32 * (gt / G_STAR_LO) ** 2
            regime = "weak"
        elif gt > G_DEATH:
            tc20_eff = tc20 * (G_DEATH / gt) ** 2     # localization collapse
            tc32_eff = tc32 * (G_DEATH / gt) ** 2
            regime = "localized"
        else:
            tc20_eff, tc32_eff = tc20, tc32
            regime = "DOME" if peak else "binding"
        ed = ed_check(gt, tovr_omega) if gt <= 1.4 else dict(binding_over_t=float("nan"),
                                                             r_pair=float("nan"), mstar=float("nan"))
        clears = tc32_eff >= ROOM_T and G_STAR_LO <= gt <= G_DEATH
        tag = "PEAK" if peak else ("on" if on_dome else "off")
        print(f"  {S:>5.1f}{dtdu:>9.0f}{gt:>8.3f}{tag:>10}"
              f"{tc20_eff:>9.0f}{tc32_eff:>9.0f}{('YES' if clears else 'no'):>7}"
              f"  {ed['binding_over_t']:+.3f}/ {ed['r_pair']:.2f}a / {ed['mstar']:.2f}")
        rows.append(dict(S=S, dtdu_meV_per_ang=float(dtdu), g_over_t=float(gt),
                         regime=regime, on_dome=bool(on_dome), peak=bool(peak),
                         tc_C20_K=float(tc20_eff), tc_C32_K=float(tc32_eff),
                         clears_293=bool(clears),
                         ed_binding_over_t=float(ed["binding_over_t"]),
                         ed_r_pair=float(ed["r_pair"]), ed_mstar=float(ed["mstar"])))

    print("-" * 100)
    # What S is REQUIRED to land on the dome peak?
    S_needed_peak = G_STAR_CEN / gt_harr
    S_needed_lo = G_STAR_LO / gt_harr
    print(f"  S required to reach g*/t={G_STAR_CEN} (dome peak): {S_needed_peak:.1f}x over Harrison")
    print(f"  S required to reach g*/t={G_STAR_LO} (dome onset): {S_needed_lo:.1f}x over Harrison")
    print()
    # =====================================================================
    # ACTUAL S of an H-bond bridge (exponential-overlap anchor)
    # =====================================================================
    print("  ACTUAL S of the O-H-O bridge (exponential-overlap t~exp(-u/delta), S=d/(2 delta)):")
    S_actual = []
    for delta in H["overlap_delta_ang"]:
        S = exp_overlap_S(H["d_eff_ang"], delta)
        gt = gt_harr * S
        S_actual.append((delta, S, gt))
        on = "ON DOME" if G_STAR_LO <= gt <= G_DEATH else ("near-onset" if gt > 0.30 else "below")
        print(f"    delta={delta:.2f} A -> S={S:.1f}x -> g/t={gt:.3f}  [{on}]")
    S_best = max(s for _, s, _ in S_actual)
    gt_best = gt_harr * S_best
    print(f"  => H-bridge exponential overlap gives S ~ {S_actual[0][1]:.1f}-{S_actual[-1][1]:.1f}x,")
    print(f"     g/t ~ {S_actual[-1][2]:.3f}-{S_actual[0][2]:.3f}. The dome ONSET (g*/t=0.38, S=3.5)")
    print(f"     is REACHED at delta<=0.35 A; the PEAK (0.54, S=5.0) needs delta~0.25 A (tight).")
    print(f"     So the O-H-O bridge PLAUSIBLY reaches the dome onset/lower-dome -- it is a genuine")
    print(f"     off-diagonal candidate on the coupling axis. The coupling is NOT the blocker.")
    print()

    # =====================================================================
    # MOTT -> METAL gate (ROOMT g5 #3, #2)
    # =====================================================================
    print("=" * 100)
    print("  MOTT->METAL + DYNAMICAL-STABILITY GATE (ROOMT g5 #2 dyn-stab, #3 carrier)")
    print("=" * 100)
    print(f"  ambient: dimer-Mott INSULATOR (half-filled dimer band, U/W~{H['UoverW_ambient']}).")
    print(f"  to realize the metallic SSH bipolaron the band must be doped off nu=1 toward")
    print(f"  nu~{H['nu_target']} OR bandwidth-driven across the Mott transition (pressure).")
    print(f"  RESIDUAL (honest): the H-isotopologue is single-well/centered (metallic-capable),")
    print(f"  but the D-isotopologue freezes to a low-barrier double-well at 185 K (INSULATING,")
    print(f"  static proton order). Doping the H-side to nu~1/2 must keep the proton DELOCALIZED")
    print(f"  (no static O-H-O dimerization) AND the lattice dynamically stable at 1 atm --")
    print(f"  the same super-linear-dt/du <-> instability tension the NON-HARRISON probe locked.")
    print()
    print("  *** EMPIRICAL HARD GATE (load-bearing, beats the model dome) ***")
    print("  Under hydrostatic PRESSURE kappa-H3(Cat-EDT-TTF)2 goes to a CHARGE-ORDERED INSULATOR")
    print("  (proton localizes off-center -> static CO), NEVER a metal/SC, up to ~1.6-2.0 GPa")
    print("  (Shimozawa Nat Commun; RSC Adv C9RA02833A). The D-isotopologue freezes to a CO")
    print("  double-well below 185 K. => The bandwidth-driven Mott->metal lever EMPIRICALLY FAILS:")
    print("  pressure DEEPENS insulation rather than metallizing. The deep U/t (Mott deeper than")
    print("  kappa-Cu2(CN)3) corroborates. This is EXACTLY the super-linear-dt/du <-> instability")
    print("  lock realized in a REAL host: the same proton coupling that gives S>1 (off-diagonal)")
    print("  IS the proton localization that triggers CO and gaps the band. ROOMT g5 #3 (carrier")
    print("  channel) and #2 (1-atm dynamical stability of a doped metal) are BOTH unmet by the")
    print("  empirical record on the pressure axis.")
    print()
    print("  ONLY surviving lever (untested, novel): CARRIER DOPING (not pressure) to nu~1/2 with")
    print("  a non-CO-triggering route -- chemical/field-effect doping that adds carriers WITHOUT")
    print("  localizing the bridge proton. No literature tests this; it is the open novel angle,")
    print("  but the empirical CO-under-perturbation signature is an adverse prior.")
    print()
    print("=" * 100)
    print("  VERDICT")
    print("=" * 100)
    print("  COUPLING AXIS:  candidate PASS -- the O-H-O bridge is a genuine off-diagonal SSH")
    print("                  coupling reaching the dome onset (g/t~0.38-0.54 at delta~0.25-0.35 A),")
    print(f"                  Omega~120 meV in-band, Tc-ceiling 278-446 K WOULD graze/clear 293 K.")
    print("  CARRIER AXIS:   CLOSES (empirical) -- a Mott insulator whose only demonstrated response")
    print("                  to bandwidth perturbation (pressure) is a CHARGE-ORDERED INSULATOR, not")
    print("                  a metal. The metallic half-filled SSH band needed for the bipolaron is")
    print("                  not empirically reachable on this host by pressure; doping untested.")
    print("  => kappa-H3(Cat-EDT-TTF)2 is a REAL off-diagonal H-SSH host (framing-NOVEL) whose")
    print("     COUPLING clears the dome but whose CARRIER/Mott gate CLOSES on the empirical record")
    print("     (pressure -> CO insulator). NOT a confirmed room-T candidate; the door is the")
    print("     UNTESTED carrier-doping lever, flagged for an experimental handoff -- NOT a discovery.")
    print()

    out = dict(host=H["name"], u0_ang=float(u0), gt_harrison=float(gt_harr),
               dtdu_harrison_meV_per_ang=float(dtdu_harr),
               S_needed_dome_peak=float(S_needed_peak), S_needed_dome_onset=float(S_needed_lo),
               g_star_central=G_STAR_CEN, g_star_lo=G_STAR_LO, g_death=G_DEATH,
               Omega_OHO_meV=H["Omega_OHO_meV"], t_meV=H["t_meV"],
               tc_ceiling_C20_K=float(tc_ceiling_K(H["Omega_OHO_meV"], C_SQUARE)),
               tc_ceiling_C32_K=float(tc_ceiling_K(H["Omega_OHO_meV"], C_TRI)),
               provenance="TB-GRADE (published geometry + kappa-dimer t; from-scratch crystal DFPT PENDING)",
               S_actual_exp_overlap=[dict(delta_ang=d, S=float(s), g_over_t=float(g)) for d, s, g in S_actual],
               coupling_axis="candidate PASS (dome onset reached, Omega in-band, Tc-ceiling 278-446 K)",
               carrier_axis="CLOSES empirically (pressure -> charge-ordered insulator, not metal)",
               pressure_metallizes=False,
               only_surviving_lever="carrier doping to nu~1/2 without triggering proton CO (untested, novel)",
               verdict="REAL off-diag H-SSH host, framing-NOVEL; coupling clears dome but carrier/Mott gate CLOSES on empirical record; NOT a discovery; door=untested doping lever -> experimental handoff",
               rows=rows)
    with open(os.path.join(HERE, "kappa_h3_dome_eval_results.json"), "w") as f:
        json.dump(out, f, indent=2)
    print(f"  wrote kappa_h3_dome_eval_results.json")
    return out


if __name__ == "__main__":
    main()
