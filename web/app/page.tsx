// Public landing — production-grade marketing surface. The working
// 8-verb pipeline + discover live behind /dashboard (auth).

import Link from "next/link";
import { listDomains } from "@/lib/domains";
import { getMessages, t } from "@/lib/i18n";

export const dynamic = "force-dynamic"; // roster is filesystem-backed

const PIPELINE = [
  "discover",
  "spec",
  "structure",
  "design",
  "analyze",
  "synth",
  "verify",
  "handoff",
] as const;

const TIERS = [
  { id: "tier_solo", price: "$29", accent: "border-emerald-400" },
  { id: "tier_team", price: "$99", accent: "border-sky-400" },
  { id: "tier_org", price: "$299", accent: "border-violet-400" },
] as const;

export default async function HomePage() {
  const [domains, m] = await Promise.all([listDomains(), getMessages()]);

  return (
    <main className="font-mono">
      {/* ── hero ───────────────────────────────────────────── */}
      <section className="relative overflow-hidden border-b border-neutral-200 dark:border-neutral-800">
        <div
          className="pointer-events-none absolute inset-0 opacity-60"
          style={{
            background:
              "radial-gradient(60% 80% at 50% -10%, rgba(139,92,246,0.18), transparent 70%)",
          }}
        />
        <div className="relative mx-auto max-w-5xl px-6 py-24 text-center">
          <span className="inline-block rounded-full border border-violet-300 bg-violet-50 px-3 py-1 text-xs text-violet-700 dark:border-violet-800 dark:bg-violet-950/40 dark:text-violet-300">
            {t(m, "landing.badge")}
          </span>
          <h1 className="mx-auto mt-6 max-w-3xl text-balance text-4xl font-bold leading-tight sm:text-5xl">
            {t(m, "landing.title")}
          </h1>
          <p className="mx-auto mt-5 max-w-2xl text-balance text-sm leading-relaxed text-neutral-500 sm:text-base">
            {t(m, "landing.sub")}
          </p>
          <div className="mt-8 flex items-center justify-center gap-3">
            <Link
              href="/signin"
              className="rounded-lg bg-violet-600 px-5 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-violet-500"
            >
              {t(m, "landing.cta_start")}
            </Link>
            <Link
              href="/pricing"
              className="rounded-lg border border-neutral-300 px-5 py-2.5 text-sm font-semibold transition-colors hover:border-neutral-500 dark:border-neutral-700"
            >
              {t(m, "nav.pricing")}
            </Link>
          </div>
        </div>
      </section>

      {/* ── pipeline ──────────────────────────────────────── */}
      <section className="border-b border-neutral-200 px-6 py-16 dark:border-neutral-800">
        <div className="mx-auto max-w-5xl text-center">
          <h2 className="text-2xl font-bold">{t(m, "landing.pipeline_title")}</h2>
          <p className="mx-auto mt-2 max-w-2xl text-sm text-neutral-500">
            {t(m, "landing.pipeline_sub")}
          </p>
          <ol className="mt-8 flex flex-wrap items-center justify-center gap-2 text-sm">
            {PIPELINE.map((v, i) => (
              <li key={v} className="flex items-center gap-2">
                <span
                  className={
                    "rounded-lg border px-3 py-1.5 " +
                    (i === 0
                      ? "border-violet-400 bg-violet-50 font-semibold text-violet-700 dark:bg-violet-950/40 dark:text-violet-300"
                      : "border-neutral-300 dark:border-neutral-700")
                  }
                >
                  {i === 0 ? `${v} · 8` : v}
                </span>
                {i < PIPELINE.length - 1 && (
                  <span className="text-neutral-400">→</span>
                )}
              </li>
            ))}
          </ol>
        </div>
      </section>

      {/* ── features ──────────────────────────────────────── */}
      <section className="border-b border-neutral-200 px-6 py-16 dark:border-neutral-800">
        <div className="mx-auto grid max-w-5xl gap-4 sm:grid-cols-3">
          {[
            { k: "verify", icon: "✓" },
            { k: "i18n", icon: "🌐" },
            { k: "gcp", icon: "☁️" },
          ].map(({ k, icon }) => (
            <div
              key={k}
              className="rounded-xl border border-neutral-200 p-5 dark:border-neutral-800"
            >
              <div className="text-2xl">{icon}</div>
              <h3 className="mt-3 font-bold">
                {t(m, `landing.feat_${k}_title`)}
              </h3>
              <p className="mt-2 text-xs leading-relaxed text-neutral-500">
                {t(m, `landing.feat_${k}_body`)}
              </p>
            </div>
          ))}
        </div>
      </section>

      {/* ── domains showcase ──────────────────────────────── */}
      <section className="border-b border-neutral-200 px-6 py-16 dark:border-neutral-800">
        <div className="mx-auto max-w-6xl">
          <div className="mb-6 text-center">
            <h2 className="text-2xl font-bold">
              {t(m, "landing.domains_title")}{" "}
              <span className="text-neutral-400">({domains.length})</span>
            </h2>
            <p className="mt-2 text-sm text-neutral-500">
              {t(m, "landing.domains_sub")}
            </p>
          </div>
          <ul className="grid grid-cols-2 gap-2 sm:grid-cols-3 lg:grid-cols-4">
            {domains.map((d) => (
              <li key={d.name}>
                <Link
                  href={`/${encodeURIComponent(d.name)}`}
                  className="block truncate rounded-lg border border-neutral-200 px-3 py-2.5 text-sm transition-colors hover:border-violet-400 hover:text-violet-600 dark:border-neutral-800"
                  title={d.goal ?? d.name}
                >
                  {d.title ?? d.name}
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </section>

      {/* ── pricing teaser ────────────────────────────────── */}
      <section className="border-b border-neutral-200 px-6 py-16 dark:border-neutral-800">
        <div className="mx-auto max-w-4xl">
          <h2 className="mb-6 text-center text-2xl font-bold">
            {t(m, "landing.pricing_title")}
          </h2>
          <div className="grid gap-4 sm:grid-cols-3">
            {TIERS.map((tier) => (
              <Link
                key={tier.id}
                href="/pricing"
                className={
                  "flex flex-col items-center rounded-xl border-2 p-6 transition-transform hover:-translate-y-0.5 " +
                  tier.accent
                }
              >
                <span className="text-sm text-neutral-500">
                  {t(m, `pricing.${tier.id}`)}
                </span>
                <span className="mt-2 text-3xl font-bold">
                  {tier.price}
                  <span className="text-sm font-normal text-neutral-500">
                    /mo
                  </span>
                </span>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ── final CTA ─────────────────────────────────────── */}
      <section className="px-6 py-20 text-center">
        <Link
          href="/signin"
          className="inline-block rounded-lg bg-violet-600 px-8 py-3 text-base font-semibold text-white transition-colors hover:bg-violet-500"
        >
          {t(m, "landing.cta_final")} →
        </Link>
      </section>
    </main>
  );
}
