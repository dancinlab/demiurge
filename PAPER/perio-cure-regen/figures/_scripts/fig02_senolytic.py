#!/usr/bin/env python3
"""fig02 -- periodontal cell-class decomposition. Each bar = class mass m_c, split into
the achievable-restored fraction m_c*eta_c (solid) and the unreachable residual
m_c*(1-eta_c) (hatched). Manifest (exports/PERIO-CURE/round1, CURE-PRIMITIVE instance):
gingiva    m=0.40 eta=0.95 (reversible)
PDL        m=0.30 eta=0.85 (dormant)
bone+cem.  m=0.30 eta=0.55 (lost, untreated) -- the binding axis."""
import os, matplotlib.pyplot as plt, numpy as np
_OUT = os.path.join(os.path.dirname(__file__), "..")
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 9,
                     "axes.spines.top": False, "axes.spines.right": False})

classes = ["gingiva\n(reversible)", "PDL\n(dormant)", "bone+cementum\n(lost)"]
mass = np.array([0.40, 0.30, 0.30])
eta  = np.array([0.95, 0.85, 0.55])
restored = mass * eta
residual = mass * (1 - eta)
col = ["#43A047", "#1E88E5", "#8E24AA"]

x = np.arange(len(classes)); w = 0.55
fig, ax = plt.subplots(figsize=(6.0, 3.6))
ax.bar(x, restored, w, color=col, edgecolor="k", lw=0.6, label="restored $m_c\\eta_c$")
ax.bar(x, residual, w, bottom=restored, color="white", edgecolor="k", lw=0.6,
       hatch="////", label="unreachable $m_c(1-\\eta_c)$")
for i in range(len(classes)):
    ax.text(i, mass[i] + 0.008, f"$m$={mass[i]:.2f}\n$\\eta$={eta[i]:.2f}",
            ha="center", fontsize=7.5)
    ax.text(i, restored[i] / 2, f"{restored[i]:.3f}", ha="center", va="center",
            fontsize=7.5, color="white", fontweight="bold")
ceiling = restored.sum()
ax.axhline(mass.max(), ls=":", color="#999", lw=0.8)
ax.set_xticks(x); ax.set_xticklabels(classes, fontsize=8)
ax.set_ylabel("fraction of normal periodontium")
ax.set_ylim(0, 0.46)
ax.set_title(f"Periodontal class decomposition: ceiling $\\Sigma m_c\\eta_c$ = "
             f"{ceiling:.2f} < 0.90\nresidual concentrated in the lost bone/cementum class",
             fontsize=9.3)
ax.legend(loc="upper right", fontsize=7.5, frameon=False)
plt.tight_layout()
plt.savefig(os.path.join(_OUT, "fig02_senolytic.pdf"))
print("fig02 ok  ceiling=%.4f" % ceiling)
