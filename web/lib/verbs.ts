// verbs — the 8-verb spine SSOT (server-safe, no "use client").
//
// This array + its types are imported by BOTH server modules (lib/verb-status,
// lib/verb-config, VerbShell) and the client sidebar (VerbTreeNav). Keeping the
// runtime VERBS value in a plain module avoids the Turbopack RSC quirk where a
// value exported from a "use client" file becomes a reference proxy (and so
// `VERBS.map` is not a function) when imported server-side.

// discover 가 최상단 — 모든 작업의 시작점 (kick / gap / 발산).
// 그 뒤로 7-verb pipeline (spec → ... → handoff) 정통 순서.
export const VERBS = [
  { id: "discover", label: "discover" },
  { id: "spec", label: "spec" },
  { id: "structure", label: "structure" },
  { id: "design", label: "design" },
  { id: "analyze", label: "analyze" },
  { id: "synth", label: "synth" },
  { id: "verify", label: "verify" },
  { id: "handoff", label: "handoff" },
] as const;

export type VerbId = (typeof VERBS)[number]["id"];
export type VerbStatus = "complete" | "in_progress" | "todo";
