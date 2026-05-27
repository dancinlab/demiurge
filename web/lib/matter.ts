// Matter ledger — reads exports/material_attestation/<m>/*.json + exports/material_verdict/<m>/*.json
// per CLAUDE.md d_paper_* — surfaces "absorbed?" gate state.
// Falls back to an empty list when the directories are absent.

import { readdir, readFile, stat } from "node:fs/promises";
import { join } from "node:path";

export type AttestationRow = {
  material: string;
  kind: "attestation" | "verdict";
  file: string;
  absorbed: boolean | null;
  measurement_gate: string | null;
  payload: Record<string, unknown>;
};

async function safeRead(p: string): Promise<Record<string, unknown>> {
  try {
    const raw = await readFile(p, "utf8");
    return JSON.parse(raw) as Record<string, unknown>;
  } catch {
    return {};
  }
}

async function dirIfExists(p: string): Promise<string[]> {
  try {
    const s = await stat(p);
    if (!s.isDirectory()) return [];
    return await readdir(p);
  } catch {
    return [];
  }
}

export async function readMatterLedger(): Promise<AttestationRow[]> {
  const root = process.env.DEMIURGE_DATA_ROOT ?? join(process.cwd(), "..");
  const rows: AttestationRow[] = [];
  for (const kind of ["material_attestation", "material_verdict"] as const) {
    const base = join(root, "exports", kind);
    const materials = await dirIfExists(base);
    for (const m of materials) {
      const matDir = join(base, m);
      const files = await dirIfExists(matDir);
      for (const f of files.filter((x) => x.endsWith(".json"))) {
        const p = join(matDir, f);
        const payload = await safeRead(p);
        rows.push({
          material: m,
          kind: kind === "material_attestation" ? "attestation" : "verdict",
          file: f,
          absorbed: typeof payload.absorbed === "boolean" ? (payload.absorbed as boolean) : null,
          measurement_gate:
            typeof payload.measurement_gate === "string"
              ? (payload.measurement_gate as string)
              : null,
          payload,
        });
      }
    }
  }
  return rows.sort((a, b) => a.material.localeCompare(b.material));
}
