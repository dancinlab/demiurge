#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# CANCER-THERAPY.log.tape — append-only event history (v1.2 split)
# Sibling: CANCER-THERAPY.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A rewrite := "CANCER-THERAPY.tape rewritten from lattice-tautology stub to real-science SSOT" :: rewrite [ok d=2026-05-15]
  origin = "CANCER-THERAPY.tape was a fabricated lattice-tautology stub (created in the hexa-bio mass-split, commit 153b5a2). It 'derived' oncology facts (5년 생존율=90%, 표적 정확도=99%, 부작용=10%, 재발률=4%) from n=6 lattice numbers (σ=12/τ=4/φ=2/J₂=24) with x=\"EXACT\" — a direct LATTICE_POLICY g1/g2 + f1 violation. Every row_* / b_* / tp_* stub entry deleted."
  authored = "Hand-written with real oncology biology + landmark clinical citations. Replaces ZERO biology with: hallmarks of cancer (Hanahan & Weinberg 2000/2011/2022), driver genetics (Knudson two-hit, Vogelstein), TME/metastasis (Folkman), TNM/molecular classification, and the genuine modality landscape — surgery, radiotherapy, cytotoxic chemo (Einhorn cisplatin), targeted therapy (Druker imatinib, Slamon trastuzumab), immune checkpoint blockade (Hodi ipilimumab, Le MSI/dMMR), CAR-T (Maude CD19), endocrine therapy (EBCTCG), supportive/palliative care (Temel). Qualitative source-grounded §3b modality comparison. 6 real-limit anchors: intratumoral heterogeneity & clonal evolution (HARD), therapeutic-index ceiling (HARD), metastasis problem (HARD), acquired-resistance inevitability (SOFT), no universal cure (HARD), early-detection floor (PHYSICAL). 3 falsifiable predictions with falsifiers + sourced. 16 real @X :: literature citations."
  n6-stance = "Declined as a derivation tool. @F f_lattice_fit + @N n6_honest_stance state plainly: oncology exposes NO natural n=6 invariant (hallmarks framework is open/expanding, NOT a closed n-tuple; TNM stage groups are AJCC-revised ordinals ≠6; >100 distinct diseases; hundreds of driver genes). Coincidence is observation-only, never derivation. This honesty IS the corrective for the audited lattice-tautology stub."
  governance = "Complies with hexa-bio AGENTS.tape g1 (real-limits-first — 6 real-limit anchors), g2 (lattice-is-tool — declined as derivation), g8 (in-silico-only-claim-scope — @N scope_disclaimer added), f1 (no lattice-fit), f2 (no in-silico→clinical/efficacy claim — figures paraphrased from published literature for modeling context only, real treatment requires licensed oncologist). Provenance recorded in @I id001 rewritten-from key."
  honesty-caveats = "No fabricated numbers/citations — exact efficacy magnitudes kept qualitative (direction + intent + landmark trial); precise percentages avoided where not certain. Two collaborative/large-author references flagged primary-author/era only: x_ebctcg_2005 (EBCTCG collaborative group, Lancet 2005) and x_vogelstein_2013 (Science 2013) — volume/page stated but explicitly paraphrased, not re-derived, mirroring the gold tape's x_goren_2014 discipline."
  lint = "python3 selftest/tape_lattice_honesty_lint.py CANCER-THERAPY.tape --json → __TAPE_LATTICE_HONESTY__ PASS (has_guard=true, has_stance=true, grounded=true, deriv_warnings=[] — zero lattice-derivation lines remain; all row_* garbage deleted)."
