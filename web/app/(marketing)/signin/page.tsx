// Sign-in page. Server shell + client form. Toggles between sign-in
// and sign-up via tab. Brutalist tone (matches landing).

import Link from "next/link";
import { getMessages, t } from "@/lib/i18n";
import { SignInForm } from "./SignInForm";

export const dynamic = "force-dynamic";

export default async function SignInPage() {
  const m = await getMessages();
  return (
    <main className="min-h-screen bg-black text-white">
      <div className="mx-auto max-w-md px-5 py-10 sm:px-8 sm:py-16">
        <nav className="mb-10 text-xs uppercase tracking-[0.3em] text-white/70">
          <Link href="/" className="hover:text-yellow-300">
            {t(m, "nav.back_home")}
          </Link>
        </nav>

        <div className="overflow-x-auto border-y-4 border-white py-2 text-[10px] uppercase sm:text-xs" style={{ letterSpacing: "0.3em" }}>
          <span className="whitespace-nowrap sm:tracking-[0.4em]">ENTER&nbsp;&nbsp;//&nbsp;&nbsp;THE&nbsp;&nbsp;LOOP</span>
        </div>

        <h1 className="mt-8 text-[clamp(48px,15vw,64px)] font-black uppercase leading-[0.85] tracking-tighter sm:mt-10">
          {t(m, "signin.title")}
          <span className="text-yellow-300">.</span>
        </h1>
        <p className="mt-6 border-l-4 border-white pl-4 text-sm uppercase tracking-wide sm:text-base">
          {t(m, "signin.subtitle")}
        </p>

        <section className="mt-12">
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
        </section>

        <footer className="mt-12 border-t-4 border-white pt-4 text-xs uppercase tracking-wide text-white/70">
          {t(m, "signin.footer")}
        </footer>
      </div>
    </main>
  );
}
