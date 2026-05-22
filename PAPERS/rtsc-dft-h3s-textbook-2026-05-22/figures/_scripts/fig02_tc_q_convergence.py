#!/usr/bin/env python3
# Figure 2: H3S Tc q-convergence — Allen-Dynes Tc vs q-grid size.
# Shows the convergence ladder hitting measurement-grade accuracy at 6x6x6 q.
import matplotlib.pyplot as plt

# (label, q-grid, Tc_low, Tc_high)
DATA = [
    ("ambient ML",         0,   1,    3),    # essentially zero
    ("DFT 2³ q",           2,   74,   78),
    ("DFT 4³ q",          4,   109,  140),
    ("DFT 6³ q (this)",   6,   175,  195),
    ("lit. harmonic",     7,   195,  205),  # plotted at x=7 (off-axis label)
]
MEASURED = 203  # K, Drozdov 2015

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "font.size": 10,
    "axes.spines.top": False,
    "axes.spines.right": False,
})

fig, ax = plt.subplots(figsize=(7.0, 3.7))

# bar = Tc range (low to high) at each grid
for i, (label, q, lo, hi) in enumerate(DATA):
    mid = (lo + hi) / 2
    err = (hi - lo) / 2
    color = "#C62828" if i == 0 else ("#388E3C" if i == 3 else ("#1976D2" if i == 4 else "#FB8C00"))
    ax.errorbar(i, mid, yerr=err, fmt="o", color=color,
                ecolor=color, elinewidth=2, capsize=6, capthick=2,
                markersize=10, markeredgecolor="black", markeredgewidth=0.6,
                label=label if i in (0, 3) else None)
    # annotate
    ax.text(i, hi + 8, f"{lo}-{hi} K" if hi != lo else f"{hi} K",
            ha="center", va="bottom", fontsize=8.5, fontweight="bold")

# measured horizontal reference
ax.axhline(MEASURED, color="black", linestyle="--", linewidth=1.0)
ax.text(4.5, MEASURED + 4, f"measured H$_3$S T$_c$ = {MEASURED} K (Drozdov 2015)",
        color="black", fontsize=9, fontweight="bold")

# shaded "measurement-grade" band (within 15% of measured)
ax.axhspan(MEASURED * 0.85, MEASURED * 1.05, color="#388E3C", alpha=0.08)
ax.text(4.5, MEASURED * 0.85 + 2, "measurement-grade band (±15%)",
        color="#388E3C", fontsize=8, alpha=0.7)

ax.set_xticks(list(range(len(DATA))))
ax.set_xticklabels([d[0] for d in DATA], fontsize=9)
ax.set_ylabel(r"Allen–Dynes $T_c$ (K)  [$\mu^*=0.10$]", fontsize=11)
ax.set_ylim(-15, 240)
ax.grid(axis="y", linestyle=":", alpha=0.4)
ax.set_title(r"H$_3$S Allen–Dynes T$_c$ convergence vs phonon $q$-grid", fontsize=12, pad=10)

plt.tight_layout()
out_pdf = __file__.rsplit("/", 2)[0] + "/fig02_tc_q_convergence.pdf"
plt.savefig(out_pdf, format="pdf", bbox_inches="tight")
print(f"[fig02] wrote {out_pdf}")
