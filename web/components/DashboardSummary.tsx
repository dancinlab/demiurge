// DashboardSummary — server component · pulls CATEGORIES + STDLIB_MATRIX
// straight from the tape parser to render the GUI navigation panels
// (category trees · porting rollup). shadcn Modern 톤 · i18n.
// Member click → /dashboard?d=<member> (active 도메인 cookie sync via middleware).

import Link from "next/link";
import { loadTape } from "@/lib/tape";
import { getMessages, t } from "@/lib/i18n";

export async function DashboardSummary() {
  const messages = await getMessages();
  let categories: Array<{ id: string; icon: string; alias: string; members: string[] }> = [];
  let rollup: Record<string, string | number | boolean | string[]> = {};
  try {
    const cats = await loadTape("domains/CATEGORIES.tape");
    categories = cats
      .filter((n) => n.type === "C")
      .map((n) => ({
        id: n.id,
        icon: String(n.fields.icon ?? "•"),
        alias: String(n.fields.alias ?? n.id),
        members: Array.isArray(n.fields.members) ? n.fields.members : [],
      }));
    const matrix = await loadTape("domains/STDLIB_MATRIX.tape");
    const summary = matrix.find((n) => n.id === "rollup_summary");
    if (summary) rollup = summary.fields;
  } catch {
    // file system unreachable -> empty panels
  }

  return (
    <section className="mt-8 space-y-4">
      <div className="flex items-baseline gap-3">
        <h2 className="font-display text-sm font-light tracking-tight text-ink">
          🗂 {t(messages, "dashboard.categories_heading")}
        </h2>
        <span className="text-xs text-muted">
          {t(messages, "dashboard.stdlib_matrix")} · {String(rollup.porting_complete ?? "—")}
        </span>
      </div>
      <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {categories.map((c) => (
          <article
            key={c.id}
            className="rounded-card border border-hairline bg-canvas p-3 transition hover:shadow-card"
          >
            <header className="mb-2 flex items-center gap-2 pb-1.5">
              <span className="text-lg" aria-hidden="true">{c.icon}</span>
              <span className="font-display text-sm font-light tracking-tight text-ink">{c.alias}</span>
              <span className="ml-auto rounded-full bg-surface-strong px-2 text-[10px] text-muted">
                {c.members.length}
              </span>
            </header>
            <ul className="space-y-0.5 text-xs">
              {c.members.map((m) => (
                <li key={m}>
                  <Link
                    className="block rounded-chip px-1.5 py-0.5 font-mono text-[11px] text-body hover:bg-surface-strong hover:text-ink"
                    href={`/dashboard?d=${encodeURIComponent(m)}`}
                  >
                    {m}
                  </Link>
                </li>
              ))}
            </ul>
          </article>
        ))}
      </div>
    </section>
  );
}
