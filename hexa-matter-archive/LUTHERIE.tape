#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "lutherie" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 악기/음향 아키텍처 -- HEXA-LUTHERIE"
  brief = "**Rating**: 8/10 -- 기타 n=6줄 + 12음계 sigma + 4/4박자 tau + 옥타브 phi=2배"
  parent = "dancinlab/hexa-matter"
  sibling-md = "LUTHERIE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in LUTHERIE.md.
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
