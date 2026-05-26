// /account — Server component reading the session cookie + Firestore
// subscription. Redirects to /signin if guest.

import Link from "next/link";
import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { getActiveSubscription } from "@/lib/firestore";
import { getMessages, t } from "@/lib/i18n";
import { SignOutButton } from "./SignOutButton";

export const dynamic = "force-dynamic";

type TierMeta = {
  badge: string;
  pillClass: string;
  labelKey: string;
};

const TIER_META: Record<string, TierMeta> = {
  solo: {
    badge: "$29 / mo",
    pillClass:
      "bg-emerald-100 text-emerald-900 dark:bg-emerald-900/40 dark:text-emerald-200",
    labelKey: "pricing.tier_solo",
  },
  team: {
    badge: "$99 / mo · 5 seats",
    pillClass:
      "bg-sky-100 text-sky-900 dark:bg-sky-900/40 dark:text-sky-200",
    labelKey: "pricing.tier_team",
  },
  org: {
    badge: "$299 / mo · 25 seats",
    pillClass:
      "bg-purple-100 text-purple-900 dark:bg-purple-900/40 dark:text-purple-200",
    labelKey: "pricing.tier_org",
  },
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
    <main className="mx-auto max-w-md px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          {t(m, "nav.back_home")}
        </Link>
      </nav>
      <header className="mb-6 flex items-center justify-between gap-3">
        <h1 className="text-2xl font-bold">{t(m, "account.title")}</h1>
        {meta && tierLabel && (
          <span
            className={
              "rounded-full px-3 py-1 text-xs font-semibold " + meta.pillClass
            }
            title={meta.badge}
          >
            {tierLabel}
          </span>
        )}
      </header>

      <section className="mb-6 rounded border border-neutral-200 bg-neutral-50 p-3 dark:border-neutral-800 dark:bg-neutral-900">
        <dl className="space-y-2 text-sm">
          <div className="flex justify-between">
            <dt className="text-neutral-500">{t(m, "account.email")}</dt>
            <dd>{user.email}</dd>
          </div>
          <div className="flex justify-between">
            <dt className="text-neutral-500">{t(m, "account.verified")}</dt>
            <dd>{user.emailVerified ? "✓" : "—"}</dd>
          </div>
          <div className="flex justify-between">
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
              <span className="font-semibold">{tierLabel}</span> ·{" "}
              <span className="text-neutral-500">{meta.badge}</span>
            </p>
            {periodEnd && (
              <p className="text-xs text-neutral-500">
                {t(m, "account.renewal")}:{" "}
                <span className="font-mono">{periodEnd}</span>
              </p>
            )}
            {typeof sub?.cancelAtPeriodEnd === "boolean" &&
              sub.cancelAtPeriodEnd && (
                <p className="text-xs text-amber-700 dark:text-amber-300">
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
    </main>
  );
}
