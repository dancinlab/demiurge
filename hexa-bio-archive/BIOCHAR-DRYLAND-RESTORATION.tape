#!/usr/bin/env tape

# ══════════════════════════════════════════════════════════════
# BIOCHAR-DRYLAND-RESTORATION.tape — architecture-current (editable per v1.2)
# Event history → BIOCHAR-DRYLAND-RESTORATION.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "biochar-dryland-restoration" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · biochar dryland restoration — soil-amendment + carbon-sequestration science knowledge SSOT"
  brief = "Biochar + dryland-restoration · n=6 NOT used as a derivation (honest) · context-dependent yield + sequestration claims explicit"
  parent = "dancinlab/hexa-bio"
  sibling-log = "BIOCHAR-DRYLAND-RESTORATION.log.tape"
  scope = "in-silico biochar-soil-science knowledge SSOT · NOT agronomic advice / not a farming protocol / not a clinical / regulatory / carbon-market claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see BIOCHAR-DRYLAND-RESTORATION.log.tape audit"

@N scope_disclaimer := "hype-aware knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico biochar-soil-science substrate. Biochar is hype-prone: yield-improvement and carbon-sequestration claims in popular and industry literature frequently over-generalise from heterogeneous meta-analyses. Figures here are paraphrased from published literature for modeling context ONLY — they are NOT a soil-amendment protocol, carbon-credit promise, regulatory submission, or wet-lab claim. Yield responses are CONTEXT-DEPENDENT (soil type, biochar feedstock and production temperature, crop, climate region). Meta-analysis results show high between-study heterogeneity — reporting the mean without the variance is dishonest. Sequestration permanence is conditional on production conditions and soil/climate environment."

# ── §1 Biochar production — pyrolysis thermochemistry ────────────────

@D dom_pyrolysis := "slow pyrolysis — the core production process" :: domain [ok]
  definition = "Pyrolysis = thermal decomposition of organic matter in a low-oxygen or oxygen-free atmosphere, yielding three co-products: (1) solid char (biochar), (2) condensable bio-oil/tar, and (3) non-condensable syngas (CO, H₂, CH₄)."
  slow-pyrolysis = "Slow pyrolysis: feedstock heated at low rates (typically 1–10 °C/min) to peak temperatures of 300–700 °C; favours solid char yield over bio-oil and syngas. Residence times minutes to hours depending on kiln design."
  char-yield = "Char mass yield in slow pyrolysis is roughly 25–40% of dry feedstock mass (temperature-dependent: decreases as peak temperature rises above ~400 °C, approximately 0.35% per °C — Antal & Grønli 2003 envelope). Higher-temp pyrolysis yields lower-mass but more-aromatic, stable char."
  high-temp-variants = "Flash/fast pyrolysis (>500 °C/s, short residence) maximises bio-oil; gasification (>700 °C, partial oxidation) maximises syngas. These routes produce little solid char — biochar production deliberately favours slow/moderate conditions."
  activated-carbon = "High-temperature activation (steam or chemical, 700–900 °C) produces activated carbon with very high BET surface area (>500 m²/g); used for water/air treatment, not soil amendment. Distinct product class from agronomic biochar."
  |> "[@x_antal_gronli_2003]"

@D dom_terra_preta := "Terra Preta de Índio — archaeological origin and lessons" :: domain [ok]
  definition = "Terra Preta de Índio (Portuguese: 'Indian dark earth') — anthropogenic dark, highly fertile soils found in the Amazon basin, associated with pre-Columbian indigenous settlement. Recognised as biochar-enriched by modern soil scientists."
  key-properties = "High charcoal content (pyrogenic carbon), elevated CEC, higher organic matter persistence, and historically higher agricultural productivity compared to surrounding oxisols/ultisols — observed in field studies, not a lattice-derived constant."
  archaeo-era = "Research era primarily associated with Bruno Glaser, Johannes Lehmann and William Woods (late 1990s–2000s) who characterised Terra Preta's pyrogenic carbon, CEC, and microbiology. The 'Lehmann era' landmark is his 2007 Nature paper and the Lehmann & Joseph textbook."
  lesson-honesty = "Terra Preta is a proof-of-concept that biochar can persist in soils for centuries and improve fertility; but (a) it formed over centuries of accumulated settlement, not a single application; (b) its formation process is not fully replicated by modern biochar application; (c) it formed in humid tropical soils — direct extrapolation to temperate or arid drylands requires caution."
  |> "[@x_lehmann_joseph_2009] · [@x_glaser_lehmann_2002]"

@D dom_biochar_classification := "biochar classification and quality standards" :: domain [ok]
  ebc = "European Biochar Certificate (EBC) — grades from EBC-Feed to EBC-Carbon-Sink; requires minimum C content, H/C and O/C ratios (molar H/Corg < 0.7 for EBC-Agro; < 0.6 for EBC-Material), PAH limits (<12 mg/kg 16-EPA PAHs for EBC-Agro)."
  ibi = "International Biochar Initiative (IBI) standard — parallel voluntary certification; IBI Basic / Premium tiers."
  key-indicators = "Stable aromatic carbon fraction (correlates with molar H/Corg and O/Corg ratios — lower ratios = more condensed aromatic structure = more persistent). Production temperature is a primary driver: higher peak temperature → lower H/Corg → more stable char."
  feedstock-matters = "Wood, crop residues, manure, sewage sludge — all give different char properties. Manure-derived biochar has higher nutrient content; sludge-derived has heavy-metal risk requiring careful screening. Feedstock choice is not lattice-constrained."
  |> "[@x_lehmann_joseph_2009]"

# ── §2 Soil amendment effects — honest summary ───────────────────────

@D dom_cec := "cation exchange capacity effects — real but modest" :: domain [ok]
  what = "Biochar surfaces carry negative charge (especially after oxidative ageing in soil), increasing soil CEC — the capacity to retain K⁺, Ca²⁺, Mg²⁺, NH₄⁺ against leaching."
  magnitude = "CEC of fresh biochar varies widely (10–200 cmol/kg depending on feedstock and temperature); mixed into soil at typical application rates (5–50 t/ha), the net soil CEC increase is modest — weighted by the mass fraction of biochar in the soil."
  glaser-2002 = "Glaser, Lehmann & Zech (2002) documented elevated CEC in Terra Preta vs adjacent soils and characterised the pyrogenic carbon contribution — aged biochar in Terra Preta had much higher CEC than fresh biochar due to decades of surface oxidation."
  honesty = "CEC improvement is real but not universal or large in magnitude per single application; it builds with multiple applications and ageing. Do not conflate aged Terra Preta CEC with that of a single fresh-biochar application."
  |> "[@x_glaser_lehmann_2002]"

@D dom_water_holding := "water-holding capacity — context-dependent, not universal" :: domain [ok]
  mechanism = "Biochar's porous structure (BET surface area typically 10–500 m²/g for agronomic chars) can increase soil porosity and potentially improve water retention in coarse sandy soils; but in fine-textured soils may have little effect or reduce plant-available water."
  meta-analysis = "Jeffery et al. (2015, GCB Bioenergy) updated analysis confirmed that water-holding effects are soil-texture-dependent; sandy soils show more consistent improvement; clay soils show mixed results. Effect sizes are small to moderate."
  dryland-context = "In dryland/semi-arid soils (often coarse-textured, degraded), there is a mechanistic rationale for water-retention benefit, but field evidence is site-specific and studies are sparse relative to humid-tropical work."
  honesty = "Water-holding-capacity improvement is commonly cited in biochar advocacy but the evidence is genuinely heterogeneous. Reporting a single percentage improvement without soil-texture qualification is misleading."
  |> "[@x_jeffery_2011]"

@D dom_microbiome := "soil microbiome effects — stimulatory but mechanism unclear" :: domain [ok]
  observations = "Biochar application has been associated with increased microbial biomass, shifts in microbial community composition, and sometimes enhanced mycorrhizal colonisation in pot and field experiments."
  mechanisms-proposed = "Proposed mechanisms include: habitat provision (pores), reduced toxin/pesticide availability (adsorption), pH buffering, improved nutrient retention near microbial communities. No single mechanism is confirmed as dominant."
  honesty = "Microbiome effects are real-signal but the published literature shows high variability across soils, biochar types, and measurement methodologies. Mechanistic understanding is still developing. Not a universal benefit."
  |> "[@x_lehmann_joseph_2009]"

@D dom_nutrient_retention := "nutrient retention and leaching reduction" :: domain [ok]
  mechanism = "High-charge-density biochar surfaces can adsorb NH₄⁺ (cation) and reduce leaching; some biochars have P sorption capacity. Effect is feedstock-, pH-, and soil-mineralogy-dependent."
  n-retention = "N-retention via NH₄⁺ sorption on negatively charged biochar surface — documented in lab studies; field-scale reduction of N leaching is less consistently demonstrated."
  p-dynamics = "P behaviour is complex: some biochars release plant-available P (from feedstock P); others adsorb P; still others have negligible effect. Depends on feedstock P content and biochar's surface chemistry."
  honesty = "Nutrient-retention effects are plausible and mechanistically grounded, but field-scale quantification is noisy and context-dependent. Not a universally guaranteed benefit."
  |> "[@x_jeffery_2011] · [@x_woolf_2010]"

# ── §3 Yield response — honest meta-analysis reading ─────────────────

@D dom_yield_response := "crop yield response to biochar — heterogeneous meta-analysis" :: domain [ok]
  jeffery-2011 = "Jeffery et al. (2011) Agric Ecosyst Environ 144:175–187 — the foundational yield meta-analysis (~16% mean increase across all studies, later commonly quoted as ~10% in more conservative readings). KEY FINDING: very high between-study heterogeneity (wide confidence intervals). Effects were highly dependent on soil type, biochar type, crop, and climate region."
  tropics-vs-temperate = "Consistently reported pattern across meta-analyses: tropical and sub-tropical soils (especially acidic, low-fertility, coarse-textured) show larger positive yield responses. Temperate soils show smaller and less consistent effects. Some temperate studies show negative yield effects (e.g. N immobilisation by high-C/low-N biochar)."
  soil-ph-dependence = "Biochar typically raises soil pH (liming effect); in acid tropical soils this is a benefit (aluminium toxicity reduction); in already-near-neutral temperate soils, over-liming can reduce yield."
  honesty-required = "A meta-analysis mean of ~10–16% conceals effects ranging from substantially negative to >50% positive depending on conditions. Reporting the mean without the variance distribution and moderating factors is a common biochar hype pattern. This tape reports it with its heterogeneity explicit."
  crane-droesch-2013 = "Crane-Droesch et al. (2013) Environ Res Lett 8:044049 — meta-regression identifying factors moderating yield response; confirmed context-dependence; found low-fertility tropical soils and coarse textures as positive-response drivers; negative or null responses common in better-managed temperate systems."
  |> "[@x_jeffery_2011] · [@x_crane_droesch_2013]"

# ── §4 Carbon sequestration — real but conditional ────────────────────

@D dom_carbon_seq := "carbon sequestration — real potential with important caveats" :: domain [ok]
  woolf-2010 = "Woolf et al. (2010) Nature Communications 1:56 — global modelling of sustainable biochar's theoretical climate-mitigation potential. Estimated upper-bound of ~1.8 Gt CO₂-equivalent per year could be avoided if biochar production were scaled globally using sustainable biomass; this represents ~12% of current anthropogenic GHG emissions at maximum sustainable deployment."
  recalcitrance = "Biochar's persistence in soil (mean residence time) depends primarily on production temperature (higher temp → more condensed aromatics → more stable) and the soil/climate environment. Half-lives estimated from isotope-labelled biochar degradation and Terra Preta age-dating vary from decades to centuries to millennia."
  singh-2012 = "Singh et al. (2012) Glob Change Biol 18:2659–2676 — measured biochar mineralisation activation energies; mid-range values (~100 kJ/mol) correspond to estimated half-lives of several hundred years at 25°C. But this is a lab-to-field extrapolation under constant conditions — field conditions (wetting/drying, freeze/thaw, soil fauna disturbance) accelerate physical breakdown and may shorten persistence."
  production-footprint = "Biochar production requires energy (kiln heating), and biomass collection/transport has a carbon footprint. The net carbon balance depends on feedstock (would the biomass otherwise decompose rapidly anyway?), production efficiency, and what the energy input displaces. Not all biochar production is net-carbon-negative."
  honesty = "Woolf 2010's 1.8 Gt/yr estimate is a theoretical maximum under optimistic but sustainable assumptions — it is not a current trajectory, not a committed offset, and requires massive feedstock mobilisation. Real-world biochar carbon sequestration to date is a small fraction of this. The permanence assumption under field conditions adds further uncertainty."
  |> "[@x_woolf_2010] · [@x_singh_2012]"

# ── §5 Dryland restoration — techniques and evidence ─────────────────

@D dom_dryland_restoration := "dryland restoration — landscape-scale techniques" :: domain [ok]
  definition = "Drylands = arid, semi-arid, and dry sub-humid regions (UNESCO aridity index <0.65); cover ~41% of global land area and support ~2.5 billion people. Degradation via overgrazing, vegetation loss, soil erosion, and desertification is a global land-degradation challenge."
  fmnr = "Farmer-managed natural regeneration (FMNR) — low-cost, high-impact technique documented extensively in the Sahel (Niger, Burkina Faso, Ethiopia): protecting and managing naturally regenerating trees and shrubs on farmland rather than planting new ones. Reij & Garrity (2016) documented multi-million-hectare FMNR expansion in Niger — one of the largest land restoration successes on record."
  half-moon-contour-ridges = "Half-moon (demi-lune) contour ridges (zai pits / tassa) — traditional water-harvesting earthworks on degraded dryland soils; concentrate rainfall runoff to planted zones; documented in Burkina Faso and Niger. Dramatically improve seedling establishment in semi-arid degraded land."
  check-dams = "Gabion check dams and rock bunds in dryland watercourses slow runoff, reduce gully erosion, and promote groundwater recharge; traditional water-harvesting infrastructure."
  niger-success = "Niger reforestation case — documented by Chris Reij and colleagues: farmer-managed tree protection across >5 million ha in the Zinder and Maradi regions of Niger between 1983 and 2006, associated with improved crop yields and tree cover. Referenced in Reij & Garrity 2016 era."
  sand-dune-stabilisation = "Sahel sand-dune stabilisation via windbreaks (Acacia or adapted exotics), fencing, and surface roughening; documented programmes in Niger and Senegal."
  biochar-role = "Biochar's role in dryland restoration is mechanistically plausible (water retention in coarse, degraded soils; CEC improvement in low-fertility arid soils; liming in acid drylands) but field evidence specifically in dryland restoration contexts is much thinner than humid-tropical literature. Context-dependence applies doubly here."
  |> "[@x_reij_garrity_2016]"

@D dom_invasive_feedstock := "invasive-species biomass as biochar feedstock — South Africa context" :: domain [ok]
  prosopis = "Prosopis glandulosa / P. juliflora (mesquite) — invasive legume in semi-arid South Africa, Karoo and Nama-Karoo bioregions; can produce 30–80 t/ha aboveground biomass; aggressively colonises riverbeds and grazing land."
  wfwater = "South Africa's Working for Water (WfW) programme — state-funded invasive-species clearing programme; provides a feedstock supply channel. Cleared biomass that would otherwise be left or burned is a candidate biochar feedstock, which partially offsets the carbon footprint of production."
  acacia = "Acacia mearnsii (black wattle) — invasive in South African riparian zones and fynbos; cleared under WfW; bark has 35–45% tannin (commercial value separately). Pyrolysis volatile speciation differs from non-tanniniferous feedstocks."
  stacking-value = "The WfW + biochar combination offers a value-stacking hypothesis: invasive-clearing subsidy + biochar soil amendment + possible carbon credit. This is a plausible systems argument but each component requires independent validation — the combined economics have not been rigorously published at scale."
  honesty = "The South Africa invasive-biomass-to-biochar pathway is conceptually coherent and has pilot-scale demonstrations, but robust peer-reviewed multi-year field evidence for the stacked value proposition at commercial scale is not yet established as of the knowledge cutoff."
  |> "[@x_woolf_2010]"

# ── §6 Real-limits anchors ────────────────────────────────────────────

@D lim_yield_heterogeneity := "yield response high heterogeneity — not a universal positive" :: real-limit [ok required]
  wall = "SOFT WALL (context-dependent — not a hard physical ceiling but a practical limit on predictability)"
  statement = "Meta-analysis of biochar yield effects (Jeffery et al. 2011) shows mean positive response but very high between-study variance. In temperate, high-fertility, well-managed agricultural soils the expected yield benefit from biochar is frequently small, absent, or negative. The mean result cannot be applied universally without soil-type and management qualification."
  consequence = "A decision to apply biochar in a temperate high-fertility context expecting the tropical-average yield benefit is scientifically unjustified. Site-specific characterisation is required before any yield prediction."
  |> "[@x_jeffery_2011] · [@x_crane_droesch_2013]"

@D lim_pyrolysis_energy := "pyrolysis energy and carbon footprint of production — HARD cost" :: real-limit [ok required]
  wall = "HARD WALL (thermodynamic — cannot be zeroed)"
  statement = "Slow pyrolysis requires sustained heating of feedstock to 300–700 °C; the energy must come from somewhere. In practice, syngas and bio-oil co-products can supply much or all of the kiln energy (self-sustaining thermochemical loop at scale), but capital cost, operational expertise, and transport logistics are real costs. Off-grid or low-scale kilns often use external fuel."
  consequence = "The net carbon and energy balance of biochar production is not automatically positive — it depends on feedstock (avoided decomposition emissions), kiln efficiency (energy recovery from co-products), and what the energy input would otherwise have been. 'Carbon-negative' is conditional, not universal."
  |> "[@x_woolf_2010] · [@x_antal_gronli_2003]"

@D lim_permanence_conditional := "carbon sequestration permanence — conditional on soil and climate" :: real-limit [ok required]
  wall = "SOFT WALL (biogeochemical — long but uncertain under field conditions)"
  statement = "Biochar carbon persistence in soil is not uniform. Lab-based estimates (Arrhenius kinetics of mineralisation, Singh et al. 2012) project long half-lives under stable conditions, but field conditions introduce physical breakdown (wetting/drying, freeze/thaw, tillage disturbance, soil fauna), surface oxidation (accelerating solubility), and possible leaching of dissolved black carbon. Half-life distributions are wide and site-specific."
  consequence = "Carbon-credit methodologies that assume 100-year or 1000-year permanence are applying model projections, not confirmed field measurements over those timescales. Monitoring, reporting, and verification (MRV) frameworks (Verra VM0044, Puro.earth) attempt to manage this uncertainty with buffers, not eliminate it."
  |> "[@x_singh_2012] · [@x_woolf_2010]"

@D lim_biomass_competition := "biomass feedstock sustainability and competition" :: real-limit [ok required]
  wall = "HARD WALL (resource competition)"
  statement = "Biochar production at scale requires substantial biomass feedstock. Not all biomass is sustainably available for pyrolysis — agricultural residues have soil-cover and organic-matter-return functions; dedicated energy crops compete with food production for land; forest biomass raises deforestation risk if not carefully governed."
  consequence = "Woolf et al. (2010) explicitly defined a 'sustainable biochar' scenario — only using biomass that would otherwise rapidly decompose (crop residues, green waste, invasive-species biomass) and excluding biomass that would better remain in soil or forest. The global mitigation potential shrinks substantially under non-sustainable scenarios."
  |> "[@x_woolf_2010]"

@D lim_transport_cost := "transport costs limit deployment density" :: real-limit [ok required]
  wall = "SOFT WALL (logistic/economic — site-specific)"
  statement = "Biochar has low bulk density (typically 0.25–0.35 g/cm³ for agronomic chars) relative to its volume, making transport costly per tonne. Optimal kiln siting is near feedstock source AND near application area, which in dryland contexts may not be the same location. Transport costs can make the economics unviable at distances typical of rural dryland landscapes."
  consequence = "Decentralised, community-scale kilns near both feedstock and application sites are the logistically coherent model for dryland contexts — but this constrains the scale of any single operation and makes quality-control certification more challenging."
  |> "[@x_lehmann_joseph_2009]"

# ── §7 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-biochar" :: governance [required deny:write]
  pattern = "Deriving biochar or dryland-restoration quantities (char yield %, soil amendment ratios, sequestration rates, yield improvements, Terra Preta properties, pyrolysis temperature counts) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'char yield = 33% because J₂/σ=2' or '6 soil amendment mechanisms because n=6'."
  why = "This is the violation the pre-rewrite BIOCHAR-DRYLAND-RESTORATION.tape committed: a lattice-tautology stub with rows of `x=\"n=6\" · x=\"EXACT\"` carrying zero real citations. hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real biochar/soil/dryland-restoration science (this tape's @X entries). Pyrolysis temperature ranges, char yield envelopes, yield responses, and sequestration estimates are empirically determined quantities from published literature — not lattice-derived. The lattice may only be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "biochar science has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: biochar and dryland restoration expose NO natural n=6 invariant. Char yield (25–40% of feedstock) is set by pyrolysis thermochemistry (Antal & Grønli 2003). Yield responses are heterogeneous meta-analysis outcomes (Jeffery et al. 2011). Carbon residence times are Arrhenius-kinetics projections (Singh et al. 2012). Soil CEC improvement depends on mass-fraction mixing and surface oxidation. Terra Preta formed over centuries of indigenous settlement — the number of identified contributing factors is an archaeological reconstruction, not a lattice partition. Dryland restoration techniques (FMNR, half-moon ridges, check dams, sand-dune stabilisation) are engineering/agro-ecological practices documented by field researchers — not derived from σ/τ/φ/J₂. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is DECLINED here as a derivation tool. This honesty is the corrective for the audited lattice-tautology stub."

# ── §8 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 tropical acid-soil yield benefit" :: prediction [ok]
  claim = "Biochar amendment (10–50 t/ha, wood-derived, slow pyrolysis 400–550 °C) of an acid (pH < 5.5), low-CEC, coarse-textured tropical or subtropical soil will show a statistically detectable yield improvement for a staple legume or cereal within 2 cropping seasons."
  falsifier = "If a properly randomised controlled field trial meeting these specifications (acid, coarse-textured, tropical, wood biochar 400–550 °C) shows no significant yield benefit vs unamended control after 2 seasons, [@x_jeffery_2011]'s tropical-soil moderator effect is overstated for this context."
  source = "[@x_jeffery_2011] · [@x_crane_droesch_2013]"

@D tp_2 := "TP-2 temperate high-fertility null or negative yield response" :: prediction [ok]
  claim = "Biochar amendment of a temperate, near-neutral, well-fertilised agricultural soil will produce no statistically significant yield improvement and may show transient reduction (N immobilisation) in at least some crops in the first season post-application."
  falsifier = "If a properly powered RCT in a temperate, well-managed (high-fertility, near-neutral pH) system shows a consistent positive yield response comparable to tropical-soil meta-analysis means, the soil-type moderator documented by Jeffery 2011 / Crane-Droesch 2013 is wrong."
  source = "[@x_jeffery_2011] · [@x_crane_droesch_2013]"

@D tp_3 := "TP-3 sequestration permanence shorter under physical disturbance" :: prediction [ok]
  claim = "Biochar carbon persists substantially longer (multi-decade to century timescales) in undisturbed soils than in annually tilled agricultural soils, where physical comminution and increased surface area accelerate oxidation and dissolved black-carbon leaching."
  falsifier = "If a long-running paired experiment (tilled vs untilled biochar-amended plots) shows no significant difference in biochar carbon remaining after 10–20 years, [@lim_permanence_conditional]'s tillage-disturbance qualifier is unsupported."
  source = "[@x_singh_2012] · [@x_woolf_2010]"

# ── §9 Cross-links ────────────────────────────────────────────────────

@X x_agriculture_sibling := "AGRICULTURE.tape" :: sibling-tape [active]
  scope = "Field agronomy substrate — soil science, nutrient cycling, Liebig's law, photosynthesis; biochar-dryland-restoration is a specialised soil-amendment and carbon-sequestration sub-domain of this agronomy foundation"

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real biochar/soil science, in-silico knowledge SSOT only, lattice declined as derivation tool, hype-discipline applied."

# ── §10 External citations (real, landmark literature) ─────────────────
# Where exact bibliographic detail is not asserted with confidence,
# the entry names primary author + era only and says so explicitly.

@X x_jeffery_2011 := "Jeffery et al. 2011" :: literature [active]
  ref = "Jeffery S, Verheijen FGA, van der Velde M, Bastos AC. A quantitative review of the effects of biochar application to soils on crop productivity using meta-analysis. Agriculture Ecosystems & Environment 2011;144:175–187. (foundational biochar-yield meta-analysis; ~16% mean yield increase, high between-study heterogeneity; tropical acid-soil benefit documented; temperate results more mixed)"

@X x_crane_droesch_2013 := "Crane-Droesch et al. 2013" :: literature [active]
  ref = "Crane-Droesch A, Abiven S, Jeffery S, Torn MS. Heterogeneous global crop yield response to biochar: a meta-regression analysis. Environmental Research Letters 2013;8:044049. (meta-regression identifying moderating factors for biochar yield response: soil texture, fertility, climate region; confirms context-dependence)"

@X x_woolf_2010 := "Woolf et al. 2010" :: literature [active]
  ref = "Woolf D, Amonette JE, Street-Perrott FA, Lehmann J, Joseph S. Sustainable biochar to mitigate global climate change. Nature Communications 2010;1:56. (global modelling of theoretical biochar climate-mitigation potential; defines sustainable-biochar scenario ~1.8 Gt CO₂e/yr; feedstock sustainability constraints explicit)"

@X x_antal_gronli_2003 := "Antal & Grønli 2003" :: literature [active]
  ref = "Antal MJ, Grønli M. The art, science, and technology of charcoal production. Industrial & Engineering Chemistry Research 2003;42:1619–1640. (definitive review of slow-pyrolysis char yield — Table 4 char-yield envelope; temperature-dependence of yield; carbon-retention in char; fundamental reference for pyrolysis thermochemistry)"

@X x_singh_2012 := "Singh et al. 2012" :: literature [active]
  ref = "Singh BP, Cowie AL, Smernik RJ. Biochar carbon stability in a clayey soil as a function of feedstock and pyrolysis temperature. Global Change Biology 2012;18:2659–2676. (measured biochar mineralisation kinetics and activation energies; E_a 75–120 kJ/mol range; basis for estimated half-life projections of several hundred years at 25°C)"

@X x_glaser_lehmann_2002 := "Glaser, Lehmann & Zech 2002" :: literature [active]
  ref = "Glaser B, Lehmann J, Zech W. Ameliorating physical and chemical properties of highly weathered soils in the tropics with charcoal — a review. Biology and Fertility of Soils 2002;35:219–230. (Terra Preta pyrogenic carbon, CEC characteristics, comparison of biochar-enriched Amazonian dark earths to adjacent oxisols; foundational Terra Preta characterisation paper)"

@X x_lehmann_joseph_2009 := "Lehmann & Joseph (Biochar for Environmental Management, 2009/2015 era)" :: literature [active]
  ref = "Lehmann J, Joseph S (eds). Biochar for Environmental Management: Science, Technology and Implementation. Earthscan/Routledge, 1st ed. 2009; 2nd ed. 2015. (standard textbook reference for biochar production, soil effects, Terra Preta, carbon sequestration, and quality standards; Johannes Lehmann, Cornell University — primary editor/author of the field)"

@X x_reij_garrity_2016 := "Reij & Garrity (farmer-managed natural regeneration, 2016 era)" :: literature [active]
  ref = "Reij C, Garrity D. Scaling up farmer-managed natural regeneration in Africa to restore degraded landscapes. Biotropica 2016;48:834–843. (FMNR documentation in the Sahel — Niger multi-million-hectare farmer-managed tree regeneration as one of the largest dryland restoration successes; Chris Reij, VU Amsterdam / World Resources Institute; primary author/era)"
