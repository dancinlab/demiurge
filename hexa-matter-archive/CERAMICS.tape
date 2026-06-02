#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "ceramics" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 세라믹 (HEXA-CERAMICS) — n=6 체계 완전 관통"
  brief = "세라믹(Ceramics)는 인류 문명의 핵심 자산이다. **열/부식/마모 극한 환경 구조재. CN=6 coordination이 결정 안정성의 핵심.**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "CERAMICS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CERAMICS.md.
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
