#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""
DENSE-BIPOLARON probe — the n (pair-density) lever on the bond-bipolaron Tc cap.

icon · 🌊 · NAME: dense-bipolaron-density-lever · alias: "push the flat band to half-filling"

CONTEXT (the wall, state/fb-geom-lambda/bond-bipolaron/R2_RESULTS.md):
  R2 computed a real 2D bond-SSH bipolaron (binding |Δb|, mass enh m**) and a
  COMPUTED Tc = min( |Δb| , T_BKT ).  Every flat-band candidate (COF, MATBG) came out
  PHASE-STIFFNESS (BKT) limited, with
        kB T_BKT = C_BKT · t** · n            (t** = t / m**_enh)
  evaluated at a DILUTE pair density n = 0.1 / site.  Result: Tc(COF) ≈ 42 K — a
  tens-of-K cap.  R2's verdict: compact pair ⇔ flat band ⇔ small t ⇔ small t** ⇔ small
  stiffness; the lighter 2D mass only nudges t** ~40%, far short of the ~50× for room-T.

THIS LANE'S LENS (d2 — the n lever):
  T_BKT ∝ t**·n GROWS with pair density n.  R2 sat at n=0.1.  A FLAT band has a huge DOS
  and can host MANY pairs.  Push n up to optimal filling (~½ of the flat band) and ask:
    (1) how does Tc scale with n up to n_opt?
    (2) at n_opt, does Tc cross ~100K+ for sp²C N-Lieb COF / kagome?
    (3) where is the BEC-BCS crossover (n where Tc peaks) and Tc_max there?
    (4) does inter-pair repulsion (Wigner-crystallize / phase-separate) kill the dense
        regime — the honest failure mode?

PHYSICS (honest finite-density, NOT a naive linear extrapolation of R2's n=0.1 line):
  The pairs are hard-core composite bosons living on the lattice.  Their superfluid
  (phase) stiffness — and hence T_BKT — is NOT linear in n forever.  On a lattice of
  hard-core bosons (XY-model mapping), the COM superfluid weight obeys
        ρ_s(n) ∝ t** · n(1 - n_b)          [n_b = boson filling = n / n_max]
  i.e. it RISES with density, PEAKS near half boson-filling, then FALLS as the band
  fills (a particle-hole-symmetric dome — the textbook hard-core-boson / quantum XY
  result; cf. lattice-boson QMC, Trivedi-Ceperley, and the BEC-BCS dome).  n_max is set
  by how many pairs a flat band of width W and N_orb flat orbitals can host before the
  pairs overlap and the bound state dissolves: n_max ≈ (pair size)⁻² but bounded above
  by the flat-band capacity.  We take the pair-lattice picture: a bipolaron occupies a
  region ~ ξ_pair² (ξ_pair from the binding), so n_max ≈ min( n_band_cap , 1/ξ_pair² ).

  On the BCS (overlapping) side the relevant scale is no longer t**·n but the PAIRING
  GAP itself: kB Tc ≲ |Δb|/2 (pair-breaking / Thouless), because once pairs overlap the
  "condensate stiffness" saturates and the gap is the bottleneck.  So the honest dome is

        Tc(n) = min(  T_BKT_dome(n) ,  |Δb|/2  )                       (the cap)
        T_BKT_dome(n) = C_BKT · t** · n_max · 4·n_b(1-n_b)            (peaks at n_b=½)

  with C_BKT fixed by the SAME R2/Zhang-Berciu anchor (Tc/Ω=0.10 at the n=0.1 dilute
  point so the low-density end reproduces R2 bit-for-bit).  The factor 4 normalises the
  dome to peak value C_BKT·t**·n_max at n_b=½ while matching the dilute slope at n→0.

  FAILURE MODE (item 4): if the pairs Wigner-crystallise / phase-separate before n_b=½,
  the superfluid is destroyed (insulating pair-crystal), so the ACHIEVABLE optimum is
  n_b = min(½, n_b_WC).  We model the repulsion-driven instability with a simple
  criterion: the inter-pair Coulomb/hard-core repulsion V_pp competes with the kinetic
  delocalisation t**; the pair lattice freezes (CDW/WC) when V_pp/t** exceeds an O(1)
  threshold.  For an on-site-repulsive composite boson the SF dome SURVIVES to n_b=½
  (the repulsion is what makes it hard-core, not what kills SF) UNLESS a competing
  density-wave commensuration wins — we report both the optimistic (SF to ½) and the
  pessimistic (WC pins the optimum below ½) brackets.

This reuses the R2 solver's COMPUTED binding & mass verbatim (no re-derivation of the
two-particle physics); the ONLY new code is the finite-density dome + crossover + WC
failure check.  mini python only · no pods · no cost.
"""
import json, math, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
R2DIR = os.path.normpath(os.path.join(HERE, '..', 'bond-bipolaron'))

MEV2K = 11.604
ANCHOR_TcO  = 0.10    # Zhang/Berciu PRX 13,011010 light-bipolaron Tc/Ω @ t/Ω~1 (R2 anchor)
ANCHOR_ENH  = 1.104   # R2 computed 2D square-3x3 SSH enh at t/Ω=1,g/Ω=1,Nb=3
ANCHOR_N    = 0.1     # R2 dilute pair density (the anchor point)
# C_BKT fixed exactly as in R2's tc_bkt_over_omega so the dilute end matches R2:
#   kB T_BKT/Ω = C_BKT * (t/enh) * n ,  with C_BKT*1.0*0.1 = 0.10*1.104  →
C_BKT = ANCHOR_TcO * ANCHOR_ENH / (1.0 * ANCHOR_N)   # = 1.104 (so T_BKT/Ω = 1.104*t_pair*n)


def load_r2_candidates():
    """Pull the R2-computed binding/mass/Ω for each candidate (verbatim reuse)."""
    with open(os.path.join(R2DIR, 'results.json')) as f:
        j = json.load(f)
    return j['candidates']


# --- the honest finite-density dome ---------------------------------------------------
def pair_size_xi(binding_over_t):
    """Crude pair radius from binding: deeper binding ⇒ smaller pair (ξ ~ 1/sqrt|Δb/t|),
    floored at 1 lattice const (a compact pair sits on ~1 site).  Returns ξ in lattice
    constants; n_max ≈ 1/ξ² is the overlap-limited max pair density per site."""
    b = abs(binding_over_t)
    xi = 1.0 / math.sqrt(max(b, 1e-6))
    return max(xi, 1.0)


def n_max_capacity(binding_over_t, band_cap=0.5):
    """Max pair density before pairs overlap / band fills.  min(1/ξ² , flat-band cap).
    band_cap = max pairs per site the (half-filled) flat band can hold = 0.5 (½ filling
    of a 1-orbital flat band hosts 0.5 pairs/site at most: 1 electron/site → 0.5 pairs)."""
    xi = pair_size_xi(binding_over_t)
    return min(1.0 / (xi * xi), band_cap)


def tc_dome_over_omega(n, binding_over_O, mstar_enh, t_over_O,
                       wc_threshold=None):
    """Honest Tc(n)/Ω = min( T_BKT_dome(n) , |Δb|/2 ).
    Returns (Tc/Ω, T_BKT_dome/Ω, gap_cap/Ω, limited_by, n_b, n_max)."""
    t_pair = t_over_O / mstar_enh
    binding_over_t = binding_over_O / t_over_O
    nmax = n_max_capacity(binding_over_t)
    if n <= 0 or nmax <= 0:
        return 0.0, 0.0, 0.0, 'none', 0.0, nmax
    n_b = min(n / nmax, 1.0)                      # boson filling fraction of the pair band
    # hard-core-boson SF dome: peaks at n_b=½, normalised so dilute slope = R2 linear line.
    #   dilute limit n→0: n_b→n/nmax, dome→ C_BKT*t_pair*nmax*4*(n/nmax) = 4*C_BKT*t_pair*n
    #   R2 line is C_BKT*t_pair*n, so to MATCH the anchored dilute slope we drop the ×4 and
    #   use n(1-n_b) directly:  T_BKT_dome = C_BKT*t_pair*n*(1-n_b)*2  → dilute slope ×2?
    # Keep the dilute slope IDENTICAL to R2 (so n=0.1 reproduces 42 K): use
    #   T_BKT_dome = C_BKT * t_pair * n * (1 - n_b)/(1 - ANCHOR_N/nmax)  is messy; instead
    # use the clean particle-hole-symmetric stiffness with the R2 slope built in:
    #   rho(n_b) = nmax * n_b(1-n_b)*4   (peaks at nmax at n_b=½, →0 at 0,1; slope 4*nmax at 0)
    #   set T_BKT = C_BKT * t_pair * [n_b(1-n_b)*4] * nmax  ... at small n_b this = 4*C_BKT*t_pair*n
    # To preserve R2's EXACT dilute number we re-anchor C_BKT_dome so the dome's value at
    # n=ANCHOR_N equals R2's linear value there:
    lin_anchor = C_BKT * t_pair * ANCHOR_N                     # R2 value @ n=0.1
    nb_anchor  = min(ANCHOR_N / nmax, 1.0)
    shape_anchor = nb_anchor * (1.0 - nb_anchor) * 4.0
    if shape_anchor <= 0:
        return 0.0, 0.0, 0.0, 'none', n_b, nmax
    # dome scaled so dome(ANCHOR_N) == R2 linear(ANCHOR_N); dome peaks at n_b=½
    shape = n_b * (1.0 - n_b) * 4.0
    tbkt_dome = lin_anchor * (shape / shape_anchor)
    # pairing-gap cap on the overlapping (BCS) side: kB Tc ≲ |Δb|/2
    gap_cap = 0.5 * binding_over_O
    tcO = min(tbkt_dome, gap_cap)
    limited = 'BKT-dome' if tbkt_dome < gap_cap else 'pairing-gap'
    return tcO, tbkt_dome, gap_cap, limited, n_b, nmax


def sweep_candidate(c, n_grid):
    rows = []
    for n in n_grid:
        tcO, tbkt, gap, lim, n_b, nmax = tc_dome_over_omega(
            n, c['binding_over_O'], c['mstar'], c['t_over_O'])
        rows.append(dict(n=n, n_b=n_b, tcO=tcO, tbkt=tbkt, gap_cap=gap,
                         limited=lim, Tc_K=tcO * c['Omega_meV'] * MEV2K))
    return rows, nmax


def find_optimum(rows):
    best = max(rows, key=lambda r: r['tcO'])
    return best


def wigner_crystal_check(c, nmax):
    """Honest failure mode (item 4): do pairs phase-separate / Wigner-crystallise before
    n_b=½?  Composite hard-core bosons with on-site repulsion KEEP a SF dome to n_b=½
    (the repulsion makes them hard-core, the SF survives).  A CDW/WC pinning wins only at
    a commensurate filling if the LONG-RANGE inter-pair V_pp beats the pair kinetic t**.
    Estimate V_pp ~ e²/(ε·d) with d = mean pair spacing = 1/sqrt(n_opt·nmax... ) and the
    pair kinetic = t** = t/enh.  Freeze when V_pp/t** > ~few.  We report the ratio at
    n_b=½ (the would-be optimum) so the verdict is explicit."""
    t_pair_O = c['t_over_O'] / c['mstar']          # t** in Ω units
    # at n_b=1/2 the pair filling is nmax/2 pairs/site → mean spacing d = 1/sqrt(nmax/2)
    n_pairs = nmax / 2.0
    if n_pairs <= 0:
        return dict(applicable=False)
    d = 1.0 / math.sqrt(n_pairs)                    # in lattice constants
    # inter-pair repulsion: composite boson has charge 2e.  In a flat-band host the
    # on-site/short-range Hubbard-screened V dominates; take V_pp ~ U_screened/d with
    # U_screened ~ Ω (the same energy scale; a conservative O(Ω) inter-pair scale).
    # The honest knob is V_pp/t**: if >>1 the pair lattice freezes (insulating WC), if <~1
    # the SF dome survives to ½.  We bracket V_pp ∈ [0.3Ω, 1.0Ω]/d.
    Vpp_lo = 0.3 / d
    Vpp_hi = 1.0 / d
    ratio_lo = Vpp_lo / t_pair_O
    ratio_hi = Vpp_hi / t_pair_O
    # freeze if ratio > ~3 (a standard CDW-vs-SF crossover for lattice bosons)
    freezes_lo = ratio_lo > 3.0
    freezes_hi = ratio_hi > 3.0
    return dict(applicable=True, t_pair_O=t_pair_O, mean_spacing=d,
                Vpp_over_tpair_lo=ratio_lo, Vpp_over_tpair_hi=ratio_hi,
                freezes_optimistic=freezes_lo, freezes_pessimistic=freezes_hi)


def main():
    cands = load_r2_candidates()
    # focus on the recipe-pure FLAT-BAND hosts (item 2: COF / kagome).  Re6Se8Cl2 and
    # graphene-Kekulé are NOT compact (|Δb|<t) so their BEC mapping is untrustworthy (R2);
    # we sweep all four but the headline verdict is for the compact flat-band ones.
    n_grid = [round(x, 3) for x in
              [0.02, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5]]

    out = {'anchor': dict(C_BKT=C_BKT, ANCHOR_TcO=ANCHOR_TcO, ANCHOR_N=ANCHOR_N,
                          ANCHOR_ENH=ANCHOR_ENH),
           'candidates': {}}

    print("=" * 104)
    print("DENSE-BIPOLARON — the n (pair-density) lever on the bond-bipolaron Tc cap")
    print("  Tc(n)/Ω = min( T_BKT_dome(n) [hard-core-boson SF, peaks n_b=½] , |Δb|/2 [pairing-gap cap] )")
    print("  dilute end (n=0.1) reproduces R2 by construction (same Zhang/Berciu anchor).")
    print("=" * 104)

    for c in cands:
        rows, nmax = sweep_candidate(c, n_grid)
        best = find_optimum(rows)
        wc = wigner_crystal_check(c, nmax)
        compact = c.get('compact_pair', False)

        print(f"\n### {c['name']}   (t/Ω={c['t_over_O']}, |Δb|/Ω={c['binding_over_O']:.3f}, "
              f"m**enh={c['mstar']:.3f}, Ω={c['Omega_meV']} meV, compact={compact})")
        print(f"  n_max(pair capacity) = {nmax:.3f} pairs/site   t**/Ω = {c['t_over_O']/c['mstar']:.3f}")
        print(f"  {'n':>6}{'n_b':>7}{'TBKTdome/Ω':>12}{'gap/2/Ω':>9}{'Tc/Ω':>8}{'limited':>13}{'Tc_K':>9}")
        for r in rows:
            mark = '  <-- R2 anchor (n=0.1)' if abs(r['n'] - 0.1) < 1e-9 else ''
            mark += '  *** n_opt' if r is best else ''
            print(f"  {r['n']:>6.3f}{r['n_b']:>7.3f}{r['tbkt']:>12.4f}{r['gap_cap']:>9.4f}"
                  f"{r['tcO']:>8.4f}{r['limited']:>13}{r['Tc_K']:>9.1f}{mark}")
        print(f"  → n_opt = {best['n']:.3f} (n_b={best['n_b']:.3f}), "
              f"Tc_max = {best['tcO']:.4f} Ω = {best['Tc_K']:.1f} K, limited by {best['limited']}")
        # R2 dilute number for the same candidate
        r2row = next(r for r in rows if abs(r['n'] - 0.1) < 1e-9)
        gain = best['Tc_K'] / r2row['Tc_K'] if r2row['Tc_K'] > 0 else float('inf')
        print(f"  → density GAIN vs R2 dilute (n=0.1, {r2row['Tc_K']:.1f} K): ×{gain:.2f}")
        if wc.get('applicable'):
            print(f"  → Wigner-crystal / phase-sep check at n_b=½: V_pp/t** ∈ "
                  f"[{wc['Vpp_over_tpair_lo']:.2f}, {wc['Vpp_over_tpair_hi']:.2f}] "
                  f"(freeze if >3) → optimistic_freeze={wc['freezes_optimistic']}, "
                  f"pessimistic_freeze={wc['freezes_pessimistic']}")

        out['candidates'][c['name']] = dict(
            t_over_O=c['t_over_O'], binding_over_O=c['binding_over_O'], mstar=c['mstar'],
            Omega_meV=c['Omega_meV'], compact=compact, n_max=nmax,
            sweep=rows, n_opt=best['n'], n_b_opt=best['n_b'],
            Tc_max_over_O=best['tcO'], Tc_max_K=best['Tc_K'], limited_by=best['limited'],
            R2_dilute_Tc_K=r2row['Tc_K'], density_gain=gain, wigner=wc)

    # ---- headline verdict on the compact flat-band hosts -------------------------------
    cof = out['candidates']['sp2C N-Lieb COF']
    print("\n" + "=" * 104)
    print("HEADLINE — recipe-pure flat-band host sp²C N-Lieb COF (the compact pair):")
    print(f"  R2 dilute (n=0.1):  {cof['R2_dilute_Tc_K']:.1f} K")
    print(f"  dense  n_opt={cof['n_opt']:.3f} (n_b={cof['n_b_opt']:.2f}):  Tc_max = {cof['Tc_max_K']:.1f} K "
          f"(×{cof['density_gain']:.2f}), limited by {cof['limited_by']}")
    crosses_100 = cof['Tc_max_K'] >= 100.0
    breaks_cap  = cof['Tc_max_K'] >= 80.0     # "≫ tens-of-K" bar
    print(f"  crosses 100K+? {crosses_100}   breaks tens-of-K cap (≥80K)? {breaks_cap}")
    out['verdict'] = dict(
        cof_R2_K=cof['R2_dilute_Tc_K'], cof_dense_K=cof['Tc_max_K'],
        cof_n_opt=cof['n_opt'], cof_gain=cof['density_gain'],
        cof_limited_by=cof['limited_by'], crosses_100K=crosses_100,
        breaks_tens_of_K_cap=breaks_cap)

    with open(os.path.join(HERE, 'results.json'), 'w') as f:
        json.dump(out, f, indent=2)
    print(f"\nwrote {os.path.join(HERE, 'results.json')}")


if __name__ == '__main__':
    main()
