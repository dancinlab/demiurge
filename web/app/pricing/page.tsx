// /pricing — public pricing page. Stripe Checkout buttons require
// sign-in; we route through /signin if guest.
//
// Brutalist tone — matches landing (PR #324) and root chrome (PR #325).

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
    <main className="min-h-screen bg-black text-white">
      <div className="mx-auto max-w-5xl px-8 py-16">
        <nav className="mb-10 text-xs uppercase tracking-[0.3em] text-white/70">
          <Link href="/" className="hover:text-yellow-300">
            {t(m, "nav.back_home")}
          </Link>
          <span className="px-3 text-white/40">//</span>
          {user ? (
            <Link href="/account" className="hover:text-yellow-300">
              {t(m, "nav.account")}
            </Link>
          ) : (
            <Link href="/signin" className="hover:text-yellow-300">
              {t(m, "nav.signin")}
            </Link>
          )}
        </nav>

        <div className="border-y-4 border-white py-2 text-xs uppercase" style={{ letterSpacing: "0.4em" }}>
          PRICING&nbsp;&nbsp;//&nbsp;&nbsp;TIERS&nbsp;&nbsp;//&nbsp;&nbsp;BILLING
        </div>

        <h1 className="mt-10 text-[80px] font-black uppercase leading-[0.85] tracking-tighter">
          {t(m, "pricing.title")}
          <span className="text-yellow-300">.</span>
        </h1>
        <p className="mt-6 max-w-xl border-l-4 border-white pl-4 text-base uppercase tracking-wide">
          {t(m, "pricing.subtitle")}
        </p>

        <section className="mt-16 grid grid-cols-1 gap-0 border-4 border-white md:grid-cols-3">
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
                  "flex flex-col border-white p-6 " +
                  (middle ? "bg-yellow-300 text-black md:border-x-4" : "bg-black text-white")
                }
              >
                <div
                  className="text-xs uppercase opacity-60"
                  style={{ letterSpacing: "0.3em" }}
                >
                  {String(idx + 1).padStart(2, "0")}
                </div>
                <h2 className="mt-1 text-2xl font-black uppercase">{tierLabel}</h2>
                <p className="mt-4 text-5xl font-black">
                  ${tier.monthlyUsd}
                  <span className="ml-1 text-sm font-normal uppercase opacity-70">
                    {t(m, "pricing.per_mo")}
                  </span>
                </p>
                <ul className="mt-6 flex-1 space-y-2 text-xs uppercase tracking-wide">
                  {tier.highlights.map((h) => (
                    <li key={h} className="border-l-2 border-current pl-2">{h}</li>
                  ))}
                </ul>
                <div className="mt-8">
                  {user ? (
                    <CheckoutButton tier={tier.id} label={startLabel} />
                  ) : (
                    <Link
                      href={`/signin?next=/pricing`}
                      className={
                        "block w-full border-4 px-4 py-3 text-center text-sm font-black uppercase " +
                        (middle
                          ? "border-black bg-black text-yellow-300 hover:bg-white hover:text-black"
                          : "border-white bg-white text-black hover:bg-yellow-300")
                      }
                    >
                      {t(m, "pricing.signin_first")}
                    </Link>
                  )}
                </div>
              </div>
            );
          })}
        </section>

        <footer className="mt-12 border-t-4 border-white pt-4 text-xs uppercase tracking-wide text-white/70">
          {t(m, "pricing.footer")}
        </footer>
      </div>
    </main>
  );
}
