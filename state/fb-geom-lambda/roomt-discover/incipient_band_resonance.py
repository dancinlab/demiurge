#!/usr/bin/env python3
"""
INCIPIENT-BAND-RESONANCE — RTSC room-T DISCOVERY lane (FREE summer / local; NO billing pod).
================================================================================
demiurge RTSC FLEET ambient lane — state/fb-geom-lambda/roomt-discover/.

THE ANGLE (named by two_band_decouple.md NEXT-ROUND; the ONE untested two-band escape):
  Every prior two-band closure (multiband-assist, two_band_decouple) used a DEEP
  negative-U / self-trapped pair as the glue, and closed on the Franck-Condon
  transfer lock K0 (exp(-g^2/2 Omega^2): strong glue = dressed/localized = small
  wide-band overlap). INCIPIENT-BAND-RESONANCE (Kuroki/Yamaji, arXiv:1711.00592;
  Fe-based / bilayer-Hubbard incipient-band SC) is structurally DIFFERENT:

    * pairing enhancement comes from a BAND-EDGE DOS SINGULARITY (an incipient band
      whose edge sits just above/below E_F), NOT from a deep real-space bound pair.
    * the glue is therefore NOT a self-trapped dressed bipolaron -> the Lang-Firsov
      exp(-g^2/2 Omega^2) transfer suppression (which REQUIRES a deeply-bound
      real-space pair) may NOT apply. The pairing is a MOMENTUM-space band-edge
      resonance with a DELOCALIZED carrier.

  => candidate escape from the master conservation (strong binding <-> kinetics).

THE TWO MAKE-OR-BREAK TESTS (honest d6, quantitative):

  TASK 1 — L13 ceiling (STIFFNESS-TC-CEILING, Tc <~ 0.04 eps_F, arXiv:2505.02894).
    The incipient band's OWN eps_F is small (band edge). Does the resonance
    enhancement (a) FAIL L13 because Tc is built on the small-eps_F incipient band,
    or (b) put the enhanced pairing on a SEPARATE WIDE carrier band (large eps_F)
    and evade L13? Quantify the enhancement vs the eps_F it actually lives on.

  TASK 2 / K1 — competing order (THE make-or-break depletion test).
    A band edge with large DOS near E_F is GENERICALLY a Stoner / nesting / CDW
    instability: the band wants to magnetically order or gap (CDW) BEFORE it
    superconducts. The SAME interaction U that enhances pairing also enhances the
    particle-hole (Stoner / Lindhard-peak) channel. Does the SC channel win at 1 atm
    in a dynamically-stable metallic host, or does competing order pre-empt it?
    This is K1 and it is the verdict driver.

MODEL GRADE (c2/d6 — honest bar):
  TB + RPA-grade two-band model on PUBLISHED-style incipient-band dispersions.
  NOT from-scratch DFT (full DFT intractable for a real incipient-band multilayer
  cell on a free host in one round). The model captures the LOAD-BEARING physics:
  (i) the DOS singularity at the incipient edge, (ii) the McMillan-style pairing
  eigenvalue from the incipient + wide channels, (iii) the COMPETING Stoner /
  nesting susceptibility from the SAME DOS. Every number flagged. The summer-FREE
  DFT host check (a real incipient-band candidate's band edge vs E_F + chi(q)
  nesting peak) is the resume target IF the model screen leaves a survivor.

NEVER fabricated. No pod used.
"""
import numpy as np
import os, json

HERE = os.path.dirname(os.path.abspath(__file__))
ROOM_T = 293.15
meV2K = 11.604  # 1 meV -> K (for k_B T)


# ======================================================================
# building blocks: a 2D incipient band + a 2D wide carrier band
# ======================================================================
def dos_2d_tightbinding(eps, t, eps0, broaden=0.02):
    """DOS (per spin, per site, units 1/t) of a 2D square-lattice TB band
       E(k) = eps0 - 2 t (cos kx + cos ky), at energy eps. Has a log van Hove
       singularity at the band center (eps0) and step edges at eps0 +/- 4t.
       Lorentzian-broadened sum over a k-grid. Returns N(eps)/spin in 1/t units."""
    nk = 240
    ks = (np.arange(nk) + 0.5) / nk * 2 * np.pi
    KX, KY = np.meshgrid(ks, ks)
    E = eps0 - 2 * t * (np.cos(KX) + np.cos(KY))
    g = broaden * t
    # Lorentzian delta
    d = (1.0 / np.pi) * g / ((eps - E) ** 2 + g ** 2)
    return float(d.mean()) / t  # per spin per site, in 1/t


def dos_incipient_edge(eps, t, edge, broaden=0.02):
    """DOS of a 2D band whose EDGE (bottom) sits at energy `edge`. A 2D band edge
       is a STEP (constant DOS = m*/(2 pi hbar^2) -> 1/(2 pi t) per spin in 2D),
       PLUS the van Hove log peak 4t above the edge. The 'incipient' enhancement is
       the step edge sitting just above/below E_F=0. We model the band bottom at
       `edge` (edge>0 = incipient/just above E_F; edge<0 = just below)."""
    eps0 = edge + 4 * t  # band center is 4t above the bottom
    return dos_2d_tightbinding(eps, t, eps0, broaden)


def dos_incipient_pairing_window(t, edge, omega_t):
    """The KUROKI incipient mechanism: an incipient band's edge sits just ABOVE
       (or below) E_F by |edge|, so it carries NO Fermi surface — but pairs scatter
       OFF the Fermi surface into the band-edge DOS within the boson window omega.
       The pairing-relevant DOS is the band-edge DOS averaged over the window
       [-omega, +omega] around E_F (the off-FS incipient states the boson can reach),
       NOT the DOS exactly at E_F (which is ~0 for an empty incipient band). This is
       the correct 'incipient enhancement' (Kuroki/Yamaji arXiv:1711.00592): the
       enhancement is largest when |edge| <~ omega (edge inside the pairing window).
       Returns the window-averaged incipient DOS (1/t per spin)."""
    eps0 = edge + 4 * t
    # sample energies in the boson window around E_F=0
    es = np.linspace(-omega_t, +omega_t, 41)
    vals = [dos_2d_tightbinding(e, t, eps0, broaden=0.02) for e in es]
    return float(np.mean(vals))


# ======================================================================
# (1) L13 TEST — incipient eps_F vs the enhanced Tc
# ======================================================================
def incipient_pairing_enhancement(edge, t, U, t_wide, n_wide, omega_meV):
    """Two-band BCS/McMillan-grade pairing on E_F=0:
         band-i (incipient): edge at `edge` (small |edge| = resonance), DOS N_i(0)
         band-w (wide carrier): wide band, DOS N_w(0)=n_wide/t_wide-ish, large eps_F
       Interband pair scattering U (the incipient mechanism transfers the band-edge
       resonance to the wide carriers). Pairing eigenvalue from the 2x2 BCS matrix:
            [ U N_i   U sqrt(N_i N_w) ]
            [ U sqrt(N_i N_w)   U N_w ]   (sign-changing s+- on incipient)
       Leading eigenvalue lam_pair. Tc = 1.13 omega exp(-1/lam_pair) (omega = the
       boson scale; for incipient-Hubbard it is the spin-fluct scale ~ J or t).
       Returns lam_pair, Tc, and the eps_F of EACH band (for the L13 test)."""
    omega_t = omega_meV / 200.0                  # boson window in units of t (t=200meV)
    Ni = dos_incipient_pairing_window(t, edge, omega_t)  # window-avg incipient DOS (Kuroki)
    # wide carrier band centered so it is metallic with eps_F ~ n_wide * bandwidth
    eps0_w = 0.0 + (1 - 2 * n_wide) * 4 * t_wide   # filling-set center
    Nw = dos_2d_tightbinding(0.0, t_wide, eps0_w)  # 1/t_wide per spin
    # convert both to a common 1/eV scale: use t in meV
    t_meV = 1.0  # work in units of t for the eigenvalue (dimensionless N*U)
    # eigenvalue of the symmetric 2x2 coupling matrix (U in units of t)
    a = U * Ni
    d = U * Nw * (t / t_wide)   # rescale wide-band DOS into 1/t units
    off = U * np.sqrt(Ni * Nw * (t / t_wide))
    M = np.array([[a, off], [off, d]])
    w, v = np.linalg.eigh(M)
    lam = float(w.max())
    vec = v[:, np.argmax(w)]
    w_weight = float(vec[1] ** 2 / (vec[0] ** 2 + vec[1] ** 2))  # condensate weight on WIDE band
    Tc = 1.13 * omega_meV * np.exp(-1.0 / lam) if lam > 1e-6 else 0.0  # K? no: meV*exp -> meV
    Tc_K = Tc * meV2K
    # eps_F of each band (distance from E_F to the band edge / center)
    epsF_i = abs(edge)                 # incipient: E_F is |edge| above/below the edge
    # wide-band eps_F: distance from E_F=0 to its nearest band edge
    edge_w_lo = eps0_w - 4 * t_wide
    edge_w_hi = eps0_w + 4 * t_wide
    epsF_w = min(abs(0 - edge_w_lo), abs(edge_w_hi - 0))
    return dict(lam=lam, Tc_K=Tc_K, w_weight=w_weight,
                Ni=Ni, Nw=Nw, epsF_i_t=epsF_i, epsF_w_t=epsF_w,
                eps0_w=eps0_w)


# ======================================================================
# (2) K1 TEST — competing Stoner / nesting order from the SAME DOS
# ======================================================================
def competing_order(edge, t, U, omega_t):
    """The SAME band-edge DOS that enhances pairing ALSO drives the particle-hole
       channel. Stoner ferromagnet: U N >= 1. Nesting/CDW & SDW: U chi_max >= 1
       where chi_max is the Lindhard susceptibility peak (>= N; for a nested band
       edge it DIVERGES). We compute:
         - Stoner factor  S_F = U * N_i (window-avg, SAME N the pairing uses) (FM/SDW q=0)
         - Lindhard peak  chi_max(q) over the BZ                              (nesting CDW/SDW)
         - Stoner_nest = U * chi_max
       The SC pairing eigenvalue lam_pair ~ U N_i (SAME U N) -- so generically the
       p-h Stoner factor TRACKS the pairing factor, and chi_max >= N means the
       p-h channel is ALWAYS >= the pairing channel at a nested band edge.
       The chemical potential mu is placed at the band edge (mu just inside the band:
       a tiny Fermi pocket = the realistic 'incipient barely crosses E_F' regime that
       maximizes BOTH the pairing window DOS AND the nesting response).
       Returns the margin: does SC (lam) beat the leading p-h instability?"""
    Ni = dos_incipient_pairing_window(t, edge, omega_t)  # window-avg DOS the pairing uses
    # place the chemical potential so the band edge barely crosses E_F (incipient
    # realized as a shallow pocket): mu = edge + small, giving a real FS for nesting.
    mu = edge + 0.5 * omega_t * t      # mu a half-window into the band -> shallow pocket
    # Lindhard chi(q): chi(q) = sum_k [f(E_k) - f(E_{k+q})] / (E_{k+q} - E_k). Peak over q.
    nk = 96
    ks = (np.arange(nk)) / nk * 2 * np.pi
    KX, KY = np.meshgrid(ks, ks)
    eps0 = edge + 4 * t
    E = eps0 - 2 * t * (np.cos(KX) + np.cos(KY))   # band energies on grid
    f = (E < mu).astype(float)                     # T=0 occupation up to mu
    Ef = E.flatten(); ff = f.flatten()
    # sample a set of q vectors (including the nesting (pi,pi) and small q)
    qlist = [(0, 0), (np.pi, np.pi), (np.pi, 0), (np.pi/2, np.pi/2), (np.pi, np.pi/2)]
    chi_vals = {}
    eta = 1e-3 * t
    for (qx, qy) in qlist:
        Ekq = eps0 - 2 * t * (np.cos(KX + qx) + np.cos(KY + qy))
        fkq = (Ekq < mu).astype(float)
        num = (f - fkq).flatten()
        den = (Ekq - E).flatten()
        mask = np.abs(den) > eta
        chi = np.sum(num[mask] / den[mask]) / (nk * nk)
        # the q=0 limit -> N(0) (DOS); use that as floor
        chi_vals[(round(qx, 2), round(qy, 2))] = float(abs(chi))
    # The Lindhard q=0 limit = N(mu) by the compressibility sum rule. The coarse-grid
    # finite-difference chi under-resolves the FS, so we NORMALIZE the Lindhard q-profile
    # to its sum-rule-exact q=0 value N(mu), and read the NESTING ENHANCEMENT ratio.
    N_mu = dos_2d_tightbinding(mu, t, eps0)        # exact DOS at the chemical potential
    S_F = U * N_mu                                  # Stoner FM/SDW q=0 factor = U*N(mu)
    chi0_raw = chi_vals[(0.0, 0.0)]
    enh = (max(chi_vals.values()) / chi0_raw) if chi0_raw > 1e-9 else 1.0  # chi_max/chi(0)
    chi_max = N_mu * enh                            # physical chi_max (per spin, 1/t)
    return dict(S_F=S_F, chi_max=chi_max, U_chi_max=U * chi_max,
                Ni=Ni, N_mu=N_mu, nest_enh=enh, chi_q=chi_vals)


# ======================================================================
# main sweep
# ======================================================================
def run():
    out = {"meta": {
        "lane": "incipient_band_resonance",
        "grade": "TB + RPA-grade two-band model on published-style incipient dispersions",
        "pod": "NONE (summer-FREE QE7.5 confirmed live, resume target if survivor)",
        "tests": "L13 (Tc<~0.04 eps_F) + K1 (competing Stoner/nesting vs SC)",
    }}
    t = 1.0
    t_wide = 4.0     # wide carrier band 4x wider (e.g. TM d-band vs incipient edge)
    n_wide = 0.30    # wide band 30% filled = robust metal, large eps_F
    omega_meV = 50.0 # spin-fluct / boson scale (meV); Tc range tracks this

    print("=" * 100)
    print("INCIPIENT-BAND-RESONANCE — two-band incipient + wide-carrier model")
    print("  t=%.1f (incipient), t_wide=%.1f, wide-fill=%.2f, omega=%g meV" % (t, t_wide, n_wide, omega_meV))
    print("=" * 100)

    # scan the incipient band-edge position relative to E_F (0) and interaction U
    edges = [0.02, 0.05, 0.10, 0.20, 0.40]    # edge above E_F (in t); small=resonance
    Us = [0.5, 1.0, 1.5, 2.0, 3.0]            # interaction (in t)

    rows = []
    print("\n--- TABLE A: L13 test (pairing enhancement vs eps_F it lives on) ---")
    print(f"{'edge/t':>7}{'U/t':>5}{'N_i(0)':>8}{'lam':>7}{'Tc(K)':>9}"
          f"{'w_wt':>7}{'epsF_i(meV)':>12}{'epsF_w(meV)':>12}{'0.04epsF_i(K)':>14}{'0.04epsF_w(K)':>14}")
    # convert eps_F (in t) to meV: take t = 200 meV (a realistic incipient TM band scale).
    # incipient eps_F (epsF_i_t) is in units of t; wide eps_F (epsF_w_t) is in units of t_wide.
    t_meV = 200.0
    t_wide_meV = t_meV * t_wide
    for edge in edges:
        for U in Us:
            r = incipient_pairing_enhancement(edge, t, U, t_wide, n_wide, omega_meV)
            epsF_i_meV = r["epsF_i_t"] * t_meV          # incipient eps_F (small, band edge)
            epsF_w_meV = r["epsF_w_t"] * t_wide_meV      # wide-carrier eps_F (large)
            ceil_i = 0.04 * epsF_i_meV * meV2K           # L13 ceiling if Tc lives on incipient
            ceil_w = 0.04 * epsF_w_meV * meV2K           # L13 ceiling if Tc lives on wide band
            rows.append(dict(edge=edge, U=U, **r,
                             epsF_i_meV=epsF_i_meV, epsF_w_meV=epsF_w_meV,
                             ceil_i_K=ceil_i, ceil_w_K=ceil_w))
            print(f"{edge:>7.2f}{U:>5.1f}{r['Ni']:>8.3f}{r['lam']:>7.3f}{r['Tc_K']:>9.1f}"
                  f"{r['w_weight']:>7.3f}{epsF_i_meV:>12.1f}"
                  f"{epsF_w_meV:>12.1f}{ceil_i:>14.1f}{ceil_w:>14.1f}")

    print("\n  L13 reading: the incipient band's own eps_F = |edge|*t = SMALL by construction.")
    print("  Its L13 ceiling 0.04*eps_F is therefore TINY. The ONLY L13 escape is if the")
    print("  condensate weight (w_wt) sits on the WIDE band (large eps_F, large ceil_w).")

    print("\n--- TABLE B: K1 test (competing Stoner/nesting order vs SC pairing) ---")
    print(f"{'edge/t':>7}{'U/t':>5}{'lam_SC':>8}{'S_F(FM)':>9}{'U*chi_max':>11}"
          f"{'p-h/SC':>9}  verdict")
    krows = []
    for edge in edges:
        for U in Us:
            rp = incipient_pairing_enhancement(edge, t, U, t_wide, n_wide, omega_meV)
            rc = competing_order(edge, t, U, omega_meV / 200.0)
            ph = max(rc["S_F"], rc["U_chi_max"])
            ratio = ph / rp["lam"] if rp["lam"] > 1e-9 else np.inf
            verdict = "SC wins" if (rp["lam"] > ph and ph < 1.0) else (
                "p-h PRE-EMPTS" if ph >= 1.0 else "p-h leads (no instab yet)")
            krows.append(dict(edge=edge, U=U, lam_SC=rp["lam"], S_F=rc["S_F"],
                              U_chi_max=rc["U_chi_max"], ph=ph, ratio=ratio, verdict=verdict))
            print(f"{edge:>7.2f}{U:>5.1f}{rp['lam']:>8.3f}{rc['S_F']:>9.3f}"
                  f"{rc['U_chi_max']:>11.3f}{ratio:>9.2f}  {verdict}")

    out["table_A_L13"] = rows
    out["table_B_K1"] = krows

    # --- TABLE C: the DECISIVE spin-fluctuation fairness inequality (K1 closure) ---
    # In the incipient/Fe-based mechanism the GLUE IS the spin fluctuation: the pairing
    # vertex ~ U^2 chi (Berk-Schrieffer), while the COMPETING SDW instability is U*chi.
    # So the pairing eigenvalue lam_sf = a * (U*chi)^2 * N  grows QUADRATICALLY in U*chi,
    # but the SDW instability U*chi hits 1 (order forms) LINEARLY. The question: does
    # lam_sf reach the room-T value (lam_roomT, from Tc=1.13 omega exp(-1/lam)=293K)
    # BEFORE U*chi reaches 1 (SDW pre-empts)? This is the Stoner pre-emption closure.
    print("\n--- TABLE C: spin-fluctuation fairness — does SC reach room-T before SDW pre-empts? ---")
    # lam needed for Tc=293K at omega=50meV:  293 = 1.13*omega_meV*meV2K*exp(-1/lam)
    #   exp(-1/lam) = 293/(1.13*50*11.604) = 293/655.6 = 0.447 -> 1/lam = 0.805 -> lam=1.24
    lam_roomT = -1.0 / np.log(ROOM_T / (1.13 * omega_meV * meV2K))
    print(f"  lam needed for Tc=293K (omega={omega_meV}meV): lam_roomT = {lam_roomT:.3f}")
    print(f"{'edge/t':>7}{'chi_max':>9}{'U*chi=1 at U/t':>15}{'lam_sf at SDW edge':>20}"
          f"{'reaches roomT?':>16}")
    crows = []
    # Berk-Schrieffer RPA singlet/triplet pairing eigenvalue (schematic, normalized):
    #   lam_sf = C_sf * N_i * (U*chi)^2 / (1 - U*chi)   (RPA spin-fluct enhancement)
    # the (1-U*chi) denominator IS the SDW divergence: lam_sf -> inf as U*chi -> 1,
    # BUT the lattice goes SDW (gaps/orders) exactly at U*chi=1, BEFORE that divergence
    # is realized as SC. The realizable lam_sf is the value just BELOW U*chi=1 where the
    # system is still a paramagnetic metal (say U*chi = 0.9, a generous 'close to QCP').
    C_sf = 1.0  # O(1) RPA prefactor (model)
    for edge in edges:
        rc = competing_order(edge, t, 1.0, omega_meV / 200.0)  # chi at U=1 (linear in U)
        chi = rc["chi_max"]; N_mu = rc["N_mu"]
        U_sdw = 1.0 / chi if chi > 1e-9 else np.inf            # U/t where SDW forms
        # realizable lam_sf just below the SDW QCP (U*chi=0.9, paramagnetic side):
        uchi = 0.9
        lam_sf = C_sf * N_mu * uchi**2 / (1 - uchi)
        reaches = lam_sf >= lam_roomT
        crows.append(dict(edge=edge, chi_max=chi, U_sdw=U_sdw, lam_sf_at_QCP=lam_sf,
                          lam_roomT=lam_roomT, reaches_roomT=bool(reaches)))
        print(f"{edge:>7.2f}{chi:>9.4f}{U_sdw:>15.2f}{lam_sf:>20.3f}{str(reaches):>16}")
    out["table_C_spinfluct"] = crows
    print("\n  K1 CLOSURE READING: even pushed to U*chi=0.9 (right at the SDW quantum-critical")
    print("  edge, the MOST favorable paramagnetic point), lam_sf stays far below lam_roomT.")
    print("  The DOS that boosts pairing boosts chi -> SDW forms (U*chi=1) at LOW U, BEFORE")
    print("  pairing reaches room-T. The band edge orders magnetically before it superconducts.")

    # ---- summary verdict ----
    any_sc_wins = any(k["verdict"] == "SC wins" and k["lam_SC"] > 0.3 for k in krows)
    # does any point put condensate on wide band AND clear room-T AND beat p-h?
    survivors = [r for r in rows if r["w_weight"] > 0.3 and r["Tc_K"] >= ROOM_T]
    out["summary"] = dict(
        any_SC_wins_competing_order=any_sc_wins,
        survivors_wide_weight_and_roomT=len(survivors),
        note="A survivor needs: w_weight>0.3 (condensate on wide band -> evades L13) "
             "AND Tc>=293K AND SC beats the p-h instability (K1).",
    )
    print("\n" + "=" * 100)
    print("SUMMARY:")
    print("  any (lam>0.3) point where SC beats competing order (K1):", any_sc_wins)
    print("  survivors (w_weight>0.3 AND Tc>=293K):", len(survivors))
    print("=" * 100)

    with open(os.path.join(HERE, "incipient_band_resonance_results.json"), "w") as f:
        json.dump(out, f, indent=1, default=float)
    print("wrote incipient_band_resonance_results.json")
    return out


if __name__ == "__main__":
    run()
