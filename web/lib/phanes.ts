// Phanes bridge — discover (8th verb) subprocess wrapper.
// CLAUDE.md @I = "demiurge cli discover" 8th verb · phanes binary is the canonical home.
// PHANES_BIN env var overrides; defaults to "phanes" on PATH. Falls back to a
// deterministic stub tree when the binary is missing — keeps the discover slot
// non-broken in dev/preview environments.

import { spawn } from "node:child_process";

export type DiscoverNode = { label: string; children?: DiscoverNode[] };

function stubTree(seed: string): DiscoverNode {
  return {
    label: `seed: ${seed}`,
    children: [
      { label: "🚀 kick · alternative substrate" },
      { label: "🚀 kick · scale-down knob" },
      { label: "🕳 gap · missing closed-form" },
      { label: "🕳 gap · external dataset dep" },
    ],
  };
}

function runPhanes(seed: string, rounds: number): Promise<string> {
  return new Promise((resolve, reject) => {
    const bin = process.env.PHANES_BIN ?? "phanes";
    const child = spawn(
      bin,
      ["discover", "--seed", seed, "--rounds", String(rounds), "--format", "json"],
      { stdio: ["ignore", "pipe", "pipe"] },
    );
    let out = "";
    let err = "";
    child.stdout.on("data", (b: Buffer) => (out += b.toString()));
    child.stderr.on("data", (b: Buffer) => (err += b.toString()));
    child.on("error", reject);
    child.on("close", (code) => {
      if (code === 0) resolve(out);
      else reject(new Error(`phanes exit ${code}: ${err.slice(0, 300)}`));
    });
  });
}

export async function discover(
  seed: string,
  rounds: number = 3,
): Promise<{ tree: DiscoverNode; source: "phanes" | "stub" }> {
  try {
    const stdout = await runPhanes(seed, rounds);
    const parsed = JSON.parse(stdout) as DiscoverNode;
    return { tree: parsed, source: "phanes" };
  } catch {
    return { tree: stubTree(seed), source: "stub" };
  }
}
