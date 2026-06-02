#!/usr/bin/env tape
# ══════════════════════════════════════════════════════════════════════
# RARE-EARTH.log.tape — append-only event history
# ══════════════════════════════════════════════════════════════════════
# Per AGENTS.tape @D g_arch_vs_log_split:
#   UPPERCASE.tape    = EDITABLE architecture (latest-wins per id)
#   UPPERCASE.log.tape = APPEND-ONLY event history
#
# Grammar reference: ~/core/tape/spec/tape.md (v1.2)
# Architecture sibling: RARE-EARTH.tape
# ══════════════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@A genesis_2026_05_17 := "RARE-EARTH.tape created" :: assistant [d=2026-05-17 ok]
  => "17-element family reference seeded (LREE/HREE/Sc taxonomy, application matrix, supply concentration anchors). Sibling .md companion created same day."
  -> "RARE-EARTH+ALTERNATIVE.tape (meta-domain) + CRITICAL-MINERAL.tape (umbrella) co-seeded"

# ─── append new events below this line ───
