// Public landing — Brutalist tone (검정·노랑·과대 산세리프·하드 보더).
// Sample SSOT: ~/Desktop/demiurge-design-samples/2-brutalist.md
// 대시보드(/dashboard)는 Mono 톤 유지 — 두 surface가 의도적으로 대비.

import Link from "next/link";
import { listDomains } from "@/lib/domains";
import { getMessages, t } from "@/lib/i18n";

export const dynamic = "force-dynamic";

const PIPELINE = ["discover", "spec", "structure", "design", "analyze", "synth", "verify", "handoff"] as const;
const TIERS = [
  { id: "tier_solo", price: "$29",  accent: false },
  { id: "tier_team", price: "$99",  accent: true },
  { id: "tier_org",  price: "$299", accent: false },
] as const;

export default async function HomePage() {
  const [domains, m] = await Promise.all([listDomains(), getMessages()]);

  return (
    <main
      className="min-h-screen bg-black text-white"
      style={{ fontFamily: "ui-sans-serif, system-ui, -apple-system, 'Helvetica Neue', sans-serif" }}
    >
      {/* ── hero ──────────────────────────────────────────────── */}
      <section className="border-b-4 border-white">
        <div className="mx-auto max-w-6xl px-5 py-10 sm:px-8 sm:py-16">
          <div className="overflow-x-auto border-y-4 border-white py-2 text-[10px] uppercase sm:text-xs" style={{ letterSpacing: "0.3em" }}>
            <span className="whitespace-nowrap sm:tracking-[0.4em]">BUILT &nbsp;//&nbsp; WITH &nbsp;//&nbsp; GEMINI &nbsp;//&nbsp; XPRIZE&nbsp;2026</span>
          </div>
          <h1 className="mt-8 text-[clamp(56px,15vw,128px)] font-black uppercase leading-[0.85] tracking-tighter sm:mt-10">
            DEMI<br />URGE<span className="text-yellow-300">.</span>
          </h1>
          <p className="mt-8 max-w-2xl border-l-4 border-white pl-4 text-sm uppercase tracking-wide sm:mt-10 sm:text-base">
            AI-NATIVE 8-VERB PIPELINE.&nbsp; ATOMS · MATERIALS · CHIPS · BIO · CHEMISTRY.&nbsp; ONE PRODUCTION LOOP.&nbsp;
            VERIFY IS SACRED — ZERO LLM VERDICTS.
          </p>
          <div className="mt-10 flex flex-col sm:mt-12 sm:flex-row">
            <Link
              href="/signin"
              className="border-4 border-white bg-yellow-300 px-8 py-4 text-center text-base font-black uppercase text-black hover:bg-white"
            >
              {t(m, "landing.cta_start")} &nbsp;▶
            </Link>
            <Link
              href="/pricing"
              className="-mt-1 border-4 border-white px-8 py-4 text-center text-base font-black uppercase hover:bg-yellow-300 hover:text-black sm:-ml-1 sm:-mt-0"
            >
              {t(m, "nav.pricing")}
            </Link>
          </div>
        </div>
      </section>

      {/* ── pipeline 8-verb grid ─────────────────────────────── */}
      <section className="border-b-4 border-white">
        <div className="mx-auto max-w-6xl px-5 py-10 sm:px-8 sm:py-16">
          <h2 className="text-2xl font-black uppercase tracking-tight sm:text-3xl">
            ONE LOOP.&nbsp;<span className="text-yellow-300">EIGHT VERBS.</span>
          </h2>
          <p className="mt-3 max-w-xl text-sm uppercase tracking-wide text-white/70">
            DISCOVER SEEDS IT. VERIFY CLOSES IT. EVERY STAGE — A DETERMINISTIC SURFACE, NEVER A CHAT.
          </p>
          <div className="mt-10 grid grid-cols-2 gap-0 border-4 border-white sm:grid-cols-4">
            {PIPELINE.map((v, i) => (
              <div
                key={v}
                className={
                  "border border-white px-4 py-6 text-center " +
                  (i === 0 ? "bg-yellow-300 text-black" : "bg-black")
                }
              >
                <div className="text-xs uppercase opacity-60" style={{ letterSpacing: "0.15em" }}>
                  {i === 0 ? "08 · head" : String(i).padStart(2, "0")}
                </div>
                <div className="mt-1 text-lg font-black uppercase">{v}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── features 3 ────────────────────────────────────────── */}
      <section className="border-b-4 border-white">
        <div className="mx-auto grid max-w-6xl grid-cols-1 gap-0 px-5 sm:grid-cols-3 sm:px-8">
          {[
            { k: "verify",  title: t(m, "landing.feat_verify_title"),  body: t(m, "landing.feat_verify_body") },
            { k: "i18n",    title: t(m, "landing.feat_i18n_title"),    body: t(m, "landing.feat_i18n_body") },
            { k: "gcp",     title: t(m, "landing.feat_gcp_title"),     body: t(m, "landing.feat_gcp_body") },
          ].map((c, i) => (
            <div
              key={c.k}
              className={"px-6 py-10 " + (i < 2 ? "border-b-4 sm:border-b-0 sm:border-r-4 border-white" : "")}
            >
              <div className="text-xs uppercase tracking-[0.3em] text-yellow-300">{`0${i + 1}`}</div>
              <h3 className="mt-2 text-xl font-black uppercase">{c.title}</h3>
              <p className="mt-3 text-sm leading-relaxed uppercase tracking-wide text-white/70">{c.body}</p>
            </div>
          ))}
        </div>
      </section>

      {/* ── 20 research domains ──────────────────────────────── */}
      <section className="border-b-4 border-white">
        <div className="mx-auto max-w-6xl px-5 py-10 sm:px-8 sm:py-16">
          <h2 className="text-2xl font-black uppercase tracking-tight sm:text-3xl">
            {t(m, "landing.domains_title")}{" "}
            <span className="text-yellow-300">/ {domains.length}</span>
          </h2>
          <p className="mt-3 text-xs uppercase tracking-[0.3em] text-white/60">
            ATOM · MATTER · CHIP · BIO · CHEMISTRY
          </p>
          <ul className="mt-8 grid grid-cols-2 gap-0 border-4 border-white sm:grid-cols-4">
            {domains.map((d) => (
              <li key={d.name} className="border border-white">
                <Link
                  href={`/${encodeURIComponent(d.name)}`}
                  className="block truncate px-4 py-4 text-sm font-black uppercase hover:bg-yellow-300 hover:text-black"
                  title={d.goal ?? d.name}
                >
                  {d.name}
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </section>

      {/* ── pricing teaser ───────────────────────────────────── */}
      <section className="border-b-4 border-white">
        <div className="mx-auto max-w-6xl px-5 py-10 sm:px-8 sm:py-16">
          <h2 className="text-2xl font-black uppercase tracking-tight sm:text-3xl">
            {t(m, "landing.pricing_title")}
          </h2>
          <div className="mt-8 grid grid-cols-1 gap-0 border-4 border-white sm:grid-cols-3">
            {TIERS.map((tier, i) => (
              <Link
                key={tier.id}
                href="/pricing"
                className={
                  "block border border-white px-6 py-8 " +
                  (tier.accent ? "bg-yellow-300 text-black" : "bg-black") +
                  " hover:bg-white hover:text-black"
                }
              >
                <div className="text-xs uppercase opacity-60" style={{ letterSpacing: "0.2em" }}>{`0${i + 1}`}</div>
                <div className="mt-1 text-xl font-black uppercase">{t(m, `pricing.${tier.id}`)}</div>
                <div className="mt-4 text-5xl font-black">
                  {tier.price}
                  <span className="text-base font-normal opacity-70"> / MO</span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ── final CTA ────────────────────────────────────────── */}
      <section className="bg-yellow-300 text-black">
        <div className="mx-auto flex max-w-6xl flex-col items-start gap-6 px-5 py-10 sm:flex-row sm:items-center sm:justify-between sm:px-8 sm:py-16">
          <h2 className="text-4xl font-black uppercase leading-none tracking-tighter sm:text-5xl">
            {t(m, "landing.cta_final")}<span className="text-black">.</span>
          </h2>
          <Link
            href="/signin"
            className="w-full border-4 border-black px-8 py-4 text-center text-base font-black uppercase hover:bg-black hover:text-yellow-300 sm:w-auto"
          >
            {t(m, "landing.cta_start")} &nbsp;▶
          </Link>
        </div>
      </section>
    </main>
  );
}
