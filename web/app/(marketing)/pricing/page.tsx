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
      <div className="mx-auto max-w-5xl px-5 py-10 sm:px-8 sm:py-16">
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

        <div className="overflow-x-auto border-y-4 border-white py-2 text-[10px] uppercase sm:text-xs" style={{ letterSpacing: "0.3em" }}>
          <span className="whitespace-nowrap sm:tracking-[0.4em]">PRICING&nbsp;&nbsp;//&nbsp;&nbsp;TIERS&nbsp;&nbsp;//&nbsp;&nbsp;BILLING</span>
        </div>

        <h1 className="mt-8 text-[clamp(48px,14vw,80px)] font-black uppercase leading-[0.85] tracking-tighter sm:mt-10">
          {t(m, "pricing.title")}
          <span className="text-yellow-300">.</span>
        </h1>
        <p className="mt-6 max-w-xl border-l-4 border-white pl-4 text-sm uppercase tracking-wide sm:text-base">
          {t(m, "pricing.subtitle")}
        </p>

        <section className="mt-10 grid grid-cols-1 gap-0 border-4 border-white sm:mt-16 md:grid-cols-3">
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

        {/* GCP compute usage table — public list prices, us-central1.
            Billed directly by Google (not by demiurge). */}
        <section className="mt-14 sm:mt-20">
          <div className="overflow-x-auto border-y-4 border-white py-2 text-[10px] uppercase sm:text-xs" style={{ letterSpacing: "0.3em" }}>
            <span className="whitespace-nowrap sm:tracking-[0.4em]">GCP&nbsp;&nbsp;//&nbsp;&nbsp;{t(m, "pricing.gcp_label")}</span>
          </div>
          <h2 className="mt-8 text-3xl font-black uppercase leading-[0.9] tracking-tighter sm:text-4xl">
            {t(m, "pricing.gcp_title")}
            <span className="text-yellow-300">.</span>
          </h2>
          <p className="mt-4 max-w-2xl border-l-4 border-white pl-4 text-xs uppercase tracking-wide text-white/70">
            {t(m, "pricing.gcp_subtitle")}
          </p>

          <div className="mt-8 overflow-x-auto border-4 border-white">
            <div className="grid min-w-[20rem] grid-cols-[1fr_auto_auto] items-center border-b-4 border-white bg-yellow-300 px-4 py-2 text-[10px] font-black uppercase tracking-[0.2em] text-black sm:min-w-0 sm:tracking-[0.3em]">
              <span>{t(m, "pricing.gcp_col_resource")}</span>
              <span className="px-2 sm:px-6">{t(m, "pricing.gcp_col_unit")}</span>
              <span className="text-right">{t(m, "pricing.gcp_col_price")}</span>
            </div>
            {[
              { resource: "Gemini 2.5 Flash",   unit: "per 1M tokens",  price: "$0.20 / $0.70",  note: "input / output · Vertex AI" },
              { resource: "Gemini 2.5 Pro",     unit: "per 1M tokens",  price: "$1.25 / $5.00",  note: "input / output · Vertex AI" },
              { resource: "Cloud Run vCPU",     unit: "per vCPU-hour",  price: "$0.0864",        note: "per-second billing, scale-to-zero" },
              { resource: "GPU · L4 (24 GB)",   unit: "per hour",       price: "$0.71",          note: "inference · lighter training" },
              { resource: "GPU · A100 (40 GB)", unit: "per hour",       price: "$3.67",          note: "training · heavy inference" },
              { resource: "GPU · H100 (80 GB)", unit: "per hour",       price: "$11.06",         note: "large-scale training · LLM finetune" },
              { resource: "TPU v5e",            unit: "per chip-hour",  price: "$1.20",          note: "inference-optimized" },
              { resource: "TPU v5p",            unit: "per chip-hour",  price: "$4.20",          note: "training-optimized" },
              { resource: "BigQuery",           unit: "per TB scanned", price: "$5.00",          note: "on-demand · or flat-rate slots" },
              { resource: "Cloud Storage",      unit: "per GB-month",   price: "$0.020",         note: "standard class, us-central1" },
            ].map((row, i, arr) => (
              <div
                key={row.resource}
                className={
                  "grid min-w-[20rem] grid-cols-[1fr_auto_auto] items-center px-4 py-3 text-xs uppercase tracking-wide sm:min-w-0 " +
                  (i < arr.length - 1 ? "border-b border-white/30 " : "")
                }
              >
                <div>
                  <div className="font-black text-white">{row.resource}</div>
                  <div className="mt-0.5 text-[10px] normal-case tracking-normal text-white/50">{row.note}</div>
                </div>
                <span className="px-2 text-white/70 sm:px-6">{row.unit}</span>
                <span className="text-right font-black text-yellow-300">{row.price}</span>
              </div>
            ))}
          </div>

          <p className="mt-4 text-[10px] uppercase tracking-wide text-white/50">
            {t(m, "pricing.gcp_disclaimer")}
          </p>
        </section>

        <footer className="mt-12 border-t-4 border-white pt-4 text-xs uppercase tracking-wide text-white/70">
          {t(m, "pricing.footer")}
        </footer>
      </div>
    </main>
  );
}
