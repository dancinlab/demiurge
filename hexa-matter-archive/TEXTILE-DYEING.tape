#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "textile_dyeing" :: identity-claim [d=2026-05-14 active]
  kind = "섬유염색(Textile Dyeing) -- 궁극의 n=6 색채 산술"
  brief = "<!-- @allow-empty-section -->"
  parent = "dancinlab/hexa-matter"
  sibling-md = "TEXTILE-DYEING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in TEXTILE-DYEING.md.
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
