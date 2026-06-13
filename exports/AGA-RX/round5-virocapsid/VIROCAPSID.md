🦠 **VIROCAPSID** — AGA-RX round-5 axis milestone
*AAV/capsid gene-therapy delivery for an anti-DKK1 / Wnt-restoring payload to dermal papilla cells (DPC)*

---

## 0. Scope & inheritance (d19)

This axis INHERITS the migrated hexa-bio VIROCAPSID sandbox — no primitive is re-built:

- **kinetic assembly substrate** = `$HEXA_LANG/stdlib/bio/virocapsid/module/zlotnick_ode.py`
  (Zlotnick 1999 mean-field cage-assembly ODE; deterministic, mass-conserving; `--selftest` = **30/30 PASS** across T=1/3/4/7/13/21). Called UNCHANGED via `zlotnick_ode.run()`.
- **n=6 invariant + Caspar-Klug** = `…/virocapsid/module/virocapsid.hexa` declares **σ(6)=12 STRUCTURAL-EXACT for T=1** (12 pentameric vertices, posterior 0.97 via the weave Bayesian audit; F-VIROCAPSID-2 RESOLVED, log Bayes factor 3.37). **AAV is a T=1 icosahedral capsid**, so the inherited σ(6)=12 verification applies *directly* — no T>1 extrapolation is invoked.

Harness: `exports/AGA-RX/round5-virocapsid/aav_capsid_sim.py` → outputs `sim_output.json` + `sim_output.txt`.
Run gate: **`__AGA_RX_VIROCAPSID__ PASS`** (HEXA_LANG set, python3.14).

---

## 1. Payload design

**Primary payload — anti-DKK1 RNAi cassette (Pol III / U6-shRNA).**
DKK1 is the most DHT-upregulated gene in balding-scalp dermal papilla cells; it is the secreted Wnt/β-catenin antagonist (LRP5/6 co-receptor blocker) that drives catagen entry and follicle miniaturisation downstream of the androgen receptor. Knocking DKK1 down in the DPC *restores* Wnt tone at the follicle — the disease-modifying mechanism, orthogonal to AR blockade (so it sidesteps the sexual-side-effect liability of finasteride/dutasteride). This complements the **RIBOZYME axis** (catalytic/siRNA anti-DKK1): VIROCAPSID delivers a *genomically-encoded, continuously-transcribed* shRNA instead of a dosed oligo.

Cassette budget (from the sim, ssAAV window ≈ 4.7 kb):

| element | bp |
|---|---|
| 5′ ITR | 145 |
| U6 (or H1) Pol III promoter | 250 |
| anti-DKK1 shRNA hairpin (pri-miR scaffold optional) | 80 |
| Pol III terminator (TTTTT) | 6 |
| 3′ ITR | 145 |
| **total** | **626 bp = 0.626 kb** |

→ **0.626 kb ≪ 4.7 kb ssAAV limit · headroom = 4.07 kb · fits = TRUE.**
The huge headroom means a **self-complementary AAV (scAAV, ~2.4 kb limit)** is viable — scAAV skips the rate-limiting second-strand synthesis, giving faster/stronger onset in slow-dividing DPC. 0.626 kb < 2.4 kb, so scAAV also fits.

**Alternative payload — DPC-restricted Pol II arm (miR-embedded anti-DKK1 *or* a Wnt-agonist mini-transgene, e.g. a stabilised-β-catenin / Rspo mini-ORF):** 5′ITR + compact promoter (~500) + cargo (~700) + short polyA (~130) + 3′ITR ≈ **1.62 kb**, also well under 4.7 kb. Kept as the Wnt-*restorer-by-addition* option vs the knockdown option.

---

## 2. Capsid / serotype + assembly sim

**Serotype:** baseline **AAV2** for dermal/follicular work (best-characterised, broad HSPG-mediated dermal-fibroblast/DPC uptake in published intradermal studies), with an **engineered-capsid upgrade lane** (AAV-DJ chimera, or a directed-evolution / peptide-display variant selected on DPC) as the tropism-optimisation path. Serotype choice does NOT change the T=1 geometry below — all AAV serotypes are T=1, 60-mer icosahedra; tropism lives in the VP3 surface loops, not the lattice.

**Delivery route:** **intradermal microneedle array** depositing vector at the **dermal-papilla / bulge depth** of the follicle — bypasses the stratum-corneum barrier that defeats topical macromolecules and concentrates dose at the DPC niche while limiting systemic exposure.

**Inherited assembly sim — actual run output** (`zlotnick_ode.run()` @ inherited T=1 defaults, N=12 pentameric-vertex cascade):

| quantity | value |
|---|---|
| T-number | **1** (icosahedral) |
| subunits | **60 VP** (Caspar-Klug 60·T) |
| pentamers / 5-fold vertices | **12 / 12** |
| hexamers | **0** (T=1) |
| **σ(6) = 12 STRUCTURAL-EXACT** | **TRUE** ✅ |
| diameter | **26.0 nm** (reference-anchored cryo-EM AAV outer Ø) |
| assembly yield (substrate) | **0.7587** |
| mass-conservation error | **2.44 × 10⁻¹⁵** (machine-ε; invariant holds) |
| genome capacity (ssAAV) | **4.7 kb** |

Geometry combinatorics are first-principles Caspar-Klug (subunits = 60·T; pentamers = 12 = σ(6); hexamers = 10·(T−1) = 0; diameter ∝ √T from the T=1 reference). The σ(6)=12 / vertices=12 invariant is verified TRUE — this is the inherited STRUCTURAL-EXACT result, and AAV sits exactly on the T=1 case where it is proven. **Assembly validity vs σ(6)=12: VALID.**

Yield 0.7587 is the *substrate-default* (smoke-level) competence signal — the inherited `calibration.hexa` reaches the calibrated 0.8546 ≥ 0.85 target at the backward-Euler stability corner; the substrate value is reported as a *relative assembly-competence* number, **not** a wet-lab packaging titer (honest C3).

---

## 3. Durability angle (DPC turnover vs episomal AAV persistence)

| quantity | value |
|---|---|
| modality | one-time AAV **episomal** gene therapy |
| DPC pool half-life (model param) | 540 d (~18 mo; conservative slow-mesenchymal estimate) |
| expression half-life | ≈ DPC pool half-life (episome stable in non-dividing cells) |
| topical washout → reversal | ~90 d |
| topical redose interval | 1 d |
| **durability factor vs daily topical** | **540×** |
| expression retained @ 1 / 2 / 5 yr (single dose) | 0.63 / 0.40 / 0.10 |

**Thesis.** Dermal papilla cells are a quiescent, slow-turnover mesenchymal population that persists across multiple hair cycles. AAV genomes persist as **stable nuclear episomes** (no integration, no replication) — they are diluted only by *cell division*, so in a near-non-dividing DPC the transgene persists for essentially the cell-pool lifetime. A **single intradermal dose** therefore substitutes for *hundreds* of daily topical applications and is **intrinsically reversal-resistant**: there is no "stopping" event that triggers the minoxidil/finasteride rebound-regression failure mode, because expression is endogenous and continuous. Model retained-expression: ~63 % at 1 yr, ~40 % at 2 yr on a single conservative dose.

---

## 4. Verdict

| field | value |
|---|---|
| **payload** | anti-DKK1 U6-shRNA cassette, **0.626 kb** (primary); DPC Pol II miR / Wnt mini-transgene **1.62 kb** (alt). Both ≪ 4.7 kb. |
| **serotype** | **AAV2** baseline → engineered **AAV-DJ / directed-evolution DPC-tropic** capsid (upgrade lane). |
| **capsid spec** | **T=1 icosahedral · 60 VP subunits · 12 pentamers / 12 five-fold vertices · σ(6)=12 STRUCTURAL-EXACT = TRUE · Ø 26 nm · 4.7 kb ssAAV (scAAV 2.4 kb also fits)**. Assembly validity vs σ(6)=12 = VALID; mass-conservation 2.4×10⁻¹⁵. |
| **route** | intradermal **microneedle** array to bulge/dermal-papilla depth. |
| **durability** | one-time, **reversal-resistant**, ~540× the daily-topical maintenance burden; ~40 % expression retained @ 2 yr (single dose, conservative). |
| **portfolio role** | the **disease-modifying / reversal-resistant arm** of AGA-RX — the round-1 white-space. Small-molecule paths (PATH A SFRP1 · PATH B Dkk1-LRP6 · PATH C metabolic+senescence) are daily/topical and reverse on stop; VIROCAPSID is the *one-and-done, Wnt-restoring* modality that attacks the same DHT→DPC-DKK1↑→Wnt↓ anchor **below the AR**, avoiding the sexual-side-effect class liability and the chronic-adherence failure mode. Sister to RIBOZYME (delivers the same anti-DKK1 logic as a genomically-encoded shRNA vs a dosed oligo). |

### Honest C3 / g63 / d6
- **Geometry tier = STRUCTURAL-EXACT** (Caspar-Klug σ(6)=12 invariant, T=1 — the case where the inherited audit proves it). Diameter/capacity are reference-anchored to public AAV cryo-EM / vector-biology literature.
- **Kinetics tier = SMOKE-substrate** — the Zlotnick ODE is a deterministic, mass-conserving substrate (machine-ε invariant), **not** a wet-lab packaging-titer prediction. AAV-specific rate constants are not calibrated.
- **KEY WET-LAB-CONFIRMABLE RISK (out of in-silico scope): AAV-to-DPC tropism.** Whether AAV2 (or an engineered capsid) actually transduces human dermal papilla cells at therapeutic efficiency must be confirmed by a transduction assay in DPC — **no in-silico tropism claim is made here.** This is the gating empirical question for the axis and is flagged, not asserted.
