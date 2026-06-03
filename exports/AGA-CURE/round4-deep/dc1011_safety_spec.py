import numpy as np
# ===== DC10 cumulative multi-modal safety =====
# Each arm carries an independent adverse-event probability r_i (per-cycle, in-silico est).
# Cumulative AE = 1 - prod(1-r_i). Compare per-arm vs stacked; flag if stacked > tolerance.
print("=== DC10 cumulative multi-modal safety ===")
arms={
 "② SFRP1+Dkk1 topical": 0.04,   # extracellular ligand-limited, low systemic
 "① MPC/LDH topical":     0.05,   # metabolic, de-risked
 "④ neogenesis inducer":  0.06,   # local morphogen, ectopic-pattern risk (bounded by DC8 robustness)
 "③ Cas12f AAV (1-shot)": 0.10,   # vector immunogenicity + edit risk, ONE administration
}
r=np.array(list(arms.values()))
cum=1-np.prod(1-r)
for k,v in arms.items(): print(f"  {k:24s} r={v:.2f}")
print(f"  cumulative AE (independent) = 1-∏(1-r_i) = {cum:.3f}")
# worst-case fully-correlated = sum capped at 1
print(f"  worst-case (correlated)     = {min(r.sum(),1.0):.3f}")
TOL=0.30
print(f"  tolerance threshold = {TOL:.2f} → {'PASS (under tol)' if cum<TOL else 'FLAG'}")
print(f"  note: arm③ is a ONE-TIME lock (not chronic) → its risk is non-recurring;")
print(f"        topical arms ①②④ dominate the recurring AE budget ({1-np.prod(1-r[:3]):.3f}).")

# ===== DC11 epigenetic-edit specificity =====
# Cas12f gRNA (~20nt). Off-target = genomic near-matches within mismatch tolerance.
# On:off specificity ratio from a mismatch-penalty model. Human genome ~3.1e9 bp.
print("\n=== DC11 epigenetic-edit (Cas12f) specificity ===")
G=3.1e9
def expected_offtargets(seed_len, max_mm):
    # expected sites matching with <=max_mm mismatches in a 20nt protospacer (rough combinatorial)
    L=20; p_match=0.25
    exp=0.0
    for mm in range(0,max_mm+1):
        from math import comb
        exp += G * comb(L,mm) * (p_match**(L-mm)) * ((1-p_match)**mm)
    return exp
print(f"{'max-mismatch':>12s} {'expected off-target sites':>26s}")
for mm in [0,1,2,3,4]:
    print(f"{mm:12d} {expected_offtargets(20,mm):26.2e}")
# specificity ratio: on-target (1 site, high-affinity) vs summed off (mismatch-penalized binding)
on=1.0; off2=expected_offtargets(20,3)*0.01  # mismatched sites bind ~100x weaker
spec=on/(on+off2)
print(f"  on:off specificity (≤3mm, 100x weaker off-binding) ≈ {spec:.3f}")
print(f"  interpretation: 20nt Cas12f protospacer → ~0 exact off-target in 3.1e9 bp;")
print(f"  epigenetic (reversible) edit further de-risks vs permanent DNA cut (g63: spec not a")
print(f"  hexa-verified value — order-of-magnitude in-silico estimate, flag for empirical GUIDE-seq).")
