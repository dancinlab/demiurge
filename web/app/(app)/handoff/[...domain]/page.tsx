// /handoff/[...domain] — handoff verb completed-form.
// Slot = real downloadable dossier (HandoffDossier client component).
// catch-all [...domain] so nested meta/sub ids (e.g. CARDIO+/DAPTPGX) route as
// path segments; flat ids (RTSC) arrive as a 1-element array. Joined with "/".
// i18n resolved server-side (getMessages/t) and passed down as props.

import { VerbShell } from "@/components/VerbShell";
import { HandoffDossier } from "@/components/HandoffDossier";
import { getMessages, t } from "@/lib/i18n";

export const dynamic = "force-dynamic";

export default async function Page({
  params,
}: {
  params: Promise<{ domain: string[] }>;
}) {
  const { domain: seg } = await params;
  const domain = (seg ?? []).map(decodeURIComponent).join("/");
  const messages = await getMessages();
  const dossierI18n = {
    loading: t(messages, "app_gui.loading"),
    dossier: t(messages, "app_gui.handoff_title"),
    completed: t(messages, "app_gui.handoff_completed"),
    download: t(messages, "app_gui.download_json"),
    complete: t(messages, "app_gui.status_complete"),
    inProgress: t(messages, "app_gui.status_in_progress"),
    todo: t(messages, "app_gui.status_todo"),
    records: t(messages, "app_gui.records"),
    confirmTitle: t(messages, "app_gui.dossier_confirm_title"),
    confirmBody: t(messages, "app_gui.dossier_confirm_body"),
    confirmDownload: t(messages, "app_gui.dossier_confirm_download"),
    confirmCancel: t(messages, "app_gui.dossier_confirm_cancel"),
    close: t(messages, "app_gui.modal_close"),
  };
  return (
    <VerbShell
      verb="handoff"
      domain={domain}
      statusByVerb={{}}
      slot={<HandoffDossier domain={domain} i18n={dossierI18n} />}
    />
  );
}
