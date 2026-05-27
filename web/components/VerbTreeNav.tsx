// VerbTreeNav — left rail 8-verb spine (Q1).
// 현재 단계는 ring-2 테두리 강조 · 완료=🟢 진행중=🟡 미시작=⚪.
// Server-rendered; activeVerb + statusByVerb come from page props.

import Link from "next/link";

export const VERBS = [
  { id: "spec", icon: "📜", label: "spec" },
  { id: "structure", icon: "🧊", label: "structure" },
  { id: "design", icon: "📐", label: "design" },
  { id: "analyze", icon: "📊", label: "analyze" },
  { id: "synth", icon: "🧪", label: "synth" },
  { id: "verify", icon: "🟢", label: "verify" },
  { id: "handoff", icon: "📦", label: "handoff" },
  { id: "discover", icon: "🌳", label: "discover" },
] as const;

export type VerbId = (typeof VERBS)[number]["id"];
export type VerbStatus = "complete" | "in_progress" | "todo";

const STATUS_DOT: Record<VerbStatus, string> = {
  complete: "🟢",
  in_progress: "🟡",
  todo: "⚪",
};

export function VerbTreeNav({
  activeVerb,
  statusByVerb,
  domain,
}: {
  activeVerb: VerbId;
  statusByVerb: Partial<Record<VerbId, VerbStatus>>;
  domain: string;
}) {
  return (
    <nav className="space-y-1 text-sm">
      {VERBS.map((v) => {
        const status: VerbStatus = statusByVerb[v.id] ?? "todo";
        const isActive = v.id === activeVerb;
        return (
          <Link
            key={v.id}
            href={`/${v.id}?d=${domain}`}
            className={[
              "flex items-center gap-2 rounded px-2 py-1",
              isActive
                ? "ring-2 ring-blue-500 bg-blue-50 dark:bg-blue-950/30"
                : "hover:bg-neutral-100 dark:hover:bg-neutral-900",
            ].join(" ")}
          >
            <span>{v.icon}</span>
            <span className="flex-1">{v.label}</span>
            <span className="text-xs">{STATUS_DOT[status]}</span>
          </Link>
        );
      })}
    </nav>
  );
}
