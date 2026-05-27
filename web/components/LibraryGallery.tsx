// LibraryGallery — fetches /api/v1/public-domains, renders cards. Fork button
// calls /api/v1/projects/fork (PR#11). Guests get sign-in prompt instead.

"use client";

import { useEffect, useState } from "react";

type Entry = {
  id: string;
  subject: string;
  curator: string;
  version: string;
  status: string;
  composes: string[];
  hero_verb: string;
  license: string;
  fork_ok: boolean;
};

export function LibraryGallery() {
  const [entries, setEntries] = useState<Entry[]>([]);
  const [authed, setAuthed] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [forking, setForking] = useState<string | null>(null);

  useEffect(() => {
    fetch("/api/v1/public-domains")
      .then((r) => r.json())
      .then((d) => setEntries((d as { entries: Entry[] }).entries ?? []))
      .catch((e: unknown) =>
        setError(e instanceof Error ? e.message : String(e)),
      );
    fetch("/api/v1/me")
      .then((r) => setAuthed(r.ok))
      .catch(() => setAuthed(false));
  }, []);

  async function fork(id: string) {
    if (!authed) {
      window.location.href = `/signin?next=/library`;
      return;
    }
    setForking(id);
    try {
      const res = await fetch("/api/v1/projects/fork", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ sourceId: id }),
      });
      if (res.ok) {
        const { projectId } = (await res.json()) as { projectId: string };
        window.location.href = `/spec/${projectId}`;
      } else {
        setError(`fork failed (HTTP ${res.status})`);
      }
    } catch (e: unknown) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setForking(null);
    }
  }

  if (error) return <div className="text-red-500">{error}</div>;
  if (!entries.length) return <div className="text-neutral-500">로딩…</div>;

  return (
    <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
      {entries.map((e) => (
        <article
          key={e.id}
          className="flex flex-col rounded border border-neutral-300 bg-white p-4 dark:border-neutral-700 dark:bg-neutral-900"
        >
          <h3 className="text-lg font-bold">{e.subject}</h3>
          <p className="mt-1 text-xs text-neutral-500">
            {e.curator} · v{e.version} · {e.license}
          </p>
          <p className="mt-2 text-sm">{e.status}</p>
          {e.composes.length > 1 && (
            <p className="mt-1 text-xs text-neutral-500">
              composes: {e.composes.join(" · ")}
            </p>
          )}
          <button
            type="button"
            disabled={!e.fork_ok || forking === e.id}
            onClick={() => fork(e.id)}
            className="mt-auto rounded border border-blue-500 px-3 py-1 text-xs text-blue-600 disabled:opacity-50 hover:bg-blue-50 dark:hover:bg-blue-950"
          >
            {forking === e.id ? "fork 중…" : authed ? "🍴 fork" : "🔑 sign in to fork"}
          </button>
        </article>
      ))}
    </div>
  );
}
