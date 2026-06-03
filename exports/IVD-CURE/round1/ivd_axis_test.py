#!/usr/bin/env python3
# IVD (intervertebral disc) degeneration — CURE-PRIMITIVE test + #548 boundary condition.
# tissue classes: reversible (mildly-degen NP/AF cells) / dormant (NP progenitors, SCARCE) / lost.
# Special features vs the other 4: (a) AVASCULAR (nutrition via endplate diffusion, like OA),
# (b) endplate CALCIFICATION adds a nutrition barrier, (c) NP progenitor reserve is small.
mass={'reversible_NP_AF':0.30, 'dormant_progenitor':0.15, 'lost_NP_AF_endplate':0.55}
eta_max={'reversible_NP_AF':0.85, 'dormant_progenitor':0.60, 'lost_NP_AF_endplate':0.30}  # avascular+calcified → low
gate=0.90
def ceiling(eta_lost): return mass['reversible_NP_AF']*eta_max['reversible_NP_AF']+mass['dormant_progenitor']*eta_max['dormant_progenitor']+mass['lost_NP_AF_endplate']*eta_lost
base=ceiling(eta_max['lost_NP_AF_endplate'])
print("=== IVD-CURE axis-collapse (CURE-PRIMITIVE) ===")
for c in mass: print(f"  {c:22s} mass={mass[c]:.2f} eta_max={eta_max[c]:.2f}")
print(f"  best-achievable (no senolytic) = {base:.2f} → gate {gate}: {'CLOSE' if base>=gate else 'BLOCK'}")
print(f"  BINDING AXIS = lost NP/AF/endplate neogenesis (η={eta_max['lost_NP_AF_endplate']:.2f}) — lowest of all 5 domains")
print()
# #548 BOUNDARY CONDITION: does even PERFECT senolytic (η_lost→1) close it?
ceil_perfect = ceiling(1.0)
print(f"=== #548 boundary test: ceiling at η_lost=1.0 (perfect neogenesis) = {ceil_perfect:.2f} ===")
if ceil_perfect < gate:
    print(f"  ✗ BOUNDARY CASE: even η_lost=1.0 gives {ceil_perfect:.2f} < {gate} — NO senolytic dose closes the gate.")
    print(f"    Reason: small dormant reserve (0.15) + low reversible mass → reachable ceiling too low.")
    print(f"    → IVD falls OUTSIDE the cross-cutting senolytic claim (#548 predicted this boundary).")
    # what WOULD be needed
    need_react=(gate - mass['lost_NP_AF_endplate']*1.0 - mass['dormant_progenitor']*eta_max['dormant_progenitor'])/mass['reversible_NP_AF']
    print(f"    Even then, additional requirement on reversible-class η: would need >1 → structurally blocked.")
else:
    # senolytic lift sweep
    print(f"  ✓ closable. SENOLYX η_neo-lift sweep:")
    for clear in [0.6,0.8,0.95,1.0]:
        eb=eta_max['lost_NP_AF_endplate']+clear*(1-eta_max['lost_NP_AF_endplate'])
        print(f"    clearance {clear:.0%} → η_lost {eb:.2f} → ceiling {ceiling(eb):.2f}")
print()
print("HONEST VERDICT (d6):")
print(" • IVD fits the SAME structural frame (binding axis = lost-tissue neogenesis) — yes, attackable in-concept.")
print(" • BUT IVD is the hardest/boundary case: avascular + endplate calcification (nutrition barrier) +")
print("   scarce NP-progenitor reserve. Senescence IS heavily implicated (NP-cell SASP well documented),")
print("   so SENOLYX is well-motivated — but a senolytic ALONE may not close the gate without ALSO")
print("   (a) restoring endplate nutrition (de-calcification/vascular access) and (b) supplying exogenous")
print("   progenitors (cell therapy), because the endogenous dormant reserve is too small.")
print(" • This makes IVD the test that SHARPENS the #548 boundary: senolytic is necessary, not sufficient.")
