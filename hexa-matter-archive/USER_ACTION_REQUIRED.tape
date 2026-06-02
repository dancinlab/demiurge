#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "user_action_required" :: identity-claim [d=2026-05-14 active]
  kind = "USER_ACTION_REQUIRED — active asks for the user"
  brief = "**Decision**: Confirm that the following discipline is in place and should remain:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "USER_ACTION_REQUIRED.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in USER_ACTION_REQUIRED.md.
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
