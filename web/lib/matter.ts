// Matter ledger — reads exports/material_attestation/<m>/*.json + exports/material_verdict/<m>/*.json
// per CLAUDE.md d_paper_* — surfaces "absorbed?" gate state.
// Falls back to an empty list when the directories are absent.

import { readdir, readFile, stat } from "node:fs/promises";
import { join } from "node:path";
import { repoDataRoot } from "@/lib/data-root";

export type AttestationRow = {
  material: string;
  kind: "attestation" | "verdict";
  file: string;
  absorbed: boolean | null;
  measurement_gate: string | null;
  /** aggregate_verdict (verdict files) or kind (attestation files) — the headline ruling. */
  verdict: string | null;
  /** the physical compound, when carried in the record's context block. */
  compound: string | null;
  /** the material family (e.g. lts · htc · hydride). */
  family: string | null;
  /** critical temperature in Kelvin, when present. */
  tc_k: number | null;
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

/** Walk a few known nesting paths to pull a string/number field out of a record. */
function dig(payload: Record<string, unknown>, ...keys: string[]): unknown {
  for (const k of keys) {
    if (k in payload) return payload[k];
  }
  // common nesting: measured_oracle.context.<key>
  const oracle = payload.measured_oracle;
  if (oracle && typeof oracle === "object") {
    const ctx = (oracle as Record<string, unknown>).context;
    if (ctx && typeof ctx === "object") {
      for (const k of keys) {
        if (k in (ctx as Record<string, unknown>)) {
          return (ctx as Record<string, unknown>)[k];
        }
      }
    }
  }
  return undefined;
}

function asString(v: unknown): string | null {
  return typeof v === "string" && v.length > 0 ? v : null;
}
function asNumber(v: unknown): number | null {
  return typeof v === "number" && Number.isFinite(v) ? v : null;
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
  // Resolve the demiurge data root through the canonical helper (same one the
  // dashboard uses) — robust whether the dev server's cwd is web/ or the repo
  // root. The naive cwd/.. fails when the server runs from the repo root.
  const root = repoDataRoot();
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
        const isVerdict = kind === "material_verdict";
        rows.push({
          material: m,
          kind: isVerdict ? "verdict" : "attestation",
          file: f,
          absorbed: typeof payload.absorbed === "boolean" ? (payload.absorbed as boolean) : null,
          measurement_gate:
            typeof payload.measurement_gate === "string"
              ? (payload.measurement_gate as string)
              : null,
          verdict:
            asString(payload.aggregate_verdict) ??
            asString(payload.gate_type) ??
            asString(payload.kind),
          compound: asString(dig(payload, "compound")),
          family: asString(dig(payload, "family")),
          tc_k: asNumber(dig(payload, "tc_k")),
          payload,
        });
      }
    }
  }
  return rows.sort((a, b) => a.material.localeCompare(b.material));
}
