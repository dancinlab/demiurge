import type { NextConfig } from "next";
import path from "node:path";

// `output: standalone` ships only the runtime files Cloud Run needs.
// `outputFileTracingRoot` is the demiurge repo root (one level above
// web/) so the standalone tracer picks up the data files we read at
// request time — DOMAINS.tape, domains/*.md, exports/**.
const REPO_ROOT = path.resolve(__dirname, "..");

const nextConfig: NextConfig = {
  output: "standalone",
  outputFileTracingRoot: REPO_ROOT,
  outputFileTracingIncludes: {
    "/**": [
      "../DOMAINS.tape",
      "../domains/*.md",
      "../*.md",
    ],
  },
};

export default nextConfig;
