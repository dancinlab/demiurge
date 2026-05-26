"use client";

// LiveTail — EventSource client for /api/stream. Renders stdout/stderr
// lines live + the final exit code. Caller passes the args[] array
// that mirrors the demiurge cli command line.

import { useEffect, useRef, useState } from "react";

type Line = { id: number; kind: "stdout" | "stderr" | "meta"; text: string };

export function LiveTail({
  args,
  autoStart = false,
  label,
}: {
  args: string[];
  autoStart?: boolean;
  label?: string;
}) {
  const [lines, setLines] = useState<Line[]>([]);
  const [running, setRunning] = useState(false);
  const [exitCode, setExitCode] = useState<number | null>(null);
  const seq = useRef(0);
  const esRef = useRef<EventSource | null>(null);

  function append(kind: Line["kind"], text: string) {
    seq.current += 1;
    setLines((prev) => [...prev, { id: seq.current, kind, text }]);
  }

  function start() {
    if (running) return;
    setLines([]);
    setExitCode(null);
    seq.current = 0;
    setRunning(true);
    const url =
      `/api/stream?args=${encodeURIComponent(JSON.stringify(args))}`;
    const es = new EventSource(url);
    esRef.current = es;

    es.addEventListener("open", () => append("meta", `▶ connected — args: ${args.join(" ")}`));
    es.onmessage = (e) => {
      try {
        const obj = JSON.parse(e.data) as { kind: "stdout" | "stderr"; text: string };
        append(obj.kind, obj.text);
      } catch {
        append("meta", `(malformed event: ${e.data.slice(0, 80)})`);
      }
    };
    es.addEventListener("exit", (e: MessageEvent) => {
      try {
        const obj = JSON.parse(e.data) as { code: number };
        setExitCode(obj.code);
        append("meta", `■ exit code ${obj.code}`);
      } catch {
        /* ignore */
      }
      es.close();
      setRunning(false);
    });
    es.addEventListener("error", () => {
      append("meta", "✖ stream error (server closed connection?)");
      es.close();
      setRunning(false);
    });
  }

  function stop() {
    esRef.current?.close();
    setRunning(false);
    append("meta", "■ stopped (client)");
  }

  useEffect(() => {
    if (autoStart) start();
    return () => esRef.current?.close();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="space-y-2">
      <div className="flex items-center gap-3">
        <button
          onClick={running ? stop : start}
          className="rounded bg-neutral-900 px-3 py-1 text-sm text-white dark:bg-neutral-100 dark:text-neutral-900"
        >
          {running ? "stop" : (label ?? "start tail")}
        </button>
        {exitCode !== null && (
          <span className="text-xs text-neutral-500">exit code: {exitCode}</span>
        )}
      </div>
      <pre className="max-h-96 overflow-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs leading-snug dark:border-neutral-800 dark:bg-neutral-900">
        {lines.length === 0 ? (
          <span className="text-neutral-500">(no output yet)</span>
        ) : (
          lines.map((l) => (
            <div
              key={l.id}
              className={
                l.kind === "stderr"
                  ? "text-yellow-700 dark:text-yellow-300"
                  : l.kind === "meta"
                    ? "text-neutral-500"
                    : ""
              }
            >
              {l.text}
            </div>
          ))
        )}
      </pre>
    </div>
  );
}
