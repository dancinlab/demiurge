// DOMAINS.tape roster parser — single SSOT for domain discovery.
//
// Format (per CLAUDE.md domain spec):
//   NAME → relative path to <NAME>.md (companion <NAME>.log.md sits next to it)
// Web GUI never duplicates this list; we parse the roster the CLI /
// domain tooling already maintains.

import fs from "node:fs/promises";
import path from "node:path";

const REPO_ROOT = path.resolve(process.cwd(), "..");
const ROSTER_PATH = path.join(REPO_ROOT, "DOMAINS.tape");

export type DomainEntry = {
  name: string;
  mdPath: string;
  logPath: string;
  goal: string | null;
  title: string | null;
  progress: { done: number; total: number } | null;
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

export async function listDomains(): Promise<DomainEntry[]> {
  let rosterText: string;
  try {
    rosterText = await fs.readFile(ROSTER_PATH, "utf8");
  } catch {
    return [];
  }

  // Parse DOMAINS.tape — accept either tape entry rows or plain `NAME path`
  // lines. Tape format has many flavors across the repo; we tolerate both
  // and lean on filename existence as the authoritative filter.
  const entries: DomainEntry[] = [];
  const seen = new Set<string>();
  const lines = rosterText.split("\n");

  for (const raw of lines) {
    const line = raw.trim();
    if (!line || line.startsWith("#")) continue;
    let mdRel: string | null = null;
    let name: string | null = null;

    // Canonical: `@domain NAME := "path/to/NAME.md"`
    const atDomain = line.match(/^@domain\s+([A-Z][A-Z0-9+_-]*)\s*:=\s*"([^"]+)"/);
    if (atDomain) {
      name = atDomain[1];
      mdRel = atDomain[2];
    } else {
      // Tape variant: `@D NAME ... path = "..."`
      const tapeMatch = line.match(/path\s*=\s*"([^"]+)"/);
      if (tapeMatch) {
        mdRel = tapeMatch[1];
        const nameMatch = line.match(/@D\s+([A-Z][A-Z0-9+_-]*)/);
        if (nameMatch) name = nameMatch[1];
      } else {
        // Bare: `NAME path/to/NAME.md`
        const bare = line.match(/^([A-Z][A-Z0-9+_-]*)\s+(\S+\.md)\s*$/);
        if (bare) {
          name = bare[1];
          mdRel = bare[2];
        }
      }
    }

    if (!name || !mdRel) continue;
    if (seen.has(name)) continue;
    seen.add(name);

    const mdAbs = path.isAbsolute(mdRel) ? mdRel : path.join(REPO_ROOT, mdRel);
    const logAbs = mdAbs.replace(/\.md$/, ".log.md");
    const snap = await readSnapshot(mdAbs);

    entries.push({
      name,
      mdPath: relativeToRepo(mdAbs),
      logPath: relativeToRepo(logAbs),
      ...snap,
    });
  }

  return entries.sort((a, b) => a.name.localeCompare(b.name));
}
