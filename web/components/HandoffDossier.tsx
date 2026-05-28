// HandoffDossier — client-side dossier preview + download.
// Pulls /api/v1/handoff/[domain], renders manifest summary, offers download.
//
// Pure presentation copy arrives via the `i18n` prop from the server page (no
// client t()). Semantic tokens only (DESIGN_TOKENS.md SSOT).

"use client";

import { useEffect, useState } from "react";
import { Modal } from "./Modal";
import { Section } from "./ui/Section";

type Dossier = {
  domain: string;
  generated_at: string;
  records: Array<Record<string, unknown>>;
  manifest: {
    verb_count: number;
    complete_count: number;
    in_progress_count: number;
    todo_count: number;
  };
};

export type HandoffDossierI18n = {
  loading: string;
  dossier: string; // "dossier"
  completed: string; // "{done}/{total} complete ({pct}%)" -> uses {done}{total}{pct}
  download: string; // "download (.json)"
  complete: string; // "complete"
  inProgress: string; // "in progress"
  todo: string; // "todo"
  records: string; // "records"
  // Radix Modal — 다운로드 확인 다이얼로그 (#3 대표 적용처)
  confirmTitle: string; // "Download dossier?"
  confirmBody: string; // "{domain}" 토큰 — 다운로드 대상 설명
  confirmDownload: string; // 확인 버튼
  confirmCancel: string; // 취소 버튼
  close: string; // 닫기 aria-label
};

export function HandoffDossier({
  domain,
  i18n,
}: {
  domain: string;
  i18n: HandoffDossierI18n;
}) {
  const [dossier, setDossier] = useState<Dossier | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [confirmOpen, setConfirmOpen] = useState(false);

  function doDownload(): void {
    setConfirmOpen(false);
    if (typeof window !== "undefined") {
      window.location.href = `/api/v1/handoff/${domain}?download=1`;
    }
  }

  useEffect(() => {
    fetch(`/api/v1/handoff/${domain}`)
      .then(async (r) => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then((d) => setDossier(d as Dossier))
      .catch((e: unknown) =>
        setError(e instanceof Error ? e.message : String(e)),
      );
  }, [domain]);

  if (error) return <div className="text-xs text-danger">{error}</div>;
  if (!dossier) return <div className="text-xs text-muted">{i18n.loading}</div>;

  const m = dossier.manifest;
  const pct = m.verb_count
    ? Math.round((m.complete_count / m.verb_count) * 100)
    : 0;

  const completedMeta = i18n.completed
    .replace("{done}", String(m.complete_count))
    .replace("{total}", String(m.verb_count))
    .replace("{pct}", String(pct));
  const downloadModal = (
    /* #3 Radix Modal 대표 적용 — 다운로드 전 확인 다이얼로그 (fade+scale 전환,
       reduced-motion 가드는 Modal 내부 useReducedMotion). 라벨 전부 i18n. */
    <Modal
      open={confirmOpen}
      onOpenChange={setConfirmOpen}
      title={i18n.confirmTitle}
      description={i18n.confirmBody.replace("{domain}", dossier.domain)}
      closeLabel={i18n.close}
      trigger={
        <button
          type="button"
          className="rounded-control bg-canvas-soft px-3 py-1 text-xs text-ink hover:bg-surface-strong"
        >
          ⬇ {i18n.download}
        </button>
      }
      footer={
        <>
          <button
            type="button"
            onClick={() => setConfirmOpen(false)}
            className="rounded-control px-3 py-1.5 text-xs text-muted hover:bg-surface-strong hover:text-ink"
          >
            {i18n.confirmCancel}
          </button>
          <button
            type="button"
            onClick={doDownload}
            className="rounded-control bg-primary px-3 py-1.5 text-xs font-medium text-on-primary hover:bg-primary-active"
          >
            ⬇ {i18n.confirmDownload}
          </button>
        </>
      }
    />
  );

  return (
    <Section
      eyebrow={`📦 ${dossier.generated_at.slice(0, 19).replace("T", " ")}`}
      title={`${dossier.domain} ${i18n.dossier}`}
      meta={completedMeta}
      trailing={downloadModal}
      bodyClassName="mt-3 space-y-3 text-sm"
    >
      <div className="grid grid-cols-3 gap-2 text-xs">
        <div className="px-2 py-1 text-success">
          🟢 {i18n.complete} {m.complete_count}
        </div>
        <div className="px-2 py-1 text-muted">
          🟡 {i18n.inProgress} {m.in_progress_count}
        </div>
        <div className="px-2 py-1 text-muted-soft">
          ⚪ {i18n.todo} {m.todo_count}
        </div>
      </div>
      <details className="text-xs">
        <summary className="cursor-pointer text-body">
          📜 {i18n.records} ({dossier.records.length})
        </summary>
        <ul className="mt-1 space-y-1">
          {dossier.records.map((r, i) => (
            <li
              key={String(r.verb ?? r.id ?? i)}
              className="flex items-center gap-2 py-1"
            >
              <span className="font-mono text-body-strong">
                {String(r.verb ?? r.id ?? `record ${i + 1}`)}
              </span>
              {typeof r.summary === "string" && r.summary && (
                <span className="flex-1 truncate text-muted">{r.summary}</span>
              )}
              <RecordStatus status={r.status} />
            </li>
          ))}
        </ul>
      </details>
    </Section>
  );
}

function RecordStatus({ status }: { status: unknown }) {
  const s = typeof status === "string" ? status : "";
  const tone =
    s === "complete"
      ? "text-success"
      : s === "in_progress"
        ? "text-muted"
        : s === "todo"
          ? "text-muted-soft"
          : "text-danger";
  return <span className={`ml-auto shrink-0 ${tone}`}>{s || "—"}</span>;
}
