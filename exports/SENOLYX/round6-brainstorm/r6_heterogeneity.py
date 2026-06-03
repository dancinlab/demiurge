#!/usr/bin/env python3
# R3: does senescent-cell HETEROGENEITY (a BCL-xL-resistant fraction) break the ≥60% niche
# clearance the cure gate needs? Monotherapy (BCL-xL) vs 2-drug cocktail (BCL-xL + non-BCL axis).
import numpy as np
# senescent population: fraction r BCL-xL-dependent (killable by SENOLYX warhead), 1-r resistant
# (BCL-xL-independent: MCL-1/other). kill efficiency per axis on its susceptible subset.
e_bclxl=0.90   # SENOLYX kills 90% of BCL-xL-dependent senescent cells
e_alt  =0.80   # a 2nd axis kills 80% of the resistant subset
print("=== R3 senescent heterogeneity: monotherapy vs cocktail clearance ceiling ===")
print(f"{'BCL-xL-dependent frac r':>24s} {'mono clearance':>14s} {'cocktail clearance':>18s} {'≥60% gate?':>22s}")
for r in [0.5,0.6,0.7,0.8,0.9]:
    mono = r*e_bclxl                          # only the dependent subset cleared
    cocktail = r*e_bclxl + (1-r)*e_alt        # both subsets
    gm = 'mono FAIL' if mono<0.60 else 'mono ok'
    gc = 'cocktail ok' if cocktail>=0.60 else 'cocktail FAIL'
    print(f"{r:>22.0%}   {mono*100:12.0f}%  {cocktail*100:16.0f}%   {gm} / {gc}")
print()
print("FINDING: if the BCL-xL-dependent fraction r < ~0.67, MONOTHERAPY clearance falls below the")
print("60% the cure gate requires (mono ceiling = r·0.90). A 2-axis COCKTAIL (BCL-xL + non-BCL")
print("e.g. MCL-1/FOXO4-DRI) restores clearance ≥60% across the whole r range — senescent")
print("heterogeneity makes a COCKTAIL necessary when the resistant fraction is large.")
print("⇒ SENOLYX should be a 2-axis cocktail, not BCL-xL monotherapy, for niches with low r.")
print("g63: r and per-axis kill are literature-order; the structural point (heterogeneity →")
print("cocktail when r low) is robust. The non-BCL-xL 2nd axis is the R1 NEW target to add.")
