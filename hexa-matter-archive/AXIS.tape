#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "axis" :: identity-claim [d=2026-05-14 active]
  kind = "AXIS — hexa-matter 7-group material taxonomy"
  brief = "**Phase D (2026-05-13) verb expansion** (12 new verbs):"
  parent = "dancinlab/hexa-matter"
  sibling-md = "AXIS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in AXIS.md.
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
