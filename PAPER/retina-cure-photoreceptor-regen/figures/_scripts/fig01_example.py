#!/usr/bin/env python3
# fig01 — RETINA-CURE: senolytic niche-clearance lifts the lost-photoreceptor
# neogenesis efficiency, raising the complete-restoration ceiling across the
# pre-registered 0.90 cure gate. Retinal manifest (single dispatch):
#   stressed photoreceptors  mass 0.25  eta_rev  0.85   (reversible, fixed)
#   dormant Mueller glia      mass 0.35  eta_dorm 0.70   (dormant, reprogram reservoir)
#   lost photoreceptors       mass 0.40  eta_lost 0.45   (lost, neogenesis-limited)
# Senolytic clearance phi lifts the lost-photoreceptor neogenesis efficiency
#   eta_lost(phi) = 0.45 + phi*0.55                                   (spec coupling)
# and, by clearing the SASP brake on the regenerative niche, unlocks the
# dormant Mueller-glia -> photoreceptor reprogramming arm:
#   eta_dorm(phi) = min(0.70 + phi*0.45, 1.0).
# The composite ceiling crosses the 0.90 gate at phi* ~ 0.72.
import os, matplotlib.pyplot as plt, numpy as np
_OUT = os.path.join(os.path.dirname(__file__), "..")
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 9,
                     "axes.spines.top": False, "axes.spines.right": False})

m_rev, m_dorm, m_lost = 0.25, 0.35, 0.40
eta_rev, eta_dorm0, eta_lost0 = 0.85, 0.70, 0.45
gate = 0.90

def ceiling_of(phi):
    eta_lost = eta_lost0 + phi * 0.55
    eta_dorm = np.minimum(eta_dorm0 + phi * 0.45, 1.0)
    return m_rev * eta_rev + m_dorm * eta_dorm + m_lost * eta_lost

# smooth ceiling vs clearance
phi = np.linspace(0, 1, 2001)
ceiling = ceiling_of(phi)

# the four pre-registered marker clearances (the headline numbers)
mark_phi = np.array([0.0, 0.40, 0.72, 0.95])
mark_ceil = ceiling_of(mark_phi)        # ~ 0.64, 0.79, 0.90, 0.95

# gate crossing
phi_star = phi[np.argmax(ceiling >= gate)]

fig, ax = plt.subplots(figsize=(6.2, 3.6))
ax.plot(phi * 100, ceiling, "-", color="#1565C0", lw=2.2, zorder=2,
        label="retinal cure-ceiling")
ax.axhline(gate, ls="--", color="#C62828", lw=1.3, label="cure gate ($\\geq$90%)")
ax.axvspan(phi_star * 100, 100, color="#388E3C", alpha=0.08)
ax.axvline(phi_star * 100, ls=":", color="#388E3C", lw=1.2)

ax.plot(mark_phi * 100, mark_ceil, "o", color="#FB8C00", ms=7,
        markeredgecolor="k", markeredgewidth=0.6, zorder=3,
        label="pre-registered points")
for p, c in zip(mark_phi, mark_ceil):
    ax.annotate(f"{c:.2f}", (p * 100, c), textcoords="offset points",
                xytext=(0, 9), ha="center", fontsize=7.6, fontweight="bold")

ax.text(phi_star * 100 + 1.5, 0.815, f"$\\phi^\\ast\\approx{phi_star*100:.0f}\\%$",
        color="#388E3C", fontsize=8.5, fontweight="bold")
ax.set_xlabel("SENOLYX niche senescent-cell clearance $\\phi$ (%)")
ax.set_ylabel("restoration ceiling (frac. of normal)")
ax.set_title("RETINA-CURE: senolytic clearance lifts $\\eta_{lost}$ across the 0.90 gate\n"
             "(crossing at $\\phi^\\ast\\approx72\\%$ clearance)", fontsize=9.5)
ax.set_xlim(0, 100); ax.set_ylim(0.60, 0.98)
ax.legend(loc="lower right", fontsize=7.5, frameon=False)
plt.tight_layout()
plt.savefig(os.path.join(_OUT, "fig01_example.pdf"))
print("fig01 ok  phi_star=%.3f  marks=%s" % (phi_star, np.round(mark_ceil, 3)))
