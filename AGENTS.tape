#!/usr/bin/env tape
# AGENTS.tape — Demiurge project governance (SSOT for load-bearing rules)
# tape v1.2. Decision audit trail = design.md (D1..). This file = the
# enforced governance an agent must obey in this repo.

@V := "tape" :: spec [active]
  version = "1.2"

@D g_stdlib_ownership := "stdlib ⊂ hexa-lang ONLY" :: governance [required d=2026-05-18 active]
  rule = "The `stdlib/` namespace belongs EXCLUSIVELY to hexa-lang. demiurge is a *consumer* of hexa-lang stdlib — it MUST NOT own or carry a `stdlib/` tree."
  demiurge_role = "가져다 쓰는 쪽 (consumer). Absorbed/re-derived reusable hexa-native modules belong in hexa-lang/stdlib/ (rfc_047/048 precedent), referenced from demiurge."
  user_directive = "2026-05-18 — 'stdlib 은 오로지 hexa-lang 이 보유 · demiurge 는 가져다쓸분'"
  violation_resolved = "design.md D15 applied 2026-05-18: the 6 modules + .stubs migrated to hexa-lang/stdlib/booksim/ (committed hexa-lang d5a63a82, self-tests re-verified GREEN there, unpushed pending hexa-lang review); demiurge/stdlib/ git-rm'd. demiurge now carries NO stdlib/ tree — rule satisfied. rfc_003 references the hexa-lang location."

@D g3_no_over_claim := "no-over-claim — RETAINED" :: governance [required d=2026-05-18 active]
  rule = "Never assert unmeasured/unproven results. 'absorbed'/'parity'/'resolved' only at a measured gate, filed with cited numbers. SKIP-mode regression banned."
  status = "User requested g3 removal (2026-05-18) — DECLINED (honesty floor, inherited from user identity SSOT). RETAINED per design.md D12."

@D g_clean_room := "public-surface clean-room (D1)" :: governance [required d=2026-05-18 active]
  rule = "External prior art absorbed from public surface only (OSS/arxiv/patents/standards/datasheets/vendor public docs). No closed-binary RE, no license/DRM circumvention."

@D g_decouple := "typed-interface decoupling (D2/D11)" :: governance [d=2026-05-18 active]
  rule = "hexa-bio + comb + hexa-matter ALL typed-interface-consumed (decoupled). hexa-matter's absorption SSOT = hexa-lang (already 완전 이관; D17 supersedes the D12 demiurge-absorb — domains/matter/ is a pointer, not a copy). comb SSOT stays hexa-lang; archive/comb = non-SSOT mirror."

@D g_scope := "scope (D10 rescinded → full)" :: governance [d=2026-05-18 active]
  rule = "design-only (D10) RESCINDED per user (D12) — full scope incl. execution/absorption. Still: no-big-bang incremental, hexa-first."

@D g_absorption := "absorption pattern" :: governance [d=2026-05-18 active]
  rule = "Per absorbed tool/repo: one proposals/rfc_0NN_*.md (rfc_047/048 mirror). Clean-room, measured gate, tombstone (archive_ rename + local delete) ONLY after measured-GREEN + dependents + explicit per-step go. Anti-data-loss: push origin before any delete."

@D g_hexa_native := "hexa-native-only (g5)" :: governance [d=2026-05-18 active]
  rule = "Absorb into hexa intrinsics, never shell out — EXCEPT the rfc_048-precedented bounded exception: verbatim-preserved foreign substrate invoked as a documented subprocess, fail-loud. Re-derivation to hexa-native is the scheduled follow-on. Precedents (cited): D14 (hexa-matter python shim, now moot per D17), D18 (Yosys flow re-derived hexa-native + ABC tech-mapping invoked as bounded subprocess; rfc_006 §7)."

@D g_swift_native := "swift = native + canonical patterns first" :: governance [required d=2026-05-19 active]
  rule = "When implementing Swift (rfc_009 macOS cockpit, D22 downstream — and any future Swift inside Demiurge's product-surface boundary): prefer SwiftUI / Foundation / AppKit native idioms and Apple-canonical patterns FIRST. Third-party libraries, custom DSLs, or non-canonical structures require an explicit justification noted in the producing PR — they are NOT default."
  reason = "rfc_009 cockpit is the product surface for honesty-as-feature (D22, g3); applying g5's hexa-native spirit to the Swift dialect = prefer Apple-canonical Swift idiom over bespoke abstractions. Reduces review surface, keeps build/runtime obvious, aligns with rfc_009 §5's g5-unpressured boundary, and matches the andrej-karpathy minimum-new-structure principle."
  applies_to = "rfc_009 cockpit (planned build, D22 downstream session) + any future Swift inside Demiurge's product-surface boundary; precedent reusable for other native-dialect product surfaces if they appear."
  user_directive = "2026-05-19 — 'swift 작성시 구현시 native, canonical 방식 우선 => AGENTS.tape 등록'"
  decision_ref = "design.md D26"

@F forbidden := "hard denies" :: governance [required d=2026-05-18 active]
  f1 = "creating/extending a `stdlib/` tree under demiurge (g_stdlib_ownership)"
  f2 = "over-claim — asserting unmeasured 'absorbed/parity/resolved' (g3)"
  f3 = "closed-binary RE / license circumvention (g_clean_room)"
  f4 = "silent skip / SKIP-mode regression (g3)"
  f5 = "tombstone (repo rename / local delete) before measured-GREEN + dependents + explicit go"

@N ssot := "where governance + decisions live" :: note [d=2026-05-19 active]
  governance = "this AGENTS.tape (enforced rules + @F denies)"
  decisions = "design.md D1..D26 (gated decision audit trail; D15 stdlib ownership, D16 macOS Swift surface, D17 hexa-matter SSOT=hexa-lang, D18 Yosys ABC bounded-subprocess, D19 yosys impl belongs to hexa-lang session, D20 materials→chip seam rfc_007, D21 component = new top-level domain, D22 Phase-4 cockpit spec rfc_009 — build OOS, D23 brand mark = Demiurge / 데미우르지 (paired with Phanes), D24 rename scope = mass replace excl. records, D25 GitHub repo = in-place rename to dancinlab/demiurge, D26 swift = native + canonical patterns first)"
  arch_why = "CHARTER.md + HANDOFF.md (reconciled to D22 on 2026-05-19)"
  goal = "GOAL.md (한 문장 north-star + 정직한 현 위치)"
  progress = "PLAN.md (append-only log)"
  index = "ARCH.tape"
