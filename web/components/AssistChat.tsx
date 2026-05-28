"use client";

// AssistChat — DEMI chat surface. ElevenLabs 톤 (토큰 SSOT 소비).
// Full: seed prompts (활성 도메인 인식) · multi-turn context · 도메인별
// localStorage history · lightweight inline markdown.
// All UI strings + persona come as i18n props (5 locales) — no hardcoded text.
//
// POSTs { prompt } to /api/llm where `prompt` is a serialized transcript
// (PERSONA + history + current) — server signature unchanged.

import { useEffect, useRef, useState } from "react";
import { Send, Loader2, Trash2 } from "lucide-react";
import { AnimatePresence, motion } from "motion/react";
import { useEffectiveReducedMotion } from "@/lib/motion";

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
// by the `locale` line so DEMI replies in the user's UI language.
function persona(locale: string): string {
  return [
    'You are demiurge "DEMI", a friendly, concise assistant.',
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
  // Skip transient error bubbles (⚠ …) — feeding them back as context made
  // the model parrot the error (e.g. "set GCP_PROJECT") instead of answering.
  const clean = history
    .slice(-MAX_HISTORY)
    .filter((m) => !(m.role === "assistant" && m.text.startsWith("⚠")));
  if (clean.length > 0) {
    lines.push("", "Conversation so far:");
    for (const m of clean) {
      lines.push(`${m.role === "user" ? "User" : "DEMI"}: ${m.text}`);
    }
  }
  lines.push("", `User: ${current}`, "DEMI:");
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
        <code key={`c-${key++}`} className="rounded-tag bg-surface-strong px-1 font-mono text-[11px]">
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
          className="my-1 overflow-auto rounded-chip bg-inverted px-2 py-1.5 font-mono text-[11px] text-on-inverted"
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
  // 모션 정책 = lib/motion 의 RESPECT_REDUCED_MOTION 단일 토글에 위임.
  const reduced = useEffectiveReducedMotion();

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
      if (data.text) {
        // success — persist so it joins multi-turn context
        persist([...afterUser, { role: "assistant", text: data.text, ts: Date.now() }]);
      } else {
        // error — show on screen but DON'T persist (transient · keeps the
        // model's future context clean so it never parrots the error back)
        setMsgs([
          ...afterUser,
          { role: "assistant", text: `⚠ ${data.error ?? "no response"}`, ts: Date.now() },
        ]);
      }
    } catch (e) {
      setMsgs([
        ...afterUser,
        {
          role: "assistant",
          text: `⚠ ${e instanceof Error ? e.message : String(e)}`,
          ts: Date.now(),
        },
      ]);
    } finally {
      setBusy(false);
      // 최신이 맨 위 — 위로 스크롤
      requestAnimationFrame(() => scrollRef.current?.scrollTo({ top: 0 }));
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
      {/* Input — 상단 */}
      <div className="space-y-1.5">
        <textarea
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={onKeyDown}
          placeholder={i18n.placeholder}
          disabled={busy}
          rows={2}
          className="w-full resize-none rounded-control border border-hairline bg-surface px-2.5 py-1.5 text-[12px] text-ink placeholder:text-muted-soft focus:border-hairline-strong focus:outline-none disabled:opacity-60"
        />
        <div className="flex items-center justify-between">
          <button
            onClick={clear}
            disabled={busy || msgs.length === 0}
            className="inline-flex items-center gap-1 text-[10px] text-muted-soft hover:text-body disabled:opacity-30"
            title={i18n.clear}
          >
            <Trash2 className="h-3 w-3" /> {i18n.clear}
          </button>
          <button
            onClick={() => void send()}
            disabled={busy || !input.trim()}
            className="inline-flex items-center gap-1 rounded-full bg-primary px-3 py-1 text-[11px] font-medium text-on-primary hover:bg-primary-active disabled:opacity-50"
          >
            {busy ? (
              <motion.span
                className="inline-flex"
                animate={reduced ? undefined : { rotate: 360 }}
                transition={reduced ? undefined : { duration: 0.8, ease: "linear", repeat: Infinity }}
              >
                <Loader2 className="h-3 w-3" />
              </motion.span>
            ) : (
              <Send className="h-3 w-3" />
            )}
            {i18n.send}
          </button>
        </div>
      </div>

      {/* Transcript — 하단 */}
      {/* 입력이 상단이므로 메시지도 역순 — 최신이 맨 위(입력 바로 아래) */}
      <div ref={scrollRef} className="flex-1 space-y-2 overflow-auto pr-0.5">
        {/* #1 응답 대기 모션 — typing indicator (점 3개 stagger bounce) + 텍스트.
            데미가 "생각 중"인 시그널. CSS keyframe(demi-typing-dot) + per-dot 지연
            stagger; reduced-motion 에선 globals.css 미디어쿼리가 점을 정지시킨다. */}
        <AnimatePresence>
          {busy && (
            <motion.div
              key="demi-typing"
              initial={reduced ? false : { opacity: 0, y: 4 }}
              animate={{ opacity: 1, y: 0 }}
              exit={reduced ? { opacity: 0 } : { opacity: 0, y: 4 }}
              transition={{ duration: 0.18, ease: [0.23, 1, 0.32, 1] }}
              className="mr-auto inline-flex items-center gap-1.5 rounded-control bg-surface-strong px-3 py-2 text-[11px] text-muted"
              aria-live="polite"
              aria-label={i18n.thinking}
            >
              <span className="inline-flex items-center gap-0.5" aria-hidden="true">
                {[0, 1, 2].map((d) => (
                  <motion.span
                    key={d}
                    className="inline-block h-1 w-1 rounded-full bg-muted"
                    animate={reduced ? undefined : { y: [0, -3, 0], opacity: [0.3, 1, 0.3] }}
                    transition={
                      reduced
                        ? undefined
                        : {
                            duration: 1.2,
                            ease: [0.23, 1, 0.32, 1],
                            repeat: Infinity,
                            delay: d * 0.16,
                          }
                    }
                  />
                ))}
              </span>
              {i18n.thinking}
            </motion.div>
          )}
        </AnimatePresence>
        {msgs.length === 0 ? (
          <div className="space-y-2 py-1">
            <p className="text-xs text-muted">{i18n.greeting}</p>
            <div className="flex flex-wrap gap-1.5">
              {seedPrompts(domain, i18n).map((sp, i) => (
                <button
                  key={i}
                  onClick={() => void send(sp)}
                  className="rounded-full bg-surface-strong px-3 py-1 text-[11px] text-body hover:bg-hairline"
                >
                  {sp}
                </button>
              ))}
            </div>
          </div>
        ) : (
          // #2 메시지 등장 모션 — Motion AnimatePresence + motion.div. 새 말풍선이
          // 역순 리스트 top(입력 바로 아래)에 부드럽게 fade+slide. reduced-motion 이면
          // 전환을 무모션(initial=false)으로 — globals.css .animate-msg-in fallback 도
          // 미디어쿼리로 정지되어 이중 가드. layout 으로 아래 항목들이 자연스레 밀림.
          <AnimatePresence initial={false}>
            {[...msgs].reverse().map((m) => {
              const isError = m.role === "assistant" && m.text.startsWith("⚠");
              return (
                <motion.div
                  key={m.ts}
                  layout={!reduced}
                  initial={reduced ? false : { opacity: 0, y: -8, scale: 0.95 }}
                  animate={{ opacity: 1, y: 0, scale: 1 }}
                  exit={reduced ? { opacity: 0 } : { opacity: 0, scale: 0.96, y: -4 }}
                  transition={
                    reduced
                      ? { duration: 0.15 }
                      : {
                          // 스프링 물리 — 말풍선이 작게 시작해 톡 자리잡음(iMessage 톤).
                          type: "spring",
                          stiffness: 460,
                          damping: 30,
                          mass: 0.8,
                          opacity: { duration: 0.18 },
                        }
                  }
                  className={[
                    "rounded-2xl px-3 py-2 text-[12px] leading-relaxed",
                    // 꼬리 효과 — user 우하단 직각 · assistant 좌하단 직각
                    m.role === "user"
                      ? "ml-auto max-w-[85%] origin-top-right rounded-tr-sm bg-inverted text-on-inverted"
                      : isError
                        ? "mr-auto max-w-[95%] origin-top-left rounded-tl-sm bg-danger/5 text-danger"
                        : "mr-auto max-w-[95%] origin-top-left rounded-tl-sm border border-hairline bg-surface text-ink",
                  ].join(" ")}
                >
                  {m.role === "assistant" && !isError ? renderMarkdown(m.text) : m.text}
                </motion.div>
              );
            })}
          </AnimatePresence>
        )}
      </div>
    </div>
  );
}
