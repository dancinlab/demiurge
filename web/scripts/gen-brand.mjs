// gen-brand.mjs — canonical demiurge brand-asset generator (Node ESM, zero deps).
//
// Single source of truth for the hexaloop logomark. Produces:
//   web/app/icon.svg                  favicon (256×256, dark-mode adaptive)
//   web/public/logo.svg               horizontal wordmark
//   web/app/apple-icon.png  180²      via rsvg-convert
//   web/app/opengraph-image.png 1200×630
//
// Run:        node web/scripts/gen-brand.mjs   (from repo root or web/)
// Verify:     the script ASSERTS geometric invariants — exits non-zero on breach.
//
// Why a script + invariants instead of ad-hoc Python in chat:
//  - prevents regressions where loop crosses hexagon (clearance asserted at gen time)
//  - prevents viewBox clipping (mark bounding-box asserted within viewBox)
//  - deterministic output (any drift surfaces in PR diff)
//
// Design invariants (HARD asserted):
//  i1  loop outer-edge radius ≤ hex inner-edge radius − SAFETY  ⇒ loop strictly inside hexagon
//  i2  mark bounding-box ⊆ viewBox                              ⇒ no clipping
//
// Knobs (all in one place — adjust here, rerun, commit):

import { writeFileSync, existsSync, mkdirSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const HERE     = dirname(fileURLToPath(import.meta.url));
const WEB_ROOT = resolve(HERE, "..");
const REPO_ROOT = resolve(WEB_ROOT, "..");

// ── tunable design constants ─────────────────────────────────────────────
const LR             = 0.40;   // loop radius / hexagon radius
const STROKE_RATIO   = 0.135;  // stroke width / hexagon radius (for standard renders)
const GAP_START_DEG  = 245;    // gap edge 1 (loop)
const GAP_END_DEG    = -65;    // gap edge 2 (loop), end-of-traversal
const CHEVRON_LEN_R  = 0.075;  // chevron arm length / hexagon radius
const CHEVRON_OFF_R  = 0.025;  // chevron tip offset along tangent / R
const SAFETY_PX_AT_R86 = 5;    // min radial clearance loop↔hex at R=86 (scales linearly)
const PALETTE = {
  ink:       "#1a1a1a",
  inkInv:    "#ededed",
  bgWhite:   "#ffffff",
  bgDark:    "#0a0a0a",
  gradFrom:  "#8b5cf6",
  gradTo:    "#06b6d4",
};

// ── geometry helpers ────────────────────────────────────────────────────
const f = (n) => n.toFixed(2);
const angNorm = (a) => ((a + 180) % 360 + 360) % 360 - 180;
const shortDist = (a, b) => Math.abs(angNorm(a - b));
const polar = (cx, cy, r, deg) => {
  const a = (deg * Math.PI) / 180;
  return [cx + r * Math.cos(a), cy + r * Math.sin(a)];
};

// ── hexaloop mark (asserts invariants) ──────────────────────────────────
function hexaloop({ cx, cy, R, viewBox, cls = null, color = null, strokeOverride = null }) {
  const r = R * LR;
  const W = strokeOverride ?? R * STROKE_RATIO;
  const style = cls ? `class="${cls}" fill="none"` : `stroke="${color}" fill="none"`;

  // i1 — loop ⊂ hexagon (radial clearance, both stroke half-widths considered)
  const loopOuter = r + W / 2;
  const hexInner  = R * Math.cos(Math.PI / 6) - W / 2;
  const safety    = (SAFETY_PX_AT_R86 / 86) * R;
  const clearance = hexInner - loopOuter;
  if (clearance < safety) {
    throw new Error(
      `[gen-brand] invariant i1 BREACH: loop_outer=${loopOuter.toFixed(2)} `
      + `hex_inner=${hexInner.toFixed(2)} clearance=${clearance.toFixed(2)} `
      + `< safety=${safety.toFixed(2)} (R=${R}, LR=${LR}, W=${W.toFixed(2)})`
    );
  }

  // hexagon path (pointy-top, vertex at -90°)
  const hexPts = Array.from({ length: 6 }, (_, i) => polar(cx, cy, R, -90 + 60 * i));
  const hexD = "M " + hexPts.map(([x, y]) => `${f(x)} ${f(y)}`).join(" L ") + " Z";

  // i2 — mark bbox ⊆ viewBox (hex vertices)
  if (viewBox) {
    const [vw, vh] = viewBox;
    const halfW = W / 2;
    for (const [px, py] of hexPts) {
      if (px - halfW < 0 || px + halfW > vw || py - halfW < 0 || py + halfW > vh) {
        throw new Error(
          `[gen-brand] invariant i2 BREACH: hex vertex (${f(px)},${f(py)}) `
          + `+stroke/2 outside viewBox 0..${vw} × 0..${vh}`
        );
      }
    }
  }

  const hex = `<path d="${hexD}" ${style} stroke-width="${f(W)}" stroke-linejoin="round"/>`;

  // arc (major) from GAP_START → GAP_END, sweep=1 large-arc=1
  const [xs, ys] = polar(cx, cy, r, GAP_START_DEG);
  const [xe, ye] = polar(cx, cy, r, GAP_END_DEG);
  const arc = `<path d="M ${f(xs)} ${f(ys)} A ${f(r)} ${f(r)} 0 1 1 ${f(xe)} ${f(ye)}" ${style} stroke-width="${f(W)}" stroke-linecap="round"/>`;

  // finite-difference tangent at gap end (robust against angle-sign conventions)
  const gap = shortDist(GAP_END_DEG, GAP_START_DEG);
  let interior = null;
  for (const d of [3, -3]) {
    if (shortDist(GAP_END_DEG + d, GAP_START_DEG) > gap) { interior = GAP_END_DEG + d; break; }
  }
  const [ix, iy] = polar(cx, cy, r, interior);
  let Tx = xe - ix, Ty = ye - iy;
  const Tn = Math.hypot(Tx, Ty); Tx /= Tn; Ty /= Tn;
  const Nx = -Ty, Ny = Tx;
  const a = R * CHEVRON_LEN_R;
  const tipX = xe + Tx * R * CHEVRON_OFF_R;
  const tipY = ye + Ty * R * CHEVRON_OFF_R;
  const Ax = tipX - Tx * a + Nx * a * 0.8;
  const Ay = tipY - Ty * a + Ny * a * 0.8;
  const Bx = tipX - Tx * a - Nx * a * 0.8;
  const By = tipY - Ty * a - Ny * a * 0.8;
  const chev = `<polyline points="${f(Ax)},${f(Ay)} ${f(tipX)},${f(tipY)} ${f(Bx)},${f(By)}" `
             + `${style} stroke-width="${f(W)}" stroke-linecap="round" stroke-linejoin="round"/>`;

  return { svg: hex + arc + chev, clearance };
}

// ── asset composers ────────────────────────────────────────────────────
const ICON_STYLE =
  `<style>.m{stroke:${PALETTE.ink}}`
  + `@media (prefers-color-scheme:dark){.m{stroke:${PALETTE.inkInv}}}</style>`;
const LOGO_STYLE =
  `<style>.m{stroke:${PALETTE.ink}}.t{fill:${PALETTE.ink}}`
  + `@media (prefers-color-scheme:dark){.m{stroke:${PALETTE.inkInv}}.t{fill:${PALETTE.inkInv}}}</style>`;

function iconSvg() {
  // favicon: hexagon centered (128,128) R=86 in 256² viewBox → vertices at (53.5,85)..(128,42)..
  const { svg } = hexaloop({ cx: 128, cy: 128, R: 86, viewBox: [256, 256], cls: "m" });
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="256" height="256">${ICON_STYLE}${svg}</svg>`;
}

function logoSvg() {
  // wordmark: mark cx=48 cy=48 R=34 in 380×96 → vertices y 14..82 (fits with 14px margin)
  const { svg } = hexaloop({ cx: 48, cy: 48, R: 34, viewBox: [380, 96], cls: "m" });
  const text =
    `<text x="100" y="62" class="t" font-family="ui-monospace, SFMono-Regular, Menlo, monospace"`
    + ` font-size="46" font-weight="700" letter-spacing="-1">demiurge</text>`;
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 96" width="380" height="96">${LOGO_STYLE}${svg}${text}</svg>`;
}

function appleSrcSvg() {
  // apple-icon source: white opaque bg + charcoal mark, 256² → rsvg → 180×180 PNG
  const { svg } = hexaloop({ cx: 128, cy: 128, R: 84, viewBox: [256, 256], color: PALETTE.ink });
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" width="256" height="256">`
    + `<rect width="256" height="256" fill="${PALETTE.bgWhite}"/>${svg}</svg>`;
}

function ogSrcSvg() {
  // OG 1200×630: dark bg + gradient mark on left + wordmark + tagline
  const { svg } = hexaloop({ cx: 165, cy: 315, R: 140, viewBox: [1200, 630], color: "url(#g)" });
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630" width="1200" height="630">`
    + `<defs><linearGradient id="g" x1="0" y1="0" x2="300" y2="500" gradientUnits="userSpaceOnUse">`
    + `<stop stop-color="${PALETTE.gradFrom}"/><stop offset="1" stop-color="${PALETTE.gradTo}"/></linearGradient></defs>`
    + `<rect width="1200" height="630" fill="${PALETTE.bgDark}"/>${svg}`
    + `<text x="360" y="300" fill="#fafafa" font-family="ui-monospace, Menlo, monospace" font-size="92" font-weight="800" letter-spacing="-2">demiurge</text>`
    + `<text x="362" y="360" fill="#a3a3a3" font-family="ui-monospace, Menlo, monospace" font-size="30">AI-native technical-design pipeline</text>`
    + `<text x="362" y="408" fill="${PALETTE.gradFrom}" font-family="ui-monospace, Menlo, monospace" font-size="26">spec to verify to handoff &#183; Built with Gemini</text>`
    + `</svg>`;
}

// ── main ───────────────────────────────────────────────────────────────
function rsvg(srcSvgPath, outPngPath, w, h) {
  try {
    execFileSync("rsvg-convert", ["-w", String(w), "-h", String(h), srcSvgPath, "-o", outPngPath]);
  } catch (e) {
    throw new Error(`[gen-brand] rsvg-convert failed for ${srcSvgPath}: ${e.message}\n`
      + `  install: brew install librsvg`);
  }
}

function main() {
  const iconPath  = resolve(WEB_ROOT, "app/icon.svg");
  const logoPath  = resolve(WEB_ROOT, "public/logo.svg");
  const applePath = resolve(WEB_ROOT, "app/apple-icon.png");
  const ogPath    = resolve(WEB_ROOT, "app/opengraph-image.png");
  const tmpDir    = resolve(WEB_ROOT, ".gen-brand-tmp");
  if (!existsSync(tmpDir)) mkdirSync(tmpDir);

  const icon = iconSvg();
  writeFileSync(iconPath, icon);
  console.log(`✓ ${iconPath}`);

  const logo = logoSvg();
  writeFileSync(logoPath, logo);
  console.log(`✓ ${logoPath}`);

  const appleSrcPath = resolve(tmpDir, "apple.svg");
  writeFileSync(appleSrcPath, appleSrcSvg());
  rsvg(appleSrcPath, applePath, 180, 180);
  console.log(`✓ ${applePath} (180×180)`);

  const ogSrcPath = resolve(tmpDir, "og.svg");
  writeFileSync(ogSrcPath, ogSrcSvg());
  rsvg(ogSrcPath, ogPath, 1200, 630);
  console.log(`✓ ${ogPath} (1200×630)`);

  // Final invariant report
  const probe = hexaloop({ cx: 128, cy: 128, R: 86, viewBox: [256, 256], cls: "m" });
  console.log(`\n  invariant i1 (loop⊂hex):  clearance = ${probe.clearance.toFixed(2)}px at R=86  ✓`);
  console.log(`  invariant i2 (no clip):   asserted per-render                                  ✓`);
  console.log(`\nbrand assets regenerated. Commit the diff if intended.`);
}

main();
