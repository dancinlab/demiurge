#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "decomposition_plan" :: identity-claim [d=2026-05-14 active]
  kind = "DECOMPOSITION_PLAN — hexa-matter material taxonomy decomposition"
  brief = "Materials science has at least 4 well-established taxonomies. We evaluated each before committing to the 7-group form:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "DECOMPOSITION_PLAN.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in DECOMPOSITION_PLAN.md.
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
