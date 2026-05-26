#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "todo" :: identity-claim [d=2026-05-15 active]
  kind = "TODO — hexa-aura"
  brief = "v1.0.0 full design DONE. Post-v1.0.0 Cycle 3–6 (2026-05-15): §A.6.1 stage A–D code-layer halves + §A.5 D1/D2/D3 resolved — depth, NOT closure. Remaining = owner-pending + T4."
  parent = "dancinlab/hexa-aura"
  sibling-md = "TODO.md"

@N n_status := "current status (architecture-current)" :: note [d=2026-05-15 active]
  done = "§3 v1.0.0 substrate ✓ ; Cycle 3–6 §A.6.1 stage A–D code-layer halves ✓ ; §A.5 D1/D2/D3 ✓ ; C1 relocation declined ; BENCHTOP.tape created"
  invariant = "depth NOT closure — sat-1 / __HEXA_AURA_RSC_SATURATED__ STOP / falsifier_check 15-sub-ID-OPEN / 100% code-layer 3-tier / run_all green-core 19 all unchanged; never PASS→FAIL"
  pending = "§1 canon ✦KR restore (owner) · §2 hexa-mind/hexa-senses split (owner) · §A.5 D4/D5/D6 (owner/external) · §6 v1.1.0/v1.2.0 cross-verify · T4 §A.6 step 1–5 (hardware/regulatory)"
  hw_path = "T4 detail SSOT → BENCHTOP.tape"

@D d_a5_resolved := "§A.5 D1/D2/D3 resolved" :: decision [d=2026-05-15 active]
  D1 = "pillar CLI dispatch = clip→coil→cortex→safety — @D d_cli_dispatch (AGENTS.tape)"
  D2 = "hexa-rtsc cross-link = single selftest (loose, not full import) — @D d_rtsc_xlink (COIL.tape)"
  D3 = "cortex keeps M1 substrate lane, decode → hexa-brain — @D d_m1_lane (CORTEX.tape)"
  resolves = "TODO.md §8 · .roadmap.hexa_aura §A.5"

@D d_c1_declined := "C1 domain-tape relocation declined" :: decision [d=2026-05-15 active]
  rule = "per-pillar .tape/.log.tape stay at hexa-aura root; per-concept move to owner repos (e.g. COIL.tape→hexa-rtsc) declined."
  why = "user-directed 2026-05-15 (\"재배치는 pass\"); RT-SC material dep already handled by the loose hexa-rtsc cross-link (D2)."

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in TODO.md.
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
