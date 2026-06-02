#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# LESSONS.log.tape — append-only event history (v1.2 split)
# Sibling: LESSONS.tape (architecture-current, editable)
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# §Log — entries chronological, oldest first.

@A a_rewrite_2026_05_16 := "honesty-lint compliance rewrite" :: rewrite [ok d=2026-05-16]
  what = "Rewrote LESSONS.tape to satisfy tape_lattice_honesty_lint.py meta-mode PASS contract."
  changes = [
    "Added tape-class = 'meta/lessons' + rewritten-from to @I id001 (meta-mode opt-in)",
    "Added @N scope_disclaimer (in-silico scope, wet-lab boundary, AGENTS.tape g8_in_silico_only)",
    "Added @F f_lattice_fit (lattice-fit-in-lessons-entries, anti-pattern guard)",
    "Added @N n6_honest_stance (observation-not-derivation, methodology-cite for meta-mode grounding)",
    "Added @X x_lattice_policy :: governance (LATTICE_POLICY.md)",
    "Added @X x_agents_tape :: governance (AGENTS.tape g_meta_mode_optin)",
    "Removed emoji prefixes from cluster_type / label / text fields (cosmetic cleanup)",
    "Preserved all genuine engineering lessons verbatim in substance"
  ]
  linter = "tape_lattice_honesty_lint.py --json → PASS is_meta=true has_guard=true has_stance=true grounded=true"
  deriv_warnings = "1 (L174 loop-cheap Pauli count — observed compute boundary, provenance not derivation)"
