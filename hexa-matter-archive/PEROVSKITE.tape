#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "perovskite" :: identity-claim [d=2026-05-14 active]
  kind = "PEROVSKITE — Phase D candidate stub"
  brief = "The perovskite structure is **ABX₃**: large A cation in cuboctahedral coordination, small B cation in octahedral coordination, X anion (oxide or halide) at corners. This single structure type spans 4 "
  parent = "dancinlab/hexa-matter"
  sibling-md = "PEROVSKITE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in PEROVSKITE.md.
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
