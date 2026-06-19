"""
SENOLYX-AG S1 — the decisive AND-gate selectivity index (the make-or-break number).

PRIMARY readout that REPLACES ABFE (which is affinity, the wrong/depleted axis):
    S_total = product of per-axis senescent:healthy recognition ratios, degraded by
              (a) axis correlation rho (independence loss), (b) systemic leak, and
              (c) the Hill co-opening haircut near the kill dose.

This quantifies whether the orthogonal AND-gate (uPAR/DPP4 x SA-beta-gal) multiplies
selectivity robustly, or collapses to a single axis when the two recognition markers
are correlated. Pure ratio-of-ratios => force-field systematic error cancels (the whole
reason this beats ABFE for selectivity).

All inputs are literature-grounded RANGES (d6: model estimate, not measurement):
  uPAR/PLAUR  sen:healthy  ~3-10x   (Amor Nature 2020 / patent 0.5-10x)
  DPP4        sen:healthy  ~3-8x    (Kim Genes Dev 2017, surface ectopeptidase)
  SA-bgal/GLB1 sen:healthy ~3-10x   (C12FDG MdFI, Lee Aging Cell 2006)
  rho (PLAUR<->GLB1 or DPP4<->GLB1): unknown -> swept 0..0.6 (decisive unknown)
  leak (systemic gut/hepatic beta-gal): swept 0..0.30 (MULTIPLICATIVE across axes)
  Hill haircut near kill dose: ~5-8x (round-1 honest assumption)
"""
import numpy as np

# ----- per-axis recognition ratios (sen:healthy), literature ranges -----
AX = {
    "uPAR":    (3.0, 6.0, 10.0),   # surface, fibroblast-validated
    "DPP4":    (3.0, 5.0, 8.0),    # surface, most-orthogonal
    "SAbgal":  (3.0, 5.0, 10.0),   # lysosomal enzyme gate
}

def eff_exponent(k, rho):
    """Correlated axes lose independence: k_eff = 1 + (k-1)*(1-rho)."""
    return 1.0 + (k - 1) * (1.0 - rho)

def s_total(ratios, rho, leak, haircut):
    """ratios: list of per-axis sen:healthy folds (k axes).
    Multiplicative under independence; degraded by rho, multiplicative leak, Hill haircut."""
    k = len(ratios)
    geom = float(np.prod(ratios)) ** (1.0 / k)          # geometric mean per axis
    k_eff = eff_exponent(k, rho)
    naive = geom ** k_eff                                 # independence-degraded product
    # multiplicative leak: a healthy cell must FALSELY pass ALL axes; per-axis false-pass ~ leak
    # discrimination ceiling from leak = 1/leak^k  (a healthy false-positive needs all k leaks)
    leak_ceiling = (1.0 / max(leak, 1e-6)) ** k if leak > 0 else np.inf
    s = min(naive, leak_ceiling)
    return s / haircut                                    # Hill co-opening penalty

def clearable_fraction(S, max_healthy_harm=0.05):
    """At a dose giving <=max_healthy_harm healthy kill, senescent kill fraction.
    Simple competitive model: healthy_harm = d, senescent_kill = min(1, S*d)."""
    d = max_healthy_harm
    return min(1.0, S * d)

def summarize(label, axes, n=20000, seed_offset=0):
    lo = np.array([AX[a][0] for a in axes]); mid = np.array([AX[a][1] for a in axes]); hi = np.array([AX[a][2] for a in axes])
    # deterministic median estimate
    S_med = s_total(mid, rho=0.0, leak=0.05, haircut=6.5)
    print(f"\n=== {label}  (axes: {'+'.join(axes)}) ===")
    print(f"  median (rho=0, leak=5%, haircut 6.5x): S_total = {S_med:5.2f}x  -> clearable@5%harm = {clearable_fraction(S_med)*100:4.1f}%")
    # robustness box: the PASS gate is S>=10x ACROSS rho[0,0.5] x leak[0,0.2]
    box_min = np.inf; worst = None
    for rho in np.linspace(0, 0.5, 6):
        for leak in np.linspace(0, 0.2, 5):
            s = s_total(mid, rho, leak, 6.5)
            if s < box_min: box_min = s; worst = (rho, leak)
    print(f"  robustness box min over rho[0,.5]xleak[0,.2]: S = {box_min:4.2f}x at rho={worst[0]:.2f} leak={worst[1]:.2f}")
    print(f"    PASS(>=10x across box)? {'YES' if box_min>=10 else 'NO'}   collapse(<2x anywhere)? {'YES' if box_min<2 else 'NO'}")
    # uncertainty band: Monte-Carlo over ratio ranges + rho/leak priors (deterministic grid, no RNG seed needed)
    samples = []
    grid_r = np.linspace(0,0.5,11); grid_l = np.linspace(0,0.25,11)
    for rho in grid_r:
        for leak in grid_l:
            for fr in (lo, mid, hi):
                samples.append(s_total(fr, rho, leak, 6.5))
    samples = np.array(sorted(samples))
    p10, p50, p90 = np.percentile(samples, [10,50,90])
    print(f"  band over priors: S_total 10/50/90 = {p10:4.2f} / {p50:4.2f} / {p90:5.2f} x")
    return S_med, box_min, (p10,p50,p90)

if __name__ == "__main__":
    print("="*74)
    print("SENOLYX-AG S1 — AND-gate selectivity index (decisive number)")
    print("="*74)
    # single axis (the ceiling-bound baseline) vs 2-axis gate vs 3-axis
    summarize("SINGLE marker (uPAR only)", ["uPAR"])
    summarize("2-axis gate  uPAR x SA-bgal (fibroblast-best)", ["uPAR","SAbgal"])
    summarize("2-axis gate  DPP4 x SA-bgal (most-orthogonal)", ["DPP4","SAbgal"])
    summarize("3-axis gate  uPAR x DPP4 x SA-bgal", ["uPAR","DPP4","SAbgal"])
    print("\n--- INTERPRETATION (d6 honest) ---")
    print("The make-or-break unknown is rho (axis independence). The 2-axis gate only")
    print("clears the senescent target meaningfully when rho is small (<~0.3). DPP4 x SA-bgal")
    print("is more orthogonal than uPAR x SA-bgal (different regulatory hubs) -> lower rho.")
    print("The decisive wet-data-free next step: estimate rho(PLAUR<->GLB1) and rho(DPP4<->GLB1)")
    print("from public single-cell senescence atlases; whichever pair has lower rho wins the design.")
