// cosmos.ts — the Domain Cosmos composition graph (8VERB Cosmos design SSOT).
//
// Pure, server-safe data module (no UI). Assembles the full cosmos graph the GUI
// renders, rebased onto the `.demi` SSOT (COSMOS.md §10). The prior patchwork
// (DOMAINS.tape roster · `@link` edges · `<D>.md` prose-parse · matter ledger)
// is RETIRED — everything now reads from `.demi`:
//
//   INDEX.demi `[<id>]` sections   ── nodes (membership by CONSTRUCTION: no
//                                      exclude list; tooling/meta domains simply
//                                      aren't in INDEX.demi)
//   INDEX.demi `prerequisites`     ── composition/decompose edges (D82 direct
//                                      prereqs; transitive closure via decompose)
//   INDEX.demi `facets.scale`      ── the rung (§2 ladder · 4 canonical scales)
//   <id>.demi `[cell.<verb>]`      ── verify-state (gate_default / absorbed_default)
//
// Verification state is HONEST (§4 · d6 · d_paper_*): a node is only painted
// 🟢/🔵 when a real verified signal exists in its `.demi` cells (a CLOSED gate or
// an absorbed=true cell). All-OPEN / all-false cells → ⚪ "unverified". We NEVER
// upgrade from progress — `.demi` gate/absorbed flags ARE the proof signal.

// NOTE (SSR/bundling): this module is imported by BOTH server pages and client
// components (CosmosScene needs the PURE functions `decompose` · `STATE_BADGE`
// + the types). The fs reads live in cosmos.server.ts / demi.server.ts and are
// never pulled in here, so this file stays client-safe (no `node:fs` in the
// browser chunk). The `.demi` parse types below are type-only (bundler-free).
import type { DemiDomain, DemiManifest } from "@/lib/demi";

// ── §2 / §10 scale ladder — the layperson 6-band rung, data-driven via `.demi` ─
// COSMOS.md §10: the intended LAYPERSON ladder is SIX bands —
//   atom(원자) · materials(물질) · bio(바이오) · chem(화학) · chip(칩) · system(시스템)
// The canonical `.demi` `facets.scale` has only FOUR coarse values
// (molecular · device · component · system) and LUMPS materials/bio/chem into
// `molecular`. To restore the finer ladder WITHOUT a hardcoded keyword classifier
// (d4 — data, not code), INDEX.demi carries an OPTIONAL `facets.rung` per node
// (one of the 6 bands). cosmos PREFERS `facets.rung` and falls back to mapping
// `facets.scale` when it is absent. atom is the bottom band, system the apex.
export type Rung = "atom" | "materials" | "bio" | "chem" | "chip" | "system";

// The valid 6-band set (membership check for an INDEX.demi `facets.rung` value).
export const RUNG_VALUES: readonly Rung[] = [
  "atom",
  "materials",
  "bio",
  "chem",
  "chip",
  "system",
];

function isRung(v: string): v is Rung {
  return (RUNG_VALUES as readonly string[]).includes(v);
}

// SCALE_TO_RUNG — the FALLBACK mapping from a coarse `.demi` `facets.scale` onto
// the 6-band rung, used ONLY when a node carries no explicit `facets.rung`. The
// coarse `molecular` scale lumps materials/bio/chem together, so it maps to the
// most generic of those (`materials`); device/component → `chip`; system → `system`.
// (A node that wants bio/chem precision adds `facets.rung = "bio"` in INDEX.demi.)
const SCALE_TO_RUNG: Record<string, Rung> = {
  molecular: "materials",
  device: "chip",
  component: "chip",
  system: "system",
};

// scaleToRung — map a `.demi` `facets.scale` string onto the Rung union. Unknown
// or empty → "system" (INDEX.demi's own default for a record with no facets.scale).
export function scaleToRung(scale: string): Rung {
  return SCALE_TO_RUNG[scale] ?? "system";
}

// resolveRung — the canonical rung resolution (§10 finer-split): PREFER an explicit
// `facets.rung` (if present AND a valid 6-band value), else fall back to mapping
// the coarse `facets.scale`. `rung` is OPTIONAL per node (data-driven · d4), so a
// node with no/invalid `facets.rung` degrades cleanly through SCALE_TO_RUNG.
export function resolveRung(rung: string | undefined, scale: string): Rung {
  if (rung && isRung(rung)) return rung;
  return scaleToRung(scale);
}

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

// A composition edge (INDEX.demi `prerequisites` · §10). The prerequisite is the
// CHILD (a constituent the parent is COMPOSED of); the parent is the consumer.
// CosmosEdge keeps from=PROVIDER(child), to=CONSUMER(parent): for `[ufo]
// prerequisites = [fusion, antimatter, rtsc]`, three edges {from:fusion,to:ufo}
// … so decompose() walks children = providers of a consumer (edge.to === node,
// child = edge.from) downward, unchanged.
export type EdgeTier = "tier-1" | "tier-2" | "tier-3" | "candidate" | "unknown";

export type CosmosEdge = {
  from: string; // provider domain (the prerequisite / child)
  to: string; // consumer domain (the dependent / parent)
  primitive?: string;
  tier?: EdgeTier;
  evidence?: string;
};

export type CosmosGraph = { nodes: CosmosNode[]; edges: CosmosEdge[] };

// ── §4 verify-state derivation from `.demi` cells — HONEST (§10) ──────────────
// The `<id>.demi` verb cells ARE the verify-state SSOT (replaces the prose-parse +
// matter ledger). Per cell:
//   gate_default = CLOSED      → a real measurement gate passed  → "verified"
//   absorbed_default = true    → an absorption claim (gate still OPEN by default)
//                                → "verified" (matches the prior matter-ledger
//                                  `absorbed===true → verified` honesty rule)
//   gate OPEN + absorbed false → no proof signal                → contributes ⚪
// A domain with NO cells (missing `<id>.demi`) → "unverified" (honest). We NEVER
// infer verified from progress — only a CLOSED gate or absorbed=true cell upgrades.
//
// Rank picks the strongest honest verdict across cells. (No `.demi` field yet
// expresses a FORMAL closed-form (🔵) or a FALSIFIED (🔴) gate; those states stay
// in the union for forward-compat + the decompose rollup, but a cell cannot
// currently emit them — honesty: we only surface what `.demi` actually asserts.)
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

// cellsToState — derive the honest node VerifyState from its `.demi` verb cells.
// ALL cells OPEN + absorbed=false (or NO cells) → "unverified" ⚪. A single
// CLOSED gate or absorbed=true cell upgrades to "verified" 🟢.
export function cellsToState(cells: DemiManifest["cells"]): VerifyState {
  if (cells.length === 0) return "unverified";
  let best: VerifyState = "unverified";
  for (const c of cells) {
    let s: VerifyState = "unverified";
    if (c.gateDefault.toUpperCase() === "CLOSED") s = "verified";
    else if (c.absorbedDefault === true) s = "verified";
    best = strongest(best, s);
  }
  return best;
}

// ── icon + label from the `.demi` `label` field (§ d10: icon · NAME · alias) ──
// INDEX.demi `label` is a short display string (e.g. "UFO·디스크 추진", "초전도 코일").
// The `.demi` label carries no leading emoji by convention, so the cosmos uses
// the label as the human alias and lets the renderer pick a default glyph. We
// still split a leading emoji defensively (a future label MAY carry one).
const LEADING_EMOJI =
  /^([\p{Extended_Pictographic}←-⇿⌀-➿️‍]+)/u;

function parseLabel(label: string): { icon?: string; alias?: string } {
  const t = label.trim();
  if (t.length === 0) return {};
  const em = t.match(LEADING_EMOJI);
  const icon = em ? em[1].trim() : undefined;
  const rest = icon ? t.slice(em![0].length).trim() : t;
  return { icon: icon || undefined, alias: rest || undefined };
}

// ── prereqEdges — INDEX.demi `prerequisites` → CosmosEdge[] (§10) ─────────────
// For each domain, each prerequisite `p` yields an edge {from:p, to:domain}
// (provider=prereq/child, consumer=domain/parent). Self-edges and edges whose
// endpoint is not an INDEX.demi node are dropped (by-construction membership —
// an unknown prereq id has no node, so the graph has no dangling refs).
export function prereqEdges(domains: DemiDomain[]): CosmosEdge[] {
  const known = new Set(domains.map((d) => d.id.toLowerCase()));
  const edges: CosmosEdge[] = [];
  for (const d of domains) {
    for (const p of d.prerequisites) {
      if (p === d.id) continue;
      if (!known.has(p.toLowerCase())) continue; // membership by construction
      edges.push({ from: p, to: d.id, tier: "tier-1", evidence: "prerequisite" });
    }
  }
  return edges;
}

// ── assembleCosmos — pure graph assembly from already-loaded `.demi` inputs ────
// Client-safe (no I/O): the server entry buildCosmos() (cosmos.server.ts) reads
// INDEX.demi + each <id>.demi off disk and calls this. Keeping assembly pure lets
// it be unit-tested and keeps cosmos.ts free of node:fs.
//
// `manifests` maps a domain id → its parsed `<id>.demi` cells (empty if missing).
// Node membership IS the INDEX.demi `[<id>]` set (no exclude list); edges ARE the
// `prerequisites` (no @link); rung IS `facets.scale`; state IS the cell gate/absorbed.
export function assembleCosmos(
  domains: DemiDomain[],
  manifests: Record<string, DemiManifest>,
): CosmosGraph {
  const edges = prereqEdges(domains);

  const nodes: CosmosNode[] = domains.map((d) => {
    const { icon, alias } = parseLabel(d.label);
    const cells = manifests[d.id]?.cells ?? [];
    return {
      name: d.id,
      icon,
      alias,
      // §10 finer-split: PREFER the explicit `facets.rung`, else map `facets.scale`.
      rung: resolveRung(d.rung, d.scale),
      state: cellsToState(cells),
      goal: d.label || undefined,
    };
  });

  nodes.sort((a, b) => a.name.localeCompare(b.name));
  return { nodes, edges };
}

// ── decompose — downward composition tree (§1 D2 focus sub-constellation) ─────
// Given a target (e.g. ufo), follow prerequisite edges DOWNWARD: target is a
// CONSUMER (edge.to), its children are the PROVIDERS / prerequisites (edge.from)
// it is composed of. Recurse on each child, guarding against cycles. Roll up an
// overall state per §4: any ⚪ leaf → target 🟡 (needs-verify); all 🟢/🔵 → 🟢; a
// 🔴 on a load-bearing edge is flagged (surfaced via `hasFalsified`).

export type CosmosTree = {
  node: CosmosNode;
  /** the edge by which the PARENT is composed of this node (undefined for root). */
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

    // children = prerequisites this node is composed of (edge.to === node, child =
    // edge.from), skipping already-visited names (cycle guard) and self-edges.
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
