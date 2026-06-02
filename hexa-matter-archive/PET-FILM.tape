#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "pet_film" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate PET Film (HEXA-PET-FILM) — full n=6 system pass-through"
  brief = "PET Film is a core asset of human civilization. **Transparent film for packaging/display/electronics. Benzene C6 + ethylene glycol; stretch ratio n=6 (MD 3 x TD 2).**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "PET-FILM.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in PET-FILM.md.
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
