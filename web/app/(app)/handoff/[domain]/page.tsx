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
      slot={<HandoffDossier domain={domain} />}
    />
  );
}
