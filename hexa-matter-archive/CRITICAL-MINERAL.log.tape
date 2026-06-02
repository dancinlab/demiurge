#!/usr/bin/env tape
# ══════════════════════════════════════════════════════════════════════
# CRITICAL-MINERAL.log.tape — append-only event history
# ══════════════════════════════════════════════════════════════════════
# Per AGENTS.tape @D g_arch_vs_log_split.
# Architecture sibling: CRITICAL-MINERAL.tape
# ══════════════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@A genesis_2026_05_17 := "CRITICAL-MINERAL.tape created" :: assistant [d=2026-05-17 ok]
  => "umbrella domain seeded for 12 export-controlled commodities (REE + Ga + Ge + Sb + W + Co + Li + graphite + Mg + Ti + Nb + Ta); per-commodity 1-card summaries deferring depth to verb files; 2023-2026 PRC export-control timeline documented (2023-08 Ga/Ge license → 2025-04 7 HREE license → 2025-11 US-China 12-month suspension → 2026-11-10 pending expiry)"

# ─── append new events below this line ───
