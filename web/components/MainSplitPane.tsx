// MainSplitPane — Q2 layout · 위=record · 중간=시각화 slot · 아래=history.
// Server-rendered shell; slot/history children injected by the verb page.
// 재설계 후 — 옵션 H · 완전 평면. 밴드 배경/라운딩 0; 분리는 헤딩 위계 + 공간만.
//
// 헤딩 = `components/ui/Section` SSOT (H 패턴 자동 적용 — font-display +
// font-light + tracking-tight). 밴드 박스 배경(bg-surface-strong)·라운딩 제거.

import type { ReactNode } from "react";
import { Section } from "./ui/Section";

function Band({
  title,
  children,
  grow = false,
}: {
  title: string;
  children: ReactNode;
  grow?: boolean;
}) {
  return (
    <div
      className={grow ? "min-h-0 flex-1" : ""}
    >
      <Section
        title={title}
        bodyClassName={
          grow ? "mt-2 h-full" : "mt-2 font-mono text-xs text-body-strong"
        }
      >
        {children}
      </Section>
    </div>
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
      <Band title="record">{record}</Band>
      <Band title="slot" grow>{slot}</Band>
      <Band title="history">{history}</Band>
    </div>
  );
}
