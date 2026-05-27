// CookChefRail — shadcn Modern 톤.

import { AssistChat } from "./AssistChat";

export function CookChefRail({ domain }: { domain: string }) {
  return (
    <aside className="flex h-full flex-col rounded-[10px] border border-slate-200 bg-white p-3 text-sm shadow-sm">
      <header className="mb-2 flex items-center gap-2 border-b border-slate-200 pb-2">
        <span className="text-lg">🧑‍🍳</span>
        <span className="font-semibold text-slate-900">요리선생</span>
        <span className="ml-auto text-xs text-slate-500">always on</span>
      </header>
      <div className="flex-1 overflow-auto">
        <AssistChat note={domain} />
      </div>
    </aside>
  );
}
