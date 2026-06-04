// geometry-3d.server.ts — SERVER-ONLY descriptor resolver.
//
// Splits the node:fs / data-root dependency OUT of the client-bundled
// lib/geometry-3d.ts. Use `loadDescriptor` from server components / route
// handlers (e.g. to resolve a descriptor server-side and pass it to
// DomainModel3D as a prop, avoiding a client fetch round-trip).
//
// Resolution priority (8VERB D5 · AUTO-PROMOTION):
//   (1) hand-authored web/public/models/<DOMAIN>/model.3d.json  — highest (override)
//   (2) AUTO-PARSED faithful descriptor from domains/<DOMAIN>.md — if doc has
//       enough REAL structural numbers (parseDescriptorFromDisk); IN-MEMORY, no
//       JSON written to disk at request time
//   (3) derived procedural → (4) stylized symbol — the prior rung-typed default
// (3)+(4) reuse the pure `deriveDescriptor` from the client-safe module so both
// paths share one fallback. A domain auto-promotes the MOMENT its doc carries
// numbers, with ZERO new files (CLAUDE.md d1/d5/d10).

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";
import {
  deriveDescriptor,
  validateDescriptor,
  type DescriptorSource,
  type Model3DDescriptor,
} from "@/lib/geometry-3d";
import { parseDescriptorFromDisk } from "@/lib/geometry-3d-parse.server";
import type { DomainEntry } from "@/lib/domains";

// (1) read web/public/models/<DOMAIN>/model.3d.json from disk. null if absent.
async function readExternalDescriptor(
  domain: string,
): Promise<Model3DDescriptor | null> {
  try {
    const file = path.join(
      repoDataRoot(),
      "web",
      "public",
      "models",
      domain.toUpperCase(),
      "model.3d.json",
    );
    const raw = await fs.readFile(file, "utf8");
    return validateDescriptor(JSON.parse(raw));
  } catch {
    return null;
  }
}

export async function loadDescriptor(
  src: DescriptorSource,
  entry?: Pick<DomainEntry, "mdPath">,
): Promise<Model3DDescriptor> {
  // (1) hand-authored JSON wins — lets us override the auto-parse.
  const external = await readExternalDescriptor(src.name);
  if (external) return external;
  // (2) auto-parsed faithful descriptor from the domain doc (in-memory). Only
  //     promotes when the doc yields ≥1 real structural number for the rung.
  const parsed = await parseDescriptorFromDisk(src, entry);
  if (parsed) return parsed;
  // (3)+(4) rung-typed derived / stylized default (prior behavior).
  return deriveDescriptor(src);
}
