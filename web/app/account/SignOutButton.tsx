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
      className="border-4 border-white bg-black px-4 py-2 text-xs font-black uppercase tracking-[0.2em] text-white hover:bg-yellow-300 hover:text-black disabled:opacity-40"
    >
      {loading ? "..." : label}
    </button>
  );
}
