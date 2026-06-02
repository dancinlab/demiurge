#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "superalloy" :: identity-claim [d=2026-05-14 active]
  kind = "SUPERALLOY — Phase D candidate stub"
  brief = "A separate `superalloy/` verb (vs the existing `metallurgy/` verb) is justified because:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "SUPERALLOY.md"

@H h_xlink_critical_mineral := "Co / Re / Ni / W feedstock concentration" :: cross-link [active d=2026-05-17]
  ?> "[[CRITICAL-MINERAL]]"
  ?> "[[RARE-EARTH]]"
  why = "Co (DRC mining + China refining 70%), Re (Chile + Kazakhstan), W (China ~80%), and trace REE alloying covered in CRITICAL-MINERAL.tape + RARE-EARTH.tape; this file owns the alloy spec + creep / oxidation parity gates"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SUPERALLOY.md.
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
