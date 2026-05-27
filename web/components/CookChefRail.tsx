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
    <aside className="flex h-full flex-col rounded-[10px] border border-gray-200 bg-white p-3 text-sm shadow-sm">
      <header className="mb-2 flex items-center gap-2 border-b border-gray-200 pb-2">
        <span className="text-lg" aria-hidden="true">🧑‍🍳</span>
        <div className="flex flex-col leading-tight">
          <span className="font-semibold text-gray-900">{i18n.chefTitle}</span>
          {domain ? (
            <span className="font-mono text-[10px] text-gray-500">· {domain}</span>
          ) : (
            <span className="text-[10px] text-gray-400">{i18n.chefAwaiting}</span>
          )}
        </div>
        <span
          className="ml-auto h-2 w-2 rounded-full bg-emerald-500"
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
