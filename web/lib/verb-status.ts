// verb-status — derive a per-verb status (complete | in_progress | todo) for
// the sidebar status dots from a domain's milestone progress.
//
// Domain milestones (<DOMAIN>.md `- [ ]` / `- [x]`) are free-form prose, NOT
// verb-tagged, so a literal verb→milestone mapping is not reliable. We use a
// SIMPLE, SAFE, DETERMINISTIC heuristic (plan: "매핑이 모호하면 단순/안전하게"):
//
//   1. The 8 verbs sit on a pipeline in canonical order (the VERBS order:
//      discover → spec → structure → design → analyze → synth → verify → handoff).
//   2. Map the domain's completed fraction onto that pipeline: verbs whose
//      index is fully below the frontier are `complete`, the frontier verb is
//      `in_progress`, the rest are `todo`.
//   3. Keyword override: if any milestone line mentions a verb's name/synonym,
//      a done line upgrades that verb toward complete, an open line keeps it at
//      least in_progress. This lets explicit signals beat the smooth pipeline
//      estimate without inventing precision we don't have.
//
// Pure function over (orderedVerbs, milestones) — no fs, importable anywhere.

import type { VerbId, VerbStatus } from "@/lib/verbs";

export type Milestone = { done: boolean; text: string };

// Canonical pipeline order (mirrors lib/verbs VERBS). Hardcoded as a literal so
// module evaluation never depends on a value import crossing the RSC boundary
// (a `VERBS.map` at module top-level can intermittently fail under Turbopack).
const VERB_ORDER: VerbId[] = [
  "discover",
  "spec",
  "structure",
  "design",
  "analyze",
  "synth",
  "verify",
  "handoff",
];

// Lowercase keyword cues per verb (English + common Korean labels).
const VERB_KEYWORDS: Record<VerbId, string[]> = {
  discover: ["discover", "kick", "gap", "발견", "발산", "탐색"],
  spec: ["spec", "@goal", "target", "사양", "목표"],
  structure: ["structure", "lattice", "cell", "구조", "격자"],
  design: ["design", "schematic", "설계", "회로"],
  analyze: ["analyze", "analysis", "cycle round", "분석"],
  synth: ["synth", "recipe", "anneal", "precursor", "합성"],
  verify: ["verify", "verdict", "tier", "🟢", "🔵", "검증", "absorbed"],
  handoff: ["handoff", "dossier", "wet-lab handoff", "인계"],
};

/**
 * Parse `<DOMAIN>.md` text into milestones. Only top-level `- [ ]` / `- [x]`
 * checkbox lines count (matches lib/domains' progress parser).
 */
export function parseMilestones(mdText: string): Milestone[] {
  const out: Milestone[] = [];
  for (const raw of mdText.split("\n")) {
    const m = raw.match(/^\s*-\s+\[([ xX])\]\s*(.*)$/);
    if (!m) continue;
    out.push({ done: m[1].toLowerCase() === "x", text: m[2] });
  }
  return out;
}

export function deriveVerbStatus(
  milestones: Milestone[],
): Partial<Record<VerbId, VerbStatus>> {
  const n = VERB_ORDER.length;
  const result: Partial<Record<VerbId, VerbStatus>> = {};

  if (milestones.length === 0) {
    // No data → everything todo.
    for (const v of VERB_ORDER) result[v] = "todo";
    return result;
  }

  const doneCount = milestones.filter((m) => m.done).length;
  const fraction = doneCount / milestones.length;
  // Frontier = how many verbs are "behind" the progress wave.
  const frontier = Math.min(n, Math.floor(fraction * n));

  // 1. Smooth pipeline baseline.
  VERB_ORDER.forEach((v, i) => {
    result[v] = i < frontier ? "complete" : i === frontier ? "in_progress" : "todo";
  });

  // 2. Keyword override (explicit signal beats the estimate).
  for (const v of VERB_ORDER) {
    const kws = VERB_KEYWORDS[v];
    let sawDone = false;
    let sawOpen = false;
    for (const m of milestones) {
      const lower = m.text.toLowerCase();
      if (kws.some((k) => lower.includes(k))) {
        if (m.done) sawDone = true;
        else sawOpen = true;
      }
    }
    if (sawDone && !sawOpen) result[v] = "complete";
    else if (sawOpen) {
      // Open mention → at least in_progress (don't downgrade a complete).
      if (result[v] !== "complete") result[v] = "in_progress";
    }
  }

  return result;
}
