# RFC 004 — end-to-end design program: 물질합성 → 칩아키텍쳐 → 부품설계 (brainstorm / plan)

> Status: **brainstorm / draft** · 2026-05-18 · design-only (design.md
> D10 — producing a design *plan* is in scope; building it is gated).
> Source: user vision — "물질합성부터 칩아키텍쳐 설계 및 부품설계까지
> 전부 아우르는 프로젝트로, comb 에서 필요한 라이브러리들도 모두 흡수,
> SaaS/Web/GUI". Exhaustive brainstorm requested. One pivotal decision
> (§3, D11) is gated; everything else is plan to react to.

---

## 1. Final goal — restated from SSOT (verbatim anchors)

- CHARTER Mission: *"a hexa-native, domain-pluggable technical-design
  architecture program: SPECIFY→ARCHITECT→DESIGN→ANALYZE⟲→SYNTHESIZE→
  VERIFY(+VALIDATE)→HANDOFF for any engineered system … chip first …
  sibling of hexa-matter / hexa-bio via typed-interface consumption,
  not absorption (D2)."*
- HANDOFF §2: *"Not a chip tool. A universal technical-design
  architecture program … the 7 verbs are domain-neutral … 'Chip' is
  one plug-in domain among many."*
- README 정체: *"📐 만능 설계 아키텍쳐 프로그램 … hexa-arch = 설계
  자체를 계산·검증 (분야 무관 메타프레임워크)."*

**Distilled invariant**: hexa-arch is the domain-neutral 7-verb
*technical-design meta-framework*. It does not compute matter (that is
hexa-matter) or molecules (hexa-bio) — it computes & verifies *the
design itself*, for any engineered system, domains plugged in,
external prior art absorbed clean-room, nothing over-claimed.

## 2. Is the expanded vision a scope change, or a zoom-in? (honest)

**Zoom-in, not a change** — with one pivotal reconciliation (§3). The
user adds three things:

1. **Explicit *chain*** 물질합성 → 칩아키텍쳐 → 부품설계 (in *series*),
   not just parallel independent domains. The 7-verb spine is already
   chainable: a domain's **HANDOFF** verb output is the next domain's
   **SPECIFY** verb input. The vision makes the series wiring explicit.
2. **Absorb comb's full library stack** (not just BookSim2). Already
   the stated plan — HANDOFF §5 maps the whole EDA stack; rfc_001/003
   did NoC-sim; the rest follow the same absorption-RFC pattern (§5).
3. **Product surface** (SaaS / Web / GUI). New dimension — the *design*
   of a delivery surface (§6); building it is gated (D10) like fab.

None of these contradicts the invariant; (1) needs the D2 reconcile.

## 3. ⚖ PIVOTAL DECISION (D11) — how does "전부 아우르는" reconcile with D2?

D2 froze: hexa-matter / hexa-bio are **typed-interface consumed, NOT
absorbed** (decoupled siblings). "물질합성부터 … 전부 아우르는
프로젝트로" can be read two ways:

- **Option A — meta-conductor (recommended).** hexa-arch is the
  *umbrella that orchestrates a chained series of 7-verb domain
  passes*. 물질합성 = the first pass, **consumed from hexa-matter via a
  typed interface** (mirroring rfc_002's F1F2 contract — NOT absorbed,
  D2 holds). 칩아키텍쳐 = next pass (hexa-arch[chip], EDA stack
  absorbed). 부품설계 = next pass (hexa-arch[component]). Each pass's
  HANDOFF → next pass's SPECIFY, all under one hexa-arch program.
  hexa-arch owns: the chain/orchestration, the inter-stage typed
  contracts, and the *per-domain tooling* absorption (EDA, FEM,
  transport…). The *science* siblings (matter/bio) stay decoupled
  providers. = "전부 아우르는 1 프로젝트" via conducting, not swallowing.
- **Option B — monolith re-absorb.** Pull hexa-matter/hexa-bio (and
  every library) into one hexa-arch mega-repo. Contradicts D2,
  no-big-bang, the entire HEXA sibling-family architecture; unbounded
  scope; over-claim risk. **Rejected.**
- **Option C — A + explicit chip-adjacent absorption.** = A, plus
  hexa-arch[chip] absorbs the *EDA libraries comb needs* (Yosys,
  OpenROAD, …) clean-room. This is already the rfc_001/002/003 pattern
  — i.e. C is a *subset of A made explicit*, not a distinct option.

> **RESOLVED 2026-05-18 — D11 = A (meta-conductor). See `design.md`
> Decision 11. D2 preserved (matter/bio typed-interface-consumed);
> B and Defer declined.**

**Recommendation: A** (with C's comb-library absorption as its §5
work-stream). Rationale:
- Delivers the user's "전부 아우르는" literally — one project conducts
  the whole materials→chip→component chain end to end — *without*
  breaking D2, no-big-bang, or the sibling family (the constraint that
  has held all session).
- The 7-verb spine *is* the conductor: chaining = HANDOFF→SPECIFY
  edges. No new mechanism invented; the cited spine already supports
  it. (andrej-karpathy: minimum new structure.)
- Honest scope — hexa-arch absorbs *tooling* it can clean-room +
  measure; it *consumes* mature science siblings via typed contracts
  it cannot honestly re-derive. Keeps g3 no-over-claim intact.
- Reversible & incremental — each chain stage / library is its own
  absorption-RFC; the program grows per-domain, never big-bang.

## 4. The chained meta-pipeline (exhaustive map)

Each box is one **7-verb pass**; the seam between boxes = upstream
HANDOFF feeding downstream SPECIFY via a typed contract (rfc_002-style
per seam).

```
 ┌── hexa-matter ──┐   typed    ┌── hexa-arch[chip] ──┐  typed   ┌── hexa-arch[component] ──┐
 │ 물질합성·소재   │  contract  │ 칩 아키텍쳐 설계     │ contract │ 부품 / 패키지 설계        │
 │ (consumed, D2)  │ ─────────▶ │ (EDA stack absorbed) │ ───────▶ │ (mech/EM/thermal absorbed)│
 │ SPECIFY..HANDOFF│  matprops  │ SPECIFY..HANDOFF     │ netlist/ │ SPECIFY..HANDOFF          │
 └─────────────────┘   record   └──────────────────────┘ GDS/STA  └───────────────────────────┘
        ▲                                ▲                                   ▲
   hexa-matter SSOT              comb (consumer) ▲                    hexa-bio (consumed, bio-adjacent)
   (sibling, typed)              uses chip domain                     packaging biocompat etc.
```

| chain stage | 7-verb owner | external prior art (clean-room absorb) | seam OUT → next SPECIFY |
|---|---|---|---|
| 물질합성·소재 | **hexa-matter** (consumed, D2) | ASE/pymatgen (hexa-matter's own) | material-property record (typed; new rfc) |
| 소자/공정 (device/PDK) | hexa-arch[chip] | SKY130 · SG13G2 PDK | process/cell-lib characterization |
| 칩 아키텍쳐 (NoC/system) | hexa-arch[chip] | **BookSim2 ✅** (rfc_001/003) · gem5 | F1F2 typed record (rfc_002 ✅) |
| RTL → netlist (synth) | hexa-arch[chip] | **Yosys** (rfc planned) | gate netlist |
| 물리설계 P&R → GDSII | hexa-arch[chip] | **OpenROAD ✅ built ubu-1** (rfc planned) | T3 post-P&R record (rfc_002 §pnr ✅) |
| 검증 (sim/formal/STA) | hexa-arch[chip] | Verilator · SymbiYosys · **OpenSTA** | signoff record |
| 아날로그 | hexa-arch[chip] | ngspice | SPICE record |
| 부품/패키지/시스템 | hexa-arch[component] (new domain) | FEM/EM/thermal (FEMM/COMSOL-pub) — already mapped in domains/* | system BoM + thermal/EM dossier |

The 14 Cohort-1/2 domain maps already enumerate the per-domain tool
classes; this RFC wires them into a *series* under one program.

## 5. comb library absorption — full plan (the §C work-stream)

Per HANDOFF §5 + comb `T3_DESIGN_FINAL.md` §3. Pattern = one
`rfc_0NN_<tool>_absorption.md` each, clean-room hexa-native
re-derivation modules, GATE markers, **design-only** (re-derivation +
RFC is the deliverable; full measured parity gated like rfc_003 §B).

| library | role | status | plan |
|---|---|---|---|
| BookSim2 | NoC cycle sim | ✅ rfc_001 + rfc_003 (6 modules, GATE_B_PINNED_MET) | done (design) |
| OpenROAD/ORFS | P&R → GDSII | ✅ built ubu-1; T3 records emitted | rfc_005: clean-room re-derivation *design* (exec gated) |
| Yosys | RTL synthesis | mapped (HANDOFF §5) | rfc_006: absorption design |
| Verilator + cocotb | functional sim | mapped | rfc_007 |
| SymbiYosys | formal | mapped | rfc_008 |
| OpenSTA | timing signoff | mapped | rfc_009 |
| ngspice | analog SPICE | mapped | rfc_010 |
| Chisel/FIRRTL · Amaranth | RTL-gen (DESIGN verb) | mapped | rfc_011 |
| SKY130 · SG13G2 PDK | process node (⊥ resource) | mapped | rfc_012 (cross-cutting) |

All carry: clean-room provenance (D1), `provenance.absorbed=false`
until per-tool measured parity (g3), interpreted-toolchain-throughput
caveat (rfc_003 finding) → execution gated (D10).

> **RFC-number note (honest reconciliation).** The `rfc_007..012`
> above are **indicative projections, not bindings** — RFC numbers
> are assigned at *creation order* (precedent: rfc_002 is itself a
> seam contract sitting among absorption RFCs; rfc_005 was
> repurposed for hexa-matter then SUPERSEDED by D17). Actual:
> Yosys = **rfc_006 ✅** (created, D18/D19); Phase-3 seams took the
> next free numbers — **rfc_007 ✅** materials→chip (`design.md`
> D20), **rfc_008 ✅** chip→component (`design.md` D21). The
> remaining tool absorptions get the next free numbers at creation
> (Verilator → rfc_009, SymbiYosys → rfc_010, OpenSTA → rfc_011,
> ngspice → rfc_012, Chisel/Amaranth → rfc_013, PDK → rfc_014) —
> indicative, re-confirmed when created.

## 6. Product surface — SaaS / Web / GUI (design of, not build of)

> **RESOLVED 2026-05-18 — D16 = native macOS Swift app** (user
> accepts macOS lock-in). Local design cockpit, pure consumer of
> `exports/**.{json,hxc}`; zero server/auth/DB; hexa-native core
> untouched. The public honest-audit surface is **already** the
> public GitHub repo (committed records / design.md / GATE state) —
> so GitHub = public audit, Swift app = local cockpit
> (complementary). WEB's sole edge already covered → Swift is the
> more coherent choice here (ops-free, no sync-gap). Build = still
> downstream. See `design.md` Decision 16. The SaaS/web framing
> below is retained as the rejected alternative for the audit trail.
surface; building/hosting it is a gated downstream (same class as fab).

```
 hexa-native CORE (7-verb engine + absorbed tooling, stdlib/*.hexa)
        │  emits/consumes typed records (HXC v2 / JSON), rfc_002 schema
        ▼
 API layer (typed interface = the ONLY coupling point — like comb)
        ▼
 Web / GUI front  (guided 7-verb workflow · domain plugin picker ·
                   provenance + GATE state shown on every output)
```

Design principles for the surface:
- The front-end is a **consumer of the typed interface** (same decouple
  pattern as comb / D2) — the hexa-native core stays clean; no web
  stack inside the core (hexa-native-only g5 preserved).
- **Honesty is the product feature**: every UI output renders
  `provenance.absorbed`, `measurement_gate` (GATE_OPEN /
  GATE_B_PINNED_MET / …), and citations. The no-over-claim discipline
  becomes the differentiator vs Cadence/Synopsys black boxes.
- The 7 verbs = the guided workflow steps; domains = plugins; the
  chain (§4) = a pipeline canvas. ANALYZE ⟲ = the iterate-back loop in
  the UI.
- vs existing: SysML/Modelica/Cadence are single-domain or
  proprietary-opaque; hexa-arch's surface = domain-neutral + cited +
  honest-gated. (Comparison axis preserved.)

Building it = execution → gated (D10). This RFC = its design only.

## 7. Phasing (all design-only; execution/SaaS-build/parity gated)

- **Phase 0 — DONE**: 7-verb spine (cited) · chip-domain absorption
  design · 14 domain maps · rfc_001/002/003 · characterization records
  · D1–D10.
- **Phase 1**: lock D11 (§3 reading) → formalize the chained
  meta-pipeline (this RFC → accepted design).
- **Phase 2**: comb full EDA-stack absorption *designs* — rfc_005…012
  (clean-room re-derivation modules + GATE markers, per §5).
- **Phase 3**: chain seam contracts — typed inter-stage records
  (material-property contract from hexa-matter, mirroring rfc_002);
  hexa-matter/bio consumer contracts (D2-consistent).
  *(Phase 3 seams DESIGN-COMPLETE — both chain seams drafted at the
  contract level: `materials → chip` = **rfc_007 ✅** (D20),
  `chip → component` = **rfc_008 ✅** (D21, after resolving the §9
  component-domain-shape gate = new top-level domain →
  `domains/component.md`). Both: contract spec + `exports/seams/<>/`
  with records empty by design (g3, distinct honest reasons —
  rfc_007 §5 / rfc_008 §5). Component-domain **internal** sub-staging
  = domain-internal per D21, not gated. NOTE: design-complete ≠
  wired — no record flows, nothing absorbed, g3.)*
- **Phase 4**: product-surface design — API spec + UI/workflow spec
  (rfc_0NN), front-end as typed-interface consumer.
- Each phase = incremental, per-domain, no-big-bang; nothing flips
  `absorbed=true` without measured parity (g3).

## 8. Governance carried (unchanged, explicit)

design-only (D10) · no-over-claim + GATE markers (g3) · hexa-first
(constraints live in hexa-lang → PR-only there; e.g. the
interpreted-toolchain-throughput wall) · absorption-RFC pattern ·
typed-interface decoupling (D2 — *not* re-litigated unless D11=B) ·
no-big-bang incremental · public-surface clean-room (D1).

## 9. Open decisions (gate list)

- **D11 — RESOLVED = A meta-conductor** (`design.md` Decision 11;
  B / Defer declined; D2 preserved).
- D12+ (enumerated): comb-library absorption ordering; product-surface
  tech stack (deferred — execution).
- **Phase 3 seam schemas — RESOLVED**: materials→chip typed contract
  → **rfc_007** (`design.md` D20, v0 draft); chip→component typed
  contract → **rfc_008** (`design.md` D21, v0 draft).
- **hexa-arch[component] shape — RESOLVED = new top-level domain**
  (`design.md` D21 → `domains/component.md`); was the gate the
  chip→component seam depended on.
- **STILL OPEN but NOT gating** (declared domain-internal per D21,
  not a seam blocker): component-domain *internal* sub-staging
  granularity (package vs system sub-passes) — decided inside the
  component domain later, no gate now.

## 10. Cross-references

design.md D1–D10 · CHARTER (Mission, design-only non-goal) · HANDOFF
§2/§4/§5/§9 · rfc_001/002/003 · domains/* (14 maps) · comb
`T3_DESIGN_FINAL.md` (consumer) · README 정체.
