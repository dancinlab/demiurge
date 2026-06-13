# AGA-RX Round-4 — PK/PD → ANAGEN% efficacy model + g5 verification

date: 2026-06-03 · host: mini · milestone = **VERIFY**
method: in-silico PK/PD coupling — round-3 follicular PK → SFRP1 occupancy → Wnt
de-repression → anagen-fraction shift in the **Al-Nuaimi/Dobreva human hair-cycle ODE**
(arXiv **2502.15035**, Dobreva, Comer, Cogan, Paus 2025).
scripts: `model.py` (PK/PD simulation, sympy/scipy) · `verify_identities.py` (g5 deterministic checker)
honesty (d6): every number is computed from the cited model + measured/lit-bracketed inputs.
The single unmeasured PD parameter (E_max) is reported as a **bracket**, not a point — no fabricated effect size.

---

## 1. PD backbone (cited, verbatim)

Al-Nuaimi et al. (2012) modelled the human hair cycle as a **relaxation oscillator** in the
matrix-keratinocyte (MK) population ξ; Dobreva 2025 (arXiv 2502.15035) re-informed it with
Courtois (1995) AGA anagen/telogen data. Eq.(1)–(5):

```
dξ/dt  = p1·ξ/[(p2+ξ)(p3+Cprol·z1)] − p4·ξ/(p5^k + ξ^k) + α − β·ξ     (1)
dn1/dt = c1·ξ + Dη·(n2 − d1·n1)                                       (2)
dn2/dt = Dη·(n1 − d2·n2)                                              (3)
dz1/dt = Dz·(z2 − d3·z1)                                              (4)
dz2/dt = c2·n2 + Dz·(z1 − d4·z2)                                      (5)
```

- ξ(t) = relaxation oscillation: **long upper state = ANAGEN**, short lower state = telogen/catagen (paper p.4).
- **AGA disease knob = p4 (MK apoptosis)** — paper Results: normal p4 ≈ 0.4994–0.5269; AGA mild
  0.5136–0.5405; AGA severe ≥ 0.5405 (≤ 0.5634). Sobol GSA: in severe AGA, **p4 + Cprol dominate** anagen length.
- Nominal params (Table 1): α=0.1, β=0.01, p1=0.48, p2=0.1, p3=0.1, p5=0.32, Cprol=1, c1=c2=1,
  k=2.036, Dη=0.5, Dz=0.1, d1=d2=d3=d4=2. ICs (p.8): ξ0=0.01, n1=n2=0.5, z1=2, z2=0.5.
- This round uses **p4_normal = 0.5096** (control subj A last cycle, Fig.1B) and **p4_AGA = 0.5393**
  (AGA subj E last cycle, Fig.2B) as representative anchors.

## 2. PK→occupancy→PD coupling (the round-4 contribution)

SFRP1 is a secreted Wnt antagonist **up-regulated in the AGA dermal papilla**; WAY-316606 inhibits it,
**de-repressing Wnt** and restoring the MK-proliferation drive the AGA state suppresses. Mechanistic map:

```
C_DPC   = C_surf · exp(−z_DP/λ_foll)         (round-3 PK.md, INHERITED d19)
θ       = C_DPC / (C_DPC + Kd)               (equilibrium SFRP1 occupancy)
p4(dose)= p4_AGA − θ · E_max · (p4_AGA − p4_normal)   (fractional reversal of the AGA p4 elevation)
```

Anchors: WAY-316606 SFRP1 **Kd = 0.08 mM = 80 µM** (lit); EC50 0.65 µM (measured, ex-vivo active);
C_surf 0.1% w/v = 2230 µM, 1% w/v = 22300 µM; z_DP 1.0–1.5 mm; λ_foll 0.2–2.0 mm (round-3 bracket).
**E_max** (max Wnt-de-repression efficacy, 0=no effect, 1=full restoration to normal) is the **one
unmeasured parameter** → reported as a [0.25, 1.0] bracket.

## 3. Results (from `model.py`)

### 3a. PD baselines — AGA shortens anagen (reproduces the paper's qualitative finding)

| state | p4 | anagen fraction | mean anagen (model-d) | mean telogen (model-d) |
|---|---|---|---|---|
| normal | 0.5096 | **0.883** | 531 | 75 |
| AGA (vehicle) | 0.5393 | **0.772** | 245 | 69 |

AGA anagen-fraction deficit vs normal = **−0.111 (−12.6% of normal)**; the headline AGA signature
(anagen shortened 531→245 model-days, ~2.2×) matches the paper's "progressively shortening anagen."

### 3b. SFRP1 occupancy θ at the DPC across the PK bracket (Kd=80 µM)

| C_surf | z_DP | λ_foll | C_DPC (µM) | θ |
|---|---|---|---|---|
| 0.1% | 1.5 mm | 0.2 mm | 1.2 | 0.015 (worst corner) |
| 0.1% | 1.0 mm | 1.0 mm | 820 | **0.911 (typical)** |
| 1% | 1.0 mm | 2.0 mm | 13526 | 0.994 (best) |

Across the realistic typical-to-best PK bracket, **θ = 0.79–0.99** — SFRP1 is near-saturated at the DPC.
Only the extreme worst corner (deepest follicle × shortest λ, 0.1% dose) drops θ below the EC50/Kd margin.

### 3c. Predicted anagen% increase vs vehicle

| PK corner (θ) | E_max=0.25 | E_max=0.5 | E_max=1.0 |
|---|---|---|---|
| worst (θ=0.015) | −0.0% | −0.0% | +0.7% |
| **typical (θ=0.911)** | +2.0% | **+6.4%** | **+13.6%** |
| best (θ=0.994) | +3.4% | +6.7% | +13.9% |

**Biological ceiling** (full restoration to normal anagen fraction) = **+14.4% vs vehicle** — the model is
self-limiting (the drug can at most return AGA to the normal cycle, never exceed it).

### 3d. Effect-size vs Standard-of-Care

| therapy | reported effect | model-comparable basis |
|---|---|---|
| finasteride | +107 hairs/yr-1 (1 cm²) ≈ +9–11% density | systemic 5αR |
| minoxidil | ~ +12–15% count (mid-frontal) | topical vasodilator/K-channel |
| **WAY-316606 (this model)** | **+13.6% anagen-frac vs vehicle (typical PK, E_max=1)**; +6.4% at E_max=0.5; ceiling +14.4% | topical SFRP1/Wnt, non-AR |

**Verdict on competitiveness:** at saturating SFRP1 occupancy and full Wnt-de-repression efficacy, the
projected anagen-fraction gain (**+13.6%**) **lands inside the minoxidil band and above the finasteride
band** — i.e. competitive. At half efficacy (E_max=0.5) it is **+6.4%**, sub-SoC but still positive. The
finding is **sign-robust** (positive across the entire occupancy×E_max bracket except the single worst PK
corner) and **mechanistically orthogonal** to the AR axis (relieves the round-3 sexual-side-effect liability).

## 4. Honest limits (d6)

- **E_max is unmeasured** → the result is a bracket, not a point. The competitiveness claim holds only at
  the upper E_max; it is honestly conditional. Converting E_max to a measured number needs an ex-vivo
  hair-organ-culture anagen assay (wet-lab, out of software scope).
- anagen-fraction → hair-density is a **linear proxy**, not a fitted transfer function.
- p4_normal/p4_AGA are **subject-representative** (Fig.1B/2B), not a population fit; the % deltas are
  model-internal and sign-robust, but absolute days are nominal.
- The PK θ inherits round-3's λ_foll/D_foll literature bracket (🟠 → 🟢 only via Franz-cell wet-lab).

## 5. g5 VERIFICATION — verbatim `hexa verify` verdicts

Tool: `hexa verify --verifier-cmd` (VERIFY-KIT **V8** — pluggable external deterministic verifier,
phanes tenant-verifier model). The Python checker `verify_identities.py` **IS the judge** (g5 — no LLM
self-judge); hexa records its verdict verbatim and maps exit-code+stdout-match to a tier.
HEXA_LANG=/Users/mini/dancinlab/hexa-lang.

### Claim 1 — PK lag-time identity t_lag = h²/(6D)
```
  claim    = PK lag-time identity t_lag = h^2/(6D) (Daynes-Barrer membrane time-lag)
  ext rc   = 0
  ext out  = VERDICT: t_lag derived from Daynes-Barrer asymptote = h**2/(6*D) ; target h^2/(6D) = h**2/(6*D) ; identity_holds=True
  expect = matched ("identity_holds=True")
  tier   = 🟢 SUPPORTED-NUMERICAL  (external verifier passed AND stdout matches --expect — delegated, deterministic)
```

### Claim 2 — EMLA onset anchor 2·t_lag = 55.6 min
```
  claim    = EMLA onset 2*t_lag = 55.6 min at h=10um D=1e-10 cm2/s
  ext rc   = 0
  ext out  = VERDICT: EMLA onset 2*t_lag = 55.6 min ; expected 55.6 min ; match=True
  expect = matched ("match=True")
  tier   = 🟢 SUPPORTED-NUMERICAL  (external verifier passed AND stdout matches --expect — delegated, deterministic)
```

### Claim 3 — occupancy identity θ = C/(C+Kd)
```
  claim    = Occupancy theta=C/(C+Kd): half at C=Kd, Langmuir-equiv, limits 0/1
  ext rc   = 0
  ext out  = VERDICT: theta=C/(C+Kd): theta(Kd)=1/2 ->True; lim_hi=1,lim_lo=0 ->True; Langmuir-equiv ->True; all=True
  expect = matched ("all=True")
  tier   = 🟢 SUPPORTED-NUMERICAL  (external verifier passed AND stdout matches --expect — delegated, deterministic)
```

### Claim 4 — depth attenuation C(z) = C_surf·exp(−z/λ)
```
  claim    = Depth attenuation C(z)=C_surf*exp(-z/lambda) solves dC/dz=-C/lambda, C(0)=C_surf
  ext rc   = 0
  ext out  = VERDICT: dC/dz=-C/lambda, C(0)=C_surf => C(z)=C_surf*exp(-z/lambda) ; target C_surf*exp(-z/lambda) ; identity_holds=True
  expect = matched ("identity_holds=True")
  tier   = 🟢 SUPPORTED-NUMERICAL  (external verifier passed AND stdout matches --expect — delegated, deterministic)
```

### Claim 5 — PD monotonicity (the anagen sign-robust finding)
```
  claim    = PD: AGA p4-elevation shortens anagen; SFRP1-occupancy reversal increases it, bounded by normal
  ext rc   = 0
  ext out  = VERDICT: f_norm=0.883 f_aga=0.772 f_partial=0.821 f_full=0.883 ; AGA<normal->True; partial>AGA->True; full>AGA->True; full<=normal->True ; monotone_PD_holds=True
  expect = matched ("monotone_PD_holds=True")
  tier   = 🟢 SUPPORTED-NUMERICAL  (external verifier passed AND stdout matches --expect — delegated, deterministic)
```

**g5 summary:** 5/5 quantitative claims **🟢 SUPPORTED-NUMERICAL** via hexa V8 delegated deterministic
verifier. The two closed-form identities (t_lag, occupancy) are exact symbolic identities (sympy
`simplify == 0`); hexa's V8 maps the deterministic exit-0+match to 🟢 (it does not auto-mint 🔵 for an
external verifier — the 🔵 tier is reserved for hexa-native recompute of an atlas atom). The symbolic
derivations are exact (would be 🔵 under a hexa-native symbolic recompute); they are honestly recorded at
the **delegated-deterministic 🟢** tier the V8 path assigns.
