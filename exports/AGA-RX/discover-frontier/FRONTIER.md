# AGA-RX — DISCOVER lane frontier (round-2 self-feed seed)

> 🧴 **AGA-RX** — androgenetic alopecia NEW Rx drug, in-silico R&D · alias "non-AR hair-loss drug discovery"
> Lane = DISCOVER. Output = the verified next-round frontier for DESIGN + ANALYZE milestones, plus PATH C scope.
> Authorized pharma in-silico R&D. Honest framing (@D d5/d6): in-silico PASS ≠ absorbed; wet-lab is downstream confirmation.

## Round-1 inherited state (recap)

Top non-AR targets ranked (PGD2/CRTH2 FALSIFIED, dropped):

| ID | Target | Path | Status (round-1) | Structure on disk |
|----|--------|------|------------------|-------------------|
| T1 | SFRP1 (Wnt antagonist; secreted Frizzled-related) | PATH A | docking now | `exports/AGA-RX/path-a-sfrp1/AF-Q8N474-F1-SFRP1.pdb` (AlphaFold Q8N474) |
| T2 | Dkk1–LRP6 (Wnt co-receptor block) | PATH B | docking now | PDB **3S2K** (DKK1 CRD2 : LRP6 E3E4) — fetch pending |
| T4 | Metabolic HFSC switch (MPC inh / LDH) | → PATH C arm-1 | scope | this doc |
| T5 | DPC senescence / autophagy reversal | → PATH C arm-2 | scope | this doc |
| T6 | CXXC5–Dishevelled PPI | backlog | scope | this doc |
| T3 | SCUBE3 | backlog | thin structural data | — |

Atlas check (`hexa atlas dump --json`): **no AGA / skin-permeation / docking atom exists yet** — all current atoms are unrelated ω-cycle/math nodes. AGA-RX reuse must come from sibling `<DOMAIN>.md` files (NUMB / TTR-LAC / COSME-SCALP), not the atlas. First AGA-RX verify pass should fold the inaugural domain atoms.

---

## 1. PATH C scope — differentiated metabolic(T4) + senescence(T5) COMBINATION

**Differentiation thesis (vs PP405 me-too):** PP405 is a *dual* MPC1/MPC2 blocker that floods the HFSC with pyruvate → LDH → lactate, flipping telogen→anagen (≈31% of advanced-AGA men > 20% density gain at ~8 wk, vs 0% placebo). The me-too trap is to clone another MPC inhibitor. PATH C instead **stacks two orthogonal axes that PP405 leaves on the table**: (a) act *downstream* of MPC at the LDHA isoform itself with polarity tuned for the anagen lactate set-point, and (b) clear the *senescent* DPC compartment that no metabolic agent addresses — so a follicle that is reawakened metabolically is not re-silenced by SASP. The combination is the product; neither arm alone is differentiated.

### Arm-1 (metabolic, T4) — LDHA-axis, NOT MPC

- **Target:** human LDHA (lactate dehydrogenase A, the anagen-driving isoform). PP405 raises lactate *indirectly* via pyruvate accumulation; AGA-RX arm-1 modulates LDHA **directly + isoform-selectively** to bias the lactate set-point without the systemic MPC liability (MPC is ubiquitous; LDHA is the metabolic node the lactate-anagen literature actually fingers).
- **Differentiation thesis — LDHA-over-LDHB isoform selectivity:** the chemical-tool precedent **GSK2837808A** is NADH-competitive, IC50 2.6 nM hLDHA vs 43 nM hLDHB (>10× LDHA-selective). The thesis: an LDHA-selective scaffold tuned as a *partial / set-point* modulator (not a full kill-switch — full LDHA inhibition would block the very lactate the follicle needs) gives anagen induction with a clean isoform margin, differentiating from both PP405 (MPC) and from blunt LDHA oncology inhibitors.
- **Candidate small molecule (seed):** GSK2837808A analog series (NADH-competitive pyrazole/sulfonamide chemotype) as the docking lead; counter-candidate = oxamate (weak, non-selective — negative control).
- **Structure to dock:** LDHA crystal structures **PDB 6Q0D / 6Q13** (LDHA + drug-like inhibitor 23/52 series) as the holo template; cross-dock vs **LDHB** (e.g. PDB 1I0Z) for the isoform counter-screen. NADH cofactor must be present in the grid (inhibitors are NADH-competitive).

### Arm-2 (senescence/autophagy, T5) — DPC senolytic + autophagy restorer

- **Target (senolytic axis):** **BCL-xL / BCL-2** anti-apoptotic survival node that keeps DHT-senescent dermal-papilla cells (DPCs) alive and SASP-secreting. DHT + AR drives a DNA-damage → p16^INK4a^ premature-senescence axis in DPCs; UVA + DHT activate mTOR → autophagy failure → senescence (rapamycin reverses it in the 2025 AGA mouse model).
- **Differentiation thesis — local senolysis + mTOR-autophagy restore, topical-confined:** systemic navitoclax (BCL-xL/2 inhibitor) is thrombocytopenic; the thesis is a **topically-confined, follicle-retained senolytic** (or a BCL-xL-selective degrader) that clears senescent DPCs *only in the scalp* (PK-confined, see §3), paired with a **localized mTOR/autophagy restorer** (rapalog or a follicle-targeted autophagy inducer) — combination clears the senescent burden AND restores the autophagy that DHT/UVA broke. This is the axis PP405 and finasteride both ignore.
- **Candidate small molecules (seed):** senolytic arm — navitoclax (ABT-263) / A-1331852 (BCL-xL-selective) as docking leads; D+Q (dasatinib + quercetin) as the broad senolytic comparator. Autophagy arm — rapamycin / everolimus (mTOR), or a Beclin-1/ULK1 inducer.
- **Structure to dock:** **BCL-xL PDB 3ZLR / 4QVX** (navitoclax / A-1331852 co-crystals) for the senolytic arm; **mTOR–FKBP12–rapamycin PDB 1FAP / 4DRI** for the autophagy arm.

### PATH C combination logic (the product)
Arm-1 reawakens the follicle (metabolic anagen induction, LDHA set-point); arm-2 removes the senescent DPC brake + restores autophagy so the reawakening *persists*. In-silico deliverable for PATH C = a 2-target dock + a combination-index (Bliss/Loewe) projection on the shared anagen-fraction readout, NOT a single-target dock.

---

## 2. DESIGN milestone frontier (dispatch-ready in-silico tasks)

| # | Task | Ligand library / inputs | Free-energy method | Exact inputs needed |
|---|------|--------------------------|--------------------|---------------------|
| D1 | **SFRP1 (T1) blind dock** — finish round-1 | ZINC20 in-stock drug-like subset (~1M, LogP ≤5, MW ≤500) + ChEMBL Wnt-modulator set | AutoDock Vina (HTVS) → top-1% → **MM-GBSA** rescoring | `AF-Q8N474-F1-SFRP1.pdb` (on disk); define CRD pocket; AlphaFold pLDDT mask (drop <70 regions before grid) |
| D2 | **Dkk1–LRP6 (T2) PPI dock** | LRP6-E3E4 interface fragment library + ChEMBL Wnt set | Vina protein–protein interface dock → FEP on top hits | fetch **PDB 3S2K**; carve DKK1-CRD2 : LRP6 interface; hot-spot residues from the complex |
| D3 | **LDHA (T4 arm-1) selective dock** | GSK2837808A analog series + NADH-competitive ChEMBL LDHA set | Vina → **FEP+ relative binding** across LDHA vs LDHB | **PDB 6Q0D/6Q13** holo (keep NADH); **PDB 1I0Z** LDHB for counter |
| D4 | **BCL-xL (T5 arm-2 senolytic) dock** | navitoclax/A-1331852 analog series + senolytic ChEMBL set | Vina → MM-GBSA → FEP on leads | **PDB 3ZLR/4QVX** (BH3 groove); BAK/BAD BH3 peptide as positive control |
| D5 | **mTOR (T5 arm-2 autophagy) dock** | rapalog series + ATP-competitive mTOR-kinase set | Vina (FRB site for rapalog, kinase site for ATP-comp) | **PDB 1FAP/4DRI** (FRB–FKBP12–rapamycin); FKBP12 must be co-modeled for rapalogs |
| D6 | **CXXC5–Dishevelled (T6) PPI** | PTD-DBM peptidomimetic library; KY19382 small-molecule analog series | Vina PPI interface dock → MM-GBSA | CXXC5 DBM domain model (AlphaFold) + DVL PDZ; PTD-DBM as the competitive-peptide positive control |
| D7 | **Selectivity counter-screen battery** | the round-1+2 top hits from D1–D6 | Vina cross-dock matrix | counter-targets: LDHB, MPC (off-target vs PP405 class), kinome anti-targets (hERG see §3), and the **AR off-target** (§3, ANALYZE A4) |

**Escalation ladder (free-energy):** Vina HTVS (whole library) → MM-GBSA rescore (top 1%, ~$0 on pool/CPU) → FEP+ / FEP relative binding (top ~20 leads, GPU pod per @D d7) → only escalate a scaffold that survives the prior tier. State cost per @D d17 at dispatch.

---

## 3. ANALYZE milestone frontier

### 3a. ADMET prediction toolchain (open tools)

- **ADMET-AI** (github.com/swansonk14/admet_ai) — **primary**, the only one with a real local Python batch API (open-source pip package + web server admet.ai.greenstonebio.com). Fastest public server; run the whole D1–D6 hit set locally, no molecule cap. Inputs = SMILES list of all docking leads.
- **pkCSM** (web, ≤100 molecules/batch) — secondary cross-check on the top ~100 leads (regression endpoints: Caco-2, CYP, total clearance, AMES, hepatotox). No public API → script the web form or submit the curated top-100.
- **SwissADME** (web, ≤200 molecules/batch) — tertiary, BOILED-Egg (GI/BBB) + Lipinski/Veber drug-likeness + synthetic accessibility on top-200. No public API.
- **Critical ADMET endpoints for a TOPICAL scalp drug:** skin permeability (log Kp), hERG (cardiac, must be clean), AMES + hepatotox (systemic-spillover safety), and **plasma-protein binding / clearance to confirm low systemic exposure** (the topical-confinement thesis depends on it).

### 3b. PK model — topical follicular penetration (REUSE NUMB/TTR-LAC)

Inherit the verified closed-form skin-permeation primitives directly (these are the load-bearing reuse edges, see §4):
- **Lag time** `t_lag = h²/(6 D)` (TTR-LAC/A1; D ≈ 1e-10 cm²/s, h = SC thickness ~10 µm → t_lag ≈ 27.8 min, onset ≈ 2·t_lag ≈ 55.6 min, clinically validated vs EMLA). For AGA the readout is *follicular* delivery time, not anesthetic onset, but the rate law is identical.
- **Depth profile** `C(z) = C_surf · exp(−z/λ)` (TTR-LAC/A3; λ tunes with vasoconstrictor / penetration enhancer 40→60 µm). For AGA the DPC sits ~2–4 mm down the follicle (bulb), reached via the **trans-follicular shunt route** (not trans-SC) — so re-parameterize λ for the follicular-infundibulum path, NOT the inter-follicular SC. This is the key adaptation: AGA delivery is follicle-targeted, which RAISES effective delivery vs the inter-follicular SC model NUMB uses.
- **D-boost / CPE stack** (TTR-LAC/A2: LA + EtOH MD 42×; in-vivo 5–15×) — reusable to push the metabolic/senolytic payload to the bulb depth.
- **LAST-style systemic safety envelope** (NUMB/G3-G4 + TTR-LAC/A4: Pliaglis k = 0.0533 ng/mL/mg, area×time×concentration → Cmax) — re-skinned as the **systemic-spillover envelope** proving the senolytic stays follicle-confined (navitoclax thrombocytopenia is the named off-target to bound).

### 3c. AR off-target screen — PROVE no finasteride-like endocrine liability (CRITICAL gate)

The entire AGA-RX thesis is **non-AR, non-endocrine**. Must prove every PATH-A/B/C lead does NOT bind the androgen axis:
- **Dock all top leads vs androgen-receptor LBD:** **PDB 2AM9** (testosterone), **2AMA / 1T7T** (DHT), **5JJM** (DHT + LxxLL homodimer). Pass criterion = lead binding affinity to AR-LBD ≫ (weaker than) DHT/finasteride reference, with no occupancy of the DHT pocket.
- **Dock vs 5α-reductase (SRD5A2):** **PDB 7BW1** (human SRD5A2 + finasteride). Pass = no SRD5A2 active-site engagement (this is exactly finasteride's mechanism — AGA-RX must be orthogonal to it).
- **Positive controls in the same grid:** DHT/testosterone (AR), finasteride/dutasteride (SRD5A2) — confirm the grid reproduces their known binding, then show AGA-RX leads do not.
- **Deliverable:** an AR/SRD5A2 off-target matrix (lead × {AR-LBD, SRD5A2} affinity) with a hard FALSIFIER — any lead that docks competitively into AR-LBD or SRD5A2 is dropped from the pool (this is a 🔴-closing test, not a soft flag).

---

## 4. Cross-domain reuse lattice (@D d19)

Atlas has no relevant atom (verified above) → reuse edges come from sibling DOMAIN.md. Concrete inherited primitives:

| Reuse edge | Source (verified primitive) | What AGA-RX inherits |
|------------|------------------------------|----------------------|
| `AGA-RX ⟵ TTR-LAC/A1` | `t_lag = h²/(6D)` SC rate law (🔵/🟢, EMLA-validated) | follicular delivery-time model |
| `AGA-RX ⟵ TTR-LAC/A3` | `C(z) = C_surf · exp(−z/λ)` depth profile + λ tuning (🟢) | DPC-bulb depth-delivery model (re-λ for trans-follicular shunt) |
| `AGA-RX ⟵ TTR-LAC/A2` | CPE D-boost stack (LA+EtOH 42× MD, 5–15× in-vivo, 🟢) | penetration-enhancer formulation to reach bulb depth |
| `AGA-RX ⟵ NUMB/G3-G4 + TTR-LAC/A4` | LAST Cmax envelope `Cmax = k·area·conc·time` (🟢, Pliaglis k=0.0533) | systemic-spillover safety envelope (bound senolytic off-target) |
| `AGA-RX ⟵ NUMB/N7` | Henderson-Hasselbalch + Hadgraft f_free / pH-partition (🟢 hexa-native) | ionization-tuned flux for the payload's pKa |
| `AGA-RX ⟵ NUMB/G6` | adjacency / compatibility matrix + canonical apply-order (🟡) | combination-product co-application logic (arm-1 + arm-2 layering) |
| `AGA-RX ⟵ COSME-SCALP` | scalp/follicle delivery context, TrichoScan 4-axis readout (모근 밀도·두께·anagen%·성장률) + 24-wk clinical design | scalp PK context + the anagen-fraction efficacy readout PATH C's combination index maps onto |

Stamp on each AGA-RX record: `reused[TTR-LAC/A1,A3,A2,A4; NUMB/N7,G3,G4,G6; COSME-SCALP]`. Update repo-root `NEXUS.tape` with these edges. Intra-project only (@D d19) — all sources are in this repo. **Cross-domain provides[]:** AGA-RX provides the trans-follicular-shunt λ re-parameterization back to NUMB/TTR (a new delivery route none of them modeled).

---

## 5. Frontier inventory — round-2 next-list (deduplicated, impact-ranked, dispatch-ready)

1. **[A4 / CRITICAL gate]** AR-LBD + SRD5A2 off-target dock of ALL leads — PDB 2AM9·2AMA·1T7T·5JJM (AR) + 7BW1 (SRD5A2), DHT/finasteride positive controls; hard FALSIFIER drops any AR/SRD5A2 binder. *Gates the entire non-AR thesis — run first.*
2. **[D1]** Finish SFRP1 (T1) Vina dock → MM-GBSA on `AF-Q8N474-F1-SFRP1.pdb` (already on disk); mask pLDDT <70. *Round-1 carryover, lowest setup cost.*
3. **[D2]** Fetch PDB 3S2K, dock Dkk1–LRP6 (T2) PPI interface → FEP on hits. *Round-1 carryover.*
4. **[PATH C arm-1 / D3]** LDHA (T4) selective dock — PDB 6Q0D/6Q13 holo (keep NADH) + GSK2837808A series; LDHB (1I0Z) counter-screen for >10× isoform margin. *Differentiates from PP405 (MPC).*
5. **[PATH C arm-2 / D4]** BCL-xL senolytic dock — PDB 3ZLR/4QVX + navitoclax/A-1331852 series; BAK/BAD BH3 positive control. *DPC senescence clearance.*
6. **[PATH C arm-2 / D5]** mTOR autophagy-restore dock — PDB 1FAP/4DRI (FRB–FKBP12) + rapalog series. *Restores DHT/UVA-broken autophagy.*
7. **[PATH C product]** 2-target combination-index projection (Bliss/Loewe) of arm-1 × arm-2 on the COSME-SCALP anagen-fraction readout — the differentiated deliverable, not a single dock.
8. **[ANALYZE 3a]** ADMET-AI local batch run (pip package) on the full D1–D6 hit set (SMILES); pkCSM top-100 + SwissADME top-200 cross-check; gate on clean hERG + low systemic clearance.
9. **[ANALYZE 3b]** Topical follicular PK model — instantiate `t_lag=h²/(6D)` + `C(z)=C_surf·exp(−z/λ)` with trans-follicular-shunt λ; verify DPC-bulb (~2–4 mm) delivery + systemic-spillover Cmax envelope (bound senolytic). *Pure reuse, hexa-native, free.*
10. **[D6]** CXXC5–Dishevelled (T6) PPI dock — AlphaFold CXXC5-DBM + DVL-PDZ; PTD-DBM / KY19382 positive controls. *Backlog promotion; Wnt-axis breadth.*
11. **[D7]** Selectivity counter-screen matrix — top hits × {LDHB, MPC, hERG, kinome anti-targets}. *Off-target de-risk before FEP escalation.*
12. **[NOVEL probe, @D d18]** SCUBE3 (T3) — AlphaFold model + arxiv/web lit-grounding for a dockable surface; if structural data too thin, log as 🟠 deferred (@D d_defer_no_delete), keep in pool.
13. **[NEXUS]** Register the inaugural AGA-RX atlas atoms on first verify pass + add the §4 reuse edges to NEXUS.tape. *Closes the atlas gap found in round-1.*

**Dispatch note (@D d17):** items 1–6, 8–11 are in-silico Vina/MM-GBSA tier — runnable on pool free / Vast CPU batch (small ligand sets), GPU pod only for FEP escalation (@D d7). State estimated cost in one line, then fire — no user gate.

---

### Sources
- PP405 / MPC1+MPC2 dual inhibitor, lactate-anagen switch, Phase-1 31% vs 0%: en.wikipedia.org/wiki/PP405 · prnewswire AAD-2024 Pelage release
- DHT/UVA→mTOR→autophagy-failure senescence, rapamycin reversal (2025): ui.adsabs.harvard.edu/abs/2025JPPB..26913200W · sciencedirect S2452199X24000689 (ADSC-nanovesicle autophagy) · ncbi PMC3828374 (AR→DNA-damage→p16 senescence) · karger drm 239/4/533
- LDHA-selective GSK2837808A (2.6 nM hLDHA vs 43 nM hLDHB, >10×): selleckchem GSK2837808A · LDHA holo PDB 6Q0D/6Q13 (researchgate fig 344214772)
- AR-LBD PDB 2AM9 (T), 2AMA/1T7T (DHT), 5JJM (DHT dimer); SRD5A2+finasteride PDB 7BW1: rcsb.org · ncbi PMC7591894
- ADMET-AI open Python batch / pkCSM 100 / SwissADME 200 caps: ncbi PMC11226862 · github.com/swansonk14/admet_ai · mdpi 1420-3049/28/2/776
- CXXC5–Dishevelled PPI, PTD-DBM / KY19382: pubmed 28595998 · mdpi 2073-4409/12/4/555
- Reuse primitives: domains/TTR-LAC.md (A1·A2·A3·A4), domains/NUMB.md (G3·G4·G6·N7), domains/COSME/COSME-SCALP.md
