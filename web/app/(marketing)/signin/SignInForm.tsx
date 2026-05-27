"use client";

import { useState } from "react";

type Mode = "signin" | "signup";

export type SignInLabels = {
  tabSignin: string;
  tabSignup: string;
  email: string;
  password: string;
  passwordHint: string;
  submitSignin: string;
  submitSignup: string;
  loading: string;
  errorRequired: string;
};

export function SignInForm({ labels }: { labels: SignInLabels }) {
  const [mode, setMode] = useState<Mode>("signin");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    if (!email || !password) {
      setError(labels.errorRequired);
      return;
    }
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/auth/${mode}`, {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ email, password }),
      });
      const data = (await res.json()) as { ok?: boolean; error?: string };
      if (!res.ok || data.error) {
        setError(data.error ?? `http ${res.status}`);
      } else {
        window.location.href = "/account";
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex gap-0 border-b-4 border-white">
        {(["signin", "signup"] as Mode[]).map((m) => (
          <button
            key={m}
            onClick={() => {
              setMode(m);
              setError(null);
            }}
            className={
              "px-4 py-2 text-xs font-black uppercase tracking-[0.2em] " +
              (mode === m
                ? "bg-yellow-300 text-black"
                : "bg-black text-white/60 hover:text-yellow-300")
            }
          >
            {m === "signin" ? labels.tabSignin : labels.tabSignup}
          </button>
        ))}
      </div>
      <form onSubmit={submit} className="space-y-4">
        <div>
          <label className="block text-xs font-black uppercase tracking-[0.2em] text-white/70">{labels.email}</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            autoComplete="email"
            disabled={loading}
            className="mt-2 w-full border-4 border-white bg-black p-3 font-mono text-sm text-white focus:border-yellow-300 focus:outline-none"
          />
        </div>
        <div>
          <label className="block text-xs font-black uppercase tracking-[0.2em] text-white/70">
            {labels.password}{" "}
            {mode === "signup" && (
              <span className="text-white/40">{labels.passwordHint}</span>
            )}
          </label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            autoComplete={mode === "signin" ? "current-password" : "new-password"}
            disabled={loading}
            className="mt-2 w-full border-4 border-white bg-black p-3 font-mono text-sm text-white focus:border-yellow-300 focus:outline-none"
          />
        </div>
        {error && (
          <div className="border-l-4 border-yellow-300 bg-black p-3 text-xs uppercase tracking-wide text-yellow-300">
            {error}
          </div>
        )}
        <button
          type="submit"
          disabled={loading}
          className="w-full border-4 border-white bg-yellow-300 px-4 py-3 text-sm font-black uppercase text-black hover:bg-white disabled:opacity-40"
        >
          {loading
            ? labels.loading
            : mode === "signin"
              ? labels.submitSignin
              : labels.submitSignup}
        </button>
      </form>
    </div>
  );
}
