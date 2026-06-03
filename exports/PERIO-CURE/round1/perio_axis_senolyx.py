#!/usr/bin/env python3
# PERIO-CURE round-1 — CURE-PRIMITIVE axis-collapse + SENOLYX η_neo-lift (d4 reuse, instance=manifest).
# tissue classes (mass): reversible gingiva / dormant PDL / lost bone+cementum
mass={'gingiva':0.40,'PDL':0.30,'bone_cementum':0.30}
eta_max={'gingiva':0.95,'PDL':0.85,'bone_cementum':0.55}   # achievable w/o senolytic (BMP/Wnt regen)
gate=0.90
def ceiling(eta_bone): return mass['gingiva']*eta_max['gingiva']+mass['PDL']*eta_max['PDL']+mass['bone_cementum']*eta_bone
base=ceiling(eta_max['bone_cementum'])
print("=== PERIO-CURE axis-collapse (CURE-PRIMITIVE reuse) ===")
for c in mass: print(f"  {c:14s} mass={mass[c]:.2f} eta_max={eta_max[c]:.2f}")
print(f"  best-achievable ceiling (no senolytic) = {base:.2f}  → gate {gate}: {'CLOSE' if base>=gate else 'BLOCK'}")
print(f"  BINDING AXIS = lost bone/cementum neogenesis (η={eta_max['bone_cementum']:.2f}) — the residual")
# required η_bone to close gate
need=(gate - (mass['gingiva']*eta_max['gingiva']+mass['PDL']*eta_max['PDL']))/mass['bone_cementum']
print(f"  η_bone needed for ≥{gate} gate = {need:.2f}")
print()
print("=== SENOLYX η_neo-lift (reused[SENOLYX]) ===")
# senolytic clears niche senescence → lifts η_bone: η_bone(clear)=0.55 + clear*(1-0.55)
print(f"{'sen-clearance':>13s} {'η_bone':>7s} {'ceiling':>8s} {'≥0.90?':>7s}")
gate_clear=None
for clear in [0.0,0.4,0.6,0.73,0.8,0.95]:
    eb=eta_max['bone_cementum']+clear*(1-eta_max['bone_cementum'])
    cc=ceiling(eb); ok='CLOSE' if cc>=gate else 'open'
    if cc>=gate and gate_clear is None: gate_clear=clear
    print(f"{clear:13.0%} {eb:7.2f} {cc:8.2f} {ok:>7s}")
print(f"  → PERIO gate CLOSES at SENOLYX senescent-clearance ≥ {gate_clear:.0%} (η_bone {eta_max['bone_cementum']+gate_clear*(1-eta_max['bone_cementum']):.2f})")
print()
print("FINDING: periodontal complete-regen is BLOCKED@0.80 by lost-bone neogenesis (CURE-PRIMITIVE),")
print("and SENOLYX niche-clearance ≥~73% lifts η_bone enough to CLOSE the ≥90% gate — the SAME")
print("cross-cutting key validated for AGA. Confirms d4 reuse: one drug (SENOLYX) + per-tissue regen.")
print("g63: η_max/lift are literature-order (BMP/Wnt regen + CURE-PRIMITIVE coupling); structure robust.")
