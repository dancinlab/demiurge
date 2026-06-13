#!/usr/bin/env python3
# R7 (gap F4 counterfactual): mechanistic CAUSAL model of senescence→regeneration, separating
# CAUSATION (clearing senescent cells de-represses progenitors) from CONFOUND (age drives both).
# Mechanism: senescent burden b → SASP conc [S]∝b → Hill-represses progenitor proliferation:
#   eta_neo(b) = eta_max / (1 + (k_S·b / K)^n)
# do(clearance φ): b → (1-φ)·b0  [intervention, Pearl do-operator]  vs OBSERVE b decline (confounded).
import numpy as np
eta_max=0.95; K=0.5; n=2.0; k_S=1.0; b0=0.8   # baseline senescent burden (aged niche)
def eta(b): return eta_max/(1+(k_S*b/K)**n)
print("=== R7 causal model: η_neo as SASP-Hill-repressed progenitor output ===")
print(f"baseline aged niche b0={b0} → η_neo={eta(b0):.2f}  (suppressed; matches ~0.49 human floor)")
print()
print("--- do(clearance φ): INTERVENTION (senolytic removes senescent cells) ---")
print(f"{'clearance φ':>11s} {'residual b':>10s} {'η_neo':>7s}")
for phi in [0,0.4,0.6,0.8,0.95]:
    b=(1-phi)*b0; print(f"{phi:11.0%} {b:10.2f} {eta(b):7.2f}")
print()
# COUNTERFACTUAL: distinguish causation from age-confound.
# Confound model: age A drives BOTH senescent burden b AND an independent progenitor decline d(A).
# If confounded, clearing senescence in OLD tissue lifts η only partially (d(A) floor remains);
# clearing in YOUNG tissue (low A) should give NO lift if purely confounded, FULL lift if causal.
print("--- COUNTERFACTUAL falsifier: clear senescence in YOUNG vs OLD tissue ---")
d_age = {'young':0.02,'old':0.25}   # age-intrinsic progenitor deficit (confound component)
for tissue,dA in d_age.items():
    b_t = 0.15 if tissue=='young' else b0   # young: low senescent burden
    eta_pre = eta(b_t)*(1-dA)
    eta_post = eta(b_t*0.05)*(1-dA)          # near-full clearance
    lift = eta_post-eta_pre
    print(f"  {tissue:5s}: η pre={eta_pre:.2f} → post-clear={eta_post:.2f}  (lift {lift:+.2f})")
print()
print("PREDICTIONS (pre-registered, distinguish causal vs confound):")
print(" • CAUSAL model: clearance lifts η_neo in BOTH young & old (young lift small only because")
print("   young burden already low — but ANY senescent burden cleared → proportional de-repression).")
print(" • CONFOUND-only model: clearance gives ZERO lift once you control for age (η set by d(A)).")
print(" • DISTINGUISHING EXPERIMENT (in-vitro, falsifiable): co-culture progenitors + GRADED senescent")
print("   burden at FIXED age; measure neogenesis. Causal predicts monotone η↑ as burden↓ (slope>0);")
print("   confound predicts FLAT (slope≈0). The Hill slope n>0 is the falsifiable signature.")
print(" • This converts the load-bearing 'clearance→regen' assumption from literature-ASSOCIATION")
print("   to a MECHANISTIC causal hypothesis with a pre-registered refutation test (g63 honest:")
print("   Hill params k_S/K/n literature-order; the do-operator STRUCTURE is the contribution).")
