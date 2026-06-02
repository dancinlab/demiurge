#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# FOOD-SCIENCE.tape — architecture-current (editable per v1.2)
# Event history → FOOD-SCIENCE.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "food-science" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · food science substrate — food chemistry + safety + preservation knowledge SSOT"
  brief = "Maillard chemistry · lipid oxidation · microbial safety · hurdle preservation · sensory science — real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "FOOD-SCIENCE.log.tape"
  scope = "in-silico food-chemistry + safety knowledge SSOT · NOT dietary advice / not a regulatory claim / not a food-formulation prescription"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see FOOD-SCIENCE.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico food-science substrate. Food-chemistry figures (reaction temperatures, aw thresholds, pathogen limits) are paraphrased from published food-science literature for modeling context ONLY — they are NOT dietary advice, a food-formulation recipe, a food-safety protocol, a regulatory claim, or a clinical nutrition recommendation. Real food-safety decisions require certified food scientists, accredited testing, and jurisdiction-specific regulatory compliance."

# ── §1 Macronutrient composition framework ────────────────────────────

@D dom_carbohydrates := "carbohydrate classes in food systems" :: domain [ok]
  mono = "Monosaccharides (glucose, fructose, galactose) — the reducing sugars most reactive in Maillard and caramelization chemistry."
  di = "Disaccharides: sucrose (glucose + fructose; non-reducing), lactose (glucose + galactose; reducing), maltose (glucose + glucose; reducing)."
  oligo = "Oligosaccharides (fructo-oligosaccharides, galacto-oligosaccharides) — partially digestible; prebiotic substrates."
  poly-starch = "Starch: a mixture of amylose (~20–30%, linear α-1,4 chains) and amylopectin (~70–80%, branched α-1,4/α-1,6). Source-dependent ratio governs gelatinisation temperature, retrogradation and digestibility."
  poly-nonstarch = "Non-starch polysaccharides: pectin (methylated GalUA backbone; gelling agent in high-sugar/high-acid systems); cellulose (β-1,4-glucan, indigestible dietary fiber); hemicelluloses; β-glucans."
  dietary-fiber = "Dietary fiber (insoluble: cellulose/hemicellulose; soluble: pectin/β-glucan/inulin) — not directly hydrolyzed by mammalian amylases; fermented in the colon by the microbiota."
  honesty = "Carbohydrate class counts (mono/di/oligo/poly) are a biochemical taxonomy of chemical structure — not a lattice partition; intermediate and hybrid structures exist."
  |> "[@x_fennema_textbook]"

@D dom_proteins := "protein structure and food functionality" :: domain [ok]
  essential-aa = "Essential amino acids (cannot be synthesised de novo in humans at adequate rates): His, Ile, Leu, Lys, Met, Phe, Thr, Trp, Val — nine by current consensus. Count is biological/nutritional science, not lattice-derived."
  denaturation = "Thermal denaturation: disruption of non-covalent secondary/tertiary structure → loss of solubility / changed functionality; temperature threshold is protein-specific (e.g. myosin ~50°C, ovalbumin ~84°C)."
  functionality = "Food-protein functional properties: foaming (air/water interface stabilisation by denatured protein films), emulsification (amphiphilic surface activity at oil/water interfaces), gelation (network formation from partially denatured aggregates — heat/acid/salt induced)."
  maillard-link = "Free amino groups (especially Lys ε-amino) are the amine reactants in the Maillard reaction (see [@dom_maillard])."
  |> "[@x_fennema_textbook] · [@x_damodaran_food_proteins]"

@D dom_lipids := "lipid classes and stability" :: domain [ok]
  saturated = "Saturated fatty acids (SFA) — no double bonds; solid/waxy at room temperature; more resistant to oxidation."
  unsaturated = "Unsaturated: monounsaturated (MUFA, one C=C), polyunsaturated (PUFA, two or more C=C, e.g. linoleic 18:2 ω-6, α-linolenic 18:3 ω-3). Susceptibility to oxidation rises sharply with degree of unsaturation."
  trans = "Trans fatty acids: from partial hydrogenation of vegetable oils (industrial) or ruminant biohydrogenation (natural, at lower levels). Industrial trans fats are banned/restricted in many jurisdictions (FDA 2018 determination)."
  iodine-value = "Iodine value (IV): grams of I₂ absorbed per 100 g fat — a classical analytical measure of total unsaturation degree; higher IV = more double bonds = higher oxidative risk."
  rancidity = "Rancidity: hydrolytic (lipase-catalysed → free fatty acids; acyl-ester cleavage in moist/high-aw environments) or oxidative (radical-chain mechanism; see [@dom_lipid_oxidation])."
  |> "[@x_fennema_textbook]"

@D dom_water_activity := "water activity and free vs bound water" :: domain [ok]
  aw = "Water activity (aw) = p/p₀ = ratio of vapour pressure of food to pure water at the same temperature. Ranges 0 (bone-dry) to 1.0 (pure water)."
  free-vs-bound = "Free water (high aw) is available as a solvent and supports microbial growth, enzymatic reactions and chemical deterioration. Bound water (associated with macromolecule surfaces, dissolved solutes) is less available."
  thresholds = "aw < 0.60: most microbial growth ceases (bacteria typically need aw > 0.90; most yeasts > 0.80; xerophilic moulds can grow as low as ~0.60–0.70). Mould growth floor conventionally cited near aw 0.70–0.75 (see [@lim_aw_floor])."
  sorption = "Moisture sorption isotherms (BET/GAB models) describe the water content ↔ aw relationship for a given food matrix — non-linear, hysteretic."
  |> "[@x_labuza_water_activity] · [@x_fennema_textbook]"

# ── §2 Browning chemistry ─────────────────────────────────────────────

@D dom_maillard := "Maillard reaction — mechanism (Hodge 1953)" :: mechanism [ok]
  discovery = "Louis-Camille Maillard described the reaction of amino acids with reducing sugars in 1912; the mechanistic framework was systematised by Hodge (1953) into an interconnected scheme of three broad stages."
  stage1 = "Stage 1 — initial (colourless): condensation of amine group (free amino acid or Lys ε-NH₂ of protein) + reducing sugar carbonyl → N-glycosylamine → Amadori rearrangement product (ARP) (1-amino-1-deoxy-2-ketose). Reversible."
  stage2 = "Stage 2 — intermediate (yellow, some volatiles): ARPs degrade via multiple routes — 1,2-enolisation (forming reductones/3-deoxyosones) or 2,3-enolisation (furfural/HMF from pentoses/hexoses respectively); Strecker degradation of amino acids by α-dicarbonyl intermediates → aldehydes (Strecker aldehydes, e.g. methional, phenylacetaldehyde) + aminoketones → CO₂ loss; together these generate the bulk of Maillard-associated volatile aroma compounds."
  stage3 = "Stage 3 — final (brown/black, melanoidins): condensation and polymerisation of reactive intermediates into high-molecular-weight, nitrogen-containing melanoidin pigments (heterogeneous structure). Colour and antioxidant activity of the product depend on stage-1/2 reactant balance, temperature, time and pH."
  drivers = "Accelerated by: higher temperature, lower aw (concentrated, dry conditions), alkaline pH (more reactive free amine at higher pH), reducing-sugar type (pentoses > hexoses; glucose > fructose in many systems)."
  |> "[@x_hodge_1953]"

@D dom_caramelisation := "caramelisation — sugar-only browning" :: mechanism [ok]
  definition = "Thermal degradation of sugars in the ABSENCE of amines — high temperature, no protein/amino-acid co-reactant required."
  temperature = "Onset temperatures (pure sugars): fructose ~110°C, glucose ~160°C, sucrose ~160–180°C. In complex food matrices these shift."
  products = "Caramel flavour compounds: furans, furanones, diacetyl, maltol; brown melanin-like polymers (caramels). Distinct from Maillard melanoidins in the absence of N-containing pigment."
  distinction = "Maillard = amine + reducing sugar (requires N source); caramelisation = sugar thermal degradation (N-free). Both co-occur in baking/roasting/cooking."
  |> "[@x_fennema_textbook]"

@D dom_acrylamide := "acrylamide formation in heat-processed starchy foods" :: mechanism [ok]
  discovery = "Tareke et al (2002) first reported high acrylamide levels in heat-processed foods (Swedish National Food Agency / Stockholm University study, J Agric Food Chem 50:4998–5006)."
  mechanism = "Free asparagine + reducing sugars (primarily glucose/fructose) at temperatures > ~120°C → Maillard-pathway intermediates → acrylamide (CH₂=CH–CO–NH₂) via decarboxylation and elimination from Schiff base adducts. Asparagine is the primary amine precursor; other Strecker pathways contribute minor amounts."
  foods = "High-risk foods: french fries, potato crisps, breakfast cereals, biscuits/cookies, bread crust, coffee (roasting). Levels in μg/kg range; regulatory benchmarks set (EFSA opinions; FDA guidance)."
  mitigation = "Reduction strategies: lower fry/bake temperature, shorter time, asparaginase treatment of dough (enzymatic asparagine depletion), variety selection for lower free-asparagine cultivars, aw reduction prior to frying."
  |> "[@x_tareke_2002] · [@x_efsa_acrylamide]"

@D dom_lipid_oxidation := "lipid oxidation — initiation / propagation / termination" :: mechanism [ok]
  initiation = "Initiation: abstraction of a bisallylic H from a PUFA methylene (C–H bond weakened by flanking C=C bonds) by radical initiators (heat, light, metal ions, pre-formed radicals) → lipid alkyl radical (L•)."
  propagation = "Propagation: L• + O₂ → lipid peroxyl radical (LOO•); LOO• + LH → LOOH (lipid hydroperoxide) + L• → chain-carries until termination. Rate rises with unsaturation degree and O₂ access."
  termination = "Termination: radical–radical combination (L•+L•, L•+LOO•, LOO•+LOO•) → non-radical products (stable dimers, aldehydes, etc.). Terminators are antioxidants acting as H-donors or metal chelators."
  secondary-products = "Lipid hydroperoxides (primary oxidation products) → volatile secondary aldehydes (hexanal, malondialdehyde), ketones, alcohols — organoleptic rancidity markers."
  antioxidants = "Synthetic: BHA (butylated hydroxyanisole), BHT (butylated hydroxytoluene) — phenolic H-donors, chain-terminating. Natural: tocopherols (vitamin E; α-tocopherol the most active antioxidant in membranes/fats), ascorbate (aqueous-phase reducing agent + metal chelator), rosemary extracts (carnosic acid)."
  synergism = "Antioxidant synergism: tocopherol regeneration by ascorbate (aqueous–lipid interface handoff) amplifies efficacy beyond additive — a documented physical-chemistry phenomenon, not a lattice product."
  |> "[@x_fennema_textbook] · [@x_frankel_lipid_oxidation]"

# ── §3 Microbial safety & the FAT-TOM mnemonic ───────────────────────

@D dom_fattom := "FAT-TOM — intrinsic/extrinsic factors governing microbial growth" :: domain [ok]
  mnemonic = "FAT-TOM = Food (nutrients) · Acidity (pH) · Time · Temperature · Oxygen · Moisture (aw). Six physical-environmental factors that together determine whether a microbial hazard can grow to unsafe levels in a food."
  food-nutrients = "Nutrient availability varies: high-protein/high-carbohydrate foods support rapid growth of many pathogens; competition with resident microbiota also modulates outcome."
  acidity = "pH: most pathogens grow between pH 4.6–9. Foods at or below pH 4.6 (acid/acidified foods) are considered low-risk for Clostridium botulinum toxin production — the basis for the US FDA 21 CFR pH-4.6 cut-off for canned foods."
  temperature = "Temperature: USDA 'Danger Zone' 4–60°C (40–140°F) — the range where most foodborne pathogens grow at measurable rates. Refrigeration (≤4°C) slows but does not eliminate growth of psychrotrophs such as Listeria monocytogenes."
  oxygen = "Oxygen: obligate aerobes (most spoilage bacteria) vs facultative anaerobes (Staphylococcus aureus, Salmonella) vs obligate anaerobes (Clostridium spp.). MAP and vacuum packaging manipulate this factor."
  moisture = "Moisture (aw) — see [@dom_water_activity]; aw < 0.85 restricts growth of most non-xerophilic bacteria; aw < 0.60 stops virtually all microbial growth."
  honesty = "FAT-TOM is a mnemonic framework of 6 factors established in food-safety pedagogy — this '6' count is a mnemonic classification of biological and physical variables, NOT a lattice value. See [@n6_honest_stance]."
  |> "[@x_potter_hotchkiss_textbook] · [@x_codex_alimentarius]"

@D dom_pathogens := "major foodborne bacterial pathogens" :: domain [ok]
  salmonella = "Salmonella spp. — leading cause of bacterial foodborne illness globally; reservoir: poultry, eggs, produce, nuts; grows 7–48°C; killed at standard pasteurization; infective dose variable (typically 10^4–10^6 cells for non-typhoidal)."
  listeria = "Listeria monocytogenes — psychrotrophic (grows 0–45°C, optimum 30–37°C, including in refrigerated foods); zero-tolerance regulatory policy on ready-to-eat (RTE) foods in many jurisdictions (US FDA/USDA, EU 2073/2005); high lethality in immunocompromised, pregnant, elderly."
  ecoli = "Escherichia coli O157:H7 (and other STECs) — Shiga-toxin-producing; very low infective dose (~10–100 cells); haemorrhagic colitis, haemolytic-uraemic syndrome risk; reservoir: ruminants (cattle); critical hazard in raw/undercooked beef, raw leafy greens."
  campylobacter = "Campylobacter jejuni — most common bacterial cause of diarrhoeal illness in many high-income countries; reservoir: poultry (high colonisation rates); grows only under microaerophilic conditions, so culture-confirmation requires specialised technique."
  c-botulinum = "Clostridium botulinum — endospore-forming obligate anaerobe; produces the most acutely toxic biological substance known (botulinum neurotoxin); hazard in low-acid anaerobic environments (canned foods, garlic-in-oil, fermented products); control: heat (retort/UHT), pH < 4.6, aw < 0.94, sodium nitrite in cured meats."
  b-cereus = "Bacillus cereus — sporulating, heat-resistant; two syndromes: emetic (preformed cereulide toxin, heat-stable, in starchy cooked-rice dishes) and diarrhoeal (enterotoxin, heat-labile)."
  s-aureus = "Staphylococcus aureus — produces preformed, heat-stable enterotoxins (inactivation requires > 100°C for extended periods); risk from high-touch (hands/nasal carriage) preparation in foods held in temperature danger zone; growth suppressed by aw < 0.86 (toxin production needs aw > 0.92)."
  honesty = "Pathogen list is representative of major established hazards in the food-safety literature, not exhaustive. Regulatory-threshold figures are paraphrased from publicly available guidance — see [@scope_disclaimer]."
  |> "[@x_potter_hotchkiss_textbook] · [@x_codex_alimentarius] · [@x_fda_bad_bug_book]"

@D dom_hurdle := "hurdle technology (Leistner)" :: mechanism [ok]
  concept = "Leistner's hurdle technology: effective preservation is achieved by combining multiple sub-lethal antimicrobial factors (hurdles) rather than relying on any single intervention at extreme intensity. Each hurdle (aw, pH, temperature, redox, preservatives) need only be applied at a mild level; the combination is synergistic or at least additive."
  hurdles = "Common hurdles: high temperature (processing), low temperature (storage), low aw, low pH, low Eh (redox potential), competitive microflora, preservatives (nitrite, sorbate, benzoate, organic acids)."
  homeostasis = "The physiological rationale: microbial cells subjected to multiple simultaneous stresses must expend energy restoring homeostasis in multiple dimensions simultaneously, exhausting metabolic capacity below the level needed to grow/reproduce."
  practical = "Intermediate-moisture foods (aw 0.60–0.90), fermented sausages, and minimally processed refrigerated foods are all hurdle-technology products. The principle explains why combined reduced-aw + mild acid + refrigeration outperforms extreme aw reduction alone."
  |> "[@x_leistner_hurdle]"

# ── §4 Preservation technologies ─────────────────────────────────────

@D dom_thermal := "thermal preservation — pasteurization, retort, UHT" :: domain [ok]
  pasteurization = "Pasteurization: mild heat (typically 63°C/30 min LTLT or 72°C/15 s HTST for milk) to eliminate vegetative pathogens and reduce spoilage load without sterilisation; refrigerated storage required post-process; shelf-life days to weeks."
  retort = "Retort/sterilisation (commercial sterilisation): high-temperature pressure cooking of sealed containers (typically ≥121°C / 250°F, 3+ min at the thermal centre) to achieve 12D (12 log) reduction of C. botulinum spores in low-acid foods — the F₀ concept (lethality at 121°C reference temperature). Shelf-stable at ambient temperature."
  uht = "UHT (ultra-high temperature): 135–150°C for 2–5 seconds, aseptic packaging → commercially sterile, ambient-stable fluid products (milk, juices). Applies equivalent lethality to retort with less heat damage to nutrients/flavour (high T, short t)."
  z-value = "Thermal death kinetics: D-value (time at a given T to achieve 1-log reduction); z-value (°C change for 10× change in D); these are organism/food-matrix specific — not lattice constants."
  |> "[@x_potter_hotchkiss_textbook] · [@x_codex_alimentarius]"

@D dom_refrigeration := "refrigeration and freezing" :: domain [ok]
  refrigeration = "Refrigeration (≤4°C/40°F): slows enzyme and microbial activity but does not eliminate psychrotrophic growth (Listeria, Pseudomonas, etc.). Shelf-life extension proportional to temperature drop."
  freezing = "Freezing (< −18°C): arrests microbial growth and most enzymatic activity; ice-crystal damage — slow freezing → large extracellular ice crystals → cell disruption → drip loss on thaw; rapid freezing → small crystals → better texture retention. Recrystallisation during storage degrades texture over time."
  cold-chain = "Efficacy depends on maintaining the cold chain unbroken; partial thaw-refreeze cycles degrade quality and can allow transient microbial growth at intermediate temperatures."
  |> "[@x_potter_hotchkiss_textbook]"

@D dom_drying := "drying and water-activity reduction" :: domain [ok]
  principle = "Reduction of aw to below the growth threshold of target organisms (bacteria < 0.85–0.90; moulds < 0.70–0.75 generally; aw < 0.60 for all spoilage organisms)."
  methods = "Sun drying, spray drying, freeze drying (lyophilisation — sublimation at low T/P → minimal heat damage, best quality retention), drum drying, fluidised-bed drying."
  maillard-risk = "Spray/drum drying of protein-carbohydrate mixtures accelerates Maillard browning due to concentration and elevated temperature — colour and lysine availability losses."
  |> "[@x_labuza_water_activity] · [@x_fennema_textbook]"

@D dom_curing := "salt and nitrite curing" :: domain [ok]
  salt = "Salt (NaCl) reduces aw, increases osmotic pressure — bacteriostatic; primary historical preservation mechanism in meat, fish, vegetables."
  nitrite = "Sodium/potassium nitrite: inhibits C. botulinum outgrowth from spores in cured/cooked anoxic meat (mechanism: reacts with iron-sulfur proteins of the electron-transport chain; also forms NO, which binds myoglobin → pink colour). Legally regulated maximum residual levels."
  maillard-precursor = "Nitrite + amines → N-nitrosamines under acid/heat conditions; some N-nitrosamines are rodent carcinogens (IARC Group 1/2A). Also, processed/red-meat consumption is associated with colorectal cancer risk in epidemiological evidence (IARC 2015) — a documented health tradeoff with the botulism-prevention benefit."
  tradeoff = "Nitrite is irreplaceable at current technology for botulism control in cured anaerobic meat products. The safety tradeoff (nitrosamine cancer risk vs botulism prevention) is an active regulatory and scientific discussion, not a lattice-resolvable trade."
  |> "[@x_iarc_processed_meat] · [@x_potter_hotchkiss_textbook]"

@D dom_emerging := "emerging/non-thermal preservation" :: domain [ok]
  map = "Modified atmosphere packaging (MAP): CO₂ inhibits spoilage moulds/bacteria; N₂ displaces O₂ to limit oxidation; O₂ added for red-meat bloom. Composition tailored to product (meat, fresh produce, baked goods)."
  hpp = "High-pressure processing (HPP): isostatic pressure 300–600 MPa at ambient temperature inactivates vegetative cells and some viruses without heat damage; spores are pressure-resistant — HPP is NOT equivalent to retort for low-acid foods."
  pef = "Pulsed electric fields (PEF): microsecond high-voltage pulses cause membrane electroporation → cell inactivation; primarily cold-pasteurisation of fluid foods; also used for extraction/blanching."
  irradiation = "Food irradiation (gamma, e-beam, X-ray): ionising radiation doses (kGy range) reduce pathogen load (D-values expressed in kGy); approved in many countries for specific food categories; does not induce food radioactivity."
  |> "[@x_potter_hotchkiss_textbook]"

# ── §5 HACCP framework ────────────────────────────────────────────────

@D dom_haccp := "HACCP — Hazard Analysis and Critical Control Points" :: domain [ok]
  origin = "Developed by Pillsbury Company in collaboration with NASA in the late 1960s for US space-food safety (zero-defect approach). Codified into the Codex Alimentarius framework (CAC/RCP 1-1969, Rev.4 2003); legally mandated in many jurisdictions."
  seven-principles = "The 7 HACCP principles: (1) Conduct a hazard analysis; (2) Identify critical control points (CCPs); (3) Establish critical limits for each CCP; (4) Establish monitoring procedures; (5) Establish corrective actions; (6) Establish verification procedures; (7) Establish record-keeping and documentation. Seven is the number established by the Codex Alimentarius Commission — NOT a lattice number (see [@n6_honest_stance])."
  ccp = "A CCP is a step in the process where a control measure can be applied to prevent, eliminate or reduce a food safety hazard to an acceptable level. Examples: retort temperature/time, pasteurisation HTST, metal detection, pH < 4.6."
  scope = "HACCP is a preventive, science-based system focused on biological, chemical and physical hazards. It is the international food-safety management standard (Codex, ISO 22000, FSMA in the US)."
  |> "[@x_codex_alimentarius]"

# ── §6 Sensory science ───────────────────────────────────────────────

@D dom_sensory := "sensory science — taste, olfaction, trigeminal" :: domain [ok]
  five-tastes = "The five recognised basic/primary tastes: sweet (sugars, some amino acids, saccharin), sour (H⁺/acids), salty (Na⁺ ionic), bitter (alkaloids, phenolic glycosides, many bitter-tasting compounds; the most diverse chemosensory category), umami (glutamate — first characterised by Kikunae Ikeda in 1909 from kombu seaweed extract; also synergised by 5'-IMP and 5'-GMP ribonucleotides). Five is a scientific consensus from validated receptor/neurological evidence — not a lattice constant."
  umami = "Umami (旨味, 'delicious/savoury taste'): identified by Ikeda Kikunae (1909) as the taste of L-glutamate / monosodium glutamate (MSG). Umami receptors: T1R1+T1R3 heterodimer on type-II taste-receptor cells; mGluR4 variant. Glutamate is abundant in parmesan, soy sauce, fermented foods, tomatoes, meat."
  fat-candidate = "A sixth basic taste candidate, for dietary fat (oleogustus / fat taste via free fatty acids), is debated in current sensory science literature. Observation: free fatty acid receptors (GPR120/CD36) are expressed on taste cells; the full receptor/perceptual-quality story is under active investigation. This tape notes the debate without claiming resolution — explicitly NOT a lattice n=6 completion."
  olfaction = "Olfaction provides the majority of what is perceived as 'flavour' (retronasal olfaction). Volatile aroma compounds generated by Maillard/caramelisation/fermentation interact with ~400 active olfactory receptor genes in humans (vs ~800 in mouse). Flavour = taste + retronasal olfaction + texture + trigeminal."
  trigeminal = "Trigeminal (chemesthesis): pungency (capsaicin/TRPV1), cooling (menthol/TRPM8), astringency (tannin–protein precipitation → tactile). These are not 'tastes' in the taste-receptor sense."
  honesty = "The debate around the number of basic tastes is a current scientific discussion anchored in receptor biology — the count (5, possibly 6) follows the evidence, not the lattice. See [@n6_honest_stance]."
  |> "[@x_ikeda_1909] · [@x_fennema_textbook]"

# ── §7 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ───

@D lim_listeria_zero := "Listeria monocytogenes zero-tolerance in RTE foods" :: real-limit [ok required]
  wall = "HARD REGULATORY + BIOLOGICAL LIMIT"
  statement = "Listeria monocytogenes is subject to a zero-tolerance (absent in 25 g / 25 mL) regulatory standard for ready-to-eat (RTE) foods that support its growth in many jurisdictions (US FDA/USDA, EU Regulation 2073/2005). This reflects its psychrotrophic capacity (grows at refrigerator temperatures down to 0°C) and high case-fatality rate (~20–30%) in immunocompromised/pregnant populations."
  consequence = "For RTE food manufacturers: there is no 'acceptable level' of L. monocytogenes in the post-process product when growth potential exists — the detection sensitivity limit is the operational floor (typically PCR-based methods, ≥10^1–10^2 CFU/g analytical sensitivity, but regulatory criterion is not detected in 25 g)."
  |> "[@x_fda_bad_bug_book] · [@x_codex_alimentarius]"

@D lim_acrylamide_unavoidable := "acrylamide in heat-processed starchy foods — unavoidable below regulatory benchmarks" :: real-limit [ok required]
  wall = "SOFT WALL (chemistry-constrained; reducible but not eliminable at current technology)"
  statement = "Acrylamide forms spontaneously from free asparagine and reducing sugars at temperatures > ~120°C — the same Maillard-pathway chemistry that generates desired browning and flavour. Any heat-processed starchy food that undergoes surface browning will generate some acrylamide; elimination requires either eliminating the reaction (impossible in current baked/fried products) or removing the precursors (asparaginase treatment; low-asparagine variety selection — reduces but does not eliminate)."
  regulation = "EFSA (2015, 2020 opinions) set indicative/performance benchmarks for acrylamide in various food categories; US FDA issued guidance in 2016. Levels in the high hundreds to low thousands μg/kg in worst-case products."
  |> "[@x_tareke_2002] · [@x_efsa_acrylamide]"

@D lim_allergens := "Big 8/9 food allergens — hard biological triggers" :: real-limit [ok required]
  wall = "HARD BIOLOGICAL LIMIT (host immune system)"
  statement = "IgE-mediated food allergy to the major food allergens (historically 'Big 8' in the US, now 'Big 9' with addition of sesame per FASTER Act 2021: peanut, tree nuts, milk, egg, wheat/gluten, soy, fish, shellfish, sesame) is a fixed host-immune response to stable protein epitopes. For sensitised individuals, ingestion of even milligram quantities can trigger anaphylaxis. There is no food-processing step that reliably destroys all allergenicity of the major allergens (though Maillard modification of peanut allergens can alter but not eliminate IgE binding; thermal treatment varies by allergen)."
  consequence = "Food labelling of allergens is a hard regulatory requirement (US FALCPA/FASTER Act; EU 1169/2011). Cross-contact (trace contamination) is the primary industrial management challenge. The 'Big 9' count is a regulatory/biological classification — not lattice-derived."
  |> "[@x_fennema_textbook] · [@x_fda_bad_bug_book]"

@D lim_spoilage_kinetics := "spoilage kinetics vs shelf-life economics" :: real-limit [ok required]
  wall = "SOFT WALL (kinetic/economic)"
  statement = "Spoilage is a continuous kinetic process (microbial, enzymatic, oxidative, chemical) governed by time × temperature × aw × pH × O₂. Shelf-life is an economic/sensory threshold, not an engineering absolute — 'best before' is the point at which quality falls below acceptable, not the point at which the food becomes dangerous. Extending shelf-life requires either slowing the kinetics (hurdle technology, MAP, cold chain) or improving the product formulation — each with diminishing returns and consumer-acceptability trade-offs."
  |> "[@x_leistner_hurdle] · [@x_labuza_water_activity]"

@D lim_nutrient_preservation := "nutrient retention vs preservation intensity tradeoff" :: real-limit [ok required]
  wall = "SOFT WALL (process-chemistry)"
  statement = "Preservation processes that are more intense (higher temperature, longer time, stronger chemical treatment) achieve greater microbial safety but incur greater nutrient and flavour losses. Heat-labile vitamins (C, thiamin, folate) are partially destroyed by retort processing; UHT reduces this loss but does not eliminate it. Freeze-drying preserves nutrients best of all drying methods but is the most energy-intensive. No current preservation technology simultaneously maximises all of: microbial safety, nutrient retention, flavour quality, shelf-life, and economic cost."
  |> "[@x_potter_hotchkiss_textbook] · [@x_fennema_textbook]"

# ── §8 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-food-science" :: governance [required deny:write]
  pattern = "Deriving food-science quantities (safety detection rates, shelf-life days, nutrient retention %, sensory scores, pathogen counts, FAT-TOM factor count) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'shelf-life = 180 days because σ·φ' or 'safety detection = 99% because σ·sopfr/10' or '6 FAT-TOM factors because n=6'."
  why = "This is exactly the fabrication the pre-rewrite FOOD-SCIENCE.tape committed (see FOOD-SCIENCE.log.tape audit — lattice-tautology stubs with Korean-language lattice mappings, σ/τ/φ/J₂ row-by-row, no real food science). hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 forbid it."
  remedy = "Cite real food-chemistry/food-safety sources (this tape's @X entries). The FAT-TOM mnemonic has 6 factors as a pedagogical mnemonic of biological/physical variables — OBSERVATION coincidence only, never a lattice derivation."

@N n6_honest_stance := "food chemistry has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: food science exposes NO natural n=6 invariant. FAT-TOM has 6 factors by pedagogical convention covering 6 biological/physical variables — not derived from n=6. The 9 essential amino acids, 7 HACCP principles, Big-9 allergens, 5 basic tastes (with a debated 6th candidate from receptor biology, not from the lattice), and the Maillard reaction's 3 broad stages are all counts set by biochemistry, receptor biology, regulatory classification, and historical agreement — NOT by σ=12, τ=4, φ=2, or J₂=24. Even if a count numerically equals 6 (e.g. FAT-TOM), the causal path is biology/convention, not the lattice. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool) and LATTICE_POLICY: the lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub."

# ── §9 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 Maillard temperature-dependence" :: prediction [ok]
  claim = "Maillard browning rate in a model system (glucose + glycine, aw ~0.5) approximately doubles per 10°C temperature increase in the 50–100°C range (Q10 ~2); colour (Absorbance 420 nm) and volatile Strecker aldehyde yield both increase monotonically with temperature at fixed time."
  falsifier = "If a controlled isothermal model-system study shows no significant browning rate increase across the 50–100°C range, the Hodge/general Maillard temperature-dependence claim in [@dom_maillard] is wrong."
  source = "[@x_hodge_1953] · [@x_fennema_textbook]"

@D tp_2 := "TP-2 water-activity microbial growth floor" :: prediction [ok]
  claim = "No known foodborne bacterial pathogen (including xerotolerant strains of Staphylococcus aureus) can grow at aw < 0.85 under otherwise optimal conditions; mould growth of most spoilage and mycotoxigenic species is suppressed at aw < 0.70."
  falsifier = "If a peer-reviewed isolation study documents growth (not survival) of a bona fide bacterial food pathogen below aw 0.85, or mould growth of a non-xerophilic food spoilage species below aw 0.60, [@lim_aw_floor] / [@dom_water_activity] thresholds need revision."
  source = "[@x_labuza_water_activity] · [@x_potter_hotchkiss_textbook]"

@D tp_3 := "TP-3 acrylamide obligatory co-product" :: prediction [ok]
  claim = "Starchy food subjected to surface browning above ~120°C in the presence of free asparagine and reducing sugars will contain detectable acrylamide (above analytical detection limit); complete elimination without asparaginase treatment and/or variety selection is not achievable at conventional baking/frying temperatures."
  falsifier = "If a properly controlled baking trial at 180°C with a high-asparagine cultivar produces oven-browned product with acrylamide below LLOQ (lower limit of quantification by LC-MS/MS), the obligatory-formation claim in [@dom_acrylamide] is wrong."
  source = "[@x_tareke_2002] · [@x_efsa_acrylamide]"

# ── §10 Cross-links ───────────────────────────────────────────────────

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). This tape complies: real food science, in-silico knowledge SSOT only, lattice declined as a derivation tool."

# ── §11 External citations (real, landmark literature) ────────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names the primary author + era only and says so explicitly.

@X x_hodge_1953 := "Hodge JE 1953 — Maillard reaction mechanism" :: literature [active]
  ref = "Hodge JE. Dehydrated foods: chemistry of browning reactions in model systems. J Agric Food Chem 1953;1:928–943. (The systematic Maillard mechanism framework: 3 stages, Amadori rearrangement, melanoidin formation. Primary Maillard mechanistic reference for this tape.)"

@X x_tareke_2002 := "Tareke et al 2002 — acrylamide in heat-processed foods" :: literature [active]
  ref = "Tareke E, Rydberg P, Karlsson P, Eriksson S, Törnqvist M. Analysis of acrylamide, a carcinogen formed in heated foodstuffs. J Agric Food Chem 2002;50:4998–5006. (First major report of acrylamide in cooked/fried starchy foods, Stockholm University / Swedish National Food Agency.)"

@X x_ikeda_1909 := "Ikeda K 1909 — umami / glutamate discovery" :: literature [active]
  ref = "Ikeda K. New seasonings (Neue Würzen). J Tokyo Chem Soc 1909;30:820–836. (Primary discovery paper for umami taste, L-glutamate as the taste-active compound from kombu. Primary author/era; the Japanese original pre-dates English translations. English translation: Chem Senses 2002;27:847–849.)"

@X x_fennema_textbook := "Fennema — Food Chemistry (textbook era)" :: literature [active]
  ref = "Fennema OR (ed). Food Chemistry (primary editions 1976, 1985, 1996; Damodaran S, Parkin KL, Fennema OR, 4th ed 2008, CRC Press). Standard food-chemistry reference covering macronutrient composition, browning chemistry, lipid oxidation, water activity, sensory science. Primary-author/era cited; 4th edition (2008) is the current canonical form of the Fennema tradition."

@X x_damodaran_food_proteins := "Damodaran — food protein functionality" :: literature [active]
  ref = "Damodaran S. Food proteins: an overview. Chapter in: Damodaran S, Parkin KL, Fennema OR (eds). Fennema's Food Chemistry, 4th ed. CRC Press, 2008. (Foaming, emulsification, gelation, denaturation review — primary-author/era cited.)"

@X x_labuza_water_activity := "Labuza — water activity in food science" :: literature [active]
  ref = "Labuza TP. Sorption phenomena in foods. Food Technol 1968;22:263–272; and Labuza TP, Tannenbaum SR, Karel M. Water content and stability of low-moisture and intermediate-moisture foods. Food Technol 1970;24:543–550. (Foundational water-activity / food-stability framework. Primary author/era.)"

@X x_frankel_lipid_oxidation := "Frankel — Lipid Oxidation" :: literature [active]
  ref = "Frankel EN. Lipid Oxidation (2nd ed., The Oily Press / Woodhead Publishing, 2005). Standard mechanistic reference for initiation/propagation/termination, antioxidant mechanism, Rancimat/TOTOX measurement. Primary author/era."

@X x_leistner_hurdle := "Leistner — hurdle technology" :: literature [active]
  ref = "Leistner L. Basic aspects of food preservation by hurdle technology. Int J Food Microbiol 2000;55:181–186. (The definitive hurdle-technology mechanistic framework paper; primary author/era.)"

@X x_potter_hotchkiss_textbook := "Potter & Hotchkiss — Food Science (textbook era)" :: literature [active]
  ref = "Potter NN, Hotchkiss JH. Food Science (5th ed., Chapman & Hall, 1995). Classic food-science textbook covering preservation technologies (thermal, refrigeration, drying, curing), FAT-TOM framework, HACCP, major pathogens. Primary author/era."

@X x_codex_alimentarius := "Codex Alimentarius Commission — HACCP and food safety standards" :: literature [active]
  ref = "Codex Alimentarius Commission. Hazard Analysis and Critical Control Point (HACCP) System and Guidelines for Its Application. Annex to CAC/RCP 1-1969 (General Principles of Food Hygiene), Revision 4 (2003). Rome: FAO/WHO. (Institutional document family; primary HACCP 7-principle framework reference used internationally.)"

@X x_fda_bad_bug_book := "FDA Bad Bug Book — foodborne pathogens" :: literature [active]
  ref = "US FDA. Bad Bug Book: Foodborne Pathogenic Microorganisms and Natural Toxins Handbook (2nd ed., 2012). Freely available FDA reference on Salmonella, Listeria, E. coli O157:H7, Campylobacter, C. botulinum, B. cereus, S. aureus and others; infectious/toxic doses, symptoms, foods involved. Institutional, publicly available."

@X x_iarc_processed_meat := "IARC Monograph 114 — processed meat / red meat (2015)" :: literature [active]
  ref = "International Agency for Research on Cancer (IARC). IARC Monographs on the Evaluation of Carcinogenic Risks to Humans, Volume 114: Red Meat and Processed Meat. Lyon: IARC, 2015. (Processed meat classified Group 1 carcinogen; red meat Group 2A; colorectal cancer primary endpoint. Institutional monograph.)"

@X x_efsa_acrylamide := "EFSA — acrylamide opinions" :: literature [active]
  ref = "European Food Safety Authority (EFSA). Scientific opinion on acrylamide in food. EFSA Journal 2015;13(6):4104. (And subsequent monitoring/benchmarking reports.) Institutional regulatory science document on acrylamide dietary exposure, risk characterisation, and benchmark levels."

# ── §12 Water-activity limit anchor (used in tp_2, dom_water_activity) ─

@D lim_aw_floor := "aw 0.60 as the absolute microbial growth floor" :: real-limit [ok required]
  wall = "HARD BIOLOGICAL LIMIT (known microbiology)"
  statement = "Water activity < 0.60 is the conventional absolute lower bound for microbial growth in food systems — even xerophilic organisms (Zygosaccharomyces rouxii, halophilic bacteria) cannot grow at aw < 0.60 under food conditions at ambient temperature. This is a biophysical limit set by enzyme kinetics and membrane function in dehydrated conditions, not by any lattice value."
  |> "[@x_labuza_water_activity] · [@x_potter_hotchkiss_textbook]"
