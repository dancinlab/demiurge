// /pricing — public pricing page. Stripe Checkout buttons require
// sign-in; we route through /signin if guest.

import Link from "next/link";
import { TIERS } from "@/lib/billing";
import { currentUser } from "@/lib/session";
import { CheckoutButton } from "./CheckoutButton";

export const dynamic = "force-dynamic";

export default async function PricingPage() {
  const user = await currentUser();

  return (
    <main className="mx-auto max-w-5xl px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← home
        </Link>
        {user ? (
          <>
            {" "}
            ·{" "}
            <Link href="/account" className="underline">
              account
            </Link>
          </>
        ) : (
          <>
            {" "}
            ·{" "}
            <Link href="/signin" className="underline">
              sign in
            </Link>
          </>
        )}
      </nav>

      <header className="mb-8">
        <h1 className="text-2xl font-bold">pricing</h1>
        <p className="mt-1 text-xs text-neutral-500">
          월정액 · 14일 무료 trial · 카드 등록만, 첫 결제는 trial 종료 후
        </p>
      </header>

      <section className="grid grid-cols-1 gap-4 md:grid-cols-3">
        {TIERS.map((t) => (
          <div
            key={t.id}
            className="flex flex-col rounded border border-neutral-200 bg-neutral-50 p-4 dark:border-neutral-800 dark:bg-neutral-900"
          >
            <h2 className="text-xl font-bold">{t.label}</h2>
            <p className="mt-1 text-3xl font-bold">
              ${t.monthlyUsd}
              <span className="text-sm font-normal text-neutral-500">
                {" "}
                / mo
              </span>
            </p>
            <ul className="mt-3 flex-1 space-y-1 text-xs">
              {t.highlights.map((h) => (
                <li key={h}>· {h}</li>
              ))}
            </ul>
            <div className="mt-4">
              {user ? (
                <CheckoutButton tier={t.id} label={`${t.label} 시작`} />
              ) : (
                <Link
                  href={`/signin?next=/pricing`}
                  className="block w-full rounded bg-neutral-900 px-3 py-2 text-center text-sm text-white dark:bg-neutral-100 dark:text-neutral-900"
                >
                  sign in 후 시작
                </Link>
              )}
            </div>
          </div>
        ))}
      </section>

      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        결제 = Stripe · related-party 라벨링은 webhook 적재 후 회계 단계에서.
        XPRIZE 매출 증빙은 월별 P&L에 자동 반영 (M17 Firestore).
      </footer>
    </main>
  );
}
