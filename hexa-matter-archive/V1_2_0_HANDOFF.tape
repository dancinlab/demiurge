#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "v1_2_0_handoff" :: identity-claim [d=2026-05-14 active]
  kind = "V1_2_0_HANDOFF — Phase B-G roadmap (future-facing)"
  brief = "- 17/17 verbs spec-present (silicon was the 17th, added 2026-05-13)"
  parent = "dancinlab/hexa-matter"
  sibling-md = "V1_2_0_HANDOFF.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in V1_2_0_HANDOFF.md.
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
