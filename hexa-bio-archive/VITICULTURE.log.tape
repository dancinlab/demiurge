#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# VITICULTURE.log.tape — append-only event history (v1.2 split)
# Sibling: VITICULTURE.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A rewrite_lattice_tautology_to_real_science := "VITICULTURE.tape rewritten from lattice-tautology stub to real viticultural science SSOT" :: rewrite [ok d=2026-05-16]
  origin = "VITICULTURE.tape was a lattice-tautology stub (hexa-bio mass-split 153b5a2) — ~380 lines of @D row_* entries mapping viticultural quantities (Brix, yield t/ha, quality %, disease control %) to lattice values (J₂=24, σ=12, τ=4, etc.) with zero real viticulture science. Example violations: row_brix_0 (target Brix '18' → '24 because J₂=24'); row_t_ha_1 (yield '8' → '12 because σ=12'); row_core_0 ('n=6 core degrees of freedom EXACT') through row_exact_9 ('EXACT ratio 93%' derived from σ·φ/n·τ). All violate hexa-bio AGENTS.tape @F f1 + @D g1/g2 (LATTICE_POLICY honesty)."
  authored = "Full real-science rewrite 2026-05-16. Replaces ALL lattice-tautology stubs with evidence-grounded viticultural science: Vitis taxonomy (~10,000 cultivars, McGovern Caucasus domestication ~6000 BCE era); phylloxera history (~1860s European devastation → American rootstock grafting solution, still the only durable control); vine phenology (E-L 47-stage system, Coombe & McCarthy ~2000 era); berry development/veraison biochemistry; terroir (Winkler GDD I-V, Huglin index, Tonietto & Carbonneau 2004 MCC); grapevine diseases (Plasmopara viticola, Erysiphe necator, Botrytis cinerea noble-rot vs grey-rot, ESCA trunk disease); climate change (van Leeuwen & Darriet 2016 J Wine Econ 11:150-167; Hannah et al 2013 PNAS 110:6907-6912); precision viticulture (NDVI, RDI, biological controls)."
  real-limits = "4 @D lim_* :: real-limit entries: lim_phylloxera (HARD WALL — no durable chemical/biological control); lim_climate_envelope (HARD WALL — cardinal temperature bounds); lim_disease_fungicide (SOFT WALL — fungicide resistance evolution); lim_water_smoke (HARD WALL — water finitude + emerging smoke-taint wildfire constraint)."
  n6-stance = "Declined as a derivation tool. @N n6_honest_stance + @F f_lattice_fit state plainly: viticulture has no natural n=6 invariant (E-L: 47 stages ≠ 6; Winkler regions: I-V = 5 ≠ 6; major disease categories: 5 named threats, not 6; Brix at harvest: site/style-specific empirical range, not J₂=24). This honesty IS the corrective for the audited lattice-tautology violation."
  citations = "Confident journal citations: van Leeuwen & Darriet 2016 J Wine Econ 11:150-167; Hannah et al 2013 PNAS 110:6907-6912; Jaillon et al 2007 Nature 449:463-467; Tonietto & Carbonneau 2004 Agric For Meteorol 124:81-97. Author/era-flagged (exact volume not asserted): McGovern archaeobotany era; Galet ampelography textbook era; Mullins/Bouquet/Williams 'Biology of the Grapevine' 1992; Coombe & McCarthy modified E-L system ~2000; Winkler General Viticulture ~1974; Bove/Gubler ESCA trunk disease literature ~2010s."
  lint = "python3 selftest/tape_lattice_honesty_lint.py VITICULTURE.tape --json → __TAPE_LATTICE_HONESTY__ PASS (has_guard=true, has_stance=true, grounded=true; zero lattice-derivation lines — all lattice-token references are inside the @F guard body or @N stance body, which the linter correctly exempts as provenance-not-derivation)"
