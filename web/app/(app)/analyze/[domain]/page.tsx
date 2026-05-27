// /analyze/[domain] — slot = analyze-specific Q12 viewer.

import { VerbShell } from "@/components/VerbShell";
import { pickSlot } from "@/components/slots/SlotViewers";

export const dynamic = "force-dynamic";

export default async function Page({ params }: { params: Promise<{ domain: string }> }) {
  const { domain } = await params;
  return (
    <VerbShell
      verb="analyze"
      domain={domain}
      statusByVerb={{}}
      record={<pre className="text-xs">{JSON.stringify({ verb: "analyze", domain }, null, 2)}</pre>}
      slot={pickSlot("analyze", domain)}
      history={<div className="text-xs text-neutral-500">history · {domain}/analyze</div>}
    />
  );
}
