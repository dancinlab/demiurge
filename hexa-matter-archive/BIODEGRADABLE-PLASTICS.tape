#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "biodegradable_plastics" :: identity-claim [d=2026-05-14 active]
  kind = "BIODEGRADABLE-PLASTICS — Phase D candidate stub"
  brief = "Biodegradable polymers are polymers that decompose under defined conditions (composting, marine, soil microbial) into CO₂ + H₂O + biomass within a defined timeframe (months to a few years)."
  parent = "dancinlab/hexa-matter"
  sibling-md = "BIODEGRADABLE-PLASTICS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in BIODEGRADABLE-PLASTICS.md.
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
