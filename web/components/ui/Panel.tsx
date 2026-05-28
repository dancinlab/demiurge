// Panel — main 영역 내부 패널 SSOT.
//
// 재설계 원칙(옵션 H · 완전 평면):
//   main 영역 콘텐츠 카드/패널은 배경·라운딩을 두지 않는다. 섹션/카드 구분은
//   공간(여백 = PAD) + 타이포 위계(Section SSOT)만으로 한다.
//   1) `tone` 은 호출부 호환 위해 시그너처만 유지 — 셋 다 배경 없음(평면).
//   2) `shape` 도 호환 위해 유지하나 라운딩을 부여하지 않음(평면).
//   3) PAD(패딩)는 공간 affordance 라 유지.
//
//   배경/라운딩이 필요한 곳은 main 콘텐츠 카드가 아니라 입력·버튼·네비/플로팅
//   affordance 이며, 그것들은 Panel 을 쓰지 않고 직접 토큰을 단다.
//
// 시맨틱 토큰만 (DESIGN_TOKENS.md SSOT).

import { createElement, type ElementType, type ReactNode } from "react";

type Tone = "raised" | "recessed" | "flat";
type Shape = "card" | "panel" | "control";
type Padding = "none" | "sm" | "md" | "lg";

// 옵션 H — main 콘텐츠는 완전 평면: tone/shape 모두 배경·라운딩 없음.
// (시그너처는 기존 호출부 호환 위해 유지하되, 시각 효과는 0 으로 통일.)
const TONE: Record<Tone, string> = {
  raised: "",
  recessed: "",
  flat: "",
};
const SHAPE: Record<Shape, string> = {
  card: "",
  panel: "",
  control: "",
};
const PAD: Record<Padding, string> = {
  none: "",
  sm: "p-2",
  md: "p-3",
  lg: "p-4",
};

export function Panel({
  tone = "raised",
  shape = "card",
  padding = "md",
  className = "",
  children,
  as = "div",
}: {
  tone?: Tone;
  shape?: Shape;
  padding?: Padding;
  className?: string;
  children: ReactNode;
  as?: ElementType;
}) {
  const cls = [TONE[tone], SHAPE[shape], PAD[padding], className]
    .filter(Boolean)
    .join(" ");
  // createElement keeps the polymorphic `as` type-safe (avoids JSX generic
  // children-typing pitfall on dynamic ElementType).
  return createElement(as, { className: cls }, children);
}

// Panel.Stat — 메트릭 셀 SSOT (큰 숫자 + 작은 라벨).
export function PanelStat({
  value,
  label,
}: {
  value: string;
  label: string;
}) {
  return (
    <Panel tone="raised" shape="card" padding="none" className="px-4 py-3">
      <span className="block font-display text-2xl font-light tracking-tight text-ink">
        {value}
      </span>
      <span className="mt-0.5 block text-[11px] uppercase tracking-wide text-muted">
        {label}
      </span>
    </Panel>
  );
}

// Panel.Empty — 빈 상태/로딩 SSOT (평면 · 배경 없음 · 여백 + muted 텍스트만).
export function PanelEmpty({
  children,
  className = "",
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <Panel
      tone="raised"
      shape="card"
      padding="none"
      className={`px-4 py-6 text-sm text-muted ${className}`}
    >
      {children}
    </Panel>
  );
}
