// /synth/[domain] — slot = synth-specific Q12 viewer.

import { VerbShell } from "@/components/VerbShell";
import { pickSlot } from "@/components/slots/SlotViewers";

export const dynamic = "force-dynamic";

export default async function Page({ params }: { params: Promise<{ domain: string }> }) {
  const { domain } = await params;
  return (
    <VerbShell
      verb="synth"
      domain={domain}
      statusByVerb={{}}
      slot={pickSlot("synth", domain)}
    />
  );
}
