#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# HORTICULTURE.log.tape — append-only event history (v1.2 split)
# Sibling: HORTICULTURE.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A rewrite_lattice_to_real_science := "HORTICULTURE.tape rewritten from lattice-tautology stub to real-science SSOT" :: rewrite [ok d=2026-05-16]
  origin = "HORTICULTURE.tape was a ~683-line lattice-tautology stub (hexa-bio mass-split 153b5a2) containing @D row_x_* performance tables with fabricated ratios ('σ-φ=10× 균질', '1/(σ-φ)=90% 절감', '1/φ=절반') and BT-429–433 breakthrough theorems asserting 'n=6 EXACT' across unrelated horticultural quantities. Zero literature citations. Zero real-limits anchors."
  authored = "Full rewrite with real horticulture science + landmark citations: Hartmann & Kester propagation textbook (1959 era) · Bewley & Black seed dormancy · Murashige & Skoog 1962 (MS medium) · Taiz & Zeiger plant physiology · Burg & Burg 1962 era (ethylene/fruit ripening) · Stern et al 1959 (IPM economic thresholds) · Blankenship & Dole 2003 (1-MCP / SmartFresh review) · Kader 2002 (postharvest postharvest technology) · Meuwissen et al 2001 (genomic selection) · Allard 1960 (plant breeding) · Hanan 1998 (greenhouse technology) · Faust (dwarfing rootstocks). 13 @X :: literature entries."
  domains = "§1 plant propagation (sexual/asexual: cuttings/layering/division/grafting/micropropagation; seed dormancy scarification/stratification) · §2 grafting biology (cambium alignment, M.9/M.27 dwarfing rootstocks, virus transmission, ornamental grafting) · §3 PGRs (auxin/IAA/NAA/IBA; cytokinin; gibberellin; ethylene/Burg&Burg; ABA/stomata) · §4 greenhouse/protected cultivation (temperature/humidity/CO₂/DLI; hydroponics; vertical systems) · §5 plant breeding (F1/heterosis; MAS; genomic selection) · §6 IPM (Stern 1959 economic thresholds; resistance evolution; biocontrol; resistant cultivars) · §7 postharvest physiology (FAO 30–40% loss estimates; cold chain; climacteric/non-climacteric; 1-MCP/SmartFresh) · §8 ornamental horticulture (photoperiod; floriculture; landscape)"
  real-limits = "5 @D lim_* :: real-limit entries: rootstock-scion compatibility (HARD); pesticide-resistance evolution (HARD evolutionary); postharvest losses thermodynamic floor (SOFT reducible); water/labour economics (SOFT); genetic complexity / G×E interaction (SOFT)"
  n6-stance = "Declined as derivation tool. @F f_lattice_fit + @N n6_honest_stance state plainly: horticulture has no natural n=6 invariant. Propagation modes coincidentally enumerating to ~6 is an OBSERVATION ONLY — explicitly not lattice-derived. Five classical plant hormones (5 ≠ 6). All former BT-429–433 entries and row_* tautology tables deleted."
  governance = "Complies with hexa-bio AGENTS.tape @D g1 (real-limits-first) · @D g2 (lattice-is-tool) · @D g8 (in-silico-only) · @F f1 (no lattice-fit on external entities). Knowledge-scope disclaimer (@N scope_disclaimer) added."
  lint = "python3 selftest/tape_lattice_honesty_lint.py HORTICULTURE.tape --json → __TAPE_LATTICE_HONESTY__ PASS (has_guard=true, has_stance=true, grounded=true)"
