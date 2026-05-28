// DOMAINS.tape roster parser — single SSOT for domain discovery.
//
// Format (per CLAUDE.md domain spec):
//   NAME → relative path to <NAME>.md (companion <NAME>.log.md sits next to it)
// Web GUI never duplicates this list; we parse the roster the CLI /
// domain tooling already maintains.

import fs from "node:fs/promises";
import path from "node:path";
import { repoDataRoot } from "@/lib/data-root";

const REPO_ROOT = repoDataRoot();
const ROSTER_PATH = path.join(REPO_ROOT, "DOMAINS.tape");
// Full internal roster (40+ · folder-nested paths · meta↔sub edges). The web
// roster (root DOMAINS.tape) is the curated flat 20; the tree view derives
// hierarchy from this fuller roster + the on-disk folder nesting.
const FULL_ROSTER_PATH = path.join(REPO_ROOT, "domains", "DOMAINS.tape");

export type DomainEntry = {
  name: string;
  mdPath: string;
  logPath: string;
  goal: string | null;
  title: string | null;
  progress: { done: number; total: number } | null;
};

// Tree node = a DomainEntry plus a nested-path-safe `id` (e.g. "CARDIO+/DAPTPGX")
// and its children. `id` is the URL + lookup key; `name` stays the bare domain
// name. `depth` = nesting level (0 = top-level). `scale` is derived ONLY when
// the data carries it (atom/material → chip → component → system) — null when
// no signal exists (never invented).
export type DomainScale = "atom" | "material" | "chip" | "component" | "system";

export type DomainNode = DomainEntry & {
  id: string;
  depth: number;
  scale: DomainScale | null;
  children: DomainNode[];
};

function relativeToRepo(p: string): string {
  return path.relative(REPO_ROOT, p);
}

async function readSnapshot(mdAbsPath: string): Promise<{
  goal: string | null;
  title: string | null;
  progress: { done: number; total: number } | null;
}> {
  try {
    const text = await fs.readFile(mdAbsPath, "utf8");
    const titleMatch = text.match(/^@title:\s*(.+)$/m);
    const goalMatch = text.match(/^@goal:\s*([\s\S]+?)(?=\n\n|\n## |\n$)/m);
    const checkboxes = text.match(/^- \[[ xX]\]/gm) ?? [];
    const done = (text.match(/^- \[[xX]\]/gm) ?? []).length;
    return {
      title: titleMatch?.[1].trim() ?? null,
      goal: goalMatch?.[1].trim() ?? null,
      progress: checkboxes.length > 0 ? { done, total: checkboxes.length } : null,
    };
  } catch {
    return { goal: null, title: null, progress: null };
  }
}

// Parse ONE roster line into { name, mdRel } or null. Tolerates the three
// flavors the repo uses (canonical @domain · @D tape · bare NAME path).
function parseRosterLine(raw: string): { name: string; mdRel: string } | null {
  const line = raw.trim();
  if (!line || line.startsWith("#")) return null;

  // Canonical: `@domain NAME := "path/to/NAME.md"`
  const atDomain = line.match(/^@domain\s+([A-Z][A-Z0-9+_-]*)\s*:=\s*"([^"]+)"/);
  if (atDomain) return { name: atDomain[1], mdRel: atDomain[2] };

  // Tape variant: `@D NAME ... path = "..."`
  const tapeMatch = line.match(/path\s*=\s*"([^"]+)"/);
  if (tapeMatch) {
    const nameMatch = line.match(/@D\s+([A-Z][A-Z0-9+_-]*)/);
    if (nameMatch) return { name: nameMatch[1], mdRel: tapeMatch[1] };
    return null;
  }

  // Bare: `NAME path/to/NAME.md`
  const bare = line.match(/^([A-Z][A-Z0-9+_-]*)\s+(\S+\.md)\s*$/);
  if (bare) return { name: bare[1], mdRel: bare[2] };
  return null;
}

// Load + snapshot a roster file into flat DomainEntry[] (no hierarchy yet).
async function loadRoster(rosterPath: string): Promise<DomainEntry[]> {
  let rosterText: string;
  try {
    rosterText = await fs.readFile(rosterPath, "utf8");
  } catch {
    return [];
  }

  const entries: DomainEntry[] = [];
  const seen = new Set<string>();
  for (const raw of rosterText.split("\n")) {
    const parsed = parseRosterLine(raw);
    if (!parsed) continue;
    if (seen.has(parsed.name)) continue;
    seen.add(parsed.name);

    const mdAbs = path.isAbsolute(parsed.mdRel)
      ? parsed.mdRel
      : path.join(REPO_ROOT, parsed.mdRel);
    const logAbs = mdAbs.replace(/\.md$/, ".log.md");
    const snap = await readSnapshot(mdAbs);

    entries.push({
      name: parsed.name,
      mdPath: relativeToRepo(mdAbs),
      logPath: relativeToRepo(logAbs),
      ...snap,
    });
  }
  return entries;
}

// FLAT roster — single SSOT for the curated web 20 (root DOMAINS.tape). The
// (app) layout's statusForDomain and the dashboard's metrics keep using this
// (no regression). Tree-view callers use listDomainTree() instead.
export async function listDomains(): Promise<DomainEntry[]> {
  const entries = await loadRoster(ROSTER_PATH);
  return entries.sort((a, b) => a.name.localeCompare(b.name));
}

// Derive a scale band ONLY from a signal the data actually carries — never
// invented. Checked sources (in order): an explicit `@scale: <band>` line in
// the .md (read by readSnapshot? no — kept minimal), then the domain's path
// under the canonical scale folders, then a small name-prefix map for the
// curated frontier domains whose category is unambiguous. Returns null when no
// signal exists so the UI shows no badge (per #6b: data-less → unmarked).
const SCALE_BY_NAME: Record<string, DomainScale> = {
  // ATOM band — particles / quanta.
  QUBIT: "atom",
  ANTIMATTER: "atom",
  FUSION: "atom",
  // MATERIAL band — bulk / thin-film matter.
  RTSC: "material",
  PEROVSKITE: "material",
  GRAPHENE: "material",
  METAMATERIAL: "material",
  AEROGEL: "material",
  SPINTRONIC: "material",
  MEMRISTOR: "material",
  // CHIP band — circuits / photonic devices.
  NEUROMORPHIC: "chip",
  PHOTONIC: "chip",
};

function deriveScale(name: string, mdPath: string): DomainScale | null {
  // Canonical scale folders (brief: materials → chip → component → system).
  const lower = mdPath.toLowerCase();
  if (/(^|\/)(matter|material)s?\//.test(lower)) return "material";
  if (/(^|\/)chips?\//.test(lower)) return "chip";
  if (/(^|\/)components?\//.test(lower)) return "component";
  if (/(^|\/)systems?\//.test(lower)) return "system";
  // Curated frontier map (unambiguous category membership).
  return SCALE_BY_NAME[name.toUpperCase()] ?? null;
}

// Build the recursive domain tree from the FULL internal roster
// (domains/DOMAINS.tape) + on-disk folder nesting. A domain whose .md sits at
// `domains/<META>/<X>.md` (or `domains/<META>/<X>/<X>.md`) is a CHILD of <META>
// when <META> is itself a registered domain and <META> !== <X>. The meta's own
// file is `domains/<META>/<META>.md` (M13 folder-nested pattern, domain 0.8.0).
// The returned node `id` is a nested-path-safe key: top-level = name, child =
// "<META>/<NAME>" — this is the URL segment + lookup key for the verb routes.
export async function listDomainTree(): Promise<DomainNode[]> {
  // Prefer the full internal roster; fall back to the curated flat one so the
  // tree is never empty even if the full roster is absent.
  let flat = await loadRoster(FULL_ROSTER_PATH);
  if (flat.length === 0) flat = await loadRoster(ROSTER_PATH);

  // Map each domain to the folder directly containing its .md (relative to the
  // `domains/` dir). For `domains/CARDIO+/DAPTPGX.md` the folder is "CARDIO+".
  const byName = new Map<string, DomainEntry>();
  for (const e of flat) byName.set(e.name, e);

  // Index registered names by uppercase for case-tolerant parent matching.
  const registeredByUpper = new Map<string, string>();
  for (const e of flat) registeredByUpper.set(e.name.toUpperCase(), e.name);

  function folderOf(mdPath: string): string | null {
    // mdPath is repo-relative, e.g. "domains/CARDIO+/DAPTPGX.md".
    const parts = mdPath.split("/");
    const di = parts.indexOf("domains");
    if (di < 0) return null;
    // child file directly under domains/<folder>/<file>.md → folder = parts[di+1]
    // meta-with-own-folder domains/<folder>/<folder>.md also lands here.
    if (parts.length - di === 3) return parts[di + 1];
    return null;
  }

  // First pass — create nodes; record each node's parent name (if any).
  const nodes = new Map<string, DomainNode>();
  const parentOf = new Map<string, string | null>();

  for (const e of flat) {
    const folder = folderOf(e.mdPath);
    let parent: string | null = null;
    if (folder) {
      const reg = registeredByUpper.get(folder.toUpperCase());
      // Parent = the folder's registered domain, but not itself (meta's own file).
      if (reg && reg.toUpperCase() !== e.name.toUpperCase()) parent = reg;
    }
    parentOf.set(e.name, parent);
    nodes.set(e.name, {
      ...e,
      id: e.name, // patched to "<parent>/<name>" below for children
      depth: 0,
      scale: deriveScale(e.name, e.mdPath),
      children: [],
    });
  }

  // Second pass — link children, assign nested ids + depth.
  const roots: DomainNode[] = [];
  for (const [name, node] of nodes) {
    const parent = parentOf.get(name) ?? null;
    if (parent && nodes.has(parent)) {
      const p = nodes.get(parent)!;
      node.id = `${p.id}/${name}`;
      node.depth = p.depth + 1;
      p.children.push(node);
    } else {
      roots.push(node);
    }
  }

  // depth is only correct if parents are assigned before children; the roster
  // lists metas, but order isn't guaranteed. Re-walk from roots to fix depth +
  // nested ids deterministically.
  function fix(node: DomainNode, prefix: string, depth: number) {
    node.id = prefix ? `${prefix}/${node.name}` : node.name;
    node.depth = depth;
    node.children.sort((a, b) => a.name.localeCompare(b.name));
    for (const c of node.children) fix(c, node.id, depth + 1);
  }
  roots.sort((a, b) => a.name.localeCompare(b.name));
  for (const r of roots) fix(r, "", 0);

  return roots;
}

// Resolve a (possibly nested) domain id → its DomainEntry. The id is the URL
// form "CARDIO+/DAPTPGX" (or flat "RTSC"). We match on the LAST path segment
// against the full roster, case-insensitively, so both the nested verb routes
// and the legacy flat routes resolve. Falls back to the flat web roster.
export async function findDomainEntry(id: string): Promise<DomainEntry | null> {
  const leaf = id.split("/").pop() ?? id;
  let flat = await loadRoster(FULL_ROSTER_PATH);
  if (flat.length === 0) flat = await loadRoster(ROSTER_PATH);
  const hit =
    flat.find((e) => e.name.toLowerCase() === leaf.toLowerCase()) ?? null;
  if (hit) return hit;
  // Last resort — curated flat roster (covers lowercase frontier names).
  const web = await loadRoster(ROSTER_PATH);
  return web.find((e) => e.name.toLowerCase() === leaf.toLowerCase()) ?? null;
}
