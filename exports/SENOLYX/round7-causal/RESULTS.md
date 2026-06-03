# SENOLYX round-7 — causal model (closes /gap F4 counterfactual top-1)

## Gap closed
/gap top-1: the load-bearing "senescent clearance → regeneration recovery" was only
literature-ASSOCIATION. R7 makes it a MECHANISTIC CAUSAL hypothesis with a do-operator
intervention model + a pre-registered experiment separating causation from age-confound.

## Mechanism (Pearl do-operator)
SASP from senescent burden b Hill-represses progenitor proliferation:
  η_neo(b) = η_max / (1 + (k_S·b / K)^n),  η_max=0.95, K=0.5, n=2.
do(clearance φ): b → (1−φ)·b0 (intervention), giving:
| clearance φ | residual b | η_neo |
|---|---|---|
| 0% | 0.80 | 0.27 |
| 40% | 0.48 | 0.49 |
| 60% | 0.32 | 0.67 |
| 80% | 0.16 | 0.86 |
| 95% | 0.04 | 0.94 |
(honest calibration: illustrative b0=0.8 → floor 0.27; to match the AGA DC14 human floor
η_neo≈0.49 set b0≈0.49. The structural contribution — do-operator + Hill repression — is
robust to the exact b0; absolute η are literature-order, g63.)

## Counterfactual falsifier (causation vs age-confound)
Confound model: age A drives BOTH senescent burden AND an independent progenitor deficit d(A).
Clearing senescence young (d=0.02) vs old (d=0.25): lift +0.08 (young, low burden) vs +0.51 (old).
- CAUSAL prediction: clearance lifts η_neo proportional to burden cleared, at ANY fixed age.
- CONFOUND-only prediction: zero lift once age is controlled.
- **DISTINGUISHING EXPERIMENT (pre-registered, falsifiable):** co-culture progenitors with GRADED
  senescent burden at FIXED age; measure neogenesis. Causal ⇒ monotone η↑ as burden↓ (Hill slope
  n>0); confound ⇒ flat (slope≈0). The slope sign is the refutation criterion.

## Verdict
Converts SENOLYX's central assumption from association to a falsifiable causal model with a clean
in-vitro test. The /gap F4 top-1 gap is now structurally addressed (mechanism + falsifier);
empirical confirmation remains the in-vitro step (the experiment is specified).
