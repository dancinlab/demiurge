# NEXT_SESSIONS — historical log

Spec at [`./NEXT_SESSIONS.md`](./NEXT_SESSIONS.md). Log entries below preserve session-by-session evolution; the spec file holds only the current confirmed state.

## Log

- 2026-05-19 — created. 3 forward-handoff prompts (P-②③ hexa-lang
  yosys+push, P-④ chip measurement, P-⑤ Swift cockpit build).
  Each is 0-context cold-readable, names its gate, and forbids the
  matching over-claim path. Companion to `HANDOFF.md` §10 RESUME
  (which is the *demiurge session* pickup; this file is for the
  three downstream sessions demiurge's 4-Phase design enables).
- 2026-05-19 — **P-⑤ partially executed + P-⑥ added.** The cockpit
  build session (P-⑤) was actually run this session: cockpit/ is a
  built SwiftPM package — phases α / α-2 / α-3 / β / γ / δ / η-1 all
  measured-green (`swift run` verified, commits e601e5b → 56f900a).
  The remaining phases were handed off as **P-⑥**.
- 2026-05-19 — **P-⑧ added** (user intent). Once the workbench is
  complete, hexa-rtsc / hexa-antimatter / hexa-cern / hexa-ufo are to
  be run through demiurge for real verification → a baseline library.
  Recorded as a post-completion handoff.
- 2026-05-19 — **P-⑧ updated** — user confirmed the four are sibling
  repos under `~/core/hexa-*` (cross-repo, like hexa-lang). `hexa-ufo`
  TBD resolved (sibling repo, no demiurge domain map yet). One TBD
  remains: the exact form of "기본 라이브러리".
- 2026-05-19 — **κ-17 — sibling-repo 인식 철회 (user correction
  "hexa-lang 이 모두 stdlib / hexa-lang/component 나")**. The κ-16
  B-track sibling code was a wrong assumption — `~/core/hexa-<id>`
  directories exist on disk but are NOT SSOT; the single hexa-lang
  repo holds every domain's stdlib (booksim/matter pattern; component
  belongs at `~/core/hexa-lang/component/`). Removed
  Domain.siblingRepoPath / siblingRepoExists, NewProjectSheet
  sibling banner, cli show-project sibling_repo line. NEXT_SESSIONS
  Tracks B withdrawn, F path corrected, P-⑨ heading corrected.
  AGENTS.tape user_directive carries the 정정 line.
- 2026-05-19 — **hexa-lang = sole SSOT (user directive)** + **two-
  prompt collapse**. AGENTS.tape `g_stdlib_ownership.user_directive`
  gains the 2026-05-19 강화 line. The cross-repo tracks collapse to
  two prompts: D + E live in the SAME `~/core/hexa-lang` session
  (engine tools + measurement producers all there), F is the
  `~/core/hexa-component` session (P-⑨). Tracks matrix updated.
- 2026-05-19 — **P-⑨ added** (user "각각 프롬프트줘"). The F track
  (ι-2 component USDZ) now has its own cold-readable handoff prompt
  at P-⑨. D track is P-②③, E track is P-④ (both already present).
- 2026-05-19 — **Tracks matrix added** (user "갈래 모두 기록"). All
  six tracks A/B/C/D/E/F catalogued under "Tracks" at the top of
  this file, classified 🟢 demiurge-internal vs 🟡 cross-repo, with
  current state per track.
- 2026-05-19 — **P-⑦ all closed** (κ-11..κ-16). Open follow-ups
  marked ✅; the ζ dependency-graph half stays deferred (workbench
  value unclear). sibling-repo awareness added as κ-16 —
  `Domain.siblingRepoPath` / `siblingRepoExists` in DemiurgeCore, and
  NewProjectSheet + `cli show-project` surface the `~/core/hexa-
  <domain>` pointer (P-⑧ groundwork). **P-⑧ working definition** for
  "기본 라이브러리" landed (`hexa-*` × 7-verb → `exports/<domain>/
  baseline/`) — provisional, awaiting user confirm. D / E / F
  unchanged: `d5a63a82` still unpushed (hexa-lang session), chip §B
  still GATE_B_PINNED_MET, exports/ holds zero USDZ.
- 2026-05-19 — **cockpit workbench built (κ-1..κ-10) + P-⑦ added.**
  After P-⑥ closed, rfc_012 (project workbench) was discussed,
  locked (design.md D42..D50), and built as cockpit phases
  κ-1..κ-10 — all measured-green, `/Applications/demiurge.app`
  installed. Header / P-⑤ / P-⑥ NET updated to reflect this; P-⑦
  added for the demiurge-only workbench follow-ups (ingredient-shelf
  real data, REJECTED-guard hardening, expert-mode depth, phase ζ).
  Cross-cutting D-range note pointer-ized per @D g_ssot_single_source.
- 2026-05-20 — **H-1..H-7 added** (Track E: cross-session star-
  session handoffs). After κ-49 swept ROI 1→18 (잔여=0 substrate
  side) + κ-51 cern+synth absorbed=true flip + κ-52 SSOT reconcile,
  the *next* gating step is the heavy install + measurement parity
  rounds that κ-47..κ-49 honest-skipped. 7 cold-readable handoffs
  filed: H-1 hexa-lang live-tree re-align (unblocks all others) ·
  H-2 Geant4 (3-cell mc_transport parity) · H-3 OpenMC + ENDF/B-
  VIII.0 (energy+verify / fusion+verify) · H-4 CARLA + Unreal
  (mobility+verify, Linux-only) · H-5 Drake (bot+verify Lyapunov/
  SOS) · H-6 CalculiX + GetDP (component+analyze / rtsc+verify) ·
  H-7 firmware D73 7-verb QEMU mps2-an385 first end-to-end. Each
  carries Verification + Touches; none may flip `absorbed=true`
  without a cited parity record. Companion to existing P-* (which
  remain unchanged — design / build sessions, not measurement
  sessions).
- 2026-05-19 — **P-⑥ CLOSED** (goal "NEXT_SESSIONS.md 100% closure").
  θ landed measured-green (commit `50e9a41` — chat → `claude -p`
  subprocess dispatch). The other four P-⑥ items reached a definite
  state: η-2 merged into θ (the `claude` CLI covers conversational
  prompts — no separate API path needed); γ-2 resolved (γ's
  kind-aware MarkdownView is functional; a full Artifact protocol is
  premature abstraction — not pursued); δ-2 resolved scope-reduced
  (Data redundant, Citations already in ProvenanceBanner,
  DEPENDENCIES → phase ζ); ι held open on a downstream-DATA gate
  (zero USDZ/STL records in exports/ — opens when a component-domain
  producer emits geometry). NET: every P-* in this file is now in a
  definite terminal state — P-②③ / P-④ are cross-repo / heavy
  sessions correctly handed to their own sessions; P-⑤ executed;
  P-⑥ closed. Genuinely-open cockpit work = θ-2 (scoped-tool action
  dispatch) + ι (3D data) + ζ (filters/dep-graph), each with a
  definite gate. Nothing silently unfinished.
- 2026-05-20 — **κ-66/κ-67 close + P-⑩/P-⑪/P-⑫ added**. D80
  `g_hexa_only` ultimate-form sweep closed at **13 hexa-native
  pilots / 339 cumulative parity assertions** (PILOTS.demi 13 rows
  · #1..#11 + concurrent-branch entries) across `solar · mc_
  transport · neural_lif · graph_bfs · urdf_fk_2link · plasma_
  metrics · orbital_kepler · dft_naive · event_queue · transport_
  kinematics · breaker_trace_reduce · fem_bar1d_subset · autodiff_
  dual_forward`. Five `.demi` SSOTs consolidated under `domains/`
  (`INDEX · DEPENDENCIES · PRODUCERS · PILOTS · SUBSTRATE_LINKS`)
  — every kernel / producer / dependency / pilot / cross-substrate
  link reads from declarative SSOT via DemiParser loaders (D86
  `g_no_hardcoded_data` 정합). Decision sweep D87..D100 audited the
  consolidation: `.demi` location (D87) · DEPENDENCIES.demi move
  (D88) · `allHardcoded` fallback removal (D89) · PILOTS.demi
  8-field schema (D90) · row=kernel granularity (D91) · flat dir
  layout (D92) · pattern-pilot ↔ PILOTS dual-source (D93) ·
  parity_ref = PilotLoader.find (D94) · `isHexaNativeAbsorbed`
  computed (D95) · sibling sub-domain narrative (D96) · 3-tier
  link-integrity verifier (D97 / Q3 = A) · DEPENDENCIES ↔ PILOTS
  dual-source CI (D98) · cockpit HexaNativeParityChip (D99) ·
  non-sibling narrative reverse (D100). **RFC 013 PARTIAL-LAND**
  (`proposals/rfc_013_hexa_native_parity_connection.md`, κ-67) —
  schema half (demiurge `5e9f6dea`) wires `HexaNativeParityRef` +
  5 cell-record carriers + `GateType.hexaNativeFuture` + Dependencies
  Loader; producer-side emit + live `DEPENDENCIES.demi` mirror +
  `illustrative-physics` gate first-class are queued as §6
  follow-on (covered by P-⑩ below). Header refreshed (origin/main
  `f28c1b0` · hexa-lang `170f74af`). State summary at H-* branch-
  out refreshed — H-2 / H-6 first substrate records cited, H-3
  blocked note added. Three new prompts:
  * **P-⑩** — *originally* κ-67 producer-emit + live mirror (RFC 013
    §6) — three sub-jobs all LANDED (① producer-emit `efa4afe`,
    ② live mirror `47bf504`/`e451037`, ③ `.illustrativePhysics`
    gate `f9a9a90`). κ-67 closure `eea2804` D108. **Refreshed
    (post-κ-67) to κ-68 — per-cell measured-oracle parity round
    (RFC 013 §6.11)** · four steps G27..G30 (ARCH §11.4 Round 7
    scaffold). cell = Energy/solar (`inbox/notes/k68-cell-pick-
    2026-05-21.md`). g3 floor: stored `absorbed: Bool` 의 첫
    legitimate flip 은 cell-side measured oracle PASS 근거로만 —
    D95 computed projection 재사용 금지 (D103 separation).
  * **P-⑪** — bio domain D80 pilot full sweep. bio is the ONE
    demiurge domain still mid-port (D100 "D80 pilot WEAVE"
    narrative) — T3 `.py → .hexa` per `hexa-lang/stdlib/PLAN.md`;
    sibling `~/core/hexa-bio/` only, no `stdlib/bio/` subtree yet.
    Session ports one bounded kernel (Needleman-Wunsch / FASTA
    parse — molecular-dynamics NOT) + files PILOTS.demi row +
    optionally seeds bio into SUBSTRATE_LINKS.demi once link-ready.
  * **P-⑫** — Q3 advisory cross-cohort follow-up + chem substrate
    growth. D97 Tier ③ (`advisory_prereqs` cross-cohort) is
    currently warn-only with drift=0; session inspects future
    drift + decides per-row (patch / document / re-design). chem
    substrate seed (`stdlib/kernels/chem/arrhenius_kernel`,
    hexa-lang `78aee88d` 6/6 PASS · demiurge `3215cea` narrative
    update) landed but PILOTS.demi has no chem row yet — session
    files the first chem pilot row + watches 2nd-consumer rule +
    sibling-seed gate. Both sub-jobs are gate-watching — neither
    flips `absorbed=true` from substrate-parity alone.
- 2026-05-21 — **κ-68 close + κ-69 opening · P-⑩ historical-marked
  + P-⑬ added**. κ-68 (per-cell measured-oracle parity round)
  4-fold full land 이 한 사이클로 마감 (`80a1664` closure commit · RFC
  013 §6.11 `MOSTLY-LANDED` → `LANDED` · Energy/solar 첫 cell
  `absorbed=true` legitimate flip · D110 · hexa-lang `b8d35920`
  PR #259 MERGED · mean rel_err 0.0499 vs 0.05 PASS · 480 clear-sky
  samples NREL MIDC SRRL Golden CO · G30 Stage 1 `fee34cc` XCTest
  invariant LANDED). P-⑩ 본문은 **historical reference** (κ-68
  closure marker block 추가) — κ-69 horizon 은 새 P-⑬ 로 분리.
  같은 cycle 에 κ-69 opening 이 함께 land — ARCH §11.4 Round 8
  scaffold (G31..G34) pre-code 박힘 (`5897572`) + ARCH §12 신설
  (chip §B substrate-axis 잔여 로드맵 이관 from rm'd YOSYS.md ·
  `e7371be` · Tier-1/2/3 · 8-16 session est · detail SSOT =
  `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`) + §12.1
  PR state drift 정정 (`984c2d4` · cross-repo audit triggered ·
  PR #260→#261 first area>0 + PR #255 OPEN not MERGED + PR #256
  inbox patch 정정) + **G31a wrapper half landed** (`8b46c95` ·
  κ-69 first cross-repo partial-land · hexa-lang PR #263 OPEN ·
  `740964a0` · `stdlib/energy/_solar_position_cli.hexa` 64-line
  CLI · parity Δ≈0.002° vs pvlib 0.13.0 noon Phoenix · isolated
  worktree `~/core/hexa-lang-g31` pattern). P-⑬ 4 open axes:
  * **(a) G31b** — Energy/solar producer integration (1-2 session ·
    hexa-lang PR #263 merge gate · `nrel_midc_pyranometer.py` swap +
    480-sample mean rel_err 유지 verify + `bridgeStack` 갱신). 본
    update 시점에서 isolated worktree 측 background 진행 중.
  * **(b) G32** — 다음 cell pick + measured-oracle source 5-fold
    decision (design.md D111 · 0.3-0.5 session · code 0 ·
    Aura / Ufo non-illustrative / Energy `wind` 후보).
  * **(c) G33** — G32 cell 첫 `absorbed=true` legitimate flip
    (2-4 session · `MeasuredOracleRef` schema 재사용).
  * **(d) G34** — G30 Stage 2 constitution.md governance row
    (`.specify/memory/constitution.md` populate 후 · 0.3-0.5 session).
  κ-69 별 axis: chip §B substrate-axis (§12.1 (e) fifo_mem RTLIL
  Memory emit) 은 hexa-lang sibling repo 측에 **다른 agent 가 활성
  작업 중** — 본 세션은 이 axis 미접촉. landing-axis distinction
  (D80 §0 endpoint rule) 으로 §11.4 G-round (measurement-parity)
  ↔ §12 substrate-axis 가 별 gate.
