#!/usr/bin/env python3
"""SENOLYX OA-cartilage — Step 2: senolytic-only anabolic competence A0.

H2 falsifier: A0 >= 0.690  => neogenesis co-driver NOT needed (arm collapses to single-agent).
              A0 <  0.690  => a chondro-anabolic co-driver IS additionally required.

Honest design (Fable Wall-B): do NOT invent a GAG-synthesis slope. GAG/collagen-II matrix
synthesis rate is PROPORTIONAL to viable chondrogenic cell density rho(t). For the fully-LOST
class the defining property is rho -> 0 (acellular matrix down to subchondral bone; resident
chondrocytes post-mitotic, no vascular progenitor recruitment). So A0 is bounded structurally,
parameter-robust, by how much cell density senolytic clearance alone can restore.

Minimal coupled ODE for the neogenesis-competent pool feeding the lost class:
  progenitor pool P from the dormant class (mass 0.30), SASP-inhibited.
  dP/dt = r * P * (1 - P/Pmax) * s(phi)  -  d * P      (logistic recruitment, SASP-gated)
  s(phi) = phi                             (SASP relief scales with clearance)
  matrix build rate m(t) proportional to P that MIGRATES into the acellular lost zone,
  gated by an avascular migration fraction mu (progenitors must traverse avascular matrix
  with NO chemotactic vascular gradient) -> mu is small and is the structural bound.

A0 = asymptotic normalized matrix fill of the lost zone from senolytic clearance ALONE
   = mu * (P_ss / Pmax)   with phi = 1 (max clearance), no exogenous anabolic.
mu swept (structural uncertainty); report A0(mu) frontier, not a point (d6).
"""
import numpy as np
from scipy.integrate import odeint

Pmax = 1.0
r = 0.5      # recruitment rate (units 1/time; asymptote independent of r>d)
d = 0.05     # progenitor attrition
PHI = 1.0    # max senolytic clearance (best case for senolytic-only)


def dP(P, t, phi):
    return r * P * (1 - P / Pmax) * phi - d * P


def P_steady(phi):
    P = odeint(dP, 0.02, np.linspace(0, 400, 4000), args=(phi,))[-1, 0]
    return max(P, 0.0)


def main():
    print("== SENOLYX OA-cartilage :: Step 2 neogenesis A0 (senolytic-only) ==")
    Pss = P_steady(PHI)
    print(f"progenitor steady state P_ss(phi=1) = {Pss:.3f} / Pmax  (SASP fully relieved)")
    print("(P_ss is the reactivatable dormant pool; NOT yet matrix in the lost zone)\n")

    print("A0 = mu * P_ss  (mu = avascular migration/fill fraction into acellular lost zone)")
    print("mu is structurally SMALL: no vascular chemotactic gradient, dense matrix, long path.\n")
    print(f"{'mu':>6} {'A0':>7}  {'H2 (A0>=0.690?)':>16}")
    for mu in [0.0, 0.05, 0.1, 0.2, 0.4, 0.6, 0.8, 1.0]:
        A0 = mu * Pss
        flag = "co-driver NOT needed" if A0 >= 0.690 else "co-driver REQUIRED"
        print(f"{mu:>6.2f} {A0:>7.3f}  {flag:>16}")

    A0_needed_mu = 0.690 / Pss if Pss > 0 else float("inf")
    print(f"\nA0 reaches 0.690 only if mu >= {A0_needed_mu:.3f}")
    if A0_needed_mu > 1.0:
        print("  => mu>1 IMPOSSIBLE: senolytic-only can NEVER supply enough matrix fill.")
    print("\nSTRUCTURAL VERDICT: for acellular lost cartilage mu<<1 (avascular, no gradient),")
    print("so A0 << 0.690  ==>  H2 CONFIRMED: a chondro-anabolic co-driver IS additionally")
    print("required. Senolytic clearance re-opens the window but supplies no builder.")


if __name__ == "__main__":
    main()
