#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# GENETICS.tape — architecture-current (editable per v1.2)
# Event history → GENETICS.log.tape sibling
# Full real-science rewrite 2026-05-16 (prior: lattice-tautology stub 153b5a2)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "genetics" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · genetics knowledge substrate — from Mendelian rules to genome / GWAS / PRS / epigenetic era"
  brief = "Genetics — Mendelian to modern · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "GENETICS.log.tape"
  scope = "in-silico genetics knowledge SSOT · NOT clinical/diagnostic advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see GENETICS.log.tape audit"

@N scope_disclaimer := "knowledge-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico genetics knowledge substrate. Figures, rates, and dates are paraphrased from published primary literature for in-silico modeling context ONLY — NOT clinical or diagnostic guidance, NOT a prescription, NOT a genetic-counseling protocol. Genetic testing, interpretation, and any clinical action require licensed clinicians, certified laboratories, and appropriate regulatory framework (g8 in-silico-only · f2 no-clinical-claim)."

# ── §1 Mendelian foundations & the rediscovery era ────────────────────

@D dom_mendel := "Mendel 1866 — particulate inheritance" :: domain [ok]
  experiments = "Gregor Mendel's quantitative pea-plant (Pisum sativum) hybridisation experiments (~1856–1863) at the Augustinian Abbey in Brno demonstrated that inheritance is PARTICULATE: discrete 'factors' (now: alleles) segregate in predictable ratios across generations rather than blending."
  laws = "Law of Segregation — the two alleles at a locus separate during gamete formation; each gamete carries one. Law of Independent Assortment — alleles at different loci (effectively: on different chromosomes) assort independently. Together they account for the 3:1 and 9:3:3:1 ratios from monohybrid and dihybrid crosses."
  publication = "Mendel GJ. Versuche über Pflanzenhybriden. Verhandlungen des naturforschenden Vereines in Brünn 1866;4:3–47."
  reception = "The 1866 paper was largely overlooked for ~34 years. Modern genetics dates not from Mendel's publication but from his rediscovery in 1900."
  honesty = "3:1 and 9:3:3:1 ratios are combinatorial consequences of diploid segregation under independent assortment, not lattice products."
  |> "[@x_mendel_1866]"

@D dom_rediscovery := "1900 rediscovery — de Vries, Correns, Tschermak" :: domain [ok]
  event = "In 1900 three botanists — Hugo de Vries (Netherlands), Carl Correns (Germany), and Erich von Tschermak (Austria) — independently rediscovered Mendel's results and laws within months of each other. Primary authors / year cited; specific journal volumes not asserted for the three rediscovery papers."
  significance = "The rediscovery launched genetics as an experimental science. William Bateson became the principal English-language popularizer of Mendelism and is credited with coining the term 'genetics' (≈1905–1906 era; primary attribution cited, exact venue not asserted)."
  arc = "Mendel (1866) → rediscovery (1900) → 'genetics' as a named discipline (Bateson, mid-1900s) is the standard founding arc of the field."

# ── §2 Chromosome theory & classical genetics ─────────────────────────

@D dom_chromosome_theory := "Sutton–Boveri chromosome theory of inheritance" :: domain [ok]
  sutton = "Walter Sutton (1902) observed that chromosomes occur in homologous pairs and segregate during meiosis in a manner exactly paralleling Mendel's 'factors' — the chromosomal basis of inheritance. Primary author / year cited; exact journal volume not asserted."
  boveri = "Theodor Boveri (parallel work, ~1902–1904 era) demonstrated through sea-urchin embryology that chromosomes are individually distinct and required as a complete set for normal development — independent support for the chromosome theory. Primary author / era cited; exact bibliographic detail not asserted."
  synthesis = "The joint contribution is now known as the Sutton–Boveri chromosome theory: chromosomes are the physical carriers of Mendelian hereditary factors."

@D dom_morgan_fly := "Morgan school — fruit-fly genetics" :: domain [ok]
  organism = "Thomas Hunt Morgan's Drosophila melanogaster laboratory (Columbia, early 1900s) established the fruit fly as the model organism of classical genetics."
  findings = "Sex-linked inheritance (white-eye mutation linked to the X chromosome), genetic linkage, recombination as a measure of chromosomal distance, and chromosomal sex determination — all grounded in physical chromosomes."
  map = "Alfred Sturtevant, an undergraduate in Morgan's lab, constructed the FIRST genetic linkage map (1913) by treating recombination frequency between loci as a proxy for physical distance along the chromosome. Primary author / year cited; exact bibliographic detail not asserted."
  nobel = "Morgan was awarded the 1933 Nobel Prize in Physiology or Medicine for discoveries on the role of chromosomes in heredity."
  honesty = "Recombination frequencies (centimorgan units) are empirical measurements per organism and per region; they are not lattice-derived constants. Map distances saturate at ≈50 cM (unlinked loci) — a real meiotic limit, not a tautology."

# ── §3 DNA as the genetic material ────────────────────────────────────

@D dom_griffith := "Griffith 1928 — transforming principle (phenomenology)" :: domain [ok]
  experiment = "Frederick Griffith (1928) showed that mixing heat-killed virulent (S-strain) pneumococcus with live non-virulent (R-strain) bacteria produced virulent infection in mice — and live virulent S-strain bacteria could be recovered. Some heritable 'transforming principle' had crossed from the dead to the live organism. Primary author / year cited; the chemical identity of the principle was not yet known."
  significance = "Griffith demonstrated PHENOMENA of genetic transformation without identifying the molecule responsible — setting the stage for Avery, MacLeod, and McCarty (1944)."

@D dom_avery_1944 := "Avery, MacLeod & McCarty 1944 — DNA is the transforming principle" :: domain [ok]
  experiment = "Oswald Avery, Colin MacLeod, and Maclyn McCarty systematically purified Griffith's transforming principle from heat-killed S-strain pneumococcus and showed by enzymatic destruction (protease did NOT abolish activity; DNase DID) and chemical characterisation that the transforming material is DNA, not protein."
  publication = "Avery OT, MacLeod CM, McCarty M. Studies on the chemical nature of the substance inducing transformation of pneumococcal types. J Exp Med 1944;79:137–158."
  reception = "Initially controversial — the contemporary expectation was that the genetic material would be protein (much greater chemical diversity than the 'monotonous' four-base DNA). Acceptance grew over the next decade."
  |> "[@x_avery_1944]"

@D dom_hershey_chase := "Hershey & Chase 1952 — phage labeling confirms DNA" :: domain [ok]
  experiment = "Alfred Hershey and Martha Chase differentially labelled bacteriophage T2 protein (³⁵S, sulphur in cysteine/methionine) and DNA (³²P, phosphorus in the backbone) and showed that DNA — not protein — entered the bacterial host and directed production of new phage progeny."
  publication = "Hershey AD, Chase M. Independent functions of viral protein and nucleic acid in growth of bacteriophage. J Gen Physiol 1952;36:39–56."
  significance = "Together with Avery 1944, this experiment ended the 'protein-as-gene' alternative hypothesis. By 1952 DNA was the consensus genetic material."
  |> "[@x_hershey_chase_1952]"

# ── §4 Molecular era — structure, code, dogma ─────────────────────────

@D dom_chargaff := "Chargaff's rules (base composition)" :: domain [ok]
  observation = "Erwin Chargaff and colleagues (late 1940s — early 1950s era) showed by paper-chromatography quantification of DNA hydrolysates that across species the molar amount of adenine equals thymine and guanine equals cytosine (A=T, G=C), while the (A+T)/(G+C) ratio varies between species."
  significance = "Chargaff's pairing equivalence was a CRITICAL empirical constraint that any candidate DNA structure had to satisfy — it immediately implied complementary base pairing once the structure was solved. Primary author / era cited; specific volume not asserted for the original Chargaff papers."

@D dom_watson_crick := "Watson & Crick 1953 — DNA double helix" :: domain [ok]
  publication = "Watson JD, Crick FHC. Molecular structure of nucleic acids: a structure for deoxyribose nucleic acid. Nature 1953;171:737–738."
  data = "The model was constructed using Rosalind Franklin's X-ray diffraction data (notably 'Photograph 51', taken with Raymond Gosling) and Maurice Wilkins's measurements at King's College London — combined with Chargaff's base-pairing rules and Pauling's α-helix precedent for polymer model-building."
  structure = "Two antiparallel sugar-phosphate strands wound in a right-handed double helix with the bases stacked inside; A pairs with T (2 H-bonds), G with C (3 H-bonds). The model immediately implied a copying mechanism: each strand is a template for its complement."
  honesty = "≈10 bp/turn (B-form), ≈3.4 nm pitch, ≈2 nm helix diameter are empirically measured crystallographic/fiber-diffraction quantities that vary with sequence and conditions (A-form ~11 bp/turn; Z-form ~12 bp/turn left-handed). Not lattice constants."
  nobel = "Watson, Crick, and Wilkins shared the 1962 Nobel Prize in Physiology or Medicine; Franklin had died in 1958 (Nobels are not awarded posthumously)."
  |> "[@x_watson_crick_1953]"

@D dom_central_dogma := "Crick 1958/1970 — the central dogma" :: domain [ok]
  statement = "Information flows DNA → RNA → Protein; the residue-level sequence information cannot pass from protein back into nucleic acid. Crick first articulated this in his 1958 'On protein synthesis' Symposia of the Society for Experimental Biology paper, and formalised it in Crick FHC. Central dogma of molecular biology. Nature 1970;227:561–563."
  exceptions = "Reverse transcription (RNA → DNA; Temin and Baltimore, 1970 — primary authors / year cited) is permitted by Crick's framework; the dogma forbids the protein-to-nucleic-acid step, not all RNA-to-DNA traffic."
  cross-link = "Full transcription/translation mechanism lives in BIOLOGY.tape §6 (mech_transcription / mech_translation). This tape focuses on genetics-specific consequences (inheritance, variation, mapping)."
  |> "[@x_crick_1970]"

@D dom_genetic_code := "Nirenberg / Khorana / Holley — cracking the genetic code (1960s)" :: domain [ok]
  effort = "The genetic code (which codons specify which amino acids) was solved through the 1960s by several groups, principally: Marshall Nirenberg (poly-U → polyphenylalanine, 1961; trinucleotide-binding/ribosome filter-binding assays for all 64 codons by 1966); Har Gobind Khorana (chemical synthesis of defined repeating oligonucleotides as templates); Robert Holley (first sequenced tRNA, yeast alanine-tRNA)."
  table = "61 sense codons encode the 20 canonical amino acids; 3 stop codons (UAA, UAG, UGA). The code is degenerate (2–6 synonymous codons per amino acid via 'wobble' at the third position) and nearly universal."
  nobel = "Nirenberg, Khorana, and Holley shared the 1968 Nobel Prize in Physiology or Medicine for their interpretation of the genetic code and its function in protein synthesis. Primary authors / year cited; exact original-paper citations not asserted in this entry."
  honesty = "64 = 4³ is combinatorics (four bases, triplet codons). 20 canonical amino acids and 3 stop codons are empirical counts from the experiments above — not lattice products."

# ── §5 Sequencing & the genome era ────────────────────────────────────

@D dom_sanger := "Sanger 1977 — dideoxy chain-termination sequencing" :: domain [ok]
  method = "Frederick Sanger and colleagues introduced the dideoxy chain-termination ('Sanger') method: DNA polymerase extends a primer along a template, and chain-terminating dideoxynucleotides (ddNTPs) randomly stop extension to produce a ladder of fragments resolved by electrophoresis."
  publication = "Sanger F, Nicklen S, Coulson AR. DNA sequencing with chain-terminating inhibitors. Proc Natl Acad Sci USA 1977;74:5463–5467."
  impact = "Sanger sequencing dominated the field for ≈25 years and was the workhorse of the original Human Genome Project draft (2001). Sanger received his second Nobel Prize in Chemistry in 1980 for this work (his first was for protein sequencing, 1958)."
  |> "[@x_sanger_1977]"

@D dom_hgp := "Human Genome Project — draft sequence (2001)" :: domain [ok]
  publications = "Two landmark 2001 papers published in parallel: (a) International Human Genome Sequencing Consortium (Lander et al.) — Nature 409:860–921 (public consortium, hierarchical shotgun); (b) Celera Genomics (Venter et al.) — Science 291:1304–1351 (whole-genome shotgun). Primary authors / journals / volumes for both papers asserted."
  finishing = "A 'finished' reference followed in 2003 (50th anniversary of Watson–Crick). The Telomere-to-Telomere (T2T) Consortium completed centromeric and acrocentric-short-arm gaps (Nurk et al. 2022 Science — primary authors / year cited, additional bibliographic detail not asserted)."
  gene-count = "Protein-coding gene count converged near 20,000–25,000 — substantially fewer than pre-project expectations of ~100,000."
  cross-link = "BIOLOGY.tape §7 dom_hgp covers the broader cell-biology context; this tape focuses on genetics-of-variation consequences (downstream GWAS, PRS, clinical genetics)."
  |> "[@x_lander_2001] · [@x_venter_2001]"

@D dom_ngs := "next-generation sequencing — Solexa/Illumina era" :: domain [ok]
  platforms = "Second-generation ('next-generation') sequencing platforms — Roche 454 (pyrosequencing, mid-2000s), Solexa/Illumina (reversible-terminator sequencing-by-synthesis, late 2000s onward), ABI SOLiD — reduced per-genome cost by several orders of magnitude relative to Sanger. Primary platforms / era cited; specific founding-publication details not asserted in this entry."
  long-read = "Third-generation single-molecule long-read platforms (PacBio SMRT, Oxford Nanopore — 2010s onward) enable phasing, structural-variant discovery, and assembly of repetitive regions inaccessible to short reads."
  impact = "NGS turned population genetics, transcriptomics (RNA-seq), epigenomics (ChIP-seq, ATAC-seq, bisulfite-seq), and single-cell genomics into data-intensive, routinely accessible disciplines."
  honesty = "Throughput, read length, and error rates are platform-specific empirical specifications that continue to evolve — not fixed invariants."

# ── §6 Population & quantitative genetics ─────────────────────────────

@D dom_pop_genetics := "population genetics — founding era" :: domain [ok]
  founders = "The mathematical theory of population genetics was developed in the 1920s–1940s principally by Ronald A. Fisher, Sewall Wright, and J.B.S. Haldane — extending Mendel into populations under selection, drift, mutation, and migration. Primary authors / era cited; individual landmark-paper details not asserted in this entry."
  hwe = "Hardy–Weinberg equilibrium (Hardy 1908 / Weinberg 1908, independent) states that in a large, randomly mating, non-selecting, non-migrating, non-mutating diploid population, allele frequencies remain constant and genotype frequencies obey p² + 2pq + q² = 1. Primary authors / year cited; exact bibliographic detail not asserted for the original papers."
  fst = "Wright's fixation indices (F-statistics: F_IS, F_ST, F_IT) quantify population structure: F_ST measures the fraction of total genetic variance attributable to between-population differences. Standard tool in modern population-structure analysis."
  drift = "Genetic drift — stochastic allele-frequency change in finite populations — is mathematically identical to a random walk; effective population size N_e (typically smaller than the census size) governs the rate. Drift fixes or loses alleles independently of selection; the smaller the N_e, the faster the drift."
  honesty = "p² + 2pq + q² = 1 is algebraic identity from random union of gametes; not a lattice product. F-statistics, N_e, and substitution rates are empirical or estimated population parameters."

@D dom_quant_genetics := "quantitative genetics & heritability" :: domain [ok]
  trait-types = "Mendelian / monogenic traits (large-effect single locus, e.g. classical Huntington disease) vs polygenic / quantitative traits (height, BMI, blood pressure, most common diseases) — a spectrum, not a clean dichotomy."
  heritability = "Narrow-sense heritability h² = V_A / V_P (additive genetic variance over phenotypic variance) captures the response to selection (breeder's equation: R = h²·S). Broad-sense heritability H² = V_G / V_P includes dominance and epistasis."
  estimation = "Twin studies, family pedigrees, and (more recently) SNP-based heritability estimation (GREML/LD-score regression, post-2010 era) estimate heritability with different assumptions and yield partially-overlapping numbers."
  honesty = "h² is a population-and-environment-specific statistic, not a fixed property of a trait. It cannot exceed 1 and does not by itself tell you the magnitude of any individual gene's effect."

@D dom_missing_heritability := "Manolio 2009 — missing-heritability problem" :: domain [ok]
  problem = "Early GWAS for complex traits (post-2007 era) recovered genome-wide-significant variants that, summed, explained only a small fraction of the heritability estimated from twins/families — the 'missing heritability' gap."
  publication = "Manolio TA, Collins FS, Cox NJ, et al. Finding the missing heritability of complex diseases. Nature 2009;461:747–753."
  proposed-explanations = "(1) rare variants of moderate-to-large effect missed by common-variant GWAS arrays; (2) structural variation (CNVs, large indels) inadequately captured; (3) gene–gene interactions (epistasis); (4) gene–environment interactions; (5) overestimation of twin-based heritability; (6) very-small-effect common variants below GWAS detection thresholds (recovered subsequently by larger studies)."
  current-status = "A substantial portion of the gap has been closed by larger GWAS, whole-genome SNP-based heritability methods, and inclusion of rare variants — but residual gap and the role of epistasis/GxE remain active research questions."
  |> "[@x_manolio_2009]"

@D dom_prs := "polygenic risk scores — Khera 2018 era" :: domain [ok]
  definition = "A polygenic risk score (PRS, or polygenic score / PGS) is a weighted sum across many SNPs of an individual's allele counts times effect sizes estimated from GWAS — a single number summarising aggregate common-variant risk for a trait or disease."
  landmark-era = "Khera and colleagues (Nat Genet 2018 era — primary author / era / journal cited, exact volume not asserted in this entry) reported PRS that identified individuals with multi-fold elevated risk for common diseases (coronary artery disease, type-2 diabetes, atrial fibrillation, inflammatory bowel disease, breast cancer) comparable in magnitude to certain monogenic risk variants — popularising PRS in clinical-translation discussion."
  limitations = "PRS performance is markedly higher in the ancestry of the discovery GWAS (overwhelmingly European) and degrades sharply in other ancestries — the 'PRS portability' problem (see [@lim_ancestry_bias])."
  honesty = "PRS captures common-variant additive risk; it does NOT capture rare large-effect variants, structural variation, epistasis, environment, or gene–environment interaction. A PRS is a population-relative percentile, not a personal diagnosis."

# ── §7 Epigenetics & X-inactivation ──────────────────────────────────

@D dom_epigenetics := "epigenetics — heritable regulation beyond sequence" :: domain [ok]
  scope = "Epigenetics studies mitotically (and sometimes meiotically) heritable changes in gene expression that do not alter DNA sequence. Principal molecular layers: DNA methylation, histone post-translational modifications, chromatin accessibility, and non-coding-RNA regulation."
  methylation = "DNA methylation in vertebrates is primarily 5-methylcytosine at CpG dinucleotides; gene-body and promoter methylation are correlated with distinct transcriptional outcomes. Genome-scale methods (bisulfite sequencing, whole-genome bisulfite sequencing) profile methylation patterns."
  histones = "Histone tails carry combinatorial post-translational modifications (acetylation, methylation, phosphorylation, ubiquitination) — the 'histone code' (Strahl & Allis era, ~2000) — read/written/erased by dedicated enzyme families; chromatin states integrate these marks with nucleosome positioning."
  imprinting = "Genomic imprinting — parent-of-origin-specific monoallelic expression at ≈100–200 imprinted loci in mammals — is established in the germline and erased/reset across generations. Disease examples include Prader-Willi and Angelman syndromes (both involve chromosome 15q11-q13 imprinted region)."
  honesty = "Mark types, enzyme-family counts, and imprinted-locus counts are empirical biology; none are lattice-derived."

@D dom_x_inactivation := "Lyon 1961 — X-chromosome inactivation hypothesis" :: domain [ok]
  hypothesis = "Mary Lyon (1961 era — primary author / year cited, exact bibliographic detail not asserted in this entry) proposed that in female mammals one of the two X chromosomes is randomly transcriptionally inactivated early in embryogenesis, producing cellular mosaicism and equalising X-linked gene dosage between XX and XY individuals."
  mechanism = "X-inactivation is initiated by the lncRNA XIST (expressed from the future inactive X), spreading along the chromosome and recruiting silencing machinery; the inactive X is cytologically visible as the Barr body."
  manifestations = "The classic phenotypic illustration is the X-linked tortoiseshell / calico coat pattern in heterozygous female cats; mosaic X-inactivation also explains variable expressivity in female carriers of X-linked recessive disorders."

# ── §8 Single-cell & spatial era ──────────────────────────────────────

@D dom_single_cell := "single-cell genomics — population to individual cells" :: domain [ok]
  era = "Single-cell genomics matured in the 2010s. Sten Linnarsson's group (Karolinska, ~2011 era onward — primary group / era cited, individual landmark-paper details not asserted) and contemporaneous groups (Tang et al. 2009 era for single-cell RNA-seq; subsequent droplet/microfluidic platforms — Drop-seq, 10x Genomics Chromium) drove the technological transition."
  capabilities = "Single-cell RNA-seq (scRNA-seq), ATAC-seq, multi-omic single-cell assays, lineage tracing, and large-scale atlases (Human Cell Atlas, Tabula Muris/Sapiens) profile gene-expression and chromatin state at the resolution of individual cells rather than bulk tissue averages."
  spatial = "Spatial transcriptomics (Visium / MERFISH / seqFISH / Stereo-seq, ~2016+ era) records expression while preserving the tissue coordinate of each measurement — restoring spatial context lost in dissociation-based single-cell assays."
  honesty = "Cell-type counts, atlas sizes, and platform throughputs are empirical / institutional figures specific to each project — not lattice quantities."

# ── §9 Clinical & consumer genetic testing (context, not advice) ─────

@D dom_clinical_testing := "clinical & consumer genetic testing — modalities" :: domain [ok]
  mendelian-panels = "Mendelian disease panels (e.g. cystic fibrosis CFTR variant panels, BRCA1/2 sequencing for hereditary breast/ovarian cancer, familial hypercholesterolaemia panels) target known disease genes and report pathogenic/likely-pathogenic/variant-of-uncertain-significance (ACMG/AMP variant classification framework era)."
  carrier-screening = "Carrier screening identifies reproductive-couple carriers of recessive disorders (CF, SMA, fragile X, Tay-Sachs, sickle-cell, thalassaemias) to inform reproductive options."
  prenatal-pgt = "Non-invasive prenatal testing (NIPT, cell-free fetal DNA in maternal plasma, post-2011 era) for common aneuploidies; preimplantation genetic testing (PGT-A aneuploidy, PGT-M monogenic, PGT-SR structural) on IVF embryos."
  pharmacogenomics = "Pharmacogenomic testing (CYP2D6, CYP2C19, TPMT, DPYD, HLA-B*57:01 abacavir hypersensitivity, etc.) informs drug choice/dose for selected agents — cross-link PHARMACOLOGY substrate."
  consumer = "Direct-to-consumer (DTC) genotyping arrays (23andMe and similar, late-2000s onward era) report ancestry and selected health-trait associations from a SNP array (NOT whole-genome sequencing) — regulatory scope varies by jurisdiction."
  ?> "PHARMACOLOGY substrate (cross-link) for pharmacogenomics specifics; PRECISION-MEDICINE for clinical-implementation context"
  honesty = "Test names, panels, and regulatory categories are jurisdiction-specific and evolving; nothing here is recommended-test guidance."

# ── §10 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ──

@D lim_missing_heritability := "missing-heritability gap" :: real-limit [ok required]
  wall = "HARD WALL (current-knowledge limit, partially eroding)"
  statement = "Polygenic risk scores built from GWAS-significant common variants typically capture only a fraction of the heritability estimated from twin / family studies, and an even smaller fraction of family-history risk in clinical practice. Larger GWAS, rare-variant inclusion, and SNP-heritability methods have narrowed the gap but not closed it."
  consequence = "Genomic prediction is bounded by what the assay and model capture — not all heritable risk is GWAS-visible. Cited PRS magnitudes do not generalise to lifetime risk one-for-one."
  |> "[@x_manolio_2009]"

@D lim_pleiotropy_epistasis := "pleiotropy and epistasis complicate single-variant interpretation" :: real-limit [ok required]
  wall = "SOFT WALL (biological complexity)"
  statement = "PLEIOTROPY — one locus affecting multiple traits — is the rule, not the exception, in GWAS: most genome-wide-significant SNPs associate with several phenotypes. EPISTASIS — non-additive interaction between loci — is detectable in model organisms and present in human complex traits, though statistical power to detect it genome-wide is limited."
  consequence = "A 'variant for X' often also influences Y and Z. Variant interpretation cannot be cleanly per-trait; clinical reporting of single variants in isolation oversimplifies. Quantitative-genetic models that ignore epistasis can underestimate true heritability and mis-attribute effect to additive components."

@D lim_gxe := "gene–environment (GxE) interaction limits interpretation" :: real-limit [ok required]
  wall = "SOFT WALL (study-design and measurement limit)"
  statement = "Penetrance and effect sizes of genetic variants depend on environmental context (diet, smoking, exposures, socioeconomic factors, medical care). GxE interactions are well-documented for several monogenic and polygenic risks (e.g. phenylketonuria penetrance vs phenylalanine diet; FTO/BMI and physical activity; G6PD and oxidant exposure) but are statistically harder to detect than main effects and require very large, well-phenotyped, longitudinal cohorts."
  consequence = "Genetic risk estimates derived in one environmental context do not transfer cleanly to another. PRS calibration cohorts implicitly fix the environment of estimation."

@D lim_ancestry_bias := "ancestry bias in genomic reference data" :: real-limit [ok required]
  wall = "HARD WALL (data-distribution / equity limit)"
  statement = "Genome-wide-association studies, clinical-variant databases, and the resulting polygenic risk scores have been historically and overwhelmingly conducted in European-ancestry populations — a structural sampling problem highlighted by Sirugo and colleagues (Cell 2019 era — primary author / journal / era cited, exact bibliographic detail not asserted in this entry) and many subsequent commentaries."
  consequence = "PRS performance and the interpretation of variants of uncertain significance (VUS) degrade substantially outside the ancestries of the source data. This is an equity issue with concrete clinical consequence — and a real limit on the universality of any single-population-derived genomic model. Active correction requires deliberate non-European cohort recruitment (H3Africa, All of Us, FinnGen for Finnish-specific bottleneck variants, etc.)."

@D lim_ethics_privacy := "ethical & privacy constraints on genetic data" :: real-limit [ok required]
  wall = "REGULATORY / ETHICAL WALL"
  statement = "Genetic data is identifying (small numbers of SNPs uniquely re-identify individuals against reference panels) and informative about relatives who did not consent; aggregation across services enables familial re-identification. Legal frameworks (US Genetic Information Nondiscrimination Act 'GINA' 2008 era — limits employment/health-insurance use but NOT life/disability/long-term-care insurance; EU General Data Protection Regulation 'GDPR' 2018 — treats genetic data as a special category; varying national laws elsewhere) constrain use but are not globally uniform."
  consequence = "Consent for genetic testing is consent for an informational footprint extending across relatives and across time; storage, sharing, and downstream use carry legal and ethical obligations that an in-silico modelling substrate (this tape) cannot satisfy on the user's behalf. Real genetic testing requires real informed consent and real privacy governance."

# ── §11 n=6 lattice stance (HONEST — observation, not derivation) ────

@F f_lattice_fit := "lattice-fit-on-genetics" :: governance [required deny:write]
  pattern = "Deriving genetics quantities (allele counts, chromosome numbers, codon counts, recombination frequencies, heritability values, PRS percentiles, sequencing depths, variant-detection rates) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'variant detection = 99% because σ·sopfr/10' or 'sequencing depth = 144 because σ²' or '6 core indicators because n=6'. These were the exact fabrications in the pre-rewrite stub (hexa-bio mass-split 153b5a2)."
  why = "Allele frequencies, chromosome numbers (humans 46; varies 2 to >600 across eukaryotes), recombination rates, heritability estimates, GWAS significance thresholds (~5×10⁻⁸ from multiple-testing correction), sequencing depths, and PRS portability metrics are measured genetics — they come from experiments, populations, and statistical models, not from lattice arithmetic. Forbidden by hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool), f1 (lattice-fit-on-external-entity)."
  remedy = "Cite real primary literature (this tape's @X entries). The lattice may be a coincidental OBSERVATION only — NEVER a derivation. The pre-rewrite stub's '99% variant detection because σ·sopfr=60' style derivations are exactly the anti-pattern forbidden here."

@N n6_honest_stance := "genetics has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: genetics exposes NO natural n=6 invariant. The human karyotype is 22 autosome pairs + XX/XY (46 chromosomes; varies 2 to >600 across eukaryotes — Myrmecia pilosula ant 2; some ferns >600). The codon table is 64 = 4³ (combinatorics, not lattice). Twenty canonical amino acids is an empirical count. Heritability h² is a population/environment-specific statistic bounded in [0,1] by definition, not lattice-fixed. Mendel's 3:1 / 9:3:3:1 ratios are combinatorial consequences of diploid segregation. Hardy–Weinberg p² + 2pq + q² = 1 is algebraic identity. GWAS p-value threshold ~5×10⁻⁸ is a multiple-testing correction over ~1 million effective independent tests. Per hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool), and echoes/LATTICE_POLICY: the n=6 lattice is DECLINED here as a derivation tool. Any numeric coincidence with σ/τ/φ/J₂ is OBSERVATION ONLY. This honesty IS the corrective for the audited lattice-tautology stub (153b5a2)."

# ── §12 Verifiable predictions (real, falsifiable — NOT lattice) ─────

@D tp_1 := "TP-1 PRS portability degrades outside discovery-ancestry" :: prediction [ok]
  claim = "A polygenic risk score derived from a GWAS conducted in one ancestry (typically European) has measurably lower variance-explained / AUROC when applied to individuals from a different ancestry — the effect is reproducible across diseases (CAD, T2D, breast cancer) and across PRS construction methods."
  falsifier = "If properly cross-ancestry-validated PRS show no statistically meaningful loss of variance-explained when transferred between ancestries (matched for sample size and trait prevalence), [@lim_ancestry_bias] is wrong."
  source = "[@x_manolio_2009] (missing-heritability context) and ancestry-bias literature cited under [@lim_ancestry_bias]."

@D tp_2 := "TP-2 missing-heritability gap shrinks with cohort size" :: prediction [ok]
  claim = "For polygenic traits, the heritability captured by genome-wide-significant common-variant GWAS hits grows monotonically as discovery-GWAS sample size increases (more very-small-effect variants cross significance) — at least until rare-variant / structural / GxE contributions become rate-limiting."
  falsifier = "If a well-powered GWAS at 10× the prior sample size yields no additional heritability-captured for a given polygenic trait, the small-effect-common-variant explanation in [@lim_missing_heritability] is wrong (and rare-variant / epistasis / GxE explanations dominate)."
  source = "[@x_manolio_2009]"

@D tp_3 := "TP-3 Hardy–Weinberg deviation flags assumption violation" :: prediction [ok]
  claim = "In a properly genotyped, ancestrally-homogeneous, randomly-mating diploid sample, autosomal SNP genotype frequencies match Hardy–Weinberg expectation to within sampling noise; systematic deviation (excess homozygosity / heterozygote deficit beyond expectation) indicates a real-world violation — population structure / cryptic stratification, inbreeding, selection at the locus, or a genotyping/assay artefact (allele-dropout, copy-number variation)."
  falsifier = "If HWE-deviating loci in well-controlled cohorts are routinely shown NOT to correspond to any of these mechanisms (no structure, no inbreeding, no selection, no assay artefact), the population-genetic interpretation is wrong."
  source = "Hardy 1908 / Weinberg 1908 (foundational; primary authors / year cited)."

# ── §13 Cross-links to HEXA-Bio cohort tapes ─────────────────────────

@X x_biology_master := "BIOLOGY.tape (hexa-bio)" :: sibling-tape [active]
  path = "BIOLOGY.tape"
  scope = "Master foundational-biology substrate: cell theory, evolution, central dogma, ribosome, HGP, three-domain phylogeny. GENETICS specialises BIOLOGY's §3 Mendelian and §4 DNA / §7 HGP sections with deeper variation / GWAS / PRS / clinical-testing detail."

@X x_crispr_sibling := "CRISPR-GENE-EDITING.tape (hexa-bio)" :: sibling-tape [active]
  path = "CRISPR-GENE-EDITING.tape"
  scope = "CRISPR-Cas genome-editing knowledge substrate — the modification side of genetics (this tape covers the inheritance / variation / sequencing side). Off-target floor and HDR limits live there; this tape cross-links to them via the broader 'genetic data is hard to act on cleanly' theme."

@X x_pharmacology_sibling := "PHARMACOLOGY substrate (cross-link)" :: sibling-tape [active]
  path = "PHARMACOLOGY.tape (if/when present)"
  scope = "Pharmacogenomics specifics (CYP2D6/2C19, TPMT, DPYD, HLA pharmacogenetics) cross-link from [@dom_clinical_testing]."

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "@D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity) · @F f2 (wet-lab-clinical-claim-from-in-silico). This tape complies: real genetics science, in-silico knowledge SSOT only, no clinical/diagnostic claim, lattice declined as a derivation tool."

# ── §14 External citations (real, landmark literature) ───────────────
# Where a specific bibliographic detail is not asserted with confidence,
# the entry names primary author + era only and says so explicitly.

@X x_mendel_1866 := "Mendel GJ 1866 (laws of inheritance)" :: literature [active]
  ref = "Mendel GJ. Versuche über Pflanzenhybriden [Experiments on Plant Hybridization]. Verhandlungen des naturforschenden Vereines in Brünn 1866;4:3–47. (Primary source for laws of segregation and independent assortment. Rediscovered 1900.)"

@X x_avery_1944 := "Avery OT, MacLeod CM & McCarty M 1944" :: literature [active]
  ref = "Avery OT, MacLeod CM, McCarty M. Studies on the chemical nature of the substance inducing transformation of pneumococcal types: induction of transformation by a desoxyribonucleic acid fraction isolated from pneumococcus type III. J Exp Med 1944;79:137–158. (Identified DNA — not protein — as the transforming principle.)"

@X x_hershey_chase_1952 := "Hershey AD & Chase M 1952" :: literature [active]
  ref = "Hershey AD, Chase M. Independent functions of viral protein and nucleic acid in growth of bacteriophage. J Gen Physiol 1952;36:39–56. (³²P/³⁵S phage-labeling confirmation that DNA is the genetic material.)"

@X x_watson_crick_1953 := "Watson JD & Crick FHC 1953" :: literature [active]
  ref = "Watson JD, Crick FHC. Molecular structure of nucleic acids: a structure for deoxyribose nucleic acid. Nature 1953;171:737–738. (DNA double-helix structure; complementary base pairing.)"

@X x_crick_1970 := "Crick FHC 1970 (central dogma, Nature)" :: literature [active]
  ref = "Crick FHC. Central dogma of molecular biology. Nature 1970;227:561–563. (Formal statement of the Central Dogma; addressed reverse transcription.)"

@X x_sanger_1977 := "Sanger F, Nicklen S & Coulson AR 1977" :: literature [active]
  ref = "Sanger F, Nicklen S, Coulson AR. DNA sequencing with chain-terminating inhibitors. Proc Natl Acad Sci USA 1977;74:5463–5467. (Dideoxy chain-termination sequencing method.)"

@X x_lander_2001 := "Lander ES et al 2001 (Human Genome Project consortium)" :: literature [active]
  ref = "Lander ES et al (International Human Genome Sequencing Consortium). Initial sequencing and analysis of the human genome. Nature 2001;409:860–921. (Public consortium working draft.)"

@X x_venter_2001 := "Venter JC et al 2001 (Celera genome)" :: literature [active]
  ref = "Venter JC et al. The sequence of the human genome. Science 2001;291:1304–1351. (Celera whole-shotgun human genome; published in parallel with [@x_lander_2001].)"

@X x_wtccc_2007 := "Wellcome Trust Case Control Consortium 2007" :: literature [active]
  ref = "The Wellcome Trust Case Control Consortium. Genome-wide association study of 14,000 cases of seven common diseases and 3,000 shared controls. Nature 2007;447:661–678. (Landmark GWAS demonstrating the genome-wide-association study design across seven common diseases — anchors the modern GWAS era.)"

@X x_manolio_2009 := "Manolio TA et al 2009 (missing heritability)" :: literature [active]
  ref = "Manolio TA, Collins FS, Cox NJ, Goldstein DB, Hindorff LA, Hunter DJ, McCarthy MI, et al. Finding the missing heritability of complex diseases. Nature 2009;461:747–753. (Formal articulation of the missing-heritability gap and candidate explanations.)"

@X x_sutton_boveri := "Sutton WS 1902 / Boveri T 1902-1904 (chromosome theory)" :: literature [active]
  ref = "Sutton WS. On the morphology of the chromosome group in Brachystola magna. Biological Bulletin 1902 (primary author / year cited; exact volume/page not asserted in this entry). Parallel work by Theodor Boveri ~1902–1904 (primary author / era cited; specific bibliographic detail not asserted). Joint contribution known as the Sutton–Boveri chromosome theory of inheritance."

@X x_morgan_nobel_1933 := "Morgan TH — fruit-fly genetics (1933 Nobel)" :: literature [active]
  ref = "Thomas Hunt Morgan was awarded the 1933 Nobel Prize in Physiology or Medicine for discoveries concerning the role played by the chromosome in heredity (Columbia/Caltech Drosophila program, early 1900s). Primary scientist / Nobel year cited; individual primary-paper bibliographic detail not asserted in this entry. Includes Sturtevant 1913 first genetic linkage map (primary author / year cited)."

@X x_griffith_1928 := "Griffith F 1928 (transforming principle)" :: literature [active]
  ref = "Griffith F. The significance of pneumococcal types. Journal of Hygiene 1928 (primary author / year / journal cited; exact volume/page not asserted in this entry). Demonstrated heritable transformation of pneumococcus phenotype — phenomenon later identified as DNA-mediated by Avery 1944."

@X x_nirenberg_khorana_holley_1968 := "Nirenberg / Khorana / Holley — genetic code (1968 Nobel)" :: literature [active]
  ref = "Marshall W. Nirenberg, H. Gobind Khorana, and Robert W. Holley shared the 1968 Nobel Prize in Physiology or Medicine for their interpretation of the genetic code and its function in protein synthesis. Primary scientists / Nobel year cited; individual primary-paper bibliographic detail (Nirenberg 1961 poly-U; Khorana repeating-oligonucleotide templates; Holley 1965 yeast alanine-tRNA sequence) not asserted in this entry."

@X x_lyon_1961 := "Lyon MF 1961 (X-chromosome inactivation hypothesis)" :: literature [active]
  ref = "Mary F. Lyon proposed the X-chromosome inactivation hypothesis in 1961 (Nature paper era — primary author / year cited; exact bibliographic detail not asserted in this entry). Random monoallelic silencing of one X chromosome in female mammals — equalises X-linked gene dosage between XX and XY."

@X x_khera_2018 := "Khera AV et al 2018 (polygenic risk scores era)" :: literature [active]
  ref = "Khera AV and colleagues, Nat Genet 2018 era (primary author / journal / year cited; exact volume / page not asserted in this entry). Landmark popularisation of polygenic risk scores reaching effect-size magnitudes comparable to certain monogenic risk variants for several common diseases (CAD, T2D, AFib, IBD, breast cancer)."

@X x_sirugo_2019 := "Sirugo G et al 2019 (ancestry bias in genomic studies)" :: literature [active]
  ref = "Sirugo G, Williams SM, Tishkoff SA, and colleagues, Cell 2019 era (primary authors / journal / era cited; exact volume / page not asserted in this entry). Influential commentary documenting the structural under-representation of non-European-ancestry participants in genomic research and the resulting clinical-equity problem."
