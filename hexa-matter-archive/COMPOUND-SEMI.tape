#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "compound_semi" :: identity-claim [d=2026-05-14 active]
  kind = "COMPOUND-SEMI — Phase D candidate stub"
  brief = "Compound semiconductors are crystalline III-V or II-VI binaries (or ternaries / quaternaries) with electronic / optoelectronic properties distinct from elemental Si. The material layer (bulk crystal g"
  parent = "dancinlab/hexa-matter"
  sibling-md = "COMPOUND-SEMI.md"

@H h_xlink_critical_mineral := "Ga / Ge / In / Te supply concentration" :: cross-link [active d=2026-05-17]
  ?> "[[CRITICAL-MINERAL]]"
  why = "GaAs / GaN / InP / CIGS feedstock concentration (Ga ~98% China, Ge ~60% China) + 2023-08 export controls covered in CRITICAL-MINERAL.tape per-commodity cards; this file owns the device-material spec"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in COMPOUND-SEMI.md.
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
