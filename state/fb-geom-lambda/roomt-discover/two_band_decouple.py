#!/usr/bin/env python3
"""
TWO-BAND-DECOUPLE — RTSC room-T DISCOVERY lane (FREE summer / local; NO billing pod).
================================================================================
demiurge RTSC FLEET ambient lane — state/fb-geom-lambda/roomt-discover/.

THE ANGLE (distinct from multiband-assist & non_harrison_gu, which both CLOSED):
  The 9th law STIFF-BOND-WEAK-SSH-BINDING anticorrelation (g/t needs a SOFT light
  bond; Tc∝Ω needs a STIFF bond) is anticorrelated *ONLY WHEN the coupling band and
  the carrier band are the SAME band*. DECOUPLE the two jobs onto DIFFERENT bands:
    band A (PAIRING/GLUE band): a light-atom SOFT-bond SSH (off-diagonal ∂t/∂u)
       channel that produces a strong LOCAL pair attraction (negative-U_eff). It may
       be NARROW / even localized — it is NOT asked to carry the supercurrent.
    band B (CARRIER band): a SEPARATE, already-metallic, weakly-correlated WIDE band
       (large t_B, NOT Mott, NO CDW) that carries the carriers & the condensate.
    coupling: interband PAIR-scattering J_int (Suhl-Kondo / negative-U-band ⟷
       metallic-band), which transfers the A-channel pairing onto the metallic B band
       WITHOUT requiring B to localize.

WHY THIS IS NOT multiband-assist (which CLOSED-NEGATIVE):
  multiband-assist put a SINGLE PAIR on flat-A(bind)+dispersive-B(stiffness) and tried
  to borrow B's KINETIC stiffness via single-particle t_AB or η-pair-hopping. It found
  |Δb|·t** ≈ const (kinetic conservation): the coupling that lends stiffness unbinds the
  pair. THE DIFFERENCE HERE: band B is ALREADY a half-filled metal with its OWN large
  Fermi-surface carriers — it does not need to "borrow binding" to be stiff; it is stiff
  by construction. The A-band supplies an EFFECTIVE PAIR INTERACTION (a negative U_eff
  delivered to B's electrons by interband scattering), Suhl-Kondo style. The pairing
  glue and the carrier stiffness live on PHYSICALLY DIFFERENT electrons. The question is
  whether the Suhl-Kondo channel delivers a LARGE ENOUGH effective attraction on B to
  give Tc≥293 K, while A stays sub-CDW and B stays metallic & dynamically stable.

WHAT KILLS IT (the three honest closure axes to test):
  (K1) INTERBAND CO / phase separation: a strong negative-U_eff A-band at finite density
       tends to charge-order or phase-separate (the bipolaron crystal), and the interband
       coupling J_int that is strong enough to matter DRAGS B into the same CO. (the
       κ-H3 lesson: bandwidth perturbation → CO, not metal.)
  (K2) PAIRING-BAND LOCALIZATION: the A-band negative-U_eff that is deep enough to be a
       strong glue is exactly the regime where the A pair self-traps (heavy bipolaron),
       and a self-trapped A pair has VANISHING J_int matrix element to the wide B band
       (Franck-Condon / mass-mismatch suppression): big glue ⇒ small transfer to B.
  (K3) PHONON / dynamical instability: the soft A bond that gives big ∂t/∂u softens to
       a static Peierls/CDW distortion (Ω→0) at the coupling needed — same wall as
       non_harrison_gu C1/C2.

THE CALC (tractable, FREE):
  A two-band BCS/Suhl-Kondo gap-equation solver (mean-field, the right tool for the
  Tc of a TWO-BAND model — ED is for the single-pair binding, already done). Inputs:
    - U_eff_A(g_A, Ω_A): the negative-U the A-channel SSH delivers (mapped from the
      lane's VALIDATED bond-bipolaron ED binding Δ_b → an attractive U_eff).
    - N_B(0), t_B: the metallic carrier band DOS & width (the STIFF band, Ω-free).
    - J_int: interband pair-scattering, BOUNDED by the Franck-Condon transfer (K2).
  Output: Tc(2-band) via the coupled gap equations, and an HONEST audit of K1/K2/K3 —
  does any real (g_A,Ω_A,t_B,J_int) point clear 293 K with all three killers avoided?

REUSES (no rebuild, d_novel_only): bond-bipolaron/solver.py (validated SSH ED → U_eff_A
  via binding), pin_gstar.py (g/t↔Ω↔Tc dome machinery, QMC anchor). NO pod.

HONEST BAR (c2/d6): if every clearing point violates K1/K2/K3, report CLOSED-NEGATIVE
  with WHICH axis closes and WHY. NEVER fabricate a Tc. The Suhl-Kondo enhancement is a
  real, known multiplier — but its INPUTS (U_eff_A reachable on a stable soft bond, J_int
  surviving Franck-Condon) are the load-bearing numbers, taken from the lane's own ED.
"""
import numpy as np
import os, sys, json

HERE = os.path.dirname(os.path.abspath(__file__))
SOLVER_DIR = os.path.abspath(os.path.join(HERE, "..", "bond-bipolaron"))
AMBIENT_DIR = os.path.abspath(os.path.join(HERE, "..", "ambient"))
sys.path.insert(0, SOLVER_DIR)
sys.path.insert(0, AMBIENT_DIR)

import solver as ssh                  # validated 2-body SSH ED (binding, mass)

meV2K = 11.604
ROOM_T = 293.15
KB = 1.0  # work in units where we restore K via meV2K at the end


# ============================================================================
# (A) Map the A-channel SSH coupling -> an effective on-site attraction U_eff_A.
#     The validated bond-bipolaron ED gives the 2-body binding Δ_b(g_A,Ω_A,t_A).
#     In the dilute/local-pair limit the bound pair acts as a negative-U center:
#        |U_eff_A| ≈ |Δ_b|  (the pair binding energy IS the attraction depth).
#     This is the standard local-pair / negative-U mapping (Micnas-Ranninger-Robaszkiewicz).
# ============================================================================
def u_eff_A(t_A, Omega_A, g_A, L=6, Nb=8):
    """Effective attraction |U_eff_A| (in units of t_A) the SSH A-channel delivers,
       plus the A-pair mass enhancement (the K2 localization indicator)."""
    rr = ssh.bipolaron(L, Nb, t_A, Omega_A, g_A, "ssh")
    binding = rr["binding"]            # Δ_b (negative when bound), absolute units of t_A
    mstar = rr["mstar_over_m0"]        # A-pair COM mass enhancement (K2)
    return dict(U_eff=-binding, binding=binding, mstar=mstar)  # U_eff>0 = attractive depth


# ============================================================================
# (B) Franck-Condon suppression of the interband pair-transfer J_int (K2).
#     A self-trapped (heavy) A-pair has a phonon-dressed wavefunction whose overlap
#     with the bare wide-B band is suppressed by the polaronic Franck-Condon factor:
#        J_int_eff = J0 * exp(-g_A^2 / (2 Ω_A^2))   (Lang-Firsov / small-polaron form)
#     i.e. the very coupling that makes U_eff_A deep EXPONENTIALLY kills the transfer to B.
#     This is the quantitative form of K2 (big glue ⇒ small transfer).
# ============================================================================
def franck_condon(g_A, Omega_A, J0):
    return J0 * np.exp(-(g_A ** 2) / (2.0 * Omega_A ** 2))


# ============================================================================
# (C) Two-band Suhl-Kondo gap equations (the right Tc tool for a 2-band model).
#     Bands: A (pairing, DOS N_A, intraband attraction V_AA = U_eff_A·N_A),
#            B (metallic carriers, DOS N_B, intraband V_BB ~ 0 or weak),
#     coupled by interband V_AB = J_int·sqrt(N_A N_B) (Suhl-Kondo).
#     Linearized Tc condition (BCS 2-band): the largest eigenvalue Λ of the 2x2
#     coupling matrix  M = [[V_AA, V_AB],[V_AB, V_BB]]  sets
#        Tc = 1.13 ω_c exp(-1/Λ)   with ω_c the pairing cutoff (= Ω_A here).
#     The Suhl-Kondo POINT: even with V_BB≈0 (B has NO intrinsic glue), the off-diagonal
#     V_AB lends pairing to B; Λ = (V_AA+V_BB)/2 + sqrt(((V_AA-V_BB)/2)^2 + V_AB^2) > V_AA
#     is the interband ENHANCEMENT. We test whether that enhancement → Tc≥293 K.
# ============================================================================
def two_band_Tc(U_eff_A, N_A, N_B, J_int, omega_cut_meV, V_BB=0.0):
    """HONEST two-band gap eq. The GOAL is a SUPERCONDUCTING METALLIC B band — so the
       load-bearing output is the B-band gap ratio Δ_B/Δ_A, driven ONLY by the interband
       V_AB (B has no intrinsic glue, V_BB=0). The largest eigenvalue Λ sets the overall
       Tc, BUT we MUST separate two physically different solutions:
         (i) A-dominated (eigenvector ~ on A): this is the SINGLE-BAND A bipolaron the
             campaign ALREADY CLOSED (strong V_AA on a narrow soft band → bipolaron-CDW),
             NOT the metallic-B SC we are after. Δ_B/Δ_A ≈ V_AB/(1/N? ) is TINY here.
         (ii) genuinely two-band (B carries a real gap): needs V_AB comparable to V_AA.
       We report Λ, the eigenvector B-weight, and the B-gap fraction Δ_B/Δ_A."""
    V_AA = U_eff_A * N_A                       # intraband coupling on A
    V_AB = J_int * np.sqrt(N_A * N_B)          # interband (Suhl-Kondo)
    M = np.array([[V_AA, V_AB], [V_AB, V_BB]])
    w, v = np.linalg.eigh(M)
    Lam = float(w[-1]); evec = v[:, -1]
    # B-weight of the leading pairing eigenvector: how much the condensate lives on B
    b_weight = float(evec[1] ** 2)
    # the B-gap fraction relative to the A-gap (Δ_B/Δ_A) in the leading solution
    gap_ratio_BA = float(abs(evec[1]) / (abs(evec[0]) + 1e-12))
    if Lam <= 1e-9:
        return dict(Tc_K=0.0, Lambda=Lam, V_AA=V_AA, V_AB=V_AB,
                    b_weight=b_weight, gap_ratio_BA=gap_ratio_BA)
    Tc_meV = 1.13 * omega_cut_meV * np.exp(-1.0 / Lam)
    return dict(Tc_K=Tc_meV * meV2K, Lambda=float(Lam),
                V_AA=float(V_AA), V_AB=float(V_AB), Tc_meV=float(Tc_meV),
                b_weight=b_weight, gap_ratio_BA=gap_ratio_BA)


# ============================================================================
# (D) THE SWEEP — does ANY (g_A, Ω_A, t_B, J0) point clear 293 K with K1/K2/K3 OK?
# ============================================================================
def main():
    print("\n" + "#" * 92)
    print("# TWO-BAND-DECOUPLE — Suhl-Kondo (SSH-glue band A ⟷ metallic carrier band B)")
    print("#" * 92 + "\n")

    print("STEP 1 — U_eff_A(g_A,Ω_A) from the VALIDATED bond-bipolaron ED")
    print("-" * 92)
    print("  A-band: light SOFT bond (the only regime with big g_A). t_A=1 (band unit).")
    print(f"  {'g_A/t':>7}{'Ω_A/t':>7}{'|U_eff|/t':>11}{'A-pair m**':>12}{'FC factor':>11}  note")
    # soft-bond A-channel: Ω_A/t small (soft) is where SSH g_A is large (9th law).
    # We scan g_A up toward/over the QMC dome g*/t≈0.54 and the strong regime.
    A_points = []
    for g_A in [0.4, 0.54, 0.8, 1.2, 1.6, 2.0]:
        Omega_A = 0.5            # soft bond, t_A units (Ω_A/t=0.5, deep-adiabatic dome point)
        d = u_eff_A(1.0, Omega_A, g_A, L=6, Nb=8)
        fc = np.exp(-(g_A ** 2) / (2.0 * Omega_A ** 2))
        note = ""
        if d["mstar"] > 10: note = "A-pair SELF-TRAPPED (K2)"
        elif d["mstar"] > 3: note = "A-pair heavy"
        A_points.append(dict(g_A=g_A, Omega_A=Omega_A, **d, fc=float(fc)))
        print(f"  {g_A:>7.2f}{Omega_A:>7.2f}{d['U_eff']:>11.3f}{d['mstar']:>12.2f}{fc:>11.3e}  {note}")
    print()
    print("  ★ K2 already visible: as g_A grows (deeper |U_eff|), m** rises AND the")
    print("    Franck-Condon factor (∝ transfer to B) collapses exponentially.")
    print()

    print("STEP 2 — TWO-BAND Suhl-Kondo Tc with the metallic carrier band B")
    print("-" * 92)
    print("  B = wide metallic band: N_B(0) ~ 0.3 /t (typical good metal), V_BB=0 (no")
    print("  intrinsic glue — B is a SPECTATOR metal that ONLY receives pairing via J_int).")
    print("  N_A: narrow A-band DOS ~ 0.5 /t. J0 = bare interband pair-scattering ~ 0.3·U_eff")
    print("  (a generous upper bound; physically J_int ≲ the smaller of the two couplings),")
    print("  THEN suppressed by Franck-Condon (K2).  ω_cut = Ω_A (set the meV scale below).")
    print()
    # Set the real meV scale: the soft A-bond Ω_A. To even have a chance at room-T the
    # ceiling Tc=C·Ω caps everything, so Ω_A(meV) must itself be sizable. But Ω_A/t=0.5
    # (soft, for big g_A). We scan the REAL Ω_A in meV to expose the K3 (Ω) tension.
    N_A, N_B = 0.5, 0.3
    print("  ★ HONEST discriminator: b_weight = condensate weight on the METALLIC B band.")
    print("    b_weight→0 means the 'SC' is the A-band single-band bipolaron (CAMPAIGN-CLOSED),")
    print("    NOT the metallic carrier band. We require b_weight ≳ 0.3 for a TRUE two-channel win.")
    print()
    print(f"  {'g_A/t':>6}{'Ω(meV)':>8}{'|Ueff|':>8}{'Jint(FC)':>10}"
          f"{'V_AA':>6}{'V_AB':>7}{'Λ':>6}{'b_wt':>6}{'Tc(K)':>8}{'≥293':>6}  killer")
    rows = []
    cleared_clean = []
    for g_A in [0.54, 0.8, 1.2, 1.6, 2.0]:
        # find the A_point
        ap = next(a for a in A_points if abs(a["g_A"] - g_A) < 1e-6)
        U = ap["U_eff"]; mstar = ap["mstar"]; fc = ap["fc"]
        # Real Ω_A in meV: a SOFT light-atom bond. The softest end that still has the big
        # g_A is LOW Ω (the 9th-law tension). Take Ω_A(meV) tied to Ω_A/t=0.5 with t set so
        # the bond is a real soft H/light mode. Scan a generous Ω_A range to be fair to K3.
        for Omega_A_meV in [50.0, 100.0, 200.0]:
            J0 = 0.3 * U                       # generous bare interband pair-scattering
            J_int = J0 * fc                    # Franck-Condon suppressed (K2)
            tb = two_band_Tc(U, N_A, N_B, J_int, Omega_A_meV, V_BB=0.0)
            b_wt = tb["b_weight"]
            # killer audit (HONEST thresholds)
            killers = []
            # K0 (the decisive one): is the condensate actually ON the metallic B band?
            # b_weight<0.3 => the 'SC' is the A-band single-band bipolaron = CAMPAIGN-CLOSED,
            # NOT the metallic carrier band. This is the central claim's failure mode.
            if b_wt < 0.30:
                killers.append("K0:not-on-B(A-bipolaron=closed)")
            # K2: A-pair self-trap (heavy) at strong g_A -> kills transfer (FC) AND mobility.
            if mstar > 3.0:
                killers.append("K2:A-heavy")
            # K1: deep U_eff at finite density -> bipolaron-CDW/phase-sep on A; interband
            # drags B into CO if V_AB is a sizable fraction of V_AA. (κ-H3 lesson.)
            if U * N_A > 1.0:
                killers.append("K1:A-band-CDW/PS")
            # K3: real room-T ceiling Tc=C·Ω caps the gap-eq (which has no Ω ceiling).
            tc_ceiling = 0.32 * Omega_A_meV * meV2K
            tc_capped = min(tb["Tc_K"], tc_ceiling)
            if tb["Tc_K"] > tc_ceiling:
                killers.append("K3:Ω-ceiling")
            clears = tc_capped >= ROOM_T
            clean = clears and not killers
            kill_s = ",".join(killers) if killers else "—"
            rows.append(dict(g_A=g_A, Omega_A_meV=Omega_A_meV, U_eff=U, J_int=float(J_int),
                             V_AA=tb["V_AA"], V_AB=tb["V_AB"], Lambda=tb["Lambda"],
                             b_weight=b_wt, gap_ratio_BA=tb["gap_ratio_BA"],
                             Tc_K_raw=tb["Tc_K"], Tc_K_capped=float(tc_capped),
                             tc_ceiling=float(tc_ceiling), mstar=mstar,
                             clears=bool(clears), clean=bool(clean), killers=killers))
            if clean:
                cleared_clean.append(rows[-1])
            print(f"  {g_A:>6.2f}{Omega_A_meV:>8.0f}{U:>8.2f}{J_int:>10.2e}"
                  f"{tb['V_AA']:>6.2f}{tb['V_AB']:>7.3f}{tb['Lambda']:>6.2f}{b_wt:>6.3f}"
                  f"{tc_capped:>8.0f}{('YES' if clears else 'no'):>6}  {kill_s}")
    print()

    # ========================================================================
    # (E) VERDICT
    # ========================================================================
    # FAIRNESS: what J_int would it TAKE to put the condensate on B (b_weight≥0.3)?
    # b_weight≥0.3 (eigenvector) needs V_AB ≳ ~0.5·V_AA. Compare that REQUIRED V_AB to the
    # PHYSICAL MAX V_AB (Franck-Condon-suppressed, even at the generous J0=U bound).
    print("STEP 3 — FAIRNESS: required vs achievable interband coupling to pair the B band")
    print("-" * 92)
    print("  To get b_weight≥0.3 (condensate genuinely on metallic B) need V_AB ≳ 0.5·V_AA.")
    print("  Max achievable V_AB = (J0=U)·FC·sqrt(N_A N_B)  [most generous: J0 = full U_eff].")
    print(f"  {'g_A/t':>6}{'V_AA':>7}{'V_AB_req':>10}{'V_AB_max(FC)':>14}{'reachable?':>12}")
    fair = []
    for g_A in [0.54, 0.8, 1.2, 1.6, 2.0]:
        ap = next(a for a in A_points if abs(a["g_A"] - g_A) < 1e-6)
        U = ap["U_eff"]; fc = ap["fc"]
        V_AA = U * N_A
        V_AB_req = 0.5 * V_AA
        V_AB_max = (U * fc) * np.sqrt(N_A * N_B)   # J0 = full U_eff (generous ceiling)
        reach = V_AB_max >= V_AB_req
        fair.append(dict(g_A=g_A, V_AA=float(V_AA), V_AB_req=float(V_AB_req),
                         V_AB_max=float(V_AB_max), reachable=bool(reach)))
        print(f"  {g_A:>6.2f}{V_AA:>7.2f}{V_AB_req:>10.3f}{V_AB_max:>14.3e}"
              f"{('YES' if reach else 'NO'):>12}")
    print()

    print("=" * 92)
    print("VERDICT — does the two-channel decouple clear BOTH axes at 293 K, clean?")
    print("=" * 92)
    if cleared_clean:
        print(f"  🟡 {len(cleared_clean)} point(s) clear 293 K with NO killer flagged — INSPECT:")
        for r in cleared_clean:
            print(f"     g_A={r['g_A']} Ω_A={r['Omega_A_meV']}meV Tc={r['Tc_K_capped']:.0f}K")
        verdict = "SURVIVES_INSPECT"
    else:
        # diagnose the dominant closure axis
        from collections import Counter
        all_k = Counter(k for r in rows for k in r["killers"])
        print("  🔴 NO clean point clears 293 K. Dominant closure axes (count over sweep):")
        for k, c in all_k.most_common():
            print(f"     {k}: {c} points")
        verdict = "CLOSED_NEGATIVE"
    print()
    print("  THE STRUCTURAL TENSION (why decoupling does not rescue it):")
    print("  ───────────────────────────────────────────────────────────────────────")
    print("  Decoupling the bands DOES break the L9 g↔Ω anticorrelation on band A (A can")
    print("  be soft for big g_A; B is stiff/metallic independently). BUT a NEW lock")
    print("  appears on the TRANSFER: the interband pair-scattering J_int that carries the")
    print("  A-glue to the metallic B is FRANCK-CONDON suppressed by exactly exp(-g_A²/2Ω_A²)")
    print("  — the SAME g_A that deepens U_eff. Deep glue on A ⇒ self-trapped A-pair ⇒")
    print("  exponentially small J_int to B ⇒ the metallic band receives almost no pairing.")
    print("  The L9 'same-band' anticorrelation is replaced by a 'transfer' anticorrelation:")
    print("    big U_eff_A (deep glue)  ⇔  tiny J_int (transfer to the carrier band).")
    print("  This is the multiband-assist |Δb|·t**≈const conservation re-expressed in the")
    print("  Suhl-Kondo channel: the coupling strong enough to pair is too localized to")
    print("  transfer. The metallic carrier band stays metallic — but UNPAIRED.")
    print()

    out = dict(A_points=A_points, sweep=rows, fairness=fair,
               cleared_clean=cleared_clean, verdict=verdict)

    def jd(x):
        if isinstance(x, float) and not np.isfinite(x): return None
        if isinstance(x, (np.floating,)): return float(x)
        if isinstance(x, (np.integer,)): return int(x)
        if isinstance(x, (np.bool_,)): return bool(x)
        return str(x)
    p = os.path.join(HERE, "two_band_decouple_results.json")
    with open(p, "w") as f:
        json.dump(out, f, indent=2, default=jd)
    print(f"[done] wrote {p}")
    return out


if __name__ == "__main__":
    main()
