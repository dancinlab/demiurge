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

export type VerbDraftFormI18n = {
  submit: string; // "draft 받기"
  calling: string; // "Gemini 호출 중..."
  modelNote: string; // "모델: gemini-2.5-flash · server-side ..."
  missingRequired: string; // "필수 입력 누락: {field}"
  failed: string; // "실패"
  draftLabel: string; // "Gemini draft (검수 필요 · ...)"
  emptyResp: string; // "(빈 응답 ...)"
  reasoningNote: string; // "(reasoning 토큰 포함)"
  saveToLog: string; // "도메인 로그에 저장"
  saving: string; // "저장 중..."
  saved: string; // "저장됨 → {path}"
  saveFailed: string; // "저장 실패"
};

export type VerbDraftFormProps = {
  verb: "spec" | "design" | "analyze" | "handoff";
  fields: VerbInputField[];
  /** Frozen params (e.g. domainName, currentGoal) prefilled by server. */
  fixedParams: Record<string, string | null>;
  /** Domain name for the save-to-log action (#3 draft persistence). */
  domain?: string;
  i18n: VerbDraftFormI18n;
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
  const { i18n } = props;
  const [values, setValues] = useState<Record<string, string>>(
    Object.fromEntries(props.fields.map((f) => [f.name, ""]))
  );
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<LlmOk | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [saveState, setSaveState] = useState<
    { kind: "idle" } | { kind: "saving" } | { kind: "saved"; path: string } | { kind: "error"; msg: string }
  >({ kind: "idle" });

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

  async function saveDraft() {
    if (!result || !props.domain) return;
    setSaveState({ kind: "saving" });
    try {
      const res = await fetch("/api/domain-log", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          domain: props.domain,
          verb: props.verb,
          text: result.text,
        }),
      });
      const data = (await res.json()) as { logPath?: string; error?: string };
      if (!res.ok || data.error) {
        setSaveState({ kind: "error", msg: data.error ?? `http ${res.status}` });
      } else {
        setSaveState({ kind: "saved", path: data.logPath ?? "" });
      }
    } catch (err) {
      setSaveState({ kind: "error", msg: err instanceof Error ? err.message : String(err) });
    }
  }

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    const missing = missingRequired();
    if (missing) {
      setError(i18n.missingRequired.replace("{field}", missing));
      return;
    }
    setLoading(true);
    setError(null);
    setResult(null);
    setSaveState({ kind: "idle" });
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
            <label className="block text-xs text-muted">{f.label}</label>
            <textarea
              value={values[f.name]}
              onChange={(e) => setField(f.name, e.target.value)}
              rows={f.rows ?? 4}
              placeholder={f.placeholder}
              disabled={loading}
              className="mt-1 w-full rounded-control border border-hairline bg-surface p-2 font-mono text-sm"
            />
          </div>
        ))}
        <div className="flex items-center gap-3">
          <button
            type="submit"
            disabled={loading}
            className="rounded-control bg-primary px-3 py-1 text-sm text-on-primary disabled:opacity-40"
          >
            {loading ? i18n.calling : (props.submitLabel ?? i18n.submit)}
          </button>
          <span className="text-xs text-muted">{i18n.modelNote}</span>
        </div>
      </form>

      {error && (
        <div className="rounded-control bg-danger/10 p-3 text-sm text-danger">
          <p className="font-semibold">{i18n.failed}</p>
          <pre className="mt-1 whitespace-pre-wrap text-xs">{error}</pre>
        </div>
      )}

      {result && (
        <div className="space-y-2">
          <div className="py-1">
            <p className="mb-1 text-xs text-muted">{i18n.draftLabel}</p>
            <pre className="overflow-x-auto whitespace-pre-wrap text-sm text-body-strong">
              {result.text || i18n.emptyResp}
            </pre>
          </div>
          <div className="flex flex-wrap items-center gap-3">
            {props.domain && result.text && (
              <button
                type="button"
                onClick={saveDraft}
                disabled={saveState.kind === "saving"}
                className="rounded-control bg-canvas-soft px-3 py-1 text-xs text-ink hover:bg-surface-strong disabled:opacity-40"
              >
                {saveState.kind === "saving" ? i18n.saving : `⬇ ${i18n.saveToLog}`}
              </button>
            )}
            {saveState.kind === "saved" && (
              <span className="text-xs text-success">
                {i18n.saved.replace("{path}", saveState.path)}
              </span>
            )}
            {saveState.kind === "error" && (
              <span className="text-xs text-danger">
                {i18n.saveFailed} · {saveState.msg}
              </span>
            )}
          </div>
          <p className="text-xs text-muted">
            usage: prompt={result.usage.promptTokens} · candidate=
            {result.usage.candidateTokens} · total={result.usage.totalTokens}
            {result.usage.totalTokens >
              result.usage.promptTokens + result.usage.candidateTokens &&
              ` ${i18n.reasoningNote}`}
          </p>
        </div>
      )}
    </div>
  );
}
