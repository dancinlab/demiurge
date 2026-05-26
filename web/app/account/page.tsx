// /account — Server component reading the session cookie.
// Redirects to /signin if guest. Stripe billing surface lands in M16c.

import Link from "next/link";
import { redirect } from "next/navigation";
import { currentUser } from "@/lib/session";
import { SignOutButton } from "./SignOutButton";

export const dynamic = "force-dynamic";

export default async function AccountPage() {
  const user = await currentUser();
  if (!user) redirect("/signin");

  return (
    <main className="mx-auto max-w-md px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← home
        </Link>
      </nav>
      <header className="mb-6">
        <h1 className="text-2xl font-bold">account</h1>
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
        <p className="mb-2 text-xs text-neutral-500">
          $29 Solo · $99 Team · $299 Org (월정액 · 14일 무료 trial)
        </p>
        <Link
          href="/pricing"
          className="inline-block rounded bg-neutral-900 px-3 py-1 text-sm text-white dark:bg-neutral-100 dark:text-neutral-900"
        >
          요금제 선택 →
        </Link>
        <p className="mt-2 text-xs text-neutral-500">
          구독 후 영수증 · 카드 변경 · 해지는 Stripe 빌링 포털에서 (M17에서
          현재 customer.id를 Firestore에서 lookup하여 자동 노출).
        </p>
      </section>

      <SignOutButton />
    </main>
  );
}
