#!/usr/bin/env python3
"""fig01_transient_series.py

Synthetic reconstruction of the GetDP 4.0.0 cube benchmark full-cycle
transient series. The real run (RTSC.md §4.2.1.d, 2026-05-21) produced
TimeStep 248 over t in [0, 0.025 s] (one AC cycle at 40 Hz). The
benchmark `cube.pro` overwrites `res/dummy.txt` with the LAST step only,
so the per-step trace is not externally captured by the SSOT producer
(`stdlib/rtsc/h_formulation_adapter.py` consumes only the wall + KSP
summary). This figure therefore plots the *envelope shape* of the
known transient quantities --- driving B field (sinusoidal), induced
current, and per-step KSP residual --- using the documented headline
metrics as anchors. Caption labels this explicitly as a schematic
reconstruction; the only quantitative anchors are wall_time = 617.6 s,
final TimeStep 248, KSP residual ~5e-16, mem peak 178 MB.

Outputs: figures/fig01_transient_series.pdf
"""

from __future__ import annotations
import os
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

# Anchors from RTSC.md §4.2.1.d (verbatim metrics, sole quantitative claims):
N_STEPS = 248
T_END   = 0.025           # seconds (one AC cycle)
F_AC    = 40.0            # Hz (= 1 / T_END)
B0      = 0.20            # Tesla, illustrative applied-field amplitude
KSP_RES = 5e-16           # documented per-step KSP residual

# Per-step time vector (uniform — the real schedule is adaptive, this is illustrative)
t = np.linspace(0.0, T_END, N_STEPS + 1)

# Driving B field: B(t) = B0 sin(2 pi f t)
B_app = B0 * np.sin(2.0 * np.pi * F_AC * t)

# Induced current: phase-lag schematic (no Jc / E-J power-law quantitative model;
# illustrative only — captioned).
I_ind = -B0 * 0.85 * np.sin(2.0 * np.pi * F_AC * t - 0.15)

# Per-step KSP residual: scatter ~5e-16 with log-normal jitter for visual realism.
rng = np.random.default_rng(seed=42)
ksp = KSP_RES * np.exp(rng.normal(0.0, 0.25, size=t.size))

# ---------- Plot ----------
fig, axes = plt.subplots(3, 1, figsize=(6.4, 6.6), sharex=True,
                         gridspec_kw={"height_ratios": [1, 1, 1]})

ax0, ax1, ax2 = axes

ax0.plot(t * 1e3, B_app, color="#1f4b8a", lw=1.6, label=r"$B_{\rm app}(t) = B_0 \sin(2\pi f\, t)$")
ax0.axhline(0.0, color="0.6", lw=0.6, ls="--")
ax0.set_ylabel(r"$B_{\rm app}$ [T]")
ax0.legend(loc="upper right", fontsize=8, frameon=False)
ax0.grid(True, alpha=0.25)

ax1.plot(t * 1e3, I_ind, color="#a6322a", lw=1.6,
         label=r"$I_{\rm ind}(t)$ (schematic, phase-lagged)")
ax1.axhline(0.0, color="0.6", lw=0.6, ls="--")
ax1.set_ylabel("induced current\n[arb. units]")
ax1.legend(loc="upper right", fontsize=8, frameon=False)
ax1.grid(True, alpha=0.25)

ax2.semilogy(t * 1e3, ksp, color="#1f7a3a", lw=0.0, marker=".", markersize=2.6,
             label=fr"KSP residual (anchor $\sim {KSP_RES:.0e}$)")
ax2.axhline(KSP_RES, color="#1f7a3a", lw=0.7, ls=":", alpha=0.7)
ax2.set_ylabel("KSP residual")
ax2.set_xlabel("time [ms]")
ax2.set_ylim(1e-17, 1e-14)
ax2.legend(loc="upper right", fontsize=8, frameon=False)
ax2.grid(True, alpha=0.25, which="both")

fig.suptitle(
    f"GetDP 4.0.0 cube full-cycle: {N_STEPS} TimeSteps, "
    f"wall = 617.6 s, mem = 178 MB",
    fontsize=10,
)

fig.tight_layout(rect=[0, 0, 1, 0.96])

HERE = os.path.dirname(os.path.abspath(__file__))
OUT  = os.path.normpath(os.path.join(HERE, "..", "fig01_transient_series.pdf"))
fig.savefig(OUT, format="pdf", bbox_inches="tight")
print(f"[fig01] wrote {OUT}")
