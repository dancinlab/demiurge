// trajectory — 도메인 .log.md 의 step 로그를 ara "AUTO-CAPTURED TRAJECTORY"
// 4-label 타임라인으로 변환 (decision · dead_end · heuristic · experiment).
// 키워드 휴리스틱 분류 — LLM 없이 결정적.

export type TrajLabel = "decision" | "dead_end" | "heuristic" | "experiment";
export type TrajEntry = { label: TrajLabel; text: string };

export function classifyLogLine(line: string): TrajLabel {
  const l = line.toLowerCase();
  // dead_end — 벽 · 실패 · 발산 · falsified
  if (/🔴|falsif|diverg|\bwall\b|\bfail|막힘|벽|불가|abandon|revert/.test(l)) {
    return "dead_end";
  }
  // experiment — 측정 · 통과 · 수렴 · 게이트
  if (/🟢|✅|\bpass\b|absorb|converg|gate|measured|verdict|run|loss|결과|측정/.test(l)) {
    return "experiment";
  }
  // decision — 선택 · 채택 · 전략 · 접근
  if (/decision|chose|choose|택|결정|strateg|approach|채택|pivot|adopt|선택/.test(l)) {
    return "decision";
  }
  // 나머지 — heuristic (fix · use · apply · tweak)
  return "heuristic";
}

// 로그 본문 → 최근 N개 trajectory entry. demiurge .log.md 는 append-only
// (맨 아래가 최신) 이므로 헤더(# · >)·구분선 제외하고 tail 에서 최신순으로.
export function logToTrajectory(logText: string, max = 8): TrajEntry[] {
  return logText
    .split("\n")
    .map((l) => l.trim())
    .filter(
      (l) =>
        l.length > 8 &&
        !l.startsWith("#") &&
        !l.startsWith(">") &&
        !/^={3,}|^-{3,}/.test(l),
    )
    .map((l) => l.replace(/^[-*\s]+/, "").trim())
    .slice(-max) // append-only → 맨 아래(최신) N개
    .reverse() // 최신 먼저
    .map((text) => ({
      label: classifyLogLine(text),
      text: text.length > 140 ? text.slice(0, 137) + "…" : text,
    }));
}

// log 가 비어있는 도메인용 데모 trajectory (ara session-042 예시).
// 4-label 이 모두 등장해 패턴을 한눈에 보여줌.
export const DEMO_TRAJECTORY: TrajEntry[] = [
  { label: "decision", text: "ReLU transformer approach" },
  { label: "dead_end", text: "Loss diverged (norm bug)" },
  { label: "heuristic", text: "Inv-std outside forward pass" },
  { label: "experiment", text: "Training stable, loss 4.60" },
  { label: "heuristic", text: "Differential LR: emb 3e-4 / tfm 3e-5" },
  { label: "experiment", text: "Loss 3.98 (+13% vs uniform)" },
];
