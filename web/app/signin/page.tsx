// Sign-in page. Server shell + client form. Toggles between sign-in
// and sign-up via tab. Mono / Terminal tone (sample 1).

import Link from "next/link";
import { getMessages, t } from "@/lib/i18n";
import { SignInForm } from "./SignInForm";

export const dynamic = "force-dynamic";

export default async function SignInPage() {
  const m = await getMessages();
  return (
    <main className="min-h-screen bg-white font-mono text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
      <div className="mx-auto max-w-md px-8 py-16">
        <nav className="mb-6 text-xs text-neutral-500">
          <Link href="/" className="underline">
            {t(m, "nav.back_home")}
          </Link>
        </nav>

        <header className="mb-8">
          <span className="inline-block rounded border border-neutral-300 px-2 py-0.5 text-xs text-neutral-600 dark:border-neutral-700 dark:text-neutral-400">
            sign-in
          </span>
          <h1 className="mt-4 text-3xl font-bold tracking-tight">{t(m, "signin.title")}</h1>
          <p className="mt-3 text-sm leading-relaxed text-neutral-600 dark:text-neutral-400">
            {t(m, "signin.subtitle")}
          </p>
        </header>

        <SignInForm
          labels={{
            tabSignin: t(m, "signin.tab_signin"),
            tabSignup: t(m, "signin.tab_signup"),
            email: t(m, "signin.email"),
            password: t(m, "signin.password"),
            passwordHint: t(m, "signin.password_hint"),
            submitSignin: t(m, "signin.submit_signin"),
            submitSignup: t(m, "signin.submit_signup"),
            loading: t(m, "signin.loading"),
            errorRequired: t(m, "signin.error_required"),
          }}
        />

        <footer className="mt-10 border-t border-neutral-200 pt-4 text-xs text-neutral-500 dark:border-neutral-800">
          {t(m, "signin.footer")}
        </footer>
      </div>
    </main>
  );
}
