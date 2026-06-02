#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "liquid_crystal" :: identity-claim [d=2026-05-14 active]
  kind = "LIQUID-CRYSTAL — Phase D candidate stub"
  brief = "A **liquid crystal (LC)** is a phase of matter with orientational order (like a solid) but positional fluidity (like a liquid). Three main phases:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "LIQUID-CRYSTAL.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in LIQUID-CRYSTAL.md.
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
