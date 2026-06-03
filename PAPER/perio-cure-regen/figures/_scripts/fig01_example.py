#!/usr/bin/env python3
"""fig01 -- SENOLYX niche senescent-cell clearance (%) vs periodontal complete-restoration
ceiling, crossing the >=0.90 cure gate. Discrete anchors from exports/PERIO-CURE/round1.
ceiling = m_ging*eta_ging + m_pdl*eta_pdl + m_bone*eta_bone(clearance),
eta_bone(c) = 0.55 + c*0.45 ; masses 0.40 gingiva / 0.30 PDL / 0.30 bone+cementum."""
import os, matplotlib.pyplot as plt, numpy as np
_OUT = os.path.join(os.path.dirname(__file__), "..")
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 9,
                     "axes.spines.top": False, "axes.spines.right": False})

# discrete measured anchors (round-1 PD model)
clear_pts = np.array([0, 40, 60, 73, 80, 95])
ceil_pts  = np.array([0.80, 0.85, 0.88, 0.90, 0.91, 0.93])

# continuous closed-form backbone (same coupling)
c = np.linspace(0, 1, 201)
eta_bone = 0.55 + c * 0.45
ceil = 0.40 * 0.95 + 0.30 * 0.85 + 0.30 * eta_bone
gate = 0.90

fig, ax = plt.subplots(figsize=(6.2, 3.6))
ax.plot(c * 100, ceil, "-", color="#6A1B9A", lw=2,
        label=r"ceiling $=\Sigma\,m_c\eta_c$ (closed form)")
ax.plot(clear_pts, ceil_pts, "s", color="#6A1B9A", ms=7, mec="k", mew=0.6,
        zorder=5, label="round-1 PD-model anchors")
ax.axhline(gate, ls="--", color="#C62828", lw=1.3, label=r"cure gate ($\geq$90%)")
# threshold where the curve crosses the gate (~73% clearance)
xc = (gate - (0.40 * 0.95 + 0.30 * 0.85) - 0.30 * 0.55) / (0.30 * 0.45) * 100
ax.axvline(xc, ls=":", color="#455A64", lw=1.1)
ax.axvspan(xc, 100, color="#388E3C", alpha=0.08)
ax.annotate(f"gate closes\n$\\phi^*\\approx{xc:.0f}\\%$", xy=(xc, gate),
            xytext=(xc + 5, 0.835), fontsize=8, color="#455A64",
            arrowprops=dict(arrowstyle="->", color="#455A64", lw=0.9))
for xx, yy in zip(clear_pts, ceil_pts):
    ax.text(xx, yy + 0.004, f"{yy:.2f}", ha="center", fontsize=7, color="#4A148C")
ax.set_xlabel(r"SENOLYX niche senescent-cell clearance $\phi$ (%)")
ax.set_ylabel("complete-restoration ceiling (frac of normal)")
ax.set_title("Senolytic niche-clearance lifts $\\eta_{bone}$ -> periodontal\n"
             "cure-ceiling crosses the $\\geq$90% gate", fontsize=9.5)
ax.set_xlim(0, 100); ax.set_ylim(0.79, 0.95)
ax.legend(loc="lower right", fontsize=7.5, frameon=False)
plt.tight_layout()
plt.savefig(os.path.join(_OUT, "fig01_example.pdf"))
print("fig01 ok")
