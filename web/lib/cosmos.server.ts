// cosmos.server.ts — the SERVER-ONLY I/O layer for the Domain Cosmos graph.
//
// Mirrors the geometry-3d.ts / geometry-3d.server.ts split: the pure logic +
// types live in cosmos.ts (client-safe — CosmosScene imports decompose /
// STATE_BADGE from there), while the node:fs reads live HERE so they never enter
// the browser chunk. The MAIN PAGE server component imports buildCosmos here.
//
// §10: the data layer is rebased onto the `.demi` SSOT. buildCosmos reads
// domains/INDEX.demi (the graph: nodes + prerequisites + facets.scale) and each
// referenced domains/<id>.demi (verb cells → verify-state) via demi.server.ts.
// The retired sources (DOMAINS.tape roster · @link edges · <D>.md prose-parse ·
// matter ledger) are no longer read.

import {
  assembleCosmos,
  decompose,
  type CosmosGraph,
  type CosmosNode,
  type Decomposition,
} from "@/lib/cosmos";
import { readIndexDemi, readDomainDemi } from "@/lib/demi.server";
import type { DemiManifest } from "@/lib/demi";

// buildCosmos — load the `.demi` SSOT and assemble the full graph (pure step).
// INDEX.demi gives the node set + prerequisite edges + scale; each <id>.demi gives
// that node's verb cells (→ verify-state). A node whose <id>.demi is missing reads
// honest ⚪ unverified (empty-cells fallback in readDomainDemi).
export async function buildCosmos(): Promise<CosmosGraph> {
  const domains = await readIndexDemi();
  const manifests: Record<string, DemiManifest> = {};
  await Promise.all(
    domains.map(async (d) => {
      manifests[d.id] = await readDomainDemi(d.id);
    }),
  );
  return assembleCosmos(domains, manifests);
}

// resolveCosmosNode — resolve ONE focused node + its decomposition from the full
// graph. The verb pages (P4) carry a focused domain-node; this is the SSOT lookup
// they all share (d4: single generic path — match on the leaf segment, no per-
// domain branch). `id` may be a nested route id or a flat name; we match the LEAF
// (last "/" segment), case-insensitive.
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
