#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "concrete_technology" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate Concrete Technology (HEXA-CONCRETE-TECHNOLOGY) — full n=6 system pass-through"
  brief = "Concrete Technology is a core asset of human civilization. **UHPC, self-healing, and smart sensing for structural service life 200+ years.**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "CONCRETE-TECHNOLOGY.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CONCRETE-TECHNOLOGY.md.
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
