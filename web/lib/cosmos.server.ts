// cosmos.server.ts — the SERVER-ONLY I/O layer for the Domain Cosmos graph.
//
// Mirrors the geometry-3d.ts / geometry-3d.server.ts split: the pure logic +
// types live in cosmos.ts (client-safe — CosmosScene imports decompose /
// STATE_BADGE from there), while the node:fs reads (DOMAINS.tape roster +
// @link connection graph · matter verdict ledger) live HERE so they never enter
// the browser chunk. The MAIN PAGE server component imports buildCosmos here.
//
// §7.1: NEXUS.tape is RETIRED. The connection graph now rides inside DOMAINS.tape
// as `@link <from> --<verb>--> <to>  # evidence` rows (readLinkEdges below).

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";
import { listDomains } from "@/lib/domains";
import { readMatterLedger } from "@/lib/matter";
import {
  assembleCosmos,
  decompose,
  parseLinkEdges,
  type CosmosEdge,
  type CosmosGraph,
  type CosmosNode,
  type Decomposition,
} from "@/lib/cosmos";

const LINK_PATH_PARTS = ["DOMAINS.tape"] as const;

// Read the root DOMAINS.tape off disk and parse its `@link` rows into reuse edges
// (pure parse in cosmos.ts). §7.1 — replaces the retired NEXUS.tape reader. Keeps
// the empty-on-missing fallback so an absent roster yields an empty graph.
export async function readLinkEdges(): Promise<CosmosEdge[]> {
  const p = path.join(repoDataRoot(), ...LINK_PATH_PARTS);
  try {
    const text = await fs.readFile(p, "utf8");
    return parseLinkEdges(text);
  } catch {
    return [];
  }
}

// buildCosmos — load the three sources and assemble the full graph (pure step).
export async function buildCosmos(): Promise<CosmosGraph> {
  const [domains, edges, ledger] = await Promise.all([
    listDomains(),
    readLinkEdges(),
    readMatterLedger(),
  ]);
  return assembleCosmos(domains, edges, ledger);
}

// resolveCosmosNode — resolve ONE focused node + its decomposition from the full
// graph. The verb pages (P4) carry a focused domain-node; this is the SSOT lookup
// they all share (d4: single generic path — match on the leaf segment, no per-
// domain branch). `id` may be the nested route id ("CARDIO+/DAPTPGX") or a flat
// name ("RTSC"); we match the LEAF (last "/" segment), case-insensitive.
export async function resolveCosmosNode(id: string): Promise<{
  node: CosmosNode | null;
  graph: CosmosGraph;
  decomposition: Decomposition | null;
}> {
  const graph = await buildCosmos();
  const leaf = (id.split("/").pop() ?? id).toUpperCase();
  const node =
    graph.nodes.find((n) => n.name.toUpperCase() === leaf) ?? null;
  const decomposition = node ? decompose(node.name, graph) : null;
  return { node, graph, decomposition };
}
