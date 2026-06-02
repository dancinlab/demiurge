#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# CRISPR-GENE-EDITING.tape — architecture-current (editable per v1.2)
# Event history → CRISPR-GENE-EDITING.log.tape sibling
# Full real-science rewrite 2026-05-15 (was a lattice-tautology stub)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "crispr-gene-editing" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Bio family · CRISPR-Cas genome-editing knowledge substrate (in-silico)"
  brief = "CRISPR-Cas adaptive immunity → programmable RNA-guided nucleases · Cas9/Cas12/Cas13 · base & prime editing · off-target / specificity floor · germline-editing ethical line · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "CRISPR-GENE-EDITING.log.tape"
  scope = "in-silico knowledge SSOT · NOT clinical / therapeutic / germline-editing guidance"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-15 — see CRISPR-GENE-EDITING.log.tape audit"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico molecular substrate. Mechanisms and figures are paraphrased from published primary literature for modeling context only — NOT clinical, therapeutic, or laboratory guidance. Somatic genome editing in patients is investigational/early-clinical and carries real safety risk; HERITABLE (germline / embryo) editing is subject to a broad international moratorium and profound ethical/legal constraint. Per g8 (in-silico-only) + f2 (no clinical claim from in-silico): nothing here is a therapeutic, efficacy, or safety claim."

# ── §1 Origin & mechanism (adaptive immunity → programmable nuclease) ──

@D dx_origin := "CRISPR is a prokaryotic adaptive immune system" :: domain [ok]
  what = "CRISPR (Clustered Regularly Interspaced Short Palindromic Repeats) + cas (CRISPR-associated) genes are an adaptive, heritable, nucleic-acid-based immune system in bacteria and archaea."
  stages = "(1) ADAPTATION: short fragments of invading phage/plasmid DNA ('protospacers') are captured and integrated as 'spacers' into the CRISPR array. (2) expression: the array is transcribed and processed into crRNAs. (3) INTERFERENCE: crRNA-guided Cas effector recognizes and cleaves matching nucleic acid on re-infection."
  experimental-proof = "Barrangou et al. demonstrated that spacer content controls bacteriophage resistance in a dairy-starter bacterium — the first experimental demonstration that CRISPR confers adaptive immunity."
  |> "[@x_barrangou_2007] · [@x_jansen_2002] (cas gene family / 'CRISPR' nomenclature)"

@D mech_cas9 := "Cas9: RNA-guided, PAM-dependent dsDNA cleavage" :: mechanism [ok]
  effector = "Cas9 (type II, class 2) is a single multidomain protein that, programmed by a guide RNA, makes a blunt double-strand break (DSB) in target DNA."
  guide = "Native system uses crRNA + trans-activating tracrRNA; Jinek et al. fused them into a single-guide RNA (sgRNA) — the engineering step that made Cas9 a programmable tool. The ~20-nt spacer of the guide base-pairs the protospacer; '20 nt' is an engineering convention, not a lattice value."
  pam = "Cleavage REQUIRES a protospacer-adjacent motif (PAM) immediately 3' of the protospacer (SpCas9 = 5'-NGG-3'). PAM is read by the protein, is absent from the CRISPR array itself (self/non-self discrimination), and is the principal targeting-range constraint."
  catalysis = "Two nuclease domains cut the two strands: HNH cleaves the target (guide-complementary) strand; RuvC cleaves the non-target strand — together a DSB ~3 bp 5' of the PAM. R-loop formation / PAM-proximal 'seed' pairing gates cleavage."
  |> "[@x_jinek_2012] (programmable dual-RNA-guided cleavage + sgRNA) · [@x_jinek_2014] (Cas9 structure / domain architecture)"

@D mech_mammalian := "Cas9 genome editing in eukaryotic cells" :: mechanism [ok]
  step = "Translating bacterial Cas9 into mammalian genome editing required codon-optimization, nuclear localization, and Pol-III-expressed sgRNAs."
  achievement = "Cong et al. and Mali et al. (back-to-back, 2013) independently demonstrated efficient, multiplexable Cas9 editing of endogenous human/mouse loci — the result that opened genome editing to the broad biomedical community."
  contemporaneous = "Jinek et al. (2013) and Cho et al. (2013) reported eukaryotic editing in the same window; multiple groups converged near-simultaneously."
  |> "[@x_cong_2013] · [@x_mali_2013]"

@D mech_repair := "DSB repair outcome determines the edit" :: mechanism [ok]
  premise = "Cas9/Cas12 do not 'edit' — they cut. The host DNA-repair pathway that resolves the DSB determines the genomic outcome."
  nhej = "Non-homologous end joining (NHEJ): error-prone re-ligation → small insertions/deletions (indels) → frameshift / gene KNOCKOUT. Dominant in most cells, active in all cell-cycle phases."
  hdr = "Homology-directed repair (HDR): templated repair from a supplied donor → precise KNOCK-IN / point correction. Largely restricted to S/G2 phase and inefficient in non-dividing cells (see [@lim_hdr])."
  mmej = "Microhomology-mediated end joining (MMEJ/TMEJ) and single-strand annealing are additional, often deletion-prone, outcomes."
  consequence = "Knockout is comparatively easy; precise correction is hard — the central engineering problem motivating base/prime editing."
  |> "[@x_jasin_haber_2016] (DSB repair pathway biology)"

# ── §2 Editor families & classification ───────────────────────────────

@D cls_class_type := "CRISPR-Cas systems are classified by effector" :: classification [ok]
  framework = "Two CLASSES; Class 1 uses multi-protein effector complexes (types I, III, IV), Class 2 uses a single effector protein (types II, V, VI). Class 2 is the engineering workhorse (one protein to deliver)."
  type-ii = "Type II → Cas9 (dsDNA, blunt cut, NGG-type PAM)."
  type-v = "Type V → Cas12 (e.g. Cas12a/Cpf1: T-rich 5' PAM, staggered/sticky-end cut, processes its own crRNA, single RuvC-like nuclease)."
  type-vi = "Type VI → Cas13 (targets ssRNA not DNA; collateral RNase 'shredder' activity exploited for nucleic-acid diagnostics, e.g. SHERLOCK)."
  honesty = "Type count (I–VI) and class count (2) are an evolving microbiology classification, NOT an n=6 lattice fact — new types/subtypes are still being described. Do not lattice-fit (see [@f_lattice_fit])."
  |> "[@x_makarova_2020] (Cas classification) · [@x_zetsche_2015] (Cas12a/Cpf1) · [@x_abudayyeh_2016] (Cas13/C2c2 RNA targeting)"

@D mech_base_editing := "base editors — no DSB, direct chemistry" :: mechanism [ok]
  principle = "Catalytically impaired Cas9 (nickase or dead) fused to a deaminase installs a point mutation WITHOUT a double-strand break and WITHOUT a donor template, within a small editing window of the protospacer."
  cbe = "Cytosine base editor (CBE): cytidine deaminase → C·G → T·A transition (Komor et al., 2016)."
  abe = "Adenine base editor (ABE): a laboratory-evolved tRNA-adenosine-deaminase variant → A·T → G·C transition (Gaudelli et al., 2017). No natural DNA adenosine deaminase existed; it was directed-evolved."
  scope-limit = "Base editors install TRANSITION point mutations efficiently but cannot make arbitrary substitutions, insertions, or deletions; bystander edits within the window and some off-target deamination are recognized limits."
  |> "[@x_komor_2016] (CBE) · [@x_gaudelli_2017] (ABE)"

@D mech_prime_editing := "prime editing — search-and-replace" :: mechanism [ok]
  principle = "Cas9 nickase fused to an engineered reverse transcriptase, programmed by a prime-editing guide RNA (pegRNA) that both targets the site AND templates the new sequence. The RT copies the edit from the pegRNA into the nicked strand."
  capability = "Can install all 12 point substitutions plus small insertions/deletions WITHOUT a DSB or donor template — broader edit scope than base editors."
  cost = "More complex ribonucleoprotein cargo; efficiency is locus- and design-dependent; large-scale therapeutic delivery remains a challenge (see [@lim_delivery])."
  |> "[@x_anzalone_2019]"

@D cmp_editor_axis := "editor-family comparison (qualitative)" :: comparison [ok]
  dimensions = "Each family compared on: (1) lesion made, (2) template requirement, (3) edit scope, (4) signature limitation."
  nuclease = "Cas9/Cas12 nuclease: makes a DSB; KO via NHEJ (no template) or precise via HDR (donor + dividing cells); broad but repair-outcome-dependent; signature risk = uncontrolled indels / large deletions."
  base-editor = "Base editor: NICK only, no DSB, no donor; scope = transition point mutations within a window; signature limit = bystander/window edits, transitions only."
  prime-editor = "Prime editor: nick only, pegRNA-templated, no donor; scope = all substitutions + small indels; signature limit = design-dependent efficiency, large cargo."
  honesty = "This ordering is qualitative mechanism comparison grounded in the cited landmark papers — NOT a lattice-derived ranking. No magnitude is derived from σ/τ/φ."
  |> "[@x_komor_2016] · [@x_gaudelli_2017] · [@x_anzalone_2019]"

# ── §3 Delivery & the specificity problem ─────────────────────────────

@D mech_delivery := "delivery is the rate-limiter, not the nuclease" :: mechanism [ok]
  modalities = "(1) Adeno-associated virus (AAV): efficient in vivo, but ~4.7 kb packaging cap is tight for SpCas9+sgRNA → drives smaller orthologs (SaCas9) / dual-vector / Cas12 use. (2) Lentivirus: large cargo but integrates. (3) Lipid nanoparticles (LNP) delivering mRNA/RNP: transient, redosable, liver-tropic — basis of in vivo therapeutic programs. (4) Electroporation of ribonucleoprotein (RNP) ex vivo: transient, low off-target, the workhorse for ex-vivo cell therapy."
  tradeoff = "Transient delivery (RNP/mRNA-LNP) lowers off-target and immunogenicity exposure vs persistent expression (integrating viral) — a delivery-pharmacology tradeoff, not a lattice value."
  |> "[@x_doudna_2020] (delivery/therapeutic landscape review)"

@D mech_specificity := "off-target editing & specificity engineering" :: mechanism [ok]
  problem = "Guide RNAs tolerate mismatches, so Cas9 can cut off-target sites with partial homology — the central safety problem for therapeutic editing. Genome-wide off-target was mapped by unbiased assays (GUIDE-seq, CIRCLE-seq, Digenome-seq)."
  mitigations = "(1) High-fidelity engineered Cas9 variants (eSpCas9, SpCas9-HF1, HiFi Cas9) with weakened nonspecific contacts. (2) Truncated/optimized guides. (3) Transient RNP delivery (shorter active window). (4) Paired nickases. (5) PAM-flexible / smaller orthologs to widen targetable space without losing specificity."
  residual = "These REDUCE but do not ZERO off-target editing — a real specificity FLOOR persists (g1 explicitly names the 'CRISPR off-target floor' as a real limit; see [@lim_offtarget])."
  |> "[@x_kleinstiver_2016] (SpCas9-HF1) · [@x_slaymaker_2016] (eSpCas9) · [@x_tsai_2015] (GUIDE-seq off-target mapping)"

# ── §4 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ─────

@D lim_offtarget := "off-target / specificity floor" :: real-limit [ok required]
  wall = "SOFT WALL (reducible, not zeroable with current tech)"
  statement = "Guide-RNA mismatch tolerance means a non-zero genome-wide off-target editing probability persists even with high-fidelity Cas9, truncated guides, and transient delivery. Off-target rate can be driven low but not provably to zero, and unbiased detection assays have finite sensitivity."
  consequence = "Therapeutic safety is bounded by residual off-target risk, NOT by a lattice constant. g1 (LATTICE_POLICY) explicitly names the 'CRISPR off-target floor' as a real limit — it is a real, non-zero floor, not a tautology."
  |> "[@x_tsai_2015] · [@x_kleinstiver_2016]"

@D lim_hdr := "HDR inefficiency in non-dividing cells" :: real-limit [ok required]
  wall = "HARD WALL (cell-cycle-coupled)"
  statement = "Homology-directed repair is largely confined to S/G2 phase and is intrinsically inefficient or near-absent in post-mitotic / non-dividing cells (neurons, mature cardiomyocytes, quiescent stem cells)."
  consequence = "Precise template-based correction by classical HDR is low-yield in exactly the tissues where many genetic diseases manifest — a key motivation for DSB-free base/prime editing. This is cell-biology, not a lattice limit."
  |> "[@x_jasin_haber_2016]"

@D lim_delivery := "delivery / packaging bottleneck" :: real-limit [ok required]
  wall = "ENGINEERING WALL (current vectors)"
  statement = "No delivery vehicle is simultaneously high-efficiency, tissue-targeted, large-cargo, non-immunogenic, and transient. AAV's ~4.7 kb cap constrains payload; LNP is largely liver-tropic; viral persistence raises off-target/immune exposure; ex-vivo RNP cannot reach most solid tissues."
  consequence = "In vivo editing is feasible mainly where delivery is solved (notably liver via LNP-RNP); most tissues remain delivery-limited. Bound is vector engineering + immunology, not a lattice value."

@D lim_mosaicism := "embryo mosaicism" :: real-limit [ok required]
  wall = "BIOLOGICAL WALL (timing-coupled)"
  statement = "When editing reagents act after the one-cell stage (or persist across early cleavage divisions), an embryo becomes a MOSAIC of edited and unedited cells with heterogeneous alleles. Editing/repair kinetics relative to the cell cycle make uniform single-allele outcomes in embryos unreliable."
  consequence = "Mosaicism (alongside off-target and unintended large rearrangements) is a core technical reason heritable embryo editing is scientifically unsafe with current methods — independent of the separate ethical prohibition (see [@lim_germline])."

@D lim_p53_chromothripsis := "p53 toxicity / large-deletion & chromothripsis risk" :: real-limit [ok required]
  wall = "BIOLOGICAL WALL (DSB-intrinsic)"
  statement = "A Cas9 DSB triggers a p53-mediated DNA-damage response; editing can enrich for p53-pathway-deficient cells (a oncogenic-selection concern). Unintended on-target consequences include large deletions, complex rearrangements, and chromothripsis (catastrophic chromosome shattering) — under-detected by short-amplicon assays."
  consequence = "Every DSB-based edit carries a non-zero genotoxic/oncogenic risk that cannot be fully engineered away, only minimized (favoring nick-based base/prime editing for some applications). Real cell-biology limit, not a lattice quantity."
  |> "[@x_haapaniemi_2018] (p53 / DNA-damage response) · [@x_kosicki_2018] (large deletions / rearrangements) · [@x_leibowitz_2021] (chromothripsis)"

@D lim_germline := "heritable (germline) editing ethical hard wall" :: real-limit [ok required]
  wall = "HARD WALL (ethical / legal — absolute under current consensus)"
  statement = "In 2018 He Jiankui announced the birth of twins from CRISPR-edited human embryos (CCR5), provoking near-universal scientific and ethical condemnation; he was criminally convicted in China (2019). Major bodies (WHO advisory committee, the International Commission/National Academies) concluded heritable human genome editing is not currently permissible — on safety AND ethics (consent of future generations, equity, off-target/mosaicism)."
  consequence = "Heritable human genome editing is outside responsible scientific practice under the current international consensus. This tape treats it ONLY as modeling-context knowledge of the ethical boundary — NEVER as guidance (g8 in-silico-only · f2 no-clinical-claim · scope_disclaimer)."
  |> "[@x_nas_who_2020] (international heritable-editing governance reports — primary bodies/era; specific volume not asserted)"

# ── §5 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-crispr-biology" :: governance [required deny:write]
  pattern = "Deriving CRISPR efficacy / counts / ratios / specificity FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'off-target < 0.1% because σ-φ', 'PAM = 3 nt because n/φ', '6 Cas types because n', 'sgRNA = 20 nt because J₂-τ'. These were the exact fabrications in the pre-rewrite stub (hexa-bio mass-split 153b5a2)."
  why = "PAM lengths, guide lengths, Cas family/type counts, editing-window sizes, repair-pathway counts, and off-target rates are molecular biology and microbial classification — they are measured/observed, not lattice-derived. Forbidden by hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool), f1 (lattice-fit-on-external-entity)."
  remedy = "Cite real primary literature (this tape's @X entries). The lattice may be a coincidental OBSERVATION only (e.g. SpCas9 NGG PAM happens to be 3 nt) — NEVER a derivation."

@N n6_honest_stance := "CRISPR has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: CRISPR-Cas genome editing exposes NO natural n=6 invariant. PAM length (SpCas9 NGG=3 nt, SaCas9 ~6 nt, Cas12a TTTV=4 nt) is protein-specific biochemistry. Conventional spacer/guide length (~20 nt) is an engineering choice. Cas type count (I–VI) and class count (2) are an evolving microbial classification, not a fixed lattice number. DSB-repair pathways (NHEJ/HDR/MMEJ/...) are cell biology. Editing efficiencies and off-target rates are empirically measured and assay-dependent. Any numeric coincidence with σ/τ/φ/J₂ is OBSERVATION ONLY. Per LATTICE_POLICY g1/g2 + lattice-as-tool (격자는 도구이지 제약이 아니다): the n=6 lattice is declined here as a derivation tool. This honesty is the corrective for the audited lattice-tautology stub."

# ── §6 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 off-target floor is non-zero" :: prediction [ok]
  claim = "Unbiased genome-wide off-target assays (GUIDE-seq / CIRCLE-seq class) detect ≥1 off-target site for a non-trivial fraction of therapeutically-relevant guides, even with high-fidelity Cas9 — i.e. the off-target floor is empirically non-zero, not abolished."
  falsifier = "If a sufficiently sensitive unbiased assay routinely shows EXACTLY zero off-target across high-fidelity-Cas9 guides genome-wide, [@lim_offtarget] is wrong."
  source = "[@x_tsai_2015] · [@x_kleinstiver_2016]"

@D tp_2 := "TP-2 HDR is cell-cycle-gated" :: prediction [ok]
  claim = "For the same locus and donor, precise HDR knock-in efficiency is markedly higher in actively dividing (S/G2-cycling) cells than in matched post-mitotic / quiescent cells; DSB-free base/prime editing narrows that gap."
  falsifier = "If HDR knock-in efficiency is equal in post-mitotic vs dividing cells under matched conditions, [@lim_hdr] is wrong."
  source = "[@x_jasin_haber_2016]"

@D tp_3 := "TP-3 base editing avoids DSB-class large rearrangements" :: prediction [ok]
  claim = "DSB-free editors (cytosine/adenine base editors, prime editors) show substantially LOWER rates of on-target large deletions / chromothripsis-type rearrangements than DSB-inducing Cas9 nuclease at comparable loci."
  falsifier = "If base/prime editors produce on-target large deletions/rearrangements at rates indistinguishable from Cas9 nuclease, the DSB-avoidance rationale of base/prime editing ([@mech_base_editing], [@mech_prime_editing], [@lim_p53_chromothripsis]) is undermined."
  source = "[@x_kosicki_2018] · [@x_komor_2016] · [@x_anzalone_2019]"

# ── §7 External citations (real, landmark literature) ─────────────────

@X x_jansen_2002 := "Jansen R et al 2002" :: literature [active]
  ref = "Jansen R, van Embden JDA, Gaastra W, Schouls LM. Identification of genes that are associated with DNA repeats in prokaryotes. Mol Microbiol 2002;43:1565–1575. (coined 'CRISPR' + cas gene family)"

@X x_barrangou_2007 := "Barrangou R et al 2007" :: literature [active]
  ref = "Barrangou R, Fremaux C, Deveau H, Richards M, Boyaval P, Moineau S, Romero DA, Horvath P. CRISPR provides acquired resistance against viruses in prokaryotes. Science 2007;315:1709–1712."

@X x_jinek_2012 := "Jinek M et al 2012" :: literature [active]
  ref = "Jinek M, Chylinski K, Fonfara I, Hauer M, Doudna JA, Charpentier E. A programmable dual-RNA-guided DNA endonuclease in adaptive bacterial immunity. Science 2012;337:816–821."

@X x_cong_2013 := "Cong L et al 2013" :: literature [active]
  ref = "Cong L, Ran FA, Cox D, Lin S, Barretto R, Habib N, Hsu PD, Wu X, Jiang W, Marraffini LA, Zhang F. Multiplex genome engineering using CRISPR/Cas systems. Science 2013;339:819–823."

@X x_mali_2013 := "Mali P et al 2013" :: literature [active]
  ref = "Mali P, Yang L, Esvelt KM, Aach J, Guell M, DiCarlo JE, Norville JE, Church GM. RNA-guided human genome engineering via Cas9. Science 2013;339:823–826."

@X x_jinek_2014 := "Jinek M et al 2014" :: literature [active]
  ref = "Jinek M, Jiang F, Taylor DW, et al. Structures of Cas9 endonucleases reveal RNA-mediated conformational activation. Science 2014;343:1247997. (Cas9 domain architecture / HNH-RuvC; primary-author/era cited)"

@X x_zetsche_2015 := "Zetsche B et al 2015" :: literature [active]
  ref = "Zetsche B, Gootenberg JS, Abudayyeh OO, et al. Cpf1 is a single RNA-guided endonuclease of a class 2 CRISPR-Cas system. Cell 2015;163:759–771. (Cas12a/Cpf1)"

@X x_abudayyeh_2016 := "Abudayyeh OO et al 2016" :: literature [active]
  ref = "Abudayyeh OO, Gootenberg JS, Konermann S, et al. C2c2 is a single-component programmable RNA-guided RNA-targeting CRISPR effector. Science 2016;353:aaf5573. (Cas13 RNA targeting)"

@X x_komor_2016 := "Komor AC et al 2016" :: literature [active]
  ref = "Komor AC, Kim YB, Packer MS, Zuris JA, Liu DR. Programmable editing of a target base in genomic DNA without double-stranded DNA cleavage. Nature 2016;533:420–424. (cytosine base editing)"

@X x_gaudelli_2017 := "Gaudelli NM et al 2017" :: literature [active]
  ref = "Gaudelli NM, Komor AC, Rees HA, Packer MS, Badran AH, Bryson DI, Liu DR. Programmable base editing of A·T to G·C in genomic DNA without DNA cleavage. Nature 2017;551:464–471. (adenine base editing)"

@X x_anzalone_2019 := "Anzalone AV et al 2019" :: literature [active]
  ref = "Anzalone AV, Randolph PB, Davis JR, et al, Liu DR. Search-and-replace genome editing without double-strand breaks or donor DNA. Nature 2019;576:149–157. (prime editing)"

@X x_kleinstiver_2016 := "Kleinstiver BP et al 2016" :: literature [active]
  ref = "Kleinstiver BP, Pattanayak V, Prew MS, Tsai SQ, Nguyen NT, Zheng Z, Joung JK. High-fidelity CRISPR-Cas9 nucleases with no detectable genome-wide off-target effects. Nature 2016;529:490–495. (SpCas9-HF1)"

@X x_slaymaker_2016 := "Slaymaker IM et al 2016" :: literature [active]
  ref = "Slaymaker IM, Gao L, Zetsche B, Scott DA, Yan WX, Zhang F. Rationally engineered Cas9 nucleases with improved specificity. Science 2016;351:84–88. (eSpCas9)"

@X x_tsai_2015 := "Tsai SQ et al 2015" :: literature [active]
  ref = "Tsai SQ, Zheng Z, Nguyen NT, et al, Joung JK. GUIDE-seq enables genome-wide profiling of off-target cleavage by CRISPR-Cas nucleases. Nat Biotechnol 2015;33:187–197."

@X x_jasin_haber_2016 := "Jasin M, Haber JE 2016" :: literature [active]
  ref = "Jasin M, Haber JE. The democratization of gene editing: insights from site-specific cleavage and double-strand break repair. DNA Repair (Amst) 2016;44:6–16. (DSB repair pathway biology; primary-authors/era cited, exact volume not asserted)"

@X x_makarova_2020 := "Makarova KS et al 2020" :: literature [active]
  ref = "Makarova KS, Wolf YI, Iranzo J, et al, Koonin EV. Evolutionary classification of CRISPR-Cas systems: a burst of class 2 and derived variants. Nat Rev Microbiol 2020;18:67–83. (CRISPR-Cas classification framework)"

@X x_haapaniemi_2018 := "Haapaniemi E et al 2018" :: literature [active]
  ref = "Haapaniemi E, Botla S, Persson J, Schmierer B, Taipale J. CRISPR-Cas9 genome editing induces a p53-mediated DNA damage response. Nat Med 2018;24:927–930."

@X x_kosicki_2018 := "Kosicki M et al 2018" :: literature [active]
  ref = "Kosicki M, Tomberg K, Bradley A. Repair of double-strand breaks induced by CRISPR-Cas9 leads to large deletions and complex rearrangements. Nat Biotechnol 2018;36:765–771."

@X x_leibowitz_2021 := "Leibowitz ML et al 2021" :: literature [active]
  ref = "Leibowitz ML, Papathanasiou S, Doerfler PA, et al, Pellman D. Chromothripsis as an on-target consequence of CRISPR-Cas9 genome editing. Nat Genet 2021;53:895–905. (on-target chromothripsis)"

@X x_doudna_2020 := "Doudna JA 2020" :: literature [active]
  ref = "Doudna JA. The promise and challenge of therapeutic genome editing. Nature 2020;578:229–236. (delivery / therapeutic-editing landscape review)"

@X x_nas_who_2020 := "Heritable human genome editing governance reports (2020)" :: literature [active]
  ref = "International Commission on the Clinical Use of Human Germline Genome Editing — National Academy of Medicine, National Academy of Sciences, & The Royal Society. Heritable Human Genome Editing. Washington, DC: The National Academies Press, 2020; and WHO Expert Advisory Committee on Developing Global Standards for Governance and Oversight of Human Genome Editing (2021 reports). (primary bodies / era cited; specific report volume not asserted)"
