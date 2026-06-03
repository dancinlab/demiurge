# OA-CURE — in-silico results (reproducibility artifacts)

Instance of the universal neogenesis-bottleneck framework (CURE-PRIMITIVE, d4 single dispatch).
Generic primitive: `exports/CURE-PRIMITIVE/round1/cure_axis_collapse.py`.

## OA manifest (single dispatch — manifest only, no per-disease code)

| class (mass)                      | eta_now | eta_max (no senolytic) | role / arm                         |
|-----------------------------------|---------|------------------------|------------------------------------|
| reversible chondrocyte (0.35)     | 0.70    | 0.90                   | dedifferentiation reversal         |
| dormant progenitor (0.30)         | 0.45    | 0.75                   | chondrogenic reactivation          |
| fibrillated/lost cartilage (0.35) | 0.05    | 0.40 (LOWEST of 4)     | chondral neogenesis (BINDING AXIS) |

ceiling = sum(mass*eta):
- current therapy: 0.40
- best-achievable (no senolytic): **0.68 → gate (>=0.90) BLOCK**

## Cross-cure context (4 senolytic-closable cures)

OA lost-class eta_max = 0.40 is the LOWEST among the four (alopecia 0.49, periodontal 0.55,
retinal 0.45, OA 0.40) → **OA is the hardest of the four senolytic-closable cures**.

## Senolytic lift (SENOLYX niche senescent-cell clearance phi)

eta_lost(phi) = 0.40 + 0.60*phi   (clearance re-opens the chondral neogenesis window)
eta_dorm(phi) = 0.75 + 0.25*phi   (SASP also gates the dormant progenitor pool)
eta_rev fixed at 0.90.

ceiling(phi) = 0.35*0.90 + 0.30*(0.75+0.25*phi) + 0.35*(0.40+0.60*phi)

| clearance phi | 0    | 40%  | 60%  | 78%  | 95%  |
|---------------|------|------|------|------|------|
| ceiling       | 0.68 | 0.78 | 0.85 | 0.90 | 0.95 |

Gate closes at phi* = (0.90 - 0.7775)/0.285 = **0.772 (~78%)**.

## Secondary binding axis — avascular delivery

Cartilage is avascular → intra-articular delivery with matrix diffusion. Effective clearance
phi_eff = delta * phi, delta in (0,1]. Headline phi* assumes delta=1 (mechanism-limited).
Delivery cap delta is literature-order (ORANGE), requires intra-articular PK.

## Honest tiers (g63 / d6)

- GREEN: axis-collapse arithmetic; OA ceiling 0.68 BLOCK; lost-class lowest of 4; senolytic crossing phi*~78%.
- YELLOW: senescent chondrocytes drive OA + are a validated senolytic target (Jeon 2017, Coryell 2021).
- ORANGE: per-class eta values + phi->eta coupling + intra-articular delivery cap = literature-order estimates.
- No efficacy claim. The eta values are literature-ORDER; the binding-axis ordering is robust to their exact values.

## Reproduce

```
python fig01_senolytic_oa.py   # -> fig01 ok  phi_star=0.772
python fig02_classdecomp.py    # -> fig02 ok  ceiling_now=0.398 ceiling_ach=0.680
```
(use /private/tmp/aga-dock-tc/mamba/envs/dock/bin/python)

Paper: `PAPER/oa-cure-cartilage-regen/` (build: `tectonic main.tex`).
