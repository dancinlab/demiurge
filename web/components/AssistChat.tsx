"use client";

// Right-rail LLM chat (Gemini draft assist). Posts { prompt } to /api/llm,
// renders { text }. Drafts only — verify stays deterministic (0 LLM verdicts).
// Mono / Terminal tone.

import { useRef, useState } from "react";
import { Send, Loader2 } from "lucide-react";

type Msg = { role: "user" | "assistant"; text: string };

export function AssistChat({ note }: { note: string }) {
  const [msgs, setMsgs] = useState<Msg[]>([]);
  const [input, setInput] = useState("");
  const [busy, setBusy] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  async function send() {
    const prompt = input.trim();
    if (!prompt || busy) return;
    setInput("");
    setMsgs((m) => [...m, { role: "user", text: prompt }]);
    setBusy(true);
    try {
      const res = await fetch("/api/llm", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ prompt }),
      });
      const data = (await res.json()) as { text?: string; error?: string };
      setMsgs((m) => [
        ...m,
        { role: "assistant", text: data.text ?? `⚠ ${data.error ?? "no response"}` },
      ]);
    } catch (e) {
      setMsgs((m) => [
        ...m,
        { role: "assistant", text: `⚠ ${e instanceof Error ? e.message : String(e)}` },
      ]);
    } finally {
      setBusy(false);
      requestAnimationFrame(() =>
        scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight })
      );
    }
  }

  return (
    <aside className="flex h-full flex-col border-r border-neutral-300 dark:border-neutral-700">
      <div className="border-b border-neutral-200 px-4 py-3 text-[11px] uppercase tracking-wider text-neutral-500 dark:border-neutral-800">
        assist · gemini
      </div>

      <div ref={scrollRef} className="flex-1 space-y-3 overflow-y-auto p-4">
        {msgs.length === 0 ? (
          <p className="text-[11px] leading-relaxed text-neutral-400">{note}</p>
        ) : (
          msgs.map((mm, i) => (
            <div
              key={i}
              className={
                "rounded border p-2.5 text-xs leading-relaxed " +
                (mm.role === "user"
                  ? "border-neutral-300 bg-neutral-50 dark:border-neutral-700 dark:bg-neutral-900"
                  : "border-neutral-200 dark:border-neutral-800")
              }
            >
              <div className="mb-1 text-[9px] uppercase tracking-[0.2em] text-neutral-400">
                {mm.role}
              </div>
              <div className="whitespace-pre-wrap">{mm.text}</div>
            </div>
          ))
        )}
      </div>

      <div className="border-t border-neutral-200 p-3 dark:border-neutral-800">
        <div className="flex items-end gap-2">
          <textarea
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                send();
              }
            }}
            rows={2}
            placeholder="ask…  (Enter to send)"
            className="min-h-0 flex-1 resize-none rounded border border-neutral-300 bg-white p-2 font-mono text-xs text-neutral-900 focus:border-neutral-900 focus:outline-none dark:border-neutral-700 dark:bg-neutral-950 dark:text-neutral-100 dark:focus:border-neutral-100"
          />
          <button
            onClick={send}
            disabled={busy || !input.trim()}
            aria-label="send"
            className="flex h-9 w-9 shrink-0 cursor-pointer items-center justify-center rounded border border-neutral-900 bg-neutral-900 text-white disabled:opacity-30 dark:border-neutral-100 dark:bg-neutral-100 dark:text-neutral-900"
          >
            {busy ? <Loader2 size={15} className="animate-spin" /> : <Send size={15} />}
          </button>
        </div>
      </div>
    </aside>
  );
}
