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
  STATE_BADGE,
  type CosmosGraph,
  type Rung,
  type VerifyState,
} from "./cosmos";
import { buildCosmos, readNexusEdges } from "./cosmos.server";

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
  // 1. NEXUS edges parse and resolve domain endpoints.
  const edges = await readNexusEdges();
  assert(edges.length > 0, "readNexusEdges yields ≥1 edge");
  assert(
    edges.every((e) => e.from && e.to),
    "every edge has from + to domains",
  );
  // The seed UFO ← {ANTIMATTER, FUSION} edges (e4/e5/e6) must be present.
  assert(
    edges.some((e) => e.to === "UFO" && e.from === "FUSION"),
    "FUSION → UFO reuse edge parsed",
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
