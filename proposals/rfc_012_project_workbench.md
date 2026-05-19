# rfc_012 — Project workbench (cockpit evolution: viewer → workbench)

> Status: **DISCUSSION COMPLETE** (2026-05-19) — §8's seven open
> questions are all resolved through step-by-step discussion. Still
> NOT locked: no `design.md` decision, no governance change, no code
> yet — `design.md` decision-lock + implementation are a separate
> step (the user has been running this in discussion-only mode).
> Builds-on: `rfc_009` / `rfc_010` / `rfc_011` (the cockpit so far —
> a read-only record viewer). This RFC is the discussion of turning it
> into a project workbench.

---

## 1. Purpose

Through `rfc_009`–`rfc_011` the cockpit is a **read-only viewer** of
existing `exports/**` records. The user (2026-05-19) redirected:

> "프로젝트 생성이 있어야 하고 / 어떤 것을 개발할건지 / 유저한테
> 프로젝트명 입력받아 생성 / + 버튼 필요 / 이 프로그램은 일반인도
> 이해하고 사용하기 쉬울 정도가 필요해"

So the cockpit must become a **project workbench**: the user creates
a named project, picks what to design, and runs it through the 7-verb
spine — and a non-expert must be able to understand and use it.

---

## 2. "Project" — a new concept

demiurge's data model so far = records · decisions · RFCs · domains
(all *pre-existing artifacts*). A **project** is a NEW unit — something
the *user creates*:

```
project = {
  name          유저 입력 (e.g. "우리 회사 칩")
  target        무엇을 설계 (도메인 / 목표)
  verbProgress  7-verb 진행 상태 (명세→…→인계 어디까지)
  records       이 프로젝트가 생성한 typed records
}
```

vs the hexa-family: a project is *scoped work inside demiurge*, not a
sibling repo. One project = one 7-verb run over one design target.

---

## 3. Single screen + in-place `+` button (user-resolved)

The user resolved: **NO separate "pick a project" screen.** There is
ONE screen (the workbench, §5); the `+` button lives *inside* it and
both creates and switches projects. `+` location = **④ top toolbar**
(resolved — §5 ASCII).

`+` flow (project creation):

```
④ [+] click
   → "새 프로젝트 이름은?"        user types a project name
   → "무엇을 만들고 싶으세요?"    user types FREE TEXT (plain words)
   → 🍳 LLM infers the domain, e.g. "칩 설계 프로젝트군요 — chip
        도메인으로 시작할게요 — 맞나요? [네 / 바꾸기]"
   → user confirms (or corrects) the domain
   → ② workbench opens on verb 1 (명세 / SPECIFY)
```

**"무엇을 설계" = option C (user-resolved 2026-05-19): free text →
AI infers the domain → user confirms.** The user never has to know
the 15 domain names (`cern` / `rtsc` / …); they describe the goal in
plain words and the LLM maps it to a domain, which the user then
ratifies. (Rejected: A — pick from a 15-domain menu, non-experts
don't know the names; B — free text only, the system can stall when
it cannot resolve a domain. C keeps A's determinacy via the confirm
step and B's friendliness via free input.)

g3 note: the AI *infers* but never *finalizes* the domain — the user
[네/바꾸기] confirm step keeps the human as the authority.

---

## 4. Plain-language layer (일반인용)

demiurge's thesis is honesty (`g3` — no claim before measurement),
but a non-expert does not read `GATE_OPEN` / `provenance` / `F1F2`.
The honesty stays; only the *wording* becomes plain:

| expert term            | plain wording (proposed)              |
| ---------------------- | ------------------------------------- |
| `GATE_OPEN`            | ⏳ "아직 측정 안 됨"                   |
| `GATE_CLOSED_MEASURED` | ✅ "측정으로 확인됨"                   |
| `GATE_B_PINNED_MET`    | 🔶 "일부만 측정됨"                     |
| `absorbed: false`      | "참고용 · 검증 전"                     |
| `provenance`           | "이 결과를 믿어도 되는 이유"           |
| 7-verb (명세→…→인계)   | "7단계: 무엇을→어떻게→설계→점검→만들기→검증→넘기기" |

→ honesty = a **signal light** (⏳ / 🔶 / ✅). Plain on the surface,
g3-honest underneath.

**Expert toggle (resolved — option B):** default = plain language; a
toggle (④ top toolbar) reveals the raw `GATE_*` / `provenance` /
`F1F2` verbatim. OFF by default — non-experts never encounter it; an
expert flips it ON to verify provenance directly (g3's public-audit
principle — verification must stay possible). The §4 mapping above is
bidirectional; the toggle only picks which side is shown. (Rejected:
A plain-only — blocks expert verification, weakens g3; C always-both
— clutter that distracts the non-expert.)

---

## 5. Layout — single workbench, 3 columns; ② is widest & split

User-resolved (2026-05-19, refined across several turns). Key insight:
**area ≠ driver.** The chat is narrow but DRIVES the project; ② is
the widest because it SHOWS the result.

- **① recipe rail (7-verb)** — NARROW, leftmost.
- **③ LLM chat (cooking teacher)** — NARROW, centre. The project
  advances *through this conversation*; honesty signal light (§6)
  renders inline in replies.
- **② work zone** — WIDEST, rightmost — split top / bottom:
  - **② top (short) = ingredient shelf** — plain UI option pick;
    "[냄비에 넣기]" feeds the selection into the next chat turn.
  - **② bottom (main, largest) = result visualization** — 3D
    rendering (RealityKit ComponentView3D), charts, record views —
    where the design's result is shown.

**Cooking metaphor (product voice):**
- **③ chat = the cooking teacher** — stands narrow at your side and
  *directs*; small on screen, but the dialogue is what *moves* the
  project.
- **② bottom = the big plate on the bench** — the largest area; the
  dish being cooked (3D render / work result) is laid out here.
- **② top = the ingredient shelf** — a short strip; pick ingredients
  (options) and drop them in.
- **① = the recipe card on the wall** — which of the 7 steps.

```
┌──────────── ④ 상단: 프로젝트명 + 7단계 진행바 ──────────────┐
│  [+]  칩 A ▾   [무엇을]─[어떻게]─[설계]─◉해석─[합성]─…      │
├──────┬────────────┬──────────────────────────────────────────┤
│ ①    │ ③ chat     │ ② work zone (widest) ★                  │
│narrow│ (narrow)   │ ┌─ ② top: ingredient shelf (short) ────┐ │
│recipe│ cooking    │ │ ○22nm ○7nm  ○mesh ●hex   [냄비에 넣기]│ │
│rail  │ teacher    │ └──────────────────────────────────────┘ │
│무엇✅│ (LLM)      │ ┌─ ② bottom: MAIN (largest) ────────────┐│
│어떻✅│ 👨‍🍳 …     │ │  🧊 3D render · charts · record views  ││
│설계◉│ 🙋 …       │ │     ┌──────┐                           ││
│해석  │ 👨‍🍳 …⏳   │ │     │ ╱╲   │  exploded 3D / 결과 시각화 ││
│합성  │ [입력…]    │ │     │ ╲╱   │                           ││
│검증  │            │ │     └──────┘                           ││
│인계  │            │ └────────────────────────────────────────┘│
└──────┴────────────┴──────────────────────────────────────────┘
  narrow   narrow              widest (top shelf + bottom main)
```

- **① (leftmost, narrow)** — 7-verb recipe; done ✅ / current ◉ /
  upcoming (grey).
- **③ (centre, narrow) — LLM chat** — the cooking teacher; rfc_011
  chat + θ Claude Code CLI; drives the project; ⏳/🔶/✅ inline.
- **② (rightmost, WIDEST) — work zone**, split:
  - *top strip* — ingredient shelf (option pick → next chat turn).
  - *bottom (largest)* — result visualization: 3D render
    (ComponentView3D), latency charts, record views, …
- **④ (top)** — `+` button · project switch · 7-step progress bar ·
  light/dark.

Why area≠driver: demiurge's GOAL is a *meta-conductor* — a conductor
works by *direction* (the narrow chat), while the orchestra's output
(the wide ② bottom) is what fills the hall. The cockpit is a place you
*converse a design into being*, and watch the result take shape on the
big plate.

---

## 6. Honesty preserved — the signal light

The plain-language layer (§4) MUST NOT weaken `g3`. Rules:
- the signal light is sourced from `provenance.measurement_gate`
  VERBATIM — the UI never upgrades ⏳ to ✅.
- "측정으로 확인됨 ✅" appears ONLY for `GATE_CLOSED_MEASURED`.
- a project with zero measured records shows ⏳ everywhere — honest.
- AI 도우미 reply asserting ✅ without a backing record = REJECTED
  (`@F f6`, rfc_011 §4.2).

---

## 7. Data model — where projects live (resolved — option C)

**Two data kinds, two homes** (user-resolved 2026-05-19):

- 🗄 **project manifest** — name · what-to-design · 7-verb progress
  state. This is the **cockpit's own work-state**, NOT an `exports/`
  record. It lives OUTSIDE `exports/`, at the macOS app-data standard
  location:
  `~/Library/Application Support/lab.dancin.demiurge/projects/<name>/`

- 📸 **records the project produces** (F1F2 etc.) — D7
  producer-owned; written to `exports/` by the **AI agent** (Claude
  Code CLI, θ) under `@D g_ai_agent_action_surface` (D34). The
  cockpit *triggers*, the agent *produces* — never the cockpit
  directly.

→ `@D g_cockpit_isolation` stays intact — it is the *records honesty
boundary*; the manifest is the cockpit's app-state, *outside* that
boundary. The rule will get a one-line clarification (same pattern as
D41's a-records / a-docs split): a new clause permitting the cockpit
to write its **own app-state** under Application Support — explicitly
NOT `exports/`.

(Rejected: A — cockpit writes `exports/` directly: kills invariant
(d) + a g3 risk, the cockpit could mint records without a measurement
gate. B — agent-mediate even the manifest: a Claude Code subprocess
per trivial manifest write is overkill.)

**Project ↔ records ownership (resolved — option C):** a project
OWNS only the records its OWN 7-verb run produces. The ~50 existing
`exports/` records (rfc_001–003 NoC measurements) are **viewable as
reference** in the ② work zone — the cockpit's original viewer role
— but are **never folded into** the project. This keeps provenance
1:1 (each record traces to exactly one producing project). (Rejected:
A — own-only with no reference view, discards measured assets; B —
auto-fold existing records into the project, blurs which record
belongs to which project and weakens g3 provenance tracing.)

---

## 8. Open questions

### Resolved during discussion (2026-05-19)

- **`+` button location** → ④ top toolbar (§3, §5).
- **"무엇을 설계"** → option C: free text → AI infers domain → user
  confirms (§3).
- **① sidebar = 7-verb stages** → yes; ① is the narrow 7-verb recipe
  rail (§5). Chat became its own narrow centre column ③; the Artifact
  browser folds into ② work zone (a result-visualization mode).
- **Layout** → 3-column, ② widest & split (§5).
- **project data location + governance** → option C: manifest in
  `~/Library/Application Support/lab.dancin.demiurge/projects/`
  (outside `exports/`); records via the AI agent into `exports/`;
  `@D g_cockpit_isolation` gains a cockpit-app-state clause (§7).
- **expert mode** → option B: plain language by default, a ④-toolbar
  toggle reveals raw `GATE_*` / `provenance` / `F1F2` (§4).
- **project ↔ existing records** → option C: a project owns only the
  records its own 7-verb run produces; the ~50 existing `exports/`
  records are viewable as reference, never folded in (§7).
- **what "develop" means per verb** → option C: verb stages advance
  by conversation/planning by default; a "실제로 돌리기 / run for
  real" action invokes the real tool via θ-2 (the rfc_011 scoped
  AI-agent action dispatch). Un-run stages stay ⏳; only a θ-2 run
  with a measured record turns a stage ✅ (§6 signal light, g3).
  (Rejected: A design-only — never measures, fails GOAL's "compute &
  verify the design itself"; B always-auto-run — a Yosys/OpenROAD
  call on every verb entry, rate-limit blowup, P-④'s lesson.)

### Still open

(none — all seven resolved 2026-05-19.)

---

## 9. State — discussion complete, not yet locked (g3)

§8's seven questions are all resolved through step-by-step
discussion. But this is STILL not built:
- no `design.md` decision is locked (the resolved §8 picks would
  become a batch of `### Decision N` blocks — D42.. — when the user
  says go);
- no governance changed (§7 needs a `@D g_cockpit_isolation`
  cockpit-app-state clause; the workbench needs the existing
  `@D g_ai_agent_action_surface` for records);
- no code written — the cockpit is still the rfc_009–011 read-only
  viewer (commit `1a6da4c`).

So rfc_012 is a *complete design* awaiting an explicit lock+build
go-ahead — same DESIGN/build separation as rfc_009 (D22) and the
phase-α..ι sequence. Honest position: the project-workbench is
fully designed on paper, zero of it is built.

---

## 10. Cross-references

- `rfc_009` / `rfc_010` / `rfc_011` — the cockpit as built so far
- `design.md` D22 / D27–D41 — cockpit decision audit trail
- `AGENTS.tape` `@D g_cockpit_isolation` (the read-only invariant this
  RFC's §7 must reconcile) · `@D g_ai_agent_action_surface` (D34 —
  the producer-mediation pattern §7 likely reuses)
- `GOAL.md` — 7-verb spine; honesty-as-feature (§6 must preserve)
- `cockpit/references/` — Quiver (rfc_010) + BIPV + the Electron
  news-app screenshot (icon-rail reference, now superseded by
  `.sidebarAdaptable` per commit `1a6da4c`)
