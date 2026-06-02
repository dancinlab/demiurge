#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# VACCINE.tape — architecture-current (editable per v1.2)
# Event history → VACCINE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "vaccine" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · vaccine in-silico knowledge SSOT"
  brief = "Vaccine immunology + platform landscape · evidence-based · real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  scope = "in-silico knowledge SSOT · NOT clinical / regulatory advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see VACCINE.log.tape audit"
  sibling-log = "VACCINE.log.tape"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is an evidence-summary knowledge SSOT for an in-silico vaccinology substrate. Platform / efficacy / schedule / cold-chain figures are paraphrased from published immunology and clinical literature for modeling context only — they are NOT prescribing guidance, NOT regulatory advice, and NOT a substitute for national immunization-advisory recommendations (WHO SAGE / national NITAGs / ACIP). Real immunization decisions require licensed clinicians and public-health authorities. All claims here are in-silico simulator/metadata consistency only; the wet-lab → preclinical → clinical → licensure → post-marketing-surveillance boundary is explicitly out of scope (hexa-bio AGENTS.tape g8 / f2)."

# ── §1 What a vaccine is & how it works ───────────────────────────────

@D dx_definition := "what a vaccine is" :: domain [ok]
  definition = "A vaccine is a biological preparation that exposes the immune system to a pathogen-derived antigen (or to instructions for producing one) in a controlled, non-pathogenic form, so that subsequent encounter with the actual pathogen is met by a primed, memory-bearing immune response."
  goal = "Establish antigen-specific adaptive immunity (antibodies + memory B/T cells) before natural infection, reducing disease severity, transmission, or both."
  not-this-tape = "Therapeutic monoclonal antibodies, passive-immunization sera, and pathogen-direct antimicrobials are NOT vaccines (mechanism distinct: passive vs active immunity). Cancer therapeutic vaccines share platform tooling but are scoped under CANCER-THERAPY.tape."
  |> "[@x_pollard_bijker_2021]"

@D mech_innate_to_adaptive := "innate priming → adaptive response" :: mechanism [ok]
  step1 = "Antigen (and any adjuvant / PAMP signal) is taken up by antigen-presenting cells (APCs — dendritic cells dominantly) at the injection site and draining lymph node."
  step2 = "APCs process antigen and present peptide fragments on MHC class I (to CD8+ T cells, endogenous/cytosolic route) and MHC class II (to CD4+ T cells, exogenous/endosomal route)."
  step3 = "Cognate B cells with B-cell receptors (BCRs) recognising the antigen receive T-follicular-helper (Tfh) help in the germinal center; affinity maturation (somatic hypermutation + selection) and class switching (isotype switching) occur."
  step4 = "Output: long-lived plasma cells (sustained serum antibody) + memory B cells (rapid recall on re-exposure) + memory CD4+/CD8+ T cells."
  |> "[@x_janeway_textbook] · [@x_pollard_bijker_2021]"

@D mech_humoral := "humoral / antibody response" :: mechanism [ok]
  isotypes = "IgM (early/primary, pentameric, complement-fixing) → class switch to IgG (dominant systemic, neutralizing/opsonising), IgA (mucosal/secretory, dimeric), IgE (allergy/parasites), IgD (B-cell receptor co-expression)."
  igg-subclasses = "IgG1/IgG2/IgG3/IgG4 — different complement and Fcγ-receptor engagement; vaccine-induced profiles vary by platform and adjuvant."
  neutralization = "Neutralizing antibodies block pathogen attachment/entry (e.g. binding the receptor-binding domain of a viral spike, or a bacterial toxin's active site). Non-neutralizing antibodies still contribute via opsonization, ADCC, and complement."
  affinity-maturation = "Repeated germinal-center cycles select for higher-affinity BCRs; this is one mechanism by which prime-boost schedules outperform single-dose regimens."
  honesty = "Isotype/subclass counts are immunology-textbook biological facts; they are NOT used here as a lattice derivation."
  |> "[@x_janeway_textbook]"

@D mech_cellular := "cell-mediated response" :: mechanism [ok]
  cd4-helper = "CD4+ T cells (Th1/Th2/Th17/Tfh polarization) provide B-cell help and shape the response; Th1 → cytotoxic / intracellular-pathogen bias, Th2 → humoral / allergic bias, Tfh → germinal-center driver."
  cd8-cytotoxic = "CD8+ T cells kill infected cells displaying viral peptides on MHC-I; particularly relevant for intracellular viral pathogens and for platforms (mRNA, viral-vector) that deliver antigen-encoding nucleic acid into cells."
  tissue-resident-memory = "T_RM populations in mucosal tissues (gut, lung, genital) provide site-of-entry surveillance; mucosal vaccines aim to elicit these but most parenteral vaccines do so weakly."
  |> "[@x_janeway_textbook]"

@D mech_memory := "immunological memory & boosting" :: mechanism [ok]
  memory-b = "Memory B cells persist long after antigen clearance; on re-exposure they rapidly differentiate to antibody-secreting plasmablasts, producing a faster and higher-titer response than the primary."
  memory-t = "Central-memory (T_CM) and effector-memory (T_EM) populations enable recall cytotoxic responses."
  long-lived-plasma = "Long-lived plasma cells in bone marrow can sustain serum antibody for years to decades for some antigens (e.g. yellow-fever, measles) but only months for others (e.g. seasonal coronaviruses) — antigen- and platform-dependent."
  prime-boost = "Most vaccines require ≥2 doses to elicit durable memory; the interval and platform combination (homologous vs heterologous prime-boost) affects breadth and durability."

@D mech_correlates := "correlates of protection" :: mechanism [ok]
  definition = "An immune measurement (often neutralizing-antibody titer; sometimes specific T-cell frequency) that statistically predicts protection from disease or infection."
  examples = "Anti-HBs ≥10 mIU/mL (hepatitis B vaccine surrogate); hemagglutination-inhibition (HAI) titer ≥1:40 historically for influenza; serum neutralizing-antibody thresholds for measles, rubella, polio, yellow fever; defined more recently for COVID-19 mRNA vaccines."
  honesty = "Specific cutoffs (e.g. anti-HBs ≥10 mIU/mL) are widely used regulatory surrogates from the immunology literature; they are biological/clinical thresholds, NOT lattice derivations. Where the exact figure is not certain (e.g. evolving CoP for newer pathogens), only the qualitative concept is asserted."
  |> "[@x_plotkin_correlates_2010]"

# ── §2 Platform classes (real, evidence-grounded) ─────────────────────

@D plat_live_attenuated := "live-attenuated vaccines" :: platform [ok]
  principle = "A pathogen weakened (by passage, deletion, or rational engineering) so it replicates limitedly in the host, eliciting a strong, broad, durable response that mimics natural infection."
  examples = "Measles, mumps, rubella (MMR — Enders/Hilleman lineage); oral polio (OPV, Sabin); yellow fever (17D, Theiler); varicella (Oka); rotavirus; BCG (tuberculosis, Calmette-Guérin); intranasal influenza (LAIV)."
  strengths = "Robust humoral + cellular + mucosal response; often single-dose protection (yellow fever, MMR with booster)."
  limits = "Contraindicated in significant immunocompromise (replication risk); cold-chain dependence; rare reversion-to-virulence (OPV → vaccine-derived poliovirus → reason for OPV-to-IPV transitions); manufacturing in eggs/cell-culture has its own constraints."
  |> "[@x_plotkin_textbook]"

@D plat_inactivated := "inactivated / whole-killed vaccines" :: platform [ok]
  principle = "Whole pathogen rendered non-replicating (formalin, heat, β-propiolactone), preserving antigenic structure for B-cell recognition."
  examples = "Inactivated polio (IPV, Salk); hepatitis A; rabies (post-exposure prophylaxis); inactivated influenza (split/subunit/whole-virion variants); inactivated SARS-CoV-2 vaccines (e.g. CoronaVac, BBIBP-CorV)."
  strengths = "Safe in immunocompromised hosts; thermal stability generally better than live-attenuated."
  limits = "Typically weaker cellular response (no intracellular replication → less MHC-I presentation); often need adjuvant + multiple doses + periodic boosters."
  |> "[@x_plotkin_textbook] · [@x_salk_1955]"

@D plat_subunit_recombinant := "subunit / recombinant protein vaccines" :: platform [ok]
  principle = "Only a specific protein antigen (recombinant or purified) is delivered, often with adjuvant to compensate for reduced intrinsic immunogenicity."
  examples = "Hepatitis B surface antigen (HBsAg, recombinant yeast-expressed — first recombinant vaccine licensed); HPV virus-like particles (VLPs of L1 capsid protein; Gardasil/Cervarix); acellular pertussis (aP, in DTaP/Tdap); recombinant zoster (Shingrix, with AS01 adjuvant); recombinant influenza HA; protein-subunit SARS-CoV-2 vaccines (Novavax NVX-CoV2373, with Matrix-M)."
  strengths = "Safety profile (no live agent); precise antigen definition; manufacturability."
  limits = "Often less immunogenic without adjuvant; cellular response can be modest."
  |> "[@x_plotkin_textbook]"

@D plat_toxoid := "toxoid vaccines" :: platform [ok]
  principle = "An exotoxin chemically inactivated to a non-toxic but immunogenic form (toxoid); antibodies neutralize toxin in subsequent infection."
  examples = "Diphtheria toxoid (D); tetanus toxoid (T) — components of DT, DTaP, Tdap, Td."
  strengths = "Highly effective against toxin-mediated disease; long track record."
  limits = "Protects against toxin, not colonization → diphtheria/tetanus vaccines do not eliminate carriage."
  |> "[@x_plotkin_textbook]"

@D plat_conjugate := "conjugate vaccines" :: platform [ok]
  principle = "A polysaccharide antigen (T-cell-independent, poorly immunogenic in infants) covalently linked to a carrier protein (e.g. CRM197, tetanus toxoid) converts the response to T-cell-dependent, enabling memory and infant efficacy."
  examples = "Haemophilus influenzae type b (Hib — first conjugate vaccine; nearly eliminated invasive Hib disease in children where used); pneumococcal conjugate (PCV7 → PCV13 → PCV15/20/21 — serotype coverage expansion); meningococcal conjugate (MenC, MenACWY)."
  strengths = "Memory induction in infants; transformative public-health impact on bacterial meningitis."
  limits = "Serotype replacement (non-vaccine serotypes can expand in carriage); requires conjugation chemistry expertise."
  |> "[@x_plotkin_textbook]"

@D plat_vlp := "virus-like-particle (VLP) vaccines" :: platform [ok]
  principle = "Self-assembling structural proteins form particles that mimic virion geometry without genome — highly immunogenic due to repetitive, ordered antigen display on the particle surface."
  examples = "Hepatitis B (HBsAg forms VLPs spontaneously when expressed); HPV L1 VLPs (Gardasil-9 covers 9 high-risk + warts genotypes); hepatitis E (Hecolin, China)."
  strengths = "Strong antibody response from densely-arrayed epitopes; no infectious material."
  limits = "Manufacturing complexity (proper self-assembly required); typically requires adjuvant."
  |> "[@x_plotkin_textbook]"

@D plat_viral_vector := "viral-vector vaccines" :: platform [ok]
  principle = "A non-pathogenic (or attenuated) viral genome is engineered to encode the target antigen; the vector delivers the antigen-encoding nucleic acid into host cells where the antigen is expressed endogenously, enabling MHC-I presentation and cellular immunity."
  replication-incompetent = "Adenoviral vectors are the dominant clinical class: Ad26 (Johnson & Johnson / Janssen Ad26.COV2.S), ChAdOx1 (chimpanzee adenovirus — Oxford/AstraZeneca ChAdOx1-nCoV-19 / AZD1222), Ad5 (CanSino), rAd26/rAd5 (Sputnik V heterologous prime-boost)."
  replication-competent = "rVSV-ZEBOV (recombinant vesicular-stomatitis-virus expressing Ebola GP — Ervebo; landmark ring-vaccination trial showed high protective effect against Ebola virus disease)."
  strengths = "Strong CD8+ T-cell response; rapid platform deployment (demonstrated in COVID-19 and Ebola)."
  limits = "Anti-vector immunity (pre-existing or vaccine-induced) can blunt repeat dosing of the same vector; rare thrombosis-with-thrombocytopenia syndrome (TTS) reported post-deployment for some adenoviral COVID-19 vaccines — a real safety signal that shaped subsequent use recommendations."
  |> "[@x_voysey_2021] · [@x_henao_restrepo_2017]"

@D plat_mrna := "mRNA vaccines" :: platform [ok]
  principle = "Synthetic mRNA encoding the target antigen (typically with modified nucleosides, e.g. N1-methylpseudouridine, to reduce innate sensing and increase translation) is delivered in lipid nanoparticles (LNPs); host cells translate the antigen transiently, then degrade the mRNA."
  examples = "BNT162b2 (Pfizer-BioNTech, COVID-19); mRNA-1273 (Moderna, COVID-19). Both showed high efficacy against symptomatic COVID-19 in their phase-3 trials and were the first mRNA vaccines deployed at scale."
  strengths = "Rapid antigen redesign cycle (sequence in → manufactured material in weeks); strong humoral and cellular responses; cell-free manufacturing."
  limits = "Cold-chain (ultra-low-temperature storage requirements at deployment, especially for early formulations); rare myocarditis/pericarditis post-mRNA-COVID vaccine (particularly young males, mostly mild, transient — a real safety signal characterized post-licensure)."
  honesty = "Specific phase-3 efficacy point estimates (e.g. ~95% against symptomatic disease in original trials) are well-documented in primary literature; here they are referenced qualitatively (high efficacy in original trial) rather than re-asserted as exact numbers."
  |> "[@x_polack_2020] · [@x_baden_2020] · [@x_kariko_weissman_2005]"

# ── §3 Adjuvants & delivery ───────────────────────────────────────────

@D adj_overview := "adjuvant rationale & classes" :: domain [ok]
  rationale = "Many non-replicating antigens are weakly immunogenic alone; adjuvants provide the danger signal (PAMP/DAMP) needed to activate APCs and shape the response (magnitude, durability, Th1/Th2 polarization)."
  alum = "Aluminium salts (aluminium hydroxide / aluminium phosphate) — the oldest licensed adjuvant; predominantly Th2-biased; used in many infant vaccines (DTaP, HepB, HPV original formulation)."
  oil-in-water = "MF59 (squalene-based, Novartis/Seqirus, seasonal influenza in elderly); AS03 (squalene + tocopherol + polysorbate, pandemic influenza)."
  combined-pamp = "AS01 (liposomal MPL + QS-21) used in recombinant zoster (Shingrix) and the RTS,S malaria vaccine — strong Th1 / cellular response."
  AS04 = "AS04 (alum + MPL, a detoxified TLR4 agonist) used in HBV (Fendrix) and one HPV formulation."
  cpg = "CpG-1018 (TLR9 agonist) — adjuvants HepB-CpG (Heplisav-B) for adult HepB; included in some COVID-19 protein-subunit candidates."
  matrix-m = "Matrix-M (saponin-based, Novavax) — used in NVX-CoV2373 (COVID-19) and the R21/Matrix-M malaria vaccine."
  honesty = "Adjuvant counts (alum, MF59, AS01/03/04, CpG, Matrix-M, etc.) are an open and expanding list driven by immunology and regulatory acceptance — NOT a lattice tuple."
  |> "[@x_pollard_bijker_2021]"

@D adj_conjugation_chem := "conjugation chemistry" :: mechanism [ok]
  why = "Polysaccharides are T-independent antigens (TI-2) — poor memory, poor infant response. Covalent linkage to a carrier protein converts the response to T-dependent."
  carriers = "CRM197 (a non-toxic diphtheria-toxin mutant, used in PCV13/PCV15/PCV20, MenACWY-CRM); tetanus toxoid (TT, used in Hib-TT, MenACWY-TT); diphtheria toxoid (DT)."
  chemistry = "Reductive amination, carbodiimide coupling, cyanogen-bromide / CDAP activation — established protein-bioconjugation methods; the specific chemistry shapes epitope preservation and lot-to-lot consistency."
  honesty = "These are established bioconjugation chemistries; cited as a domain category, not as a lattice derivation."

@D adj_delivery_lnp := "lipid-nanoparticle (LNP) delivery for mRNA" :: mechanism [ok]
  components = "An ionisable cationic lipid (which becomes positively charged at endosomal pH to enable mRNA release into cytosol), a PEG-lipid (for circulation/stability), a phospholipid (membrane structure), and cholesterol (membrane fluidity) — co-formulated with mRNA cargo."
  function = "Protects mRNA from RNase degradation; delivers it into target cells (predominantly local APCs / muscle / draining lymph-node cells after IM injection); endosomal escape releases mRNA into the cytosol for translation."
  honesty = "The four-lipid LNP architecture is an engineering convergence (Cullis / Acuitas / Moderna lineage); it is NOT a derivation from any number-theoretic lattice."
  |> "[@x_kariko_weissman_2005]"

# ── §4 Schedule, herd immunity, cold chain (practical limits) ─────────

@D sched_design := "schedule design principles" :: domain [ok]
  prime-boost = "Most non-live vaccines require ≥2 doses; intervals are tuned to allow germinal-center maturation between doses (typically weeks)."
  infant-schedule = "WHO Expanded Programme on Immunization (EPI) defines a core infant schedule (BCG, OPV/IPV, DTP-containing combinations, HepB, Hib, PCV, rotavirus, measles, etc.); national NITAGs adapt locally."
  catch-up = "Catch-up schedules for missed doses; combination vaccines (e.g. DTaP-IPV-Hib-HepB hexavalent) reduce injection burden."
  honesty = "Schedules are EPIDEMIOLOGY/IMMUNOLOGY-driven and revised by national bodies and WHO SAGE; dose counts and intervals are NOT lattice-derived."
  |> "[@x_who_epi]"

@D sched_cold_chain := "cold-chain & thermostability" :: domain [ok]
  standard = "Most routine vaccines: 2-8 °C refrigerator chain from manufacturer to point of administration; vaccine-vial monitor (VVM) heat-history indicator on each vial for field use."
  ultra-low = "Early mRNA COVID-19 vaccines: ultra-low-temperature storage (e.g. roughly -70 °C for BNT162b2 original formulation, -20 °C for mRNA-1273); subsequent reformulations relaxed the requirement somewhat."
  freeze-sensitive = "Many adjuvanted vaccines (especially alum-containing) are damaged by FREEZING — a common cold-chain failure mode in resource-limited settings."
  consequence = "Cold-chain economics, infrastructure and failure modes are real public-health constraints on access, not a lattice product."
  |> "[@x_who_vvm]"

@D sched_herd := "herd immunity threshold (qualitative)" :: domain [ok]
  concept = "If the basic reproduction number is R0 and vaccine effectiveness against transmission is e, the immunised proportion p required to drive effective reproduction below 1 satisfies (qualitatively) approximately p · e ≥ 1 − 1/R0. So higher-transmissibility pathogens require a higher immunised fraction."
  examples = "Measles (very high R0) historically required very high coverage (often cited around the 90s-percent range) to prevent outbreaks; pertussis and influenza have lower (and for influenza highly variable) thresholds."
  honesty = "The 1 − 1/R0 expression is a SIMPLE COMPARTMENTAL-MODEL approximation (homogeneous mixing, all-or-nothing immunity); real thresholds are population-structured and depend on contact networks, waning, and leaky vs all-or-nothing protection. This is epidemiology, NOT a lattice derivation."
  not-lattice = "The expression 1 − 1/R0 is a real-pathogen-specific quantity (different for each R0). It is explicitly NOT derived from the n=6 lattice."
  |> "[@x_anderson_may]"

@D sched_outcomes := "landmark public-health outcomes" :: domain [ok]
  smallpox = "Smallpox: declared eradicated by WHO in 1980 following a global ring-vaccination + surveillance campaign — the only human disease eradicated by vaccination. The campaign built on Jenner's 1796/1798 cowpox observations."
  polio = "Polio: near-elimination by combined OPV/IPV strategies; remaining endemic transmission has been confined to a small number of countries (and outbreaks from vaccine-derived poliovirus track regional OPV use)."
  hpv = "HPV vaccination: population-level studies in early-adopter countries show large reductions in vaccine-type HPV prevalence, cervical pre-cancer, and emerging evidence of reduced invasive cervical cancer in vaccinated cohorts."
  measles = "Measles-containing-vaccine introduction reduced global measles mortality dramatically over the past few decades, though resurgent outbreaks track coverage drops."
  honesty = "These are well-documented public-health outcomes referenced qualitatively; precise mortality-averted estimates vary by source and are not asserted here as exact numbers."
  |> "[@x_jenner_1798] · [@x_who_smallpox_1980]"

# ── §5 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_antigenic_change := "antigenic drift & shift" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "Some pathogens evolve their surface antigens faster than population immunity can track. Influenza undergoes antigenic drift (point mutations in HA/NA accumulating each season) and periodic antigenic shift (reassortment) — necessitating annual strain selection and reformulation. SARS-CoV-2 variants (Alpha → Delta → Omicron → BA.x → XBB → ...) have produced repeated escape from prior-strain neutralisation, driving updated boosters."
  consequence = "Sterilizing, lifetime immunity to a rapidly evolving pathogen is generally not achievable with a single, fixed antigen formulation; the constraint is set by the pathogen's evolutionary rate, NOT by therapy potency or any numeric invariant."

@D lim_waning := "waning immunity" :: real-limit [ok required]
  wall = "SOFT WALL"
  statement = "Antibody titers (and cellular responses) decline over time after vaccination at antigen- and platform-dependent rates. Yellow-fever and measles vaccines yield decades-long protection in most recipients; pertussis and seasonal-coronavirus protection wane on a timescale of months to a few years; many platforms benefit from periodic boosting."
  consequence = "Booster strategy is empirically tuned per pathogen × platform; 'one dose for life' is a biological exception, not the rule, and aggregate 'durability' is not a single number."
  |> "[@x_plotkin_correlates_2010]"

@D lim_rare_ae := "rare immunogenicity adverse events & safety floor" :: real-limit [ok required]
  wall = "PHYSICAL/BIOLOGICAL LIMIT"
  statement = "All vaccines have some adverse-event profile; rare serious events (rates that may be in the per-million range and can only be characterised in post-marketing surveillance) include intussusception with first-generation rotavirus (RotaShield, withdrawn); narcolepsy associated with one pandemic-influenza vaccine formulation (Pandemrix, Northern Europe); thrombosis-with-thrombocytopenia syndrome (TTS) with certain adenoviral-vector COVID-19 vaccines; myocarditis post-mRNA COVID-19 vaccine (especially young males, mostly mild and self-limited)."
  consequence = "A nonzero rare-AE floor is a fundamental property of biologically active medical interventions; the public-health calculus is benefit-vs-risk vs the disease itself, not zero-risk attainability. Specific event rates are surveillance estimates with population dependence — they are NOT lattice values."

@D lim_hesitancy_access := "vaccine hesitancy & access" :: real-limit [ok required]
  wall = "BEHAVIORAL / ECONOMIC / SOCIAL LIMIT"
  statement = "Even an efficacious, safe, affordable vaccine fails to protect those it does not reach. Coverage is bounded by hesitancy (trust, misinformation, religious/cultural factors), access (supply, cost, cold-chain infrastructure, geography), and policy (mandates, recommendations, reimbursement). WHO has identified vaccine hesitancy as a major global health concern."
  consequence = "Programmatic outcomes depend on the social system as much as the immunology. A high-efficacy vaccine with low coverage protects fewer people than a moderate-efficacy vaccine with high coverage."
  |> "[@x_who_epi]"

@D lim_pathogen_specific_failures := "pathogen-specific failures (HIV, malaria, RSV historical)" :: real-limit [ok required]
  wall = "HARD WALL (current science, pathogen-by-pathogen)"
  hiv = "HIV: despite decades of effort and many candidate trials (RV144 showed modest, partial efficacy; subsequent trials did not replicate or extended only briefly), no licensed prophylactic HIV vaccine exists at knowledge cutoff. HIV's extreme antigenic variability, integration, and immune-evasion strategies have defeated successive approaches."
  malaria = "Malaria: RTS,S/AS01 (Mosquirix) and R21/Matrix-M are licensed/WHO-recommended for children in endemic regions — but efficacy is partial and wanes, requiring multiple doses and ongoing vector-control complementation."
  rsv-historical = "RSV: a 1960s formalin-inactivated RSV vaccine caused enhanced respiratory disease (ERD) on natural infection in vaccinees — setting back the field for decades. Only recently (2023+) have prefusion-stabilised-F protein subunit vaccines (for older adults and maternal immunization for infant protection) and monoclonal antibodies (nirsevimab; passive immunization) reached licensure."
  tuberculosis = "Tuberculosis: BCG protects against severe paediatric forms but provides variable / limited protection against adult pulmonary TB; a fully effective adult TB vaccine remains an open problem."
  consequence = "Some pathogens have, to date, defeated vaccine development on biological grounds (antigenic variability, immune-privileged reservoirs, dysregulated host responses) — these are real-biology hard walls, not failures of effort, and they cannot be wished away by lattice arguments."

@D lim_immunocompromised := "immunocompromised-host limit" :: real-limit [ok required]
  wall = "BIOLOGICAL LIMIT (host-intrinsic)"
  statement = "Vaccine response depends on a functional adaptive immune system. Profound immunodeficiency (e.g. advanced HIV with low CD4; haematologic-cancer chemotherapy; B-cell-depleting therapy such as rituximab; solid-organ transplant immunosuppression) markedly reduces vaccine immunogenicity and protection. Live-attenuated vaccines may also be contraindicated for safety."
  consequence = "Indirect protection via household / community immunity is part of the strategy for these patients; passive immunization (monoclonals, immunoglobulin) may complement vaccination."

# ── §6 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-vaccine-immunology" :: governance [required deny:write]
  pattern = "Deriving vaccine efficacy / dose count / interval / cold-chain temperature / serotype number FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. the deleted stub's '면역원성 = 6개월 × 6배', 'LNP = τ=4 components → 4 lipids derivation', 'IgG subclasses = τ', 'WHO EPI core = σ=12'."
  why = "This is exactly the violation the pre-rewrite VACCINE.tape committed (lattice-tautology stub, mass-split 153b5a2 — see VACCINE.log.tape audit). Some immunology counts (e.g. 4 IgG subclasses, 2 MHC classes, 4 LNP-lipid components) NUMERICALLY coincide with lattice values; that is OBSERVATION ONLY. Deriving the count, or claiming the count is so BECAUSE of n=6, is the violation. hexa-bio AGENTS.tape g1/g2/g3/g8 + f1/f2/f3 forbid it; f1 forbids lattice-fit, f2 forbids in-silico→clinical/efficacy claims."
  remedy = "Cite real vaccine immunology / landmark clinical literature (this tape's @X entries). Coincidence is observable; derivation is forbidden."

@N n6_honest_stance := "vaccine immunology has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: vaccine immunology exposes NO natural n=6 invariant. Platform classes are an open and expanding list (live-attenuated, inactivated, subunit/recombinant, toxoid, conjugate, VLP, viral-vector, mRNA, ... and growing — NOT a closed 6-tuple). Adjuvants are an open list (alum, MF59, AS01/03/04, CpG, Matrix-M, ...). Antibody isotypes (5), IgG subclasses (4), MHC classes (2) are textbook immunology numbers that EXIST in the immune system regardless of any lattice; their occasional numerical coincidence with σ/τ/φ values is an OBSERVATION, never a derivation. Herd-immunity threshold (1 − 1/R0) is pathogen-specific, not lattice-derived. Schedule dose counts are EPI/NITAG/SAGE clinical recommendations, not lattice products. Per LATTICE_POLICY g1/g2 + lattice-as-tool: the lattice is DECLINED here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §7 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 antigenic-drift-driven reformulation" :: prediction [ok]
  claim = "For rapidly evolving respiratory viruses with antigenically variable surface proteins (influenza A, SARS-CoV-2), strain-matched seasonal/periodic vaccine reformulation outperforms a fixed-composition formulation as the circulating-strain antigenic distance from the vaccine antigen increases."
  falsifier = "If a fixed-composition influenza or SARS-CoV-2 vaccine were shown to provide undiminished neutralisation and clinical protection across antigenically distant drift/shift variants over multiple seasons, [@lim_antigenic_change] is wrong."
  source = "[@x_voysey_2021] · [@x_polack_2020] (platform-rapid-redesign evidence and the broader influenza-WHO-strain-selection literature)"

@D tp_2 := "TP-2 platform-dependent durability gradient" :: prediction [ok]
  claim = "Durability of vaccine-induced humoral protection is platform- and antigen-dependent: live-attenuated vaccines for stable antigens (yellow fever 17D, measles) yield far longer-lasting antibody titres than non-live vaccines against rapidly evolving or short-replication-cycle pathogens (seasonal coronavirus / pertussis). Boosting strategies will be required for the latter class indefinitely."
  falsifier = "If a non-live, non-adjuvant-novel vaccine against a rapidly evolving respiratory pathogen produced sterile, lifetime immunity from a single primary series in a properly-followed cohort, [@lim_waning] is wrong."
  source = "[@x_plotkin_correlates_2010] · [@x_plotkin_textbook]"

@D tp_3 := "TP-3 coverage dominates efficacy at the population level" :: prediction [ok]
  claim = "For a vaccine-preventable disease at the population level, achievable disease incidence reduction is dominated by COVERAGE × effectiveness, so a moderate-efficacy vaccine with high coverage typically outperforms a high-efficacy vaccine with low coverage."
  falsifier = "If population-level disease incidence in a high-coverage moderate-efficacy programme were not lower than in a low-coverage high-efficacy programme (controlling for baseline incidence and surveillance), [@lim_hesitancy_access] is wrong."
  source = "[@x_who_epi] · [@x_anderson_may]"

# ── §8 External citations (real, landmark literature) ─────────────────

@X x_jenner_1798 := "Jenner E 1798" :: literature [active]
  ref = "Jenner E. An inquiry into the causes and effects of the variolae vaccinae, a disease discovered in some of the western counties of England, particularly Gloucestershire, and known by the name of the cow pox. London, 1798. (primary-author/era — original monograph; cowpox→smallpox cross-protection observation)"

@X x_salk_1955 := "Salk JE et al 1955" :: literature [active]
  ref = "Salk JE. Considerations in the preparation and use of poliomyelitis virus vaccine (inactivated). Field trial outcomes published 1955. (primary-author/era — landmark IPV field-trial era; exact JAMA volume not asserted here)"

@X x_sabin_1961 := "Sabin AB 1961" :: literature [active]
  ref = "Sabin AB. Live, orally given poliovirus vaccine — laboratory and field studies. Early-1960s literature describing OPV development. (primary-author/era; OPV / live-attenuated polio vaccine)"

@X x_plotkin_textbook := "Plotkin's Vaccines (textbook)" :: literature [active]
  ref = "Plotkin SA, Orenstein WA, Offit PA, Edwards KM (eds). Plotkin's Vaccines. Elsevier, multiple editions. (the standard vaccinology textbook; cited as primary-author/era — specific edition not asserted)"

@X x_plotkin_correlates_2010 := "Plotkin SA 2010" :: literature [active]
  ref = "Plotkin SA. Correlates of protection induced by vaccination. Clin Vaccine Immunol 2010;17:1055–1065."

@X x_pollard_bijker_2021 := "Pollard AJ, Bijker EM 2021" :: literature [active]
  ref = "Pollard AJ, Bijker EM. A guide to vaccinology: from basic principles to new developments. Nat Rev Immunol 2021;21:83–100."

@X x_janeway_textbook := "Janeway's Immunobiology (textbook)" :: literature [active]
  ref = "Murphy K, Weaver C (eds, founding author Janeway CA). Janeway's Immunobiology. Garland Science / Norton, multiple editions. (the standard immunology textbook; cited as primary-author/era)"

@X x_polack_2020 := "Polack FP et al 2020" :: literature [active]
  ref = "Polack FP et al. Safety and efficacy of the BNT162b2 mRNA Covid-19 vaccine. N Engl J Med 2020;383:2603–2615. (Pfizer-BioNTech BNT162b2 phase-3)"

@X x_baden_2020 := "Baden LR et al 2020" :: literature [active]
  ref = "Baden LR et al. Efficacy and safety of the mRNA-1273 SARS-CoV-2 vaccine. N Engl J Med 2020/2021;384:403–416. (Moderna mRNA-1273 phase-3; published online late 2020)"

@X x_voysey_2021 := "Voysey M et al 2021" :: literature [active]
  ref = "Voysey M et al (Oxford COVID Vaccine Trial Group). Safety and efficacy of the ChAdOx1 nCoV-19 vaccine (AZD1222) against SARS-CoV-2: an interim analysis of four randomised controlled trials. Lancet 2021;397:99–111."

@X x_henao_restrepo_2017 := "Henao-Restrepo AM et al 2017" :: literature [active]
  ref = "Henao-Restrepo AM et al. Efficacy and effectiveness of an rVSV-vectored vaccine in preventing Ebola virus disease: final results from the Guinea ring vaccination, open-label, cluster-randomised trial (Ebola Ça Suffit!). Lancet 2017;389:505–518."

@X x_kariko_weissman_2005 := "Karikó K, Weissman D et al 2005" :: literature [active]
  ref = "Karikó K, Buckstein M, Ni H, Weissman D. Suppression of RNA recognition by Toll-like receptors: the impact of nucleoside modification and the evolutionary origin of RNA. Immunity 2005;23:165–175. (nucleoside-modified mRNA → reduced innate sensing; foundational to mRNA-vaccine feasibility)"

@X x_anderson_may := "Anderson RM, May RM" :: literature [active]
  ref = "Anderson RM, May RM. Infectious Diseases of Humans: Dynamics and Control. Oxford University Press, 1991. (standard reference for the 1 − 1/R0 herd-immunity expression and compartmental-model foundations; primary-author/era — specific edition not asserted)"

@X x_who_smallpox_1980 := "WHO 1980 smallpox declaration" :: literature [active]
  ref = "World Health Assembly. Declaration of global eradication of smallpox. WHA33.3, 1980. (WHO formal declaration following the Global Commission for the Certification of Smallpox Eradication)"

@X x_who_epi := "WHO Expanded Programme on Immunization" :: literature [active]
  ref = "World Health Organization. Expanded Programme on Immunization (EPI) — global immunization schedules and SAGE recommendations. WHO, ongoing. (programmatic reference; cited as institutional source, specific document edition not asserted)"

@X x_who_vvm := "WHO vaccine vial monitor (VVM)" :: literature [active]
  ref = "World Health Organization. Vaccine vial monitor (VVM) policy and operational guidance. WHO Department of Immunization, Vaccines and Biologicals. (cold-chain heat-history field tool; institutional source, specific document edition not asserted)"
