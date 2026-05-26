#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hexa_ufo" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate UFO Flying Saucer (HEXA-UFO) — RT-SC-based disc-shape VTOL (design draft)"
  brief = "HEXA-UFO per-domain ledger · sibling of HEXA-UFO.md"
  parent = "dancinlab/hexa-ufo"
  sibling-md = "HEXA-UFO.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HEXA-UFO.md.
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
