#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "elastomer" :: identity-claim [d=2026-05-14 active]
  kind = "ELASTOMER — Phase D candidate stub"
  brief = "Elastomers are polymers with long-chain flexibility + cross-linking (covalent or physical) → reversible elastic deformation at room T (typical strain-to-fail 200-1000% with negligible permanent set)."
  parent = "dancinlab/hexa-matter"
  sibling-md = "ELASTOMER.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in ELASTOMER.md.
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
