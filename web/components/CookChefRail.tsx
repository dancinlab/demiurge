// CookChefRail — server component. i18n strings flow as props.
// shadcn Modern 톤. AssistChat 본체에 chat i18n + locale 전달.

import { AssistChat, type ChatI18n } from "./AssistChat";

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
      {/* 단일 행: 🧑‍🍳 + 제목 + 상태닷. 도메인명은 헤더(TopBar 좌측)로 이동 — 여기선 제거. */}
      <header className="mb-2 flex items-center gap-2 border-b border-hairline pb-2">
        <span className="shrink-0 text-lg leading-none" aria-hidden="true">🧑‍🍳</span>
        <span className="flex-1 truncate font-serif text-base font-semibold text-ink">{i18n.chefTitle}</span>
        <span
          className="h-2 w-2 shrink-0 rounded-full bg-success"
          title={i18n.chefReady}
          aria-label={i18n.chefReady}
        />
      </header>
      <div className="flex-1 min-h-0 overflow-hidden">
        <AssistChat note={domain} i18n={chatI18n} locale={locale} />
      </div>
    </aside>
  );
}
