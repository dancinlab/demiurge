// demi.server.ts — SERVER-ONLY fs reads for the `.demi` SSOT (COSMOS.md §10).
//
// Mirrors the cosmos.server.ts / cosmos.ts split: the pure parsers live in
// demi.ts (client-safe), while the node:fs reads live HERE so they never enter
// the browser chunk. buildCosmos() (cosmos.server.ts) consumes these.
//
//   readIndexDemi()      — reads domains/INDEX.demi → DemiDomain[] (the graph SSOT)
//   readDomainDemi(id)   — reads domains/<id>.demi → DemiManifest (verb cells)
//
// Both keep the empty-on-missing fallback (an absent file yields an empty result,
// not a throw) — a `[<id>]` in INDEX.demi with no matching `<id>.demi` honestly
// reads as zero cells → ⚪ unverified downstream.

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";
import {
  parseIndexDemi,
  parseDomainDemi,
  type DemiDomain,
  type DemiManifest,
} from "@/lib/demi";

// domains/ dir under the repo data root (same tree the hexa CLI's
// dc_domains_dir() resolves: <projectRoot>/domains).
function domainsDir(): string {
  return path.join(repoDataRoot(), "domains");
}

// readIndexDemi — domains/INDEX.demi → DemiDomain[]. Empty on missing.
export async function readIndexDemi(): Promise<DemiDomain[]> {
  const p = path.join(domainsDir(), "INDEX.demi");
  try {
    const text = await fs.readFile(p, "utf8");
    return parseIndexDemi(text);
  } catch {
    return [];
  }
}

// readDomainDemi — domains/<id>.demi → DemiManifest. Empty cells on missing
// (an INDEX.demi node with no per-domain manifest is honest ⚪ unverified).
export async function readDomainDemi(id: string): Promise<DemiManifest> {
  const p = path.join(domainsDir(), `${id}.demi`);
  try {
    const text = await fs.readFile(p, "utf8");
    return parseDomainDemi(text);
  } catch {
    return { cells: [] };
  }
}
