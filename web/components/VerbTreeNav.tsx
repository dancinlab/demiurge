// VerbTreeNav — left rail 8-verb spine (Q1).
// PR#34: client component · usePathname() 으로 active verb 자동 감지.
// layout.tsx 가 이 컴포넌트를 한 번 mount → SPA navigation 시 persistent.

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

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

const VERB_RE = /^\/(spec|structure|design|analyze|synth|verify|handoff|discover)(?:\/([^/?#]+))?/;

function detectActive(pathname: string): { verb: VerbId | null; domain: string | null } {
  const m = pathname.match(VERB_RE);
  if (!m) return { verb: null, domain: null };
  return { verb: m[1] as VerbId, domain: m[2] ?? null };
}

export function VerbTreeNav({
  domain: domainProp,
  statusByVerb,
}: {
  domain?: string;
  statusByVerb?: Partial<Record<VerbId, VerbStatus>>;
}) {
  const pathname = usePathname() ?? "";
  const { verb: activeVerb, domain: detectedDomain } = detectActive(pathname);
  const domain = domainProp ?? detectedDomain;

  return (
    <nav className="space-y-1 text-sm">
      <div className="mb-2 px-2 text-xs uppercase text-neutral-500">
        {domain ? `domain · ${domain}` : "8 verbs"}
      </div>
      {VERBS.map((v) => {
        const status: VerbStatus = statusByVerb?.[v.id] ?? "todo";
        const isActive = v.id === activeVerb;
        const href = domain ? `/${v.id}/${domain}` : `/${v.id}`;
        return (
          <Link
            key={v.id}
            href={href}
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
