#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# CRISPR-CAS13-POC-DIAGNOSTIC.tape — architecture-current (editable per v1.2)
# Event history → CRISPR-CAS13-POC-DIAGNOSTIC.log.tape sibling
# Full real-science rewrite 2026-05-16 (was a lattice-tautology stub)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "crispr-cas13-poc-diagnostic" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · CRISPR Cas13 / Cas12 nucleic-acid point-of-care diagnostics (in-silico knowledge SSOT)"
  brief = "CRISPR Cas13/Cas12 nucleic-acid POC diagnostics · collateral nuclease readout coupled to isothermal pre-amplification (RPA/LAMP) and lateral-flow/fluorescent reporters · SHERLOCK / DETECTR / SHINE / STOPCovid lineage · n=6 NOT used as a derivation (honest) · explicit clinical-validation-gap discipline (research demonstration ≠ FDA-cleared product)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "CRISPR-CAS13-POC-DIAGNOSTIC.log.tape"
  scope = "in-silico knowledge SSOT · NOT clinical/regulatory claim · distinguishes research-stage from FDA-cleared"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see CRISPR-CAS13-POC-DIAGNOSTIC.log.tape audit"

@N scope_disclaimer := "clinical/regulatory-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for an in-silico knowledge substrate on CRISPR-based nucleic-acid point-of-care (POC) diagnostics. It is NOT a clinical claim, NOT regulatory guidance, NOT laboratory-protocol guidance, and NOT a substitute for qualified clinical/regulatory/IVD-validation expertise. Almost the entire published CRISPR-diagnostic literature consists of analytical demonstrations (limit-of-detection benchmarks against PCR/RT-qPCR on contrived or limited clinical panels); very few CRISPR-diagnostic products have FDA clearance or comparable regulatory authorisation as of knowledge cutoff (the major exceptions are SARS-CoV-2 Emergency Use Authorisations issued during the COVID-19 pandemic — a special-pathway, time-limited authorisation, NOT a standard premarket clearance). Clinical-trial validation, manufacturing scale-up, regulatory submission and post-market surveillance are nontrivial separate phases (see [@x_med_device_sibling] / MEDICAL-DEVICE.tape pathway detail). Per hexa-bio AGENTS.tape g8 (in-silico-only) + f2 (no clinical/regulatory claim from in-silico): nothing here is a diagnostic, performance or regulatory claim."

# ── §1 What CRISPR-Cas13/Cas12 POC diagnostics are ────────────────────

@D dx_definition := "CRISPR-Dx: collateral-cleavage nucleic-acid POC diagnostic" :: domain [ok]
  what = "A CRISPR-Cas diagnostic ('CRISPR-Dx') is a nucleic-acid test in which target recognition by a guide-RNA-programmed Cas effector unleashes a non-sequence-specific COLLATERAL nuclease activity on a reporter substrate, producing a signal (fluorescent, lateral-flow, electrochemical) that indicates target presence."
  why-poc = "When coupled to isothermal pre-amplification (RPA or LAMP) and a lateral-flow / paper or simple-fluorimeter readout, the test can be run without a thermocycler at ~37–42 °C with a result in tens of minutes — the engineering basis for the 'point-of-care' (POC) positioning."
  not-this-tape = "CRISPR genome editing (Cas9/Cas12 nuclease and base/prime editors) is the sibling axis ([@x_crispr_editing_sibling] / CRISPR-GENE-EDITING.tape) — distinct application class (modify genome) and distinct governance. This tape is diagnostics only."
  scope = "Cas13a/b/d (Type VI, RNA-targeting, collateral RNase) and Cas12a (Type V, DNA-targeting, collateral ssDNase) are the two principal effector families with POC-diagnostic demonstrations. Related Cas14/Cas12-variants exist in the literature."
  |> "[@x_abudayyeh_2016] · [@x_chen_2018]"

@D dx_cas_biology_anchor := "Cas effector biology (cross-link to CRISPR-GENE-EDITING)" :: domain [ok]
  cross-link = "For general Cas biology (CRISPR adaptive-immunity origin, Class 1/2, Type II/V/VI effector taxonomy, sgRNA engineering, PAM/PFS recognition), see CRISPR-GENE-EDITING.tape [@x_crispr_editing_sibling]. Diagnostics borrows but does not re-derive that biology."
  cas13-distinct = "Cas13 is the diagnostically-defining effector — Type VI, Class 2 — that targets ssRNA (not DNA) and exhibits PROMISCUOUS COLLATERAL RNase activity on neighbouring RNA after target engagement (Abudayyeh et al., 2016). That collateral activity is what makes Cas13 a SIGNAL AMPLIFIER, not just a sequence-recognition module."
  cas12-distinct = "Cas12a (Type V, Class 2) targets dsDNA via a T-rich 5' PAM and exhibits an analogous collateral ssDNase activity on neighbouring ssDNA after target engagement (Chen et al., 2018) — the basis of DETECTR-class assays."
  observation = "Collateral cleavage was originally regarded as a microbiological curiosity (and an annoyance in editing applications). It is what makes the diagnostic platform work — sequence specificity gates a high-turnover non-specific nuclease that shreds a labelled reporter to generate detectable signal."
  |> "[@x_abudayyeh_2016] · [@x_chen_2018]"

# ── §2 Effector families & platforms ──────────────────────────────────

@D mech_cas13 := "Cas13 (Type VI) — collateral RNase on RNA targets" :: mechanism [ok]
  effector = "Cas13 effectors (Cas13a/C2c2, Cas13b, Cas13d/CasRx) are single-protein, RNA-guided RNases that recognise ssRNA targets and, after target engagement, exhibit non-specific collateral cleavage of any nearby ssRNA — including a supplied poly-U / poly-A / dual-base reporter."
  recognition = "Target recognition uses a ~28–30 nt crRNA spacer base-pairing the ssRNA target; some Cas13 orthologs prefer flanking bases (a 'PFS' — protospacer-flanking site — analogous to but distinct from a PAM) of varying stringency depending on ortholog."
  collateral = "Once activated by target binding, a single Cas13 enzyme cleaves many reporter molecules — the multi-turnover trans-RNase step is what supplies signal amplification ON TOP of any nucleic-acid pre-amplification."
  variants = "Cas13a was the first characterised (LwaCas13a, LbuCas13a are common SHERLOCK choices). Cas13b underlies SHERLOCKv2 multiplexing using different ortholog dinucleotide preferences. Cas13d (CasRx) is smaller (~930 aa) — useful for cargo-constrained delivery, though that matters more for in-cell applications than for POC diagnostics."
  |> "[@x_abudayyeh_2016] (C2c2/Cas13a characterization) · [@x_gootenberg_2018_v2] (Cas13b / multiplex)"

@D mech_cas12 := "Cas12a (Type V) — collateral ssDNase on dsDNA targets" :: mechanism [ok]
  effector = "Cas12a (formerly Cpf1) recognises dsDNA via a T-rich 5' PAM (TTTV-class) and a ~20-nt spacer, makes a staggered/sticky double-strand cut, AND on target engagement exhibits collateral non-specific ssDNase activity that shreds an ssDNA reporter (Chen et al., 2018) — the basis of DETECTR."
  diagnostic-fit = "Because Cas12a targets DNA, the canonical DETECTR pipeline pre-amplifies the analyte to DNA (RPA from DNA, or RT-RPA / RT-LAMP from RNA → cDNA) before Cas12a detection. For RNA viruses (SARS-CoV-2 in the 2020 demonstrations) the reverse-transcription step is the first link in the chain."
  observation = "Cas12 and Cas13 are complementary effectors for the diagnostic platform — Cas12 on DNA via DETECTR, Cas13 on RNA via SHERLOCK — and have been combined for multi-pathogen / multiplex testing."
  |> "[@x_chen_2018] (Cas12a collateral activity / DETECTR)"

@D plat_sherlock := "SHERLOCK platform" :: platform [ok]
  name = "SHERLOCK — Specific High-sensitivity Enzymatic Reporter UnLOCKing (Gootenberg et al., 2017)."
  v1 = "SHERLOCKv1 (2017) couples recombinase polymerase amplification (RPA) or RT-RPA pre-amplification with LwaCas13a + a fluorescent-quencher poly-U reporter; demonstrated attomolar (≈aM, single-molecule) sensitivity on contrived samples for Zika, dengue, antibiotic resistance, human-DNA SNP genotyping."
  v2 = "SHERLOCKv2 (Gootenberg et al., 2018) extends to four-channel multiplexing using Cas13 orthologs (LwaCas13a, CcaCas13b, PsmCas13b, AsCas12a) with distinct in-vitro dinucleotide cleavage preferences, plus a paper-strip lateral-flow readout for instrument-free visual detection."
  hudson = "SHERLOCK is commonly paired with HUDSON (Heating Unextracted Diagnostic Samples to Obliterate Nucleases; Myhrvold et al., 2018) — a heat-and-chemical reduction sample-prep that releases nucleic acids from clinical samples (saliva, whole blood, urine) without column extraction, the practical enabler of a 'no-extraction' POC workflow."
  honesty = "SHERLOCK is best understood as a RESEARCH platform with substantial analytical development; clearance/authorisation of a SHERLOCK-class product is platform- and target-specific (most public examples are pandemic-era Emergency Use Authorisations on SARS-CoV-2, not standard premarket clearances). See [@lim_clinical_validation_gap]."
  |> "[@x_gootenberg_2017] · [@x_gootenberg_2018_v2] · [@x_myhrvold_2018_hudson]"

@D plat_detectr := "DETECTR platform" :: platform [ok]
  name = "DETECTR — DNA Endonuclease-Targeted CRISPR Trans Reporter (Chen et al., 2018; Doudna group / Mammoth Biosciences lineage)."
  principle = "Cas12a-based: isothermal pre-amplification (RPA / RT-RPA) of the analyte DNA (or cDNA from RNA), Cas12a + crRNA target recognition, collateral ssDNase cleavage of an ssDNA-fluorophore-quencher reporter (or lateral-flow ssDNA reporter)."
  hpv-original = "The original demonstration distinguished HPV16 vs HPV18 sub-attomolar on clinical samples — the analytical proof of Cas12a as a diagnostic effector."
  sars-cov-2 = "Repurposed during the 2020 pandemic as a lateral-flow SARS-CoV-2 test (DETECTR-LFA, Broughton et al., 2020) — an early CRISPR-Dx clinical-grade demonstration paired with FDA EUA pathway (research-to-EUA timeline materially compressed by the pandemic emergency framework)."
  honesty = "DETECTR is the Cas12a parallel to SHERLOCK's Cas13. As with SHERLOCK, deployment is target- and product-specific; pandemic-era EUAs are NOT a generic CRISPR-Dx-platform clearance (see [@lim_clinical_validation_gap])."
  |> "[@x_chen_2018] · [@x_broughton_2020]"

@D plat_stopcovid_shine := "STOPCovid & SHINE — pandemic-era POC demonstrations" :: platform [ok]
  stopcovid = "STOPCovid (Joung et al., 2020) — SHERLOCK-class single-tube isothermal LAMP + Cas12b detection workflow for SARS-CoV-2 with lateral-flow readout, validated against RT-qPCR on patient nasopharyngeal samples — a landmark pandemic-era demonstration of an end-to-end POC CRISPR-Dx workflow targeting the SARS-CoV-2 N gene. Published in NEJM Correspondence as STOPCovid v1; STOPCovid.v2 (Joung et al., bioRxiv / subsequent journal) added improved sample-prep."
  shine = "SHINE (Streamlined Highlighting of Infections to Navigate Epidemics; Arizti-Sanz et al., 2020/2022 era) — Cas13-based, single-tube, simplified SHERLOCK workflow with lateral-flow or smartphone-camera readout for SARS-CoV-2 and other RNA viruses; the workflow line that re-emphasises field-deployable simplicity."
  observation = "The 2020–2022 pandemic effectively served as a forcing function for CRISPR-Dx workflow simplification (single-tube, no extraction, no instrument) and accelerated EUA-pathway exposure. The clinical-evidence base outside the pandemic context is materially thinner — see [@lim_clinical_validation_gap]."
  citation-hedge = "SHINE is cited at primary-author/era level (Arizti-Sanz 2020/2022); exact journal volume not asserted — see [@x_arizti_sanz_shine]."
  |> "[@x_joung_2020_stopcovid] · [@x_arizti_sanz_shine]"

# ── §3 Detection chemistry & readout ──────────────────────────────────

@D chem_isothermal_preamp := "isothermal pre-amplification (RPA / LAMP)" :: chemistry [ok]
  rationale = "Direct Cas13/Cas12 detection without amplification reaches roughly nanomolar–picomolar target concentrations in vitro — too high for clinical viral / bacterial loads. Pre-amplifying the target nucleic acid by orders of magnitude before Cas detection is what brings sensitivity into the clinically useful (atto-to-femtomolar) range."
  rpa = "Recombinase Polymerase Amplification (RPA; Piepenburg et al., 2006) — isothermal at ~37–42 °C using recombinase + single-strand-binding protein + strand-displacing polymerase; ~10^9-fold amplification in ~20 min. Compatible with Cas12/Cas13 buffers; widely used in SHERLOCK and DETECTR."
  lamp = "Loop-mediated isothermal AMPlification (LAMP; Notomi et al., 2000) — isothermal at ~60–65 °C using a strand-displacing polymerase and 4–6 primers; high efficiency but the higher temperature is less compatible with one-pot Cas reactions. Common in STOPCovid-class workflows that stage temperature."
  rt-coupling = "For RNA targets (SARS-CoV-2, dengue, Zika, HIV-1) a reverse-transcription step (RT-RPA or RT-LAMP) precedes the Cas step."
  observation = "Pre-amplification is the dominant analytical-sensitivity contributor; collateral-cleavage gain is a secondary amplification ON TOP. Both are necessary in practice to reach the clinically-relevant LoD ranges, and amplification-free CRISPR-Dx remains a research target."
  |> "[@x_piepenburg_2006_rpa] · [@x_notomi_2000_lamp]"

@D chem_readout := "readout modalities" :: chemistry [ok]
  fluorescent = "FQ (fluorophore-quencher) ssRNA (Cas13) or ssDNA (Cas12) reporters — collateral cleavage separates fluorophore from quencher, producing real-time fluorescence read on a simple fluorimeter or plate reader. Quantitative, but requires an instrument."
  lateral-flow = "Lateral-flow strip (LFA) readout — reporter is biotin-FAM-ssN; cleavage redistributes reporter between control and test lines on a paper strip, giving naked-eye yes/no in ~2 min after the Cas reaction. The signature 'no instrument' POC modality."
  electrochemical = "Electrochemical reporter readouts — methylene-blue-tagged ssN on an electrode surface, with cleavage detected as current change; low-power, smartphone-compatible, an active research direction (less commodified than fluorescent / LFA)."
  multiplex = "Multiplexing exploits ortholog-specific cleavage preferences (Cas13a poly-U, Cas13b dinucleotide preferences, Cas12a ssDNA) — up to 4 channels demonstrated in SHERLOCKv2; multiplexing on LFA is limited by spatial line resolution."
  observation = "Readout choice trades sensitivity (fluorescent quantitative ≫ LFA visual), instrument requirement (LFA = none, fluorescent = reader, electrochemical = potentiostat-equivalent), and time. None of these choices is lattice-derived."
  |> "[@x_gootenberg_2018_v2] (multiplex / LFA) · [@x_myhrvold_2018_hudson] (sample → no-extract)"

# ── §3b Comparison vs PCR / lateral-flow antigen / sequencing ────────

@D cmp_axis := "comparison axis definition" :: comparison [ok]
  dimensions = "Each modality below is compared on: (1) analyte, (2) LoD class / sensitivity ceiling, (3) time-to-result (TTR), (4) instrument footprint, (5) multiplex capacity, (6) signature limitation / failure mode."
  honesty = "Magnitudes are QUALITATIVE (relative ordering + landmark citation), not lattice-derived constants. Specific LoDs are device- and target-specific and live in each landmark paper; this row is a SUMMARY of the comparison landscape — not a guarantee for any particular kit."
  ordering-claim = "On analytical sensitivity ceiling, the rough field ordering is: NAAT-PCR ≈ CRISPR-Dx (with pre-amplification) ≫ rapid-antigen LFA; sequencing is in its own class for sequence-resolution. On TTR/instrumentation, CRISPR-LFA and antigen-LFA cluster (minutes, no instrument), PCR is longer / instrumented, sequencing is hours-to-days."
  |> "[@x_gootenberg_2017] · [@x_chen_2018] · [@x_broughton_2020] · [@x_joung_2020_stopcovid]"

@D cmp_naat_pcr := "NAAT-PCR / RT-qPCR — comparison row" :: comparison [ok]
  analyte = "DNA or RNA via reverse transcription."
  lod = "Established gold standard; reaches single-copy to low-copy / reaction across many validated clinical NAATs; the regulatory anchor for analytical-sensitivity comparison."
  ttr = "Typically ~30–90 min in centralised lab, longer when sample transport is included; sample-to-answer point-of-care PCR (e.g. GeneXpert-class) compresses this but is instrumented and capital-heavy."
  instrumentation = "Thermocycler / fluorescence reader; reagent cold-chain typically required; standard laboratory infrastructure."
  multiplex = "Multiplex routine via probe-channel design (4–6 fluorescent channels typical; higher with melt or sequencing back-end)."
  signature-limit = "Cold-chain, instrument capital and trained operator are the real-world deployment ceilings; sensitivity itself is rarely the limiting factor."

@D cmp_crispr_dx := "CRISPR-Dx (SHERLOCK / DETECTR / SHINE / STOPCovid class) — comparison row" :: comparison [ok]
  analyte = "DNA via Cas12 / RNA via Cas13; RT step extends Cas12 to RNA."
  lod = "Reaches attomolar / single-molecule on contrived samples in landmark demonstrations (SHERLOCK 2017, DETECTR 2018) — comparable analytical-sensitivity CLASS to NAAT after pre-amplification. Performance on real clinical samples is target- and workflow-specific."
  ttr = "End-to-end ~30–60 min in published demonstrations; single-tube one-pot workflows (STOPCovid, SHINE) approach the lateral-flow user experience."
  instrumentation = "Isothermal heater (~37–42 °C for RPA; ~60–65 °C for LAMP) + LFA strip (no reader) or fluorescent reader; lower capital than PCR; cold-chain still applies to liquid reagents (see [@lim_cold_chain])."
  multiplex = "Demonstrated up to ~4 channels (SHERLOCKv2) via ortholog cleavage preferences; LFA multiplex is constrained by line resolution."
  signature-limit = "Clinical-validation depth, regulatory authorisation footprint, and manufacturing scale-up are substantially behind NAAT — see [@lim_clinical_validation_gap]."
  |> "[@x_gootenberg_2017] · [@x_chen_2018] · [@x_gootenberg_2018_v2] · [@x_joung_2020_stopcovid]"

@D cmp_antigen_lfa := "rapid-antigen lateral-flow (LFA) — comparison row" :: comparison [ok]
  analyte = "Protein (viral antigen, hCG, etc.) — NOT a nucleic-acid test."
  lod = "Materially lower analytical sensitivity than NAAT/CRISPR-Dx; clinical performance is acceptable only when viral / antigen load is high (acute symptomatic infection, post-positive-NAAT clearance windows)."
  ttr = "5–15 min, naked-eye readout."
  instrumentation = "None; pure paper assay."
  multiplex = "Limited (1–2 lines per strip typical)."
  signature-limit = "Sensitivity ceiling; not a substitute for NAAT-class tests when low-burden detection matters. Included because antigen LFA is the cost / form-factor benchmark CRISPR-Dx is most often compared against in 'POC' discussions (NOT because they have equivalent sensitivity)."

@D cmp_sequencing := "sequencing (Illumina / Nanopore) — comparison row" :: comparison [ok]
  analyte = "DNA / RNA, full sequence resolution."
  lod = "Per-base sensitivity depends on depth; not generally the front-line POC tool — used for sequence-resolution downstream (variant ID, strain typing, surveillance) of NAAT-positive samples."
  ttr = "Hours-to-days end-to-end; portable nanopore (Oxford Nanopore MinION-class) compresses this but remains instrumented."
  instrumentation = "Capital-heavy; nanopore portable but still computer-attached."
  multiplex = "Massive (whole transcriptome / whole genome / metagenomic)."
  signature-limit = "Not a POC tool in the lateral-flow sense; included to bound the landscape — CRISPR-Dx does not aspire to sequencing's resolution and sequencing does not aspire to LFA's footprint."

@D cmp_synthesis := "comparison synthesis" :: comparison [ok]
  positioning = "CRISPR-Dx (especially LFA-readout SHERLOCK/SHINE/STOPCovid) plausibly fills a real gap: ~NAAT-class sensitivity in ~LFA-class instrument footprint — IF the cold-chain, manufacturing, regulatory and clinical-validation challenges are solved per target."
  no-cure-row = "No comparison row is a 'cure': PCR carries instrument/capital cost; CRISPR-Dx carries clinical-validation and manufacturing-maturity debt; antigen LFA carries a sensitivity ceiling; sequencing carries a footprint cost. The synthesis is a MULTI-DIMENSIONAL tradeoff, not a lattice ranking."
  honesty = "Performance comparisons in the literature are heavily target- and matrix-dependent. Any 'CRISPR-Dx beats PCR' or 'CRISPR-Dx beats LFA' statement requires the SPECIFIC target/matrix/study to be cited — generic platform-vs-platform claims are not honest."

# ── §4 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ────

@D lim_clinical_validation_gap := "clinical-validation gap (research demo → cleared diagnostic)" :: real-limit [ok required]
  wall = "HARD WALL (years + cost + regulatory process)"
  statement = "Almost all published CRISPR-Dx work is ANALYTICAL — limit-of-detection benchmarks, specificity against off-target sequences, and small clinical-sample comparisons (typically dozens to low hundreds of patient samples) against an RT-qPCR / NAAT reference. The path from such a demonstration to an FDA-cleared / CE-marked in-vitro diagnostic (IVD) requires: (i) prospective clinical-performance studies on representative populations and matrices; (ii) reagent and manufacturing stability data sufficient for shelf-life claims; (iii) human-factors / usability validation (POC use by intended operators including lay users in some claims); (iv) regulatory submission (FDA 510(k) with predicate, De Novo without one, or PMA for highest-risk; EU IVDR class A–D with notified-body involvement above class A); (v) post-market surveillance commitments. Most publicly-known clearances for CRISPR-Dx products to date arose under the COVID-19 pandemic Emergency Use Authorisation (EUA) framework — a SPECIAL, TIME-LIMITED pathway that is NOT equivalent to standard premarket clearance and that the FDA has progressively wound down."
  consequence = "A published 'CRISPR-Dx for TB / HIV / dengue / influenza' paper is not the same kind of object as an 'FDA-cleared CRISPR-Dx for TB / HIV / dengue / influenza' kit. Conflating them is the central honesty failure this tape exists to prevent. Real product programs spend years and substantial capital crossing this gap — see MEDICAL-DEVICE.tape pathway detail."
  cross-link = "Specific regulatory-pathway mechanics, classification frameworks, ISO/IEC standards, QMS, biocompatibility, sterilization, and post-market surveillance: see [@x_med_device_sibling] / MEDICAL-DEVICE.tape."
  |> "[@x_med_device_sibling]"

@D lim_cold_chain := "cold-chain & reagent stability for true field deployment" :: real-limit [ok required]
  wall = "HARD WALL (chemistry & logistics)"
  statement = "Cas12 / Cas13 recombinant proteins, RPA enzyme cocktails (recombinase, SSB, polymerase), and crRNA reagents are biologically active proteins/RNAs that lose activity at elevated temperature and humidity. Out of the box, liquid SHERLOCK / DETECTR / SHINE reagents need refrigeration; achieving room-temperature or ambient-tropical stability requires lyophilisation (freeze-drying) with appropriate excipients (trehalose, mannitol, etc.), pouch + desiccant packaging, and ACCELERATED-STABILITY studies extrapolated to real-time-stability claims."
  consequence = "Stability is a separate engineering effort that has been demonstrated in research (lyophilised SHERLOCK / SHINE reagents) but that has to be carried through to a regulated stability program for any cleared product. Cold-chain dependence is a deployment-cost limit, not a lattice value."
  observation = "Pandemic-era SHINE / STOPCovid demonstrations made simplification (one-pot, lyo, ambient-tolerant) an explicit design target; routine non-pandemic CRISPR-Dx programs typically inherit cold-chain assumptions from PCR."

@D lim_manufacturing_cost := "manufacturing scale & cost vs antigen LFA" :: real-limit [ok required]
  wall = "ECONOMIC / ENGINEERING WALL"
  statement = "Antigen-LFA tests (e.g., pandemic-era SARS-CoV-2 rapid antigen kits) at-scale reached low-USD unit cost driven by paper-strip economics and mature manufacturing. CRISPR-Dx kits bring additional recombinant-enzyme cost (Cas13/Cas12 plus pre-amplification enzymes), synthetic-guide-RNA / reporter-oligo cost, lyophilisation cycle cost, and stricter QC for enzymatic-reagent lot release. Reaching antigen-LFA-comparable cost at scale is a manufacturing-cost-engineering problem — not a lattice constant."
  consequence = "On a strict $-per-test basis, CRISPR-Dx is structurally more expensive to manufacture than antigen LFA but can be substantially cheaper than instrumented NAAT cartridges; the relevant question is 'cheap enough to be deployed at NAAT-sensitivity in settings where NAAT is not affordable', and that answer is target- and program-specific."
  honesty = "Specific USD-per-test figures are highly program-specific and outside this in-silico SSOT's competence; cited as cost-class observation only."

@D lim_specificity_lowcopy := "off-target / specificity floor at low template copies" :: real-limit [ok required]
  wall = "SOFT WALL (residual, not zeroable)"
  statement = "At very low template copies, two specificity floors apply: (1) the Cas effector itself can tolerate guide mismatches that occasionally let close-relative sequences activate collateral cleavage (the off-target specificity issue, paralleling the genome-editing off-target floor but with diagnostic — not safety — consequences); (2) the isothermal pre-amplification step (RPA in particular) can generate non-specific amplification artefacts in long-incubation low-input conditions, occasionally producing 'no-template' false positives. Both effects are reducible (engineered guides, dual-guide AND-gates, optimised RPA conditions, no-target controls per run) but not zeroable."
  consequence = "Real-world clinical performance at the lower end of the dynamic range is dominated by specificity floors and contamination control; this is a practical clinical-test-design constraint, not a lattice quantity."
  cross-link = "Conceptual parallel (not equivalent) to the genome-editing off-target floor in [@x_crispr_editing_sibling]; diagnostically the consequence is false positive / call quality at low template, not somatic mutation."
  |> "[@x_abudayyeh_2016] · [@x_piepenburg_2006_rpa]"

@D lim_regulatory_pathway := "regulatory pathway constraint (IVD classification & PMS)" :: real-limit [ok required]
  wall = "HARD WALL (process)"
  statement = "A CRISPR-Dx intended for clinical use is an in-vitro diagnostic medical device. In the EU it is governed by Regulation (EU) 2017/746 (IVDR) with risk classes A/B/C/D and notified-body involvement above Class A; in the US it falls under FDA IVD pathways (510(k) / De Novo / PMA depending on risk and predicate) or — exceptionally — Emergency Use Authorisation in declared emergencies. Standards for QMS (ISO 13485), risk management (ISO 14971), software (IEC 62304 where embedded firmware / smartphone-app readouts are involved) and usability (IEC 62366-1) apply."
  consequence = "Regulatory pathway choice (IVDR class / FDA pathway) materially determines program time-to-market, evidence burden and clinical-trial design. None of those mechanics is lattice-derived."
  cross-link = "Full pathway detail (FDA classes I/II/III; EU MDR classes I/IIa/IIb/III; EU IVDR classes A/B/C/D; pathway mechanics; QMS / ISO 13485 / ISO 14971; biocompatibility ISO 10993; SaMD IEC 62304; usability IEC 62366-1; PMS; UDI) lives in MEDICAL-DEVICE.tape — see [@x_med_device_sibling]. This tape does NOT duplicate that material."
  |> "[@x_med_device_sibling]"

@D lim_sample_prep := "sample-prep bottleneck (clinical matrix → assay-ready)" :: real-limit [ok required]
  wall = "BIOLOGICAL / ENGINEERING WALL"
  statement = "Real clinical samples (saliva, nasopharyngeal swab, whole blood, urine, sputum) contain inhibitors of polymerase / Cas / amplification chemistry, host nucleases that degrade target RNA, and variable nucleic-acid burden. Eliminating an extraction step is a major selling point of POC CRISPR-Dx; doing so requires sample-prep chemistry (e.g. HUDSON: heat + reducing agent / chaotrope) that has been demonstrated for several matrices but does NOT generalise automatically to every matrix or analyte."
  consequence = "End-to-end POC performance is gated by sample-prep efficacy at least as much as by the Cas detection step; matrix-by-matrix validation work is non-trivial and is a recurring source of demonstrated-vs-deployed performance gaps."
  |> "[@x_myhrvold_2018_hudson]"

# ── §5 n=6 lattice stance (HONEST — observation, not derivation) ──────

@F f_lattice_fit := "lattice-fit-on-crispr-diagnostics" :: governance [required deny:write]
  pattern = "Deriving CRISPR-diagnostic facts (LoD, TTR, multiplex count, reagent stability, cost per test, Cas type count) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. the deleted stub's 'TTR=30–60 min via Cas13 k_cat ratio = σ/φ', '4 ultrasound-style detection modes = τ', '6 Cas types = n EXACT', 'LoD≤100 cp/mL HIV via RPA 10^9 amplification = some-lattice-product'. These were exactly the lattice-fit patterns of the pre-rewrite stub (hexa-bio mass-split 153b5a2)."
  why = "CRISPR-Dx analytical sensitivity (LoD), time-to-result, multiplex count, reagent stability, cost-per-test and Cas effector taxonomy are molecular biology, biochemistry, manufacturing engineering and regulatory science. They are MEASURED / OBSERVED in published trials and bench work — not lattice-derived. Forbidden by hexa-bio AGENTS.tape g1 (real-limits-first), g2 (lattice-is-tool), g3 (honesty-obligation-external — FDA / EU IVDR / WHO / ISO are external bodies), f1 (lattice-fit-on-external-entity), f2 (no clinical/regulatory claim from in-silico)."
  remedy = "Cite real primary literature and the cross-linked MEDICAL-DEVICE.tape pathway material (this tape's @X entries). The n=6 lattice may only be a coincidental OBSERVATION (e.g. SHERLOCKv2 happens to demonstrate 4 multiplex channels; the multiplex limit is biochemical ortholog availability + LFA-line spatial resolution, NOT τ=4). NEVER a derivation source for any sensitivity, time, cost, or clearance claim."

@N n6_honest_stance := "CRISPR diagnostics has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: CRISPR-Cas13/Cas12 POC diagnostics exposes NO natural n=6 invariant. Cas effector taxonomy (Cas12 = Type V / Class 2; Cas13 = Type VI / Class 2) is an evolving microbial classification, not a fixed lattice number. Spacer/guide length (~28–30 nt for Cas13, ~20 nt for Cas12) is an engineering / biochemical choice. SHERLOCKv2 four-channel multiplexing happens to be four because four ortholog-cleavage preferences were available at publication, not because τ=4. RPA amplification is ~10^9 over ~20 min because of recombinase / SSB / polymerase enzymology under isothermal conditions, not because of any σ-derived number. LFA visual LoD is set by Au-NP plasmon optics + nitrocellulose capillarity, not by φ. Specific TTR / LoD / cost figures are device- and target-specific empirical results published in landmark papers; any numeric coincidence with σ/τ/φ/J₂ is OBSERVATION ONLY. Per LATTICE_POLICY g1/g2 + lattice-as-tool (격자는 도구이지 제약이 아니다): the n=6 lattice is declined here as a derivation tool. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §6 Verifiable predictions (real, falsifiable — NOT lattice) ───────

@D tp_1 := "TP-1 pre-amplification is necessary for clinical-relevance LoD" :: prediction [ok]
  claim = "For clinically-relevant target loads in real matrices (e.g. low-titre RNA viruses in respiratory samples, low-burden bacterial pathogens), Cas13/Cas12 detection WITHOUT a pre-amplification step (RPA/LAMP/RT-RPA/RT-LAMP) does not reach NAAT-comparable sensitivity. Direct, amplification-free Cas detection plateaus orders of magnitude above clinically-actionable target concentrations."
  falsifier = "If a properly powered head-to-head study demonstrates amplification-free Cas13/Cas12 reaching, on real clinical samples, sensitivity statistically indistinguishable from NAAT-PCR, [@chem_isothermal_preamp] / [@lim_specificity_lowcopy] would be wrong."
  source = "[@x_gootenberg_2017] · [@x_chen_2018]"

@D tp_2 := "TP-2 clinical-validation-gap is multi-year" :: prediction [ok]
  claim = "From an analytical-demonstration publication (LoD characterization on contrived + small clinical panels) to an FDA-cleared / CE-IVDR-certified CRISPR-Dx product under STANDARD (non-emergency, non-EUA) pathways requires multi-year programs comparable in time/cost order-of-magnitude to other novel-pathway IVDs of similar risk class — substantially longer than the months-to-quarters timeline of an EUA pathway in a declared public-health emergency."
  falsifier = "If a sufficiently large cohort of post-2017 CRISPR-Dx products reaches standard FDA 510(k) / De Novo / PMA clearance (NOT EUA) at timelines indistinguishable from analytical-paper publication dates, [@lim_clinical_validation_gap] / [@lim_regulatory_pathway] would be wrong."
  source = "[@x_med_device_sibling] · [@x_broughton_2020]"

@D tp_3 := "TP-3 single-tube one-pot improves field-deployability" :: prediction [ok]
  claim = "End-to-end one-pot / single-tube / no-extract workflows (HUDSON sample prep + single-tube RT-RPA/LAMP + Cas + LFA readout, as in SHINE and STOPCovid lineages) demonstrate measurably better field-deployability (operator-step count, instrument count, time-to-result) than multi-tube SHERLOCK/DETECTR v1 lineage workflows, at equal or modestly reduced analytical sensitivity."
  falsifier = "If single-tube workflows show no operational-deployability gain (or strict sensitivity loss without compensating user-step reduction) versus multi-tube workflows in matched comparisons on real clinical samples, [@plat_stopcovid_shine] / [@lim_sample_prep] would be wrong."
  source = "[@x_joung_2020_stopcovid] · [@x_arizti_sanz_shine] · [@x_myhrvold_2018_hudson]"

# ── §7 Cross-links ────────────────────────────────────────────────────

@X x_crispr_editing_sibling := "CRISPR-GENE-EDITING.tape" :: sibling-tape [active]
  scope = "Sibling tape for CRISPR-Cas genome-editing knowledge SSOT — Cas adaptive-immunity origin, Class/Type taxonomy, Cas9/Cas12/Cas13 effector mechanism, base & prime editing, off-target / specificity floor, germline-editing ethical line. This DIAGNOSTIC tape cross-links to it for general Cas biology and does NOT re-derive that material."
  governance-link = "Both tapes share the same hexa-bio AGENTS.tape governance (g1/g2/g3/g8/f1/f2)."

@X x_med_device_sibling := "MEDICAL-DEVICE.tape" :: sibling-tape [active]
  scope = "Sibling tape for medical-device regulation, classification, premarket pathways (FDA 510(k)/De Novo/PMA/Breakthrough; EU MDR Annex IX/X/XI; EU IVDR), QMS (ISO 13485), risk management (ISO 14971), biocompatibility (ISO 10993), sterilization (ISO 11135/11137/17665), SaMD (IMDRF/IEC 62304/AI/ML), human factors (IEC 62366-1), clinical evaluation, PMS / vigilance, UDI. CRISPR-Dx clinical-validation-gap and regulatory-pathway real-limit entries in §4 of THIS tape explicitly defer to MEDICAL-DEVICE.tape rather than duplicating that material."

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "g1 real-limits-first · g2 lattice-is-tool · g3 honesty-obligation-external · g8 in-silico-only-claim-scope · f1 lattice-fit-on-external-entity · f2 wet-lab-clinical-claim-from-in-silico — all directly enforce the disciplines this tape applies (clinical-validation gap honesty, no lattice-fit on FDA/IVDR/WHO/ISO, in-silico knowledge SSOT scope)."

# ── §8 External citations (real, landmark literature) ─────────────────

@X x_abudayyeh_2016 := "Abudayyeh OO et al 2016" :: literature [active]
  ref = "Abudayyeh OO, Gootenberg JS, Konermann S, Joung J, Slaymaker IM, Cox DBT, Shmakov S, Makarova KS, Semenova E, Minakhin L, Severinov K, Regev A, Lander ES, Koonin EV, Zhang F. C2c2 is a single-component programmable RNA-guided RNA-targeting CRISPR effector. Science 2016;353:aaf5573. (Cas13/C2c2 characterization as RNA-guided RNase with collateral activity — the foundational biology underlying SHERLOCK.)"

@X x_chen_2018 := "Chen JS et al 2018" :: literature [active]
  ref = "Chen JS, Ma E, Harrington LB, Da Costa M, Tian X, Palefsky JM, Doudna JA. CRISPR-Cas12a target binding unleashes indiscriminate single-stranded DNase activity. Science 2018;360:436–439. (Cas12a collateral ssDNase activity — DETECTR foundation.)"

@X x_gootenberg_2017 := "Gootenberg JS et al 2017 (SHERLOCKv1)" :: literature [active]
  ref = "Gootenberg JS, Abudayyeh OO, Lee JW, Essletzbichler P, Dy AJ, Joung J, Verdine V, Donghia N, Daringer NM, Freije CA, Myhrvold C, Bhattacharyya RP, Livny J, Regev A, Koonin EV, Hung DT, Sabeti PC, Collins JJ, Zhang F. Nucleic acid detection with CRISPR-Cas13a/C2c2. Science 2017;356:438–442. (SHERLOCK platform — Cas13a + RPA pre-amplification + fluorescent reporter.)"

@X x_gootenberg_2018_v2 := "Gootenberg JS et al 2018 (SHERLOCKv2)" :: literature [active]
  ref = "Gootenberg JS, Abudayyeh OO, Kellner MJ, Joung J, Collins JJ, Zhang F. Multiplexed and portable nucleic acid detection platform with Cas13, Cas12a, and Csm6. Science 2018;360:439–444. (SHERLOCKv2 — multiplexed Cas13 orthologs + Cas12a + lateral-flow paper-strip readout.)"

@X x_myhrvold_2018_hudson := "Myhrvold C et al 2018 (HUDSON)" :: literature [active]
  ref = "Myhrvold C, Freije CA, Gootenberg JS, Abudayyeh OO, Metsky HC, Durbin AF, Kellner MJ, Tan AL, Paul LM, Parham LA, Garcia KF, Barnes KG, Chak B, Mondini A, Nogueira ML, Isern S, Michael SF, Lorenzana I, Yozwiak NL, MacInnis BL, Bosch I, Gehrke L, Zhang F, Sabeti PC. Field-deployable viral diagnostics using CRISPR-Cas13. Science 2018;360:444–448. (HUDSON sample-prep chemistry that obviates nucleic-acid extraction for several viral matrices; SHERLOCK clinical-sample applications.)"

@X x_joung_2020_stopcovid := "Joung J et al 2020 (STOPCovid)" :: literature [active]
  ref = "Joung J, Ladha A, Saito M, Kim NG, Woolley AE, Segel M, Barretto RPJ, Ranu A, Macrae RK, Faure G, Ioannidi EI, Krajeski RN, Bruneau R, Huang MW, Yu XG, Li JZ, Walker BD, Hung DT, Greninger AL, Jerome KR, Gootenberg JS, Abudayyeh OO, Zhang F. Detection of SARS-CoV-2 with SHERLOCK One-Pot Testing. N Engl J Med 2020;383:1492–1494. (STOPCovid — single-tube SHERLOCK-class isothermal LAMP + Cas12b lateral-flow workflow for SARS-CoV-2; landmark pandemic-era end-to-end POC demonstration.)"

@X x_broughton_2020 := "Broughton JP et al 2020 (DETECTR-LFA SARS-CoV-2)" :: literature [active]
  ref = "Broughton JP, Deng X, Yu G, Fasching CL, Servellita V, Singh J, Miao X, Streithorst JA, Granados A, Sotomayor-Gonzalez A, Zorn K, Gopez A, Hsu E, Gu W, Miller S, Pan CY, Guevara H, Wadford DA, Chen JS, Chiu CY. CRISPR-Cas12-based detection of SARS-CoV-2. Nat Biotechnol 2020;38:870–874. (DETECTR-LFA for SARS-CoV-2 — early CRISPR-Dx pandemic-era EUA-pathway demonstration.)"

@X x_arizti_sanz_shine := "Arizti-Sanz J et al 2020/2022 (SHINE)" :: literature [active]
  ref = "Arizti-Sanz J, Freije CA, Stanton AC, Petros BA, Boehm CK, Siddiqui S, Shaw BM, Adams G, Kosoko-Thoroddsen T-S F, Kemball ME, Uwanibe JN, Ajogbasile FV, Eromon PE, Gross R, Wronka L, Caviness K, Hensley LE, Bergman NH, MacInnis BL, Happi CT, Lemieux JE, Sabeti PC, Myhrvold C. Streamlined inactivation, amplification, and Cas13-based detection of SARS-CoV-2 (SHINE). Nat Commun (Arizti-Sanz et al., 2020/2022 era; primary-author/era cited — exact volume not asserted). (SHINE — single-tube Cas13 workflow with simplified field-deployable readout.)"

@X x_piepenburg_2006_rpa := "Piepenburg O et al 2006 (RPA)" :: literature [active]
  ref = "Piepenburg O, Williams CH, Stemple DL, Armes NA. DNA detection using recombination proteins. PLoS Biol 2006;4:e204. (Recombinase polymerase amplification — the isothermal pre-amplification chemistry coupled to most SHERLOCK / DETECTR workflows.)"

@X x_notomi_2000_lamp := "Notomi T et al 2000 (LAMP)" :: literature [active]
  ref = "Notomi T, Okayama H, Masubuchi H, Yonekawa T, Watanabe K, Amino N, Hase T. Loop-mediated isothermal amplification of DNA. Nucleic Acids Res 2000;28:e63. (LAMP isothermal amplification chemistry — coupled to STOPCovid-class CRISPR-Dx workflows.)"

@X x_eu_ivdr_2017_746 := "EU IVDR Regulation (EU) 2017/746" :: literature [active]
  ref = "European Union. Regulation (EU) 2017/746 of the European Parliament and of the Council of 5 April 2017 on in vitro diagnostic medical devices (IVDR); date of application 26 May 2022. The IVD-pathway anchor for any CRISPR-Dx intended for the EU market; specific class (A/B/C/D) determined by IVDR Annex VIII rules. Cross-link to MEDICAL-DEVICE.tape for pathway detail. Publisher: Official Journal of the European Union."
