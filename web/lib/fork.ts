// Fork — clones a public-domain entry (PUBLIC_DOMAINS.tape) into a user's
// private project under users/{uid}/projects/{projectId}/. Idempotent —
// re-fork re-seeds (cheap; demoware).
//
// public-domain currently ships with a baked-in 7-verb seed for QUBIT
// (web/lib/seed.ts). HBM/other entries get a minimal scaffold record set.

import { setDoc } from "./firestore";
import { loadTape } from "./tape";
import { seedQubitDemo } from "./seed";

function makeProjectId(sourceId: string): string {
  const stamp = Date.now().toString(36);
  return `${sourceId.replace(/[^a-z0-9_-]+/gi, "-").toLowerCase()}-${stamp}`;
}

export async function forkPublicDomain(
  uid: string,
  sourceId: string,
): Promise<{ projectId: string }> {
  const nodes = await loadTape("domains/PUBLIC_DOMAINS.tape");
  const src = nodes.find((n) => n.type === "C" && n.id === sourceId);
  if (!src) throw new Error(`public-domain not found: ${sourceId}`);

  const projectId = makeProjectId(sourceId);
  const base = `users/${uid}/projects/${projectId}`;
  await setDoc(base, {
    name: (src.subject ?? sourceId) + " (fork)",
    forkedFrom: sourceId,
    domain: Array.isArray(src.fields.composes) && src.fields.composes.length
      ? src.fields.composes[0]
      : sourceId,
    composes: Array.isArray(src.fields.composes) ? src.fields.composes : [],
    members: [uid], // Q10 team-seat 공동 데이터 — owner 가 첫 멤버
    owner: uid,
    createdAt: new Date().toISOString(),
  });

  // Reuse the QUBIT seed when the source has the qubit primitive in its stack.
  const composes = Array.isArray(src.fields.composes) ? src.fields.composes : [];
  if (composes.includes("qubit") || sourceId.startsWith("qubit")) {
    await seedQubitDemo(uid);
  } else {
    // Minimal scaffold for non-qubit sources (HBM etc.) — 8 todo records.
    // discover 최상단 (모든 작업의 시작점) + 7-verb pipeline.
    const verbs = ["discover", "spec", "structure", "design", "analyze", "synth", "verify", "handoff"];
    for (const v of verbs) {
      await setDoc(`${base}/records/${v}`, {
        verb: v,
        status: "todo",
        summary: `${v} (forked from ${sourceId})`,
        payload: {},
        ts: new Date().toISOString(),
      });
    }
  }

  return { projectId };
}
