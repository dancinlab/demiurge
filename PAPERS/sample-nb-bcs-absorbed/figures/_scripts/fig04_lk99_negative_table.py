#!/usr/bin/env python3
# Figure 4: LK-99 four-source honest-negative — horizontal bar table.
# Each axis returns FAIL/SKIP independently.
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

# (axis, source/test, predicted/observed, gate_outcome)
NEGATIVES = [
    ("Tier 1 self-prediction",
     "Allen-Dynes with paper's $\\lambda{=}0.6, \\mu^*{=}0.13, \\omega_{log}{=}300$\\,K",
     "$T_c^{AD}=45$\\,K",
     "FAIL: 45\\,K $\\ll$ 300\\,K claim"),
    ("Tier 4 falsifier dispatch",
     "\\texttt{MaterialFalsifierDispatch}, F-RTSC-3 (replication)",
     "\\texttt{replicated\\_by\\_independent\\_labs} $=0$",
     "aggregate $=$ \\texttt{FAILS-AT-LEAST-ONE}"),
    ("Sibling substrate cross-link",
     "\\texttt{hexa-rtsc} \\texttt{calc\\_lk99.hexa}",
     "upstream parser error at line 336",
     "SKIPPED (cannot evaluate)"),
    ("Public database curation",
     "Materials Project REST API (\\texttt{mp\\_query.py})",
     "Pb$_{10}$Cu(PO$_4$)$_6$O \\& Pb$_9$Cu(PO$_4$)$_6$O",
     "\\texttt{row\\_count} $=0$ (parent apatite Pb$_{10}$(PO$_4$)$_6$O is mp-1220209)"),
]

plt.rcParams.update({
    "font.family": "serif", "font.size": 10,
    "axes.linewidth": 0.8, "figure.dpi": 150,
})

fig, ax = plt.subplots(figsize=(7.3, 3.2))
ax.set_xlim(0, 1); ax.set_ylim(0, len(NEGATIVES))
ax.axis("off")

# Header
HEAD_Y = len(NEGATIVES) + 0.3
for x, w, label in [(0.00, 0.22, "axis"),
                    (0.22, 0.38, "source / test"),
                    (0.60, 0.22, "predicted / observed"),
                    (0.82, 0.18, "outcome")]:
    ax.add_patch(mpatches.Rectangle((x, HEAD_Y - 0.2), w, 0.4,
                                     facecolor="#cfd8dc", edgecolor="black", linewidth=0.6))
    ax.text(x + w/2, HEAD_Y, label, ha="center", va="center",
            fontsize=9.5, fontweight="bold", color="black")

# Rows
for i, (axis, src, val, out) in enumerate(reversed(NEGATIVES)):
    y = i + 0.5
    # Background stripe
    bg = "#fafafa" if i % 2 == 0 else "#ffffff"
    ax.add_patch(mpatches.Rectangle((0, i), 1, 1,
                                     facecolor=bg, edgecolor="lightgray", linewidth=0.3))
    # Axis label
    ax.text(0.01, y, axis, ha="left", va="center", fontsize=9,
            fontweight="bold", color="#37474f")
    # Source
    ax.text(0.23, y, src, ha="left", va="center", fontsize=8.5, color="#444")
    # Value
    ax.text(0.61, y, val, ha="left", va="center", fontsize=8.5, color="#444")
    # Outcome (red badge)
    is_fail = "FAIL" in out or "row_count" in out or "aggregate" in out
    badge_color = "#c62828" if is_fail else "#ef6c00"
    ax.text(0.83, y, out, ha="left", va="center", fontsize=8,
            color=badge_color, fontweight="bold")

ax.set_title("Four-source honest-negative for LK-99 (Pb$_{10-x}$Cu$_x$(PO$_4$)$_6$O at 300\\,K)",
             fontsize=10, pad=12)

plt.tight_layout()
out_path = "/Users/ghost/core/demiurge/PAPERS/sample-nb-bcs-absorbed/figures/fig04_lk99_negative_table.pdf"
plt.savefig(out_path, bbox_inches="tight", pad_inches=0.05)
print(f"[fig04] wrote {out_path}")
