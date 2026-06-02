#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "axis_closure_plan" :: identity-claim [d=2026-05-14 active]
  kind = "AXIS_CLOSURE_PLAN — hexa-matter per-group closure roadmap"
  brief = "- **(a) in-repo software** — closeable by code/test/spec work in this repo; **counts against v1.x closure-grade**. ✅ **100% REACHED 2026-05-13** with the silicon addition (17/17 verbs spec-present, 4/"
  parent = "dancinlab/hexa-matter"
  sibling-md = "AXIS_CLOSURE_PLAN.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in AXIS_CLOSURE_PLAN.md.
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
