// /account — Server component reading the session cookie + Firestore
// subscription. Redirects to /signin if guest. Brutalist tone.

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
    <main className="min-h-screen bg-black text-white">
      <div className="mx-auto max-w-2xl px-8 py-16">
        <nav className="mb-10 text-xs uppercase tracking-[0.3em] text-white/70">
          <Link href="/" className="hover:text-yellow-300">
            {t(m, "nav.back_home")}
          </Link>
          <span className="px-3 text-white/40">//</span>
          <Link href="/dashboard" className="hover:text-yellow-300">
            DASHBOARD
          </Link>
        </nav>

        <div className="border-y-4 border-white py-2 text-xs uppercase" style={{ letterSpacing: "0.4em" }}>
          ACCOUNT&nbsp;&nbsp;//&nbsp;&nbsp;BILLING&nbsp;&nbsp;//&nbsp;&nbsp;SESSION
        </div>

        <header className="mt-10 flex items-end justify-between gap-6">
          <h1 className="text-[64px] font-black uppercase leading-[0.85] tracking-tighter">
            {t(m, "account.title")}
            <span className="text-yellow-300">.</span>
          </h1>
          {meta && tierLabel && (
            <span
              className="shrink-0 border-4 border-yellow-300 bg-yellow-300 px-3 py-1 text-xs font-black uppercase tracking-[0.2em] text-black"
              title={meta.badge}
            >
              {tierLabel}
            </span>
          )}
        </header>

        <section className="mt-12 border-4 border-white">
          <div className="grid grid-cols-1">
            <div className="flex items-center justify-between border-b-4 border-white px-4 py-3">
              <span className="text-xs font-black uppercase tracking-[0.2em] text-white/70">
                {t(m, "account.email")}
              </span>
              <span className="text-sm uppercase">{user.email}</span>
            </div>
            <div className="flex items-center justify-between border-b-4 border-white px-4 py-3">
              <span className="text-xs font-black uppercase tracking-[0.2em] text-white/70">
                {t(m, "account.verified")}
              </span>
              <span className="text-sm">
                {user.emailVerified ? (
                  <span className="text-yellow-300">✓</span>
                ) : (
                  "—"
                )}
              </span>
            </div>
            <div className="flex items-center justify-between px-4 py-3">
              <span className="text-xs font-black uppercase tracking-[0.2em] text-white/70">
                {t(m, "account.uid")}
              </span>
              <span className="font-mono text-xs">{user.localId}</span>
            </div>
          </div>
        </section>

        <section className="mt-12">
          <h2 className="border-y-4 border-white py-2 text-xs font-black uppercase tracking-[0.4em]">
            {t(m, "account.billing")}
          </h2>
          {meta && tierLabel ? (
            <div className="mt-4 space-y-3 border-l-4 border-white pl-4">
              <p className="text-base uppercase tracking-wide">
                <span className="font-black">{tierLabel}</span>
                <span className="px-3 text-white/40">//</span>
                <span className="text-white/70">{meta.badge}</span>
              </p>
              {periodEnd && (
                <p className="text-xs uppercase tracking-wide text-white/70">
                  {t(m, "account.renewal")}:{" "}
                  <span className="font-mono text-white">{periodEnd}</span>
                </p>
              )}
              {typeof sub?.cancelAtPeriodEnd === "boolean" &&
                sub.cancelAtPeriodEnd && (
                  <p className="text-xs uppercase tracking-wide text-yellow-300">
                    {t(m, "account.cancel_warning")}
                  </p>
                )}
              <p className="text-xs uppercase tracking-wide text-white/70">
                {t(m, "account.portal_note")}
              </p>
            </div>
          ) : (
            <div className="mt-4">
              <p className="mb-4 border-l-4 border-white pl-4 text-xs uppercase tracking-wide text-white/70">
                {t(m, "account.no_sub_tagline")}
              </p>
              <Link
                href="/pricing"
                className="inline-block border-4 border-white bg-yellow-300 px-6 py-3 text-sm font-black uppercase text-black hover:bg-white"
              >
                {t(m, "account.pick_plan")} ▶
              </Link>
            </div>
          )}
        </section>

        <div className="mt-12 border-t-4 border-white pt-6">
          <SignOutButton label={t(m, "account.signout")} />
        </div>
      </div>
    </main>
  );
}
