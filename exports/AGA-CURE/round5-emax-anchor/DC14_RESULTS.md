# DC14 — arm④ neogenesis efficiency bracket (corrects DC13)

## Correction of DC13 (honest, d6)
DC13's script concluded "required lift 0.37 is within arm④'s 0.25 headroom → feasible."
This is an **arithmetic error**: 0.37 > 0.25, so even a PERFECT arm④ (η_neo=1.0),
with arms①② held at the current-drug ceiling, reaches only 0.59 + 0.25 = **0.84 < 0.96**.
The gate cannot close on arm④ neogenesis alone.

## Correct decomposition
ceiling (fraction of normal) = (reachable mini+dorm mass 0.75)·η_react + (fibrosed 0.25)·η_neo
- current drugs: η_react ≈ 0.59/0.75 = 0.79, η_neo = 0 → ceiling 0.59 (matches clinical)

## Feasibility frontier for ceiling ≥ 0.96
| η_react | min η_neo needed | verdict |
|---|---|---|
| 0.79 (current) | 1.47 | IMPOSSIBLE (η_neo>1) |
| 0.90 | 1.14 | IMPOSSIBLE |
| 0.95 | 0.99 | mouse-embryo regime only (human-lit ≤0.49) |
| 1.00 | 0.84 | mouse-embryo regime only |

## Literature anchor for η_neo (human-relevant)
- human organoid invagination efficiency: **17–49%** (Kim 2024; DP-spheroid→fibrin microgel 17%→49%)
- mouse-embryonic skin organoids: ~100% (not human-applicable)
- WIHN in vivo: variable, large-wound-dependent (≥1cm), rabbit classic up to 3500 follicles/wound

## Finding (tightens DC9/DC13)
- The ≥0.96 cure gate is **NOT reachable by arm④ neogenesis alone** — corrects DC13.
- It requires BOTH cure-grade reactivation η_react ≳ 0.95 (above the current-drug 0.79)
  AND high neogenesis η_neo.
- With **today's human neogenesis efficiency (≤0.49)**, best-case restoration is
  0.75·1.0 + 0.25·0.49 = **0.87 < 0.96** — the gate cannot close today.
- The true bottleneck is **η_neo: human in-vitro neogenesis must rise from ~0.49 to ~0.84**.
- Residual is therefore a **two-number in-vitro target** (η_react→0.95, η_neo→0.84),
  both bracketable on organoid platforms — neogenesis efficiency is the dominant gap.
