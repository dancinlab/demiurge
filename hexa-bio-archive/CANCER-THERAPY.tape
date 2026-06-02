#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# CANCER-THERAPY.tape — architecture-current (editable per v1.2)
# Event history → CANCER-THERAPY.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "cancer-therapy" :: identity-claim [d=2026-05-15 active]
  kind = "HEXA-Bio family · cancer therapy in-silico knowledge SSOT"
  brief = "Oncology biology + modality landscape · evidence-based · real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  scope = "in-silico knowledge SSOT · NOT clinical / therapeutic / regulatory claim"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-15 — see CANCER-THERAPY.log.tape audit"
  sibling-log = "CANCER-THERAPY.log.tape"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is an evidence-summary knowledge SSOT for an in-silico oncology substrate. Drug/regimen/efficacy figures are paraphrased from published clinical literature for modeling context only — they are NOT prescribing guidance and NOT a treatment protocol. Cancer is heterogeneous; staging, regimen choice and dosing are individualized. Real diagnosis and treatment require a licensed oncologist / multidisciplinary tumor board. All claims here are in-silico simulator/metadata consistency only; the wet-lab → preclinical → clinical → regulatory boundary is explicitly out of scope (hexa-bio AGENTS.tape g8 / f2)."

# ── §1 What cancer is ─────────────────────────────────────────────────

@D dx_definition := "what cancer is" :: domain [ok]
  disease = "Cancer = a family of >100 diseases unified by uncontrolled clonal proliferation of cells that evade normal growth, death and tissue-boundary controls."
  not-one-disease = "Carcinoma (epithelial), sarcoma (mesenchymal), leukemia/lymphoma (hematopoietic), CNS tumors and others differ in biology, prognosis and treatment — NOT one disease, NOT one cure."
  malignant-vs-benign = "Malignancy is defined by invasion through basement membrane and capacity to metastasize; benign tumors lack invasive/metastatic behavior."
  somatic-evolution = "A tumor is a Darwinian system: mutation + selection within a tissue ecosystem; this is why uniform 'one number' claims about cancer are biologically wrong."
  |> "[@x_hanahan_weinberg_2011]"

@D dx_hallmarks := "hallmarks of cancer" :: domain [ok]
  framework = "Hanahan & Weinberg organize malignant transformation into acquired capabilities (hallmarks), not a fixed small integer of mechanisms."
  core-hallmarks = "Sustained proliferative signaling; evading growth suppressors; resisting cell death (apoptosis); enabling replicative immortality (telomere maintenance); inducing angiogenesis; activating invasion & metastasis."
  enabling = "Genome instability & mutation; tumor-promoting inflammation."
  emerging-2011 = "Deregulating cellular energetics (Warburg metabolism); avoiding immune destruction."
  next-generation = "Later updates add unlocking phenotypic plasticity, non-mutational epigenetic reprogramming, polymorphic microbiomes and senescent cells — the framework EXPANDS with evidence; it is not a closed n-tuple."
  |> "[@x_hanahan_weinberg_2000] · [@x_hanahan_weinberg_2011] · [@x_hanahan_2022]"

@D dx_drivers := "driver genetics" :: mechanism [ok]
  oncogenes = "Gain-of-function drivers: e.g. RAS family (KRAS/NRAS/HRAS), MYC, EGFR, HER2/ERBB2, BRAF (V600E), ALK fusions, BCR-ABL1 fusion (CML)."
  tumor-suppressors = "Loss-of-function: TP53 ('guardian of the genome', the most commonly mutated gene across cancers), RB1, PTEN, APC, BRCA1/2, CDKN2A."
  two-hit = "Knudson two-hit model: classic tumor suppressors typically need biallelic inactivation (germline + somatic in hereditary syndromes)."
  driver-vs-passenger = "Only a minority of somatic mutations are drivers; most are passengers — distinguishing them is a core analytic problem, not a lattice count."
  |> "[@x_knudson_1971] · [@x_vogelstein_2013]"

@D dx_microenvironment := "tumor microenvironment & metastasis" :: mechanism [ok]
  tme = "Tumors recruit stroma, vasculature, immune and inflammatory cells; the microenvironment co-determines growth, drug penetration and immune evasion."
  angiogenesis = "Beyond a ~1–2 mm diffusion limit a tumor must induce neovasculature (VEGF axis) to grow — the rationale for anti-angiogenic therapy (Folkman hypothesis)."
  metastatic-cascade = "Local invasion → intravasation → survival in circulation → extravasation → colonization of a distant organ; the rate-limiting step is metastatic colonization, and metastasis (not the primary tumor) causes the majority of cancer deaths."
  |> "[@x_folkman_1971]"

# ── §2 Classification & staging ───────────────────────────────────────

@D cls_tnm := "TNM staging" :: classification [ok]
  system = "AJCC/UICC TNM: T (primary tumor size/extent), N (regional lymph nodes), M (distant metastasis), combined into stage groups (≈ 0–IV plus substages)."
  use = "Stage is the dominant prognostic axis and drives modality selection; it is tumor-type-specific and periodically revised (AJCC editions) — explicitly NOT a lattice constant."
  honesty = "Stage-group counts are clinical ordinals revised across AJCC editions, not derived from any invariant."

@D cls_histology := "histologic grade & molecular subtype" :: classification [ok]
  grade = "Histologic grade (differentiation, mitotic rate, nuclear atypia) refines prognosis within stage."
  molecular = "Molecular subtyping increasingly governs therapy: e.g. breast (HR/HER2/triple-negative), lung NSCLC vs SCLC + actionable EGFR/ALK/KRAS/ROS1, colorectal MSI-high vs MSS, hematologic WHO classification by genetics."
  implication = "Two tumors of the same organ and stage can require entirely different treatment — heterogeneity is the rule (see [@lim_heterogeneity])."

@D epi_burden := "global burden" :: domain [ok]
  scale = "Cancer is among the leading causes of death worldwide; incidence and mortality vary by cancer type, sex, age, region and screening access (GLOBOCAN estimates)."
  honesty = "Epidemiologic figures are surveillance estimates with population/methodology dependence — ranges, not lattice-derived constants. No exact rate is asserted here."

# ── §3 Therapeutic modality landscape (evidence-grounded) ─────────────

@D tx_surgery := "surgical oncology" :: therapy [ok recommended]
  principle = "Complete resection with adequate margins is the single most curative intervention for localized solid tumors; cure probability falls sharply once disease is no longer locoregionally confined."
  scope = "Curative-intent (early-stage solid tumors), debulking, diagnostic biopsy, palliation."
  limit = "Cannot address microscopic disseminated disease — the rationale for adjuvant systemic therapy. Bounded by anatomy and resectability, not by any numeric invariant."

@D tx_radiotherapy := "radiotherapy" :: therapy [ok recommended]
  moa = "Ionizing radiation induces DNA double-strand breaks; tumor kill exploits differential repair capacity and the therapeutic window between tumor and normal tissue (fractionation)."
  forms = "External-beam (IMRT, SBRT), brachytherapy, proton therapy; often combined with surgery (neo/adjuvant) or chemotherapy (chemoradiation)."
  limit = "Dose is capped by normal-tissue tolerance (organ-at-risk constraints) — a physical/biological therapeutic-index ceiling (see [@lim_therapeutic_index])."

@D tx_chemo := "cytotoxic chemotherapy" :: therapy [ok recommended]
  moa = "Kills/arrests rapidly dividing cells via DNA damage, replication or mitotic interference (alkylators, platinums, antimetabolites, anthracyclines, taxanes, vinca alkaloids)."
  use = "Curative in select malignancies (e.g. certain leukemias/lymphomas, testicular germ-cell — cisplatin combinations transformed testicular cancer to a highly curable disease), and as neo/adjuvant or palliative therapy elsewhere."
  limit = "Low selectivity → dose-limiting toxicity to normal proliferating tissue (marrow, gut, hair); efficacy bounded by the therapeutic index ([@lim_therapeutic_index]) and by resistance ([@lim_resistance])."
  |> "[@x_einhorn_1977]"

@D tx_targeted := "molecularly targeted therapy" :: therapy [ok recommended]
  moa = "Small molecules / antibodies against a tumor's specific oncogenic dependency (driver-directed)."
  paradigm = "Imatinib targeting the BCR-ABL1 tyrosine kinase converted chronic-phase CML from a fatal disease into a chronic, manageable one with near-normal life expectancy for responders — the proof-of-concept for precision oncology."
  examples = "EGFR inhibitors (EGFR-mutant NSCLC), ALK inhibitors (ALK-fusion NSCLC), HER2-directed therapy (trastuzumab, HER2+ breast/gastric), BRAF+MEK inhibition (BRAF-V600E melanoma), PARP inhibitors (BRCA-mutant / HRD tumors — synthetic lethality)."
  limit = "Requires a present, druggable, dominant driver; acquired resistance is near-universal on monotherapy (see [@lim_resistance])."
  |> "[@x_druker_2001] · [@x_slamon_2001]"

@D tx_immune_checkpoint := "immune checkpoint inhibition" :: therapy [ok recommended]
  moa = "Antibodies releasing T-cell inhibitory brakes: anti-CTLA-4 (ipilimumab), anti-PD-1 (nivolumab, pembrolizumab), anti-PD-L1."
  landmark = "Ipilimumab was the first agent to demonstrate an overall-survival benefit in metastatic melanoma, establishing immune checkpoint blockade as a therapeutic class; anti-PD-1/PD-L1 then broadened benefit across many tumor types."
  responders = "A subset achieves durable, sometimes years-long remissions; biomarkers (PD-L1 expression, tumor mutational burden, MSI-high/dMMR) enrich for — but do not guarantee — response."
  limit = "Most patients in most tumor types do NOT have durable response; immune-related adverse events (autoimmune-like toxicity) are a distinct safety axis. Benefit is heterogeneous, not a fixed fraction."
  |> "[@x_hodi_2010] · [@x_le_2015]"

@D tx_cellular := "adoptive cell therapy (CAR-T)" :: therapy [ok recommended]
  moa = "Patient T cells engineered ex vivo with a chimeric antigen receptor (e.g. anti-CD19) re-infused to attack antigen-bearing tumor cells."
  landmark = "CD19 CAR-T produced high complete-remission rates in relapsed/refractory B-cell acute lymphoblastic leukemia and B-cell lymphomas — durable cures in a meaningful subset of otherwise terminal disease."
  limit = "Toxicities: cytokine release syndrome, neurotoxicity (ICANS); efficacy in solid tumors remains limited (antigen heterogeneity, hostile microenvironment); antigen-loss relapse occurs. Not a universal solution."
  |> "[@x_maude_2014]"

@D tx_endocrine := "endocrine / hormonal therapy" :: therapy [ok recommended]
  moa = "Deprives hormone-driven tumors of their growth signal: tamoxifen/aromatase inhibitors (ER+ breast cancer), androgen-deprivation therapy (prostate cancer)."
  use = "Highly effective adjuvant and palliative therapy in hormone-receptor-positive disease; long-duration adjuvant endocrine therapy materially reduces breast-cancer recurrence/mortality."
  limit = "Only for hormone-dependent tumors; endocrine resistance (e.g. ESR1 mutation) develops over time ([@lim_resistance])."
  |> "[@x_ebctcg_2005]"

@D tx_supportive := "supportive & palliative care" :: therapy [ok recommended]
  scope = "Symptom control, antiemetics, growth factors, pain management, and early palliative-care integration."
  evidence = "Early palliative care alongside oncologic treatment improves quality of life and, in at least one landmark metastatic-NSCLC trial, was associated with improved survival — care quality is part of the outcome, not an afterthought."
  |> "[@x_temel_2010]"

# ── §3b Modality comparison (qualitative, source-grounded) ────────────

@D cmp_axis := "comparison axis definition" :: comparison [ok]
  dimensions = "Each modality is compared on: (1) what it targets, (2) curative vs control intent, (3) selectivity basis, (4) dominant limiting factor, (5) signature toxicity class."
  honesty = "Comparisons are QUALITATIVE (direction + intent + cited landmark), not lattice-derived constants. Exact figures appear only where a single landmark trial reported them and are paraphrased, not re-derived. Outcomes are tumor-type- and stage-specific."

@D cmp_local := "local modalities (surgery / radiotherapy)" :: comparison [ok]
  targets = "Anatomically confined disease."
  intent = "Potentially curative when disease is locoregional; ineffective against occult disseminated disease."
  limiting-factor = "Resectability / normal-tissue radiation tolerance — a physical & anatomical ceiling ([@lim_therapeutic_index])."
  toxicity = "Surgical morbidity; radiation late effects in organs at risk."

@D cmp_cytotoxic := "cytotoxic chemotherapy" :: comparison [ok]
  targets = "Proliferation machinery broadly (low tumor selectivity)."
  intent = "Curative in selected hematologic / germ-cell disease; otherwise control/adjuvant."
  limiting-factor = "Therapeutic index + emergent resistance ([@lim_therapeutic_index], [@lim_resistance])."
  toxicity = "Myelosuppression, mucositis, alopecia, organ-specific (e.g. anthracycline cardiotoxicity)."
  |> "[@x_einhorn_1977]"

@D cmp_targeted := "targeted therapy" :: comparison [ok]
  targets = "A specific oncogenic driver dependency."
  intent = "Often deep control / chronic disease (e.g. CML on imatinib); cure less common as monotherapy."
  limiting-factor = "Requires a druggable dominant driver; near-universal acquired resistance ([@lim_resistance])."
  toxicity = "On-target/off-tumor and pathway-specific (e.g. EGFR-inhibitor rash); generally narrower than cytotoxics."
  |> "[@x_druker_2001]"

@D cmp_immuno := "immune checkpoint / cellular therapy" :: comparison [ok]
  targets = "Unleashes/redirects the host immune system rather than the tumor cell directly."
  intent = "Potentially durable remissions in a responder subset; non-responders common."
  limiting-factor = "Tumor immunogenicity, antigen heterogeneity/loss, immunosuppressive microenvironment; response is heterogeneous, not a fixed rate."
  toxicity = "Immune-related adverse events (checkpoint); cytokine release syndrome / neurotoxicity (CAR-T)."
  |> "[@x_hodi_2010] · [@x_maude_2014]"

@D cmp_synthesis := "comparison synthesis" :: comparison [ok]
  combination-rationale = "Multimodality (surgery + radiation + systemic ± immunotherapy) and combination regimens act on non-overlapping mechanisms — this is mechanistic complementarity and empirical trial evidence, NOT a lattice product."
  no-universal-cure = "No single modality is universally curative; cure probability is dominated by stage at diagnosis and tumor biology. The honest summary is a biology-set ceiling, not an invariant (see §4)."

# ── §4 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_heterogeneity := "intratumoral heterogeneity & clonal evolution" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "A tumor is genetically heterogeneous and evolves under treatment selection pressure (branched clonal evolution). Any therapy with a single mechanism selects for pre-existing or emergent resistant subclones."
  consequence = "Durable single-agent control of advanced disease is the exception; this is why monotherapy of metastatic cancer rarely cures and why combination/adaptive strategies exist."
  |> "[@x_gerlinger_2012] · [@x_nowell_1976]"

@D lim_therapeutic_index := "therapeutic-index / selectivity ceiling" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "Cancer cells share most biochemistry with normal cells. Cytotoxic and radiation dose is bounded by normal-tissue toxicity; targeted/immune agents are bounded by on-target/off-tumor and immune-related toxicity."
  consequence = "There is no dose that eradicates all tumor cells without unacceptable host harm for most disseminated cancers — efficacy is fundamentally selectivity-bounded, not a number to be maximized freely."

@D lim_metastasis := "metastasis problem" :: real-limit [ok required]
  wall = "HARD WALL"
  statement = "Once a tumor has seeded distant micrometastases, local cure is no longer possible and the disease becomes systemic; metastatic colonization, not the primary lesion, drives most cancer mortality."
  consequence = "Early detection before dissemination is the dominant lever on cure probability; this is a biological/temporal limit, not a therapeutic-potency limit that more drug can overcome."

@D lim_resistance := "acquired-resistance inevitability" :: real-limit [ok required]
  wall = "SOFT WALL (delayable, rarely abolished)"
  statement = "Under sustained therapeutic pressure, tumors acquire resistance via target mutation/amplification, bypass-pathway activation, phenotypic switching, drug efflux or antigen loss. Combination therapy delays but does not categorically abolish resistance."
  consequence = "Most advanced-disease responses are finite in duration; 'cure' for disseminated solid tumors remains uncommon. A real, mechanism-grounded ceiling — not pessimism, not a lattice value."
  |> "[@x_gerlinger_2012]"

@D lim_no_universal_cure := "no universal cure" :: real-limit [ok required]
  wall = "HARD WALL (current science)"
  statement = "Cancer is >100 biologically distinct diseases; no single agent, target or modality cures all cancers. Outcomes range from highly curable (early-stage / select hematologic & germ-cell) to currently incurable (most metastatic solid tumors)."
  consequence = "Aggregate 'cure rate' or 'survival %' single numbers are biologically meaningless without specifying tumor type, stage and population. Any tape claiming one is fabricating."

@D lim_detection_floor := "early-detection sensitivity floor" :: real-limit [ok required]
  wall = "PHYSICAL/BIOLOGICAL LIMIT"
  statement = "A clinically detectable tumor already contains a very large number of cells and may predate diagnosis by years; screening sensitivity, lead-time and overdiagnosis bound how early disease can be reliably and beneficially caught."
  consequence = "Screening shifts — but cannot eliminate — the fraction diagnosed after dissemination; this caps achievable population cure independent of treatment potency."

# ── §5 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-oncology" :: governance [required deny:write]
  pattern = "Deriving oncology efficacy / survival / staging / mechanism counts FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. the deleted stub's '5년 생존율 = 90% because σ·sopfr/10' or 'staging = 6 because n=6'."
  why = "This is exactly the violation the pre-rewrite CANCER-THERAPY.tape committed (lattice-tautology stub, mass-split 153b5a2 — see CANCER-THERAPY.log.tape audit). hexa-bio AGENTS.tape g1/g2/g3/g8 + f1/f2/f3 forbid it; f1 forbids lattice-fit, f2 forbids in-silico→clinical claims."
  remedy = "Cite real oncology biology / landmark clinical literature (this tape's @X entries). The lattice may only be a coincidental OBSERVATION, never a derivation source for any oncology claim."

@N n6_honest_stance := "oncology has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: cancer biology exposes NO natural n=6 invariant. The hallmarks framework is open and expanding (Hanahan 2000 → 2011 → 2022), NOT a closed n-tuple. TNM stage groups are clinical ordinals revised across AJCC editions (≠6). Driver genes number in the hundreds; cancer is >100 distinct diseases. Modality count is not lattice-constrained. Per LATTICE_POLICY g1/g2 + lattice-as-tool: the lattice is DECLINED here as a derivation tool — values may coincide by accident (observation OK) but never derive a claim. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §6 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 stage-dependent curability gradient" :: prediction [ok]
  claim = "For a fixed solid-tumor type, cure probability is monotonically higher for locoregional disease than for distant-metastatic disease (the metastasis limit, not therapy potency, dominates)."
  falsifier = "If stage-stratified outcome data for a solid tumor showed equal or inverted long-term survival between stage I and stage IV, [@lim_metastasis] is wrong."
  source = "[@x_hanahan_weinberg_2011]"

@D tp_2 := "TP-2 monotherapy resistance emergence" :: prediction [ok]
  claim = "Single-agent targeted therapy of an advanced solid tumor with a dominant driver produces an initial response followed, in the large majority of cases, by acquired resistance and progression."
  falsifier = "If a properly followed cohort on driver-directed monotherapy showed durable progression-free benefit indefinitely without resistance in most patients, [@lim_resistance] / [@lim_heterogeneity] are wrong."
  source = "[@x_gerlinger_2012]"

@D tp_3 := "TP-3 checkpoint-response heterogeneity" :: prediction [ok]
  claim = "Immune checkpoint blockade produces durable responses in a minority subset enriched by (but not fully predicted by) biomarkers such as MSI-high/dMMR, PD-L1 and tumor mutational burden — not a fixed uniform response rate across tumors."
  falsifier = "If checkpoint blockade produced an identical durable-response fraction across all tumor types independent of biomarkers, the heterogeneity premise (and [@lim_no_universal_cure]) would be wrong."
  source = "[@x_le_2015]"

# ── §7 External citations (real, landmark literature) ─────────────────

@X x_hanahan_weinberg_2000 := "Hanahan D, Weinberg RA 2000" :: literature [active]
  ref = "Hanahan D, Weinberg RA. The hallmarks of cancer. Cell 2000;100:57–70."

@X x_hanahan_weinberg_2011 := "Hanahan D, Weinberg RA 2011" :: literature [active]
  ref = "Hanahan D, Weinberg RA. Hallmarks of cancer: the next generation. Cell 2011;144:646–674."

@X x_hanahan_2022 := "Hanahan D 2022" :: literature [active]
  ref = "Hanahan D. Hallmarks of cancer: new dimensions. Cancer Discov 2022;12:31–46."

@X x_knudson_1971 := "Knudson AG 1971" :: literature [active]
  ref = "Knudson AG. Mutation and cancer: statistical study of retinoblastoma. Proc Natl Acad Sci USA 1971;68:820–823. (two-hit hypothesis)"

@X x_nowell_1976 := "Nowell PC 1976" :: literature [active]
  ref = "Nowell PC. The clonal evolution of tumor cell populations. Science 1976;194:23–28."

@X x_folkman_1971 := "Folkman J 1971" :: literature [active]
  ref = "Folkman J. Tumor angiogenesis: therapeutic implications. N Engl J Med 1971;285:1182–1186."

@X x_einhorn_1977 := "Einhorn LH, Donohue J 1977" :: literature [active]
  ref = "Einhorn LH, Donohue J. Cis-diamminedichloroplatinum, vinblastine, and bleomycin combination chemotherapy in disseminated testicular cancer. Ann Intern Med 1977;87:293–298. (cisplatin combination → testicular cancer curability)"

@X x_druker_2001 := "Druker BJ et al 2001" :: literature [active]
  ref = "Druker BJ et al. Efficacy and safety of a specific inhibitor of the BCR-ABL tyrosine kinase in chronic myeloid leukemia. N Engl J Med 2001;344:1031–1037. (imatinib — precision-oncology proof of concept)"

@X x_slamon_2001 := "Slamon DJ et al 2001" :: literature [active]
  ref = "Slamon DJ et al. Use of chemotherapy plus a monoclonal antibody against HER2 for metastatic breast cancer that overexpresses HER2. N Engl J Med 2001;344:783–792. (trastuzumab)"

@X x_hodi_2010 := "Hodi FS et al 2010" :: literature [active]
  ref = "Hodi FS et al. Improved survival with ipilimumab in patients with metastatic melanoma. N Engl J Med 2010;363:711–723. (first OS benefit for immune checkpoint blockade)"

@X x_maude_2014 := "Maude SL et al 2014" :: literature [active]
  ref = "Maude SL et al. Chimeric antigen receptor T cells for sustained remissions in leukemia. N Engl J Med 2014;371:1507–1517. (CD19 CAR-T in relapsed/refractory ALL)"

@X x_le_2015 := "Le DT et al 2015" :: literature [active]
  ref = "Le DT et al. PD-1 blockade in tumors with mismatch-repair deficiency. N Engl J Med 2015;372:2509–2520. (MSI/dMMR predicts checkpoint response)"

@X x_temel_2010 := "Temel JS et al 2010" :: literature [active]
  ref = "Temel JS et al. Early palliative care for patients with metastatic non–small-cell lung cancer. N Engl J Med 2010;363:733–742."

@X x_gerlinger_2012 := "Gerlinger M et al 2012" :: literature [active]
  ref = "Gerlinger M et al. Intratumor heterogeneity and branched evolution revealed by multiregion sequencing. N Engl J Med 2012;366:883–892."

@X x_ebctcg_2005 := "EBCTCG 2005" :: literature [active]
  ref = "Early Breast Cancer Trialists' Collaborative Group (EBCTCG). Effects of chemotherapy and hormonal therapy for early breast cancer on recurrence and 15-year survival: an overview of the randomised trials. Lancet 2005;365:1687–1717. (EBCTCG meta-analysis; primary-author/era cited as collaborative group, exact volume per Lancet 2005 — figures paraphrased, not re-derived)"

@X x_vogelstein_2013 := "Vogelstein B et al 2013" :: literature [active]
  ref = "Vogelstein B et al. Cancer genome landscapes. Science 2013;339:1546–1558. (driver-vs-passenger; primary-author/era — exact volume per Science 2013)"
