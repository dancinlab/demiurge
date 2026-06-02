#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "novel_roadmap" :: identity-claim [d=2026-05-14 active]
  kind = "NOVEL_ROADMAP — brainstorming ledger for future NOVEL.md rounds"
  brief = "Catalog the candidate design space hexa-matter could populate in future"
  parent = "dancinlab/hexa-matter"
  sibling-md = "NOVEL_ROADMAP.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in NOVEL_ROADMAP.md.
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
