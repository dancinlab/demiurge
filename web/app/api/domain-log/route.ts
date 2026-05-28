// POST /api/domain-log — APPEND a verb draft to <DOMAIN>.log.md.
//
// #3 (draft-only persistence): the ONLY write surface in the web GUI. It
// appends a timestamped block; it never rewrites or truncates. The domain's
// log path is resolved through the DOMAINS.tape roster (lib/domains) so we
// can only ever touch a registered domain log inside the repo data root.
//
// Body: { "domain": "RTSC", "verb": "spec", "text": "draft body ..." }
// Resp: { "ok": true, "appendedBytes": N, "logPath": "domains/RTSC.log.md" }
//
// Safety:
//   - domain MUST resolve to a roster entry (no arbitrary path)
//   - logPath stays under REPO_ROOT (path-traversal guard)
//   - open in "a" (append) mode only — never "w"
//   - bounded body size

import fs from "node:fs/promises";
import path from "node:path";
import { listDomains } from "@/lib/domains";
import { repoDataRoot } from "@/lib/data-root";

const REPO_ROOT = repoDataRoot();

const ALLOWED_VERBS = new Set([
  "spec",
  "structure",
  "design",
  "analyze",
  "synth",
  "verify",
  "handoff",
  "discover",
]);

const MAX_TEXT = 16_000;

type Body = { domain?: unknown; verb?: unknown; text?: unknown };

export async function POST(request: Request) {
  let body: Body;
  try {
    body = (await request.json()) as Body;
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const domain = typeof body.domain === "string" ? body.domain.trim() : "";
  const verb = typeof body.verb === "string" ? body.verb : "";
  const text = typeof body.text === "string" ? body.text : "";

  if (!domain) return Response.json({ error: "domain required" }, { status: 400 });
  if (!ALLOWED_VERBS.has(verb)) {
    return Response.json({ error: `verb '${verb}' not allowed` }, { status: 400 });
  }
  if (text.trim().length === 0) {
    return Response.json({ error: "text required" }, { status: 400 });
  }
  if (text.length > MAX_TEXT) {
    return Response.json({ error: "text too large (>16K chars)" }, { status: 413 });
  }

  // Resolve the log path through the roster — only a registered domain wins.
  const domains = await listDomains();
  const entry =
    domains.find((d) => d.name.toLowerCase() === domain.toLowerCase()) ?? null;
  if (!entry) {
    return Response.json({ error: `domain '${domain}' not in roster` }, { status: 404 });
  }

  const logAbs = path.resolve(REPO_ROOT, entry.logPath);
  // Path-traversal guard: must stay under REPO_ROOT.
  const rel = path.relative(REPO_ROOT, logAbs);
  if (rel.startsWith("..") || path.isAbsolute(rel)) {
    return Response.json({ error: "resolved path escapes data root" }, { status: 400 });
  }

  const ts = new Date().toISOString();
  const block =
    `\n## ${ts} · web/${verb} draft\n\n` +
    text.trimEnd() +
    `\n\n— (web GUI draft · 검수 필요 · unverified)\n`;

  try {
    // "a" flag = append-only; creates the file if missing, never truncates.
    await fs.appendFile(logAbs, block, { encoding: "utf8", flag: "a" });
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    return Response.json({ error: msg }, { status: 500 });
  }

  return Response.json({
    ok: true,
    appendedBytes: Buffer.byteLength(block, "utf8"),
    logPath: entry.logPath,
  });
}
