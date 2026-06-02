#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# AQUACULTURE.tape — architecture-current (editable per v1.2)
# Event history → AQUACULTURE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "aquaculture" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · aquaculture substrate — farmed aquatic species science knowledge SSOT"
  brief = "global production · FCR · disease pressure · system types · environmental footprint · real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "AQUACULTURE.log.tape"
  scope = "in-silico knowledge SSOT · NOT aquaculture-management advice / not a farming protocol / not a veterinary or regulatory claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see AQUACULTURE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico aquaculture substrate. Production figures, FCR ranges, and disease parameters are paraphrased from published aquaculture/fisheries literature for modeling context ONLY — they are NOT a farm-management protocol, veterinary prescription, feed formulation, or regulatory-compliance guide. Real aquaculture decisions require species-specific husbandry expertise, local regulation compliance, and qualified veterinary oversight."

# ── §1 Global production scale & species landscape ────────────────────

@D dom_global_production := "global aquaculture production — FAO SOFIA baseline" :: domain [ok]
  magnitude = "Global aquaculture production (finfish + shellfish + algae combined) has grown substantially over recent decades; FAO SOFIA reports are the authoritative statistical source updated every two years."
  major-finfish = "Atlantic salmon (Salmo salar) — Norway, Chile, UK, Canada; Nile tilapia (Oreochromis niloticus) — dominant warm-water species, widely farmed globally; Rainbow trout; Various carp species (common carp, silver carp, bighead carp) — especially large-volume East Asian production; Pangasius/catfish (Southeast Asia)."
  major-shellfish = "Whiteleg shrimp (Penaeus vannamei) and Giant tiger prawn (Penaeus monodon) — dominant globally; Pacific oyster (Crassostrea gigas); Mussel (Mytilus spp.); Scallops; Clams."
  finfish-vs-shellfish = "Finfish (carnivorous/omnivorous) require more expensive high-protein feeds and have higher environmental footprints per unit output than filter-feeding bivalves (mussels, oysters), which require no feed inputs. This asymmetry is a documented environmental economics fact, not a lattice partition."
  honesty = "Precise annual production tonnages shift year-to-year; specific figures cited only where a specific FAO SOFIA edition or peer-reviewed source supports them."
  |> "[@x_fao_sofia] · [@x_naylor_2000]"

@D dom_species_economics := "finfish vs shellfish — feed and economic contrasts" :: domain [ok]
  salmon-profile = "Atlantic salmon: high-value, high-FCR species. Requires feed rich in protein and omega-3 fatty acids (historically via fishmeal/fish oil); commands premium market prices."
  tilapia-profile = "Nile tilapia: fast-growing, omnivorous, tolerates plant-protein substitution better than salmonids; major low-cost protein source globally."
  shrimp-profile = "Whiteleg shrimp: very high economic value globally; susceptible to devastating disease epizootics (EMS/AHPND — see §3). Short grow-out cycles. Primarily pond-based."
  bivalve-profile = "Mussels and oysters: filter feeders — no supplemental feed required. Lower trophic level. Extractive — can remove nutrients and suspended particles from water. Regarded as among the most environmentally sustainable aquaculture products."
  carp-profile = "Common and silver/bighead carp: globally the largest-volume aquaculture segment by tonnage (FAO); largely freshwater pond-based in Asia; lower economic value per kg than salmon or shrimp."
  |> "[@x_fao_sofia] · [@x_naylor_2000] · [@x_costello_era]"

# ── §2 Feed Conversion Ratio (FCR) & protein-source dependence ────────

@D dom_fcr := "Feed Conversion Ratio (FCR) — definition and species variation" :: domain [ok]
  definition = "FCR = kg of dry feed required to produce 1 kg of live-weight gain. Lower FCR = more feed-efficient. FCR is the primary economic efficiency metric in fed aquaculture."
  species-variation = "FCR varies substantially by species, diet composition, water temperature, stocking density and husbandry quality. Salmonids (salmon, trout) typically show higher FCR than omnivorous species (tilapia) partly due to protein/lipid-dense feed requirements; industry FCRs have improved over decades as feed formulation has advanced."
  honesty = "Specific FCR values are production-system-dependent and year-specific; this tape does not pin a single number to a species without a peer-reviewed source — directional claims only."
  |> "[@x_naylor_2000] · [@x_tacon_metian_2008]"

@D mech_fishmeal_dependency := "fishmeal and fish-oil dependency — the forage-fish link" :: mechanism [ok]
  fishmeal = "Fishmeal is a high-protein ingredient historically central to carnivorous-fish feeds (salmon, trout, marine shrimp). It is manufactured primarily from wild-caught small pelagic forage fish (anchovy, herring, mackerel, menhaden)."
  fish-oil = "Fish oil is the primary marine source of long-chain omega-3 fatty acids (EPA, DHA) in aquafeeds; nutritionally critical for salmonid product quality and flesh omega-3 content."
  supply-ceiling = "Wild forage-fish harvest is bounded by sustainable yield of the stocks; demand from aquaculture competes with direct human consumption and other uses. Naylor et al. (2000) flagged this tension in a landmark Nature paper — the analysis is still cited as the baseline framing of the dependency."
  plant-protein-substitution = "Substantial research effort has been directed to replacing fishmeal/oil with plant proteins (soy, rapeseed, lupine, novel ingredients) and alternative lipids. Amino acid profiles and the absence of DHA/EPA in most plant sources limit full substitution, especially in salmonids."
  |> "[@x_naylor_2000] · [@x_tacon_metian_2008]"

# ── §3 Disease pressure ───────────────────────────────────────────────

@D dom_sea_lice := "sea lice — Lepeophtheirus salmonis on Atlantic salmon" :: domain [ok]
  pathogen = "Lepeophtheirus salmonis — ectoparasitic copepod; the dominant sea-louse species on Atlantic salmon in cold-water open-net-pen farming regions (Norway, Scotland, Canada, Chile)."
  biology = "Grazes on mucus, skin and tissue of farmed salmon; causes wounds, secondary infections, osmotic stress, and immune suppression. Can transmit to wild salmonids in proximity to net-pens — an ecological externality concern."
  economic-impact = "Sea lice are one of the most economically significant disease challenges in Atlantic salmon farming globally; treatment costs and production losses amount to substantial industry expenditure annually."
  treatments = "Chemical (hydrogen peroxide baths, organophosphates, pyrethroids — resistance has emerged to several classes), biological (cleaner fish: wrasse and lumpfish), mechanical (thermolicer, lasers), and management (fallowing, synchronised treatments)."
  resistance = "Resistance to multiple chemical treatments is documented and is a genuine sustainability concern — an evolutionary constraint on chemical-control durability."
  |> "[@x_torrissen_2013] · [@x_costello_era]"

@D dom_isa := "infectious salmon anemia (ISA) — viral threat to salmon farming" :: domain [ok]
  pathogen = "Infectious salmon anemia virus (ISAV) — Orthomyxoviridae; infects Atlantic salmon."
  impact = "ISA outbreaks can cause mass mortality in net-pen farms; the 2007–2009 ISA outbreak in Chile was a major economic catastrophe for the Chilean salmon industry."
  control = "Strict biosecurity (all-in/all-out, site fallowing), sentinel surveillance, ISA vaccines available in some regions."
  OIE-listed = "ISA is an OIE (WOAH)-listed notifiable disease — reflects international regulatory significance."
  honesty = "Specific mortality rates and economic losses are episode-specific; directional framing only. The Chile example is a documented historical fact."

@D dom_ems_ahpnd := "EMS/AHPND — early mortality syndrome in shrimp" :: domain [ok]
  full-name = "Acute hepatopancreatic necrosis disease (AHPND), historically called early mortality syndrome (EMS)."
  pathogen = "Caused by strains of Vibrio parahaemolyticus (and other Vibrio spp.) harboring a plasmid encoding binary toxins (PirAB-like) — a Pir toxin mechanism."
  impact = "EMS/AHPND emerged in China (~2009), spreading to Vietnam, Malaysia, Thailand, Mexico; caused severe production losses across Asian shrimp aquaculture in the early 2010s."
  lesion = "Acute degeneration of hepatopancreatic tubule epithelium within 30 days of stocking — characteristically early in grow-out."
  management = "Improved biosecurity, pathogen-free stock (SPF broodstock), probiotics/competitive exclusion, reduced antibiotic reliance; no universally effective treatment."
  |> "[@x_aerts_ahpnd_era]"

@D dom_antibiotic_vaccination := "antibiotic use and the vaccination success in salmon" :: domain [ok]
  early-overuse = "Early Norwegian and Chilean salmon farming relied heavily on antibiotic prophylaxis; mass antibiotic use created AMR concerns and was a documented environmental hazard."
  vaccination-success = "Norway dramatically reduced antibiotic use in salmon farming — by approximately 99% from peak usage in the late 1980s/early 1990s — after introducing effective multivalent vaccines (covering Aeromonas salmonicida, Vibrio anguillarum, ISA and other pathogens). This is widely regarded as one of the most successful examples of vaccination replacing antibiotic use in production animal agriculture."
  vaccines = "Oil-adjuvanted injectable multivalent vaccines; delivered by automated injection at the smolt stage. Lillehaug and Sommerset reviews document this transition."
  shrimp-antibiotic-concern = "Shrimp aquaculture (especially in some Asian systems) continues to face concerns about antibiotic overuse and AMR; vaccination is less developed for penaeid shrimp than for salmonids."
  |> "[@x_lillehaug_era] · [@x_sommerset_era]"

# ── §4 System types ───────────────────────────────────────────────────

@D dom_system_types := "aquaculture production system types" :: domain [ok]
  net-pen = "Open net-pen (sea cage): dominant method for Atlantic salmon in Norway, Scotland, Canada, Chile. Low infrastructure cost, high throughput; significant environmental concerns (lice transmission, escapement genetics, nutrient loading, benthic impact)."
  pond = "Earthen pond: dominant for tilapia, shrimp (Asia, Latin America), carp. Low capital cost, management complexity varies; effluent management is the primary environmental challenge."
  raceway = "Flow-through raceway systems: used for salmonids; require clean fast-moving fresh water; high water volume; suitable for cool-water species."
  ras = "Recirculating Aquaculture Systems (RAS): closed-loop systems with biofiltration, mechanical filtration, UV sterilisation, and temperature control. Very low water use and low environmental footprint per kg produced; high capital and operational energy cost. Growing role for salmon smolt production and some grow-out (land-based salmon)."
  imta = "Integrated Multi-Trophic Aquaculture (IMTA): co-culture of species from different trophic levels — e.g., salmon (fed) + mussels (suspension feeders) + sea urchins/seaweeds (extractive). Nutrient and organic waste from salmon are captured by other trophic levels; reduces net waste; still largely experimental/demonstration scale."
  |> "[@x_chopin_imta_era] · [@x_naylor_2000]"

# ── §5 Environmental footprint ────────────────────────────────────────

@D dom_env_footprint := "environmental footprint — Naylor et al 2000 framing" :: domain [ok]
  naylor-framing = "Naylor et al. (2000) — the landmark Nature paper 'Effect of aquaculture on world fish supplies' — provided the canonical framing of aquaculture's environmental tradeoffs: net-pen aquaculture can consume more wild fish (in feed) than it produces for some species, creating a net-negative wild-fish balance for carnivorous species, while filter-feeders and herbivorous species are net-positive."
  nutrient-loading = "Net-pen and pond aquaculture discharge dissolved N and P (metabolic waste, uneaten feed) to receiving waters; localized eutrophication and benthic anoxia under high-density net-pens are documented impacts."
  escapement = "Escape of farmed individuals (especially Atlantic salmon from open net-pens) into wild ecosystems poses genetic introgression risk to wild populations — interbreeding can alter the genetic composition and local adaptations of wild stocks."
  land-water = "Pond aquaculture (shrimp, tilapia) competes for land and freshwater; some coastal shrimp pond expansion has destroyed mangroves, with associated biodiversity and carbon-stock losses."
  footprint-asymmetry = "Per-kg environmental footprint is highly species/system-specific. Bivalves (mussels, oysters) have among the lowest footprints of any animal protein source; fed carnivorous species (salmon) have among the highest for animal aquaculture, though still lower per kg protein than most terrestrial livestock in some metrics."
  |> "[@x_naylor_2000]"

@D dom_bivalves := "bivalves — low-trophic extractive aquaculture" :: domain [ok]
  species = "Pacific oyster (Crassostrea gigas), blue mussel (Mytilus edulis and related), scallops (Pecten spp., Argopecten), clams (Ruditapes, Mercenaria)."
  no-feed = "Filter-feeding bivalves require no supplemental feed — they harvest particulate organic matter and phytoplankton from the surrounding water column; this is the defining feature of extractive aquaculture."
  ecosystem-services = "Can provide water-clarity improvement and nutrient removal from the water column; often described as beneficial for coastal water quality at appropriate stocking densities."
  limitations = "Production is constrained by primary productivity of the growing site; disease (Bonamia, Perkinsus/dermo, Vibrio) can cause episodic mass mortality; market price is generally lower than fed finfish on a per-kg basis."
  |> "[@x_naylor_2000]"

# ── §6 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_forage_fish_ceiling := "fishmeal/fish-oil supply bounded by forage-fish sustainability" :: real-limit [ok required]
  wall = "HARD WALL (ecological/resource finitude)"
  statement = "Wild forage-fish stocks (Peruvian anchovy, Norwegian herring, Atlantic mackerel, etc.) have finite sustainable yields governed by ocean productivity, recruitment, and climate variability. Aquaculture demand for fishmeal/fish-oil is in competition with direct human consumption and ecosystems that depend on forage fish as prey. The forage-fish harvest cannot be arbitrarily increased to meet aquaculture feed demand."
  consequence = "Salmon and other carnivorous-species farming is bounded by the sustainable supply of wild marine ingredients; industry shift to plant proteins and novel ingredients is driven by this ceiling. Long-term growth of fed aquaculture requires ingredient diversification."
  |> "[@x_naylor_2000] · [@x_tacon_metian_2008]"

@D lim_disease_open_systems := "disease and escapement HARD on open systems" :: real-limit [ok required]
  wall = "HARD WALL (ecological/biological)"
  statement = "Open net-pen systems expose farmed fish to ambient pathogens and parasites (sea lice, ISA) without a physical barrier; they also allow escaped individuals to reach wild ecosystems. These are structural constraints of the system type — unavoidable without shifting to a physically separated system (RAS or terrestrial). No management intervention fully eliminates lice infestation risk in open-pen salmonid systems in endemic coastal areas."
  consequence = "Open-cage salmon farming cannot sustainably eliminate sea-lice challenge in high-density production regions without substantial biological/mechanical controls or transition to closed systems. Escapement risk persists regardless of netting quality. These are real physical/ecological constraints, not lattice values."
  |> "[@x_torrissen_2013]"

@D lim_nutrient_loading_benthic := "nutrient loading and benthic impact — site-capacity ceiling" :: real-limit [ok required]
  wall = "HARD WALL (ecological carrying capacity)"
  statement = "The receiving water body has a finite capacity to assimilate waste N, P, and organic matter from aquaculture without causing eutrophication, hypoxia, or benthic anoxia. This carrying capacity is set by hydrodynamics, dilution, microbial processing, and the resident ecosystem — it is a site-specific ecological ceiling, not a managed parameter."
  consequence = "Stocking density and site selection in net-pen farming are constrained by local carrying capacity; exceeding it causes documented environmental damage and may trigger regulatory shut-down. RAS largely sidesteps this limit by treating waste internally but at energy/capital cost."
  |> "[@x_naylor_2000]"

@D lim_freshwater_land_inland := "freshwater and land constraints for inland/pond systems" :: real-limit [ok required]
  wall = "HARD WALL (resource finitude)"
  statement = "Pond aquaculture and RAS (land-based) require freshwater and land, which are globally finite and regionally scarce resources. Freshwater aquifer depletion is locally irreversible on human timescales. Coastal pond expansion for shrimp has historically displaced mangroves — carbon-dense, biodiversity-critical ecosystems."
  consequence = "Geographic and hydrological constraints bound the expansion potential of freshwater-dependent aquaculture systems. Mangrove conversion for shrimp ponds is a documented irreversible ecological cost; some jurisdictions have enacted prohibitions."
  |> "[@x_naylor_2000]"

@D lim_climate_thermal := "thermal tolerance and climate sensitivity" :: real-limit [ok required]
  wall = "HARD WALL (physiological/environmental)"
  statement = "Aquatic poikilotherms (fish, shrimp) have species-specific thermal tolerance ranges outside which survival, growth, FCR, immune function, and reproduction are compromised. Atlantic salmon, for example, are cold-water species; warming seas and summer temperature events already stress Norwegian fjord net-pens. Ocean warming and acidification are altering the geographic suitability envelope for various aquaculture species."
  consequence = "Climate change is not merely a productivity risk but a structural constraint on where specific aquaculture species can be profitably grown. RAS provides thermal control but at high energy cost."

# ── §7 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-aquaculture" :: governance [required deny:write]
  pattern = "Deriving aquaculture production quantities, FCR values, species counts, disease parameters, system types or environmental metrics FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'optimal FCR = n=6' or '12 monitored parameters because σ=12' or 'φ=2 system types'."
  why = "This is exactly the fabrication the pre-rewrite AQUACULTURE.tape committed (rows of @D row_* x=n_6 / hexa=σ·φ / EXACT lattice-tautology — see AQUACULTURE.log.tape audit). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real aquaculture science/fisheries sources (this tape's @X entries). Species counts, production volumes, and FCR ranges are empirical fisheries data (FAO) and peer-reviewed literature — the lattice may only be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "aquaculture has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: aquaculture exposes NO natural n=6 invariant. Production species diversity is set by ecology and market demand; FCR is a feed-biology metric; disease categories are microbiology/parasitology; system types reflect engineering/ecology tradeoffs; environmental impact categories are biogeochemical. None of these quantities derives from σ/τ/φ/J₂. Numeric coincidences (e.g. if a particular regional count happens to equal a lattice value) are OBSERVATION ONLY, not derivation — and even such coincidences are not present here as natural examples. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §8 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 fishmeal substitution limits in salmonids" :: prediction [ok]
  claim = "Complete dietary replacement of fishmeal with plant protein in Atlantic salmon diets, without supplemental essential amino acids and omega-3 enrichment, will produce measurably lower growth rates and altered fatty-acid composition in flesh compared to fishmeal-based controls — reflecting the known nutritional gap."
  falsifier = "If a peer-reviewed salmon feeding trial demonstrates full (100%) plant-protein substitution without supplementation achieving equivalent growth, FCR, and flesh omega-3 composition to fishmeal controls, the dependency framing in [@mech_fishmeal_dependency] requires revision."
  source = "[@x_naylor_2000] · [@x_tacon_metian_2008]"

@D tp_2 := "TP-2 salmon vaccination vs antibiotic trajectory" :: prediction [ok]
  claim = "In Norwegian salmon farming, antibiotic use per kg produced remains at a small fraction (roughly two orders of magnitude lower) of the pre-vaccination-era peak, tracking the documented post-vaccination reduction — a durable outcome of effective immunisation, not a temporary trend."
  falsifier = "If Norwegian antimicrobial statistics (reported by NORM-VET) show a sustained return to multi-tonne annual use without an identified new pandemic-scale outbreak, the vaccination success claim in [@dom_antibiotic_vaccination] is wrong."
  source = "[@x_lillehaug_era] · [@x_sommerset_era]"

@D tp_3 := "TP-3 RAS environmental footprint vs open-pen" :: prediction [ok]
  claim = "RAS-produced salmon generates lower direct marine environmental impact per kg (near-zero escapement, near-zero sea-lice transmission to wild fish, controlled effluent) than open-net-pen production at the same scale — a structural consequence of physical containment, offset by higher energy consumption per kg."
  falsifier = "If a full life-cycle assessment (LCA) shows that RAS energy-related GHG emissions per kg salmon already exceed the total environmental footprint of well-managed open-pen systems under current renewable-energy grids, the RAS environmental framing requires nuancing."
  source = "[@x_naylor_2000] · [@x_torrissen_2013]"

# ── §9 Cross-links ────────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real aquaculture science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §10 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_fao_sofia := "FAO SOFIA (State of World Fisheries and Aquaculture)" :: literature [active]
  ref = "FAO. The State of World Fisheries and Aquaculture (SOFIA). Food and Agriculture Organization of the United Nations, Rome. Biennial publication series (most recent editions 2020, 2022, 2024). Authoritative global production statistics for aquaculture and capture fisheries by species, country and system type."

@X x_naylor_2000 := "Naylor et al 2000 Nature" :: literature [active]
  ref = "Naylor RL, Goldburg RJ, Primavera JH, Kautsky N, Beveridge MCM, Clay J, Folke C, Lubchenco J, Mooney H, Troell M. Effect of aquaculture on world fish supplies. Nature 2000;405:1017–1024. (landmark paper on fishmeal/fish-oil dependency, net fish balance, and environmental footprint of aquaculture; the canonical baseline framing)"

@X x_tacon_metian_2008 := "Tacon & Metian 2008" :: literature [active]
  ref = "Tacon AGJ, Metian M. Global overview on the use of fish meal and fish oil in industrially compounded aquafeeds: Trends and future prospects. Aquaculture 2008;285:146–158. (fishmeal and fish-oil use trends; plant-protein substitution context)"

@X x_torrissen_2013 := "Torrissen et al 2013" :: literature [active]
  ref = "Torrissen O, Jones S, Asche F, Guttormsen A, Skilbrei OT, Nilsen F, Horsberg TE, Jackson D. Salmon lice — impact on wild salmonids and salmon aquaculture. J Fish Dis 2013;36:171–194. (comprehensive review of sea-lice biology, ecological impact on wild salmonids, and management; primary author/era cited; full volume confirmed)"

@X x_lillehaug_era := "Lillehaug (salmon vaccination, late 1980s–1990s)" :: literature [active]
  ref = "A. Lillehaug — Norwegian salmon vaccine development and adoption; work documenting the dramatic reduction in antibiotic use following vaccine introduction in Norwegian aquaculture (primary author/era; specific article volume not asserted — recommend consulting Norwegian Veterinary Institute / NORM-VET annual reports for quantified antibiotic-use statistics)."

@X x_sommerset_era := "Sommerset et al (salmon vaccine review, ~2005)" :: literature [active]
  ref = "Sommerset I, Krossøy B, Biering E, Frost P — review of vaccines for fish in aquaculture: approx. 2005 era; comprehensive review of salmon vaccine types, administration, and efficacy (primary author/era; exact volume not asserted). Contextualises [@dom_antibiotic_vaccination]."

@X x_aerts_ahpnd_era := "Aerts et al / AHPND literature (~2013–2016)" :: literature [active]
  ref = "Acute hepatopancreatic necrosis disease (AHPND/EMS) characterisation literature: Tran L et al. (identification of causative Vibrio parahaemolyticus plasmid/PirAB toxin mechanism, ~2013); Flegel TW and colleagues on EMS epidemiology in Southeast Asia. Primary-author/era framing — the AHPND causal mechanism (PirAB toxin on mobile plasmid in Vibrio parahaemolyticus) is well established as of knowledge cutoff."

@X x_costello_era := "Costello et al (global fisheries/aquaculture, ~2016)" :: literature [active]
  ref = "Costello C et al. — global fisheries and aquaculture trajectory analysis; ~2016 era (primary author/era; specific article volume not asserted). Context for global aquaculture growth projections and species economics."

@X x_chopin_imta_era := "Chopin et al (IMTA, ~2001–2010)" :: literature [active]
  ref = "T. Chopin and colleagues — integrated multi-trophic aquaculture (IMTA) concept development and demonstration; work from ~2001–2010 in Canadian Atlantic context (salmon + mussels + sea urchins/seaweeds). Primary author/era cited; exact volumes not asserted. Basis for [@dom_system_types] IMTA entry."
