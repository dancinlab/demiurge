#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "silicon" :: identity-claim [d=2026-05-14 active]
  kind = "SILICON — extended chapter (material layer)"
  brief = "Silicon is the second-most-abundant element in the Earth's crust (~27.7 % by mass, CRC Handbook 105th ed.). It is the **largest single material input by mass** to the global electronics industry. As a"
  parent = "dancinlab/hexa-matter"
  sibling-md = "SILICON.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SILICON.md.
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
