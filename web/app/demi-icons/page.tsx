// /demi-icons — DEV-ONLY 데미 시그니처 아이콘 후보 4종 비교 (디자이너 스크래치패드).
//
// 제품의 일부가 아니다 — 어떤 프로덕션 nav 에서도 링크되지 않으며, 아래 notFound()
// 가드가 프로덕션 빌드(NODE_ENV === "production")에서는 이 라우트를 통째로 404 시킨다.
// `next dev` 에서만 /demi-icons 로 도달 가능.
//
// 인증 불필요: middleware.ts 의 PROTECTED 정규식은 /(dashboard|spec|…|account) 만
// 매칭한다. /demi-icons 는 거기 없으므로 미들웨어가 NextResponse.next() 로 통과시킨다
// → 로그인 없이 200. (별도 매처 제외 불필요.)
//
// 커스텀 SVG 모션(이모지 아님). 시맨틱 토큰만 (DESIGN_TOKENS.md SSOT). 브랜드 노란
// 닷은 랜딩 로고와 동일한 text-yellow-300.

import { notFound } from "next/navigation";
import { Orbit } from "@/components/demi-icons/Orbit";
import { Morph } from "@/components/demi-icons/Morph";
import { Forge } from "@/components/demi-icons/Forge";
import { Constellation } from "@/components/demi-icons/Constellation";

export const dynamic = "force-dynamic";

type Concept = {
  id: string;
  name: string;
  ko: string;
  blurb: string;
  Icon: React.ComponentType<{ state?: "idle" | "thinking"; size?: number }>;
};

const CONCEPTS: Concept[] = [
  {
    id: "orbit",
    name: "Orbit",
    ko: "오비탈 닷",
    blurb: "중심 노란 닷 + 둘레를 도는 점 8개 (8-verb). idle=느린 공전, thinking=빠른 공전+점 밝아짐.",
    Icon: Orbit,
  },
  {
    id: "morph",
    name: "Morph",
    ko: "모핑 닷",
    blurb: "노란 닷이 원↔육각↔다이아로 숨쉬듯 변형. 가장 미니멀. thinking=빠른 맥동.",
    Icon: Morph,
  },
  {
    id: "forge",
    name: "Forge",
    ko: "포지 스파크",
    blurb: "스파크 입자가 중심 닷으로 모였다 흩어짐 (벼리는 조물주). thinking=모임↔터짐 반복.",
    Icon: Forge,
  },
  {
    id: "constellation",
    name: "Constellation",
    ko: "컨스텔레이션",
    blurb: "점 5개가 선으로 이어진 별자리. thinking=노드 순차 점등 (흐름 은유).",
    Icon: Constellation,
  },
];

// 한 컨셉을 한 배경(light or dark)에서 보여주는 셀:
// 확대(96px) idle/thinking 나란히 + 실제 레일 크기(20px) 맥락.
function PreviewCell({
  Icon,
  variant,
}: {
  Icon: Concept["Icon"];
  variant: "light" | "dark";
}) {
  const isDark = variant === "dark";
  return (
    <div
      className={
        (isDark ? "dark " : "") +
        "rounded-panel border border-hairline bg-canvas p-4 text-ink"
      }
    >
      <div className="mb-3 text-[10px] font-semibold uppercase tracking-wider text-muted-soft">
        {isDark ? "dark bg" : "light bg"}
      </div>

      {/* 확대 96px — idle / thinking */}
      <div className="flex items-end gap-6">
        <figure className="flex flex-col items-center gap-1.5">
          <div className="flex h-24 w-24 items-center justify-center rounded-control bg-surface text-ink">
            <Icon state="idle" size={96} />
          </div>
          <figcaption className="text-[10px] text-muted">idle</figcaption>
        </figure>
        <figure className="flex flex-col items-center gap-1.5">
          <div className="flex h-24 w-24 items-center justify-center rounded-control bg-surface text-ink">
            <Icon state="thinking" size={96} />
          </div>
          <figcaption className="text-[10px] text-muted">thinking</figcaption>
        </figure>
      </div>

      {/* 실제 레일 크기 20px — 라벨 옆 inline 맥락 모사 */}
      <div className="mt-4 flex items-center gap-3 border-t border-hairline pt-3">
        <span className="flex items-center gap-2 text-sm text-ink">
          <Icon state="idle" size={20} />
          demiurge<span className="text-yellow-300">.</span>
        </span>
        <span className="flex items-center gap-2 text-sm text-ink">
          <Icon state="thinking" size={20} />
          <span className="text-muted">thinking…</span>
        </span>
      </div>
    </div>
  );
}

export default function DemiIconsPage() {
  // Hard dev-only gate: 프로덕션 빌드는 이 라우트를 통째로 404.
  if (process.env.NODE_ENV === "production") notFound();

  return (
    <main className="min-h-screen bg-canvas px-8 py-8 text-ink antialiased">
      <header className="mb-6">
        <h1 className="font-display text-2xl font-light tracking-tight text-ink">
          dev · 데미 아이콘 후보 4종 (Demi signature icons)
        </h1>
        <p className="mt-1 max-w-2xl text-sm text-muted">
          커스텀 SVG 모션 (이모지 아님). 각 컨셉 = idle / thinking 2상태. 확대(96px) +
          실제 레일(20px) 맥락. 라이트/다크 배경 둘 다에서 노란 닷 가독성 확인용.
          하나를 골라 알려주면 DemiIcon 으로 채택한다.
        </p>
      </header>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        {CONCEPTS.map((c) => (
          <article
            key={c.id}
            className="rounded-card border border-hairline bg-surface p-5 shadow-card"
          >
            <header className="mb-4 flex items-baseline justify-between gap-3">
              <div>
                <h2 className="text-lg font-semibold text-ink">
                  {c.name}
                  <span className="ml-2 text-sm font-normal text-muted">
                    {c.ko}
                  </span>
                </h2>
                <p className="mt-1 max-w-md text-xs leading-relaxed text-body">
                  {c.blurb}
                </p>
              </div>
              <code className="shrink-0 text-[10px] text-muted-soft">
                id={c.id}
              </code>
            </header>

            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <PreviewCell Icon={c.Icon} variant="light" />
              <PreviewCell Icon={c.Icon} variant="dark" />
            </div>
          </article>
        ))}
      </div>

      <p className="mt-8 text-xs text-muted-soft">
        채택할 컨셉 id 를 알려주세요 (orbit · morph · forge · constellation).
        지금은 프리뷰만 — 기존 DemiIcon 교체 안 함.
      </p>
    </main>
  );
}
