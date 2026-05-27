// VerbShell — main 영역 3-band (record · slot · history).
// record + history 는 도메인 데이터에서 직접 구성 (이전엔 각 verb page 가
// raw JSON dump · placeholder 를 넘겨주던 걸 여기로 통합):
//   record  = 도메인 메타 (title · @goal · 진행도 bar)
//   history = 도메인 log tail (12줄)
// verb page 는 이제 slot 만 전달. shadcn Modern 톤.

import type { ReactNode } from "react";
import fs from "node:fs/promises";
import path from "node:path";
import { MainSplitPane } from "./MainSplitPane";
import { listDomains } from "@/lib/domains";
import type { VerbId, VerbStatus } from "./VerbTreeNav";

const REPO_ROOT =
  process.env.DEMIURGE_DATA_ROOT ?? path.resolve(process.cwd(), "..");

export async function VerbShell({
  domain,
  slot,
}: {
  verb: VerbId;
  domain: string;
  statusByVerb?: Partial<Record<VerbId, VerbStatus>>;
  slot: ReactNode;
}) {
  const domains = await listDomains();
  const entry =
    domains.find((d) => d.name.toLowerCase() === domain.toLowerCase()) ?? null;

  const pct =
    entry?.progress && entry.progress.total > 0
      ? Math.round((100 * entry.progress.done) / entry.progress.total)
      : null;

  const record = entry ? (
    <div className="space-y-1.5">
      <div className="flex items-baseline gap-2">
        <span className="font-sans font-semibold text-gray-900">
          {entry.title ?? entry.name}
        </span>
        <span className="font-mono text-[10px] text-gray-400">{domain}</span>
        {pct !== null && (
          <span className="ml-auto font-sans text-[11px] text-gray-500">
            {entry.progress!.done}/{entry.progress!.total} · {pct}%
          </span>
        )}
      </div>
      {entry.goal && (
        <p className="font-sans text-[11px] leading-snug text-gray-600">🎯 {entry.goal}</p>
      )}
      {pct !== null && (
        <div className="h-1.5 overflow-hidden rounded-full bg-gray-100">
          <div className="h-full rounded-full bg-indigo-600" style={{ width: `${pct}%` }} />
        </div>
      )}
    </div>
  ) : (
    <span className="text-gray-400">domain &lsquo;{domain}&rsquo; — no record</span>
  );

  let logTail = "";
  if (entry) {
    try {
      const full = await fs.readFile(path.join(REPO_ROOT, entry.logPath), "utf8");
      logTail = full.split("\n").slice(0, 12).join("\n");
    } catch {
      logTail = "(no log yet)";
    }
  }
  const history = (
    <pre className="max-h-40 overflow-auto whitespace-pre-wrap text-[11px] leading-relaxed text-gray-600">
      {logTail || "(no log)"}
    </pre>
  );

  return <MainSplitPane record={record} slot={slot} history={history} />;
}
