// /handoff/[domain] — handoff verb 완성형.
// Slot = 실 dossier 다운로드 가능 (HandoffDossier client component).

import { VerbShell } from "@/components/VerbShell";
import { HandoffDossier } from "@/components/HandoffDossier";

export const dynamic = "force-dynamic";

export default async function Page({
  params,
}: {
  params: Promise<{ domain: string }>;
}) {
  const { domain } = await params;
  return (
    <VerbShell
      verb="handoff"
      domain={domain}
      statusByVerb={{}}
      record={<pre className="text-xs">{JSON.stringify({ verb: "handoff", domain }, null, 2)}</pre>}
      slot={<HandoffDossier domain={domain} />}
      history={<div className="text-xs text-neutral-500">history · {domain}/handoff · 매 다운로드는 generated_at 새로 기록</div>}
    />
  );
}
