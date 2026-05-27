// /pricing — public pricing page. Stripe Checkout buttons require
// sign-in; we route through /signin if guest.
//
// Mono / Terminal tone — matches dashboard (sample 1).

import Link from "next/link";
import { TIERS } from "@/lib/billing";
import { currentUser } from "@/lib/session";
import { getMessages, t } from "@/lib/i18n";
import { CheckoutButton } from "./CheckoutButton";

export const dynamic = "force-dynamic";

const TIER_KEY: Record<"solo" | "team" | "org", string> = {
  solo: "pricing.tier_solo",
  team: "pricing.tier_team",
  org: "pricing.tier_org",
};

export default async function PricingPage() {
  const [user, m] = await Promise.all([currentUser(), getMessages()]);

  return (
    <main className="min-h-screen bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
      <div className="mx-auto max-w-4xl px-8 py-16">
        <nav className="mb-6 text-xs text-neutral-500">
          <Link href="/" className="underline">
            {t(m, "nav.back_home")}
          </Link>
          {" · "}
          {user ? (
            <Link href="/account" className="underline">
              {t(m, "nav.account")}
            </Link>
          ) : (
            <Link href="/signin" className="underline">
              {t(m, "nav.signin")}
            </Link>
          )}
        </nav>

        <header className="mb-10">
          <span className="inline-block rounded border border-neutral-300 px-2 py-0.5 text-xs text-neutral-600 dark:border-neutral-700 dark:text-neutral-400">
            pricing
          </span>
          <h1 className="mt-4 text-4xl font-bold tracking-tight">
            {t(m, "pricing.title")}
          </h1>
          <p className="mt-3 max-w-xl text-sm leading-relaxed text-neutral-600 dark:text-neutral-400">
            {t(m, "pricing.subtitle")}
          </p>
        </header>

        <section className="grid grid-cols-1 gap-4 md:grid-cols-3">
          {TIERS.map((tier, idx) => {
            const tierLabel = t(m, TIER_KEY[tier.id]);
            const startLabel = t(m, "pricing.start_label").replace(
              "{tier}",
              tierLabel
            );
            const middle = idx === 1;
            return (
              <div
                key={tier.id}
                className={
                  "flex flex-col rounded border p-5 " +
                  (middle
                    ? "border-neutral-900 dark:border-neutral-100"
                    : "border-neutral-300 dark:border-neutral-700")
                }
              >
                <div className="text-[10px] uppercase tracking-[0.2em] text-neutral-500">
                  {String(idx + 1).padStart(2, "0")}
                </div>
                <h2 className="mt-1 text-lg font-bold">{tierLabel}</h2>
                <p className="mt-4 text-3xl font-bold">
                  ${tier.monthlyUsd}
                  <span className="ml-1 text-xs font-normal text-neutral-500">
                    {t(m, "pricing.per_mo")}
                  </span>
                </p>
                <ul className="mt-5 flex-1 space-y-1 text-xs text-neutral-700 dark:text-neutral-300">
                  {tier.highlights.map((h) => (
                    <li key={h}>· {h}</li>
                  ))}
                </ul>
                <div className="mt-6">
                  {user ? (
                    <CheckoutButton tier={tier.id} label={startLabel} />
                  ) : (
                    <Link
                      href={`/signin?next=/pricing`}
                      className="block w-full rounded border border-neutral-900 bg-neutral-900 px-3 py-2 text-center text-sm text-white dark:border-neutral-100 dark:bg-neutral-100 dark:text-neutral-900"
                    >
                      {t(m, "pricing.signin_first")}
                    </Link>
                  )}
                </div>
              </div>
            );
          })}
        </section>

        <footer className="mt-12 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
          {t(m, "pricing.footer")}
        </footer>
      </div>
    </main>
  );
}
