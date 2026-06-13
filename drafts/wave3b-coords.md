# wave3b coords research (Cycle 18) — RESOLVED so far

## CeH9 — RESOLVED ✓
src: Salke 2019 Nat.Commun 10, 4453 (arxiv 1805.02060) — PMC6773858
SG: P6_3/mmc (#194); a=3.7110 Å, c=5.5429 Å @ 100 GPa
- Ce 2d  (2/3, 1/3, 1/4)
- H  2b  (0, 0, 1/4)
- H  4f  (1/3, 2/3, 0.1499)
- H  12k (0.1565, 0.8435, 0.4404)  [12k: (x,2x,z) form -> x=0.1565, z=0.4404]
Pressure: ~88-100 GPa. Use 100 GPa = 1000 kbar.

## Li2MgH16 — RESOLVED ✓
src: Sun 2019 PRL 123,097001 (predict); coords from Table S1 of arxiv 2305.04875 (solid phase)
SG: Fd-3m (#227); a=b=c=6.718513 Å @ 260 GPa
- Li 16c (0.62500, 0.87500, 0.87500)
- Mg 8b  (0.00000, 0.00000, 0.00000)
- H  32e (0.83306, 0.16694, 0.16694)  [free x=0.83306]
- H  96g (0.06466, 0.24560, 0.43534)  [3 free]
ratio 16:8:32:96 = 2:1:4:12 = Li2 Mg1 H16 ✓
Pressure: 250-260 GPa. Use 250 GPa = 2500 kbar (Sun prediction).

## YH9 — PENDING (P6_3/mmc, transfers from CeH9 with Y)
## YH10 — PENDING (Fm-3m sodalite: Y 4a, H 32f x~?, H 8c)

## YH9 — RESOLVED ✓ (isostructural transfer from CeH9, lit-grounded)
src: Kong 2021 NatCommun 12,5075 (arxiv 1909.xxxx measured 243K@201GPa);
     phase = P6_3/mmc-1 H29 clathrate (Peng2017 1612.xxxx; confirmed isostructural to CeH9
     in arxiv 2302.01122 "Superconducting phases of YH9": "P63/mmc-1 ... clathrate structure
     with H29 cage, widely exists in rare earth metal superhydrides")
SG: P6_3/mmc (#194). H29 cage SAME topology as CeH9 → transfer Ce→Y at 2d:
- Y  2d  (2/3, 1/3, 1/4)
- H  2b  (0, 0, 1/4)
- H  4f  (1/3, 2/3, 0.1499)
- H  12k (0.1565, 0.8435, 0.4404)
Pressure: P63/mmc-1 harmonic-stable ABOVE 250 GPa (2302.01122 Fig S4: imag modes <250).
  Measured Tc 243K @ 201 GPa. USE 250 GPa = 2500 kbar (safe harmonic basin).
  est a ~ 3.58 Å (Y smaller than Ce) — vc-relax refines.

## YH10 — RESOLVED ✓ (Fm-3m sodalite, LaH10-isostructural, lit-grounded)
src: Liu/Peng/Ma 2017 PNAS 114,6990 (predicted YH10 Tc~303K@400GPa);
     isostructural to LaH10 sodalite (Errea 2020 Nature, Geballe 2018).
SG: Fm-3m (#225) sodalite clathrate. Single free param = 32f.
- Y  4a  (0, 0, 0)            [4b origin choice equiv]
- H  8c  (1/4, 1/4, 1/4)
- H  32f (x,x,x), x = 0.375   [H8-cube vertices; lit value, 0.12 = 0.5-0.375 partner; vc-relax refines]
ratio 4a:8c:32f = 1 Y : 8 H : 32 H ... wait need YH10 = 1:10. 
  CHECK: Fm-3m conventional cell Z=4 f.u. → 4 Y (4a), H8c=8, H32f=32 → 40 H = 4*10 ✓ YH10 ✓
Pressure: predicted ~250-300 GPa stable. USE 250 GPa = 2500 kbar (Peng lower bound, matches budget/family).
  est a ~ 4.75 Å (LaH10 4.748@300; Y smaller) — vc-relax refines.

## ALL 4 RESOLVED — none skipped. Pressures (kbar): CeH9=1000, YH9=2500, YH10=2500, Li2MgH16=2500.
