#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hexa_hover" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 호버보드 (HEXA-HOVER-BOARD)"
  brief = "HEXA-HOVER-BOARD는 n=6 완전수 구조를 축으로 삼아 물리/공학 한계를 돌파한다. 핵심 5가지:"
  parent = "dancinlab/hexa-ufo"
  sibling-md = "HEXA-HOVER.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HEXA-HOVER.md.
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
