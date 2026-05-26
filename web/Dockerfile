# syntax=docker/dockerfile:1.6
#
# Multi-stage build for the demiurge Web GUI (Cloud Run target).
# Source context = demiurge repo root (one level above web/). This lets
# us copy DOMAINS.tape + domains/ + *.md alongside the standalone
# output without symlinking out of /app/web.
#
# Stages:
#   deps   — npm ci with the lockfile only (cache-friendly)
#   build  — next build → .next/standalone + .next/static
#   runtime — slim node + only the runtime files. Cloud Run sets
#            $PORT; Next standalone reads it directly.

ARG NODE_IMAGE=node:22-bookworm-slim

# ─── deps ──────────────────────────────────────────────────────────────
FROM ${NODE_IMAGE} AS deps
WORKDIR /app/web
COPY web/package.json web/package-lock.json ./
RUN npm ci --no-audit --no-fund

# ─── build ─────────────────────────────────────────────────────────────
FROM ${NODE_IMAGE} AS build
WORKDIR /app
COPY --from=deps /app/web/node_modules ./web/node_modules
# Copy the data files Next.js will trace into the standalone bundle.
COPY DOMAINS.tape ./DOMAINS.tape
COPY domains ./domains
# Copy the web app itself last to maximize cache hits on the deps layer.
COPY web ./web
WORKDIR /app/web
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# ─── runtime ───────────────────────────────────────────────────────────
FROM ${NODE_IMAGE} AS runtime
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=8080
# Run as non-root for Cloud Run hardening.
RUN groupadd -r app && useradd -r -g app -d /app app
# Standalone server expects to live at /app/web; trace root sits at /app.
COPY --from=build --chown=app:app /app/web/.next/standalone ./
COPY --from=build --chown=app:app /app/web/.next/static ./web/.next/static
COPY --from=build --chown=app:app /app/web/public ./web/public
USER app
EXPOSE 8080
CMD ["node", "web/server.js"]
