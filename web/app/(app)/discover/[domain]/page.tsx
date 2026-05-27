// /discover/[domain] — slot = kick/gap tree (Q12 🌳).

import { VerbShell } from "@/components/VerbShell";
import { pickSlot } from "@/components/slots/SlotViewers";

export const dynamic = "force-dynamic";

export default async function Page({ params }: { params: Promise<{ domain: string }> }) {
  const { domain } = await params;
  return (
    <VerbShell
      verb="discover"
      domain={domain}
      statusByVerb={{}}
      record={<pre className="text-xs">{JSON.stringify({ verb: "discover", domain }, null, 2)}</pre>}
      slot={pickSlot("discover", domain)}
      history={<div className="text-xs text-neutral-500">history · {domain}/discover</div>}
    />
  );
}
