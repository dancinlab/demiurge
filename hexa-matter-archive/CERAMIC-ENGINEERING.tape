#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "ceramic_engineering" :: identity-claim [d=2026-05-14 active]
  kind = "CERAMIC-ENGINEERING — extended chapter (GROUP_CER deep dive)"
  brief = "The term \"engineering ceramic\" (also called \"advanced ceramic\" or \"technical ceramic\") distinguishes from \"traditional ceramic\" (whiteware, refractories, brick). The differences:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "CERAMIC-ENGINEERING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CERAMIC-ENGINEERING.md.
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
