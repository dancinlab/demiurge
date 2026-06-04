// cosmos.ts — the Domain Cosmos composition graph (8VERB Cosmos design SSOT).
//
// Pure, server-safe data module (no UI). Assembles, manifest-driven (d4 — no
// per-domain dispatch hardcoding beyond a small classification table), the full
// cosmos graph the GUI renders:
//
//   listDomains() (DOMAINS.tape roster + per-domain .md snapshot)   ── nodes
//   DOMAINS.tape  @link <from> --<verb>--> <to> rows (§7.1)         ── edges
//   classifyRung()                                                  ── §2 ladder
//   deriveState()                                                   ── §4 verify state
//
// Verification state is HONEST (§4 · d6 · d_paper_*): a node is only painted
// 🟢/🔵 when a real verified signal exists; absence of signal → ⚪ "unverified".
// We NEVER upgrade a projection / partial / candidate into a proven badge.

// NOTE (SSR/bundling): this module is imported by BOTH server pages and client
// components (CosmosScene needs the PURE functions `decompose` · `STATE_BADGE`
// + the types). So the fs-bound deps (node:fs · node:path · matter ledger ·
// domains roster) are loaded LAZILY inside the async server-only functions
// (readLinkEdges · buildCosmos) — never at module top level — so this file
// stays client-safe (no `node:fs` in the browser chunk). Types are erased, so
// the type-only imports below are bundler-free.
import type { DomainEntry } from "@/lib/domains";
import type { AttestationRow } from "@/lib/matter";

// ── §2 scale ladder ──────────────────────────────────────────────────────────
// SIX rungs the user named: 원자 → 물질 → 바이오 → 화학 → 칩 → 시스템. Each is its
// own Y-band in the /cosmos vertical scale ladder. "materials" was previously the
// catch-all for materials·bio·chem; it is now split so bio (단백질·세포·유전자) and
// chem (분자·촉매·반응) read as distinct scale rungs with their own 3D vocabulary.
export type Rung =
  | "atom"
  | "materials"
  | "bio"
  | "chem"
  | "chip"
  | "system";

// ── §4 verification-state model ────────────────────────────────────────────
// verified-formal 🔵 · verified 🟢 · needs-verify 🟡 · unverified ⚪ · falsified 🔴
export type VerifyState =
  | "verified-formal"
  | "verified"
  | "needs-verify"
  | "unverified"
  | "falsified";

export const STATE_BADGE: Record<VerifyState, string> = {
  "verified-formal": "🔵",
  verified: "🟢",
  "needs-verify": "🟡",
  unverified: "⚪",
  falsified: "🔴",
};

export type CosmosNode = {
  name: string;
  icon?: string;
  alias?: string;
  rung: Rung;
  state: VerifyState;
  goal?: string;
  progress?: { done: number; total: number };
};

// A reuse / composition edge (DOMAINS.tape @link row · §7.1).
// `from` provides the primitive; `to` reuses it (provides → reused_by). For the
// downward composition view (§1 UFO tree), a parent system reuses its children,
// so an edge from=child(provider) → to=parent(consumer); decompose() walks the
// reused_by side downward.
export type EdgeTier = "tier-1" | "tier-2" | "tier-3" | "candidate" | "unknown";

export type CosmosEdge = {
  from: string; // provider domain (provides[])
  to: string; // consumer domain (reused_by)
  primitive?: string;
  tier?: EdgeTier;
  evidence?: string;
};

export type CosmosGraph = { nodes: CosmosNode[]; edges: CosmosEdge[] };

// ── §7 cosmos membership — inclusion / exclusion (d4: ONE manifest set) ──────
// A cosmos node is a physical MATERIAL / DEVICE / SYSTEM (something you could
// build or measure). Tooling / infra / process-tracking / meta / CLI-web-surface
// domains are NOT nodes — left unfiltered they leak in as bogus `materials` nodes
// (classifyRung honest-default) and re-enter via composition edges (NOVEL-TOOL as
// a provider). EXCLUDE-by-name from a single exported const so add/remove is
// data-only (no per-call branching). Names are UPPERCASE roster tokens.
//
// Category-C (non-material · audited from the full DOMAINS.tape roster):
//   meta / goal-tracking / process : 8VERB COSMOS DEMIURGE GOAL XPRIZE ABSORPTION INBOX
//   tooling / infra / EDA / data   : NOVEL-TOOL POOL CLI+COCKPIT HEXA-PORT YOSYS NUMB MP
//   compute engine + process       : QFORGE QFORGE-PROCESS QFORGE-PERF QFORGE-FEATURE
// Default-include posture: anything NOT in this set stays a node (new science
// domains appear with zero code edits). Only the named set is removed — an
// ambiguous name is KEPT (honesty · §7).
export const COSMOS_EXCLUDE: ReadonlySet<string> = new Set([
  // meta / goal-tracking / process
  "8VERB",
  "COSMOS",
  "DEMIURGE",
  "GOAL",
  "XPRIZE",
  "ABSORPTION",
  "INBOX",
  // tooling / infra / EDA / data
  "NOVEL-TOOL",
  "POOL",
  "CLI+COCKPIT",
  "HEXA-PORT",
  "YOSYS",
  "NUMB",
  "MP",
  // compute engine + its process domains
  "QFORGE",
  "QFORGE-PROCESS",
  "QFORGE-PERF",
  "QFORGE-FEATURE",
]);

// isCosmosDomain — true when `name` is a cosmos node (NOT in COSMOS_EXCLUDE).
// Defensive: any name starting with `QFORGE` is excluded (covers future
// QFORGE-* process spin-offs without a manifest edit).
export function isCosmosDomain(name: string): boolean {
  const up = name.toUpperCase();
  if (up.startsWith("QFORGE")) return false;
  return !COSMOS_EXCLUDE.has(up);
}

// ── §3 reuse edges — DOMAINS.tape @link parser (§7.1: NEXUS.tape RETIRED) ─────
// The old `@X e<n> :: reuse-edge` lattice (NEXUS.tape) is RETIRED. The cross-
// domain reuse / composition graph now rides INSIDE DOMAINS.tape as @link rows:
//
//   @link <from> --<verb>--> <to>   # <evidence>
//
// These were migrated from NEXUS.tape with the consumer (old `reused_by`) as the
// `<from>` and the provider (old `provides`) as the `<to>`, joined by `--reuses-->`.
// So in @link space, `from` = the CONSUMER and `to` = the PROVIDER it reuses.
//
// CosmosEdge keeps its original semantics (`from` = provider, `to` = consumer),
// so we SWAP when mapping: edge.from = link.<to> (provider), edge.to = link.<from>
// (consumer). decompose() walks children = providers of a consumer (edge.to ===
// node, child = edge.from) unchanged. The link verb (reuses/uses/refines/…) is
// recorded; tier defaults to "tier-1" (a migrated edge is a real reuse link) and
// the evidence string after `#` is preserved.

// A roster-style domain token: UPPERCASE start, then [A-Z0-9+_-], e.g.
// RTSC · HEX-N6 · AGA-CURE · CLI+COCKPIT.
const DOMAIN_TOKEN_RE = /^[A-Z][A-Z0-9+_-]*$/;

// Pure DOMAINS.tape @link parser — takes the file TEXT (no I/O), so it is
// client-safe and unit-testable. The fs READ lives in cosmos.server.ts
// (readLinkEdges). Lines NOT matching the `@link A --verb--> B` shape (including
// `@domain` roster rows, `@V`, comments) are ignored.
export function parseLinkEdges(text: string): CosmosEdge[] {
  const edges: CosmosEdge[] = [];
  // @link <from> --<verb>--> <to>   # <evidence>
  // <verb> = a lowercase token (reuses · uses · refines · provides …).
  const linkRe = /^@link\s+(\S+)\s+--([a-z][a-z-]*)-->\s+(\S+)\s*(?:#\s*(.*))?$/gm;
  for (const m of text.matchAll(linkRe)) {
    const linkFrom = m[1]; // CONSUMER in @link space
    const verb = m[2];
    const linkTo = m[3]; // PROVIDER in @link space
    const evidence = m[4]?.trim() || undefined;

    // Only domain↔domain edges (skip lowercase stdlib paths like stdlib/material).
    if (!DOMAIN_TOKEN_RE.test(linkFrom) || !DOMAIN_TOKEN_RE.test(linkTo)) continue;
    if (linkFrom === linkTo) continue;

    // CosmosEdge: from = PROVIDER, to = CONSUMER (swap from @link orientation).
    edges.push({
      from: linkTo,
      to: linkFrom,
      tier: "tier-1",
      evidence: evidence ? `${verb} · ${evidence}` : verb,
    });
  }
  return edges;
}

// ── §2 rung classification — manifest table + keyword fallback (d4) ──────────
// Known anchors per §2; a generic keyword fallback covers everything else. NO
// per-domain branching beyond this single table — add/rename/remove is table-only.
const RUNG_BY_NAME: Record<string, Rung> = {
  // ① 원자 ATOM — particles / quanta / lattice primitives.
  "HEX-N6": "atom",
  QUBIT: "atom",
  SRR: "atom",
  // ② 물질 MATERIALS — bulk solids / lattices / device-feedstock materials.
  RTSC: "materials",
  PEROVSKITE: "materials",
  GRAPHENE: "materials",
  METAMATERIAL: "materials",
  AEROGEL: "materials",
  SPINTRONIC: "materials",
  MEMRISTOR: "materials",
  // ③ 바이오 BIO — proteins / cells / genes / therapeutics.
  "AGA-RX": "bio",
  "AGA-CURE": "bio",
  "GENE-EDIT": "bio",
  "RNA-THERAPY": "bio",
  ORGANOID: "bio",
  "PROTEIN-FOLD": "bio",
  SENOLYX: "bio",
  "OA-CURE": "bio",
  "PERIO-CURE": "bio",
  "RETINA-CURE": "bio",
  "IVD-CURE": "bio",
  // ④ 화학 CHEM — molecules / catalysts / reactions.
  ELECTROCAT: "chem",
  PHOTOREDOX: "chem",
  "CO2-CAPTURE": "chem",
  "GREEN-NH3": "chem",
  // ⑤ 칩·상위구조 CHIP — devices / metasurfaces / trap assemblies.
  CLOAK: "chip",
  ANTIMATTER: "chip",
  CERN: "chip",
  NEUROMORPHIC: "chip",
  PHOTONIC: "chip",
  // ⑥ 시스템 SYSTEM — assembled bodies / full pipelines.
  UFO: "system",
  WORMHOLE: "system",
  WARP: "system",
  FUSION: "system",
  "DIM-JUMP": "system",
  "DIM-USE": "system",
};

// Keyword fallback — runs only when a domain is absent from RUNG_BY_NAME. Generic
// (matches on the domain name + its goal text), so new domains classify without a
// code edit when their language is conventional.
// Ordering is significant — first regex to match wins. bio/chem are listed BEFORE
// materials so a therapeutic / catalysis domain lands in its specific rung; the
// "-CURE" therapeutic family is bio (a treatment), NOT a "system" vehicle.
const RUNG_KEYWORDS: Array<{ rung: Rung; re: RegExp }> = [
  { rung: "bio", re: /(-CURE\b|CURE\b|완치|치료|therap|치료제|drug|약물|약\b|gene|유전|protein|단백|peptide|펩타이드|cell|세포|organoid|오가노이드|senolyt|노화|residue|잔기|sequence|서열|antibody|항체|capsid|캡시드|mRNA|siRNA|RNA|DNA|모낭|탈모)/i },
  { rung: "chem", re: /(catalys|촉매|electrocat|전기촉매|photoredox|광촉매|molecule|분자|reaction|반응|synthesis route|합성|CO2|capture|포집|NH3|암모니아|Tafel|overpotential|과전압|Faradaic)/i },
  { rung: "system", re: /(시스템|system|비행체|추진|craft|vehicle|drive|propuls|tokamak|토카막|reactor|반응로|warp|워프|wormhole|웜홀|fusion|핵융합)/i },
  { rung: "chip", re: /(chip|칩|device|소자|trap|트랩|metasurface|메타표면|circuit|회로|accelerator|가속|crossbar|크로스바|neuromorph|뉴로모픽|photonic|포토닉|die|wafer|웨이퍼)/i },
  { rung: "atom", re: /(atom|원자|lattice|격자|qubit|큐비트|quantum|양자|primitive)/i },
  { rung: "materials", re: /(material|물질|재료|metamaterial|메타물질|aerogel|에어로젤|graphene|그래핀|perovskite|페로브스카이트|superconduct|초전도|spintronic|memristor)/i },
];

export function classifyRung(name: string, doc?: { goal?: string | null }): Rung {
  const up = name.toUpperCase();
  if (RUNG_BY_NAME[up]) return RUNG_BY_NAME[up];

  const hay = `${name} ${doc?.goal ?? ""}`;
  for (const { rung, re } of RUNG_KEYWORDS) {
    if (re.test(hay)) return rung;
  }
  // Honest default: a bulk research artifact with no other signal → materials
  // (the broadest, lowest-commitment rung); it carries no proven-ness claim.
  return "materials";
}

// ── §4 verify-state derivation — HONEST mapping ──────────────────────────────
// Sources, strongest → weakest:
//   1. matter.ts ledger rows associated with the domain (absorbed flag + verdict
//      tier) — the canonical attestation/verdict SSOT.
//   2. NEXUS edge evidence markers on edges this domain *provides* (🔵/🟢/🔴).
//   3. nothing → "unverified" ⚪ (never inferred from progress alone — progress is
//      activity, not proof).
// We NEVER upgrade: a partial / 🟠 / candidate maps to needs-verify at best.

const FORMAL_RE = /SUPPORTED-FORMAL|🔵|formal|closed-form|identity/i;
const SUPPORTED_RE = /SUPPORTED-NUMERICAL|🟢|GATE_CLOSED|PASS\b|ALL_PASS/i;
const FALSIFIED_RE = /FALSIFIED|🔴|CLOSED-negative|REFUTED/i;
const PARTIAL_RE = /INCONCLUSIVE|🟠|🟡|partial|citation|needs-verify|MISSING-INPUT/i;

// Rank for picking the strongest honest verdict among several signals. Note:
// falsified does NOT outrank verified here — a domain with one falsified path and
// other verified paths is still "verified" overall; only an *all-falsified* /
// load-bearing falsification is surfaced by the caller (decompose rollup).
const STATE_RANK: Record<VerifyState, number> = {
  unverified: 0,
  falsified: 1,
  "needs-verify": 2,
  verified: 3,
  "verified-formal": 4,
};

function strongest(a: VerifyState, b: VerifyState): VerifyState {
  return STATE_RANK[a] >= STATE_RANK[b] ? a : b;
}

function ledgerState(rows: AttestationRow[]): VerifyState | null {
  if (rows.length === 0) return null;
  let best: VerifyState | null = null;
  for (const r of rows) {
    let s: VerifyState | null = null;
    const v = r.verdict ?? "";
    if (FORMAL_RE.test(v)) s = "verified-formal";
    else if (r.absorbed === true || SUPPORTED_RE.test(v)) s = "verified";
    else if (FALSIFIED_RE.test(v)) s = "falsified";
    else if (PARTIAL_RE.test(v) || r.absorbed === false) s = "needs-verify";
    if (s) best = best ? strongest(best, s) : s;
  }
  return best;
}

// Associate ledger rows to a domain. The ledger is keyed by *material* (compound)
// not domain; we attach a material row to a domain when the material/compound/
// family string contains the domain name, or (for the superconductor campaign)
// when the domain is RTSC — its compounds (LaH10, CaH6, Nb, MgB2, YBCO…) live in
// the material ledger. Generic substring match keeps this manifest-free.
function rowsForDomain(name: string, ledger: AttestationRow[]): AttestationRow[] {
  const up = name.toUpperCase();
  const direct = ledger.filter((r) =>
    [r.material, r.compound, r.family].some(
      (s) => typeof s === "string" && s.toUpperCase().includes(up),
    ),
  );
  if (direct.length > 0) return direct;
  // RTSC owns the superconductor material campaign ledger.
  if (up === "RTSC") return ledger;
  return [];
}

// Evidence-marker fallback: scan the badge glyphs in edge evidence for edges this
// domain PROVIDES (it is the trust anchor). 🔵 > 🟢 > (🟡/⚪) — never upgrade.
function edgeProvidedState(name: string, edges: CosmosEdge[]): VerifyState | null {
  const up = name.toUpperCase();
  const mine = edges.filter((e) => e.from.toUpperCase() === up);
  if (mine.length === 0) return null;
  let best: VerifyState | null = null;
  for (const e of mine) {
    const blob = `${e.primitive ?? ""} ${e.evidence ?? ""}`;
    let s: VerifyState | null = null;
    if (FORMAL_RE.test(blob)) s = "verified-formal";
    else if (SUPPORTED_RE.test(blob)) s = "verified";
    else if (FALSIFIED_RE.test(blob)) s = "falsified";
    else if (e.tier === "candidate") s = "needs-verify";
    if (s) best = best ? strongest(best, s) : s;
  }
  return best;
}

export function deriveState(
  domain: DomainEntry,
  opts?: { ledger?: AttestationRow[]; edges?: CosmosEdge[] },
): VerifyState {
  const ledger = opts?.ledger ?? [];
  const edges = opts?.edges ?? [];

  const fromLedger = ledgerState(rowsForDomain(domain.name, ledger));
  if (fromLedger) return fromLedger;

  const fromEdges = edgeProvidedState(domain.name, edges);
  if (fromEdges) return fromEdges;

  // No proof signal → unverified (honest). Progress/goal alone never imply 🟢.
  return "unverified";
}

// ── icon + alias from the domain @title head (§ d10: icon · NAME · alias) ─────
// listDomains() already extracts `title` (e.g. "🛸 UFO — 통합 비행체(직접개발)").
// We split it into a leading emoji icon + the trailing alias. Generic — no per-
// domain table.
const LEADING_EMOJI =
  /^([\p{Extended_Pictographic}←-⇿⌀-➿️‍]+)/u;

function parseTitle(
  title: string | null,
  name: string,
): { icon?: string; alias?: string } {
  if (!title) return {};
  const t = title.trim();
  const em = t.match(LEADING_EMOJI);
  const icon = em ? em[1].trim() : undefined;
  // alias = the human phrase after the "— " (em dash) or "- " separator.
  const dash = t.split(/\s+[—–-]\s+/);
  const alias = dash.length > 1 ? dash.slice(1).join(" — ").trim() : undefined;
  void name;
  return { icon: icon || undefined, alias: alias || undefined };
}

// ── assembleCosmos — pure graph assembly from already-loaded inputs ──────────
// Client-safe (no I/O): the server entry buildCosmos() (cosmos.server.ts) reads
// the roster / NEXUS / ledger off disk and calls this. Keeping assembly pure
// lets it be unit-tested and keeps cosmos.ts free of node:fs.
export function assembleCosmos(
  domains: DomainEntry[],
  edges: CosmosEdge[],
  ledger: AttestationRow[],
): CosmosGraph {
  // §7 membership filter (d4): drop Category-C (tooling / meta / process) domains
  // at the SOURCE so every downstream view (overview · decompose · /d/<D> ·
  // /api/cosmos/targets) inherits it. Filter the roster BEFORE building nodes, AND
  // drop any edge whose endpoint is excluded — else a Category-C name (e.g.
  // NOVEL-TOOL as a provider) re-enters as a synthesized node via a composition
  // edge below.
  domains = domains.filter((d) => isCosmosDomain(d.name));
  edges = edges.filter((e) => isCosmosDomain(e.from) && isCosmosDomain(e.to));

  // Roster names (uppercase) for edge sanity — keep every edge (an endpoint may be
  // a primitive-only domain not in the curated web roster, e.g. HEX-N6/SRR), but
  // surface a node for every edge endpoint too so the graph has no dangling refs.
  const byName = new Map<string, DomainEntry>();
  for (const d of domains) byName.set(d.name.toUpperCase(), d);

  const nodes: CosmosNode[] = domains.map((d) => {
    const { icon, alias } = parseTitle(d.title, d.name);
    return {
      name: d.name,
      icon,
      alias,
      rung: classifyRung(d.name, { goal: d.goal }),
      state: deriveState(d, { ledger, edges }),
      goal: d.goal ?? undefined,
      progress: d.progress ?? undefined,
    };
  });

  // Synthesize lightweight nodes for edge endpoints missing from the roster so the
  // composition tree (decompose) can render a leaf even when it is a bare
  // primitive domain. State derived from edges only; rung from keyword fallback.
  const present = new Set(nodes.map((n) => n.name.toUpperCase()));
  const extraNames = new Set<string>();
  for (const e of edges) {
    for (const end of [e.from, e.to]) {
      if (!present.has(end.toUpperCase())) extraNames.add(end);
    }
  }
  for (const name of extraNames) {
    const stub: DomainEntry = {
      name,
      mdPath: "",
      logPath: "",
      goal: null,
      title: null,
      progress: null,
    };
    nodes.push({
      name,
      rung: classifyRung(name),
      state: deriveState(stub, { ledger, edges }),
    });
    present.add(name.toUpperCase());
  }

  nodes.sort((a, b) => a.name.localeCompare(b.name));
  return { nodes, edges };
}

// ── decompose — downward composition tree (§1 D2 focus sub-constellation) ─────
// Given a target (e.g. UFO), follow reuse edges DOWNWARD: target is a CONSUMER
// (edge.to), its children are the PROVIDERS (edge.from) it reuses. Recurse on each
// child, guarding against cycles. Roll up an overall state per §4:
//   any ⚪ leaf → target 🟡 (needs-verify); all 🟢/🔵 → target 🟢; any 🔴 on a
//   load-bearing edge is flagged (surfaced via `falsifiedEdge`).

export type CosmosTree = {
  node: CosmosNode;
  /** the edge by which the PARENT reuses this node (undefined for the root). */
  via?: CosmosEdge;
  children: CosmosTree[];
  /** rolled-up state for this subtree (the node + all descendants). */
  rollup: VerifyState;
  /** true if any load-bearing edge in this subtree is falsified. */
  hasFalsified: boolean;
};

export type Decomposition = {
  root: CosmosNode;
  tree: CosmosTree;
};

function rollupState(self: VerifyState, children: CosmosTree[]): VerifyState {
  // No children → the node's own state is the rollup.
  if (children.length === 0) return self;
  const states = [self, ...children.map((c) => c.rollup)];
  if (states.some((s) => s === "falsified")) {
    // A falsified load-bearing dependency means the assembly can't be "verified";
    // honest rollup is needs-verify (the falsification is flagged separately).
    return "needs-verify";
  }
  if (states.some((s) => s === "unverified" || s === "needs-verify")) {
    return "needs-verify";
  }
  // all verified / verified-formal → verified (don't claim formal for an assembly
  // unless every part is formal).
  if (states.every((s) => s === "verified-formal")) return "verified-formal";
  return "verified";
}

export function decompose(
  target: string,
  graph: CosmosGraph,
): Decomposition | null {
  const byName = new Map<string, CosmosNode>();
  for (const n of graph.nodes) byName.set(n.name.toUpperCase(), n);

  const rootNode = byName.get(target.toUpperCase());
  if (!rootNode) return null;

  function build(
    nodeName: string,
    via: CosmosEdge | undefined,
    seen: Set<string>,
  ): CosmosTree {
    const up = nodeName.toUpperCase();
    const node =
      byName.get(up) ??
      ({ name: nodeName, rung: "materials", state: "unverified" } as CosmosNode);

    // children = providers this node reuses (edge.to === node, child = edge.from),
    // skipping already-visited names (cycle guard) and self-edges.
    const childEdges = graph.edges.filter(
      (e) => e.to.toUpperCase() === up && e.from.toUpperCase() !== up,
    );

    const children: CosmosTree[] = [];
    let hasFalsified = node.state === "falsified";
    for (const e of childEdges) {
      const childUp = e.from.toUpperCase();
      if (seen.has(childUp)) continue;
      const childSeen = new Set(seen);
      childSeen.add(childUp);
      const child = build(e.from, e, childSeen);
      children.push(child);
      if (child.hasFalsified) hasFalsified = true;
    }

    const rollup = rollupState(node.state, children);
    return { node, via, children, rollup, hasFalsified };
  }

  const seen = new Set<string>([rootNode.name.toUpperCase()]);
  const tree = build(rootNode.name, undefined, seen);
  return { root: rootNode, tree };
}
