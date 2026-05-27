// HandoffDossier — client-side dossier preview + download.
// Pulls /api/v1/handoff/[domain], renders manifest summary, offers download.

"use client";

import { useEffect, useState } from "react";

type Dossier = {
  domain: string;
  generated_at: string;
  records: Array<Record<string, unknown>>;
  manifest: {
    verb_count: number;
    complete_count: number;
    in_progress_count: number;
    todo_count: number;
  };
};

export function HandoffDossier({ domain }: { domain: string }) {
  const [dossier, setDossier] = useState<Dossier | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(`/api/v1/handoff/${domain}`)
      .then(async (r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then((d) => setDossier(d as Dossier))
      .catch((e: unknown) =>
        setError(e instanceof Error ? e.message : String(e)),
      );
  }, [domain]);

  if (error) return <div className="text-xs text-red-500">{error}</div>;
  if (!dossier) return <div className="text-xs text-gray-500">로딩…</div>;

  const m = dossier.manifest;
  const pct = m.verb_count
    ? Math.round((m.complete_count / m.verb_count) * 100)
    : 0;

  return (
    <div className="space-y-3 text-sm">
      <div className="flex items-center gap-3">
        <span className="text-2xl">📦</span>
        <div className="flex-1">
          <div className="font-bold">{dossier.domain} dossier</div>
          <div className="text-xs text-gray-500">
            {dossier.generated_at.slice(0, 19).replace("T", " ")} ·{" "}
            {m.complete_count}/{m.verb_count} 완료 ({pct}%)
          </div>
        </div>
        <a
          className="rounded-[6px] border border-indigo-600 px-3 py-1 text-xs text-indigo-600 hover:bg-gray-100"
          href={`/api/v1/handoff/${domain}?download=1`}
        >
          ⬇ 다운로드 (.json)
        </a>
      </div>
      <div className="grid grid-cols-3 gap-2 text-xs">
        <div className="rounded-[6px] border border-green-300 bg-green-50 px-2 py-1">
          🟢 complete {m.complete_count}
        </div>
        <div className="rounded-[6px] border border-yellow-300 bg-yellow-50 px-2 py-1">
          🟡 in_progress {m.in_progress_count}
        </div>
        <div className="rounded-[6px] border border-gray-200 bg-gray-50 px-2 py-1">
          ⚪ todo {m.todo_count}
        </div>
      </div>
      <details className="text-xs">
        <summary className="cursor-pointer">📜 records ({dossier.records.length})</summary>
        <pre className="mt-1 max-h-72 overflow-auto rounded-[6px] bg-gray-100 p-2 text-[10px]">
          {JSON.stringify(dossier.records, null, 2)}
        </pre>
      </details>
    </div>
  );
}
