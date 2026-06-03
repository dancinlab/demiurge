import numpy as np
# DC14 — bracket arm④ neogenesis conversion efficiency η_neo against the cure gate,
# using literature in-vitro/in-vivo efficiencies. CATCHES a DC13 arithmetic error:
# DC13 claimed "required lift 0.37 is within arm④'s 0.25 headroom" — but 0.37 > 0.25,
# so even PERFECT arm④ cannot close the gate from the current 0.59 ceiling alone.
#
# Correct ceiling decomposition (fraction of normal productivity):
#   ceiling = (reachable mini+dorm mass 0.75) * η_react  +  (fibrosed mass 0.25) * η_neo
# where η_react = per-follicle reactivation/reversal efficacy on reachable mass,
#       η_neo   = fraction of fibrosed follicles regenerated to functional (×~1.0 productivity).
m_reach, m_fibr = 0.75, 0.25
Emax_cur = 0.59          # clinical anchor (current drugs)
eta_react_cur = Emax_cur/m_reach   # implied current reactivation efficacy
gate = 0.96
print("=== DC14 arm④ neogenesis efficiency bracket ===")
print(f"  reachable mass (mini+dorm) = {m_reach}; fibrosed mass = {m_fibr}")
print(f"  current ceiling {Emax_cur} ⇒ implied η_react(current drugs) = {eta_react_cur:.2f}")
print()
# CORRECTION of DC13: max possible from arm④ alone (perfect η_neo=1) at current η_react
ceil_arm4_only = Emax_cur + m_fibr*1.0
print(f"  [DC13 CORRECTION] arm④ alone, η_neo=1.0, η_react held at current {eta_react_cur:.2f}:")
print(f"     max ceiling = {Emax_cur} + {m_fibr}*1.0 = {ceil_arm4_only:.2f}  < gate {gate}")
print(f"     ⇒ DC13 'lift 0.37 within 0.25 headroom' was WRONG (0.37 > 0.25).")
print(f"     Even PERFECT neogenesis cannot close the gate from the current ceiling alone.")
print()
# So BOTH arms must improve. Solve the feasible (η_react, η_neo) frontier for ceiling>=gate.
print("  feasibility frontier: 0.75*η_react + 0.25*η_neo >= 0.96")
print(f"  {'η_react':>8s} {'min η_neo needed':>16s}  feasible vs literature η_neo∈[0.17,0.49] human / ~1.0 mouse-embryo")
for er in [0.79,0.85,0.90,0.95,1.00]:
    need = (gate - m_reach*er)/m_fibr
    if need>1.0: tag="IMPOSSIBLE (η_neo>1)"
    elif need>0.49: tag=f"needs η_neo≥{need:.2f} > human-lit 0.49 → only mouse-embryo regime"
    else: tag=f"needs η_neo≥{need:.2f} → within human-organoid 0.17–0.49 ✓"
    print(f"  {er:8.2f} {max(need,0):16.2f}  {tag}")
print()
print("  FINDING (honest, tightens DC9/DC13):")
print("   • The ≥0.96 gate is NOT reachable by arm④ neogenesis alone (corrects DC13).")
print("   • It requires arms①② reactivation efficacy η_react ≳ 0.95 (cure-grade mechanisms,")
print("     ABOVE the current-drug 0.79) AND arm④ η_neo near the top of its range.")
print("   • Human in-vitro neogenesis today (organoid invagination 17–49%, Kim 2024) is")
print("     BELOW what a low-η_react path would need; ~100% is only mouse-embryonic.")
print("   • So the residual is a TWO-number in-vitro target, not one: (η_react→0.95, η_neo→high).")
print("   • A softer gate (≥0.90) loosens this: 0.75*0.90+0.25*0.49=0.80; still needs η_react≈0.95.")
# what gate IS reachable with best literature human η_neo=0.49 and perfect react=1.0?
best_ceiling = m_reach*1.0 + m_fibr*0.49
print(f"   • Best-case ceiling (η_react=1.0, η_neo=0.49 human-lit) = {best_ceiling:.2f}")
print(f"     ⇒ with TODAY's human neogenesis efficiency, max restoration ≈ {best_ceiling:.2f} (< 0.96 gate).")
print(f"     The gate's bottleneck is η_neo: human neogenesis must rise 0.49→~0.84 to clear 0.96.")
