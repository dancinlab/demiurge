// VerbTreeNav — left rail 8-verb spine · ElevenLabs 톤 · Lucide Outline 아이콘.
// /icons 비교에서 lucide-out 채택 (이모지 → 실 SVG path).
// collapsible (≡ 토글 · localStorage 'verbtree.expanded').

"use client";

import { Fragment } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { VERBS, type VerbId, type VerbStatus } from "@/lib/verbs";

// NOTE: do NOT re-export the runtime `VERBS` value from this "use client"
// module — Turbopack turns a value re-exported across the RSC boundary into a
// reference proxy, so a server-side `VERBS.map` then throws "not a function"
// (the exact stale error seen pre-#2). The SSOT is @/lib/verbs; import VERBS
// from there. Types are erased at compile time, so re-exporting them is safe.
export type { VerbId, VerbStatus };

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
  workbench: "M3 3h7v7H3z M14 3h7v7h-7z M14 14h7v7h-7z M3 14h7v7H3z",
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

const STATUS_DOT: Record<VerbStatus, string> = {
  complete: "●",
  in_progress: "◐",
  todo: "○",
};
const STATUS_COLOR: Record<VerbStatus, string> = {
  complete: "text-success",
  in_progress: "text-body",
  todo: "text-muted-soft",
};

// 다국어 verb 라벨 (하이브리드: 로케일 라벨 + 캐논 verb 병기). en 은 캐논 verb 그대로라 생략 → 병기 없음.
// 8-verb 어휘는 고정이라 i18n 카탈로그 대신 여기 단일 출처. workbench 는 i18n(dashboard.title) 사용.
const VERB_LABELS: Record<string, Partial<Record<VerbId, string>>> = {
  ko: { discover: "발견", spec: "사양", structure: "구조", design: "설계", analyze: "분석", synth: "합성", verify: "검증", handoff: "인계" },
  ja: { discover: "発見", spec: "仕様", structure: "構造", design: "設計", analyze: "分析", synth: "合成", verify: "検証", handoff: "引継ぎ" },
  ru: { discover: "поиск", spec: "спец", structure: "структура", design: "дизайн", analyze: "анализ", synth: "синтез", verify: "проверка", handoff: "передача" },
  zh: { discover: "发现", spec: "规格", structure: "结构", design: "设计", analyze: "分析", synth: "合成", verify: "验证", handoff: "交接" },
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
  topbarWorkbench?: string;
};

export function VerbTreeNav({
  domain: domainProp,
  statusByVerb,
  i18n,
  locale,
}: {
  domain?: string;
  statusByVerb?: Partial<Record<VerbId, VerbStatus>>;
  // i18n kept for caller compat (collapse/expand strings now unused — toggle 폐기).
  i18n?: VerbTreeI18n;
  locale?: string;
}) {
  const pathname = usePathname() ?? "";
  const { verb: activeVerb, domain: detectedDomain } = detectActive(pathname);
  const domain = domainProp ?? detectedDomain;

  // ElevenLabs 사이드바 패턴 — 항상 아이콘 + 라벨 표시 (펼치기/접기 토글 폐기).
  return (
    <nav className="flex h-full flex-col gap-0.5 text-sm">
      {VERBS.map((v) => {
        const status: VerbStatus = statusByVerb?.[v.id] ?? "todo";
        const isActive = v.id === activeVerb;
        const href = domain ? `/${v.id}/${domain}` : `/${v.id}`;
        const locLabel = (locale && VERB_LABELS[locale]?.[v.id]) || v.label;
        return (
          <Fragment key={v.id}>
            <Link
              href={href}
              title={v.label}
              className={[
                "flex items-center gap-2 rounded-chip px-2 py-1.5 text-[13px]",
                isActive
                  ? "bg-surface-strong font-semibold text-ink"
                  : "text-body-strong hover:bg-surface-strong hover:text-ink",
              ].join(" ")}
            >
              <LucideIcon id={v.id} />
              <span className="flex min-w-0 flex-1 items-center gap-2">
                <span className="truncate">{locLabel}</span>
                {locLabel !== v.label && (
                  <span className="shrink-0 text-[10px] font-normal text-muted-soft">{v.label}</span>
                )}
              </span>
              <span className={`text-xs ${STATUS_COLOR[status]}`}>{STATUS_DOT[status]}</span>
            </Link>
            {/* discover 바로 아래 — 워크벤치(대시보드) 진입. verb 아님이라 상태닷 없음. */}
            {v.id === "discover" && (
              <Link
                href="/dashboard"
                title={i18n?.topbarWorkbench ?? "Workbench"}
                className={[
                  "flex items-center gap-2 rounded-chip px-2 py-1.5 text-[13px]",
                  pathname.startsWith("/dashboard")
                    ? "bg-surface-strong font-semibold text-ink"
                    : "text-body-strong hover:bg-surface-strong hover:text-ink",
                ].join(" ")}
              >
                <LucideIcon id="workbench" />
                <span className="flex min-w-0 flex-1 items-center gap-2">
                  <span className="truncate">{i18n?.topbarWorkbench ?? "Workbench"}</span>
                  {(i18n?.topbarWorkbench ?? "Workbench").toLowerCase() !== "workbench" && (
                    <span className="shrink-0 text-[10px] font-normal text-muted-soft">workbench</span>
                  )}
                </span>
              </Link>
            )}
          </Fragment>
        );
      })}
    </nav>
  );
}
