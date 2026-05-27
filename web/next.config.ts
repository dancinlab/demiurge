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
  async headers() {
    return [
      // brand/icon assets — regenerated every release, never cache
      {
        source: "/:icon(icon.svg|favicon.ico|apple-icon.png|opengraph-image.png|logo.svg)",
        headers: [{ key: "Cache-Control", value: "no-store, must-revalidate" }],
      },
      // hashed bundles — safe to cache forever (Next emits content-hashed filenames)
      {
        source: "/_next/static/:path*",
        headers: [{ key: "Cache-Control", value: "public, max-age=31536000, immutable" }],
      },
      // every other route (HTML, API, images served from app/) — never cache
      {
        source: "/:path*",
        headers: [
          { key: "Cache-Control", value: "no-store, must-revalidate" },
          { key: "Pragma", value: "no-cache" },
        ],
      },
    ];
  },
};

export default nextConfig;
