#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "closure_residual_backlog" :: identity-claim [d=2026-05-14 active]
  kind = "CLOSURE_RESIDUAL_BACKLOG — hexa-matter (b)/(c) deferral ledger"
  brief = "- **(a) in-repo software** — closeable by code/test/spec work in this repo; **counts against v1.x closure-grade**. ✅ **100% REACHED 2026-05-13.**"
  parent = "dancinlab/hexa-matter"
  sibling-md = "CLOSURE_RESIDUAL_BACKLOG.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CLOSURE_RESIDUAL_BACKLOG.md.
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
