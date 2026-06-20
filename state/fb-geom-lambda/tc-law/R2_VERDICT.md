# TC-LAW r2 — Exponential-Collapse + Family-Offset

🧪 **Lane** tc-law · **Round** r2 · **Date** 2026-06-19
**Goal** Test whether a SINGLE 2-parameter Allen-Dynes-exponential ansatz collapses ALL phonon
families (hydride + classic) onto one curve, with the residual-from-curve as the family fingerprint
(hydride≈0; kagome = non-phonon EXCESS to be quantified).

---

## §hypothesis (falsifiable)

**H2 (universal exponential + family offset):** the 2-parameter ansatz

> `y(λ) = Tc/ω_log = A·exp[ −B·(1+λ)/(λ − μ*(1+0.62λ)) ]`   (μ*=0.10)

collapses **all phonon families** (hydride+classic) onto one curve to **<0.1 dex** RMS, and the
residual from that universal curve is the **family fingerprint**: hydride ≈ classic ≈ 0, while
**kagome shows a clean POSITIVE offset** (= the non-phonon flat-band/vHS excess Tc).

**Pre-registered falsifier (from r1 §Next-round):** if the collapsed-curve residual is **NOT
systematically family-ordered** (hydride < classic < kagome, kagome strictly positive), the
"universal-exponential + single-sign family-offset" reading is **CLOSED-NEGATIVE**.

---

## §method

- **Corpus** = same 12-material, 3-family, fully-sourced `tc_corpus.json` from r1 (no new cells).
- **Ansatz linearization** (`r2_collapse.py`, numpy-free): with the AD exponent kernel
  `x = (1+λ)/(λ−μ*(1+0.62λ))`, `ln(y) = ln(A) − B·x` is **linear in x** → closed-form OLS
  slope/intercept. Slope = −B, intercept = ln(A).
- **Fit set = PHONON families only** (hydride+classic, n=9). **Kagome (n=3) held out**; its residual
  vs the phonon-fit curve is the out-of-family offset.
- **Residual metric** = `resid_dex = log10(y_obs / y_curve)` (dex; >0 ⇒ above the universal phonon
  curve ⇒ excess Tc). Family RMS + signed mean offset reported.

---

## §measurement

**Fit (phonon, n=9):** `ln(y) = −0.196 − 1.033·x` → **A = 0.822, B = 1.033**.

| Material | Family | λ | ω_log (K) | Tc (K) | x | y_obs | y_curve | resid (dex) |
|---|---|---|---|---|---|---|---|---|
| Al | classic | 0.43 | 300 | 1.9 | 4.71 | 0.0063 | 0.0063 | **+0.001** |
| MgB2 | classic | 0.87 | 600 | 33.1 | 2.61 | 0.0552 | 0.0554 | **−0.002** |
| NbC | classic | 0.98 | 250 | 16.9 | 2.42 | 0.0676 | 0.0678 | **−0.001** |
| NbN | classic | 1.46 | 150 | 16.7 | 1.94 | 0.1113 | 0.1111 | **+0.001** |
| Pb | classic | 1.55 | 52 | 6.1 | 1.88 | 0.1173 | 0.1176 | **−0.001** |
| Nb3Sn | classic | 1.80 | 130 | 17.3 | 1.76 | 0.1331 | 0.1332 | **−0.000** |
| H3S | hydride | 2.19 | 1335 | 203.7 | 1.63 | 0.1526 | 0.1524 | **+0.001** |
| CaH6 | hydride | 2.45 | 1100 | 179.2 | 1.57 | 0.1629 | 0.1626 | **+0.001** |
| LaH10 | hydride | 2.46 | 1120 | 182.9 | 1.57 | 0.1633 | 0.1629 | **+0.001** |
| **CsV3Sb5** | **kagome** | 0.45 | 198 | 2.6 | 4.50 | 0.0131 | 0.0079 | **+0.222** |
| **LuRu3B2** | **kagome** | 0.56 | 300 | 3.27 | 3.66 | 0.0109 | 0.0187 | **−0.235** |
| **LaRu3Si2** | **kagome** | 0.83 | 220 | 6.8 | 2.69 | 0.0309 | 0.0509 | **−0.216** |

**Collapse quality (RMS dex per family):**

| Family | n | RMS (dex) | signed mean offset (dex) | range |
|---|---|---|---|---|
| hydride | 3 | **0.001** | +0.001 | [+0.001, +0.001] |
| classic | 6 | **0.001** | −0.000 | [−0.002, +0.001] |
| **kagome** | 3 | **0.225** | **−0.076** | **[−0.235, +0.222]** |

- **PHONON collapse RMS (n=9) = 0.001 dex** — essentially exact (target was <0.100). ✅
- **Full-set (n=12) RMS = 0.112 dex** — the 2-param universal exponential **beats the r1 single-FoM**
  (0.382 dex) and **matches Allen-Dynes** (0.133 dex), with all the residual concentrated in kagome.

---

## §finding — 🔴 CLOSED-NEGATIVE (falsifier H2 fired) · with a sharper NOVEL kagome structure

### (1) The exponential collapse is PERFECT for phonon families — but tautologically so

The 2-parameter AD-exponential ansatz collapses hydrides + classics to **0.001 dex** (a factor of
1.002 in Tc). This confirms r1's mechanistic claim that the **unifying form is the exponential**, not
the √λ power law. **Caveat (honesty, d6):** the corpus `Tc_calc` values were *generated* by the
AD-prefactor form, so a 2-param exponential recovering them to ~0 dex is **near-tautological** (the
same circularity flagged for McMillan in r1). The collapse is real evidence that **one exponential law
spans λ=0.43→2.46 across families**, but its tightness is partly by construction; the **discriminating
content is the kagome residual**, which is independent of the fit.

### (2) Kagome does NOT show a clean positive offset → falsifier FIRES

The pre-registered "second-channel" reading predicted kagome residual ≈ a **single positive** offset
(uniform non-phonon excess). The data **refute this**:

| Kagome | resid (dex) | Tc factor vs phonon curve | reading |
|---|---|---|---|
| **CsV3Sb5** | **+0.222** | **1.67× ABOVE** | non-phonon **ENHANCEMENT** (vHS/flat-band adds Tc) |
| **LaRu3Si2** | **−0.216** | 0.61× below | phonon curve **over-predicts** |
| **LuRu3B2** | **−0.235** (calc); **−0.772** vs Tc_exp | 0.58× (calc) / **0.17× (exp)** | phonon **SUPPRESSION** (hardening) |

The kagome residual is **bidirectional**, spanning **−0.24 → +0.22 dex (~1 dex against Tc_exp)** with
**mean ≈ −0.076 (NEGATIVE)**. It is **not family-ordered** (kagome is not "hydride < classic <
kagome"; it straddles the curve) and **not a single-sign non-phonon excess**. → **H2 falsifier fires:
CLOSED-NEGATIVE** on the "universal exponential + clean positive family-offset" hypothesis.

### (3) The NOVEL number — kagome is bidirectional, material-specific, not one channel

Quantifying against **Tc_exp** (the physically real anomaly; calc was AD-back-solved so calc-vs-curve
is partly circular):

- **CsV3Sb5: Tc_exp 1.67× the phonon-curve Tc → ~40% of its Tc is non-phonon** (positive vHS/flat-band
  enhancement). This is the **one genuine "second-channel excess"** in the corpus.
- **LaRu3Si2: 0.63× → phonon over-predicts by ~37%** (no excess; mild suppression).
- **LuRu3B2: 0.17× → phonon over-predicts by ~6× (−0.77 dex)** — strong **phonon-hardening
  suppression**, the OPPOSITE sign of a non-phonon excess.

**The NOVEL cross-family result:** the kagome deviation from the universal e-ph law is **not a uniform
non-phonon Tc excess** — it is a **bidirectional, material-specific** split: **enhancement in the
vanadium-antimonide vHS system (CsV3Sb5, +)** vs **suppression in the Ru-based kagome borosilicides
(LaRu3Si2, LuRu3B2, −)**. A single scalar "kagome non-phonon fraction" does **not** exist; the
non-phonon channel **changes sign with kagome chemistry**.

---

## g5 gate

- **≥8-material cross-family corpus WITH sources** ✅ (reuses r1's 12-material, fully-sourced corpus)
- **Quantified collapse residual (dex) for phonon families** ✅ (hydride/classic RMS = 0.001 dex;
  full-set 0.112 dex < r1-FoM 0.382, ≈ Allen-Dynes 0.133)
- **Quantified kagome offset** ✅ (bidirectional, −0.24 … +0.22 dex; CsV3Sb5 +40% non-phonon vs
  LuRu3B2 −6× suppression — sign-changing, material-specific)
- **HONEST closed-negative recorded** ✅ (H2 falsifier fired: residual NOT family-ordered, kagome NOT a
  clean positive offset; phonon-collapse tightness flagged as partly tautological per d6)
- **No fabricated cells** ✅ (no new materials; estimated-ω_log kagome still flagged; calc-vs-exp
  circularity called out explicitly)

**g5 = PASS** (terminal 🔴 CLOSED-NEGATIVE: the universal 2-parameter exponential collapses phonon
families but the kagome offset is **bidirectional/sign-changing**, not a single-sign non-phonon
excess → the "one universal exponential + one family-offset descriptor" hypothesis is falsified).

---

## Depletion declaration

**r1 (single √λ power-law FoM) = CLOSED-NEGATIVE.**
**r2 (universal 2-parameter exponential + family-offset) = CLOSED-NEGATIVE** (this round).

Both single-descriptor formulations are now closed. Per the r1-registered depletion test, **the
single-descriptor axis is DEPLETED**: neither a power-law FoM nor a 2-parameter universal exponential
(with any single-sign family offset) unifies cross-family Tc. The phonon physics is captured by the
exponential to ~0 dex, but the kagome deviation is **not a one-parameter channel** — it is a
**sign-changing, material-specific** residual that no scalar offset can absorb.

### Pivot — the next lane focus (named, per r1 plan)

The lane now pivots to the **explicit two-term coupling law**:

> `λ_eff = λ_ph + λ_nonphonon`,  with **λ_nonphonon material-specific and SIGNED**
> (positive vHS/flat-band enhancement in V-Sb kagome; effectively negative / hardening-renormalized
> in Ru-kagome).

The r2 finding **constrains** this next lane: a useful two-term law cannot treat λ_nonphonon as a
single positive family constant — it must carry a **sign and a chemistry dependence** (vHS proximity
/ flat-band filling vs phonon-hardening). The next round should (i) extract the kagome λ_nonphonon
per material from the +0.22/−0.77 dex residuals, and (ii) test whether a vHS/flat-band descriptor
(ARPES band-filling distance to vHS, or N(E_F) flat-band weight) predicts the **sign** of the
residual across the three kagome systems. That is a genuine NOVEL two-channel target, distinct from
the now-depleted single-descriptor line.

---

## Artifacts

- `r2_collapse.py` — the collapse fit + residual + falsifier probe (numpy-free, reproducible).
- Corpus `tc_corpus.json` (unchanged from r1).

## Sources

Same as r1 (Two-Channel Allen-Dynes Framework arXiv:2604.04719 Table I; kagome
Nat.Commun.14,1945 / arXiv:2512.16945 / arXiv:2012.15654; Allen & Dynes PRB 12, 905).
