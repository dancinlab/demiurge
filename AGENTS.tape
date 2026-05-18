#!/usr/bin/env tape
# AGENTS.tape — hexa-arch project governance (SSOT for load-bearing rules)
# tape v1.2. Decision audit trail = design.md (D1..). This file = the
# enforced governance an agent must obey in this repo.

@V := "tape" :: spec [active]
  version = "1.2"

@D g_stdlib_ownership := "stdlib ⊂ hexa-lang ONLY" :: governance [required d=2026-05-18 active]
  rule = "The `stdlib/` namespace belongs EXCLUSIVELY to hexa-lang. hexa-arch is a *consumer* of hexa-lang stdlib — it MUST NOT own or carry a `stdlib/` tree."
  hexa_arch_role = "가져다 쓰는 쪽 (consumer). Absorbed/re-derived reusable hexa-native modules belong in hexa-lang/stdlib/ (rfc_047/048 precedent), referenced from hexa-arch."
  user_directive = "2026-05-18 — 'stdlib 은 오로지 hexa-lang 이 보유 · hexa-arch 는 가져다쓸분'"
  violation_resolved = "design.md D15 applied 2026-05-18: the 6 modules + .stubs migrated to hexa-lang/stdlib/booksim/ (committed hexa-lang d5a63a82, self-tests re-verified GREEN there, unpushed pending hexa-lang review); hexa-arch/stdlib/ git-rm'd. hexa-arch now carries NO stdlib/ tree — rule satisfied. rfc_003 references the hexa-lang location."

@D g3_no_over_claim := "no-over-claim — RETAINED" :: governance [required d=2026-05-18 active]
  rule = "Never assert unmeasured/unproven results. 'absorbed'/'parity'/'resolved' only at a measured gate, filed with cited numbers. SKIP-mode regression banned."
  status = "User requested g3 removal (2026-05-18) — DECLINED (honesty floor, inherited from user identity SSOT). RETAINED per design.md D12."

@D g_clean_room := "public-surface clean-room (D1)" :: governance [required d=2026-05-18 active]
  rule = "External prior art absorbed from public surface only (OSS/arxiv/patents/standards/datasheets/vendor public docs). No closed-binary RE, no license/DRM circumvention."

@D g_decouple := "typed-interface decoupling (D2/D11)" :: governance [d=2026-05-18 active]
  rule = "hexa-bio + comb stay typed-interface-consumed (decoupled siblings). hexa-matter = absorbed exception (D12, domains/matter/). comb SSOT stays hexa-lang; archive/comb = non-SSOT mirror."

@D g_scope := "scope (D10 rescinded → full)" :: governance [d=2026-05-18 active]
  rule = "design-only (D10) RESCINDED per user (D12) — full scope incl. execution/absorption. Still: no-big-bang incremental, hexa-first."

@D g_absorption := "absorption pattern" :: governance [d=2026-05-18 active]
  rule = "Per absorbed tool/repo: one proposals/rfc_0NN_*.md (rfc_047/048 mirror). Clean-room, measured gate, tombstone (archive_ rename + local delete) ONLY after measured-GREEN + dependents + explicit per-step go. Anti-data-loss: push origin before any delete."

@D g_hexa_native := "hexa-native-only (g5)" :: governance [d=2026-05-18 active]
  rule = "Absorb into hexa intrinsics, never shell out — EXCEPT the rfc_048-precedented bounded exception: verbatim-preserved foreign substrate invoked as a documented subprocess, fail-loud (D14 hybrid). Re-derivation to hexa-native is the scheduled follow-on."

@F forbidden := "hard denies" :: governance [required d=2026-05-18 active]
  f1 = "creating/extending a `stdlib/` tree under hexa-arch (g_stdlib_ownership)"
  f2 = "over-claim — asserting unmeasured 'absorbed/parity/resolved' (g3)"
  f3 = "closed-binary RE / license circumvention (g_clean_room)"
  f4 = "silent skip / SKIP-mode regression (g3)"
  f5 = "tombstone (repo rename / local delete) before measured-GREEN + dependents + explicit go"

@N ssot := "where governance + decisions live" :: note [d=2026-05-18 active]
  governance = "this AGENTS.tape (enforced rules + @F denies)"
  decisions = "design.md D1..D14 (gated decision audit trail)"
  arch_why = "CHARTER.md + HANDOFF.md"
  progress = "PLAN.md (append-only log)"
  index = "ARCH.tape"
