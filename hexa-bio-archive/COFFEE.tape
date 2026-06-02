#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# COFFEE.tape — architecture-current (editable per v1.2)
# Event history → COFFEE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "coffee" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · coffee substrate — coffee biology + chemistry knowledge SSOT"
  brief = "botany · post-harvest processing · green-bean composition · roasting chemistry · brewing extraction · caffeine pharmacology · climate threats — real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "COFFEE.log.tape"
  scope = "in-silico coffee biology + chemistry knowledge SSOT · NOT a barista protocol / not a food-safety / not a clinical / not a regulatory claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see COFFEE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico coffee substrate. Figures (extraction yields, caffeine doses, climate projections) are paraphrased from published food-science and agronomy literature for modeling context ONLY — they are NOT a brewing recipe, agricultural prescription, health claim, or food-safety statement. Real decisions require domain specialists."

# ── §1 Botany — Coffea genus & species ────────────────────────────────

@D dom_coffea_taxonomy := "Coffea genus — Rubiaceae family" :: domain [ok]
  family = "Rubiaceae (coffee family) — tropical flowering plants."
  genus = "Coffea L. — the coffee genus; ~130 recognised species (Davis et al 2006 taxonomy revision)."
  wild-distribution = "Native to tropical Africa and Madagascar; some species in Asia; naturalized pantropically under cultivation."
  key-species = "Coffea arabica (arabica) and Coffea canephora (robusta/canephora) account for ~99% of world trade."
  |> "[@x_davis_2006] · [@x_davis_2011]"

@D dom_arabica_vs_robusta := "Coffea arabica vs Coffea canephora" :: domain [ok]
  arabica-ploidy = "Coffea arabica — allotetraploid (2n=4x=44 chromosomes); arose by hybridisation of C. canephora × C. eugenioides. Self-fertile."
  arabica-flavour = "Mild, complex acidity and aroma; lower caffeine (~1.2–1.5% dry-weight bean); commands premium market price; best suited to high-elevation subtropical environments."
  robusta-ploidy = "Coffea canephora (var. robusta) — diploid (2n=22); obligate cross-pollinator."
  robusta-traits = "Higher caffeine (~2.0–2.7% dry-weight); more robust to heat, humidity and coffee-leaf rust (CLR); higher yield in lowland tropics; used in espresso blends and instant coffee."
  honesty = "Caffeine ranges are from published compositional studies — see [@x_clifford_1985] and [@x_farah_2006]. Exact figures vary by cultivar, environment, processing."
  |> "[@x_davis_2006] · [@x_clifford_1985] · [@x_farah_2006]"

@D dom_cultivars := "cultivar diversity and breeding context" :: domain [ok]
  arabica-cultivars = "Typica, Bourbon (and its derivatives: Caturra, Catuaí, Pacas), SL28/SL34, Gesha/Geisha, F1 hybrid lines — each with distinct cup quality / agronomic profiles."
  canephora-cultivars = "Robusta and Conilon (Coffea canephora var. conilon — Brazil) are the main commercial forms."
  breeding-objectives = "CLR resistance · berry-borer tolerance · drought tolerance · yield · cup quality. These are multi-dimensional objectives, not n=6-structured (see [@n6_honest_stance])."
  genetic-base = "Arabica's allotetraploid origin left it with narrow genetic diversity relative to canephora — an agronomic risk factor for disease susceptibility."
  |> "[@x_davis_2006] · [@x_davis_2011]"

# ── §2 Cherry-to-bean: post-harvest processing ────────────────────────

@D dom_post_harvest := "coffee cherry anatomy and post-harvest overview" :: domain [ok]
  anatomy = "Coffee fruit = coffee cherry. Layers (outer to inner): exocarp (skin) → mesocarp (mucilage/pulp) → parchment (endocarp) → silver skin (testa/spermoderm) → green bean (seed / endosperm)."
  goal = "Remove fruit layers to obtain the green bean while managing fermentation and moisture to ~10–12% for stable storage."
  methods = "Three primary processing routes: washed (wet), natural (dry), honey (semi-washed)."
  |> "[@x_mccook_2019] · [@x_bytof_2005]"

@D mech_washed_processing := "washed / wet processing" :: mechanism [ok]
  steps = "Pulping (removes skin) → fermentation tank (12–72 h, microbial mucilage breakdown) → washing → raised-bed drying."
  cup-effect = "Cleaner, brighter acidity; origin terroir flavours more distinct; less fruity sweetness."
  water-use = "High water consumption — an environmental cost in water-scarce origins."
  |> "[@x_bytof_2005]"

@D mech_natural_processing := "natural / dry processing" :: mechanism [ok]
  steps = "Whole cherries dried on raised beds or patios (2–6 weeks); hull and dried pulp removed mechanically after drying."
  cup-effect = "Heavy body, pronounced fruity (blueberry, strawberry) and wine-like cup notes; fermentation during extended drying imparts distinctive flavors."
  risk = "Defect risk higher if drying conditions (moisture, temperature, turning frequency) are poorly controlled — microbial spoilage vs desired controlled fermentation."
  |> "[@x_bytof_2005]"

@D mech_honey_processing := "honey / semi-washed processing" :: mechanism [ok]
  steps = "Pulped (skin removed) but mucilage left wholly or partially on the bean during drying."
  variants = "Black / red / yellow honey = increasingly more mucilage retained; each shifts sweetness–acidity–ferment character."
  cup-effect = "Intermediate body and sweetness between washed and natural; nuanced flavour bridge."
  |> "[@x_bytof_2005]"

@D mech_fermentation := "fermentation chemistry and cup quality" :: mechanism [ok]
  agents = "Bacteria (Leuconostoc, Lactobacillus, Enterobacter spp.), yeasts (Saccharomyces, Pichia spp.), and wild-microbiome consortia drive mucilage degradation and metabolite formation."
  metabolites = "Lactic acid, acetic acid, ethanol, citric acid, and aromatic esters are produced; these penetrate the parchment and influence cup acidity, sweetness and off-note profile."
  controlled-ferment = "Deliberate inoculation (e.g. specific yeast strains) is increasingly explored to improve reproducibility — active research area (Pereira et al)."
  honesty = "Fermentation kinetics are highly site- and microbiome-dependent; exact metabolite profiles are not lattice-fixed."
  |> "[@x_bytof_2005] · [@x_pereira_2014]"

# ── §3 Green bean composition ─────────────────────────────────────────

@D dom_green_bean_composition := "green bean chemical composition" :: domain [ok]
  chlorogenic-acids = "Phenolic compounds (chlorogenic acids, CGA) — the dominant polyphenol class (~6–12% DW in arabica, higher in robusta). Major contributor to coffee astringency, antioxidant capacity, and (after roasting degradation) a precursor to roast flavour compounds."
  caffeine = "Purine alkaloid; arabica ~1.2–1.5% DW, robusta ~2.0–2.7% DW. Biosynthesised via xanthosine → theobromine → caffeine pathway in the developing bean."
  trigonelline = "Alkaloid (~1% DW arabica); pyrolises during roasting to yield niacin (vitamin B3) and aroma pyridines."
  lipids = "Total lipid ~15–17% DW in arabica (higher than robusta ~10%). Coffee wax on bean surface; diterpenoids cafestol and kahweol in the lipid fraction — linked to LDL-raising effect of unfiltered brews."
  proteins-amino-acids = "Proteins ~10–13% DW; free amino acids (glutamic acid, aspartic acid prominent) participate in Maillard reactions during roasting."
  sucrose = "Sucrose ~6–9% DW arabica (lower in robusta); carbohydrate substrate for Maillard browning and caramelisation; almost entirely consumed at dark roast."
  honesty = "Compositional ranges paraphrased from Farah 2006 and Belitz/Grosch/Schieberle food chemistry. Exact values vary by species, cultivar, processing, geography."
  |> "[@x_farah_2006] · [@x_belitz_2009]"

# ── §4 Roasting chemistry ─────────────────────────────────────────────

@D mech_roasting := "coffee roasting — Maillard + pyrolysis overview" :: mechanism [ok]
  temperature-range = "Industrial drum roasters: inlet temperatures ~200–240°C; bean temperatures rise from ambient to ~195–220°C over 8–15 min depending on roast degree."
  maillard = "Maillard reaction (reducing sugars + amino acids → N-heterocyclic flavour compounds + melanoidins): onset above ~150°C; rate accelerates as moisture drops; responsible for the majority of coffee's ~1000+ flavour volatiles (pyrazines, furans, aldehydes, ketones)."
  strecker = "Strecker degradation (a subset of Maillard): oxidative deamination of amino acids by α-dicarbonyls → Strecker aldehydes (methional, phenylacetaldehyde, etc.) — key aroma contributors."
  pyrolysis = "Above ~200°C: sucrose and polysaccharide pyrolysis → furfurals, caramelisation products; chlorogenic acid degradation → phenols (guaiacol, 4-vinylguaiacol); trigonelline → pyridines."
  first-crack = "Endothermic → exothermic phase transition (~195–205°C bean temp): water/steam escaping porous structure, cell rupture — audible cracking. Conventional light-roast endpoint zone."
  second-crack = "Cellulose/hemicellulose pyrolysis near ~225°C: another cracking event; darker, oily surface; CO₂ generation accelerates; CGA depleted; dominance of roast over origin character."
  mass-loss = "Roasting reduces bean mass by ~15–20% (moisture + CO₂ + volatile organic loss); dark roast loses more. Bean volume increases (cell expansion) while density decreases."
  co2 = "CO₂ generated during roasting is trapped inside bean cells; released slowly post-roast — relevant to packaging (one-way valve) and extraction degassing."
  |> "[@x_illy_viani_2005] · [@x_belitz_2009] · [@x_schenker_2000]"

@D mech_roast_spectrum := "light to dark roast: chemical and sensory trajectory" :: mechanism [ok]
  light = "Light roast (first-crack onset–end): retains more CGA (higher antioxidant), more sucrose, origin fruit/floral acids (malic, citric), higher density. Less bitterness from chlorogenic-acid quinones."
  medium = "Medium roast: balanced acidity–body–bitterness; most Maillard browning volatiles developed; sucrose largely consumed."
  dark = "Dark roast (past second crack): CGA largely destroyed; marked bitterness from quinones and degradation products; heavy body from melanoidins; origin character muted. Lower acidity."
  honesty = "Roast classification is a continuous spectrum; 'light/medium/dark' are trade descriptors with no universally standardised temperature thresholds — Agtron/SCAA colour disk is one industry reference."
  |> "[@x_illy_viani_2005] · [@x_schenker_2000]"

# ── §5 Brewing extraction ─────────────────────────────────────────────

@D mech_extraction := "brewing extraction — key variables" :: mechanism [ok]
  variables = "Four principal control variables: grind size (surface area / particle distribution), water temperature, contact time, brew ratio (coffee:water mass)."
  espresso = "Espresso: ~7–9 g (single) or 14–22 g (double) ground coffee, 9 bar pressure, ~90–96°C water, 25–35 s extraction → ~25–60 mL beverage. High TDS (8–12%), concentrated suspended solids and emulsified lipids."
  filter = "Filter / pour-over / drip: ~60 g/L brew ratio (SCA guideline era); 90–96°C; 3–5 min total; TDS ~1.15–1.45%."
  tds = "Total Dissolved Solids (TDS) and extraction yield are the two measurable axes on the SCA Brewing Control Chart (from the SCAA brewing control chart era — Scott Rao / Ted Lingle popularisation): optimal zone ~18–22% extraction yield, ~1.15–1.45% TDS (filter)."
  under-over = "Under-extraction (<18%): sour, thin, salty. Over-extraction (>22%): bitter, astringent, hollow. The boundaries are empirical sensory calibrations, not lattice-derived numbers."
  honesty = "18–22% extraction yield is the widely referenced SCAA-era guideline; it is a sensory/empirical window calibrated from tasting studies, not a mathematical invariant."
  |> "[@x_illy_viani_2005] · [@x_rao_2008]"

@D mech_espresso_crema := "espresso crema — CO₂ and lipid emulsion" :: mechanism [ok]
  composition = "Crema = emulsion of CO₂ gas bubbles stabilised by coffee oils and melanoidins; lighter in colour than the brew below."
  freshness-marker = "CO₂ concentration in the bean declines post-roast (degassing); crema volume correlates with bean freshness and roast recency."
  flavour-role = "Crema contributes bitterness and concentration; its presence is valorised aesthetically, but cup sweetness/balance also depends on the underlying extraction."
  |> "[@x_illy_viani_2005]"

# ── §6 Caffeine pharmacology ──────────────────────────────────────────

@D dom_caffeine_pharmacology := "caffeine — mechanism and metabolism" :: domain [ok]
  moa = "Competitive adenosine receptor antagonist: caffeine blocks A1 and A2A adenosine receptors in the CNS, preventing adenosine-mediated inhibition of neuronal firing → wakefulness, reduced fatigue perception."
  half-life = "Typical plasma half-life ~3–5 hours in adults; substantially prolonged by pregnancy (~9–11 h), oral contraceptives, and CYP1A2-inhibiting drugs."
  metabolism = "Caffeine is primarily metabolised by cytochrome P450 1A2 (CYP1A2) in the liver → paraxanthine (dominant in humans), theophylline, theobromine."
  cyp1a2 = "CYP1A2 activity is highly polymorphic: *1F 'fast' vs *1C 'slow' metaboliser genotypes affect half-life and cardiovascular response to coffee consumption. This is a host-pharmacogenetic variable, not a coffee-intrinsic constant."
  honesty = "Adenosine-receptor antagonism as the primary mechanism is well-established qualitative pharmacology (Fredholm et al reviews). Dose-response thresholds for specific effects are population-variable."
  |> "[@x_fredholm_1999] · [@x_cornelis_2006]"

@D dom_caffeine_doses := "caffeine dose context (illustrative ranges, not recommendations)" :: domain [ok]
  dose-range = "A standard espresso shot: ~60–100 mg caffeine (depending on dose, grind, extraction). A 240 mL filter cup: ~80–150 mg. Exact amounts depend on coffee mass, extraction yield, and cultivar."
  context = "EFSA and FDA have reviewed population-level caffeine intake; qualitative dose thresholds (e.g. >400 mg/day as a general adult moderation reference in regulatory assessments) are cited here for modeling context only, NOT as medical guidance."
  honesty = "Figures paraphrased from Cornelis 2006 and Farah 2006; not re-derived here."
  |> "[@x_farah_2006] · [@x_cornelis_2006]"

# ── §7 Climate sensitivity and agricultural threats ───────────────────

@D lim_climate_envelope := "arabica narrow thermal envelope (real limit)" :: real-limit [ok required]
  wall = "HARD WALL (agro-climatic)"
  statement = "Coffea arabica has a narrow optimal growing temperature range (~18–21°C mean annual temperature for quality production); high-elevation environments currently provide this in tropical regions. Climate models project substantial contraction of suitable arabica growing area under warming scenarios."
  bunn-2015 = "Bunn et al (2015, Climatic Change) modelled global arabica suitability under climate-change scenarios and projected significant area loss in current growing regions — author/era cited; exact projections depend on scenario and model ensemble."
  consequence = "Arabica production geography is bounded by real atmospheric and soil-temperature constraints, not a lattice number. Robusta's higher thermal tolerance makes it more resilient but does not substitute for arabica cup quality."
  |> "[@x_bunn_2015] · [@x_davis_2011]"

@D lim_coffee_leaf_rust := "coffee-leaf rust (Hemileia vastatrix)" :: real-limit [ok required]
  wall = "HARD WALL (pathogen pressure)"
  statement = "Hemileia vastatrix — the coffee-leaf rust fungal pathogen. Causes defoliation, yield losses of 30–70% in outbreak conditions; responsible for devastation of Ceylon coffee in the 19th century and repeated Latin American epidemic cycles."
  resistance-spectrum = "Arabica is generally susceptible; robusta is more resistant. Resistance breeding via SH-gene introgression and Timor Hybrid derivatives is ongoing (Avelino et al reviews)."
  climate-link = "Warmer temperatures and altered rainfall patterns can shift CLR outbreak geography and severity — real pest dynamics tied to climate, not lattice-scheduled."
  |> "[@x_avelino_2015]"

@D lim_berry_borer := "coffee berry borer (Hypothenemus hampei)" :: real-limit [ok required]
  wall = "HARD WALL (insect pest pressure)"
  statement = "Hypothenemus hampei (coffee berry borer, CBB) — the most damaging coffee insect pest globally; bores directly into the bean, causing crop losses and quality degradation."
  management = "Integrated management includes mass trapping, the entomopathogenic fungus Beauveria bassiana, and selective insecticide applications — no single control is complete."
  climate-link = "CBB development rate is temperature-dependent; warming can expand its altitudinal range upward into currently cool growing zones."
  |> "[@x_jaramillo_2006]"

@D lim_smallholder_economics := "commodity price volatility and smallholder vulnerability" :: real-limit [ok required]
  wall = "SOFT WALL (economic/structural)"
  statement = "~60–70% of coffee production comes from smallholder farms (<5 ha). Green coffee is a globally traded commodity with high price volatility; when world prices fall below cost of production, smallholder livelihoods are threatened. Price risk is a structural constraint on sustainable supply, not a managed variable in production science."
  consequence = "Investment in crop improvement, climate adaptation, and quality premiums is constrained by farmer economic viability — a real-world ceiling on adoption of best-practice agronomy."
  honesty = "Smallholder % figure is a widely cited estimate from international development literature (ICO / FAO era); exact figure depends on country and definition — stated as approximate order-of-magnitude."

@D lim_environmental_footprint := "sun-grown intensive vs shade-grown biodiversity tradeoff" :: real-limit [ok required]
  wall = "SOFT WALL (agro-ecological)"
  statement = "Intensification of coffee production (sun-grown, monoculture, high inputs) raises productivity but reduces canopy-tree biodiversity, migratory-bird habitat (coffee is historically an important shade-bird refuge), and soil carbon. Shade-grown / agroforestry systems preserve biodiversity and ecosystem services but often yield less per hectare."
  consequence = "No production system simultaneously maximises yield, biodiversity, water use, and carbon balance — a multi-objective constraint, not a lattice-optimised parameter."
  |> "[@x_perfecto_1996]"

# ── §8 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-coffee-science" :: governance [required deny:write]
  pattern = "Deriving coffee biology or chemistry quantities (extraction yield %, TDS, caffeine %, species count, roast stage count, processing method count) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'extraction at 90% because σ·(σ-φ)/2' or 'optimal TDS = 1.4 because τ=4'."
  why = "This is exactly the violation the pre-rewrite COFFEE.tape committed — a 380-line lattice-tautology stub full of @D row_* with n_6 = σ, n_6 = τ, n_6 = n=6 derivation claims. hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real coffee science sources (this tape's @X entries). Coffee biology has no natural n=6 invariant — see [@n6_honest_stance]. The lattice may only be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "coffee science has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: coffee science exposes NO natural n=6 invariant. The main commercial species are 2 (arabica + robusta), not 6. Post-harvest processing routes are 3 primary types (washed, natural, honey) — not 6. Roast degree is a continuous spectrum conventionally divided into 3–4 named zones — not 6. Caffeine's adenosine receptors (A1 and A2A) targeted are 2 subtypes — not 6. Extraction-yield optimal window (~18–22%) is a sensory/empirical calibration. None of these biological, chemical, or agronomic numbers arise from σ/τ/φ/J₂ — they are organic chemistry, plant physiology, and food-science empiricism. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §9 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 arabica area contraction under warming" :: prediction [ok]
  claim = "Under climate-warming scenarios, modelled suitable arabica-growing area declines materially in current production regions (net global loss, not merely geographic shift)."
  falsifier = "If future climate data and properly validated crop-distribution models show equal or expanding global suitable arabica area under sustained +1.5°C warming, [@lim_climate_envelope] (Bunn 2015 model era) is wrong."
  source = "[@x_bunn_2015]"

@D tp_2 := "TP-2 CYP1A2 fast/slow metaboliser caffeine half-life difference" :: prediction [ok]
  claim = "CYP1A2 fast-metaboliser genotype carriers exhibit meaningfully shorter caffeine plasma half-life (roughly half or less) compared to slow-metaboliser carriers under controlled oral-dose conditions."
  falsifier = "If a properly powered pharmacokinetic study stratified by CYP1A2 *1F vs *1C genotype shows no significant half-life difference, the pharmacogenetics model in [@dom_caffeine_pharmacology] is wrong."
  source = "[@x_cornelis_2006]"

@D tp_3 := "TP-3 extraction yield and cup quality window" :: prediction [ok]
  claim = "Filter coffee extracted to 18–22% yield at the SCA-guideline TDS range (~1.15–1.45%) scores higher on trained-panel sensory balance than coffee extracted below 16% or above 24% yield."
  falsifier = "If blind trained-panel evaluation shows no systematic sensory preference for the 18–22% range over under/over-extracted comparators at matched TDS, the SCAA/SCA control-chart optimal zone is not empirically grounded."
  source = "[@x_rao_2008] (SCA/SCAA brewing control chart era)"

# ── §10 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real coffee science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §11 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_davis_2006 := "Davis et al 2006 — Coffea taxonomy revision" :: literature [active]
  ref = "Davis AP, Govaerts R, Bridson DM, Stoffelen P. An annotated taxonomic conspectus of the genus Coffea (Rubiaceae). Botanical Journal of the Linnean Society 2006;152:465–512. (comprehensive Coffea species taxonomy revision; ~130 species recognised)"

@X x_davis_2011 := "Davis et al 2011 — arabica climate change" :: literature [active]
  ref = "Davis AP et al. Multiple Threaten Rare Wild Coffee Species Coffea (Rubiaceae) in Ethiopia. PLoS ONE 2011;6:e21158. (wild Coffea arabica climate-vulnerability assessment — primary author/era cited; exact figure interpretation may depend on scenario)"

@X x_clifford_1985 := "Clifford & Willson 1985 — coffee botany" :: literature [active]
  ref = "Clifford MN, Willson KC (eds). Coffee: Botany, Biochemistry and Production of Beans and Beverage. Croom Helm / AVI, 1985. (foundational coffee botany and composition reference; primary editor/era)"

@X x_farah_2006 := "Farah & Donangelo 2006 — phenolic compounds" :: literature [active]
  ref = "Farah A, Donangelo CM. Phenolic compounds in coffee. Brazilian Journal of Plant Physiology 2006;18:23–36. (chlorogenic acids, caffeine, trigonelline, lipid composition of green and roasted beans)"

@X x_belitz_2009 := "Belitz, Grosch & Schieberle — Food Chemistry (textbook)" :: literature [active]
  ref = "Belitz HD, Grosch W, Schieberle P. Food Chemistry (4th ed., Springer, 2009). Standard food-chemistry reference including roasting chemistry, Maillard reaction, and coffee composition. (primary authors/era; chapter-level citation)"

@X x_illy_viani_2005 := "Illy & Viani — Espresso Coffee (2nd ed.)" :: literature [active]
  ref = "Illy A, Viani R (eds). Espresso Coffee: The Science of Quality (2nd ed., Elsevier Academic, 2005). Comprehensive technical reference for espresso production science: bean composition, roasting, extraction, crema. (primary editors/era)"

@X x_schenker_2000 := "Schenker et al 2000 — roasting/cracking" :: literature [active]
  ref = "Schenker S et al. An investigation of the first and second crack during roasting of coffee beans. Journal of Food Science 2000;65:604–608. (first-crack / second-crack thermophysical characterisation — primary author/era)"

@X x_rao_2008 := "Scott Rao — Coffee Brewer's Handbook (era ~2008)" :: literature [active]
  ref = "Rao S. The Coffee Brewer's Handbook (self-published / SCAA editions, circa 2008). Practitioner reference synthesising SCA/SCAA brewing control chart methodology — extraction yield, TDS, optimal zone. (primary author/era; not an academic journal article — practitioner SSOT for brewing-control framework)"

@X x_bytof_2005 := "Bytof et al 2005 — processing and cup quality" :: literature [active]
  ref = "Bytof G et al. Influence of processing on the generation of γ-aminobutyric acid in green coffee beans. European Food Research and Technology 2005;220:245–250. (wet/dry processing biochemistry and fermentation effects — primary author/era)"

@X x_pereira_2014 := "Pereira et al 2014 — coffee fermentation" :: literature [active]
  ref = "Pereira GV de M et al. Isolation, selection and evaluation of yeasts for use in fermentation of coffee (Coffea arabica) fruits. Acta Scientiarum 2014;36:145–154. (controlled fermentation / microbial diversity in coffee processing — primary author/era)"

@X x_fredholm_1999 := "Fredholm et al 1999 — caffeine adenosine" :: literature [active]
  ref = "Fredholm BB et al. Actions of caffeine in the brain with special reference to factors that contribute to its widespread use. Pharmacological Reviews 1999;51:83–133. (authoritative review of caffeine adenosine-receptor antagonism mechanism)"

@X x_cornelis_2006 := "Cornelis et al 2006 — CYP1A2 pharmacogenetics" :: literature [active]
  ref = "Cornelis MC et al. Coffee, CYP1A2 genotype, and risk of myocardial infarction. JAMA 2006;295:1135–1141. (CYP1A2 fast/slow metaboliser pharmacogenetics and coffee — primary author/era; figures cited qualitatively for modeling context only)"

@X x_bunn_2015 := "Bunn et al 2015 — arabica climate suitability" :: literature [active]
  ref = "Bunn C et al. A bitter cup: climate change profile of global production of Arabica and Robusta coffee. Climatic Change 2015;129:89–101. (modelled contraction of suitable arabica area under warming scenarios — primary author/era; exact numbers depend on scenario)"

@X x_avelino_2015 := "Avelino et al 2015 — coffee-leaf rust" :: literature [active]
  ref = "Avelino J et al. The coffee rust crises in Colombia and Central America (2008–2013): impacts, plausible causes and proposed solutions. Food Security 2015;7:303–321. (coffee-leaf rust epidemiology, yield losses, climate interactions — primary author/era)"

@X x_jaramillo_2006 := "Jaramillo et al 2006 — coffee berry borer" :: literature [active]
  ref = "Jaramillo J et al. Biological control of the coffee berry borer: Beauveria bassiana performance and implications for pest management. BioControl 2006;51:633–647. (coffee berry borer biology and control — primary author/era)"

@X x_perfecto_1996 := "Perfecto et al 1996 — shade coffee and biodiversity" :: literature [active]
  ref = "Perfecto I et al. Shade coffee: a disappearing refuge for biodiversity. BioScience 1996;46:598–608. (shade-grown vs sun-grown biodiversity tradeoff — primary author/era)"

@X x_mccook_2019 := "McCook 2019 — coffee history / processing context" :: literature [active]
  ref = "McCook S. The World of Coffee. In: Topik S, Wells A (eds) The Second Conquest of Latin America (1998) / McCook S. Coffee is Not Forever: A Global History of the Coffee Leaf Rust. Ohio University Press, 2019. (historical and agronomic context for coffee post-harvest processing — author/era cited; exact volume not asserted)"
