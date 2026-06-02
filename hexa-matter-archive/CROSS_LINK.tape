#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "cross_link" :: identity-claim [d=2026-05-14 active]
  kind = "CROSS_LINK — sister-repo material-layer manifest"
  brief = "`hexa-matter` owns the **MATERIAL LAYER** only:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "CROSS_LINK.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CROSS_LINK.md.
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
