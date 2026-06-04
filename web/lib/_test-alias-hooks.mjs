// _test-alias-hooks.mjs — the actual resolve hook (loaded on the loader thread
// by _test-alias-loader.mjs via module.register). See that file for the why.
import { pathToFileURL } from "node:url";
import path from "node:path";
import fs from "node:fs";

const WEB_ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");

function withTsExt(absNoExt) {
  for (const ext of [".ts", ".tsx", ".mjs", ".js"]) {
    if (fs.existsSync(absNoExt + ext)) return absNoExt + ext;
  }
  return absNoExt;
}

export async function resolve(specifier, context, nextResolve) {
  // Map "@/*" → web-root, resolving the on-disk extension.
  if (specifier.startsWith("@/")) {
    const abs = path.join(WEB_ROOT, specifier.slice(2));
    return nextResolve(pathToFileURL(withTsExt(abs)).href, context);
  }
  // Relative imports whose on-disk file needs a TS/TSX extension appended.
  // ".server"/".test" are NOT real extensions, so we always probe disk
  // (e.g. "./geometry-3d-parse.server" → "./geometry-3d-parse.server.ts").
  if ((specifier.startsWith("./") || specifier.startsWith("../")) && context.parentURL) {
    const parentDir = path.dirname(new URL(context.parentURL).pathname);
    const abs = path.resolve(parentDir, specifier);
    if (!fs.existsSync(abs)) {
      const resolved = withTsExt(abs);
      if (resolved !== abs) return nextResolve(pathToFileURL(resolved).href, context);
    }
  }
  return nextResolve(specifier, context);
}
