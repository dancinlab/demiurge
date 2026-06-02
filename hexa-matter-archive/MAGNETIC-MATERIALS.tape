#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "magnetic_materials" :: identity-claim [d=2026-05-14 active]
  kind = "MAGNETIC-MATERIALS — Phase D candidate stub"
  brief = "Magnetic materials split into two operational classes:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "MAGNETIC-MATERIALS.md"

# ────────────────────────────────────────────────────────────────────
# Cross-links — added 2026-05-17
# ────────────────────────────────────────────────────────────────────

@H h_xlink_rare_earth_alternative := "REE-free magnet roadmap" :: cross-link [active d=2026-05-17]
  ?> "[[RARE-EARTH+ALTERNATIVE]]"
  why = "5-track REE substitution roadmap (recycling · ferrite-hd · Mn-Al-C · boride · low-Dy/Tb · AI-found) lives in RARE-EARTH+ALTERNATIVE.tape; this file owns the verb (process · characterization · parity gates)"

@H h_xlink_rare_earth := "REE element-family reference" :: cross-link [active d=2026-05-17]
  ?> "[[RARE-EARTH]]"
  why = "Nd / Pr / Dy / Tb / Sm / Eu application + supply detail lives in RARE-EARTH.tape"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in MAGNETIC-MATERIALS.md.
# New per-domain history entries land here as typed events:
#
#   @A commit_<hash> :: <domain> [d=<YYYY-MM-DD> ok]
#     <- <prev-id>
#     => "<one-line description>"
#
#   @D <id> := "<decision-name>" :: <domain> [<grades>]
#     <- <evidence-id>
#     |> <verifier>
#
# See ~/core/tape/spec/tape.md for full grammar.
