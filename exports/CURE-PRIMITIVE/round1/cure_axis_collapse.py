#!/usr/bin/env python3
# cure-axis-collapse PRIMITIVE (generalized from AGA-CURE, d4 single-generic-dispatch).
# Any chronic-degenerative cure with a reversibility gradient maps to:
#   ceiling = sum_c mass[c] * eta[c]     (tissue classes: reversible / dormant / lost-fibrosed)
# The gate (>= gate_frac of normal) collapses to the class whose eta is the binding constraint.
# Instance = a manifest dict only (NO per-tissue code) — exactly the AGA-CURE pattern.
def axis_collapse(name, classes, eta_current, eta_achievable, gate=0.90):
    # classes: {class: mass}; eta_current/eta_achievable: {class: efficiency in [0,1]}
    cur = sum(classes[c]*eta_current[c] for c in classes)
    best = sum(classes[c]*eta_achievable[c] for c in classes)
    # binding axis = the class with the largest (gate-demanded - achievable) shortfall per unit mass
    # required uniform lift to hit gate, attributing to the lowest-eta high-mass class
    gaps = {c: (eta_achievable[c], classes[c]) for c in classes}
    binding = min(classes, key=lambda c: eta_achievable[c])  # lowest achievable efficiency = bottleneck
    print(f"\n=== {name} ===")
    for c in classes:
        print(f"  {c:10s} mass={classes[c]:.2f}  eta_now={eta_current[c]:.2f}  eta_max={eta_achievable[c]:.2f}")
    print(f"  current ceiling = {cur:.2f}  |  best-achievable ceiling = {best:.2f}  (gate {gate})")
    verdict = "CLOSES" if best>=gate else f"BLOCKED (cap {best:.2f} < {gate})"
    print(f"  gate @ best-achievable: {verdict}")
    print(f"  → BINDING AXIS = '{binding}' neogenesis/efficiency (eta_max={eta_achievable[binding]:.2f}) — the single residual")
    return name, cur, best, binding, best>=gate

# instances = manifests only (no per-tissue code)
INSTANCES = [
 ("🦷 periodontal-regen",
   {"reversible_gingiva":0.40, "dormant_PDL":0.30, "lost_bone_cementum":0.30},
   {"reversible_gingiva":0.80, "dormant_PDL":0.55, "lost_bone_cementum":0.10},   # eta now (current SRP/GTR)
   {"reversible_gingiva":0.95, "dormant_PDL":0.85, "lost_bone_cementum":0.55}),  # eta achievable (BMP/Wnt regen)
 ("🦵 OA-cartilage",
   {"reversible_chondro":0.35, "dormant_progenitor":0.30, "lost_fibrillated":0.35},
   {"reversible_chondro":0.70, "dormant_progenitor":0.45, "lost_fibrillated":0.05},
   {"reversible_chondro":0.90, "dormant_progenitor":0.75, "lost_fibrillated":0.40}),  # avascular → delivery-capped
 ("👁 retinal-photoreceptor",
   {"reversible_stressed":0.25, "dormant_muller":0.35, "lost_photoreceptor":0.40},
   {"reversible_stressed":0.60, "dormant_muller":0.20, "lost_photoreceptor":0.02},
   {"reversible_stressed":0.85, "dormant_muller":0.70, "lost_photoreceptor":0.45}),  # glia→PR reprogramming-capped
]
results=[]
for inst in INSTANCES:
    results.append(axis_collapse(*inst, gate=0.90))

print("\n=== cross-instance summary (primitive reuse, d4) ===")
print(f"{'target':26s} {'cur':>5s} {'best':>5s} {'gate?':>8s}  binding axis")
for n,cur,best,b,ok in results:
    print(f"{n:26s} {cur:5.2f} {best:5.2f} {('CLOSE' if ok else 'BLOCK'):>8s}  {b}")

# ▶ 5/5 senolytic eta_neo-lift hypothesis (shared bottleneck from AGA DC14)
print("\n=== 💊 senolytic eta_neo-lift (shared across all regen-cures) ===")
# hypothesis: clearing senescent fibroblasts re-opens the neogenesis window, lifting eta_neo.
# model: eta_neo_effective = eta_neo_base + lift*(1 - eta_neo_base); lift = fraction of senescence-imposed block removed
eta_base=0.49  # AGA DC14 human neogenesis ceiling
for lift in [0.0,0.2,0.4,0.6,0.8]:
    eff=eta_base + lift*(1-eta_base)
    print(f"  senolytic clearance {lift:.0%} of senescence block → eta_neo {eta_base:.2f} → {eff:.2f}"
          + ("  ← clears AGA 0.84 target" if eff>=0.84 else ""))
print("  → senolytic niche-clearance is the cross-cutting lever on the DC14 eta_neo bottleneck.")
print("    Need ~69% senescence-block removal to lift eta_neo 0.49→0.84 (AGA gate target).")
