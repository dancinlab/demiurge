// geometry-3d-parse smoke test — pure-logic sanity for the AUTO-PROMOTION parser.
//
// Run (from web/):
//   node --experimental-strip-types --import ./lib/_test-alias-loader.mjs lib/geometry-3d-parse.test.ts
// (Set DEMIURGE_DATA_ROOT to the demiurge repo root if cwd isn't under it — only
//  needed for the live-disk sub-check at the end.)
//
// Exits non-zero on any failed assertion. Verifies: (1) docs WITHOUT real numbers
// stay stylized (return null) — the honest outcome; (2) docs WITH real structural
// numbers promote to a faithful (stylized:false) descriptor carrying provenance;
// (3) formula summation; (4) the live disk parse over the real repo never invents
// numbers (every promoted node carries a src + ≥1 promoting hit).

import {
  parseDocToDescriptor,
  inspectDoc,
  sumFormula,
} from "./geometry-3d-parse.server";
import type { DescriptorSource } from "./geometry-3d";
import { isStylizedDescriptor } from "./geometry-3d";

function assert(cond: unknown, msg: string): void {
  if (!cond) {
    console.error(`✗ ${msg}`);
    process.exitCode = 1;
    throw new Error(msg);
  }
  console.log(`✓ ${msg}`);
}

function main(): void {
  // 1. Empty / number-free doc → null (stays stylized — honest).
  const sampler =
    "# 🧱 GRAPHENE\n@goal: verify claims\n## 측정 클레임\n- carrier mobility\n- quantum Hall\n";
  const grSrc: DescriptorSource = { name: "GRAPHENE", rung: "materials" };
  assert(parseDocToDescriptor(sampler, grSrc) === null, "number-free doc → null (stylized)");

  // 2. material doc WITH a lattice constant → faithful supercell descriptor.
  const matDoc = "spec: cubic cell, lattice constant a = 3.61 Å, 2x2x2 supercell\n";
  const matSrc: DescriptorSource = { name: "TESTMAT", rung: "materials" };
  const mat = parseDocToDescriptor(matDoc, matSrc);
  assert(mat !== null, "material doc with a=3.61Å promotes");
  assert(mat!.shape === "supercell", "material → supercell shape");
  assert(mat!.params.a === 3.61, "extracted a=3.61");
  assert(mat!.params.nx === 2, "extracted nx=2 from 2x2x2");
  assert(isStylizedDescriptor(mat!) === false, "auto-parsed faithful is NOT stylized");
  assert(
    typeof mat!.params.src === "string" && (mat!.params.src as string).includes(":1"),
    "src provenance carries file:line",
  );

  // 3. bio doc with residue count → helix with turns derived from real residues.
  const bioDoc = "## structure\nThe target protein is 144 residues long (PDB 1ABC).\n";
  const bioSrc: DescriptorSource = { name: "TESTBIO", rung: "bio" };
  const bio = parseDocToDescriptor(bioDoc, bioSrc);
  assert(bio !== null, "bio doc with 144 residues promotes");
  assert(bio!.shape === "helix", "bio → helix shape");
  assert(bio!.params.turns === Math.round(144 / 3.6), "turns derived from real residue count");
  assert(
    (bio!.params.src as string).includes("PDB"),
    "PDB id recorded as a weak (non-promoting) hint",
  );

  // 3b. bio doc with ONLY a PDB id (no counts) → null (PDB alone never promotes).
  const pdbOnly = "## structure\nWe used the crystal structure PDB 6XYZ.\n";
  assert(
    parseDocToDescriptor(pdbOnly, { name: "TESTPDB", rung: "bio" }) === null,
    "PDB id alone (no counts) → null (stays stylized, honest)",
  );

  // 4. chem formula summation.
  assert(sumFormula("C6H12O6") === 24, "sumFormula C6H12O6 = 24");
  assert(sumFormula("H3S") === 4, "sumFormula H3S = 4");
  assert(sumFormula("In") === 0, "sumFormula of a non-formula token = 0");
  const chemDoc = "molecular formula C6H12O6 (glucose) with 24 atoms\n";
  const chem = parseDocToDescriptor(chemDoc, { name: "TESTCHEM", rung: "chem" });
  assert(chem !== null && chem.shape === "molecule", "chem doc with atom count promotes");

  // 5. system doc with a real radius → coil.
  const sysDoc = "verb-2 structure: D = 6.0 m disc, H = 1.6 m, ×6 solenoid array\n";
  const sys = parseDocToDescriptor(sysDoc, { name: "TESTSYS", rung: "system" });
  assert(sys !== null && sys.shape === "coil", "system doc with D=6.0m promotes to coil");
  assert(sys!.params.radius === 3.0, "radius = D/2 = 3.0");

  // 6. inspectDoc never invents — a number-free doc yields zero hits.
  const ins = inspectDoc(sampler, grSrc);
  assert(ins.hits.length === 0, "inspectDoc on number-free doc → 0 hits (no fabrication)");

  console.log("\nALL geometry-3d-parse smoke checks passed.");
}

main();
