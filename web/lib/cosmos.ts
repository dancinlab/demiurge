// cosmos.ts — the Domain Cosmos composition graph (8VERB Cosmos design SSOT).
//
// Pure, server-safe data module (no UI). Assembles, manifest-driven (d4 — no
// per-domain dispatch hardcoding beyond a small classification table), the full
// cosmos graph the GUI renders:
//
//   listDomains() (DOMAINS.tape roster + per-domain .md snapshot)   ── nodes
//   NEXUS.tape  @X e<n>/c<n> reuse edges                            ── edges
//   classifyRung()                                                  ── §2 ladder
//   deriveState()                                                   ── §4 verify state
//
// Verification state is HONEST (§4 · d6 · d_paper_*): a node is only painted
// 🟢/🔵 when a real verified signal exists; absence of signal → ⚪ "unverified".
// We NEVER upgrade a projection / partial / candidate into a proven badge.

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";
import { listDomains, type DomainEntry } from "@/lib/domains";
import { readMatterLedger, type AttestationRow } from "@/lib/matter";

// ── §2 scale ladder ──────────────────────────────────────────────────────────
// 원자 / 물질·바이오·화학 / 칩·상위구조 / 시스템.
export type Rung = "atom" | "materials" | "chip" | "system";

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

// A reuse / composition edge (NEXUS.tape @X e<n> reuse-edge or @X c<n> candidate).
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

// ── §3 reuse edges — NEXUS.tape parser ───────────────────────────────────────
// Parse `@X e<n> := "..." :: reuse-edge [tier-N ...]` blocks (provides → reused_by
// + primitive + evidence) AND `@X c<n> := "..." :: reuse-candidate [...]` blocks
// (marked tier:"candidate"). A reuse-edge whose id starts with `c` but is tagged
// `reuse-edge` (e.g. c7/c8 in the live file) keeps its declared tier.
//
// Domain extraction: the block's `provides`/`reused_by` fields are free-form prose
// ("ANTIMATTER (6) trap — ...", "CLOAK Phase A ⓸ ..."). We pull the leading
// UPPERCASE domain token (the roster name) from each. This is the SSOT shape the
// design (§3) prescribes: edge tier = trust of the LINK, node state = trust of the
// DOMAIN.

const NEXUS_PATH_PARTS = ["NEXUS.tape"] as const;

// Leading roster-style domain token: UPPERCASE start, then [A-Z0-9+_-], e.g.
// RTSC · HEX-N6 · AGA-CURE · CARDIO+ . Stops at the first lowercase/space/paren.
const DOMAIN_TOKEN = /([A-Z][A-Z0-9+_-]*)/;

// Tokens that look like a domain name but are NOT (provenance/library noise).
// e13 "stdlib/math (PR #1949)" would otherwise yield the bogus domain "PR".
const NON_DOMAIN_TOKENS = new Set(["PR", "PRs", "OEIS", "LOC", "TODO", "WIP", "TL"]);

function leadingDomain(text: string | undefined): string | null {
  if (!text) return null;
  // A provider/consumer that begins with a lowercase library path (stdlib/math,
  // compiler/atlas) is a stdlib primitive, not a roster domain — no domain edge.
  if (/^[a-z]/.test(text.trim())) return null;
  const m = text.match(DOMAIN_TOKEN);
  if (!m) return null;
  if (NON_DOMAIN_TOKENS.has(m[1])) return null;
  return m[1];
}

function parseTier(tags: string): EdgeTier {
  const m = tags.match(/tier-([123])/);
  if (m) return `tier-${m[1]}` as EdgeTier;
  return "unknown";
}

// Read the `key = "value"` (or `key = value`) body fields of one block.
function blockField(body: string, key: string): string | undefined {
  // quoted form first
  const q = body.match(new RegExp(`^\\s*${key}\\s*=\\s*"([^"]*)"`, "m"));
  if (q) return q[1].trim();
  const u = body.match(new RegExp(`^\\s*${key}\\s*=\\s*(.+)$`, "m"));
  return u ? u[1].trim() : undefined;
}

export async function readNexusEdges(): Promise<CosmosEdge[]> {
  const p = path.join(repoDataRoot(), ...NEXUS_PATH_PARTS);
  let text: string;
  try {
    text = await fs.readFile(p, "utf8");
  } catch {
    return [];
  }

  const edges: CosmosEdge[] = [];

  // Split into @X blocks: a header line `@X <id> := "..." :: <kind> [<tags>]`
  // followed by indented body lines until the next top-level token.
  const headerRe =
    /^@X\s+([a-zA-Z]+\d+)\s*:=\s*"[^"]*"\s*::\s*(reuse-edge|reuse-candidate)\s*\[([^\]]*)\]/gm;

  const matches = [...text.matchAll(headerRe)];
  for (let i = 0; i < matches.length; i++) {
    const m = matches[i];
    const id = m[1];
    const kind = m[2];
    const tags = m[3];
    const bodyStart = m.index! + m[0].length;
    const bodyEnd = i + 1 < matches.length ? matches[i + 1].index! : text.length;
    const body = text.slice(bodyStart, bodyEnd);

    const provides = blockField(body, "provides");
    const reusedBy = blockField(body, "reused_by");
    const primitive = blockField(body, "primitive");
    const evidence = blockField(body, "evidence");

    const from = leadingDomain(provides);
    const to = leadingDomain(reusedBy);

    // candidate blocks (reuse-candidate) often have only a `note` — no provides/
    // reused_by domains. We still keep them when both endpoints resolve; else skip
    // (no node pair to connect). reuse-candidate ⇒ tier "candidate" regardless of
    // any [tier-N] tag (the LINK is unproven by definition).
    if (!from || !to) continue;

    const tier: EdgeTier = kind === "reuse-candidate" ? "candidate" : parseTier(tags);
    edges.push({
      from,
      to,
      primitive: primitive ?? undefined,
      tier,
      evidence: evidence ?? undefined,
    });
  }

  // Also fold the `@reuse <DOMAIN> reused[...]` short-form edges (AGA-CURE, OA-CURE,
  // …) appended at the tail of NEXUS.tape. Form:
  //   @reuse <CONSUMER> reused[<PROVIDER>,<PROVIDER>...]
  // consumer reuses each provider → edge from=provider → to=consumer.
  const reuseShortRe = /^@reuse\s+([A-Z][A-Z0-9+_-]*)\s+reused\[([^\]]*)\]/gm;
  for (const m of text.matchAll(reuseShortRe)) {
    const consumer = m[1];
    const providers = m[2]
      .split(",")
      .map((s) => leadingDomain(s.trim()))
      .filter((s): s is string => !!s);
    for (const provider of providers) {
      if (provider === consumer) continue;
      edges.push({ from: provider, to: consumer, tier: "tier-1" });
    }
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
  // ② 물질·바이오·화학 MATERIALS.
  RTSC: "materials",
  PEROVSKITE: "materials",
  GRAPHENE: "materials",
  METAMATERIAL: "materials",
  AEROGEL: "materials",
  SPINTRONIC: "materials",
  MEMRISTOR: "materials",
  "AGA-RX": "materials",
  "GENE-EDIT": "materials",
  "RNA-THERAPY": "materials",
  ORGANOID: "materials",
  "PROTEIN-FOLD": "materials",
  ELECTROCAT: "materials",
  PHOTOREDOX: "materials",
  "CO2-CAPTURE": "materials",
  "GREEN-NH3": "materials",
  SENOLYX: "materials",
  // ③ 칩·상위구조 CHIP — devices / metasurfaces / trap assemblies.
  CLOAK: "chip",
  ANTIMATTER: "chip",
  CERN: "chip",
  NEUROMORPHIC: "chip",
  PHOTONIC: "chip",
  // ④ 시스템 SYSTEM — assembled bodies / full pipelines.
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
const RUNG_KEYWORDS: Array<{ rung: Rung; re: RegExp }> = [
  { rung: "system", re: /(-CURE$|CURE\b|시스템|system|비행체|추진|craft|vehicle|drive|propuls)/i },
  { rung: "chip", re: /(chip|칩|device|소자|trap|트랩|metasurface|메타표면|circuit|회로|accelerator|가속)/i },
  { rung: "atom", re: /(atom|원자|lattice|격자|qubit|큐비트|quantum|양자|primitive)/i },
  { rung: "materials", re: /(material|물질|재료|drug|약|gene|유전|protein|단백|cell|세포|catalyst|촉매|molecule|분자|superconduct|초전도)/i },
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

// ── buildCosmos — assemble the full graph ────────────────────────────────────
export async function buildCosmos(): Promise<CosmosGraph> {
  const [domains, edges, ledger] = await Promise.all([
    listDomains(),
    readNexusEdges(),
    readMatterLedger(),
  ]);

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
