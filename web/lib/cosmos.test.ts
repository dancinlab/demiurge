// cosmos.test.ts — pure-logic sanity over the live `.demi` SSOT (COSMOS.md §10).
//
// Run (from web/, with tsx installed):  npx tsx lib/cosmos.test.ts
// Or with Node ≥22 native TS stripping + a tiny '@/' alias loader:
//   node --experimental-strip-types --import=<loader>.mjs lib/cosmos.test.ts
// Set DEMIURGE_DATA_ROOT to the demiurge repo root if cwd isn't under it.
// Exits non-zero on any failed assertion. Verifies the `.demi` rebase: nodes =
// INDEX.demi sections (membership by construction), edges = prerequisites, rung =
// facets.scale, verify-state = <id>.demi cell gate/absorbed.

import {
  assembleCosmos,
  decompose,
  scaleToRung,
  cellsToState,
  prereqEdges,
  STATE_BADGE,
  type CosmosGraph,
  type Rung,
  type VerifyState,
} from "./cosmos";
import { parseIndexDemi, parseDomainDemi, type DemiManifest } from "./demi";
import { buildCosmos } from "./cosmos.server";
import { readIndexDemi, readDomainDemi } from "./demi.server";

function assert(cond: unknown, msg: string): void {
  if (!cond) {
    console.error(`✗ ${msg}`);
    process.exitCode = 1;
    throw new Error(msg);
  }
  console.log(`✓ ${msg}`);
}

const RUNGS: Rung[] = ["molecular", "device", "component", "system"];
const STATES: VerifyState[] = [
  "verified-formal",
  "verified",
  "needs-verify",
  "unverified",
  "falsified",
];

async function main(): Promise<void> {
  // 0. parseIndexDemi parses a `[id]` section with scalars + dotted keys + lists.
  const sampleIndex = parseIndexDemi(
    "# comment line\n" +
      "[ufo]\n" +
      'label = "UFO·디스크 추진"  # trailing comment\n' +
      'canvas_mode = "cohort"\n' +
      "prerequisites = [fusion, antimatter, rtsc]\n" +
      'facets.scale = "system"\n' +
      'keywords = ["ufo", "uap"]\n' +
      "\n" +
      "[rtsc]\n" +
      'label = "초전도 코일"\n' +
      "prerequisites = []\n" +
      'facets.scale = "device"\n',
  );
  assert(sampleIndex.length === 2, "parseIndexDemi yields 2 records");
  const ufoRec = sampleIndex.find((d) => d.id === "ufo");
  assert(!!ufoRec, "parseIndexDemi finds [ufo] section");
  assert(ufoRec!.label === "UFO·디스크 추진", "label parsed (comment stripped)");
  assert(ufoRec!.scale === "system", "facets.scale dotted key parsed");
  assert(
    JSON.stringify(ufoRec!.prerequisites) ===
      JSON.stringify(["fusion", "antimatter", "rtsc"]),
    "prerequisites list parsed",
  );
  assert(
    JSON.stringify(ufoRec!.keywords) === JSON.stringify(["ufo", "uap"]),
    "keywords list parsed",
  );

  // 0b. parseDomainDemi parses cell sections + multi-line scope_caveats.
  const sampleCells = parseDomainDemi(
    "# header comment\n" +
      "[cell.specify]\n" +
      "gate_default      = OPEN\n" +
      "absorbed_default  = false\n" +
      "scope_caveats     = [\n" +
      '  "first caveat",\n' +
      '  "second caveat with a # inside a quote",\n' +
      "]\n" +
      "\n" +
      "[cell.verify]\n" +
      "gate_default      = OPEN\n" +
      "absorbed_default  = true\n",
  );
  assert(sampleCells.cells.length === 2, "parseDomainDemi yields 2 cells");
  const sp = sampleCells.cells.find((c) => c.verb === "specify");
  assert(!!sp && sp.gateDefault === "OPEN", "specify cell gate=OPEN");
  assert(!!sp && sp.absorbedDefault === false, "specify cell absorbed=false");
  assert(!!sp && sp.caveats.length === 2, "multi-line scope_caveats parsed (2 entries)");
  const vf = sampleCells.cells.find((c) => c.verb === "verify");
  assert(!!vf && vf.absorbedDefault === true, "verify cell absorbed=true parsed");

  // 1. scaleToRung — the 4 canonical scales map 1:1; unknown → system.
  assert(scaleToRung("molecular") === "molecular", "scaleToRung molecular");
  assert(scaleToRung("device") === "device", "scaleToRung device");
  assert(scaleToRung("component") === "component", "scaleToRung component");
  assert(scaleToRung("system") === "system", "scaleToRung system");
  assert(scaleToRung("") === "system", "scaleToRung empty → system (honest default)");

  // 2. cellsToState — HONEST: all-OPEN/false → unverified; absorbed/CLOSED → verified.
  assert(cellsToState([]) === "unverified", "no cells → unverified ⚪");
  assert(
    cellsToState([{ verb: "specify", gateDefault: "OPEN", absorbedDefault: false, caveats: [] }]) ===
      "unverified",
    "all GATE_OPEN + absorbed=false → unverified ⚪",
  );
  assert(
    cellsToState([
      { verb: "specify", gateDefault: "OPEN", absorbedDefault: false, caveats: [] },
      { verb: "verify", gateDefault: "OPEN", absorbedDefault: true, caveats: [] },
    ]) === "verified",
    "an absorbed=true cell upgrades to verified 🟢",
  );
  assert(
    cellsToState([{ verb: "verify", gateDefault: "CLOSED", absorbedDefault: false, caveats: [] }]) ===
      "verified",
    "a CLOSED gate cell upgrades to verified 🟢",
  );

  // 3. prereqEdges — INDEX.demi prerequisites → edges {from:prereq, to:domain},
  // dropping any prereq not present as a node (membership by construction).
  const edges = prereqEdges(sampleIndex);
  // sampleIndex has ufo→[fusion,antimatter,rtsc] but only rtsc is a node here, so
  // only the rtsc→ufo edge survives.
  assert(
    edges.length === 1 && edges[0].from === "rtsc" && edges[0].to === "ufo",
    "prereqEdges drops prereqs with no node (rtsc→ufo survives, fusion/antimatter dropped)",
  );

  // 4. buildCosmos assembles a well-typed graph from the LIVE INDEX.demi.
  const graph: CosmosGraph = await buildCosmos();
  assert(graph.nodes.length > 0, "buildCosmos yields ≥1 node from INDEX.demi");
  assert(
    graph.nodes.every((n) => RUNGS.includes(n.rung)),
    "every node rung ∈ {molecular,device,component,system}",
  );
  assert(
    graph.nodes.every((n) => STATES.includes(n.state)),
    "every node state ∈ verify-state set",
  );
  const names = new Set(graph.nodes.map((n) => n.name.toLowerCase()));

  // membership BY CONSTRUCTION: ufo present; a tooling/meta name (8VERB) absent
  // (it is simply NOT in INDEX.demi — no exclude list needed).
  assert(names.has("ufo"), "INDEX.demi node `ufo` present");
  assert(names.has("rtsc"), "INDEX.demi node `rtsc` present");
  assert(!names.has("8verb"), "tooling name 8VERB absent (not in INDEX.demi)");
  assert(!names.has("cosmos"), "meta name COSMOS absent (not in INDEX.demi)");
  assert(!names.has("qforge"), "compute-engine name QFORGE absent (not in INDEX.demi)");

  // rung of `ufo` = its facets.scale = system.
  const ufoNode = graph.nodes.find((n) => n.name.toLowerCase() === "ufo")!;
  assert(ufoNode.rung === "system", "ufo rung = facets.scale (system)");

  // every edge endpoint has a node (no dangling refs — prereqs filtered to nodes).
  assert(
    graph.edges.every(
      (e) => names.has(e.from.toLowerCase()) && names.has(e.to.toLowerCase()),
    ),
    "no dangling edge endpoints (prereqs restricted to INDEX.demi nodes)",
  );

  // 5. ufo prerequisites edges include antimatter, fusion, rtsc (the §10 assertion).
  const ufoChildren = new Set(
    graph.edges.filter((e) => e.to === "ufo").map((e) => e.from),
  );
  assert(ufoChildren.has("antimatter"), "ufo prereq edge ← antimatter");
  assert(ufoChildren.has("fusion"), "ufo prereq edge ← fusion");
  assert(ufoChildren.has("rtsc"), "ufo prereq edge ← rtsc");

  // 6. a domain whose live <id>.demi cells are ALL GATE_OPEN reads unverified ⚪.
  // cloak.demi (all 7 cells GATE_OPEN + absorbed=false) — but cloak is NOT in
  // INDEX.demi, so assert directly on its parsed manifest (verify-state derivation).
  const cloakCells = await readDomainDemi("cloak");
  if (cloakCells.cells.length > 0) {
    assert(
      cellsToState(cloakCells.cells) === "unverified",
      "all-GATE_OPEN domain (cloak.demi) → unverified ⚪",
    );
  } else {
    console.log("· (cloak.demi not on disk in this tree — skipping live all-OPEN check)");
  }
  // And on a LIVE INDEX.demi node with all-OPEN cells: ufo.demi is all GATE_OPEN.
  const ufoCells = await readDomainDemi("ufo");
  if (ufoCells.cells.length > 0) {
    assert(
      cellsToState(ufoCells.cells) === "unverified",
      "ufo.demi (all GATE_OPEN) → ufo node unverified ⚪",
    );
    assert(ufoNode.state === "unverified", "live ufo node state = unverified ⚪ (honest)");
  }

  // 7. decompose(ufo) builds a downward tree with a rolled-up state.
  const d = decompose("ufo", graph);
  assert(d !== null, "decompose(ufo) resolves");
  if (d) {
    assert(d.root.name === "ufo", "decomposition root = ufo");
    assert(d.tree.children.length > 0, "ufo decomposes into ≥1 child");
    assert(STATES.includes(d.tree.rollup), "rollup state is honest ∈ set");
  }
  assert(decompose("nope-not-a-domain", graph) === null, "unknown target → null");

  // 8. badge map is total.
  assert(
    STATES.every((s) => typeof STATE_BADGE[s] === "string"),
    "STATE_BADGE total over states",
  );

  // sanity: readIndexDemi + assembleCosmos round-trip equals buildCosmos node count.
  const liveIndex = await readIndexDemi();
  const manifests: Record<string, DemiManifest> = {};
  for (const dd of liveIndex) manifests[dd.id] = await readDomainDemi(dd.id);
  const reassembled = assembleCosmos(liveIndex, manifests);
  assert(
    reassembled.nodes.length === graph.nodes.length,
    "assembleCosmos round-trip = buildCosmos node count",
  );

  console.log("\nALL cosmos smoke checks passed.");
}

main().catch((e) => {
  console.error(e);
  process.exitCode = 1;
});
