#!/usr/bin/env python3
# Figure 1: H3S lambda ladder — ambient ML / DFT q-convergence / literature / measured.
# Publication-style: 1-column matplotlib, bar chart, color-coded by tier.
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

LADDER = [
    ("ambient ML\n(BETE-NET·ALIGNN)", 0.48, 0.0,  "#C62828", "Tier-1 ML"),
    ("DFT 2³ q\n(under-conv.)",        0.85, 0.0,  "#FB8C00", "Tier-1 DFT"),
    ("DFT 4³ q\n(8 irred.)",           1.29, 0.08, "#FFB300", "Tier-1 DFT"),
    ("DFT 6³ q\n(16 irred., this work)",2.37, 0.25, "#388E3C", "Tier-1 DFT"),
    ("literature\nharmonic [Errea16]", 2.20, 0.10, "#1976D2", "Tier-1 lit"),
    ("measured\n[Drozdov15]",          2.00, 0.10, "#1565C0", "Tier-3 meas"),
]

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "font.size":   10,
    "axes.spines.top":   False,
    "axes.spines.right": False,
})

fig, ax = plt.subplots(figsize=(7.0, 3.7))
xs = list(range(len(LADDER)))
heights = [r[1] for r in LADDER]
errs    = [r[2] for r in LADDER]
colors  = [r[3] for r in LADDER]
bars = ax.bar(xs, heights, yerr=errs, color=colors, capsize=4,
              edgecolor="black", linewidth=0.6, width=0.65)

# annotate values on top
for x, h, e in zip(xs, heights, errs):
    ax.text(x, h + max(e, 0.05) + 0.08, f"{h:.2f}",
            ha="center", va="bottom", fontsize=9, fontweight="bold")

# arrow / trend
ax.annotate("", xy=(3, 2.37), xytext=(0, 0.48),
            arrowprops=dict(arrowstyle="->", color="black", lw=1.0, alpha=0.4,
                            connectionstyle="arc3,rad=-0.18"))
ax.text(1.5, 1.6, "monotonic\nq-convergence", ha="center", va="center",
        fontsize=9, fontstyle="italic", color="#555")

# measured/literature horizontal reference
ax.axhline(2.0, color="#1565C0", linestyle="--", linewidth=0.8, alpha=0.5)
ax.text(5.4, 2.04, "meas. target", color="#1565C0", fontsize=8, alpha=0.7)

ax.set_xticks(xs)
ax.set_xticklabels([r[0] for r in LADDER], fontsize=8.5)
ax.set_ylabel(r"electron–phonon coupling $\lambda$", fontsize=11)
ax.set_ylim(0, 3.0)
ax.set_yticks([0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0])
ax.grid(axis="y", linestyle=":", alpha=0.4)

ax.set_title(r"H$_3$S electron–phonon coupling $\lambda$ ladder", fontsize=12, pad=10)

plt.tight_layout()
out_pdf = __file__.rsplit("/", 2)[0] + "/fig01_lambda_ladder.pdf"
plt.savefig(out_pdf, format="pdf", bbox_inches="tight")
print(f"[fig01] wrote {out_pdf}")
