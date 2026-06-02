#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# AGRICULTURE.tape — architecture-current (editable per v1.2)
# Event history → AGRICULTURE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "agriculture" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Bio family · agriculture substrate — crop/soil/agronomy science knowledge SSOT"
  brief = "photosynthesis · plant nutrition · soil science · nitrogen cycle · water relations · IPM · crop genetics — real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "AGRICULTURE.log.tape"
  scope = "in-silico knowledge SSOT · NOT agronomic advice / not a farming protocol / not an agro-regulatory or pesticide-use claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-15 — see AGRICULTURE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico agriculture substrate. Agronomic figures (efficiency ceilings, nutrient values, yield ranges) are paraphrased from published crop/soil-science literature for modeling context ONLY — they are NOT a farming protocol, fertiliser prescription, pesticide-use guidance, or cultivar recommendation. Real field decisions require local soil tests, extension agronomists, and jurisdiction-specific regulation."

# ── §1 Photosynthesis & carbon-fixation pathways ──────────────────────

@D dom_photosynthesis := "photosynthesis — the primary productivity engine" :: domain [ok]
  reaction = "Light-driven: 6 CO₂ + 6 H₂O + photons → C₆H₁₂O₆ + 6 O₂ (net, simplified). The stoichiometric '6' here is fixed organic chemistry of hexose, NOT a lattice value — see [@n6_honest_stance]."
  two-stages = "Light reactions (thylakoid: PSII/PSI, water splitting, ATP + NADPH) → Calvin–Benson cycle (stroma: RuBisCO carboxylation of RuBP, reduction, regeneration)."
  rubisco-limit = "RuBisCO is slow and also fixes O₂ (photorespiration), capping C3 carbon-use efficiency — a real enzymatic constraint, not a designed ceiling. See [@lim_photo_efficiency]."
  |> "[@x_farquhar_1980] · [@x_zhu_long_ort_2010]"

@D mech_c3_c4_cam := "C3 / C4 / CAM carbon-concentrating strategies" :: mechanism [ok]
  c3 = "Direct Calvin fixation (most plants: wheat, rice, soybean). Loses carbon to photorespiration as temperature/aridity rise."
  c4 = "Spatial CO₂ concentration via PEP carboxylase + bundle-sheath anatomy (maize, sorghum, sugarcane). Higher water- and N-use efficiency in hot/high-light climates; higher light-saturated ceiling than C3."
  cam = "Temporal separation — nocturnal CO₂ uptake stored as malate, daytime decarboxylation with stomata closed (cacti, pineapple, agave). Maximises water-use efficiency in arid climates at a productivity cost."
  honesty = "Three pathways is a biochemical taxonomy of evolved strategies, NOT a φ/τ/lattice partition; intermediates (C3–C4) exist, so even 'three' is a simplification."
  |> "[@x_hatch_slack_1970] · [@x_zhu_long_ort_2010]"

# ── §2 Plant nutrition & the law of the minimum ───────────────────────

@D mech_liebig_minimum := "Liebig's law of the minimum" :: mechanism [ok]
  statement = "Plant growth is limited by the scarcest essential resource relative to demand, not by total nutrients. Adding an abundant nutrient does not raise yield if a different one is limiting."
  origin = "Articulated in the mineral-nutrition tradition of von Liebig (mid-19th-century agricultural chemistry); the 'barrel with unequal staves' is the canonical teaching metaphor."
  refinement = "Mitscherlich/Liebscher later showed the response is a smooth diminishing-returns curve, not a hard knife-edge, and that factors interact — but 'fix the limiting factor first' remains the governing agronomic principle."
  |> "[@x_von_liebig_1840]"

@D dom_essential_nutrients := "essential plant nutrients (macro / micro)" :: domain [ok]
  macro-primary = "N, P, K — required in largest amounts; the basis of NPK fertiliser grades."
  macro-secondary = "Ca, Mg, S."
  micronutrients = "Fe, Mn, Zn, Cu, B, Mo, Cl, Ni — required in trace amounts but each can be the limiting factor (Liebig)."
  count-honesty = "~17 elements are classically termed essential (Arnon–Stout criteria); this count is an evolving biological classification, not a lattice constant — beneficial elements (Si, Na, Co) blur the boundary."
  function = "N → proteins/chlorophyll/nucleic acids; P → ATP/nucleic acids/membranes; K → osmoregulation, stomatal/enzyme function."
  |> "[@x_marschner_2012]"

@D mech_nutrient_cycling := "NPK & micronutrient cycling in the soil–plant system" :: mechanism [ok]
  n-forms = "Plants take up N mainly as NO₃⁻ and NH₄⁺; soil N turns over via mineralisation, nitrification, immobilisation, leaching, denitrification."
  p-behaviour = "P is strongly fixed by Fe/Al oxides (acid soils) or Ca (alkaline soils) → low mobility, residual buildup, legacy-P pollution risk."
  k-behaviour = "K cycles between solution, exchangeable (CEC-held), and mineral-fixed pools; availability depends on clay mineralogy."
  efficiency = "Nutrient-use efficiency (fraction of applied nutrient captured in harvest) is typically well below 100% — unrecovered N/P is the dominant agro-environmental loss pathway (eutrophication, N₂O)."
  |> "[@x_marschner_2012]"

# ── §3 Soil science ───────────────────────────────────────────────────

@D dom_soil_texture := "soil texture, structure & cation exchange" :: domain [ok]
  texture = "Sand/silt/clay fractions (USDA textural triangle) set water retention, drainage, aeration and workability."
  structure = "Aggregation into peds (organic matter + biota + clay) governs porosity, infiltration and root penetration — degradable by tillage/compaction."
  cec = "Cation exchange capacity: negatively charged clay + organic-matter surfaces retain K⁺, Ca²⁺, Mg²⁺, NH₄⁺ against leaching. Higher CEC ≈ higher nutrient-buffering, but is soil-mineralogy-determined, not lattice-set."
  ph = "Soil pH controls nutrient availability (P most available ≈ pH 6–7; micronutrient solubility shifts strongly with pH) and microbial activity."
  |> "[@x_brady_weil_2016]"

@D cls_soil_horizons := "soil horizons (the pedological profile)" :: classification [ok]
  master-horizons = "O (organic), A (topsoil/humus + leaching), E (eluvial/leached), B (illuvial accumulation), C (weathered parent material), R (bedrock)."
  meaning = "Horizons record pedogenesis — weathering, translocation, organic accumulation over time/climate/parent-material/topography/biota (the soil-forming factors)."
  honesty = "Horizon letters are a descriptive pedological taxonomy; not every profile shows every horizon, and the set is a classification convention, not an n=6 partition ([@n6_honest_stance])."
  |> "[@x_brady_weil_2016]"

# ── §4 Nitrogen cycle & biological N fixation ─────────────────────────

@D mech_nitrogen_cycle := "the nitrogen cycle" :: mechanism [ok]
  steps = "N₂ fixation → ammonia/ammonium → nitrification (NH₄⁺→NO₂⁻→NO₃⁻) → plant/microbial assimilation → ammonification (mineralisation) → denitrification (NO₃⁻→N₂/N₂O)."
  bottleneck = "Atmospheric N₂ is ~78% of air but inert (triple bond); the rate-limiting step for the biosphere is breaking N≡N to bioavailable forms."
  loss-terms = "Leaching (NO₃⁻ to groundwater), volatilisation (NH₃), denitrification (N₂O — a potent greenhouse gas) — these set the real efficiency ceiling on N fertilisation."
  |> "[@x_galloway_2004]"

@D mech_bnf := "biological nitrogen fixation & the Haber–Bosch context" :: mechanism [ok]
  bnf = "Diazotrophs (rhizobia in legume nodules; free-living/associative bacteria; cyanobacteria) reduce N₂→NH₃ via nitrogenase at an ATP cost (~16 ATP per N₂, plus reductant) — a hard bioenergetic price, not a lattice ratio."
  symbiosis = "Legume–rhizobium symbiosis underlies crop rotation's soil-N benefit and reduces synthetic-N demand."
  haber-bosch = "Industrial Haber–Bosch (high T/P, Fe catalyst) made synthetic N fertiliser the dominant reactive-N input to global agriculture, roughly doubling the natural terrestrial N-fixation flux — with energy cost and N₂O/eutrophication externalities."
  honesty = "Haber–Bosch dependence is a documented agronomic-historical fact; the 'roughly doubled reactive N' framing is paraphrased from the global N-cycle literature, not a derived constant."
  |> "[@x_galloway_2004] · [@x_smil_2001]"

# ── §5 Water relations & evapotranspiration ───────────────────────────

@D mech_water_relations := "plant water relations & evapotranspiration" :: mechanism [ok]
  transport = "Water moves down a water-potential gradient: soil → root → xylem (cohesion–tension) → leaf → atmosphere (transpiration through stomata)."
  et = "Evapotranspiration (ET) = soil evaporation + plant transpiration; reference ET is commonly estimated with the Penman–Monteith approach from climate variables and crop coefficients."
  wue = "Water-use efficiency (biomass or yield per unit water) is bounded by the unavoidable CO₂-for-H₂O exchange at open stomata; C4/CAM raise WUE by concentrating CO₂ or shifting uptake in time."
  deficit = "Crop water deficit reduces yield non-linearly, with stage-specific sensitivity (flowering/grain-fill typically most sensitive) — agronomic phenology, not a lattice schedule."
  |> "[@x_allen_1998] · [@x_zhu_long_ort_2010]"

# ── §6 Crop protection & integrated pest management ───────────────────

@D dom_ipm := "integrated pest management (IPM)" :: domain [ok]
  principle = "Combine biological, cultural, physical/mechanical and chemical controls; use economic thresholds; deploy pesticides as a last, targeted resort to slow resistance and protect non-target organisms."
  resistance = "Pest/pathogen/weed resistance evolves under selection pressure (single-mode-of-action overuse) — a real evolutionary constraint that mandates rotation of modes of action and refuges."
  bt-context = "Bt (Bacillus thuringiensis) Cry/Vip insecticidal proteins (transgenic or sprayed) are mode-of-action-specific; durability depends on refuge strategy and resistance management — an agronomic/evolutionary problem, NOT a lattice-numbered toxin set."
  honesty = "Pest-management is risk/threshold reasoning; this tape does not recommend any product or rate (see [@scope_disclaimer])."
  |> "[@x_stern_1959]"

# ── §7 Crop genetics, rotation & the Green Revolution ─────────────────

@D mech_crop_rotation := "crop rotation & cropping-system agronomy" :: mechanism [ok]
  benefits = "Breaks pest/disease/weed cycles, diversifies rooting/residue, and (with legumes) adds biologically fixed N; improves soil structure and reduces input dependence."
  legume-n = "Rotating a legume credits the following crop with fixed N, partially substituting synthetic fertiliser — quantitatively soil/climate-dependent, not a fixed lattice number."
  honesty = "Rotation length/sequence is an agronomic design choice (2-, 3-, 4-course historically common) optimised to local constraints — the historical numbers are convention, not n=6-derived."
  |> "[@x_karlen_1994]"

@D dom_green_revolution := "the Green Revolution & semi-dwarf cereals" :: domain [ok]
  borlaug = "Borlaug's semi-dwarf, disease-resistant, fertiliser-responsive wheat (and parallel IRRI semi-dwarf rice) sharply raised cereal yields across the mid-20th century — Norman Borlaug, 1970 Nobel Peace Prize."
  mechanism = "Reduced-height (Rht / sd1) alleles shorten straw → lodging resistance → plants tolerate high N + irrigation and partition more biomass to grain (higher harvest index)."
  caveats = "Gains came with higher input dependence (fertiliser, irrigation, agrochemicals), genetic-uniformity risk, and uneven regional/equity outcomes — a documented historical trade-off, not an idealised constant."
  |> "[@x_borlaug_2000] · [@x_evenson_gollin_2003]"

@D cmp_yield_gap := "yield-gap analysis" :: comparison [ok]
  definition = "Yield gap = water-limited/irrigated potential yield (best cultivar + non-limiting management) minus actual farm yield in the same environment."
  use = "Decomposes the gap into closeable agronomic deficits (nutrients, water, pest, timing) vs the biophysical ceiling that no management closes."
  honesty = "Potential yield is a site/climate/cultivar-specific modelled quantity (e.g. via the Global Yield Gap Atlas methodology), an empirical envelope — explicitly NOT a lattice-fixed number."
  |> "[@x_vanittersum_2013]"

# ── §8 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_liebig := "the limiting-factor law (Liebig's minimum)" :: real-limit [ok required]
  wall = "HARD LAW (resource-limitation principle)"
  statement = "Yield is governed by the scarcest essential input relative to demand. No amount of a non-limiting input substitutes for the limiting one; correcting it merely shifts the limit to the next factor."
  consequence = "Optimisation is sequential bottleneck removal under diminishing returns — an agronomic law, not an n=6 invariant."
  |> "[@x_von_liebig_1840]"

@D lim_photo_efficiency := "photosynthetic light-use-efficiency ceiling" :: real-limit [ok required]
  wall = "HARD WALL (thermodynamic/biochemical)"
  statement = "The theoretical maximum conversion of solar energy to plant biomass is low — on the order of a few percent (commonly cited as roughly ~4.6% for C3 and ~6% for C4 of total solar energy under ideal conditions), and real field crops achieve well below even that."
  losses = "Energy is lost to non-absorbed/non-PAR wavelengths, reflection/transmission, photochemical inefficiency, photorespiration (C3), and respiration — each a physical/biochemical loss term, not an adjustable lattice parameter."
  consequence = "There is a physics-and-enzymology ceiling on biomass per unit incident light; agronomy closes the gap toward it but cannot exceed it. Improvement targets the loss terms (e.g. RuBisCO, photorespiratory bypasses), not the ceiling itself."
  |> "[@x_zhu_long_ort_2010]"

@D lim_finite_resources := "finite arable land, water & mineral nutrients" :: real-limit [ok required]
  wall = "HARD WALL (resource finitude)"
  land = "Arable land is finite and degrading (erosion, salinisation, sealing, organic-matter loss); expansion trades against forest/biodiversity carbon."
  water = "Freshwater for irrigation is finite and competed-for; aquifer depletion is locally irreversible on human timescales."
  p-finitude = "Mined phosphate rock is a non-renewable, geographically concentrated finite reserve — no synthetic substitute for the P element."
  consequence = "Agricultural output is bounded by finite land/water/mineral stocks; these are geophysical limits, not lattice values."
  |> "[@x_cordell_2009]"

@D lim_diminishing_returns := "yield-gap & diminishing returns" :: real-limit [ok required]
  wall = "SOFT WALL (economic/biophysical asymptote)"
  statement = "Yield response to added inputs is concave (Mitscherlich-type): each increment yields less, asymptoting toward the environment's potential yield. Beyond the agronomic optimum, extra input lowers net return and raises loss/pollution."
  consequence = "The closeable yield gap shrinks toward a biophysical ceiling; 'more input' is not indefinitely 'more yield'. An empirical response law, not an n=6 product."
  |> "[@x_vanittersum_2013]"

@D lim_climate_envelope := "crop climate envelope" :: real-limit [ok required]
  wall = "HARD WALL (agro-climatic)"
  statement = "Each crop has temperature/photoperiod/water bounds (cardinal temperatures, vernalisation/photoperiod requirements, frost-free season, heat-stress thresholds at flowering) outside which yield collapses regardless of management."
  consequence = "Where a crop can be productively grown is set by climate and phenology — a biophysical envelope, not a lattice schedule. Climate change shifts (does not abolish) these envelopes."
  |> "[@x_lobell_2011]"

# ── §9 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-agronomy" :: governance [required deny:write]
  pattern = "Deriving agronomic quantities (yield %, nutrient ratios, rotation length, growth-stage counts, soil-horizon counts) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'yield = 100% because J₂=24' or '6 macronutrients because n=6' or '12-month cycle = σ=12'."
  why = "This is exactly the fabrication the pre-rewrite AGRICULTURE.tape committed (~1112 lines of `@D row_* x=\"n=6\" x=\"…\" x=\"EXACT\"` lattice-tautology — see AGRICULTURE.log.tape audit). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real agronomy/soil/crop-science sources (this tape's @X entries). Stoichiometric/calendar numbers (6 CO₂ in hexose, 12-month year, ~17 essential elements) are domain chemistry/convention; the lattice may only be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "agriculture has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: agriculture exposes NO natural n=6 invariant. Crop cycles (annual/biennial/perennial, season-driven), NPK and the ~17 essential elements, soil horizons (O/A/E/B/C/R), growth stages (e.g. BBCH/Feekes scales), and rotation lengths are AGRONOMY — set by plant biology, soil chemistry, climate and historical convention, NOT lattice-derived. Numeric coincidences (6 CO₂ molecules in a hexose; a 12-month calendar; 24 solar terms in East-Asian farming almanacs) are OBSERVATION ONLY: they arise from organic chemistry, Earth's orbit, and cultural calendars — not from σ/τ/φ/J₂. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §10 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 limiting-factor response" :: prediction [ok]
  claim = "Under controlled trial, correcting only the single Liebig-limiting nutrient raises yield, while adding a non-limiting nutrient at the same site/season does not (until it becomes limiting)."
  falsifier = "If a properly designed factorial nutrient trial shows yield rising equally from adding a demonstrably non-limiting nutrient, [@lim_liebig] is wrong."
  source = "[@x_von_liebig_1840] · [@x_marschner_2012]"

@D tp_2 := "TP-2 photosynthetic ceiling" :: prediction [ok]
  claim = "No field crop, under any management, sustains seasonal solar-energy-to-biomass conversion above the few-percent theoretical maximum (≈4.6% C3 / ≈6% C4 ideal); real values fall well below."
  falsifier = "If a peer-reviewed whole-season field measurement shows energy-conversion efficiency materially exceeding the cited C3/C4 thermodynamic maxima, [@lim_photo_efficiency] is wrong."
  source = "[@x_zhu_long_ort_2010]"

@D tp_3 := "TP-3 diminishing returns" :: prediction [ok]
  claim = "Yield response to a single input (e.g. N) is concave and asymptotic toward the site's potential yield; beyond the agronomic optimum, marginal yield per added unit declines and loss terms (leaching, N₂O) rise."
  falsifier = "If a multi-rate field experiment shows a sustained linear (non-saturating) yield response with no loss escalation across the agronomic range, [@lim_diminishing_returns] is wrong."
  source = "[@x_vanittersum_2013]"

# ── §11 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real agronomy science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §12 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_von_liebig_1840 := "von Liebig (mineral nutrition, ~1840s)" :: literature [active]
  ref = "Justus von Liebig — mineral theory of plant nutrition / law of the minimum, mid-19th-century agricultural-chemistry tradition (primary author/era; exact volume & edition not asserted). Foundational for [@mech_liebig_minimum] / [@lim_liebig]."

@X x_farquhar_1980 := "Farquhar, von Caemmerer & Berry 1980" :: literature [active]
  ref = "Farquhar GD, von Caemmerer S, Berry JA. A biochemical model of photosynthetic CO₂ assimilation in leaves of C3 species. Planta 1980;149:78–90. (FvCB photosynthesis model)"

@X x_hatch_slack_1970 := "Hatch & Slack (C4 pathway, ~1966-1970)" :: literature [active]
  ref = "M.D. Hatch & C.R. Slack — discovery/characterisation of the C4 dicarboxylic-acid photosynthetic pathway (primary authors/era; exact volume not asserted). Basis for the C4 component of [@mech_c3_c4_cam]."

@X x_zhu_long_ort_2010 := "Zhu, Long & Ort 2010" :: literature [active]
  ref = "Zhu XG, Long SP, Ort DR. Improving photosynthetic efficiency for greater yield. Annu Rev Plant Biol 2010;61:235–261. (theoretical maximum conversion efficiency of C3/C4 photosynthesis; quantitative loss accounting)"

@X x_marschner_2012 := "Marschner — Mineral Nutrition of Higher Plants" :: literature [active]
  ref = "Marschner's Mineral Nutrition of Higher Plants (P. Marschner ed., 3rd ed., 2012; orig. H. Marschner). Standard reference for essential-element function and the Arnon–Stout essentiality criteria."

@X x_brady_weil_2016 := "Brady & Weil — The Nature and Properties of Soils" :: literature [active]
  ref = "Brady NC, Weil RR. The Nature and Properties of Soils (15th ed., 2016). Standard reference for soil texture/structure, CEC, pH and pedological horizons."

@X x_galloway_2004 := "Galloway et al 2004" :: literature [active]
  ref = "Galloway JN et al. Nitrogen cycles: past, present, and future. Biogeochemistry 2004;70:153–226. (global reactive-N cycle, anthropogenic perturbation, loss pathways)"

@X x_smil_2001 := "Smil 2001 — Enriching the Earth" :: literature [active]
  ref = "Smil V. Enriching the Earth: Fritz Haber, Carl Bosch, and the Transformation of World Food Production. MIT Press, 2001. (Haber–Bosch and synthetic-N dependence of modern agriculture)"

@X x_allen_1998 := "Allen et al — FAO Irrigation & Drainage Paper 56" :: literature [active]
  ref = "Allen RG, Pereira LS, Raes D, Smith M. Crop evapotranspiration — guidelines for computing crop water requirements. FAO Irrigation and Drainage Paper 56, 1998. (Penman–Monteith reference ET, crop coefficients)"

@X x_stern_1959 := "Stern et al (economic-threshold / integrated control, ~1959)" :: literature [active]
  ref = "V.M. Stern and colleagues — the integrated-control concept and economic-injury/threshold framework that underlies modern IPM (primary author/era; exact volume not asserted). Basis for [@dom_ipm]."

@X x_karlen_1994 := "Karlen et al (crop-rotation agronomy, ~1994)" :: literature [active]
  ref = "D.L. Karlen and colleagues — review of crop-rotation effects on soil quality and crop performance (primary author/era; exact volume not asserted). Supports [@mech_crop_rotation]."

@X x_borlaug_2000 := "Borlaug 2000 (Green Revolution)" :: literature [active]
  ref = "Norman E. Borlaug — semi-dwarf cereal breeding and the Green Revolution; 1970 Nobel Peace Prize. Borlaug's writings on ending hunger / 'Green Revolution' (primary author/era; specific article volume not asserted). Supports [@dom_green_revolution]."

@X x_evenson_gollin_2003 := "Evenson & Gollin 2003" :: literature [active]
  ref = "Evenson RE, Gollin D. Assessing the impact of the Green Revolution, 1960 to 2000. Science 2003;300:758–762. (empirical productivity and equity assessment of the Green Revolution)"

@X x_vanittersum_2013 := "van Ittersum et al 2013" :: literature [active]
  ref = "van Ittersum MK et al. Yield gap analysis with local to global relevance — a review. Field Crops Research 2013;143:4–17. (yield-gap definition and decomposition methodology; Global Yield Gap Atlas basis)"

@X x_cordell_2009 := "Cordell, Drangert & White 2009" :: literature [active]
  ref = "Cordell D, Drangert JO, White S. The story of phosphorus: Global food security and food for thought. Global Environmental Change 2009;19:292–305. (finite mined phosphate-rock reserves)"

@X x_lobell_2011 := "Lobell, Schlenker & Costa-Roberts 2011" :: literature [active]
  ref = "Lobell DB, Schlenker W, Costa-Roberts J. Climate trends and global crop production since 1980. Science 2011;333:616–620. (climate sensitivity of crop yields / agro-climatic envelope)"
