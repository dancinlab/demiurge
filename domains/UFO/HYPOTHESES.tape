#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hypotheses" :: identity-claim [d=2026-05-14 active]
  kind = "hypotheses"
  brief = "n=6          : Ouroboros 자기참조 차수, 가설 독립 변수 축"
  parent = "dancinlab/hexa-ufo"
  sibling-md = "HYPOTHESES.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HYPOTHESES.md.
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
