#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# COFFEE.log.tape — append-only event history (v1.2 split)
# Sibling: COFFEE.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A rewrite_lattice_to_real_science := "COFFEE.tape rewritten from lattice-tautology stub to real coffee science SSOT" :: rewrite [ok d=2026-05-16]
  origin = "COFFEE.tape was a 380-line lattice-tautology stub (hexa-bio mass-split 153b5a2) with @D row_* entries carrying n_6 = σ, n_6 = τ, n_6 = n=6 derivation claims — extraction yield '96% because σ·sopfr/10', TDS '1.4 because τ=4', espresso quality '90% because σ·(σ-φ)/2', etc. Zero real coffee-science content. Violates hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) + @D g1/g2 (real-limits-first / lattice-is-tool)."
  action = "Full rewrite 2026-05-16. Deleted ALL stub entries from @I id001 onward. Replaced with real coffee biology and chemistry in 11 sections."
  sections-written = [
    "§1 Botany: Coffea genus (Rubiaceae, ~130 spp, Davis et al 2006); arabica (allotetraploid, 2n=44) vs canephora (diploid, 2n=22); cultivar diversity",
    "§2 Post-harvest: cherry anatomy; washed/natural/honey processing; fermentation chemistry (microbial consortia, metabolites, Bytof 2005 / Pereira 2014)",
    "§3 Green-bean composition: chlorogenic acids, caffeine, trigonelline, lipids (cafestol/kahweol), proteins, sucrose — Farah 2006 / Belitz 2009",
    "§4 Roasting chemistry: Maillard + Strecker + pyrolysis; first/second crack; mass-loss; CO₂ — Illy & Viani 2005 / Belitz 2009 / Schenker 2000",
    "§5 Brewing extraction: SCA optimal window ~18–22% yield, ~1.15–1.45% TDS (sensory-empirical, not lattice); espresso vs filter — Rao 2008 era",
    "§6 Caffeine pharmacology: adenosine receptor antagonism (A1/A2A); CYP1A2 fast/slow metaboliser polymorphism — Fredholm 1999 / Cornelis 2006",
    "§7 Climate sensitivity (real-limits): arabica thermal envelope (Bunn 2015 model era); coffee-leaf rust (Hemileia vastatrix, Avelino 2015); coffee berry borer (Jaramillo 2006); smallholder economics; shade-grown biodiversity tradeoff (Perfecto 1996)",
    "§8 @F f_lattice_fit governance guard; @N n6_honest_stance (coffee science has no natural n=6 invariant — 2 commercial species, 3 processing routes, 2 adenosine receptor subtypes, ~18–22% extraction window: all agronomy/food-science, none lattice-derived)",
    "§9 Three falsifiable predictions (arabica area contraction, CYP1A2 half-life, extraction yield window) each with stated falsifier and source",
    "§10 Cross-links to hexa-bio AGENTS.tape",
    "§11 16 @X :: literature citations (real, landmark, author/era-flagged where exact volume not asserted)"
  ]
  real-limits-anchored = "5 @D lim_* :: real-limit entries: climate envelope (HARD WALL, Bunn 2015 era); coffee-leaf rust (HARD WALL, Avelino 2015); coffee berry borer (HARD WALL, Jaramillo 2006); smallholder economics (SOFT WALL); shade-grown vs sun-grown tradeoff (SOFT WALL, Perfecto 1996)"
  n6-stance = "Declined as a derivation tool. @F f_lattice_fit + @N n6_honest_stance state plainly: coffee science has no natural n=6 invariant. No lattice-derivation lines remain in the rewritten tape."
  honesty = "No fabricated numbers or citations. Uncertain volumes and exact figures are flagged as 'primary author/era cited; exact volume not asserted'. Compositional ranges cited to Farah 2006 / Belitz 2009 with explicit caveat that exact values vary by cultivar, environment, processing."
  lint = "python3 selftest/tape_lattice_honesty_lint.py COFFEE.tape --json → {verdict: PASS, has_guard: true, has_stance: true, grounded: true, deriv_warnings: []}"
  sentinel = "__TAPE_LATTICE_HONESTY__ PASS"
  governance = "Complies with hexa-bio AGENTS.tape @F f1 (lattice-fit-on-external-entity) · @D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only-claim-scope). In-silico knowledge SSOT only — NOT a brewing recipe, food-safety, health, or regulatory claim."
