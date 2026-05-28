// VerbShell — main 영역 3-band (record · slot · history).
// record + history 는 도메인 데이터에서 직접 구성:
//   record  = 도메인 메타 (title · @goal · 진행도 bar)
//   history = 도메인 log tail (12줄)
//
// #2 base pattern: the slot band is now a FUNCTIONAL workspace. VerbShell
// resolves the verb's execution config (lib/verb-config) + i18n (server-side),
// builds a serializable WorkspacePanel, and wraps the verb's live viewer
// (pickSlot, passed as `slot`) inside <VerbWorkspace>. #4 only edits the
// config table + labels — this shell stays generic (d4 single dispatch).

import type { ReactNode } from "react";
import fs from "node:fs/promises";
import path from "node:path";
import { MainSplitPane } from "./MainSplitPane";
import { VerbWorkspace, type WorkspacePanel } from "./VerbWorkspace";
import { findDomainEntry } from "@/lib/domains";
import type { VerbId, VerbStatus } from "@/lib/verbs";
import { getVerbConfig } from "@/lib/verb-config";
import { getMessages, t } from "@/lib/i18n";
import { repoDataRoot } from "@/lib/data-root";

const REPO_ROOT = repoDataRoot();

function buildPanel(
  verb: VerbId,
  domain: string,
  fixedParams: Record<string, string | null>,
  labelFor: (key: string) => string,
): WorkspacePanel {
  const cfg = getVerbConfig(verb);
  if (cfg.kind === "llm") {
    return {
      kind: "llm",
      verb: cfg.verb,
      // Resolve each field's i18n KEY → display copy here (server-side).
      fields: cfg.fields.map((f) => ({ ...f, label: labelFor(f.label) })),
      fixedParams,
      maxOutputTokens: cfg.maxOutputTokens,
    };
  }
  return { kind: "cli", verb, args: cfg.buildArgs(domain) };
}

export async function VerbShell({
  verb,
  domain,
  slot,
}: {
  verb: VerbId;
  domain: string;
  statusByVerb?: Partial<Record<VerbId, VerbStatus>>;
  slot: ReactNode;
}) {
  // `domain` is the (possibly nested) id, e.g. "CARDIO+/DAPTPGX" or "RTSC".
  // findDomainEntry resolves it against the full roster on the leaf segment, so
  // both nested + legacy-flat routes find their .md/.log.md record.
  const [entry, messages] = await Promise.all([
    findDomainEntry(domain),
    getMessages(),
  ]);

  const pct =
    entry?.progress && entry.progress.total > 0
      ? Math.round((100 * entry.progress.done) / entry.progress.total)
      : null;

  const record = entry ? (
    <div className="space-y-1.5">
      <div className="flex items-baseline gap-2">
        <span className="font-sans font-semibold text-ink">
          {entry.title ?? entry.name}
        </span>
        <span className="font-mono text-[10px] text-muted-soft">{domain}</span>
        {pct !== null && (
          <span className="ml-auto font-sans text-[11px] text-muted">
            {entry.progress!.done}/{entry.progress!.total} · {pct}%
          </span>
        )}
      </div>
      {entry.goal && (
        <p className="font-sans text-[11px] leading-snug text-body">🎯 {entry.goal}</p>
      )}
      {pct !== null && (
        <div className="h-1.5 overflow-hidden rounded-full bg-surface-strong">
          <div className="h-full rounded-full bg-inverted" style={{ width: `${pct}%` }} />
        </div>
      )}
    </div>
  ) : (
    <span className="text-muted-soft">domain &lsquo;{domain}&rsquo; — no record</span>
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
    <pre className="max-h-40 overflow-auto whitespace-pre-wrap text-[11px] leading-relaxed text-body">
      {logTail || "(no log)"}
    </pre>
  );

  // ── Build the functional workspace (#2) ───────────────────────────────────
  const labelFor = (key: string) => t(messages, `verb_workspace.${key}`);
  const fixedParams: Record<string, string | null> = {
    domainName: entry?.name ?? domain,
    currentGoal: entry?.goal ?? null,
  };
  const panel = buildPanel(verb, entry?.name ?? domain, fixedParams, labelFor);

  const workspaceI18n = {
    panelHeading: labelFor("panel_heading"),
    viewerHeading: labelFor("viewer_heading"),
    draft: {
      submit: labelFor("submit"),
      calling: labelFor("calling"),
      modelNote: labelFor("model_note"),
      missingRequired: labelFor("missing_required"),
      failed: labelFor("failed"),
      draftLabel: labelFor("draft_label"),
      emptyResp: labelFor("empty_resp"),
      reasoningNote: labelFor("reasoning_note"),
      saveToLog: labelFor("save_to_log"),
      saving: labelFor("saving"),
      saved: labelFor("saved"),
      saveFailed: labelFor("save_failed"),
    },
    run: {
      run: labelFor("run"),
      running: labelFor("running"),
      stop: labelFor("stop"),
      exited: labelFor("exited"),
      empty: labelFor("empty_output"),
      failed: labelFor("failed"),
    },
  };

  const workspace = (
    <VerbWorkspace domain={entry?.name ?? domain} panel={panel} i18n={workspaceI18n}>
      {slot}
    </VerbWorkspace>
  );

  return <MainSplitPane record={record} slot={workspace} history={history} />;
}
