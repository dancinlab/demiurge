// /docs — in-app documentation (surface #5).
//
// (app)/layout.tsx owns the left 8-verb spine + TopBar; this page renders the
// main-area content only. Three sections:
//   1. 8-verb pipeline guide — each verb's one-line role + LLM/CLI kind + an
//      ASCII pipeline diagram. Verb spine + kinds are read from the SSOT
//      (lib/verbs · lib/verb-config) so docs can never drift from the runtime.
//   2. CLI guide — `demiurge cli <verb> <domain>` usage + real example argv
//      that mirror verb-config.ts (structure/synth/verify → `action <verb>
//      <domain>`, discover → free-text seed).
//   3. PAT guide — web ↔ CLI/API auth token overview. Token issuance lives in
//      Account → CLI tab (rolling out); we link there rather than inventing a
//      route that does not exist.
//
// Server component. All copy resolves through messages/*.json `docs.*`
// (en fallback). Semantic tokens only (DESIGN_TOKENS.md SSOT) — no hardcoded
// copy, no gray-*/neutral-*/rounded-[Npx].

import Link from "next/link";
import { getMessages, getLocale, t } from "@/lib/i18n";
import { VERBS, type VerbId } from "@/lib/verbs";
import { VERB_CONFIG } from "@/lib/verb-config";
import { Section } from "@/components/ui/Section";

export const dynamic = "force-dynamic";

// Locale verb labels (hybrid: locale label + canonical verb) — same single
// source convention as the dashboard / VerbTreeNav. en uses the canonical verb
// verbatim, so no entry → falls back to v.label.
const VERB_LABELS: Record<string, Partial<Record<VerbId, string>>> = {
  ko: { discover: "발견", spec: "사양", structure: "구조", design: "설계", analyze: "분석", synth: "합성", verify: "검증", handoff: "인계" },
  ja: { discover: "発見", spec: "仕様", structure: "構造", design: "設計", analyze: "分析", synth: "合成", verify: "検証", handoff: "引継ぎ" },
  ru: { discover: "поиск", spec: "спец", structure: "структура", design: "дизайн", analyze: "анализ", synth: "синтез", verify: "проверка", handoff: "передача" },
  zh: { discover: "发现", spec: "规格", structure: "结构", design: "设计", analyze: "分析", synth: "合成", verify: "验证", handoff: "交接" },
};

// ASCII pipeline diagram — discover head feeds the 7-verb spine; the ⟲ marks
// the analyze iterate-until-converged loop. Pure presentation; verb tokens are
// the canonical labels (locale-independent in the diagram for alignment).
const PIPELINE_DIAGRAM = `discover
   │
   ▼
spec → structure → design → analyze ⟲ → synthesize → verify → handoff`;

// A small code/command block — 옵션 H · 평면(배경/라운딩 0). mono + 좌측 여백만.
function CodeLine({ children }: { children: React.ReactNode }) {
  return (
    <code className="block overflow-x-auto whitespace-pre py-1 font-mono text-[12px] leading-relaxed text-body-strong">
      {children}
    </code>
  );
}

// SectionCard — 재설계 후 — 테두리 없이 헤딩 + 공간만으로 chapter 구분.
// (docs 3섹션은 main 영역 안에서 큰 chapter — 평면 위 chapter 위계).
// 헤딩 = `components/ui/Section` SSOT 로 위임(H 패턴 자동 적용).
// 외곽 <section id=..> 는 toc 앵커(#pipeline · #cli · #pat) 점프 타깃이라 유지.
function SectionCard({
  id,
  title,
  children,
}: {
  id: string;
  title: string;
  children: React.ReactNode;
}) {
  return (
    <section id={id} className="scroll-mt-6">
      <Section as="div" title={title} bodyClassName="mt-2 space-y-4">
        {children}
      </Section>
    </section>
  );
}

export default async function DocsPage() {
  const [messages, locale] = await Promise.all([getMessages(), getLocale()]);

  // Resolve the per-verb description + canonical/locale label once.
  const verbRows = VERBS.map((v) => {
    const kind = VERB_CONFIG[v.id].kind; // "llm" | "cli"
    return {
      id: v.id,
      canon: v.label,
      label: VERB_LABELS[locale]?.[v.id] ?? v.label,
      what: t(messages, `docs.verb_${v.id}`),
      kindLabel:
        kind === "llm"
          ? t(messages, "docs.pipeline_kind_llm")
          : t(messages, "docs.pipeline_kind_cli"),
      isLlm: kind === "llm",
    };
  });

  // CLI examples — argv mirrors verb-config.ts buildArgs so the docs match the
  // real allowlisted invocations (structure/synth/verify → `action <verb>
  // <domain>`; discover takes a free-text seed). Rendered as `demiurge cli …`.
  const cliExamples = [
    {
      key: "discover",
      desc: t(messages, "docs.cli_ex_discover"),
      cmd: 'demiurge cli discover "high-Tc ambient-pressure RTSC"',
    },
    {
      key: "structure",
      desc: t(messages, "docs.cli_ex_structure"),
      cmd: "demiurge cli action structure rtsc",
    },
    {
      key: "synth",
      desc: t(messages, "docs.cli_ex_synth"),
      cmd: "demiurge cli action synth rtsc",
    },
    {
      key: "verify",
      desc: t(messages, "docs.cli_ex_verify"),
      cmd: "demiurge cli action verify rtsc",
    },
  ];

  return (
    <div className="mx-auto max-w-3xl space-y-8">
      {/* ── header ───────────────────────────────────────────────────────── */}
      <header className="space-y-3">
        <h1 className="font-display text-3xl font-light tracking-tight text-ink">
          {t(messages, "docs.title")}
        </h1>
        <p className="max-w-prose text-sm text-muted">
          {t(messages, "docs.subtitle")}
        </p>
        <nav className="flex flex-wrap gap-2 text-xs">
          <span className="text-[11px] font-semibold uppercase tracking-wide text-muted">
            {t(messages, "docs.toc_heading")}:
          </span>
          <a href="#pipeline" className="text-body hover:text-ink hover:underline">
            {t(messages, "docs.pipeline_heading")}
          </a>
          <span className="text-muted-soft">·</span>
          <a href="#cli" className="text-body hover:text-ink hover:underline">
            {t(messages, "docs.cli_heading")}
          </a>
          <span className="text-muted-soft">·</span>
          <a href="#pat" className="text-body hover:text-ink hover:underline">
            {t(messages, "docs.pat_heading")}
          </a>
        </nav>
      </header>

      {/* ── 1. 8-verb pipeline ───────────────────────────────────────────── */}
      <SectionCard id="pipeline" title={t(messages, "docs.pipeline_heading")}>
        <p className="max-w-prose text-sm text-muted">
          {t(messages, "docs.pipeline_intro")}
        </p>

        <pre className="overflow-x-auto py-2 text-center font-mono text-[12px] leading-relaxed text-body-strong">
          {PIPELINE_DIAGRAM}
        </pre>

        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead>
              <tr className="border-b border-hairline text-[11px] uppercase tracking-wide text-muted">
                <th className="px-3 py-2 font-semibold">
                  {t(messages, "docs.pipeline_col_verb")}
                </th>
                <th className="px-3 py-2 font-semibold">
                  {t(messages, "docs.pipeline_col_kind")}
                </th>
                <th className="px-3 py-2 font-semibold">
                  {t(messages, "docs.pipeline_col_what")}
                </th>
              </tr>
            </thead>
            <tbody>
              {verbRows.map((r) => (
                <tr key={r.id} className="border-b border-hairline last:border-0">
                  <td className="px-3 py-2 align-top">
                    <span className="flex items-baseline gap-1.5">
                      <span className="font-medium text-ink">{r.label}</span>
                      {r.label !== r.canon && (
                        <span className="font-mono text-[10px] text-muted-soft">
                          {r.canon}
                        </span>
                      )}
                    </span>
                  </td>
                  <td className="px-3 py-2 align-top">
                    <span
                      className={
                        "font-mono text-[10px] " +
                        (r.isLlm
                          ? "rounded-chip bg-inverted px-1.5 py-0.5 text-on-primary"
                          : "text-body")
                      }
                    >
                      {r.kindLabel}
                    </span>
                  </td>
                  <td className="px-3 py-2 align-top text-muted">{r.what}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </SectionCard>

      {/* ── 2. CLI guide ─────────────────────────────────────────────────── */}
      <SectionCard id="cli" title={t(messages, "docs.cli_heading")}>
        <p className="max-w-prose text-sm text-muted">
          {t(messages, "docs.cli_intro")}
        </p>

        {/* install — Section SSOT 로 헤딩 (H 패턴 자동 적용). */}
        <Section title={t(messages, "docs.cli_install_heading")} bodyClassName="mt-2 space-y-2">
          <p className="text-[13px] text-muted">
            {t(messages, "docs.cli_install_note")}
          </p>
          <CodeLine>
            {'/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dancinlab/hexa-lang/main/install.sh)"\nhx install demiurge'}
          </CodeLine>
        </Section>

        {/* authenticate */}
        <Section title={t(messages, "docs.cli_auth_heading")} bodyClassName="mt-2 space-y-2">
          <p className="text-[13px] text-muted">
            {t(messages, "docs.cli_auth_note")}
          </p>
          <CodeLine>demiurge auth login --token &lt;DEMIURGE_PAT&gt;</CodeLine>
        </Section>

        {/* invoke */}
        <Section title={t(messages, "docs.cli_invoke_heading")} bodyClassName="mt-2 space-y-2">
          <p className="text-[13px] text-muted">
            {t(messages, "docs.cli_invoke_note")}
          </p>
          <p className="text-[11px] uppercase tracking-wide text-muted-soft">
            {t(messages, "docs.cli_form_label")}
          </p>
          <CodeLine>demiurge cli &lt;verb&gt; &lt;domain&gt;</CodeLine>
          <p className="text-[11px] uppercase tracking-wide text-muted-soft">
            {t(messages, "docs.cli_example_label")}
          </p>
          <div className="space-y-3">
            {cliExamples.map((ex) => (
              <div key={ex.key} className="space-y-1">
                <p className="text-[12px] text-muted">{ex.desc}</p>
                <CodeLine>{ex.cmd}</CodeLine>
              </div>
            ))}
          </div>
        </Section>
      </SectionCard>

      {/* ── 3. PAT guide ─────────────────────────────────────────────────── */}
      <SectionCard id="pat" title={t(messages, "docs.pat_heading")}>
        <p className="max-w-prose text-sm text-muted">
          {t(messages, "docs.pat_intro")}
        </p>
        <ol className="ml-5 list-decimal space-y-2 text-[13px] text-muted">
          <li>{t(messages, "docs.pat_step_issue")}</li>
          <li>{t(messages, "docs.pat_step_store")}</li>
          <li>{t(messages, "docs.pat_step_use")}</li>
        </ol>
        <p className="max-w-prose py-1 text-[12px] text-body">
          {t(messages, "docs.pat_security_note")}
        </p>
        <Link
          href="/account?tab=cli"
          className="inline-flex items-center gap-1.5 rounded-control bg-inverted px-4 py-2 text-sm font-medium text-on-primary transition hover:opacity-90"
        >
          {t(messages, "docs.pat_open_account")}
        </Link>
      </SectionCard>
    </div>
  );
}
