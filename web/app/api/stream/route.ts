// GET /api/stream?args=<json-encoded-args> — SSE wrapper around runCli().
//
// Streams stdout / stderr lines as Server-Sent Events. Emits a final
// `event: exit` with the process exit code, then closes.
//
// Event format:
//   data: {"kind":"stdout","text":"line ..."}
//   data: {"kind":"stderr","text":"line ..."}
//   event: exit
//   data: {"code":0}
//
// d4 single generic — args[] runs through the same allowlist as /api/cli.

import { streamCli } from "@/lib/cli";

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

export async function GET(request: Request) {
  const url = new URL(request.url);
  const argsParam = url.searchParams.get("args");
  if (!argsParam) {
    return Response.json({ error: "missing args query param (JSON array)" }, { status: 400 });
  }

  let args: unknown;
  try {
    args = JSON.parse(argsParam);
  } catch {
    return Response.json({ error: "args must be a JSON-encoded string[]" }, { status: 400 });
  }

  if (!Array.isArray(args) || !args.every((a): a is string => typeof a === "string")) {
    return Response.json({ error: "args must be string[]" }, { status: 400 });
  }
  if (args.length === 0) {
    return Response.json({ error: "args[] must be non-empty" }, { status: 400 });
  }
  if (!ALLOWED_FIRST_ARG.has(args[0])) {
    return Response.json(
      { error: `subcommand '${args[0]}' is not allowlisted` },
      { status: 403 }
    );
  }

  const encoder = new TextEncoder();

  const stream = new ReadableStream<Uint8Array>({
    async start(controller) {
      const send = (event: string | null, data: unknown) => {
        const payload = JSON.stringify(data);
        const block = (event ? `event: ${event}\n` : "") + `data: ${payload}\n\n`;
        controller.enqueue(encoder.encode(block));
      };

      // open-event lets clients know we're alive
      send("open", { args });

      try {
        for await (const item of streamCli(args)) {
          if (item.kind === "stdout" || item.kind === "stderr") {
            // split chunks into lines for nicer rendering; SSE doesn't
            // require it but the client expects line-oriented data
            for (const line of String(item.data).split(/\r?\n/)) {
              if (line.length === 0) continue;
              send(null, { kind: item.kind, text: line });
            }
          } else if (item.kind === "exit") {
            send("exit", { code: Number(item.data) });
          }
        }
      } catch (err) {
        send("error", { message: err instanceof Error ? err.message : String(err) });
      } finally {
        controller.close();
      }
    },
  });

  return new Response(stream, {
    headers: {
      "content-type": "text/event-stream; charset=utf-8",
      "cache-control": "no-store, no-transform",
      "x-accel-buffering": "no", // disable nginx/Cloud Run buffering
      connection: "keep-alive",
    },
  });
}
