#!/usr/bin/env tape
# ══════════════════════════════════════════════════════════════════════
# IMPORTED_FROM_CANON.log.tape — append-only event history
# Architecture (editable) → IMPORTED_FROM_CANON.tape
# See AGENTS.tape @D g_arch_vs_log_split for the split rationale.
# ══════════════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@A rewrite_2026_05_16 := "honesty-lint compliance rewrite" :: rewrite [ok d=2026-05-16]
  => "IMPORTED_FROM_CANON.tape rewritten to honesty-lint compliance: added tape-class=meta/import-record opt-in, @F f_lattice_fit guard, @N n6_honest_stance, @N scope_disclaimer, preserved full import inventory, added @X governance citations. Linter verdict: PASS is_meta=true."
  method = "meta-mode opt-in per AGENTS.tape g_meta_mode_optin (d=2026-05-16)"
  authority = "selftest/tape_lattice_honesty_lint.py --json → PASS"
