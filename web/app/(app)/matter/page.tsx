// /matter — material attestation/verdict ledger (CLAUDE.md d_paper_*).
// Read-only public surface · ⚖️ absorbed? gate state.

import { readMatterLedger } from "@/lib/matter";

export const dynamic = "force-dynamic";

export default async function MatterPage() {
  const rows = await readMatterLedger();
  return (
    <main className="mx-auto max-w-5xl px-6 py-10">
      <header className="mb-6">
        <h1 className="text-2xl font-bold">⚖️ matter — attestation / verdict ledger</h1>
        <p className="mt-1 text-sm text-neutral-500">
          per-material absorbed? gate · CLAUDE.md d_paper_* SSOT
        </p>
      </header>
      {rows.length === 0 ? (
        <p className="text-sm text-neutral-500">
          exports/material_{`{attestation,verdict}`}/ 디렉터리에 아직 기록이 없습니다.
        </p>
      ) : (
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b border-neutral-300 text-left text-xs uppercase text-neutral-500 dark:border-neutral-700">
              <th className="py-2">material</th>
              <th>kind</th>
              <th>absorbed</th>
              <th>gate</th>
              <th>file</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r, i) => (
              <tr key={i} className="border-b border-neutral-200 dark:border-neutral-800">
                <td className="py-1 font-bold">{r.material}</td>
                <td>{r.kind}</td>
                <td>
                  {r.absorbed === true ? "🟢 true" : r.absorbed === false ? "🟠 false" : "—"}
                </td>
                <td className="font-mono text-xs">{r.measurement_gate ?? "—"}</td>
                <td className="font-mono text-xs">{r.file}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </main>
  );
}
