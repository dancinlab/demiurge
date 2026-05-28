// TrajectoryPanel — "RESEARCH SESSION / AUTO-CAPTURED TRAJECTORY" UI.
// 도메인 작업 로그를 decision · dead_end · heuristic · experiment 4-label
// 타임라인으로. ElevenLabs 톤 (무채색 웜 + 단일 파스텔 · Geist 제목 · 직선 라인).
// dot 색 = 무채색 웜(ink/muted) + 단일 파스텔(orb-peach/mint), 위험만 danger.

import type { TrajEntry, TrajLabel } from "@/lib/trajectory";
import { Section } from "@/components/ui/Section";

// 옵션 H — chip 배경 제거; 라벨은 텍스트 톤 + 좌측 dot 색만으로 구분.
const LABEL_STYLE: Record<TrajLabel, { chip: string; dot: string }> = {
  decision: { chip: "text-ink", dot: "bg-ink" },
  dead_end: { chip: "text-danger", dot: "bg-danger" },
  heuristic: { chip: "text-body-strong", dot: "bg-orb-peach" },
  experiment: { chip: "text-body-strong", dot: "bg-orb-mint" },
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
    <div className="py-2.5 pb-3">
      <Section
        as="section"
        title="RESEARCH SESSION"
        trailing={
          <span className="font-mono text-[11px] text-muted-soft">
            session-{sessionId}
          </span>
        }
        bodyClassName="mt-2"
      >
        <p className="mb-1.5 text-[10px] font-medium uppercase tracking-wide text-muted-soft">
          auto-captured trajectory
        </p>
        <div className="mb-3 flex flex-wrap items-center gap-1.5 text-[11px] text-muted">
          <span>Context Harvester</span>
          <span className="text-muted-soft" aria-hidden="true">→</span>
          <span>Event Router</span>
          <span className="text-muted-soft" aria-hidden="true">→</span>
          <span>Maturity Tracker</span>
        </div>
        <ul className="space-y-1.5">
          {entries.map((e, i) => {
            const s = LABEL_STYLE[e.label];
            return (
              <li key={i} className="flex items-start gap-2 text-xs">
                <span className={`mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full ${s.dot}`} aria-hidden="true" />
                <span className={`shrink-0 font-mono text-[10px] uppercase tracking-wide ${s.chip}`}>
                  {e.label}
                </span>
                <span className="leading-relaxed text-body-strong">{e.text}</span>
              </li>
            );
          })}
        </ul>
        <p className="mt-3 text-[11px] leading-relaxed text-muted-soft">
          Collaborate with AI on research. The trajectory is automatically captured with epistemic provenance.
        </p>
      </Section>
    </div>
  );
}
