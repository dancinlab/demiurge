// geometry-3d.server.ts — SERVER-ONLY descriptor resolver.
//
// Splits the node:fs / data-root dependency OUT of the client-bundled
// lib/geometry-3d.ts. Use `loadDescriptor` from server components / route
// handlers (e.g. to resolve a descriptor server-side and pass it to
// DomainModel3D as a prop, avoiding a client fetch round-trip).
//
// Resolution priority (8VERB D5): (1) external file on disk → (2) derived
// procedural → (3) stylized symbol. (2)+(3) reuse the pure `deriveDescriptor`
// from the client-safe module so both paths share one fallback.

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";
import {
  deriveDescriptor,
  validateDescriptor,
  type DescriptorSource,
  type Model3DDescriptor,
} from "@/lib/geometry-3d";

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
): Promise<Model3DDescriptor> {
  const external = await readExternalDescriptor(src.name);
  if (external) return external;
  return deriveDescriptor(src);
}
