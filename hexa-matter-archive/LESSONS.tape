#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "lessons" :: identity-claim [d=2026-05-14 active]
  kind = "LESSONS — hexa-matter v1.0.0 → v1.1.0 construction journal"
  brief = "The 4-script aggregator (`verify/run_all.hexa`) was the right shape:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "LESSONS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in LESSONS.md.
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
