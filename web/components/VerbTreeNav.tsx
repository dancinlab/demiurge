// VerbTreeNav — left rail 8-verb spine · shadcn Modern 톤 · Lucide Outline 아이콘.
// /icons 비교에서 lucide-out 채택 (이모지 → 실 SVG path).
// collapsible (≡ 토글 · localStorage 'verbtree.expanded').

"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";

// Lucide outline SVG path 8개 (file-text · layers · pen-tool · bar-chart · flask-conical
// · check-circle · package · search). ISC 라이선스 (lucide).
const VERB_ICON_PATHS: Record<string, string> = {
  spec:      "M14 3v4a1 1 0 0 0 1 1h4M5 8V5a2 2 0 0 1 2-2h7l5 5v11a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2v-3M9 12h6M9 16h4",
  structure: "M3 7l9-4 9 4-9 4-9-4zM3 12l9 4 9-4M3 17l9 4 9-4",
  design:    "M12 19l7-7 3 3-7 7-3-3zM18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5zM2 2l7.586 7.586",
  analyze:   "M3 3v18h18M7 16V9M12 16V5M17 16v-5",
  synth:     "M9 2v7.31M15 9.34V2M11 14h2M12 2v0M6.4 22h11.2a2 2 0 0 0 1.84-2.77L15 9V2H9v7L4.56 19.23A2 2 0 0 0 6.4 22z",
  verify:    "M9 12l2 2 4-4m6 2a9 9 0 1 1-18 0 9 9 0 0 1 18 0z",
  handoff:   "M16.5 9.4l-9-5.19M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z",
  discover:  "M21 21l-6-6m2-5a7 7 0 1 1-14 0 7 7 0 0 1 14 0z",
};

function LucideIcon({ id }: { id: string }) {
  return (
    <svg
      viewBox="0 0 24 24"
      width="18"
      height="18"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.6"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
    >
      <path d={VERB_ICON_PATHS[id]} />
    </svg>
  );
}

// discover 가 최상단 — 모든 작업의 시작점 (kick / gap / 발산).
// 그 뒤로 7-verb pipeline (spec → ... → handoff) 정통 순서.
export const VERBS = [
  { id: "discover", label: "discover" },
  { id: "spec", label: "spec" },
  { id: "structure", label: "structure" },
  { id: "design", label: "design" },
  { id: "analyze", label: "analyze" },
  { id: "synth", label: "synth" },
  { id: "verify", label: "verify" },
  { id: "handoff", label: "handoff" },
] as const;

export type VerbId = (typeof VERBS)[number]["id"];
export type VerbStatus = "complete" | "in_progress" | "todo";

const STATUS_DOT: Record<VerbStatus, string> = {
  complete: "●",
  in_progress: "◐",
  todo: "○",
};
const STATUS_COLOR: Record<VerbStatus, string> = {
  complete: "text-emerald-600",
  in_progress: "text-amber-600",
  todo: "text-gray-300",
};

const VERB_RE = /^\/(spec|structure|design|analyze|synth|verify|handoff|discover)(?:\/([^/?#]+))?/;

function detectActive(pathname: string): { verb: VerbId | null; domain: string | null } {
  const m = pathname.match(VERB_RE);
  if (!m) return { verb: null, domain: null };
  return { verb: m[1] as VerbId, domain: m[2] ?? null };
}

type VerbTreeI18n = {
  verbtreeCollapse: string;
  verbtreeExpand: string;
  verbtree8Verbs: string;
};

export function VerbTreeNav({
  domain: domainProp,
  statusByVerb,
  i18n,
}: {
  domain?: string;
  statusByVerb?: Partial<Record<VerbId, VerbStatus>>;
  i18n?: VerbTreeI18n;
}) {
  const pathname = usePathname() ?? "";
  const { verb: activeVerb, domain: detectedDomain } = detectActive(pathname);
  const domain = domainProp ?? detectedDomain;

  // Fallback strings — used when this component is mounted outside the
  // (app) layout (e.g. tests · public pages). Layout always passes i18n.
  const labels = i18n ?? {
    verbtreeCollapse: "collapse",
    verbtreeExpand: "expand",
    verbtree8Verbs: "8 verbs",
  };

  const [expanded, setExpanded] = useState(false);
  useEffect(() => {
    const v = typeof window !== "undefined" && localStorage.getItem("verbtree.expanded");
    if (v === "1") setExpanded(true);
  }, []);
  function toggle() {
    setExpanded((e) => {
      if (typeof window !== "undefined") localStorage.setItem("verbtree.expanded", e ? "0" : "1");
      return !e;
    });
  }

  return (
    <nav className="flex h-full flex-col gap-0.5 text-sm">
      <button
        type="button"
        onClick={toggle}
        className="mb-1 flex items-center justify-between rounded-md px-2 py-1 text-[11px] font-medium uppercase tracking-wide text-gray-500 hover:bg-gray-100"
        title={expanded ? labels.verbtreeCollapse : labels.verbtreeExpand}
      >
        <span>{expanded ? (domain ? `· ${domain}` : labels.verbtree8Verbs) : "≡"}</span>
        <span>{expanded ? "◂" : "▸"}</span>
      </button>
      {VERBS.map((v) => {
        const status: VerbStatus = statusByVerb?.[v.id] ?? "todo";
        const isActive = v.id === activeVerb;
        const href = domain ? `/${v.id}/${domain}` : `/${v.id}`;
        return (
          <Link
            key={v.id}
            href={href}
            title={v.label}
            className={[
              "flex items-center gap-2 rounded-md px-2 py-1.5 text-[13px]",
              isActive
                ? "bg-gray-100 font-semibold text-gray-900"
                : "text-gray-700 hover:bg-gray-100 hover:text-gray-900",
            ].join(" ")}
          >
            <LucideIcon id={v.id} />
            {expanded && <span className="flex-1">{v.label}</span>}
            {expanded && <span className={`text-xs ${STATUS_COLOR[status]}`}>{STATUS_DOT[status]}</span>}
          </Link>
        );
      })}
    </nav>
  );
}
