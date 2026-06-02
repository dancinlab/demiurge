#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# APICULTURE.tape — architecture-current (editable per v1.2)
# Event history → APICULTURE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "apiculture" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · apiculture substrate — honey bee biology + colony ecology knowledge SSOT"
  brief = "Apis mellifera biology · dance language · honeycomb geometry · pollination ecology · colony health (Varroa/CCD) — real-limits anchored · n=6 NOT used as a derivation (honest); honeycomb hexagonal cells are geometric (close-packing, Hales 1999), not lattice-derived"
  parent = "dancinlab/hexa-bio"
  sibling-log = "APICULTURE.log.tape"
  scope = "in-silico knowledge SSOT · NOT agronomic/veterinary advice / not a beekeeping protocol / not a pesticide-use or veterinary-treatment claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see APICULTURE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico apiculture substrate. Figures (colony losses, honey yield ranges, Varroa thresholds) are paraphrased from published entomology/ecology literature for modeling context ONLY — they are NOT a beekeeping management protocol, veterinary prescription, pesticide-use guidance, or regulatory claim. Real hive decisions require local expertise and jurisdiction-specific regulation."

# ── §1 Honey bee biology — Apis mellifera ─────────────────────────────

@D dom_apis_mellifera := "Apis mellifera — the Western honey bee" :: domain [ok]
  taxonomy = "Order Hymenoptera, family Apidae, genus Apis. A. mellifera is the globally dominant managed pollinator species, native to Europe/Africa/western Asia, now worldwide via human introduction."
  eusociality = "Superorganism with reproductive division of labour (eusociality): overlapping generations, cooperative brood care, and reproductive specialisation into castes — a defining trait of the order Hymenoptera, not a lattice value."
  colony-size = "A productive colony holds roughly 40,000–80,000 workers in peak summer; winter cluster drops to 10,000–20,000 or fewer. These are biological ranges set by colony dynamics, not fixed constants."
  products = "Honey (concentrated nectar, enzymatically converted + water-reduced to <20% moisture); beeswax; pollen; propolis; royal jelly."
  honesty = "Colony sizes and yield ranges are reported from apiculture literature as approximate empirical ranges, not lattice-derived constants."
  |> "[@x_winston_1987]"

@D dom_castes := "caste system — queen, worker, drone" :: domain [ok]
  queen = "Single reproductive female per colony; lays 1,000–2,000 eggs per day at peak; mated once in a nuptial flight with 10–20 drones; sperm stored in spermatheca for 2–5 year laying lifespan. Caste determination is nutritional (royal jelly quantity/composition), not genetic — same diploid genome as workers."
  worker = "Sterile diploid female; ~40,000–80,000 per colony at peak; age-based (temporal) polyethism: brood-nursing → wax-building → guarding → foraging. Lifespan ~6 weeks in summer, months in winter cluster."
  drone = "Unfertilised (haploid) male; sole reproductive function — mating with virgin queens from other colonies; expelled in autumn and dies. No sting, no wax/propolis production."
  polyethism = "Task-switching by workers follows a glandular-age programme, not a rigid schedule. Hemolymph JH (juvenile hormone) titre correlates with forager transition."
  caste-count = "Three castes — a fact of bee biology. Not a τ(6)=3 derivation; the number is what it is."
  |> "[@x_winston_1987] · [@x_seeley_2010]"

@D mech_swarming := "swarming, queen supersedure, absconding" :: mechanism [ok]
  swarming = "Primary reproduction mode of the colony: when colony grows too crowded in spring, the old queen departs with roughly half the workers to found a new colony. Rests in a temporary cluster while scouts locate a cavity."
  queen-mating = "Virgin queen performs 1–2 nuptial (mating) flights; mates with 10–20 drones in mid-air at drone congregation areas (DCAs). Polyandry increases genetic diversity within the worker force, correlated with colony fitness."
  supersedure = "Colony replaces an ageing or failing queen by rearing a new one in a queen cell; the old queen is usually killed by the new queen's workers after the new queen is accepted."
  absconding = "Entire colony abandons the hive in response to severe stress (pest pressure, food shortage, disease) — common in A. mellifera scutellata (African bee); rarer in European strains."
  |> "[@x_seeley_2010] · [@x_winston_1987]"

# ── §2 Dance language (von Frisch 1973 Nobel) ─────────────────────────

@D dom_dance_language := "dance language — round dance and waggle dance" :: domain [ok]
  discovery = "Karl von Frisch decoded honey-bee dance communication over decades of work, rewarded with the 1973 Nobel Prize in Physiology or Medicine (shared with Lorenz and Tinbergen). His key monograph ([@x_vonfrisch_1967]) remains the primary reference."
  round-dance = "Used for food sources close to the hive (generally <100 m). The forager circles repeatedly, stimulating recruits but giving no precise directional information."
  waggle-dance = "Used for food sources farther away. The waggle run's duration encodes distance; its angle relative to vertical gravity (on the comb) encodes direction relative to the sun azimuth. A 'dance dialect' — populations differ in the distance-to-waggle-run-duration calibration."
  debate = "The dance-language hypothesis was contested by Wenner and others (odour-cue alternative hypothesis) through the 1970s. Subsequent rigorous experiments (including radar-tracking of recruits directed by dancers to novel locations) substantially vindicated von Frisch's interpretation, though odour cues also play a role."
  honesty = "Dance-language details are cited from von Frisch's own monograph and subsequent literature; the directional encoding is the landmark finding, not a derivation."
  |> "[@x_vonfrisch_1967]"

# ── §3 Honeycomb geometry — Hales 1999, NOT lattice ───────────────────

@D dom_honeycomb_geometry := "honeycomb hexagonal cells — geometric, not lattice-derived" :: domain [ok]
  structure = "Worker honey bees construct cells with regular hexagonal cross-section arranged in a flat comb; two layers of cells back-to-back, tilted slightly upward (~13°) to retain honey."
  geometry-why = "Hexagonal tiling of the plane by equal-area cells minimises the total perimeter of cell walls per unit area — thus minimises wax cost per unit storage volume. This is the Honeycomb Conjecture, proven rigorously by Thomas Hales in 1999."
  hales-proof = "Hales proved that the regular hexagonal tiling uniquely minimises the boundary length enclosing a given area in the Euclidean plane, among all tilings by equal-area regions. This is a geometric/mathematical result, not a lattice identity."
  not-lattice = "The hexagonal geometry of comb cells derives from geometric close-packing optimality, NOT from the n=6 lattice (σ=12, τ=4, φ=2, J₂=24). Six-sidedness here is Euclidean geometry — the number 6 emerges from the fact that 6 equilateral triangles tile around a point. This is OBSERVATION that honeycomb cells happen to have 6 sides; it is emphatically NOT a derivation from the σ/τ/φ/J₂ invariants."
  wax-cost = "A worker bee consumes roughly 6–8 kg of honey to metabolically produce 1 kg of wax (energetically expensive) — a real bioenergetic figure from apiculture literature, not a lattice ratio. The exact conversion varies; the range is an empirical estimate."
  |> "[@x_hales_1999]"

# ── §4 Pollination ecology & economic value ────────────────────────────

@D dom_pollination := "pollination ecology and managed pollinators" :: domain [ok]
  mechanism = "Honey bees pollinate flowers by transferring pollen between anthers and stigmas while foraging for nectar and pollen. Cross-pollination enables seed/fruit set in the majority of flowering plant species."
  crop-dependence = "Klein et al 2007 ([@x_klein_2007]) estimated that ~75% of leading global food-crop types (by number) depend on animal pollination to some degree for fruit/seed set; however these crops represent a lower fraction of caloric production (staple cereals are wind-pollinated). The per-crop dependence ranges from fully animal-pollinated (almonds, many fruits) to partially (rapeseed, sunflower) to none (wheat, rice, maize)."
  economic-value = "Calderone 2012 ([@x_calderone_2012]) estimated the US crop value attributable to managed honey-bee pollination at roughly $14.6 billion per year (US-level; 2009 prices). Global-level estimates are higher but contested in methodology."
  honesty = "Economic-value figures are US-centric and year-specific; global extrapolations vary widely by study. The Klein et al figure (75% of crop types) is widely cited but refers to crop type count, not caloric share — an important distinction."
  |> "[@x_klein_2007] · [@x_calderone_2012]"

# ── §5 Colony health — Varroa, DWV, Nosema, pesticides ───────────────

@D dom_varroa := "Varroa destructor — the primary honey bee mite parasite" :: domain [ok]
  biology = "Varroa destructor (Acari: Varroidae) is an ectoparasite of Apis mellifera, originally a parasite of the Eastern honey bee A. cerana. Host-switch to A. mellifera occurred when European beekeepers introduced A. mellifera to Southeast Asia; V. destructor then spread globally through managed bee movement."
  reproduction = "Mite reproduces only in sealed brood cells; foundress female enters a cell shortly before capping, lays eggs on the developing larva/pupa. Drone brood is preferred (longer capping period allows more reproductive cycles)."
  DWV-axis = "V. destructor vectors Deformed Wing Virus (DWV), a picornavirus family member. Mite feeding on hemolymph suppresses bee immune function and facilitates high DWV viral titres → bees emerge with deformed wings, shortened lifespan, impaired navigation. DWV is the primary proximate cause of colony collapse in heavily Varroa-infested colonies."
  treatment = "Oxalic acid, synthetic acaricides (amitraz, tau-fluvalinate, coumaphos) can reduce mite loads — but resistance has evolved to some synthetic compounds. IPM approaches combine monitoring, threshold-based treatment, and selecting for hygienic/Varroa-sensitive hygiene (VSH) traits."
  |> "[@x_rosenkranz_2010]"

@D dom_nosema := "Nosema — microsporidian gut pathogen" :: domain [ok]
  species = "Nosema apis (classical, European bee disease) and N. ceranae (more virulent, originally from A. cerana, now globally dominant in A. mellifera). Both are microsporidia — intracellular fungi-related obligate parasites of midgut epithelial cells."
  effects = "Disrupts digestive function; shortens worker lifespan; reduces colony population and honey production in spring. N. ceranae infection can be asymptomatic at low load but has been associated with sudden colony collapse at high infestation."
  treatment = "Fumagillin historically used (banned in several jurisdictions); current focus on IPM (spring colony stimulation, requeening)."
  |> "[@x_higes_2009]"

@D dom_pesticides := "pesticide stress — neonicotinoids and sublethal effects" :: domain [ok]
  neonicotinoids = "Systemic insecticides (imidacloprid, clothianidin, thiamethoxam) applied to seeds or soil are taken up by plants and appear in nectar/pollen at sublethal concentrations for bees."
  henry_2012 = "Henry et al 2012 ([@x_henry_2012]) used a radio-frequency identification (RFID) tagging experiment to show that field-realistic sublethal imidacloprid exposure significantly impaired honey-bee homing/navigation, causing a 2–3× increase in homing failure — a landmark ecotoxicology result."
  sublethal-effects = "Sublethal neonicotinoid exposure impairs learning and memory (olfactory conditioning), foraging efficiency, colony thermoregulation, and immune function — individually sub-lethal but cumulatively stressful."
  regulatory = "The European Union restricted outdoor use of three neonicotinoids (imidacloprid, clothianidin, thiamethoxam) for bee-relevant crops in 2018, citing pollinator risk. Regulatory status varies by jurisdiction."
  honesty = "Causation and magnitude of field-level colony impact from neonicotinoids remains an active scientific and regulatory debate; Henry 2012 is a landmark experiment, not a settled consensus figure."
  |> "[@x_henry_2012]"

# ── §6 Colony Collapse Disorder (CCD) ────────────────────────────────

@D dom_ccd := "Colony Collapse Disorder — multifactorial syndrome" :: domain [ok]
  definition = "CCD: a syndrome in which the majority of adult worker bees in a colony disappear, leaving behind a queen, capped brood, and food stores but almost no dead bee bodies (workers disappear rather than dying in the hive). First widely reported in the US in 2006–2007."
  vanEngelsdorp = "vanEngelsdorp and colleagues published foundational surveillance-level characterisations of CCD in 2009–2010 ([@x_vanengelsdorp_2009]). The syndrome had no single identified cause in early studies."
  multi-factor = "Goulson et al 2015 ([@x_goulson_2015]) synthesised the evidence across factors: Varroa + DWV, Nosema, pesticides (especially neonicotinoids), habitat/nutritional stress (monoculture, lost floral diversity), and pathogens all contribute — no single silver-bullet cause has been established. The consensus view is multifactorial."
  status = "CCD-type losses declined in media prominence post-2013 while colony-level annual loss rates remained elevated in the US (~30–45% annual losses reported in USDA/Bee Informed surveys), suggesting underlying pressure continued under different loss patterns."
  honesty = "The causality of CCD remains contested; the multifactorial hypothesis is the current scientific consensus but no controlled experiment has replicated the full syndrome. Loss rate figures are from US survey data and are year/region-variable."
  |> "[@x_vanengelsdorp_2009] · [@x_goulson_2015]"

# ── §7 Pollinator decline (broader context) ───────────────────────────

@D dom_pollinator_decline := "insect biomass decline and pollinator context" :: domain [ok]
  hallmann_2017 = "Hallmann et al 2017 ([@x_hallmann_2017]) reported a >75% decline in total flying insect biomass over 27 years in German protected areas, representing a major biodiversity finding. This is broader than honey bees — it encompasses the full flying-insect community (wild pollinators, predatory insects, etc.)."
  wild-pollinators = "Wild pollinators (bumblebees, solitary bees, hoverflies, butterflies) contribute substantially to crop and wild-plant pollination, often more effectively per individual than honey bees. Their populations face overlapping pressures: habitat loss, pesticides, disease spillover from managed bees, climate change."
  managed-vs-wild = "Managed honey-bee colony numbers globally have increased over the past 50 years (due to agricultural expansion), masking declines in wild pollinators. The colony-number increase does not substitute for functional wild-pollinator community loss."
  |> "[@x_hallmann_2017]"

# ── §8 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_varroa := "Varroa-DWV pressure — HARD WALL on Western honey bee colony survival" :: real-limit [ok required]
  wall = "HARD WALL (parasitism + viral amplification)"
  statement = "Without active mite management, V. destructor populations grow exponentially within a colony (reproductive rate ~2.6-fold per brood cycle under permissive conditions). DWV viral loads track mite load. Unmanaged colonies in temperate climates typically collapse within 1–3 years. There is no self-resolving immunity at the colony level in A. mellifera comparable to A. cerana."
  consequence = "Commercial apiculture requires ongoing, active Varroa management; there is no set-and-forget solution. Resistance to synthetic acaricides is an additional escalating constraint."
  |> "[@x_rosenkranz_2010]"

@D lim_neonicotinoid := "neonicotinoid sublethal stress — navigation and homing impairment" :: real-limit [ok required]
  wall = "SOFT WALL (agricultural landscape exposure)"
  statement = "Field-realistic sublethal neonicotinoid exposure significantly impairs honey-bee navigation/homing (Henry 2012), reducing forager return rates. The impairment is not lethal at the individual level but causes colony-level forager attrition when foraging pressure is high."
  consequence = "In intensively managed agricultural landscapes, neonicotinoid exposure is a persistent background stressor that interacts with Varroa and nutritional stress — contributing to the multifactorial colony loss pattern. No single threshold is universally agreed."
  |> "[@x_henry_2012]"

@D lim_ccd_multifactorial := "CCD — no single-cause model; multifactorial causation" :: real-limit [ok required]
  wall = "STRUCTURAL LIMIT (complex systems — multi-driver)"
  statement = "Colony Collapse Disorder has no single identified cause. Every proposed monocausal model (neonicotinoids alone, Nosema alone, virus alone) has failed to explain the full syndrome in controlled conditions. The interacting drivers (Varroa/DWV, Nosema, pesticides, nutritional stress, habitat loss) make prediction from a single variable unreliable."
  consequence = "Mitigation requires multi-stressor management, not a single intervention. Any model that claims a single predictor for CCD is likely to fail out-of-sample."
  |> "[@x_goulson_2015] · [@x_vanengelsdorp_2009]"

@D lim_pollinator_habitat := "pollinator habitat and nectar-flow timing mismatch" :: real-limit [ok required]
  wall = "SOFT WALL (landscape/climate)"
  statement = "Honey bee and wild pollinator colonies depend on continuous nectar and pollen flow through the season. Agricultural monocultures produce brief intense bloom periods followed by dearth. Climate change is shifting the timing of plant flowering (phenology) and bee emergence/foraging windows — creating mismatches in some regions."
  consequence = "Nutritional stress from dearth periods weakens colonies independently of disease pressure; a colony entering Varroa or winter stress in poor nutritional condition has lower resilience. No lattice constant describes the mismatch window — it is climate/landscape-specific."
  |> "[@x_hallmann_2017] · [@x_goulson_2015]"

# ── §9 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-apiculture" :: governance [required deny:write]
  pattern = "Deriving apiculture quantities (colony sizes, caste counts, honey yields, Varroa thresholds, dance-language parameters) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'workers = 40,000 because σ·...' or 'hexagonal cells because n=6'."
  why = "This is exactly the fabrication the pre-rewrite APICULTURE.tape committed (rows row_x_*/b_* with x='EXACT' binding apiculture figures to σ/τ/φ/J₂ — see APICULTURE.log.tape audit). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real apiculture/entomology/ecology sources (this tape's @X entries). Honeycomb hex-cell geometry is Euclidean close-packing optimality (Hales 1999) — OBSERVATION that cells are six-sided, not a lattice derivation. The lattice may only be a coincidental observation, never a derivation."

@N n6_honest_stance := "apiculture has no natural n=6 invariant — hexagonal comb is geometric, not lattice-derived" :: note [required]
  text = "Stated plainly: apiculture exposes NO natural n=6 invariant. The three castes (queen/worker/drone) is bee biology, not τ(6). Varroa reproductive rate, dance-language parameters, colony size ranges, and Nosema spore counts are entomology/ecology, not σ/τ/φ/J₂. Most importantly: honeycomb hexagonal cell geometry derives from the mathematical optimality of hexagonal tiling (Hales 1999 proof of the Honeycomb Conjecture — hexagonal packing minimises wall perimeter per unit area in the plane), NOT from the n=6 lattice. The number six appears here because of Euclidean geometry (six equilateral triangles tile around a point), not because n=6 is a perfect number or because σ(6)=12. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §10 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 Varroa collapse threshold" :: prediction [ok]
  claim = "Unmanaged A. mellifera colonies in temperate climates with V. destructor infestation exceed sustainable mite loads and collapse within 1–3 years in the absence of intervention, consistent with documented feral colony loss rates."
  falsifier = "If a properly monitored unmanaged population of A. mellifera colonies in a temperate region sustains stable population levels over 5+ years with naturally controlled Varroa infestation, [@lim_varroa] is wrong."
  source = "[@x_rosenkranz_2010]"

@D tp_2 := "TP-2 sublethal neonicotinoid homing impairment" :: prediction [ok]
  claim = "Honey bees exposed to field-realistic sublethal concentrations of neonicotinoids (imidacloprid) under controlled RFID-tagged foraging conditions show significantly elevated homing failure rates compared to unexposed controls."
  falsifier = "If a pre-registered replication of the Henry 2012 RFID experiment under the same field-realistic dosing fails to find elevated homing failure, [@lim_neonicotinoid] and [@x_henry_2012] require re-evaluation."
  source = "[@x_henry_2012]"

@D tp_3 := "TP-3 CCD multi-factor interaction" :: prediction [ok]
  claim = "Colonies exposed simultaneously to Varroa + sublethal pesticide + nutritional stress will show higher collapse rates than colonies with any single stressor alone, consistent with the multi-factor CCD hypothesis."
  falsifier = "If a factorial colony-stress experiment shows single-factor Varroa or single-factor pesticide explains CCD variance equally well as multi-factor combinations, [@lim_ccd_multifactorial] is wrong."
  source = "[@x_goulson_2015]"

# ── §11 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real apiculture science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §12 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_vonfrisch_1967 := "von Frisch 1967 — The Dance Language and Orientation of Bees" :: literature [active]
  ref = "von Frisch K. The Dance Language and Orientation of Bees. Harvard University Press, Cambridge MA, 1967. (English translation of Tanzsprache und Orientierung der Bienen, 1965.) Primary source for round-dance / waggle-dance communication."

@X x_winston_1987 := "Winston 1987 — The Biology of the Honey Bee" :: literature [active]
  ref = "Winston ML. The Biology of the Honey Bee. Harvard University Press, Cambridge MA, 1987. Standard reference for A. mellifera caste biology, colony demography, and seasonal biology."

@X x_seeley_2010 := "Seeley 2010 — Honeybee Democracy" :: literature [active]
  ref = "Seeley TD. Honeybee Democracy. Princeton University Press, Princeton NJ, 2010. (primary author/era; detailed swarm-site-selection decision-making, scout-bee communication, queen-mating biology.) Seeley authorship and approximate year asserted; precise ISBN/edition not independently verified."

@X x_hales_1999 := "Hales 1999 — The Honeycomb Conjecture" :: literature [active]
  ref = "Hales TC. The honeycomb conjecture. Discrete & Computational Geometry 2001;25(1):1–22. (Preprint circulated 1999; published 2001.) Proves that the regular hexagonal tiling uniquely minimises the perimeter enclosing equal areas in the plane — the geometric basis for comb-cell hexagonality."

@X x_klein_2007 := "Klein et al 2007" :: literature [active]
  ref = "Klein AM, Vaissière BE, Cane JH, Steffan-Dewenter I, Cunningham SA, Kremen C, Tscharntke T. Importance of pollinators in changing landscapes for world crops. Proceedings of the Royal Society B 2007;274:303–313."

@X x_calderone_2012 := "Calderone 2012" :: literature [active]
  ref = "Calderone NW. Insect pollinated crops, insect pollinators and US agriculture: trend analysis of aggregate data for the period 1992–2009. PLoS ONE 2012;7:e37235. (US managed-pollinator economic value; ~$14.6 billion estimate)"

@X x_henry_2012 := "Henry et al 2012" :: literature [active]
  ref = "Henry M, Béguin M, Requier F, Rollin O, Odoux JF, Aupinel P, Aptel J, Tchamitchian S, Decourtye A. A common pesticide decreases foraging success and survival in honey bees. Science 2012;336(6079):348–350. (RFID-tracked imidacloprid sublethal homing impairment)"

@X x_rosenkranz_2010 := "Rosenkranz, Aumeier & Ziegelmann 2010" :: literature [active]
  ref = "Rosenkranz P, Aumeier P, Ziegelmann B. Biology and control of Varroa destructor. Journal of Invertebrate Pathology 2010;103 Suppl 1:S96–119. (comprehensive review of Varroa biology, reproductive rate, DWV interaction, and treatment)"

@X x_vanengelsdorp_2009 := "vanEngelsdorp et al 2009/2010" :: literature [active]
  ref = "vanEngelsdorp D et al. Colony collapse disorder: a descriptive study. PLoS ONE 2009;4:e6481. (primary characterisation of CCD; primary-author/era cited; companion survey papers appeared ~2009–2010; exact companion-paper volumes not independently asserted)"

@X x_goulson_2015 := "Goulson et al 2015" :: literature [active]
  ref = "Goulson D, Nicholls E, Botías C, Rotheray EL. Bee declines driven by combined stress from parasites, pesticides, and lack of flowers. Science 2015;347(6229):1255957. (multi-factor bee decline synthesis review)"

@X x_hallmann_2017 := "Hallmann et al 2017" :: literature [active]
  ref = "Hallmann CA, Sorg M, Jongejans E, Siepel H, Hofland N, Schwan H, et al. More than 75 percent decline over 27 years in total flying insect biomass in protected areas. PLoS ONE 2017;12(10):e0185809. (German flying-insect biomass decline; broader pollinator context)"

@X x_higes_2009 := "Higes et al 2009" :: literature [active]
  ref = "Higes M, Martín-Hernández R, Garrido-Bailón E, González-Porto AV, García-Palencia P, Meana A, Del Nozal MJ, Mayo R, Bernal JL. Honeybee colony collapse due to Nosema ceranae in professionally managed apiaries. Environmental Microbiology Reports 2009;1(2):110–113. (N. ceranae and colony collapse association; primary-author/era cited; volume asserted from published reference)"
