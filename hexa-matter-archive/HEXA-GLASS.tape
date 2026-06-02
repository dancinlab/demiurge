#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hexa_glass" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 AI 안경 — HEXA-GLASS (AR/MR 홀로그램 + 실시간 인지)"
  brief = "**n=6 산술 기반, 렌즈 소재 ~ AR 광학 ~ 시선추적 ~ 실시간 번역 ~ 3D 공간인식까지 관통하는 8단 AI 안경 아키텍처**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "HEXA-GLASS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HEXA-GLASS.md.
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
