#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "swordsmithing" :: identity-claim [d=2026-05-14 active]
  kind = "도검 제작 — HEXA-Swordsmithing 설계 목표"
  brief = "<!-- @allow-empty-section -->"
  parent = "dancinlab/hexa-matter"
  sibling-md = "SWORDSMITHING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SWORDSMITHING.md.
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
