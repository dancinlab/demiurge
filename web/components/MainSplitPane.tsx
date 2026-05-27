// MainSplitPane — Q2 layout · 위=record · 중간=시각화 slot · 아래=history.
// Server-rendered shell; slot/history children injected by the verb page.
// shadcn Modern 톤 (border-gray-200 · rounded-[10px] · shadow-sm).

import type { ReactNode } from "react";

function Band({
  label,
  children,
  grow = false,
}: {
  label: string;
  children: ReactNode;
  grow?: boolean;
}) {
  return (
    <section
      className={[
        "rounded-lg border border-gray-200 bg-gray-50 p-3",
        grow ? "flex-1 min-h-0" : "",
      ].join(" ")}
    >
      <div className="mb-1.5 text-[11px] font-medium uppercase tracking-wide text-gray-500">
        {label}
      </div>
      <div className={grow ? "h-full" : "font-mono text-xs text-gray-700"}>{children}</div>
    </section>
  );
}

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
      <Band label="📜 record">{record}</Band>
      <Band label="🎨 slot" grow>{slot}</Band>
      <Band label="📜 history">{history}</Band>
    </div>
  );
}
