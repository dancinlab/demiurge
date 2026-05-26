// Sign-in page. Server shell + client form. Toggles between sign-in
// and sign-up via tab.

import Link from "next/link";
import { getMessages, t } from "@/lib/i18n";
import { SignInForm } from "./SignInForm";

export const dynamic = "force-dynamic";

export default async function SignInPage() {
  const m = await getMessages();
  return (
    <main className="mx-auto max-w-md px-6 py-10 font-mono">
      <nav className="mb-4 text-xs text-neutral-500">
        <Link href="/" className="underline">
          {t(m, "nav.back_home")}
        </Link>
      </nav>
      <header className="mb-6">
        <h1 className="text-2xl font-bold">{t(m, "signin.title")}</h1>
        <p className="mt-1 text-xs text-neutral-500">{t(m, "signin.subtitle")}</p>
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
    </main>
  );
}
