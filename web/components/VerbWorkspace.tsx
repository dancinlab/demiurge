"use client";

// VerbWorkspace — #2 base pattern. The SINGLE reusable composition that turns
// every verb page into a functional workspace:
//
//   ┌─ execution panel ─┐   LLM verb → VerbDraftForm  (→ POST /api/llm)
//   │  (verb-specific)  │   CLI verb → VerbRunStream   (→ /api/stream SSE)
//   └───────────────────┘
//   ┌─ live viewer ─────┐   the pickSlot(verb, domain) server node, passed in
//   │  (server slot)    │   as `children` (slot stays server-rendered)
//   └───────────────────┘
//
// d4 single generic dispatch: which panel renders is decided ENTIRELY by
// `panel.kind` from lib/verb-config — no per-verb branching beyond this switch.
// #4 (per-verb finishing) only edits lib/verb-config + the i18n labels.
//
// All copy arrives pre-resolved as serializable props (server resolves i18n in
// VerbShell) so this client component never imports the message catalog.

import type { ReactNode } from "react";
import { VerbDraftForm, type VerbDraftFormI18n, type VerbInputField } from "./VerbDraftForm";
import { VerbRunStream, type VerbRunStreamI18n } from "./VerbRunStream";
import { Section } from "./ui/Section";

export type WorkspacePanel =
  | {
      kind: "llm";
      verb: "spec" | "design" | "analyze" | "handoff";
      fields: VerbInputField[]; // labels already localized
      fixedParams: Record<string, string | null>;
      maxOutputTokens?: number;
    }
  | {
      kind: "cli";
      verb: string;
      args: string[];
    };

export type VerbWorkspaceI18n = {
  panelHeading: string; // "▶ execute"
  viewerHeading: string; // "live view"
  draft: VerbDraftFormI18n;
  run: VerbRunStreamI18n;
};

export function VerbWorkspace({
  domain,
  panel,
  i18n,
  children,
}: {
  domain: string;
  panel: WorkspacePanel;
  i18n: VerbWorkspaceI18n;
  children: ReactNode; // the live viewer slot (server-rendered)
}) {
  return (
    <div className="flex h-full flex-col gap-4 overflow-auto">
      <Section title={i18n.panelHeading}>
        {panel.kind === "llm" ? (
          <VerbDraftForm
            verb={panel.verb}
            fields={panel.fields}
            fixedParams={panel.fixedParams}
            domain={domain}
            maxOutputTokens={panel.maxOutputTokens}
            i18n={i18n.draft}
          />
        ) : (
          <VerbRunStream verb={panel.verb} args={panel.args} i18n={i18n.run} />
        )}
      </Section>

      <Section
        as="div"
        title={i18n.viewerHeading}
        bodyClassName="mt-2 min-h-0 flex-1"
      >
        {/* viewer panel — 옵션 H · 완전 평면. 배경/라운딩 0; 공간(패딩)만 유지. */}
        <div className="py-1">{children}</div>
      </Section>
    </div>
  );
}
