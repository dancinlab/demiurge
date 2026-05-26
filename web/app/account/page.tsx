// /account — Server component reading the session cookie + Firestore
// subscription. Redirects to /signin if guest.

import Link from "next/link";
import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { getActiveSubscription } from "@/lib/firestore";
import { SignOutButton } from "./SignOutButton";

export const dynamic = "force-dynamic";

type TierMeta = {
  label: string;
  badge: string;
  pillClass: string;
};

const TIER_META: Record<string, TierMeta> = {
  solo: {
    label: "Solo",
    badge: "$29 / mo",
    pillClass: "bg-emerald-100 text-emerald-900 dark:bg-emerald-900/40 dark:text-emerald-200",
  },
  team: {
    label: "Team",
    badge: "$99 / mo · 5 seats",
    pillClass: "bg-sky-100 text-sky-900 dark:bg-sky-900/40 dark:text-sky-200",
  },
  org: {
    label: "Org",
    badge: "$299 / mo · 25 seats",
    pillClass:
      "bg-purple-100 text-purple-900 dark:bg-purple-900/40 dark:text-purple-200",
  },
};

function formatPeriodEnd(v: unknown): string | null {
  if (v instanceof Date && !Number.isNaN(v.getTime())) {
    return v.toISOString().slice(0, 10);
  }
  return null;
}

export default async function AccountPage() {
  const user = await currentUser();
  if (!user) redirect("/signin");

  const sub = await getActiveSubscription(user.localId);
  const tier =
    typeof sub?.tier === "string" && TIER_META[sub.tier as string]
      ? (sub.tier as keyof typeof TIER_META)
      : null;
  const meta = tier ? TIER_META[tier] : null;
  const periodEnd = formatPeriodEnd(sub?.currentPeriodEnd);

  return (
    <main className="mx-auto max-w-md px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← home
        </Link>
      </nav>
      <header className="mb-6 flex items-center justify-between gap-3">
        <h1 className="text-2xl font-bold">account</h1>
        {meta && (
          <span
            className={
              "rounded-full px-3 py-1 text-xs font-semibold " + meta.pillClass
            }
            title={meta.badge}
          >
            {meta.label}
          </span>
        )}
      </header>

      <section className="mb-6 rounded border border-neutral-200 bg-neutral-50 p-3 dark:border-neutral-800 dark:bg-neutral-900">
        <dl className="space-y-2 text-sm">
          <div className="flex justify-between">
            <dt className="text-neutral-500">email</dt>
            <dd>{user.email}</dd>
          </div>
          <div className="flex justify-between">
            <dt className="text-neutral-500">verified</dt>
            <dd>{user.emailVerified ? "✓" : "—"}</dd>
          </div>
          <div className="flex justify-between">
            <dt className="text-neutral-500">uid</dt>
            <dd className="text-xs">{user.localId}</dd>
          </div>
        </dl>
      </section>

      <section className="mb-6">
        <h2 className="mb-2 text-lg font-semibold">billing</h2>
        {meta ? (
          <div className="space-y-2">
            <p className="text-sm">
              <span className="font-semibold">{meta.label}</span> ·{" "}
              <span className="text-neutral-500">{meta.badge}</span>
            </p>
            {periodEnd && (
              <p className="text-xs text-neutral-500">
                갱신일: <span className="font-mono">{periodEnd}</span>
              </p>
            )}
            {typeof sub?.cancelAtPeriodEnd === "boolean" &&
              sub.cancelAtPeriodEnd && (
                <p className="text-xs text-amber-700 dark:text-amber-300">
                  ⚠ 기간 종료 후 자동 해지 예정
                </p>
              )}
            <p className="text-xs text-neutral-500">
              영수증 · 카드 변경 · 해지는 Stripe 빌링 포털에서 (다음 슬라이스에서
              현재 customer.id로 자동 redirect).
            </p>
          </div>
        ) : (
          <>
            <p className="mb-2 text-xs text-neutral-500">
              $29 Solo · $99 Team · $299 Org (월정액 · 14일 무료 trial)
            </p>
            <Link
              href="/pricing"
              className="inline-block rounded bg-neutral-900 px-3 py-1 text-sm text-white dark:bg-neutral-100 dark:text-neutral-900"
            >
              요금제 선택 →
            </Link>
          </>
        )}
      </section>

      <SignOutButton />
    </main>
  );
}
