#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# HIV-TREATMENT.tape — architecture-current (editable per v1.2)
# Event history → HIV-TREATMENT.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hiv-treatment" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · HIV biology + ART knowledge index (in-silico SSOT)"
  brief = "Real published HIV virology + antiretroviral therapy literature index · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  scope = "in-silico knowledge SSOT paraphrasing public peer-reviewed HIV literature for modeling context · NOT clinical / therapeutic / prescribing / treatment-protocol advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see HIV-TREATMENT.log.tape audit"
  sibling-log = "HIV-TREATMENT.log.tape"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is a knowledge index of real published HIV literature for an in-silico modeling substrate. Drug class names, mechanism summaries and trial-outcome paraphrases come from the cited peer-reviewed papers and consensus public-health sources; they are NOT prescribing guidance, NOT a treatment regimen, NOT clinical advice. Real HIV care requires a licensed infectious-disease clinician. All claims are scoped to in-silico simulator/metadata consistency only; the wet-lab → clinical → regulatory boundary is explicitly out of scope (hexa-bio AGENTS.tape g8 / f2)."

# ── §1 Virology of HIV ────────────────────────────────────────────────

@D dx_definition := "what HIV is" :: domain [ok]
  pathogen = "Human immunodeficiency virus — an enveloped, positive-sense single-stranded RNA retrovirus of the Lentivirus genus (family Retroviridae) that establishes lifelong infection by integrating a DNA copy of its genome into host-cell chromosomes."
  types = "Two species: HIV-1 (global pandemic, four groups M/N/O/P with group M the dominant pandemic lineage and multiple subtypes/CRFs) and HIV-2 (largely West Africa; lower transmissibility, slower CD4 decline, intrinsically resistant to non-nucleoside reverse-transcriptase inhibitors)."
  disease = "Untreated HIV-1 infection progressively depletes CD4+ T cells over years, culminating in acquired immunodeficiency syndrome (AIDS) defined by opportunistic infections / specific malignancies / CD4 thresholds."
  isolation = "First isolated by Barré-Sinoussi, Montagnier and colleagues at the Institut Pasteur in 1983 from a patient with lymphadenopathy; later confirmed as the causative agent of AIDS."
  |> "[@x_barre_sinoussi_1983]"

@D virion_structure := "virion architecture & genome" :: mechanism [ok]
  envelope = "Host-derived lipid bilayer carrying the viral Env glycoprotein trimer — surface subunit gp120 (receptor binding) non-covalently associated with transmembrane subunit gp41 (fusion machinery); the functional spike is a heterotrimer of gp120/gp41 protomers."
  matrix-capsid = "Matrix protein (MA, p17) underlies the envelope; conical capsid (CA, p24) encloses two copies of the +ssRNA genome plus the viral enzymes."
  enzymes = "Reverse transcriptase (RT, p66/p51 heterodimer; RNA-dependent and DNA-dependent DNA polymerase + RNase H), integrase (IN), and protease (PR) are packaged as part of the Gag-Pol polyprotein and matured by PR cleavage."
  genome = "~9.7 kb +ssRNA; canonical genes gag, pol, env plus regulatory (tat, rev) and accessory (nef, vif, vpr, vpu in HIV-1; vpx in HIV-2) reading frames."
  accessory-roles = "Tat trans-activates LTR-driven transcription; Rev exports unspliced/singly-spliced viral RNA from the nucleus; Nef downregulates CD4 and MHC-I and is a virulence determinant; Vif counteracts host APOBEC3G; Vpu antagonises tetherin; Vpr / Vpx (HIV-2/SIVsmm) counteract SAMHD1."

@D entry_receptors := "entry — CD4 + co-receptor" :: mechanism [ok]
  primary = "gp120 binds CD4 on T helper cells, monocytes/macrophages and dendritic cells; CD4 engagement triggers conformational change in gp120 exposing the co-receptor binding site."
  co-receptor = "A chemokine co-receptor is required for fusion: CCR5 (R5-tropic viruses; dominant in transmission and early infection) or CXCR4 (X4-tropic viruses; often emerge later, associated with faster CD4 decline)."
  ccr5-delta32 = "A 32-bp deletion in CCR5 (CCR5-Δ32, common in some European-ancestry populations) abolishes surface CCR5 expression in homozygotes, conferring strong but not absolute protection from R5-HIV infection — the genetic basis of the Berlin/London patient transplant cases ([@x_hutter_2009] · [@x_gupta_2019])."
  fusion = "After co-receptor engagement gp41 undergoes a spring-loaded refolding (six-helix-bundle formation) that drives membrane fusion."
  honesty = "CD4 + co-receptor is the entry architecture; the integer 2 (two-receptor entry) is a biological fact, not a lattice derivation."

@D rt_integration := "reverse transcription, integration, latency" :: mechanism [ok]
  rt-step = "Within the infected cell RT copies the +ssRNA genome into double-stranded proviral DNA; RT has no proofreading exonuclease and a high in-vivo error rate (well-characterised mutagenesis underlies rapid resistance evolution; see [@lim_resistance])."
  integration = "Integrase catalyses 3' processing and strand transfer, covalently inserting the proviral DNA into host chromatin (preferred for actively transcribed regions)."
  provirus = "Once integrated the provirus is a permanent fixture of that cell's genome — replicating with the host cell and transmitting to daughter cells on division."
  latency = "A small fraction of integrations occur in resting memory CD4+ T cells, where transcription is silenced; these latently infected cells are the basis of the persistent reservoir that ART cannot eliminate ([@x_chun_1995] · [@x_chun_1997] · [@lim_reservoir])."

@D natural_history := "untreated natural history" :: domain [ok]
  acute = "Acute infection (~2–4 wk after exposure): high-level plasma viraemia, CD4 transient dip, often a flu-like / mononucleosis-like illness; massive depletion of gut-mucosal memory CD4+ T cells in the first weeks."
  chronic = "Years-long clinical latency with ongoing immune activation, gradual CD4 decline and viral evolution."
  aids = "AIDS-defining illness (e.g. Pneumocystis jirovecii pneumonia, oesophageal candidiasis, Kaposi sarcoma, cryptococcal meningitis, certain lymphomas) typically with CD4 <200 cells/µL; without ART, median time from infection to AIDS is several years (varies by host genetics, viral strain, age, co-infection)."
  honesty = "Time-courses are paraphrased ranges from the natural-history literature; exact medians are population-dependent and not lattice values."

# ── §2 Antiretroviral drug classes (literature taxonomy) ──────────────

@D drug_classes_overview := "ART drug classes (taxonomy)" :: therapy [ok]
  scope = "Names and mechanism summaries below are from the peer-reviewed ART literature and standard public-health guidelines. Listed for in-silico modeling context only — not prescribing guidance ([@scope_disclaimer]). Specific regimen choice, sequencing, dose, contraindications and drug-drug interactions are the province of an infectious-disease clinician working from current treatment guidelines (DHHS / EACS / WHO / IAS-USA)."
  classes = "NRTIs / NNRTIs / INSTIs / PIs / entry-inhibitors (CCR5 antagonists, fusion inhibitors) / capsid inhibitors / attachment inhibitors — open and expanding list, NOT a closed n-tuple."

@D drug_nrti := "nucleoside/nucleotide RT inhibitors (NRTI/NtRTI)" :: therapy [ok]
  moa = "Chain-terminating nucleoside/nucleotide analogues incorporated by RT into the nascent viral DNA, halting elongation; activated intracellularly by host kinases (NRTI) or already monophosphorylated (NtRTI, e.g. tenofovir)."
  literature-examples = "Zidovudine (AZT, the first ARV approved 1987 — antiviral activity originally demonstrated in vitro by Mitsuya, Broder and colleagues at NCI), lamivudine (3TC), emtricitabine (FTC), abacavir (ABC), tenofovir disoproxil fumarate (TDF), tenofovir alafenamide (TAF)."
  role = "Backbone of essentially all first-line ART regimens (commonly two NRTIs paired with a third agent of another class)."
  |> "[@x_mitsuya_broder_1985]"

@D drug_nnrti := "non-nucleoside RT inhibitors (NNRTI)" :: therapy [ok]
  moa = "Non-competitive allosteric inhibitors binding a hydrophobic pocket near the RT active site, distorting its conformation."
  literature-examples = "Efavirenz (EFV), nevirapine (NVP), rilpivirine (RPV), doravirine (DOR)."
  notes = "Low genetic barrier to resistance for older agents (e.g. single K103N mutation can abolish efavirenz/nevirapine activity); HIV-2 is intrinsically NNRTI-resistant."

@D drug_insti := "integrase strand-transfer inhibitors (INSTI)" :: therapy [ok]
  moa = "Block the strand-transfer step of integrase by chelating the active-site Mg²⁺ ions."
  literature-examples = "Raltegravir (RAL, first-in-class), elvitegravir (EVG), dolutegravir (DTG), bictegravir (BIC), cabotegravir (CAB)."
  role = "INSTI-anchored regimens (e.g. dolutegravir-based, bictegravir/FTC/TAF single-tablet) dominate first-line ART in current major guidelines — high potency, high genetic barrier (especially DTG/BIC), favourable tolerability profile."

@D drug_pi := "protease inhibitors (PI)" :: therapy [ok]
  moa = "Competitive inhibitors of HIV-1 protease, the aspartyl protease that cleaves Gag and Gag-Pol polyproteins during virion maturation; PI-blocked virions remain immature and non-infectious."
  literature-examples = "Saquinavir (first PI, 1995, contributing to the HAART era), ritonavir (used today primarily as a pharmacokinetic booster of other PIs), lopinavir/ritonavir, atazanavir/ritonavir, darunavir/ritonavir or darunavir/cobicistat."
  role = "High genetic barrier (especially boosted darunavir); important in salvage therapy and pregnancy contexts; largely supplanted by INSTI-based first-line in current guidelines."

@D drug_entry := "entry inhibitors (CCR5 antagonist & fusion inhibitor)" :: therapy [ok]
  ccr5 = "Maraviroc — a small-molecule allosteric CCR5 antagonist; effective only against R5-tropic virus; requires tropism testing."
  fusion = "Enfuvirtide (T-20) — a 36-amino-acid peptide that binds HR1 of gp41 and prevents six-helix-bundle formation; injectable, used in heavily treatment-experienced disease."
  role = "Niche use cases; mechanistically illustrate that entry is multi-step (receptor binding → co-receptor → fusion)."

@D drug_capsid := "capsid inhibitor — lenacapavir" :: therapy [ok]
  moa = "Lenacapavir is a long-acting capsid inhibitor that binds the CA hexamer interface, interfering with multiple capsid-dependent steps (uncoating, nuclear import, assembly)."
  role = "First-in-class long-acting agent approved for heavily treatment-experienced multidrug-resistant HIV-1 in combination with an optimised background regimen; subcutaneous dosing with extended dosing intervals; also under investigation for PrEP."
  honesty = "Approval status and specific indications evolve; clinical use is governed by current regulatory labelling and treatment guidelines, not by this index."

@D drug_long_acting := "long-acting injectables — cabotegravir + rilpivirine" :: therapy [ok]
  moa = "Cabotegravir (INSTI) and rilpivirine (NNRTI) co-formulated as long-acting intramuscular injectable suspensions, allowing infrequent dosing intervals for maintenance of virologic suppression in eligible already-suppressed individuals."
  role = "Documented in the published ATLAS / FLAIR / ATLAS-2M programmes as non-inferior to continued daily oral ART for maintenance of suppression in selected populations; addresses pill-fatigue / adherence in some clinical contexts."
  honesty = "Eligibility, prior-resistance screening, and ongoing on-time injection-visit adherence are real-world clinical constraints, not lattice-derived metrics."

# ── §3 Treatment-strategy landmarks (paraphrased from literature) ─────

@D era_haart := "cART/HAART — the 1996 pivot" :: domain [ok]
  what = "The introduction in the mid-1990s of combination antiretroviral therapy ('highly active antiretroviral therapy', HAART; now generally cART), typically two NRTIs plus a PI or NNRTI, transformed HIV from a near-uniformly fatal disease into a chronic manageable infection for individuals with sustained access and adherence."
  outcome = "The Palella et al 1998 NEJM report documented sharp declines in mortality and opportunistic infections among patients with advanced HIV after HAART introduction in a multi-centre US cohort — the landmark population-level evidence of the HAART era's mortality shift."
  honesty = "The mortality reduction is paraphrased qualitatively from the Palella 1998 cohort; exact per-cent figures are reported in the original paper. This is paraphrase of public literature, not a prescribing claim."
  |> "[@x_palella_1998]"

@D start_trial := "INSIGHT START — immediate vs deferred ART" :: domain [ok]
  what = "The INSIGHT START Study Group 2015 NEJM report on the randomised START trial compared immediate initiation of ART versus deferral until CD4 dropped below a threshold."
  outcome = "Reported significantly lower risk of serious AIDS-related and serious non-AIDS-related events in the immediate-initiation arm — public evidence supporting initiation of ART regardless of CD4 count, paraphrased from the trial publication."
  consequence = "Major treatment guidelines (DHHS / WHO / EACS) subsequently aligned around recommending ART for all individuals with HIV as soon as they are diagnosed and ready, paraphrased from public guidelines literature."
  |> "[@x_insight_start_2015]"

@D prep := "pre-exposure prophylaxis (PrEP)" :: domain [ok]
  oral = "The Grant et al 2010 NEJM report (iPrEx trial) documented a reduction in HIV acquisition among men who have sex with men assigned daily oral emtricitabine/tenofovir disoproxil fumarate vs placebo, with efficacy strongly modulated by adherence — the landmark trial establishing oral TDF/FTC PrEP."
  long-acting = "Subsequent trials (HPTN 083 / HPTN 084 — paraphrased programme-level literature) reported long-acting injectable cabotegravir as superior to daily oral TDF/FTC PrEP in their respective study populations; lenacapavir is also under investigation as a long-acting PrEP agent."
  honesty = "Specific efficacy point estimates live in the original trial papers; here only the qualitative finding (PrEP works; adherence is the dominant modifier; long-acting agents address adherence) is paraphrased."
  |> "[@x_grant_2010]"

@D uequalsu := "U=U — undetectable equals untransmittable" :: domain [ok]
  premise = "Sustained virologic suppression on cART (plasma HIV RNA durably below the assay's quantification threshold) is associated, in the published serodifferent-couple literature, with no observed linked sexual transmission of HIV from the suppressed partner to the HIV-negative partner."
  partner = "The Rodger et al PARTNER (2016 JAMA — paraphrased) and PARTNER2 (2019 Lancet — paraphrased) reports followed serodifferent couples (heterosexual and MSM) with the HIV-positive partner suppressed on cART and reported zero phylogenetically-linked within-couple transmissions during the observation periods despite many condomless sex acts."
  meaning = "U=U is the public-health communication summarising this body of evidence; it is a paraphrase of the trial outcome literature, not a personal medical assurance — the necessary conditions (durable suppression confirmed by viral-load monitoring) are clinical questions for an HIV clinician."
  |> "[@x_rodger_partner_2016] · [@x_rodger_partner2_2019]"

@D mtct := "mother-to-child transmission (MTCT) prevention" :: domain [ok]
  landmark = "The Connor et al 1994 NEJM report (ACTG 076 / PACTG 076) documented that a regimen of zidovudine administered to the pregnant person during pregnancy and labour and to the neonate after birth markedly reduced perinatal HIV-1 transmission compared with placebo — the trial that opened the era of pharmacologic MTCT prevention."
  current-era = "Subsequent decades of public guideline-level literature describe combination maternal ART, obstetric measures (mode-of-delivery decisions informed by maternal viral load), avoidance of breastfeeding where safe alternative feeding is feasible (or maternal ART + infant prophylaxis where it is not), and infant post-exposure prophylaxis as a multi-component strategy that reduces vertical transmission to very low rates when the components are reliably delivered."
  honesty = "Specific transmission-rate point estimates appear in the cited primary literature and in WHO / DHHS / EACS guidelines; only the qualitative finding (MTCT can be reduced dramatically with maternal ART + obstetric/neonatal measures) is paraphrased here."
  |> "[@x_connor_1994]"

# ── §4 Cure-direction literature (paraphrased) ────────────────────────

@D cure_reservoir := "the latent reservoir — why ART is not a cure" :: mechanism [ok]
  finding = "Chun, Siliciano and colleagues demonstrated in the mid-1990s that replication-competent HIV-1 persists in a pool of resting memory CD4+ T cells in patients on suppressive cART — a stable, long-lived reservoir from which virus rebounds when therapy is interrupted."
  papers = "Chun et al 1995 Nature Medicine (initial demonstration of latently infected resting CD4+ T cells in vivo) and Chun et al 1997 PNAS (quantification of the long-lived latent reservoir under suppressive therapy)."
  implication = "The reservoir is the fundamental obstacle to a curative ART regimen — it is invisible to current antivirals (which require viral replication) and decays on a half-life of years, projecting clearance times that are clinically infeasible without an additional intervention."
  |> "[@x_chun_1995] · [@x_chun_1997]"

@D cure_berlin := "the Berlin-patient case" :: domain [ok]
  what = "Hütter et al 2009 NEJM reported on a patient with HIV-1 and acute myeloid leukaemia who received an allogeneic stem-cell transplant from a donor homozygous for CCR5-Δ32/Δ32; the patient subsequently maintained undetectable HIV without ART, and is the index case of an apparent HIV cure."
  why-non-generalizable = "The intervention combines (a) a clinical indication for allogeneic stem-cell transplantation (a high-morbidity, high-mortality procedure with its own indication) and (b) the rarity of a histocompatible CCR5-Δ32 homozygous donor; it is not a scalable therapeutic strategy. See [@lim_ccr5_donor]."
  |> "[@x_hutter_2009]"

@D cure_london := "the London-patient case" :: domain [ok]
  what = "Gupta et al 2019 Nature reported a second case of HIV remission after allogeneic stem-cell transplantation from a CCR5-Δ32/Δ32 donor for the underlying haematologic malignancy (Hodgkin lymphoma), with subsequent extended ART-free remission."
  meaning = "Provides corroborating proof-of-principle that CCR5-Δ32/Δ32-allograft can achieve sustained ART-free remission of HIV in select cases — and reinforces, rather than relaxes, the non-generalizability constraint of [@lim_ccr5_donor]."
  |> "[@x_gupta_2019]"

@D cure_bnabs := "broadly neutralizing antibodies (bnAbs)" :: domain [ok]
  discovery-era = "The Burton, Mascola, Walker and related laboratories described, over the 2009–2014 era and beyond, an expanding catalogue of human monoclonal antibodies that neutralise broad swathes of HIV-1 strains by targeting conserved sites on the Env trimer (CD4-binding site, V1/V2 apex, V3 glycan supersite, gp120-gp41 interface, MPER) — primary-author/era citations, exact volumes not asserted ([@x_burton_mascola_walker_era])."
  passive-transfer = "Caskey, Nussenzweig and colleagues conducted clinical trials of bnAb passive transfer in people living with HIV and in viraemia-control / prevention contexts, demonstrating transient viral-load reductions and viraemia delays with monotherapy and informing combination-bnAb development — primary-author/era citation ([@x_caskey_bnab_era])."
  status = "bnAbs as therapeutics / preventives / cure-adjuncts are an active research direction with multiple in-progress trials at knowledge cutoff; not standard of care for treatment. Listed for scientific completeness, not endorsed as therapy."

@D cure_strategies := "research-strategy taxonomy (paraphrased)" :: domain [ok]
  shock-and-kill = "Latency-reversing agents intended to transcriptionally activate the latent provirus so the cell can be cleared by immune mechanisms or apoptosis. Multiple agents tested clinically (HDAC inhibitors, etc.) without yet demonstrating reservoir reduction translating to off-ART remission — paraphrased programme-level literature."
  block-and-lock = "Conceptually opposite strategy aiming to deepen latency irreversibly (e.g. Tat inhibitors). Pre-clinical/early-clinical."
  gene-therapy = "Editing of CCR5 in autologous CD4+ T cells / hematopoietic stem cells to phenocopy the Δ32/Δ32 protection. Early-phase clinical evidence exists; durability and scalability remain research questions."
  immunotherapy = "Therapeutic vaccines, bnAb combinations, CAR-T against HIV — research direction, not standard care."
  honesty = "None of these strategies is, at knowledge cutoff, an approved cure for HIV in the general population. Listed as the literature's research taxonomy, not as therapeutic options."

# ── §5 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_reservoir := "latent-reservoir hard wall" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "The latent reservoir of integrated, transcriptionally silent provirus in long-lived memory CD4+ T cells is invisible to ART and decays on a half-life measured in years; projected clearance times under ART alone are clinically infeasible. No intervention has been shown to scalably eliminate the reservoir in unselected people living with HIV."
  consequence = "ART is suppressive, not curative for the general population; cure remains a research direction (see [@cure_strategies]). The Berlin/London cases ([@cure_berlin] · [@cure_london]) are special-condition exceptions ([@lim_ccr5_donor]), not a scalable cure."
  |> "[@x_chun_1997]"

@D lim_resistance := "drug resistance under adherence drift / blip viraemia" :: real-limit [ok required]
  wall = "SOFT WALL"
  statement = "HIV reverse transcriptase has no proofreading exonuclease and an in-vivo mutation rate that, combined with the very large replicating viral population, generates pre-existing resistance variants for many single drugs. Suboptimal adherence, drug-level dips and intermittent low-level viraemia ('blips') select for resistance over time, especially for low-barrier agents (older NNRTIs, single-NRTI)."
  consequence = "Combination therapy with a high-barrier anchor (e.g. dolutegravir-based or boosted darunavir) raises the resistance barrier substantially but does not abolish it. The published literature on the K103N (NNRTI), M184V (3TC/FTC), K65R (TDF/TAF), Q148/N155/G140 (older INSTI) and major PI mutations is the empirical evidence base."
  honesty = "Resistance is a real, mechanism-grounded, evidence-based limit on durable single-agent control — not pessimism, not a lattice value."

@D lim_adherence_access := "adherence + access" :: real-limit [ok required]
  wall = "BEHAVIORAL / ECONOMIC LIMIT"
  statement = "ART works only as well as it is taken. Real-world outcomes are bounded by sustained access (financing, supply chain, drug availability), engagement-in-care, and daily / on-schedule adherence; this is the dominant determinant of population-level virologic suppression, not the intrinsic potency of the molecules."
  consequence = "Long-acting injectables (CAB/RPV, lenacapavir) address part of the adherence axis but introduce on-time injection-visit dependence; they do not eliminate the access dimension."

@D lim_immune_reconstitution := "immune-reconstitution ceiling in late-presenting / advanced disease" :: real-limit [ok required]
  wall = "BIOLOGICAL LIMIT"
  statement = "Individuals initiating ART at very low CD4 counts can recover plasma viraemia control but may have incomplete CD4 recovery, persistent immune activation, and elevated long-term risk of non-AIDS comorbidities (cardiovascular, metabolic, renal, malignancy). This is a biology-set ceiling on full immune normalisation, paraphrased from the natural-history and cohort literature."
  consequence = "Early diagnosis and initiation ([@start_trial]) materially improve achievable outcomes; it is a temporal/biological limit, not one that more drug can overcome."

@D lim_structural_social := "structural, stigma & social-determinant ceilings on coverage" :: real-limit [ok required]
  wall = "SOCIAL / STRUCTURAL LIMIT"
  statement = "Real-world coverage of testing, prevention, treatment and retention-in-care is bounded by stigma, criminalisation, key-population marginalisation, gender inequities, conflict/displacement, health-system capacity and financing. UNAIDS surveillance reporting tradition documents the gaps between scientific possibility and delivered coverage."
  consequence = "The biology of HIV is, at this point, the smaller part of the problem; the gap between known-effective interventions and people actually reached is the dominant lever on global outcome. A structural ceiling, not a lattice value."

@D lim_ccr5_donor := "CCR5-Δ32 donor-specificity (why Berlin/London do not generalize)" :: real-limit [ok required]
  wall = "STRUCTURAL / EPIDEMIOLOGIC LIMIT"
  statement = "The Berlin/London ART-free-remission cases combined two restrictive conditions: (1) an independent clinical indication for allogeneic stem-cell transplantation (a high-toxicity, high-mortality procedure used for haematologic malignancy, not for HIV per se), and (2) a histocompatible donor who is homozygous for CCR5-Δ32, an allele common only in some European-ancestry populations."
  consequence = "The intersection is too rare and the procedure too dangerous to be a population-level cure strategy. Generalisation requires either a fundamentally safer way to achieve CCR5-null haematopoiesis (gene therapy — a research direction, not standard care) or a different cure modality."
  |> "[@x_hutter_2009] · [@x_gupta_2019]"

# ── §6 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-hiv-biology" :: governance [required deny:write]
  pattern = "Deriving HIV / ART numerical claims FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24, sopfr, n/φ) — e.g. the deleted stub's '95% bnAb coverage because φ=2 doubling', 'resistance ECL n/φ=3 combination', 'rebound 86% because σ×φ', 'PI monomer 99 aa ≈ σ·sopfr·φ=120 within 17% error', 'σ-φ=10분의 1 (one-tenth)', or any 'EXACT 잠정 40/50' lattice-tautology row."
  why = "This is exactly the violation the pre-rewrite HIV-TREATMENT.tape committed (lattice-tautology stub, mass-split 153b5a2 — see HIV-TREATMENT.log.tape audit). hexa-bio AGENTS.tape g1/g2/g3/g8 + f1/f2/f3 forbid it; f1 forbids lattice-fit, f2 forbids in-silico→clinical claims."
  remedy = "Cite real HIV virology / pharmacology / clinical-trial literature (this tape's @X entries). The lattice may only be a coincidental OBSERVATION, never a derivation source for any HIV claim; numbers come from peer-reviewed papers, not from σ/τ/φ arithmetic."

@N n6_honest_stance := "HIV has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: HIV virology exposes NO natural n=6 invariant. The virus has 9 named gene products, two species (HIV-1 / HIV-2), the entry machinery uses two receptors (CD4 + co-receptor), the Env spike is a trimer, gp41 fusion uses a six-helix bundle (a structural fact, NOT a derivation source for treatment claims), and the drug-class list is open and expanding (NRTI / NNRTI / INSTI / PI / entry / capsid / attachment / ...). Any of these numbers may COINCIDENTALLY match a lattice value (six-helix bundle ↔ n=6 is observation only) but none of them derives from σ/τ/φ/J₂ arithmetic. Per LATTICE_POLICY g1/g2 + lattice-as-tool: the lattice is DECLINED here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §7 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 ART-cessation viral rebound from latent reservoir" :: prediction [ok]
  claim = "Cessation of suppressive ART in a fully virologically suppressed individual results, in the large majority of cases, in measurable plasma viral rebound from the latent reservoir within weeks to months — the empirical finding from the analytical-treatment-interruption (ATI) family of studies in the Chun/Siliciano lineage."
  falsifier = "If a properly designed ATI cohort of unselected suppressed individuals demonstrated sustained (years-long) ART-free remission as the typical, not the exceptional, outcome, [@lim_reservoir] would be wrong."
  source = "[@x_chun_1997]"

@D tp_2 := "TP-2 U=U — no linked sexual transmission under sustained suppression" :: prediction [ok]
  claim = "Sustained virologic suppression on cART is associated, in the published serodifferent-couple literature, with no observed phylogenetically-linked sexual transmission of HIV from the suppressed partner to their HIV-negative partner."
  falsifier = "A properly designed serodifferent-couple cohort with confirmed durable suppression (regular viral-load monitoring) showing phylogenetically-linked within-couple transmissions at a rate detectably above zero would falsify the U=U paraphrase."
  source = "[@x_rodger_partner_2016] · [@x_rodger_partner2_2019]"

@D tp_3 := "TP-3 Berlin/London generalisability — real-limits gate" :: prediction [ok]
  claim = "The published Berlin/London ART-free-remission cases generalise only when BOTH (a) an independent clinical indication for allogeneic stem-cell transplantation is present AND (b) a histocompatible CCR5-Δ32/Δ32 donor is available — a real-limits gate ([@lim_ccr5_donor]), not a programmatic cure option."
  falsifier = "Reproduction of sustained ART-free remission of HIV in unselected people living with HIV (without an allograft indication and without CCR5-Δ32 donor matching) by an alternative, scalable, acceptably-safe intervention would change the gate — and would itself be a major announcement in the cure literature."
  source = "[@x_hutter_2009] · [@x_gupta_2019]"

# ── §8 External citations (real, landmark literature) ─────────────────

@X x_barre_sinoussi_1983 := "Barré-Sinoussi F et al 1983" :: literature [active]
  ref = "Barré-Sinoussi F et al. Isolation of a T-lymphotropic retrovirus from a patient at risk for acquired immune deficiency syndrome (AIDS). Science 1983;220:868–871. (original HIV isolation)"

@X x_mitsuya_broder_1985 := "Mitsuya H, Broder S 1985" :: literature [active]
  ref = "Mitsuya H, Broder S and colleagues. In vitro inhibition of HTLV-III/LAV (HIV) replication by 3'-azido-3'-deoxythymidine (AZT, zidovudine), reported in PNAS in 1985 (primary-author/era cited; exact volume/page not asserted)."

@X x_palella_1998 := "Palella FJ et al 1998" :: literature [active]
  ref = "Palella FJ Jr et al. Declining morbidity and mortality among patients with advanced human immunodeficiency virus infection. HIV Outpatient Study Investigators. N Engl J Med 1998;338:853–860. (HAART-era mortality shift)"

@X x_chun_1995 := "Chun T-W et al 1995" :: literature [active]
  ref = "Chun T-W et al. In vivo fate of HIV-1-infected T cells: quantitative analysis of the transition to stable latency. Nature Medicine 1995 (primary-author/era cited; exact volume/page not asserted)."

@X x_chun_1997 := "Chun T-W et al 1997" :: literature [active]
  ref = "Chun T-W et al. Quantification of latent tissue reservoirs and total body viral load in HIV-1 infection. Nature 1997;387:183–188; and Chun T-W et al. Presence of an inducible HIV-1 latent reservoir during highly active antiretroviral therapy. Proc Natl Acad Sci USA 1997;94:13193–13197. (latent-reservoir quantification under suppressive therapy)"

@X x_hutter_2009 := "Hütter G et al 2009" :: literature [active]
  ref = "Hütter G et al. Long-term control of HIV by CCR5 Delta32/Delta32 stem-cell transplantation. N Engl J Med 2009;360:692–698. (the 'Berlin patient' case report)"

@X x_gupta_2019 := "Gupta RK et al 2019" :: literature [active]
  ref = "Gupta RK et al. HIV-1 remission following CCR5Δ32/Δ32 haematopoietic stem-cell transplantation. Nature 2019;568:244–248. (the 'London patient' case report)"

@X x_insight_start_2015 := "INSIGHT START Study Group 2015" :: literature [active]
  ref = "INSIGHT START Study Group. Initiation of antiretroviral therapy in early asymptomatic HIV infection. N Engl J Med 2015;373:795–807. (START trial — immediate-vs-deferred ART)"

@X x_grant_2010 := "Grant RM et al 2010" :: literature [active]
  ref = "Grant RM et al. Preexposure chemoprophylaxis for HIV prevention in men who have sex with men. N Engl J Med 2010;363:2587–2599. (iPrEx — oral TDF/FTC PrEP)"

@X x_rodger_partner_2016 := "Rodger AJ et al 2016 (PARTNER)" :: literature [active]
  ref = "Rodger AJ et al. Sexual activity without condoms and risk of HIV transmission in serodifferent couples when the HIV-positive partner is using suppressive antiretroviral therapy. JAMA 2016 (PARTNER study; primary-author/era cited as confidently identifiable; exact volume/page paraphrased from the original)."

@X x_rodger_partner2_2019 := "Rodger AJ et al 2019 (PARTNER2)" :: literature [active]
  ref = "Rodger AJ et al. Risk of HIV transmission through condomless sex in serodifferent gay couples with the HIV-positive partner taking suppressive antiretroviral therapy (PARTNER): final results of a multicentre, prospective, observational study. Lancet 2019;393:2428–2438. (PARTNER2 — U=U evidence base in MSM serodifferent couples)"

@X x_connor_1994 := "Connor EM et al 1994 (ACTG 076)" :: literature [active]
  ref = "Connor EM et al. Reduction of maternal-infant transmission of human immunodeficiency virus type 1 with zidovudine treatment. Pediatric AIDS Clinical Trials Group Protocol 076 Study Group. N Engl J Med 1994;331:1173–1180. (landmark MTCT-prevention RCT)"

@X x_burton_mascola_walker_era := "bnAb discovery era — Burton / Mascola / Walker labs" :: literature [active]
  ref = "Burton DR, Mascola JR, Walker LM and colleagues (2009–2014+ era). Discovery and characterisation of broadly neutralising human monoclonal antibodies against HIV-1 Env (CD4-binding site, V1/V2 apex, V3 glycan supersite, gp120-gp41 interface, MPER classes). Multiple papers across Science / Nature / Cell / PNAS / J Virol; primary-author/era cited, exact volumes not asserted."

@X x_caskey_bnab_era := "bnAb passive-transfer clinical trials — Caskey / Nussenzweig era" :: literature [active]
  ref = "Caskey M, Nussenzweig MC and colleagues. Clinical trials of broadly neutralising antibody passive transfer in people living with HIV (e.g. 3BNC117, 10-1074, VRC01) demonstrating transient viral-load reductions and viraemia delays, mid-2010s era. Primary-author/era cited; exact volumes not asserted."
