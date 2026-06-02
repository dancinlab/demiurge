#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# MICROPLASTICS.tape — architecture-current (editable per v1.2)
# Event history → MICROPLASTICS.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "microplastics" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · microplastics + nanoplastics — environmental and emerging-health science knowledge SSOT"
  brief = "Microplastics + nanoplastics — environmental + emerging-health science · n=6 NOT used as a derivation (honest) · evidence-grade distinguishes well-documented from emerging"
  parent = "dancinlab/hexa-bio"
  sibling-log = "MICROPLASTICS.log.tape"
  scope = "in-silico microplastics knowledge SSOT · NOT a regulatory assessment / not a clinical health claim / not a waste-management protocol"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see MICROPLASTICS.log.tape audit"

@N scope_disclaimer := "evidence-grade and knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico microplastics substrate. Evidence-grade is stated explicitly: environmental persistence and marine accumulation are well-documented; specific human-health causal mechanisms at environmental doses are LIMITED / EMERGING as of 2026-05-16. Microplastics-health-effect claims often outrun the evidence — this tape does not. Figures are paraphrased from published literature for modeling context ONLY — they are NOT regulatory guidance, clinical risk assessments, or remediation prescriptions. The WHO 2019 assessment (drinking water) found current data insufficient for quantitative human risk characterisation."

# ── §1 Definition and coining ─────────────────────────────────────────

@D dom_definition := "what microplastics and nanoplastics are" :: domain [ok]
  microplastics = "Plastic particles less than 5 mm in any dimension. The <5 mm size threshold and the term 'microplastics' were introduced and publicised by Thompson et al (2004), who detected plastic fragments in marine sediment and water column samples and noted that such particles were accumulating widely but going largely unmeasured."
  nanoplastics = "Plastic particles below ~1 μm (some definitions use <100 nm). The term 'nanoplastics' emerged in the literature after Thompson et al — there is no single consensus coining event; the sub-micron designation carries distinct methodological challenges that microplastic detection methods do not address."
  size-note = "The size boundaries are operational / methodological, not physical phase boundaries. Detection capability — not particle behaviour — largely defines the categories in practice."
  |> "[@x_thompson_2004]"

# ── §2 Sources: primary vs secondary ─────────────────────────────────

@D dom_sources := "primary vs secondary microplastic sources" :: domain [ok]
  primary = "Particles manufactured at small size for a specific application. Includes: (1) microbeads in personal-care products (exfoliating face washes, toothpaste — PE, PP, PS spheres ≤1 mm); (2) nurdles / pre-production pellets (raw material for plastic manufacturing, 2–5 mm — major pathway to marine environment through pellet spills); (3) fibres from synthetic textile laundering (polyester, nylon, acrylic shedding during washing — Cole and colleagues documented this pathway in relation to zooplankton uptake [@x_cole_2013])."
  secondary = "Particles arising from fragmentation of larger plastic items already in the environment. Dominant process: UV photodegradation (sunlight breaks polymer chains, causing embrittlement) + mechanical abrasion (wave action, wind abrasion, tumbling). Major secondary sources: tire-wear rubber particles (styrene-butadiene rubber — estimated among the highest-volume terrestrial-to-aquatic pathways), road-marking paint, agricultural mulch films, fishing gear degradation."
  relative-scale = "Proportionate contributions vary by geography and pathway studied; no single globally-agreed mass-balance figure exists at the time of writing. This is an ongoing measurement science challenge."
  |> "[@x_thompson_2004] · [@x_cole_2013]"

# ── §3 Polymer composition and partitioning ──────────────────────────

@D dom_polymers := "dominant polymer types and environmental partitioning" :: domain [ok]
  dominant = "PET (polyethylene terephthalate), PE (polyethylene, high- and low-density), PP (polypropylene), PS (polystyrene, including expanded EPS), PVC (polyvinyl chloride) are consistently the most abundant polymers detected in environmental microplastic surveys. Together they account for the large majority of global plastic production and of sampled environmental particles."
  density-partitioning = "Polymer density determines water-column fate. Low-density polymers (PE, PP; ρ < 1.0 g cm⁻³) tend to float or remain near the surface. High-density polymers (PET, PVC, PS; ρ > 1.0 g cm⁻³) sink toward sediments. Biofouling raises effective particle density over time, causing initially buoyant particles to sink — a complication for long-term fate modelling."
  persistence = "All major commodity plastics are highly resistant to biodegradation under environmental conditions. Photodegradation fragments them but does not mineralise them to CO₂ and H₂O at environmentally relevant rates. Persistence is measured in decades to centuries — a hard environmental constraint documented by Thompson et al and the broader marine debris literature."
  |> "[@x_thompson_2004]"

# ── §4 Marine accumulation — ocean gyres, GPGP ───────────────────────

@D dom_marine_accum := "marine accumulation and ocean gyres" :: domain [ok]
  gyres = "The five major subtropical ocean gyres (North Pacific, South Pacific, North Atlantic, South Atlantic, Indian Ocean) are convergence zones where wind-driven surface circulation concentrates buoyant debris. Gyres are established physical oceanography — not a lattice-derived count."
  gpgp = "The Great Pacific Garbage Patch (GPGP) is the most studied high-concentration zone, located in the North Pacific subtropical gyre. Lebreton et al (2018) conducted an extensive ocean sampling campaign and estimated the GPGP contained approximately 79,000 metric tonnes of plastic spread over approximately 1.6 million km², with microplastics and ghost fishing gear as major components. Particle count dominated by microplastics; mass dominated by larger debris."
  surface-vs-deep = "Surface survey methods (trawls, nets) capture floating particles but substantially underestimate total ocean plastic load. A substantial fraction of ocean plastic is estimated to reside in the deep-sea sediment column — poorly constrained by current measurements."
  |> "[@x_lebreton_2018]"

# ── §5 Detection methods ──────────────────────────────────────────────

@D dom_detection := "analytical detection methods for micro- and nanoplastics" :: domain [ok]
  ftir = "Fourier-transform infrared spectroscopy (FTIR) — workhorse method for particles ≥10–20 μm. ATR-FTIR and μ-FTIR (microscopy-coupled) enable chemical identification of individual particles by polymer spectral fingerprint. Well-established, widely used in environmental microplastics monitoring."
  raman = "Raman spectroscopy — complementary to FTIR; better spatial resolution (can characterise particles down to ~1 μm); useful for pigmented particles where FTIR signal is obscured. Microscopy-coupled confocal Raman (micro-Raman) has been applied to nanoplastic characterisation."
  pyrolysis-gcms = "Pyrolysis-GC/MS — thermally decomposes plastic particles; the pyrolysis products are separated and identified by gas chromatography / mass spectrometry to identify polymer type. Key advantage: can analyse particles too small for FTIR/Raman spectral methods, including nanoplastics in complex matrices. Technique has been applied to nanoplastic-scale characterisation in marine and tissue samples in work from the Hartmann group and contemporaries (era ~2010s–2020s); exact first application to nanoplastics in tissue is an active literature front."
  nanoplastics-challenge = "Nanoplastic detection in biological and environmental matrices remains methodologically immature as of 2026. No standardised extraction + analysis protocol is universally adopted. This is a stated HARD real-limit ([@lim_nanoplastics_detection])."
  |> "[@x_thompson_2004]"

# ── §6 Biological exposure — invertebrates, seabirds, trophic transfer ─

@D dom_bio_exposure_invertebrates := "zooplankton and filter-feeder uptake (well-documented)" :: domain [ok]
  zooplankton = "Cole et al (2013) conducted laboratory exposure experiments demonstrating that zooplankton (copepods: Calanus helgolandicus and others) ingest polystyrene microspheres of sizes overlapping natural prey (1–30 μm). Ingestion was confirmed microscopically; effects included reduced feeding, reduced egg production, and gut impacts at environmentally relevant concentrations. This established the fundamental biological uptake pathway for microplastics in marine pelagic food webs."
  filter-feeders = "Filter-feeding bivalves (mussels, oysters, clams) and other suspension feeders ingest microplastics at high rates because filtration is non-selective for polymer type vs similarly-sized organic particles. Documented in multiple environmental survey studies; these species are consumed by humans, providing a direct dietary exposure route."
  evidence-grade = "WELL-DOCUMENTED: invertebrate uptake of microplastics under experimental conditions is established. Trophic-transfer and population-level ecological consequences at environmental concentrations are more variable — evidence-grade EMERGING."
  |> "[@x_cole_2013]"

@D dom_bio_exposure_seabirds := "seabird plastic ingestion (well-documented)" :: domain [ok]
  finding = "Wilcox et al (2015) modelled the probability of plastic ingestion for 186 seabird species using existing data and projected that, if trends continued, 99% of seabird species would have ingested plastic by 2050. As of their analysis, plastic was already found in the stomach contents of the majority of studied species, with the highest rates in albatrosses, petrels, and shearwaters — species that forage at the ocean surface."
  mechanism = "Seabirds mistake floating plastic debris for prey items (fish eggs, squid, prey aggregations); chicks are fed plastic by parents. Plastic accumulation causes gut obstruction, satiation without nutrition, toxicant delivery."
  evidence-grade = "WELL-DOCUMENTED: seabird plastic ingestion at population scale. Quantitative projections to future decades carry modelling uncertainty."
  |> "[@x_wilcox_2015]"

@D dom_trophic_transfer := "trophic transfer of microplastics" :: domain [ok]
  studies = "Trophic transfer of microplastics — the passage of plastic particles from prey to predator — has been demonstrated in controlled laboratory studies and inferred in field studies. Evidence includes detection of microplastics in fish, marine mammals, and seabirds at higher trophic levels than direct-ingestion pathways alone would predict."
  evidence-grade = "EMERGING for magnitude / ecological consequence: laboratory trophic transfer is demonstrated; whether field concentrations at higher trophic levels meaningfully exceed lower-trophic-level concentrations (biomagnification in the classic sense) is actively debated. Current data show transfer occurs; quantitative biomagnification is not established."
  honesty = "The term 'biomagnification of microplastics' is sometimes used loosely in secondary sources. The correct characterisation is: transfer occurs; magnification relative to lower trophic levels is not yet consistently established and is a subject of ongoing study."

# ── §7 Human exposure ────────────────────────────────────────────────

@D dom_human_exposure := "human exposure pathways and detection in human tissues" :: domain [ok]
  stool = "Schwabl et al (2019) was among the first studies to detect microplastics in human stool (fecal matter). Eight participants from different countries consumed controlled diets for 1 week and provided stool samples. All samples contained microplastics; up to nine polymer types were detected, with polypropylene and polyethylene terephthalate most common. The authors cautioned that the sample size (n=8) was too small for quantitative dietary exposure assessment — a well-noted limitation."
  blood = "Leslie et al (2022) reported detection of plastic particles in human blood from 17 of 22 healthy adult donors (77%), using a pyrolysis-GC/MS method with rigorous contamination controls. PET, polystyrene, and PE were detected. This is considered a landmark first study demonstrating plastic particles in circulating human blood. The authors noted detection-methodology constraints and called for larger follow-up studies."
  other-matrices = "Microplastics have been detected in human placental tissue (Ragusa et al 2021), lung tissue, liver, and breast milk in subsequent studies. The literature in this area has grown rapidly since 2019. Evidence of ubiquitous human exposure is accumulating; characterisation of particle burden remains early-stage."
  dietary-routes = "Dietary exposure includes seafood (especially bivalves), bottled drinking water, sea salt, and packaged foods. Inhalation is a significant non-dietary route (airborne fibres from textiles/dust). Dermal exposure is considered minor."
  |> "[@x_schwabl_2019] · [@x_leslie_2022]"

# ── §8 Health effects — HONEST evidence-grade ────────────────────────

@D dom_health_effects := "health effects — distinguishing well-documented from emerging" :: domain [ok]
  well-documented = "Widespread environmental exposure: established ([@x_schwabl_2019]; [@x_leslie_2022]; multiple tissue-detection studies). Microplastics are detectable in human body compartments; this is not disputed."
  in-vitro = "In vitro evidence (cell culture) consistently shows that microplastic and nanoplastic particles can induce inflammation, oxidative stress, cytotoxicity, and other cellular responses at sufficient concentrations. This mechanistic evidence is well-replicated in laboratory models."
  in-vivo-animal = "Rodent studies show that very high dose microplastic exposures can cause gut inflammation, hepatic stress, reproductive effects, and other outcomes. Effect relevance to human environmental doses is uncertain — most animal studies use doses orders of magnitude above realistic human environmental exposures."
  human-causal = "CAUSAL MECHANISM IN HUMANS AT ENVIRONMENTAL DOSES: evidence is LIMITED / EMERGING. As of the WHO 2019 report and subsequent reviews, epidemiological evidence linking microplastic body burden to specific human disease outcomes is insufficient to establish causality. This is not denial of risk — it is an honest characterisation of the evidence gap."
  who-assessment = "WHO (2019) — Microplastics in drinking water — concluded: 'The available information does not indicate that microplastics at current levels constitute a concern for human health,' while calling for more research and better exposure characterisation. This was an institutional assessment of evidence adequacy at time of publication, not a declaration of safety. Evidence has continued to accumulate post-2019."
  honest-framing = "The honest framing: exposure is real and ubiquitous; mechanism plausibility is supported by in vitro and high-dose animal data; epidemiological causal evidence at environmental doses in humans is not yet established. Claims that microplastics 'cause' specific human diseases should be made with evidence-grade caveats."
  |> "[@x_schwabl_2019] · [@x_leslie_2022] · [@x_who_2019]"

# ── §9 Mitigation — source reduction and regulatory response ──────────

@D dom_mitigation := "mitigation approaches and regulatory responses" :: domain [ok]
  microbead-bans = "Microbead bans address primary-source microplastics in personal-care products. The US Microbead-Free Waters Act (2015) prohibited microbeads in rinse-off cosmetics effective 2017–2018. The UK implemented its microbead ban in 2018, effective for manufacturing January 2018 and retail July 2018. These are documented legislative actions."
  effectiveness = "Microbead bans address a quantified but relatively small fraction of total microplastic input to aquatic systems; tire wear, textile fibres, and secondary fragmentation of macroplastic waste are larger contributors by most estimates. Source reduction remains the only intervention considered capable of reducing environmental microplastic load at meaningful scale — ocean cleanup (filtering surface water) is physically feasible for larger debris but impractical for eliminating small particles already dispersed through the water column and sediments."
  biodegradable-plastics = "Biodegradable and compostable plastics are sometimes proposed as solutions; however, many degrade only under specific industrial composting conditions (elevated temperature, humidity) and persist in marine and soil environments similarly to conventional plastics. Labelling as 'biodegradable' in environmental context is often misleading — this is a noted greenwashing concern in the regulatory and scientific literature."
  textile-tire = "Textile fibre and tire-wear abrasion reduction are active areas of policy discussion but lack the clear regulatory consensus that microbead bans achieved. Washing machine filtration and road-runoff treatment are proposed technical interventions."
  |> "[@x_us_microbead_act_2015] · [@x_uk_microbead_ban_2018]"

# ── §10 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ──

@D lim_nanoplastics_detection := "nanoplastic detection methodology immaturity" :: real-limit [ok required]
  wall = "HARD METHODOLOGICAL LIMIT (current state of measurement science)"
  statement = "There is no standardised, universally adopted protocol for detecting, extracting, and quantifying nanoplastics (particles <1 μm, some definitions <100 nm) in environmental or biological matrices. Pyrolysis-GC/MS can detect plastic-derived pyrolysis products at nanoplastic size ranges, but blank contamination control is technically demanding and interlaboratory reproducibility is limited. The consequence is that quantitative nanoplastics exposure data in human tissues and environmental compartments are sparse and methodologically heterogeneous."
  consequence = "Risk assessment for nanoplastics is particularly data-limited; this is a methodological wall, not a solved problem with unknown answers."

@D lim_human_health_causality := "human-health causal-mechanism evidence gap" :: real-limit [ok required]
  wall = "SOFT WALL (evidence gap, not a physical limit — can be reduced by future epidemiology)"
  statement = "Causal disease mechanisms linking microplastic or nanoplastic body burden to specific human health outcomes at environmental concentrations are not established as of 2026-05-16. In vitro and high-dose animal studies demonstrate biological plausibility; epidemiological studies capable of establishing causality in human populations are nascent. This is a genuine evidence limit, not a blanket denial of risk."
  consequence = "Any claim that 'microplastics cause disease X in humans' must be qualified with the evidence grade. WHO 2019 explicitly stated data insufficiency for quantitative risk assessment in drinking water context. The responsible scientific framing is: mechanism biologically plausible, human causal evidence insufficient."
  |> "[@x_who_2019]"

@D lim_environmental_persistence := "plastic environmental persistence and irreversibility" :: real-limit [ok required]
  wall = "HARD WALL (polymer chemistry)"
  statement = "Major commodity plastics (PE, PP, PET, PS, PVC) do not biodegrade under environmental conditions on human-relevant timescales. UV photodegradation and mechanical abrasion fragment them into progressively smaller particles but do not mineralise the polymer backbone to CO₂ and water. Environmental microplastic accumulation is therefore quasi-irreversible on decadal to century timescales. Once distributed through ocean sediments and soils, particles cannot be practically retrieved."
  consequence = "Source reduction is the only intervention that changes the trajectory; remediation of existing environmental microplastic loads is not physically feasible at scale."
  |> "[@x_thompson_2004]"

@D lim_cleanup_infeasibility := "ocean cleanup scale infeasibility for small particles" :: real-limit [ok required]
  wall = "HARD ENGINEERING LIMIT"
  statement = "While surface debris (larger macroplastics) can be partially retrieved by ocean cleanup systems, removing microplastics (<5 mm) from the open ocean at scale is not technically feasible. The particles are distributed through a vast water volume and sediment column; filtering at the necessary volume would require energy and infrastructure that does not exist and would cause collateral bycatch of zooplankton and other organisms. Only source reduction changes the input rate; the environmental reservoir is effectively permanent on any engineering timescale."
  consequence = "Projection: even if all plastic emissions ceased immediately, the existing marine microplastic burden would persist and continue to fragment into smaller particles for centuries."

@D lim_ecological_causality := "ecological cause-effect vs correlation in marine ecosystems" :: real-limit [ok required]
  wall = "SOFT WALL (evidence grade — confounding in real marine systems)"
  statement = "While laboratory studies clearly demonstrate that microplastics can harm marine organisms at exposure concentrations, establishing causal attribution in real marine ecosystems is difficult because plastic pollution co-occurs with other stressors (chemical pollution, ocean warming, ocean acidification, overfishing, habitat loss). Distinguishing the microplastic contribution to observed population declines or ecological changes from these co-occurring stressors requires designs that are difficult to implement in the open ocean. This is a genuine scientific limit, not a denial of ecological harm."
  consequence = "Field ecological studies should be interpreted as association evidence; the mechanistic harm pathway is supported by laboratory data and exposure detection, but quantitative attribution of ecological change to microplastics specifically is an open research question."

# ── §11 n=6 lattice stance (HONEST — observation, not derivation) ─────

@F f_lattice_fit := "lattice-fit-on-microplastics" :: governance [required deny:write]
  pattern = "Deriving microplastics science quantities (particle counts, polymer categories, trophic levels, exposure concentrations, health-effect thresholds, gyre counts, detection method counts) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'ocean gyres = φ+τ' or 'detection methods = φ=2' or 'polymer types = n=6 because perfect number'."
  why = "This is exactly the fabrication the pre-rewrite MICROPLASTICS.tape committed (lattice-tautology stub, hexa-bio mass-split 153b5a2 — see MICROPLASTICS.log.tape audit). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it. Microplastics science has no natural n=6 invariant."
  remedy = "Cite real environmental science sources (this tape's @X entries). Counts in this domain (5 gyres, dominant polymer types, WHO evidence-grade conclusions) are empirical findings — the lattice may only be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "microplastics science has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: microplastics / nanoplastics science exposes NO natural n=6 invariant. The count of major ocean gyres is 5 (physical oceanography, not lattice). The count of dominant polymer types (PET, PE, PP, PS, PVC) is commonly cited as 5 major types — not 6, and the actual number varies by survey. WHO 2019 concluded data are insufficient for risk assessment — that conclusion is evidence-based, not lattice-constrained. The <5 mm size threshold was an operational field-definition choice by Thompson et al (2004), not a mathematical invariant. The count of analytical methods is domain convention, not a lattice product. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §12 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 GPGP mass dominance by macroplastic vs particle count by microplastic" :: prediction [ok]
  claim = "In the GPGP, plastic mass is dominated by large objects (abandoned fishing gear, macroplastic debris >5 cm), while particle count is dominated by microplastic fragments — both predictions follow from the physics of fragmentation and from Lebreton et al (2018)."
  falsifier = "If a well-powered GPGP mass-fraction survey finds that microplastic fragments (<5 mm) account for more than half of total plastic mass by weight, the Lebreton et al size-distribution finding needs revision."
  source = "[@x_lebreton_2018]"

@D tp_2 := "TP-2 low-density polymer surface enrichment" :: prediction [ok]
  claim = "Polymer composition of surface-trawl microplastic samples is enriched in low-density polymers (PE, PP) relative to their share of total plastic production, because high-density polymers (PET, PVC) sink to sediments. The surface:sediment ratio for PE+PP should exceed the production-mix ratio."
  falsifier = "If surface-trawl surveys from multiple ocean basins show PE+PP proportions at or below production-mix fractions, buoyancy-driven partitioning is not the dominant sorting mechanism at the surface, and the density-partitioning model needs revision."
  source = "[@x_thompson_2004]"

@D tp_3 := "TP-3 seabird species plastic ingestion projection" :: prediction [ok]
  claim = "Wilcox et al (2015) projected that if trends continued, 99% of seabird species would show plastic ingestion by 2050. This is falsifiable: if rigorous monitoring of species not previously sampled shows substantially lower ingestion rates than the model projection, the projection's trend assumption was too pessimistic."
  falsifier = "If a species-wide monitoring programme circa 2040–2050 finds plastic ingestion in fewer than 80% of sampled seabird species, the Wilcox et al projection overestimated the trajectory."
  source = "[@x_wilcox_2015]"

# ── §13 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real environmental science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

@X x_ecology_sibling := "ECOLOGY.tape" :: sibling-tape [active]
  scope = "Ecology science SSOT — ecosystem function, biodiversity, trophic ecology. Microplastics intersects with marine ecology at trophic transfer and population-impact questions; distinct tapes, cross-linked."

# ── §14 External citations (real, landmark literature) ────────────────
# Confidence level stated per entry. Where a specific bibliographic detail
# is not asserted with full confidence, primary author + era is given and
# the caveat is explicit.

@X x_thompson_2004 := "Thompson et al 2004 Science 304:838" :: literature [active]
  ref = "Thompson RC, Swan SH, Moore CJ, vom Saal FS. Lost at sea: where is all the plastic? Science 2004;304:838. (coining and popularisation of 'microplastics'; detection of small plastic fragments in marine sediment and water column; <5 mm operational definition; foundational paper for the field)"

@X x_cole_2013 := "Cole et al 2013 Environ Sci Technol 47:6646-6655" :: literature [active]
  ref = "Cole M, Lindeque P, Fileman E, Halsband C, Goodhead R, Moger J, Galloway TS. Microplastic ingestion by zooplankton. Environ Sci Technol 2013;47:6646–6655. (laboratory demonstration of microplastic uptake by marine zooplankton copepods; effects on feeding, egg production; establishment of trophic uptake pathway)"

@X x_lebreton_2018 := "Lebreton et al 2018 Sci Rep 8:4666" :: literature [active]
  ref = "Lebreton L et al. Evidence that the Great Pacific Garbage Patch is rapidly accumulating plastic. Scientific Reports 2018;8:4666. (GPGP characterisation — aerial and vessel survey; ~79,000 metric tonnes; size distribution showing mass dominated by larger debris, count by microplastics; accumulation rate evidence)"

@X x_wilcox_2015 := "Wilcox et al 2015 PNAS 112:11899-11904" :: literature [active]
  ref = "Wilcox C, Van Sebille E, Hardesty BD. Threat of plastic pollution to seabirds is global, pervasive, and increasing. Proc Natl Acad Sci USA 2015;112:11899–11904. (186 seabird species; probability of plastic ingestion; projection to 99% of species by 2050 under trend continuation; global scope)"

@X x_schwabl_2019 := "Schwabl et al 2019 Ann Intern Med 171:453-457" :: literature [active]
  ref = "Schwabl P et al. Detection of various microplastics in human stool: a prospective case series. Ann Intern Med 2019;171:453–457. (first study detecting microplastics in human stool; 8 participants; multiple polymer types; authors explicitly noted small sample size and called for larger studies)"

@X x_leslie_2022 := "Leslie et al 2022 Environ Int 163:107199" :: literature [active]
  ref = "Leslie HA, van Velzen MJM, Brandsma SH, Vethaak AD, Garcia-Vallejo JJ, Lamoree MH. Discovery and quantification of plastic particle pollution in human blood. Environ Int 2022;163:107199. (landmark first detection of plastic particles in human blood; 22 donors, 17 positive; PET, polystyrene, PE detected; pyrolysis-GC/MS; rigorous contamination controls)"

@X x_who_2019 := "WHO 2019 — Microplastics in drinking-water (institutional report)" :: literature [active]
  ref = "World Health Organization. Microplastics in drinking-water. Geneva: WHO, 2019. (institutional assessment concluding current data insufficient for quantitative human risk characterisation from microplastics in drinking water; called for improved exposure characterisation and further research; not a declaration of safety — a statement of evidence adequacy)"

@X x_us_microbead_act_2015 := "US Microbead-Free Waters Act 2015 (legislative)" :: literature [active]
  ref = "Microbead-Free Waters Act of 2015. Public Law 114-114, enacted December 28, 2015. United States Congress. (prohibited the manufacture and introduction into interstate commerce of rinse-off cosmetics containing intentionally-added plastic microbeads, effective 2017–2018 by product category)"

@X x_uk_microbead_ban_2018 := "UK microbead ban 2018 (legislative/regulatory)" :: literature [active]
  ref = "United Kingdom — The Environmental Protection (Plastic Straws, Cotton Buds and Stirrers) and Marine Conservation Regulations 2021 (broader plastics); specifically for microbeads: The Cosmetic Products (Responsible Person and Prohibitions) (Amendment) (EU Exit) Regulations; microbead ban in rinse-off cosmetics effective manufacturing January 2018, retail July 2018. UK REACH / DEFRA regulatory action. (primary authority/era cited; exact statutory instrument reference may require verification against the UK National Archives)"
