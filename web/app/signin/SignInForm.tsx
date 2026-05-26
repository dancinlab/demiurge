"use client";

import { useState } from "react";

type Mode = "signin" | "signup";

export function SignInForm() {
  const [mode, setMode] = useState<Mode>("signin");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    if (!email || !password) {
      setError("email + password 필수");
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
    <div className="space-y-4">
      <div className="flex gap-1 border-b border-neutral-200 dark:border-neutral-800">
        {(["signin", "signup"] as Mode[]).map((m) => (
          <button
            key={m}
            onClick={() => {
              setMode(m);
              setError(null);
            }}
            className={
              "px-3 py-1 text-sm " +
              (mode === m
                ? "border-b-2 border-neutral-900 font-semibold dark:border-neutral-100"
                : "text-neutral-500 hover:text-neutral-900 dark:hover:text-neutral-100")
            }
          >
            {m === "signin" ? "sign in" : "sign up"}
          </button>
        ))}
      </div>
      <form onSubmit={submit} className="space-y-3">
        <div>
          <label className="block text-xs text-neutral-500">email</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            autoComplete="email"
            disabled={loading}
            className="mt-1 w-full rounded border border-neutral-300 bg-white p-2 font-mono text-sm dark:border-neutral-700 dark:bg-neutral-950"
          />
        </div>
        <div>
          <label className="block text-xs text-neutral-500">
            password{" "}
            {mode === "signup" && (
              <span className="text-neutral-400">(≥6 chars)</span>
            )}
          </label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            autoComplete={mode === "signin" ? "current-password" : "new-password"}
            disabled={loading}
            className="mt-1 w-full rounded border border-neutral-300 bg-white p-2 font-mono text-sm dark:border-neutral-700 dark:bg-neutral-950"
          />
        </div>
        {error && (
          <div className="rounded border border-red-300 bg-red-50 p-2 text-xs text-red-900 dark:border-red-800 dark:bg-red-950/40 dark:text-red-200">
            {error}
          </div>
        )}
        <button
          type="submit"
          disabled={loading}
          className="w-full rounded bg-neutral-900 px-3 py-2 text-sm text-white disabled:opacity-40 dark:bg-neutral-100 dark:text-neutral-900"
        >
          {loading ? "..." : mode === "signin" ? "sign in" : "create account"}
        </button>
      </form>
    </div>
  );
}
