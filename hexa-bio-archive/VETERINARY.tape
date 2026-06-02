#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# VETERINARY.tape — architecture-current (editable per v1.2)
# Event history → VETERINARY.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "veterinary" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · veterinary substrate — veterinary medicine + One Health knowledge SSOT"
  brief = "Veterinary medicine + One Health · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "VETERINARY.log.tape"
  scope = "in-silico veterinary knowledge SSOT · NOT veterinary advice / not a clinical or diagnostic protocol / not a regulatory or therapeutic claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see VETERINARY.log.tape audit"

@N scope_disclaimer := "veterinary-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico veterinary substrate. Drug toxicities, vaccine histories, disease epidemiology and welfare standards are paraphrased from published veterinary/public-health literature for modeling context ONLY — they are NOT veterinary advice, prescribing guidance, diagnostic protocols, or regulatory direction. Real animal health decisions require a licensed veterinarian. All hexa-bio axes are in-silico; see AGENTS.tape g8/f2."

# ── §1 Comparative anatomy, physiology & species pharmacology ──────────

@D dom_species_diversity := "veterinary species scope" :: domain [ok]
  scope = "Companion animals (dog, cat), equine, food animals (cattle, swine, poultry, small ruminants), exotic/zoo/wildlife. Each species has distinct anatomy, physiology, and pharmacology — 'veterinary medicine' is not one medicine."
  pharmacology-honesty = "Drug dose extrapolation across species fails frequently because of metabolic, receptor, and enzymatic differences. Species-specific data are required."
  |> "[@x_plumb_2023]"

@D dom_acetaminophen_cats := "acetaminophen (paracetamol) toxicity in cats" :: domain [ok]
  mechanism = "Cats have markedly reduced UDP-glucuronosyltransferase (UGT1A6/1A9) activity relative to dogs and humans — the glucuronidation pathway that detoxifies acetaminophen is largely absent. Toxic metabolite (NAPQI) accumulates, causing methemoglobinemia and hepatic necrosis."
  clinical = "Even single human-dose tablets can be lethal in cats. Cats develop methemoglobinemia (characteristic 'chocolate brown' blood), facial edema, and rapid deterioration."
  management = "N-acetylcysteine (NAC) replenishes glutathione; methylene blue for methemoglobinemia. Prognosis is time-dependent."
  principle = "This is the canonical interspecies pharmacology failure — a drug safe in one species is acutely toxic in another due to a defined enzymatic deficit."
  |> "[@x_plumb_2023]"

@D dom_xylitol_dogs := "xylitol toxicity in dogs" :: domain [ok]
  mechanism = "Xylitol (sugar alcohol used in sugar-free products, some peanut butters, gums) causes a potent insulin release in dogs — an insulin secretagogue effect not seen in humans or cats. This triggers rapid profound hypoglycemia. High doses also cause acute hepatic necrosis (mechanism less fully characterised, but dose-dependent)."
  clinical = "Hypoglycemia signs: vomiting, weakness, ataxia, seizures, coma. Onset within 30–60 minutes of ingestion. Hepatotoxic doses can produce ALT/AST elevation and coagulopathy."
  honesty = "Dose thresholds are published but exact mg/kg cut-offs should be checked against current toxicology references, not derived from this tape."
  |> "[@x_plumb_2023]"

@D dom_theobromine_dogs := "theobromine/chocolate toxicity in dogs" :: domain [ok]
  mechanism = "Theobromine (and caffeine) are methylxanthines. Dogs metabolise theobromine far more slowly than humans (~17.5-hour half-life in dogs vs ~7 hours in humans). Methylxanthines inhibit phosphodiesterase and antagonise adenosine receptors → cardiovascular and CNS stimulation."
  clinical = "Vomiting, diarrhea, restlessness, tachycardia, arrhythmias, tremors, seizures. Dark/baking chocolate has higher theobromine density than milk chocolate."
  principle = "Another interspecies pharmacokinetic difference: humans tolerate chocolate because they clear theobromine efficiently; dogs cannot."
  |> "[@x_plumb_2023]"

@D dom_lily_nephrotoxicity := "lily nephrotoxicity in cats" :: domain [ok]
  species = "TRUE lilies (Lilium spp.) and daylilies (Hemerocallis spp.) cause acute renal failure in cats. Dogs are not affected by the same species."
  mechanism = "Nephrotoxic compound(s) not fully characterised as of knowledge cutoff. Cats develop acute tubular necrosis; prognosis is poor without rapid decontamination and IV fluid therapy."
  honesty = "The toxic compound has not been definitively isolated in published literature as of knowledge cutoff. Taxon specificity (cats, not dogs) is established."
  |> "[@x_plumb_2023]"

# ── §2 Veterinary vaccinology ──────────────────────────────────────────

@D dom_vaccinology_history := "veterinary vaccine history — key landmarks" :: domain [ok]
  rabies-pasteur = "Louis Pasteur and colleagues demonstrated rabies attenuation and vaccination in dogs (1885), later extending to the first human post-exposure application. This is the origin of veterinary vaccinology as a scientific discipline."
  distemper = "Canine distemper virus (CDV) vaccine development (Laidlaw & Dunkin era, early-to-mid 20th century); CDV is a morbillivirus related to measles. CDV vaccine is a cornerstone of companion-animal preventive care."
  parvovirus = "Canine parvovirus type 2 (CPV-2) emerged as a new pathogen around 1978 (Carmichael and colleagues at Cornell described the emergence and initial vaccine development in the ~1978–1980 era — primary author/era, exact volumes cited cautiously). Rapid spread caused massive mortality in naive dog populations; CPV-2 vaccine developed quickly and became standard."
  felv = "Feline leukemia virus (FeLV) vaccine — FeLV causes immunosuppression and lymphoma in cats; vaccine is a major feline preventive care tool."
  fip = "Feline infectious peritonitis (FIP) vaccines have been historically difficult; the intranasal vaccine (Primucell) generated debate about efficacy. mRNA-based and novel antiviral approaches (GS-441524/remdesivir era) changed FIP treatment more than vaccination."
  fmd = "Foot-and-mouth disease (FMD) is the economically dominant livestock disease globally — highly contagious, multi-host (cattle, pigs, sheep, goats, wildlife). FMD vaccination is central to livestock protection and trade policy; many countries maintain vaccine banks."
  rinderpest = "Rinderpest (caused by Rinderpest morbillivirus) was eradicated globally — declared by OIE/FAO in 2011. It is only the second disease ever eradicated (after human smallpox, 1980), achieved through coordinated vaccination campaigns and surveillance."
  |> "[@x_pasteur_1885] · [@x_oie_rinderpest_2011] · [@x_wsava_guidelines]"

@D dom_wsava_core_vaccines := "WSAVA core vaccine principles" :: domain [ok]
  core-dog = "WSAVA guidelines designate CDV, CAV (canine adenovirus), CPV-2 as core vaccines for dogs globally — those that every dog should receive regardless of location."
  core-cat = "FHV-1 (feline herpesvirus), FCV (feline calicivirus), FPV (feline panleukopenia virus) are core cat vaccines. Rabies is core where the disease is present/required by law."
  non-core = "Non-core vaccines (Leptospira, Bordetella, Borrelia, etc.) based on geographic exposure risk and lifestyle."
  three-year-intervals = "WSAVA and evidence from duration-of-immunity studies support 3-year intervals for most core boosters in adult animals after initial puppy/kitten series, rather than annual; annual is protective but more than typically needed."
  honesty = "Specific schedules depend on local disease prevalence, manufacturer data, regulatory environment — not derivable from this tape."
  |> "[@x_wsava_guidelines]"

# ── §3 Companion animal medicine ──────────────────────────────────────

@D dom_companion_dental := "dental disease in companion animals" :: domain [ok]
  prevalence = "Periodontal disease is the most common clinical condition in dogs and cats. Studies suggest >70–80% of dogs and cats show some form of periodontal disease by age 3 (primary-author/era estimates; Gengler/Harvey era literature); prevalence rises with age."
  progression = "Plaque → calculus → gingivitis → periodontitis (irreversible attachment loss, bone resorption). Advanced disease causes pain, tooth loss, and potentially bacteremic events."
  management = "Professional dental scaling/polishing under anesthesia; home care (tooth brushing, dental diets/chews with VOHC acceptance). Prevention is more effective than treatment of established disease."
  |> "[@x_wsava_guidelines]"

@D dom_feline_ckd := "chronic kidney disease (CKD) in cats" :: domain [ok]
  prevalence = "CKD is one of the leading causes of morbidity and mortality in older cats. Studies report prevalence of ~30% in cats >10 years and up to ~50% in cats >15 years (IRIS era epidemiology)."
  staging = "IRIS (International Renal Interest Society) CKD staging system uses serum creatinine and SDMA (symmetric dimethylarginine) as biomarkers for staging I–IV; substaging by proteinuria and blood pressure. SDMA is an earlier marker than creatinine."
  management = "Renal diets (phosphorus restriction, high-quality protein), hydration (subcutaneous fluids), phosphorus binders, blood pressure control (amlodipine). No curative therapy; management slows progression."
  honesty = "Survival data and staging cut-offs are from IRIS guidelines and clinical studies; exact numbers should be checked against current IRIS guidelines, not derived from this tape."
  |> "[@x_iris_ckd]"

@D dom_canine_obesity := "obesity and osteoarthritis in dogs" :: domain [ok]
  obesity = "Canine obesity is estimated at 25–40% of the dog population in developed countries (primary-author/era estimates; Lund, German era literature). Excess body condition increases risk of orthopedic disease, diabetes, cardiorespiratory compromise, and reduces lifespan."
  osteoarthritis = "Osteoarthritis (OA) is the most common musculoskeletal disease in dogs; prevalence approximately 20% of dogs >1 year in some surveys, rising sharply in older and large-breed dogs."
  treatment = "Weight management (caloric restriction, body condition scoring BCS 4–5/9 target); NSAIDs (licensed veterinary NSAIDs — carprofen, meloxicam, grapiprant); rehabilitation; joint supplements (evidence variable)."
  honesty = "BCS scales are clinical ordinals (5- or 9-point), not lattice values. OA is a clinical/radiographic diagnosis."
  |> "[@x_plumb_2023]"

@D dom_spay_neuter := "companion animal spay/neuter — benefits and debates" :: domain [ok]
  traditional-rationale = "Ovariohysterectomy (OHE) in females prevents pyometra, mammary neoplasia (early spay markedly reduces risk), and unwanted reproduction. Castration prevents testicular neoplasia, reduces benign prostatic hyperplasia risk."
  emerging-debate = "Large-breed dog studies (Zink, Hart era — Golden Retrievers, German Shepherds; primary author/era noted) have raised concerns that early gonadectomy may increase risk of certain joint disorders and some cancers in large breeds. This has prompted reconsideration of timing in large/giant breeds."
  honesty = "The spay/neuter benefit-risk balance depends on species, breed, size, and individual circumstances. This tape records the scientific debate, not a recommendation."
  |> "[@x_wsava_guidelines]"

# ── §4 Production animal medicine ─────────────────────────────────────

@D dom_mastitis := "mastitis in dairy cattle" :: domain [ok]
  definition = "Mastitis (udder inflammation, usually infectious) is the most economically costly disease in dairy cattle globally. Contagious pathogens (Staphylococcus aureus, Streptococcus agalactiae) vs environmental pathogens (E. coli, environmental Streptococcus spp.)."
  impact = "Reduced milk yield, culling, treatment costs, milk discard. Subclinical mastitis (no visible signs but elevated somatic cell count, SCC) causes greater aggregate economic loss than clinical mastitis in most herds."
  control = "Dry-cow therapy (antibiotic/non-antibiotic teat sealer at drying off), post-milking teat dipping, milking hygiene, nutrition, housing. Moving from blanket dry-cow therapy to selective dry-cow therapy is an AMR-stewardship priority."
  |> "[@x_who_amr_tripartite]"

@D dom_lameness := "lameness in cattle and dairy herds" :: domain [ok]
  prevalence = "Lameness affects a substantial proportion of dairy cows — herd-level prevalence estimates range from 15–50% in intensive systems (primary-author/era estimates; Sprecher, Flower era locomotion scoring literature)."
  causes = "Digital dermatitis (Mortellaro disease, Treponema spp.), white-line disease, sole ulcer, interdigital necrobacillosis (footrot). Contagious vs non-contagious aetiologies have different control strategies."
  welfare = "Lameness is a significant welfare concern — it impairs locomotion, feeding, and reproductive performance, and causes pain."
  |> "[@x_mellor_five_domains]"

@D dom_reproduction_ai := "reproductive management and artificial insemination (AI)" :: domain [ok]
  ai-history = "Artificial insemination in cattle began systematically in the mid-20th century — a technology that enabled genetic improvement at scale by widely distributing semen from genetically superior bulls."
  synchronisation = "Synchronisation protocols (CIDR, OvSynch, 7-day CIDR-PRID etc.) allow time-AI without heat detection, enabling batch reproductive management. Prostaglandin F2α and GnRH are the pharmacological tools."
  impact = "AI combined with genomic selection (genomic estimated breeding values, GEBVs) has dramatically accelerated the rate of genetic gain in dairy cattle, particularly for milk production and increasingly for health/welfare traits."
  honesty = "Synchronisation protocol details, conception rates, and genetic parameters are herd/environment/management-dependent, not lattice-fixed constants."

@D dom_antibiotic_stewardship := "antibiotic use in livestock and AMR stewardship" :: domain [ok]
  global-framework = "WHO, FAO and OIE (now WOAH) have operated a tripartite One Health AMR framework. The 2015 WHO Global Action Plan on AMR called for reducing unnecessary antimicrobial use in livestock (particularly growth promotion and metaphylactic mass medication), noting that agriculture accounts for the majority of global antibiotic use by volume."
  growth-promoters = "Antibiotic growth promoters (AGPs) were widely used in livestock; the EU banned all AGP use from 2006. The US FDA implemented Guidance 213 (2012–2017 phase-out of growth-promotion labeling for medically important antimicrobials). The scientific consensus is that AGP use selects for AMR."
  critical-list = "WHO Critically Important Antimicrobials for Human Medicine (WHO CIA list) prioritises certain classes (carbapenems, 3rd/4th-gen cephalosporins, fluoroquinolones, colistin) for restriction in veterinary use."
  honesty = "AMR is a complex systems problem; this tape records the regulatory and scientific framework, not a farming protocol."
  |> "[@x_who_amr_tripartite]"

# ── §5 One Health: zoonoses and the human-animal-environment interface ─

@D dom_one_health := "One Health framework" :: domain [ok]
  definition = "One Health recognises that the health of humans, animals, and ecosystems is interdependent and must be addressed jointly. Formalised as a policy/scientific framework by FAO/OIE/WHO tripartite and later the Quadripartite (UNEP added) in the 2020s."
  zoonosis-burden = "An estimated 60–75% of emerging human infectious diseases have animal origins (primary-author/era: Taylor/Woolhouse/Jones era literature, ~2001–2008); zoonoses span bacteria, viruses, parasites, and fungi."
  |> "[@x_who_one_health] · [@x_plowright_2017]"

@D dom_rabies := "rabies — the model zoonosis" :: domain [ok]
  agent = "Rabies lyssavirus; neurotropic; causes invariably fatal encephalitis once clinical."
  burden = "WHO estimates approximately 59,000 human deaths per year globally, predominantly in Africa and Asia; >95% of human cases transmitted by dogs. The vaccine-preventable burden is an access/delivery problem, not a scientific unknown."
  reservoir = "Domestic dogs are the principal reservoir for human exposure globally. Wildlife reservoirs (raccoons, skunks, foxes, bats) dominate in regions where canine rabies is controlled (Americas, Europe)."
  pasteur-origin = "Pasteur's 1885 rabies vaccination campaign (first human application, post-exposure, to Joseph Meister) defined the possibility of post-exposure prophylaxis (PEP) — a cornerstone of current rabies control."
  control = "Mass dog vaccination (target: 70% coverage) interrupts transmission. Dog-mediated rabies is eliminable; this is a WHO/GARC elimination target by 2030."
  |> "[@x_pasteur_1885] · [@x_who_rabies]"

@D dom_brucellosis := "brucellosis — livestock reservoir, human spillover" :: domain [ok]
  agents = "Brucella abortus (cattle), B. melitensis (sheep/goat, most virulent for humans), B. suis (pigs), B. canis (dogs). Gram-negative, facultative intracellular."
  disease-animals = "Abortion, retained placenta, reproductive failure in livestock. Economic impact on production and trade (many countries require Brucella-free status for animal export)."
  disease-humans = "Undulant fever (Malta fever) — chronic febrile illness; joint, cardiac, neurological complications possible. Occupational risk for farmers, vets, abattoir workers. Transmission via raw dairy, direct contact with aborted material, laboratory exposure."
  control = "Vaccination of cattle (RB51, S19 strains) + test-and-slaughter programs. Many developed countries achieved eradication or very low prevalence."
  |> "[@x_who_one_health]"

@D dom_leptospirosis := "leptospirosis — globally widespread zoonosis" :: domain [ok]
  agent = "Spirochete Leptospira spp.; rodents are the principal maintenance hosts; livestock, dogs are incidental/amplifying hosts."
  human-burden = "One of the most common zoonoses globally; estimated ~1 million severe cases per year (Hartskeerl/Hartskeerl/WHO era estimates); fatality rate 5–20% in severe cases (Weil's disease)."
  veterinary = "Clinical disease in dogs (acute renal/hepatic failure; Weils disease in dogs). Vaccine available (serotype-specific; annual booster). Serovars vary geographically."
  |> "[@x_who_one_health]"

@D dom_avian_influenza := "avian influenza H5N1/H5N8 — wildlife-poultry-human interface" :: domain [ok]
  emergence = "Highly pathogenic avian influenza (HPAI) H5N1 first caused confirmed human mortality during the 1997 Hong Kong poultry outbreak — the initial demonstration of HPAI crossing directly to humans. Subsequent global spread from ~2003 onwards."
  h5n1-human = "H5N1 human cases: over 900 confirmed by WHO as of the knowledge cutoff, case fatality >50% (though surveillance bias inflates this). Not efficiently human-to-human transmissible as of knowledge cutoff — pandemic risk depends on mutational adaptation."
  h5n8-h5n1-2020s = "H5N1 clade 2.3.4.4b caused unprecedented global HPAI outbreaks from 2020–2024 affecting poultry, wild birds, and spilling into marine mammals (US fur seals, sea lions) and US dairy cattle (2024). The dairy cattle outbreak was a novel host range event."
  risk-framework = "The Plowright et al. (2017) zoonotic-pathway framework identifies land-use change, host community composition, and pathogen shedding intensity as key drivers of spillover risk — not a single linear chain but a probability product across ecological stages."
  honesty = "H5N1 case-count figures are WHO surveillance data subject to ascertainment bias; trends more reliable than absolute numbers."
  |> "[@x_plowright_2017] · [@x_who_one_health]"

@D dom_bse_prion := "BSE/vCJD and prion disease" :: domain [ok]
  discovery = "Stanley Prusiner proposed the prion (proteinaceous infectious particle — protein-only hypothesis of TSE infectivity) in a landmark 1982 Science paper. Prusiner was awarded the 1997 Nobel Prize in Physiology or Medicine for this work."
  bse = "Bovine spongiform encephalopathy (BSE, 'mad cow disease') emerged in UK cattle in the 1980s. Epidemiologically linked to feeding meat-and-bone meal (MBM) containing scrapie-contaminated ruminant material — a recycled protein source that amplified the prion."
  vcjd = "Variant Creutzfeldt-Jakob disease (vCJD) in humans — the zoonotic consequence of BSE exposure through beef consumption, primarily in the UK. A distinct clinical and neuropathological entity from classical CJD."
  control = "MBM feeding ban for ruminants; enhanced surveillance; specified risk material (SRM) removal from the food chain. BSE incidence fell sharply following controls."
  |> "[@x_prusiner_1982]"

@D dom_mers := "MERS-CoV — dromedary camel reservoir" :: domain [ok]
  emergence = "Middle East respiratory syndrome coronavirus (MERS-CoV) first identified in human patients in 2012 (Zaki et al., Saudi Arabia). Dromedary camels identified as the primary animal reservoir — most human cases traceable to zoonotic spillover from camels, with limited nosocomial human-to-human transmission."
  burden = "Over 2,500 confirmed human cases and approximately 900 deaths (WHO data to knowledge cutoff); case fatality ~35%. Not sustainably human-to-human transmissible (in contrast to SARS-CoV-2)."
  covid19 = "SARS-CoV-2 (COVID-19) origin investigation implicated wildlife market/bat-origin spillover; a reminder that novel coronavirus emergence via animal-human interfaces is an ongoing One Health risk."
  |> "[@x_who_one_health]"

# ── §6 Anesthesia and animal welfare ──────────────────────────────────

@D dom_welfare_five_domains := "animal welfare — Five Domains model" :: domain [ok]
  history = "The Five Freedoms framework (Brambell Report, UK, 1965/FAWC) was the dominant welfare framework for decades: freedom from hunger/thirst; discomfort; pain/injury/disease; fear/distress; freedom to express normal behaviour."
  five-domains = "The Five Domains model (David Mellor and colleagues, Massey University, New Zealand — developed from the 1990s–2000s onward) replaced/extended Five Freedoms: Domain 1 Nutrition; Domain 2 Physical Environment; Domain 3 Health; Domain 4 Behavioural Interactions; Domain 5 Mental State. It explicitly incorporates positive welfare experiences, not only the absence of negatives."
  significance = "Five Domains is now the standard welfare assessment framework recommended by WSAVA and WOAH. It shifts emphasis from merely preventing suffering to enabling positive welfare outcomes."
  honesty = "5 Domains count is the count of model domains as defined by Mellor et al. — a welfare-model design choice, not a lattice value (it is 5, not 6)."
  |> "[@x_mellor_five_domains]"

@D dom_anesthesia := "veterinary anesthesia — species considerations" :: domain [ok]
  cat-morphine = "Cats differ from dogs and humans in opioid pharmacology — they metabolise morphine slowly (reduced glucuronidation, same UGT deficit as for acetaminophen) and can develop excitation rather than sedation at high doses. Species-specific protocols are essential."
  equine = "Equine anesthesia carries higher mortality risk than small animal anesthesia — myopathy under prolonged recumbency (compartment syndrome), respiratory compromise, and recovery (standing recovery is inherently hazardous). Halothane/isoflurane equine anesthetic death rates historically estimated at 1–2% for routine surgery (Matthews & Lindner era)."
  avian-exotic = "Birds and reptiles have markedly different respiratory physiology (avian air-sac system, reptilian ectothermy) requiring protocol adaptation. Monitoring (respiratory rate, SpO2) is challenging."
  honesty = "Anesthetic protocols and dose ranges are species/procedure/patient-specific; not prescribable from this tape — consult licensed veterinary anesthesiologists."
  |> "[@x_plumb_2023]"

# ── §7 Veterinary regulatory landscape ────────────────────────────────

@D dom_regulatory := "veterinary regulatory bodies" :: domain [ok]
  usda-aphis = "USDA/APHIS (Animal and Plant Health Inspection Service) — US federal oversight of veterinary biologics (vaccine licensing), animal import/export, disease surveillance, and eradication programs (brucellosis, bovine TB)."
  fda-cvm = "FDA Center for Veterinary Medicine (FDA/CVM) — approves veterinary drugs and medicated animal feeds in the USA; administers Veterinary Feed Directive (VFD) for medicated feeds requiring veterinarian oversight."
  ema = "European Medicines Agency (EMA) — evaluates and approves veterinary medicines for the EU; has implemented progressively stricter AMR-related restrictions on veterinary antibiotic classes."
  oie-woah = "OIE (World Organisation for Animal Health, now rebranded WOAH) — the intergovernmental body setting animal health standards, disease notification obligations, and veterinary trade standards globally. Published the Terrestrial and Aquatic Animal Health Codes."
  honesty = "Regulatory requirements change; this tape records the structural landscape, not specific approval status of any product."
  |> "[@x_oie_rinderpest_2011]"

# ── §8 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_amr := "antimicrobial resistance (AMR) — a hard One Health constraint" :: real-limit [ok required]
  wall = "HARD WALL (evolutionary — cannot be deleted, only managed)"
  statement = "Selection pressure from antibiotic use in livestock (and humans) drives resistance evolution in bacteria. AMR genes move between animal and human pathogen populations via horizontal gene transfer and zoonotic pathogen spread. WHO/FAO/WOAH tripartite framework identifies AMR as a One Health crisis requiring co-management across veterinary and human medicine."
  consequence = "The efficacy of medically critical antimicrobial classes is being progressively depleted by overuse. This is an evolutionary constraint, not a regulatory choice — resistance emerges regardless of intent, driven by selective pressure."
  |> "[@x_who_amr_tripartite]"

@D lim_owner_cost := "owner cost-of-care floor — access to veterinary treatment" :: real-limit [ok required]
  wall = "ECONOMIC/SOCIAL LIMIT"
  statement = "Veterinary care access is limited by owner financial resources, geographic access to veterinary services (rural shortage), and species-economic calculus (production animals: treatment cost vs animal value determines whether treatment is pursued). A medically optimal treatment plan is often not implemented due to cost."
  consequence = "Treatment decisions in veterinary medicine are always two-party: clinician recommendation and owner resource/consent. Unlike human medicine there is no universal access floor. This shapes what interventions are practically achievable at population level."

@D lim_cat_acetaminophen := "species-specific pharmacology — cat UGT deficit (acetaminophen)" :: real-limit [ok required]
  wall = "HARD WALL (enzymatic/species-intrinsic)"
  statement = "Cats lack effective UDP-glucuronosyltransferase activity for acetaminophen conjugation — a hard species-intrinsic metabolic limit. A dose that is safe in humans or dogs is acutely lethal in cats. This is the paradigm case for why cross-species drug extrapolation requires species-specific data, not allometric scaling alone."
  consequence = "Any veterinary pharmacology model must track species-specific metabolic pathways, not assume mammalian universality."
  |> "[@x_plumb_2023]"

@D lim_welfare_heterogeneity := "global heterogeneity of animal welfare standards" :: real-limit [ok required]
  wall = "REGULATORY/ETHICAL LIMIT"
  statement = "Animal welfare standards vary enormously across jurisdictions — from comprehensive legislative frameworks (EU Animal Welfare Regulation, UK Animal Welfare Act) to minimal or unenforced standards in many regions. What constitutes acceptable husbandry or slaughter practice is not globally uniform. This limits harmonisation of production-system welfare outcomes."
  consequence = "Welfare-driven production claims (free-range, cage-free, etc.) are jurisdiction/certification-specific, not universally defined. In-silico models must not assume a single welfare standard applies globally."
  |> "[@x_mellor_five_domains]"

@D lim_zoonotic_emergence := "emerging-zoonosis pandemic risk — a systemic ecological limit" :: real-limit [ok required]
  wall = "HARD ECOLOGICAL CONSTRAINT (probability-bounded, not preventable to zero)"
  statement = "The Plowright et al. 2017 (Nat Rev Microbiol 15:502-510) pathways framework shows that zoonotic spillover is a multi-stage probability product: pathogen exists in wildlife reservoir → shedding/infection of interface hosts → exposure opportunity for humans → human infection → human-to-human transmission. Land-use change (habitat fragmentation, wildlife-livestock contact), amplifying host community composition, and pathogen mutation rates determine spillover risk at each stage. No intervention eliminates all stages simultaneously."
  consequence = "Novel zoonotic emergence is a permanent ecological risk to human health. Surveillance systems (OneHealth) at the wildlife-livestock-human interface reduce detection lag but do not prevent the evolutionary and ecological drivers."
  |> "[@x_plowright_2017]"

# ── §9 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-veterinary" :: governance [required deny:write]
  pattern = "Deriving veterinary quantities (species counts, vaccine schedules, organ counts, disease classifications, pregnancy lengths, pharmacologic efficacy) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'cattle have 4 stomachs because τ=4', '42 dog teeth because n=6×7', 'pregnancy 114 days because σ*(σ-φ)-n'. These are exactly the fabrications in the pre-rewrite VETERINARY.tape stub."
  why = "Veterinary medicine has no natural n=6 invariant. Animal anatomy (cervical vertebrae, dental counts, gestation days) is shaped by evolution, developmental biology, and functional constraint — not by integer arithmetic on lattice constants. hexa-bio AGENTS.tape @F f1 + @D g1/g2 forbid this derivation pattern."
  remedy = "Cite real veterinary/biomedical literature (this tape's @X entries). Numeric coincidences between biological counts and lattice constants are OBSERVATION ONLY, not derivation — and many are not even genuine coincidences (e.g. 63-day canine gestation is an approximate mean with natural variation, not a constant)."

@N n6_honest_stance := "veterinary medicine has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: veterinary medicine exposes NO natural n=6 invariant. The prior stub's 'EXACT' claims (cervical vertebrae = σ - sopfr, dog teeth = (σ-sopfr)×n, gestation = σ*(σ-φ)-n, etc.) are post-hoc arithmetic exercises on flexible approximations — they work only because animal biometrics have natural variation and the lattice has many constants to combine. None are derivations; they are coincidence-engineering. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool), and LATTICE_POLICY: the lattice is declined here as a derivation tool. Numeric coincidences (e.g. ~6 major livestock species as a rough historical count) may be noted as OBSERVATION ONLY, not derived. This honesty is the corrective for the audited lattice-tautology stub (153b5a2 mass-split)."

# ── §10 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 canine parvovirus vaccine protection" :: prediction [ok]
  claim = "A properly vaccinated dog (full puppy series + booster per WSAVA guidelines) has substantially lower risk of clinical CPV-2 disease than an unvaccinated dog in the same environment."
  falsifier = "If a properly powered prospective cohort study with verified vaccination status shows no difference in CPV-2 disease rates between vaccinated and unvaccinated dogs, the efficacy basis for CPV-2 vaccination is wrong."
  source = "[@x_wsava_guidelines]"

@D tp_2 := "TP-2 dog-mediated rabies elimination via mass vaccination" :: prediction [ok]
  claim = "Achieving ≥70% dog population vaccination coverage in an endemic region interrupts dog-mediated rabies transmission and reduces human post-exposure prophylaxis demand — consistent with WHO's field evidence from elimination campaigns."
  falsifier = "If a large-scale mass dog vaccination campaign achieving verified ≥70% coverage in a closed population fails to substantially reduce canine rabies incidence within 2–3 years, the epidemiological threshold model for rabies interruption is wrong."
  source = "[@x_who_rabies]"

@D tp_3 := "TP-3 AMR resistance emergence under AGP pressure" :: prediction [ok]
  claim = "Sustained antibiotic growth promoter use in livestock at a farm/region level increases the prevalence of resistance genes (and resistant bacteria) in on-farm animal populations and their environment, compared to equivalent populations managed without AGPs."
  falsifier = "If a randomised controlled trial at farm level with verified AGP removal shows no change in AMR gene prevalence in livestock or farm environment after ≥2 years, the AMR selection-pressure model for AGP use is wrong."
  source = "[@x_who_amr_tripartite]"

# ── §11 Cross-links ────────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity) · @D g3 (honesty-obligation-external). This tape complies: real veterinary science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §12 External citations (real, landmark literature) ────────────────
# Where specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_pasteur_1885 := "Pasteur et al 1885 — rabies vaccination" :: literature [active]
  ref = "Pasteur L, Chamberland C, Roux E. Méthode pour prévenir la rage après morsure. C R Acad Sci 1885;101:765–774. (first human rabies post-exposure vaccination, July 1885 — Joseph Meister; establishes post-exposure prophylaxis principle; origin of veterinary vaccinology as a field)"

@X x_prusiner_1982 := "Prusiner 1982 — prion discovery" :: literature [active]
  ref = "Prusiner SB. Novel proteinaceous infectious particles cause scrapie. Science 1982;216:136–144. (original prion proposal; Nobel Prize in Physiology or Medicine 1997)"

@X x_plowright_2017 := "Plowright et al 2017 — zoonotic-pathway framework" :: literature [active]
  ref = "Plowright RK, Parrish CR, McCallum H, Hudson PJ, Ko AI, Graham AL, Lloyd-Smith JO. Pathways to zoonotic spillover. Nat Rev Microbiol 2017;15:502–510. (probabilistic multi-stage spillover framework; wildlife–livestock–human interface)"

@X x_who_rabies := "WHO — rabies fact sheet" :: literature [active]
  ref = "World Health Organization. Rabies fact sheet (institutional; regularly updated). Key figures: ~59,000 human deaths/year; >95% dog-transmitted; 2030 zero-human-deaths-from-dog-mediated-rabies target. URL: https://www.who.int/news-room/fact-sheets/detail/rabies"

@X x_who_amr_tripartite := "WHO/FAO/WOAH tripartite AMR framework" :: literature [active]
  ref = "WHO/FAO/OIE Tripartite. Global Action Plan on Antimicrobial Resistance (WHO 2015) and associated Tripartite AMR monitoring frameworks. Also: WHO Critically Important Antimicrobials for Human Medicine (CIA list, 6th revision 2019 and updates). Institutional, multiple documents."

@X x_who_one_health := "WHO/FAO/WOAH One Health framework" :: literature [active]
  ref = "WHO/FAO/UNEP/WOAH. One Health Joint Plan of Action (2022–2026). Institutional document establishing the Quadripartite One Health framework. https://www.who.int/publications/i/item/9789240059139"

@X x_oie_rinderpest_2011 := "OIE/FAO rinderpest eradication 2011" :: literature [active]
  ref = "OIE/FAO. Global eradication of rinderpest declared May 2011 (Resolution No. 18, 79th OIE General Session). Rinderpest morbillivirus is the second pathogen eradicated (after human smallpox 1980). Institutional."

@X x_wsava_guidelines := "WSAVA Vaccination Guidelines" :: literature [active]
  ref = "WSAVA Vaccination Guidelines Group. WSAVA guidelines for the vaccination of dogs and cats (primary author/era: Day, Horzinek, Schultz, Squires — multiple editions; 2016 guidelines most cited). Establishes core/non-core vaccine framework and 3-year booster intervals."

@X x_plumb_2023 := "Plumb's Veterinary Drug Handbook" :: literature [active]
  ref = "Plumb DC. Plumb's Veterinary Drug Handbook (9th ed. 2018 or current edition; primary author D.C. Plumb). Standard veterinary pharmacology reference; basis for species-specific drug dosing and toxicity profiles (acetaminophen/cats, xylitol/dogs, theobromine/dogs)."

@X x_iris_ckd := "IRIS CKD Staging Guidelines" :: literature [active]
  ref = "International Renal Interest Society (IRIS). IRIS Staging of CKD (feline and canine). Institutional guidelines, updated periodically. Basis for creatinine/SDMA staging and substaging by proteinuria and blood pressure. https://www.iris-kidney.com/"

@X x_mellor_five_domains := "Mellor — Five Domains animal welfare model" :: literature [active]
  ref = "Mellor DJ. Moving beyond the 'Five Freedoms' by updating the 'Five Domains' model. Animals 2016;6(7):59. (primary author David Mellor, Massey University; formalises Five Domains replacing Five Freedoms as the dominant welfare framework)"
