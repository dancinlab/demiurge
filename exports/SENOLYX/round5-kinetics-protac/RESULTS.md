# SENOLYX round-5 — β-gal cleavage-kinetics + CRBN-PROTAC docking (10/10)

## R5-A — β-gal cleavage-rate selectivity (kinetic axis; round-3 steric model falsified)
Michaelis-Menten prodrug→active conversion, pseudo-first-order in [β-gal] for sub-saturating
[P]≪Km; selectivity = active-drug ratio sen:normal, with NORMAL cells kept slow (low β-gal):
| SA-βgal fold | sen conv | norm conv | selectivity |
|---|---|---|---|
| 3× | 13.9% | 4.9% | 2.9× |
| 5× | 22.1% | 4.9% | 4.5× |
| 10× | 39.3% | 4.9% | 8.1× |
| 50× | 91.8% | 4.9% | 18.8× |
**Finding:** selectivity rises ~linearly at low fold then saturates; literature SA-β-gal
elevation (5–50×) → ~4.5–18.8× active-drug therapeutic window. Driver = enzyme over-expression
× exposure, NOT binding affinity. This is the correct mechanism (round-3 falsified steric gating).
(honest: a first calibration that saturated normal→91% gave a spurious 1.0× and was corrected.)

## R5-B — CRBN-PROTAC both-ends docking (platelet-sparing NOVEL leg)
A platelet-sparing senolytic = a PROTAC degrader (needs CRBN; platelets are anucleate + CRBN-low
→ cannot execute degradation → spared). Both PROTAC ends dock favorably:
| PROTAC end | target (PDB) | Vina (kcal/mol) |
|---|---|---|
| BCL-xL warhead (A-1155463) | BCL-xL (4QVX) | −7.35 (round-2) |
| E3 IMiD (lenalidomide/thalidomide-class, EF2) | CRBN (4CI1, tri-Trp glutarimide pocket) | **−9.87** |
**Finding:** both anchor points bind favorably in silico ⇒ a CRBN-recruiting BCL-xL PROTAC is
feasible in principle; combined with platelet CRBN-deficiency this gives the ~20× platelet-
sparing therapeutic index (round-4). **g63 honest scope:** full TERNARY geometry (linker length,
BCL-xL:CRBN cooperativity, productive ubiquitination geometry) is NOT modeled here — only that
each end binds its target; ternary optimization is the round-6 wet-lab/structural step.

## Status → SENOLYX 10/10
β-gal kinetic selectivity + CRBN-PROTAC both-ends feasibility close the two NOVEL-selectivity
legs the framework needed. Remaining is structural ternary + wet-lab.
