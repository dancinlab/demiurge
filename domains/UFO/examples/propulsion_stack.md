# 7-stage Propulsion Stack — Evolution Table

`hexa-ufo` organizes its substrate atlas around a 7-stage propulsion ladder.
Each stage is keyed to an `alien_index` band and a candidate physical
substrate. Stages 1-3 are **substrate-grounded** (sister repos exist);
Stages 4-7 are **TBD** (no public substrate exists yet).

## Evolution table

| Stage | alien_index | Mechanism                                | Operating regime         | Sister substrate (public)                                    | Status     |
|-------|-------------|------------------------------------------|--------------------------|--------------------------------------------------------------|------------|
| 1     | ~6-10       | Meissner diamagnetism (RT-SC 48T coil)   | 0~20 km altitude         | [`dancinlab/hexa-rtsc`](https://github.com/dancinlab/hexa-rtsc)             | grounded   |
| 2     | ~10         | MHD + tabletop fusion (D-T / p-11B)      | 20~200 km                | [`dancinlab/hexa-fusion`](https://github.com/dancinlab/hexa-fusion)         | grounded   |
| 3     | ~10         | antimatter gamma-rocket (anti-H + H, Isp 10^10 s) | 200 km~1 AU       | [`dancinlab/hexa-antimatter`](https://github.com/dancinlab/hexa-antimatter) + [`hexa-cern`](https://github.com/dancinlab/hexa-cern) | grounded   |
| 4     | ~11         | Alcubierre warp bubble (sigma-phi=10 m, v_s = sigma^2 = 144c) | 1 AU~galactic | — (no public substrate)                                        | **TBD**    |
| 5     | ~12         | Morris-Thorne ER bridge (b_0 = sigma*tau = 48 m) | intergalactic   | — (no public substrate)                                        | **TBD**    |
| 6     | ~13         | KK-tower 4.8 TeV brane transit (dim-jump) | bulk-wide               | — (no public substrate)                                        | **TBD**    |
| 7     | ~14         | Calabi-Yau 6-fold navigation (dim-use)    | observer-invisible      | — (no public substrate)                                        | **TBD**    |

## 484-tier indexing convention

The atlas uses an arithmetic indexing convention based on the n=6 lattice:

```
  L(k) = 24^(k-15)        for k = 15, 16, 17, 18, ...
  L(15) = 1
  L(16) = 24
  L(17) = 576
  L(18) = 13824
  ...
```

This is an **indexing convention**, not an empirical claim. The 484 tiers
span META-LK017 through META-LK500.

## Honest scope

- Stages 1-3: substrate exists in public sister repos. Cross-verify there
  for empirical claims.
- Stages 4-7: TBD. Atlas describes them narratively but no public substrate
  has been independently verified. Treat as design-draft / thought-experiment.
- This file is a navigation aid, not an engineering spec.

## Cross-link

- Sister: <https://github.com/dancinlab/hexa-rtsc>      (Stage-1)
- Sister: <https://github.com/dancinlab/hexa-fusion>    (Stage-2)
- Sister: <https://github.com/dancinlab/hexa-antimatter> (Stage-3)
- Sister: <https://github.com/dancinlab/hexa-cern>    (Stage-3 aux)
- Atlas:  `hexa-ufo ufo` (or `ufo/doc/hexa-ufo.md` — 1890 LOC)
