#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# AGRICULTURE.log.tape — append-only event history (v1.2 split)
# Sibling: AGRICULTURE.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A rewrite_from_lattice_tautology := "AGRICULTURE.tape rewritten from lattice-tautology stub into real agronomy SSOT" :: rewrite [ok d=2026-05-15]
  origin = "AGRICULTURE.tape was a fabricated lattice-tautology stub from the hexa-bio mass-split (commit 153b5a2): ~1112 lines, almost entirely `@D row_* / @D b_*` entries of the form `x=\"n=6\" · x=\"<korean gloss>\" · x=\"EXACT\"` — zero real science, every 'value' asserted as lattice-derived (e.g. 'n=6 = 6 macronutrients', 'σ=12 = 12-month crop cycle', 'J₂=24 = 24 solar terms'). No citations, no falsifiers, no real limits. Deleted in full (all 1100+ stub lines removed)."
  authored = "Hand-written with real crop/soil/agronomy science + landmark literature. Replaced the stub with: photosynthesis & C3/C4/CAM (Farquhar 1980 · Hatch–Slack · Zhu/Long/Ort 2010); Liebig's law of the minimum & essential nutrients (von Liebig · Marschner); NPK/micronutrient & nitrogen cycling + biological N fixation + Haber–Bosch context (Galloway 2004 · Smil 2001); soil texture/structure/CEC & pedological horizons (Brady & Weil); water relations & evapotranspiration (FAO-56 Allen 1998); IPM (Stern economic-threshold); crop rotation & the Green Revolution / Borlaug semi-dwarf cereals (Borlaug · Evenson & Gollin 2003); yield-gap analysis (van Ittersum 2013). Five @D :: real-limit anchors (Liebig limiting-factor law · photosynthetic light-use-efficiency ceiling ≈4.6%C3/≈6%C4 · finite arable land/water/phosphate · diminishing-returns yield-gap asymptote · crop climate envelope) + 3 falsifiable @D :: prediction entries with explicit falsifiers."
  n6-stance = "Declined as a derivation tool. @F f_lattice_fit + @N n6_honest_stance state plainly: agriculture exposes NO natural n=6 invariant — crop cycles, NPK/~17 essential elements, soil horizons (O/A/E/B/C/R), growth stages and rotation lengths are agronomy (plant biology / soil chemistry / climate / historical convention), not lattice-derived. Numeric coincidences (6 CO₂ in hexose; 12-month calendar; 24 solar terms) are OBSERVATION ONLY — organic chemistry, Earth's orbit, cultural calendars; not σ/τ/φ/J₂. This honesty is the corrective for the audited lattice-tautology stub."
  governance = "Complies with hexa-bio AGENTS.tape @D g1 (real-limits-first — every @D |>-grounded to a real @X), @D g2 (lattice-is-tool — declined here), @D g8 (in-silico-only-claim-scope — @N scope_disclaimer: knowledge SSOT, NOT agronomic advice / farming protocol / pesticide-use claim), @F f1 (no lattice-fit). No fabricated numbers or citations: efficiency/nutrient/yield figures are paraphrased from cited literature; 4 citations are deliberately author/era-only where exact bibliographic detail is not asserted (von Liebig 1840s; Hatch & Slack ~1966–70; Stern ~1959; Karlen ~1994; Borlaug primary-author/era for the non-Science writings) — flagged as such in each @X ref."
  lint = "python3 selftest/tape_lattice_honesty_lint.py AGRICULTURE.tape --json → __TAPE_LATTICE_HONESTY__ PASS (has_guard=true, has_stance=true, grounded=true; deriv_warnings = guard/stance provenance lines only, no genuine lattice-derivation lines)."
