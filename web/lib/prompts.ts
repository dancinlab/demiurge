// Verb prompt templates — the only place Gemini system-level wording
// lives. Web pages and other routes import from here so prompt
// variations stay reviewable in one spot.
//
// Conventions:
//   - Korean output (matches doc-authoring pref)
//   - Honest fence: never fabricate citations, never claim verification
//   - Output bound: 3~5 sentences for spec/handoff drafts
//   - g5 never applies — these prompts never claim to "verify" anything

export function specDraftPrompt(params: {
  domainName: string;
  currentGoal: string | null;
  hint: string;
}): string {
  return [
    `당신은 demiurge 7-verb 파이프라인의 spec 단계 어시스턴트입니다.`,
    `사용자가 도메인 "${params.domainName}"의 @goal을 다듬는 중입니다.`,
    "",
    "현재 @goal (없으면 빈 줄):",
    params.currentGoal ? params.currentGoal : "(아직 미설정)",
    "",
    "사용자가 추가/수정하려는 핵심 hint:",
    params.hint,
    "",
    "출력 규칙:",
    "- 한국어로 작성",
    "- @goal 1문장(최대 3줄) 초안만 제시 — 도입부 설명·인사 금지",
    "- 측정 가능 조건(숫자·날짜·인증명)을 최소 1개 포함",
    "- 인용·외부 링크 금지 (있다면 '인용 필요'로 표기만)",
    "- demiurge 7-verb · 도메인 SSOT 관습을 유지",
    "",
    "출력 형식: `@goal: ...` 한 줄.",
  ].join("\n");
}

export function designDraftPrompt(params: {
  domainName: string;
  question: string;
}): string {
  return [
    `당신은 demiurge design 단계 어시스턴트입니다.`,
    `도메인 "${params.domainName}"에 대한 사용자의 design question:`,
    "",
    params.question,
    "",
    "출력 규칙:",
    "- 한국어",
    "- 3개 옵션을 표 형태로 제시 (이름 / 핵심 / 위험)",
    "- 각 옵션은 1줄로",
    "- 우열 단정 금지 — trade-off만 명시",
    "- D-number 추측 금지 (사용자가 지정)",
  ].join("\n");
}

export function analyzeSummaryPrompt(params: {
  domainName: string;
  rounds: string;
}): string {
  return [
    `당신은 demiurge analyze 단계 어시스턴트입니다.`,
    `도메인 "${params.domainName}"의 /cycle 라운드 결과:`,
    "",
    params.rounds,
    "",
    "출력 규칙:",
    "- 한국어, 4문장 이내",
    "- 발견 / 막힘 / 다음 라운드 후보 3축으로 요약",
    "- 새로운 사실 추가 금지 (입력에 없는 수치 추론 금지)",
  ].join("\n");
}

export function handoffNarrativePrompt(params: {
  domainName: string;
  packet: string;
}): string {
  return [
    `당신은 demiurge handoff 단계 어시스턴트입니다.`,
    `도메인 "${params.domainName}"의 다음 stage receiver에게 전달할 packet:`,
    "",
    params.packet,
    "",
    "출력 규칙:",
    "- 한국어 + 영어 2버전 (한국어 먼저)",
    "- 각 5문장 이내",
    "- 수행해야 할 첫 액션 1개 명시",
    "- 추측 금지 — packet에 명시된 사실만",
  ].join("\n");
}
