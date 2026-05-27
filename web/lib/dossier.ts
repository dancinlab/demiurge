// Dossier builder — collects all 7 verb records for a user's domain project
// into a single JSON bundle the user can download from /handoff/[domain].
// This is what "completes" the handoff verb (Q12 📦 dossier).

import { listSubcollection } from "./firestore";

export type Dossier = {
  domain: string;
  uid: string;
  generated_at: string;
  records: Array<Record<string, unknown>>;
  manifest: {
    verb_count: number;
    complete_count: number;
    in_progress_count: number;
    todo_count: number;
  };
};

export async function buildDossier(uid: string, domain: string): Promise<Dossier> {
  let records: Array<Record<string, unknown>> = [];
  try {
    records = await listSubcollection(
      `users/${uid}/projects/${domain}-demo`,
      "records",
    );
  } catch {
    records = [];
  }
  const status = (s: string) =>
    records.filter((r) => r.status === s).length;
  return {
    domain,
    uid,
    generated_at: new Date().toISOString(),
    records,
    manifest: {
      verb_count: records.length,
      complete_count: status("complete"),
      in_progress_count: status("in_progress"),
      todo_count: status("todo"),
    },
  };
}
