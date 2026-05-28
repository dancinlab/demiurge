// demiurge CLI subprocess invocation helper.
//
// d4: Web GUI never reimplements verb logic; every action shells out to
// `demiurge cli`. d3: hexa-lang/stdlib stays canonical-home; web reads
// only via CLI stdout or exports/** typed records.
//
// Resolution order for the binary:
//   1. $DEMIURGE_BIN
//   2. dev fallback: <repo>/cockpit/.build/{release,debug}/DemiurgeCLI
//   3. dev fallback: any sibling demiurge*/cockpit/.build/… (the localdev
//      clone ships no compiled CLI; reuse the canonical checkout's build)
//   4. `demiurge` on PATH (looked up at spawn time) — the hx WRAPPER, which
//      needs a leading `cli` subcommand (handled by spawnArgs() below).
//
// resolveBinary() returns { bin, wrapper }. When `wrapper` is true the bin is
// the PATH `demiurge` shim (`demiurge cli <args…>`), so spawnArgs() prepends
// "cli"; when false the bin is a DemiurgeCLI binary invoked with args directly.
//
// Anything reading stdin/stdout outside of this helper is a smell.

import { spawn } from "node:child_process";
import path from "node:path";
import fs from "node:fs";

const REPO_ROOT = path.resolve(process.cwd(), "..");

type Resolved = { bin: string; wrapper: boolean };

function buildPaths(root: string): string[] {
  return [
    path.join(root, "cockpit", ".build", "release", "DemiurgeCLI"),
    path.join(root, "cockpit", ".build", "debug", "DemiurgeCLI"),
  ];
}

function resolveBinary(): Resolved {
  const env = process.env.DEMIURGE_BIN;
  if (env && fs.existsSync(env)) return { bin: env, wrapper: false };

  // (2) this repo's own build, then (3) any sibling demiurge* checkout that
  // carries a compiled DemiurgeCLI (the localdev tree typically has none).
  const candidates = [...buildPaths(REPO_ROOT)];
  try {
    const parent = path.resolve(REPO_ROOT, "..");
    for (const sib of fs.readdirSync(parent)) {
      if (!sib.startsWith("demiurge")) continue;
      const sibRoot = path.join(parent, sib);
      if (sibRoot === REPO_ROOT) continue;
      candidates.push(...buildPaths(sibRoot));
    }
  } catch {
    /* parent unreadable — skip sibling probe */
  }
  for (const p of candidates) {
    if (fs.existsSync(p)) return { bin: p, wrapper: false };
  }

  return { bin: "demiurge", wrapper: true }; // PATH lookup (hx wrapper)
}

function spawnArgs(resolved: Resolved, args: string[]): string[] {
  return resolved.wrapper ? ["cli", ...args] : args;
}

export type CliResult = {
  stdout: string;
  stderr: string;
  exitCode: number;
};

export async function runCli(
  args: string[],
  opts: { timeoutMs?: number; stdin?: string } = {}
): Promise<CliResult> {
  const resolved = resolveBinary();
  const timeoutMs = opts.timeoutMs ?? 30_000;

  return new Promise((resolve, reject) => {
    const proc = spawn(resolved.bin, spawnArgs(resolved, args), { cwd: REPO_ROOT });
    let stdout = "";
    let stderr = "";

    proc.stdout.on("data", (d) => (stdout += d.toString()));
    proc.stderr.on("data", (d) => (stderr += d.toString()));

    const timer = setTimeout(() => {
      proc.kill("SIGTERM");
      reject(new Error(`demiurge cli timeout after ${timeoutMs}ms (args: ${args.join(" ")})`));
    }, timeoutMs);

    proc.on("error", (err) => {
      clearTimeout(timer);
      reject(err);
    });

    proc.on("close", (code) => {
      clearTimeout(timer);
      resolve({ stdout, stderr, exitCode: code ?? -1 });
    });

    if (opts.stdin !== undefined) {
      proc.stdin.write(opts.stdin);
      proc.stdin.end();
    }
  });
}

export async function* streamCli(
  args: string[]
): AsyncGenerator<{ kind: "stdout" | "stderr" | "exit"; data: string | number }> {
  const resolved = resolveBinary();
  const proc = spawn(resolved.bin, spawnArgs(resolved, args), { cwd: REPO_ROOT });

  const queue: Array<{ kind: "stdout" | "stderr" | "exit"; data: string | number }> = [];
  let resolveNext: (() => void) | null = null;
  let done = false;

  const push = (item: typeof queue[number]) => {
    queue.push(item);
    if (resolveNext) {
      const r = resolveNext;
      resolveNext = null;
      r();
    }
  };

  proc.stdout.on("data", (d) => push({ kind: "stdout", data: d.toString() }));
  proc.stderr.on("data", (d) => push({ kind: "stderr", data: d.toString() }));
  proc.on("close", (code) => {
    push({ kind: "exit", data: code ?? -1 });
    done = true;
    if (resolveNext) {
      const r = resolveNext;
      resolveNext = null;
      r();
    }
  });

  while (!done || queue.length > 0) {
    if (queue.length === 0) {
      await new Promise<void>((res) => (resolveNext = res));
      continue;
    }
    yield queue.shift()!;
  }
}
