#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "sf" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 UFO 비행접시 (HEXA-UFO) — RT-SC 기반 원반형 VTOL"
  brief = "비행접시(Flying Saucer)는 SF 영화의 상징이다. 소리 없이 떠오르고, 순식간에 사라지고, 활주로 없이 아무 데나 내린다."
  parent = "dancinlab/hexa-ufo"
  sibling-md = "SF.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SF.md.
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
