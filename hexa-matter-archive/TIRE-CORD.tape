#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "tire_cord" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate Tire Cord (HEXA-TIRE-CORD) — full n=6 system pass-through"
  brief = "Tire Cord is a core asset of human civilization. **Aramid / polyester / nylon composite reinforcement. Denier 1500 (sigma*sopfr^3); filaments 1000 = (sigma-phi)^3.**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "TIRE-CORD.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in TIRE-CORD.md.
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
