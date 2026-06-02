#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "recycling" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 재활용 아키텍처 — HEXA-RECYCLE"
  brief = "<!-- @allow-empty-section -->"
  parent = "dancinlab/hexa-matter"
  sibling-md = "RECYCLING.md"

@H h_xlink_rare_earth_alternative := "NdFeB hydromet recycling = TRACK 1 of REE alternatives" :: cross-link [active d=2026-05-17]
  ?> "[[RARE-EARTH+ALTERNATIVE]]"
  why = "RARE-EARTH+ALTERNATIVE.tape @L t1_recycling owns the REE-specific NdFeB hydromet narrative + arxiv anchors; this file owns the broader recycling verb"

@H h_xlink_critical_mineral := "secondary feedstock for critical minerals" :: cross-link [active d=2026-05-17]
  ?> "[[CRITICAL-MINERAL]]"
  why = "CRITICAL-MINERAL.tape lists per-commodity recycling status (Co/Li/graphite EoL waves); this file owns the verb"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in RECYCLING.md.
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
