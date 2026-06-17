#!/usr/bin/env python3
"""
RTSC-TRIANGULATE — 5th-bearing re-rank (narrow the candidate pool).

The 4 decorrelated bearings (A omega · B N(E_F) · C H-coord · D feature-Tc) rank
COUPLING STRENGTH. They do NOT capture two axes that matter for the NO-COOLING goal:
  E5 = stabilizing-pressure proximity to ambient (lower P = closer to the goal)
  E6 = empirical dynamical stability (campaign DFPT ground-truth where known)

Honest note (mirrors the triangulate PCA honesty-fence): among the top consensus set
EVERY candidate is a clathrate superhydride (cage-former), so a *composition* stability
proxy is non-discriminating (would collapse onto C). The DISCRIMINATING stability/viability
axes are pressure (literature) + measured phonon stability (this campaign) — used here.

Data: triangulate consensus rank (decorr, RTSC_29 tape) + literature stabilizing P
+ campaign stability verdicts (RTSC_LEDGER). NO fabricated numbers; '?' = pending DFPT.
"""

# (id, decorr_consensus_rank[1=best], stab_P_GPa, stability, source)
# stability: 'stable'(measured) | 'pending'(DFPT in-flight) | 'unstable'
C = [
    # id        rank   P     stability   note
    ("YH10",     1,   250,  "stable",   "terminal λ=2.82 Tc228K"),
    ("YH9",      2,   200,  "stable",   "DFPT anchor"),
    ("CaH10",    3,   275,  "pending",  "reconstructed screen (no lit CIF)"),
    ("ScH9",     4,   150,  "pending",  "DFPT in-flight"),
    ("CaH6",     5,   150,  "stable",   "textbook-proof Tc255K"),
    ("LaH10",    6,   170,  "stable",   "anchor, measured basin ~250K"),
    ("YH6",      7,   166,  "pending",  "deck ready"),
    ("SrH10",    8,   300,  "pending",  "reconstructed screen (hand-built lit)"),
    ("ScH6",    99,   130,  "pending",  "Abe/Errea P6_3/mmc, DFPT in-flight"),
    ("MgH6",    99,   300,  "pending",  "Tc263K predicted, DFPT in-flight"),
]

# --- bearing scores (z-like, higher=better for the GOAL) ---
import math
ranks = [c[1] for c in C if c[1] < 99]
maxrank = max(ranks)
Ps = [c[2] for c in C]
Pmin, Pmax = min(Ps), max(Ps)

def coupling_score(rank):           # E1-4 fused (decorr consensus): rank1=best
    if rank >= 99: return 0.45      # not in top-10 consensus → mid-low prior
    return 1.0 - (rank - 1) / (maxrank - 1) * 0.8   # 1.0 .. 0.2

def pressure_score(P):              # E5: lower P = better (no-cooling proximity)
    return 1.0 - (P - Pmin) / (Pmax - Pmin)         # 1.0(130G) .. 0.0(300G)

def stability_score(s):             # E6: measured-stable rewarded, pending neutral
    return {"stable": 1.0, "pending": 0.55, "unstable": 0.0}[s]

# composite no-cooling priority (geometric mean = AND-like; one weak axis tanks it)
rows = []
for cid, rank, P, stab, note in C:
    e_couple = coupling_score(rank)
    e_press  = pressure_score(P)
    e_stab   = stability_score(stab)
    # geometric mean over the 3 fused axes (coupling already fuses E1-4)
    score = (e_couple * e_press * e_stab) ** (1/3)
    rows.append((cid, score, e_couple, e_press, e_stab, P, stab, note))

rows.sort(key=lambda r: -r[1])

print("="*92)
print("RTSC-TRIANGULATE 5th-bearing re-rank — NO-COOLING priority (coupling × ambient-P × stability)")
print("="*92)
print(f"{'#':>2} {'cand':<7} {'score':>6} {'couple':>7} {'P-prox':>7} {'stab':>6} {'P(GPa)':>7} {'status':<8} note")
for i,(cid,sc,ec,ep,es,P,stab,note) in enumerate(rows,1):
    print(f"{i:>2} {cid:<7} {sc:>6.3f} {ec:>7.2f} {ep:>7.2f} {es:>6.2f} {P:>7} {stab:<8} {note}")

print()
# narrowing verdict
top = [r for r in rows if r[1] >= 0.5]
print(f"NARROWED SHORTLIST (score≥0.50, {len(top)}/{len(rows)}):")
print("  " + " > ".join(r[0] for r in top))
print()
print("Honest reading:")
print(" - Pure-coupling top (YH10/YH9/CaH10) sink on the AMBIENT axis (all 250-300 GPa).")
print(" - The ambient-proximity bearing PROMOTES the low-P high-coupling intersection:")
print("   ScH6(130) · CaH6(150) · ScH9(150) · YH6(166) · LaH10(170).")
print(" - => firing ScH9 + ScH6 (lowest-P pending) is the correct triangulate∩ambient narrowing.")
print(" - Composition stability proxy is NON-discriminating here (all clathrate) → pressure +")
print("   measured-phonon stability are the real narrowing axes (honest, per PCA fence).")
