#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "aramid" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate Aramid (HEXA-ARAMID-(HERACRON)) — full n=6 system pass-through"
  brief = "Aramid (Heracron) is a core asset of human civilization. **The strongest fiber for body armor / firefighter gear / aerospace composites. Benzene C6 repeat unit, decomposition at 500 C, tensile 3.5 GPa"
  parent = "dancinlab/hexa-matter"
  sibling-md = "ARAMID.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in ARAMID.md.
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
