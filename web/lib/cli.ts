// demiurge CLI subprocess invocation helper.
//
// d4: Web GUI never reimplements verb logic; every action shells out to
// `demiurge cli`. d3: hexa-lang/stdlib stays canonical-home; web reads
// only via CLI stdout or exports/** typed records.
//
// Resolution order for the binary:
//   1. $DEMIURGE_BIN
//   2. `demiurge` on PATH (looked up at spawn time)
//   3. dev fallback: cockpit/.build/debug/DemiurgeCLI
//   4. dev fallback: cockpit/.build/release/DemiurgeCLI
//
// Anything reading stdin/stdout outside of this helper is a smell.

import { spawn } from "node:child_process";
import path from "node:path";
import fs from "node:fs";

const REPO_ROOT = path.resolve(process.cwd(), "..");

function resolveBinary(): string {
  const env = process.env.DEMIURGE_BIN;
  if (env && fs.existsSync(env)) return env;

  const dev = [
    path.join(REPO_ROOT, "cockpit", ".build", "release", "DemiurgeCLI"),
    path.join(REPO_ROOT, "cockpit", ".build", "debug", "DemiurgeCLI"),
  ];
  for (const p of dev) {
    if (fs.existsSync(p)) return p;
  }
  return "demiurge"; // PATH lookup
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
  const bin = resolveBinary();
  const timeoutMs = opts.timeoutMs ?? 30_000;

  return new Promise((resolve, reject) => {
    const proc = spawn(bin, args, { cwd: REPO_ROOT });
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
  const bin = resolveBinary();
  const proc = spawn(bin, args, { cwd: REPO_ROOT });

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
