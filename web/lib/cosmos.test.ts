// cosmos.ts smoke test — pure-logic sanity over the live repo tree.
//
// Run (from web/, with tsx installed):  npx tsx lib/cosmos.test.ts
// Or with Node ≥22 native TS stripping + a tiny '@/' alias loader:
//   node --experimental-strip-types --import=<loader>.mjs lib/cosmos.test.ts
// Set DEMIURGE_DATA_ROOT to the demiurge repo root if cwd isn't under it.
// Exits non-zero on any failed assertion. Intentionally tiny — verifies the
// module imports, the graph assembles, and the §2/§4 invariants hold; not a
// coverage suite. (Build typecheck is the primary gate; this is a runtime sanity.)

import {
  decompose,
  classifyRung,
  parseLinkEdges,
  isCosmosDomain,
  COSMOS_EXCLUDE,
  STATE_BADGE,
  type CosmosGraph,
  type Rung,
  type VerifyState,
} from "./cosmos";
import { buildCosmos, readLinkEdges } from "./cosmos.server";

function assert(cond: unknown, msg: string): void {
  if (!cond) {
    console.error(`✗ ${msg}`);
    process.exitCode = 1;
    throw new Error(msg);
  }
  console.log(`✓ ${msg}`);
}

const RUNGS: Rung[] = ["atom", "materials", "bio", "chem", "chip", "system"];
const STATES: VerifyState[] = [
  "verified-formal",
  "verified",
  "needs-verify",
  "unverified",
  "falsified",
];

async function main(): Promise<void> {
  // 0. parseLinkEdges parses a sample `@link A --reuses--> B  # ev` row (§7.1).
  // CosmosEdge keeps from=PROVIDER, to=CONSUMER, so the @link orientation swaps:
  // `@link RTSC --reuses--> NOVEL-TOOL` ⇒ from=NOVEL-TOOL (provider), to=RTSC.
  const sample = parseLinkEdges(
    "@domain RTSC := \"domains/rtsc.md\"\n" +
      "@link RTSC --reuses--> NOVEL-TOOL  # current_loop_offaxis · PR #168\n" +
      "@link UFO --reuses--> FUSION       # triple_product\n" +
      "@link QFORGE --reuses--> stdlib/qforge  # lowercase target skipped\n",
  );
  assert(sample.length === 2, "parseLinkEdges yields 2 domain↔domain edges (skips lowercase)");
  const sampleEdge = sample.find((e) => e.from === "NOVEL-TOOL" && e.to === "RTSC");
  assert(!!sampleEdge, "parseLinkEdges: @link RTSC --reuses--> NOVEL-TOOL → {from:NOVEL-TOOL,to:RTSC}");
  assert(
    !!sampleEdge && /current_loop_offaxis/.test(sampleEdge.evidence ?? ""),
    "parseLinkEdges preserves the evidence string after #",
  );

  // 0b. §7 membership predicate — Category-C excluded, science kept.
  for (const name of COSMOS_EXCLUDE) {
    assert(!isCosmosDomain(name), `isCosmosDomain(${name}) === false (Category-C)`);
  }
  assert(!isCosmosDomain("QFORGE-FUTURE"), "isCosmosDomain QFORGE* prefix excluded");
  assert(isCosmosDomain("RTSC"), "isCosmosDomain(RTSC) === true (science domain)");

  // 1. @link edges parse from the live DOMAINS.tape and resolve domain endpoints.
  const edges = await readLinkEdges();
  assert(edges.length > 0, "readLinkEdges yields ≥1 edge");
  assert(
    edges.every((e) => e.from && e.to),
    "every edge has from + to domains",
  );
  // The seed UFO ← {ANTIMATTER, FUSION} edges must be present after migration.
  assert(
    edges.some((e) => e.to === "UFO" && e.from === "FUSION"),
    "FUSION → UFO reuse edge parsed (migrated @link)",
  );

  // 2. classifyRung honors the manifest table.
  assert(classifyRung("HEX-N6") === "atom", "HEX-N6 → atom (manifest)");
  assert(classifyRung("RTSC") === "materials", "RTSC → materials (manifest)");
  assert(classifyRung("PROTEIN-FOLD") === "bio", "PROTEIN-FOLD → bio (manifest)");
  assert(classifyRung("ELECTROCAT") === "chem", "ELECTROCAT → chem (manifest)");
  assert(classifyRung("CLOAK") === "chip", "CLOAK → chip (manifest)");
  assert(classifyRung("UFO") === "system", "UFO → system (manifest)");
  // keyword fallback (no manifest entry): a "-CURE" therapeutic → bio, not system.
  assert(
    classifyRung("SKIN-CURE", { goal: "완치 치료제 개발" }) === "bio",
    "unlisted -CURE therapeutic → bio (keyword)",
  );

  // 3. buildCosmos assembles a well-typed graph.
  const graph: CosmosGraph = await buildCosmos();
  assert(graph.nodes.length > 0, "buildCosmos yields ≥1 node");
  assert(
    graph.nodes.every((n) => RUNGS.includes(n.rung)),
    "every node rung ∈ ladder",
  );
  assert(
    graph.nodes.every((n) => STATES.includes(n.state)),
    "every node state ∈ verify-state set",
  );
  // every edge endpoint has a node (no dangling refs).
  const names = new Set(graph.nodes.map((n) => n.name.toUpperCase()));
  assert(
    graph.edges.every(
      (e) => names.has(e.from.toUpperCase()) && names.has(e.to.toUpperCase()),
    ),
    "no dangling edge endpoints (stub nodes synthesized)",
  );

  // §7 membership filter — every COSMOS_EXCLUDE name is ABSENT from the graph
  // (neither a roster node nor re-entering via a composition edge endpoint), and
  // the known science domain RTSC IS present.
  for (const ex of COSMOS_EXCLUDE) {
    assert(!names.has(ex.toUpperCase()), `Category-C ${ex} absent from cosmos nodes (§7)`);
  }
  assert(
    graph.edges.every((e) => isCosmosDomain(e.from) && isCosmosDomain(e.to)),
    "no edge endpoint is a Category-C domain (§7 edge filter)",
  );
  assert(names.has("RTSC"), "science domain RTSC present in cosmos nodes (§7)");

  // 4. decompose(UFO) builds a downward tree with a rolled-up state.
  const d = decompose("UFO", graph);
  assert(d !== null, "decompose(UFO) resolves");
  if (d) {
    assert(d.root.name === "UFO", "decomposition root = UFO");
    assert(d.tree.children.length > 0, "UFO decomposes into ≥1 child");
    assert(STATES.includes(d.tree.rollup), "rollup state is honest ∈ set");
  }
  // unknown target → null.
  assert(decompose("NOPE-NOT-A-DOMAIN", graph) === null, "unknown target → null");

  // 5. badge map is total.
  assert(
    STATES.every((s) => typeof STATE_BADGE[s] === "string"),
    "STATE_BADGE total over states",
  );

  console.log("\nALL cosmos smoke checks passed.");
}

main().catch((e) => {
  console.error(e);
  process.exitCode = 1;
});
