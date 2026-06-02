#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# FOOD-SCIENCE.log.tape — append-only event history (v1.2 split)
# Sibling: FOOD-SCIENCE.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A rewrite_real_science := "FOOD-SCIENCE.tape full real-science rewrite" :: rewrite [ok d=2026-05-16]
  origin = "FOOD-SCIENCE.tape was a lattice-tautology stub (hexa-bio mass-split 153b5a2) — ~380 lines of @D row_* entries with Korean-language lattice mappings (σ/τ/φ/J₂ exact columns, 'n=6' derivation lines, no real food chemistry citations, no real literature). Committed with zero food-science content."
  what-replaced = "Every stub @D row_*/b_* entry deleted. Replaced with 12 sections of real food-science: macronutrient composition (carbohydrates/proteins/lipids/water-activity), Maillard mechanism (Hodge 1953), caramelisation, acrylamide formation (Tareke 2002), lipid oxidation kinetics + antioxidants, FAT-TOM, 7 major foodborne pathogens, Leistner hurdle technology, thermal/refrigeration/drying/curing/MAP/HPP/PEF/irradiation preservation, HACCP 7-principle framework (Codex), sensory science (5 basic tastes / umami Ikeda 1909 / debated fat-taste 6th candidate / olfaction / trigeminal)."
  real-limits = "5 @D lim_* :: real-limit entries: Listeria zero-tolerance in RTE foods ([@lim_listeria_zero]); acrylamide unavoidable in browned starchy foods ([@lim_acrylamide_unavoidable]); Big-9 allergens as hard biological triggers ([@lim_allergens]); spoilage kinetics vs shelf-life economics ([@lim_spoilage_kinetics]); nutrient-retention vs preservation-intensity tradeoff ([@lim_nutrient_preservation]); plus water-activity absolute microbial floor ([@lim_aw_floor])."
  n6-stance = "Declined as a derivation tool. @F f_lattice_fit (f_lattice_fit-on-food-science) + @N n6_honest_stance state plainly: food chemistry has no natural n=6 invariant. FAT-TOM has 6 factors by pedagogical convention; 5 basic tastes + debated 6th candidate follows receptor biology; HACCP has 7 principles — all set by science/convention, NOT by lattice. Per hexa-bio AGENTS.tape g1/g2 and LATTICE_POLICY."
  citations = "12 @X :: literature entries: Hodge 1953 (J Agric Food Chem 1:928-943, Maillard mechanism — full citation asserted); Tareke et al 2002 (J Agric Food Chem 50:4998-5006, acrylamide — full citation asserted); Ikeda 1909 (umami discovery — primary author/era, Japanese original + 2002 English translation noted); Fennema Food Chemistry textbook era; Damodaran food-protein functionality era; Labuza water-activity era; Frankel Lipid Oxidation era; Leistner 2000 (Int J Food Microbiol 55:181-186, hurdle technology); Potter & Hotchkiss textbook era; Codex Alimentarius CAC/RCP 1-1969 Rev.4 (institutional); FDA Bad Bug Book 2012 (institutional); IARC Monograph 114 (institutional); EFSA acrylamide opinion 2015 (institutional)."
  governance = "Complies with hexa-bio AGENTS.tape @D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope) · @F f1 (lattice-fit-on-external-entity). @N scope_disclaimer added — in-silico knowledge SSOT only, NOT dietary/regulatory advice."
  lint = "python3 selftest/tape_lattice_honesty_lint.py FOOD-SCIENCE.tape --json → __TAPE_LATTICE_HONESTY__ PASS (has_guard=true, has_stance=true, grounded=true)"
