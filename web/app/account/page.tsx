// /account — Tabbed account surface (profile · billing · cli · usage).
// Server component; auth-gated. Tab state lives in ?tab= search param so
// reloads + bookmarks are stable.

import Link from "next/link";
import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { getActiveSubscription } from "@/lib/firestore";
import { getMessages, t } from "@/lib/i18n";
import { SignOutButton } from "./SignOutButton";

export const dynamic = "force-dynamic";

type TabId = "profile" | "billing" | "cli" | "usage";
const TABS: TabId[] = ["profile", "billing", "cli", "usage"];

type TierMeta = { badge: string; labelKey: string };
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

function pickTab(raw: unknown): TabId {
  return TABS.includes(raw as TabId) ? (raw as TabId) : "profile";
}

export default async function AccountPage({
  searchParams,
}: {
  searchParams: Promise<{ tab?: string }>;
}) {
  const [user, m, sp] = await Promise.all([
    currentUser(),
    getMessages(),
    searchParams,
  ]);
  if (!user) redirect("/signin");

  const tab = pickTab(sp.tab);
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
      <div className="mx-auto max-w-4xl px-8 py-16">
        <nav className="mb-10 text-xs uppercase tracking-[0.3em] text-white/70">
          <Link href="/" className="hover:text-yellow-300">
            {t(m, "nav.back_home")}
          </Link>
          <span className="px-3 text-white/40">//</span>
          <Link href="/dashboard" className="hover:text-yellow-300">
            DASHBOARD
          </Link>
        </nav>

        <header className="flex items-end justify-between gap-6">
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

        {/* tab bar — Brutalist 4px chip row */}
        <nav className="mt-10 flex flex-wrap gap-0 border-4 border-white">
          {TABS.map((id, idx) => {
            const active = id === tab;
            return (
              <Link
                key={id}
                href={id === "profile" ? "/account" : `/account?tab=${id}`}
                className={
                  "flex-1 border-white px-4 py-3 text-center text-xs font-black uppercase tracking-[0.2em] " +
                  (idx < TABS.length - 1 ? "border-r-4 " : "") +
                  (active
                    ? "bg-yellow-300 text-black"
                    : "bg-black text-white/70 hover:bg-white/10 hover:text-yellow-300")
                }
              >
                {t(m, `account.tab_${id}`)}
              </Link>
            );
          })}
        </nav>

        <div className="mt-10">
          {tab === "profile" && (
            <ProfilePanel user={user} m={m} />
          )}
          {tab === "billing" && (
            <BillingPanel
              meta={meta}
              tierLabel={tierLabel}
              periodEnd={periodEnd}
              cancelAtPeriodEnd={Boolean(sub?.cancelAtPeriodEnd)}
              m={m}
            />
          )}
          {tab === "cli" && <CliPanel m={m} />}
          {tab === "usage" && <UsagePanel m={m} meta={meta} />}
        </div>

        <div className="mt-12 border-t-4 border-white pt-6">
          <SignOutButton label={t(m, "account.signout")} />
        </div>
      </div>
    </main>
  );
}

// ---------- panel components (server, render-only) ----------

type User = { email?: string | null; localId: string; emailVerified?: boolean };
type Msgs = Awaited<ReturnType<typeof getMessages>>;

function ProfilePanel({ user, m }: { user: User; m: Msgs }) {
  return (
    <section className="border-4 border-white">
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
          {user.emailVerified ? <span className="text-yellow-300">✓</span> : "—"}
        </span>
      </div>
      <div className="flex items-center justify-between px-4 py-3">
        <span className="text-xs font-black uppercase tracking-[0.2em] text-white/70">
          {t(m, "account.uid")}
        </span>
        <span className="font-mono text-xs">{user.localId}</span>
      </div>
    </section>
  );
}

function BillingPanel({
  meta,
  tierLabel,
  periodEnd,
  cancelAtPeriodEnd,
  m,
}: {
  meta: TierMeta | null;
  tierLabel: string | null;
  periodEnd: string | null;
  cancelAtPeriodEnd: boolean;
  m: Msgs;
}) {
  if (meta && tierLabel) {
    return (
      <section className="space-y-3 border-l-4 border-white pl-4">
        <p className="text-base uppercase tracking-wide">
          <span className="font-black">{tierLabel}</span>
          <span className="px-3 text-white/40">//</span>
          <span className="text-white/70">{meta.badge}</span>
        </p>
        {periodEnd && (
          <p className="text-xs uppercase tracking-wide text-white/70">
            {t(m, "account.renewal")}: <span className="font-mono text-white">{periodEnd}</span>
          </p>
        )}
        {cancelAtPeriodEnd && (
          <p className="text-xs uppercase tracking-wide text-yellow-300">
            {t(m, "account.cancel_warning")}
          </p>
        )}
        <p className="text-xs uppercase tracking-wide text-white/70">
          {t(m, "account.portal_note")}
        </p>
      </section>
    );
  }
  return (
    <section>
      <p className="mb-4 border-l-4 border-white pl-4 text-xs uppercase tracking-wide text-white/70">
        {t(m, "account.no_sub_tagline")}
      </p>
      <Link
        href="/pricing"
        className="inline-block border-4 border-white bg-yellow-300 px-6 py-3 text-sm font-black uppercase text-black hover:bg-white"
      >
        {t(m, "account.pick_plan")} ▶
      </Link>
    </section>
  );
}

function CliPanel({ m }: { m: Msgs }) {
  return (
    <section className="space-y-6">
      <p className="border-l-4 border-white pl-4 text-xs uppercase tracking-wide text-white/70">
        {t(m, "account.cli_intro")}
      </p>

      <pre className="overflow-x-auto border-4 border-white bg-black p-4 font-mono text-xs leading-relaxed text-yellow-300">{`# install\nnpm i -g @demiurge/cli\n\n# authenticate (paste the token below)\ndemiurge auth login --token <DEMIURGE_PAT>\n\n# run any verb\ndemiurge cli discover "high-Tc ambient-pressure RTSC"`}</pre>

      <div className="border-4 border-white">
        <div className="flex items-center justify-between border-b-4 border-white bg-yellow-300 px-4 py-2 text-[10px] font-black uppercase tracking-[0.3em] text-black">
          <span>{t(m, "account.cli_keys_heading")}</span>
          <button
            disabled
            className="border-2 border-black bg-black px-3 py-1 text-[10px] font-black uppercase tracking-[0.2em] text-yellow-300 opacity-50"
            title="coming soon"
          >
            + {t(m, "account.cli_new_key")}
          </button>
        </div>
        <div className="px-4 py-6 text-center text-xs uppercase tracking-wide text-white/50">
          {t(m, "account.cli_no_keys")}
        </div>
      </div>

      <p className="text-[10px] uppercase tracking-wide text-white/50">
        {t(m, "account.cli_disclaimer")}
      </p>
    </section>
  );
}

function UsagePanel({ m, meta }: { m: Msgs; meta: TierMeta | null }) {
  const rows = [
    { k: "gemini_tokens",  unit: "tokens",  used: "—", limit: meta ? "included*" : "—" },
    { k: "cloud_run_cpu",  unit: "vCPU-hr", used: "—", limit: "GCP usage"   },
    { k: "gpu_hours",      unit: "hr",      used: "—", limit: "GCP usage"   },
    { k: "tpu_hours",      unit: "chip-hr", used: "—", limit: "GCP usage"   },
    { k: "bigquery_scan",  unit: "TB",      used: "—", limit: "GCP usage"   },
    { k: "storage",        unit: "GB-mo",   used: "—", limit: "GCP usage"   },
  ];
  return (
    <section className="space-y-6">
      <p className="border-l-4 border-white pl-4 text-xs uppercase tracking-wide text-white/70">
        {t(m, "account.usage_intro")}
      </p>
      <div className="border-4 border-white">
        <div className="grid grid-cols-[1fr_auto_auto] items-center border-b-4 border-white bg-yellow-300 px-4 py-2 text-[10px] font-black uppercase tracking-[0.3em] text-black">
          <span>{t(m, "account.usage_col_resource")}</span>
          <span className="px-6">{t(m, "account.usage_col_used")}</span>
          <span className="text-right">{t(m, "account.usage_col_limit")}</span>
        </div>
        {rows.map((r, i) => (
          <div
            key={r.k}
            className={
              "grid grid-cols-[1fr_auto_auto] items-center px-4 py-3 text-xs uppercase tracking-wide " +
              (i < rows.length - 1 ? "border-b border-white/30 " : "")
            }
          >
            <div>
              <div className="font-black text-white">{t(m, `account.usage_row_${r.k}`)}</div>
              <div className="mt-0.5 text-[10px] normal-case tracking-normal text-white/50">{r.unit}</div>
            </div>
            <span className="px-6 font-mono text-white/70">{r.used}</span>
            <span className="text-right font-black text-yellow-300">{r.limit}</span>
          </div>
        ))}
      </div>
      <p className="text-[10px] uppercase tracking-wide text-white/50">
        {t(m, "account.usage_disclaimer")}
      </p>
    </section>
  );
}
