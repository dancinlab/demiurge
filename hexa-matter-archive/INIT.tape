#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "init" :: identity-claim [d=2026-05-14 active]
  kind = "INIT — hexa-matter elevation to hexa-bio level"
  brief = "Elevate `dancinlab/hexa-matter` from a thin 17-verb SPEC_FIRST catalog to the"
  parent = "dancinlab/hexa-matter"
  sibling-md = "INIT.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in INIT.md.
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
