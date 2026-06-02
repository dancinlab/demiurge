#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "metallurgy_deep" :: identity-claim [d=2026-05-14 active]
  kind = "METALLURGY-DEEP — extended chapter (GROUP_MET superalloy + heat treatment)"
  brief = "A **superalloy** is a metal alloy designed for high-T strength, oxidation resistance, and creep resistance at temperatures > 0.7 × T_m (homologous temperature). The three families:"
  parent = "dancinlab/hexa-matter"
  sibling-md = "METALLURGY-DEEP.md"

@H h_xlink_rare_earth := "Sc / Y / Re / Co supply detail" :: cross-link [active d=2026-05-17]
  ?> "[[RARE-EARTH]]"
  ?> "[[CRITICAL-MINERAL]]"
  why = "Al-Sc aerospace (Sc), Ni-MH (La/Ce), Re-superalloy supply concentration covered in RARE-EARTH.tape + CRITICAL-MINERAL.tape; this file owns the alloy metallurgy"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in METALLURGY-DEEP.md.
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
