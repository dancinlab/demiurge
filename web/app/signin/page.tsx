// Sign-in page. Server shell + client form. Toggles between sign-in
// and sign-up via tab.

import Link from "next/link";
import { SignInForm } from "./SignInForm";

export const dynamic = "force-dynamic";

export default function SignInPage() {
  return (
    <main className="mx-auto max-w-md px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          ← home
        </Link>
      </nav>
      <header className="mb-6">
        <h1 className="text-2xl font-bold">sign in / up</h1>
        <p className="mt-1 text-xs text-neutral-500">
          Firebase Auth via REST · httpOnly session cookie (token 노출 없음)
        </p>
      </header>
      <SignInForm />
      <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
        XPRIZE 매출 surface 전제 — 결제는 sign-in 후 /account에서.
      </footer>
    </main>
  );
}
