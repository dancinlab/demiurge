#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# DOLPHIN.tape — architecture-current (editable per v1.2)
# Event history → DOLPHIN.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §0 Identity ──────────────────────────────────────────────────────

@I id001 := "dolphin" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · cetacean / Delphinidae biology knowledge SSOT"
  brief = "Cetacean / Delphinidae biology · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "DOLPHIN.log.tape"
  scope = "in-silico cetacean knowledge SSOT · NOT a veterinary / conservation management / clinical claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see DOLPHIN.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico cetacean biology substrate. Biological facts, population figures and ecology data are paraphrased from peer-reviewed literature for modeling context ONLY — not conservation-management prescriptions, not veterinary protocols, not regulatory submissions. Real conservation and welfare decisions require wildlife biologists, IUCN assessments and jurisdiction-specific regulation."

# ─── §1 Taxonomy & evolutionary origin ───────────────────────────────

@D dom_cetacean_taxonomy := "Cetacea — order-level taxonomy and evolutionary origin" :: domain [ok]
  origin = "Cetaceans evolved from terrestrial artiodactyls approximately 50 million years ago. Pakicetus and allied pakicetids are the best-documented early stem-whales; subsequent fossil series (Ambulocetus, Rodhocetus, Dorudon) trace the progressive aquatic transition — documented by Thewissen and colleagues over the 1990s-2000s in the fossil record of the Indian subcontinent / Tethys margin."
  living-orders = "Order Cetacea comprises two living sub-orders: Odontoceti (toothed whales: dolphins, orcas, sperm whales, beaked whales) and Mysticeti (baleen whales: blue, fin, humpback, bowhead). A third fossil sub-order, Archaeoceti, is entirely extinct."
  delphinidae = "Family Delphinidae (ocean dolphins) is the largest cetacean family — approximately 36 species recognised in recent taxonomic reviews, including Tursiops truncatus (common bottlenose), Orcinus orca (orca / killer whale), Lagenorhynchus spp., Grampus griseus (Risso's dolphin), Stenella spp. The species count is a taxonomic inventory subject to revision, NOT a lattice-fixed number."
  count-honesty = "~36 Delphinidae species is current taxonomy; cetacean species counts evolve with molecular systematics — the number is an empirical inventory, not derived from any algebraic invariant."
  |> "[@x_thewissen_fossil_series] · [@x_iucn_redlist]"

@D dom_odontoceti_mysticeti := "Odontoceti vs Mysticeti: the toothed/baleen split" :: domain [ok]
  odontoceti = "Toothed whales (Odontoceti) possess teeth, a single blowhole, an asymmetric skull, and a melon organ for echolocation (biosonar). They include dolphins, porpoises, sperm whales, orcas, and beaked whales."
  mysticeti = "Baleen whales (Mysticeti) lack teeth; they filter prey via baleen plates, have paired blowholes, and show symmetric skulls. They include the largest animals ever known (blue whale Balaenoptera musculus, up to ~30 m)."
  common-ancestor = "The two sub-orders shared a common ancestor; molecular and morphological evidence places the Odontoceti/Mysticeti split well back in the Eocene/Oligocene."
  |> "[@x_thewissen_fossil_series]"

# ─── §2 Anatomy ───────────────────────────────────────────────────────

@D dom_anatomy := "cetacean external anatomy" :: domain [ok]
  fusiform = "Streamlined fusiform (fish-like) body reduces drag; secondary aquatic adaptation convergent with fish body-form — different skeletal origin (vestigial hind-limb elements persist internally)."
  flukes = "Tail flukes are HORIZONTAL (vs vertical caudal fin of fish), driven by dorsoventral spinal flexion. This horizontal/vertical distinction reflects the mammalian (dorsoventral locomotion) vs teleost (lateral undulation) ancestry."
  blowhole = "Single blowhole (Odontoceti) or paired (Mysticeti) at dorsal apex; explosive exhalation + rapid inhalation at the surface — 'blow' visible as water vapour condensate."
  melon = "The melon is a rounded, lipid-filled forehead structure in odontocetes — an acoustic lens that focuses outgoing echolocation clicks into a directional beam. Melon lipid composition (different from blubber) is tuned for acoustic propagation."
  dorsal-fin = "Dorsal fin: present in most delphinids (absent in some species, e.g. Lissodelphis); acts as a stabiliser / thermoregulator. Shape and size are species-specific."
  blubber = "Thick blubber layer (insulation + energy reserve); species in colder waters have proportionally thicker blubber — Bergmann's rule analogue."

# ─── §3 Echolocation (biosonar) ───────────────────────────────────────

@D dom_echolocation := "dolphin echolocation — click generation, propagation, reception" :: domain [ok]
  mechanism = "Clicks are generated in the nasal passage complex (phonic lips / museau de singe — 'monkey lips'), focused by the melon, then projected forward. Each click is broadband with dominant energy typically in the range of roughly 40–150 kHz (species- and context-dependent). Au (1993) 'The Sonar of Dolphins' is the canonical textbook source for click-frequency characterisation."
  frequency-note = "40–150 kHz range is a representative literature range for delphinid biosonar; exact centre frequencies differ by species, individual, target, and task. This is empirical measurement, NOT a lattice-derived bandwidth."
  water-sound-speed = "Sound travels in seawater at approximately 1500 m/s (versus ~340 m/s in air) — a physical property of the medium (density, bulk modulus), enabling rapid acoustic return for range estimation."
  reception = "Return echoes are received via the lower jaw (mandible): a fat-filled channel (mandibular fat pad / acoustic window) conducts sound from the jaw to the inner ear — a derived anatomical feature unique to toothed whales. See Au (textbook, author/era flagged)."
  range-estimation = "Dolphins estimate target range from the time-of-flight of echo return (range = (Δt × c) / 2) and target characteristics from spectral features of the echo."
  discrimination = "Laboratory experiments show bottlenose dolphins can discriminate objects differing by a few millimetres at ranges of metres — documented by Au and colleagues in psychoacoustic experiments (textbook era)."
  |> "[@x_au_sonar_textbook]"

# ─── §4 Cognition & behaviour ─────────────────────────────────────────

@D dom_mirror_recognition := "mirror self-recognition in bottlenose dolphins" :: domain [ok]
  finding = "Reiss & Marino (2001) demonstrated mirror self-recognition (MSR) in bottlenose dolphins (Tursiops truncatus) using contingency testing and mark-directed behaviour — both behaviours indicative of self-awareness in the MSR paradigm. Dolphins are among the few non-human species showing robust MSR (others: great apes, elephants, some corvids)."
  caveat = "MSR is an operational index, not a proof of rich phenomenal consciousness; the relationship between MSR and other cognitive capacities remains an active research question — sentience/consciousness claims are evidence-grade gradients, not certainties. See [@lim_anthropomorphism]."
  |> "[@x_reiss_marino_2001]"

@D dom_signature_whistles := "individual vocal identity — signature whistles" :: domain [ok]
  mechanism = "Bottlenose dolphins produce individually stereotyped 'signature whistles' — frequency-modulated tonal calls that function as acoustic labels. A dolphin's signature whistle is learned in early development and retains individual distinctiveness throughout life."
  social-function = "Signature whistles are used for individual identification during social interactions (reunion, separation, group cohesion) — reviewed by Janik & Sayigh 2013 (J Comp Physiol A)."
  copying = "Dolphins copy the signature whistles of close social partners (alliances), a form of vocal mimicry with a social-bonding function. Reviewed by Janik (2009) in the context of vocal-learning elements."
  |> "[@x_janik_sayigh_2013] · [@x_janik_2009]"

@D dom_social_structure := "social structure — fission-fusion societies, alliances, matrilines" :: domain [ok]
  fission-fusion = "Bottlenose dolphins (Tursiops) live in fission-fusion societies: fluid groupings that repeatedly split and merge over days to months; membership varies continuously. Group size ranges from a few individuals to hundreds depending on habitat and behaviour."
  alliances = "Male bottlenose dolphins form long-term first-order and second-order alliances (pairs / triads) for mate access and social competition — documented in Shark Bay, Western Australia (Connor and colleagues, ~1990s)."
  matrilines = "Orca (Orcinus orca) society is matrilineal: offspring remain with their mothers throughout life; groups (pods) are led by elder females. Cultural transmission of foraging techniques (fish-stunning, beaching) flows along matrilines."
  cultural-transmission = "Krützen et al (2005) documented tool use (sponge-carrying foraging) in a subset of bottlenose dolphin females in Shark Bay and showed the behaviour spreads along matrilineal social ties — interpreted as cultural transmission in wild cetaceans."
  |> "[@x_krutzen_2005] · [@x_janik_sayigh_2013]"

# ─── §5 Sleep ──────────────────────────────────────────────────────────

@D dom_sleep := "unihemispheric slow-wave sleep in cetaceans" :: domain [ok]
  mechanism = "Cetaceans exhibit unihemispheric slow-wave sleep (USWS): one cerebral hemisphere sleeps (shows EEG slow waves) while the other remains alert, allowing simultaneous sleep and surface/respiration maintenance. This is absent in terrestrial mammals and represents a derived adaptation to obligate air-breathing in a continuous aquatic environment."
  review = "Lyamin et al (2008, Neurosci Biobehav Rev 32:1451–1484) provide a comprehensive review of sleep in cetaceans and other marine mammals."
  logging = "Dolphins also exhibit 'logging' — floating motionless at the surface, sometimes with both eyes closed — interpreted as a period of minimal-activity rest."
  |> "[@x_lyamin_2008]"

# ─── §6 Conservation & threats ────────────────────────────────────────

@D dom_conservation_status := "conservation status — critically endangered species" :: domain [ok]
  hectors-maui = "Hector's dolphin (Cephalorhynchus hectori) and Maui dolphin (C. h. maui) are critically endangered small coastal dolphins endemic to New Zealand with among the smallest cetacean populations. Maui dolphin population estimated at fewer than 50 adults as of recent IUCN assessments."
  vaquita = "The vaquita porpoise (Phocoena sinus), endemic to the northern Gulf of California, has fewer than 10 individuals remaining (IUCN estimate, recent assessments), making it the most endangered marine mammal. Primary driver: bycatch in illegal gillnet fisheries targeting totoaba."
  population-counts = "These population figures are IUCN Red List estimates subject to survey uncertainty and updating — not exact invariants."
  |> "[@x_iucn_redlist]"

@D dom_threats := "anthropogenic threats — bycatch, ship strike, pollution" :: domain [ok]
  bycatch = "Incidental capture in fishing gear (gillnets, trawls, longlines) is the leading direct mortality source for many small cetacean populations globally. Entanglement causes drowning (obligate air-breathers). The vaquita situation is the extreme case."
  ship-strike = "Large cetaceans (blue whales, sperm whales, North Atlantic right whales) are particularly vulnerable to collisions with ships; North Atlantic right whale (Eubalaena glacialis) has <350 individuals with ship strike and gear entanglement as major mortality drivers."
  pollution-pcb = "Jepson et al (2016, Sci Rep 6:18573) documented exceptionally high PCB (polychlorinated biphenyl) concentrations in European orca and striped dolphin populations — legacy pollution from industrial use prior to PCB bans — associated with population-level reproductive impairment and immune suppression. PCBs bioaccumulate through marine food chains (biomagnification)."
  noise = "Chronic anthropogenic ocean noise (shipping, sonar, seismic surveys) disrupts cetacean communication, echolocation, navigation and social behaviour — a diffuse but pervasive threat with evidence of masking, displacement and in extreme cases noise-induced hearing loss."
  |> "[@x_jepson_2016] · [@x_iucn_redlist]"

# ─── §7 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ──

@D lim_anthropomorphism := "cetacean cognition vs human-anthropomorphism floor" :: real-limit [ok required]
  wall = "EPISTEMOLOGICAL LIMIT"
  statement = "Consciousness, sentience and emotional experience in dolphins are evidence-grade gradients, NOT certainties. MSR, sophisticated social learning, and signature-whistle individuality are behaviourally documented facts. Attributing rich phenomenal experience (pain, joy, grief in the human sense) goes beyond the evidence base and conflates behavioural proxy with phenomenology."
  consequence = "Claims about 'dolphin emotions' or 'dolphin consciousness' must be scoped to the evidence: behavioural indicators (MSR, social complexity, vocal individuality). Certainty is not warranted; denial is also not warranted. The honest position is: compelling evidence of complex cognition, uncertain mapping to human-like experience."
  |> "[@x_reiss_marino_2001]"

@D lim_captive_wild_generalization := "captive-vs-wild generalization limits" :: real-limit [ok required]
  wall = "ECOLOGICAL/METHODOLOGICAL LIMIT"
  statement = "Much cetacean cognitive and acoustic research is conducted with captive bottlenose dolphins under controlled conditions — logistically necessary for controlled experiments but not guaranteed to generalize to wild conspecifics in naturalistic social and acoustic environments. Wild studies (Shark Bay, Sarasota Bay, etc.) provide the ecological complement but with lower experimental control."
  consequence = "Data from captive-dolphin experiments should be hedged as 'in captive Tursiops' unless explicitly confirmed in wild populations. Extrapolation across species (bottlenose → orca → sperm whale) requires additional justification."

@D lim_genetic_bottleneck := "small-population genetic bottleneck (vaquita, Maui dolphin)" :: real-limit [ok required]
  wall = "HARD WALL (demographic / genetic)"
  statement = "Populations below ~50 effective individuals face catastrophic inbreeding depression, loss of allelic diversity, and demographic stochasticity — all reinforcing collapse. The vaquita (<10 individuals) and Maui dolphin (< 50 adults) are arguably past or approaching the point at which demographic recovery is probabilistically foreclosed without extraordinary ex-situ intervention."
  consequence = "Conservation interventions (net removal, sanctuary zones) can remove the proximate threat but cannot restore lost genetic diversity. Recovery from this extreme a bottleneck has no documented cetacean precedent."
  |> "[@x_iucn_redlist]"

@D lim_chronic_noise := "chronic anthropogenic noise — cumulative and diffuse harm" :: real-limit [ok required]
  wall = "SOFT WALL (anthropogenic pressure)"
  statement = "Ocean ambient noise levels from shipping have risen substantially over the 20th century in key cetacean habitats, compressing the communication range of low-frequency calling species (e.g., baleen whales) and masking echolocation-bandwidth-relevant frequencies for some odontocetes. High-intensity acute sources (naval sonar mid-frequency active) have been causally linked to beaked-whale mass strandings."
  consequence = "Noise is not a one-event threat but a pervasive alteration of the acoustic habitat — difficult to reverse without broad shipping and sonar policy changes. There is no single clean metric for 'safe noise level' across cetacean species and contexts."

# ─── §8 n=6 lattice stance (HONEST — observation, not derivation) ─────

@F f_lattice_fit := "lattice-fit-on-cetacean-biology" :: governance [required deny:write]
  pattern = "Deriving cetacean biological quantities (echolocation frequency range, species counts, alliance sizes, social-group counts, conservation thresholds, foraging success rates) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'click frequency = 120 kHz because σ·sopfr/6' or '6 dolphin species are primary because n=6'."
  why = "This is exactly the fabrication the pre-rewrite DOLPHIN.tape committed (see DOLPHIN.log.tape audit). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real cetacean biology/ecology sources (this tape's @X entries). Biological counts (Delphinidae ~36 spp., Norwood-equivalent staging if applicable) arise from taxonomy and measurement — the lattice may be a coincidental OBSERVATION, never a derivation."

@N n6_honest_stance := "cetacean biology has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: cetacean biology exposes NO natural n=6 invariant. Delphinidae species count (~36) is a taxonomic inventory. Echolocation frequency range (40–150 kHz) is a measured spectral quantity. Orca social-group composition, vaquita population size, PCB contamination levels, and all other cetacean biological quantities are empirically measured facts or IUCN estimates — NOT lattice-derived. Numeric coincidences (6 described male alliances in a given Shark Bay study cohort; any count that happens to equal 6 or 12) are OBSERVATION ONLY: they arise from biology, not from σ/τ/φ/J₂. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ─── §9 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 signature whistle individuality persists across decades" :: prediction [ok]
  claim = "An adult bottlenose dolphin's signature whistle retains individually distinctive features (frequency contour shape) throughout its life; long-term photo-ID + acoustic re-identification studies should confirm the same whistle type over 10+ years."
  falsifier = "If a longitudinal study (>10 yr individual follow-up with known ID) shows adult dolphins routinely switch to new signature contours not attributable to gradual drift, [@x_janik_sayigh_2013] is substantially wrong."
  source = "[@x_janik_sayigh_2013]"

@D tp_2 := "TP-2 PCB body burden → reproductive impairment gradient" :: prediction [ok]
  claim = "Across European orca and striped dolphin populations, body burden of PCBs (measured in blubber biopsy) predicts reproductive success — high-PCB individuals and populations show measurably lower calf production / higher calf mortality compared to low-PCB or PCB-declining populations."
  falsifier = "If a well-powered population-level study shows no correlation between PCB blubber concentration and reproductive rate across the documented concentration range, [@x_jepson_2016] is substantially wrong on the population-effects inference."
  source = "[@x_jepson_2016]"

@D tp_3 := "TP-3 sponge-foraging cultural transmission follows matrilineal lines" :: prediction [ok]
  claim = "In Shark Bay bottlenose dolphins, sponge-foraging should be significantly more prevalent among maternal relatives of known spongers than among non-relatives of equivalent association levels — the matrilineal social-learning signature of Krützen et al 2005."
  falsifier = "If a subsequent larger-sample genetic pedigree study shows sponge-foraging is equally common in non-relatives after controlling for habitat use, the cultural-transmission interpretation in [@x_krutzen_2005] requires revision."
  source = "[@x_krutzen_2005]"

# ─── §10 Cross-links ──────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real cetacean science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

@X x_dolphin_bioacoustics_sibling := "DOLPHIN-BIOACOUSTICS.tape" :: sibling-tape [active]
  scope = "Separate sibling tape covering dolphin bioacoustics in depth — do not conflate or absorb into this tape. This DOLPHIN.tape is the general cetacean-biology SSOT."

# ─── §11 External citations (real, landmark literature) ───────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_thewissen_fossil_series := "Thewissen and colleagues — cetacean fossil series (~1994–2007)" :: literature [active]
  ref = "J.G.M. Thewissen and colleagues — fossil discovery and description of Pakicetus, Ambulocetus, Rodhocetus and allied stem-cetaceans tracing the land-to-water transition; published across multiple journals (Nature, Science, Science, PNAS) through the 1990s and 2000s. Primary-author/era flagged; individual papers span multiple co-authors and dates not consolidated here as a single volume."

@X x_au_sonar_textbook := "Au — The Sonar of Dolphins (textbook, ~1993)" :: literature [active]
  ref = "Whitlow W.L. Au. 'The Sonar of Dolphins.' Springer, 1993. Textbook-era canonical reference for click-frequency characterisation, psychoacoustic performance, and biosonar signal properties in odontocetes. Author and approximate publication year asserted; full bibliographic details are textbook-standard and well-established."

@X x_reiss_marino_2001 := "Reiss & Marino 2001" :: literature [active]
  ref = "Reiss D, Marino L. Mirror self-recognition in the bottlenose dolphin: A case of cognitive convergence. Proc Natl Acad Sci USA 2001;98(10):5937–5942."

@X x_krutzen_2005 := "Krützen et al 2005" :: literature [active]
  ref = "Krützen M, Mann J, Heithaus MR, Connor RC, Bejder L, Sherwin WB. Cultural transmission of tool use in bottlenose dolphins. Proc Natl Acad Sci USA 2005;102(25):8939–8943."

@X x_janik_sayigh_2013 := "Janik & Sayigh 2013" :: literature [active]
  ref = "Janik VM, Sayigh LS. Communication in bottlenose dolphins: 50 years of signature whistle research. J Comp Physiol A 2013;199(6):479–489."

@X x_janik_2009 := "Janik 2009 — elements of signature whistles" :: literature [active]
  ref = "Janik VM. Acoustic communication in delphinids. In: Naguib M, Janik VM (eds), Advances in the Study of Behavior, Vol 40. Academic Press / Elsevier, 2009. (Author/era flagged; chapter details not asserted beyond author, volume and approximate year.)"

@X x_lyamin_2008 := "Lyamin et al 2008" :: literature [active]
  ref = "Lyamin OI, Manger PR, Mukhametov LM, Siegel JM, Shpak OV. Cetacean sleep: An unusual form of mammalian sleep. Neurosci Biobehav Rev 2008;32(8):1451–1484."

@X x_jepson_2016 := "Jepson et al 2016" :: literature [active]
  ref = "Jepson PD, Deaville R, Barber JL, Aguilar À, Borrell A, Murphy S, Barry J, Brownlow A, Barnett J, Berrow S, Cunningham AA, Davison NJ, ten Doeschate M, Esteban R, Ferreira M, Foote AD, Genov T, Giménez J, Loveridge J, Llavona Á, Martin V, Maxwell DL, Papachlimitzou A, Penrose R, Perkins MW, Smith B, de Stephanis R, Tregenza N, Verborgh P, Spence KL, Law RJ. PCB pollution continues to impact populations of orcas and other dolphins in European waters. Sci Rep 2016;6:18573."

@X x_iucn_redlist := "IUCN Red List — cetacean assessments (current)" :: literature [active]
  ref = "IUCN Red List of Threatened Species — cetacean species assessments (Cephalorhynchus hectori maui, Phocoena sinus, Eubalaena glacialis and others). https://www.iucnredlist.org/. Species-specific assessments cited for Maui dolphin and vaquita; population figures are assessment-year estimates subject to updating. Author = IUCN SSC Cetacean Specialist Group."
