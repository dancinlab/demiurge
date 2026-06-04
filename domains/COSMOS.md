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
1. **Composition** — a target (UFO) is built from internal sub-domains; edges read from the **`DOMAINS.tape` connection graph** (`@link` rows · see §7.1 — `NEXUS.tape` is RETIRED).
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
web/lib/cosmos.server.ts fs reader: readNexusEdges⚠RETIRE→readLinkEdges · buildCosmos · resolveCosmosNode (DOMAINS @link + roster + verdict ledger)
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

## §7 Cosmos membership — WHO is a node (inclusion / exclusion) ⚠ IMPLEMENT BEFORE DEPLOY
The node-set today = the ENTIRE `DOMAINS.tape` roster (`listDomains()` → `assembleCosmos()`), with
**NO exclusion filter**. The roster mixes real science domains with NON-material tooling / meta / process
domains — and those leak in as bogus nodes (`classifyRung` honest-default → `materials`). They MUST be excluded.

**Rule** — a cosmos node = a physical **material / device / system** (something you could build or measure).
EXCLUDE anything that is tooling, infra, process-tracking, meta, or a CLI/web surface. Implement as a single
predicate `isCosmosDomain(name)` in `web/lib/cosmos.ts` (d4 — one manifest set, NO per-call branching), applied
inside `assembleCosmos()` so every downstream view (overview · decompose · `/d/<D>` · `/api/cosmos/targets`) is
filtered at the source.

**Category C — EXCLUDE from cosmos** (non-material · audited from the 70-row full roster):
```
8VERB · COSMOS · DEMIURGE · GOAL · XPRIZE · ABSORPTION · INBOX        ← meta / goal-tracking / process
NOVEL-TOOL · POOL · CLI+COCKPIT · HEXA-PORT · YOSYS · NUMB · MP       ← tooling / infra / EDA / data
QFORGE · QFORGE-PROCESS · QFORGE-PERF · QFORGE-FEATURE                ← compute engine + its process domains
```
- These are EXCLUDE-by-name. Keep the set in ONE exported const (`COSMOS_EXCLUDE`) so add/remove is data-only.
- Default-include posture for everything else: a roster domain NOT in `COSMOS_EXCLUDE` stays a node (so new
  science domains appear with zero code edits). When the line is genuinely ambiguous, KEEP it (honesty — do
  not silently drop a real domain); only the named non-material set is removed.
- Provenance: full roster `domains/DOMAINS.tape` (70 rows) · curated web roster root `DOMAINS.tape` (29 rows,
  already contains the leakers `8VERB`·`COSMOS`).
- A cosmos.test.ts case MUST assert: every `COSMOS_EXCLUDE` name is absent from `buildCosmos()` nodes, and a
  known science domain (RTSC) is present.
- **Edge endpoints inherit the filter** — the connection graph (§7.1) references Category-C names as providers
  (e.g. `NOVEL-TOOL --provides--> RTSC`). When building decomposition, DROP any edge whose endpoint is excluded
  (or its node is filtered), so a Category-C tooling domain never re-enters via a composition edge.

### §7.1 Connection graph — `NEXUS.tape` RETIRED → `DOMAINS.tape @link` (g67/g68)
`NEXUS.tape` (the old `@X … :: reuse-edge` lattice, 260 lines) is **RETIRED**. The cross-domain reuse /
composition graph now rides INSIDE `DOMAINS.tape` as `@link` rows (canonical reference: `hexa-lang/DOMAINS.tape`,
also `anima`). Format (g3-minimal):
```
@link <from> --<verb>--> <to>    # <evidence>
   intra-repo cross-domain = g67   ·   cross-project star = g68
   e.g.  @link RTSC --reuses--> NOVEL-TOOL   # current_loop_offaxis · PR #168
```
These lines ride along harmlessly — `domain list` ignores non-`@domain` rows. **Cosmos migration (2 parts):**
1. **Code** — retire `readNexusEdges`/`parseNexusEdges`/`NEXUS_PATH_PARTS` in `cosmos.server.ts`+`cosmos.ts`;
   read `@link <from> --<verb>--> <to>  # evidence` from `DOMAINS.tape` instead (rename → `readLinkEdges`/
   `parseLinkEdges`). Keep the empty-on-missing fallback. Update `cosmos.test.ts` fixtures NEXUS→`@link`.
2. **Data** — the composition edges in `NEXUS.tape` must be MIGRATED to `@link` rows in `DOMAINS.tape` (else
   decomposition goes empty after retirement). The `@X reuse-edge` `provides`→`reused_by` pairs map directly:
   `@link <reused_by> --reuses--> <provides-domain>  # <evidence>`. This is a data migration, not a cosmos-only
   concern — coordinate with the repo-wide NEXUS retirement (g67 SSOT is now `DOMAINS.tape`).

## §8 GUI-implementation guardrails (read before touching cosmos code — anti-mistake checklist)
```
[ ] node membership — apply isCosmosDomain() in assembleCosmos(); NEVER render a Category-C name (§7)
[ ] honesty (d6)    — fidelity(3D shape detail) ≠ verify-badge. A faithful model NEVER implies "verified".
                      ⚪/🟡/🔴 are derived ONLY from the verdict ledger / NEXUS markers — never from progress%.
[ ] no fabrication  — a faithful 3D needs a REAL number from the doc (file:line). No number → stylized + ⚪ badge.
                      Do NOT invent lattice/residue/atom counts to "fill" a shape.
[ ] geometry=data   — all geometry lives in external descriptors / parsed doc numbers (d4·@L10·D5). NEVER
                      hardcode per-shape constants in .ts source.
[ ] rung manifest   — classify via the RUNG_BY_NAME table + keyword fallback (d4). Add a domain = edit the
                      table, not a new branch. bio/chem keywords run BEFORE materials (a -CURE is bio, not system).
[ ] reuse, no dup   — extend the existing primitives (lattice·supercell·helix·molecule·die·coil·orbit·symbol);
                      do NOT add a parallel renderer. SSE=LiveTail, cards=LibraryGallery already exist.
[ ] edges = @link   — NEXUS.tape is RETIRED (§7.1). Read composition edges from DOMAINS.tape `@link` rows, NOT
                      NEXUS.tape. Drop edges whose endpoint is a Category-C name.
[ ] no deploy       — localdev branch only; main→Cloud Run is user-approval-gated (d_deploy). Never auto-push main.
[ ] shared worktree — land via an isolated `/tmp` worktree + PR (d9); the dev preview tree is shared, do not
                      stage/commit there.
[ ] build-green     — `npm run build` + cosmos.test.ts must pass before claiming done; paste the result.
```

## §9 Bio/Chem data audit (faithful-3D candidates · honest status)
Most bio/chem domains are PROSE STUBS — they cite outcomes/PDB ids but carry NO raw structural counts, so they
stay rung-typed STYLIZED (helix / molecule) + ⚪/🟡 "데이터없음/검증필요" badge. They AUTO-promote to faithful the
moment a real number lands (pipeline `geometry-3d-parse.server.ts` is live). What "real number" means per rung:
```
bio  (helix)    ← residue count / sequence length → helix turns · chain count → strands
chem (molecule) ← molecular formula → atom count + bonds
```
- Today: 0 net bio/chem promotions — no bio/chem doc has a clean extractable count (PDB id alone is insufficient
  by design; it names a structure but gives no count to build from). This is the HONEST state, not a gap to paper over.
- To promote a real bio/chem domain: add the count to its `domains/<D>.md` (e.g. "residues: 214", a bare formula),
  OR hand-author `web/public/models/<D>/model.3d.json`. Then it renders faithful automatically.
- The user reports real progress in some bio domains (AGA-RX/SENOLYX/CURE family) — that progress is in
  `.log.md` + `exports/<D>/`, but the geometry parser reads `<D>.md` for a STRUCTURAL number; if those numbers
  exist they should be surfaced into `<D>.md` (or a descriptor) to trigger promotion. Open milestone below.

## §9.1 Research (2026-06-05 · web + arxiv + AlphaFold) — how to fill faithful bio/chem 3D
Three parallel research threads (structural-data sourcing · web-3D viewer · arxiv/licensing). All numbers below
were verified against LIVE APIs, not transcribed from docs. This is the actionable plan for the §9 milestone.

### (a) Per-domain promotion table — real entities + structural numbers (groundable NOW)
The bio domains DO cite real PDB/UniProt ids in their `.log.md`/`exports/` — they just never reached `<D>.md`.
Resolve the count via the APIs in (c) and write it into `<D>.md` (or a descriptor) to auto-promote:
```
domain     entity (id)                       structural number          shape (rung)
─────────────────────────────────────────────────────────────────────────────────────
AGA-RX     SFRP1  (UniProt Q8N474)           residues 314 → ~87 turns   helix      ✅now
AGA-RX     Dkk1–LRP6 (PDB 3S2K)              3 chains · 1298 res         helix×3    ✅now
AGA-RX     AR-LBD (PDB 2AM9, off-target)     266 res · 2403 atoms        helix      ✅now
AGA-RX     WAY-316606 (PubChem 16727102)     C18H19F3N2O4S2 · 29 heavy   molecule   ✅now
SENOLYX    BCL-xL (PDB 3ZLR)                 290 res · 2 chains          helix      ✅now
SENOLYX    BCL-xL/PROTAC (4QVX·4CI1)+ligands per-PDB via RCSB; CID/ligand molecule   ✅now
AGA-CURE   (reuses AGA-RX targets)           reuse SFRP1/Dkk1            helix      reuse
IVD-CURE   (reuses SENOLYX BCL-xL)           reuse 3ZLR                  helix      reuse
OA/PERIO/RETINA-CURE  η_neo modeling, no own PDB → choose a pathway target first   needs-target
GENE-EDIT·RNA-THERAPY·ORGANOID·PROTEIN-FOLD  generic samplers, NO entity → honest ⚪ (do not invent)
ELECTROCAT·PHOTOREDOX·CO2-CAPTURE·GREEN-NH3  generic chem samplers, NO formula → honest ⚪
```
Real-id source files: `domains/AGA-RX.log.md` (Q8N474·3S2K·2AM9·6Q0D), `domains/SENOLYX.md/.log.md` (3ZLR·4QVX·4CI1).

### (b) Faithful-3D rendering — viewer + integration (AlphaFold-grade)
AlphaFold DB's own GUI = **Mol\*** (molstar). Recommendation = HYBRID (the WebGL-context split is the real trap —
browsers cap ~8 contexts, no cross-context sharing; the cosmos overview already owns one R3F canvas):
```
COSMOS overview (R3F scene)  → keep NATIVE R3F meshes (CA-trace tube / low-poly ribbon · atoms+bonds).
                               Faithful-LITE, lives IN the existing canvas, NO 2nd WebGL context.
/d/<domain> detail page      → mount Mol* (pdbe-molstar, MIT) in its OWN canvas, dynamic import ssr:false.
                               Real fold + pLDDT confidence coloring (built-in) = the AlphaFold-DB UX.
chem detail                  → Mol* reads SDF too; 3Dmol.js (BSD-3, lighter) if bundle-tight.
```
- Today's `web/components/StructureViewer.tsx` is a CSS-3D PLACEHOLDER (its own comment says so) — Mol* replaces it.
- Data feed: protein mmCIF `alphafold.ebi.ac.uk/files/AF-<UNIPROT>-F1-model_v4.cif` (pLDDT in B-factor) or RCSB
  `files.rcsb.org/download/<PDBID>.cif`; molecule SDF from PubChem `record_type=3d`. Proxy via a Next route handler
  (`app/api/structure/route.ts`) to dodge CORS + cache. Dispose viewer on unmount (`plugin.dispose()`).
- AVOID: `molstar-react` (stale 2023) · NGL (RCSB-removed 2024). Wrap `pdbe-molstar` yourself (~30-line client cmp).

### (c) API endpoints (verified live)
```
RCSB entry   GET data.rcsb.org/rest/v1/core/entry/{PDB}      → deposited_atom_count · *_polymer_monomer_count(res) · *_instance_count(chains)
RCSB chain   GET data.rcsb.org/rest/v1/core/polymer_entity/{PDB}/{N}  → entity_poly.rcsb_sample_sequence_length
AlphaFold    GET alphafold.ebi.ac.uk/api/prediction/{UNIPROT} → uniprotEnd(res) · cifUrl/pdbUrl
UniProt      GET rest.uniprot.org/uniprotkb/{ACC}.json?fields=length → sequence.length(res)
PubChem      GET pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/{CID}/property/MolecularFormula,HeavyAtomCount/JSON
download     files.rcsb.org/download/{PDB}.cif · alphafold.ebi.ac.uk/files/AF-{ACC}-F1-model_v4.cif · pug .../SDF?record_type=3d
```

### (d) Licensing (LOAD-BEARING for a product GUI)
- **AlphaFold DB structures = CC-BY-4.0 → product-safe WITH attribution** ("AlphaFold DB, EMBL-EBI/DeepMind"). PDB = CC0.
- **AlphaFold 3 model+weights = NON-COMMERCIAL only** → COSMOS must CONSUME pre-computed AlphaFold DB structures,
  NEVER run AF3 inference in-product. Viewers Mol*/NGL = MIT · 3Dmol.js = BSD-3 (all clean).

### (e) NOVEL probe — prose→structure resolver cascade (worth a milestone, frontier but real)
When a domain has no PDB, generate a flagged-illustrative structure instead of a fake placeholder:
```
1 known protein   → AlphaFold DB / PDB mmCIF          (faithful)
2 sequence-only   → ESMFold on-demand                 (faithful)
3 prose-only bio  → ESM3 / RFdiffusion representative  (⚠ flag "generated · illustrative")
4 prose-only chem → text→graph diffusion (3M-Diffusion) (⚠ flag "generated · illustrative")
```
Tiers 3–4 MUST be visibly flagged generated (never shown as experimental) — honesty (d6). Refs: AlphaFold3
Nature 2024 (s41586-024-07487-w) · AF-DB NAR 2024 (gkad1011) · ESMFold Science 2023 (ade2574) · RFdiffusion
Nature 2023 (s41586-023-06415-8) · Mol* NAR 2021 (W431) · 3M-Diffusion arXiv:2403.07179 · ProteinGPT arXiv:2408.11363.

## §10 `.demi`-CANONICAL data layer ⚠ SUPERSEDES the §7/§7.1/§9 sourcing patchwork
**Directive (2026-06-05): "우리는 .demi잖아 — .demi 기준으로 모두 작동되게."** The COSMOS data layer is rebased
onto the `.demi` SSOT. `.demi` is the repo's canonical machine-readable domain format (TOML-ish, loaded by the
hexa `demi` CLI via `stdlib/demi/domain_catalog.hexa` + `domain_composer.hexa` — the ported DemiParser→DomainLoader).
This RETIRES the ad-hoc sources cosmos used: DOMAINS.tape roster · `@link` edges · `<D>.md` prose-parse · matter
ledger. Everything below reads from `.demi`.

### Two `.demi` tiers cosmos reads
```
domains/INDEX.demi          THE graph SSOT (D83 · "canonical machine-readable 19-domain graph"):
  [<id>] sections           = the cosmos NODES (membership solved by construction —
                              tooling/meta domains are simply NOT in INDEX.demi, so COSMOS_EXCLUDE retires)
  prerequisites = [...]      = the cosmos COMPOSITION EDGES (D82 direct-prereq; transitive closure computed)
                              — REPLACES the retired NEXUS→@link migration entirely (prerequisites IS the graph)
  facets.scale = "..."       = the cosmos RUNG (canonical) ∈ molecular · device · component · system
  canvas_mode · keywords · label  = presentation hints (3D mode · search · display name)

domains/<id>.demi           per-domain VERB-CELL manifest (cellrun Phase-A dialect):
  [cell.<verb>] sections     = the 8-verb surface (specify·structure·design·analyze·synthesize·verify·handoff)
  gate_default / absorbed_default = the HONEST verify-state SSOT (GATE_OPEN+absorbed=false → ⚪/🟡;
                              flips only on a real gate PASS) — REPLACES prose-parse + matter ledger
  scope_caveats              = honest caveats per cell (surface verbatim, never hide)
```

### Mapping `.demi` → cosmos model
| cosmos concept | `.demi` source | note |
|---|---|---|
| node membership | `INDEX.demi` `[<id>]` present | by construction — no exclude list |
| composition/decompose edges | `INDEX.demi` `prerequisites` | direct prereqs + transitive closure (D82) |
| rung / scale ladder | `INDEX.demi` `facets.scale` | molecular·device·component·system (4, canonical) |
| verify-state ⚪🟡🟢🔵🔴 | `<id>.demi` cell `gate_default`/`absorbed_default` | honest gate, not prose |
| 8 verb surfaces | `<id>.demi` `[cell.<verb>]` | substrate/script/record_kind/caveats |
| faithful 3D geometry | `<id>.demi` (or descriptor) | geometry data stays external (d4·@L10) |

### Honest deltas vs the prior design (must reconcile)
- **Node set CHANGES**: INDEX.demi = ~19 high-level category domains (matter·chem·bio·chip·fusion·ufo…), NOT the
  ~50 product domains (AGA-RX·SENOLYX·QUBIT·GRAPHENE) of the DOMAINS.tape roster. The cosmos becomes the clean
  19-node composition graph (ufo→antimatter/fusion/rtsc · fusion→antimatter/rtsc). Product/science domains that
  carry their own `<id>.demi` but are absent from INDEX.demi are out-of-graph until registered in INDEX.demi (one
  `[<id>]` section — data, no code).
- **Rung is 4, not 6**: `.demi` `facets.scale` = molecular·device·component·system. The earlier 원자·물질·바이오·화학·칩·시스템 6-rung is NOT the `.demi` canonical. If a finer split is wanted, ADD it to `INDEX.demi` facets
  (e.g. `facets.rung`) — data-driven (d4), never a hardcoded cosmos keyword table. classifyRung keyword fallback retires.
- **bio/chem 3D (§9.1) still applies** but now keyed off the `.demi` node + its cells; the AlphaFold/PDB data path
  is unchanged, it just attaches to the `.demi`-sourced node.

### Implementation (cosmos code)
- New `web/lib/demi.ts` (+ `.server.ts`): parse `INDEX.demi` (section + `key = value` + `key.sub` + `[list]`) and
  `<id>.demi` (cell sections), mirroring `stdlib/demi/domain_catalog.hexa`. `buildCosmos()` reads `.demi`, not
  DOMAINS.tape/NEXUS/<D>.md. Keep `CosmosNode`/`CosmosEdge` shape stable; map prereq→edge, facets.scale→rung,
  cell gate→VerifyState. RETIRE `COSMOS_EXCLUDE`/`isCosmosDomain`/`readLinkEdges`/`parseLinkEdges`/prose verify-state.
- cosmos.test.ts: assert INDEX.demi `[ufo]` node exists with prereqs antimatter/fusion/rtsc; a tooling name (8VERB)
  is absent (not in INDEX.demi); rung = facets.scale; an all-GATE_OPEN domain reads ⚪.

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
- [x] overview hover highlight — pointer-over a node lifts tint 40%→white + scale ×1.22 (instanced) / ×1.18 + emissive 0.7 (glyph fallback) + label→white, via existing zero-rebuild instanced buffers (setColorAt/setMatrixAt); onPointerMove re-targets per-instance; both render paths; click→focus/layout/badge intact. · SHA d38f5907
- [x] **`.demi`-canonical data layer (§10)** — LANDED `feat/8verb-cosmos` `21475446`·`860a089a`·`bb6c4ad5`·`0f757d46`: `web/lib/demi.ts`(+`.server`) parses INDEX.demi + `<id>.demi`; `buildCosmos()` reads `.demi`; verify-state from cell `gate_default`/`absorbed_default`. RETIRED `COSMOS_EXCLUDE`/`isCosmosDomain`/`parseLinkEdges`/keyword-classifyRung/prose-state. Nodes 25→20 (clean INDEX.demi graph). build exit 0 · cosmos.test 43✓ (ufo←antimatter/fusion/rtsc · 8VERB/COSMOS/QFORGE absent · ufo rung=system · all-GATE_OPEN→⚪) · geometry 19✓
- [x] **6-band rung via `.demi` facets.rung** — LANDED `eae83c00`(data)·`020b36ac`(code): added `facets.rung ∈ {atom,materials,bio,chem,chip,system}` to all 20 INDEX.demi `[id]` (matter→materials · bio→bio · chem→chem · device→chip · system→system); cosmos `resolveRung(facets.rung ?? SCALE_TO_RUNG[scale])` — data-driven, no keyword classifier (d4). `Rung` restored to 6; ladder 6 bands (atom↓→system↑); `atom` band intentionally EMPTY (no atom-scale INDEX.demi node — honest, none faked). i18n 5 locales. build exit 0 · cosmos.test ✓ (rung=bio not lumped molecular · scale fallback · ufo=system · matter=materials) · geometry ✓
- [x] ~~membership filter (§7)~~ + ~~NEXUS→@link (§7.1)~~ — LANDED (`c229f2c7`·`d87a2185`) but SUPERSEDED by §10: INDEX.demi membership is by-construction (no exclude list) and `prerequisites` IS the graph (no @link). These were the right fix for the DOMAINS.tape sourcing; §10 replaces that sourcing wholesale
- [x] faithful bio/chem 3D — **AGA-RX·SENOLYX registered as `.demi` bio nodes + faithful α-helix** LANDED `feat/8verb-cosmos` `6595148a`: `[aga-rx]`/`[senolyx]` in INDEX.demi (facets.rung=bio · prereq=[bio]); descriptors `web/public/models/{AGA-RX,SENOLYX}/model.3d.json` = helix from real residue counts (SFRP1 314→87 turns · BCL-xL 3ZLR 290→81 turns·2 strands, src-cited). Nodes 20→22. Both read ⚪ unverified (no `<id>.demi` cell, no fabricated gate — faithful shape ≠ verified verdict). next.config tracing now bundles `*.demi`. build exit 0 · cosmos.test ✓ (aga-rx/senolyx present · rung=bio · edge→bio · faithful non-symbol · ⚪). Generic samplers (GENE-EDIT/chem) stay honest ⚪ (no entity). Real fold via Mol* = §9.1b follow-up
- [x] **Mol\* real-fold viewer on `/d/<domain>` (§9.1b)** — LANDED `feat/8verb-cosmos` `babf1fa4`(facets→node.structure)·`aeb5c126`(viewer): `pdbe-molstar@^3.12` (MIT) in `MolViewer`/`MolstarInner` (dynamic ssr:false, own canvas) fed via `web/app/api/structure/route.ts` proxy (AlphaFold `AF-<uniprot>-F1-model_v4.cif` w/ pLDDT · RCSB `<pdb>.cif`, id-regex SSRF guard). Structure ref is `.demi`-canonical: INDEX.demi `facets.uniprot="Q8N474"` (AGA-RX/SFRP1) · `facets.pdb="3ZLR"` (SENOLYX/BCL-xL) → parsed to `node.structure`. `/d/<domain>` renders Mol* when structure ref present (+ CC-BY/CC0 attribution + "예측 신뢰도(pLDDT)" note), else existing R3F. Overview stays native R3F (no 2nd WebGL ctx). build exit 0 (38 pages) · cosmos.test exit 0. Browser-only: actual 3D render confirmed in-browser (headless verifies build+route+parse).
- [ ] NOVEL prose→structure resolver cascade (§9.1e) — AlphaFold-DB → ESMFold → ESM3/RFdiffusion (flagged "generated·illustrative") → text→graph for chem; tiers 3–4 visibly flagged generated (d6 honesty)
- [ ] deploy gate — push main → Cloud Run ONLY on explicit user approval (d_deploy)

## §6 shelf — design options / deferred
- 2D `8verb-web-visual` build (flat NodeGraphCanvas) — SUPERSEDED by this 3D cosmos (plan abandoned); a few components (SSE, cards) reused.
- ARCHITECTURE home: chose a dedicated COSMOS domain over folding into 8VERB (CLI-only goal) or DEMIURGE (top-level) — the web cosmos is a first-class system spanning all domains.
- Heavy glb assets → GCS bucket (`NEXT_PUBLIC_3D_ASSET_BUCKET`) when procedural insufficient.
