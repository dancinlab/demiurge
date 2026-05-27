// TrajectoryPanel — ara "RESEARCH SESSION / AUTO-CAPTURED TRAJECTORY" UI.
// 도메인 작업 로그를 decision · dead_end · heuristic · experiment 4-label
// 타임라인으로. ara 톤 (gray + indigo · Cormorant 제목 · 직선 라인).

import type { TrajEntry, TrajLabel } from "@/lib/trajectory";

const LABEL_STYLE: Record<TrajLabel, { chip: string; dot: string }> = {
  decision: { chip: "bg-gray-100 text-gray-900", dot: "bg-gray-1000" },
  dead_end: { chip: "bg-rose-50 text-rose-700", dot: "bg-rose-500" },
  heuristic: { chip: "bg-amber-50 text-amber-700", dot: "bg-amber-500" },
  experiment: { chip: "bg-emerald-50 text-emerald-700", dot: "bg-emerald-500" },
};

export function TrajectoryPanel({
  sessionId,
  entries,
}: {
  sessionId: string;
  entries: TrajEntry[];
}) {
  if (entries.length === 0) return null;
  return (
    <section className="border border-gray-200 bg-white">
      <header className="flex items-baseline gap-2 border-b border-gray-200 px-4 py-2.5">
        <h3 className="font-serif text-base font-semibold text-gray-900">RESEARCH SESSION</h3>
        <span className="font-mono text-[11px] text-gray-400">session-{sessionId}</span>
      </header>
      <div className="px-4 py-3">
        <p className="mb-1.5 text-[10px] font-medium uppercase tracking-wide text-gray-400">
          auto-captured trajectory
        </p>
        <div className="mb-3 flex flex-wrap items-center gap-1.5 text-[11px] text-gray-500">
          <span>Context Harvester</span>
          <span className="text-gray-400" aria-hidden="true">→</span>
          <span>Event Router</span>
          <span className="text-gray-400" aria-hidden="true">→</span>
          <span>Maturity Tracker</span>
        </div>
        <ul className="space-y-1.5">
          {entries.map((e, i) => {
            const s = LABEL_STYLE[e.label];
            return (
              <li key={i} className="flex items-start gap-2 text-xs">
                <span className={`mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full ${s.dot}`} aria-hidden="true" />
                <span className={`shrink-0 rounded px-1.5 py-0.5 font-mono text-[10px] ${s.chip}`}>
                  {e.label}
                </span>
                <span className="leading-relaxed text-gray-700">{e.text}</span>
              </li>
            );
          })}
        </ul>
      </div>
    </section>
  );
}
