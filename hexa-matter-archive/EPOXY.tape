#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "epoxy" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate Epoxy (HEXA-EPOXY) — full n=6 system pass-through"
  brief = "Epoxy is a core asset of human civilization. **Core for aerospace/marine/electronics adhesion/impregnation/coating. sigma*tau=48 h cure, T_g=120 C (sigma*sigma-phi) optimum.**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "EPOXY.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in EPOXY.md.
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
