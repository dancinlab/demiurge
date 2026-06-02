#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "adhesive" :: identity-claim [d=2026-05-14 active]
  kind = "ADHESIVE — Phase D candidate stub"
  brief = "Adhesives bond two substrates via one (or more) of 5 adhesion mechanisms:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "ADHESIVE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in ADHESIVE.md.
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
