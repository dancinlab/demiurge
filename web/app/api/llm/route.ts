// POST /api/llm — Vertex AI Gemini proxy.
//
// Two request shapes (verb+params preferred — keeps prompts SSOT-side):
//   { "verb": "spec", "params": { "domainName": "X", "currentGoal": null, "hint": "..." } }
//   { "prompt": "raw text", "verb"?: "spec" }
//
// Resp: { "text", "model", "usage": { ... } }
//
// XPRIZE constraint: only Gemini may be invoked from the deployed app.

import { generateText } from "@/lib/gemini";
import {
  specDraftPrompt,
  designDraftPrompt,
  analyzeSummaryPrompt,
  handoffNarrativePrompt,
} from "@/lib/prompts";

const VERBS_WITH_LLM = new Set([
  "spec",
  "design",
  "analyze",
  "handoff",
  "discover",
]);

type Body = {
  prompt?: unknown;
  verb?: unknown;
  params?: unknown;
  model?: unknown;
  temperature?: unknown;
  maxOutputTokens?: unknown;
};

function buildPromptFromParams(verb: string, params: unknown): string | null {
  if (typeof params !== "object" || params === null) return null;
  const p = params as Record<string, unknown>;
  const str = (k: string): string =>
    typeof p[k] === "string" ? (p[k] as string) : "";
  const strOrNull = (k: string): string | null =>
    typeof p[k] === "string" ? (p[k] as string) : null;

  switch (verb) {
    case "spec":
      return specDraftPrompt({
        domainName: str("domainName"),
        currentGoal: strOrNull("currentGoal"),
        hint: str("hint"),
      });
    case "design":
      return designDraftPrompt({
        domainName: str("domainName"),
        question: str("question"),
      });
    case "analyze":
      return analyzeSummaryPrompt({
        domainName: str("domainName"),
        rounds: str("rounds"),
      });
    case "handoff":
      return handoffNarrativePrompt({
        domainName: str("domainName"),
        packet: str("packet"),
      });
    default:
      return null;
  }
}

export async function POST(request: Request) {
  let body: Body;
  try {
    body = (await request.json()) as Body;
  } catch {
    return Response.json({ error: "invalid JSON body" }, { status: 400 });
  }

  const verb = typeof body.verb === "string" ? body.verb : null;
  if (verb && !VERBS_WITH_LLM.has(verb)) {
    return Response.json(
      { error: `verb '${verb}' must not call LLM (g5 or deterministic)` },
      { status: 403 }
    );
  }

  // Resolve prompt: prefer (verb + params), fall back to raw prompt.
  let prompt: string | null = null;
  if (verb && body.params !== undefined) {
    prompt = buildPromptFromParams(verb, body.params);
    if (prompt === null) {
      return Response.json(
        { error: `verb '${verb}' params missing or wrong shape` },
        { status: 400 }
      );
    }
  } else if (typeof body.prompt === "string" && body.prompt.trim().length > 0) {
    prompt = body.prompt;
  } else {
    return Response.json(
      { error: "either {verb, params} or {prompt} required" },
      { status: 400 }
    );
  }

  if (prompt.length > 32_000) {
    return Response.json({ error: "prompt too large (>32K chars)" }, { status: 413 });
  }

  try {
    const result = await generateText({
      prompt,
      model: typeof body.model === "string" ? body.model : undefined,
      temperature:
        typeof body.temperature === "number" ? body.temperature : undefined,
      maxOutputTokens:
        typeof body.maxOutputTokens === "number"
          ? body.maxOutputTokens
          : undefined,
    });
    return Response.json(result);
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    const status =
      msg.includes("auth unavailable") || msg.includes("project unset")
        ? 503
        : 500;
    return Response.json({ error: msg }, { status });
  }
}
