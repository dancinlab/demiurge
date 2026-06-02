#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "graphene_carbon" :: identity-claim [d=2026-05-14 active]
  kind = "GRAPHENE-CARBON — extended chapter (sp²/sp³ carbon family)"
  brief = "Carbon's electron configuration (1s² 2s² 2p²) allows three hybridization states with distinct geometric + bonding signatures:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "GRAPHENE-CARBON.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in GRAPHENE-CARBON.md.
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
