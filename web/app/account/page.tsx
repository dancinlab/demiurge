// /account — Server component reading the session cookie + Firestore
// subscription. Redirects to /signin if guest. Mono / Terminal tone.

import Link from "next/link";
import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { getActiveSubscription } from "@/lib/firestore";
import { getMessages, t } from "@/lib/i18n";
import { SignOutButton } from "./SignOutButton";

export const dynamic = "force-dynamic";

type TierMeta = {
  badge: string;
  labelKey: string;
};

const TIER_META: Record<string, TierMeta> = {
  solo: { badge: "$29 / mo", labelKey: "pricing.tier_solo" },
  team: { badge: "$99 / mo · 5 seats", labelKey: "pricing.tier_team" },
  org: { badge: "$299 / mo · 25 seats", labelKey: "pricing.tier_org" },
};

function formatPeriodEnd(v: unknown): string | null {
  if (v instanceof Date && !Number.isNaN(v.getTime())) {
    return v.toISOString().slice(0, 10);
  }
  return null;
}

export default async function AccountPage() {
  const [user, m] = await Promise.all([currentUser(), getMessages()]);
  if (!user) redirect("/signin");

  const sub = await getActiveSubscription(user.localId);
  const tierId =
    typeof sub?.tier === "string" && TIER_META[sub.tier as string]
      ? (sub.tier as keyof typeof TIER_META)
      : null;
  const meta = tierId ? TIER_META[tierId] : null;
  const tierLabel = meta ? t(m, meta.labelKey) : null;
  const periodEnd = formatPeriodEnd(sub?.currentPeriodEnd);

  return (
    <main className="min-h-screen bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
      <div className="mx-auto max-w-md px-8 py-16">
        <nav className="mb-6 text-xs text-neutral-500">
          <Link href="/" className="underline">
            {t(m, "nav.back_home")}
          </Link>
          {" · "}
          <Link href="/dashboard" className="underline">
            dashboard
          </Link>
        </nav>

        <header className="mb-8 flex items-center justify-between gap-3">
          <div>
            <span className="inline-block rounded border border-neutral-300 px-2 py-0.5 text-xs text-neutral-600 dark:border-neutral-700 dark:text-neutral-400">
              account
            </span>
            <h1 className="mt-3 text-3xl font-bold tracking-tight">{t(m, "account.title")}</h1>
          </div>
          {meta && tierLabel && (
            <span
              className="shrink-0 rounded border border-neutral-900 px-3 py-1 text-xs font-semibold dark:border-neutral-100"
              title={meta.badge}
            >
              {tierLabel}
            </span>
          )}
        </header>

        <section className="mb-6 rounded border border-neutral-300 dark:border-neutral-700">
          <dl className="divide-y divide-neutral-200 text-sm dark:divide-neutral-800">
            <div className="flex justify-between px-3 py-2">
              <dt className="text-neutral-500">{t(m, "account.email")}</dt>
              <dd>{user.email}</dd>
            </div>
            <div className="flex justify-between px-3 py-2">
              <dt className="text-neutral-500">{t(m, "account.verified")}</dt>
              <dd>{user.emailVerified ? "✓" : "—"}</dd>
            </div>
            <div className="flex justify-between px-3 py-2">
              <dt className="text-neutral-500">{t(m, "account.uid")}</dt>
              <dd className="text-xs">{user.localId}</dd>
            </div>
          </dl>
        </section>

        <section className="mb-6">
          <h2 className="mb-2 text-lg font-semibold">{t(m, "account.billing")}</h2>
          {meta && tierLabel ? (
            <div className="space-y-2">
              <p className="text-sm">
                <span className="font-semibold">{tierLabel}</span>{" "}
                <span className="text-neutral-500">· {meta.badge}</span>
              </p>
              {periodEnd && (
                <p className="text-xs text-neutral-500">
                  {t(m, "account.renewal")}:{" "}
                  <span className="font-mono">{periodEnd}</span>
                </p>
              )}
              {typeof sub?.cancelAtPeriodEnd === "boolean" &&
                sub.cancelAtPeriodEnd && (
                  <p className="text-xs text-neutral-700 dark:text-neutral-300">
                    {t(m, "account.cancel_warning")}
                  </p>
                )}
              <p className="text-xs text-neutral-500">{t(m, "account.portal_note")}</p>
            </div>
          ) : (
            <>
              <p className="mb-2 text-xs text-neutral-500">
                {t(m, "account.no_sub_tagline")}
              </p>
              <Link
                href="/pricing"
                className="inline-block rounded bg-neutral-900 px-3 py-1 text-sm text-white dark:bg-neutral-100 dark:text-neutral-900"
              >
                {t(m, "account.pick_plan")}
              </Link>
            </>
          )}
        </section>

        <SignOutButton label={t(m, "account.signout")} />
      </div>
    </main>
  );
}
