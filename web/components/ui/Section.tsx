// Section — main 영역 섹션 SSOT.
//
// 옵션 H (타이포 위계만) — 사용자 채택안 (/design-samples).
//
// 분리 메커니즘 = 헤딩 타이포 위계만. border / bg / shadow / hairline 0,
// 컨테이너 패딩 0. children 은 헤딩 바로 아래 짧은 spacing(mt-2) 으로 따라온다.
// 섹션 간 간격은 부모(space-y-*) 가 결정 — Section 은 외곽 margin 미사용.
//
// 헤딩 클래스 (reference: app/design-samples/page.tsx · OptionH):
//   font-display text-3xl font-light tracking-tight text-ink
//
// Prop 시그니처는 기존 호출부 호환 위해 그대로 유지:
//   - eyebrow : 섹션 헤딩 텍스트 (현 호출부의 기본 사용; title 미지정 시 헤딩으로 승격).
//               title 이 함께 지정되면 작은 muted 라벨(uppercase · tracking-wide)
//               로 헤딩 위 한 줄에 렌더.
//   - title   : 옵션 — 명시적 헤딩 텍스트. 지정 시 eyebrow 는 라벨로 강등.
//   - meta    : 헤딩 옆 작은 텍스트(우측 ml-auto).
//   - trailing: 헤딩 행에 인라인 우측 요소(예: tabs).
//
// 시맨틱 토큰만 (DESIGN_TOKENS.md SSOT). border / bg 추가 금지.

import { createElement, type ReactNode } from "react";

export function Section({
  eyebrow,
  title,
  meta,
  trailing,
  children,
  as = "section",
  // children-only spacing override. Default mt-2 (Option H 와 동일).
  bodyClassName,
}: {
  /** 작은 uppercase 라벨 — title 과 함께 지정되면 헤딩 위 한 줄.
   *  title 이 없으면 헤딩 텍스트로 승격(현 호출부 기본 동작). */
  eyebrow?: ReactNode;
  /** 명시적 섹션 헤딩(Option H 타이포). 미지정 시 eyebrow 가 헤딩으로 승격. */
  title?: ReactNode;
  /** 헤딩 옆 우측 작은 텍스트(예: progress dot · count). */
  meta?: ReactNode;
  /** 헤딩 행에 인라인 우측 요소(예: tab pills). */
  trailing?: ReactNode;
  children: ReactNode;
  as?: "section" | "div" | "article";
  bodyClassName?: string;
}) {
  // title 미지정 + eyebrow 만 있으면 eyebrow 를 헤딩으로 승격(현 호출부 호환).
  const heading: ReactNode = title ?? eyebrow;
  // title 이 명시되어 있을 때만 eyebrow 는 라벨로 표시.
  const labelAbove: ReactNode = title ? eyebrow : null;

  const hasHeaderRow = heading || trailing || meta || labelAbove;

  return createElement(
    as,
    {},
    hasHeaderRow && (
      <div>
        {labelAbove && (
          <p className="text-[10px] font-semibold uppercase tracking-[0.18em] text-muted-soft">
            {labelAbove}
          </p>
        )}
        {(heading || trailing || meta) && (
          <div
            className={
              (labelAbove ? "mt-1 " : "") +
              "flex flex-wrap items-baseline gap-3"
            }
          >
            {heading && (
              <h2 className="font-display text-3xl font-light tracking-tight text-ink">
                {heading}
              </h2>
            )}
            {trailing}
            {meta && <span className="ml-auto text-xs text-muted">{meta}</span>}
          </div>
        )}
      </div>
    ),
    <div className={bodyClassName ?? "mt-2"}>{children}</div>,
  );
}
