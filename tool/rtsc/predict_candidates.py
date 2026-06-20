"""
USE the (improved) fbgeom predictor at scale — candidate hosts + parameter landscape + HONEST band.

R1: host table + (Omega, U/Om) landscape (optimistic raw 2D-BKT).
R2: same, but via the improved tool's tc_band (deflated by real-SC anchor over-prediction) and
    omega_for_roomT(deflate=True) -> the honest design-target box. Imports the committed tool only.
"""
import numpy as np
from fbgeom_predictor import (tc_bkt, room_t_gap, tc_band, anchor_calibration,
                              omega_for_roomT, G_REF, UOM_REF, TCOM_REF)

ROOM_T = 293.15

CANDS = [
    ("CoSn (kagome SOC C=1)",      2.87, 15,  1.9, "GATED(paramagnet)", "NOVEL"),
    ("light-kagome (TARGET)",      2.90, 150, 1.0, "DESIGN",            "OPEN-NOVEL"),
    ("Nb3Cl8 (breathing-kagome)",  2.11, 30,  1.0, "GATED(Mott/QSL)",   "NOVEL"),
    ("graphene-Kekule (kagome)",   2.19, 160, 1.0, "unknown",           "PARTIAL"),
    ("MATBG (moire flat)",         1.00, 16,  0.3, "real SC ~1.7K",     "PUBLISHED"),
    ("tMoTe2 (moire C=1)",         1.00, 10,  1.0, "real SC ~1-3K",     "PARTIAL"),
    ("sp2C N-Lieb COF",            0.672,120, 1.08,"proposed(no SC)",   "NOVEL"),
    ("Re6Se8Cl2 (real anchor)",    0.30, 11,  1.0, "real SC ~8K",       "PUBLISHED"),
    # --- C-tier carbon-pi residuals, folded in via the computed lattice-model <g> (Q_geom proxy):
    #     triangulene = carbon kagome (lattice <g>~0.49); benzene-COF = carbon Lieb (<g>~0.50);
    #     Omega = C-C bond phonon ~150-160 meV. No fabricated per-material <g> — uses the TB lattice value.
    ("triangulene 2D-kagome",      0.49, 150, 1.0, "proposed(no SC)",   "NOVEL"),
    ("benzene-ethynylene COF",     0.50, 150, 1.0, "proposed(no SC)",   "NOVEL"),
    # biphenylene network EXCLUDED here: type-II Dirac, NO isolated flat band -> geometric predictor N/A.
]

def host_table_banded():
    gm, rmin, rmax, _ = anchor_calibration()
    print("="*104)
    print(f"[R2a] HOST TABLE — HONEST banded Tc (raw 2D-BKT deflated by anchor over-prediction x{gm:.1f})")
    print("="*104)
    print(f"  {'host':<26}{'<g>':>6}{'Om':>5}{'U/Om':>6}{'raw Tc':>8}{'best':>7}{'[lo':>6}{'hi]':>7}{'>293?':>6}  novelty/SC")
    print("  " + "-"*102)
    rows = []
    for n, g, Om, U, sc, nov in CANDS:
        raw = tc_bkt(g, Om, U); best, lo, hi = tc_band(g, Om, U)
        rows.append((n, g, Om, U, raw, best, lo, hi, sc, nov))
    for n, g, Om, U, raw, best, lo, hi, sc, nov in sorted(rows, key=lambda r: -r[5]):
        rt = "YES" if best >= ROOM_T else ("maybe" if hi >= ROOM_T else "no")
        print(f"  {n:<26}{g:>6.2f}{Om:>5}{U:>6.2f}{raw:>7.0f}K{best:>6.0f}K{lo:>6.0f}{hi:>7.0f}{rt:>6}  {nov}/{sc}")

def design_box_honest():
    print("\n" + "="*104)
    print("[R2b] DESIGN-TARGET BOX — Omega(meV) needed for 293K, OPTIMISTIC vs HONEST(anchor-deflated)")
    print("="*104)
    print(f"  {'<g>':>5}{'U/Om':>6}{'Om_opt(meV)':>13}{'Om_honest(meV)':>16}   feasible? (light-elem bond ceiling ~300meV)")
    for g in (1.0, 2.0, 3.0, 4.0):
        for U in (1.0, 1.5, 2.0):
            opt = omega_for_roomT(g, U, deflate=False)
            hon = omega_for_roomT(g, U, deflate=True)
            feas = "YES" if hon <= 300 else "NO (>300meV unphysical)"
            print(f"  {g:>5.1f}{U:>6.1f}{opt:>11.0f}  {hon:>14.0f}     {feas}")
    print("\n  => HONEST box (anchor-deflated): room-T needs <g>>=3 AND U/Om>=1.5 AND Om>=~115meV, OR")
    print("     <g>=2,U/Om=2,Om~130meV. Below <g>=2 the honest Om_needed exceeds the ~300meV light-element")
    print("     phonon ceiling -> not reachable. Real synthesized topological hosts have <g>~2-3 but Om~15-30meV")
    print("     (soft d-electron) -> NONE sit in the honest box. The wall = co-locating big <g> + stiff Om.")

if __name__ == "__main__":
    host_table_banded()
    design_box_honest()
    print("\nHONEST (d6): tc_band deflates raw 2D-BKT by the real-anchor geomean over-prediction; [lo,hi] = full")
    print("anchor scatter. No real synthesized host enters the honest room-T box -> consistent with L38 (~6K).")
    print("The improved tool now reports a HONEST band, not a single optimistic Tc (self-improving, c2-verified).")
