# AGA-RX — IND Package Draft (in-silico-grounded outline)

🧴 **AGA-RX** — androgenetic alopecia new-Rx · *non-AR Wnt-restorer topical* · lead **WAY-316606** (SFRP1 inhibitor), best analog **A2** (4-aminotetrahydropyran cap)

date: 2026-06-03 · milestone = **HANDOFF** (final) · synthesizes the closed in-silico pipeline (rounds 2–5)
honesty (d6): every section is marked **[in-silico-DONE]** (closed by simulation/QSAR/closed-form physics + g5 verify) vs **[wet-lab-REQUIRED]** (out-of-software-scope downstream confirmation, per d5/d19 — a trailer, NOT a gap). No clinical-readiness is claimed. The in-silico content of the IND-enabling package is rendered to completed form; the wet-lab items are the standard IND-enabling battery a sponsor runs next.

This is an **IND outline / pre-IND scientific dossier** — it scopes what an FDA Form-1571 IND would contain, marks which content the in-silico campaign has produced, and lists the wet-lab data packages that must be generated to file. It is NOT a fileable IND (an IND cannot be filed on in-silico data alone — GLP nonclinical + CMC release data are statutory).

---

## 0. Product summary (Investigator's Brochure backbone)

| field | value | status |
|---|---|---|
| drug substance | WAY-316606 (lead) / **A2** (4-aminoTHP cap, dev candidate) — small-molecule SFRP1 inhibitor | [in-silico-DONE] structure + route |
| MoA | SFRP1 (secreted Frizzled-related protein 1) inhibition → de-repression of Wnt/β-catenin at the dermal papilla → anagen extension | [in-silico-DONE] mechanistic + lit |
| indication | androgenetic alopecia (AGA), male + female pattern hair loss | — |
| route / form | **topical**, scalp, once-daily; 5% w/v O/W nanoemulsion (2.5% tolerability SKU) | [in-silico-DONE] formulation design |
| differentiation | **AR-orthogonal** — no androgen-axis engagement → avoids the finasteride/dutasteride sexual-side-effect (post-finasteride-syndrome) class liability | [in-silico-DONE] AR off-target gate |
| projected efficacy | +13.6% anagen-fraction vs vehicle (typical PK, E_max=1); inside the minoxidil band (+12–15%), above finasteride (+9–11%) | [in-silico-DONE] PK/PD model, **conditional on E_max** |
| portfolio | small-molecule topical (lead arm) + RIBOZYME siRNA + VIROCAPSID AAV (durable/disease-modifying arm) | [in-silico-DONE] design; arms wet-lab-staged |

---

## 1. CMC (Chemistry, Manufacturing & Controls)

### 1.1 Drug substance — synthetic route

**Dev candidate = A2 (4-aminotetrahydropyran cap)** — selected over the WAY-316606 lead on developability: lowest synthetic-accessibility score (SA 2.41), **shortest route (4 steps, no Boc protect/deprotect)**, all-commodity starting materials, and it **caps the basic piperidine** (the lead's main metabolic/off-target liability). cLogP 3.00 keeps it inside the topical window.

| # | route element | status |
|---|---|---|
| S1–S3 | central *o*-CF3 benzene core: bromination → thioether→sulfonyl chloride (Cl₂/AcOH) → Cu/Pd C–S sulfonylative coupling with PhSO₂Na (installs distal phenyl-sulfone) | **[in-silico-DONE]** rules-based retro + rdkit BRICS confirms disconnections; every step **[LIT]**-precedented |
| S4′ | aryl-SO₂Cl + 4-aminotetrahydropyran → sulfonamide (Et₃N/DCM); non-basic amine → no protection | **[in-silico-DONE]** route designed; reaction class textbook |
| — | **route demonstration / scale-up (mg→g), isolated yields, identity (NMR/MS), HPLC purity** | **[wet-lab-REQUIRED]** — actual bench synthesis + characterization |
| — | impurity profile, genotoxic-impurity (ICH M7) assessment, residual-solvent (ICH Q3C), elemental impurities (ICH Q3D) | **[wet-lab-REQUIRED]** |
| — | drug-substance specification + stability (ICH Q1A) | **[wet-lab-REQUIRED]** |

SM cost class = **LOW** (4-aminotetrahydropyran, PhSO₂Na, *o*-CF3-aryl SM all commodity catalog). Backup candidates: **A3** (saccharin-bicycle, QED 0.83, potency-optimization track) and the WAY-316606 parent.

### 1.2 Drug product — topical formulation

| element | spec | status |
|---|---|---|
| vehicle | hydroalcoholic, EtOH : PG : water ≈ 50 : 20 : 30 (minoxidil-class), ±Transcutol 10% | **[in-silico-DONE]** design, lit-anchored |
| penetration enhancer | linoleic acid 5% w/v + 50% EtOH → conservative 10–15× in-vivo flux boost | **[in-silico-DONE]** (inherited TTR-LAC CPE, down-rated; not measured for this molecule) |
| carrier | O/W nanoemulsion, droplet ≤200 nm, PDI ≤0.2 → 2× follicular depth + ≥50% 6 h retention | **[in-silico-DONE]** design (inherited QD-HSPRAY ≤200 nm follicular spec) |
| loading | 5% w/v (2.5% tolerability SKU) — set by weak Kd ≈ 80 µM requiring hundreds-of-µM bulb conc, minoxidil-5%-anchored | **[in-silico-DONE]** derived from PK margin |
| trigger-release | NANOBOT-axis pH/enzyme-gated release at the DPC (esterase-cleavable prodrug or pH-sensitive lipid) | **[in-silico-DONE]** design concept; line-extension |
| — | **actual emulsification (droplet z-avg/PDI by DLS), drug-load assay, content uniformity, preservative-efficacy, container-closure, product stability** | **[wet-lab-REQUIRED]** |

---

## 2. Pharmacology (primary + secondary)

### 2.1 Primary pharmacology — SFRP1 MoA

- **Target validation [in-silico-DONE + lit]:** SFRP1 = secreted Wnt antagonist, up-regulated in balding-scalp dermal papilla; ex-vivo hair-growth-active on inhibition (literature). G1 PASS (🟡→🟢 lit + mechanistic).
- **Binding [in-silico-DONE]:** AutoDock-Vina ΔG WAY→SFRP1-CRD = **−7.77 kcal/mol**; literature Kd ≈ 0.08 mM (80 µM), measured EC50 0.65 µM (ex-vivo active). G2 PASS (🟢 docking + measured EC50).
- **Mechanistic chain [in-silico-DONE]:** SFRP1 inhibition → Wnt/β-catenin de-repression → matrix-keratinocyte proliferation drive restored → anagen extension. Disease anchor = DHT → DPC SFRP1↑/DKK1↑ → Wnt↓.
- **[wet-lab-REQUIRED]:** SPR/ITC **measured Kd** for WAY–SFRP1 (confirms the lit 80 µM); cellular Wnt-reporter (TOPFlash) de-repression assay.

### 2.2 Secondary pharmacology — anagen PD model

- **PK/PD model [in-silico-DONE, g5-verified]:** follicular PK → SFRP1 occupancy θ = C/(C+Kd) → fractional reversal of the AGA p4 (matrix-keratinocyte apoptosis) elevation → anagen-fraction shift in the Al-Nuaimi/Dobreva human hair-cycle relaxation-oscillator ODE (arXiv 2502.15035).
- **Result:** +13.6% anagen-fraction vs vehicle at saturating occupancy (θ=0.91 typical) and full efficacy (E_max=1); +6.4% at E_max=0.5; biological ceiling +14.4% (self-limiting — drug at most restores AGA to the normal cycle). Sign-robust positive across the full occupancy×E_max bracket bar the single worst PK corner.
- **g5 verification:** 5/5 quantitative claims 🟢 SUPPORTED-NUMERICAL via `hexa verify --verifier-cmd` (V8 delegated deterministic verifier — t_lag identity, EMLA onset anchor, occupancy identity, depth-attenuation identity, PD monotonicity).
- **Honest [d6]:** **E_max is unmeasured** → efficacy magnitude is a bracket, not a point. Sign + competitiveness-at-saturation are verified; the point estimate requires the ex-vivo anagen assay.
- **[wet-lab-REQUIRED]:** ex-vivo human-hair-follicle-organ-culture (HHFOC) anagen-extension assay to **measure E_max** (converts the G6 bracket → point).

---

## 3. Nonclinical safety / toxicology

### 3.1 In-silico safety (DONE)

| axis | in-silico result | status |
|---|---|---|
| **AR off-target** (the core differentiation safety claim) | Vina WAY→AR-LBD **−5.38** vs DHT **−9.89** (Δ +4.5 kcal, at finasteride's non-binder −5.04 level); orthogonal Tox21 QSAR NR-AR 0.025 / NR-AR-LBD 0.008 (≪0.5). Redock validation gate PASS (TES 1.23 Å). | **[in-silico-DONE]** G3 PASS, 🟢 two orthogonal methods |
| **ADMET / drug-likeness** | ADMET-AI v2.0.1: QED 0.73, HIA 0.999, 0 BRENK/PAINS, Ro5+Veber PASS | **[in-silico-DONE]** G4 PASS (topical) |
| **systemic tox flags** | DILI 0.83 · CYP3A4 0.69 · hERG 0.56 — all **systemic-exposure-driven** → mitigated by the topical-follicular route that keeps plasma C low (A2's THP cap further removes the basic-piperidine liability) | **[in-silico-DONE]** flagged honestly; topical-mitigable, NOT cleared |
| **mutagenicity** | AMES 0.04 (clean), carcinogen 0.30 (borderline-low) | **[in-silico-DONE]** QSAR |

### 3.2 Wet-lab safety battery (the IND-enabling trailer — out-of-software-scope)

These are statutory IND-enabling data packages that **cannot** be produced in-silico and are correctly trailered as downstream confirmation (d5/d19), not as in-silico gaps:

| residual | what it confirms | converts which gate |
|---|---|---|
| **Franz-cell + follicular-closing permeation** | measures λ_foll/D_foll for WAY/A2 in real scalp skin | G5 PK bracket → point |
| **ex-vivo hair-organ-culture E_max assay** | SFRP1-inhibition → anagen-extension efficacy | G6 E_max bracket → point |
| **SPR/ITC measured Kd** | confirms lit 80 µM SFRP1 affinity | G2 docking → measured |
| **DILI / hERG / CYP in-vitro panels** | confirms the QSAR tox flags under topical exposure | G4 QSAR → assay |
| **GLP repeat-dose dermal tox + systemic TK** (rat + minipig/dog), local tolerance / skin-irritation / sensitization, genotox battery (Ames/micronucleus), safety pharmacology (hERG patch, CV/CNS/resp) | the core IND-enabling nonclinical safety package | whole-model → IND-fileable |
| **in-vivo (mouse/human) hair-count** | clinical efficacy endpoint | whole-model → clinical |

---

## 4. Portfolio arms (non-small-molecule) — IND-staging note

| arm | modality | in-silico status | wet-lab gate |
|---|---|---|---|
| **RIBOZYME** | siRNA / gapmer ASO knockdown of DKK1 / SRD5A2 / AR / SFRP1 mRNA (OLX104C topical-siRNA precedent) | [in-silico-DONE] 19-mer designs, Reynolds≥6/8, Ui-Tei PASS, local cross-driver seed screen clean (off_cross=0) | **transcriptome-wide BLAST/seedDB off-target screen [REQUIRED before any synthesis]**; in-vitro knockdown; nuclease-stability chemistry |
| **VIROCAPSID** | AAV (AAV2 → engineered DPC-tropic) anti-DKK1 U6-shRNA cassette (0.626 kb ≪ 4.7 kb; scAAV-viable), intradermal microneedle, episomal/durable (~540× daily-topical) | [in-silico-DONE] T=1 σ(6)=12 STRUCTURAL-EXACT capsid geometry; cassette fit | **AAV-to-DPC tropism transduction assay [the gating empirical question]**; packaging titer; GLP biodistribution/shedding; immunogenicity |

Both arms are at **discovery/design** stage — each carries its own IND-enabling path (siRNA and AAV have distinct FDA review divisions and CMC/tox requirements) and is staged behind the small-molecule lead arm.

---

## 5. IND outline status summary

| IND module | in-silico content | overall |
|---|---|---|
| **CMC** (synth route A2 + topical formulation) | route designed (4-step, all-commodity, [LIT]), formulation designed (5% nanoemulsion ≤200 nm) | **DESIGN-DONE** · bench synth + GMP + stability = wet-lab-REQUIRED |
| **Pharmacology** (SFRP1 MoA + anagen PD) | binding ΔG −7.77, mechanistic chain, g5-verified PK/PD +13.6% (E_max-conditional) | **MODEL-DONE** · measured Kd + E_max = wet-lab-REQUIRED |
| **Nonclinical safety** | AR off-target PASS (2 orthogonal), ADMET QED 0.73, systemic tox flags (topical-mitigable) | **IN-SILICO-DONE** · GLP tox battery = wet-lab-REQUIRED |

**RENDERED:** the IND-enabling **scientific/design content** is in-silico-complete; the package is **pre-IND / IND-outline stage**. Filing requires the standard wet-lab IND-enabling battery (route demonstration + GMP, GLP dermal tox, measured Kd/E_max, Franz permeation, in-vivo hair-count) — an out-of-software-scope trailer per d5/d19, not an in-silico gap.

artifacts: this file · `REGULATORY.md` · `IP_PORTFOLIO.md` · round2–5 + round3/round4 dirs.
