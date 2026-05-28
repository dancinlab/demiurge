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
      {/* 단일 행: 🧑‍🍳 + 제목(고정) + · 도메인(truncate) + 상태닷(고정).
          긴 도메인은 줄내림 대신 말줄임(…) — flex-col 스택 제거가 줄내림 수정. */}
      <header className="mb-2 flex items-center gap-2 border-b border-hairline pb-2">
        <span className="shrink-0 text-lg leading-none" aria-hidden="true">🧑‍🍳</span>
        <span className="shrink-0 font-serif text-base font-semibold text-ink">{i18n.chefTitle}</span>
        {domain ? (
          <span className="min-w-0 flex-1 truncate font-mono text-[10px] text-muted">· {domain}</span>
        ) : (
          <span className="min-w-0 flex-1 truncate text-[10px] text-muted-soft">{i18n.chefAwaiting}</span>
        )}
        <span
          className="ml-auto h-2 w-2 shrink-0 rounded-full bg-success"
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
