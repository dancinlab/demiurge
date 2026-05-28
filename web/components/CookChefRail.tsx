// CookChefRail — server component. i18n strings flow as props.
// shadcn Modern 톤. AssistChat 본체에 chat i18n + locale 전달.

import { AssistChat, type ChatI18n } from "./AssistChat";
import { DemiIcon } from "./DemiIcon";

type ChefI18n = {
  chefTitle: string;
  chefAwaiting: string;
  chefReady: string;
};

export function CookChefRail({
  domain,
  i18n,
  chatI18n,
  locale,
}: {
  domain: string;
  i18n: ChefI18n;
  chatI18n: ChatI18n;
  locale: string;
}) {
  return (
    <aside className="flex h-full flex-col p-3 text-sm">
      {/* 단일 행: ✨ + 제목 + 상태닷. 도메인명은 헤더(TopBar 좌측)로 이동 — 여기선 제거.
          재설계: 헤더 hairline 폐기 — 공간(mb-3 + pb-1)만으로 분리. */}
      <header className="mb-3 flex items-center gap-2 pb-1">
        {/* 데미 시그니처 = 모핑 닷(노란 브랜드 포인트). 우측 초록 "라이브" 닷은
            폐기 — 포인트 컬러는 노란 데미 닷 하나로 통일(브랜드 일관). */}
        <DemiIcon className="shrink-0 text-ink" />
        {/* DEMI = 로고(demiurge.) 와 동일 폰트: 시스템 산세리프 · font-black · -0.04em. */}
        <span
          className="flex-1 truncate font-black uppercase leading-none text-ink"
          style={{
            fontFamily:
              "ui-sans-serif, system-ui, -apple-system, 'Helvetica Neue', sans-serif",
            fontSize: 18,
            letterSpacing: "-0.04em",
          }}
        >
          {i18n.chefTitle}
        </span>
      </header>
      <div className="flex-1 min-h-0 overflow-hidden">
        <AssistChat note={domain} i18n={chatI18n} locale={locale} />
      </div>
    </aside>
  );
}
