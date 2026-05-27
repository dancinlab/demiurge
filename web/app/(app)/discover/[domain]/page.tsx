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
      slot={pickSlot("discover", domain)}
    />
  );
}
