#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# HEXA-VIROCAPSID.tape — architecture-current (editable per v1.2)
# Event history → HEXA-VIROCAPSID.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §0 Identity ──────────────────────────────────────────────────────

@I id001 := "hexa-virocapsid" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · VIROCAPSID axis — viral capsid biology (life-cycle packaging · maturation · gene-therapy vector use · immunogenicity · VLP vaccines)"
  brief = "viral-specific capsid axis · packaging motors · HK97-class maturation chainmail · AAV/lentivirus/adenovirus vectors · capsid-mediated immunity · VLP vaccine antigens · n=6 lattice DECLINED as derivation tool (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "HEXA-VIROCAPSID.log.tape"
  scope = "in-silico viral-capsid simulator consistency SSOT · NOT wet-lab/therapeutic claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see HEXA-VIROCAPSID.log.tape audit"
  axis-note = "VIROCAPSID is a CORE hexa-bio axis. The n=6 lattice may APPEAR in native-lattice-spec context but is never the source of a serotype count, packaging force, T-number, neutralizing-antibody seroprevalence, or vector cargo limit. See [@f_lattice_fit] + [@n6_honest_stance]."
  specialization-vs-weave = "VIROCAPSID specializes the general assembly framework (Caspar–Klug + Zlotnick) provided by [@x_hexa_weave_sibling] to the VIROLOGICAL setting: viral life cycle, genome packaging by ATP-driven motors, post-assembly maturation, gene-therapy vector engineering, and host humoral immunity against capsid antigens. Caspar–Klug T-number theory and Zlotnick nucleation–elongation are CROSS-REFERENCED to HEXA-WEAVE, not re-derived here."

@N scope_disclaimer := "in-silico viral-capsid scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico viral-capsid modeling substrate. Serotype names, T-numbers, packaging forces, cargo size limits, and seroprevalence figures are paraphrased from structural-virology / gene-therapy / vaccine literature for modeling context only. A C2/C3 in-silico simulator-consistency PASS here is NOT a clinical, immunogenicity, vector-efficacy, or vaccine-platform claim — every prediction is unverified at the wet-lab / clinical boundary (hexa-bio AGENTS.tape g8_in_silico_only). Quantitative magnitudes (e.g. AAV ~4.7 kb cargo) are well-established field constants from the cited primary literature, not re-derived constants. Where exact volume/pages are not asserted, the citation is given by primary-author/era only (literature-honesty rule)."
  |> "[@x_caspar_klug_1962] · [@x_wikoff_2000] · [@x_smith_2001]"

# ─── §1 What VIROCAPSID adds beyond HEXA-WEAVE (virology specialization) ─

@D vc_specialization := "what makes VIROCAPSID virological (vs general assembly)" :: domain [ok]
  weave-handles = "General icosahedral / quasi-equivalent capsid & cage geometry, Caspar–Klug T = h²+hk+k² enumeration, 12-pentamer Euler constraint, Zlotnick equilibrium / nucleation–elongation assembly thermodynamics+kinetics, kinetic traps. Cross-reference [@x_hexa_weave_sibling] for all of this — NOT re-derived here."
  virocapsid-adds-1 = "Viral LIFE CYCLE coupling: capsid assembly is one stage of an obligate intracellular replication cycle (entry · uncoating · genome replication · capsid assembly · genome packaging · maturation · egress · re-entry), not standalone self-assembly."
  virocapsid-adds-2 = "Active genome PACKAGING by molecular motors (dsDNA phages, herpesviruses) against tens of pN forces — distinct from passive co-assembly."
  virocapsid-adds-3 = "Post-assembly MATURATION: a metastable procapsid undergoes large-scale conformational expansion / proteolytic processing / covalent crosslinking after packaging (HK97 chainmail is the paradigm)."
  virocapsid-adds-4 = "Use as GENE-THERAPY VECTORS: AAV/lentivirus/adenovirus capsids repurposed as cargo delivery vehicles with serotype-specific tropism, real cargo-size hard walls, and capsid-engineering routes."
  virocapsid-adds-5 = "CAPSID-MEDIATED IMMUNITY: capsid surface is the primary antigen seen by the host humoral system → neutralizing antibodies (pre-existing or induced), a real clinical exclusion criterion for AAV gene therapy."
  virocapsid-adds-6 = "VLP VACCINES: assembly competence WITHOUT a viral genome makes capsids vaccine antigens (HPV Gardasil, HBV); licensed products demonstrate the capsid surface alone is sufficient for protective immunity in some pathogens."
  honesty = "If your work concerns generic protein-cage self-assembly with no host life-cycle, motor, maturation, vector, or immunity component, route to HEXA-WEAVE; this axis specifically addresses the virological layer."
  |> "[@x_hexa_weave_sibling]"

# ─── §2 Capsid geometry baseline (CROSS-REFERENCE to HEXA-WEAVE) ─────

@D vc_geometry_baseline := "geometric baseline (delegated to HEXA-WEAVE)" :: domain [ok]
  delegated = "Caspar–Klug quasi-equivalence (T = h²+hk+k²), 60·T subunit count, 12 pentamers + 10(T−1) hexamers, Euler χ=2 closed-surface constraint, Zlotnick assembly thermodynamics+kinetics — ALL defined and grounded in [@x_hexa_weave_sibling] §1–§3. This tape uses these results; it does NOT re-derive them."
  observed-in-viruses = "T-numbers observed in real viral families (see §3 viral-family survey for which virus uses which T). The T-number is a geometric classification of the capsid lattice, NOT a viral functional category."
  honesty = "If reviewing capsid GEOMETRY, read HEXA-WEAVE first. This tape's geometric statements stand on HEXA-WEAVE; any apparent disagreement should be resolved in favor of the WEAVE primary source."
  |> "[@x_hexa_weave_sibling] · [@x_caspar_klug_1962]"

# ─── §3 Viral families & T-numbers in nature (the virology survey) ───

@D viral_family_t1 := "T=1 viral families" :: classification [ok]
  geometry = "60 subunits = 12 pentamers, no hexamers (Caspar–Klug minimum closed icosahedron)."
  examples = "Parvoviridae (e.g. AAV — Adeno-Associated Virus; CPV canine parvovirus; B19), satellite tobacco necrosis virus (STNV; classic structural reference), some single-stranded DNA satellite/circoviruses."
  virological-significance = "AAV — the dominant in-vivo gene-therapy vector (see [@vector_aav]). Small genome (~4.7 kb ssDNA) is geometrically consistent with a T=1 60-subunit shell of ~20–26 nm diameter; this small interior is the source of the AAV cargo-size hard wall ([@lim_aav_cargo])."
  honesty = "T=1 is geometrically minimal; it is NOT the smallest possible biological capsid (some satellite/sub-viral particles have non-icosahedral shells). Listed examples are illustrative of T=1 occurrence, not exhaustive."
  |> "[@x_caspar_klug_1962]"

@D viral_family_t3 := "T=3 viral families" :: classification [ok]
  geometry = "180 subunits = 12 pentamers + 20 hexamers."
  examples = "Many small icosahedral plant RNA viruses (tomato bushy stunt virus TBSV — landmark T=3 X-ray structure; cowpea mosaic virus CCMV; turnip yellow mosaic virus), tobamovirus-related icosahedral RNA viruses, many small bacterial/insect viruses."
  virological-significance = "T=3 is one of the most common architectures for small +ssRNA plant and insect viruses; serves as the model system for much of structural virology and self-assembly thermodynamics (CCMV-class)."
  honesty = "Note: 'Tobamovirus' itself (e.g. tobacco mosaic virus TMV) is HELICAL, NOT icosahedral — TMV is the canonical helical-rod counter-class to icosahedral capsids. Don't conflate the family with the geometry."
  |> "[@x_caspar_klug_1962]"

@D viral_family_t4 := "T=4 viral families" :: classification [ok]
  geometry = "240 subunits = 12 pentamers + 30 hexamers."
  examples = "Hepatitis B virus (HBV) core antigen — predominantly T=4 in vivo; HBV is also dimorphic and assembles a minority T=3 form in vitro (a well-studied example of T-number polymorphism within a single coat protein)."
  virological-significance = "HBV core assembly is one of the most extensively studied viral-capsid systems for Zlotnick-class kinetic and thermodynamic analysis. HBV core dimer is the assembly unit, with a four-helix bundle interaction interface."
  honesty = "HBV core/T=4 is empirically the dominant species; in-vitro reassembly under altered ionic conditions yields a minority T=3 fraction. Reporting 'HBV = T=4' is the standard simplification; the dimorphism is the more precise statement."
  |> "[@x_caspar_klug_1962]"

@D viral_family_t7 := "T=7 viral families" :: classification [ok]
  geometry = "420 subunits = 12 pentamers + 60 hexamers (T=7 laevo or T=7 dextro chirality)."
  examples = "Papillomaviruses (HPV — human papillomavirus; cervical-cancer agent and source of the Gardasil/Cervarix VLP vaccines) and polyomaviruses (SV40, BKV, JCV)."
  virological-significance-papova = "CRITICAL EXCEPTION: papilloma-/polyomaviruses violate strict Caspar–Klug quasi-equivalence — they assemble 360 subunits as 72 PENTAMERS (no hexamers), with pentamers at both the 5-coordinated AND 6-coordinated positions. This is the canonical 'all-pentamer T=7' that drove development of Twarock's tiling theory generalization (see [@x_hexa_weave_sibling] §2 ex_pseudo_t)."
  virological-significance-phages = "T=7 also occurs in many tailed dsDNA bacteriophages (e.g. HK97 procapsid, before maturation expansion to T=7 mature — see [@vc_maturation_hk97])."
  honesty = "'T=7' is used to describe both classical quasi-equivalent T=7 (phage HK97 mature) AND non-quasi-equivalent all-pentamer T=7 (papova). Conflating them is a common error — they are geometrically distinct realizations."
  |> "[@x_caspar_klug_1962]"

@D viral_family_t13 := "T=13 viral families" :: classification [ok]
  geometry = "780 subunits = 12 pentamers + 120 hexamers."
  examples = "Inner capsid layers of some reoviruses (Reoviridae — rotavirus, bluetongue virus), some segmented dsRNA virus shells."
  virological-significance = "Multi-shell architecture: reoviruses are TWO-or-three-layered capsids (e.g. rotavirus VP2 inner T=1/T=2*, VP6 middle T=13, VP7 outer T=13). The T=13 layer carries the active transcription complex for endogenous mRNA synthesis inside the capsid — the capsid is functionally a TRANSCRIPTION FACTORY, not a passive shell."
  honesty = "Reovirus shell layers vary by virus; the 'T=13' assignment refers to specific layers and is a literature-standard simplification. 'T=2' is a misnomer — strict quasi-equivalent T=2 is geometrically forbidden, the inner reovirus shell is described as 'pseudo-T=2' or T=1 with two subunits per asymmetric unit ([@x_hexa_weave_sibling] §2 ex_pseudo_t)."
  |> "[@x_caspar_klug_1962]"

@D viral_family_t16 := "T=16 viral families" :: classification [ok]
  geometry = "960 subunits = 12 pentamers + 150 hexamers."
  examples = "Herpesvirus capsids (e.g. HSV-1, cytomegalovirus) — the major capsid protein VP5 + minor scaffolding/triplex proteins assemble a large T=16 procapsid that matures via scaffold release and angular expansion. Bacteriophage HK97 MATURE capsid is also T=7 (not T=16) — herpesvirus T=16 is the larger architectural cousin."
  virological-significance = "Herpesvirus T=16 capsids are large enough to package ~150 kbp linear dsDNA genomes under high internal pressure delivered by the terminase packaging motor (a HerpesVirus analog of the phage portal-motor system, see [@vc_packaging_motor_phi29] for the canonical phi29 packaging system)."
  honesty = "Herpesvirus T-number assignment is established by cryo-EM. 'T=16' here refers to the major capsid layer; the full herpesvirus particle additionally has tegument layer + envelope outside the capsid."
  |> "[@x_caspar_klug_1962]"

@D viral_family_pseudo_t := "pseudo-T viral families (picornaviruses)" :: classification [ok]
  geometry = "60 subunits at T=3 positions but assembled from THREE chemically distinct jelly-roll proteins (VP1, VP2, VP3) — described as pseudo-T=3 (or P=3)."
  examples = "Picornaviridae: poliovirus (Rossmann's 1985 atomic-resolution structure is a foundational virology landmark), rhinovirus, foot-and-mouth disease virus, enterovirus."
  virological-significance = "Pseudo-T=3 evolved from a presumed single-CP T=3 ancestor by gene duplication+specialization. Each of the 60 protomers contains one copy of each VP1/VP2/VP3, breaking strict quasi-equivalence but preserving the geometric framework. VP4 is an internal myristoylated peptide important for uncoating."
  honesty = "Pseudo-T is well-defined for picornaviruses but a 'pseudo-T=N' label without specifying the protein composition is ambiguous. Reading the originating literature ([@x_rossmann_1985]) is recommended."
  |> "[@x_rossmann_1985]"

@D viral_family_helical_counter := "helical capsids — explicit counter-class" :: classification [ok]
  why-listed = "Listed explicitly so the icosahedral framework above is not mis-applied: HELICAL capsids violate the icosahedral T-number framework entirely."
  examples = "Tobacco mosaic virus (TMV — rod-shaped, ~2130 identical coat-protein copies in a helical array around a single ssRNA), influenza A nucleocapsid (helical RNP), rabies virus, measles, Ebola filovirus (filamentous helical)."
  virological-significance = "Many medically and agriculturally critical viruses are helical (orthomyxoviruses, paramyxoviruses, filoviruses, rhabdoviruses); they assemble by repeated subunit-RNA addition along a helical path, not by T-number quasi-equivalence."
  honesty = "Helical capsids are out of scope for the Caspar–Klug / T-number framework but in scope for VIROCAPSID as a virology axis. Their packaging and maturation rules are different and not addressed in this revision."
  |> "[@x_caspar_klug_1962]"

# ─── §4 HK97 maturation — the chainmail paradigm ──────────────────────

@D vc_maturation_hk97 := "HK97 maturation: covalent chainmail" :: mechanism [ok]
  context = "Bacteriophage HK97 (a tailed dsDNA phage of E. coli) assembles a metastable T=7 PROCAPSID from ~420 copies of gp5 coat protein around a transient scaffolding protein. After genome packaging, the procapsid expands ~20% in radius and undergoes irreversible covalent crosslinking between adjacent subunits, producing 'protein chainmail'."
  chainmail = "Each gp5 forms a covalent isopeptide bond (Lys169 of one subunit to Asn356 of the next, catalyzed by Glu363) creating concatenated rings of 5 and 6 subunits topologically interlocked — like medieval chainmail. The Wikoff et al. 2000 Science paper resolved this at atomic resolution and named the 'chainmail' motif. This is the paradigmatic example of capsid maturation by chemical/covalent stabilization."
  significance = "Maturation is not a curiosity — it is the rule for most large dsDNA viruses (phages, herpesviruses, adenovirus). The procapsid is the kinetically accessible assembly intermediate; the mature capsid is the thermodynamically stable end state that survives the harsh extracellular environment between hosts."
  pressure = "Packaged dsDNA inside the mature capsid is under tens of atmospheres of internal pressure (phi29 ~50 atm by single-molecule measurements [@x_smith_2001]) — the chainmail provides the mechanical strength to contain it."
  honesty = "The Wikoff et al 2000 paper is the canonical structural reference; subsequent work has elaborated the maturation pathway in detail. Stated as foundational landmark; exact subsequent paper enumeration not asserted."
  |> "[@x_wikoff_2000]"

@D vc_maturation_general := "general maturation patterns" :: mechanism [ok]
  proteolysis = "Many viruses mature by site-specific proteolysis: HIV-1 (retrovirus) Gag polyprotein is cleaved by the viral protease into MA/CA/NC + accessory peptides, triggering capsid rearrangement (immature spherical Gag lattice → mature conical CA-only core). HIV maturation is the clinical drug target of protease inhibitors."
  expansion = "Procapsid → mature capsid expansion is a near-universal motif in tailed phages and herpesviruses: scaffolding exits during packaging, the shell expands and faceting becomes pronounced, T-number is preserved but geometry stiffens."
  scaffolding-loss = "Scaffolding proteins (bacteriophage P22 gp8; herpes UL26) drive procapsid size selection and exit during maturation — see [@vc_assembly_scaffolding]."
  honesty = "Maturation by protease activation, scaffold release, or chainmail crosslinking are three distinct mechanisms; a given virus uses one or two of them. Conflating them across families is incorrect."
  |> "[@x_wikoff_2000] · [@x_fane_prevelige_2003]"

# ─── §5 Assembly with scaffolding proteins (viral specialization) ─────

@D vc_assembly_scaffolding := "viral scaffolding-protein assembly" :: mechanism [ok]
  why-viral = "Most large dsDNA viruses (tailed phages, herpesviruses, adenovirus) do NOT self-assemble the mature capsid directly. They co-assemble coat + transient scaffolding into a procapsid; scaffolding exits during DNA packaging; coat matures (expand/crosslink/proteolyse) into the mature capsid."
  p22-canonical = "Bacteriophage P22: ~415 coat (gp5) + ~250–300 scaffolding (gp8) co-assemble into a T=7 procapsid; scaffolding exits and is reused for further procapsids; coat then matures during DNA packaging. Without scaffolding, P22 coat does not form the correct T-number (yields aberrant T=4 or T=7 'petit'/'giant' phage variants)."
  hk97-special = "HK97 scaffolding is an N-terminal extension (delta-domain) of gp5 itself, cleaved off proteolytically before maturation expansion (autoscaffolding) — different from the separate-polypeptide P22 model."
  phi29-connector = "Bacteriophage phi29 procapsid is built around a unique 12-subunit dodecameric portal/connector at one vertex (replaces one pentamer); this connector is the docking site for the packaging motor [@vc_packaging_motor_phi29]. The Simpson et al. 2000 Nature paper resolved the connector structure."
  honesty = "Subunit counts (gp5 ~415, gp8 ~250–300) are approximate stoichiometries from cryo-EM literature; exact numbers vary slightly with growth condition. Reporting these as ballpark values is the convention."
  |> "[@x_fane_prevelige_2003] · [@x_simpson_2000]"

# ─── §6 Genome packaging motors (the virological hallmark) ────────────

@D vc_packaging_motor_phi29 := "phi29 packaging motor (canonical)" :: mechanism [ok]
  system = "Bacteriophage phi29 packages its ~19 kbp linear dsDNA genome into the procapsid against rising internal pressure using a five-fold-symmetric ATP-driven motor at the connector vertex. Components: the dodecameric connector (12-fold), a pentameric pRNA ring (5-fold prohead RNA — unique to phi29 among studied phages), and a pentameric ATPase gp16."
  symmetry-mismatch = "The 12-fold connector vs 5-fold pRNA/ATPase ring creates a structural symmetry mismatch that is mechanistically important and unresolved at full atomic detail in early structural work — a hallmark study system for symmetry mismatch in molecular motors."
  force = "Smith, Bustamante and co-workers (Nature 2001) used optical-trap single-molecule force spectroscopy on a single phi29 motor packaging its DNA, measuring stall forces ≥ ~50 pN — among the strongest known biological molecular motors. Internal capsid pressure at full packaging is estimated at tens of atmospheres."
  steps = "Moffitt, Chemla, Bustamante and co-workers (Nature 2009) resolved the motor into bursts of 4 power strokes of ~2.5 bp each (10 bp DNA translocation per ATP hydrolysis cycle of the 4 firing ATPase subunits) — explicit mechanical stepping behavior, hand-over-hand subunit firing."
  significance = "phi29 is the experimentally most-tractable viral packaging motor and the canonical reference for: force generation against capsid pressure, symmetry-mismatch coupling, and discrete burst stepping in DNA translocation. Its operating regime (tens of pN, picoseconds-to-milliseconds) is well outside passive self-assembly."
  honesty = "Stall force and step size quoted as established consensus from the cited single-molecule literature; both have been refined by subsequent work but the magnitudes are stable. Internal pressure 'tens of atmospheres' is the field-standard interpretation, model-dependent."
  |> "[@x_smith_2001] · [@x_moffitt_2009] · [@x_simpson_2000]"

@D vc_packaging_motor_terminase := "herpesvirus / large-phage terminase (analog)" :: mechanism [ok]
  system = "Herpesviruses (HSV-1, CMV) and most large tailed dsDNA phages (e.g. T7, lambda, T4) use TERMINASE complexes — a large terminase ATPase + small terminase DNA-recognition subunit — that dock at the capsid portal and translocate genomic DNA into the procapsid against internal pressure."
  function = "Terminase recognizes packaging-initiation sequence (cos site / pac site / herpes 'a' sequence), nicks the genome concatamer, and translocates one genome unit length into one procapsid, then nicks again ('headful' or 'sequence-defined' packaging depending on phage)."
  clinical = "Herpesvirus terminase is a clinical drug target: LETERMOVIR (FDA-approved) inhibits the human cytomegalovirus terminase complex (UL56/UL89/UL51) for CMV prophylaxis in stem-cell-transplant recipients — first-in-class capsid-stage antiviral. Stated as well-established clinical pharmacology; not a re-derivation."
  honesty = "Terminase mechanism is structurally and biochemically conserved across large dsDNA viruses; specific subunit composition varies (phi29 uses gp16+pRNA, a different system). Treating phi29 and terminase phages as one 'packaging motor' family is a simplification — distinct architectures, shared functional role."
  |> "[@x_smith_2001]"

# ─── §7 AAV — the dominant in-vivo gene-therapy vector ───────────────

@D vector_aav := "Adeno-Associated Virus (AAV) as gene-therapy vector" :: domain [ok]
  basics = "AAV (Parvoviridae) is a small (~25 nm) T=1 60-subunit ssDNA virus, naturally REPLICATION-DEFECTIVE (requires adenovirus or herpesvirus co-infection to replicate — 'helper-dependent'). This natural defectivity made it attractive as a gene-therapy vector: a recombinant AAV (rAAV) carrying a therapeutic transgene cannot replicate in patients."
  serotypes = "Multiple naturally-occurring serotypes with distinct tissue tropism: AAV1, AAV2 (reference serotype, broad tropism), AAV5, AAV6, AAV8 (liver-tropic), AAV9 (CNS, can cross blood-brain barrier in young animals), AAVrh10 (rhesus), and many engineered/directed-evolved variants. Tropism is determined primarily by capsid surface residues binding cell-surface glycans/receptors."
  approved-products = "FDA-approved AAV gene-therapy products as of recent regulatory history include LUXTURNA (AAV2 voretigene neparvovec — RPE65 retinal dystrophy), ZOLGENSMA (AAV9 onasemnogene abeparvovec — SMA), HEMGENIX (AAV5 etranacogene dezaparvovec — Hemophilia B), and ELEVIDYS (AAVrh74 delandistrogene — Duchenne MD). Stated as well-established clinical pharmacology; exact approval years not asserted."
  capsid-engineering = "Two main engineering routes: (1) RATIONAL design (point-mutate known capsid-receptor or capsid-antibody epitopes), (2) DIRECTED EVOLUTION via DNA-shuffled capsid libraries + in-vivo selection (Schaffer/Schaffner-group methodology — engineered AAVs with retargeted tropism, immune evasion, or BBB crossing). Davidson and others have published extensively on AAV engineering."
  honesty = "AAV is a thoroughly characterized vector system; figures here (size, serotype names, approved-product names) are field-standard. Field-knowledge citations rather than exhaustive primary-literature pointers; treat as a survey, not a re-derivation."
  |> "[@x_mingozzi_high_aav_review]"

@D vector_lentivirus_adenovirus := "lentivirus & adenovirus vectors (context)" :: domain [ok]
  lentivirus = "Lentivirus (HIV-derived, helical RNP not icosahedral capsid) vectors INTEGRATE into host genome — durable expression but with insertional-mutagenesis risk. Workhorses of EX-VIVO gene therapy (CAR-T cell engineering, hematopoietic stem-cell modification — e.g. for sickle cell, beta-thalassemia, X-linked SCID). Conceptually different from AAV (integrating retrovirus vs episomal DNA virus)."
  adenovirus = "Adenovirus (dsDNA icosahedral capsid, T=25 pseudo-T architecture in adenovirus type-5 — a complex capsid with hexon + penton + fiber proteins) vectors used for transient high-level expression; well-known as the backbone of the Oxford-AstraZeneca (ChAdOx1) and Johnson & Johnson (Ad26) COVID-19 vaccines. Adenoviruses have substantial pre-existing population immunity (Ad5 seroprevalence is very high in some populations), driving the use of rarer serotypes (chimpanzee Ad, Ad26)."
  why-aav-dominates-in-vivo = "AAV: small cargo but small immunogenicity vs adenovirus; episomal (no insertional mutagenesis) vs lentivirus; suitable for in-vivo single-dose delivery. Trade-offs are the source of vector-platform diversity, not a single best vector."
  honesty = "Adenovirus capsid is icosahedral but with a complex pseudo-T architecture — calling it 'T=25' is a simplification of the literature. Listed for context; full adenovirus architecture is beyond this revision."
  |> "[@x_mingozzi_high_aav_review]"

# ─── §8 Capsid-mediated immunity (the clinical reality) ──────────────

@D vc_immunogenicity_aav := "AAV capsid immunogenicity (neutralizing antibodies)" :: domain [ok]
  mechanism = "AAV capsid surface is the primary antigen seen by the host adaptive immune system. Wild-type AAV serotypes circulate in humans and other mammals as common subclinical infections, so a substantial fraction of the adult human population carries PRE-EXISTING neutralizing antibodies (NAbs) against multiple AAV serotypes."
  clinical-exclusion = "Pre-existing anti-AAV NAbs are a REAL CLINICAL TRIAL EXCLUSION CRITERION for systemic AAV gene-therapy administration: high-titer NAbs neutralize the injected vector before it reaches target tissue, abolishing efficacy. Patients are screened for capsid-specific NAbs and excluded if above protocol-defined thresholds. This is field-standard, not a theoretical concern."
  seroprevalence-pattern = "Reported seroprevalence varies by serotype, population, geography, and assay; the QUALITATIVE pattern is consistent: AAV2 highest seroprevalence (broad human exposure), AAV5/AAV8/AAV9 lower but non-trivial (often a third or more of adults), engineered novel-capsid variants the lowest. Specific percentages depend on study cohort; exact figures NOT asserted here to avoid fabrication."
  post-treatment = "Post-AAV-treatment patients develop high-titer NAbs against the administered serotype → effective REDOSING with the same serotype is generally not possible. This is a hard limit on AAV gene therapy paradigms that require re-administration ([@lim_immune_redose])."
  capsid-T-cell = "Beyond humoral immunity, AAV capsid peptides presented on MHC-I can trigger CD8+ T-cell responses against transduced cells, observed clinically in some AAV-treated patients (e.g. hepatic cellular response in early hemophilia B trials with AAV2). This 'capsid T-cell response' was the canonical Mingozzi & High finding."
  honesty = "AAV immunogenicity is a deep clinical literature; this entry summarizes the field-standard understanding. Specific seroprevalence percentages and clinical-trial cohort figures NOT asserted here (literature-honesty rule)."
  |> "[@x_mingozzi_high_aav_review]"

@D vc_immunogenicity_vlp := "VLP vaccine antigens (capsid as protective immunity)" :: domain [ok]
  vlp-concept = "Virus-Like Particles (VLPs) are assembly-competent capsid shells produced WITHOUT a viral genome (recombinant capsid protein only). The capsid surface alone presents the protective epitopes; absence of genome makes VLPs non-infectious and non-replicating — ideal vaccine antigen format for several pathogens."
  hpv-gardasil = "Human Papillomavirus VLPs assembled from the L1 major capsid protein (T=7 all-pentamer architecture, 72 pentamers) are the active ingredient of GARDASIL (Merck, quadrivalent then 9-valent: HPV 6/11/16/18 ± 5 more) and CERVARIX (GSK, bivalent: HPV 16/18). These vaccines prevent cervical cancer (caused predominantly by HPV 16/18) and other HPV-driven cancers — a milestone in cancer prevention by capsid-based vaccination."
  hbv-vaccine = "Hepatitis B vaccine (Recombivax HB, Engerix-B, etc.) uses recombinant HBsAg (HBV surface antigen) particles — a sub-viral particle assembled from the surface protein, technically a lipoprotein particle rather than a strict T=4 core VLP, but presented as the canonical 'recombinant capsid-like vaccine antigen'. Universal HBV vaccination is one of the most successful public-health vaccine campaigns."
  others = "VLP vaccines for HEV (Hecolin, China), and investigational VLP platforms for malaria (RTS,S/Mosquirix uses an HBsAg-based VLP), influenza, norovirus, and others. VLP technology is a real, licensed vaccine platform."
  honesty = "HPV vaccine compositions are field-standard; HBV vaccine technically uses sub-viral particles rather than the icosahedral core VLP, a distinction often glossed in summary descriptions. Treat HBV as a 'recombinant capsid-like antigen' for honesty."
  |> "[@x_caspar_klug_1962]"

# ─── §9 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ───

@D lim_aav_cargo := "AAV cargo size — the ~4.7 kb hard wall" :: real-limit [ok required]
  wall = "HARD WALL (geometric/genomic — well-established field constant)"
  statement = "Recombinant AAV (rAAV) vector genome is limited to approximately 4.7 kb of single-stranded DNA between the inverted terminal repeats (ITRs). This is set by the volume of the T=1 60-subunit AAV capsid interior. Cargo significantly above ~5 kb shows sharply reduced packaging efficiency; cargo above ~5.2 kb is generally NOT packaged at acceptable yield."
  consequence = "Many therapeutic transgenes exceed 4.7 kb (e.g. full-length dystrophin for DMD is ~11 kb cDNA; full-length CFTR is ~4.5 kb cDNA — uncomfortably close to the limit; ABCA4 for Stargardt disease is ~6.8 kb). For oversized cargos, workarounds include: (a) dual-AAV split-intein reconstitution, (b) micro/mini gene engineering (e.g. micro-dystrophin variants used in DMD AAV programs), (c) switching to a larger-capacity vector (lentivirus ~8 kb, adenovirus ~36 kb but with different trade-offs)."
  why-real-limit = "This is a GEOMETRIC limit (capsid interior volume × DNA packaging density), not a tunable parameter and not lattice-derived. It is one of the most cited single hard constraints in human gene therapy."
  |> "[@x_mingozzi_high_aav_review]"

@D lim_immune_redose := "AAV pre-existing & post-dose neutralizing antibodies" :: real-limit [ok required]
  wall = "HARD WALL (clinical, host-intrinsic)"
  statement = "Pre-existing anti-AAV neutralizing antibodies in a non-trivial fraction of the adult population (varies by serotype and cohort) exclude those patients from systemic AAV gene therapy. Post-treatment NAb induction generally prevents redosing with the same serotype indefinitely. Plasmapheresis / immunosuppression / capsid engineering for immune evasion are active research areas but not solved."
  consequence = "AAV gene therapy is, in practice, a ONE-SHOT modality per serotype. This drives strategic decisions: which serotype to use first, whether to reserve serotypes for retreatment, and whether to develop immunologically novel engineered capsids."
  honesty = "Specific seroprevalence percentages depend on assay/cohort and are NOT asserted as a single number here (avoiding fabrication). Stated as 'non-trivial fraction'."
  |> "[@x_mingozzi_high_aav_review]"

@D lim_t_quantization := "T-number geometric quantization (delegated to HEXA-WEAVE)" :: real-limit [ok required]
  wall = "HARD WALL (number-theoretic / geometric)"
  statement = "Only T-numbers of the form h² + hk + k² (h,k ≥ 0 integers) are realizable as quasi-equivalent icosahedral capsids. Forbidden T values (T=2, 5, 6, 8, 10, 11, 14, …) require non-quasi-equivalent architecture (pseudo-T, tiling theory) or are simply not realized. Exactly 12 pentamers is fixed by the closed-surface Euler characteristic (χ=2)."
  consequence-virological = "A viral capsid cannot evolve an arbitrary subunit count; family-specific T-numbers are constrained to the geometrically allowed set. The reovirus-inner-shell 'pseudo-T=2' and papovavirus 'all-pentamer T=7' are real exceptions that PROVE the strictness of quasi-equivalence — they violate it by becoming non-quasi-equivalent, not by realizing forbidden T."
  delegation = "Full derivation and number-theoretic detail in [@x_hexa_weave_sibling] §4 lim_t_quantization. Cited here because it directly bounds which T-numbers viral families can use."
  honesty = "This is GEOMETRIC quantization, not n=6 lattice. Cross-reference, do not re-derive."
  |> "[@x_caspar_klug_1962] · [@x_hexa_weave_sibling]"

@D lim_manufacturing_empty_capsid := "AAV manufacturing empty-capsid contamination" :: real-limit [ok required]
  wall = "SOFT WALL (manufacturing process limit — improvable, but never eliminated)"
  statement = "Industrial rAAV production (HEK293 triple-transfection or Sf9/baculovirus systems) routinely yields a mixed population of GENOME-CONTAINING (full) capsids and EMPTY capsids (assembly competent but unfilled). Empty-capsid fraction in raw production can be majority (>50%); downstream purification (typically iodixanol or CsCl gradient centrifugation, AEX chromatography) reduces but does not eliminate empties."
  consequence = "Empty capsids do not deliver transgene but DO contribute to antigenic load → unwanted immunogenicity per dose. Regulatory specifications increasingly require quantitation of full:empty ratio (often analytical ultracentrifugation, cryo-EM, or charge-detection mass-spec). High doses (e.g. >10^14 vg/kg systemic AAV for SMA / DMD) magnify the empty-capsid antigenic load proportionally — implicated in observed dose-limiting hepatotoxicity / immune complications."
  honesty = "Empty-capsid fraction figures vary by process and product; '>50% in crude harvest' is the qualitative field-standard observation, not asserted as a specific number. Stated as a manufacturing reality, not a re-derivation."
  |> "[@x_mingozzi_high_aav_review]"

@D lim_in_silico_boundary := "in-silico → wet-lab/clinical unverified boundary" :: real-limit [ok required]
  wall = "HARD WALL (epistemic — out of repo scope)"
  statement = "Hexa-bio VIROCAPSID verifies internal consistency of a viral-capsid SIMULATOR + metadata. Whether a designed/predicted vector serotype, VLP vaccine antigen, or capsid-engineered immune-evasion variant actually packages, transduces target tissue, evokes neutralizing antibodies at a particular titer, or elicits protective immunity in vivo is empirically unproven and out of repo scope."
  consequence = "No C2/C3 PASS in this axis is a vector-efficacy, immunogenicity, vaccine-platform, or clinical claim. Crossing this boundary requires biochemical assays, cell-culture transduction, animal studies, and ultimately clinical trials — tracked outside this repo (hexa-bio AGENTS.tape g8_in_silico_only · CLOSURE_RESIDUAL_BACKLOG.md §0)."

# ─── §10 n=6 lattice stance (HONEST — observation, not derivation) ────

@F f_lattice_fit := "lattice-fit-on-viral-capsid-biology" :: governance [required deny:write]
  pattern = "Deriving viral-capsid biology numbers FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'AAV cargo limit = some function of n=6', '12 pentamers because σ(6)=12', 'HPV is T=7 because of n=6', 'AAV NAb seroprevalence = some lattice ratio', 'phi29 stall force = lattice value', 'serotype count = J₂ thereof', or any other count/ratio/force/yield derived from the lattice tokens rather than from the cited virology literature."
  why = "Viral-capsid biology is governed by structural virology (Caspar–Klug quasi-equivalence + icosahedral surface geometry — see [@x_hexa_weave_sibling]), virological pharmacology (terminase / phi29 mechanics, AAV serotype biology, VLP licensure pharmacology), and host adaptive immunity (anti-capsid NAbs, T-cell responses). The n=6 invariant lattice is not a derivation tool for any of these. hexa-bio AGENTS.tape g2 (lattice-is-tool) and f1 (lattice-fit-forbidden) apply."
  remedy = "Cite the real virology / gene-therapy / vaccine sources (this tape's @X entries plus delegated @X entries in HEXA-WEAVE). The lattice may only be a coincidental OBSERVATION (e.g. 12 pentamers numerically equals σ(6)=12, but the cause is Euler χ=2) — never the reason."
  scope-note = "This guard is the VIROCAPSID-axis instance of the cohort-wide LATTICE_POLICY enforcement (hexa-bio AGENTS.tape f1/f3). f3: this tape REFERENCES HEXA-WEAVE for general assembly theory; it does not shadow / reimplement WEAVE logic."

@N n6_honest_stance := "viral capsid biology has no derivational n=6 invariant" :: note [required]
  text = "Stated plainly: viral-capsid biology exposes NO natural n=6 invariant. Subunit counts are 60·T where T ∈ {h²+hk+k²} (geometry/number theory — delegated to HEXA-WEAVE). Exactly 12 pentamers per closed icosahedral shell is fixed by the Euler characteristic χ=2 (Euler's polyhedron formula) — this numerically COINCIDES with σ(6)=12 but is OBSERVATION ONLY; the cause is Euler, never the lattice. T-number diversity across viral families (T=1 AAV, T=3 TBSV/CCMV, T=4 HBV, T=7 HPV all-pentamer, T=13 reovirus inner, T=16 herpesvirus, T=25 adenovirus) is determined by viral coat-protein evolution under genetic-economy + assembly-energetics constraints, not by n=6. AAV ~4.7 kb cargo cap is set by capsid interior volume + DNA packaging density. Anti-AAV NAb seroprevalence is set by natural human exposure to wild-type AAV serotypes. phi29 stall force (~50 pN) is set by ATPase mechanochemistry and DNA-DNA repulsion at high packaging density. HPV vaccine protective immunity is set by neutralizing-antibody epitope geometry on the L1 pentamer surface. NONE of these are n=6-derived. Per hexa-bio AGENTS.tape g1 (real-limits-first) / g2 (lattice-is-tool): in this CORE axis the lattice is permitted to appear in native-spec files as a TOOL only, but it is here explicitly DECLINED as a derivation of any count, yield, force, seroprevalence, or efficacy. This honesty IS the corrective for the audited lattice-tautology stub this tape replaced."

# ─── §11 Verifiable predictions (real, falsifiable — NOT lattice) ─────

@D tp_1 := "TP-1 AAV cargo packaging falloff" :: prediction [ok]
  claim = "Recombinant AAV packaging yield falls sharply (>10-fold) for vector genomes above ~5.2 kb between ITRs, and is essentially zero above ~5.5 kb, for standard AAV serotypes. Workarounds (dual-AAV, micro-gene) recover delivery only by splitting/shrinking the cargo, not by overpacking a single capsid."
  falsifier = "A reproducible, standard-serotype rAAV preparation containing >6 kb single-stranded vector genome at packaging efficiency comparable to a 4.5 kb control would falsify [@lim_aav_cargo]."
  source = "[@x_mingozzi_high_aav_review]"

@D tp_2 := "TP-2 high-pre-existing-NAb redosing failure" :: prediction [ok]
  claim = "Systemic AAV gene therapy administered to a patient with high-titer pre-existing serotype-matched neutralizing antibodies will fail to achieve target-tissue transduction at therapeutic levels. This is why clinical trials screen and exclude high-NAb patients."
  falsifier = "A controlled clinical or large-animal study showing therapeutic transgene expression equivalent to NAb-negative patients in a high-NAb cohort (without immunomodulation / plasmapheresis) would falsify [@lim_immune_redose]."
  source = "[@x_mingozzi_high_aav_review]"

@D tp_3 := "TP-3 HK97-class chainmail in dsDNA phages" :: prediction [ok]
  claim = "Other large dsDNA tailed phages distantly related to HK97 will, on careful structural and mass-spectrometric analysis, show covalent or near-covalent post-assembly inter-subunit linkages stabilizing the mature capsid against internal pressure — the chainmail / chainmail-analog motif is conserved beyond HK97 itself."
  falsifier = "If no other tailed dsDNA phage outside the HK97-like clade shows any covalent or quasi-covalent maturation linkage despite operating under tens-of-atmospheres internal pressure, the generality of the chainmail-class maturation hypothesis is reduced (though HK97 itself stands)."
  source = "[@x_wikoff_2000]"

# ─── §12 Cross-links (sister tapes — reference, do NOT shadow · f3) ──

@X x_hexa_weave_sibling := "HEXA-WEAVE.tape (sister axis — general assembly theory)" :: sibling-tape [active]
  scope = "General icosahedral capsid & protein-cage self-assembly. Caspar–Klug quasi-equivalence + T-number theory + 12-pentamer Euler constraint + Zlotnick equilibrium/nucleation-elongation thermodynamics+kinetics + kinetic traps. VIROCAPSID specializes WEAVE to virology — it does NOT duplicate or re-derive WEAVE content. If a fact concerns general assembly theory, the WEAVE source is canonical."

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "g1 real-limits-first · g2 lattice-is-tool · g8_in_silico_only · f1 lattice-fit-forbidden · f3 no-shadow-impl-of-sister-repo. This tape complies; chemistry-VQE/Lean/exotic-routing remain in qmirror/hexa-meta/xeno and are referenced via CLI gates, never reimplemented here. HEXA-WEAVE content is cross-referenced, not duplicated (f3 applies between sibling axes by the same principle)."

@X x_closure_backlog := "CLOSURE_RESIDUAL_BACKLOG.md" :: doc [active]
  scope = "§0 in-silico-only scope boundary — wet-lab biochemistry / animal studies / clinical trials for any predicted vector / VLP / capsid-engineering variant are out-of-repo and unverified."

# ─── §13 External citations (real virology literature) ──────────────

@X x_caspar_klug_1962 := "Caspar DLD & Klug A 1962" :: literature [active]
  ref = "Caspar DLD, Klug A. Physical principles in the construction of regular viruses. Cold Spring Harbor Symp Quant Biol 1962;27:1–24. (foundational quasi-equivalence + T = h²+hk+k² — also cited from HEXA-WEAVE; included here so this tape is independently grounded)"

@X x_rossmann_1985 := "Rossmann MG, Arnold E, Erickson JW, Frankenberger EA, Griffith JP, Hecht HJ, Johnson JE, Kamer G, Luo M, Mosser AG, Rueckert RR, Sherry B, Vriend G 1985" :: literature [active]
  ref = "Rossmann MG et al. Structure of a human common cold virus and functional relationship to other picornaviruses. Nature 1985;317:145–153. (and the companion Hogle et al 1985 Science poliovirus paper — picornavirus pseudo-T=3 atomic-resolution architecture; primary-authors/era cited, the Rossmann poliovirus/rhinovirus series is the canonical landmark)"

@X x_wikoff_2000 := "Wikoff WR, Liljas L, Duda RL, Tsuruta H, Hendrix RW, Johnson JE 2000" :: literature [active]
  ref = "Wikoff WR, Liljas L, Duda RL, Tsuruta H, Hendrix RW, Johnson JE. Topologically linked protein rings in the bacteriophage HK97 capsid. Science 2000;289:2129–2133. (HK97 'chainmail' covalent inter-subunit crosslinking — the paradigm of capsid maturation by chemical stabilization)"

@X x_simpson_2000 := "Simpson AA, Tao Y, Leiman PG, Badasso MO, He Y, Jardine PJ, Olson NH, Morais MC, Grimes S, Anderson DL, Baker TS, Rossmann MG 2000" :: literature [active]
  ref = "Simpson AA et al. Structure of the bacteriophage phi29 DNA packaging motor. Nature 2000;408:745–750. (phi29 dodecameric connector / portal — packaging-motor docking site structure; primary-authors/era cited, the exact 2000 Nature paper)"

@X x_smith_2001 := "Smith DE, Tans SJ, Smith SB, Grimes S, Anderson DL, Bustamante C 2001" :: literature [active]
  ref = "Smith DE, Tans SJ, Smith SB, Grimes S, Anderson DL, Bustamante C. The bacteriophage straight phi29 portal motor can package DNA against a large internal force. Nature 2001;413:748–752. (single-molecule optical-trap measurement of phi29 packaging force, ≥50 pN stall — landmark single-molecule virology)"

@X x_moffitt_2009 := "Moffitt JR, Chemla YR, Aathavan K, Grimes S, Jardine PJ, Anderson DL, Bustamante C 2009" :: literature [active]
  ref = "Moffitt JR, Chemla YR, Aathavan K, Grimes S, Jardine PJ, Anderson DL, Bustamante C. Intersubunit coordination in a homomeric ring ATPase. Nature 2009;457:446–450. (phi29 motor stepping: bursts of ~2.5 bp steps × 4 firings = 10 bp per ATP cycle; subunit coordination)"

@X x_fane_prevelige_2003 := "Fane BA & Prevelige PE 2003 (scaffolding-protein assembly)" :: literature [active]
  ref = "Fane BA, Prevelige PE Jr. Mechanism of scaffolding-assisted viral assembly. Adv Protein Chem 2003;64:259–299. (transient internal scaffolding proteins template procapsid size/curvature, e.g. bacteriophage P22 coat gp5 + scaffolding gp8; review — also cited from HEXA-WEAVE; primary-authors/era cited, exact pages not asserted)"

@X x_mingozzi_high_aav_review := "Mingozzi F & High KA (AAV immunology review-class)" :: literature [active]
  ref = "Mingozzi F, High KA. Immune responses to AAV vectors: overcoming barriers to successful gene therapy. Blood 2013;122:23–36. (also Mingozzi & High Nature Reviews Genetics 2011-class reviews on AAV gene-therapy immunology — pre-existing neutralizing antibodies as clinical exclusion criterion; capsid T-cell responses; primary-authors/era cited; the Blood 2013 paper is the most-cited single review of AAV immunological barriers)"
