#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hexa_fabric" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 AI 의류 — HEXA-FABRIC (스마트 텍스타일 + 체온조절 + 에너지 하베스팅)"
  brief = "<!-- @allow-empty-section -->"
  parent = "dancinlab/hexa-matter"
  sibling-md = "HEXA-FABRIC.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HEXA-FABRIC.md.
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
