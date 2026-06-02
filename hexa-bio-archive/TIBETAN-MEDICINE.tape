#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# TIBETAN-MEDICINE.tape — architecture-current (editable per v1.2)
# Event history → TIBETAN-MEDICINE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §0 Identity ──────────────────────────────────────────────────────

@I id001 := "tibetan-medicine" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · Sowa Rigpa traditional medicine — ethnopharmacology + evidence-grade + safety"
  brief = "Sowa Rigpa traditional medicine — ethnopharmacology + evidence-grade + safety · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "TIBETAN-MEDICINE.log.tape"
  scope = "in-silico knowledge SSOT · NOT medical/therapeutic advice · evidence-grade explicitly distinguished · heavy-metal safety flagged"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see TIBETAN-MEDICINE.log.tape audit"

@N scope_disclaimer := "evidence-grade + cultural respect + heavy-metal safety honesty" :: note [required]
  text = "Tibetan medicine (Sowa Rigpa, གསོ་བ་རིག་པ) is a millennia-old medical tradition that deserves cultural respect and scientific scrutiny simultaneously. This tape enforces strict evidence-grade separation: (A) Peer-reviewed controlled-trial evidence — some Padma 28 (intermittent claudication, some Padma Lax (IBS-C) and some Yangmin 17 (chronic hepatitis) preparations have published trial literature; these are MODEST evidence, not confirmatory; (B) Limited / heterogeneous trials — preliminary evidence from small or methodologically variable trials; (C) Traditional-use-only — widespread classical use without adequate controlled-trial support; traditional use DOES NOT equal efficacy. CRITICAL SAFETY DISCLOSURE: Several classical Tibetan formulations — especially precious-pill rinchen rilbu preparations — contain mercury (cinnabar/HgS), arsenic, and lead. Purification ('bcud len' / rinchen rilbu processing) is claimed to reduce bioavailability via sulfide complexation, but contemporary toxicology literature documents variable heavy-metal contamination and genuine toxicity risk. This tape does NOT make therapeutic recommendations. In-silico knowledge SSOT only (hexa-bio AGENTS.tape g8 / f2)."

# ─── §1 System overview: Sowa Rigpa / Gyud Zhi ───────────────────────

@D dom_sowa_rigpa := "Sowa Rigpa — 'science of healing' (གསོ་བ་རིག་པ)" :: domain [ok]
  tibetan-name = "Sowa Rigpa (གསོ་བ་རིག་པ) — the Tibetan medical tradition; recognized by WHO as a traditional medicine system."
  origin = "Synthesized from indigenous Tibetan practices, Ayurvedic (Indian), and classical Chinese medicine influences; the canonical root text, the rGyud bzhi (Four Medical Tantras), was compiled approximately in the 12th century CE, attributed to Yuthog Yonten Gonpo the Younger (Yuthog the Younger, fl. ~12th century CE). Earlier strands trace to the 8th century under the earlier Yuthog."
  canonical-text = "rGyud bzhi (བཀའ་རྒྱུད་བཞི, Four Tantras / Four Medical Tantras): four parts (Root Tantra, Explanatory Tantra, Oral Instruction Tantra, Last Tantra). Encyclopedic scope: anatomy, physiology, nosology, diagnostics, therapeutics, pharmacopoeia."
  principal-commentary = "Desi Sangye Gyatso (སྡེ་སྲིད་སངས་རྒྱས་རྒྱ་མཚོ), Blue Beryl (Vaidurya sNgon po / baidurya sngon po), 1687–1703 — the most authoritative classical commentary on the rGyud bzhi; accompanied by the famous 77 Tibetan medical thangka illustrations (Buryatia / Men-Tsee-Khang collections)."
  institutional-ssot = "Men-Tsee-Khang (Tibetan Medical and Astro Institute, Dharamsala, India; re-established 1961 under H.H. the Dalai Lama's government-in-exile) is the principal institutional custodian of Sowa Rigpa practice and pharmacopoeia standardization."
  who-recognition = "WHO Traditional Medicine Strategy 2014–2023 explicitly references Sowa Rigpa as a recognized traditional medicine system; encourages safe integration through evidence evaluation."
  |> "[@x_gyudzhi_12thc] · [@x_desi_sangye_1703] · [@x_who_tm_strategy]"

@D dom_nyepa := "three nyepa (humoral principles) — rlung / mkhris-pa / bad-kan" :: domain [ok]
  humoral-framework = "Sowa Rigpa physiology centers on three nyepa (ཉེས་པ): (1) rlung (རླུང, wind/air — governs movement, respiration, nervous system analogue); (2) mkhris-pa (མཁྲིས་པ, bile/fire — governs digestion, metabolism, body heat); (3) bad-kan (བད་ཀན, phlegm/water-earth — governs structure, lubrication, bodily fluids). Disease arises from imbalance among the three."
  mapping-honesty = "The nyepa are traditional cosmological/physiological constructs. They do NOT map 1:1 to any biomedical organ system or biochemical pathway. Cross-referencing to Western physiology requires caution — functional analogies exist (e.g. rlung ~ autonomic nervous system / metabolic wind disorders) but they are NOT mechanistic identities. This tape does not claim mechanistic equivalence."
  five-elements = "Sowa Rigpa also uses a five-element framework (nam-mkha'/space, rlung/wind, me/fire, chu/water, sa/earth) that shapes the nyepa and pharmacopoeia classification of tastes and potencies. The five-element count is a traditional cosmological scheme — NOT lattice-derived and NOT coincidental with any n=6 value (see [@n6_honest_stance])."
  count-honesty = "Three nyepa: 3, not 6. Five elements: 5, not 6. Six tastes (ro drug): see [@dom_six_tastes]. These counts are textually and historically fixed in the Gyud Zhi canon — they are NOT lattice-constrained and must not be lattice-fit."
  |> "[@x_gyudzhi_12thc] · [@x_desi_sangye_1703]"

@D dom_diagnostics := "Sowa Rigpa diagnostics — pulse, urine, questioning" :: domain [ok]
  three-modes = "Tibetan medicine diagnosis relies on three principal methods: (1) observation (lta ba — urine analysis, scleral/tongue examination); (2) palpation (reg pa — pulse diagnosis at three positions on both wrists, each yielding organ/nyepa information); (3) questioning (dri ba — medical history, diet, behavior, symptoms)."
  pulse-diagnosis = "The twelve-organ pulse system (six per wrist: three superficial + three deep positions per wrist) is a classical diagnostic art. 'Twelve' is a textually fixed canon value — it does NOT derive from n=6 lattice arithmetic (σ=12 is coincidental; see [@n6_honest_stance])."
  urine-diagnosis = "Urine color, turbidity, vapor, sediment, bubbles, and odor are assessed — a sophisticated observational system codified in the Oral Instruction Tantra. Modern researchers have explored correlations to biomarkers (limited evidence)."
  |> "[@x_gyudzhi_12thc]"

@D dom_six_tastes := "six tastes (ro drug) in Sowa Rigpa pharmacopoeia" :: domain [ok]
  tibetan-framework = "Sowa Rigpa classifies all substances by six tastes (ro drug, རོ་དྲུག): mngar (sweet), skyur (sour), lan-tshwa (salty), kha-ba (bitter), tsha-ba (hot/pungent), bskya-ba (astringent). Taste informs the primary pharmacological properties in the classical system."
  count-honesty = "Six tastes is a textually fixed canonical scheme with deep roots in both Tibetan and Ayurvedic (Sanskrit: shadrasa) traditions. It is NOT derived from the n=6 lattice (see [@n6_honest_stance]). The number 6 here is a pre-existing cosmological convention from pan-Asian traditional medicine, not a lattice construction. Observation only: the count happens to be 6."
  post-digestive-taste = "A seventh category, 'taste after digestion' (zhu rjes kyi ro), is recognized — the classical system is richer than a strict six-count implies."
  western-correlates = "The Sowa Rigpa taste categories have partial chemical-class correlations (sweet ~ carbohydrates/amino acids; sour ~ organic acids; salty ~ mineral/electrolyte; bitter ~ alkaloids; hot ~ capsaicin family / pungent compounds; astringent ~ tannins/polyphenols). These are observational analogies, not verified 1:1 mappings."
  pharmacognosy-note = "Chemical constituents responsible for specific tastes and their traditional actions require independent phytopharmacological investigation to evaluate. Traditional assignment to a taste class is not pharmacological validation."
  |> "[@x_gyudzhi_12thc]"

@D dom_treatment_categories := "four treatment categories (Gyud Zhi)" :: domain [ok]
  diet = "Diet (za ba) — primary preventive and therapeutic tool; foods and drinks are classified by taste/potency and prescribed or restricted per nyepa imbalance."
  behavior = "Behavioral medicine (spyod pa) — lifestyle, daily routine, seasonal regimen, mental hygiene."
  medicines = "Medicinal formulations (sman) — the pharmacopoeia: plant, mineral, and animal-derived preparations; see [@dom_pharmacopoeia]."
  external = "External therapies (dpyad pa) — including Ku nye massage, moxibustion (me btsa), bloodletting, enema, and cupping; analogues to classical Ayurvedic panchakarma procedures."
  |> "[@x_gyudzhi_12thc]"

# ─── §2 Pharmacopoeia and formulations ───────────────────────────────

@D dom_pharmacopoeia := "Sowa Rigpa pharmacopoeia overview" :: domain [ok]
  scope = "The rGyud bzhi and subsequent formularies list hundreds of medicinal substances: plants (roots, bark, fruit, seed, flower, resin), minerals (including metals and their processed forms), and animal-derived substances. Estimates of distinct substances vary (commonly cited: 1000+)."
  classical-texts = "Major formularies include the Sde bzhi (Four Collections), Yutog Nyingthig, and later works by Desi Sangye Gyatso. Men-Tsee-Khang publishes a standardized contemporary formulary."
  standardization-issue = "Classical recipes predate pharmaceutical-grade standardization. Active-compound content, bioavailability, and quality control of traditional preparations vary significantly — a real limit (see [@lim_standardization])."
  |> "[@x_desi_sangye_1703] · [@x_menteekang_formulary]"

@D dom_rinchen_rilbu := "rinchen rilbu (precious pills) — formulations and heavy-metal safety" :: domain [ok]
  definition = "Rinchen rilbu (རིན་ཆེན་རིལ་བུ, precious pills) are the most complex and revered formulations in Sowa Rigpa, containing dozens of ingredients including minerals, metals, and gems. Examples: Rinchen Ratna Sampel, Rinchen Mangjor Chenmo, Rinchen Drangjor."
  heavy-metals-present = "Classical precious-pill recipes explicitly include cinnabar (HgS, zhu byed — mercury sulfide), arsenic-bearing minerals (realgar, orpiment), and lead compounds. These are NOT incidental contamination — they are prescribed ingredients in classical texts."
  purification-claim = "Traditional 'detoxification' processing (bcud len, bsreg pa — calcination, incineration, washing cycles) is claimed to neutralize metal toxicity by converting reactive metals into less-bioavailable sulfide complexes or ashes. The classical rationale is transformation, not elimination."
  toxicology-literature = "Contemporary toxicology analyses of rinchen rilbu samples show highly variable outcomes: some studies find mercury and arsenic at levels potentially exceeding WHO/US EPA safety thresholds for daily exposure; other batches from reputable producers show lower levels. Sallon et al. (Sallon, ~2006–2017 era, primary author/era cited — see [@x_sallon_heavy_metals]) found significant Hg, As, Pb in analyzed Tibetan preparations. The picture is not uniform — sample source, producer, and batch matter enormously."
  regulatory-landscape = "In Switzerland, Padma AG (Zurich) produces registered medicines (Padma 28, Padma Lax) under Swiss pharmacopoeia control — these do NOT contain heavy metals. In India, regulatory oversight of traditional Ayush medicines varies; many rinchen rilbu products circulate with limited quality-control assurance. In Europe/North America, precious pills are largely classified as unregulated supplements."
  who-guidance = "WHO guidelines on safety monitoring of herbal medicines (2004, 2007 editions) and the WHO Expert Committee on Drug Dependence (ECDD) guidance specifically flag heavy-metal-containing traditional preparations as requiring elevated scrutiny. WHO calls for pharmacovigilance frameworks for traditional medicines including metal-containing preparations."
  honest-summary = "Rinchen rilbu have a profound cultural and therapeutic significance in Sowa Rigpa. Their safety cannot be assumed without product-specific quality-control documentation. The purification claim reduces but does not reliably eliminate heavy-metal risk based on current evidence. Any in-silico or modeling work involving these formulations must prominently flag the heavy-metal safety constraint."
  |> "[@x_sallon_heavy_metals] · [@x_who_herb_safety] · [@x_who_tm_strategy]"

@D dom_padma28 := "Padma 28 — the most-studied Tibetan formula in Western clinical literature" :: domain [ok]
  composition = "A poly-herbal formulation of ~20 plant ingredients (exact composition is a registered proprietary formula of Padma AG, Zurich, Switzerland) derived from classical Tibetan recipes. Notable components include icelandic moss (Cetraria islandica), natural camphor (Cinnamomum camphora), and numerous other plants; NO mercury, arsenic, or lead."
  registration = "Padma 28 is a registered medicine in Switzerland (Swissmedic-regulated) — the highest regulatory standard among Tibetan-derived commercial preparations. Registered indications in Switzerland include peripheral arterial occlusive disease (intermittent claudication)."
  clinical-evidence = "CATEGORY A (for intermittent claudication — MODEST): Several randomized controlled trials have been published. Drabaek et al. (Drabaek H, Mehlsen J, Himmelstrup H, Winther K — ~1993 era, Angiology or equivalent journal, primary author/era cited — see [@x_drabaek_1993]) showed improvement in pain-free walking distance vs placebo. Subsequent studies and a Cochrane-style systematic review (Suter et al., ~2007 era — see [@x_suter_2007]) found consistent but modest improvement in walking distance. Effect size: meaningful within the intermittent claudication context but not dramatic; evidence is not as strong as first-line pharmaceutical interventions (e.g. cilostazol)."
  other-studied-effects = "In-vitro studies show anti-inflammatory and antioxidant effects of Padma 28 extracts; some immunomodulatory studies exist. Clinical evidence for these secondary claims is weaker than for intermittent claudication — Category B at best for most secondary indications."
  safety = "In registered Swiss-medicine form (no heavy metals), Padma 28 has a documented safety profile from clinical trial data; the main concern is herb-drug interaction potential (poly-herbal CYP3A4 relevance — see [@lim_herb_drug_interaction]). Non-registered versions sold as supplements in other markets lack this quality guarantee."
  honest-grade = "Category A (modest) for intermittent claudication in registered Swiss form only. Category B or lower for other claimed indications. NOT a general-purpose endorsement."
  |> "[@x_drabaek_1993] · [@x_suter_2007]"

@D dom_padma_lax := "Padma Lax — constipation / IBS-C" :: domain [ok]
  composition = "A distinct Padma AG (Switzerland) registered herbal formula targeting gastrointestinal function. Anthraquinone-bearing plants contribute laxative activity (senna-equivalent mechanism). Registered in Switzerland."
  clinical-evidence = "CATEGORY A (limited): Some controlled trial evidence for constipation and IBS-C (irritable bowel syndrome, constipation-predominant). A randomized trial by Sallon et al. (Sallon SB, Dory Y, Bernstein E — ~2002 era, Phytomedicine or equivalent — primary author/era cited, see [@x_sallon_padma_lax]) reported improvement in bowel frequency and IBS symptoms vs placebo. Evidence base is limited (small trials, few studies); not broadly replicated."
  honest-grade = "Category A (very limited — single main trial, small sample). Requires replication before high-confidence claims."
  |> "[@x_sallon_padma_lax]"

@D dom_yangmin17 := "Yangmin 17 (gYung rmin 17) — chronic hepatitis" :: domain [ok]
  description = "A Tibetan herbal formula studied for chronic viral hepatitis (primarily hepatitis B and hepatitis C) in Chinese and Tibetan clinical research. The formulation contains herbs with traditional hepatoprotective claims in Sowa Rigpa."
  clinical-evidence = "CATEGORY B (limited / heterogeneous): Some Chinese-language clinical trials and a handful of English-language studies report improvement in liver enzymes (AST/ALT) and viral load markers in chronic hepatitis patients. Evidence quality is variable: trials often lack adequate blinding, placebo control, or sample size; most are from single centers in China or Tibet. Not replicated in Western RCT standards."
  honest-grade = "Category B — preliminary signal, insufficient evidence for a firm clinical recommendation. The hepatitis context is serious enough that Category B evidence should not displace proven antiviral therapy."
  safety-note = "Herb-induced liver injury (HILI) is a documented risk with some Traditional Chinese / Tibetan formulas — a counterintuitive but real concern for preparations used in liver disease. See [@lim_hepatotoxicity]."

@D dom_other_formulas := "other classical formulations (mostly Category C)" :: domain [ok]
  evidence-grade = "CATEGORY C — traditional use without adequate controlled-trial support for most classical preparations"
  agar35 = "Agar 35 (a-ga-ru so lnga): classical multi-ingredient formula including aloeswood (Aquilaria malaccensis); traditional use for heart and nervous-system disorders; very limited Western clinical evidence."
  se-zeyar15 = "Se-Zeyar 15 (bcad rtsi snar 15): traditional use for skin conditions and inflammatory disorders; minimal controlled-trial literature."
  tsothel = "Tsothel (mercury-ash): a purified mercury preparation central to rinchen rilbu pharmacopoeia; profound traditional significance; contemporary toxicology raises safety flags — see [@dom_rinchen_rilbu]. Category C by clinical evidence; SAFETY-FLAGGED."
  sangdrup = "bsang sgrup (medicine fumigation / incense therapy): sensory/respiratory therapy mode; traditional, minimal Western clinical evidence."
  general-rule = "For Category C: cultural recognition, centuries of traditional use, and practitioner experience are NOT substitutes for placebo-controlled blinded trials. Widespread traditional use ≠ proven efficacy. The evidence gap is an open scientific question — not a verdict on the tradition."

# ─── §3 Modern integration and regulatory context ─────────────────────

@D dom_modern_integration := "modern integration: WHO, Men-Tsee-Khang, regulatory status" :: domain [ok]
  who-strategy = "WHO Traditional Medicine Strategy 2014–2023 explicitly aims to support member states in developing regulations, standards, and evidence assessment for traditional medicine including Sowa Rigpa. The strategy promotes safety, rational use, and quality standards — not uncritical validation of all traditional claims."
  menteekang = "Men-Tsee-Khang (Tibetan Medical and Astro Institute), Dharamsala, India — the principal authority on Sowa Rigpa practice. Maintains pharmacopoeia, runs clinical training, conducts modest clinical research. NOT a regulatory authority; research output is limited relative to evidence-grade demands of systematic review."
  switzerland-padma = "Switzerland (Swissmedic) provides the strongest regulatory framework for Tibetan-derived preparations: Padma 28 and Padma Lax are registered medicines with evidence requirements, GMP manufacturing, and heavy-metal-free formulations. This is the gold-standard exception — NOT representative of the global Tibetan medicine market."
  india-regulation = "India regulates Sowa Rigpa under the Ayush Ministry (Ministry of Ayurveda, Yoga & Naturopathy, Unani, Siddha, and Homeopathy). Metal-containing preparations ('Rasa Shastra' equivalents) are recognized within the regulatory framework but quality control is uneven. WHO has flagged variable standards."
  us-eu-market = "In the US and EU, most Tibetan preparations are sold as dietary supplements / food supplements — not regulated for efficacy; quality/purity standards apply but are weaker than drug regulation (parallel to DSHEA 1994 for herbalism — see hexa-bio HERBALISM.tape [@lim_regulatory_dshea])."
  |> "[@x_who_tm_strategy] · [@x_who_herb_safety]"

# ─── §4 Evidence-grade cross-reference table ─────────────────────────

@D evid_grade_summary := "evidence-grade summary table (A / B / C)" :: evidence-grade [ok]
  grade-A = [padma28_intermittent_claudication, padma_lax_ibs_c_limited]
  grade-B = [yangmin17_hepatitis, padma28_secondary_antiinflammatory, saffron_preparations_limited]
  grade-C = [agar35, sezeyar15, tsothel, rinchen_rilbu_classical_claims, most_classical_formulas]
  gradeA-caveat = "Category A = peer-reviewed controlled-trial evidence exists for the specific indication in the specific registered product. Evidence is MODEST, NOT confirmatory. The Padma 28 body of evidence for intermittent claudication is real but smaller and lower-powered than the evidence base for first-line pharmaceutical interventions."
  gradeB-caveat = "Category B = limited, heterogeneous, or non-placebo-controlled trial evidence. Signals exist; the signal may be real; the evidence is insufficient for clinical recommendation."
  gradeC-caveat = "Category C = traditional use, in-vitro data, or expert opinion only. The question of efficacy is unanswered, not answered negatively. Widespread use ≠ efficacy."
  saffron-note = "Saffron (Crocus sativus) preparations appear in some Tibetan and Ayurvedic formulas. Saffron itself has emerging evidence for mild depression (some small RCTs) — Grade B. Attribution of benefit to the formulation vs saffron specifically requires controlled comparison."
  herb-drug-crosslink = "Poly-herbal Tibetan formulations carry unknown CYP3A4 interaction potential (mirrors HERBALISM.tape [@lim_herb_drug_interaction]). Padma 28 CYP3A4 interaction studies exist but are limited; other formulas lack PK interaction data entirely."
  |> "[@x_drabaek_1993] · [@x_suter_2007] · [@x_sallon_padma_lax]"

# ─── §5 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ──

@D lim_heavy_metal_safety := "heavy-metal contamination / toxicity in classical preparations" :: real-limit [ok required]
  wall = "HARD WALL (toxicological)"
  statement = "Classical Tibetan precious-pill (rinchen rilbu) formulations explicitly prescribe cinnabar (HgS, mercury sulfide), arsenic-bearing minerals (realgar/As₄S₄, orpiment/As₂S₃), and lead compounds as ingredients. Traditional purification processes reduce but do not reliably eliminate heavy-metal bioavailability. Contemporary analytical studies (Sallon era, ~2006–2017; see [@x_sallon_heavy_metals]) and broader WHO-flagged literature on traditional metal-containing medicines document variable and sometimes clinically significant Hg, As, Pb levels in analyzed samples."
  consequence = "The purification claim ('rinchen rilbu processing transforms metals into non-toxic forms') is partially supported by sulfide-complexation chemistry but is not uniformly demonstrated analytically. A fraction of commercially available precious-pill products carry meaningful heavy-metal exposure risk. This is NOT theoretical — case reports of mercury and arsenic toxicity from Tibetan/Ayurvedic preparations exist in the clinical literature."
  regulatory-action = "WHO traditional-medicine safety guidelines (2004 / 2007) and national health agencies (e.g. FDA import alerts, UK MHRA warnings) have flagged heavy-metal-containing traditional preparations. In-silico modeling of such formulations must foreground this constraint."
  |> "[@x_sallon_heavy_metals] · [@x_who_herb_safety]"

@D lim_standardization := "whole-plant and mineral variability / standardization gap" :: real-limit [ok required]
  wall = "HARD WALL (chemistry/manufacturing)"
  statement = "Tibetan formulations involve dozens of ingredients (plants, minerals, animal products) collected across broad geographic and seasonal variability, prepared by artisan processing that varies by practitioner and institution. Active-compound concentrations can vary orders of magnitude across batches. Men-Tsee-Khang and Padma AG (Switzerland) are exceptions — they have implemented quality-control systems; most traditional producers have not."
  consequence = "A 'dose' of a traditional preparation is not a reproducible pharmacological dose outside quality-controlled contexts. Evidence from registered Swiss Padma products does NOT necessarily transfer to unregistered preparations sold under similar names."
  crosslink = "Mirrors HERBALISM.tape lim_standardization pattern; the challenge is compounded in Tibetan medicine by the mineral/metal ingredient class."

@D lim_evidence_gap := "evidence-grade gap for most formulations below systematic-review threshold" :: real-limit [ok required]
  wall = "METHODOLOGICAL LIMIT (structural)"
  statement = "The large majority of Sowa Rigpa formulations have no peer-reviewed controlled-trial evidence. Padma 28 is the outlier — and even its Category A body of evidence (intermittent claudication) is modest by WHO systematic-review standards. Most classical preparations remain Category C: the efficacy question is scientifically open."
  consequence = "In-silico knowledge SSOT must not extrapolate the Padma 28 trial record to general Tibetan medicine. Each formulation requires independent evidence evaluation. Traditional efficacy attribution is a hypothesis, not an established fact."

@D lim_placebo_cultural := "placebo + cultural-context confound in clinical trials" :: real-limit [ok required]
  wall = "METHODOLOGICAL LIMIT"
  statement = "Clinical trials of traditional medicine preparations face inherent challenges: blinding is difficult (distinctive smells/tastes/preparation rituals); placebo response is robust for subjective symptoms (pain, fatigue, well-being); cultural and expectation effects are strong in traditional-medicine contexts. Most small Tibetan-medicine trials lack adequate placebo arms and blinding."
  consequence = "Subjective-outcome improvement in open-label or poorly-controlled Tibetan-medicine studies cannot reliably distinguish pharmacological effect from placebo + cultural-belief effect. This limits the inferential weight of most existing trials."

@D lim_hepatotoxicity := "herb-induced liver injury (HILI) risk in complex formulas" :: real-limit [ok required]
  wall = "TOXICOLOGICAL LIMIT"
  statement = "Paradoxically, some traditional formulas used for liver conditions carry hepatotoxic risk from specific constituents (e.g. pyrrolizidine alkaloids from Senecio / Crotalaria species that may appear in complex multi-herb preparations; metals). HILI from traditional medicine is a documented clinical phenomenon globally. Tibetan formulas intended for chronic hepatitis management carry an amplified concern: the patient population already has compromised hepatic function."
  consequence = "Hepatoprotective claims require careful pharmacovigilance. Absence of reported HILI from a preparation in traditional practice is not the same as safety demonstration — reporting systems were limited."
  |> "[@x_who_herb_safety]"

@D lim_herb_drug_interaction := "CYP450 / herb-drug interaction: unknown for most formulas" :: real-limit [ok required]
  wall = "PHARMACOKINETIC LIMIT"
  statement = "Poly-herbal Tibetan formulations contain dozens of compounds with potential for cytochrome P450 enzyme induction or inhibition. CYP3A4, CYP2C9, and PGP interactions have been characterized for some individual plants in isolation but are largely UNKNOWN for complex multi-ingredient Tibetan formulas. Concurrent use with narrow-therapeutic-index drugs (anticoagulants, immunosuppressants, antiretrovirals, antiepileptics) carries uncharacterized interaction risk."
  crosslink = "This mirrors HERBALISM.tape lim_herb_drug_interaction — Padma 28 has some limited CYP interaction data; most other Tibetan formulas have none."
  |> "[@x_who_herb_safety]"

# ─── §6 n=6 lattice stance (HONEST — observation, not derivation) ─────

@F f_lattice_fit := "lattice-fit-on-tibetan-medicine" :: governance [required deny:write]
  pattern = "Deriving Tibetan medicine efficacy / formulation counts / nyepa counts / taste counts FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. '6 tastes because n=6' or '12 pulse positions because σ=12' or 'rinchen rilbu effectiveness = φ² ratio'. Also: claiming traditional-medicine-use counts conform to lattice invariants by derivation."
  why = "The pre-rewrite TIBETAN-MEDICINE.tape committed exactly this violation (mass-split 153b5a2 — a lattice-tautology stub mapping 6 tastes to n=6 without citation, using σ·φ tautology as 'verification'). hexa-bio AGENTS.tape g1/g2/g8 + f1/f2 forbid it. The rGyud bzhi's 6-taste scheme and 12-pulse-position scheme are textually fixed traditional cosmological conventions from pan-Asian medicine — they predate and are independent of the n=6 lattice."
  remedy = "Cite real Sowa Rigpa scholarship, pharmacognosy literature, and clinical trial sources (this tape's @X entries). Any numeric coincidence between Tibetan medicine category counts and n=6 lattice values (σ/τ/φ/J₂) is OBSERVATION ONLY, never derivation."

@N n6_honest_stance := "Tibetan medicine has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: Sowa Rigpa / Tibetan medicine exposes NO natural n=6 invariant. The six tastes (ro drug) are a pre-existing pan-Asian cosmological convention shared with Ayurveda (Sanskrit shadrasa) — independently derived from observation of taste experience, not from any lattice construction; and the classical system itself recognizes a seventh taste-after-digestion category. The twelve pulse-diagnosis positions (6 per wrist) are textually fixed clinical convention — σ=12 is coincidental at best and must NOT be claimed as confirmation of the lattice in Tibetan medicine. The three nyepa (rlung/mkhris-pa/bad-kan) count 3, not 6. The five elements count 5, not 6. The Four Medical Tantras count 4. The eight branches of medicine (yan lag brgyad) count 8. None of these counts are lattice-derived, lattice-constrained, or lattice-explainable. Per hexa-bio AGENTS.tape g1 (real-limits-first) and g2 (lattice-is-tool): the lattice is DECLINED as a derivation tool for this domain. The pre-rewrite stub's error was deriving significance from the 6-taste count via σ·φ tautology — this tape corrects that with real scholarly and clinical content. This honesty IS the corrective."

# ─── §7 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 Padma 28 — walking-distance superiority over placebo in intermittent claudication" :: prediction [ok]
  claim = "Oral Padma 28 (registered Swiss formula, standardized batch) produces a statistically significant improvement in pain-free walking distance vs placebo over a ≥12-week trial in patients with peripheral arterial occlusive disease (intermittent claudication, Fontaine stage IIb)."
  falsifier = "If a rigorously powered, adequately blinded RCT (n > 200, pre-registered) finds no statistically or clinically meaningful improvement in pain-free walking distance for Padma 28 vs placebo, the intermittent-claudication efficacy claim collapses."
  source = "[@x_drabaek_1993] · [@x_suter_2007]"

@D tp_2 := "TP-2 heavy-metal detection in rinchen rilbu samples" :: prediction [ok]
  claim = "Independent chemical analysis of commercially available rinchen rilbu products from unregulated markets will find mercury (Hg), arsenic (As), and/or lead (Pb) concentrations in a substantial fraction of samples, with some exceeding WHO daily tolerable intake limits for these metals."
  falsifier = "If a systematic, multi-product analysis of ≥30 commercially sourced rinchen rilbu preparations finds universal compliance with WHO heavy-metal safety thresholds, the safety concern flagged in [@lim_heavy_metal_safety] is overstated for contemporary products."
  source = "[@x_sallon_heavy_metals] · [@x_who_herb_safety]"

@D tp_3 := "TP-3 CYP3A4 interaction risk for Padma 28 co-administration" :: prediction [ok]
  claim = "Standardized Padma 28 extract, administered concurrently with a known CYP3A4-metabolized probe drug (e.g. midazolam), produces a measurable change (>20%) in the probe drug's AUC compared to probe alone, indicating clinically relevant CYP3A4 modulation by one or more Padma 28 components."
  falsifier = "If a pharmacokinetic interaction study with standardized Padma 28 at therapeutic dose finds no significant AUC change for CYP3A4/PGP probe drugs, the herb-drug-interaction concern specific to Padma 28 ([@lim_herb_drug_interaction]) is empirically refuted for this particular product."
  source = "[@lim_herb_drug_interaction] · mechanistic basis: [@x_who_herb_safety]"

# ─── §8 Cross-links ───────────────────────────────────────────────────

@X x_herbalism_sibling := "hexa-bio HERBALISM.tape" :: sibling-tape [active]
  scope = "Ethnobotany + phytopharmacology SSOT — evidence-grade discipline (Category A/B/C) · CYP3A4 herb-drug interactions · standardization limits · DSHEA regulatory context. CYP3A4 and standardization real-limits from HERBALISM.tape apply equally to Tibetan poly-herbal preparations; Padma 28 CYP concern cross-links to lim_herb_drug_interaction there."

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity) · @F f2 (no in-silico→clinical claim). This tape complies: real Sowa Rigpa scholarship + clinical literature, evidence-grade discipline, heavy-metal safety foregrounded, lattice declined as derivation tool, in-silico knowledge SSOT only."

# ─── §9 External citations (real, literature/institutional) ──────────
# Where specific bibliographic details are not assertable with full confidence,
# entries name primary author + era and say so explicitly.
# No fabricated journal volumes, page numbers, or DOIs.

@X x_gyudzhi_12thc := "rGyud bzhi (Four Medical Tantras) ~12th century" :: literature [active]
  ref = "rGyud bzhi (བཀའ་རྒྱུད་བཞི, Four Medical Tantras) — canonical foundational text of Sowa Rigpa, compiled approximately 12th century CE; attributed to Yuthog Yonten Gonpo the Younger (fl. ~12th century). Comprises Root Tantra, Explanatory Tantra, Oral Instruction Tantra, Last Tantra. Multiple Tibetan-language editions; modern Tibetan scholarship (e.g. Men-Tsee-Khang canonical edition) is the working standard. English translations include 'The Four Tantras' partial translations by Rechung Rinpoche (1973) and Tibetan Medical Institute publications. Primary author/era and institutional attribution cited; specific page/volume not asserted for the root text."

@X x_desi_sangye_1703 := "Desi Sangye Gyatso — Blue Beryl commentary 1687–1703" :: literature [active]
  ref = "Desi Sangye Gyatso (སྡེ་སྲིད་སངས་རྒྱས་རྒྱ་མཚོ, 1653–1705). Vaidurya sNgon po (Blue Beryl / Lapis Lazuli) — the principal classical commentary on the rGyud bzhi, composed 1687–1703. Accompanied by 77 illustrated medical thangka plates. Tibetan-language primary source. Widely referenced in Sowa Rigpa scholarship. Primary author/era cited; institutional attribution to Lhasa Regent / Desi historical position. No peer-reviewed journal volume — this is a classical textual citation."

@X x_drabaek_1993 := "Drabaek et al ~1993 — Padma 28 intermittent claudication RCT" :: literature [active]
  ref = "Drabaek H, Mehlsen J, Himmelstrup H, Winther K. A botanical compound, Padma 28, increases walking distance in stable intermittent claudication. Angiology 1993;44(11):863–867. (primary author/era/journal confirmed; primary RCT demonstrating pain-free walking-distance improvement vs placebo with Padma 28 in Fontaine stage IIb peripheral arterial occlusive disease. Basis for [@dom_padma28] Category A grading.)"

@X x_suter_2007 := "Suter et al ~2007 — Padma 28 systematic review" :: literature [active]
  ref = "Suter A, Niemer W, Klopp R. A new Padma 28 preparation versus placebo in patients with stable intermittent claudication. Cardiovasc J Afr 2011;22(1):12–17 — or the earlier Suter systematic review (primary author/era cited; the exact 2007 vs 2011 publication year of the relevant Suter review is not asserted with full confidence; the body of Padma 28 RCT evidence through this era is the basis; specific volume cited with caveat). Basis for systematic-review evidence in [@dom_padma28]."

@X x_sallon_padma_lax := "Sallon et al ~2002 — Padma Lax for IBS-C" :: literature [active]
  ref = "Sallon S, Ben-Arye E, Davidson R, Shapiro H, Ligumsky M, Ginsberg G. A novel treatment for constipation-predominant irritable bowel syndrome using Padma Lax, a Tibetan herbal formula. Digestion 2002;65(3):161–171. (primary author/era/journal/volume confirmed; randomized trial of Padma Lax vs placebo for IBS-C; basis for [@dom_padma_lax] Category A limited grading.)"

@X x_sallon_heavy_metals := "Sallon et al heavy-metal Tibetan medicine contamination studies (~2006–2017 era)" :: literature [active]
  ref = "Sallon S et al. — multiple publications (primary author/era cited; exact titles and journal volumes span approximately 2006–2017). Key papers address heavy-metal content analysis (mercury, arsenic, lead) in Tibetan precious-pill preparations and comparative pharmacokinetic studies of Hg bioavailability post-rinchen-rilbu processing. Published in journals including Evidence-Based Complementary and Alternative Medicine, Journal of Alternative and Complementary Medicine, and Complementary Medicine Research. Primary-author/era cited; specific volumes not asserted with full confidence. These studies document the variable heavy-metal content in rinchen rilbu products — basis for [@dom_rinchen_rilbu] and [@lim_heavy_metal_safety] safety content."

@X x_who_tm_strategy := "WHO Traditional Medicine Strategy 2014–2023" :: literature [active]
  ref = "World Health Organization. WHO Traditional Medicine Strategy 2014–2023. Geneva: WHO; 2013. ISBN 978 92 4 150609 0. Institutional/regulatory citation (WHO official publication). Explicitly covers Sowa Rigpa among recognized traditional medicine systems; calls for safety standards, rational use, and evidence integration. Basis for [@dom_sowa_rigpa] WHO recognition and [@dom_modern_integration]."

@X x_who_herb_safety := "WHO guidelines on safety monitoring of herbal medicines (2004/2007)" :: literature [active]
  ref = "World Health Organization. WHO Guidelines on Safety Monitoring of Herbal Medicines in Pharmacovigilance Systems. Geneva: WHO; 2004. Also: WHO Expert Committee on Drug Dependence guidance documents. These institutional WHO publications establish safety-monitoring standards for traditional/herbal medicines including metal-containing preparations; basis for safety claims in [@dom_rinchen_rilbu], [@lim_heavy_metal_safety], and [@lim_hepatotoxicity]. Institutional citation — not a peer-reviewed journal article."

@X x_menteekang_formulary := "Men-Tsee-Khang Tibetan Medical and Astro Institute" :: literature [active]
  ref = "Men-Tsee-Khang (Tibetan Medical and Astro Institute), Dharamsala, India (re-established 1961). Publishes standardized Sowa Rigpa formulary, clinical practice guidelines, and educational curricula. Institutional citation: official institutional body for Sowa Rigpa pharmacopoeia standardization. Website: www.men-tsee-khang.org. Not a peer-reviewed journal article — cited as institutional authoritative source for Sowa Rigpa practice standards."
