// CookChefRail — Q9 항상 펼침 🧑‍🍳 AI 요리선생 좌측 ② 컬럼.
// Thin client wrapper over existing AssistChat — preserves Gemini call chain.

import { AssistChat } from "./AssistChat";

export function CookChefRail({ domain }: { domain: string }) {
  return (
    <aside className="flex h-full flex-col rounded border border-neutral-300 bg-white p-3 text-sm dark:border-neutral-700 dark:bg-neutral-900">
      <header className="mb-2 flex items-center gap-2 border-b border-neutral-200 pb-2 dark:border-neutral-800">
        <span className="text-lg">🧑‍🍳</span>
        <span className="font-bold">요리선생</span>
        <span className="ml-auto text-xs text-neutral-500">always on</span>
      </header>
      <div className="flex-1 overflow-auto">
        <AssistChat note={domain} />
      </div>
    </aside>
  );
}
