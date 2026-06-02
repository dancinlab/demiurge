#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# HORTICULTURE.tape — architecture-current (editable per v1.2)
# Event history → HORTICULTURE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "horticulture" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · horticulture substrate — plant cultivation, propagation, breeding, and postharvest knowledge SSOT"
  brief = "plant propagation · grafting biology · PGRs · greenhouse systems · plant breeding · IPM · postharvest physiology · ornamental horticulture — real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "HORTICULTURE.log.tape"
  scope = "in-silico horticulture knowledge SSOT · NOT horticultural advice / not a cultivation protocol / not a pesticide-use or plant-health regulatory claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see HORTICULTURE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico horticulture substrate. Figures (rooting percentages, ripening timings, postharvest loss estimates) are paraphrased from published horticultural science literature for modeling context ONLY — they are NOT a cultivation protocol, pesticide prescription, or commercial product endorsement. Real horticultural decisions require site-specific assessment, extension specialists, and jurisdiction-specific regulation."

# ── §1 Plant propagation — sexual and asexual methods ────────────────

@D dom_propagation_overview := "plant propagation: sexual vs asexual" :: domain [ok]
  distinction = "Sexual propagation (seed) recombines parental genotypes; used for varietal improvement, rootstock production, and annual crops. Asexual propagation maintains clonal uniformity; essential where heterozygous cultivars must be reproduced true-to-type."
  text = "The mechanistic and practical framework for both modes is codified in the Hartmann & Kester textbook tradition, first published 1959, continuously revised."
  |> "[@x_hartmann_kester]"

@D mech_seed_dormancy := "seed dormancy — scarification and stratification" :: mechanism [ok]
  types = "Physical dormancy: hard seed coat (Fabaceae, Convolvulaceae) blocks water imbibition — broken by mechanical or acid scarification. Physiological dormancy: embryo requires low-temperature after-ripening (cold stratification at 1–5 °C) to complete germination competence — the mechanism in Rosaceae pits and many temperate perennials."
  double-dormancy = "Some species (e.g. Viburnum spp.) have both physical and physiological dormancy — require sequential warm then cold stratification; a real biological complexity, not a lattice-countable number of steps."
  aba-role = "Abscisic acid (ABA) is the primary hormonal enforcer of physiological dormancy (see [@dom_pgr_aba]); stratification promotes its catabolism and shifts the ABA:GA ratio toward germination competence."
  |> "[@x_hartmann_kester] · [@x_bewley_black_1994]"

@D mech_asexual_propagation := "asexual propagation modes" :: mechanism [ok]
  cuttings = "Stem, leaf, and root cuttings — the most widely used clonal method in horticulture. Success depends on auxin (IAA, NAA, IBA) application, wound-induced callus formation, and adventitious root initiation (see [@dom_pgr_auxin])."
  layering = "Air-layering and ground-layering: wound the stem in situ, induce adventitious rooting before severing — used where cuttings are difficult (Ficus, Magnolia, fruit trees)."
  division = "Dividing crowns/rhizomes/tubers — simplest clonal method; standard for herbaceous perennials, ornamental grasses, strawberry runners."
  grafting = "Union of scion (above-ground cultivar) onto rootstock (below-ground system) — see [@mech_grafting] for biology."
  micropropagation = "Tissue culture / in-vitro propagation: explant on defined sterile medium; auxin:cytokinin ratio drives callus, shoot, or root organogenesis (Murashige & Skoog medium, 1962 era). Enables disease-free multiplication at commercial scale (orchids, banana, potato mini-tubers)."
  |> "[@x_hartmann_kester] · [@x_murashige_skoog_1962]"

# ── §2 Grafting biology ───────────────────────────────────────────────

@D mech_grafting := "grafting — rootstock-scion compatibility and dwarfing" :: mechanism [ok]
  union = "Successful grafting requires vascular cambium alignment between scion and rootstock so that callus tissue from both partners bridges the graft interface and differentiates into a continuous vascular system (xylem + phloem). Incompatibility — translocated toxins, lectin mismatches, or graft-transmissible virus — causes delayed failure or chronic decline."
  dwarfing = "Dwarfing apple rootstocks (M.9, M.27 from East Malling/Long Ashton breeding programs, early–mid 20th century) restrict tree size via hormonal (cytokinin/ABA balance) and anatomical root constraints. M.9 is the standard commercial intensive-planting rootstock — yield per hectare greatly exceeds standard (seedling) rootstock trees at the cost of staking and irrigation dependence."
  virus-risk = "Graft incompatibility and virus transmission are the dominant biological risks: propagating from virus-infected scion material spreads vascular-systemic pathogens (apple mosaic virus, plum pox/Sharka) across orchards. Virus indexing of mother plants is standard certification practice."
  ornamental = "Ornamental top-grafting (weeping rose, standard bay laurel, topiary forms) uses rootstock stem height to present scion architecture — the rootstock is a structural platform, not merely a root system."
  |> "[@x_hartmann_kester] · [@x_faust_1994]"

# ── §3 Plant growth regulators (PGRs) ────────────────────────────────

@D dom_pgr_auxin := "auxin (IAA, NAA, IBA) — rooting and tropisms" :: domain [ok]
  endogenous = "Indole-3-acetic acid (IAA) is the primary endogenous auxin; biosynthesised from tryptophan in shoot apices and young leaves, transported basipetally via polar auxin transport carriers (PIN proteins)."
  applications = "Synthetic auxins IBA (indole-3-butyric acid) and NAA (1-naphthaleneacetic acid) are applied as rooting powders/solutions to cuttings to stimulate adventitious root initiation; IBA is the standard commercial rooting hormone because of lower phytotoxicity than NAA at effective concentrations."
  tropisms = "Auxin gradient across root/shoot drives phototropism and gravitropism: high-concentration side elongates (shoot) or inhibits elongation (root) — the Cholodny–Went hypothesis (1920s–1930s era) providing the classical framework."
  |> "[@x_hartmann_kester] · [@x_taiz_zeiger]"

@D dom_pgr_cytokinin := "cytokinins — cell division and shoot induction" :: domain [ok]
  role = "Cytokinins (zeatin, kinetin, 6-BA) promote cell division and lateral bud release; in tissue culture, the cytokinin:auxin ratio determines organogenesis direction: high cytokinin → shoot induction; high auxin → root induction (Skoog & Miller 1957 era)."
  commercial = "6-Benzylaminopurine (6-BA) is widely used in commercial tissue culture and as a fruit-thinning agent (apples, where it can regulate fruit set and return bloom)."
  senescence = "Cytokinins delay leaf senescence — a postharvest application interest (extending cut-flower vase life, leaf-green retention)."
  |> "[@x_taiz_zeiger] · [@x_murashige_skoog_1962]"

@D dom_pgr_gibberellin := "gibberellins — stem elongation and dormancy break" :: domain [ok]
  role = "Gibberellins (GA₃ most commercially used) promote internode elongation, fruit set and parthenocarpy (seedless grape berry enlargement — standard practice in Thompson Seedless/Sultana production), and break seed/bud dormancy."
  barley = "In cereal brewing, GA₃ triggers α-amylase induction in barley endosperm during malting — a commercially important pathway (gibberellin synthesis known from the Gibberella fujikuroi 'foolish seedling' disease characterisation, early-mid 20th century)."
  mechanism = "GAs promote degradation of DELLA repressor proteins via the GID1 receptor → SCF complex ubiquitin pathway; DELLA degradation releases growth-promoting transcription factors."
  |> "[@x_taiz_zeiger]"

@D dom_pgr_ethylene := "ethylene — fruit ripening and senescence" :: domain [ok]
  role = "Ethylene (C₂H₄) is a gaseous hormone triggering fruit ripening (climacteric fruits: apple, banana, tomato — produce an autocatalytic ethylene burst at ripening onset), leaf/petal abscission, and senescence."
  burg-burg = "Burg & Burg (1962 era) established the key role of ethylene in fruit ripening and showed that elevated CO₂ competitively inhibits ethylene action at the receptor level — providing the biochemical rationale for controlled-atmosphere storage."
  biosynthesis = "ACC synthase (ACS) converts SAM to ACC (1-aminocyclopropane-1-carboxylic acid); ACC oxidase converts ACC to ethylene. ACS is the rate-limiting regulated step (IAA, wounding, ripening signals induce ACS transcription)."
  postharvest = "1-MCP (1-methylcyclopropene, SmartFresh) irreversibly binds the ethylene receptor, blocking ethylene response; prolongs postharvest life of climacteric fruit and cut flowers (see [@dom_postharvest_ethylene])."
  |> "[@x_burg_burg_1962] · [@x_taiz_zeiger]"

@D dom_pgr_aba := "abscisic acid (ABA) — stress response and dormancy" :: domain [ok]
  role = "ABA is the primary stress hormone: drought triggers ABA accumulation → stomatal closure (guard-cell K⁺ efflux) → reduced transpiration at the cost of CO₂ limitation. Also enforces seed and bud dormancy (see [@mech_seed_dormancy])."
  signalling = "ABA receptor (PYR/PYL/RCAR) → inhibits PP2C phosphatases → SnRK2 kinases active → stomatal closure and stress-response gene induction. A canonical cascade, not a lattice construct."
  |> "[@x_taiz_zeiger]"

# ── §4 Greenhouse and protected cultivation ───────────────────────────

@D dom_greenhouse := "greenhouse / protected cultivation — environment control" :: domain [ok]
  parameters = "Temperature (day/night DIF for stem elongation management), relative humidity (fungal disease pressure vs transpiration), light (DLI — daily light integral; photoperiod for flowering induction in long-day / short-day crops), CO₂ enrichment (above ambient 400 ppm toward 1000–1500 ppm improves photosynthesis rate in C3 crops — the CO₂ fertilisation effect)."
  high-density = "Vertical / stacked growing systems increase yield per land area at elevated capital and energy cost; viable where land price or arable scarcity justifies it. Labour and energy economics set the real limit (see [@lim_energy_labour])."
  hydroponics = "Soil-less growing in nutrient solution (NFT — nutrient film technique; DWC — deep water culture; substrate-based bag/slab). Decouples nutrition from soil variability; essential for high-value protected crops (tomato, cucumber, pepper, leafy). Cross-link: [@x_urban_farming_crosslink]."
  honesty = "CO₂ enrichment response is a documented agronomic practice; specific optimal set-points vary by crop, season, and system — they are crop-physiology parameters, not lattice-derived values."
  |> "[@x_hanan_1998]"

# ── §5 Plant breeding — hybridization, heterosis, genomic selection ──

@D dom_plant_breeding := "plant breeding — F1 hybridization and heterosis" :: domain [ok]
  hybridization = "F1 hybrid cultivars (first filial generation of defined inbred-line crosses) exploit heterosis (hybrid vigor): F1 often out-performs both parents in yield, uniformity, and/or stress tolerance. The biological basis remains partially debated (dominance complementation, overdominance, epistasis hypotheses) — the phenomenon is empirically reliable even where mechanistic theory is incomplete."
  commercial-scale = "F1 hybrid seed production requires controlled pollination (male sterility systems — CMS in maize/sunflower; self-incompatibility in brassicas; hand emasculation for small-scale). The premium paid for F1 seed reflects this production cost and performance advantage."
  honesty = "Hybrid vigor magnitude varies by cross and trait; it is an empirical outcome of specific crosses, not a predictable lattice product."
  |> "[@x_allard_1960]"

@D dom_mas_genomics := "marker-assisted and genomic selection" :: domain [ok]
  mas = "Marker-assisted selection (MAS): molecular markers (SSR, SNP) linked to QTLs allow selection of target alleles without phenotyping every generation — accelerates introgression of disease-resistance genes, quality traits."
  gs = "Genomic selection (GS, Meuwissen et al 2001 era): whole-genome SNP panels + statistical models (GBLUP, random forest) predict breeding values from marker genotype alone. Greatly accelerates breeding cycle and reduces costly field phenotyping for traits with high marker-to-phenotype predictability."
  limit = "Prediction accuracy depends on training population size and relatedness; rare alleles and major-effect genes require specific approaches (see [@lim_genetic_complexity])."
  |> "[@x_allard_1960] · [@x_meuwissen_2001]"

# ── §6 Integrated pest management (IPM) ──────────────────────────────

@D dom_ipm := "integrated pest management (IPM) — economic thresholds and resistance management" :: domain [ok]
  principle = "IPM combines biological, cultural, physical/mechanical, and chemical tactics. Chemical controls are a last resort, deployed at Economic Threshold (ET) — the pest density at which control cost equals the value of prevented damage (Stern et al 1959 era concept, formalised as economic-injury level and action threshold). Routine prophylactic application is explicitly NOT IPM."
  resistance = "Pesticide/fungicide/herbicide resistance evolves under selection pressure (selection of pre-existing resistance alleles in the pest/pathogen/weed population). Management mandates: rotation of modes of action, refuge areas for Bt-transgenic crops, mixture strategies. Resistance is a real evolutionary constraint with no technical override."
  biocontrol = "Biological control: introduction/conservation of natural enemies (predators, parasitoids, entomopathogenic fungi/nematodes). Most effective as suppression within an IPM system; rarely eliminates pests entirely from open systems."
  resistant-cultivars = "Host-plant resistance remains the most durable and economical long-term pest/disease management tool; resistance genes (R genes for pathogen ETI; QTL pyramiding for quantitative resistance) are central to breeding programs."
  cross-link = "Economic-threshold framework shared with [@x_agriculture_ipm_crosslink] (AGRICULTURE.tape IPM)."
  |> "[@x_stern_1959] · [@x_flint_roberts_2009]"

# ── §7 Postharvest physiology ─────────────────────────────────────────

@D dom_postharvest := "postharvest physiology — cold chain and ethylene management" :: domain [ok]
  losses = "FAO estimates postharvest losses of fruits and vegetables at roughly 30–40% of production in developing countries, declining to roughly 10–15% in developed economies with cold-chain infrastructure — a documented food-system inefficiency, not a lattice ratio. Exact figures vary by commodity, season, and source."
  cold-chain = "Refrigeration (temperature management) and modified/controlled atmosphere (CA — reduced O₂, elevated CO₂, controlled ethylene) are the primary postharvest tools. Cold slows respiration, ethylene production, microbial growth, and enzymatic browning."
  ethylene-climacteric = "Climacteric fruits (banana, apple, tomato, mango, avocado) have an autocatalytic ethylene burst at ripening onset; non-climacteric fruits (citrus, strawberry, grape) do not. This binary is biologically established, not a lattice classification."
  |> "[@x_burg_burg_1962] · [@x_kader_2002]"

@D dom_postharvest_ethylene := "1-MCP (SmartFresh) — ethylene receptor inhibition" :: domain [ok]
  mechanism = "1-MCP (1-methylcyclopropene) binds irreversibly to ethylene receptors (ETR1/ERS family) before ethylene can bind — blocks downstream ripening/senescence signalling. Applied as a gas in sealed rooms after harvest."
  effect = "Significantly extends storage life of apples, pears, kiwifruit, and cut flowers; delay in softening, colour change, and respiration rate increase. Commercial registration by regulatory agencies (EPA, EU) is commodity- and market-specific."
  limits = "1-MCP does not halt all postharvest processes; treatment window (timing after harvest) and temperature during treatment affect efficacy. Does not reverse ripening already initiated."
  honesty = "SmartFresh is a commercial product (AgroFresh); regulatory status varies by country and commodity — this tape records the mechanism and general application, not regulatory approval details. Author/era: technology developed ~1990s, commercial launch early 2000s."
  |> "[@x_blankenship_dole_2003] · [@x_kader_2002]"

# ── §8 Ornamental horticulture and landscape design ──────────────────

@D dom_ornamental := "ornamental horticulture — design and plant selection" :: domain [ok]
  scope = "Ornamental horticulture encompasses cut-flower production, potted-plant production, nursery stock (trees/shrubs), and designed landscapes. Value is aesthetic and functional (urban green infrastructure, biodiversity corridors, human wellbeing)."
  photoperiod = "Many ornamental crops are photoperiod-sensitive: chrysanthemums and poinsettias require short-day conditions (long night) for flower induction; many summer-flowering plants require long days. Greenhouse production manipulates day length artificially (blackout curtains, supplemental lighting) to regulate timing."
  breeding-targets = "Ornamental breeding targets flower colour (anthocyanin/carotenoid/flavonoid pathways), form, fragrance, cut-flower vase life, pot-plant compactness (dwarfing PGR response), and disease resistance."
  honesty = "Ornamental plant taxonomy is enormously diverse; this entry records the structural principles of the sub-sector, not a lattice-ordered classification of genera."
  |> "[@x_broschat_donselman_1983_era]"

# ── §9 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_rootstock_scion_compatibility := "rootstock-scion compatibility — hard biological wall" :: real-limit [ok required]
  wall = "HARD WALL (biological/vascular)"
  statement = "Grafting success requires close phylogenetic affinity (typically intraspecific or within a genus for most crops) and compatible vascular-cambium chemistry. Incompatibility across family or class boundaries is absolute — no technique overcomes fundamental incompatibility."
  consequence = "Rootstock availability constrains which dwarfing/resistance/adaptation traits can be combined with any given scion cultivar; incompatibility cannot be engineered away with standard propagation techniques."
  |> "[@x_hartmann_kester] · [@x_faust_1994]"

@D lim_pesticide_resistance := "pesticide resistance evolution — inevitable under selection pressure" :: real-limit [ok required]
  wall = "HARD WALL (evolutionary)"
  statement = "Repeated use of a single pesticide mode of action selects for resistant genotypes in pest/pathogen/weed populations. Resistance evolution is certain given sufficient selection pressure and standing variation or mutation supply — it is a real evolutionary constraint, not an engineering failure. No pesticide chemistry permanently avoids it."
  consequence = "Effective IPM requires resistance management (rotation of modes of action, refuge strategies, threshold-based application) as a core structural requirement, not an optional add-on."
  |> "[@x_stern_1959] · [@x_flint_roberts_2009]"

@D lim_postharvest_losses := "postharvest losses — thermodynamic and logistical constraint" :: real-limit [ok required]
  wall = "SOFT WALL (reducible but not eliminable)"
  statement = "Biological material continues to respire, transpire, and decay after harvest. FAO reports roughly 30–40% postharvest losses of fruit and vegetables in developing-world supply chains. Cold-chain investment reduces but cannot eliminate losses (transport damage, pathogen entry at any wound, overripe window). Zero loss is a thermodynamic impossibility for living tissue."
  consequence = "Postharvest-loss reduction is a finite engineering/logistics challenge bounded by biology; it informs system design priorities but is not a lattice-derivable efficiency."
  |> "[@x_kader_2002]"

@D lim_water_labour_economics := "water and labour economics — variable but real limits" :: real-limit [ok required]
  wall = "SOFT WALL (economic/resource)"
  statement = "High-value protected horticulture (greenhouse, vertical farm) consumes disproportionate water and labour relative to field production. Water availability (especially in arid regions) and labour cost (especially for hand-harvested crops) set the economic viability ceiling that no technology fully removes."
  consequence = "Automation and water recycling improve efficiency; fundamental crop-biology constraints on handling (soft fruit bruising, size variability) resist full automation. Economics vary by region, commodity, and labour market."

@D lim_genetic_complexity := "genetic complexity of horticultural traits — polygenic and environment-sensitive" :: real-limit [ok required]
  wall = "SOFT WALL (biological)"
  statement = "Most economically important horticultural traits (yield, flavour, shelf life, disease resistance) are polygenic and subject to significant genotype × environment (G×E) interaction. Marker-assisted and genomic selection improve but do not eliminate the need for multi-environment trial validation; prediction accuracy decays for untested environments or diverse genetic backgrounds."
  consequence = "Breeding gains are real and accelerating but remain constrained by trait architecture, G×E unpredictability, and the biological reproductive cycle of the crop — not by any lattice ceiling."
  |> "[@x_allard_1960] · [@x_meuwissen_2001]"

# ── §10 n=6 lattice stance (HONEST — observation, not derivation) ─────

@F f_lattice_fit := "lattice-fit-on-horticulture" :: governance [required deny:write]
  pattern = "Deriving horticultural quantities (propagation percentages, postharvest loss ratios, grafting success rates, IPM economic thresholds, plant-growth counts, PGR concentrations) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. '24 hours = J₂ optimum post-treatment window' or '6 propagation modes = n=6' or '50% cost reduction = 1/φ'."
  why = "This is exactly the fabrication the pre-rewrite HORTICULTURE.tape committed (BT-429–433 'n=6 EXACT' derivations, row_x_* performance tables with 'σ-φ', '1/(σ-φ)=90%' etc. — see HORTICULTURE.log.tape audit). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real horticultural science sources (this tape's @X entries). Stoichiometric/biological numbers (C₆H₁₂O₆ in photosynthesis, 4 seasons, 5 classical plant hormones) are domain biology/chemistry — the lattice may only be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "horticulture has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: horticulture exposes NO natural n=6 invariant. Plant propagation modes (seed, cuttings, layering, division, grafting, micropropagation — coincidentally six, but this is a biological/historical classification count, not lattice-derived). The five classical plant hormones (5, not 6). Norwood-like staging of ornamental or agronomic traits uses crop-biology ordinals. IPM economic thresholds are pest-density/economics values. Postharvest loss percentages are FAO survey estimates. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. The coincidental '6' in propagation-mode enumeration is an OBSERVATION ONLY — plant biologists and horticulturalists did not count to six to match the lattice. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §11 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 IBA rooting response" :: prediction [ok]
  claim = "IBA-treated stem cuttings of recalcitrant-rooting woody species will exhibit significantly higher adventitious-root initiation frequency than untreated controls within a standard rooting protocol."
  falsifier = "If a properly controlled RCT with recalcitrant species shows IBA treatment produces no measurable difference in rooting percentage vs control, [@mech_asexual_propagation] auxin-rooting mechanism is wrong for that species class."
  source = "[@x_hartmann_kester]"

@D tp_2 := "TP-2 ethylene-1-MCP postharvest extension" :: prediction [ok]
  claim = "1-MCP application to climacteric fruit (apple, banana) immediately post-harvest extends time-to-unacceptable softening relative to untreated cold-stored controls under identical conditions."
  falsifier = "If blinded sensory + firmness panel on commercially representative lots shows no difference between 1-MCP-treated and control fruit at equivalent storage duration, [@dom_postharvest_ethylene] mechanism is wrong."
  source = "[@x_blankenship_dole_2003] · [@x_burg_burg_1962]"

@D tp_3 := "TP-3 IPM economic threshold" :: prediction [ok]
  claim = "In a well-designed IPM field study, applying insecticide only above the established economic threshold results in comparable or greater net return than routine calendar spray programmes, at lower pesticide input and equivalent or lower crop damage."
  falsifier = "If a replicated controlled field comparison shows threshold-based IPM consistently yields lower net return than calendar spraying across multiple seasons, the economic-threshold framework ([@dom_ipm]) is invalid in that system."
  source = "[@x_stern_1959] · [@x_flint_roberts_2009]"

# ── §12 Cross-links ───────────────────────────────────────────────────

@X x_agriculture_ipm_crosslink := "AGRICULTURE.tape — IPM and crop-science cross-link" :: sibling-tape [active]
  scope = "Economic-threshold framework (Stern 1959 era shared foundation), nitrogen cycling, soil science — overlapping IPM/agronomy substrate in hexa-bio"

@X x_urban_farming_crosslink := "URBAN-FARMING.tape — hydroponics / vertical systems" :: sibling-tape [active]
  scope = "Hydroponic and vertical growing systems that appear in both horticulture ([@dom_greenhouse]) and urban farming contexts"

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real horticultural science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §13 External citations (real, landmark literature) ───────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_hartmann_kester := "Hartmann & Kester — Plant Propagation: Principles and Practices" :: literature [active]
  ref = "Hudson T. Hartmann & Dale E. Kester — Plant Propagation: Principles and Practices. Prentice-Hall, first edition 1959; multiple subsequent editions (currently through 8th ed., Hartmann, Kester, Davies & Geneve). The standard reference text for sexual and asexual propagation biology across horticultural crops. Primary authors/textbook era cited; specific edition not asserted."

@X x_bewley_black_1994 := "Bewley & Black — Seeds: Physiology of Development and Germination" :: literature [active]
  ref = "J. Derek Bewley & Michael Black — Seeds: Physiology of Development and Germination (2nd ed., Plenum Press, 1994). Standard reference for seed dormancy mechanisms (physical, physiological, double) and ABA/GA hormonal control of germination competence."

@X x_murashige_skoog_1962 := "Murashige & Skoog 1962" :: literature [active]
  ref = "Murashige T, Skoog F. A revised medium for rapid growth and bio assays with tobacco tissue cultures. Physiol Plant 1962;15:473–497. (MS medium — the foundational plant tissue-culture medium formulation; defines standard mineral-salt composition used across micropropagation)"

@X x_taiz_zeiger := "Taiz & Zeiger — Plant Physiology" :: literature [active]
  ref = "Lincoln Taiz & Eduardo Zeiger — Plant Physiology (multiple editions from 1991 onward; 6th ed. Taiz, Zeiger, Moller & Murphy, 2015). Canonical plant physiology reference covering auxin, cytokinin, gibberellin, ABA, ethylene signalling, stomatal physiology, and photomorphogenesis. Primary authors/textbook era cited; specific edition not asserted."

@X x_faust_1994 := "Faust 1989/1994 — Physiology of Temperate Zone Fruit Trees" :: literature [active]
  ref = "Miklos Faust — Physiology of Temperate Zone Fruit Trees (Wiley, 1989; revised era ~1994). Covers dwarfing rootstock physiology and grafting compatibility for Malus, Pyrus, Prunus. Primary author/era cited; exact bibliographic details not asserted beyond textbook title."

@X x_burg_burg_1962 := "Burg & Burg (ethylene / fruit ripening, ~1962)" :: literature [active]
  ref = "S.P. Burg & E.A. Burg — key ethylene-in-fruit-ripening characterisation work, early 1960s era. Established ethylene as a ripening hormone and the CO₂ competitive-inhibition basis for controlled-atmosphere storage. Primary author/era cited; exact journal/volume not asserted — well-established literature landmark in postharvest physiology."

@X x_stern_1959 := "Stern et al (economic-threshold / IPM concept, ~1959)" :: literature [active]
  ref = "V.M. Stern, R.F. Smith, R. van den Bosch, K.S. Hagen — 'The integrated control concept.' Hilgardia 1959;29:81–101. Established the economic-injury level / economic-threshold framework that underlies modern IPM. (Primary author/era cited; standard IPM foundation reference.)"

@X x_flint_roberts_2009 := "Flint & Roberts — IPM for Agronomy" :: literature [active]
  ref = "Mary Louise Flint & Steve H. Dreistadt (various Flint-era UC IPM guides) / Roberts / UCIPM Program — Integrated Pest Management for major crops. Primary author/era cited; exact volume not asserted. Basis for biological control, resistance management, and threshold-based application concepts in [@dom_ipm]."

@X x_hanan_1998 := "Hanan — Greenhouses: Advanced Technology for Protected Horticulture" :: literature [active]
  ref = "Joe J. Hanan — Greenhouses: Advanced Technology for Protected Horticulture. CRC Press, 1998. Reference for greenhouse environment management: temperature, humidity, CO₂ enrichment, lighting, hydroponics. Primary author/title/era cited."

@X x_allard_1960 := "Allard — Principles of Plant Breeding" :: literature [active]
  ref = "R.W. Allard — Principles of Plant Breeding. Wiley, 1960 (1st ed.; subsequent editions). Foundational plant breeding textbook covering hybridization, heterosis, selection theory, and quantitative genetics. Primary author/era cited."

@X x_meuwissen_2001 := "Meuwissen, Hayes & Goddard 2001" :: literature [active]
  ref = "Meuwissen THE, Hayes BJ, Goddard ME. Prediction of total genetic value using genome-wide dense marker maps. Genetics 2001;157:1819–1829. (founding paper for genomic selection methodology — GBLUP / whole-genome marker prediction of breeding values)"

@X x_kader_2002 := "Kader — Postharvest Technology of Horticultural Crops" :: literature [active]
  ref = "Adel A. Kader (ed.) — Postharvest Technology of Horticultural Crops (3rd ed., UC ANR Publication 3311, 2002). Standard postharvest reference for CA storage, ethylene management, commodity-specific guidelines, and FAO-era loss estimates. Primary editor/edition/era cited."

@X x_blankenship_dole_2003 := "Blankenship & Dole 2003" :: literature [active]
  ref = "Blankenship SM, Dole JM. 1-Methylcyclopropene: a review. Postharvest Biology and Technology 2003;28:1–25. (1-MCP mechanism, efficacy, commodity applications, and regulatory status review)"

@X x_broschat_donselman_1983_era := "ornamental horticulture — photoperiod and floriculture (author/era)" :: literature [active]
  ref = "Ornamental horticulture photoperiodism literature: Broschat TK, Donselman H (Florida era, ~1983 onward) and the broader floriculture photoperiod tradition (Garner & Allard photoperiodism discovery 1920 era; Cathey PGR dwarfing / Florel ethephon era 1960s–1970s). Primary author/era cited for the general floriculture-management literature; specific volume not asserted."
