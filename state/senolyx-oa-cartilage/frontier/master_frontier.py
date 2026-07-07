#!/usr/bin/env python3
"""SENOLYX OA-cartilage — Step 0: master feasibility frontier.

The OA cure-gate (mass-weighted regeneration ceiling >= 0.90) rewritten with the two
cartilage-unique factors absent from the 3 vascularized sister-cures:
  delta (in [0,1]) = avascular intra-articular DELIVERY fraction (phi_eff = delta*phi)
  A     (in [0,1]) = anabolic competence gating acellular chondral NEOGENESIS

class ceiling (phi = 1 clearance):
  eta_rev  = 0.90                     mass 0.35
  eta_dorm = 0.75 + 0.25*delta        mass 0.30   (progenitor reactivation, weakly A-dependent)
  eta_lost = 0.40 + 0.60*delta*A      mass 0.35   (acellular neogenesis, anabolic-gated)

  Ceiling(delta,A) = 0.68 + 0.075*delta + 0.21*delta*A
  GATE (>=0.90)  <=>  delta*(0.075 + 0.21*A) >= 0.22   [MASTER FRONTIER]

No fitting. Pure gate arithmetic (d6: report the frontier, never a forced point).
"""
import numpy as np

GATE = 0.90
BASE = 0.68  # ceiling at delta=0 (no senolytic delivery reaches lesion)


def ceiling(delta, A):
    return BASE + 0.075 * delta + 0.21 * delta * A


def ceiling_capped(delta, A):
    """PHYSICAL ceiling with per-class eta <= 1.0 cap (each class cannot over-regenerate).
    The uncapped linear form lets eta_dorm=0.75+0.25*delta exceed 1 for delta>1, which is
    unphysical -- that is why the naive A=0 -> delta>=2.93 corner is a MODEL ARTIFACT."""
    eta_rev = 0.90
    eta_dorm = min(1.0, 0.75 + 0.25 * delta)
    eta_lost = min(1.0, 0.40 + 0.60 * delta * A)
    return 0.35 * eta_rev + 0.30 * eta_dorm + 0.35 * eta_lost


def gate_lhs(delta, A):
    return delta * (0.075 + 0.21 * A)  # must be >= 0.22 (valid only where eta<=1 not binding)


def corner_readings():
    out = {}
    # A = 1 -> delta >= 0.22/0.285
    out["A=1_delta_crit"] = 0.22 / (0.075 + 0.21 * 1.0)
    # delta = 1 -> A >= (0.22-0.075)/0.21
    out["delta=1_A_crit"] = (0.22 - 0.075) / 0.21
    # A = 0 -> delta >= 0.22/0.075
    out["A=0_delta_crit"] = 0.22 / 0.075
    return out


def admissible_fraction(n=2001):
    d = np.linspace(0, 1, n)
    a = np.linspace(0, 1, n)
    D, Aa = np.meshgrid(d, a)
    ok = gate_lhs(D, Aa) >= 0.22
    return ok.mean(), D, Aa, ok


def main():
    print("== SENOLYX OA-cartilage :: Step 0 master frontier ==")
    print(f"GATE >= {GATE}   MASTER: delta*(0.075 + 0.21*A) >= 0.22\n")

    print("Corner readings (fix the verdict):")
    c = corner_readings()
    print(f"  A=1 (perfect anabolic)  -> delta_crit = {c['A=1_delta_crit']:.3f}"
          "   (reproduces published phi*)")
    print(f"  delta=1 (perfect deliv) -> A_crit     = {c['delta=1_A_crit']:.3f}")
    print(f"  A=0 (clearance only)    -> delta_crit = {c['A=0_delta_crit']:.3f}"
          "   (naive linear corner = ARTIFACT, see cap below)")
    # CORRECTION: the delta=2.93 corner is unphysical (requires eta_dorm=0.75+0.25*2.93=1.48>1).
    cap0 = ceiling_capped(1e6, 0.0)  # delta->inf, A=0, with eta<=1 cap
    print(f"  A=0 CAPPED (eta<=1): delta->inf ceiling = {cap0:.3f} -> STILL BLOCK (gate 0.90);"
          " delta CANNOT substitute for anabolism. residual gap trapped in acellular lost class.\n")

    frac, D, Aa, ok = admissible_fraction()
    print(f"Admissible (delta,A) area fraction of unit square: {frac:.3f}")

    # Representative realistic corner: small-molecule delivery into 2mm cartilage
    # is typically delta ~ 0.3-0.5; acellular lost cartilage A0 ~ 0.
    for delta, A in [(0.3, 0.0), (0.5, 0.0), (0.3, 0.5), (0.5, 0.7), (0.772, 1.0), (1.0, 0.69)]:
        cel = ceiling(delta, A)
        verdict = "PASS" if gate_lhs(delta, A) >= 0.22 else "BLOCK"
        print(f"  delta={delta:.3f} A={A:.2f} -> ceiling={cel:.3f}  {verdict}")

    print("\nVERDICT: both delta and A bind. Senolytic-only (A=0) canNOT close the OA gate at ANY")
    print("delivery -- shown correctly by the eta<=1 CAP (ceiling saturates at 0.755 < 0.90),")
    print("NOT by the naive delta>=2.93 corner (that was a linear-model artifact). An anabolic")
    print("(A) axis is irreducible; Step1->delta, Step2/2b->A_endo, Step3->external A node.")

    # persist the frontier grid for the figure / downstream
    np.savez("master_frontier_grid.npz", delta=D, A=Aa, admissible=ok,
             ceiling=ceiling(D, Aa))
    print("\nsaved: master_frontier_grid.npz")


if __name__ == "__main__":
    main()
