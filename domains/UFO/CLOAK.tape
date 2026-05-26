#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "cloak" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-CLOAK — 궁극의 전자기 스텔스/투명망토"
  brief = "┌──────────────────────────────────────────────────────────────┐"
  parent = "dancinlab/hexa-ufo"
  sibling-md = "CLOAK.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CLOAK.md.
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
