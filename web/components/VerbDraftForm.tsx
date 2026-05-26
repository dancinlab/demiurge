"use client";

// Reusable client form for the LLM-using verbs (spec / design / analyze /
// handoff). Each verb supplies its own `verb` id, a few input fields,
// and a description. Prompt construction lives ENTIRELY server-side
// (lib/prompts.ts) — this component only ships params.

import { useState } from "react";

export type VerbInputField = {
  name: string;
  label: string;
  placeholder?: string;
  rows?: number;
  required?: boolean;
};

export type VerbDraftFormProps = {
  verb: "spec" | "design" | "analyze" | "handoff";
  fields: VerbInputField[];
  /** Frozen params (e.g. domainName, currentGoal) prefilled by server. */
  fixedParams: Record<string, string | null>;
  submitLabel?: string;
  maxOutputTokens?: number;
};

type LlmOk = {
  text: string;
  model: string;
  usage: {
    promptTokens: number;
    candidateTokens: number;
    totalTokens: number;
  };
};

export function VerbDraftForm(props: VerbDraftFormProps) {
  const [values, setValues] = useState<Record<string, string>>(
    Object.fromEntries(props.fields.map((f) => [f.name, ""]))
  );
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<LlmOk | null>(null);
  const [error, setError] = useState<string | null>(null);

  function setField(name: string, v: string) {
    setValues((prev) => ({ ...prev, [name]: v }));
  }

  function missingRequired(): string | null {
    for (const f of props.fields) {
      if (f.required !== false && values[f.name].trim().length === 0) {
        return f.label;
      }
    }
    return null;
  }

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    const missing = missingRequired();
    if (missing) {
      setError(`필수 입력 누락: ${missing}`);
      return;
    }
    setLoading(true);
    setError(null);
    setResult(null);
    try {
      const params: Record<string, string | null> = {
        ...props.fixedParams,
        ...values,
      };
      const res = await fetch("/api/llm", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          verb: props.verb,
          params,
          maxOutputTokens: props.maxOutputTokens ?? 2048,
        }),
      });
      const data = (await res.json()) as LlmOk | { error: string };
      if (!res.ok || "error" in data) {
        setError("error" in data ? data.error : `http ${res.status}`);
      } else {
        setResult(data);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="space-y-4">
      <form onSubmit={submit} className="space-y-3">
        {props.fields.map((f) => (
          <div key={f.name}>
            <label className="block text-xs text-neutral-500">{f.label}</label>
            <textarea
              value={values[f.name]}
              onChange={(e) => setField(f.name, e.target.value)}
              rows={f.rows ?? 4}
              placeholder={f.placeholder}
              disabled={loading}
              className="mt-1 w-full rounded border border-neutral-300 bg-white p-2 font-mono text-sm dark:border-neutral-700 dark:bg-neutral-950"
            />
          </div>
        ))}
        <div className="flex items-center gap-3">
          <button
            type="submit"
            disabled={loading}
            className="rounded bg-neutral-900 px-3 py-1 text-sm text-white disabled:opacity-40 dark:bg-neutral-100 dark:text-neutral-900"
          >
            {loading
              ? "Gemini 호출 중..."
              : (props.submitLabel ?? "draft 받기")}
          </button>
          <span className="text-xs text-neutral-500">
            모델: gemini-2.5-flash · server-side 호출 (token 노출 없음)
          </span>
        </div>
      </form>

      {error && (
        <div className="rounded border border-red-300 bg-red-50 p-3 text-sm text-red-900 dark:border-red-800 dark:bg-red-950/40 dark:text-red-200">
          <p className="font-semibold">실패</p>
          <pre className="mt-1 whitespace-pre-wrap text-xs">{error}</pre>
        </div>
      )}

      {result && (
        <div className="space-y-2">
          <div className="rounded border border-neutral-200 bg-neutral-50 p-3 dark:border-neutral-800 dark:bg-neutral-900">
            <p className="mb-1 text-xs text-neutral-500">
              Gemini draft (검수 필요 · 자동 적용 안 됨)
            </p>
            <pre className="overflow-x-auto whitespace-pre-wrap text-sm">
              {result.text || "(빈 응답 — maxOutputTokens 초과 가능)"}
            </pre>
          </div>
          <p className="text-xs text-neutral-500">
            usage: prompt={result.usage.promptTokens} · candidate=
            {result.usage.candidateTokens} · total={result.usage.totalTokens}
            {result.usage.totalTokens >
              result.usage.promptTokens + result.usage.candidateTokens &&
              " (reasoning 토큰 포함)"}
          </p>
        </div>
      )}
    </div>
  );
}
