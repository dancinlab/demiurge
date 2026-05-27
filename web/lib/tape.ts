// Minimal `.tape` reader — parses pointer manifests under `domains/*.tape`
// into a JSON-friendly shape for /api/v1/* endpoints.
//
// Grammar subset supported:
//   @<TYPE> <id> [:= "<subject>"] :: <domain> [<grade>]
//     key = value        (string · number · bool)
//     key = [ "a", "b" ] (single-line array)
//   # comment lines + blank lines ignored.
//
// We do NOT implement the full tape grammar — only what these 3 manifests
// (STDLIB_MATRIX · CATEGORIES · PUBLIC_DOMAINS) use today.

import { readFile } from "node:fs/promises";
import { join } from "node:path";

export type TapeNode = {
  type: string;
  id: string;
  subject?: string;
  domain?: string;
  grade?: string;
  fields: Record<string, string | number | boolean | string[]>;
};

const HEADER = /^@(\w+)(?:\s+([\w+\-.]+))?(?:\s*:=\s*"([^"]*)")?(?:\s*::\s*(\w+))?(?:\s*\[(\w+)\])?\s*$/;
const FIELD = /^\s{2}(\w+)\s*=\s*(.*)$/;
const ARRAY_INLINE = /^\[\s*(.*)\s*\]$/;

function coerce(v: string): string | number | boolean | string[] {
  const trimmed = v.trim();
  const arr = trimmed.match(ARRAY_INLINE);
  if (arr) {
    return arr[1]
      .split(",")
      .map((s) => s.trim().replace(/^"|"$/g, ""))
      .filter(Boolean);
  }
  if (trimmed === "true") return true;
  if (trimmed === "false") return false;
  if (/^-?\d+(\.\d+)?$/.test(trimmed)) return Number(trimmed);
  return trimmed.replace(/^"|"$/g, "");
}

export function parseTape(src: string): TapeNode[] {
  const lines = src.split(/\r?\n/);
  const nodes: TapeNode[] = [];
  let current: TapeNode | null = null;
  for (const raw of lines) {
    const line = raw.replace(/\s+$/, "");
    if (!line || line.startsWith("#")) continue;
    const h = line.match(HEADER);
    if (h) {
      current = {
        type: h[1],
        id: h[2] ?? "_",
        subject: h[3],
        domain: h[4],
        grade: h[5],
        fields: {},
      };
      nodes.push(current);
      continue;
    }
    const f = raw.match(FIELD);
    if (f && current) {
      current.fields[f[1]] = coerce(f[2]);
    }
  }
  return nodes;
}

export async function loadTape(relPath: string): Promise<TapeNode[]> {
  // demiurge repo root is two levels above web/lib at runtime.
  // We resolve relative to process.cwd() which is the web/ dir in Cloud Run.
  const root = process.env.DEMIURGE_ROOT ?? join(process.cwd(), "..");
  const src = await readFile(join(root, relPath), "utf8");
  return parseTape(src);
}
