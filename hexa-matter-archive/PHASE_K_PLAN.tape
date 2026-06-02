#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "phase_k_plan" :: identity-claim [d=2026-05-14 active]
  kind = "PHASE_K_PLAN — Universal-FF runner infrastructure + SIM-NNP-PROXY → SIM-NNP transition path"
  brief = "Phase J.2 vendored 17 SIM-NNP-PROXY snapshots (peer-reviewed proxy values"
  parent = "dancinlab/hexa-matter"
  sibling-md = "PHASE_K_PLAN.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in PHASE_K_PLAN.md.
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
