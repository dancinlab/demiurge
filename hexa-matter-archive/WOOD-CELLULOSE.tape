#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "wood_cellulose" :: identity-claim [d=2026-05-14 active]
  kind = "WOOD-CELLULOSE — Phase D candidate stub"
  brief = "Wood is a composite of:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "WOOD-CELLULOSE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in WOOD-CELLULOSE.md.
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
