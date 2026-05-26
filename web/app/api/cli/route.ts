// POST /api/cli — generic demiurge cli subprocess proxy (Next 16 style).
//
// Body: { "args": ["action", "verify", "bio"], "timeoutMs": 30000 }
// Resp: { "stdout": "...", "stderr": "...", "exitCode": 0 }
//
// d4 single generic — every verb funnels through this one endpoint.
// Subcommand allowlist keeps arbitrary-exec attack surface tiny.

import { runCli } from "@/lib/cli";

const ALLOWED_FIRST_ARG = new Set([
  "list-all",
  "list-records",
  "list-decisions",
  "list-rfcs",
  "list-domains",
  "list-projects",
  "list-shelf",
  "list-gates",
  "gate-summary",
  "show",
  "show-project",
  "action",
  "compose",
  "operate",
  "backend",
  "atlas",
  "discover",
  "verify",
  "--version",
  "--help",
]);

export async function POST(request: Request) {
  let body: { args?: unknown; timeoutMs?: unknown };
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const args = body.args;
  if (!Array.isArray(args) || args.length === 0) {
    return Response.json({ error: "missing args[]" }, { status: 400 });
  }
  if (!args.every((a): a is string => typeof a === "string")) {
    return Response.json({ error: "args[] must be strings" }, { status: 400 });
  }
  if (!ALLOWED_FIRST_ARG.has(args[0])) {
    return Response.json(
      { error: `subcommand '${args[0]}' is not allowlisted` },
      { status: 403 }
    );
  }

  const timeoutMs = typeof body.timeoutMs === "number" ? body.timeoutMs : 30_000;
  try {
    const result = await runCli(args, { timeoutMs });
    return Response.json(result);
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    return Response.json({ error: msg }, { status: 500 });
  }
}
