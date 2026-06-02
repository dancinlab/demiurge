#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "mof" :: identity-claim [d=2026-05-14 active]
  kind = "MOF — Phase D candidate stub"
  brief = "A **Metal-Organic Framework (MOF)** is a crystalline coordination polymer with:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "MOF.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in MOF.md.
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
