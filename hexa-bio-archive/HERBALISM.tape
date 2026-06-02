#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# HERBALISM.tape — architecture-current (editable per v1.2)
# Event history → HERBALISM.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §0 Identity ──────────────────────────────────────────────────────

@I id001 := "herbalism" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · ethnobotany + phytopharmacology in-silico knowledge SSOT"
  brief = "Ethnobotany + phytopharmacology · n=6 NOT used as a derivation (honest) · evidence-grade explicitly distinguished (proven phytopharmacology vs traditional-only claims)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "HERBALISM.log.tape"
  scope = "in-silico knowledge SSOT · NOT medical/therapeutic advice · NOT a clinical or regulatory claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see HERBALISM.log.tape audit"

@N scope_disclaimer := "evidence-grade honesty — hype-prone domain" :: note [required]
  text = "Herbalism is a hype-prone domain. This tape enforces strict evidence-grade separation: (A) Proven phytopharmacology: plant-derived compounds that completed pharmacological isolation, mechanism elucidation, and RCT-level clinical validation — these became real drugs (quinine, aspirin/salicylates, digitalis, artemisinin, paclitaxel, vincristine/vinblastine, galantamine). (B) Moderate evidence: some herbal preparations have controlled-trial support but effect sizes are modest, evidence grades are lower, or inter-study heterogeneity is high (St John's Wort for mild depression per Cochrane; ginkgo cognitive claims contested). (C) Traditional-use-only: widespread ethnobotanical use without rigorous controlled trials; widespread use DOES NOT equal efficacy; placebo effects must be controlled. Category B and C claims are labeled explicitly as such throughout this tape. No therapeutic recommendations are made; this is an in-silico knowledge SSOT only (hexa-bio AGENTS.tape g8 / f2)."

# ─── §1 What phytopharmacology is ────────────────────────────────────

@D dom_definition := "ethnobotany and phytopharmacology defined" :: domain [ok]
  ethnobotany = "The study of relationships between human cultures and plants, including traditional medicinal use. Descriptive — records what was/is used, not whether it works."
  phytopharmacology = "Scientific discipline studying biologically active compounds from plants: isolation, chemical characterization, mechanism of action, pharmacokinetics, toxicology, and clinical evaluation. Phytopharmacology generates the evidence base that ethnobotany alone cannot."
  pharmacognosy = "Branch of pharmacy/pharmacology concerned with natural products of plant, animal or microbial origin; classically includes isolation, structure elucidation, and bioactivity of secondary metabolites."
  key-distinction = "Traditional use is a historical observation and a hypothesis-generation source. Efficacy requires independent testing under controlled conditions with placebo and blinding. The two categories are not interchangeable."

@D dom_secondary_metabolites := "plant secondary metabolites — chemical classes" :: domain [ok]
  alkaloids = "N-containing compounds; many are pharmacologically potent (quinine, morphine, codeine, atropine, colchicine, vincristine, vinblastine, galantamine, berberine)."
  terpenoids = "Isoprenoid-derived; artemisinin (sesquiterpene lactone), taxol/paclitaxel (diterpene), menthol, camphor, many essential-oil volatiles."
  polyphenols = "Flavonoids, tannins, lignans, stilbenes (resveratrol). Many antioxidant in vitro; evidence for clinically meaningful human outcomes is mostly weak to absent."
  glycosides = "Sugar-linked aglycones; cardiac glycosides (digitoxin, digoxin from Digitalis), salicin (Salix), hypericin (Hypericum). Activity often from the aglycone."
  coumarins-quinones = "Warfarin-related (plant-derived anticoagulant class); anthraquinone laxatives (senna)."
  honest-note = "Presence of a bioactive compound in a plant does NOT establish that consuming the crude plant or extract delivers clinical benefit — dose, bioavailability, formulation, and proof in humans are required."

# ─── §2 Proven phytopharmacology (Category A — real drugs) ────────────

@D phyto_digitalis := "cardiac glycosides from Digitalis purpurea (foxglove)" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — proven drug"
  source-plant = "Digitalis purpurea (common foxglove; also Digitalis lanata)."
  isolation-history = "William Withering published 'An Account of the Foxglove' (1785), documenting systematic clinical observation of dropsy (congestive heart failure) treated with foxglove preparations — a landmark in evidence-based pharmacognosy; isolated active principles came later."
  active-compounds = "Digitoxin and digoxin (cardiac glycosides); digoxin is the pharmaceutical form in modern use."
  mechanism = "Inhibits Na⁺/K⁺-ATPase on cardiomyocytes → intracellular Ca²⁺ ↑ → positive inotropy. Slows AV nodal conduction (rate control in atrial fibrillation)."
  clinical-status = "Digoxin is still used clinically (rate control in AF; HFrEF symptom management); its mortality benefit is contested in modern trials. Narrow therapeutic index — toxic at doses slightly above therapeutic."
  |> "[@x_withering_1785]"

@D phyto_quinine := "quinine from Cinchona bark — antimalarial" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — proven drug"
  source-plant = "Cinchona (various species; C. officinalis, C. calisaya) — Peruvian bark / Jesuit's bark."
  ethnobotanical-origin = "South American indigenous use for fevers; brought to Europe in the 17th century."
  isolation = "Pierre-Joseph Pelletier and Joseph-Bienaimé Caventou isolated quinine in 1820 — one of the first alkaloid isolations in pharmaceutical history."
  mechanism = "Accumulates in the acidic food vacuole of Plasmodium; inhibits haem polymerization → oxidative toxicity to the parasite."
  clinical-status = "Quinine IV is still a second-line treatment for severe malaria (particularly falciparum); superseded for uncomplicated malaria by artemisinin-combination therapies (ACTs). Quinidine (diastereomer) was used as an antiarrhythmic."
  |> "[@x_pelletier_caventou_1820]"

@D phyto_salicylates := "salicylates: from Salix bark to aspirin" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — proven drug"
  source-plant = "Salix (willow) bark; also Filipendula ulmaria (meadowsweet). Hippocrates described willow-bark use for pain and fever (ethnobotanical record, ancient era)."
  pharmacognosy = "Salicin is the glycoside in willow bark; hydrolyzed in vivo to saligenin, then oxidized to salicylic acid (the active species)."
  aspirin-synthesis = "Felix Hoffmann (Bayer) synthesized acetylsalicylic acid in 1897, a stable, better-tolerated derivative. This converted a plant-based folk remedy into a precisely manufactured, dose-controlled pharmaceutical."
  mechanism = "Irreversible inhibition of COX-1 and COX-2 → reduced prostaglandin/thromboxane synthesis → anti-inflammatory, analgesic, antipyretic, antiplatelet."
  clinical-status = "Aspirin is one of the most extensively studied drugs in history: low-dose antiplatelet therapy for cardiovascular prophylaxis; analgesia/antipyresis; now under evaluation for cancer chemoprevention. RCT evidence base is very large."
  |> "[@x_hoffmann_bayer_1897] · [@x_hippocratic_willow]"

@D phyto_artemisinin := "artemisinin from Artemisia annua — antimalarial revolution" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — proven drug · Nobel Prize"
  source-plant = "Artemisia annua (sweet wormwood / qinghao 青蒿)."
  ethnobotanical-origin = "Documented in Chinese traditional pharmacopeia (Ge Hong, ~4th century CE) for intermittent fevers (traditional-use record, not initially validated by RCT)."
  discovery = "Tu Youyou led the Chinese national 523 research program; isolated artemisinin (qinghaosu 青蒿素) in 1971–1972 from Artemisia annua using an ether extraction approach guided by the traditional-text clue. Tu Youyou was awarded the Nobel Prize in Physiology or Medicine 2015 — shared with William Campbell and Satoshi Omura."
  mechanism = "Sesquiterpene lactone endoperoxide; activated by haem iron → free-radical alkylation of Plasmodium proteins; rapidly parasiticidal against ring-stage parasites."
  clinical-status = "Artemisinin-combination therapies (ACTs: artemether–lumefantrine, artesunate–amodiaquine etc.) are the WHO first-line treatment for uncomplicated Plasmodium falciparum malaria. Artemisinin is a landmark example of rational re-investigation of traditional-medicine leads yielding a genuinely efficacious new drug class."
  |> "[@x_tu_youyou_2015]"

@D phyto_paclitaxel := "paclitaxel (Taxol) from Taxus brevifolia — Pacific yew" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — proven drug (first-line oncology)"
  source-plant = "Taxus brevifolia (Pacific yew); initial isolation; later semi-synthetic from Taxus baccata (European yew) 10-deacetylbaccatin III precursor."
  isolation = "Monroe E. Wall and Mansukh C. Wani isolated paclitaxel in 1971 and published the structure and activity in J Am Chem Soc 1971;93:2325–2327. Activity against P388 murine leukemia was the initial screen hit."
  mechanism = "Binds and stabilizes polymerized tubulin (microtubules); inhibits depolymerization → mitotic arrest at metaphase → apoptosis. Mechanism is distinct from vinca alkaloids (which PREVENT polymerization)."
  clinical-status = "FDA-approved for ovarian cancer, breast cancer, NSCLC, Kaposi's sarcoma and others. One of the most important anticancer drugs developed from a plant source."
  |> "[@x_wani_wall_1971]"

@D phyto_vinca_alkaloids := "vincristine and vinblastine from Catharanthus roseus" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — proven drugs"
  source-plant = "Catharanthus roseus (Madagascar periwinkle; formerly Vinca rosea) — historically used in folk medicine for diabetes (the original ethnobotanical lead, which did NOT produce an antidiabetic drug — an honest example of the ethnobotanical lead ≠ validated effect pattern)."
  isolation = "Robert Noble, Charles Beer (Toronto), Gordon Svoboda (Eli Lilly) isolated vinblastine and vincristine in the late 1950s; activity against mouse leukemia cell lines drove further development."
  mechanism = "Bind β-tubulin at the vinca domain → inhibit microtubule polymerization → mitotic arrest at metaphase → apoptosis. Complementary to paclitaxel's microtubule-stabilization."
  clinical-status = "Vincristine: CHOP regimen (lymphomas), ALL induction. Vinblastine: Hodgkin lymphoma (ABVD), testicular cancer. Vinorelbine (semi-synthetic): NSCLC. Established, indispensable clinical use."

@D phyto_galantamine := "galantamine from Galanthus / Leucojum — Alzheimer's" :: phytopharmacology [ok]
  evidence-grade = "CATEGORY A — approved drug (cholinesterase inhibitor)"
  source-plant = "Originally isolated from Galanthus nivalis (snowdrop) and related Amaryllidaceae (Leucojum aestivum); Bulgarian folklore / ethnobotanical lead in Soviet-era research."
  isolation = "D.S. Proskurnina and A.K. Yakovleva (1952, USSR) — isolated galantamine from Galanthus species."
  mechanism = "Reversible, competitive inhibitor of acetylcholinesterase (AChE) → prolongs acetylcholine availability at cholinergic synapses. Also allosteric potentiator of nicotinic ACh receptors."
  clinical-status = "FDA-approved for mild-to-moderate Alzheimer's disease; symptomatic benefit (delays functional decline) — NOT disease-modifying (does not slow neurodegeneration). Cholinesterase inhibitors slow symptom progression but have modest real-world effect sizes; the underlying Alzheimer pathology is unaffected."
  honest-note = "Galantamine is a successful example of an ethnobotanical lead yielding an approved drug. The approved indication (Alzheimer's symptomatic treatment) is precisely defined and does NOT translate to broader cognitive-enhancement claims in healthy individuals."

# ─── §3 Evidence-grade discipline (B: moderate / C: traditional-only) ──

@D evid_b_stjohnswort := "St John's Wort (Hypericum perforatum) for mild depression — moderate evidence" :: evidence-grade [ok]
  evidence-grade = "CATEGORY B — moderate evidence (Cochrane review; effect size modest; important interaction risk)"
  source-plant = "Hypericum perforatum (common St John's Wort)."
  active-hypotheses = "Hypericin (naphthodianthrone), hyperforin (phloroglucinol), and flavonoids are proposed contributors; precise mechanism disputed. Hyperforin inhibits reuptake of serotonin, dopamine and noradrenaline in vitro."
  clinical-evidence = "Cochrane review (Linde et al, 2008 Cochrane Database Syst Rev) found Hypericum extracts superior to placebo for mild-to-moderate depression, with similar efficacy to standard antidepressants and fewer AEs reported in the trials reviewed. Evidence base is dominated by European (particularly German) trials; methodological quality is variable."
  important-caveat = "ST JOHN'S WORT IS A POTENT CYP3A4 INDUCER. It reduces plasma concentrations of many drugs: oral contraceptives (contraception failure), cyclosporin (transplant rejection), HIV antiretrovirals, warfarin (INR fluctuation), some anticonvulsants, digoxin, irinotecan. This is a clinically significant herb-drug interaction — not a theoretical concern."
  scope-limitation = "Evidence applies to mild-to-moderate depression only. For severe depression, the Cochrane review found inadequate evidence; the standard of care remains conventional antidepressants and/or psychotherapy under clinical supervision."
  honest-summary = "Category B: real controlled-trial evidence for a specific indication (mild-to-moderate depression), but not strong enough to replace clinical evaluation; and the drug-interaction profile means it must be disclosed to clinicians."
  |> "[@x_linde_cochrane_2008] · [@x_cyp3a4_stjohnswort]"

@D evid_b_ginkgo := "Ginkgo biloba for cognitive function — contested evidence" :: evidence-grade [ok]
  evidence-grade = "CATEGORY B/C borderline — contested; Cochrane / large trial evidence is mixed to negative for prevention"
  source-plant = "Ginkgo biloba (maidenhair tree, a living fossil); standardized extract EGb 761 is the commercial form."
  claimed-uses = "Cognitive enhancement, dementia prevention/treatment, peripheral vascular disease, tinnitus."
  evidence-status = "Large RCTs (GEM study, GEMS) found no significant reduction in incident dementia or cognitive decline in the prevention context. Cochrane reviews find inconsistent, generally modest effects on cognition in already-diagnosed dementia. Tinnitus evidence is weak."
  honest-summary = "The large-scale prevention trial evidence is negative. Modest acute cognitive effects in specific trial designs have been reported, but overall the 'ginkgo improves memory' claim is NOT supported by the weight of rigorous evidence. Listed as borderline B/C — some trial evidence exists, outcome is mostly negative or equivocal for the major claimed indications."

@D evid_c_traditional_only := "traditional-only claims without rigorous trial evidence" :: evidence-grade [ok]
  evidence-grade = "CATEGORY C — traditional use without adequate controlled trial support"
  examples = [echinacea_colds, valerian_sleep, milk_thistle_liver, ashwagandha_stress, turmeric_inflammation]
  echinacea-colds = "Echinacea preparations for cold prevention/treatment: Cochrane reviews show inconsistent, small, unreliable effects; heterogeneous preparations make cross-study comparison difficult. Evidence grade: insufficient."
  valerian-sleep = "Valerian (Valeriana officinalis) for insomnia: trials are small, heterogeneous, methodologically variable; no reliable evidence of meaningful benefit over placebo in systematic reviews."
  milk-thistle-liver = "Silymarin (milk thistle, Silybum marianum) for liver protection: preclinical interest; clinical trial evidence for liver disease is limited and results inconsistent."
  ashwagandha = "Withania somnifera (ashwagandha): some small RCTs suggest cortisol/stress reduction; evidence base is immature (small trials, short duration, publication bias risk). Not enough evidence to make a clinical recommendation."
  turmeric-curcumin = "Curcumin (from Curcuma longa / turmeric) has extensive in-vitro anti-inflammatory activity but very poor oral bioavailability in humans; in vivo clinical evidence for meaningful therapeutic benefit is thin despite voluminous cell-line/animal literature. This is a canonical example of in-vitro-to-clinical translation failure."
  general-rule = "For all Category C claims: widespread traditional use, cultural familiarity, and in-vitro data are not substitutes for controlled human trials with blinding, adequate sample size, and pre-registered endpoints. ABSENCE of such trials ≠ EVIDENCE of benefit; it means the question is unanswered."

# ─── §4 Real limits (phytopharmacology-specific) ─────────────────────

@D lim_standardization := "whole-plant variability / active-compound standardization" :: real-limit [ok required]
  wall = "HARD WALL (chemistry/agronomy)"
  statement = "Active-compound concentrations in plant material vary widely — by species, variety, geography, season, growth conditions, storage, and processing. Variation of 10-fold or more in active-compound content across commercial preparations is documented. This means a 'dose' of a crude herbal preparation is not a reproducible pharmacological dose."
  consequence = "Without standardization to a defined active-compound content (and ideally clinical validation of the standardized extract), dose-response and safety conclusions from one preparation may not transfer to another. This is why pharmacological isolation (as with artemisinin, digoxin, galantamine) is so important — it removes this variability."
  implication = "Regulatory-grade herbal medicines (standardized extracts under pharmacopoeial monographs) are not equivalent to crude whole-plant home preparations. The difference matters for both efficacy and safety."

@D lim_herb_drug_interaction := "herb–drug interactions (CYP/PGP-mediated)" :: real-limit [ok required]
  wall = "HARD WALL (pharmacokinetic)"
  statement = "Many plant-derived compounds are potent inducers or inhibitors of cytochrome P450 enzymes and P-glycoprotein drug transporter. St John's Wort (hyperforin) is a strong CYP3A4/PGP inducer — clinically significant interactions with cyclosporin, antiretrovirals, oral contraceptives, warfarin, and numerous other narrow-therapeutic-index drugs are documented. Grapefruit (furanocoumarins) is a CYP3A4 inhibitor."
  consequence = "Herb–drug interactions are a real, mechanism-grounded pharmacokinetic phenomenon — not theoretical. The herbal compound changes plasma concentrations of co-administered drugs, potentially causing therapeutic failure or toxicity. Disclosure to clinicians is essential."
  |> "[@x_cyp3a4_stjohnswort]"

@D lim_contamination := "contamination, adulteration and species-misidentification" :: real-limit [ok required]
  wall = "HARD WALL (quality/safety)"
  statement = "Herbal supplement markets in less-regulated jurisdictions show documented contamination with heavy metals (lead, cadmium, arsenic, mercury), pesticide residues, undisclosed pharmaceutical adulterants (e.g. sildenafil in 'herbal' sexual-enhancement products, anabolic steroids in 'herbal' sports supplements), and species-misidentification (substituting a related but non-equivalent or toxic plant). US FDA/WHO have issued multiple recalls."
  consequence = "The claimed active ingredient may be absent, subtherapeutic, or contaminated with hazardous materials. This is not addressable by phytopharmacological knowledge alone — it is a manufacturing/regulatory failure."
  regulatory-note = "In the US, the Dietary Supplement Health and Education Act (DSHEA) 1994 classifies herbal supplements as dietary supplements — manufacturers are NOT required to demonstrate efficacy or safety before market entry, and FDA must prove harm post-market to remove a product. This regulatory asymmetry vs pharmaceuticals is a documented structural limitation."
  |> "[@x_dshea_1994]"

@D lim_placebo_control := "placebo effect / unblinded traditional-use observation" :: real-limit [ok required]
  wall = "METHODOLOGICAL LIMIT"
  statement = "Many traditional-medicine observations were made without control groups, blinding, or pre-specified endpoints. Placebo response in pain, mood, and subjective symptoms routinely runs 30–50% in clinical trials. Traditional healers' case series are almost entirely uncontrolled."
  consequence = "Perceived benefit from an herbal preparation in a traditional-use context cannot distinguish pharmacological effect from placebo response, regression to the mean, or natural disease resolution. This is the fundamental reason why controlled trials are required — not cultural disrespect, but scientific necessity."

@D lim_bioavailability := "bioavailability gap: in-vitro activity vs human pharmacokinetics" :: real-limit [ok required]
  wall = "PHARMACOKINETIC WALL"
  statement = "Many plant compounds with impressive in-vitro activity are poorly absorbed orally, rapidly metabolized, or unable to reach the target tissue at pharmacologically relevant concentrations in humans. Curcumin is the canonical example: potent in-vitro anti-inflammatory; very low oral bioavailability in humans without formulation interventions."
  consequence = "In-vitro / cell-line / animal data is a hypothesis-generation tool, not evidence of human clinical efficacy. The majority of plant compounds with in-vitro activity fail in clinical translation due to pharmacokinetic barriers. This is a general drug-discovery constraint that applies with particular force to natural products."

@D lim_regulatory_dshea := "US DSHEA 1994 — supplements not regulated as drugs" :: real-limit [ok required]
  wall = "REGULATORY/STRUCTURAL LIMIT"
  statement = "The Dietary Supplement Health and Education Act of 1994 (US) classifies herbal supplements as dietary supplements: pre-market efficacy and safety proof is NOT required; FDA oversight is post-market and reactive (vs pharmaceutical drugs which require pre-market approval). Structure/function claims ('supports healthy immune function') are allowed without clinical-trial substantiation, provided no disease-treatment claim is made."
  consequence = "Supplement shelf placement and labeling do not indicate pharmacological validation. The regulatory standard for a supplement is dramatically lower than for a pharmaceutical drug. Many countries have similar or even weaker regimes. This matters for interpreting herbal-product evidence (or its absence)."
  |> "[@x_dshea_1994]"

# ─── §5 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-herbalism" :: governance [required deny:write]
  pattern = "Deriving herbalism efficacy / compound counts / preparation cycles / herb classifications FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. '6 medicinal herb classes because n=6' or 'efficacy = 95% because σ·sopfr/10' or '12 traditional channels = σ=12'."
  why = "This is exactly the violation the pre-rewrite HERBALISM.tape committed (lattice-tautology stub, mass-split 153b5a2 — see HERBALISM.log.tape audit). hexa-bio AGENTS.tape g1/g2/g8 + f1/f2 forbid it. Herbalism has no natural n=6 invariant (see [@n6_honest_stance])."
  remedy = "Cite real phytopharmacological / pharmacognosy / clinical literature (this tape's @X entries). Any numeric coincidence between herbalism categories and n=6 values is OBSERVATION ONLY, never derivation."

@N n6_honest_stance := "herbalism has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: herbalism and phytopharmacology expose NO natural n=6 invariant. Plant secondary metabolite classes (alkaloids, terpenoids, polyphenols, glycosides, etc.) are a biochemical taxonomy of evolutionary origin — they do not count to 6. WHO lists hundreds of medicinal plant monographs; traditional systems categorize herbs by taste/property/organ systems in culture-specific schemas that do not map to σ/τ/φ/J₂. The number of well-validated plant-derived drugs is historically small and growing incrementally — it is not lattice-constrained. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is DECLINED as a derivation tool for this domain. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ─── §6 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 artemisinin-combination superiority over quinine for uncomplicated falciparum" :: prediction [ok]
  claim = "For uncomplicated Plasmodium falciparum malaria in WHO treatment guidelines, artemisinin-based combination therapies (ACTs) demonstrate superior parasite-clearance rates and lower gametocyte carriage versus oral quinine (reducing transmission potential), and WHO recommends ACTs as first-line over quinine."
  falsifier = "If a well-powered RCT in a non-resistance-prevalent setting shows quinine monotherapy to be non-inferior to ACT in parasite-clearance speed and gametocyte suppression, the clinical-superiority claim for ACTs for uncomplicated malaria is challenged."
  source = "[@x_tu_youyou_2015] (Nobel Prize context); WHO malaria treatment guidelines"

@D tp_2 := "TP-2 St John's Wort CYP3A4 induction — measurable pharmacokinetic interaction" :: prediction [ok]
  claim = "Co-administration of standard-dose Hypericum perforatum extract with a CYP3A4-metabolized drug (e.g. cyclosporin, midazolam) produces a measurable and clinically significant reduction in the CYP3A4 substrate's AUC, consistent with enzyme induction by hyperforin."
  falsifier = "If a properly designed pharmacokinetic interaction study with standardized hyperforin-containing extract finds no statistically or clinically significant reduction in CYP3A4 substrate AUC, the mechanism-based interaction claim ([@lim_herb_drug_interaction]) would be wrong."
  source = "[@x_cyp3a4_stjohnswort]"

@D tp_3 := "TP-3 curcumin oral bioavailability failure in humans" :: prediction [ok]
  claim = "Oral administration of standard curcumin formulations (not engineered nanoparticles or phospholipid complexes) results in very low plasma curcumin concentrations in humans — peak plasma levels are in the nanomolar range after typical supplement doses — falling well below the micromolar concentrations that show activity in cell-line assays."
  falsifier = "If a pharmacokinetic study of standard (unmodified) oral curcumin in humans consistently shows plasma concentrations reaching the micromolar range effective in cell assays, the bioavailability-gap claim ([@lim_bioavailability]) for curcumin is wrong."
  source = "[@lim_bioavailability] — the bioavailability gap is documented in pharmacokinetic literature; specific study: Sharma et al 2004 Clin Cancer Res 10:6847–6854 (primary-author/era cited; exact figures not re-derived here)"

# ─── §7 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity) · @F f2 (no in-silico→clinical claim). This tape complies: real phytopharmacological science, evidence-grade discipline, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ─── §8 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with full confidence,
# the entry names primary author + era and says so explicitly.
# No fabricated journal volumes, page numbers, or DOIs.

@X x_withering_1785 := "Withering W 1785" :: literature [active]
  ref = "Withering W. An Account of the Foxglove, and Some of Its Medical Uses: with Practical Remarks on Dropsy, and Other Diseases. Birmingham: M. Swinney, 1785. (Landmark systematic clinical pharmacognosy of Digitalis purpurea; basis for cardiac glycoside medicine)"

@X x_pelletier_caventou_1820 := "Pelletier & Caventou (quinine isolation, 1820)" :: literature [active]
  ref = "Pierre-Joseph Pelletier and Joseph-Bienaimé Caventou — isolation of quinine and cinchonine from Cinchona bark, 1820 (primary author/era; published in Annales de Chimie et de Physique; one of the first alkaloid isolations establishing the alkaloid-drug paradigm). Basis for [@phyto_quinine]."

@X x_hoffmann_bayer_1897 := "Hoffmann / Bayer aspirin synthesis (~1897)" :: literature [active]
  ref = "Felix Hoffmann (Bayer) — acetylsalicylic acid synthesis, 1897 (primary author/era; institutional attribution to Bayer AG; the precise internal Bayer laboratory record and first publication date are historically debated). Patent: Bayer AG German Imperial Patent 1900. Basis for [@phyto_salicylates]."

@X x_hippocratic_willow := "Hippocratic-era willow ethnobotanical (ancient)" :: literature [active]
  ref = "Hippocrates (ca. 400 BCE) and earlier Egyptian papyri — records of willow-bark / willow-leaf preparations for pain and fever (ethnobotanical provenance; primary-author/era only; no peer-reviewed citation appropriate for ancient-world traditional use). Basis for the ethnobotanical half of [@phyto_salicylates]."

@X x_tu_youyou_2015 := "Tu Youyou 2015 Nobel Prize in Physiology or Medicine" :: literature [active]
  ref = "Tu Youyou. Nobel Prize in Physiology or Medicine 2015 (shared with William Campbell and Satoshi Omura). For the discovery of artemisinin — a novel therapy against malaria. Nobel Lecture published in Nobel Prize organization archive. Primary isolation work: Tu et al (1977, Chinese-language journal publication; ether-extract methodology). Basis for [@phyto_artemisinin]."

@X x_wani_wall_1971 := "Wani MC, Wall ME et al 1971" :: literature [active]
  ref = "Wani MC, Taylor HL, Wall ME, Coggon P, McPhail AT. Plant antitumor agents. VI. The isolation and structure of taxol, a novel antileukemic and antitumor agent from Taxus brevifolia. J Am Chem Soc 1971;93:2325–2327. (paclitaxel isolation and structure; exact citation confirmed)"

@X x_linde_cochrane_2008 := "Linde et al 2008 Cochrane Database Syst Rev" :: literature [active]
  ref = "Linde K, Berner MM, Kriston L. St John's wort for major depression. Cochrane Database Syst Rev 2008;(4):CD000448. (systematic review of Hypericum perforatum vs placebo and antidepressants for depression; primary-author/era/journal confirmed; specific volume: Issue 4, 2008)"

@X x_cyp3a4_stjohnswort := "St John's Wort CYP3A4/PGP induction — pharmacokinetic literature" :: literature [active]
  ref = "Roby CA, Anderson GD, Kantor E, Dryer DA, Burstein AH. St John's Wort: Effect on CYP3A4 Activity. Clin Pharmacol Ther 2000;67:451–457. (primary pharmacokinetic induction study; also: Piscitelli SC et al. Indinavir concentrations and St John's wort. Lancet 2000;355:547–548 — HIV antiviral interaction). Basis for CYP3A4 induction claim in [@evid_b_stjohnswort] and [@lim_herb_drug_interaction]."

@X x_dshea_1994 := "US Dietary Supplement Health and Education Act 1994" :: literature [active]
  ref = "Dietary Supplement Health and Education Act of 1994 (DSHEA). Public Law 103-417, 108 Stat. 4325 (1994). US Federal Register / FDA regulatory framework for dietary supplements. Defines supplement category, labeling requirements, and pre-market evidence requirements (or lack thereof). Institutional/regulatory citation — exact institutional text, not a journal article. Basis for [@lim_contamination] and [@lim_regulatory_dshea]."
