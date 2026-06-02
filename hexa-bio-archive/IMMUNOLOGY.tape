#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# IMMUNOLOGY.tape — architecture-current (editable per v1.2)
# Event history → IMMUNOLOGY.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "immunology" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · immunology in-silico knowledge SSOT"
  brief = "Immunology — innate/adaptive + clinical translation · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  scope = "in-silico immunology knowledge SSOT · NOT clinical advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see IMMUNOLOGY.log.tape audit"
  sibling-log = "IMMUNOLOGY.log.tape"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is an evidence-summary knowledge SSOT for an in-silico immunology substrate. Mechanistic, classification and therapeutic figures are paraphrased from published immunology and clinical literature for modeling context only — they are NOT prescribing guidance, NOT a diagnostic protocol, and NOT a substitute for the judgement of a licensed clinician. Immune phenomena are heterogeneous across pathogens, genetics and life-stage; specific therapy decisions (e.g. checkpoint inhibitors, biologics, immunosuppression) are individualized. All claims here are in-silico simulator/metadata consistency only; the wet-lab → preclinical → clinical → licensure → post-marketing-surveillance boundary is explicitly out of scope (hexa-bio AGENTS.tape g8 / f2)."

# ── §1 What immunology is & foundational concepts ─────────────────────

@D dx_definition := "what immunology studies" :: domain [ok]
  scope = "Immunology is the study of how multicellular hosts distinguish self from non-self (and from altered-self), recognize and respond to threats (pathogens, transformed cells, allogeneic tissue), and retain memory of prior encounters."
  two-arms = "Operationally split into INNATE immunity (germline-encoded, rapid, broad pattern recognition) and ADAPTIVE immunity (somatically diversified, clonal, antigen-specific, memory-bearing). The two arms are not independent — innate priming shapes adaptive output, and adaptive feedback recruits innate effectors."
  not-this-tape = "Vaccinology platform engineering is scoped under VACCINE.tape; cancer immunotherapy clinical translation under CANCER-THERAPY.tape — this tape covers underlying immunology and cross-links to those siblings where they share mechanism."
  |> "[@x_janeway_textbook]"

@D dx_clonal_selection := "clonal selection theory" :: domain [ok]
  thesis = "Burnet's clonal selection theory: lymphocytes individually carry distinct antigen-specific receptors generated before antigen encounter; antigen SELECTS for clones whose receptors fit, driving their proliferation and effector differentiation, while self-reactive clones are deleted or anergised during development."
  era = "Burnet 1957 (Aust J Sci); preceded by Jerne's 1955 natural-selection antibody-network framing. Burnet shared the 1960 Nobel Prize (with Medawar) for acquired immunological tolerance."
  consequence = "This framework anchors essentially all modern adaptive immunology: V(D)J recombination as the source of pre-encounter diversity, central tolerance as the deletion mechanism, and immunological memory as expanded selected clones."
  |> "[@x_burnet_1957] · [@x_jerne_1955]"

# ── §2 Innate immunity ────────────────────────────────────────────────

@D innate_prr := "pattern-recognition receptors (PRRs) — TLRs and beyond" :: mechanism [ok]
  concept = "Innate cells (macrophages, dendritic cells, neutrophils, mast cells, epithelial barriers) express germline-encoded PRRs recognizing PAMPs (pathogen-associated molecular patterns) and DAMPs (damage-associated)."
  tlr-family = "Toll-like receptors (TLRs) are the prototypical PRR family — TLR4 binds bacterial LPS (lipopolysaccharide / endotoxin); TLR3 dsRNA; TLR7/8 ssRNA; TLR9 unmethylated CpG-DNA. Engagement triggers NF-κB / IRF signalling → cytokines + co-stimulation that license adaptive priming."
  beutler-2011 = "Bruce Beutler's identification of TLR4 as the LPS receptor (positional cloning in C3H/HeJ mice) shared the 2011 Nobel Prize in Physiology or Medicine (with Hoffmann and Steinman) for discoveries in innate immunity."
  other-prrs = "RLRs (RIG-I-like, cytosolic RNA), CLRs (C-type lectins, fungi), NLRs (NOD-like, including inflammasome scaffolds), cGAS-STING (cytosolic DNA)."
  |> "[@x_beutler_nobel_2011] · [@x_janeway_textbook]"

@D innate_complement := "complement system" :: mechanism [ok]
  pathways = "Three activation pathways converging on C3 cleavage: CLASSICAL (antibody-antigen complexes → C1q → C1r/s → C4/C2 → C3 convertase); LECTIN (mannose-binding lectin / ficolins → MASPs → C4/C2); ALTERNATIVE (spontaneous C3 tickover amplified on microbial surfaces)."
  effectors = "Opsonization (C3b-coated targets eaten by phagocytes); chemotaxis (C3a/C5a anaphylatoxins recruit neutrophils); membrane-attack complex (C5b-9 lyses susceptible microbes); B-cell and follicular dendritic-cell modulation via complement receptors."
  regulation = "Tightly regulated by host factors (factor H, CD55/DAF, CD59) — defects produce disease (paroxysmal nocturnal hemoglobinuria; atypical haemolytic uraemic syndrome)."
  honesty = "Three activation pathways is a textbook biology FACT, not a lattice product."
  |> "[@x_janeway_textbook]"

@D innate_nk_ilc := "NK cells & innate lymphoid cells (ILCs)" :: mechanism [ok]
  nk = "Natural killer (NK) cells are cytotoxic innate lymphocytes that integrate ACTIVATING (e.g. NKG2D recognising stress ligands) and INHIBITORY (KIR / NKG2A recognising self-MHC-I) signals — 'missing-self' detection of MHC-I downregulation by tumours or viruses triggers killing."
  ilc-subsets = "ILCs mirror T-helper polarization without antigen receptors: ILC1 (IFN-γ, Th1-like; intracellular pathogens), ILC2 (IL-5/IL-13, Th2-like; helminths, allergy), ILC3 (IL-17/IL-22, Th17-like; barrier defence). NK cells are often classified as the cytotoxic ILC1 lineage."
  honesty = "Subset counts are biological observations of a still-evolving taxonomy (ILC nomenclature continues to be refined), NOT lattice values."
  |> "[@x_janeway_textbook]"

@D innate_inflammasome := "inflammasomes — NLRP3 and the IL-1β / pyroptosis axis" :: mechanism [ok]
  scaffold = "An inflammasome is a cytosolic multi-protein platform (sensor + adaptor ASC + caspase-1) that activates pro-caspase-1 in response to PAMP/DAMP signals; activated caspase-1 cleaves pro-IL-1β / pro-IL-18 into mature cytokines and cleaves gasdermin-D to execute pyroptotic cell death."
  nlrp3 = "NLRP3 is the most studied inflammasome sensor — activated by a broad set of triggers (crystals: urate in gout, cholesterol in atherosclerosis; ATP/K+ efflux; pore-forming toxins). Characterized in large part in Jürg Tschopp's laboratory in the 2000s (Tschopp NLRP3 era)."
  disease-link = "Cryopyrin-associated periodic syndromes (CAPS — gain-of-function NLRP3) are dramatically responsive to IL-1 blockade (anakinra, canakinumab) — clinical validation of the pathway."
  |> "[@x_tschopp_nlrp3_era] · [@x_janeway_textbook]"

@D innate_dc := "dendritic cells — the innate→adaptive bridge" :: mechanism [ok]
  role = "Dendritic cells (DCs) are the dominant professional antigen-presenting cells (APCs): they sample antigen in peripheral tissues, mature on PAMP/DAMP signalling, migrate to draining lymph nodes, and present processed peptide to naive T cells on MHC, providing the obligatory co-stimulation that licenses adaptive priming."
  steinman-2011 = "Ralph Steinman discovered and named dendritic cells in the early 1970s and demonstrated their unique antigen-presenting potency; awarded the 2011 Nobel Prize (jointly with Beutler and Hoffmann; awarded posthumously after his death from pancreatic cancer)."
  subsets = "Conventional DC1 (cross-presentation to CD8+ T cells via MHC-I), cDC2 (CD4+ T-cell priming), plasmacytoid DCs (type-I interferon production in viral infection), monocyte-derived DCs (inflammation)."
  |> "[@x_steinman_nobel_2011]"

# ── §3 Adaptive immunity — receptor diversity & MHC restriction ───────

@D adap_vdj := "V(D)J recombination — antibody/TCR diversity" :: mechanism [ok]
  problem = "How does a finite genome encode a near-unbounded repertoire of antigen receptors? Susumu Tonegawa showed in the mid-1970s that immunoglobulin variable regions are assembled by somatic DNA recombination of V, D and J gene segments — generating receptor diversity from a small set of germline parts."
  tonegawa-1987 = "Tonegawa received the 1987 Nobel Prize in Physiology or Medicine for the genetic principle for generation of antibody diversity."
  machinery = "RAG1/RAG2 recombinase cleaves at recombination-signal sequences; junctional diversity is amplified by exonuclease trimming, P-nucleotide / N-nucleotide (TdT) addition. Defects in RAG → B− T− SCID (see [@dis_immunodeficiency])."
  tcr = "T-cell receptor α/β (and γ/δ) loci undergo analogous V(D)J recombination — establishing the TCR repertoire characterised in the mid-1980s (Mak and Davis laboratories, 1984, identified the TCR β-chain genes)."
  |> "[@x_tonegawa_nobel_1987] · [@x_mak_davis_tcr_1984_era]"

@D adap_mhc_restriction := "MHC restriction — Doherty & Zinkernagel" :: mechanism [ok]
  finding = "Cytotoxic T cells recognise viral peptides only when presented on SELF MHC class I — i.e. T-cell recognition is dual (peptide + MHC), not antibody-like recognition of soluble antigen. Demonstrated by Doherty & Zinkernagel in LCMV-infected mice in 1974."
  nobel-1996 = "Doherty and Zinkernagel shared the 1996 Nobel Prize for the discovery of how the immune system recognizes virus-infected cells."
  mechanism-now = "MHC class I (HLA-A/B/C in humans) presents intracellularly-derived peptides (proteasome → TAP → endoplasmic reticulum loading) to CD8+ T cells. MHC class II (HLA-DR/DP/DQ) presents extracellularly-derived peptides (endosomal processing) to CD4+ T cells. The TCR contacts both peptide and MHC; thymic selection shapes the repertoire toward self-MHC-restriction."
  |> "[@x_doherty_zinkernagel_nobel_1996]"

@D adap_germinal_center := "B-cell affinity maturation & class switching" :: mechanism [ok]
  germinal-center = "After antigen exposure and T-follicular-helper (Tfh) help, naive B cells enter germinal centers (GCs) in secondary lymphoid tissue. Cycles of SOMATIC HYPERMUTATION of immunoglobulin V regions (by activation-induced cytidine deaminase, AID) followed by AFFINITY-BASED SELECTION on follicular dendritic cells progressively raise the BCR's affinity for antigen."
  class-switch = "CLASS-SWITCH RECOMBINATION (also AID-dependent) replaces the IgM/IgD constant region with IgG, IgA, or IgE — adapting effector function (complement fixation, mucosal transport, mast-cell sensitisation) without changing antigen specificity."
  output = "GC output is high-affinity, class-switched memory B cells + long-lived plasma cells (bone-marrow-resident). This is the cellular basis of durable humoral memory and is shared with the vaccine response (cross-link VACCINE.tape mech_humoral)."
  cross-link = "[@x_vaccine_sibling] mech_humoral / mech_memory share this machinery."

@D adap_t_subsets := "T-cell subsets — CD4 helpers, CD8 cytotoxic, Tfh, T_RM" :: mechanism [ok]
  cd4-helpers = "Th1 (IFN-γ; intracellular pathogens, macrophage activation); Th2 (IL-4/IL-5/IL-13; helminths, allergy); Th17 (IL-17/IL-22; extracellular bacteria, fungi, mucosal defence; pathogenic in autoimmunity); Treg (FOXP3+; peripheral tolerance, IL-10/TGF-β). Polarization is shaped by DC-derived cytokines at priming."
  cd8-cytotoxic = "CD8+ cytotoxic T lymphocytes (CTLs) kill MHC-I-restricted targets via perforin/granzyme and Fas-FasL; critical for intracellular viral infection and tumour surveillance."
  tfh = "T-follicular-helper (Tfh; CXCR5+ Bcl-6+) cells provide cognate B-cell help in the germinal center."
  trm = "Tissue-resident memory T cells (T_RM; CD69+ CD103+ in epithelia) provide site-of-entry surveillance — they sit in barrier tissues (skin, lung, gut, genital) and respond locally on re-exposure without needing recall from circulation."
  honesty = "Subset taxonomy continues to be refined (e.g. Th9, Th22, ex-Treg plasticity); counts here are descriptive of the standard textbook framework, NOT lattice values."
  |> "[@x_janeway_textbook]"

# ── §4 Checkpoint biology & clinical translation ──────────────────────

@D ckpt_biology := "co-inhibitory checkpoints — CTLA-4 and PD-1" :: mechanism [ok]
  rationale = "T-cell activation requires TCR signal + CD28 co-stimulation; the system also encodes negative regulators ('checkpoints') to dampen / terminate responses and enforce peripheral tolerance — these include CTLA-4 (Cytotoxic T-Lymphocyte-associated Antigen 4) and PD-1 (Programmed cell Death protein 1)."
  ctla4 = "CTLA-4 (Allison laboratory, early-1990s identification of CTLA-4 as a brake on T-cell activation) competes with CD28 for B7 ligands (CD80/CD86) and raises the activation threshold — predominantly at the priming phase in lymph nodes."
  pd1 = "PD-1 (Honjo laboratory, 1992 identification by Yasumasa Ishida / Tasuku Honjo) is induced on activated/exhausted T cells; its ligands PD-L1 (often upregulated on tumours and chronically inflamed tissue) and PD-L2 engage SHP-2 to dampen effector function — predominantly in peripheral tissues."
  nobel-2018 = "James P. Allison and Tasuku Honjo shared the 2018 Nobel Prize in Physiology or Medicine for the discovery of cancer therapy by inhibition of negative immune regulation — directly recognising the translation of checkpoint biology into immunotherapy."
  |> "[@x_allison_honjo_nobel_2018]"

@D ckpt_clinical := "checkpoint inhibitors in the clinic" :: therapy [ok recommended]
  ipi = "Ipilimumab (anti-CTLA-4) was the first agent to demonstrate an overall-survival benefit in metastatic melanoma in a randomised phase-3 trial (Hodi et al., NEJM 2010) — establishing immune checkpoint blockade as a therapeutic class."
  pd1-class = "Nivolumab and pembrolizumab (anti-PD-1), and atezolizumab / durvalumab / avelumab (anti-PD-L1), now have approvals across many tumour types (melanoma, NSCLC, renal, urothelial, head-and-neck, MSI-high / dMMR colorectal, Hodgkin lymphoma, and more)."
  responders = "Biomarkers (PD-L1 expression by IHC, MSI-high/dMMR status, tumour mutational burden) enrich for — but do not guarantee — response; a durable-response minority benefits substantially, the majority does not in most tumour types."
  irae = "Immune-related adverse events (irAEs) — colitis, hepatitis, pneumonitis, endocrinopathies (thyroid, hypophysitis, type 1 diabetes), dermatologic — reflect the disinhibited immune system and are a distinct safety axis from cytotoxic toxicity (see [@lim_irae])."
  cross-link = "Clinical translation detail in [@x_cancer_therapy_sibling] CANCER-THERAPY.tape tx_immune_checkpoint / cmp_immuno."
  |> "[@x_hodi_2010]"

# ── §5 Antibody therapeutics ──────────────────────────────────────────

@D mab_overview := "therapeutic monoclonal antibodies" :: therapy [ok recommended]
  principle = "Engineered (chimeric, humanised, or fully human) monoclonal antibodies redirect immune effector function or block ligand/receptor interactions. Köhler & Milstein's 1975 hybridoma method (Nobel 1984) made monoclonal antibody production routine; later humanisation / transgenic-mouse / phage-display technologies removed murine immunogenicity."
  classes = "Naked mAbs (signalling block / immune engagement); antibody-drug conjugates (ADCs — mAb + cytotoxic payload, e.g. T-DM1, brentuximab-vedotin); bispecifics (BiTEs and T-cell engagers, e.g. blinatumomab CD19×CD3); Fc-engineered mAbs (enhanced ADCC, FcRn-extended half-life)."
  |> "[@x_janeway_textbook]"

@D mab_trastuzumab := "trastuzumab (anti-HER2)" :: therapy [ok recommended]
  target = "HER2/ERBB2 — overexpressed/amplified in roughly a fifth of breast cancers (and a subset of gastric/oesophageal). Trastuzumab is a humanised IgG1 binding HER2 extracellular domain."
  landmark = "Slamon et al., NEJM 2001: addition of trastuzumab to chemotherapy in HER2-overexpressing metastatic breast cancer improved time to progression and overall survival vs chemotherapy alone — the first targeted-mAb proof of concept for solid-tumour oncology and the basis of HER2-directed adjuvant therapy."
  moa = "HER2 signalling inhibition, ADCC via FcγR-bearing NK cells, and (mechanism still debated in detail) endocytic downregulation of HER2."
  |> "[@x_slamon_2001]"

@D mab_rituximab := "rituximab (anti-CD20)" :: therapy [ok recommended]
  target = "CD20 — pan-B-cell marker (mature B cells, not plasma cells or pro-B). Rituximab is a chimeric IgG1."
  use = "Approved for B-cell non-Hodgkin lymphoma (including diffuse large B-cell, follicular), chronic lymphocytic leukaemia, and B-cell-driven autoimmune diseases (rheumatoid arthritis, ANCA-associated vasculitis, pemphigus vulgaris)."
  moa = "ADCC (FcγRIIIa-dependent), CDC, and direct apoptotic signalling; B-cell depletion lasts months and recovery is gradual."
  immunology-import = "Rituximab is also the experimental probe of choice for asking 'is this disease B-cell-driven?' — its efficacy in MS / autoimmune disease reshaped the textbook division between 'antibody-mediated' and 'T-cell-mediated' autoimmunity."

@D mab_checkpoint := "ipilimumab / nivolumab / pembrolizumab" :: therapy [ok recommended]
  ipi = "Ipilimumab (anti-CTLA-4, IgG1) — first checkpoint inhibitor to deliver an OS benefit in metastatic melanoma (Hodi 2010); approved 2011."
  nivo = "Nivolumab (anti-PD-1, IgG4) — broad multi-tumour-type approval; pivotal in melanoma (after ipi), NSCLC second-line, renal cell carcinoma, Hodgkin lymphoma."
  pembro = "Pembrolizumab (anti-PD-1, IgG4) — first tissue-agnostic FDA approval based on MSI-high / dMMR status (mismatch-repair-deficient tumours; Le et al., NEJM 2015), reframing oncology indication around biomarker rather than tissue."
  cross-link = "Clinical-translation detail in [@x_cancer_therapy_sibling] CANCER-THERAPY.tape."
  |> "[@x_hodi_2010]"

# ── §6 Autoimmunity & tolerance ───────────────────────────────────────

@D auto_tolerance := "central and peripheral tolerance" :: mechanism [ok]
  central = "CENTRAL TOLERANCE (thymus for T cells; bone marrow for B cells): self-reactive immature lymphocytes are deleted (negative selection) or diverted (e.g. into natural Treg lineage). The AIRE (autoimmune regulator) transcription factor in thymic medullary epithelial cells (mTECs) drives 'promiscuous' expression of peripheral-tissue antigens — exposing developing T cells to tissue-restricted self-antigens they would otherwise never see. AIRE mutations cause APECED (autoimmune polyendocrinopathy-candidiasis-ectodermal dystrophy) — landmark work from the Mathis/Benoist laboratory established the mechanistic AIRE → tissue-restricted-antigen → negative-selection axis around 2002."
  peripheral = "PERIPHERAL TOLERANCE: anergy (TCR signal without co-stimulation), deletion of activated self-reactive clones, suppression by FOXP3+ regulatory T cells (defects → IPEX), checkpoint engagement (CTLA-4, PD-1)."
  molecular-mimicry = "MOLECULAR MIMICRY — microbial epitopes resembling self-antigens can break tolerance after infection. Classic exemplars include rheumatic fever (group A streptococcal M-protein epitopes cross-reacting with cardiac myosin) and Guillain-Barré syndrome post-Campylobacter jejuni (ganglioside mimicry)."
  |> "[@x_anderson_aire_2002_era] · [@x_janeway_textbook]"

@D auto_hla := "HLA associations with autoimmune disease" :: domain [ok]
  concept = "Polymorphism in MHC (HLA in humans) shapes the peptide-presentation repertoire; specific HLA alleles are statistically associated with specific autoimmune diseases (often the strongest single genetic risk factor)."
  examples = "HLA-B*27 with ankylosing spondylitis and other spondyloarthropathies; HLA-DRB1 shared-epitope alleles (e.g. *04:01, *04:04) with rheumatoid arthritis; HLA-DQ2/DQ8 with coeliac disease; HLA-DR3/DR4 with type 1 diabetes; HLA-B*57:01 with abacavir hypersensitivity."
  honesty = "Association ≠ causation: HLA-B*27 prevalence is ~7-10% in some populations but only a small fraction develop ankylosing spondylitis, indicating polygenic + environmental contribution. HLA frequencies vary substantially between populations. These are epidemiological associations, NOT lattice-derived constants."
  |> "[@x_janeway_textbook]"

@D auto_examples := "representative autoimmune diseases" :: domain [ok]
  ra = "Rheumatoid arthritis — anti-citrullinated-protein antibodies (ACPA) + synovial inflammation; TNF blockade (etanercept, infliximab, adalimumab), IL-6 blockade (tocilizumab), B-cell depletion (rituximab), JAK inhibition all in standard care."
  sle = "Systemic lupus erythematosus — anti-nuclear / anti-dsDNA antibodies + immune-complex glomerulonephritis + multisystem involvement; type-I IFN signature; anifrolumab (anti-IFNAR1) added to the toolkit alongside historical agents."
  ms = "Multiple sclerosis — CNS demyelination; anti-CD20 (ocrelizumab) recast MS as a substantially B-cell-modulated disease."
  t1dm = "Type 1 diabetes — T-cell-mediated β-cell destruction; teplizumab (anti-CD3) delays clinical onset in high-risk individuals (FDA approval 2022)."
  ibd = "Crohn's / ulcerative colitis — TNF blockade, integrin (vedolizumab), IL-12/23 (ustekinumab), IL-23 (risankizumab), JAK (tofacitinib)."
  honesty = "Disease lists are descriptive of standard clinical taxonomy; this tape does not prescribe regimens."

# ── §7 Immunodeficiency & immune evasion ──────────────────────────────

@D dis_immunodeficiency := "primary immunodeficiencies (PIDs)" :: domain [ok]
  scid = "SEVERE COMBINED IMMUNODEFICIENCY (SCID) — profound T-cell deficiency ± B/NK (T−B−, T−B+ variants); molecular causes include X-linked IL-2-receptor common γ-chain (IL2RG), adenosine deaminase (ADA), RAG1/RAG2 (V(D)J recombination defect → no receptor diversity), and others. Standard-of-care includes haematopoietic stem-cell transplantation; gene therapy is approved/in trials for several genetic causes (ADA-SCID, ARSA, etc.)."
  cgd = "CHRONIC GRANULOMATOUS DISEASE (CGD) — defects in NADPH-oxidase subunits (X-linked CYBB / gp91phox most common; CYBA, NCF1/2/4) impair phagocyte respiratory burst → recurrent catalase-positive bacterial/fungal infection. IFN-γ prophylaxis and HSCT/gene-therapy options."
  cvid = "COMMON VARIABLE IMMUNODEFICIENCY (CVID) — hypogammaglobulinaemia with impaired specific-antibody response; immunoglobulin replacement is the mainstay."
  newborn-screen = "TREC-based newborn screening identifies SCID before opportunistic infection — substantially improving HSCT outcomes."
  honesty = "PID taxonomy (IUIS classification) is itself periodically revised; counts here are descriptive."

@D dis_evasion := "immune evasion — by tumours and chronic pathogens" :: domain [ok]
  tumours = "MHC-I downregulation (escapes CTL recognition; can trigger NK 'missing-self'); PD-L1 upregulation; immunosuppressive cytokines (TGF-β, IL-10); recruitment of myeloid-derived suppressor cells and Tregs; metabolic exclusion (tryptophan depletion via IDO, adenosine via CD39/CD73)."
  chronic-viruses = "HIV — extreme antigenic variability, integration into host genome, CD4+ T-cell depletion, latent reservoir defying functional cure. EBV — establishes latency in memory B cells, expresses minimal antigens (latency 0/I/II). HCMV — encodes numerous MHC-I downregulating gene products. HCV — variability of envelope and effective T-cell exhaustion."
  bacteria = "Mycobacterium tuberculosis — survives within macrophage phagosomes (arrests phagosome maturation); granuloma physiology shields persisters."
  evasion-as-limit = "Immune evasion is a real-biology HARD WALL for both vaccine development against these pathogens (see [@x_vaccine_sibling] lim_pathogen_specific_failures) and for tumour immunotherapy response."
  cross-link = "[@x_vaccine_sibling] · [@x_cancer_therapy_sibling]"

# ── §8 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_tolerance_breakdown := "tolerance breakdown / autoimmunity" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "Central + peripheral tolerance is imperfect: a non-trivial fraction of the population (estimated several percent collectively across autoimmune diseases in epidemiological surveys) develops clinical autoimmunity over a lifetime. The mechanisms are multi-layered (HLA repertoire, AIRE-mediated tissue-antigen exposure, Treg function, molecular mimicry, environmental triggers) and probabilistic, not deterministic."
  consequence = "No therapeutic intervention currently restores broken self-tolerance to healthy baseline in established autoimmune disease. Existing therapy SUPPRESSES the response (TNF blockade, B-cell depletion, JAK inhibition, broad immunosuppression) — it does not RE-EDUCATE the immune system. Antigen-specific tolerance restoration is an unsolved problem at the human-patient scale."

@D lim_immunosenescence := "immunosenescence & inflammaging" :: real-limit [ok required]
  wall = "BIOLOGICAL LIMIT (host-intrinsic, age-dependent)"
  statement = "Adaptive immune capacity declines with age: thymic involution from puberty onward reduces naive-T-cell output (the periphery becomes increasingly memory-dominated); B-cell repertoire diversity narrows; vaccine responses (especially to novel antigens) blunt; baseline cytokine tone shifts toward chronic low-grade inflammation ('inflammaging'). Influenza and pneumococcal vaccines are formulated for older adults with high-dose / adjuvanted variants partly to compensate."
  consequence = "Age sets a real biological ceiling on naive immune responses; current interventions (high-dose / adjuvanted vaccines, tailored schedules) shift this ceiling at the margin without reversing it. This is host biology, NOT a lattice product."
  cross-link = "[@x_vaccine_sibling] sched_design / lim_waning"

@D lim_checkpoint_minority := "durable checkpoint response is a minority" :: real-limit [ok required]
  wall = "SOFT WALL (biology-set, biomarker-modulated)"
  statement = "Across most tumour types, durable response to checkpoint blockade is a MINORITY outcome — biomarker enrichment (PD-L1 expression, MSI-high / dMMR, tumour mutational burden) raises the response fraction but does not push it to majority for most indications. Melanoma and MSI-high colorectal cancer are positive outliers; pancreatic adenocarcinoma and most 'immune-cold' tumours are persistent non-responders."
  consequence = "Checkpoint blockade is transformative for the responder subset but is NOT a universal cancer cure; combination strategies, neoantigen vaccines, and TME-conditioning approaches aim to expand the responder pool. The minority-response framing is a biological observation grounded in trial data, NOT a lattice ceiling."
  cross-link = "[@x_cancer_therapy_sibling] tx_immune_checkpoint / lim_no_universal_cure"
  |> "[@x_hodi_2010] · [@x_le_2015]"

@D lim_chronic_evasion := "immune evasion by chronic pathogens" :: real-limit [ok required]
  wall = "HARD WALL (pathogen-specific, current science)"
  statement = "Some pathogens have evolved strategies that fundamentally defeat immune clearance: HIV (antigenic variability, latent integrated provirus, CD4+ T-cell depletion); Mycobacterium tuberculosis (intracellular persistence in macrophages); herpesviruses (latency programmes); Plasmodium (antigenic switching). Clearance of established infection by host immunity alone, or by vaccine-induced immunity to a fixed antigen, is not currently achievable for these classes."
  consequence = "This sets the floor for what immunology — and vaccines — can plausibly deliver against these pathogens with present technology. It is a real-biology hard wall, not a failure of effort. Cross-link [@x_vaccine_sibling] lim_pathogen_specific_failures."

@D lim_adjuvant_tradeoff := "vaccine adjuvant trade-off — reactogenicity vs immunogenicity" :: real-limit [ok required]
  wall = "SOFT WALL"
  statement = "Adjuvants improve vaccine immunogenicity by mobilising innate signalling — but the same signals drive REACTOGENICITY (local pain/swelling, fever, malaise). Tuning toward more potent adjuvants (e.g. AS01 in Shingrix) raises efficacy and side-effect burden in tandem; toward gentler adjuvants (alum) reduces both."
  consequence = "There is no free lunch in adjuvant design — innate activation IS the mechanism, so its costs are intrinsic. This trade-off is an immunology constraint, not an engineering shortfall."
  cross-link = "[@x_vaccine_sibling] adj_overview"

@D lim_irae := "checkpoint-blockade immune-related adverse events" :: real-limit [ok required]
  wall = "PHYSICAL/BIOLOGICAL LIMIT (rate-floored)"
  statement = "Releasing co-inhibitory checkpoints disinhibits self-reactive T-cell clones as well as anti-tumour clones. A subset of patients develop immune-related adverse events (irAEs) — colitis, hepatitis, pneumonitis, hypophysitis, thyroiditis, type-1 diabetes, myocarditis. Severity ranges from manageable to life-threatening; combination CTLA-4 + PD-1 blockade has higher irAE rates than monotherapy. Rare but severe events (e.g. fulminant myocarditis) have a non-zero baseline rate and have driven labelling and monitoring guidance."
  consequence = "irAE risk is intrinsic to the mechanism — the same biology that produces anti-tumour T-cell activation produces auto-reactive activation. Rate-floor cannot be driven to zero without losing efficacy. This is a fundamental immunology trade-off, NOT a lattice value."
  cross-link = "[@x_cancer_therapy_sibling] tx_immune_checkpoint"

# ── §9 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-immunology" :: governance [required deny:write]
  pattern = "Deriving immunology counts / fractions / efficacy / disease prevalence FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. the deleted stub's '방어율 = 99% because σ·sopfr/10', '자가면역 = 1% because μ=1', '면역 기억 = 6 개월 because n=6', '진단 지표 = 12 because σ=12'."
  why = "This is exactly the violation the pre-rewrite IMMUNOLOGY.tape committed (lattice-tautology stub, hexa-bio mass-split 153b5a2 — see IMMUNOLOGY.log.tape audit). Some immunology counts NUMERICALLY coincide with lattice values (e.g. 2 MHC classes ≈ φ(6)=2; 4 IgG subclasses ≈ τ(6)=4; 5 antibody isotypes ≈ sopfr(6)=5) — that is OBSERVATION ONLY. Deriving the count, or claiming the count is so BECAUSE of n=6, is the violation. hexa-bio AGENTS.tape g1/g2/g3/g8 + f1/f2/f3 forbid it; f1 forbids lattice-fit, f2 forbids in-silico→clinical/efficacy claims."
  remedy = "Cite real immunology / landmark clinical literature (this tape's @X entries). Coincidence is observable; derivation is forbidden."

@N n6_honest_stance := "immunology has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: immunology exposes NO natural n=6 invariant. The PRR / TLR family is an open, expanding set (TLR1-10 in humans, plus RLRs, CLRs, NLRs, cGAS-STING — not a closed 6-tuple). T-helper polarization subsets (Th1/Th2/Th17/Treg + emerging Tfh, Th9, Th22, Tregs of multiple flavours) are a still-refined taxonomy, not a lattice value. Complement has 3 activation pathways converging on C3 — a biological fact, not a lattice product. Antibody isotypes (5: IgM/IgG/IgA/IgE/IgD), IgG subclasses (4 in humans: IgG1-4), MHC classes (2 + the non-classical MHC class Ib) are textbook immunology numbers that EXIST in mammalian biology regardless of any lattice; their occasional numerical coincidence with σ/τ/φ values is an OBSERVATION, never a derivation. HLA polymorphism, autoimmune-disease incidence, vaccine response heterogeneity — all are population-biology distributions, NOT lattice constants. Per LATTICE_POLICY g1/g2 + lattice-as-tool: the lattice is DECLINED here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §10 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 checkpoint-response heterogeneity is biology-bound, not platform-bound" :: prediction [ok]
  claim = "Across cancer indications, durable response fraction to anti-PD-1 / anti-PD-L1 monotherapy is heterogeneous (high in MSI-high / dMMR colorectal, classical Hodgkin lymphoma, and melanoma; low in pancreatic adenocarcinoma and most immune-cold tumours) — stratified by tumour-intrinsic biology (mutational burden, neoantigen load, T-cell infiltration, MHC-I expression), NOT by which specific anti-PD-1 antibody is used."
  falsifier = "If two different anti-PD-1 antibodies showed orders-of-magnitude-different durable-response fractions in matched cohorts of the same tumour with the same biomarker stratification, the tumour-biology-dominance premise (and [@lim_checkpoint_minority]) would be wrong."
  source = "[@x_hodi_2010] · [@x_le_2015]"

@D tp_2 := "TP-2 thymic involution gates naive-T-cell responses to novel antigens with age" :: prediction [ok]
  claim = "Adult vaccine responses to NOVEL antigens (no pre-existing memory) are blunted relative to younger adults' responses to the same antigen, with the gap widening monotonically with age — driven by reduced naive-T-cell precursor frequency from thymic involution rather than by adjuvant or platform choice."
  falsifier = "If a vaccine against a wholly novel antigen achieved equivalent magnitude AND durability of antigen-specific responses in elderly adults and in young adults without high-dose or adjuvanted formulation adjustment, [@lim_immunosenescence] is wrong."
  source = "[@x_janeway_textbook] · [@x_vaccine_sibling] sched_design"

@D tp_3 := "TP-3 irAE rate scales with depth of checkpoint inhibition" :: prediction [ok]
  claim = "Combination CTLA-4 + PD-1 blockade produces a higher rate of serious immune-related adverse events than either monotherapy alone, with the trade-off being intrinsic (more disinhibition → both more anti-tumour and more anti-self) — not an artefact of dose, schedule, or specific antibody clone."
  falsifier = "If a combination regimen produced higher anti-tumour activity than either monotherapy WITHOUT a corresponding rise in irAE rate across multiple independent trials, the mechanism-coupling premise (and [@lim_irae]) would be wrong."
  source = "[@x_hodi_2010] · [@x_allison_honjo_nobel_2018]"

# ── §11 External citations (real, landmark literature) ───────────────

@X x_burnet_1957 := "Burnet FM 1957" :: literature [active]
  ref = "Burnet FM. A modification of Jerne's theory of antibody production using the concept of clonal selection. Aust J Sci 1957;20:67-69. (clonal selection theory; primary-author/era — pages per the original short note)"

@X x_jerne_1955 := "Jerne NK 1955" :: literature [active]
  ref = "Jerne NK. The natural-selection theory of antibody formation. Proc Natl Acad Sci USA 1955;41:849-857. (precursor framing to clonal selection; primary-author/era)"

@X x_beutler_nobel_2011 := "Beutler B — 2011 Nobel" :: literature [active]
  ref = "Beutler B. Nobel Prize in Physiology or Medicine 2011 (shared with Hoffmann and Steinman), for discoveries concerning the activation of innate immunity — including identification of TLR4 as the LPS / endotoxin sensor. Underlying primary work: Poltorak A et al. Defective LPS signaling in C3H/HeJ and C57BL/10ScCr mice: mutations in Tlr4 gene. Science 1998;282:2085-2088. (primary-author/era — exact citations summarised)"

@X x_steinman_nobel_2011 := "Steinman RM — 2011 Nobel" :: literature [active]
  ref = "Steinman RM. Nobel Prize in Physiology or Medicine 2011 (shared with Beutler and Hoffmann; awarded posthumously) for the discovery of the dendritic cell and its role in adaptive immunity. Underlying primary work: Steinman RM, Cohn ZA. Identification of a novel cell type in peripheral lymphoid organs of mice. J Exp Med 1973;137:1142-1162. (primary-author/era)"

@X x_tonegawa_nobel_1987 := "Tonegawa S — 1987 Nobel" :: literature [active]
  ref = "Tonegawa S. Nobel Prize in Physiology or Medicine 1987 for the genetic principle for generation of antibody diversity. Key primary work: Hozumi N, Tonegawa S. Evidence for somatic rearrangement of immunoglobulin genes coding for variable and constant regions. Proc Natl Acad Sci USA 1976;73:3628-3632. (primary-author/era)"

@X x_doherty_zinkernagel_nobel_1996 := "Doherty PC, Zinkernagel RM — 1996 Nobel" :: literature [active]
  ref = "Doherty PC, Zinkernagel RM. Nobel Prize in Physiology or Medicine 1996 for discoveries concerning the specificity of cell-mediated immune defence — i.e. MHC restriction. Key primary work: Zinkernagel RM, Doherty PC. Restriction of in vitro T cell-mediated cytotoxicity in lymphocytic choriomeningitis within a syngeneic or semiallogeneic system. Nature 1974;248:701-702. (primary-author/era)"

@X x_mak_davis_tcr_1984_era := "Mak / Davis TCR identification 1984" :: literature [active]
  ref = "Yanagi Y, Yoshikai Y, Leggett K, Clark SP, Aleksander I, Mak TW. A human T cell-specific cDNA clone encodes a protein having extensive homology to immunoglobulin chains. Nature 1984;308:145-149. AND Hedrick SM, Cohen DI, Nielsen EA, Davis MM. Isolation of cDNA clones encoding T cell-specific membrane-associated proteins. Nature 1984;308:149-153. (parallel Mak and Davis identification of the T-cell receptor; primary-author/era)"

@X x_allison_honjo_nobel_2018 := "Allison JP, Honjo T — 2018 Nobel" :: literature [active]
  ref = "Allison JP, Honjo T. Nobel Prize in Physiology or Medicine 2018 for the discovery of cancer therapy by inhibition of negative immune regulation. Key primary work: Leach DR, Krummel MF, Allison JP. Enhancement of antitumor immunity by CTLA-4 blockade. Science 1996;271:1734-1736; Ishida Y, Agata Y, Shibahara K, Honjo T. Induced expression of PD-1, a novel member of the immunoglobulin gene superfamily, upon programmed cell death. EMBO J 1992;11:3887-3895. (primary-author/era)"

@X x_hodi_2010 := "Hodi FS et al 2010" :: literature [active]
  ref = "Hodi FS et al. Improved survival with ipilimumab in patients with metastatic melanoma. N Engl J Med 2010;363:711-723. (first OS benefit for immune checkpoint blockade; cross-link CANCER-THERAPY.tape x_hodi_2010)"

@X x_le_2015 := "Le DT et al 2015" :: literature [active]
  ref = "Le DT et al. PD-1 blockade in tumors with mismatch-repair deficiency. N Engl J Med 2015;372:2509-2520. (MSI-high / dMMR predicts checkpoint response — tissue-agnostic biomarker)"

@X x_slamon_2001 := "Slamon DJ et al 2001" :: literature [active]
  ref = "Slamon DJ et al. Use of chemotherapy plus a monoclonal antibody against HER2 for metastatic breast cancer that overexpresses HER2. N Engl J Med 2001;344:783-792. (trastuzumab; cross-link CANCER-THERAPY.tape x_slamon_2001)"

@X x_anderson_aire_2002_era := "Anderson MS et al — AIRE 2002 era" :: literature [active]
  ref = "Anderson MS, Venanzi ES, Klein L, Chen Z, Berzins SP, Turley SJ, von Boehmer H, Bronson R, Dierich A, Benoist C, Mathis D. Projection of an immunological self shadow within the thymus by the aire protein. Science 2002;298:1395-1401. (AIRE → promiscuous expression of tissue-restricted antigens in mTECs → central tolerance mechanism; primary-author/era)"

@X x_tschopp_nlrp3_era := "Tschopp J — NLRP3 inflammasome era" :: literature [active]
  ref = "Martinon F, Burns K, Tschopp J. The inflammasome: a molecular platform triggering activation of inflammatory caspases and processing of proIL-beta. Mol Cell 2002;10:417-426. AND subsequent Tschopp-laboratory work on NLRP3 activation (Martinon et al., Nature 2006 for urate-crystal activation in gout). (primary-author/era — inflammasome and NLRP3 mechanistic framework)"

@X x_janeway_textbook := "Janeway's Immunobiology (textbook)" :: literature [active]
  ref = "Murphy K, Weaver C (eds, founding author Janeway CA). Janeway's Immunobiology. Garland Science / Norton, multiple editions. (the standard immunology textbook; cited as primary-author/era — specific edition not asserted; mirrors VACCINE.tape citation discipline)"

@X x_cancer_therapy_sibling := "CANCER-THERAPY.tape" :: sibling-tape [active]
  scope = "Clinical-translation detail for checkpoint biology and antibody therapeutics — tx_immune_checkpoint, tx_targeted, cmp_immuno, lim_no_universal_cure. Shared sources (x_hodi_2010, x_le_2015, x_slamon_2001) cross-referenced."

@X x_vaccine_sibling := "VACCINE.tape" :: sibling-tape [active]
  scope = "Vaccine platform engineering and clinical translation — mech_humoral, mech_memory, adj_overview, sched_design, lim_pathogen_specific_failures, lim_waning. Immunology mechanism is shared substrate; vaccinology is the engineered-input layer."
