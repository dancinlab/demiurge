"use client";

// VerbRunStream — execution panel for the CLI-using verbs
// (structure · synth · verify · discover). A single "Run <verb>" trigger
// opens an EventSource on /api/stream?args=<json> and renders the live
// stdout/stderr stream until the process emits its exit event.
//
// d4: the argv is built upstream by lib/verb-config (one generic table);
// this component is verb-agnostic — it only knows how to run + render a stream.

import { useRef, useState } from "react";

type Line = { kind: "stdout" | "stderr"; text: string };

export type VerbRunStreamI18n = {
  run: string; // "Run {verb}"
  running: string; // "running…"
  stop: string; // "stop"
  exited: string; // "exited ({code})"
  empty: string; // "(no output yet — press run)"
  failed: string; // "failed"
};

export function VerbRunStream({
  verb,
  args,
  i18n,
}: {
  verb: string;
  args: string[];
  i18n: VerbRunStreamI18n;
}) {
  const [lines, setLines] = useState<Line[]>([]);
  const [running, setRunning] = useState(false);
  const [exitCode, setExitCode] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);
  const esRef = useRef<EventSource | null>(null);

  function close() {
    esRef.current?.close();
    esRef.current = null;
    setRunning(false);
  }

  function run() {
    close();
    setLines([]);
    setExitCode(null);
    setError(null);
    setRunning(true);

    const url = `/api/stream?args=${encodeURIComponent(JSON.stringify(args))}`;
    const es = new EventSource(url);
    esRef.current = es;

    es.onmessage = (ev) => {
      try {
        const d = JSON.parse(ev.data) as Line;
        if (d.kind === "stdout" || d.kind === "stderr") {
          setLines((prev) => [...prev, d]);
        }
      } catch {
        /* ignore non-JSON keepalives */
      }
    };
    es.addEventListener("exit", (ev) => {
      try {
        const d = JSON.parse((ev as MessageEvent).data) as { code: number };
        setExitCode(d.code);
      } catch {
        /* noop */
      }
      close();
    });
    es.addEventListener("error", (ev) => {
      // Distinguish a server-sent error event (has data) from a transport drop.
      const data = (ev as MessageEvent).data;
      if (typeof data === "string" && data.length > 0) {
        try {
          const d = JSON.parse(data) as { message?: string };
          setError(d.message ?? "stream error");
        } catch {
          setError("stream error");
        }
      } else if (running) {
        setError(i18n.failed);
      }
      close();
    });
  }

  return (
    <div className="space-y-3">
      <div className="flex items-center gap-3">
        <button
          type="button"
          onClick={running ? close : run}
          className="rounded-control bg-primary px-3 py-1 text-sm text-on-primary disabled:opacity-40"
        >
          {running ? i18n.stop : i18n.run.replace("{verb}", verb)}
        </button>
        <span className="font-mono text-[11px] text-muted">demiurge {args.join(" ")}</span>
        {exitCode !== null && (
          <span
            className={`ml-auto text-xs ${exitCode === 0 ? "text-success" : "text-danger"}`}
          >
            {i18n.exited.replace("{code}", String(exitCode))}
          </span>
        )}
      </div>

      {error && (
        <div className="rounded-control bg-danger/10 p-3 text-sm text-danger">
          <p className="font-semibold">{i18n.failed}</p>
          <pre className="mt-1 whitespace-pre-wrap text-xs">{error}</pre>
        </div>
      )}

      <pre className="max-h-72 overflow-auto py-1 font-mono text-[11px] leading-relaxed text-body-strong">
        {lines.length === 0 && !running
          ? i18n.empty
          : lines.map((l, i) => (
              <span key={i} className={l.kind === "stderr" ? "text-danger" : undefined}>
                {l.text}
                {"\n"}
              </span>
            ))}
        {running && <span className="text-muted">{i18n.running}</span>}
      </pre>
    </div>
  );
}
