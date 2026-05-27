"use client";

// Client component for /discover — POSTs to /api/cli with subcommand
// "discover". demiurge cli forwards to phanes; phanes owns OUROBOROS.

import { useState } from "react";

type CliResult = {
  stdout: string;
  stderr: string;
  exitCode: number;
};

export function DiscoverForm() {
  const [objective, setObjective] = useState("");
  const [rounds, setRounds] = useState("5");
  const [json, setJson] = useState(true);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<CliResult | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    if (!objective.trim()) return;
    setLoading(true);
    setError(null);
    setResult(null);
    try {
      const args = ["discover", objective.trim(), "--rounds", rounds];
      if (json) args.push("--json");
      const res = await fetch("/api/cli", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ args, timeoutMs: 120_000 }),
      });
      const data = (await res.json()) as CliResult | { error: string };
      if (!res.ok || "error" in data) {
        setError("error" in data ? data.error : `http ${res.status}`);
      } else {
        setResult(data);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="space-y-4">
      <form onSubmit={submit} className="space-y-3">
        <div>
          <label className="block text-xs text-neutral-500">
            objective — 발견하려는 후보의 정의 (한 줄)
          </label>
          <textarea
            value={objective}
            onChange={(e) => setObjective(e.target.value)}
            rows={3}
            placeholder="예: RTSC candidate at 300K ambient pressure, BCS-validated"
            disabled={loading}
            className="mt-1 w-full rounded border border-neutral-300 bg-white p-2 font-mono text-sm"
          />
        </div>
        <div className="flex flex-wrap items-end gap-3">
          <div>
            <label className="block text-xs text-neutral-500">
              rounds (OUROBOROS cap)
            </label>
            <input
              type="number"
              min="1"
              max="20"
              value={rounds}
              onChange={(e) => setRounds(e.target.value)}
              disabled={loading}
              className="mt-1 w-24 rounded border border-neutral-300 bg-white p-1 font-mono text-sm"
            />
          </div>
          <label className="flex items-center gap-1 text-xs text-neutral-500">
            <input
              type="checkbox"
              checked={json}
              onChange={(e) => setJson(e.target.checked)}
              disabled={loading}
            />
            --json
          </label>
          <button
            type="submit"
            disabled={loading || !objective.trim()}
            className="rounded bg-neutral-900 px-3 py-1 text-sm text-white disabled:opacity-40"
          >
            {loading ? "phanes 호출 중..." : "discover"}
          </button>
        </div>
      </form>

      {error && (
        <div className="rounded border border-red-300 bg-red-50 p-3 text-sm text-red-900">
          <p className="font-semibold">실패</p>
          <pre className="mt-1 whitespace-pre-wrap text-xs">{error}</pre>
        </div>
      )}

      {result && (
        <div className="space-y-2">
          {result.stdout && (
            <div>
              <p className="mb-1 text-xs text-neutral-500">stdout</p>
              <pre className="overflow-x-auto rounded border border-neutral-200 bg-neutral-50 p-3 text-xs">
                {result.stdout}
              </pre>
            </div>
          )}
          {result.stderr && (
            <div>
              <p className="mb-1 text-xs text-neutral-500">
                stderr (exit={result.exitCode})
              </p>
              <pre className="overflow-x-auto rounded border border-yellow-300 bg-yellow-50 p-3 text-xs text-yellow-900">
                {result.stderr}
              </pre>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
