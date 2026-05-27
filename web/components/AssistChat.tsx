"use client";

// AssistChat — 요리선생 chat surface. shadcn Modern 톤.
// Full: seed prompts (활성 도메인 인식) · multi-turn context · 도메인별
// localStorage history · lightweight inline markdown.
// All UI strings + persona come as i18n props (5 locales) — no hardcoded text.
//
// POSTs { prompt } to /api/llm where `prompt` is a serialized transcript
// (PERSONA + history + current) — server signature unchanged.

import { useEffect, useRef, useState } from "react";
import { Send, Loader2, Trash2 } from "lucide-react";

type Msg = { role: "user" | "assistant"; text: string; ts: number };

export type ChatI18n = {
  greeting: string;
  placeholder: string;
  send: string;
  clear: string;
  thinking: string;
  seedSpec: string; // "{domain}" template token
  seedStructure: string;
  seedVerify: string;
  seedSimilar: string;
  seedNewDiscover: string;
  seedSpecHowto: string;
  seedRef: string;
};

const MAX_HISTORY = 20;

function storageKey(domain: string): string {
  return `demiurge.chat.${domain || "_global"}`;
}

function loadHistory(domain: string): Msg[] {
  if (typeof window === "undefined") return [];
  try {
    const raw = localStorage.getItem(storageKey(domain));
    if (!raw) return [];
    const arr = JSON.parse(raw);
    if (!Array.isArray(arr)) return [];
    return arr.slice(-MAX_HISTORY);
  } catch {
    return [];
  }
}

function saveHistory(domain: string, msgs: Msg[]): void {
  if (typeof window === "undefined") return;
  try {
    localStorage.setItem(storageKey(domain), JSON.stringify(msgs.slice(-MAX_HISTORY)));
  } catch {
    /* quota / disabled storage — silently drop */
  }
}

// Persona prepended to every request. Localized response language is enforced
// by the `locale` line so 요리선생 replies in the user's UI language.
function persona(locale: string): string {
  return [
    'You are demiurge "요리선생", a friendly, concise assistant.',
    "demiurge is an AI-native 8-verb technical-design pipeline:",
    "discover → spec → structure → design → analyze → synth → verify → handoff.",
    "Help the user diverge / specify / structure / analyze / synthesize / verify / hand off domains.",
    "Keep code identifiers · domain names · paths verbatim. Don't guess; say so if unsure.",
    `Always reply in the user's UI language (locale=${locale}).`,
  ].join("\n");
}

function seedPrompts(domain: string, i18n: ChatI18n): string[] {
  if (domain) {
    return [
      i18n.seedSpec.replace("{domain}", domain),
      i18n.seedStructure.replace("{domain}", domain),
      i18n.seedVerify.replace("{domain}", domain),
      i18n.seedSimilar.replace("{domain}", domain),
    ];
  }
  return [i18n.seedNewDiscover, i18n.seedSpecHowto, i18n.seedRef];
}

function buildPrompt(
  locale: string,
  domain: string,
  history: Msg[],
  current: string,
): string {
  const lines: string[] = [persona(locale)];
  if (domain) lines.push(`Active domain: ${domain}`);
  if (history.length > 0) {
    lines.push("", "Conversation so far:");
    for (const m of history.slice(-MAX_HISTORY)) {
      lines.push(`${m.role === "user" ? "User" : "요리선생"}: ${m.text}`);
    }
  }
  lines.push("", `User: ${current}`, "요리선생:");
  return lines.join("\n");
}

// Lightweight markdown subset (no deps): ```block``` · **bold** · `code` · 줄바꿈.
function renderInline(s: string): React.ReactNode[] {
  const nodes: React.ReactNode[] = [];
  const re = /\*\*([^*]+)\*\*|`([^`]+)`/g;
  let last = 0;
  let m: RegExpExecArray | null;
  let key = 0;
  while ((m = re.exec(s)) !== null) {
    if (m.index > last) nodes.push(s.slice(last, m.index));
    if (m[1]) nodes.push(<strong key={`b-${key++}`}>{m[1]}</strong>);
    else if (m[2])
      nodes.push(
        <code key={`c-${key++}`} className="rounded bg-slate-100 px-1 font-mono text-[11px]">
          {m[2]}
        </code>,
      );
    last = re.lastIndex;
  }
  if (last < s.length) nodes.push(s.slice(last));
  return nodes;
}

function renderMarkdown(s: string): React.ReactElement[] {
  const out: React.ReactElement[] = [];
  const parts = s.split(/```([\s\S]*?)```/);
  parts.forEach((part, i) => {
    if (i % 2 === 1) {
      out.push(
        <pre
          key={`code-${i}`}
          className="my-1 overflow-auto rounded-[6px] bg-slate-900 px-2 py-1.5 font-mono text-[11px] text-slate-100"
        >
          {part.trim()}
        </pre>,
      );
    } else {
      const lines = part.split("\n");
      lines.forEach((ln, j) => {
        out.push(<span key={`ln-${i}-${j}`}>{renderInline(ln)}</span>);
        if (j < lines.length - 1) out.push(<br key={`br-${i}-${j}`} />);
      });
    }
  });
  return out;
}

export function AssistChat({
  note: domain,
  i18n,
  locale,
}: {
  note: string;
  i18n: ChatI18n;
  locale: string;
}) {
  const [msgs, setMsgs] = useState<Msg[]>([]);
  const [input, setInput] = useState("");
  const [busy, setBusy] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setMsgs(loadHistory(domain));
  }, [domain]);

  function persist(next: Msg[]): void {
    setMsgs(next);
    saveHistory(domain, next);
  }

  async function send(textOverride?: string): Promise<void> {
    const prompt = (textOverride ?? input).trim();
    if (!prompt || busy) return;
    setInput("");
    const userMsg: Msg = { role: "user", text: prompt, ts: Date.now() };
    const afterUser = [...msgs, userMsg];
    persist(afterUser);
    setBusy(true);
    try {
      const fullPrompt = buildPrompt(locale, domain, msgs, prompt);
      const res = await fetch("/api/llm", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ prompt: fullPrompt }),
      });
      const data = (await res.json()) as { text?: string; error?: string };
      const reply: Msg = {
        role: "assistant",
        text: data.text ?? `⚠ ${data.error ?? "no response"}`,
        ts: Date.now(),
      };
      persist([...afterUser, reply]);
    } catch (e) {
      const reply: Msg = {
        role: "assistant",
        text: `⚠ ${e instanceof Error ? e.message : String(e)}`,
        ts: Date.now(),
      };
      persist([...afterUser, reply]);
    } finally {
      setBusy(false);
      requestAnimationFrame(() =>
        scrollRef.current?.scrollTo({ top: scrollRef.current.scrollHeight }),
      );
    }
  }

  function clear(): void {
    if (typeof window !== "undefined") localStorage.removeItem(storageKey(domain));
    setMsgs([]);
  }

  function onKeyDown(e: React.KeyboardEvent<HTMLTextAreaElement>): void {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      void send();
    }
  }

  return (
    <div className="flex h-full min-h-0 flex-col gap-2">
      {/* Transcript */}
      <div ref={scrollRef} className="flex-1 space-y-2 overflow-auto pr-0.5">
        {msgs.length === 0 ? (
          <div className="space-y-2 py-1">
            <p className="text-xs text-slate-500">{i18n.greeting}</p>
            <div className="flex flex-wrap gap-1.5">
              {seedPrompts(domain, i18n).map((sp, i) => (
                <button
                  key={i}
                  onClick={() => void send(sp)}
                  className="rounded-full bg-slate-100 px-3 py-1 text-[11px] text-slate-700 hover:bg-slate-200"
                >
                  {sp}
                </button>
              ))}
            </div>
          </div>
        ) : (
          msgs.map((m, i) => (
            <div
              key={`${m.ts}-${i}`}
              className={[
                "rounded-[10px] px-3 py-2 text-[12px] leading-relaxed",
                m.role === "user"
                  ? "ml-auto max-w-[85%] bg-slate-900 text-white"
                  : "mr-auto max-w-[95%] bg-slate-50 text-slate-900",
              ].join(" ")}
            >
              {m.role === "assistant" ? renderMarkdown(m.text) : m.text}
            </div>
          ))
        )}
        {busy && (
          <div className="mr-auto inline-flex items-center gap-1.5 rounded-[10px] bg-slate-50 px-3 py-2 text-[11px] text-slate-500">
            <Loader2 className="h-3 w-3 animate-spin" /> {i18n.thinking}
          </div>
        )}
      </div>

      {/* Input */}
      <div className="space-y-1.5">
        <textarea
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={onKeyDown}
          placeholder={i18n.placeholder}
          disabled={busy}
          rows={2}
          className="w-full resize-none rounded-[10px] border border-slate-200 bg-white px-2.5 py-1.5 text-[12px] text-slate-900 placeholder:text-slate-400 focus:border-slate-400 focus:outline-none disabled:opacity-60"
        />
        <div className="flex items-center justify-between">
          <button
            onClick={clear}
            disabled={busy || msgs.length === 0}
            className="inline-flex items-center gap-1 text-[10px] text-slate-400 hover:text-slate-700 disabled:opacity-30"
            title={i18n.clear}
          >
            <Trash2 className="h-3 w-3" /> {i18n.clear}
          </button>
          <button
            onClick={() => void send()}
            disabled={busy || !input.trim()}
            className="inline-flex items-center gap-1 rounded-[6px] bg-slate-900 px-3 py-1 text-[11px] font-medium text-white hover:bg-slate-800 disabled:opacity-50"
          >
            {busy ? <Loader2 className="h-3 w-3 animate-spin" /> : <Send className="h-3 w-3" />}
            {i18n.send}
          </button>
        </div>
      </div>
    </div>
  );
}
