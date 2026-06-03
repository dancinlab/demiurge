#!/usr/bin/env python3
# fig02 — RETINA-CURE class decomposition. Each cell-state class contributes
# mass * eta to the restoration ceiling. The lost photoreceptor class carries
# the LARGEST lost mass of any domain (0.40) at the LOWEST efficiency (0.45),
# so it is both the largest bar shortfall and the binding axis.
#   stressed photoreceptors  mass 0.25  eta 0.85  (reversible)
#   dormant Mueller glia      mass 0.35  eta 0.70  (dormant, reprogram reservoir)
#   lost photoreceptors       mass 0.40  eta 0.45  (lost, neogenesis-limited)
import os, matplotlib.pyplot as plt, numpy as np
_OUT = os.path.join(os.path.dirname(__file__), "..")
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 9,
                     "axes.spines.top": False, "axes.spines.right": False})

classes = ["stressed\nphotoreceptors\n(reversible)",
           "dormant\nMueller glia\n(reprogram)",
           "lost\nphotoreceptors\n(neogenesis)"]
mass = np.array([0.25, 0.35, 0.40])
eta  = np.array([0.85, 0.70, 0.45])
contrib = mass * eta                     # 0.2125, 0.2450, 0.1800
shortfall = mass * (1 - eta)             # unrecovered fraction per class
colors = ["#388E3C", "#1565C0", "#C62828"]

x = np.arange(len(classes)); w = 0.62
fig, ax = plt.subplots(figsize=(6.2, 3.8))
b1 = ax.bar(x, contrib, w, color=colors, edgecolor="k", lw=0.6,
            label="recovered  (mass$\\times\\eta$)")
b2 = ax.bar(x, shortfall, w, bottom=contrib, color=colors, edgecolor="k", lw=0.6,
            alpha=0.28, hatch="//", label="unrecovered  (mass$\\times(1-\\eta)$)")

for i in range(len(classes)):
    ax.text(i, contrib[i] / 2, f"{contrib[i]:.3f}", ha="center", va="center",
            fontsize=8, fontweight="bold", color="white")
    ax.text(i, mass[i] + 0.012, f"mass {mass[i]:.2f}\n$\\eta$ {eta[i]:.2f}",
            ha="center", fontsize=7.4)

ax.annotate("largest lost mass\nof any domain",
            xy=(2, mass[2] - 0.03), xytext=(1.35, 0.50),
            fontsize=7.8, color="#C62828", fontweight="bold",
            arrowprops=dict(arrowstyle="->", color="#C62828", lw=1.1))

ax.set_xticks(x); ax.set_xticklabels(classes, fontsize=7.6)
ax.set_ylim(0, 0.50)
ax.set_ylabel("contribution to restoration ceiling")
ax.set_title("RETINA-CURE class decomposition — lost photoreceptors\n"
             "are the largest, lowest-efficiency (binding) class", fontsize=9.5)
ax.legend(loc="upper right", fontsize=7.4, frameon=False)
plt.tight_layout()
plt.savefig(os.path.join(_OUT, "fig02_senolytic.pdf"))
print("fig02 ok  contrib=%s  ceiling=%.4f" % (np.round(contrib, 4), contrib.sum()))
