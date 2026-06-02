#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "nylon" :: identity-claim [d=2026-05-14 active]
  kind = "나일론 6/6,6 -- 궁극의 n=6 폴리아미드 아키텍처"
  brief = "나일론은 이름 자체가 n=6을 선언하는 폴리머이다. 카프로락탐(6C), 아디프산(6C), 헥사메틸렌디아민(6C) -- 세 단량체가 모두 탄소 6개로 구성되고, 반복단위 전체 구조가 sigma*phi=n*tau 완전수 항등식으로 기술된다."
  parent = "dancinlab/hexa-matter"
  sibling-md = "NYLON.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in NYLON.md.
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
