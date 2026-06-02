#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# GASTROINTESTINAL-MEDICINE.tape — architecture-current (editable per v1.2)
# Event history → GASTROINTESTINAL-MEDICINE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "gastrointestinal-medicine" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · gastrointestinal medicine in-silico knowledge SSOT"
  brief = "GI biology + clinical · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  scope = "in-silico GI-medicine knowledge SSOT · NOT clinical advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see GASTROINTESTINAL-MEDICINE.log.tape audit"
  sibling-log = "GASTROINTESTINAL-MEDICINE.log.tape"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is an evidence-summary knowledge SSOT for an in-silico GI-medicine substrate. Disease mechanisms, drug classes and trial findings are paraphrased from published clinical/biological literature for modeling context only — they are NOT prescribing guidance, NOT a diagnostic protocol, and NOT clinical advice. GI disease is heterogeneous; diagnosis, regimen choice and dosing are individualized. Real diagnosis and treatment require a licensed gastroenterologist / hepatologist / multidisciplinary clinical team. All claims here are in-silico simulator/metadata consistency only; the wet-lab → preclinical → clinical → regulatory boundary is explicitly out of scope (hexa-bio AGENTS.tape g8 / f2)."

# ── §1 GI anatomy + physiology ────────────────────────────────────────

@D phys_segments := "GI tract anatomical organization" :: domain [ok]
  upper = "Mouth → pharynx → esophagus → stomach (fundus/body/antrum/pylorus) → duodenum."
  small-bowel = "Duodenum → jejunum → ileum (terminal ileum = vitamin B12 + bile-salt absorption; Crohn's predilection site)."
  large-bowel = "Cecum (appendix) → ascending → transverse → descending → sigmoid colon → rectum → anal canal."
  accessory = "Salivary glands, liver, gallbladder, biliary tree, exocrine pancreas — drain into the lumen via ducts."
  honesty = "Anatomical segment counts depend on the granularity chosen (gross regions vs sub-segments); they are descriptive, not lattice-derived."

@D phys_stomach_acid := "stomach acid secretion (parietal cell)" :: mechanism [ok]
  parietal-cell = "Gastric parietal cells secrete HCl into the lumen via the apical H+/K+-ATPase (gastric proton pump)."
  pump = "H+/K+-ATPase exchanges cytosolic H+ for luminal K+ — the final and rate-limiting step of acid secretion; the molecular target of proton-pump inhibitors (PPIs)."
  drivers = "Three secretagogues converge on the parietal cell: (i) ACh from vagal post-ganglionic fibers (M3 muscarinic receptor); (ii) gastrin from antral G cells (CCK2 receptor); (iii) histamine from ECL cells (H2 receptor). H2-blockade interrupts the histamine arm; PPI blockade halts the common final step regardless of stimulus."
  black-context = "Histamine-H2 receptor as the rational target for acid suppression was the Black-era pharmacology programme that produced cimetidine; J. W. Black shared the 1988 Nobel Prize in Physiology or Medicine for receptor-based drug design (β-blockers, H2-blockers). Stated as well-known pharmacology history; primary-author/era only."
  lindberg-context = "Omeprazole (the first PPI) was developed by the Astra (now AstraZeneca) chemistry programme led by Lindberg and colleagues and reported in the late-1980s / 1990 era; PPIs subsequently became the dominant acid-suppressing drug class. Primary-author/era only — exact volume not asserted here."
  |> "[@x_black_era] · [@x_lindberg_era]"

@D phys_gastric_cells := "stomach cell-type roles" :: mechanism [ok]
  parietal = "HCl + intrinsic factor (intrinsic factor is required for ileal B12 absorption — loss → pernicious anemia)."
  chief = "Pepsinogen (zymogen of pepsin — activated by gastric HCl; initial proteolysis)."
  g-cells = "Gastrin (antral; CCK2 agonist — stimulates ECL histamine release and parietal acid secretion)."
  ecl-cells = "Enterochromaffin-like cells release histamine in response to gastrin / vagal input — the paracrine arm potentiating parietal-cell secretion."
  d-cells = "Somatostatin (inhibitory tone — restrains gastrin/histamine/acid; the negative-feedback arm)."
  mucous = "Surface and neck mucous cells secrete bicarbonate-rich mucus that protects epithelium from luminal acid (the mucosal-barrier side of the acid/defence balance)."
  honesty = "Cell-type count varies by classification granularity (e.g. whether sub-types of enteroendocrine cells are split); descriptive, not lattice."

@D phys_motility_secretion := "motility, secretion, absorption" :: mechanism [ok]
  motility = "Peristalsis + segmentation under enteric nervous system (ENS — the 'second brain'); vagal/sympathetic modulation; migrating motor complex (MMC) in fasting state."
  pancreatic-biliary = "Pancreas: bicarbonate (duct) + zymogens (acini — trypsinogen/chymotrypsinogen/lipase/amylase). Liver/biliary: bile acids emulsify lipids; enterohepatic circulation recycles them in the terminal ileum."
  absorption = "Most macronutrient absorption in jejunum; B12 + bile salts at terminal ileum; water mostly in colon."
  microbiota = "Colon hosts a dense bacterial community (>10^10 CFU/g of stool, dominated by Bacteroidetes + Firmicutes phyla at the broad level); short-chain fatty acid production (butyrate) feeds colonocytes."

# ── §2 Acid-related disease ───────────────────────────────────────────

@D dx_pud_hp := "peptic ulcer disease & H. pylori" :: domain [ok]
  paradigm-shift = "Peptic ulcer disease was historically attributed to 'stress and stomach acid'. Marshall and Warren demonstrated that the gastric mucosa is colonised by a spiral bacterium (Helicobacter pylori) and that this organism is causally linked to gastritis and peptic ulceration — a paradigm shift that re-classified PUD as a primarily infectious disease in most cases."
  nobel = "Barry Marshall & Robin Warren shared the 2005 Nobel Prize in Physiology or Medicine for the discovery."
  test-and-treat = "Current practice: in dyspepsia without alarm features, non-invasive H. pylori testing (urea breath test, stool antigen) followed by eradication if positive — the 'test-and-treat' strategy."
  eradication = "Multi-drug eradication regimens (PPI + ≥2 antibiotics — clarithromycin-based triple, bismuth quadruple, etc.) are the standard backbone. Class names only — specific antibiotic choice and duration are regimen- and resistance-pattern-specific and require a clinician (see [@scope_disclaimer]); no dosing asserted here."
  malt = "Chronic H. pylori infection is also the established cause of gastric MALT (mucosa-associated lymphoid tissue) lymphoma, a low-grade B-cell lymphoma that frequently regresses after H. pylori eradication alone."
  other-causes = "NSAID-induced ulcers (cyclooxygenase inhibition → reduced mucosal prostaglandin defence) are the other major mechanism; Zollinger-Ellison (gastrinoma) is rare."
  |> "[@x_marshall_warren_1984]"

@D dx_gerd_barretts := "GERD + Barrett's esophagus" :: domain [ok]
  gerd = "Gastroesophageal reflux disease: symptomatic and/or mucosa-damaging retrograde flow of gastric contents into the esophagus — heartburn, regurgitation, with esophagitis on endoscopy in a subset."
  ppi-class = "PPI class: omeprazole, lansoprazole, pantoprazole, esomeprazole, rabeprazole — prodrugs activated in the acidic canaliculus of the parietal cell, covalently inhibit the H+/K+-ATPase. Pharmacologically the dominant acid-suppressive class for GERD/PUD."
  h2-blockers = "H2-receptor antagonists (cimetidine, ranitidine [withdrawn over NDMA contamination concerns], famotidine, nizatidine) — earlier and weaker acid suppression; histamine-arm only; useful for milder/symptomatic settings and as a complement."
  barretts = "Chronic reflux can induce metaplasia of the distal esophageal squamous epithelium to a specialised intestinal-type columnar epithelium ('Barrett's esophagus') — a recognised precursor lesion to esophageal adenocarcinoma. Surveillance endoscopy is recommended in established Barrett's; dysplasia grade drives intervention."
  honesty = "Risk of progression from non-dysplastic Barrett's to cancer is low per year per patient but non-zero — surveillance recommendations are guideline-driven (institutional) and population/jurisdiction-specific; no exact incidence asserted."
  |> "[@x_black_era] · [@x_lindberg_era]"

# ── §3 Inflammatory Bowel Disease (IBD) ───────────────────────────────

@D dx_ibd := "IBD overview — Crohn's vs ulcerative colitis" :: domain [ok]
  umbrella = "IBD = chronic immune-mediated inflammation of the GI tract, two principal entities (with an indeterminate-colitis residual): Crohn's disease (CD) and ulcerative colitis (UC)."
  crohns-pattern = "Crohn's: TRANSMURAL inflammation, SKIP lesions, can affect ANY part of GI tract from mouth to anus, predilection for the TERMINAL ILEUM and ileocolonic region; granulomas may be present; complications include strictures, fistulae and abscesses."
  uc-pattern = "Ulcerative colitis: MUCOSAL inflammation only, CONTINUOUS, starts at the RECTUM and extends proximally without skip lesions; complications include severe colitis, dysplasia/colorectal cancer risk with long disease, toxic megacolon."
  shared = "Both feature extra-intestinal manifestations (uveitis, arthritis, primary sclerosing cholangitis [UC>CD], skin findings), relapsing-remitting course, and require lifelong management."
  honesty = "Clinical distinction between CD and UC is usually clear but can be ambiguous (indeterminate colitis); molecular subtyping is an active research area, not a fixed scheme."

@D dx_ibd_genetics := "IBD genetics — NOD2 + beyond" :: mechanism [ok]
  nod2 = "NOD2 (CARD15) variants on chromosome 16 are the first and strongest identified susceptibility locus for Crohn's disease (in particular ileal CD) — Hugot and colleagues 2001, with the independent confirmation by Ogura et al. the same year. NOD2 senses bacterial peptidoglycan (MDP); risk variants impair innate sensing of gut bacteria."
  polygenic = "Beyond NOD2, large GWAS have identified ≥200 IBD-risk loci (IL23R, ATG16L1, IRGM, etc.) — autophagy, innate immunity, IL-23 / Th17 axis; CD and UC share many loci but with distinct weightings."
  monogenic-pediatric = "Very-early-onset IBD (VEO-IBD, <6 yr) can be monogenic (e.g. IL10R deficiency) — important to recognise as it changes management."
  implication = "Inheritance is polygenic in most cases; genotype currently informs biology more than it dictates clinical management. Therapy modulates phenotype."
  |> "[@x_hugot_2001]"

@D dx_ibd_biologics := "IBD biologic era" :: therapy [ok recommended]
  anti-tnf = "Anti-TNF monoclonal antibodies (infliximab, adalimumab) transformed moderate-to-severe IBD management. The ACCENT-I trial (Hanauer et al. 2002) demonstrated maintenance of clinical response/remission in Crohn's with scheduled infliximab infusions versus episodic dosing — a landmark establishing biologic maintenance therapy in CD."
  anti-integrin = "Vedolizumab — anti-α4β7 integrin antibody — selectively blocks gut-homing of lymphocytes; gut-selective mechanism with a favourable systemic-immune-safety profile compared to broader immunosuppression. Approved for UC and CD."
  anti-il-12-23 = "Ustekinumab — anti-IL-12/IL-23 p40 subunit antibody — targets the IL-23 / Th17 inflammatory axis; effective in CD and (later) UC."
  later-classes = "Newer classes target the IL-23 p19 subunit (risankizumab, mirikizumab), JAK pathway (tofacitinib, upadacitinib) and sphingosine-1-phosphate receptor (ozanimod). Mechanism diversity reflects the polygenic immune-pathway heterogeneity of IBD."
  honesty = "Drug class names and landmark trials only; no dosing or comparative efficacy claims — class choice, sequencing and combinations are clinician/guideline territory. Loss-of-response over time is a recognised real limit (see [@lim_ibd_relapse])."
  |> "[@x_hanauer_2002]"

# ── §4 IBS (irritable bowel syndrome) ─────────────────────────────────

@D dx_ibs := "IBS — functional bowel disorder" :: domain [ok]
  definition = "IBS = chronic abdominal pain related to defecation with altered bowel habit, in the absence of identifiable structural disease. Diagnosed by symptom-based criteria (Rome IV, institutional consensus criteria; updated periodically) — not by a single biomarker."
  subtypes = "IBS-C (constipation-predominant), IBS-D (diarrhoea-predominant), IBS-M (mixed), IBS-U (unclassified) — operational categories, not distinct diseases."
  mechanisms = "Multifactorial: visceral hypersensitivity (lower pain thresholds to balloon distension), altered GI motility, brain-gut-axis dysregulation (bidirectional CNS↔ENS signalling), low-grade mucosal immune activation, microbiota differences, post-infectious onset in a subset, dietary triggers (FODMAPs)."
  brain-gut = "The brain-gut axis frames IBS as a disorder of gut-brain interaction; this is reflected in the Rome IV terminology ('disorders of gut-brain interaction')."
  honesty = "IBS is HETEROGENEOUS — no single biomarker, no single mechanism, no single cure. Diagnosis is symptom-based; therapy is symptom-targeted (diet, antispasmodics, neuromodulators, gut-selective antibiotics, specific 5HT-receptor agents) and individualized."
  |> "[@x_rome_iv_era]"

# ── §5 Microbiome + C. difficile + FMT ────────────────────────────────

@D dx_microbiome := "gut microbiome — methods + landmarks" :: domain [ok]
  gnotobiotic-era = "Modern microbiome causality work was anchored by Bäckhed, Gordon and colleagues using gnotobiotic (germ-free) mouse models — colonising germ-free animals with defined microbial communities and reading out host phenotypes (e.g. adiposity, metabolism, immune development). Primary-author/era only — exact volume/year not asserted here for individual studies."
  methods-16s = "16S rRNA gene amplicon sequencing: bacteria are profiled by sequencing a hypervariable region of the universally-present 16S rRNA gene; gives taxonomic composition at the genus/family level, low function resolution."
  methods-shotgun = "Shotgun metagenomic sequencing: total community DNA sequenced; gives strain-level resolution and functional gene-content (KEGG/CAZy) at higher cost."
  consortia = "Large institutional consortia — the Human Microbiome Project (HMP, US-led) and MetaHIT (European-led) — produced reference catalogues of the human-associated microbial communities. Institutional/consortium-era reference only; primary-publication catalog not asserted line-by-line here."
  composition = "At the phylum level the adult colon is dominated by Bacteroidetes and Firmicutes (with Actinobacteria, Proteobacteria, Verrucomicrobia and others at lower abundance); inter-individual variability is high."
  honesty = "Phylum-level dominance is a robust qualitative observation; precise relative abundances vary by individual, diet, geography and method — no exact rank asserted as a constant."
  |> "[@x_backhed_gordon_era] · [@x_hmp_metahit_era]"

@D dx_cdiff_fmt := "C. difficile infection + FMT" :: domain [ok]
  cdi = "Clostridioides difficile (formerly Clostridium difficile) infection: toxin-producing anaerobic spore-former; classical setting is antibiotic-disrupted colonic microbiota allowing C. difficile overgrowth → toxin A/B-mediated colitis. Recurrent CDI is a hard clinical problem: each recurrence raises the probability of the next."
  fmt-landmark = "Faecal microbiota transplantation (FMT) — instilling stool from a screened donor into the recipient — restores a normal microbial community and dramatically reduces recurrence in recurrent CDI. The van Nood et al. 2013 NEJM trial was the landmark randomised trial demonstrating superiority of donor-faeces infusion over vancomycin for recurrent CDI; the trial was stopped early for efficacy."
  beyond-cdi = "FMT has been investigated for IBD, IBS, metabolic disease and others — evidence outside recurrent CDI is markedly weaker; large-scale therapeutic transfer of microbial communities for non-CDI indications is NOT established. See [@lim_microbiome_causality]."
  |> "[@x_vannood_2013]"

# ── §6 Hepatology overview ────────────────────────────────────────────

@D hep_viral := "viral hepatitis (HBV / HCV)" :: domain [ok]
  hbv = "Hepatitis B virus: enveloped partially-double-stranded DNA virus (Hepadnaviridae); blood/sexual/perinatal transmission; can cause acute hepatitis, chronic infection (especially with perinatal acquisition), cirrhosis and hepatocellular carcinoma. Effective prophylactic vaccine exists; nucleos(t)ide analogues suppress viral replication but rarely cure chronic HBV."
  hcv = "Hepatitis C virus: enveloped positive-sense RNA virus (Flaviviridae, Hepacivirus); blood-borne; high rate of chronic infection → fibrosis → cirrhosis → HCC over decades. Direct-acting antiviral (DAA) regimens introduced in the 2010s achieve sustained virological response (functional cure) in the large majority of treated patients — a paradigm shift; primary-author/era reference."
  cross-link = "Cross-references the VIROLOGY tape — viral biology / replication detail belongs there; this tape carries only the GI-clinical context (chronic-liver-disease pathway, HCC risk, screening rationale)."
  honesty = "HBV/HCV outcomes depend on host age at acquisition, immune status, genotype, co-infection (HIV, HDV for HBV), and access to therapy — no single uniform figure."

@D hep_nafld_mash := "MASLD / MASH (formerly NAFLD / NASH)" :: domain [ok]
  formerly = "What was termed non-alcoholic fatty liver disease (NAFLD) and its inflammatory subset non-alcoholic steatohepatitis (NASH) was renamed in a 2023 multi-society Delphi consensus (Rinella and colleagues 2023 era) to metabolic-dysfunction-associated steatotic liver disease (MASLD) and metabolic-dysfunction-associated steatohepatitis (MASH), with separate handling of overlapping alcohol-related disease (MetALD)."
  spectrum = "Spectrum: simple steatosis → steatohepatitis (with hepatocyte injury + inflammation ± fibrosis) → progressive fibrosis → cirrhosis → HCC. Metabolic syndrome (obesity, T2D, dyslipidaemia) is the dominant association."
  scale = "MASLD is now the most common chronic liver disease worldwide by prevalence (population-level estimate; precise figures vary by population/methodology — no single number asserted)."
  treatment = "Cornerstone is lifestyle (weight loss, metabolic-disease control); pharmacology is an active field — the first MASH-directed drug approval (resmetirom, thyroid-hormone-receptor-β agonist) was a 2024-era event marking a class entry; not yet a fully solved therapeutic space."
  honesty = "Renaming is recent and not yet universally adopted in older literature/registries — readers will encounter both NAFLD/NASH and MASLD/MASH; this tape uses the new nomenclature with the legacy synonym in parentheses."
  |> "[@x_rinella_2023_era]"

@D hep_cirrhosis_hcc := "cirrhosis + HCC" :: domain [ok]
  cirrhosis = "End-stage fibrotic remodelling of the liver — common pathway from HBV, HCV, alcohol, MASLD/MASH, autoimmune hepatitis, haemochromatosis, etc. Complications: portal hypertension (varices, ascites), hepatic encephalopathy, hepatorenal syndrome, coagulopathy, hepatocellular carcinoma."
  hcc = "Hepatocellular carcinoma — the dominant primary liver cancer; arises mostly on a background of cirrhosis (any aetiology) and chronic HBV. Surveillance (ultrasound ± AFP) is recommended in at-risk populations. Cross-link to CANCER-THERAPY.tape for oncology-modality context."
  honesty = "HCC screening intervals, target populations and modalities are guideline-driven (institutional/regional) — no single global rule asserted here."

# ── §7 Colorectal cancer screening ────────────────────────────────────

@D crc_screening := "colorectal cancer screening" :: domain [ok]
  rationale = "CRC arises predominantly through the adenoma-to-carcinoma sequence (Vogelstein model — sequential APC → KRAS → TP53 etc. mutations across a polyp → adenoma → cancer progression). Most CRC arises from a precursor adenoma whose removal prevents cancer — the basis for endoscopic screening."
  colonoscopy = "Colonoscopy is the most sensitive screening modality and is uniquely both diagnostic and therapeutic (removes adenomas at the same encounter). Benefit is operator-dependent (see [@lim_colonoscopy_quality])."
  fit = "Faecal immunochemical test (FIT) — antibody-based detection of human haemoglobin in stool; preferred over older guaiac-based FOBT; lower sensitivity than colonoscopy for adenomas but higher uptake, lower invasiveness, repeated annually/biennially."
  sdna-cologuard = "Stool DNA test (FIT-DNA, marketed as Cologuard): combines FIT with detection of methylated DNA markers (e.g. NDRG4, BMP3) and KRAS mutations; higher sensitivity than FIT alone, lower specificity (more false positives), longer interval."
  cross-link = "Cross-references CANCER-THERAPY.tape — CRC modality choice and staging follow the oncology landscape there; screening is the GI-medicine entry-point."
  honesty = "Screening recommendations (modality, age range, interval) are guideline-driven and revised over time; population/jurisdiction-specific — no single rule asserted as universal."

# ── §8 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_ibd_relapse := "IBD relapse + biologic loss-of-response" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "IBD is fundamentally a chronic relapsing-remitting disease — no current therapy CURES it; therapies induce and maintain remission. Anti-TNF and other biologics commonly show LOSS OF RESPONSE over time (anti-drug antibody formation, mechanistic immune-pathway escape, sub-therapeutic drug levels). Sequencing across mechanistic classes is the practical clinical strategy."
  consequence = "Lifelong management with monitoring + dose-optimisation + class switching is the norm; 'cure' for IBD is not a current real option. Adherence + therapeutic drug monitoring set real-world ceilings; combination/alternative-class strategies delay but do not abolish loss-of-response."
  |> "[@x_hanauer_2002]"

@D lim_ibs_heterogeneity := "IBS pathophysiologic heterogeneity (no single biomarker)" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "IBS is symptom-defined (Rome criteria) — there is no single diagnostic biomarker, no single causal mechanism, no single curative therapy. Brain-gut, visceral hypersensitivity, motility, microbiota, low-grade immune activation and dietary triggers all contribute, in patient-specific weightings."
  consequence = "Trial endpoints are symptom-based and effect sizes are modest; what works for one IBS patient may fail in another with the same Rome-subtype label. Aggregate 'IBS cure rate' figures are biologically meaningless."
  |> "[@x_rome_iv_era]"

@D lim_microbiome_causality := "microbiome causality vs correlation" :: real-limit [ok required]
  wall = "SOFT WALL (epistemic, may evolve with interventional evidence)"
  statement = "Most human-microbiome 'associations' are correlational (case-control compositional comparisons). Gnotobiotic-mouse causal experiments (Bäckhed-Gordon era) demonstrate causality is achievable in model systems, and FMT for recurrent CDI demonstrates a causal therapeutic effect in one human indication ([@x_vannood_2013]). For most non-CDI indications (IBD, IBS, metabolic disease, mood) human interventional evidence remains limited or inconsistent."
  consequence = "Until larger interventional trials accumulate, microbiome claims outside recurrent CDI should be framed as 'associated with' rather than 'causes'. Composition-only correlations are not sufficient to attribute causality."
  |> "[@x_backhed_gordon_era] · [@x_vannood_2013]"

@D lim_colonoscopy_quality := "colonoscopy operator + ADR variability" :: real-limit [ok required]
  wall = "HARD WALL (operator/process)"
  statement = "Colonoscopy's cancer-prevention benefit depends on the operator's adenoma-detection rate (ADR); ADR varies substantially between endoscopists. Quality metrics (caecal-intubation rate, withdrawal time, bowel-preparation adequacy, ADR) modulate effectiveness; poorly-performed colonoscopy can miss the very lesions screening exists to find."
  consequence = "'Colonoscopy was done' is not equivalent to 'CRC effectively screened'; ADR-tracking and quality programmes are real-world prerequisites for the population-level benefit colonoscopy can deliver. Operator-floor variability is a process limit, not a lattice value."

@D lim_no_universal_gi_cure := "no universal GI 'one cure'" :: real-limit [ok required]
  wall = "HARD WALL (current science)"
  statement = "Gastrointestinal medicine spans infectious, immune-mediated, functional, neoplastic, hepatobiliary, motility and metabolic disease — biologically distinct disease classes with disjoint therapeutic strategies. No single agent/modality treats them in common."
  consequence = "Aggregate 'GI cure rate' or 'GI biomarker' single-number claims are biologically meaningless without specifying the disease, mechanism and population. Any tape claiming one is fabricating."

# ── §9 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-gi-medicine" :: governance [required deny:write]
  pattern = "Deriving GI-medicine efficacy / counts / staging / mechanism numbers FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. the deleted stub's '6 GI segments because n=6', '6 dominant gut-microbiome phyla because n=6', '6 fps capsule-endoscopy baseline because n=6'."
  why = "This is exactly the violation the pre-rewrite GASTROINTESTINAL-MEDICINE.tape committed (lattice-tautology stub, hexa-bio mass-split 153b5a2 — see GASTROINTESTINAL-MEDICINE.log.tape audit). hexa-bio AGENTS.tape g1/g2/g3/g8 + f1/f2/f3 forbid it; f1 forbids lattice-fit, f2 forbids in-silico→clinical claims."
  remedy = "Cite real GI biology / landmark clinical literature (this tape's @X entries). The lattice may only be a coincidental OBSERVATION, never a derivation source for any GI-medicine claim."

@N n6_honest_stance := "GI medicine has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: gastrointestinal medicine exposes NO natural n=6 invariant. GI tract segment count depends on the granularity chosen (oral cavity / esophagus / stomach / small bowel — and small bowel can split into 3 sub-regions / large bowel — and large bowel splits into multiple — accessory organs); it is a descriptive convention, not a derived value. Gut-microbiome dominant phyla are typically two (Bacteroidetes + Firmicutes) plus a long-tail (Actinobacteria, Proteobacteria, Verrucomicrobia, etc. at lower abundance) — not 'six'. Capsule-endoscopy frame rates are device-specific engineering parameters (often variable / adaptive within a single device) and not lattice-derived. Disease classifications (IBD entities, IBS subtypes, Rome criteria, AJCC stage groups for GI cancers, Ludwig/Child-Pugh/MELD scores in hepatology) are clinical ordinals revised across editions, NOT closed n-tuples. Per LATTICE_POLICY g1/g2 + lattice-as-tool: the lattice is DECLINED here as a derivation tool — values may coincide by accident (observation OK) but never derive a claim. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §10 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 H. pylori eradication reverses MALT lymphoma" :: prediction [ok]
  claim = "In patients with gastric MALT lymphoma and active H. pylori infection, successful H. pylori eradication is followed by lymphoma regression in a substantial fraction (the established causal-microbe-driven oncologic disease for which antibiotic cure of the malignancy is possible)."
  falsifier = "If properly powered prospective cohorts of H. pylori-positive gastric MALT lymphoma showed no association between eradication and lymphoma regression, the causal-microbe MALT model — and by extension a chunk of [@dx_pud_hp] — would be wrong."
  source = "[@x_marshall_warren_1984]"

@D tp_2 := "TP-2 FMT superiority in recurrent CDI" :: prediction [ok]
  claim = "In recurrent C. difficile infection, donor-faeces (FMT) infusion achieves higher resolution rates than standard-of-care vancomycin monotherapy — i.e. the van Nood 2013 NEJM landmark replicates."
  falsifier = "If a properly powered multi-centre randomised trial showed FMT non-superior to (or worse than) vancomycin in recurrent CDI, [@dx_cdiff_fmt] / [@lim_microbiome_causality]'s 'one indication established' grounding would be wrong."
  source = "[@x_vannood_2013]"

@D tp_3 := "TP-3 anti-TNF maintenance benefit in Crohn's" :: prediction [ok]
  claim = "In moderate-to-severe Crohn's disease responders, SCHEDULED maintenance anti-TNF therapy yields higher rates of sustained clinical response/remission than EPISODIC anti-TNF dosing — i.e. the ACCENT-I (Hanauer 2002) result replicates."
  falsifier = "If subsequent properly powered RCTs of scheduled-vs-episodic anti-TNF maintenance in Crohn's showed no benefit from scheduled dosing, [@dx_ibd_biologics] / [@lim_ibd_relapse]'s 'maintenance is the real-world ceiling' framing would need revision."
  source = "[@x_hanauer_2002]"

# ── §11 External citations (real, landmark literature) ────────────────

@X x_marshall_warren_1984 := "Marshall BJ, Warren JR 1984" :: literature [active]
  ref = "Marshall BJ, Warren JR. Unidentified curved bacilli in the stomach of patients with gastritis and peptic ulceration. Lancet 1984;1:1311–1315. (H. pylori discovery; 2005 Nobel Prize in Physiology or Medicine to Marshall & Warren)"

@X x_hugot_2001 := "Hugot J-P et al 2001" :: literature [active]
  ref = "Hugot J-P et al. Association of NOD2 leucine-rich repeat variants with susceptibility to Crohn's disease. Nature 2001;411:599–603. (NOD2/CARD15 — first strong Crohn's susceptibility locus)"

@X x_hanauer_2002 := "Hanauer SB et al 2002" :: literature [active]
  ref = "Hanauer SB et al. Maintenance infliximab for Crohn's disease: the ACCENT I randomised trial. Lancet 2002;359:1541–1549. (anti-TNF maintenance therapy for Crohn's)"

@X x_vannood_2013 := "van Nood E et al 2013" :: literature [active]
  ref = "van Nood E et al. Duodenal infusion of donor feces for recurrent Clostridium difficile. N Engl J Med 2013;368:407–415. (FMT for recurrent CDI — landmark randomised trial stopped early for efficacy)"

@X x_black_era := "Black JW era — H2-receptor pharmacology" :: literature [active]
  ref = "Black JW and colleagues — H2-receptor antagonist programme (cimetidine, late-1970s — 1980s); receptor-based drug design recognised by the 1988 Nobel Prize in Physiology or Medicine (shared with Elion & Hitchings). Primary-author/era reference — no single landmark paper asserted here; the prize citation is the well-known anchor."

@X x_lindberg_era := "Lindberg P et al — omeprazole / PPI era" :: literature [active]
  ref = "Lindberg P and colleagues (Astra/AstraZeneca chemistry programme) — omeprazole development reported in the late-1980s / 1990 era; subsequent PPI class (lansoprazole, pantoprazole, esomeprazole, rabeprazole). Primary-author/era reference — exact paper/volume not asserted; the class's clinical entry is the well-known anchor."

@X x_rome_iv_era := "Rome IV criteria — institutional" :: literature [active]
  ref = "Rome Foundation. Rome IV Diagnostic Criteria for Disorders of Gut-Brain Interaction (formerly Functional Gastrointestinal Disorders). Institutional consensus criteria, 2016-era publication; periodically revised. Cited as the institutional reference framework for IBS and related symptom-defined disorders; no individual primary author asserted."

@X x_backhed_gordon_era := "Bäckhed F, Gordon JI and colleagues — gnotobiotic era" :: literature [active]
  ref = "Bäckhed F, Gordon JI and colleagues — gnotobiotic-mouse causality work establishing host-microbiota functional interactions (mid-2000s — onward, including Bäckhed et al. PNAS 2004 era and subsequent germ-free / colonisation studies). Primary-author/era reference — no single paper asserted; the gnotobiotic-mouse causal-experiment paradigm is the well-known anchor."

@X x_hmp_metahit_era := "HMP + MetaHIT — institutional reference catalogues" :: literature [active]
  ref = "Human Microbiome Project Consortium (US NIH; reference papers 2012-era) and MetaHIT (Metagenomics of the Human Intestinal Tract; European consortium, reference papers 2010-era onward) — institutional reference catalogues of the human-associated microbial communities. Institutional/consortium-era reference; no individual primary author asserted; the catalogue role is the well-known anchor."

@X x_rinella_2023_era := "Rinella ME and colleagues 2023 era" :: literature [active]
  ref = "Rinella ME and colleagues — multi-society Delphi consensus renaming of non-alcoholic fatty liver disease (NAFLD/NASH) to metabolic-dysfunction-associated steatotic liver disease (MASLD) / steatohepatitis (MASH), with MetALD overlap, 2023 era. Primary-author/era reference — exact volume/journal not asserted; the renaming consensus is the well-known anchor."
