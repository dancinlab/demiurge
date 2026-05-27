"use client";

import { useState } from "react";

export function SignOutButton({ label }: { label: string }) {
  const [loading, setLoading] = useState(false);

  async function signOut() {
    setLoading(true);
    try {
      await fetch("/api/auth/signout", { method: "POST" });
    } finally {
      window.location.href = "/";
    }
  }

  return (
    <button
      onClick={signOut}
      disabled={loading}
      className="rounded border border-neutral-300 px-3 py-1 text-sm hover:bg-neutral-100 disabled:opacity-40 dark:border-neutral-700 dark:hover:bg-neutral-800"
    >
      {loading ? "..." : label}
    </button>
  );
}
