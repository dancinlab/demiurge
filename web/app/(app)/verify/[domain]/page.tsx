// /verify/[domain] — slot = verify-specific Q12 viewer.

import { VerbShell } from "@/components/VerbShell";
import { pickSlot } from "@/components/slots/SlotViewers";

export const dynamic = "force-dynamic";

export default async function Page({ params }: { params: Promise<{ domain: string }> }) {
  const { domain } = await params;
  return (
    <VerbShell
      verb="verify"
      domain={domain}
      statusByVerb={{}}
      record={<pre className="text-xs">{JSON.stringify({ verb: "verify", domain }, null, 2)}</pre>}
      slot={pickSlot("verify", domain)}
      history={<div className="text-xs text-neutral-500">history · {domain}/verify</div>}
    />
  );
}
