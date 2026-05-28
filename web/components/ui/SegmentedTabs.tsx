// SegmentedTabs — 메뉴/필터 pill 그룹 SSOT.
//
// 재설계 원칙(ElevenLabs 절제 톤):
//   1) 테두리(border) 없음 — 컨테이너 = bg-surface-strong 한 톤.
//   2) active = bg-inverted + text-on-primary (반전 fill).
//   3) inactive = text-muted, hover:text-ink.
//
// 사용처: DomainBrowser 탭(tree·public·matter) · LibraryGallery 필터
//   (all·complete·wip) · MatterLedger 필터(all·absorbed·open) 등.
//
// 시맨틱 토큰만 (DESIGN_TOKENS.md SSOT).

"use client";

export type SegItem<T extends string> = { id: T; label: string };

export function SegmentedTabs<T extends string>({
  items,
  value,
  onChange,
  ariaLabel,
}: {
  items: SegItem<T>[];
  value: T;
  onChange: (next: T) => void;
  ariaLabel?: string;
}) {
  return (
    <div
      role="tablist"
      aria-label={ariaLabel}
      className="inline-flex items-center gap-1 rounded-control bg-surface-strong p-0.5"
    >
      {items.map((it) => {
        const active = it.id === value;
        return (
          <button
            key={it.id}
            type="button"
            role="tab"
            aria-selected={active}
            onClick={() => onChange(it.id)}
            className={[
              "rounded-chip px-3 py-1 text-xs transition",
              active
                ? "bg-inverted font-medium text-on-primary"
                : "text-muted hover:text-ink",
            ].join(" ")}
          >
            {it.label}
          </button>
        );
      })}
    </div>
  );
}
