# 🌌 COSMOS — demiurge web GUI (alias: "도메인 우주 / 만들기 지도")

@title: 🌌 COSMOS — 도메인 우주
@goal := "demiurge web GUI: a layperson types a target in chat → the 3D Domain Cosmos reveals its composition (atom→system) with honest verified/needs-verify state → the 8 verbs drive each sub-domain to verified — the user-facing surface of every demiurge domain"

The living **architecture** for the demiurge web GUI (Next.js · Cloud Run ·
`demiurge.dancinlab.org`). This file is the SSOT snapshot (current completed-form);
`COSMOS.log.md` holds the append-only build history. Scope = the WEB SURFACE of
the whole project; the CLI verb pipeline itself stays in 8VERB.

> One line: `chat "make X" → reveal X's internal domain composition (atom→system)
> → each node shows verified/needs-verify → drive each to verified via the 8 verbs`.

## The three pillars (all backed by existing repo data)
1. **Composition** — a target (UFO) is built from internal sub-domains; edges read from `NEXUS.tape`.
2. **Scale ladder** — sub-domains span 원자(atom) → 물질·바이오·화학 → 칩·상위구조 → 시스템.
3. **Verification state** — every node carries a verdict (absorbed flag + g5 tier) = verified vs needs-verify. Honest (d6): ⚪/🟡/🔴 never painted 🟢.

## Scale ladder (the spine · vertical axis atom↓→system↑)
```
 ① 원자 ATOM        HEX-N6 · QUBIT · SRR
 ② 물질/바이오/화학  RTSC · PEROVSKITE · GRAPHENE · AGA-RX · GENE-EDIT · PROTEIN-FOLD …
 ③ 칩/상위구조       CLOAK · ANTIMATTER · CERN · NEUROMORPHIC · MEMRISTOR
 ④ 시스템 SYSTEM     UFO · WORMHOLE · WARP · FUSION · *-CURE
```

## Verification-state model (reuse existing signals — do NOT invent)
| badge | source | layperson |
|---|---|---|
| 🔵 verified-formal | g5 SUPPORTED-FORMAL (closed-form) | 수학적 확정 |
| 🟢 verified | absorbed=true / g5 SUPPORTED-NUMERICAL | 증명됨 |
| 🟡 needs-verify | partial / 🟠 INCONCLUSIVE | 거의 다 됨, 확인만 |
| ⚪ unverified | absorbed=false / no verdict | 아직 안 해봄 |
| 🔴 falsified | g5 CLOSED-negative | 막힌 길(확정) |
Rollup: any ⚪ child → target 🟡; all 🟢/🔵 → 🟢.

## Locked design decisions (D1–D7 · the perfected spec)
- **D1 landing** = full cosmos 3D constellation (MAIN page); chat+click drive focus.
- **D2 composition** = focus sub-constellation in the SAME 3D world (others dim), vertical scale axis.
- **D3 3D fidelity** = hybrid — faithful where structural data exists, else stylized symbol + "데이터 없음/검증필요" badge.
- **D4 wiring** = 3-layer: MAIN page `/cosmos` + node→work-page `router.push` + chat `demiurge:focus` event + `?target=` / `/d/<DOMAIN>` URL deeplink.
- **D5 3D assets** = procedural-first (descriptor `<DOMAIN>/model.3d.json`) + glb escape-hatch + GCS bucket when heavy. Geometry = external data/file, NEVER hardcoded.
- **D6 default view** = show ALL nodes + filter toggles 검증됨 / 검증필요 / 지금 만들 수 있는 것 (never hard-hide — honesty).
- **D7 first slice** = generic infra + UFO end-to-end vertical slice → extend by manifest only.

## Implemented architecture (branch `feat/8verb-cosmos`, off origin/main · localdev, NOT deployed)
```
web/lib/cosmos.ts        composition graph: types (Rung·VerifyState·CosmosNode·CosmosEdge·CosmosGraph),
                         parseNexusEdges · classifyRung (d4 manifest) · deriveState (honest) · decompose()
web/lib/cosmos.server.ts fs reader: readNexusEdges · buildCosmos · resolveCosmosNode (NEXUS+DOMAINS+verdict ledger)
web/lib/geometry-3d.ts   Model3DDescriptor (procedural|glb) + builders (lattice·supercell·metacell·orbit·throat·junction·symbol)
web/lib/geometry-3d.server.ts  server disk resolver for descriptors
web/components/DomainModel3D.tsx  generic SSR-safe R3F model (glb via useGLTF | procedural | stylized symbol), tinted by state
web/public/models/<DOMAIN>/model.3d.json  external descriptors (QUBIT·HEX-N6·RTSC seeded)
web/app/(app)/cosmos/page.tsx  MAIN page — 3D constellation, rung axis, focus decompose, filter toggles
web/components/CarriedCandidate.tsx  per-verb header (carried node + 8-verb breadcrumb)
web/components/verb-surfaces/VerbSurfaces.tsx  8 verb node surfaces (3D-first per §6)
web/app/(app)/d/[domain]/page.tsx  node detail (3D model + decompose + 8 verb links)
web/components/AssistChat.tsx  chat → demiurge:focus event (target matched vs /api/cosmos/targets roster)
```
- Reuses: existing SSE (`LiveTail`/`/api/stream`), `LibraryGallery` card styling, three@0.169 + @react-three/fiber@9.6 + drei@10.7.
- Honesty status today: only HEX-N6 🔵 + RTSC 🟢 carry proven badges; all other nodes ⚪ until a verdict signal lands (deriveState picks it up with no code change).

## §6 (web verbs, reframed onto a focused node)
discover=3D candidate gallery · spec=계약서 카드 · structure=3D assembly · design=model+inspector ·
analyze⟲=problem-glow+고치기 · synth=powered-on model+progress · verify=대조 저울+badge stamp · handoff=인증서+다운로드.

## Milestones
- [x] P0 design — perfected spec (D1–D7) → this architecture
- [x] P1 cosmos data — `web/lib/cosmos.ts` (graph + rung + verify-state) · 87b88c86
- [x] P2 3D infra — geometry-3d descriptor/builders + DomainModel3D + Josephson de-hardcoded · 56df36c3
- [x] P3 cosmos spine — `/cosmos` 3D constellation + focus + scale ladder + filters · ed431957
- [x] P4 verbs 3D — 8 verb node surfaces + CarriedCandidate · 4e4be994
- [x] P5 wiring — chat→focus + `?target=` deeplink + `/d/[domain]` + node→work-page nav · 89eceb62
- [x] P6 completeness hardening — conformance audit (D1–D7 PASS) + i18n `app_gui.*` (5 locales) + empty/error/load states + D3 "데이터없음" badge + a11y (keyboard node list, aria) + responsive + 2D-orphan cleanup · 3ad7a698·2520a8cb
- [x] real per-domain 3D data — faithful 3D extended beyond HEX-N6/RTSC/QUBIT to ANTIMATTER·FUSION·UFO via external `model.3d.json` descriptors parsed from real doc numbers (Penning B=5T/U₀=10V/d=5mm · FreeGS R=1.280m/a=0.424m/AR=2.99 · lenticular D=6.0m/H=1.6m/×6 solenoid). NO .ts hardcode (d4·@L10). Domains with no structural numbers (GRAPHENE·PEROVSKITE·… starter scaffolds) honestly stay ⚪ symbols. Fidelity=data-presence, NOT verify-badge. · SHA 56cc3973
- [x] 6-rung scale ladder + per-rung 3D vocabulary — Rung extended to 원자·물질·바이오·화학·칩·시스템 (classifyRung manifest, d4); new shape primitives `helix`(bio) · `molecule`(chem) · `die`(chip) · `coil`(system); system 3 retrofit orbit→coil; data-less nodes render rung-typed STYLIZED 3D + ⚪/🟡 "데이터없음" badge (no fabricated numbers). · SHA de2c66a4
- [x] overview per-rung 3D — constellation nodes render their rung-typed shape (not just on focus) via `InstancedMesh` grouped-by-shape + low-poly merged geometry; perf guard `OVERVIEW_GLYPH_FALLBACK_THRESHOLD=60` (>60 nodes OR `hardwareConcurrency<4` → sphere glyph); per-shape merge-fail fallback; verify-state tint + badge intact. · SHA 275d5b75
- [x] auto-promotion pipeline — `geometry-3d-parse.server.ts` scans `domains/<D>.md` for real structural numbers (lattice a/b/c · residues→helix turns · formula→atoms · radii/windings) w/ file:line provenance; resolver priority: hand-authored json → auto-parsed faithful → rung stylized. Faithful coverage now auto-grows from docs, zero new files. Honest: 0 NEW promotions today (only RTSC `a=2.984` rtsc.md:983 + UFO D=6.0m ufo.md:48 qualify, both already hand-authored); ~170 stub docs stay stylized. 19/19 parser tests. · SHA 5fcf71e6
- [ ] faithful bio/chem 3D — now AUTO-promotes the moment a bio/chem doc gains extractable numbers (residue/atom counts, formula) — pipeline live; today still stylized (docs are prose stubs, no raw counts; PDB id alone insufficient by design)
- [ ] deploy gate — push main → Cloud Run ONLY on explicit user approval (d_deploy)

## §6 shelf — design options / deferred
- 2D `8verb-web-visual` build (flat NodeGraphCanvas) — SUPERSEDED by this 3D cosmos (plan abandoned); a few components (SSE, cards) reused.
- ARCHITECTURE home: chose a dedicated COSMOS domain over folding into 8VERB (CLI-only goal) or DEMIURGE (top-level) — the web cosmos is a first-class system spanning all domains.
- Heavy glb assets → GCS bucket (`NEXT_PUBLIC_3D_ASSET_BUCKET`) when procedural insufficient.
