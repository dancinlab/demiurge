// /pricing — public pricing page. Stripe Checkout buttons require
// sign-in; we route through /signin if guest.

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
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
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

      <header className="mb-8">
        <h1 className="text-2xl font-bold">{t(m, "pricing.title")}</h1>
        <p className="mt-1 text-xs text-neutral-500">{t(m, "pricing.subtitle")}</p>
      </header>

      <section className="grid grid-cols-1 gap-4 md:grid-cols-3">
        {TIERS.map((tier) => {
          const tierLabel = t(m, TIER_KEY[tier.id]);
          const startLabel = t(m, "pricing.start_label").replace(
            "{tier}",
            tierLabel
          );
          return (
            <div
              key={tier.id}
              className="flex flex-col rounded border border-neutral-200 bg-neutral-50 p-4 dark:border-neutral-800 dark:bg-neutral-900"
            >
              <h2 className="text-xl font-bold">{tierLabel}</h2>
              <p className="mt-1 text-3xl font-bold">
                ${tier.monthlyUsd}
                <span className="text-sm font-normal text-neutral-500">
                  {" "}
                  {t(m, "pricing.per_mo")}
                </span>
              </p>
              <ul className="mt-3 flex-1 space-y-1 text-xs">
                {tier.highlights.map((h) => (
                  <li key={h}>· {h}</li>
                ))}
              </ul>
              <div className="mt-4">
                {user ? (
                  <CheckoutButton tier={tier.id} label={startLabel} />
                ) : (
                  <Link
                    href={`/signin?next=/pricing`}
                    className="block w-full rounded bg-neutral-900 px-3 py-2 text-center text-sm text-white dark:bg-neutral-100 dark:text-neutral-900"
                  >
                    {t(m, "pricing.signin_first")}
                  </Link>
                )}
              </div>
            </div>
          );
        })}
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        {t(m, "pricing.footer")}
      </footer>
    </main>
  );
}
