// LibraryGallery — fetches /api/v1/public-domains (founder-curated entries from
// domains/PUBLIC_DOMAINS.tape), renders cards with search + status filter.
// Fork → /api/v1/projects/fork (members); guests get a sign-in prompt.
//
// Pure presentation copy arrives via the `i18n` prop from the server page (no
// client t()). Semantic tokens only (DESIGN_TOKENS.md SSOT) — no gray-*/bg-white.

"use client";

import { useEffect, useMemo, useState } from "react";
import { SegmentedTabs, type SegItem } from "@/components/ui/SegmentedTabs";
import { ArticleCard } from "@/components/ui/Card";
import { PanelEmpty } from "@/components/ui/Panel";

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

type LibraryI18n = {
  searchPlaceholder: string;
  filterAll: string;
  filterComplete: string;
  filterWip: string;
  countLabel: string;
  heroVerbLabel: string;
  composesLabel: string;
  licenseLabel: string;
  curatorLabel: string;
  browse: string;
  fork: string;
  forkInProgress: string;
  signInToFork: string;
  guestNote: string;
  empty: string;
  emptyFiltered: string;
  loading: string;
  error: string;
};

type Filter = "all" | "complete" | "wip";

// A status string carries an emoji + word ("🟢 complete" · "🟡 WIP"). We bucket
// on the keyword so the filter is locale-independent of the tape's English copy.
function statusBucket(status: string): Filter | "other" {
  const s = status.toLowerCase();
  if (s.includes("complete")) return "complete";
  if (s.includes("wip") || s.includes("progress")) return "wip";
  return "other";
}

export function LibraryGallery({ i18n }: { i18n: LibraryI18n }) {
  const [entries, setEntries] = useState<Entry[] | null>(null);
  const [authed, setAuthed] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [forking, setForking] = useState<string | null>(null);
  const [query, setQuery] = useState("");
  const [filter, setFilter] = useState<Filter>("all");

  useEffect(() => {
    fetch("/api/v1/public-domains")
      .then((r) => r.json())
      .then((d) => setEntries((d as { entries: Entry[] }).entries ?? []))
      .catch(() => setError(i18n.error));
    fetch("/api/v1/me")
      .then((r) => setAuthed(r.ok))
      .catch(() => setAuthed(false));
  }, [i18n.error]);

  const filtered = useMemo(() => {
    if (!entries) return [];
    const q = query.trim().toLowerCase();
    return entries.filter((e) => {
      if (filter !== "all" && statusBucket(e.status) !== filter) return false;
      if (!q) return true;
      return [e.subject, e.id, e.curator, ...e.composes]
        .filter(Boolean)
        .some((v) => v.toLowerCase().includes(q));
    });
  }, [entries, query, filter]);

  async function fork(id: string) {
    if (!authed) {
      // library is now a tab inside the dashboard (#6b) — return there post-auth.
      window.location.href = `/signin?next=/dashboard`;
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
        setError(`${i18n.error} (HTTP ${res.status})`);
      }
    } catch {
      setError(i18n.error);
    } finally {
      setForking(null);
    }
  }

  if (error) {
    return (
      <p className="rounded-card bg-danger/10 px-4 py-6 text-sm text-danger">
        {error}
      </p>
    );
  }
  if (entries === null) {
    return <PanelEmpty>{i18n.loading}</PanelEmpty>;
  }
  if (entries.length === 0) {
    return <PanelEmpty>{i18n.empty}</PanelEmpty>;
  }

  const filters: SegItem<Filter>[] = [
    { id: "all", label: i18n.filterAll },
    { id: "complete", label: i18n.filterComplete },
    { id: "wip", label: i18n.filterWip },
  ];

  return (
    <div className="space-y-5">
      {/* controls */}
      <div className="flex flex-wrap items-center gap-3">
        <input
          type="search"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder={i18n.searchPlaceholder}
          className="min-w-0 flex-1 rounded-control border border-hairline bg-surface px-3 py-1.5 text-sm text-ink placeholder:text-muted-soft focus:border-hairline-strong focus:outline-none"
        />
        <SegmentedTabs
          items={filters}
          value={filter}
          onChange={setFilter}
          ariaLabel={i18n.filterAll}
        />
        <span className="text-xs text-muted-soft">
          {i18n.countLabel.replace("{n}", String(filtered.length))}
        </span>
      </div>

      {!authed && (
        <p className="py-1 text-xs text-muted">
          {i18n.guestNote}
        </p>
      )}

      {/* gallery */}
      {filtered.length === 0 ? (
        <PanelEmpty>{i18n.emptyFiltered}</PanelEmpty>
      ) : (
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {filtered.map((e) => (
            <ArticleCard key={e.id} className="flex flex-col gap-2">
              <div className="flex items-start justify-between gap-2">
                <h3 className="font-display text-lg font-medium text-ink">
                  {e.subject}
                </h3>
                {e.status && (
                  <span className="shrink-0 text-[10px] text-body">
                    {e.status}
                  </span>
                )}
              </div>
              <p className="text-xs text-muted">
                {e.curator && (
                  <>
                    {i18n.curatorLabel}: {e.curator} ·{" "}
                  </>
                )}
                v{e.version} · {i18n.licenseLabel}: {e.license}
              </p>
              {e.composes.length > 0 && (
                <p className="text-xs text-muted-soft">
                  {i18n.composesLabel}:{" "}
                  <span className="font-mono">{e.composes.join(" · ")}</span>
                </p>
              )}
              <p className="text-[11px] uppercase tracking-wide text-muted-soft">
                {i18n.heroVerbLabel}: {e.hero_verb}
              </p>
              <div className="mt-auto flex gap-2 pt-2">
                <a
                  href={`/structure/${e.composes[0] ?? e.id}`}
                  className="flex-1 rounded-control bg-canvas-soft px-3 py-1.5 text-center text-xs text-body transition hover:bg-surface hover:text-ink"
                >
                  {i18n.browse}
                </a>
                <button
                  type="button"
                  disabled={!e.fork_ok || forking === e.id}
                  onClick={() => fork(e.id)}
                  className="flex-1 rounded-control bg-inverted px-3 py-1.5 text-xs font-medium text-on-primary transition hover:opacity-90 disabled:opacity-50"
                >
                  {forking === e.id
                    ? i18n.forkInProgress
                    : authed
                      ? i18n.fork
                      : i18n.signInToFork}
                </button>
              </div>
            </ArticleCard>
          ))}
        </div>
      )}
    </div>
  );
}
