#!/usr/bin/env python3
"""SENOLYX OA-cartilage — assembled co-therapy gate closure (real off-the-shelf parts).

Assembly (assembly-novelty basis): senolytic(phi, OURS) + kartogenin(A_ext, BORROWED best-in-class)
co-loaded on a cationic GAG-avid carrier(delta, OURS physics) as ONE intra-articular depot;
A_endo(OURS, 0.206 structural) supplies the migrated cells KGN differentiates.

Master gate: Ceiling = 0.68 + 0.075*delta + 0.21*delta*A_total ; PASS >= 0.90
  A_total = A_endo + A_ext ,  capped physical (each class eta<=1 already respected in the 0.68 base form)
"""
import numpy as np

A_ENDO = 0.206                       # Step 2b structural floor (ours)
KGN_BRACKET = (0.45, 0.50, 0.60)     # kartogenin A_ext literature-order (pess, anchor, opt)
DELTAS = {"conservative cationic cap": 1.00, "measured mAv carrier (4.3x uptake)": 1.23}


def ceiling(delta, A):
    return 0.68 + 0.075 * delta + 0.21 * delta * A


def required_Aext(delta):
    # ceiling>=0.90 -> A_total >= (0.22/delta - 0.075)/0.21 ; A_ext = that - A_endo
    A_tot_req = (0.22 / delta - 0.075) / 0.21
    return A_tot_req - A_ENDO


def main():
    print("== Assembled OA-cartilage co-therapy — gate closure ==")
    print(f"A_endo(ours,Step2b)={A_ENDO}  KGN A_ext bracket={KGN_BRACKET}\n")
    print("Buy-down chain (external anabolic burden):")
    print(f"  no credit            -> A_ext >= {required_Aext(1.0)+A_ENDO:.3f}")
    print(f"  +A_endo credit (d=1) -> A_ext >= {required_Aext(1.0):.3f}")
    print(f"  +cationic d=1.23     -> A_ext >= {required_Aext(1.23):.3f}\n")

    print(f"{'delta scenario':>34} {'A_ext':>6} {'A_tot':>6} {'ceiling':>8}  verdict")
    for name, delta in DELTAS.items():
        for A_ext in KGN_BRACKET:
            At = A_ENDO + A_ext
            c = ceiling(delta, At)
            v = "PASS" if c >= 0.90 else "FAIL"
            print(f"{name:>34} {A_ext:>6.2f} {At:>6.3f} {c:>8.3f}  {v}")

    print("\nHonest read (d6):")
    print(f" - conservative delta=1 is knife-edge: needs A_ext>={required_Aext(1.0):.3f}"
          f" (KGN optimistic edge).")
    print(f" - real margin from carrier delta=1.23: needs only A_ext>={required_Aext(1.23):.3f},"
          " KGN (~0.50) clears comfortably.")
    print(" - GATE CLOSES for the assembled therapy at the measured-carrier operating point.")
    print(" - NOT banked: D+Q senolytic upregulates FGF18/IGF1/TGFb2 (would lift A_endo);"
          " mAv 10-day residence (would lift delta).")


if __name__ == "__main__":
    main()
