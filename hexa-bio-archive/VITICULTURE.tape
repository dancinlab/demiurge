#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# VITICULTURE.tape — architecture-current (editable per v1.2)
# Event history → VITICULTURE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "viticulture" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · viticulture substrate — grape-growing science knowledge SSOT"
  brief = "Vitis taxonomy · phylloxera history · vine phenology · terroir · disease pressure · climate change impact — real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "VITICULTURE.log.tape"
  scope = "in-silico viticulture knowledge SSOT · NOT agronomic advice / not a winemaking protocol / not a regulatory or phytosanitary claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see VITICULTURE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico viticulture substrate. Agronomic figures (yield ranges, disease thresholds, climate indices) are paraphrased from published viticultural literature for modeling context ONLY — they are NOT a vineyard management prescription, pesticide-use recommendation, cultivar selection guide, or regulatory claim. Real viticultural decisions require site-specific soil/climate assessment, certified viticulture advisors, and jurisdiction-specific phytosanitary regulations."

# ── §1 Vitis taxonomy & cultivar diversity ────────────────────────────

@D dom_vitis_taxonomy := "genus Vitis — taxonomy and domestication" :: domain [ok]
  genus = "Vitis (family Vitaceae) — the grape genus. Two primary groups: Euvitis (true grapes, cluster-bearing, 38 chromosomes) and Muscadinia (different ploidy, separate section, e.g. V. rotundifolia)."
  primary-species = "Vitis vinifera L. — European wine grape. Domesticated; source of the overwhelming majority of commercial wine cultivars worldwide."
  cultivar-count = "~10,000 named Vitis vinifera cultivars catalogued. Examples: Pinot Noir (Burgundy), Cabernet Sauvignon, Chardonnay, Riesling, Sangiovese, Tempranillo, Nebbiolo, Grenache, Syrah, Sauvignon Blanc."
  american-species = "Vitis labrusca (fox grape — e.g. Concord), Vitis riparia, Vitis rupestris — North American species; naturally phylloxera-resistant root systems (see [@dom_phylloxera]). Key rootstock parents."
  domestication = "Archaeological evidence places V. vinifera domestication in the South Caucasus (modern Georgia, Armenia, Iran) — ~6000 BCE era; McGovern archaeological evidence for wine residues in this region."
  honesty = "Cultivar count (~10,000) and domestication timeline are paraphrased from the ampelography / archaeobotany literature. Exact cultivar counts vary by authority and are growing with genetic surveys — not a lattice constant."
  |> "[@x_mcgovern_era] · [@x_galet_era] · [@x_mullins_1992]"

@D dom_vitis_genetics := "Vitis genetics — genome and polyploidy" :: domain [ok]
  ploidy = "Vitis vinifera is diploid (2n = 38); V. rotundifolia (Muscadinia) has 2n = 40 — different section."
  genome = "Pinot Noir genome sequenced 2007 (Jaillon et al, Nature; Velasco et al, PLoS ONE — two independent assemblies of PN40024 inbred line). ~487 Mb; ~30,434 protein-coding genes predicted (Jaillon assembly); relatively gene-rich."
  mildew-resistance = "Most V. vinifera lack functional resistance genes for downy/powdery mildew (see [@dom_diseases]). Resistance QTLs from American/Asian Vitis species are being introgressed — the genetic basis of disease-resistant varieties (PIWI cultivars in European nomenclature)."
  |> "[@x_jaillon_2007]"

# ── §2 Phylloxera — the defining viticultural catastrophe ────────────

@D dom_phylloxera := "Daktulosphaira vitifoliae — phylloxera" :: domain [ok]
  taxonomy = "Daktulosphaira vitifoliae (Fitch, 1856) — grape phylloxera (hemipteran, Phylloxeridae); North American native insect."
  life-cycle = "Complex dimorphic life cycle: root-feeding (radicicolae) form damages root tissue, causing galling and secondary fungal infection → plant decline. Leaf-galling (gallicolae) form also occurs on some hosts. Wingless and winged (alate) forms."
  european-devastation = "Introduced to Europe (France) ~1860s via infected plant material. Devastated European vineyards by 1880s — estimated 40% of French vineyards destroyed at peak; widespread losses across Spain, Italy, Germany, and beyond. One of the most economically destructive agricultural pest events in history."
  host-resistance = "Vitis vinifera is NOT natively resistant to root-feeding phylloxera. North American Vitis species (V. riparia, V. rupestris, V. berlandieri, hybrids) have evolved root mechanisms that limit galling and fungal colonisation."
  solution = "Grafting V. vinifera (scion) onto American Vitis rootstocks. Near-universal practice in most phylloxera-affected wine regions today. Ungrafted vinifera still exists only where phylloxera is absent (sandy soils, some islands, e.g. parts of Chile, some historic old-vine plots in Australia)."
  current-status = "Phylloxera is STILL present globally. No chemical or biological control has replaced grafting as the durable commercial solution — a HARD WALL (see [@lim_phylloxera])."
  |> "[@x_galet_era] · [@x_mullins_1992]"

# ── §3 Vine biology — annual cycle and berry development ─────────────

@D dom_vine_phenology := "vine annual phenological cycle" :: domain [ok]
  lifecycle = "Vitis vinifera is a woody perennial vine; productive for decades in the same location (100-year-old vines are not uncommon in premium viticulture)."
  annual-stages = "Key phenological stages in sequence: (1) budbreak (ecodormancy break, triggered by warming soil/air), (2) shoot elongation and leaf development, (3) flowering (inflorescence emergence → anthesis → berry set), (4) berry development (cell division → cell expansion), (5) veraison (onset of ripening — colour change in red varieties, softening and sugar accumulation), (6) harvest (maturity), (7) post-harvest shoot maturation/hardening, (8) leaf fall and dormancy."
  el-system = "The modified E-L (Eichhorn-Lorenz) system is the principal staging scale for grapevine phenology — 47 stages (E-L 1 to 47). Modified by Coombe (Coombe & McCarthy 2000 era — Aust J Grape Wine Res). Analogous to BBCH for cereals but grapevine-specific."
  honesty = "Stage count (47) is the established scale convention — an empirical agronomic classification, not a lattice value."
  |> "[@x_coombe_mccarthy_era] · [@x_mullins_1992]"

@D dom_berry_development := "berry development — biochemistry of ripening" :: domain [ok]
  pre-veraison = "Lag phase post-berry-set: cells divide, berry is green/hard/high-acid (tartaric + malic); photosynthate imported; chlorophyll dominant."
  veraison = "Onset of ripening: colour development (anthocyanin accumulation in red varieties — grape skin); berry softening (cell-wall loosening); sugar loading from phloem (glucose + fructose, largely equal ratio at harvest) begins dominant accumulation; acid catabolism (malic acid respiration) accelerates."
  harvest-parameters = "Key enological targets: Brix (soluble-solids index, dominated by sugar), titratable acidity (TA), pH, and varietal aroma precursors. Brix at harvest varies widely by region/style (roughly 18–28°Brix for table wine grapes) — this is an empirical agronomic range, NOT a lattice-derived target."
  |> "[@x_coombe_mccarthy_era] · [@x_mullins_1992]"

# ── §4 Terroir — composite environmental determinism ─────────────────

@D dom_terroir := "terroir — soil, climate, topography, cultivar, practice" :: domain [ok]
  definition = "Terroir: the composite expression of a vine's geographic environment — soil (mineralogy, texture, drainage, organic matter, pH), climate (temperature, precipitation, solar radiation, wind), topography (slope, aspect, elevation), cultivar genetics, and viticultural practice. French viticultural tradition. Widely studied and debated in scientific literature."
  components = "Each terroir component is measurable and independently causal; terroir is not a single quantity, not a lattice-derived constant."
  climate-classification = [
    "Winkler heat summation (GDD-based, °F): Region I (<2500 GDD), II (2501-3000), III (3001-3500), IV (3501-4000), V (>4000). Albert Winkler, UC Davis, mid-20th century. Still widely used in California and internationally.",
    "Huglin index: integral of mean+maximum daily temperature above 10°C during the growing season (April-September in Northern Hemisphere). Widely used in European viticultural classification.",
    "Tonietto & Carbonneau multicriteria bioclimatic system (MCC): combines Huglin index, cool-night index (CI), and dryness index (DI) into viticultural climatic classes. Tonietto & Carbonneau 2004, Agric For Meteorol."
  ]
  honesty = "Region counts (I-V for Winkler) are classification conventions — I through V is an empirical categorical system, not a lattice partition."
  |> "[@x_winkler_era] · [@x_tonietto_2004]"

# ── §5 Grapevine disease pressure ────────────────────────────────────

@D dom_diseases := "grapevine disease pressure — major pathogens" :: domain [ok]
  downy-mildew = "Plasmopara viticola (Berlese & de Toni, 1888) — downy mildew. Oomycete (water mold, not a true fungus). North American origin; introduced to Europe ~1878. Devastates foliage and fruit clusters; requires free moisture for sporangia dispersal/infection. Major cause of spray program necessity in Europe."
  powdery-mildew = "Erysiphe necator (Schwein.) Burrill (syn. Uncinula necator) — powdery mildew. True ascomycete. Obligate biotroph; requires living host; tolerates dry conditions unlike downy mildew. Infects green tissue including berries; reduced by sulfur applications, FRAC code 3/7/11 fungicides."
  botrytis = "Botrytis cinerea Pers. ex Fr. — grey mould / noble rot. Necrotrophic ascomycete. Causes grey rot (wine-quality loss, yield loss) on damaged/over-wet berries; in specific conditions (alternating humidity/dryness, late-season) causes 'noble rot' (Botrytis pourriture noble / Edelfäule) concentrating sugars/glycerol/aroma — the basis of Sauternes, Tokaj, Trockenbeerenauslese."
  esca = "ESCA — grapevine trunk disease complex. Caused by a consortium of wood-decay fungi (Phaeomoniella chlamydospora, Phaeoacremonium minimum, Fomitiporia mediterranea principally). Chronic and emerging; expressed as foliar 'tiger-stripe' symptoms, apoplexy (sudden collapse), wood necrosis. No curative treatment registered; pruning management is the main mitigation. Increasingly prevalent as old-vine stocks age and arsenite use was banned."
  |> "[@x_mullins_1992] · [@x_bove_2014]"

# ── §6 Climate change impact on viticulture ──────────────────────────

@D dom_climate_change := "climate change — viticulture impacts" :: domain [ok]
  harvest-trend = "Harvest dates across European wine regions have advanced significantly since the mid-20th century — roughly 1-3 weeks earlier over 50 years in documented records from Burgundy, Alsace, and elsewhere. Rising temperatures accelerate phenological progression."
  sugar-acid = "Higher temperatures at ripening raise sugar accumulation and reduce malic acid catabolism at different rates — resulting in higher Brix (potential alcohol), lower titratable acidity, and altered pH at harvest. Significant stylistic and enological consequence."
  zone-shift = "Suitable viticultural zones (based on heat indices) are shifting poleward and upward in altitude. Previously marginal northern/southern regions becoming viable; classic regions facing heat stress at upper bounds. New regions (e.g. southern England, Scandinavia, higher Andean elevations) gaining viticultural relevance."
  water-stress = "Increased drought frequency in Mediterranean-climate growing regions (California, Australia, Spain, Italy, southern France); increased pressure on irrigation water allocation; drought-stress accelerates ripening unevenly."
  |> "[@x_van_leeuwen_2016] · [@x_hannah_2013]"

@D dom_precision_viticulture := "precision viticulture and modern management" :: domain [ok]
  ndvi = "NDVI (Normalized Difference Vegetation Index) from multispectral satellite or drone imagery delineates within-block vigor variation — enabling variable-rate inputs (fertiliser, irrigation), selective harvest, and yield mapping. Empirical remote sensing tool; vigor variation is real soil/plant heterogeneity."
  canopy-management = "Shoot positioning, leaf removal (basal defoliation), hedging — open canopy improves light penetration and air circulation, reducing disease pressure (Botrytis) and promoting even ripening. Documented effects in viticultural practice literature."
  irrigation = "Regulated deficit irrigation (RDI) and partial rootzone drying (PRD) are documented strategies to manage vine water status, limit vegetative vigor, and maintain fruit quality under water constraints. Penman-Monteith ET reference used for scheduling."
  biological-controls = "Mating disruption (pheromone-based) for grape berry moth (Lobesia botrana / Eupoecilia ambiguella); kaolin clay applications; Trichoderma-based biocontrol for Botrytis. Growing component of IPM programs in certified organic/biodynamic vineyards."
  |> "[@x_van_leeuwen_2016]"

# ── §7 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ───

@D lim_phylloxera := "phylloxera — no durable chemical or biological control" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "Daktulosphaira vitifoliae cannot be eradicated from soil once established. No chemical, biological, or genetic treatment has replaced grafting onto American rootstocks as the durable commercial control. Systemic soil fumigants (methyl bromide) are phased out under Montreal Protocol; no registered successor achieves the same durability."
  consequence = "Vitis vinifera scion cultivation in phylloxera-affected soils requires grafted rootstocks. Old-vine ungrafted (sur-propre-racines) vinifera survives only in naturally excluding environments (deep sands, volcanic soils, isolated geographies). This is not a technological gap — it is an unresolved biological constraint."
  |> "[@x_galet_era] · [@x_mullins_1992]"

@D lim_climate_envelope := "climate envelope — grapevine cardinal temperatures" :: real-limit [ok required]
  wall = "HARD WALL (agro-climatic)"
  statement = "Vitis vinifera has cardinal temperature bounds for each phenological stage. Budbreak requires sustained warming above a threshold (~10°C base). Flowering/fruitset are sensitive to frost (catastrophic crop loss), extreme heat (>35-38°C impairs pollination and induces stress), and abnormal cold. Veraison/ripening require accumulated heat (GDD); insufficient heat summation fails to reach harvest maturity; excessive heat destroys aroma precursors and acidic balance. Climate envelopes for premium viticulture are geographically bounded."
  consequence = "Climate change shifts (does not abolish) these envelopes but also creates mismatches — regions optimised for current cultivar/climate pairings face novel heat/drought stress patterns that cannot be managed by technique alone. See [@x_hannah_2013] for projected zone-loss modelling."
  |> "[@x_winkler_era] · [@x_hannah_2013] · [@x_van_leeuwen_2016]"

@D lim_disease_fungicide := "disease pressure and fungicide resistance evolution" :: real-limit [ok required]
  wall = "SOFT WALL (evolutionary, shifting)"
  statement = "Plasmopara viticola and Erysiphe necator populations evolve resistance under fungicide selection pressure. FRAC resistance monitoring documents resistance to QoI (strobilurin, FRAC 11), DMI (FRAC 3), and SDHI (FRAC 7) compounds in European populations. No single mode of action retains indefinite efficacy; resistance management (rotation of FRAC groups, anti-resistance mixtures, biological buffers) is required."
  consequence = "A fundamental arms race: the chemical toolkit is finite; evolutionary adaptation of pathogen populations is continuous. Durable disease control is a moving target, not a solved constant."
  |> "[@x_bove_2014]"

@D lim_water_smoke := "water scarcity and smoke-taint exposure" :: real-limit [ok required]
  wall = "HARD WALL (resource finitude) + EMERGING WALL (wildfire era)"
  water = "Freshwater allocation for viticulture is competed; aquifer depletion in major wine regions (central California, Mendoza, parts of Spain/Australia) is locally irreversible on decadal timescales. Irrigation access is not guaranteed."
  smoke-taint = "Wildfire smoke exposure causes glycosylated volatile phenol accumulation in berry tissue (guaiacol, 4-methylguaiacol, syringol as the principal markers) — binding to berries even without visible smoke. Smoke-tainted fruit produces wines with objectionable medicinal/ashy off-flavors that cannot be reliably removed in winemaking. There is no established post-harvest remedy that restores quality to unaffected levels."
  consequence = "Under increasing wildfire frequency in Mediterranean-climate wine regions (California, Australia, South Africa, Chile), smoke-taint is an emerging agronomic-economic hard wall for affected vintages. Not a lattice-tunable parameter."
  |> "[@x_van_leeuwen_2016] · [@x_hannah_2013]"

# ── §8 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-viticulture" :: governance [required deny:write]
  pattern = "Deriving viticultural quantities (Brix targets, yield t/ha, disease control %, harvest-date counts, cultivar counts, phenological stage counts) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'target Brix = 24 because J₂=24' or '12 spray applications because σ=12' or '4 growth phases because τ=4'."
  why = "This is exactly the violation the pre-rewrite VITICULTURE.tape committed (row_brix_0: x=18 → hexa=24 because J₂=24; row_t_ha_1: x=8 → hexa=12 because σ=12; etc. — lattice-tautology mappings with zero viticultural science). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real viticulture/plant-science/climatology sources (this tape's @X entries). Numeric coincidences in viticulture (12 months/year, 4 seasons, ~10,000 cultivars) are OBSERVATION ONLY — arising from calendar, phenology, and taxonomic history, not from σ/τ/φ/J₂."

@N n6_honest_stance := "viticulture has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: viticulture exposes NO natural n=6 invariant. Phenological stages (E-L system: 47 stages), major disease categories (downy mildew, powdery mildew, botrytis, ESCA, plus phylloxera — 5 major threats, not 6), Winkler regions (I-V — 5 regions, not 6), primary macro-nutrients (N, P, K — 3), primary viticultural climate indices (Winkler, Huglin, Tonietto MCC — 3 principal, more exist): none of these counts emerge from the lattice. Brix at harvest is site/cultivar/style-specific (typically 18-28°) — not J₂=24. Harvest timing is climate-driven phenology, not a τ=4 schedule. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §9 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 harvest-date advancement" :: prediction [ok]
  claim = "Documented harvest dates in historically tracked European wine regions (Burgundy, Alsace, Bordeaux) continue trending earlier relative to the 1950-1980 baseline, consistent with GDD accumulation rising under warming."
  falsifier = "If a 50-year harvest-date series from multiple tracked Burgundy/Alsace plots shows no statistically significant advancement from the 1950-2025 period, [@dom_climate_change] and [@x_van_leeuwen_2016] are wrong or misapplied here."
  source = "[@x_van_leeuwen_2016]"

@D tp_2 := "TP-2 phylloxera rootstock durability" :: prediction [ok]
  claim = "Ungrafted Vitis vinifera planted in confirmed phylloxera-present soils will show root-system damage and accelerated decline within 5-15 growing seasons, regardless of variety; grafted vines on resistant rootstock in the same soil will show materially longer productive life."
  falsifier = "If a controlled field trial shows ungrafted V. vinifera sustaining productive health equal to grafted controls in confirmed phylloxera soil for >20 seasons, [@lim_phylloxera] is wrong."
  source = "[@x_mullins_1992] · [@x_galet_era]"

@D tp_3 := "TP-3 zone-loss under climate projection" :: prediction [ok]
  claim = "Under RCP 4.5 and RCP 8.5 emission scenarios, the area of land globally suitable for traditional premium wine grape production will shift measurably poleward/upward in elevation by 2050, with net loss in Mediterranean-climate regions and net gain in higher-latitude/altitude regions, as modelled by Hannah et al 2013."
  falsifier = "If 2040-2060 observational data on vineyard establishment/abandonment patterns globally shows no poleward/altitudinal shift, or if agro-climate suitability modelling with updated data reverses the projected direction, [@x_hannah_2013] is falsified for viticulture zone shifts."
  source = "[@x_hannah_2013]"

# ── §10 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real viticultural science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

@X x_wine_enology_sibling := "WINE-ENOLOGY.tape" :: sibling-tape [active]
  scope = "Winemaking / enology downstream of harvest — fermentation, elevage, SO₂ chemistry, malolactic fermentation, sensory science. Sibling to this tape; not touched by this rewrite."

# ── §11 External citations (real, landmark literature) ───────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_mcgovern_era := "McGovern (Caucasus grape domestication / archaeobotany, era ~2003)" :: literature [active]
  ref = "Patrick E. McGovern — archaeochemical evidence for early wine/grape use in the South Caucasus and Near East (primary author/era; key monograph: 'Uncorking the Past', 2009; journal work in J Archaeol Sci era). Domestication ~6000 BCE archaeobotanical framing — primary author/era cited, exact article volume not asserted for the domestication timeline."

@X x_galet_era := "Galet — A Practical Ampelography (era ~1979 English translation)" :: literature [active]
  ref = "Pierre Galet — 'A Practical Ampelography: Grapevine Identification' (translated by Lucie T. Morton; Comstock Publishing, Cornell, ~1979). The defining ampelographic reference for Vitis taxonomy and cultivar description in the modern era. Primary author/era cited; edition details not asserted for all claims."

@X x_mullins_1992 := "Mullins, Bouquet & Williams 1992" :: literature [active]
  ref = "Mullins MG, Bouquet A, Williams LE. Biology of the Grapevine. Cambridge University Press, 1992. Standard English-language textbook on Vitis biology — vine anatomy, physiology, phenology, rootstocks, phylloxera. Primary reference for [@dom_vine_phenology], [@dom_phylloxera], and [@dom_vitis_taxonomy]."

@X x_coombe_mccarthy_era := "Coombe & McCarthy (modified E-L system, ~2000 era)" :: literature [active]
  ref = "B.G. Coombe and M.G. McCarthy — Australian Journal of Grape and Wine Research, ca. 2000 — codification of the modified Eichhorn-Lorenz (E-L) grapevine phenological scale (47 stages). Primary author/era cited; exact volume/pages not asserted."

@X x_jaillon_2007 := "Jaillon et al 2007 — Pinot Noir genome" :: literature [active]
  ref = "Jaillon O et al. The grapevine genome sequence suggests ancestral hexaploidization in major angiosperm phyla. Nature 2007;449:463–467. (PN40024 Pinot Noir reference genome; ~487 Mb assembly; gene count estimation)"

@X x_winkler_era := "Winkler et al — General Viticulture (era ~1974)" :: literature [active]
  ref = "A.J. Winkler, J.A. Cook, W.M. Kliewer, L.A. Lider — General Viticulture (University of California Press; 2nd ed. ~1974). The foundational text defining the Winkler GDD heat-summation Region I-V classification for California viticulture — primary authors/era cited."

@X x_tonietto_2004 := "Tonietto & Carbonneau 2004" :: literature [active]
  ref = "Tonietto J, Carbonneau A. A multicriteria climatic classification system for grape-growing regions worldwide. Agricultural and Forest Meteorology 2004;124:81–97. (MCC system: Huglin index + cool-night index + dryness index; bioclimatic classification of wine regions worldwide)"

@X x_van_leeuwen_2016 := "van Leeuwen & Darriet 2016" :: literature [active]
  ref = "van Leeuwen C, Darriet P. The impact of climate change on viticulture and wine quality. Journal of Wine Economics 2016;11(1):150–167. (harvest date trends, sugar-acid balance shifts, zone changes, management adaptations; primary real-limits citation for [@dom_climate_change] and [@lim_climate_envelope])"

@X x_hannah_2013 := "Hannah et al 2013" :: literature [active]
  ref = "Hannah L et al. Climate change, wine, and conservation. Proceedings of the National Academy of Sciences 2013;110(17):6907–6912. (global modelling of wine-region suitability under RCP 4.5/8.5; poleward zone shift projection; water demand consequences)"

@X x_bove_2014 := "Bove & Gubler (ESCA and trunk disease, era ~2014)" :: literature [active]
  ref = "F.J. Bove, W.D. Gubler and associated grapevine trunk disease literature (~2010s era). ESCA pathogen consortium characterisation (Phaeomoniella chlamydospora, Phaeoacremonium minimum, Fomitiporia mediterranea); management review. Primary author/era cited; exact consolidated review volume not asserted — represents the ESCA emerging-literature body."
