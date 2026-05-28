// /admin — provider toggle surface. Admin-only.
//
// Single-active switch (payment) · multi-enabled + priority (GPU/LLM).
// Writes via POST /api/v1/providers — server checks `users/{uid}.role === "admin"`.

import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { getDoc } from "@/lib/firestore";
import { getRegistry } from "@/lib/providers";
import { AdminToggles } from "@/components/AdminToggles";
import { getMessages, t } from "@/lib/i18n";

export const dynamic = "force-dynamic";

export default async function AdminPage() {
  const [u, messages] = await Promise.all([currentUser(), getMessages()]);
  if (!u) redirect("/signin");

  let role = "user";
  try {
    const doc = await getDoc(`users/${u.localId}`);
    if (doc && (doc as Record<string, unknown>).role === "admin") role = "admin";
  } catch {
    // fall through with role="user"
  }
  if (role !== "admin") redirect("/dashboard");

  const registry = await getRegistry();

  const togglesI18n = {
    payment: `💳 ${t(messages, "app_gui.payment_section")}`,
    gpu: `🎮 ${t(messages, "app_gui.gpu_section")}`,
    llm: `🧠 ${t(messages, "app_gui.llm_section")}`,
  };

  return (
    <main className="mx-auto max-w-3xl px-6 py-12">
      <h1 className="text-2xl font-bold tracking-tight text-ink">⚙️ /admin</h1>
      <p className="mt-2 text-sm text-muted">{t(messages, "admin.subtitle")}</p>
      <AdminToggles initial={registry} i18n={togglesI18n} />
    </main>
  );
}
