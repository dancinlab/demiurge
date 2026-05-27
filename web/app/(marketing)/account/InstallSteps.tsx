"use client";

import { useState } from "react";

const STEPS = [
  {
    num: "01",
    label: "install hexa-lang  (gives you 'hexa' + 'hx' package manager)",
    cmd: '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dancinlab/hexa-lang/main/install.sh)"',
  },
  {
    num: "02",
    label: "install demiurge",
    cmd: "hx install demiurge",
  },
  {
    num: "03",
    label: "authenticate  (paste the token below)",
    cmd: "demiurge auth login --token <DEMIURGE_PAT>",
  },
  {
    num: "04",
    label: "run any verb",
    cmd: 'demiurge cli discover "high-Tc ambient-pressure RTSC"',
  },
];

export function InstallSteps() {
  const [copied, setCopied] = useState<string | null>(null);

  async function copy(num: string, cmd: string) {
    try {
      await navigator.clipboard.writeText(cmd);
      setCopied(num);
      setTimeout(() => setCopied((c) => (c === num ? null : c)), 1500);
    } catch {
      // clipboard API blocked — fall back: select via text node
      const range = document.createRange();
      const node = document.getElementById(`cmd-${num}`);
      if (node) {
        range.selectNodeContents(node);
        const sel = window.getSelection();
        sel?.removeAllRanges();
        sel?.addRange(range);
      }
    }
  }

  return (
    <div className="space-y-2">
      {STEPS.map((s) => {
        const isCopied = copied === s.num;
        return (
          <div
            key={s.num}
            className="border-4 border-white bg-black"
          >
            <div className="flex items-center gap-3 border-b-2 border-white/30 px-4 py-2 text-[10px] font-black uppercase tracking-[0.3em] text-white/70">
              <span className="text-yellow-300">{s.num}</span>
              <span>{s.label}</span>
            </div>
            <div className="flex items-center gap-3 px-4 py-3">
              <code
                id={`cmd-${s.num}`}
                className="flex-1 overflow-x-auto whitespace-nowrap font-mono text-xs leading-loose text-yellow-300"
              >
                {s.cmd}
              </code>
              <button
                onClick={() => copy(s.num, s.cmd)}
                className={
                  "shrink-0 border-2 px-3 py-1.5 text-[10px] font-black uppercase tracking-[0.2em] transition-colors " +
                  (isCopied
                    ? "border-yellow-300 bg-yellow-300 text-black"
                    : "border-white text-white hover:bg-yellow-300 hover:text-black hover:border-yellow-300")
                }
                aria-label={isCopied ? "copied" : "copy command"}
              >
                {isCopied ? "✓ COPIED" : "COPY"}
              </button>
            </div>
          </div>
        );
      })}
    </div>
  );
}
