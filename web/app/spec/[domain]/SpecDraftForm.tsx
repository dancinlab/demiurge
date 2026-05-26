"use client";

import { VerbDraftForm } from "@/components/VerbDraftForm";

export function SpecDraftForm({
  domainName,
  currentGoal,
}: {
  domainName: string;
  currentGoal: string | null;
}) {
  return (
    <VerbDraftForm
      verb="spec"
      fixedParams={{ domainName, currentGoal }}
      fields={[
        {
          name: "hint",
          label: "hint — 어떤 방향으로 @goal을 다듬을지 1~3줄",
          placeholder: "예: 측정 가능한 KPI 1개 추가 + 마감 날짜 명시",
          rows: 4,
        },
      ]}
    />
  );
}
