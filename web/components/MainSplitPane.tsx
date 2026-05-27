// MainSplitPane — Q2 layout · 위=record JSON · 중간=시각화 슬롯 · 아래=history.
// Server-rendered shell; slot/history children injected by the verb page.

import type { ReactNode } from "react";

export function MainSplitPane({
  record,
  slot,
  history,
}: {
  record: ReactNode;
  slot: ReactNode;
  history: ReactNode;
}) {
  return (
    <div className="flex h-full flex-col gap-3">
      <section className="rounded border border-neutral-300 bg-white p-3 dark:border-neutral-700 dark:bg-neutral-900">
        <div className="mb-1 text-xs uppercase text-neutral-500">📜 record</div>
        <div className="font-mono text-xs">{record}</div>
      </section>
      <section className="flex-1 rounded border border-neutral-300 bg-white p-3 dark:border-neutral-700 dark:bg-neutral-900">
        <div className="mb-1 text-xs uppercase text-neutral-500">🎨 slot</div>
        <div className="h-full">{slot}</div>
      </section>
      <section className="rounded border border-neutral-300 bg-white p-3 dark:border-neutral-700 dark:bg-neutral-900">
        <div className="mb-1 text-xs uppercase text-neutral-500">📜 history</div>
        <div className="font-mono text-xs">{history}</div>
      </section>
    </div>
  );
}
