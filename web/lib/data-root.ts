// data-root — resolve the demiurge repo data root ONCE, robustly.
//
// The web app may run with cwd = web/ (REPO_ROOT = cwd/..) OR with cwd already
// at the repo root (dev server launched from the data repo). Resolution order:
//   1. $DEMIURGE_DATA_ROOT (explicit override)
//   2. cwd/.. if it contains DOMAINS.tape (the canonical "web/ inside repo" layout)
//   3. cwd    if it contains DOMAINS.tape (dev server launched at repo root)
//   4. cwd/.. (final fallback — keeps prior behavior)
//
// All filesystem reads of domain data go through this so the roster, the
// per-domain .md/.log.md, and the append route all agree on one base path.

import fs from "node:fs";
import path from "node:path";

let cached: string | null = null;

export function repoDataRoot(): string {
  if (cached) return cached;

  const env = process.env.DEMIURGE_DATA_ROOT;
  if (env && fs.existsSync(path.join(env, "DOMAINS.tape"))) {
    cached = env;
    return cached;
  }
  if (env) {
    // honor explicit override even if roster missing (matches prior intent)
    cached = env;
    return cached;
  }

  const cwd = process.cwd();
  const parent = path.resolve(cwd, "..");
  if (fs.existsSync(path.join(parent, "DOMAINS.tape"))) {
    cached = parent;
    return cached;
  }
  if (fs.existsSync(path.join(cwd, "DOMAINS.tape"))) {
    cached = cwd;
    return cached;
  }
  cached = parent;
  return cached;
}
