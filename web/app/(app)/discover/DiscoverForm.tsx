"use client";

// Client component for /discover — POSTs to /api/cli with subcommand
// "discover". demiurge cli forwards to phanes; phanes owns OUROBOROS.
//
// Pure presentation copy arrives via the `i18n` prop from the server page (no
// client t()). Semantic tokens only (DESIGN_TOKENS.md SSOT) — no gray-*/bg-white.

import { useState } from "react";

type CliResult = {
  stdout: string;
  stderr: string;
  exitCode: number;
};

export type DiscoverFormI18n = {
  objectiveLabel: string;
  objectivePlaceholder: string;
  roundsLabel: string;
  submit: string;
  calling: string;
  failed: string;
  stderrLabel: string; // "stderr (exit={code})"
};

export function DiscoverForm({ i18n }: { i18n: DiscoverFormI18n }) {
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
          <label className="block text-xs text-muted">{i18n.objectiveLabel}</label>
          <textarea
            value={objective}
            onChange={(e) => setObjective(e.target.value)}
            rows={3}
            placeholder={i18n.objectivePlaceholder}
            disabled={loading}
            className="mt-1 w-full rounded-control border border-hairline bg-surface p-2 font-mono text-sm"
          />
        </div>
        <div className="flex flex-wrap items-end gap-3">
          <div>
            <label className="block text-xs text-muted">{i18n.roundsLabel}</label>
            <input
              type="number"
              min="1"
              max="20"
              value={rounds}
              onChange={(e) => setRounds(e.target.value)}
              disabled={loading}
              className="mt-1 w-24 rounded-control border border-hairline bg-surface p-1 font-mono text-sm"
            />
          </div>
          <label className="flex items-center gap-1 text-xs text-muted">
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
            className="rounded-control bg-primary px-3 py-1 text-sm text-on-primary disabled:opacity-40"
          >
            {loading ? i18n.calling : "discover"}
          </button>
        </div>
      </form>

      {error && (
        <div className="rounded-control bg-danger/10 p-3 text-sm text-danger">
          <p className="font-semibold">{i18n.failed}</p>
          <pre className="mt-1 whitespace-pre-wrap text-xs">{error}</pre>
        </div>
      )}

      {result && (
        <div className="space-y-2">
          {result.stdout && (
            <div>
              <p className="mb-1 text-xs text-muted">stdout</p>
              <pre className="overflow-x-auto py-1 text-xs text-body-strong">
                {result.stdout}
              </pre>
            </div>
          )}
          {result.stderr && (
            <div>
              <p className="mb-1 text-xs text-muted">
                {i18n.stderrLabel.replace("{code}", String(result.exitCode))}
              </p>
              <pre className="overflow-x-auto rounded-control bg-danger/10 p-3 text-xs text-danger">
                {result.stderr}
              </pre>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
