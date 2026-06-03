import numpy as np
def score(rows,cols,name):
    print(f"\n=== {name} ===")
    print(f"{'mechanism':28s} "+" ".join(f"{c:>9s}" for c in cols)+"   FIT")
    out=[]
    for r in rows:
        nm=r[0]; vals=r[1:]; fit=float(np.prod(vals))**(1/len(vals))  # geometric mean (balanced, penalizes any weak axis)
        out.append((nm,fit)); print(f"{nm:28s} "+" ".join(f"{v:9.2f}" for v in vals)+f"   {fit:.3f}")
    b=max(out,key=lambda x:x[1]); print(f"→ best (geo-mean): {b[0]} ({b[1]:.3f})")
    return out
# arm② 되돌리기 (Wnt복원) — axes: potency-reachable, selectivity, topical-feasible, oncogenic-SAFETY(1=safe)
score([
 ("SFRP1 inhib (WAY/A3)",   0.55,0.80,0.85,0.90),  # extracellular ligand-limited → safe; shallow groove → mid potency
 ("Dkk1-LRP6 block",        0.65,0.85,0.65,0.88),  # effector PPI, patent-clear, extracellular
 ("GSK3β inhib",            0.90,0.40,0.70,0.25),  # potent β-cat↑ BUT constitutive Wnt = oncogenic + kinase off-target
 ("CXXC5-PPI (PTD-DBM)",    0.70,0.70,0.55,0.70),  # Dvl-targeted, lower onco than GSK3β, peptide
 ("Wnt-agonist (Rspo surr)",0.85,0.55,0.50,0.35),  # potent but systemic Wnt = oncogenic
],["potency","selec","topical","onco-safe"],"DC4 arm② 되돌리기 5경로")
# arm① 깨우기 (HFSC reactivation) — axes: reactivation-efficacy, durability-of-wake, topical, safety
score([
 ("MPC/LDH metabolic (PP405)",0.80,0.70,0.85,0.85), # clinically de-risked, topical, metabolic switch
 ("IL-36α (WIHN)",            0.65,0.55,0.50,0.55),  # immune-driven HFSC proliferation; inflammation risk
 ("SCUBE3 (DPC signal)",      0.75,0.65,0.45,0.75),  # potent DPC pro-anagen; biologic delivery hard
 ("JAK-STAT inhib",           0.40,0.40,0.70,0.50),  # AA-effective but AGA off-axis (weak) + immunosupp
 ("PGF2α-FP (latanoprost)",   0.60,0.65,0.85,0.80),  # FP-agonist, topical safe, anagen-prolong
],["reactiv","durab","topical","safety"],"DC5 arm① 깨우기 5경로")
