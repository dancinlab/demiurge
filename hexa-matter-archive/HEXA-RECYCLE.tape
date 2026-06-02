#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hexa_recycle" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate HEXA Recycle (HEXA-HEXA-RECYCLE) — full n=6 system pass-through"
  brief = "HEXA Recycle is a core asset of human civilization. **Per-element recycling loop systematized in n=6 stages — shred / sort / refine / re-polymerize / mold / resell.**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "HEXA-RECYCLE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HEXA-RECYCLE.md.
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
