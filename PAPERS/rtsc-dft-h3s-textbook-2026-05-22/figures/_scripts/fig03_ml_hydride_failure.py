#!/usr/bin/env python3
# Figure 3: Ambient ML hydride failure — λ predictions vs literature for 5 hydrides.
# Cross-confirms BETE-NET + ALIGNN both fall flat at λ~0.3-0.5 vs literature ~2.0-2.5.
import matplotlib.pyplot as plt
import numpy as np

# (material, BETE-NET λ, ALIGNN a2F→AD λ, lit/meas λ, measured Tc K)
HYDRIDES = [
    ("H$_3$S",     0.48, 0.48, 2.00, 203),
    ("LaH$_{10}$", 0.45, 0.45, 2.20, 250),
    ("CaH$_6$",    0.43, 0.43, 2.30, 215),
    ("YH$_6$",     0.34, 0.34, 2.50, 224),
    ("MgH$_6$",    0.39, 0.39, 2.50, 260),  # MgH6 still theory-only Tc
]

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "font.size": 10,
    "axes.spines.top": False,
    "axes.spines.right": False,
})

fig, ax = plt.subplots(figsize=(7.0, 3.7))
xs = np.arange(len(HYDRIDES))
w = 0.27

bete   = [h[1] for h in HYDRIDES]
alignn = [h[2] for h in HYDRIDES]
lit    = [h[3] for h in HYDRIDES]

ax.bar(xs - w, bete,   w, color="#C62828", edgecolor="black", linewidth=0.5,
       label="BETE-NET (ambient ML)")
ax.bar(xs,     alignn, w, color="#FB8C00", edgecolor="black", linewidth=0.5,
       label="ALIGNN α²F→AD (ambient ML)")
ax.bar(xs + w, lit,    w, color="#1565C0", edgecolor="black", linewidth=0.5,
       label="literature / first-principles")

# annotate measured Tc above
for i, h in enumerate(HYDRIDES):
    ax.text(i, max(h[1], h[2], h[3]) + 0.18, f"T$_c$={h[4]}K",
            ha="center", va="bottom", fontsize=8, fontstyle="italic", color="#444")

# the "wall" — shade the ML failure region
ax.axhspan(0, 0.55, color="#C62828", alpha=0.06)
ax.text(4.4, 0.28, "ambient-ML\nfailure zone",
        color="#C62828", fontsize=8.5, alpha=0.7, ha="right", va="center", fontweight="bold")

ax.set_xticks(xs)
ax.set_xticklabels([h[0] for h in HYDRIDES], fontsize=10)
ax.set_ylabel(r"electron–phonon $\lambda$", fontsize=11)
ax.set_ylim(0, 3.2)
ax.set_yticks([0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0])
ax.grid(axis="y", linestyle=":", alpha=0.4)
ax.legend(loc="upper left", fontsize=8.5, frameon=False)
ax.set_title("Hydride electron–phonon coupling: ambient-ML wall vs literature", fontsize=11.5, pad=10)

plt.tight_layout()
out_pdf = __file__.rsplit("/", 2)[0] + "/fig03_ml_hydride_failure.pdf"
plt.savefig(out_pdf, format="pdf", bbox_inches="tight")
print(f"[fig03] wrote {out_pdf}")
