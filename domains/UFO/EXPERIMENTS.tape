#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "experiments" :: identity-claim [d=2026-05-14 active]
  kind = "Integrated Experiment Pipeline (HEXA-EXPER)"
  brief = "HEXA-EXPER uses the n=6 perfect-number structure as its axis to push through physical and engineering limits. 5 highlights:"
  parent = "dancinlab/hexa-ufo"
  sibling-md = "EXPERIMENTS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in EXPERIMENTS.md.
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
