// CookChefRail — shadcn Modern 톤. 헤더에 활성 도메인 + ready dot.
// 본체는 AssistChat (Full: seed prompts · multi-turn · history · markdown).

import { AssistChat } from "./AssistChat";

export function CookChefRail({ domain }: { domain: string }) {
  return (
    <aside className="flex h-full flex-col rounded-[10px] border border-slate-200 bg-white p-3 text-sm shadow-sm">
      <header className="mb-2 flex items-center gap-2 border-b border-slate-200 pb-2">
        <span className="text-lg" aria-hidden="true">🧑‍🍳</span>
        <div className="flex flex-col leading-tight">
          <span className="font-semibold text-slate-900">요리선생</span>
          {domain ? (
            <span className="font-mono text-[10px] text-slate-500">· {domain}</span>
          ) : (
            <span className="text-[10px] text-slate-400">도메인 선택 대기</span>
          )}
        </div>
        <span
          className="ml-auto h-2 w-2 rounded-full bg-emerald-500"
          title="ready"
          aria-label="ready"
        />
      </header>
      <div className="flex-1 min-h-0 overflow-hidden">
        <AssistChat note={domain} />
      </div>
    </aside>
  );
}
