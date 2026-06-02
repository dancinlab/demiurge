#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# ENTOMOLOGY.tape — architecture-current (editable per v1.2)
# Event history → ENTOMOLOGY.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "entomology" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · entomology — insect biology knowledge SSOT"
  brief = "Insects (Hexapoda) — 6 legs is a MORPHOLOGICAL taxon definition, NOT n=6 lattice derivation (honest) · real entomology science: body plan, classification, metamorphosis, exoskeleton, flight evolution, ecology, IPM, decline, uses · real-limits anchored · n=6 lattice DECLINED as derivation tool"
  parent = "dancinlab/hexa-bio"
  sibling-log = "ENTOMOLOGY.log.tape"
  scope = "in-silico entomology knowledge SSOT · NOT a pesticide-use recommendation / not clinical / not regulatory"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2) — 6-leg/Hexapoda was wrongly framed as n=6 lattice derivation; ~1500 lines of @D row_* / @D b_* entries asserting EXACT lattice fits, zero real citations; full real-science rewrite 2026-05-16 — see ENTOMOLOGY.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico entomology substrate. Insect-biology figures (body plan counts, metamorphosis stages, decline rates, toxicology) are paraphrased from published entomology/ecology literature for modeling context ONLY — they are NOT a pesticide prescription, agricultural advice, or IPM protocol. Real field decisions require local expertise, regulatory compliance, and jurisdiction-specific guidance."

# ── §1 Insect body plan & the Hexapoda name ──────────────────────────

@D dom_body_plan := "insect body plan — Hexapoda (head + thorax + abdomen)" :: domain [ok]
  three-tagmata = "Insect body is divided into three functional tagmata: head (feeding/sensory), thorax (locomotion), abdomen (reproduction/digestion). This three-part organisation is a MORPHOLOGICAL taxon characteristic, not a lattice partition."
  six-legs = "Three thoracic segments (prothorax, mesothorax, metathorax) each bear one pair of legs → 6 legs total. This is an evolved developmental-genetic outcome conserved across Hexapoda, not derived from any numerical framework."
  hexapoda-etymology = "The subphylum name 'Hexapoda' comes from Greek hex (six) + pous/poda (foot/feet) — named for the leg-count as an observed morphological character. The name records an observation; it does not validate any lattice theory."
  wings = "Ancestral Pterygota (winged insects) had 4 wings (2 pairs on mesothorax + metathorax). Diptera secondarily reduced the hindwing pair to halteres (gyroscopic stabilisers). Wing-pair count is evolved anatomy, not a lattice constant."
  antennae = "One pair of antennae (bilateral symmetry); crustaceans have 2 pairs — the reduction to 1 pair is a hexapod apomorphy."
  compound-eyes = "Compound eyes built of ommatidia (hexagonally packed in many species); hexagonal packing is the optimal space-filling geometry — the same reason honeycombs are hexagonal (Hales 2001 proof). This is geometry/physics, not a lattice derivation."
  tracheal-respiration = "Gas exchange via a tracheal system of air tubes rather than lungs/gills; diffusion + convective pumping; limits size scaling (Fick diffusion law)."
  |> "[@x_grimaldi_engel_2005] · [@x_gullan_cranston_2014]"

@D dom_hexapoda_vs_entognatha := "Hexapoda: Insecta vs Entognatha" :: classification [ok]
  hexapoda-scope = "Subphylum Hexapoda contains Insecta and three non-insect classes with mouthparts enclosed in folds of the head (Entognatha): Collembola (springtails), Protura, Diplura."
  insecta = "~1 million described species in class Insecta; estimated true diversity 5–10 million species (unknown majority); the largest animal class by species count."
  collembola = "Springtails (Collembola) are not insects — they lack wings in both adult and ancestral form and have entognathous mouthparts. Among the most abundant hexapods in soil."
  honesty = "The three Entognatha classes exist; 'all Hexapoda are insects' is a common simplification that is technically wrong. Hexapoda has 4 classes, not 1."
  |> "[@x_grimaldi_engel_2005]"

# ── §2 Classification: major insect orders ────────────────────────────

@D dom_major_orders := "major insect orders — the big four + others" :: classification [ok]
  coleoptera = "Beetles (Coleoptera) — largest insect order by described species (~400,000 spp). Hardened forewings (elytra) protect hindwings; complete metamorphosis. Habitat span: soil, dung, wood, water, stored grain — J.B.S. Haldane's quip about God's 'inordinate fondness for beetles' reflects the empirical diversity."
  diptera = "Flies (Diptera) — one functional wing pair (hindwings → halteres). Includes medically important species: Anopheles (malaria vector), Aedes (dengue/Zika/yellow fever), Culex, blowflies, house fly, vinegar fly Drosophila melanogaster (genetics model)."
  hymenoptera = "Ants, bees, wasps, sawflies (Hymenoptera) — includes social insects (honeybee Apis mellifera, bumble bees, ants, yellowjackets) and parasitoid wasps. Critical pollinators and biocontrol agents."
  lepidoptera = "Butterflies and moths (Lepidoptera) — scale-covered wings; holometabolous; caterpillar larval stage is often the economically damaging herbivore."
  hemiptera = "True bugs (Hemiptera) — piercing/sucking mouthparts; hemimetabolous; includes aphids, whiteflies, scale insects (major crop pests), cicadas, shield bugs. Stylet feeding can transmit plant viruses."
  odonata = "Dragonflies and damselflies (Odonata) — among the most ancestral winged insects; 4 independently moving wings; aquatic nymphs; efficient aerial predators. Hemimetabolous."
  order-count-honesty = "The number of recognized insect orders varies by taxonomic authority and includes extinct orders (fossils) — commonly cited figures range from ~26–33 extant orders depending on the classification scheme and how families are delimited. This count is a taxonomic convention, not a lattice-derived constant."
  |> "[@x_grimaldi_engel_2005] · [@x_misof_2014]"

# ── §3 Metamorphosis: hemimetabolous vs holometabolous ───────────────

@D dom_metamorphosis := "insect metamorphosis — hemi- vs holometabolous" :: domain [ok]
  hemimetabolous = "Incomplete metamorphosis (Hemimetabola / Exopterygota): egg → nymph (naiad for aquatic forms) → adult. Nymphs resemble adults and gradually develop wings externally. Examples: grasshoppers, crickets, cockroaches, true bugs, dragonflies."
  holometabolous = "Complete metamorphosis (Holometabola / Endopterygota): egg → larva → pupa → adult. Larval and adult forms are morphologically and ecologically distinct; pupal stage is the reorganisation phase. Examples: beetles, flies, butterflies, bees, ants, wasps."
  holometaboly-innovation = "Holometaboly is considered a key evolutionary innovation: larval and adult stages can exploit different niches simultaneously (avoiding intraspecific competition); pupa allows extensive tissue remodelling via histolysis and histogenesis. Holometabolous orders account for >80% of insect species."
  stage-count-honesty = "Holometabola: 4 named stages (egg, larva, pupa, adult). Hemimetabola: 3 named stages (egg, nymph, adult). These counts are morphological categories — embryology defines them, not the lattice. Hemipteran nymphs pass through multiple instar sub-stages that are not a fixed number."
  truman-riddiford = "The evolutionary origin of the pupa was analysed by Truman & Riddiford (1999, Nature) in terms of the proto-larva hypothesis — an ancestral free-living larval stage intercalated into the life cycle."
  |> "[@x_grimaldi_engel_2005] · [@x_truman_riddiford_1999]"

# ── §4 Exoskeleton: chitin, sclerotization, ecdysis ──────────────────

@D dom_exoskeleton := "insect exoskeleton — chitin, sclerotization, ecdysis" :: domain [ok]
  chitin = "Insect cuticle is primarily chitin (β-1,4-linked N-acetylglucosamine polymer) in a protein matrix. Chitin is among the most abundant natural polymers on Earth."
  sclerotization = "Hardening of the cuticle (sclerotization/tanning): dopamine → DOPA → dopaquinone → cross-linking of cuticular proteins by ortho-quinones. Also melanisation contributes to darkening. Distinct chemical routes produce either hard (tanned) or soft (membranous) cuticle in different body regions."
  ecdysis = "Moulting: insects shed the old cuticle (ecdysis) to grow, regulated by ecdysteroid hormones (ecdysone, 20-hydroxyecdysone) and juvenile hormone (JH). JH titre determines whether a moult produces a larval, pupal, or adult stage — classic neuroendocrine developmental switch."
  size-limit = "Exoskeleton + tracheal system set real size constraints on insects: tracheal oxygen delivery becomes the bottleneck for large body mass (Fick diffusion law); ancient Carboniferous giant insects (Meganeura dragonflies, Arthropleura) coincided with higher atmospheric O₂ (~30%) consistent with the diffusion-limit model."
  |> "[@x_gullan_cranston_2014] · [@x_grimaldi_engel_2005]"

# ── §5 Insect flight evolution ────────────────────────────────────────

@D dom_flight_evolution := "evolution of insect flight" :: domain [ok]
  timing = "Winged insects (Pterygota) first appear in the fossil record in the Early Carboniferous (~325 Ma). Flight is the single terrestrial-animal innovation that arose earliest and enabled the most dramatic diversification."
  hypotheses = "Two main competing hypotheses for wing origin: (1) paranotal lobe hypothesis — lateral outgrowths of the thoracic nota; (2) gill/leg exite hypothesis — mobile gill-cover structures of crustacean-like ancestors co-opted for gliding then active flight. Both hypotheses have living proponents; neither is settled."
  halteres = "Dipteran hindwing → haltere transformation is one of the most studied body-plan transitions: halteres are gyroscopic sensors (oscillate at wingbeat frequency; detect body rotations via Coriolis forces); controlled by haltere-specific mechanosensory neurons. Loss of halteres impairs flight stability."
  wing-venation = "Wing venation (network of veins) varies diagnostically among orders and is used taxonomically. The Comstock–Needham system assigns homologous names across orders."
  |> "[@x_grimaldi_engel_2005]"

# ── §6 Ecological roles ───────────────────────────────────────────────

@D dom_pollination := "pollination — ecosystem service and economic value" :: domain [ok]
  scope = "Insects pollinate ~87% of the world's flowering plant species and approximately 75% of major food crops (by species count, though staple grains are largely wind-pollinated)."
  key-pollinators = "Apis mellifera (Western honeybee) — most important managed pollinator globally; bumble bees (Bombus spp.); solitary bees (>20,000 species worldwide); syrphid flies; some beetles and moths."
  ccd = "Colony Collapse Disorder (CCD) — syndrome in which honeybee worker populations collapse; documented since mid-2000s. Multifactorial: Varroa destructor mites, Nosema microsporidian parasites, pesticides (especially neonicotinoids), habitat loss, viral pathogens. No single cause established."
  ?> "[@x_hallmann_2017] · [@x_van_klink_2020]"
  |> "[@x_gullan_cranston_2014]"

@D dom_herbivory_decomp := "herbivory, predation, parasitoidism, decomposition" :: domain [ok]
  herbivory = "Insects are the dominant herbivores of terrestrial ecosystems: leaf-chewing, sap-sucking, seed predation, stem-boring, root-feeding. Agricultural pest damage (crop losses globally estimated at tens of billions of USD annually — though figures vary widely by crop and region)."
  predation = "Many insect orders include predators: Odonata (adult and nymph), predatory beetles (Carabidae, Coccinellidae — ladybirds preying on aphids), robber flies, mantids."
  parasitoidism = "Parasitoid insects (many Hymenoptera, some Diptera) lay eggs in or on a host; larvae develop by consuming the host, killing it. Parasitoids are a major natural-enemy force in agricultural ecosystems and the basis of biocontrol agents."
  decomposition = "Dung beetles, blow flies, dermestid beetles, termites, and many others accelerate decomposition of dead organic matter, cycling nutrients."
  |> "[@x_gullan_cranston_2014] · [@x_grimaldi_engel_2005]"

# ── §7 Pest biology & integrated pest management (IPM) ───────────────

@D dom_ipm := "integrated pest management — resistance and Bt" :: domain [ok]
  ipm-principle = "IPM combines biological, cultural, physical/mechanical and chemical controls; deploys pesticides only when pest populations exceed economic injury thresholds (Stern et al. ~1959); aims to slow resistance evolution and protect non-target organisms."
  pesticide-resistance = "Resistance evolves whenever pesticides select survivors who carry resistance alleles. Major mechanisms: (1) target-site resistance — kdr (knockdown resistance) voltage-gated sodium channel mutations (pyrethroids); RDL (resistance to dieldrin) GABA receptor mutations; acetylcholinesterase (AChE) mutations reducing organophosphate/carbamate binding; (2) metabolic resistance — enhanced cytochrome P450 monooxygenase, esterase, or glutathione S-transferase detoxification; (3) reduced penetration. Resistance is an evolutionary inevitability under sustained selection pressure, not a failure of a specific pesticide."
  bt-toxins = "Bacillus thuringiensis (Bt) produces insecticidal crystal (Cry) proteins and Vip proteins that bind to midgut epithelial receptors, forming pores → cell lysis. Bt crops (transgenic — Cry genes expressed in planta) and Bt sprays are widely used bioinsecticides."
  bt-resistance = "Bt resistance has evolved in field populations of several pests (e.g. Busseola fusca in Africa; Helicoverpa zea in US Bt cotton/maize). Refuge strategies (non-Bt refuge plants to maintain susceptible individuals) are mandated in many jurisdictions to slow resistance. Tabashnik and colleagues have published extensively on Bt resistance theory and monitoring."
  |> "[@x_tabashnik_bt_2013] · [@x_gullan_cranston_2014]"

# ── §8 Insect decline ────────────────────────────────────────────────

@D dom_decline := "insect biomass and abundance decline — evidence and drivers" :: domain [ok]
  hallmann_2017 = "Hallmann et al. 2017 (PLOS ONE) reported a >75% decline in total flying insect biomass over 27 years (1989–2016) in German nature reserves, measured by Malaise traps. A landmark paper catalysing the 'insect apocalypse' discourse, though confined to a specific geographic/habitat context."
  van_klink_2020 = "van Klink et al. 2020 (Science) conducted a global meta-analysis synthesising 166 long-term datasets. Finding: terrestrial insect abundance declining on average ~9% per decade; freshwater insects increasing ~11% per decade (likely due to improved water quality). More nuanced than simple universal decline."
  sanchez_bayo_2019 = "Sánchez-Bayo & Wyckhuys (2019, Biological Conservation) reviewed 73 historical insect decline reports; concluded habitat loss, agrochemicals, invasive species, and climate change as primary drivers. Some subsequent critique of species selection bias in the reviewed studies."
  drivers = "Principal drivers: (1) habitat loss and fragmentation (especially agricultural intensification); (2) pesticide exposure (neonicotinoids, organophosphates); (3) invasive species; (4) climate change (phenological mismatch, range shifts, drought); (5) light pollution; (6) pathogens."
  uncertainty = "Insect-decline data are geographically uneven: most long-term datasets are from temperate Europe and North America; tropical diversity (where most species live) is very poorly sampled. Global extrapolations carry high uncertainty."
  |> "[@x_hallmann_2017] · [@x_van_klink_2020] · [@x_sanchez_bayo_2019]"

# ── §9 Insects as resources ──────────────────────────────────────────

@D dom_insects_as_resources := "insects as food, silk, honey, and biocontrol" :: domain [ok]
  insect-food = "FAO 2013 report 'Edible Insects: Future Prospects for Food and Feed Security' documented >2 billion people consuming insects traditionally; insects have high protein/fat per dry mass and low environmental footprint vs vertebrate livestock."
  silk = "Bombyx mori (silkworm, domesticated moth larva) produces silk — the cocoon is a continuous protein filament (fibroin + sericin) used in textiles for millennia; B. mori has been selectively bred to the point of losing the ability to fly."
  honey = "Apis mellifera produces honey by enzymatic modification and evaporative concentration of nectar; wax comb is secreted from abdominal glands. Honeybee cross-links APICULTURE domain."
  biocontrol = "Parasitoid wasps (Trichogramma, Encarsia formosa), predatory beetles and bugs, and entomopathogenic fungi (Beauveria bassiana, Metarhizium anisopliae) are commercial biocontrol agents used in IPM."
  |> "[@x_gullan_cranston_2014]"

# ── §10 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ──

@D lim_pesticide_resistance := "pesticide resistance evolution — hard evolutionary wall" :: real-limit [ok required]
  wall = "HARD WALL (evolutionary genetics)"
  statement = "Resistance to any insecticide is an evolutionary inevitability when selection pressure is sustained and resistance alleles are present in the target population. No pesticide, including Bt toxins, has an infinite durability under sufficient selection intensity."
  consequence = "IPM and refuge strategies delay resistance but cannot prevent it indefinitely; new modes of action must be developed; resistance monitoring is a permanent requirement. This is set by population genetics and natural selection — not a design parameter."
  |> "[@x_tabashnik_bt_2013] · [@x_gullan_cranston_2014]"

@D lim_habitat_loss := "habitat loss and insect decline — accumulating and partially irreversible" :: real-limit [ok required]
  wall = "HARD WALL (ecological — locally irreversible at human timescales for many specialist taxa)"
  statement = "Habitat loss and fragmentation eliminate local insect populations; many specialist insects cannot persist in degraded or fragmented habitats. Local extinctions can precede global extinction by decades to centuries."
  consequence = "Total insect diversity (and hence ecosystem services) is bounded by available high-quality habitat; agricultural intensification, urbanisation and drainage represent permanent conversions for many species' timescales."
  |> "[@x_hallmann_2017] · [@x_van_klink_2020]"

@D lim_undescribed_diversity := "undescribed species diversity — unknowable extinction floor" :: real-limit [ok required]
  wall = "HARD WALL (knowledge limit)"
  statement = "Estimates of total insect species count range from ~5–10 million, against ~1 million described. The majority of insect species, especially in tropical arthropod communities, are unknown to science. Extinction rates for unnamed species cannot be measured — only inferred from habitat-loss models."
  consequence = "Insect conservation is bounded by a fundamental sampling/description limit; species are being lost before they are named. No technological shortcut currently closes this gap at species-resolution."
  |> "[@x_grimaldi_engel_2005]"

@D lim_climate_niche_shift := "climate-driven niche shifts — uncertain re-distributions" :: real-limit [ok required]
  wall = "SOFT WALL (uncertain magnitude, confirmed direction)"
  statement = "Insect distributions are shifting poleward and to higher elevations in response to warming (documented in multiple taxa). Range contractions in heat-adapted specialists and phenological mismatches with host plants/prey impose real fitness costs."
  consequence = "Crop pest ranges will shift (expanding in some regions, contracting in others); pollinator mismatches with crop/wildflower flowering times are a documented concern. The wall is soft because adaptive evolution can partially counter niche shifts — but the rate of climate change may exceed adaptation rates for specialist taxa."
  |> "[@x_van_klink_2020]"

@D lim_bt_resistance_evolution := "Bt-toxin resistance evolution in field populations" :: real-limit [ok required]
  wall = "HARD WALL (confirmed in field populations)"
  statement = "Field-evolved resistance to Bt Cry proteins has been confirmed in multiple insect species (e.g. Busseola fusca, Helicoverpa zea, Plutella xylostella, Spodoptera frugiperda in some regions). The 2013 Tabashnik review documented that Bt resistance had evolved in at least 5 pest species by that time, with resistance allele frequencies rising in some populations even before resistance was confirmed phenotypically."
  consequence = "The durability of Bt technology is finite; refuge area requirements and mode-of-action pyramiding are empirical necessities, not policy preferences. Additional Cry/Vip proteins and non-protein-based alternatives must be in the pipeline."
  |> "[@x_tabashnik_bt_2013]"

# ── §11 n=6 lattice stance (HONEST — observation, not derivation) ────

@F f_lattice_fit := "lattice-fit-on-entomology" :: governance [required deny:write]
  pattern = "Deriving or asserting entomological quantities FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'insects have 6 legs because n=6', 'Hexapoda = n=6 lattice', 'metamorphosis stages = τ=4 because lattice', 'order count = n×sopfr because lattice', '3 body segments = n/φ because lattice'."
  why = "This is exactly the fabrication the pre-rewrite ENTOMOLOGY.tape committed (~1500 lines of `@D row_* / @D b_*` entries asserting lattice EXACT fits for every insect morphological count, including 'Hexapoda 6다리 = n=6 lattice'). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it. The HEXA-VIROCAPSID tape (commit e026183) established the same discipline for HBV T=4."
  remedy = "Cite real entomology/ecology/evolutionary-biology sources (this tape's @X entries). Morphological and taxonomic counts (6 legs, 3 tagmata, 4 holometabolous stages, ~26–33 orders) are BIOLOGY — set by evolution, developmental genetics, and taxonomic convention. The n=6 lattice may be a coincidental OBSERVATION where a number happens to be 6, never a derivation."

@N n6_honest_stance := "Hexapoda's 6 legs is morphology (taxon definition), not n=6 lattice derivation" :: note [required]
  text = "Stated plainly: entomology exposes NO natural n=6 invariant that is lattice-derived. The defining character of Hexapoda — 6 legs — is a MORPHOLOGICAL FACT arising from the developmental genetics of 3 thoracic segments × 2 legs per segment, conserved by ~400 million years of evolution. The subphylum name 'Hexapoda' is Greek for 'six-footed': it records an OBSERVED anatomy, exactly as a geographer naming a 'peninsula' does not derive peninsulas from a peninsula-theory. The number 6 coincides numerically with the n=6 lattice constant, but this is a pure NUMERICAL COINCIDENCE — the same discipline HEXA-VIROCAPSID applied to 'HBV T=4 is not n=6 lattice'. Observation is allowed; derivation is forbidden. Similarly: 3 tagmata, 4 holometabolous stages, and the approximate order count are evolutionary outcomes and taxonomic conventions — not lattice products. No honesty-compliant use of this tape should ever write 'Hexapoda = n=6 derived' or use lattice arithmetic to explain an insect morphological count. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool."

# ── §12 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 Bt-resistance refuges slow resistance" :: prediction [ok]
  claim = "In field deployments where Bt crops are planted with ≥20% structured non-Bt refuge, the frequency of Bt resistance alleles in the target pest population rises more slowly than in refuge-free deployments under equivalent Bt selection pressure."
  falsifier = "If a properly controlled multi-generation field study shows refuge-compliant deployments yield resistance-allele frequencies indistinguishable from refuge-free deployments of similar area/dose, the evolutionary-genetics model underlying [@lim_bt_resistance_evolution] is wrong."
  source = "[@x_tabashnik_bt_2013]"

@D tp_2 := "TP-2 insect biomass decline — further temporal extension" :: prediction [ok]
  claim = "Extending Hallmann et al.'s Malaise-trap time-series in German nature reserves beyond 2016 with consistent methodology will show continued negative trend in total flying insect biomass, consistent with ongoing habitat-loss and land-use-intensity drivers."
  falsifier = "If the extended time-series (>5 years additional data, same sites/methodology) shows stable or increasing biomass across the majority of sites, [@lim_habitat_loss] and the attributed driver set in [@dom_decline] require revision."
  source = "[@x_hallmann_2017]"

@D tp_3 := "TP-3 freshwater insect recovery tracks water quality" :: prediction [ok]
  claim = "The positive freshwater insect trend reported by van Klink et al. (2020) should be largest in watersheds with documented improvements in water quality (reduced eutrophication, reduced agricultural runoff) relative to watersheds without such improvements."
  falsifier = "If freshwater insect recovery rates are statistically equivalent across water-quality-improving vs non-improving watersheds, the water-quality attribution in [@x_van_klink_2020] is unsupported."
  source = "[@x_van_klink_2020]"

# ── §13 Cross-links ──────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real entomology science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §14 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_grimaldi_engel_2005 := "Grimaldi & Engel 2005 — Evolution of the Insects" :: literature [active]
  ref = "Grimaldi D, Engel MS. Evolution of the Insects. Cambridge University Press, 2005. Comprehensive textbook covering insect phylogenetics, body plan, fossil record, order-level biology, and macroevolutionary patterns. Authority for §1 body plan, §2 orders, §3 metamorphosis, §5 flight evolution."

@X x_gullan_cranston_2014 := "Gullan & Cranston 2014 — The Insects: An Outline of Entomology" :: literature [active]
  ref = "Gullan PJ, Cranston PS. The Insects: An Outline of Entomology. 5th ed. Wiley-Blackwell, 2014. Standard undergraduate entomology textbook; covers body plan, classification, metamorphosis, exoskeleton, ecology, pest management, and uses."

@X x_misof_2014 := "Misof et al 2014 — insect phylogenomics" :: literature [active]
  ref = "Misof B et al. Phylogenomics resolves the timing and pattern of insect evolution. Science 2014;346:763–767. Landmark 1478-gene phylogenomic analysis of 144 insect species; resolves the order-level phylogeny and dates key divergences including the origin of holometaboly."

@X x_truman_riddiford_1999 := "Truman & Riddiford 1999 — larval stage origin" :: literature [active]
  ref = "Truman JW, Riddiford LM. The origins of insect metamorphosis. Nature 1999;401:447–452. Proto-larva hypothesis: the endopterygote larva is an evolutionarily intercalated free-living embryonic stage; recasts the developmental biology of holometaboly."

@X x_hallmann_2017 := "Hallmann et al 2017 — 75% flying insect biomass decline" :: literature [active]
  ref = "Hallmann CA et al. More than 75 percent decline over 27 years in total flying insect biomass in protected areas. PLoS ONE 2017;12:e0185809. Malaise-trap survey in 63 German nature reserves 1989–2016; documents >75% biomass decline; the landmark 'insect apocalypse' paper."

@X x_van_klink_2020 := "van Klink et al 2020 — global insect meta-analysis" :: literature [active]
  ref = "van Klink R et al. Meta-analysis reveals declines in terrestrial but increases in freshwater insect abundances. Science 2020;368:417–420. Global synthesis of 166 long-term arthropod datasets; terrestrial insects declining ~9%/decade; freshwater insects increasing ~11%/decade."

@X x_sanchez_bayo_2019 := "Sánchez-Bayo & Wyckhuys 2019 — worldwide insect decline review" :: literature [active]
  ref = "Sánchez-Bayo F, Wyckhuys KAG. Worldwide decline of the entomofauna: A review of its drivers. Biological Conservation 2019;232:8–27. Review of 73 long-term insect decline reports; identifies habitat loss, agrochemicals, invasive species, climate change as primary drivers."

@X x_tabashnik_bt_2013 := "Tabashnik et al 2013 — Bt resistance in the field" :: literature [active]
  ref = "Tabashnik BE, Brévault T, Carrière Y. Insect resistance to Bt crops: lessons from the first billion acres. Nature Biotechnology 2013;31:510–521. Reviews evolution of field resistance to Bt Cry proteins in 5 pest species; documents refuge-strategy efficacy and identifies factors predicting resistance evolution rate."
