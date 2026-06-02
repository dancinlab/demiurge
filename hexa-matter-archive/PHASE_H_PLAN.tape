#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "phase_h_plan" :: identity-claim [d=2026-05-14 active]
  kind = "PHASE_H_PLAN — Category (b) parity-gate landing"
  brief = "Phase A-G shipped the breadth axis (architecture, selftest harness, depth"
  parent = "dancinlab/hexa-matter"
  sibling-md = "PHASE_H_PLAN.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in PHASE_H_PLAN.md.
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
