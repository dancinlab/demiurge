#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "material_synthesis" :: identity-claim [d=2026-05-14 active]
  kind = "N6 Material Synthesis --- 궁극의 물질합성 아키텍처 (통합 문서)"
  brief = "**궁극적 목표: n=6 산술로 원자 스케일부터 범용 합성기까지 관통하는 물질합성 아키텍처**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "MATERIAL-SYNTHESIS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in MATERIAL-SYNTHESIS.md.
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
