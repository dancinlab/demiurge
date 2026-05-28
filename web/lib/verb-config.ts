// verb-config — SINGLE SSOT for how each verb's execution panel behaves.
//
// #2 base pattern: VerbWorkspace consumes one `VerbConfig` and renders the
// right execution panel (LLM draft form OR CLI stream runner) next to the
// live viewer slot. #4 (per-verb finishing) only needs to flesh out the
// config entries here — no new components, no new wiring.
//
// d4 single generic dispatch: there is exactly ONE config table; adding /
// tuning a verb is a data edit, never a new code path.
//
// Two execution kinds:
//   - "llm"  → VerbDraftForm  (spec · design · analyze · handoff) → POST /api/llm
//   - "cli"  → VerbRunStream  (structure · synth · verify · discover) → /api/stream SSE
//
// This module is pure data (no React import) so both server (VerbShell) and
// client (VerbWorkspace) can import it.

import type { VerbId } from "@/lib/verbs";
import type { VerbInputField } from "@/components/VerbDraftForm";

export type LlmVerbConfig = {
  kind: "llm";
  /** must match VerbDraftForm's verb union (spec | design | analyze | handoff). */
  verb: "spec" | "design" | "analyze" | "handoff";
  fields: VerbInputField[];
  maxOutputTokens?: number;
};

export type CliVerbConfig = {
  kind: "cli";
  /**
   * Build the allowlisted CLI argv for /api/stream from the domain name.
   * First element MUST be in the route allowlist (see app/api/stream/route.ts).
   */
  buildArgs: (domain: string) => string[];
};

export type VerbConfig = LlmVerbConfig | CliVerbConfig;

// ── LLM verbs ─────────────────────────────────────────────────────────────
// fields[].label is an i18n KEY (resolved by VerbWorkspace via the label map),
// not literal copy, so the form stays multilingual. fixedParams (domainName,
// currentGoal) are injected server-side by VerbShell.

const SPEC: LlmVerbConfig = {
  kind: "llm",
  verb: "spec",
  maxOutputTokens: 1024,
  fields: [{ name: "hint", label: "field_spec_hint", rows: 4, required: true }],
};

const DESIGN: LlmVerbConfig = {
  kind: "llm",
  verb: "design",
  maxOutputTokens: 1536,
  fields: [{ name: "question", label: "field_design_question", rows: 4, required: true }],
};

const ANALYZE: LlmVerbConfig = {
  kind: "llm",
  verb: "analyze",
  maxOutputTokens: 1536,
  fields: [{ name: "rounds", label: "field_analyze_rounds", rows: 6, required: true }],
};

const HANDOFF: LlmVerbConfig = {
  kind: "llm",
  verb: "handoff",
  maxOutputTokens: 1536,
  fields: [{ name: "packet", label: "field_handoff_packet", rows: 6, required: true }],
};

// ── CLI verbs ───────────────────────────────────────────────────────────────
// First arg of each argv MUST be allowlisted in app/api/stream/route.ts.
//
// Argv shapes were verified against the built DemiurgeCLI (`demiurge cli …`):
//   - structure / synth / verify use the verb-dispatch form
//       `action <verb> <domain>`   (verbs: specify/structure/design/
//        analyze/synthesize/verify/handoff — exit 0, honest-skip if the
//        domain has no .demi manifest yet; bare `verify <domain>` instead
//        REFUSES, treating the arg as an out-of-tree path → g_cockpit_isolation).
//   - discover is the phanes-owned 8th-verb head; the cockpit CLI prints a
//        friendly "unknown subcommand" usage block (exit 0) until phanes is
//        wired (~/core/phanes/INBOX.log.md::demiurge-discover-bridge), so the
//        stream surfaces the contract rather than crashing.

const STRUCTURE: CliVerbConfig = {
  kind: "cli",
  buildArgs: (domain) => ["action", "structure", domain],
};

const SYNTH: CliVerbConfig = {
  kind: "cli",
  buildArgs: (domain) => ["action", "synth", domain],
};

const VERIFY: CliVerbConfig = {
  kind: "cli",
  buildArgs: (domain) => ["action", "verify", domain],
};

const DISCOVER: CliVerbConfig = {
  kind: "cli",
  buildArgs: (domain) => ["discover", domain],
};

export const VERB_CONFIG: Record<VerbId, VerbConfig> = {
  spec: SPEC,
  design: DESIGN,
  analyze: ANALYZE,
  handoff: HANDOFF,
  structure: STRUCTURE,
  synth: SYNTH,
  verify: VERIFY,
  discover: DISCOVER,
};

export function getVerbConfig(verb: VerbId): VerbConfig {
  return VERB_CONFIG[verb];
}
